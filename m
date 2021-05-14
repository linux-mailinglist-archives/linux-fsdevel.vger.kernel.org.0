Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA909380DC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhENQKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 12:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhENQKd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 12:10:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2830FB123;
        Fri, 14 May 2021 16:09:21 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 9cb50cc6;
        Fri, 14 May 2021 16:10:56 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: What sort of inode state does ->evict_inode() expect to see?
 [was Re: 9p: fscache duplicate cookie]
References: <YJvb9S8uxV2X45Cu@zeniv-ca.linux.org.uk>
        <YJvJWj/CEyEUWeIu@codewreck.org> <87tun8z2nd.fsf@suse.de>
        <87czu45gcs.fsf@suse.de> <2507722.1620736734@warthog.procyon.org.uk>
        <2882181.1620817453@warthog.procyon.org.uk> <87fsysyxh9.fsf@suse.de>
        <2891612.1620824231@warthog.procyon.org.uk>
        <2919958.1620828730@warthog.procyon.org.uk>
Date:   Fri, 14 May 2021 17:10:56 +0100
In-Reply-To: <2919958.1620828730@warthog.procyon.org.uk> (David Howells's
        message of "Wed, 12 May 2021 15:12:10 +0100")
Message-ID: <87bl9dwb1r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>> > We're seeing cases where fscache is reporting cookie collisions that appears
>> > to be due to ->evict_inode() running parallel with a new inode for the same
>> > filesystem object getting set up.
>> 
>> Huh?  Details, please.  What we are guaranteed is that iget{,5}_locked() et.al.
>> on the same object will either prevent the call of ->evict_inode() (if they
>> manage to grab the sucker before I_FREEING is set) or will wait until after
>> ->evict_inode() returns.
>
> See the trace from Luis in:
>
> 	https://lore.kernel.org/linux-fsdevel/87fsysyxh9.fsf@suse.de/
>
> It appears that process 20591 manages to set up a new inode that has the same
> key parameters as the one process 20585 is tearing down.
>
> 0000000097476aaa is the cookie pointer used by the old inode.
> 0000000011fa06b1 is the cookie pointer used by the new inode.
> 000000003080d900 is the cookie pointer for the parent superblock.
>
> The fscache_acquire traceline emission is caused by one of:
>
>  (*) v9fs_qid_iget() or v9fs_qid_iget_dotl() calling
>      v9fs_cache_inode_get_cookie().
>
>  (*) v9fs_file_open*(O_RDONLY) or v9fs_vfs_atomic_open*(O_RDONLY) calling
>      v9fs_cache_inode_set_cookie().
>
>  (*) v9fs_cache_inode_reset_cookie(), which appears unused.
>
> The fscache_relinquish traceline emission is caused by one of:
>
>  (*) v9fs_file_open(O_RDWR/O_WRONLY) or v9fs_vfs_atomic_open(O_RDWR/O_WRONLY)
>      calling v9fs_cache_inode_set_cookie().
>
>  (*) v9fs_evict_inode() calling v9fs_cache_inode_put_cookie().
>
>  (*) v9fs_cache_inode_reset_cookie(), which appears unused.
>
> From the backtrace in:
>
> 	https://lore.kernel.org/linux-fsdevel/87czu45gcs.fsf@suse.de/
>
> the acquisition is being triggered in v9fs_vfs_atomic_open_dotl(), so it seems
> v9fs_qid_iget_dotl() already happened - which *should* have created the
> cookie.

So, from our last chat on IRC, we have the following happening:

v9fs_vfs_atomic_open_dotl
  v9fs_vfs_lookup
    v9fs_get_new_inode_from_fid
      v9fs_inode_from_fid_dotl
        v9fs_qid_iget_dotl

At this point, iget5_locked() gets called with the test function set to
v9fs_test_new_inode_dotl(), which *always* returns 0.  It's still not
clear to me why commit ed80fcfac256 ("fs/9p: Always ask new inode in
create") has introduced this behavior but even if that's not correct, we
still have a race regarding cookies handling, right?

I'm still seeing:

CPU0                     CPU1
v9fs_drop_inode          ...
v9fs_evict_inode         /* atomic_open */
                         v9fs_cache_inode_get_cookie <= COLLISION
fscache_relinquish

So, the question remains: would it be possible to do the relinquish
earlier (->drop_inode)?  Or is 9p really shooting itself in the foot by
forcing iget5_locked() to always create a new inode here?

Cheers,
-- 
Luis
