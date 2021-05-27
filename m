Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE701393687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhE0TrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 15:47:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31190 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235425AbhE0TrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 15:47:11 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RJdtfE007579;
        Thu, 27 May 2021 12:45:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=fSfIG7r8/wS76RHFmp/8KL3FLU4e/faxcxSvO9e6uLc=;
 b=Fg53ALtEw/ZJgfTBkyykeuvlIAla3OcTRMxVWSawbjvvdvupEryJ28q2/VY0JQB7Zizu
 OWPdeXr1IuZNn4AbzdKQ7ui0RidEErDOM3P9qKXRY5x08oE3JTg6SMpSkQ65DDsYgXGH
 BB2kzQgx84zUClVbuO94E7BZnMoo/U0P45g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38sud900gu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 May 2021 12:45:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 12:45:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m02kIMbjiwjw7drm7rRAlRD+SayteHuNqfZ0rYb3LOofxQ7l9jGDyufYMeFlPT/ofdKTrquhFE6CRbHLaIvuIIsmFpnxSdxUOVuFu1x4O6hXrqcbznZ0yX3EzGZ8Fi6pJvDB9bXnRLUNXmfNDdUmESuhwNn7mJhOvaFWF27zxGP4ET0MV3dIvcvGBZ2oYsBdvOwwspaBFc5uUhemJWUf7gczlTUQ65md3SGwOANL5J9Q+XPpSewDQtvReuEhvoyoD4K0k3jlY61vqcKMWNdsjzdmDKJZstiBXTLJlbR8NNbezRXh8QBtfWsyP8u3ObJF6ulNk4qKPOLh8NyqLMYNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSfIG7r8/wS76RHFmp/8KL3FLU4e/faxcxSvO9e6uLc=;
 b=V085BrbtfweLwWh1qa7xadPirBZ6Rc8/DEJBdyVUbwS9GKJxJSE+M96FBXfm6zeT3hP0z/r6xXpeJh7fe49quEHLMI2ko0x+09J6xaemb2AWesHMuzbJSw2ewv3Lkqrzwjn2WqqpFdkXC9cTbYwO8ZLVGujQTOGKt/aWlnM5f4LCZ0ZLU0dT25H0+q9AQ46x84MLiAPDCC1jzDepa3c5eTOModj0oyXlnP98FpqSYvBfv5tpKLQevsYGHFTjoOnC2ciRofbC7+solIZbW4i04jrF+3OKApCGBxK/tFGteqorS93SmNYHKaEWQE3ZgonZ7MsVIGlLX7JLfWk0aePkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB2093.namprd15.prod.outlook.com
 (2603:10b6:805:3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 19:45:29 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::b802:71f2:d495:35eb%7]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 19:45:29 +0000
Date:   Thu, 27 May 2021 12:45:23 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>
CC:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YK/20x1zGbjJ6mg8@carbon.DHCP.thefacebook.com>
References: <20210526222557.3118114-1-guro@fb.com>
 <20210526222557.3118114-3-guro@fb.com>
 <20210527112403.GC24486@quack2.suse.cz>
 <YK/bi1OU7bNgPBab@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YK/bi1OU7bNgPBab@carbon.DHCP.thefacebook.com>
