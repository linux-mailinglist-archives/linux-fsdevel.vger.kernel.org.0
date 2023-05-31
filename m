Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45103717AD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 10:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjEaI6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 04:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEaI6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 04:58:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7257C0;
        Wed, 31 May 2023 01:58:03 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V8a5W4018378;
        Wed, 31 May 2023 08:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=DCijIo14IUSsxzXzY9h3WyI/6hJYnKjXFiCCeIxmllw=;
 b=VFZFGvSDUmzEdeJ7iPQn0JiNqtlQDiseu52b/KMO0Jj0m5NgOvh7nbYEflxGVXj0We28
 zvCFhGlnlTZ4wI0XfOuuAuTMB0jO3uvU3OFVmFBjqLgFBkSpgDXMHAHuL3tHMG9OXkyf
 ZypQu3rSLM9PXyD1y3dxxM3NLVDVE0xUMvftHgszXRFIxFbsgXReBDwlWHpXgft/pTg/
 aMKhn19i4G2lvzjELYxDI7rKvIZkOOBl2gENwAh30d9GfiXySG1y3nDl3h24bQLyvpBo
 Ur7IoSNYFOeTsLYkIXy+eJqqoS61/voyP+H62NY+ldwHZH4A8AvmUuxYxqyVF2vce23T 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwygvdamc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:57:54 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34V8tnb2025274;
        Wed, 31 May 2023 08:57:54 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwygvdakn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:57:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34V4XbYc003811;
        Wed, 31 May 2023 08:57:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g51w2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:57:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34V8vmZl16646764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 08:57:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E03BD2004B;
        Wed, 31 May 2023 08:57:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFD0620040;
        Wed, 31 May 2023 08:57:46 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.79.149])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 31 May 2023 08:57:46 +0000 (GMT)
Date:   Wed, 31 May 2023 14:27:44 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 01/12] Revert "ext4: remove ac->ac_found >
 sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"
Message-ID: <ZHcMCGO5zW/P8LHh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
 <ddcae9658e46880dfec2fb0aa61d01fb3353d202.1685449706.git.ojaswin@linux.ibm.com>
 <CA+icZUXDFbxRvx8-pvEwsZAu+-28bX4VDTj6ZTPtvn4gWqGnCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUXDFbxRvx8-pvEwsZAu+-28bX4VDTj6ZTPtvn4gWqGnCg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tq1pskt3MKwfPjNSmqkQTGhC4glPTm7c
X-Proofpoint-GUID: e0FgBzwwsD7oRx9WBcyChwPsMs0b4CVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_04,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=979 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 06:28:22PM +0200, Sedat Dilek wrote:
> On Tue, May 30, 2023 at 3:25 PM Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:
> >
> > This reverts commit 32c0869370194ae5ac9f9f501953ef693040f6a1.
> >
> > The reverted commit was intended to remove a dead check however it was observed
> > that this check was actually being used to exit early instead of looping
> > sbi->s_mb_max_to_scan times when we are able to find a free extent bigger than
> > the goal extent. Due to this, a my performance tests (fsmark, parallel file
> > writes in a highly fragmented FS) were seeing a 2x-3x regression.
> >
> > Example, the default value of the following variables is:
> >
> > sbi->s_mb_max_to_scan = 200
> > sbi->s_mb_min_to_scan = 10
> >
> > In ext4_mb_check_limits() if we find an extent smaller than goal, then we return
> > early and try again. This loop will go on until we have processed
> > sbi->s_mb_max_to_scan(=200) number of free extents at which point we exit and
> > just use whatever we have even if it is smaller than goal extent.
> >
> > Now, the regression comes when we find an extent bigger than goal. Earlier, in
> > this case we would loop only sbi->s_mb_min_to_scan(=10) times and then just use
> > the bigger extent. However with commit 32c08693 that check was removed and hence
> > we would loop sbi->s_mb_max_to_scan(=200) times even though we have a big enough
> > free extent to satisfy the request. The only time we would exit early would be
> > when the free extent is *exactly* the size of our goal, which is pretty uncommon
> > occurrence and so we would almost always end up looping 200 times.
> >
> > Hence, revert the commit by adding the check back to fix the regression. Also
> > add a comment to outline this policy.
> >
> 
> Hi,
> 
> I applied this single patch of your series v2 on top of Linux v6.4-rc4.
> 
> So, if this is a regression I ask myself if this is material for Linux 6.4?
> 
> Can you comment on this, please?
> 
> Thanks.
> 
> Regards,
> -Sedat-

Hi Sedat,

Since this patch fixes a regression I think it should ideally go in
Linux 6.4

Regards,
ojaswin
> 
> 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > ---
> >  fs/ext4/mballoc.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index d4b6a2c1881d..7ac6d3524f29 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -2063,7 +2063,7 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
> >         if (bex->fe_len < gex->fe_len)
> >                 return;
> >
> > -       if (finish_group)
> > +       if (finish_group || ac->ac_found > sbi->s_mb_min_to_scan)
> >                 ext4_mb_use_best_found(ac, e4b);
> >  }
> >
> > @@ -2075,6 +2075,20 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
> >   * in the context. Later, the best found extent will be used, if
> >   * mballoc can't find good enough extent.
> >   *
> > + * The algorithm used is roughly as follows:
> > + *
> > + * * If free extent found is exactly as big as goal, then
> > + *   stop the scan and use it immediately
> > + *
> > + * * If free extent found is smaller than goal, then keep retrying
> > + *   upto a max of sbi->s_mb_max_to_scan times (default 200). After
> > + *   that stop scanning and use whatever we have.
> > + *
> > + * * If free extent found is bigger than goal, then keep retrying
> > + *   upto a max of sbi->s_mb_min_to_scan times (default 10) before
> > + *   stopping the scan and using the extent.
> > + *
> > + *
> >   * FIXME: real allocation policy is to be designed yet!
> >   */
> >  static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
> > --
> > 2.31.1
> >
