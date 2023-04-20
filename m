Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458C36E8A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjDTGdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjDTGdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:33:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2854C24;
        Wed, 19 Apr 2023 23:33:00 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K5OLra028415;
        Thu, 20 Apr 2023 06:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=oaQBcVSLTHhfZ06cyqHfnQOj/aWC6x8DCiKcXTO7fp0=;
 b=exXGh3ebp8VerMC9eG1FWuHmzgjZ6WqirmM4SH8ZisAr7dtfzFZEHd3OR+eKZrtW4G9Q
 b5+dzQinTxy9tE8GVmZg722NbwEI9KxNuQaIM7cHqC9a1Hof8euAWiFSJXkWb08oAO6C
 Wlbqmn6q2OVdeSAskBMhjq8V2H6O8Oz1RgHysooNL3GuI4Gt2I4u46kmC0MEf07cZvM0
 noqEpPttMTelct7a2nuS+ZjVoq3HvU+NOhRlDx3Lu0w+i9X1F/mcCNKzZ7KknfDjIjtA
 DQvyN0WhykqZQwntaii9lQ+gnr0mPPijeFLqfOxJQ69KR5qP8ZO3dnElORAUpkrnnbQu GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q2y7d1qcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:32:54 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33K6PA09001434;
        Thu, 20 Apr 2023 06:32:54 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q2y7d1qbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:32:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33JIkcAd010564;
        Thu, 20 Apr 2023 06:32:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pykj6k66j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 06:32:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33K6WnZH17171034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 06:32:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5910020043;
        Thu, 20 Apr 2023 06:32:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ED4B20040;
        Thu, 20 Apr 2023 06:32:47 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Apr 2023 06:32:47 +0000 (GMT)
Date:   Thu, 20 Apr 2023 12:02:44 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 04/11] ext4: Convert mballoc cr (criteria) to enum
Message-ID: <ZEDcjKUG3OjK9hg9@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <9670431b31aa62e83509fa2802aad364910ee52e.1674822311.git.ojaswin@linux.ibm.com>
 <20230309121122.vzfswandgqqm4yk5@quack3>
 <ZBRAZsvbcSBNJ+Pl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230323105537.rrecw5xqqzmw567d@quack3>
 <ZB8IB14yLaoY4+19@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB8IB14yLaoY4+19@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dIfsX5fbnPSW3ub2EXv3iTCdPmIuUPFj
X-Proofpoint-GUID: _3-pQLHFycWDufRYiLyrr9r8QMvMsxl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_03,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304200052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 25, 2023 at 08:12:36PM +0530, Ojaswin Mujoo wrote:
> On Thu, Mar 23, 2023 at 11:55:37AM +0100, Jan Kara wrote:
> > On Fri 17-03-23 15:56:46, Ojaswin Mujoo wrote:
> > > On Thu, Mar 09, 2023 at 01:11:22PM +0100, Jan Kara wrote:
> > > > Also when going for symbolic allocator scan names maybe we could actually
> > > > make names sensible instead of CR[0-4]? Perhaps like CR_ORDER2_ALIGNED,
> > > > CR_BEST_LENGHT_FAST, CR_BEST_LENGTH_ALL, CR_ANY_FREE. And probably we could
> > > > deal with ordered comparisons like in:
> > > I like this idea, it should make the code a bit more easier to
> > > understand. However just wondering if I should do it as a part of this
> > > series or a separate patch since we'll be touching code all around and 
> > > I don't want to confuse people with the noise :) 
> > 
> > I guess a mechanical rename should not be really confusing. It just has to
> > be a separate patch.
> Alright, got it.
> > 
> > > > 
> > > >                 if (cr < 2 &&
> > > >                     (!sbi->s_log_groups_per_flex ||
> > > >                      ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &
> > > >                     !(ext4_has_group_desc_csum(sb) &&
> > > >                       (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
> > > >                         return 0;
> > > > 
> > > > to declare CR_FAST_SCAN = 2, or something like that. What do you think?
> > > About this, wont it be better to just use something like
> > > 
> > > cr < CR_BEST_LENGTH_ALL 
> > > 
> > > instead of defining a new CR_FAST_SCAN = 2.
> > 
> > Yeah, that works as well.
> > 
> > > The only concern is that if we add a new "fast" CR (say between
> > > CR_BEST_LENGTH_FAST and CR_BEST_LENGTH_ALL) then we'll need to make
> > > sure we also update CR_FAST_SCAN to 3 which is easy to miss.
> > 
> > Well, you have that problem with any naming scheme (and even with numbers).
> > So as long as names are all defined together, there's reasonable chance
> > you'll remember to verify the limits still hold :)
> haha that's true. Anyways, I'll try a few things and see what looks
> good. Thanks for the suggestions.
Hey Jan,

So I was playing around with this and I prepare a patch to convert CR
numbers to symbolic names and it looks good as far as things like these
are concerned:

  if (cr < CR_POWER2_ALIGNED)
		...

However there's one problem that this numeric naming scheme is used in
several places like struct member names, function names, traces and
comments. The issue is that replacing it everywhere is making some of
the names very long for example:

	atomic_read(&sbi->s_bal_cr0_bad_suggestions));

becomes:

	atomic_read(&sbi->s_bal_cr_power2_aligned_bad_suggestions));

And this is kind of making the code look messy at a lot of places. So
right now there are a few options we can consider:

1. Use symbolic names everywhere at the cost of readability

2. Keep function names/members as is but change criterias enums to symbolic
names. This again is not ideal as it makes things ambiguous.

3. Keep the enums as is i.e. CR0, CR1.. etc and add the documentation in the enum
declaration on what these enum means. (we can still use CR_FAST_SCAN).

Let me know you thoughts on this, or incase you'd like to look at the
patch I can attach that as well.

Regards,
ojaswin
> 
> Regards,
> ojaswin
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
