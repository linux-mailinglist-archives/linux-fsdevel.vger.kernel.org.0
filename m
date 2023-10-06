Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35F27BB5C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjJFLBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 07:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjJFLBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:01:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF43C5;
        Fri,  6 Oct 2023 04:01:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9ADD61F895;
        Fri,  6 Oct 2023 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696590096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=piOdkBH7q3g/1BdTNsnZfQXf4D5rELoYVkzhPQ8djN8=;
        b=nmSUnawLLGxHZx6O3UIeMOwzv12xv2RZvPnJ8stoCvCKdwMofAdiMkHBnrh5UPn21qX9o8
        8Q74t+0pmMyfS3/KfP2UsdmJy6rFFQvDAp98BpFFW++/+Kn1eqKAHwCtFWit6clUi1S0yR
        fgz62rGbjmT0562KHtQFkzMe8VKYFP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696590096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=piOdkBH7q3g/1BdTNsnZfQXf4D5rELoYVkzhPQ8djN8=;
        b=TbbiZWcj4OMYEB5UYrj9hYV67Ip7O8Kp80NroTbUjI3fpK0U77fZTUeMWiOsexUDWr6vKT
        qVUAtYSxM2vr4KCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A1FC13A2E;
        Fri,  6 Oct 2023 11:01:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wf6yIRDpH2WWagAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 06 Oct 2023 11:01:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 19CDFA07CC; Fri,  6 Oct 2023 13:01:36 +0200 (CEST)
Date:   Fri, 6 Oct 2023 13:01:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Vlastmil Babka <vbabka@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/8] shmem: factor shmem_falloc_wait() out of
 shmem_fault()
Message-ID: <20231006110136.7xnfmjjrmmpumwyf@quack3>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <6fe379a4-6176-9225-9263-fe60d2633c0@google.com>
 <20231003131853.ramdlfw5s6ne4iqx@quack3>
 <b2947c43-b7c6-5e50-ae55-81757efc1adb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2947c43-b7c6-5e50-ae55-81757efc1adb@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-10-23 20:48:00, Hugh Dickins wrote:
> On Tue, 3 Oct 2023, Jan Kara wrote:
> > On Fri 29-09-23 20:27:53, Hugh Dickins wrote:
> > > That Trinity livelock shmem_falloc avoidance block is unlikely, and a
> > > distraction from the proper business of shmem_fault(): separate it out.
> > > (This used to help compilers save stack on the fault path too, but both
> > > gcc and clang nowadays seem to make better choices anyway.)
> > > 
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > 
> > Looks good. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Thanks a lot for all these reviews, Jan.  (And I particularly enjoyed
> your "Autumn cleaning" remark: sweeping up the leaves, I've been glad
> to have "Autumn Almanac" running through my head since reading that.)

:-) You have widened my musical horizon.

> > Looking at the code I'm just wondering whether the livelock with
> > shmem_undo_range() couldn't be more easy to avoid by making
> > shmem_undo_range() always advance the index by 1 after evicting a page and
> > thus guaranteeing a forward progress... Because the forward progress within
> > find_get_entries() is guaranteed these days, it should be enough.
> 
> I'm not sure that I understand your "advance the index by 1" comment.
> Since the "/* If all gone or hole-punch or unfalloc, we're done */"
> change went in, I believe shmem_undo_range() does make guaranteed
> forward progress; but its forward progress is not enough.

Right, I have missed that retry when glancing over the code. And the
"advance the index by 1" was also wrong because find_get_entries() already
does it these days.

> I would love to delete all that shmem_falloc_wait() strangeness;
> and your comment excited me to look, hey, can we just delete all that
> stuff now, instead of shifting it aside?  That would be much nicer.

Well, even if you decided to keep the synchronization what you could do
these days is to use inode->i_mapping->invalidate_lock for synchronization
instead of your home-grown solution (like all other filesystems do for
these kind of races). If you don't want to pay the cost of rwsem
acquisition in the fault fast path, you could do it in the hole-punch
running case only like currently.

> And if I'd replied to you yesterday, I'd have been saying yes we can.
> But that's because I hadn't got far enough through re-reading the
> various July 2014 3.16-rc mail threads.  I had been excited to find
> myself posting a revert of the patch; before reaching Sasha's later
> livelock which ended up with "belt and braces" retaining the
> shmem_falloc wait while adding the "If all gone or hole-punch" mod.
> 
> https://marc.info/?l=linux-kernel&m=140487864819409&w=2
> though that thread did not resolve, and morphed into lockdep moans.
> 
> So I've reverted to my usual position: that it's conceivable that
> something has changed meanwhile, to make that Trinity livelock no
> longer an issue (in particular, i_mmap_mutex changed to i_mmap_rwsem,
> and much later unmap_mapping_range() changed to only take it for read:
> but though that change gives hope, I suspect it would turn out to be
> ineffectual against the livelock); but that would have to be proved.
> 
> If there's someone who can re-demonstrate Sasha's Trinity livelock
> on 3.16-with-shmem-falloc-wait-disabled, or re-demonstrate it on any
> later release-with-shmem-falloc-wait-disabled, but demonstrate that
> the livelock does not occur on 6.6-rc-with-shmem-falloc-wait-disabled
> (or that plus some simple adjustment of hacker's choosing): that would
> be great news, and we could delete all this - though probably not
> without bisecting to satisfy ourselves on what was the crucial change.
> 
> But I never got around to running up Trinity to work on it originally,
> nor in the years since, nor do I expect to soon.  (Vlastimil had a
> good simple technique for demonstrating a part of the problem, but
> fixing that part turned out not fix the whole issue with Trinity.)

Fair enough. I agree that we should do some testing before we actually
remove the serialization because the problem was not well understood even
back then and likely had something to do with unmap_mapping_folio()
inefficiency (e.g. unmapping one page at a time acquiring heavily contended
i_mmap_mutex for each page) rather than page cache eviction itself.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
