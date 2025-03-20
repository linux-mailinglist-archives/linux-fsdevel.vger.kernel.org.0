Return-Path: <linux-fsdevel+bounces-44567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4639A6A60E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A9E1709A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F899221DA3;
	Thu, 20 Mar 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hnag9lb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25378221735;
	Thu, 20 Mar 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472907; cv=fail; b=RasMPMB7bZLFEDRevvOVxIL8LbbXy89O2/PHTZg2M+nwX24598gnRFp7gzpybB6X+WjYDkIA6lw2EwVCwj9MVZQmElhY+O1x6f1UTyYQUT7KTWwoGxH8AVYG6IezoDUj1qG66HlNrFskoX4vVk5gk/BTWIdHtZSXLgiIS0K6hNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472907; c=relaxed/simple;
	bh=YX7AYyI8ksst6afWAMpMFVP7Fxx/rgRBgauuZY4FG0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=abqsEbENmjIU8WojdacKQTZ+9MX5072Y5Wi+pAhnnwqDbiG3T/Lda3PnwlBmmuK5DibwqfmdfcC1pUtkCwuz1vcESh83LEFV5l3q8WW0T542a25QKKROSvdTMqUvwSEVgus45rKnxEQbOIRfcTHCLyJcIqfyp/KR4hARgC+Xjhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hnag9lb9; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlQVcpCaMJR1GR8qwLiGYYU7Y57dIise3UyxjMH0DlPa9KxVCBPj9v6okHpHNgctSGsbJKqXNSFJUXh3QlbStE/+EyRwxSHcrb8mNAkoGSutHp2RgyihbnFmbHEmIix/l7d7Qk4NpBwazfxP+99s45i29HsajaNn5uuN0hL/xcSkCKZi1mBaIUgUKPNnevoDclVguqpLr1nNIGY6rxtwlFrUWBD9GQiPAxcoDXYJEQ3a27sRfFe9erNfzJCvnebx4zyoxaUMnaAA2Sial1I73MjK2TQqZBvnyWECw2VOI7u5Efma7m0unLnswnPfvSGiLAtTElOAVc/JfQNqdzSuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAWOBSIxJKpzyBexAdLZEIMQMLXbijVGHPO7lpmGTBU=;
 b=LUog0iLTw8mZujvxKRnFaXdKu9LC5XGbHb3dpjxu+B9UdQ764YK5JT7PSTpR9K+wHreNO9IE2RTQ78fvSw3347uB8yEhuZ40O2tdc0vEZ49KeY5p862/MQSYMUhkKjR/LhsYRdp2s/Rhgd1OASLUiFCraUn8NPaTXE8hTt101OWe+BFZ37QE2q68LTkeXEub90u1l0m9My2kJ3VN9HUAv66Vecd6hlXbVQ9pGKUIowin+y/j17cXeVs+ypZiZH3ETRBECcrtcOTGJQOZfzYmmXBPuh0//EagaQ28bOQox4RAmEdjIvKEpMZ9PW4IAnN7aaj2C8W4FoAnEY8cy9B0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAWOBSIxJKpzyBexAdLZEIMQMLXbijVGHPO7lpmGTBU=;
 b=Hnag9lb9fmnDp4m2MHKkT/mTzOx9Kb57Coy8OHSm/InKwBOne2svV4jVFzlK4iqce3PBln5krVw8AXlTRq0ugfUWPvixz3ss2RsyyUNwwqOXOLqKFURdk6HicTkw3IMGipJ0GIMgoaxUeG59RttjgcIs3yp55hMCy8lym3bMdzGCe/Y5CysS6RBB2MfXjGUApnla2H/aoBDUHzmqb0SkcJBfr/NL5f496ns1/xRN0AXv3rIvrmmfAXxCnaRywZNUZ0x7LJZq6l6yn1wR/zYNFgUJWdV7EhrsYFESKEKlYZUR/zr0VRPaDkkdCVADPLGYoz63+s3ZUBt45NxlqfE+IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 12:15:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:15:00 +0000
