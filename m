Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BFC73F8BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjF0J2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 05:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0J2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:28:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B991FD0;
        Tue, 27 Jun 2023 02:28:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2BEA2188D;
        Tue, 27 Jun 2023 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687858109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BjikeLvX+FChLy8RoplnvK+UYq47A/bo4IeIIzk5ESE=;
        b=uzqB8ANcV3bDXTqJDGGR3sstOV7O+PF/36anLRNN20CG4qB/FDfPG92MO6Gv/iWZU/ZIp5
        AYn28qmqn7G9dP0ZtXbBeRQaUSm0cQ2kkOtcoicFwcO6u+qQYrUICCOw5GFHj1wc1U3jKi
        XvJSh72f/iKjrRVrS+ALzLGu7TpPsFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687858109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BjikeLvX+FChLy8RoplnvK+UYq47A/bo4IeIIzk5ESE=;
        b=Yr+uvhTq5CZBmrydGr2wN588ifL+v7Nn5r5WcEMz2K1Fvov7DeO8Hz5u8Xcc4n33PwdWUQ
        sSWz5ECnUS9zDqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A216113462;
        Tue, 27 Jun 2023 09:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YFaFJ72rmmQvXQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 27 Jun 2023 09:28:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1626AA0762; Tue, 27 Jun 2023 11:28:29 +0200 (CEST)
Date:   Tue, 27 Jun 2023 11:28:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] quota: fix race condition between dqput() and
 dquot_mark_dquot_dirty()
Message-ID: <20230627092829.d3s3x4nkprux7jmo@quack3>
References: <20230616085608.42435-1-libaokun1@huawei.com>
 <20230616152824.ndpgvkegvvip2ahh@quack3>
 <c8daf4a0-769f-f769-50f6-8b7063542499@huawei.com>
 <20230622145620.hk3bdjxtlr64gtzl@quack3>
 <b73894fc-0c7a-0503-25ad-ab5a9dfbd852@huawei.com>
 <20230626130957.kvfli23djxc2opkq@quack3>
 <2486ec73-55e0-00cb-fc76-97b9b285a9ce@huawei.com>
 <20230627083406.hhjf55e2tqnwqaf6@quack3>
 <fe7d3b03-4d08-34ac-a695-a5c57c751aeb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe7d3b03-4d08-34ac-a695-a5c57c751aeb@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-06-23 17:08:27, Baokun Li wrote:
> Hello!
> 
> On 2023/6/27 16:34, Jan Kara wrote:
> > Hello!
> > 
> > On Mon 26-06-23 21:55:49, Baokun Li wrote:
> > > On 2023/6/26 21:09, Jan Kara wrote:
> > > > On Sun 25-06-23 15:56:10, Baokun Li wrote:
> > > > > > > I think we can simply focus on the race between the DQ_ACTIVE_B flag and
> > > > > > > the DQ_MOD_B flag, which is the core problem, because the same quota
> > > > > > > should not have both flags. These two flags are protected by dq_list_lock
> > > > > > > and dquot->dq_lock respectively, so it makes sense to add a
> > > > > > > wait_on_dquot() to ensure the accuracy of DQ_ACTIVE_B.
> > > > > > But the fundamental problem is not only the race with DQ_MOD_B setting. The
> > > > > > dquot structure can be completely freed by the time
> > > > > > dquot_claim_space_nodirty() calls dquot_mark_dquot_dirty() on it. That's
> > > > > > why I think making __dquot_transfer() obey dquot_srcu rules is the right
> > > > > > solution.
> > > > > Yes, now I also think that making __dquot_transfer() obey dquot_srcu
> > > > > rules is a better solution. But with inode->i_lock protection, why would
> > > > > the dquot structure be completely freed?
> > > > Well, when dquot_claim_space_nodirty() calls mark_all_dquot_dirty() it does
> > > > not hold any locks (only dquot_srcu). So nothing prevents dquot_transfer()
> > > > to go, swap dquot structure pointers and drop dquot references and after
> > > > that mark_all_dquot_dirty() can use a stale pointer to call
> > > > mark_dquot_dirty() on already freed memory.
> > > > 
> > > No, this doesn't look like it's going to happen.  The
> > > mark_all_dquot_dirty() uses a pointer array pointer, the dquot in the
> > > array is dynamically changing, so after swap dquot structure pointers,
> > > mark_all_dquot_dirty() uses the new pointer, and the stale pointer is
> > > always destroyed after swap, so there is no case of using the stale
> > > pointer here.
> > There is a case - CPU0 can prefetch the values from dquots[] array into its
> > local cache, then CPU1 can update the dquots[] array (these writes can
> > happily stay in CPU1 store cache invisible to other CPUs) and free the
> > dquots via dqput(). Then CPU0 can pass the prefetched dquot pointers to
> > mark_dquot_dirty(). There are no locks or memory barries preventing CPUs
> > from ordering instructions and memory operations like this in the code...
> > You can read Documentation/memory-barriers.txt about all the perils current
> > CPU architecture brings wrt coordination of memory accesses among CPUs ;)
> > 
> > 								Honza
> 
> Got it!
> 
> Sorry for misunderstanding you (I thought "completely freed" meant
> dquot_destroy(), but you should have meant dquot_release()).

Well, the dquot can even get to dquot_destroy(). There's nothing really
preventing CPU2 going into memory reclaim and free the dquot in
dqcache_shrink_scan() still before CPU0 even calls mark_dquot_dirty() on
it. Sure such timing on real hardware is very unlikely but in a VM where a
virtual CPU can get starved for a significant amount of time this could
happen.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
