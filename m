Return-Path: <linux-fsdevel+bounces-38698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C01A06D2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 05:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A2418885E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 04:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3092A213E9C;
	Thu,  9 Jan 2025 04:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UOWHQ43O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E012F2F;
	Thu,  9 Jan 2025 04:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736397522; cv=fail; b=fdrFMwFAjWTrHV6qsB2+zTxfCVJ57DRxh8oh718sb849wiVqfugMVRrPE1uXqNGhiXDk1EbMlFZ59hkiZnWUOiyyy0JURWynfBfI931DhQHFtEpPGZGafqDRRAFesM2Zbj7J2gEEWBW+L+BPE7PM7pZQ4voAV99/qMcSVLP06bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736397522; c=relaxed/simple;
	bh=ofQZ38QYWfEnreds0ElvUVsbTcI6pLaaY9iqpjSo3e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DtTm0BgYYhntr58AA38nN/QNV5Ff0THq1j2totCUPGfJWFvr8C83mLjlfELq7SDTThdLYHXBLgZ63tmTkWSWV1eJBYoe8QuSQUz7ctafzmrnhn1zTwo6+OnGXNDCEIqiGDF3QR8sJve7k/1gxXh6f26qnB3zL9RozqMIlpRIG+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UOWHQ43O; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0v93JqFwzlsqoDt6Yfz3a9NqGemIXRvoeA4j66ag8D9jbOauIS0/DQOASIiNamqlOe3Y5vgo3/llcyNestr3crlGaZRRx6irC/4uCECs2WHDr+4MyoFhxkgwCMDlrMeBCdUivcO40RtmAsjbXo6Bpt9neHkVtP3nqDYy4G2bsKg88QkrYG0gwnWcJR6ANStf3r4UEKexcL5QuHedgqetIFKdpnBAe+Zy67wHzckSCMfp6pVV/YeO1YdomKYP4xT0kO9fOlBspODBPHmDVI1nqlufxHPRJM3ecRqDDRV87SruQKjgTsnbPQxOrKaHgznzaVanwkUTz0OIyxqWWK4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ2YvM8gfp17nTPL4mYb4m25g/l7LdazDxHe8bA4t2o=;
 b=pSGa87vjMSvMqX5KWPT2t2ijhcX+e5e91+BOwf1+u77vwQRXmpq2S9Jn6+wRBeLfrEsIaXVB/N7KbM5LQraVWpw3pGn7WGW+78gj74Qn7eBeH58+aJH1O47OkA4wPpT6B73frajvjkZudPAd0cDaXNHm8sOHK6sAlh6VKqbstx0MhXqdVgEs1lDuKkqvbUElji9NLXKvFYjbEgsWUG5ee36C8TjZWfFC7VOGOYU8LABY2Ta2e2JxU7SPlyMLa+CsNIqYulLH2G4rm3twoPiZtqbC/eIhicX4TKGymZSsgx5UizQIT2qNB5rqo9VVDH/PY0jbTQJ2lBvDNJcdNApmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ2YvM8gfp17nTPL4mYb4m25g/l7LdazDxHe8bA4t2o=;
 b=UOWHQ43O3ewnYL2KH/k954OGR7FdrQNsFjThs0l7pDrRany7S5Bn5yXyW7OQQJAo+dTxOZ5lAu57b4dsVNvunEhncTmjYLCDDX4mYDZukw7+gGOr7dnWJW43HiQkPfbHH4p+casEf65BA083wyT1pryaImG8tnAKbTR6h/kjmUwfCMBDS33VkukvTdvEEqxtaiGjCD4BI3kSSUtjln3frI076pRZ37aTnUIqChFmw7r1+PGcchUHb34fwSrmSQAw6Zz1INyy67WDQEk9sbpfkvaKbhmk8kP8guXQlx8xAUJOK1yyt/kKUYVCR+JL86mdBt7jkBXT9CLrwRGcsOgQIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 04:38:38 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 04:38:37 +0000
