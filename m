Return-Path: <linux-fsdevel+bounces-16726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338558A1DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564751C24F49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418E183A11;
	Thu, 11 Apr 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i90xQprw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99481ABB;
	Thu, 11 Apr 2024 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856967; cv=fail; b=mBgA2hRkz0yazKt4utqJI+yFlUXj4lWsPSm3vplew/sCjCXpstEOJVD9bQ012MGk1J6cQWxbmxEWdhX45uvek8jzrzDIGn8pepUOS6WHLllRhbOpKzkfVlZ/M/fKsf+jSwyx+iUYPnoRjGyKYFXf8yfjM3+dfcmLYpTA7jWK5dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856967; c=relaxed/simple;
	bh=jpVYkB/GNaOjlJfiUTZNC6AqWZCF1D8Vl2nF7Nd1wug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VRl5H32YvrBqPbYaPrX8PqojkhcIKI6bady1anE4ZH5kruTYJBd1bnVvGazLDjjYboVANaRvyzQAOR8Y6FYaTJp/EnAJSnCxiG9eRxlkCCeHXOs2b8j67ySLouKTE9095FMRHAiT0vkSDhu4f3ximb16RjC1Op7jS1wcsB2GUlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i90xQprw; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRehMYqokeKzyvbqNPIZpaK4dpXUk5/uXJkHlU07P9xFaFMCpLNpIUBd3PP5x/TDxWfezQb4F1JM9ZcKnWRR7984CJlveSgQ935uAv+wQHOgIWXa0cfoblEA2uG88+sW8BfvqN1k1TLg2EuntPeAid8YcuTOl23bK1R4aL2w2GRAf3TzFdOjzeVvGr2FYSe2rvKmiy+lESyYDpX5c2g68fRZ92TvBGG5y3rmpbBYJwVR/8ffRbGFgxy8A4FblXxiEa4xTzxZ0sIaie9h4Clh+UBpEUqaRDt+SdvHMKp5gHCAksMvRwURqrKRwhhyzyqV7ITif9Yz+W05Eg7kpbQntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjl5Qols79ZClVJY6aLXyTxzrn9zDN6/cbJGvhtLSXs=;
 b=BcAHMcCqbKqi3/eQydk+3P29NKvPIYXQnwKQU+9ZEVv+BHI4IEH4RP2bFzn5Scm24Bm4Ax9GCJWUezF72UzqTYzlffTmCelmBpQza31Op4L1E+uLOjXaaBghWg91/Fw9HTjZ723tudjl6FVdHHtJDcO1eqFwjpmBznmKFQJUseIGR+TluHKJfoHVDxqwRpjebKu1TvmmJXE9oofvyGkilOy/pHYah4MO5qhHQF+0dOxx4O5OAKMKCmh+cTB+8VHi9+QQa247hwjmBpcJl031QVaoaSxn2m+O8AJQ5c4XJCFQQVMtl68AGGreWVM2xfAFjqTPguRpdfbVETXh0LbpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjl5Qols79ZClVJY6aLXyTxzrn9zDN6/cbJGvhtLSXs=;
 b=i90xQprwA+J2zMo0yf0tOdm4ZQHT19magYKMFy0AsNoLdatoaA4sRZ2mwUFyHi9eTCjoP0dVx4RzOypvY0ZLbJtJXtyzrnoyzvk/7B7wEsXYv3f28xp8HFDlrhIr6dSwA7Jb044o3ukKor4J2TthFbsYNOZvXjxs5gMEG5eL2L7rNL/14VxNHcfd1x7ffVd6q1sL/TJG8E1SZcjk6IlYdhLU/gmt8iqIi+NnIHictGdMiFnzQtpogB43dEk3sg4GFRlNZkCq2ATzAk6EvBW8zaF8Z7gVUHVduFYwX/kF/Y78LFwnIbVZyetP1zGIRqWupF53zlWeLoj1knPD+08jSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 17:36:01 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 17:36:01 +0000
