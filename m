Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8813A2146
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 02:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFJAX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 20:23:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229957AbhFJAX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:23:26 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15A0FgFW020551;
        Wed, 9 Jun 2021 17:21:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=TpK1cdobo9o7wKCHVN2XbKA1lu3rGsD869bUAtYau8w=;
 b=k/2l+fZ5vvfGbMqv4qfFYUW2YzWyA5kDEJDH8d5ZOzxro+78YefJKW3k48uLoh4ESc6u
 nMkL2lrZQVgw7s69ZMUtLaDkRFb3sIYaPMFXt7MzKDhMc9KR6Z/Zngz7bpWKnEtsA//X
 lhVEvIEi+HlajwQ0J8Jhk42I0jscqpsoKi0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3925y2vgt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Jun 2021 17:21:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 17:21:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoXcGS2cSf6A0kDXiN/fLy1MAf+4lkeUIZMCUvwuZAikEW65hrHfwj8OfDn1SU6sUEMfOoWvOYvsMaUtX7OHq5qB7ASyu1ybMtMYUtyNRmz49dpaceSvPlWbAbefGgxpKZ+svUkKNwOVuSYvahH9/ObrkZZshj2GFS5TXXeBUd+TTDcMmlVi5our8R3YCr4dQ9SB0pcX5Fg15Mi43rBu3rxBE/4YCxjMUCvdMrG52LOw8HReQxH04gRXG8SMtGk05SBjyOTXp0t0T8oDPyQ+MthawUT9qJKU7oxyFtywDtmITgGF9MSDfsNoKg0kDf8yDOcULM/BmsN9q39SN+mjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpK1cdobo9o7wKCHVN2XbKA1lu3rGsD869bUAtYau8w=;
 b=BfbPlHuvfr7CoH+dllkScm+W3sg9E4NQjT/3NavjfB9eyZaWbtbHKzBFR2WHPuvQRRBGDAvbgT1hrsuHvpVfWk8BurXV/aiIdkr9HFghSpvxGs/qok4gBjNbJrkoyF+xIfVSYzUuwgf43ylIenfFuIrXoWh/0Qcbd/jHFabf29r03SxH94eqPIjFWJ4YPVpsPDziIK90wdl04M9pcYT+syazWuus1+4o0ZZMvmGNHymFIupncWBUBBKyEupQwLa0ifuVkynR/oZIFH8eZQ51IIs2aGA4+9eVL44X8EIcFTsZU863IgEwC33JLmLQJL1gHPiK0thAvBnsdOYlVbgCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3288.namprd15.prod.outlook.com (2603:10b6:a03:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 00:21:17 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 00:21:17 +0000
Date:   Wed, 9 Jun 2021 17:21:14 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH v9 3/8] writeback, cgroup: increment isw_nr_in_flight
 before grabbing an inode
Message-ID: <YMFa+guFw7OFjf3X@carbon.dhcp.thefacebook.com>
References: <20210608230225.2078447-1-guro@fb.com>
 <20210608230225.2078447-4-guro@fb.com>
 <YMA2XEnJrHyVLWrD@T590>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YMA2XEnJrHyVLWrD@T590>