Date: Thu, 20 Mar 2025 09:14:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw2@infradead.org>,
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <tatashin@google.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <20250320121459.GS9311@nvidia.com>
References: <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <mafs0ikokidqz.fsf@amazon.de>
 <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
 <20250317165905.GN9311@nvidia.com>
 <20250318-toppen-elfmal-968565e93e69@brauner>
 <20250318145707.GX9311@nvidia.com>
 <mafs0a59i3ptk.fsf@amazon.de>
 <20250318232727.GF9311@nvidia.com>
 <mafs05xk53zz0.fsf@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs05xk53zz0.fsf@amazon.de>
X-ClientProxiedBy: BN9PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:408:fc::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d0471b-0cc2-46bb-2666-08dd67a8d631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iBddJ1lP3AXFmW/RIHdkDxKBGDxDiIgokhdwYroxr2G+Nhp+WxvavapZTWx4?=
 =?us-ascii?Q?crHXUCM+VQKyYp4LJWNqgeDaRpRCP1tYqqpSG1iTNpAT2FwA1QMwFRFyO/ie?=
 =?us-ascii?Q?AKrsIPssusXshhHynIOkHnQerIwJDVVCZMkKvPurMSacuK37CHK2kkHPVvrE?=
 =?us-ascii?Q?qjUbXYCX9AwyV0907P8dUTa48OSfou40/B+2YQ9s+kNXxcgIHiEquM/rEOap?=
 =?us-ascii?Q?FCisW6DD+B5AdG0jBTqF4KJcD1pez5/9K1q5i7gZTkPP+jPN5UGYJDEZYbQq?=
 =?us-ascii?Q?x7AMRPeCnV0QaZsnoLu7FXAFwluaMtCvfJv/4xQf0vKGb0iRBnIXZEaJGXrJ?=
 =?us-ascii?Q?EgLN4BRJgL68SgnB/ucngr6SLsImbWPzmQRGhCoiwUcIFcSfyYTnfaXzGv0h?=
 =?us-ascii?Q?C1Pu7op3Rx8oGpsJ/ykBgt/mUPo8nT0uWAdZilMyPN5fCSrlbad49QP/QbOS?=
 =?us-ascii?Q?VW4x6xUraGUnAU12LOzpV7xUqO8YeScgjzTAJC4Zwfxg3Muo7/EZzYBcPWRH?=
 =?us-ascii?Q?blUCB7sdNczOVH++Bw3jt8v3Myb2WMFCUB7KPOuKSELDJNK/KihU8mI/dFj0?=
 =?us-ascii?Q?2w+1leq9SuqcFWrlURwkZCOZMIjXp3UMWza00nMf/ldHunZ+ki2yKBsYqCGB?=
 =?us-ascii?Q?szvsZfaqbqm0zffnn91NvjScaKDETZo68192SHjF+afXcJrj0fU8O9bjch4U?=
 =?us-ascii?Q?/lu1W18C6mC0MMgoJjfDtnUAsW2oBMfTMFKT8XQd/nadQ1WbFuVxi2ig6DUZ?=
 =?us-ascii?Q?KVvWGa72G1amPTlrbmqdBBH7RbYZLaUosxnyRXwd4NsxmyAG+V85FN5V4OgD?=
 =?us-ascii?Q?u0okx1pw/MI9ZRC5DQy3Zj+BnpQtirbP+ADnejS43X7wGj+cOLDaE4FZtysq?=
 =?us-ascii?Q?LwIA/g07dPTMwHmyrKYcDmXpNUMV1tk+I5MzviFL/sxNrMO8jFB+ABH+sHEC?=
 =?us-ascii?Q?/tMRaWT5uJ8Jgi13hM6oWafXHi1EGKg9hLzAodLxui6EEMfGz7Ydfl6hkQBz?=
 =?us-ascii?Q?6U1ICM2kV17H8KHHfLX7rrSFGncurWS0rx0uda2tK7qZ4phtDihPRz0seWVw?=
 =?us-ascii?Q?7TmWFsbcZvIocVg6TFiWvJQEaENNhptgW4v6Nh6MfeVouKZgXTyoSF8epH6t?=
 =?us-ascii?Q?Y+FEzbdj5G6olMMhOUReFWZwIA99mHjL9zHqQ+g0IP3Zwy2zt2bXkEt0nqhp?=
 =?us-ascii?Q?yiGnMoszERVvHbr7XD4tgj1Xqdb9kTjSs7S6JywIrpX6yISs+oAwk8MFsWzc?=
 =?us-ascii?Q?j3yVxVS713doD1yGNVrVqNUU3NiDC6pCyF5FKpCvGoOEnB7lUftVsavFthgp?=
 =?us-ascii?Q?A6bWvwuVDzzlfhQy37EmenZR4oydZ6vFd6ypdr2Q0wNm9uV70Pm64h7GO9Ka?=
 =?us-ascii?Q?T+h64ldMKVTRsj8FwiFWq4wS5gtF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aFocaXte8zvhf7Noglsuq5m7v5lMK5iwsGZ775uLUDwBaEOqWoh9jBOWYqG6?=
 =?us-ascii?Q?2Q/FMs4JGjWJR1FxlCSaeIQSuQN1LxNUZgWMQMejY304k3dUTLoil1pbNU6c?=
 =?us-ascii?Q?o10ozxnGbAXXiVvcmBudNqKzUYX6a019XQ8RFDmshmDswWIvtGDqv0U1xHxa?=
 =?us-ascii?Q?4Kv+FjisNN94HL4YOXDEjxeOHcmCaa7u8tgkfP8Vdv8yH8Joi69y65qYUBRF?=
 =?us-ascii?Q?o7njFwpnJ6emGO+iAb2ty5FHJl9SQXlAioMSGyTwFrsmlWOv6q+58YsfjHnn?=
 =?us-ascii?Q?eMEfMsU6SEaSnUk6ZCTqWo3YhnYLcNY2pGw8/N3Lox0M07JMoI0Xw6bJiv96?=
 =?us-ascii?Q?w6XUepjXSF1PpW6pZmRBx6pj0jZSAntMF/KjAZX+l3PAj4oiTmyHDdtUFd17?=
 =?us-ascii?Q?3QQXODvqUsbEKNcDadmAh7f79Hb+reDRl5t2mfsDtggx38cRp9y6NiFsOciy?=
 =?us-ascii?Q?Zm6UTrfGvAtnKrjI9C7wvvPmfXBWPZRWTBsrMZ6bTBvUW/CUj7tZFFjCvVkn?=
 =?us-ascii?Q?9C14LEwaJcXINxUBOGcX4ofshb0hi3DZ7xMY4/E4QOMq+i6b0X8gmv2frOcQ?=
 =?us-ascii?Q?RTbLyn/QYpXP3UsDGE9oqRHqvhgymDZmQamPFawq5i/dsv4R/5MRoTkit+9H?=
 =?us-ascii?Q?KnJNzSU4dMZ0bRSAXHAg4YbY2FYAnVT7rUuqtHj+lhjno5g7+KSjpZ33apqC?=
 =?us-ascii?Q?hgTUPcfMavRT2oPInOmZY9kamhb09RG3x99J3NPlfCh3jCsT6+IxqMZHz1un?=
 =?us-ascii?Q?7qb8vpdcYLwx4BC+R+RYFrSkCemvhu/s7kOUa4Vs7/RupyTJus5+YH6lN4XP?=
 =?us-ascii?Q?21cgmnvzSbUnWM3e7nydz5cqUye+DmQewW0MMBnliGsyTJjbZ8RaaImWhJyb?=
 =?us-ascii?Q?NdGkmkQctbpZN51hEbRTyDsxsXeOnRT4RauLgGebu1Y7d7/Gc9McMaaERSDv?=
 =?us-ascii?Q?UVqX0DEuR3CxOM1sD2DUZupT/vfVVEO5V2ZwoSO3ahmN+/Ah9d5al3wua4ky?=
 =?us-ascii?Q?f8/VSv3YNlzbTMYAqjtEk/bUkDVgXjJvXGTQ7nz0SRx67WhnH5JYn6iu7IPK?=
 =?us-ascii?Q?xzD464gVk0UE6C/McIc5eWUFpl24ux810j7AGIEKvw5C1hWDbtCBNKJmfH+E?=
 =?us-ascii?Q?N3x1F5OCsndBDpE8RyMbtNkm8gDWfIOwAA12SOv0o9PmDNEJFDrYLVvOl7cc?=
 =?us-ascii?Q?Bpo5onobGyxSPlS0fwimG895vRfKcdCXNsPCKz6vkLcP06X9GhG33dVp6V80?=
 =?us-ascii?Q?GnOVir8VBrFfOcIOsNGb7K+nzTFHrB1JOmaWQQgl8158I9nzIzTjB4s2XmBs?=
 =?us-ascii?Q?hT8wfqlnKUk6RZ0i+vrx74WB2raEZs4A6HwyR3fvLEYBIlFaLBiwisJCWw1m?=
 =?us-ascii?Q?QqzYrGylbhQAtrGIMaZQnvr79l1Fc3bt0EdSGgYshq7T7i3+ahq6K3uTpaoD?=
 =?us-ascii?Q?kFIBn1PrNJuctLyCtvz2THbWNwqii6IRtR7ff6yXmB0neoHH+i3Xl94qZ+ul?=
 =?us-ascii?Q?nTznEw7lPoa0MGNJ8JVG2n+qKZuPwEXpepsbCYbInjTIRY5DIGkp/kO56bqm?=
 =?us-ascii?Q?R+y0QgFtUy+Yq8opH7k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d0471b-0cc2-46bb-2666-08dd67a8d631
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:15:00.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDTmY/rRaW6uMSIKHWlLtevuncvStYX6b+VTv9XFUj+hap4+J3O7WFtUI/zuerAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926

