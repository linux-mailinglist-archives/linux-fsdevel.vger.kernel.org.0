Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC29966DBBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 12:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjAQLDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 06:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjAQLDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:03:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA732CFE0;
        Tue, 17 Jan 2023 03:03:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9226F68532;
        Tue, 17 Jan 2023 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673953415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yM3o6KrDzy3CUB2wOjjiKrt7RPQ6X4k5rLiKiQpyu3U=;
        b=XhKYi0zY0UB1U2ncTOlegAXCinDng7M4A6EXyUdBCU5XW1TBjGVFKl2eCZle4P48TFowSh
        Nflap+aM6BwnGgRSz4jL0Reh/wEgUmqCZ3tgRdJYKLE6IpX93IWlPjMXtWs8syY0iyNiUJ
        fMyr1Yj1iJNsNkLH7OdDdj0Bz95ktMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673953415;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yM3o6KrDzy3CUB2wOjjiKrt7RPQ6X4k5rLiKiQpyu3U=;
        b=f3lXwvzuS7GBitbpHTVaYC7Oeqp7346EqDXG8dg3bQbX9pHfBchHLmQzWdnckThHCQK/0l
        6KVZSpJLlEv36jDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8530E1390C;
        Tue, 17 Jan 2023 11:03:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ai57IIeAxmPwLwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 17 Jan 2023 11:03:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 15D5BA06B2; Tue, 17 Jan 2023 12:03:35 +0100 (CET)
Date:   Tue, 17 Jan 2023 12:03:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <20230117110335.7dtlq4catefgjrm3@quack3>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
 <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
 <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 17-01-23 16:00:47, Ojaswin Mujoo wrote:
> On Mon, Jan 16, 2023 at 01:23:34PM +0100, Jan Kara wrote:
> > > Since this covers the special case we discussed above, we will always
> > > un-delete the PA when we encounter the special case and we can then
> > > adjust for overlap and traverse the PA rbtree without any issues.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Hi Jan,
> Thanks for the review, sharing some of my thoughts below.
> 
> > 
> > So I find this putting back of already deleted inode PA very fragile. For
> > example in current code I suspect you've missed a case in ext4_mb_put_pa()
> > which can mark inode PA (so it can then be spotted by
> > ext4_mb_pa_adjust_overlap() and marked as in use again) but
> > ext4_mb_put_pa() still goes on and destroys the PA.
> 
> The 2 code paths that clash here are:
> 
> ext4_mb_new_blocks() -> ext4_mb_release_context() -> ext4_mb_put_pa()
> ext4_mb_new_blocks() -> ext4_mb_normalize_request() -> ext4_mb_pa_adjust_overlap()
> 
> Since these are the only code paths from which these 2 functions are
> called, for a given inode, access will always be serialized by the upper
> level ei->i_data_sem, which is always taken when writing data blocks
> using ext4_mb_new_block(). 

Indeed, inode->i_data_sem prevents the race I was afraid of.
 
> From my understanding of the code, I feel only
> ext4_mb_discard_group_preallocations() can race against other functions
> that are modifying the PA rbtree since it does not take any inode locks.
> 
> That being said, I do understand your concerns regarding the solution,
> however I'm willing to work with the community to ensure our
> implementation of this undelete feature is as robust as possible. Along
> with fixing the bug reported here [1], I believe that it is also a good
> optimization to have especially when the disk is near full and we are
> seeing a lot of group discards going on. 
> 
> Also, in case the deleted PA completely lies inside our new range, it is
> much better to just undelete and use it rather than deleting the
> existing PA and reallocating the range again. I think the advantage
> would be even bigger in ext4_mb_use_preallocated() function where we can
> just undelete and use the PA and skip the entire allocation, incase original
> range lies in a deleted PA.

Thanks for explantion. However I think you're optimizing the wrong thing.
We are running out of space (to run ext4_mb_discard_group_preallocations()
at all) and we allocate from an area covered by PA that we've just decided
to discard - if anything relies on performance of the filesystem in ENOSPC
conditions it has serious problems no matter what. Sure, we should deliver
the result (either ENOSPC or some block allocation) in a reasonable time
but the performance does not really matter much because all the scanning
and flushing is going to slow down everything a lot anyway. One additional
scan of the rbtree is really negligible in this case. So what we should
rather optimize for in this case is the code simplicity and maintainability
of this rare corner-case that will also likely get only a small amount of
testing. And in terms of code simplicity the delete & restart solution
seems to be much better (at least as far as I'm imagining it - maybe the
code will prove me wrong ;)).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
