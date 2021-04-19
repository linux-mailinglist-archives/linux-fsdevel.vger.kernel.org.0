Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2893647BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 18:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbhDSQDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 12:03:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:52216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242165AbhDSQCf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:02:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 995D4AF35;
        Mon, 19 Apr 2021 16:02:04 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 19625ce4;
        Mon, 19 Apr 2021 16:03:32 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v6 00/20] ceph+fscrypt: context, filename and
 symlink support
References: <20210413175052.163865-1-jlayton@kernel.org>
        <87h7k2murr.fsf@suse.de>
        <e411e914cd2d329e4b0e335968c21ba85f6e89c7.camel@kernel.org>
Date:   Mon, 19 Apr 2021 17:03:26 +0100
In-Reply-To: <e411e914cd2d329e4b0e335968c21ba85f6e89c7.camel@kernel.org> (Jeff
        Layton's message of "Mon, 19 Apr 2021 08:23:18 -0400")
Message-ID: <871rb6mfch.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Mon, 2021-04-19 at 11:30 +0100, Luis Henriques wrote:
...
> Ouch. That looks like a real bug, alright.
>
> Basically when building the path, we occasionally need to fetch the
> crypto context for parent inodes and such, and that can cause us to
> recurse back into __ceph_getxattr and try to issue another RPC to the
> MDS.
>
> I'll have to look and see what we can do. Maybe it's safe to drop the
> mdsc->mutex while we're building the path? Or maybe this is a good time
> to re-think a lot of the really onerous locking in this codepath?
>
> I'm open to suggestions here...

Yeah, I couldn't see a good fix at a first glace.  Dropping the mutex
while building the path was my initial thought too but it's not easy to
proof that's a safe thing to do.

The other idea I had was to fetch all the needed fscrypt contexts at the
end, after building the path.  But I didn't found a way for doing that
because to build the path... we need the contexts.

It looks like this leaves us with the locking rethinking option.

/me tries harder to find another way out

Cheers,
-- 
Luis
