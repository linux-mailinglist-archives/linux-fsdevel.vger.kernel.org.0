Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580656C8EE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 15:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCYOrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 10:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCYOrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 10:47:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD3355AD;
        Sat, 25 Mar 2023 07:47:05 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32PCDAmQ029532;
        Sat, 25 Mar 2023 14:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=m5PvLsGj91oRQXg1jgyCTaRS+AaLTijSUGZ9SdvlRXk=;
 b=l+qa+CP2L4HYvzYmGe6jzbM+QiFABXaSLtFovr1HCNV02vbA3lc6bEdY2ybb6IddSP11
 rp3ypdx4+ormUv9Db9RrcuXZ028CazCc4zPq9FxPJnLsjdfpJE7oCAMkD8EaHm19zmNF
 XCNMwVjxkTbjAvLqxEDmAIZMXuU2nJv3BgNwUWFnSHDzI7tnSWSZsa/faxwwdG9rNonR
 NnTGSEWUKBM1Ipa+GawsaLaRKP/1aJaJtCHmfvzXQa4NNRDqs3eovyIfXF+T+8RtfJJR
 s+1/xLYdoVzysOKKyyV9qa3twcY4plYZ5sBL5W9sO3zlqfxVYQ6qEQYcnODehKvZETQ2 ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3phtwnptaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:47:01 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32PEjFLS011164;
        Sat, 25 Mar 2023 14:47:00 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3phtwnptan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:47:00 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32P2sjNu023354;
        Sat, 25 Mar 2023 14:46:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3phrk6rfuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:46:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32PEkuj325493978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 14:46:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DF6A20040;
        Sat, 25 Mar 2023 14:46:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7171F20043;
        Sat, 25 Mar 2023 14:46:54 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.64.140])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 25 Mar 2023 14:46:54 +0000 (GMT)
Date:   Sat, 25 Mar 2023 20:16:51 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 11/11] ext4: Add allocation criteria 1.5 (CR1_5)
Message-ID: <ZB8JW78PzPLc68hW@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <08173ee255f70cdc8de9ac3aa2e851f9d74acb12.1674822312.git.ojaswin@linux.ibm.com>
 <20230309150649.5pnhqsf2khvffl6l@quack3>
 <ZBRQ8W/RL/Tjju68@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230323110532.n2pxx3ouoffhl2u6@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323110532.n2pxx3ouoffhl2u6@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xGh6RJ5YlLf9b8ep_z4llGK-kGb4LOTv
X-Proofpoint-GUID: o7xJ34_KRYlTw6mpyW6hISQ_7E9GLd4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250120
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:05:32PM +0100, Jan Kara wrote:
> On Fri 17-03-23 17:07:21, Ojaswin Mujoo wrote:
> > On Thu, Mar 09, 2023 at 04:06:49PM +0100, Jan Kara wrote:
> > > On Fri 27-01-23 18:07:38, Ojaswin Mujoo wrote:
> > > > +/*
> > > > + * We couldn't find a group in CR1 so try to find the highest free fragment
> > > > + * order we have and proactively trim the goal request length to that order to
> > > > + * find a suitable group faster.
> > > > + *
> > > > + * This optimizes allocation speed at the cost of slightly reduced
> > > > + * preallocations. However, we make sure that we don't trim the request too
> > > > + * much and fall to CR2 in that case.
> > > > + */
> > > > +static void ext4_mb_choose_next_group_cr1_5(struct ext4_allocation_context *ac,
> > > > +		enum criteria *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> > > > +{
> > > > +	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> > > > +	struct ext4_group_info *grp = NULL;
> > > > +	int i, order, min_order;
> > > > +
> > > > +	if (unlikely(ac->ac_flags & EXT4_MB_CR1_5_OPTIMIZED)) {
> > > > +		if (sbi->s_mb_stats)
> > > > +			atomic_inc(&sbi->s_bal_cr1_5_bad_suggestions);
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * mb_avg_fragment_size_order() returns order in a way that makes
> > > > +	 * retrieving back the length using (1 << order) inaccurate. Hence, use
> > > > +	 * fls() instead since we need to know the actual length while modifying
> > > > +	 * goal length.
> > > > +	 */
> > > > +	order = fls(ac->ac_g_ex.fe_len);
> > > > +	min_order = order - sbi->s_mb_cr1_5_max_trim_order;
> > > 
> > > Given we still require the allocation contains at least originally
> > > requested blocks, is it ever the case that goal size would be 8 times
> > > larger than original alloc size? Otherwise the
> > > sbi->s_mb_cr1_5_max_trim_order logic seems a bit pointless...
> > 
> > Yes that is possible. In ext4_mb_normalize_request, for orignal request len <
> > 8MB we actually determine the goal length based on the length of the
> > file (i_size) rather than the length of the original request. For eg:
> > 
> > 	if (size <= 16 * 1024) {
> > 		size = 16 * 1024;
> > 	} else if (size <= 32 * 1024) {
> > 		size = 32 * 1024;
> > 	} else if (size <= 64 * 1024) {
> > 		size = 64 * 1024;
> > 
> > and this goes all the way upto size = 8MB. So for a case where the file
> > is >8MB, even if the original len is of 1 block(4KB), the goal len would
> > be of 2048 blocks(8MB). That's why we decided to add a tunable depending
> > on the user's preference.
> 
> Ah, I see. The problem with these tunables is that nobody knows to which
> value tune them :). But yeah, the default value looks sane so I don't
> object.
> 
Right, so in our workloads we were kinda seeing good improvement at this
value. 

But I think it really depends on how fragmented the FS is, we picked
trim order 3 as a safe value so we don't end up trimming too much when
CR2 could go and find something better.

Regards,
ojaswin
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
