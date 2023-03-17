Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579666BE86E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 12:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCQLjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 07:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCQLjR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:39:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DE7A6755;
        Fri, 17 Mar 2023 04:38:50 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HBAVJW035099;
        Fri, 17 Mar 2023 11:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RHd2xuUbJVsrE+lDQWezGvyR0QUXW4R0cjT3qw7Db94=;
 b=NEjWDkuQx4WfXU8JTFs3HYh4e0cYCf/DabKeT7eMxXtfIGTpFzQyT+Hiw0dy39sB7gtn
 07maVfvGKESW5OCTRSpo6BvdyIPXC2e+9frZmBBaKJq4I6OBSHzx29t+kSeEhA2vQ9ba
 3p6ZEAmRC/VQmKCsNQtskmu2r3Zj+X7vNYI67SM9jD7pJUtMKynG5Nggw8stBDVyBwsk
 vE8uKpsNyxE7z7pQaAva5EaLM96kb9ASpVobIgH8348mHb/MQuyrk0/PnP4gJV6Pvf9b
 FPrfd+NMZfY6qbbYQZdKuVyIaSPg1f4D90mF3RdS6WQtWu6pjGXnqahR0xn05aR9nx6p Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcpbtsj25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 11:37:31 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32HBKgl2029519;
        Fri, 17 Mar 2023 11:37:31 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcpbtsj18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 11:37:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32H78tBF022053;
        Fri, 17 Mar 2023 11:37:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pbsvb22h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 11:37:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32HBbQWv21955116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 11:37:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C3C20040;
        Fri, 17 Mar 2023 11:37:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CEFC20043;
        Fri, 17 Mar 2023 11:37:24 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.91.202])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 17 Mar 2023 11:37:24 +0000 (GMT)
Date:   Fri, 17 Mar 2023 17:07:21 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 11/11] ext4: Add allocation criteria 1.5 (CR1_5)
Message-ID: <ZBRQ8W/RL/Tjju68@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <08173ee255f70cdc8de9ac3aa2e851f9d74acb12.1674822312.git.ojaswin@linux.ibm.com>
 <20230309150649.5pnhqsf2khvffl6l@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309150649.5pnhqsf2khvffl6l@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YfD3d6Iv9TI2t4v1ls7vZcS1W_G0Q0B4
X-Proofpoint-GUID: AgVLpbIiXyGlNVdbEeJzuL4DS1tNfKv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_06,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:06:49PM +0100, Jan Kara wrote:
> On Fri 27-01-23 18:07:38, Ojaswin Mujoo wrote:
> > CR1_5 aims to optimize allocations which can't be satisfied in CR1. The
> > fact that we couldn't find a group in CR1 suggests that it would be
> > difficult to find a continuous extent to compleltely satisfy our
> > allocations. So before falling to the slower CR2, in CR1.5 we
> > proactively trim the the preallocations so we can find a group with
> > (free / fragments) big enough.  This speeds up our allocation at the
> > cost of slightly reduced preallocation.
> > 
> > The patch also adds a new sysfs tunable:
> > 
> > * /sys/fs/ext4/<partition>/mb_cr1_5_max_trim_order
> > 
> > This controls how much CR1.5 can trim a request before falling to CR2.
> > For example, for a request of order 7 and max trim order 2, CR1.5 can
> > trim this upto order 5.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> The idea looks good. Couple of questions below...
> 
> > +/*
> > + * We couldn't find a group in CR1 so try to find the highest free fragment
> > + * order we have and proactively trim the goal request length to that order to
> > + * find a suitable group faster.
> > + *
> > + * This optimizes allocation speed at the cost of slightly reduced
> > + * preallocations. However, we make sure that we don't trim the request too
> > + * much and fall to CR2 in that case.
> > + */
> > +static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
> > +		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > +{
> > +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> > +	struct ext4_group_info *grp = NULL;
> > +	int i, order, min_order;
> > +
> > +	if (unlikely(ac->ac_flags & EXT4_MB_CR1_5_OPTIMIZED)) {
> > +		if (sbi->s_mb_stats)
> > +			atomic_inc(&sbi->s_bal_cr1_5_bad_suggestions);
> > +	}
> > +
> > +	/*
> > +	 * mb_avg_fragment_size_order() returns order in a way that makes
> > +	 * retrieving back the length using (1 << order) inaccurate. Hence, use
> > +	 * fls() instead since we need to know the actual length while modifying
> > +	 * goal length.
> > +	 */
> > +	order = fls(ac->ac_g_ex.fe_len);
> > +	min_order = order - sbi->s_mb_cr1_5_max_trim_order;
> 
> Given we still require the allocation contains at least originally
> requested blocks, is it ever the case that goal size would be 8 times
> larger than original alloc size? Otherwise the
> sbi->s_mb_cr1_5_max_trim_order logic seems a bit pointless...

Yes that is possible. In ext4_mb_normalize_request, for orignal request len <
8MB we actually determine the goal length based on the length of the
file (i_size) rather than the length of the original request. For eg:

	if (size <= 16 * 1024) {
		size = 16 * 1024;
	} else if (size <= 32 * 1024) {
		size = 32 * 1024;
	} else if (size <= 64 * 1024) {
		size = 64 * 1024;

and this goes all the way upto size = 8MB. So for a case where the file
is >8MB, even if the original len is of 1 block(4KB), the goal len would
be of 2048 blocks(8MB). That's why we decided to add a tunable depending
on the user's preference.
> 
> > +	if (min_order < 0)
> > +		min_order = 0;
> 
> Perhaps add:
> 
> 	if (1 << min_order < ac->ac_o_ex.fe_len)
> 		min_order = fls(ac->ac_o_ex.fe_len) + 1;
> 
> and then you can drop the condition from the loop below...
That looks better, will do it. Thanks!
> 
> > +
> > +	for (i = order; i >= min_order; i--) {
> > +		if (ac->ac_o_ex.fe_len <= (1 << i)) {
> > +			/*
> > +			 * Scale down goal len to make sure we find something
> > +			 * in the free fragments list. Basically, reduce
> > +			 * preallocations.
> > +			 */
> > +			ac->ac_g_ex.fe_len = 1 << i;
> 
> When scaling down the size with sbi->s_stripe > 1, it would be better to
> choose multiple of sbi->s_stripe and not power of two. But our stripe
> support is fairly weak anyway (e.g. initial goal size does not reflect it
> at all AFAICT) so probably we don't care here either.
Oh right, i missed that. I'll make the change as it doesn't harm to have
it here.

Thanks for the review!

regards,
ojaswin
> 
> > +		} else {
> > +			break;
> > +		}
> > +
> > +		grp = ext4_mb_find_good_group_avg_frag_lists(ac,
> > +							     mb_avg_fragment_size_order(ac->ac_sb,
> > +							     ac->ac_g_ex.fe_len));
> > +		if (grp)
> > +			break;
> > +	}
> > +
> > +	if (grp) {
> > +		*group = grp->bb_group;
> > +		ac->ac_flags |= EXT4_MB_CR1_5_OPTIMIZED;
> > +	} else {
> > +		/* Reset goal length to original goal length before falling into CR2 */
> > +		ac->ac_g_ex.fe_len = ac->ac_orig_goal_len;
> >  		*new_cr = CR2;
> >  	}
> >  }
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