Date: Thu, 11 Apr 2024 14:35:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	david@fromorbit.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
	willy@infradead.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	djwong@kernel.org, hch@lst.de, david@redhat.com,
	ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	jglisse@redhat.com
Subject: Re: [RFC 00/10] fs/dax: Fix FS DAX page reference counts
Message-ID: <20240411173559.GX5383@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66181dd83f74e_15786294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BLAPR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:208:32a::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c1154e-8c8e-4df4-6316-08dc5a4ddac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CH5f3MAz61U7aSxx0EebUykqDAn5GvUvWxU/DJ9pT0mDywuHvsrV5HVXihsR3apZF6fgiox4D9yEYfL/sC1C8sJDfndzT2P5UCIx6vUNmuBzPWnWPxuwfX/TXwh/IcnET8+crc1WCbMVI25tTvcWq4J+GIbR76RSrJk+PlbAU0v0p48CZIYxo2oq+pw9b0lDRrtKGr9e/jndy97eIqGGsW1O0snyh6pfLSlxVig1yDCVLCiL45uQr6I7uxxeBYM9llyeMA7YlvhN3DF0lt72RzkZUMmAGsi2KAAqBmhVA63BWcvYoyOeUD0BCJNHDE6WirmZahGiyC0Bm77ldbdG2Dda914llZnRrcym75SiV0KqL+wBfpBpeOlgRsdLAZsvCXSG24U7if+m5FSFc0r+XL9fc2MtRHOsIXXdHUUGnf9hmhdZ7nj5wJQlxJRBc/6Jvhp4mcGqSaJVhgNzDnoax2bv/doBezR79sFubFkjlKDEbyvJ5Gqraerzis1ivI0mKSjv2SsTWHtvfY8hCabJDLrCoVstv5Gz2EO4hLLezEpf7o6ICpll+sPOlRhLUlqWtGlZcB0Shh9P0xIx+Cr8O1X/AV2lG/YmwLl6yigzGc/+YBgSeKwSup6mC6yZ1p3x4z4JRfoP3DuuZWWzGA4xgMb+wPhLLpd6Q1jpoLTLmoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qPn8+SpGrdhxfW5YYrcDwadj1neaAe3JyAUFXEDoAUANt88bp0lllP/tzvYB?=
 =?us-ascii?Q?Xx3j3zSxL/tdteTxtitOrTxlYPr/OHm8pkFV9QpnG2F+4CMeFafjK3+E5VUj?=
 =?us-ascii?Q?cs2+yPEZ+FgBpZFTduXrkuPf8ep7as+wi3+tqXSNxv5EJbhsx+9YKIeA9l5M?=
 =?us-ascii?Q?gni09r2Imzenf5qLZv0zYfNXl2rBI3y2iIebtIwewtI7pA2AvvOoSvP8b4QW?=
 =?us-ascii?Q?Wk57fR0zl79wBmbl+237JiwTS5rdO2Y7S4Moj9U/VXMLCZNjCH7Q9pxaKClX?=
 =?us-ascii?Q?Rng5dYDBLyBXdxzPDuv+rMQ4c/P1f+aO+QE+mDEjGBYWhV7dIyrfMrLPsbbM?=
 =?us-ascii?Q?5tFT9BKwHi6VhCWF4tQoSaFLzRUlNrShw0Q23vTobrcMq9JTWGg1l/T9qT6g?=
 =?us-ascii?Q?vLuXylVYlQs7ZNesCb4ahsJb14LkeMm81EtHKWCAFOU3CLHlqSYv2GJsj4Oe?=
 =?us-ascii?Q?wnU4oEe0yJpATz+5BZcAU48WtTzpVqwH7OR22Oq3dUxLVr/jlq4dfOZwzX3G?=
 =?us-ascii?Q?IXa40EPcrbJ4+LFF05rqCYKuCtWuOE6+zXazKTybLkD9lau1l7rEOlmECtHj?=
 =?us-ascii?Q?yewgwaF3+pcASYFlBciPM1dd4ux83rIxbT3zv7R31muE0GI1ByaoZkRq4dJR?=
 =?us-ascii?Q?JTpYNPHi/sk72A0+CZ+f2yfZ9zYPR9b6sOk/JvbfjUEQGAAM2wJJ7S41Azet?=
 =?us-ascii?Q?FjVE4IdA2i+ZqNfSqy9cyOQn+5bS6GVZUQ0kJvvUtNtK1cWSSuY0Ao5feVBH?=
 =?us-ascii?Q?88ScLJfz1HnuxWA+l39iY5PT9m6/bGZ2FWeWJsmA3AAnf+hX94jjSZ+xsqSP?=
 =?us-ascii?Q?CE3zkXA0VVbvdV2wpUQmL/1g1nXZGyrRtFJI40SAXZQIuKOav+Ux4X8CokkI?=
 =?us-ascii?Q?gQo3KtBpo5mcYKxQUvhVFEDIoTCqZcaz9X9QdRwdPS0McwZLFonrmq8o+QCj?=
 =?us-ascii?Q?m39InTiTrPb7EuMj1R+YAmQ0dxnnu/Ok3+OcToKMp+s5QxW/VS+R86kofNGc?=
 =?us-ascii?Q?p6UIMTAuiWcbDhe+M+ShFynDLrIV4W4Cj9e+zNQaitnKXicDTmlMho5VVBMS?=
 =?us-ascii?Q?7igAtlRzVOXbzQaT/h0ufDSTalBxvFsJscJ4wMyJqGWCe30m1S5Hh4FZgOFt?=
 =?us-ascii?Q?HzFdbTvUYJVFRd1X7d7puJARayr8Tai56w3tKbtwdfVEMeV1FwISY8OEqJfy?=
 =?us-ascii?Q?Kduo2Hc9LRkLI5hlLFGkv7PmeOsCR4uqdgYdy6Bh3k/EreG63JSishqkNsZD?=
 =?us-ascii?Q?Q578BOQWxWukMEWXP9NAVXy+zzsLVlr6r+QMxahOzUoJFYZouzdP1mBRlO8e?=
 =?us-ascii?Q?VGei2Ge+PcRWrcQ/hAUsO8Ar3pjfvPdp99VjBAf/CaiuBLvXlfaE1xV6bFOB?=
 =?us-ascii?Q?EVQqkd5P3BcHYm1WzUc7q+2j5O2TR5ng/Wsi/si8EgjtH2xm4GsEOyhD7dM4?=
 =?us-ascii?Q?nIKN3+dKkrxi4LEfBxCiG8fsBUsw9zouyqRVM7zMzmvzqxhPMV1bVcT0JDl/?=
 =?us-ascii?Q?Zmw4H+5oWRcmWjoyP21xGDAYJWKIW3yVBt7VhIxLx3XUcs5vcD64IgFLSL6r?=
 =?us-ascii?Q?Q8OJd4TcxdKWv/fwWFlCL+/8XSXP10EmJoyXucZN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c1154e-8c8e-4df4-6316-08dc5a4ddac9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:36:01.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+q5WH9Yxrp9r9txOgQ8Zkx8Gmx0E3f/eA/HkFl6ZRD+po/oUFXptYhFpnohFE7R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455

On Thu, Apr 11, 2024 at 10:28:56AM -0700, Dan Williams wrote:
> Alistair Popple wrote:
> > FS DAX pages have always maintained their own page reference counts
> > without following the normal rules for page reference counting. In
> > particular pages are considered free when the refcount hits one rather
> > than zero and refcounts are not added when mapping the page.
> 
> > Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> > mechanism for allowing GUP to hold references on the page (see
> > get_dev_pagemap). However there doesn't seem to be any reason why FS
> > DAX pages need their own reference counting scheme.
> 
> This is fair. However, for anyone coming in fresh to this situation
> maybe some more "how we get here" history helps. That longer story is
> here:
> 
> http://lore.kernel.org/all/166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com/

This never got merged? :(

Jason