Date: Thu, 9 Jan 2025 15:38:33 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 01/25] fuse: Fix dax truncate/punch_hole fault path
Message-ID: <27pzaod6lj2mwn3refns5c4titbsrqhxcxjeuae6piom6rzqgy@mxb4m4jyej5s>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
 <f20cc2603bd33ee05ec4bc4cc7327cec61119796.1736221254.git-series.apopple@nvidia.com>
 <677efc80b6fcd_f58f2943@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <677efc80b6fcd_f58f2943@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SYBPR01CA0171.ausprd01.prod.outlook.com
 (2603:10c6:10:52::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 078f67dc-c95f-4aad-f68b-08dd30677bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPdOuIEL77bcCVTjV1oYCwT/IUc+4XXL4bjz5G0s3jYRk5axr3psq914xnxp?=
 =?us-ascii?Q?Em+4S+gg2PvFxKazi/4FLtXBp5CkzGZDERZjR2NOObeYPTU0bGyWZVXJf0Dp?=
 =?us-ascii?Q?RK5Y1jwe63+KQZEc4heKsREahvPv8DHgsj7WXIDgW7ZfYmeKNxc8T7sgDfj9?=
 =?us-ascii?Q?s1E6PDPitsMN2sfbYU9LDh0XjuD/T/f+k3q9PpjGbjX+uAoXZBs1Mk5UwOyZ?=
 =?us-ascii?Q?LofCTfMq8AB0LAaQJYYe7pd8I9ctAlGTtTBB8sPVwOh4gAj5Es5TMSpOaN5r?=
 =?us-ascii?Q?u1t80Je+WMeTr9qPKO3dgwIkURG71E/CF1GeJsEqr1rt12qhelq5MPUUWN/k?=
 =?us-ascii?Q?TduzQUDM+geVOiSyY4l4GeWfyuPNWDBMn+pG4jFCQR/kWslP21bhBmWZ1I/i?=
 =?us-ascii?Q?inkdgpOV9kJsF62VQ2wIqRr6aMOgAWzo3NLLEmwZPFMG59ejVRWb88hAPAQE?=
 =?us-ascii?Q?FYv4SzkEXHVc9Jd5sglFCEyY7kLY2sYZ6xCyr22fn0YynRy3W8LfmA6HluYm?=
 =?us-ascii?Q?JC6DrCJWMcLvm3td6QizhEiE53aAYF/276X3ygjQmPLHavlrn16C/wEVfYZy?=
 =?us-ascii?Q?J8eruaK3bJu1hkGmyCh4FnHNVQfIVemjfc7kHneLFr1msXbu3f6ewxY16Hps?=
 =?us-ascii?Q?eyWPj0ZZQcSVY04AAPcbLNWyW7hYzi9DTQtwmdmkUCehQugQlv1R+TsrrUQU?=
 =?us-ascii?Q?lGE/u9ookqflEi+NKM6wnCpQ5AzAUoVDQglo285iJi/QHqzQ6gG2L0Qifyfl?=
 =?us-ascii?Q?egU3IEOMnDK2U4M2ArTIzdYxIkcDZuFDbiw1U0IGUmHz8o78EHL7VjhQ+u/H?=
 =?us-ascii?Q?sSP7iUdJsaE4Fzkvj3HCyTm2MFjEFLxi256bUSQt2k5YIb0UgGFCdHs/P6YU?=
 =?us-ascii?Q?fj82W0oTjrCGehAu8YQhn7JVF4RhjcrgLfYSVPAT/Y3gPDQBCqlb/8b+4F/P?=
 =?us-ascii?Q?sDWDaifksFfdmYOwzaDAY7wJvTHSVOtraSWbnyWdWGT/WutK5Mbo6H/EZyX5?=
 =?us-ascii?Q?57uq1g2mBaRL2vZg9rT9qZEx6jwZ515/UDG3wbL3WofIZa+U36I1KcD7yNrX?=
 =?us-ascii?Q?FDHqf0yRh8DUaEW1zwEKYFj1rjeAq21+aZsK6KOCv113xBXAGeY9etbgflVr?=
 =?us-ascii?Q?nZmWWtX9qPw/H5v8p+hALEJwHOaSghDLKgengKoQQ7azSwoKFU6hP2t354S0?=
 =?us-ascii?Q?RbJJMDMmC+rsgjG83q4zje1UfgqGQ9hzW3Ps2fjtZqfCoEnjJ0zMgX/+nn9N?=
 =?us-ascii?Q?uDMeGCmUFotPfCN9uHcluvEQ9FNQOzbvxS62+uN3ZYPtZ/R4Jg+SjUJmawgz?=
 =?us-ascii?Q?aX0Mn9Jji93PsaESoCEOdS/6voQvcXtUFijh8X6feuMyJYLWo/0qE32jdiYj?=
 =?us-ascii?Q?PmJcENfXrOAwWD90oP1q7RxF1HzI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WiH+tvJX95+OzE0jD4o1HC3s7TKbLF8k89OQl0bW1CvFR3Gdj9pIBYVv0/ly?=
 =?us-ascii?Q?9pUWooj9lU6O1iZBXPrM5qCE/5GqCADpr5+cIORD+Nzuk/KCZ+1YaWYLCCh8?=
 =?us-ascii?Q?OJrpirt3q+ZpqwYH4Pn3ee/5SbJ89/PeqaDZCqtCgajctfA6eC2YDD/B5KM5?=
 =?us-ascii?Q?GJ7psilMbWoI0KjTksDWDX9NCG39zcdPGdt5kHPB2lP7SHKLdRVFUKKHcIdA?=
 =?us-ascii?Q?F65uXiYk7h9oMQNw/MkgJie+kXfWbF/pVmIIYoiUAmiNsT8297pdXl0tANAP?=
 =?us-ascii?Q?ZqwT5Vkh7hv7On7gFtjkglyhGNgtNM43dTvMvPeF7IOkZGK9lgkbK8KyleYg?=
 =?us-ascii?Q?eb8XCKBRdRrrRntmO58IMaUrNqdA5oqiroP4rA/HlYafi8uDhmjorjwmmDxv?=
 =?us-ascii?Q?UtD8+xkra7go4+pgCGMCHkzx+wIoSJEqyMdqUtBMnVf5dCvIL0O3g7KhOzpa?=
 =?us-ascii?Q?ymcMjZvyCr6zVmZa6p71SRDG5/WMMkL8hS2dBseiB68JMGpRJQd2sPVixpbr?=
 =?us-ascii?Q?9OfeiQxAByWi8Vk02xv97wLHHYjmgoyd2N25ZE/Picb26uOwrzKaSKb4AlVn?=
 =?us-ascii?Q?IgnCThNlxI1PTc1bjAYp/kuq5Nqzfz6kV3tAZwUr4p8kmjudBChbk4/uDHoh?=
 =?us-ascii?Q?DN5jIr3OnGDO2X2EYWvRUSkd71kLo2RKEyic6/tbd8XV2NNkVIlrFubk5urq?=
 =?us-ascii?Q?VvrhElf2YfesOd7jqLeGTCVc7dqvncupvCc7058Uk7JWWlBPLUM/NKHxDkXv?=
 =?us-ascii?Q?PUSPr1JCIcaPfLO7spPliw3AuOR3B8KIkgcssW/UC5vjkllbCSCfNo7IxEil?=
 =?us-ascii?Q?UL0yeryQWQela2e2U6/pasaB+JivxbJPaTUaGrmEhqNWxKK2W9azeCxSLO+C?=
 =?us-ascii?Q?b5BkcVAei8zHEHtmH30Fs9SrCiktITRlZytrKogfniaFcVcPcsrvRqaO1N4I?=
 =?us-ascii?Q?cFBCM+ISAEDNK2DALyXRefrwuCx+BXz67tqH1fjRITdQQlPvJtyJLCZ+Coyr?=
 =?us-ascii?Q?SFWXVEMSTTEwweh3mBfUQ6ue6BMg0ilTAEMfgUIQpeIqmBI1bMx07LxbWskA?=
 =?us-ascii?Q?WlCPI7KeAeh6MngmD9L11/+VAyYvBOpfCkCyf92z8evyFE08CAYPXIgLg2tY?=
 =?us-ascii?Q?Q+ZM8s9fsnLCBq+l/5Zu/TRt0i0y7IydcsUKzoCIvRjxM7U3SMMKeogbnElV?=
 =?us-ascii?Q?DUiAW6N0ieGdtB10XA7k0NlYex+0is57FI1dUfxxWsH7+Jz26eaSf3jOcOe2?=
 =?us-ascii?Q?OOcJj+r769fjrK40MqN32afkK2P21OUQLyccrJN5QZ1CeFfJt7dS2Ax/XXiK?=
 =?us-ascii?Q?Zj5Fq0zjG86NpUbnpY3akL2tW8j7faqdOIgvj4D74MskX1PPMLeJIi19yzIX?=
 =?us-ascii?Q?8i50W1SLEdlRY8OjhyZtemS2rH+XJVbGmHHqYdxbISfh6DhF93GmfZKYC/I0?=
 =?us-ascii?Q?+3YREvM0k2yNV0vKxGhkgqAmqBIr9Ak64euO7LgpTESRhUrDDItqTebPPRqr?=
 =?us-ascii?Q?9sscqkFtZhvA9hlPytu6SwOinllhcH3BiAcdCpss3M9tAb/tRfXhdUdWGLng?=
 =?us-ascii?Q?xXEIu/SQT/is+WHGPC/OIwdWFqfUbLqXQUju9U8h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078f67dc-c95f-4aad-f68b-08dd30677bcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 04:38:37.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CekoDtQa013J7kBJMMRxZYAa0mm5E6R4yRWbXahedE0mShpvfk4snuBAa52/8bwOArbafJNEC6dCEvYcgv8Bqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840

On Wed, Jan 08, 2025 at 02:30:24PM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > FS DAX requires file systems to call into the DAX layout prior to
> > unlinking inodes to ensure there is no ongoing DMA or other remote
> > access to the direct mapped page. The fuse file system implements
> > fuse_dax_break_layouts() to do this which includes a comment
> > indicating that passing dmap_end == 0 leads to unmapping of the whole
> > file.
> > 
> > However this is not true - passing dmap_end == 0 will not unmap
> > anything before dmap_start, and further more
> > dax_layout_busy_page_range() will not scan any of the range to see if
> > there maybe ongoing DMA access to the range.
> 
> It would be useful to clarify that this is bug was found by inspection
> and that there are no known end user reports of trouble but that the
> failure more would look like random fs corruption. The window is hard to
> hit because a block needs to be truncated, reallocated to
> a file, and written to before stale DMA could corrupt it. So that may
> contribute to the fact that fuse-dax users have not reported an issue
> since v5.10.
> 
> > Fix this by checking for dmap_end == 0 in fuse_dax_break_layouts() and
> > pass the entire file range to dax_layout_busy_page_range().
> 
> That's not what this patch does, maybe a rebase error that pushed the
> @dmap_end fixup after the call to dax_layout_busy_page_range?

Ha. Yep. I spotted this when doing the conversion to
dax_layout_busy_page_range() and then had to rebase it into a stand alone patch
for easy review. Obviously I put the check in the wrong spot, although it ends
up in the right spot at the end of the series.

> However, I don't think this is quite the right fix, more below...

Yeah, I like your version better so will respin with that.

> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > 
> > ---
> > 
> > I am not at all familiar with the fuse file system driver so I have no
> > idea if the comment is relevant or not and whether the documented
> > behaviour for dmap_end == 0 is ever relied upon. However this seemed
> > like the safest fix unless someone more familiar with fuse can confirm
> > that dmap_end == 0 is never used.
> 
> It is used in several places and has been wrong since day one. I believe
> the original commit simply misunderstood that
> dax_layout_busy_page_range() semantics are analogous to
> invalidate_inode_pages2_range() semantics in terms of what @start and
> @end mean.
> 
> You can add:
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...if you end up doing a resend, or I will add it on applying to
> nvdimm.git if the rebase does not end up being too prickly.

Looks like I accidentally dropped a PPC fix so will do a respin for that. And
the kernel build bot was complaining about incorrect documentation so will fix
that while I'm at it.

> -- 8< --
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index c5d1feaa239c..455c4a16080b 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -681,7 +681,6 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
>  			0, 0, fuse_wait_dax_page(inode));
>  }
>  
> -/* dmap_end == 0 leads to unmapping of whole file */
>  int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
>  				  u64 dmap_end)
>  {
> @@ -693,10 +692,6 @@ int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
>  		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
>  					       dmap_end);
>  	} while (ret == 0 && retry);
> -	if (!dmap_end) {
> -		dmap_start = 0;
> -		dmap_end = LLONG_MAX;
> -	}
>  
>  	return ret;
>  }
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 0b2f8567ca30..bc6c8936c529 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1936,7 +1936,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (FUSE_IS_DAX(inode) && is_truncate) {
>  		filemap_invalidate_lock(mapping);
>  		fault_blocked = true;
> -		err = fuse_dax_break_layouts(inode, 0, 0);
> +		err = fuse_dax_break_layouts(inode, 0, -1);
>  		if (err) {
>  			filemap_invalidate_unlock(mapping);
>  			return err;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 082ee374f694..cef7a8f75821 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -253,7 +253,7 @@ static int fuse_open(struct inode *inode, struct file *file)
>  
>  	if (dax_truncate) {
>  		filemap_invalidate_lock(inode->i_mapping);
> -		err = fuse_dax_break_layouts(inode, 0, 0);
> +		err = fuse_dax_break_layouts(inode, 0, -1);
>  		if (err)
>  			goto out_inode_unlock;
>  	}
> @@ -2890,7 +2890,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
>  	inode_lock(inode);
>  	if (block_faults) {
>  		filemap_invalidate_lock(inode->i_mapping);
> -		err = fuse_dax_break_layouts(inode, 0, 0);
> +		err = fuse_dax_break_layouts(inode, 0, -1);
>  		if (err)
>  			goto out;
>  	}