X-Originating-IP: [2620:10d:c090:400::5:426]
X-ClientProxiedBy: CO2PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:104:6::24) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:426) by CO2PR04CA0098.namprd04.prod.outlook.com (2603:10b6:104:6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 19:45:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5570f720-c52c-4a89-717b-08d92147fb39
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2093:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB20931CC4CC187A6DEEBDCAF7BE239@SN6PR1501MB2093.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TlluneLxQGlu2tu/cf0dvTbpzxw8Qc4BPiaxnN59wsvuqphIz+OlX6fbKIJ0XEm4C5e5Fd1Sku+k232yKy9yppX0HYCIXcy+N3Y0XM1N7InFNXszg0MqgdBCjH4A4LGT44wlFvqzYcxkVbxDstFpwEHj8dHnAOrR3eP0657HfRD+hzuWOwYoJ2Xo7L/9ZxVOi53/Mjwlh+2A9qTIZLki0zK7RVo+tkwec23UTRK5nV/++jiM8D6XAMJbpYZ+PDxEe/jrZ91W7pooc93jqCRYhLQTGWJvB3lhC1ckuBEW248aio35cjhjmGRyaUGLMXZhpHFGxBhpE6wSqjuqEj+fimz8+1h7jidulqZNGa0I3Niwbl41NszGfjxelJfNSNIY3vkmc4bqD2JysOkyckB7zt8Jb58kwiublHAJdkAiU/UrEHCcCZOUNS/XHZV7B/Vp2yxkVcCect6MnEa5CkKU9QAHEFg4FijS4+zAtc58j5EvjyVHOhU96XQr2sIm4ORxVkK40axbvj7/ZuMi01wveKL7SOFI8MOVR9ZLnCdShz8ss487VsE4CJrcWxBt70eVHdd3TSpeN4ZiMp909/JCMRwUIqZphSUTusr4qdodbpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(54906003)(186003)(9686003)(83380400001)(55016002)(316002)(6666004)(8936002)(8676002)(4326008)(2906002)(86362001)(66476007)(66556008)(6506007)(52116002)(7696005)(6916009)(38100700002)(478600001)(16526019)(66946007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TUPfWY6c2PGvsLpR4YuI/rteemvIEqELEYc7b5L9aLfnbn+VzwQwC+l742Fv?=
 =?us-ascii?Q?y2Ij6BEJ1TNyaxtfXGSbPm1VhJtpE97WXS1y6sWS7Ku79b2MnMHB/JZOpQE3?=
 =?us-ascii?Q?EKftNlBuOD3/6dRdYwgUpNUp0GYk5oBhKuz2bRl74sDlz6u3K2n1wMQ0DloP?=
 =?us-ascii?Q?hFXI3qv4w6iOwAhI31ITpZNi9noJvIL25aDXgmhYDn6cqpkC6TZ6Z4kTQkEl?=
 =?us-ascii?Q?A6q6TFhNObR99ZK/K78OLjXwtASVASj0XdX86Ab28IQc3Xl3eshz+ezvGrWE?=
 =?us-ascii?Q?IeL695LGYa9zeqf53FhFmA9/NfgUN4jD8D8y8Pxj3fi3P8s8W9xG1xQXFLW3?=
 =?us-ascii?Q?ev27uIJS5AaxDVWVlWKA7tvaxVaPPCBhfFV3EMgEdHtRH3HWU/GOKjtZZPFA?=
 =?us-ascii?Q?zAmiKW9o5fbbydNldpbXwgMDCDnIqB55+wc4gEjdkUGiiggDGN6EBz/TFDzf?=
 =?us-ascii?Q?MYQaMm/npInxNUx4zp4hQzwgwxnM7IZgjKMN8kfkWXQs/Zq61vKpgV3IJXd/?=
 =?us-ascii?Q?4zEd5j/HUIzGaQvgswT8vTSZyNNYLAZ6LtSxhSUpooD3Myf1z84lYzP9tqB5?=
 =?us-ascii?Q?aSs87/klC4jmnlIskjCgj7zk4Jdty/yAlWSrM3zFARpuSYO7QP2xOzt+RpeZ?=
 =?us-ascii?Q?VdJNMis4lHfpr3uT9xfOhTecxuS3ObxeRJHTtYCTGvm6wLL4ALSkul34johj?=
 =?us-ascii?Q?Ub3U2kbSHskDvpHjZzfnW39K91jCrwbTu/y1p5zbgiBXWqz0JUCFx5uzLalQ?=
 =?us-ascii?Q?wBrwjlJszToopFviMb4/elUR2n3zcm5w2iEQR9p47OWQkaHw1AvK4njiNu8k?=
 =?us-ascii?Q?kff+9x3DIolvG072Fw9xMIHQZYb5P8SznFwGwQZlzQxqWaPlQku/tKsxgpro?=
 =?us-ascii?Q?KDALUk8VDang9GpjWKs7Njg9NyDyQTtuosdr2ZyHTs5iQ9Dqo2SEQtFfcFFb?=
 =?us-ascii?Q?cTaoYN9Xz4elfC6KZTrxM9+KSS2CZRn5A7HZypnPMCh2hTq7c7gTk7mVb8cE?=
 =?us-ascii?Q?bABpcFmMjLR5XztdHqoNyxp5hTIivJrAKYDB8UTi6RqhQ/Z2EdxmSbmshpe8?=
 =?us-ascii?Q?KMyWRZ0GoA+g4OYAXVAo3irrMJS1WQh6j0j9eWGsQADIwUXjl0fdufTYY8e1?=
 =?us-ascii?Q?GlIAIhIdIa04FhY5+X+VWAYD2rvYDTCqDwvp6eIjdHkDALzIPSH01SNgYICN?=
 =?us-ascii?Q?M8dfshvdkloALKpls4XBHt0LlA8c3s3TrfbXAPe6faLwzc71Q48DuOQh6dUd?=
 =?us-ascii?Q?FKr1m/ewdyBtP+HmVk+rdX+KYoixlpDFC0UQC1nPUVxjs4h7X8P7lBCleyn1?=
 =?us-ascii?Q?IC5xS5Q/BzAgny3IiNOiVfe3fDNKHHx0r5nN95X3e6r/3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5570f720-c52c-4a89-717b-08d92147fb39
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 19:45:29.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQHdUtRaEKbcqvnjo3ZMSWyZm7KpxWbq81n0zpvJvMyx3l8lqkX37Ur7EQTyOHdG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2093
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Xsqkc1fnLcV4MtGSLUf9XaF3ZrSAfDfZ
X-Proofpoint-GUID: Xsqkc1fnLcV4MtGSLUf9XaF3ZrSAfDfZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_10:2021-05-27,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=777 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 27, 2021 at 10:48:59AM -0700, Roman Gushchin wrote:
> On Thu, May 27, 2021 at 01:24:03PM +0200, Jan Kara wrote:
> > On Wed 26-05-21 15:25:57, Roman Gushchin wrote:
> > > Asynchronously try to release dying cgwbs by switching clean attached
> > > inodes to the bdi's wb. It helps to get rid of per-cgroup writeback
> > > structures themselves and of pinned memory and block cgroups, which
> > > are way larger structures (mostly due to large per-cpu statistics
> > > data). It helps to prevent memory waste and different scalability
> > > problems caused by large piles of dying cgroups.
> > > 
> > > A cgwb cleanup operation can fail due to different reasons (e.g. the
> > > cgwb has in-glight/pending io, an attached inode is locked or isn't
> > > clean, etc). In this case the next scheduled cleanup will make a new
> > > attempt. An attempt is made each time a new cgwb is offlined (in other
> > > words a memcg and/or a blkcg is deleted by a user). In the future an
> > > additional attempt scheduled by a timer can be implemented.
> > > 
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > ---
> > >  fs/fs-writeback.c                | 35 ++++++++++++++++++
> > >  include/linux/backing-dev-defs.h |  1 +
> > >  include/linux/writeback.h        |  1 +
> > >  mm/backing-dev.c                 | 61 ++++++++++++++++++++++++++++++--
> > >  4 files changed, 96 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > index 631ef6366293..8fbcd50844f0 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -577,6 +577,41 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> > >  	kfree(isw);
> > >  }
> > >  
> > > +/**
> > > + * cleanup_offline_wb - detach associated clean inodes
> > > + * @wb: target wb
> > > + *
> > > + * Switch the inode->i_wb pointer of the attached inodes to the bdi's wb and
> > > + * drop the corresponding per-cgroup wb's reference. Skip inodes which are
> > > + * dirty, freeing, in the active writeback process or are in any way busy.
> > 
> > I think the comment doesn't match the function anymore.
> > 
> > > + */
> > > +void cleanup_offline_wb(struct bdi_writeback *wb)
> > > +{
> > > +	struct inode *inode, *tmp;
> > > +
> > > +	spin_lock(&wb->list_lock);
> > > +restart:
> > > +	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
> > > +		if (!spin_trylock(&inode->i_lock))
> > > +			continue;
> > > +		xa_lock_irq(&inode->i_mapping->i_pages);
> > > +		if ((inode->i_state & I_REFERENCED) != I_REFERENCED) {
> > 
> > Why the I_REFERENCED check here? That's just inode aging bit and I have
> > hard time seeing how it would relate to whether inode should switch wbs...
> 
> What I tried to say (and failed :) ) was that I_REFERENCED is the only accepted
> flag here. So there must be
> 	if ((inode->i_state | I_REFERENCED) != I_REFERENCED)

Sorry, I'm wrong. Must be:

if ((inode->i_state | I_REFERENCED) == I_REFERENCED) {
	...
}

or even simpler:

if (!(inode->i_state & ~I_REFERENCED)) {
	...
}
