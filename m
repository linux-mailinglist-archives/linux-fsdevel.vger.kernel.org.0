Return-Path: <linux-fsdevel+bounces-40906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA8A2872E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20692168ECC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B522ACDF;
	Wed,  5 Feb 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FnmZmu8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77951D7985;
	Wed,  5 Feb 2025 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749434; cv=fail; b=M8/FYWOxE+KMqfDCRr0EgEmE1YpAUp+iUq1uE+5j/xgoZK02nMTpX+mvqMJvL4tGkSHZ03daP0ejvfZnYEiDfCcSW2KrrJV9dIHDG8k3g3fnSe6SITuVBGOHkpyttLa4JaRBQt0Dd/P1SzSTaQDg++wPN9L72E+LDicLYvDJKSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749434; c=relaxed/simple;
	bh=QNSh5L2fEDmdAo/O/sKrS6NZ/Gxtqn53w899DKXTCaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mCMbREf4wWdpwCM/MLD54uTODGKWUoWvUD8Yu3SuT4JHudm95MqzbnPtojYnkvJHb84wyLDIXss5vbyVudzpXfkEPAuc2PncmEWt4VFHaQovf3W01OUK+kWUwJLGJ96ARqdRnWY4zL1TBjNwOx/rI4X4nS4sZ85XByRrAKpxHhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FnmZmu8B; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rafh5Jo1UfYL5caUZF6Ta+eq3yY299lClMZQIEgLD7b+7iv/3fIOQ8C/uePP/fvIOZmOAZ/IMGjrUE2GCqohCZOBTGkoZkRBl/SFoFXsA3G8VmfvmS7wsyTTcQfHQg92zRuqHiDu9PWSj//quCtOmUl6SvWiUCsKgv+SKZqyem/Q6TjllGYl7RA7n03yFiSw0/UqTUCowFARKZbjDKuZuPY8Xklkvw2OzOcgWtg4ygjrRXUlcHxB45l9sxdMcsu2lXTEm5GzmcgW0teikpKcIjnt6zaeWs8Ud4izBN5yo7GxYk/Xx5KjLvfULdsI6eoDAx6cBM9aNQNTqSIBGRqY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grPYgrP2PfVseSkeQapVot285mLBlOsOOywlh757IFI=;
 b=XfarXO1R+ELNeATdk9viY9oRYrs4LruElDzKREt0hEFvvsTeW2DUf4QQ6pOy2OMLGh2LaVsvCKvjirzl1Mw4HIo+VTT34To1SbYkJ5RMZSa+R1tRDOEEXye1tpwtSazTvWhiPrLYFdbTzLFqIXtxh0W8pTkbYC+xntx4+iOCNxkeFRTrz7g4hh09ExM481wZ2hANqdE4WW5+bPfrL5azvMaTlZ9JZts2zo+MpcBu0ltLlIlCXaiNg67NRKlGQngAlhC/ZrjsBh82RGzeK965EiRCHERZS8reDvlZSisyYpxm+S/L8LanrTuFAE1PQZPDx4wNdJg5cfxKfhoM9OEDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grPYgrP2PfVseSkeQapVot285mLBlOsOOywlh757IFI=;
 b=FnmZmu8BjJE7pna2zqSJMO/7TCusasmRIEkEBnhKMhxmEOW0yE5+6a5OuQFPAecsVFPF3D0EXcTEyG7dxK/qI9e1k5i2ry3mHby+tzKmovBN2Wh6S94GrzWRvozz9ogiVILDAVsnYcamos+h8TuMSeIiQUXF52xgBAAam6qAdKv80jrzkla11Ix7rSP5xluyZloteUczoGDydIm8LfYAUWRiWBKeBdoAiOqjG15MyQAaDLMe+PAQCoFfbhMpOCQCopMXNEepqf8nAz7D0rbsseA/CaWSR0ZtCqGyK4m5TGQkuSv2pUwz+oSG3uamPA0IbKMUHDoDc7ZuAjD9vMS2ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 09:57:09 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 09:57:09 +0000
