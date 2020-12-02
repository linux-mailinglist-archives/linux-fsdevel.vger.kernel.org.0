Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47A72CB156
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 01:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgLBAMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 19:12:07 -0500
Received: from sandeen.net ([63.231.237.45]:35898 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgLBAMG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 19:12:06 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 2799D146284;
        Tue,  1 Dec 2020 18:11:09 -0600 (CST)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
 <CAHk-=wgOu9vgUfOSsjO3hHHxGDn4BKhitC_8XCfgmGKiiSm_ag@mail.gmail.com>
 <300456.1606856642@warthog.procyon.org.uk>
 <CAHk-=wgB_e1anR0b4B5p3qxR9nq1-xrRponA6Q6WbGTOSFNmPw@mail.gmail.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
Message-ID: <421cb25d-ca52-0a08-e535-5f650dda8d93@sandeen.net>
Date:   Tue, 1 Dec 2020 18:11:24 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgB_e1anR0b4B5p3qxR9nq1-xrRponA6Q6WbGTOSFNmPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/1/20 4:09 PM, Linus Torvalds wrote:
> So basically, the thing that argues against this patch is that it
> seems to just duplicate things inside filesystems, when the VFS layter
> already has the information.
> 
> Now, if the VFS information was possibly stale or wrong, that woudl be
> one thing. But then we'd have other and bigger  problems elsewhere as
> far as I can tell.
> 
> IOW - make generic what can be made generic, and try to avoid having
> filesystems do their own thing.
> 
> [ Replace "filesystems" by "architectures" or whatever else, this is
> obviously not a filesystem-specific rule in general. ]
> 
> And don't get me wrong - I don't _hate_ the patch, and I don't care
> _that_ deeply, but it just doesn't seem to make any sense to me. My
> initial query was really about "what am I missing - can you please
> flesh out the commit message because I don't understand what's wrong".

Backing way up, my motivation was: Only the filesystem can appropriately
set the statx->attributes_mask, so it has to be done there. Since that
has to be done in the filesystem, set the actual attribute flag adjacent
to it, as is done for ~every other flag.

*shrug*

In any case I resent the flag value clash fix on a separate thread as
V2, hopefully that one is straightforward enough to go in.

Thanks,
-Eric
