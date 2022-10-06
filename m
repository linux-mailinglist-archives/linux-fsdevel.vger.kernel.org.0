Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D15F632A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiJFJAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJFJAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:00:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7C17A9A;
        Thu,  6 Oct 2022 02:00:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 823FF219F4;
        Thu,  6 Oct 2022 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665046799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2icCegbf3s68u8LLC7CDK6sFXkipsoPomf5JYEyME8=;
        b=FJUidb+0ergppSUrx7cQDbhiIQcMRsczrqHma3foEVz42iT+qPh2s8xjOCyr+sxCLYIKSx
        3R8gROsg13SSjPjEC8TrHWn+G6dWyDhIOU0gsAzoUncZWoS4tsidJhZDMiCshHApVjQ8S5
        5mFNzEy5rVT9QHz8K28hS9yvoW1+yyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665046799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2icCegbf3s68u8LLC7CDK6sFXkipsoPomf5JYEyME8=;
        b=Esw09XR3njIjsZGo1r3XPs3KFL9nw1tZS5R4IFhDcmvexygHKGn7+L/RYWtsGoAl0X7wjn
        U6EA8p0I1RgeeiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D7811376E;
        Thu,  6 Oct 2022 08:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lCbPFg+ZPmNNRQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Oct 2022 08:59:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8B59FA0668; Thu,  6 Oct 2022 10:59:58 +0200 (CEST)
Date:   Thu, 6 Oct 2022 10:59:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC v3 8/8] ext4: Remove the logic to trim inode PAs
Message-ID: <20221006085958.l2yfkqkupqsxiqbv@quack3>
References: <cover.1664269665.git.ojaswin@linux.ibm.com>
 <a26fdd12f4f60cf506a42b6a95e8014e5f380b05.1664269665.git.ojaswin@linux.ibm.com>
 <20220929125311.bmkta7gp4a2hmcny@quack3>
 <Yz57xJSoksI5rHwL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz57xJSoksI5rHwL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-10-22 12:25:00, Ojaswin Mujoo wrote:
> On Thu, Sep 29, 2022 at 02:53:11PM +0200, Jan Kara wrote:
> > On Tue 27-09-22 14:46:48, Ojaswin Mujoo wrote:
> > > Earlier, inode PAs were stored in a linked list. This caused a need to
> > > periodically trim the list down inorder to avoid growing it to a very
> > > large size, as this would severly affect performance during list
> > > iteration.
> > > 
> > > Recent patches changed this list to an rbtree, and since the tree scales
> > > up much better, we no longer need to have the trim functionality, hence
> > > remove it.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > 
> > I'm kind of wondering: Now there won't be performance issues with much
> > more inode PAs but probably we don't want to let them grow completely out
> > of control? E.g. I can imagine that if we'd have 1 billion of inode PAs
> > attached to an inode, things would get wonky both in terms of memory
> > consumption and also in terms of CPU time spent for the cases where we
> > still do iterate all of the PAs... Is there anything which keeps inode PAs
> > reasonably bounded?
> > 
> > 								Honza
> > 
> Hi Jan,
> 
> Sorry for the delay in response, I was on leave for the last few days.
> 
> So as per my understanding, after this patch, the only path where we
> would need to traverse all the PAs is the ext4_discard_preallocations()
> call where we discard all the PAs of an inode one by one (eg when
> closing the file etc).  Such a discard is a colder path as we don't
> usually expect to do it as often as say allocating blocks to an inode.
> 
> Originally, the limit was added in this patch [1] because of the time
> lost in O(N) traversal in the allocation path (ext4_mb_use_preallocated
> and ext4_mb_normalize_request). Since the rbtree addressed this
> scalability issue we had decided to remove the trim logic in this
> patchset.
> 
> [1]
> https://lore.kernel.org/all/d7a98178-056b-6db5-6bce-4ead23f4a257@gmail.com/

I agree the O(N) traversal is not in any performance sensitive path.

> That being said, I do agree that there should be some way to limit the
> PAs from taking up an unreasonable amount of buddy space, memory and CPU
> cycles in use cases like database files and disk files of long running
> VMs. Previously the limit was 512 PAs per inode and trim was happening
> in an LRU fashion, which is not very straightforward to implement in
> trees. 
> 
> Another approach is rather than having a hard limit, we can throttle the
> PAs based on some parameter like total active PAs in FS or FSUtil% of
> the PAs but we might need to take care of fairness so one inode is not
> holding all the PAs while others get throttled.
> 
> Anyways, I think the trimming part would need some brainstorming to get
> right so just wondering if we could keep that as part of a separate
> patchset and remove the trimming logic for now since rbtree has
> addressed the scalability concerns in allocation path.

I agree the fact it took until 2020 for someone to notice inode PAs can
be cumulating enough for full scan to matter on block allocation means that
this is not a pressing issue. So I'm OK postponing it for now since I also
don't have a great idea how to best trim excessive preallocations.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