Date: Wed, 5 Feb 2025 20:57:04 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 23/26] mm: Remove pXX_devmap callers
Message-ID: <hhaj4zghiwsuuisctlydmixgxxlo3jb2vcylkeaq4gl4dcmu7i@oj6bpk2obgux>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <78cb5dce28a7895cc606e76b8e072efe18e24de1.1736488799.git-series.apopple@nvidia.com>
 <6786b209929e2_20f32945c@dwillia2-xfh.jf.intel.com.notmuch>
 <af6btaxeeodhvqrmjmdmz7vx2f7fvnavepyhweisagl2boitr6@77pwrvms66hg>
 <67a2652083600_2d2c2942f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a2652083600_2d2c2942f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY5P300CA0047.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 74222a29-0d26-4a65-b132-08dd45cb746b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bsKjSsaT7CfLhlkvC+NTLcmVuPRtyy2PsrzMyYxBITPJHTu1PX+d+EymxT5E?=
 =?us-ascii?Q?mPj666vW6oeX2rGXaIucKbN87nEnTHt9mI3GOYu6TXZ2pW3lpOd92gYpJ+kG?=
 =?us-ascii?Q?8JDpsnFGu4r7tQ+UhDOvXEtoi8VhjhqNXTjOuhKppsPOLdCFVguLYTWq5mN5?=
 =?us-ascii?Q?SgGUq7IiVNhxPSNq+AqFeun6ufLY0t0ye3lc/HmFPD0BffM2rBpq5zQG0r6x?=
 =?us-ascii?Q?NGm+a7rQYNY5A6AdkWJDwm6GVJvZF4/McKyeCW6YFm0LVr1mTYApUZMgcG7J?=
 =?us-ascii?Q?KBEsZE8C1sDIrZJWRLzCOk4ZyEcCtLNuqJoN84n2z3cS56Kt4mB9O28NnemY?=
 =?us-ascii?Q?EDMHS3PMvHCwqJfUda0a/Aky02x1yDftKa+vvs6fpYddbY6O1joxwrTweWUJ?=
 =?us-ascii?Q?CJ5IwiVfJmpmudB12rkXS2qn0BZdjA8uNTFSP/SjX2v+KgfEvguaOZE0NyRV?=
 =?us-ascii?Q?ibWTHFnPL/d2DAtdSg9re+KP9T23GCr6nsTBRjxon1G8Ke+t1tkxAh2uxndl?=
 =?us-ascii?Q?5q9lom+ShmbHwGe86r/zQXxVdKa7x8AoRYpjbXXkYjScxGMeWUFCberM9wSt?=
 =?us-ascii?Q?JQi+kTtQ0OIQC2Uw0zTbHfLLc8XfluWPSCxgvbnfac821kX2OIktbukPrK98?=
 =?us-ascii?Q?NSG7r//Zqn+wqNZEXHxNrOyOINMx54+9y0g+edAbm36Okvbdb/ROYb/vAY6+?=
 =?us-ascii?Q?xQetbD9Tr1u280likCr/+iOkSEtab5RolD/NR+6ArjDDH8JVrj76/uB0FNlz?=
 =?us-ascii?Q?Kg13rT4CsQXs8zhHIkG4ngNqaYO+qTN2GxcHc3eYC5d1Zvzg8TbHBjzW8nwU?=
 =?us-ascii?Q?l+22eVG9JA01nwoDQL3HXjybkUH05BYRC6Nb/+RGTiyP8+kLqkRguoeIfwRm?=
 =?us-ascii?Q?PRA9mESNBEVMBZl9DTGl4+5F/aKfU4oeLNAalKOtKpKygx9StPfJ07fp3BcV?=
 =?us-ascii?Q?cDEJN0ywCLSv5ZUfqgXnhO/y2lwsaad6pxJk2LauFFXzVZhhSQl8i8Kri68Y?=
 =?us-ascii?Q?+rli7ySFspGFvx1JMfwQgRVp9RoEoIHsnQBqjbBO++gLEayI3TX7Z8YrVPBD?=
 =?us-ascii?Q?NQ+w9hMreLH2d05DYp87LmY06GANsGYqcfnJlh1ixZoGJp5ZsXFfFQAmWbtd?=
 =?us-ascii?Q?UbARk1a/44ulXEGJnny/Gz3HJJluMfV75OVXm5d0WNLKC5zCd+0/Rl/J/0pK?=
 =?us-ascii?Q?DYIsqssnNuK0s+6ArzEZcSoR6//s2SBoE+NFFuTV3RDW2/g3fOp3yjqDjkwb?=
 =?us-ascii?Q?D2FCS5Fyppfj3BxTp1cI+/KsTeIauauqAKOAE7RmMNIXrbw3fmy3TUuLRGLG?=
 =?us-ascii?Q?iFVIBZcUFRKKPYrweQVX+MWSYlHn2Lc5Wkbqt85vDRyY0YHftDso2b98Cn8J?=
 =?us-ascii?Q?Z2rt9X1o1sZM7YFF/t+lLiFUW75y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4+ojzHKJ/S0XNdAM8sjxaxVtBLHaVPGdo6b4XhcJmvaYsdw0ywG70Fs2HH7K?=
 =?us-ascii?Q?ugaWjNMDC7jNK2SLhd30Tn2f44MAN1NcFMbagSISFm5Z/SzLDBhsKlG/CbQL?=
 =?us-ascii?Q?8JHlo3eX21JYiibWFyqwrRDCn4ukKaGg7EfvB2Na/xsO1oK0plK42sCkT8jQ?=
 =?us-ascii?Q?wOmkJEUW5gm3Qr1fkRNmTJZVoc/xd56vnBchyLXa89eOypFBfoah/PgHS8DS?=
 =?us-ascii?Q?bpGPMdhc7BIYtOlIuekMv57srpUWWENz+Lis94w9k4knE7ZoEltIWvO0UsvW?=
 =?us-ascii?Q?To2Aal52naf2FdcmHQ6/hp+GwXswLP9CFVYNCqhtHyrpqMfvQSrk0ZZXjOMh?=
 =?us-ascii?Q?tHsHCFulsk7LBaYVHI4cICt9Ah0uHQsAdm/Ocs+dOYC1xy0HhrhzDfdHXTwf?=
 =?us-ascii?Q?CJe5pCHW2IOOE/LNiyJ2IB80q5YwodoOd+FBKONXkuAYNWFLzfEsey0PJlmB?=
 =?us-ascii?Q?yC5WdVRzmvYpMpjRYpeseCWJBGBaG23rDesN3niS8hLGD3szc40hVBT3pYpz?=
 =?us-ascii?Q?KkmGo2pLzN1sa8r1g1dQxrTE5z/n5xPpyv3mtDZJoBrIMjQIwNiVHsVNx9eY?=
 =?us-ascii?Q?YqeQdVww0mPp55l27s3Zh8JJuMVAj2BUL7L6V6uCO+TLGCWrjTvKXmCOQvc1?=
 =?us-ascii?Q?SeI0O4ahkOzt0m4CeLeZueW/jZ3X3G41dp97jZUgB0IRQFMMISTgQInjF8sC?=
 =?us-ascii?Q?NL8g5eAlUr38vGOVWB2DPQkVAKN1bLRmGjX86tPeigYuz+/XwtDrx0xdkC2o?=
 =?us-ascii?Q?+71xxPCA/C/ia9aBC/ALsBZidae0qQXp15Bol5S1Op6f/t7n6lco2bzwvZSc?=
 =?us-ascii?Q?4OlGZsGgwVSSt6DEs2a7qy8NlG87TgOOinPb5hEedfk/RBEdyIjInROTNX+6?=
 =?us-ascii?Q?OSf4P2u63kJ+xv/kddkNo4jXEDpi0ZGMlMTbpNik3sS9wWPVVhbvFrGqI8HE?=
 =?us-ascii?Q?8mL4nDJc1LbVDSX4EnELOrjis3PF7Qg73jsnc2CDu7eOfyoyUcLM+49vt/gN?=
 =?us-ascii?Q?45OE5z2DbnzPjrLZSQ231O339moX89mkEjbVqsKRbk+z9tr3QGfWGXQJyG0P?=
 =?us-ascii?Q?F6LGwfA1DLtdNuoU0+FLgyRAwzNauEsLgFK/xIyMJlFzPvAfIKRWl84o9uUm?=
 =?us-ascii?Q?2XHBgd9DmNwONwZTV9TBBl/wA1QSTztMZYw2p8RmEQ+y9ZsTyXqU8YJnSyBt?=
 =?us-ascii?Q?sVfpQDuudRX9RNkXxnX2qdK4qhpl+nosIXw21GhJmMx4TJS1bKsQlRsIPKFK?=
 =?us-ascii?Q?deptG60qwhPVJJYjDPwwAfBp8uT6thkYoIuyKuPfLoM1FJXxgyvvR239AyUi?=
 =?us-ascii?Q?YqPzl5GYD2q1BpHam/ZraVLoZUg31Ixp45YvvzzBTTjPC4r3iHekp6sJOo9s?=
 =?us-ascii?Q?O4rUB7aBpNBb1XHn8JzMHiVk9kEI49ZH4CVAtXF9YTQAnqcUlssE1HttfYtJ?=
 =?us-ascii?Q?c+CtFS2Rz9O2DAq7sUqkz1GUEYu3Py8GLvF/txnhd8RNdM5pIkxhcBbnJoEy?=
 =?us-ascii?Q?PcNm0XhNsDvGZWjM+V5WKBuFVS8EIIoybbnet/FIuFgb/NTwPSNWgh4XRRbh?=
 =?us-ascii?Q?yWWCqxtO6hxu7xWUperk6QvQ8UB56KZ4ZncJZORn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74222a29-0d26-4a65-b132-08dd45cb746b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 09:57:09.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xK5j159XZUiFW9XMaIV4CfOWkNJvKbkk65Ub5AgKbhIHcytPeM/vbTz3sg8KJydnnCNS3gwiQ0oDVLfjmPbdtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