On Wed, Mar 19, 2025 at 01:35:31PM +0000, Pratyush Yadav wrote:
> On Tue, Mar 18 2025, Jason Gunthorpe wrote:
> 
> > On Tue, Mar 18, 2025 at 11:02:31PM +0000, Pratyush Yadav wrote:
> >
> >> I suppose we can serialize all FDs when the box is sealed and get rid of
> >> the struct file. If kexec fails, userspace can unseal the box, and FDs
> >> will be deserialized into a new struct file. This way, the behaviour
> >> from userspace perspective also stays the same regardless of whether
> >> kexec went through or not. This also helps tie FDBox closer to KHO.
> >
> > I don't think we can do a proper de-serialization without going
> > through kexec. The new stuff Mike is posting for preserving memory
> > will not work like that.
> 
> Why not? If the next kernel can restore the file from the serialized
> content, so can the current kernel. What stops this from working with
> the new memory preservation scheme (which I assume is the idea you
> proposed in [0])? 

It is because the current kernel does not destroy the struct page
before the kexec and the new kernel assumes a zero'd fresh struct page
at restore.

So it would be very easy to corrupt the struct page information if you
attempt to deserialize without going through the kexec step.

There would be a big risk of getting things like refcounts out of
sync.

Then you have the issue that I don't actually imagine shutting down
something like iommufd, I was intending to leave it frozen in place
with all its allocations and so on. If you try to de-serialize you
can't de-serialize into the thing that is frozen, you'd create a new
one from empty. Now you have two things pointing at the same stuff,
what a mess.

> The seal operation does bulk serialize/deserialize for _one_ box. You
> can have multiple boxes and distribute your FDs in the boxes based on
> the serialize or deserialize order you want. Userspace decides when to
> seal or unseal a particular box, which gives it full control over the
> order in which things happen.

Why have more than one box? What is the point? I've been thinking we
should just have a KHO control char dev FD for serializing and you can
do all the operations people have been talking about in sysfs, as well
as record FDs for serializing.

Why do we need more than one fdbox container fd?

> All of this is made easier if each component has its own FDT (or any
> other data structure) and doesn't have to share the same FDT. This is
> the direction we are going in anyway with the next KHO versions.

Yes, I agree with that for sure.

Jason

