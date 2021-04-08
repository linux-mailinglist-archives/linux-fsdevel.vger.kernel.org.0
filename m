Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2760D358EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 23:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhDHVEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhDHVEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:04:45 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E9C061760;
        Thu,  8 Apr 2021 14:04:32 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUbpG-003ny6-VI; Thu, 08 Apr 2021 21:04:31 +0000
Date:   Thu, 8 Apr 2021 21:04:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <YG9v3lRiu17cvF2M@zeniv-ca.linux.org.uk>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
 <YG8zMV59hSzpCHSn@zeniv-ca.linux.org.uk>
 <20210408204935.4itnxm4ekdv7zlrw@dlxu-fedora-R90QNFJV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408204935.4itnxm4ekdv7zlrw@dlxu-fedora-R90QNFJV>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:49:35PM -0700, Daniel Xu wrote:

> Ah right, sorry. Nobody will clean up the super_block.
> 
> > IOW, NAK.  The objects you are playing with have non-trivial lifecycle
> > and poking into the guts of data structures without bothering to
> > understand it is not a good idea.
> > 
> > Rule of the thumb: if your code ends up using fields that are otherwise
> > handled by a small part of codebase, the odds are that you need to be
> > bloody careful.  In particular, ->ns_lock has 3 users - all in
> > fs/namespace.c.  ->list/->mnt_list: all users in fs/namespace.c and
> > fs/pnode.c.  ->s_active: majority in fs/super.c, with several outliers
> > in filesystems and safety of those is not trivial.
> > 
> > Any time you see that kind of pattern, you are risking to reprise
> > a scene from The Modern Times - the one with Charlie taking a trip
> > through the guts of machinery.
> 
> I'll take a closer look at the lifetime semantics.
> 
> Hopefully the overall goal of the patch is ok. Happy to iterate on the
> implementation details until it's correct.

That depends.  Note that bumping ->s_active means that umount of that
sucker will *NOT* shut it down - that would happen only on the thread
doing the final deactivation.  What's more, having e.g. a USB stick
mounted, doing umount(1), having it complete successfully, pulling the
damn thing out and getting writes lost would make for a nasty surprise
for users.

With your approach it seems to be inevitable.  Holding namespace_sem
through the entire thing would prevent that, but's it's a non-starter
for other reasons (starting with "it's a system-wide lock, so that'd
be highly antisocial").  Are there any limits on what could be done
to the pages, anyway?  Because if it's "anything user wanted to do",
it's *really* not feasible.
