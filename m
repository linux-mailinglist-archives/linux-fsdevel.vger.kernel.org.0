Return-Path: <linux-fsdevel+bounces-39227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7EBA11902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 06:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D387A35F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 05:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2CD22F3A6;
	Wed, 15 Jan 2025 05:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVN/j+L5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB1157E82;
	Wed, 15 Jan 2025 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919162; cv=fail; b=b74s9TlSVEZo51Pmbtk67sL5+BszFpKFhkHYD3odUwzitKx4+WaRITMMjTFvsB1Jb0mzNdGB2awI8fjxENAV2oVxsSacDDPsRO1ciVMElxsHxYMLp28TTIYWjIlL1c5EpkRiIuGXq2ox4WIQQlJrVPe131mqPmwZYzy7FLLEBMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919162; c=relaxed/simple;
	bh=AfQiZYjafVS0WWBUj1cZURM2nSHNV8Xb2ODDAb7257U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b6hCWpnPucUF+4lX6llv8sB7RbIkNUcnmtcQRP8pVZoKWwSpPBjDses7Gd0HwFeX1SfDXmupnFfwNGdkR2diqgCUTGQD3p+IQIavDQzWDP/+m+RkfcU+oX79wesbL5zDYUC+frccxsRwgCYOmI7yxim8sUFCdWmtBIFEk7DtxGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVN/j+L5; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8ld8sgsBxzK7PaMkI8lXnvAJgwTfpKP2IQxIHRBJgwINico0SznC0uNe46I4XOlyJd8ipfDLPwwI0NCR/Jz+Nu8qECDabgFIhlE23PSvkfKuXuAFfCdMjR61S+S09/Nwathzwwch542pFGsp/zkn0IMreyo7qkFFX19yKCdNtDg5boJf2/UA9LFC2YRfb7SEAyfMGnp/B6uHzR/lSsrbtxNFGt518mmcGPoJncdy//BGs+sTNxRbdZ3uZMiUlxzPR9/7nfQLjZ/3baFILHOad2WumhRGpoIATCP1TIGc8dFmJJufsmOVLLl+gzO/FM8uSVi+4++p+UcMS1IRImmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2T1YcxHlZZfNUsk7hl2T25n7FwLvU7/hC5IaBmCswg=;
 b=NvnxEAVsRV468NyN7/g3oQWtAMeTpv1RpLr8pqK76gn77mcv0nT0pUXU0FpaHh0hYdyPJNZeemcDbYGHzUPS9EFfDOwY8TTXgC6X8uNGixNTpufhMYRK+joCymnwfkbOEoWPP+bCNt1zvlpBdGU/wDYgIPauLt2bT+2T5m5get1DXo5idrMb2kAbL2ui/OBAUdyloXJHeB2D9xKsyi4E2lS8KRPV/qG3pYLnw8onNqG/F+rgLcqNoQd1/1by6FS3mU4q8f27D4fwouI6XhHUB7i0ScMt1Glb4Kq34CKLdhXyP+yAyx1xg3rj0drTILqvK09uUUnuqaFf0u756eKl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2T1YcxHlZZfNUsk7hl2T25n7FwLvU7/hC5IaBmCswg=;
 b=PVN/j+L5YmQ1MnoI6sVJHnHyaFgOCwbJZ2yV91zrLwG0NdUYnqnndZSmjo1SV9v7nKbfFOpPuy/Cqu+RdRUEu9RLfk3q8tZhv+2a9qmlHnMkB/Fr7tagW112hc2B2arpbB0vhCqila2IUJnrlgqx8DV/5WRKuhS/IR8m3QFg1pCUpWyViJEMbyUIqqBOS+zHJJppNXdfh9csbuiwqqNqsTdjnt2qaodpsf/VsDhzsQExacrdH7oAsRvw8YIYqPQqQt7qwnf4ProBiKaXSwYgXYuYnaLb4YezoUL+dktJGvnhJuaFbIaNHt+Ejhv82I0iOGPfhVsfv1Tevsl0JmbAgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Wed, 15 Jan 2025 05:32:37 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 05:32:37 +0000