On Tue, Feb 04, 2025 at 11:06:08AM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > On Tue, Jan 14, 2025 at 10:50:49AM -0800, Dan Williams wrote:
> > > Alistair Popple wrote:
> > > > The devmap PTE special bit was used to detect mappings of FS DAX
> > > > pages. This tracking was required to ensure the generic mm did not
> > > > manipulate the page reference counts as FS DAX implemented it's own
> > > > reference counting scheme.
> > > > 
> > > > Now that FS DAX pages have their references counted the same way as
> > > > normal pages this tracking is no longer needed and can be
> > > > removed.
> > > > 
> > > > Almost all existing uses of pmd_devmap() are paired with a check of
> > > > pmd_trans_huge(). As pmd_trans_huge() now returns true for FS DAX pages
> > > > dropping the check in these cases doesn't change anything.
> > > > 
> > > > However care needs to be taken because pmd_trans_huge() also checks that
> > > > a page is not an FS DAX page. This is dealt with either by checking
> > > > !vma_is_dax() or relying on the fact that the page pointer was obtained
> > > > from a page list. This is possible because zone device pages cannot
> > > > appear in any page list due to sharing page->lru with page->pgmap.
> > > 
> > > While the patch looks straightforward I think part of taking "care" in
> > > this case is to split it such that any of those careful conversions have
> > > their own bisect point in the history.
> > > 
> > > Perhaps this can move to follow-on series to not blow up the patch count
> > > of the base series? ...but first want to get your reaction to splitting
> > > for bisect purposes.
> > 
> > TBH I don't feel too strongly about it - I suppose it would make it easier to
> > bisect to the specific case we weren't careful enough about. However I think if
> > a bug is bisected to this particular patch it would be relatively easy based on
> > the context of the bug to narrow it down to a particular file or two.
> > 
> > I do however feel strongly about whether or not that should be done in a
> > follow-on series :-)
> > 
> > Rebasing such a large series has already become painful and error prone enough
> > so if we want to split this change up it will definitely need to be a separate
> > series done once the rest of this has been merged. So I could be pursaded to
> > roll this and the pfn_t removal (as that depends on devmap going away) together.
> > 
> > Let me know what you think.
> 
> I tend to think that there's never any regrets for splitting a patch
> along lines of risk. I am fine with keeping that in this series if that
> makes things easier.

Yes, that is a reaonable point of view. You will notice I dropped these
clean-ups in my latest repost as I intend to post them as a separate clean-up
series to be applied on top of this one. My hope would be the clean up series
would also make it into v6.15.

