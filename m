Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43A7282F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjFHOp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 10:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbjFHOp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:45:26 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0542D5F
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 07:45:25 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 358Ej5Kk022272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 10:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686235508; bh=7D3ONS90tBxtxvVFSuJRpXjTA614AstPIznp0J//6Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LVoKt6KagPGCwFswtD8PBQ3oYWmm9gQbfn0r34MLUmolqI00rVzn8tHCqQdzeQbNw
         joxBhitCDopKhXv0/t+tFwRwrqCLJX8zuTGxn2wqkuN8thxRcE3PpxXrXkxgMtBN2u
         ra2vytRQNtiW928txOvbfXBgcBLRnJUwEU0zR3s7JMt7Zis+hx6Hw7p34HrEa5vO2q
         SBK4FZTBTsX6cLNehT+55+xx37StnBrWzV+eTfBpi2iygu3QvIjUqXgGrbLf+sr8iD
         JIrYSdHcwnoQTo9Z0eN0kNIjLH3c9DHlnymAXmfQME26NAj0v+bb5LT5Va002Yh9SV
         YHbRC8iR46A/g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 53E3615C04C3; Thu,  8 Jun 2023 10:45:05 -0400 (EDT)
Date:   Thu, 8 Jun 2023 10:45:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 11/12] ext4: Add allocation criteria 1.5 (CR1_5)
Message-ID: <20230608144505.GA1422249@mit.edu>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <150fdf65c8e4cc4dba71e020ce0859bcf636a5ff.1685449706.git.ojaswin@linux.ibm.com>
 <20230607102103.gavbiywdudx54opk@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607102103.gavbiywdudx54opk@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan, thanks for the comments to Ojaswin's patch series.  Since I had
already landed his patch series in my tree and have been testing it,
I've fixed the obvious issues you've raised in a fixup patch
(attached).

There is one issue which I have not fixed:

On Wed, Jun 07, 2023 at 12:21:03PM +0200, Jan Kara wrote:
> > +	for (i = order; i >= min_order; i--) {
> > +		int frag_order;
> > +		/*
> > +		 * Scale down goal len to make sure we find something
> > +		 * in the free fragments list. Basically, reduce
> > +		 * preallocations.
> > +		 */
> > +		ac->ac_g_ex.fe_len = 1 << i;
> 
> I smell some off-by-one issues here. Look fls(1) == 1 so (1 << fls(n)) > n.
> Hence this loop will actually *grow* the goal allocation length. Also I'm
> not sure why you have +1 in min_order = fls(ac->ac_o_ex.fe_len) + 1.

Ojaswin, could you take a look this?  Thanks!!

	       	   	       	      - Ted

commit 182d2d90a180838789ed5a19e08c333043d1617a
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jun 8 10:39:35 2023 -0400

    ext4: clean up mballoc criteria comments
    
    Line wrap and slightly clarify the comments describing mballoc's
    cirtiera.
    
    Define EXT4_MB_NUM_CRS as part of the enum, so that it will
    automatically get updated when criteria is added or removed.
    
    Also fix a potential unitialized use of 'cr' variable if
    CONFIG_EXT4_DEBUG is enabled.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6a1f013d23f7..45a531446ea2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -128,47 +128,52 @@ enum SHIFT_DIRECTION {
 };
 
 /*
- * Number of criterias defined. For each criteria, mballoc has slightly
- * different way of finding the required blocks nad usually, higher the
- * criteria the slower the allocation. We start at lower criterias and keep
- * falling back to higher ones if we are not able to find any blocks.
- */
-#define EXT4_MB_NUM_CRS 5
-/*
- * All possible allocation criterias for mballoc. Lower are faster.
+ * For each criteria, mballoc has slightly different way of finding
+ * the required blocks nad usually, higher the criteria the slower the
+ * allocation.  We start at lower criterias and keep falling back to
+ * higher ones if we are not able to find any blocks.  Lower (earlier)
+ * criteria are faster.
  */
 enum criteria {
 	/*
-	 * Used when number of blocks needed is a power of 2. This doesn't
-	 * trigger any disk IO except prefetch and is the fastest criteria.
+	 * Used when number of blocks needed is a power of 2. This
+	 * doesn't trigger any disk IO except prefetch and is the
+	 * fastest criteria.
 	 */
 	CR_POWER2_ALIGNED,
 
 	/*
-	 * Tries to lookup in-memory data structures to find the most suitable
-	 * group that satisfies goal request. No disk IO except block prefetch.
+	 * Tries to lookup in-memory data structures to find the most
+	 * suitable group that satisfies goal request. No disk IO
+	 * except block prefetch.
 	 */
 	CR_GOAL_LEN_FAST,
 
         /*
-	 * Same as CR_GOAL_LEN_FAST but is allowed to reduce the goal length to
-         * the best available length for faster allocation.
+	 * Same as CR_GOAL_LEN_FAST but is allowed to reduce the goal
+         * length to the best available length for faster allocation.
 	 */
 	CR_BEST_AVAIL_LEN,
 
 	/*
-	 * Reads each block group sequentially, performing disk IO if necessary, to
-	 * find find_suitable block group. Tries to allocate goal length but might trim
-	 * the request if nothing is found after enough tries.
+	 * Reads each block group sequentially, performing disk IO if
+	 * necessary, to find find_suitable block group. Tries to
+	 * allocate goal length but might trim the request if nothing
+	 * is found after enough tries.
 	 */
 	CR_GOAL_LEN_SLOW,
 
 	/*
-	 * Finds the first free set of blocks and allocates those. This is only
-	 * used in rare cases when CR_GOAL_LEN_SLOW also fails to allocate
-	 * anything.
+	 * Finds the first free set of blocks and allocates
+	 * those. This is only used in rare cases when
+	 * CR_GOAL_LEN_SLOW also fails to allocate anything.
 	 */
 	CR_ANY_FREE,
+
+	/*
+	 * Number of criterias defined.
+	 */
+	EXT4_MB_NUM_CRS
 };
 
 /* criteria below which we use fast block scanning and avoid unnecessary IO */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8a6896d4e9b0..2f9f5dc720cc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2759,7 +2759,7 @@ static noinline_for_stack int
 ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 {
 	ext4_group_t prefetch_grp = 0, ngroups, group, i;
-	enum criteria cr, new_cr;
+	enum criteria new_cr, cr = CR_GOAL_LEN_FAST;
 	int err = 0, first_err = 0;
 	unsigned int nr = 0, prefetch_ios = 0;
 	struct ext4_sb_info *sbi;
@@ -2816,12 +2816,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 		spin_unlock(&sbi->s_md_lock);
 	}
 
-	/* Let's just scan groups to find more-less suitable blocks */
-	cr = ac->ac_2order ? CR_POWER2_ALIGNED : CR_GOAL_LEN_FAST;
 	/*
-	 * cr == CR_POWER2_ALIGNED try to get exact allocation,
-	 * cr == CR_ANY_FREE try to get anything
+	 * Let's just scan groups to find more-less suitable blocks We
+	 * start with CR_GOAL_LEN_FAST, unless it is power of 2
+	 * aligned, in which case let's do that faster approach first.
 	 */
+	if (ac->ac_2order)
+		cr = CR_POWER2_ALIGNED;
 repeat:
 	for (; cr < EXT4_MB_NUM_CRS && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
 		ac->ac_criteria = cr;