Date: Wed, 15 Jan 2025 16:32:30 +1100
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
Subject: Re: [PATCH v6 08/26] fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping
 flag
Message-ID: <pxpog7xsknwpaqh44vjkg5anegfwxizn6sgpdipntsljx5jg2s@rwqa5zfxooag>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <b8b39849e171c120442963d3fd81c49a8f005bf0.1736488799.git-series.apopple@nvidia.com>
 <6785b5525dd93_20fa294f2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6785b5525dd93_20fa294f2@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY5P282CA0086.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: edcd0d5e-0d60-41fa-c707-08dd3526053f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L7vT40tU0ds1HQ91nng0Cl2YPBtkLrDMEkfU4FswtOL+PwPk1SA5jFVUqO3e?=
 =?us-ascii?Q?K2G1KjUusOY7EURW+oTPGSeJNlFmlNJbt3P3SnCWMrSFBmHLe5S/AUG9I2r/?=
 =?us-ascii?Q?wlj0rRBMEGdXKfE4EEA+Ihs80tLDAHEsyMY1RvBE5t7nfE/0D4yfoIFT6LTm?=
 =?us-ascii?Q?LIAWamangLI2HRmGxIoZ5+I5kVHzKGNpFfLO47nkPMp+rxepucX8/b0eANZE?=
 =?us-ascii?Q?pNE/COCMYRx0d3hYdsnnZgwRWNK0LrpiXEhDiAwhsXGvfu82kV3EV0c/TwJ4?=
 =?us-ascii?Q?yXPvUzxvm2ZszAOxnaCk7H9MIkXQt9zwYVOtKYVQoQy0Pv37ryafRCG0RtOP?=
 =?us-ascii?Q?6+fpzFV9qQZeCXdoSkW3DTCZ5uh42doyHXKExv1FrBQ1EHLfuGiFei6QggS6?=
 =?us-ascii?Q?AcPz7q9erFPuMLqh1nT7GrhYVyA4sTdDkZqAdwQGSUiveafRflr/hjqf7Xlk?=
 =?us-ascii?Q?TGx88wG0nZFj3Y10mn6JdaijhnGTfyoCdBN6ymsJLiM2Grse1tZ776GOVJj7?=
 =?us-ascii?Q?WNW9EN5Mu++3ngjAGOST3OXJ9ZAS7s0MTeiqNJLA67wvU+j9fvSDQ52WQtWj?=
 =?us-ascii?Q?a0xd4IArAhq2wN6+Vexkrr2SwRCGEpRN2M1Zjxo8NVgiESV/lptyZLe4AL+P?=
 =?us-ascii?Q?+DQ44RKimiBF5c/CYrHB48qqtH3hUTvUNdoVN6iWCV67D0ltk6DVG16SW9zz?=
 =?us-ascii?Q?bBg1UM8EvoiFrOdgJo6PkyA/dMUxlJwM24P213N7iVtFJRs87thOpInHX/AR?=
 =?us-ascii?Q?34LYxFQJ3vaOsvRKBuf2txdNA+YTuyAUnAsw53uIeTvFmXycamxZBV7ExzxG?=
 =?us-ascii?Q?ByZOExPzehPxDwGaYPBIRX+fU1Pq8zfOJTg68oLSydxf+/oRE/89GiUeFEQ8?=
 =?us-ascii?Q?JxC1qSBwsgiYkgxqrDnIeyEiQst85JUMwyX8UJH4ovPNkj2eiFxc5ma1j2TF?=
 =?us-ascii?Q?+xp/yJJwWe2R6IE0/6b8pdEdflkzdG/tE2KsXeRtuZrVtK8hbEjP4JaR46g3?=
 =?us-ascii?Q?dSVpBCUUb6a7nxMhdnlsWWc7QVz2u/89HG3+uTorubiRz+pkhQS29yu5aJej?=
 =?us-ascii?Q?PCZOL7AcXnAHyhHslpDhpXBYQM/3rUwG1NKygJwroKzJjQXOJsfG2WUpCksz?=
 =?us-ascii?Q?kXyjaY8vQAgqN0tnvcIWCKJ10MlStEo0H4cYByfUE4rPZrZLkxRWVTCXAEMT?=
 =?us-ascii?Q?+WbI55q07PC33EroOU43PUbSkiWGK/+lXXfZJPew4qjspoN4XQVnAVCWVFYn?=
 =?us-ascii?Q?Jr6KEnHEVhL7IVeLzIkbimBywOIdh6A0ORx5h1g7/Y+OHeFPEN/TyMkkwKuJ?=
 =?us-ascii?Q?L4lH2l6dcy/7aw8T3FTAUxiNC9OeMVokyTnUBL64/i+w69affJmAL6ahgrHZ?=
 =?us-ascii?Q?9OxA3kOWavRQMSzs9FLv+2UrVFsk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+3fzRW6b710jDGz6CdZJjk+7d2dV1LF63nh6JTFu8Sr21YG3O9SR7zJhaZFh?=
 =?us-ascii?Q?INdAZxE3ZbeUN0orpZ7FOE2aCNPBukS2UXsvGo9A0tDaq/vxHKDarD1ud5wR?=
 =?us-ascii?Q?myB8V1EyZuZeUEaTvoi0WqgGK4LWz1OnVpq00XmumMQPK1j8CsFJAyN5Polt?=
 =?us-ascii?Q?i9DlA0mY8IkJZIxZOebF1DprWUhcfcw/CwnN56pf0z7gZgTOMvPVGEAJ6JUa?=
 =?us-ascii?Q?E66Whvnawfm9zDLS8if6qLbkV+S2KhIFrwAP1hXyqXMm64WitGSl/uP3MCYp?=
 =?us-ascii?Q?wWuI8D0IZO5Nu+htJFE5TQipDmzeeqbmrgFA5w9DlNYANhUcGuEEu5UDBdUy?=
 =?us-ascii?Q?XfrfLt98xRwyvjLFgyDi1GBOdKB00sCZkGfVGMbwIAUg0KviqkmeZzDpWtni?=
 =?us-ascii?Q?crFU0yuwwD0jxpV6gyLYQnFXU4Yi9arRyohrsQrZLPstS6ydFUu1kcfFpS7f?=
 =?us-ascii?Q?0Q0i0CIkLNBrc1mFBPi0/NbGxKG5LDRfYmHRyboYdp4OdaDlUg1A5q+9MUg0?=
 =?us-ascii?Q?lNhdOtAH0VbWoSGaD97sokXrw0Mr37DBraiwGefzD2vrz5z86uY8ti3tf41x?=
 =?us-ascii?Q?OMvVH+gTinmHKhVPRWnJSGXCgQCVw1YqqxpyiyBe09pXWRl0mmQdj53qPxy9?=
 =?us-ascii?Q?CxcreOXV7Zp2F1f2DQ1jc+JOeIeG/RY4qYQYmQm4PWbirxyrNqjHZrydk/Sy?=
 =?us-ascii?Q?RPYOtdCnLA9udxYNjCngqb545g85sDHBBqsWeOiylSZ0VvDdeMb0gNVOubps?=
 =?us-ascii?Q?ObXwzY+kQd7EvBIxabEzFjILpoO8+wf3c/+UJJGZzrjk9lierBixENDJJlfb?=
 =?us-ascii?Q?2ir3dGz8ZOl+eEOFIDBP/F19FaGBxd2jV95vxKD2L9YAWjA9AWvJAmPUmE2q?=
 =?us-ascii?Q?PtB1LzmI5KJnMs6bfMmkPECYudpwiLk4blINScVa4mJJRik8OcI+QkeD68gJ?=
 =?us-ascii?Q?ExY3bjWQZytyG5LLalt0BJwRNXi4OejYLaAOCyDXIDfx9gkR5jvPb5122kR1?=
 =?us-ascii?Q?GA1bfb86OCGLp1JPoKKvP8/q66tYPF/AfV1++gXswX/QQc6Eu31vMMIHTy2c?=
 =?us-ascii?Q?Dl+Hyi4eqokbnTR3NvYTa/1fcmNs0y4sR6g7TjJpgKf5dQZ3k8Xi9l2ytC/8?=
 =?us-ascii?Q?EqO2aW/FcySErA/1vmNuFluL9SOEJ5I68Rs7mtPAYwih2KsDO9foiJUTnB6K?=
 =?us-ascii?Q?LLLG9dX36n5rg+1RI3hs0qREAiTjfyeqbyAAvLc6WDeiUdHgRnnrvYjpowxX?=
 =?us-ascii?Q?t6jJbLv7+d853pf4yvgkgYTFAoYV2XxKsegRLmfzYKEAWrQI/Fi6TN9l62nc?=
 =?us-ascii?Q?iFDzEIS1FGJSDICet6ejPW5qfNm/zqRQlYweT65MSr+AmMTWrSil8/UepgJG?=
 =?us-ascii?Q?R974VaNASAVL9ORjdEC65YzRzeTX7bpypoXjbmjAaX3LRUD5COMw5bJkkq0w?=
 =?us-ascii?Q?OGYlwCt06f87DoWCIXERMKhH3qN/b+10hCewzQMF+YCunJfVWxJfBUeHwOsB?=
 =?us-ascii?Q?y8JfNTlAE1Lg0SKWnoolnn8PdGzuzB5L4OVcItZ1iGH98SXbSf7L+PVuOJBi?=
 =?us-ascii?Q?eX2f8CRbSCHViPDKhq1/BegLcG8nWQxhZbjMipuD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcd0d5e-0d60-41fa-c707-08dd3526053f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:32:37.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeRTJx1yGFydjn9bIrFO9Qb23Z1h1wrOAk/kPpJHrm+HEma6aXtDa0zpudE+sDO2MB3Lc+/KgRBZi9g/ofauOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022

