Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F072378605
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhEJLDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 07:03:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:40400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232866AbhEJKyJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 06:54:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 906B8AFD5;
        Mon, 10 May 2021 10:53:03 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id de6ed6ea;
        Mon, 10 May 2021 10:54:36 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
References: <87czu45gcs.fsf@suse.de> <YJPIyLZ9ofnPy3F6@codewreck.org>
        <87zgx83vj9.fsf@suse.de> <87r1ii4i2a.fsf@suse.de>
        <YJXfjDfw9KM50f4y@codewreck.org>
Date:   Mon, 10 May 2021 11:54:36 +0100
In-Reply-To: <YJXfjDfw9KM50f4y@codewreck.org> (Dominique Martinet's message of
        "Sat, 8 May 2021 09:47:08 +0900")
Message-ID: <875yzq270z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dominique Martinet <asmadeus@codewreck.org> writes:

> Luis Henriques wrote on Fri, May 07, 2021 at 05:36:29PM +0100:
>> Ok, I spent some more time on this issue today.  I've hacked a bit of code
>> to keep track of new inodes' qids and I'm convinced there are no
>> duplicates when this issue happens.
>
> Ok, that's good.
> Just to make sure what did you look at aside of the qid to make sure
> it's unique? i_ino comes straight from qid->path too so we don't have
> any great key available which is why I hadn't suggesting building a
> debug table.
> (... well, actually that means we'll never try to allocate two inodes
> with the same inode number because of how v9fs_qid_iget_dotl() works, so
> if there is a collision in qid paths we wouldn't see it through cookies
> collision in the first place. I'm not sure that's good? But at least
> that clears up that theory, sorry for the bad suggestion)
>

Ok, I should probably have added some more details in my email.  So,
here's what I did:

I've created a list (actually a tree...) of objects that keep track of
each new inode in v9fs_qid_iget_dotl().  These objects contain the inode
number, and the qid (type, version, path).  These are then removed from
the list in v9fs_evict_inode().

Whenever there's an error in v9fs_cache_inode_get_cookie(), i.e. when
v9inode->fscache == NULL, I'll search this list to see if that inode
number was there (or if I can find the qid.path and qid.version).  

I have never seen a hit in this search, hence my claim of not having a
duplicate qids involved.  Of course my hack can be buggy and I completely
miss it ;-)

>> OTOH, I've done another quick test: in v9fs_cache_inode_get_cookie(), I do
>> an fscache_acquire_cookie() retry when it fails (due to the dup error),
>> and this retry *does* succeed.  Which means, I guess, there's a race going
>> on.  I didn't managed to look too deep yet, but my current theory is that
>> the inode is being evicted while an open is triggered.  A new inode is
>> allocated but the old inode fscache cookie hasn't yet been relinquished.
>> Does this make any sense?
>
> hm, if the retry goes through I guess that'd make sense; if they both
> were used in parallel the second call should fail all the same so that's
> definitely a likely explanation.
>
> It wouldn't hurt to check with v9fs_evict_inode if that's correct...
> There definitely is a window where inode is no longer findable (thus
> leading to allocation of a new one) and the call to the
> fscache_relinquish_cookie() at eviction, but looking at e.g. afs they
> are doing exactly the same as 9p here (iget5_locked, if that gets a new
> inode then call fscache_acquire_cookie // fscache_relinquish_cookie in
> evict op) so I'm not sure what we're missing.
>
>
> David, do you have an idea?

I've just done a quick experiment: moving the call to function
v9fs_cache_inode_put_cookie() in v9fs_evict_inode() to the beginning
(before truncate_inode_pages_final()) and it seems to, at least, narrow
the window -- I'm not able to reproduce the issue anymore.  But I'll need
to look closer.

And yeah, I had checked other filesystems too and they seem to follow this
pattern.  So either I'm looking at the wrong place or this is something
that is much more likely to be triggered by 9p.

Cheers,
-- 
Luis

>> If this theory is correct, I'm not sure what's the best way to close this
>> race because the v9inode->fscache_lock can't really be used.  But I still
>> need to proof this is really what's happening.
>
> Yes, I think we're going to need proof before thinking of a solution, I
> can't think of anything simple either.
>
>
> Thanks again for looking into it,
> -- 
> Dominique
