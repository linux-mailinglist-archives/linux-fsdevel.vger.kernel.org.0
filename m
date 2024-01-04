Return-Path: <linux-fsdevel+bounces-7334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA5823A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 03:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FA51F262B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABC820F7;
	Thu,  4 Jan 2024 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="l04Rrv1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2B4C60;
	Thu,  4 Jan 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdEoPy35KU9ii1LMGkaSWl610Am913FqP8KxxG2v1mXClM+ePqXjNqutNxwnvONx4g4FSDHOF6+JR5K5c6BnMdac4xYWn9d0mbOtdGOZZekjBvfxDMp8I6ZCH2ydjjPR7N03OQgIVvIyKXkC+gNY8VPWKBlmAR7ge4CwYNtJlH60c8MNcWY6Qs0nzY6GB2GwU9X4vJC0qr8AOmUHkQhdeC2sKuUI9k6bTf9jMlH+izSRtAsSURqlww862ZgiGs3sEeIy/26pss+I9z/xRU8OW2WZKq9BBSVww8W5g4RmUciw1N27QFREG+ebsZSjjEbM9KHjiZWD3eJ9sOyhCSlhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzEbqbIU8OWoh/tU1WC1Qsko0l0xC1xi7Yw7JfrAh48=;
 b=N7MIW+GZ3zBG4CFv/K6LBTas13yxF5X1z63LLpmgQ4XoDf7fGGKbWFWfDS5nT7Edwg0M7d3Bl2VrFf+CvIIHjfu2ZRrddRmOwn1eMkrC8ODXEA43fozRZhLYaVZrC6c4z97X8QHMhj5Fze0B8Ri/AqsEgOaLv4flPFK+BzVGJF1yBX2/pnseRswU3WEBEj0f8TTGs6TJcwasTpevihNwJ1ToZjbMZIuth34o6qUYusCwOAM3IJYGeO8KQ2eNM9S5nnYExyfhcP+g5PdTlv29A7fEXG3/p7dd1BEJ06HP20KcY2GEaY3KYUoZasy3lvWQ5V2wyimadcKfxR7KpN1oVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzEbqbIU8OWoh/tU1WC1Qsko0l0xC1xi7Yw7JfrAh48=;
 b=l04Rrv1g9sjM3z7Kr4Ct8x4j8ItCSMce2bJMj8HI4lDNdxbHHqmjl+LMXLVPGR3mHA0c6cHVjSXZS8DXPA6+QcuMeDgD+32e3x9bj0O9qk+24EnS+2Yy5MypdB1/SZJEMYYbMwZLksgopW/igVb6tpgU7Ldh/VXnZ/JtqRmTnvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5567.namprd17.prod.outlook.com (2603:10b6:510:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 02:03:56 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 02:03:56 +0000
Date: Wed, 3 Jan 2024 21:03:51 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, akpm@linux-foundation.org,
	arnd@arndb.de, tglx@linutronix.de, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mhocko@kernel.org, tj@kernel.org,
	ying.huang@intel.com, corbet@lwn.net, rakie.kim@sk.com,
	hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
	peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
	sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com, Frank van der Linden <fvdl@google.com>
Subject: Re: [PATCH v6 08/12] mm/mempolicy: add userland mempolicy arg
 structure
Message-ID: <ZZYSB3kUOjCSo28h@memverge.com>
References: <20240103224209.2541-1-gregory.price@memverge.com>
 <20240103224209.2541-9-gregory.price@memverge.com>
 <429dd825-204a-4b11-87fd-ce9d39040d4d@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429dd825-204a-4b11-87fd-ce9d39040d4d@infradead.org>
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f13017-2811-4c3f-020e-08dc0cc9689c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OjD1lF2FYVYevafqvk+jkT2IN6+FfrHv3HpipWnDfJr3DVN7XK99baJ3KUYH+d/kK3RZPIStnGOiWfSyhk3r2zpe+/doPyH0TOO47JyXN6v+vzxBolhiPk14zrRQg5BmOpr7lJQVSm6eo/2d1fHlLE99Mrkdkieya9tBDrvFhc4ZTWn8+vrj8oQ8wMBwJGjGl05cs/9vCeCVdT2JhWAl+YCgfzsPaiWoQ6XFQckPe1C0JTSs2627vVtwJ92YdxyokivRsZwHWyLk0rdo1AmZScMwviLAt8jJSiYeor852fu4U6VIePBzkwD0c6cTIBygMX/iPdevNUnZI6rQ23u8VGU0/lQoq8EZGXv4WvUrIgHqkcigiihbLoJmwW//LHh+hXz2qafyEN/Nj2Bpqer1ar7o0QztoQiRjUz1Kes1pqrdexfdcawrON+VVkDqTazYTVtXacf3Hx+GV1CaXqy8jFM3jJJ7tnhMX/qHnbYD2TGzEsIN9AYa6qLvCGQZArNDmgHjltG8HSdZ9viHsGQm1jgV+H49i/7+2iSmY/VztfJskJ3kOmb2Xh12dGLqGQyY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(66476007)(66556008)(2616005)(6916009)(478600001)(36756003)(6486002)(26005)(4326008)(316002)(54906003)(53546011)(6666004)(6506007)(41300700001)(6512007)(8936002)(8676002)(86362001)(44832011)(5660300002)(7406005)(4744005)(2906002)(7416002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7L7cbGlDXeuK3lavyb5T435IiHrGxoFV62JLGakoLQfZne7x/jXyxD5HNc22?=
 =?us-ascii?Q?sL5tC4/3m2gISMxI//iNiaLVfNuUnonyY4BTVCPt39saes4aQ+GzMWns7JlS?=
 =?us-ascii?Q?3nXeN9F27cMcGaZirvEeicuuFx4R7NV5eZcd03IdPsOcDB9P3d5ajTdQTcYX?=
 =?us-ascii?Q?j2OEbIL7zQSL90n8UMsd7rrUEFIJKqKN4O1T1zZRRF1WTaPKiSEXcuBGDU7N?=
 =?us-ascii?Q?nKjWzjZcES/lLSPyfIAlzgXVlbLErcr2d0+LsZcYS0CEkDjGt65li2INdz/g?=
 =?us-ascii?Q?hgt2HapdCqv5k2+D6qdnpbXPnGakMgfWl6A4mIe9ryRbQlB+vc41douCMg2F?=
 =?us-ascii?Q?sSjsZ69i8A5FZEAad3EWwV3f1TSkmEWhl8hnz5JugoiwQjFUPCTy4l/WU2xf?=
 =?us-ascii?Q?V0c5+/Hb/KyWRbdK0SQ/tlSKNrKMshQogpbhk1JCp8Gjpq8jrsht50uQbKdx?=
 =?us-ascii?Q?483yC+CNRW2RYQfyzJKJd8oEl1to/9bpXAFIRklsFbO5dshoti3AkUX0zp97?=
 =?us-ascii?Q?pXo0dh1RqYIzaXYVEoUNPCEH1HDPwr65rTgBku9OX8KEfQ1AKHjGKcap+Dy5?=
 =?us-ascii?Q?v7CFXAWXt05FPIJ5/4W7i6vd7aV+d42457QOcN7eeiG8S5jCdUKRK5+307Ba?=
 =?us-ascii?Q?voPRzJQedyAcLEFPleyzQEXpSbZZQA4HjYD0gEOQNlYtBU6mTzkhqpiUmZr3?=
 =?us-ascii?Q?gFr+6gLIQVDuRIb9oPAfeQ+hK8zV0oJFo+4gEVoD4PmCFOsPuVara/YnZfSZ?=
 =?us-ascii?Q?vfnCxyj1TDb9J55uwCLnOHDZXP6S8JE3KvXmgtDDala67AAGB8hnr8qcP2If?=
 =?us-ascii?Q?0qETdC7iW7kg3Tu3XlOg8UFspeGseO6iy3MqeCSz4+/YMfN9r6Qcx5o4WWBc?=
 =?us-ascii?Q?mXpD2C9qdJXTEIf1xeusGXbS6jeXR/lPN9zsFiiiAu5GFx1iEFhADYmmCkoT?=
 =?us-ascii?Q?FFbXraOQKRCcNRRzezQ7vTSUuAN+GUaUoz16ZpHofMqx4SzU5/o3e8OHKWLT?=
 =?us-ascii?Q?as5ZfoPB/LepxMDIN5UjIMtDcPA2/3pUJTvluZKjGBzPfn5QoqGzERs+Vqou?=
 =?us-ascii?Q?JgwomeniKAXb/YwsPmpawJfa/b3LSTFfSwbcZUNIX1r6JNgxsz1nBW46mafc?=
 =?us-ascii?Q?k8cP4gm4/ZNZQHTdc6alJk7qNKgOeDSmwARhzD8wxbac3ciUMVY8ZaUr+L4M?=
 =?us-ascii?Q?irNIfsAIrGZCA0MMJtsO/3v39kxL1KIhMiWX6K6knCdBPLTR2DCwzHXgu2gZ?=
 =?us-ascii?Q?24OhfTvAL5h+kcZQ4nTAGBu61YAWKHbOQ/cdoWx+SxrBsCA4f32J54DrUokj?=
 =?us-ascii?Q?98vTG/rE0KnjUhXDfvBY+auc+qN08DBchQtQKHdcESJmqIXAYZ6bQOMclrfK?=
 =?us-ascii?Q?unpwmKAs/etws8xNa4JP4D3t8vxVOsbLGX2xuv3gdJHRGPi9KPrQKmUKNWFv?=
 =?us-ascii?Q?/qSSATTPgOAbmF+fSJHgFLEqdaepn60WeiYe0e4EvDz1eeqeIz/Ck41amONN?=
 =?us-ascii?Q?wWfDGsD8f1DxG2ou7JGYrRcHg9qIUAD1qI/yOXLK6jcmsRY5YQVaBEnQbcZs?=
 =?us-ascii?Q?UVuwtsoCtlaWoqA1L+K5HPp5Bc9BI2NF1OV1rrbrYdkAS598O+YDVEhBe3MI?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f13017-2811-4c3f-020e-08dc0cc9689c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 02:03:56.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT9CJwTORPuEdRDd0y/B75TmYwy/kEHpAlH1FpwoOVjspEJDMMm6Juf8Lr5hW/Rq9fXQgcCLXqMEGm01ZFDIdoI64zGENJwViLp5SfrdgnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5567

On Wed, Jan 03, 2024 at 04:19:03PM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 1/3/24 14:42, Gregory Price wrote:
> > This patch adds the new user-api argument structure intended for
> > set_mempolicy2 and mbind2.
> > 
> > struct mpol_param {
> >   __u16 mode;
> >   __u16 mode_flags;
> >   __s32 home_node;          /* mbind2: policy home node */
> >   __u16 pol_maxnodes;
> >   __u8 resv[6];
> >   __aligned_u64 *pol_nodes;
> > };
> > 
> >  
> > +Extended Mempolicy Arguments::
> > +
> > +	struct mpol_param {
> > +		__u16 mode;
> > +		__u16 mode_flags;
> > +		__s32 home_node;	 /* mbind2: set home node */
> > +		__u64 pol_maxnodes;
> > +		__aligned_u64 pol_nodes; /* nodemask pointer */
> > +	};
> >
> 
> Can you make the above documentation struct agree with the
> struct in the header below, please?
> (just a difference in the size of pol_maxnodes and the
> 'resv' bytes)
> 
> 

*facepalm* made a note to double check this, and then still didn't.

Thank you for reviewing.  Will fix in the next pass of feedback.

~Gregory