On Mon, Jan 13, 2025 at 04:52:34PM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > PAGE_MAPPING_DAX_SHARED is the same as PAGE_MAPPING_ANON. 
> 
> I think a bit a bit more detail is warranted, how about?
> 
> The page ->mapping pointer can have magic values like
> PAGE_MAPPING_DAX_SHARED and PAGE_MAPPING_ANON for page owner specific
> usage. In fact, PAGE_MAPPING_DAX_SHARED and PAGE_MAPPING_ANON alias the
> same value.

Massaged it slightly but sounds good.

> > This isn't currently a problem because FS DAX pages are treated
> > specially.
> 
> s/are treated specially/are never seen by the anonymous mapping code and
> vice versa/
> 
> > However a future change will make FS DAX pages more like
> > normal pages, so folio_test_anon() must not return true for a FS DAX
> > page.
> > 
> > We could explicitly test for a FS DAX page in folio_test_anon(),
> > etc. however the PAGE_MAPPING_DAX_SHARED flag isn't actually
> > needed. Instead we can use the page->mapping field to implicitly track
> > the first mapping of a page. If page->mapping is non-NULL it implies
> > the page is associated with a single mapping at page->index. If the
> > page is associated with a second mapping clear page->mapping and set
> > page->share to 1.
> > 
> > This is possible because a shared mapping implies the file-system
> > implements dax_holder_operations which makes the ->mapping and
> > ->index, which is a union with ->share, unused.
> > 
> > The page is considered shared when page->mapping == NULL and
> > page->share > 0 or page->mapping != NULL, implying it is present in at
> > least one address space. This also makes it easier for a future change
> > to detect when a page is first mapped into an address space which
> > requires special handling.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >  fs/dax.c                   | 45 +++++++++++++++++++++++++--------------
> >  include/linux/page-flags.h |  6 +-----
> >  2 files changed, 29 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 4e49cc4..d35dbe1 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -351,38 +351,41 @@ static unsigned long dax_end_pfn(void *entry)
> >  	for (pfn = dax_to_pfn(entry); \
> >  			pfn < dax_end_pfn(entry); pfn++)
> >  
> > +/*
> > + * A DAX page is considered shared if it has no mapping set and ->share (which
> > + * shares the ->index field) is non-zero. Note this may return false even if the
> > + * page is shared between multiple files but has not yet actually been mapped
> > + * into multiple address spaces.
> > + */
> >  static inline bool dax_page_is_shared(struct page *page)
> >  {
> > -	return page->mapping == PAGE_MAPPING_DAX_SHARED;
> > +	return !page->mapping && page->share;
> >  }
> >  
> >  /*
> > - * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> > - * refcount.
> > + * Increase the page share refcount, warning if the page is not marked as shared.
> >   */
> >  static inline void dax_page_share_get(struct page *page)
> >  {
> > -	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
> > -		/*
> > -		 * Reset the index if the page was already mapped
> > -		 * regularly before.
> > -		 */
> > -		if (page->mapping)
> > -			page->share = 1;
> > -		page->mapping = PAGE_MAPPING_DAX_SHARED;
> > -	}
> > +	WARN_ON_ONCE(!page->share);
> > +	WARN_ON_ONCE(page->mapping);
> 
> Given the only caller of this function is dax_associate_entry() it seems
> like overkill to check that a function only a few lines away manipulated
> ->mapping correctly.