X-Originating-IP: [2620:10d:c090:400::5:4d50]
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4d50) by SJ0PR03CA0129.namprd03.prod.outlook.com (2603:10b6:a03:33c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 00:21:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdb4613c-1038-48e8-4112-08d92ba5a9d0
X-MS-TrafficTypeDiagnostic: BYAPR15MB3288:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32886CDB1CC71072D916ABE1BE359@BYAPR15MB3288.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:250;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04W54hqiGmcJak8cQqEJC06XQW2V3fcLEiO8Kcw05SWig8ZdDELBnyVvyAHYcpZm46LMUndVYBpe/8YqxnzT02HfWSq+EDD3xkXI7+tBB87o60XGCGxahR+/5eMZ5bEebeKwTatbeBECWLYhKlXvrIa7BXOwruxnyMa866oseBprDOetVE3KTv2UBHSx10qcCTwnMSVYRvvS4vjJGfKc/X5oNBORWNChrNXO1+NvLgMfuoYy7/vdFOdMiyf/jnjNNFWCYP+m7b7vKEpEqmsaNiWOByxeGqJoCELPSEpqHVZqOE2aBgYsAZ3fgqwjeNaVyg28333xD9ax0AHh9jva/pajaVlfpHyXc6EZ61SUuMrZVa+mX0whjkeyS7StPAlbPBNqA5/vriOs/jj2N5ubb9cIN+Lh1NccQWjVP5cThXQXs/7Dga/Cj7/5BFjvqq0pdU7uWOGU+6Tkjhfga7aLX9nQBTWcNt85XvOr7Voa6alUqoJPVhPd8FNUJVIUGsbtBA8xuK5KNLCxGoIMgSImTgpg+338Kd3IlJNDHISjNuM+U3AQ4x3+OWkqKs5ds8HZl/RQg7ABEZ4APDphPwhequoktOMaTnwKtKefGD5ukjoqRaZKAJGTLfPicJF2/75vPj0n5M9buQP+Io0mkAghTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(8676002)(186003)(6506007)(86362001)(66556008)(9686003)(478600001)(38100700002)(8936002)(66946007)(66476007)(53546011)(316002)(6916009)(7696005)(5660300002)(4326008)(55016002)(52116002)(83380400001)(2906002)(54906003)(16526019)(7416002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jgwd+etnhlU2chyfMY/HWV/rvcTCaJj0Sp/6jQAWzwuR/9Ijie00cGlf3ZQ0?=
 =?us-ascii?Q?sBA7pwlGtPG4X+qrGwPM68vePL03Cj+C1O319w0jFzx24bbDgBo9jRPs9Jaq?=
 =?us-ascii?Q?/+vobUdelLmpTpcChQPAfukVHpRZYj+6TcA2+5TU7tiXESckcR77ZL+5TbCN?=
 =?us-ascii?Q?Nac0jQII3nsN2VbKOmyeRMTqzzIwseA5VnaqtJE2ZRLa0HVMXmYwqVODOVfB?=
 =?us-ascii?Q?J3WvB4cR/QmWiqGGuYKU0V6e85H3CTpP563c7Nlbbw423jSb0gJ3jxqtc+O9?=
 =?us-ascii?Q?KBidFzXiEGLWc77KosiKjPJsBM1Wg7P7UNSToG1l2tFoRF97jf9mD3YlJPJt?=
 =?us-ascii?Q?Jd/rhEIPVg+bi+pcLUVURGX3kk8ilQfRtxNqJ5wsMQlYUYzYzvMCdx0O1ITY?=
 =?us-ascii?Q?UlTRdl9Z63bEuDq8RREFVarXE/oOi9Npd9EnZSKkIvOtIfUZQTkoLT5ouctT?=
 =?us-ascii?Q?WumPvUePGGz9thwkh93vTQYSL/ktk78ZbTUcuKFBZQ3dTV6DB+AUWXxPb0u7?=
 =?us-ascii?Q?DToZoy5vgJnONu0XrSeq6mvs6jK2e38PRMPSS1iU5wZT8wzY4KKiI5jBRrz1?=
 =?us-ascii?Q?bdSsMr/PVzhgOcKwSRM/m8ensJRmKneYfsWqVtrlECb1IUqGQc67oqE8k7df?=
 =?us-ascii?Q?DJtU2FHz9Fe0SVTCuzE0/nC2c6dkIEch1MmL4wYIR2Jc/r7vjrSCwGX3AOVv?=
 =?us-ascii?Q?LV1J0lM1QI8T+bNJ7rOyX/9ZhVKaf9liD3R3d2HCYCxgEfflYpVi5rEVm2eU?=
 =?us-ascii?Q?ayUXxpBE4BWAkeH6VbDtSFUQt7QDDTHfm7OnXjKW1Pt92G7INVZ0WBwHe8N6?=
 =?us-ascii?Q?MDMvGtlacrEY/w65PdX4RyUHTWeM7SEb5gzyDKMVrApn3FTQe+QJWLK/ckX9?=
 =?us-ascii?Q?WQeEHsgc8/m4mHfxoZ1YGwyMJtfNp2Zy1zKjHZVFqOZAJhXRZIC2XKuozZci?=
 =?us-ascii?Q?k7CCy4QSKN+yuAcVpFjIZmI689OTbf0mJ+F/JdN8oqQPSs7EryerEdQ8J5SM?=
 =?us-ascii?Q?yV2ExmkINkDXAyr1deyHJ9jpVW4W10P+LK6rJaM3CvY/R+zAYS7QD0Y369p2?=
 =?us-ascii?Q?787tAiN5pW9jVGwkInLpQ63YN4EsFzNzMtGDCm+q2HEKHNraGZSaxMyk0GYx?=
 =?us-ascii?Q?FIO5EyKwM7pe8jV0PuxauRLZ5dP97n7q6lbcUgNKodZugJqSBM8x8mN0nm1f?=
 =?us-ascii?Q?Yp3ucCVEQiViuLCWo0yW+6Ympl6rYVB8Jtswt8b1/kOFcnivMQgykWKIGCzI?=
 =?us-ascii?Q?hgLVAA5G8DjHq3ddSHo9/RKllg7ktBNI77W8EVbEC8ucpGHvPBdX5bcMrLeG?=
 =?us-ascii?Q?rD1bkzoDiZgHncrnvCQwpd2xkctmAqdCcRPCfSJmVJcXLQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb4613c-1038-48e8-4112-08d92ba5a9d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 00:21:17.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uNyR9K77Yec6XizboG4zBhepmV1P9FrWXGyLmMbVmICLM7iJtv3wRMfEGZFcFbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3288
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: K5BhMUB4VNTlPxlc9AlMkzgA8oyP45_Z
X-Proofpoint-ORIG-GUID: K5BhMUB4VNTlPxlc9AlMkzgA8oyP45_Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:32:44AM +0800, Ming Lei wrote:
> On Tue, Jun 08, 2021 at 04:02:20PM -0700, Roman Gushchin wrote:
> > isw_nr_in_flight is used do determine whether the inode switch queue
> > should be flushed from the umount path. Currently it's increased
> > after grabbing an inode and even scheduling the switch work. It means
> > the umount path can be walked past cleanup_offline_cgwb() with active
> > inode references, which can result in a "Busy inodes after unmount."
> > message and use-after-free issues (with inode->i_sb which gets freed).
> > 
> > Fix it by incrementing isw_nr_in_flight before doing anything with
> > the inode and decrementing in the case when switching wasn't scheduled.
> > 
> > The problem hasn't yet been seen in the real life and was discovered
> > by Jan Kara by looking into the code.
> > 
> > Suggested-by: Jan Kara <jack@suse.com>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/fs-writeback.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index b6fc13a4962d..4413e005c28c 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -505,6 +505,8 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> >  	if (!isw)
> >  		return;
> >  
> > +	atomic_inc(&isw_nr_in_flight);
> 
> smp_mb() may be required for ordering the WRITE in 'atomic_inc(&isw_nr_in_flight)'
> and the following READ on 'inode->i_sb->s_flags & SB_ACTIVE'. Otherwise,
> cgroup_writeback_umount() may observe zero of 'isw_nr_in_flight' because of
> re-order of the two OPs, then miss the flush_workqueue().
> 
> Also this barrier should serve as pair of the one added in cgroup_writeback_umount(),
> so maybe this patch should be merged with 2/8.

Hi Ming!

Good point, I agree. How about a patch below?

Thanks!

--

From 282861286074c47907759d80c01419f0d0630dae Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 9 Jun 2021 14:14:26 -0700
Subject: [PATCH] cgroup, writeback: add smp_mb() to inode_prepare_wbs_switch()

Add a memory barrier between incrementing isw_nr_in_flight
and checking the sb's SB_ACTIVE flag and grabbing an inode in
inode_prepare_wbs_switch(). It's required to prevent grabbing
an inode before incrementing isw_nr_in_flight, otherwise
0 can be obtained as isw_nr_in_flight in cgroup_writeback_umount()
and isw_wq will not be flushed, potentially leading to a memory
corruption.

Added smp_mb() will work in pair with smp_mb() in
cgroup_writeback_umount().

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 545fce68e919..6332b86ca4ed 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -513,6 +513,14 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 static bool inode_prepare_wbs_switch(struct inode *inode,
 				     struct bdi_writeback *new_wb)
 {
+	/*
+	 * Paired with smp_mb() in cgroup_writeback_umount().
+	 * isw_nr_in_flight must be increased before checking SB_ACTIVE and
+	 * grabbing an inode, otherwise isw_nr_in_flight can be observed as 0
+	 * in cgroup_writeback_umount() and the isw_wq will be not flushed.
+	 */
+	smp_mb();
+
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
-- 
2.31.1

