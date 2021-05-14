Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97FE3812C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 23:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhENVS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhENVS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 17:18:29 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0029CC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 14:17:16 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 3C817C01F; Fri, 14 May 2021 23:17:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1621027034; bh=dL1H2PZzXE0N0DMQKjto285w9JuAHYL1WG3d16tDeVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Asfce5m2lJ6vo/01moa0fWmCro1iGBwz341MAneuLLdTRbTu2Kz2TEYRLaSc1iDjH
         PaPDUStB2q/pk7GTOAsdoG1R/VN7++lLiRqivaiVW19orXdKTdxQ26FSrLF/gBw15V
         6GNvHsE37eY3fU5fMiOeZemclRC5/8UuwFlJRLf/R8p6mWWXFgLKXVB0s9PM38svIj
         21heO2yHdRJNR7Ip5D9OHaiwELu/UA69CNyRU52b/pbRbBWopRNHE/puJmhxcxgeDc
         7t+u6nxkQ+ZAKEExjtppNBEpUFxZbNhKnMtQWQGuy6odgOsDMCfTBGmlE8SvELrVPk
         3+VE/S8WN8a+g==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id CA57CC009;
        Fri, 14 May 2021 23:17:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1621027033; bh=dL1H2PZzXE0N0DMQKjto285w9JuAHYL1WG3d16tDeVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RysAxk6TeP7g9Y4tq/B5HNbYv0jlEPjxL0AkpYKrLU/gYRWSWisondWUrL2/JCvrU
         PJT5+RLAy9jRC2b+0FyW3gY5e7Axp0FpBw+yC0ED7EGScK7v9sVYZG6YUBawbB6J+9
         MgcLX6cuRrTKBKj4HYw/HZ3Afdty5blA03lyOaZLMIkAFNizU2kADt/m2PY6Vbq25y
         OwoV7zuyMdsMz9vPmF71/aloI0TVmnSDy+p09d+OfkIPEf/fZq9fExatabnhOXHRxP
         HlO42zA34va6eD32/liF00qVCjrG0vLVLsN9GhKxuPcLsrMvxat9u7NzCNHfXa+cgN
         Tmpbk40qP3SeQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id b3975c6a;
        Fri, 14 May 2021 21:17:07 +0000 (UTC)
Date:   Sat, 15 May 2021 06:16:52 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: What sort of inode state does ->evict_inode() expect to see?
 [was Re: 9p: fscache duplicate cookie]
Message-ID: <YJ7oxGY/eosPvCiA@codewreck.org>
References: <YJvb9S8uxV2X45Cu@zeniv-ca.linux.org.uk>
 <YJvJWj/CEyEUWeIu@codewreck.org>
 <87tun8z2nd.fsf@suse.de>
 <87czu45gcs.fsf@suse.de>
 <2507722.1620736734@warthog.procyon.org.uk>
 <2882181.1620817453@warthog.procyon.org.uk>
 <87fsysyxh9.fsf@suse.de>
 <2891612.1620824231@warthog.procyon.org.uk>
 <2919958.1620828730@warthog.procyon.org.uk>
 <87bl9dwb1r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bl9dwb1r.fsf@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Aneesh,

I'm going to rely on your memory here... A long, long time ago (2011!),
you've authored this commit:
-------
commit ed80fcfac2565fa866d93ba14f0e75de17a8223e
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed Jul 6 16:32:31 2011 +0530

    fs/9p: Always ask new inode in create
    
    This make sure we don't end up reusing the unlinked inode object.
    The ideal way is to use inode i_generation. But i_generation is
    not available in userspace always.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
-------

Do you happen to remember or know *why* you wanted to make sure we don't
reuse the unlinked inode object?

I'm asking because that's causing problems with (at least) fscache
cookie, iget5_locked() gets us a new inode in v9fs_qid_iget_dotl()
and tries to get a new cookie before the evict has happened and
relinquished the former inode's.
There's also problems with coherency in sight -- evict is also in charge
of flushing all dirty pages, so the new inode can in theory issue IO and
read from server data which has been written by another process on the
same client and while 9p isn't known for coherency with multiple clients
it's a different story with a single one! (didn't reproduce that one)

Anyway, it'd be great to know why you did that so we can try another
workaround.
In theory I'd love to have qemu and others export fsid + a fhandle from
name_to_handle_at that includes i_generation and full inode number in
the qid path, but we're limited by the 64bits of the protocol so it's a
tough one... In practice I don't see generation being used all that much
by filesystems to reuse inode numbers though, so wondering which is the
most problematic?



You can find the rest of the thread here if you're not subscribed to
v9fs-developer or linux-fsdevel:
https://lkml.kernel.org/r/87czu45gcs.fsf@suse.de



Luis Henriques wrote on Fri, May 14, 2021 at 05:10:56PM +0100:
> So, from our last chat on IRC, we have the following happening:
> 
> v9fs_vfs_atomic_open_dotl
>   v9fs_vfs_lookup
>     v9fs_get_new_inode_from_fid
>       v9fs_inode_from_fid_dotl
>         v9fs_qid_iget_dotl
> 
> At this point, iget5_locked() gets called with the test function set to
> v9fs_test_new_inode_dotl(), which *always* returns 0.  It's still not
> clear to me why commit ed80fcfac256 ("fs/9p: Always ask new inode in
> create") has introduced this behavior but even if that's not correct, we
> still have a race regarding cookies handling, right?
> 
> I'm still seeing:
> 
> CPU0                     CPU1
> v9fs_drop_inode          ...
> v9fs_evict_inode         /* atomic_open */
>                          v9fs_cache_inode_get_cookie <= COLLISION
> fscache_relinquish

Do you mean you still have that problem after ed80fcfac256 has been
reverted?

> So, the question remains: would it be possible to do the relinquish
> earlier (->drop_inode)?  Or is 9p really shooting itself in the foot by
> forcing iget5_locked() to always create a new inode here?

Ugh that is the kind of things I don't want to experiment with...
->drop_inode() seems to be called with i_lock taken and meant to be just
a test, not something that can wait, but from what I'm reading it might
be possible to set I_WILL_FREE, drop the lock, do our stuff and reaquire
the lock at the end.. perhaps? It looks like inode lookup will just loop
around on ilookup5_nowait while I_WILL_FREE is set so new inodes can't
be taken at this point, it's a de-facto spin lock with iget5_locked and
friends.
I have no idea what will break though, I'd really rather leave it to the
vfs and have 9p do the right thing with inode recycling.

-- 
Dominique