Good call.

> I don't see much reason for dax_page_share_get() to exist after your
> changes.
> 
> Perhaps all that is needed is a dax_make_shared() helper that does the
> initial fiddling of '->mapping = NULL' and '->share = 1'?

Ok. I was going to make the argument that dax_make_shared() was overkill as
well, but as noted below it's a good place to put the comment describing how
this all works so have done that.

> >  	page->share++;
> >  }
> >  
> >  static inline unsigned long dax_page_share_put(struct page *page)
> >  {
> > +	WARN_ON_ONCE(!page->share);
> >  	return --page->share;
> >  }
> >  
> >  /*
> > - * When it is called in dax_insert_entry(), the shared flag will indicate that
> > - * whether this entry is shared by multiple files.  If so, set the page->mapping
> > - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
> > + * When it is called in dax_insert_entry(), the shared flag will indicate
> > + * whether this entry is shared by multiple files. If the page has not
> > + * previously been associated with any mappings the ->mapping and ->index
> > + * fields will be set. If it has already been associated with a mapping
> > + * the mapping will be cleared and the share count set. It's then up to the
> > + * file-system to track which mappings contain which pages, ie. by implementing
> > + * dax_holder_operations.
> 
> This feels like a good comment for a new dax_make_shared() not
> dax_associate_entry().
> 
> I would also:
> 
> s/up to the file-system to track which mappings contain which pages, ie. by implementing
>  dax_holder_operations/up to reverse map users like memory_failure() to
> call back into the filesystem to recover ->mapping and ->index
> information/

Sounds good, although I left a reference to dax_holder_operations in the comment
because it's not immediately obvious how file-systems do this currently and I
had to relearn that more times than I'd care to admit :-)

> >   */
> >  static void dax_associate_entry(void *entry, struct address_space *mapping,
> >  		struct vm_area_struct *vma, unsigned long address, bool shared)
> > @@ -397,7 +400,17 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
> >  	for_each_mapped_pfn(entry, pfn) {
> >  		struct page *page = pfn_to_page(pfn);
> >  
> > -		if (shared) {
> > +		if (shared && page->mapping && page->share) {
> 
> How does this case happen? I don't think any page would ever enter with
> both ->mapping and ->share set, right?

Sigh. You're right - it can't. This patch series is getting a litte bit large
and unweildy with all the prerequisite bugfixes and cleanups. Obviously I fixed
this when developing the main fs dax count fixup but forgot to rebase the fix
further back in the series.

Anyway I have fixed that now, thanks.

> If the file was mapped then reflinked then ->share should be zero at the
> first mapping attempt. It might not be zero because it is aliased with
> index until it is converted to a shared page.

