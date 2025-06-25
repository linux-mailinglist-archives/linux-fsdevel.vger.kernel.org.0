Return-Path: <linux-fsdevel+bounces-52921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F427AE87D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E351886D49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14226B744;
	Wed, 25 Jun 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KwW1jK/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C548266580;
	Wed, 25 Jun 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864860; cv=fail; b=OQMDsgvfVcmopeWGKIWybL5mbiUQ5pGNQ+q0+wacQZiptU6pzX6uiA/qAcAv/U+W5aOmuappds6ssYdj4X3EeErfDKFU1KNHGpzxAO7cNqFQl5z5Qi76uZdpnKoQBnW3pDDDs9nuqKhB5Mz7jpJMdQZ2NnlVCPYKKHfr5of9QWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864860; c=relaxed/simple;
	bh=GTZt+vfe2xA1FTbg426rpelcHPiTAj9B2Udu1VgLHl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DoXM8YripDRZ1YuQoQnfMUOAeYcGsJ/cuc7ziSisrK6JXGJJS/qvuPndVTv6/6EERjelGauKW+0qsW9wz3iHE+kRXmCWSIZohzRM7ekquWABveKT3Qqp8fPuubi3yIiENx/9RJyK6aiu2CL1PjevldeePDY1DpcZpEye+yMUkME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KwW1jK/m; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtsIvoFvII8SZ4r9xje4cojfPT0Vvi5c++wA57dR7VUEXjcZglruQOzlmT2d2K1Ifq1RepfEr/xPWYDJRM2yB+vKeaUZZib3Z3KSVAaW1jBcTcE80jmrTrMvfFNjlAJrC5IjbMzbjj5uvEbIDjlrRTUiilB3T6LWsxcrl0d8qKkD3MPBoWoUGInMPo5odL6/Wa/Ffz4IfrN3VOlxSVEJGSBe0y8+o4iGfsIaRNbRrJoU/5SyiALE3tbE/fLvrnySIEKQq+s8INIhkPoP9e3kRbeQhleo4iS/7CQqFwFfHhcC39nDoijFgx9hBI4XkU4cvX+C8v87AAszXMHBrNj0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWOLM5oB0iwMv5JUCEuCI/sr1yZD0RBTyU4QABO0cH8=;
 b=XuVDVIcVBPuvp7CT8cfZOKXbUW6zFSXIQegDePBPxd3pioIsr4KUViYm4Z3cmZ97AOMYZzumChupNaUvdcycSz1S2vnjNlmfr2nEYbktq6S4sv0YFsMT5A1yC/y2Inkzh6pSya4eEwJh6JASzoVDylLHvdD02Uc7FEXI+9PvUX5dWrTlsSKFip1LMRClW8gcEDkA56jFctJAZvqiBDPXYUqaijX3c6glGf8W1aLJp9GX3sDI6Rq4GyjFgFil80M3v83p0r5bj6gvBt7l7RrxF0R+gh/5S7BTYljWuKcnll5vkaHOP7BW04oDSpR9jAArNtQ86cBfvvTNo5P6BA/B/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWOLM5oB0iwMv5JUCEuCI/sr1yZD0RBTyU4QABO0cH8=;
 b=KwW1jK/mT+FVHOp3BbQ5rHzVRiUOeILCzzP5ly8RLO6Z1P2k8PyEPZ6TuVbppaF5ek9/fD5nJDOh9udHjzfQwzcEmn0c+pr0udo8548tywMRWTQVaC+qePOJRxNrO86gDw/yddexCAmgBzjTlXQXNYuRUfiwodZ4r/ZkR775qJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 25 Jun
 2025 15:20:56 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8857.022; Wed, 25 Jun 2025
 15:20:56 +0000
Date: Wed, 25 Jun 2025 17:20:40 +0200
From: Robert Richter <rrichter@amd.com>
To: "Koralahalli Channabasappa, Smita" <Smita.KoralahalliChannabasappa@amd.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>
Subject: Re: [PATCH v4 5/7] cxl/region: Introduce SOFT RESERVED resource
 removal on region teardown
Message-ID: <aFwTyJO8EuKQOOio@rric.localdomain>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-6-Smita.KoralahalliChannabasappa@amd.com>
 <20250609135444.0000703f@huawei.com>
 <f157ff2c-0849-4446-9870-19d4df9d29c5@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f157ff2c-0849-4446-9870-19d4df9d29c5@amd.com>
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a7a896-3e38-4057-6f8d-08ddb3fbe183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yNzztIuqlIyoqKUXxh2rBDV6vii3W5uziAR73zCGi6bkzjrcQ9ff/PQSqRQF?=
 =?us-ascii?Q?mCCgQj+T3Un+lqKB2xL7foWJX4hn20jPnm1n2CzrHQWIkMgOl6ogR6jhrbR/?=
 =?us-ascii?Q?h8hWsR35klf9ehnx3mbcR0C0exg+JXmdY2IZVW1Jv7OYXlgQ0haJKwYkGNOh?=
 =?us-ascii?Q?+qDONnt4wT0qazl5OD8SEztG0J66oO1eou/vkIwLJgQSIAG99hpabWbEs13p?=
 =?us-ascii?Q?K24xJsGyfNZTFzvOro8UpZZcxWOcUm3cPBZGLCzD6jy46gHjafB7IqdYPxMc?=
 =?us-ascii?Q?yiqjCorfbOhJwzl1QhE8M6eKok2sJ/Hz/OFJ4MHJ8kdbRS+VNa89OrLhOgfy?=
 =?us-ascii?Q?EFY/mzZzqRIzHtebqyQVxZC+T/42uA0aQoaUnCI6C98S7UDTilgzXUbDKfnS?=
 =?us-ascii?Q?9oacsrPdK+JEEW2N7QeRcRFxFRy7aJX1Ya+QWMtHFDZ59Y261yoSgo6+chMr?=
 =?us-ascii?Q?MalBf4BBwUS39QZ/yqTKorOxqig5hSVjW+U7AqzUlk/DlhMb6LfJ43b2JA+Z?=
 =?us-ascii?Q?c5Q4UwQMCWgTAj5lmiSEGdd2upVWKH3IIdrOndmN7MJJ21/QMRhHzsU1gRMD?=
 =?us-ascii?Q?IkOgMZg5gXNs7iMI1M4RHa4dtXesnaWcRc4XE7QTxyPW+VMxoUY3IEc2DIu0?=
 =?us-ascii?Q?g75dgmd4DPOlFZzNqiXyJJfSfHAqVTv1RqKDVfpGt9FfTiQ3UVutGwBMMtsb?=
 =?us-ascii?Q?H3Ww8NIdCIujTVE2kEJfRcv1krdRgPRgSdWqiNDsNapL1UA0Zc+TeJxWG+OZ?=
 =?us-ascii?Q?DdzDry8CbkkzuQE5dR9+jX7wqfzHHHVCtltS71omhn7/doUuOoIJQgBYlZpd?=
 =?us-ascii?Q?YGbp89KmCERnjv4DiPKiqBOyAGD/CsE1dw5gNSIXmLcMeymy4+B4xo1f3UhA?=
 =?us-ascii?Q?RpzYojyK4vG8RQkMIBLf9V0o1z5Kwa9Zgi17Amw13PhpgrcerZbGqSP2ykRQ?=
 =?us-ascii?Q?d9QIUdAAlbePQ4OcuqF47/Ox5DeranA6lZRvorueP655HDcdGjKQwNRDQYPA?=
 =?us-ascii?Q?XfmrOgqX1F/M6EWAkvfeIQVk4LTlXhsuZp2dKeXh2kP7HP+4PF1j4lv9rJsW?=
 =?us-ascii?Q?tRn1TG41oCA/nlaM+beujxTzV0WJ72v1hbv3L0R5Ts0wwgqfcHizx+DcM1fT?=
 =?us-ascii?Q?rrF41l4y5JdZhUiTvaYsbvaGFgWzhwxLmbjk+gZ1MJ8r0CkooH+V3t/GroHw?=
 =?us-ascii?Q?9qdAAHXR7ok4aUYx7pAGirSUd8eI/sR0Hn9z1/qiS03l8XG7nvXcXCyQjshL?=
 =?us-ascii?Q?908GOPH5Ub1GuSRbntcxznu3krKo7UJuZvXgcw3WxyNmFMd1A24AasFOtwY+?=
 =?us-ascii?Q?H5/x0QzTRYd9MIeZIwb7rs2PWaj4c4yIjH/AqLFuMBv8y95am9OY90THRiJe?=
 =?us-ascii?Q?Ac9aSD7i145LWIs7Y+ufYo0yJ6fNUwmNKHBhfva1eFa1EJr2U5flTuC914se?=
 =?us-ascii?Q?pXVENP4MC+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5r93GSa+ImPUjMLWl6uPg8IeVlHPdDLZLM4VlFMVFPZfh7rjZRqTiAZxR/PC?=
 =?us-ascii?Q?AENQvaeoinCMcNpzlVQ/k3Hwqqa8tCpRvtwFqTUZu1RKgUpZDxUWfG96/CAx?=
 =?us-ascii?Q?uDKT9+bdUf1bDnvv7+0lzyhc3to5NJ1gWLWJRhNyv4MyNc78xXL370gId/f3?=
 =?us-ascii?Q?fokkXf/vTDiuP2fPSaT1SZAndJNilGMpyuDvc/VDwqQ9nAJxFJJZr7zDoP42?=
 =?us-ascii?Q?JBqRiIRs6t73Wsa9om0IpCCt/V6LZCh+uAEYQwsUHXt/oLICe9GSIgGjIspZ?=
 =?us-ascii?Q?ToYIN5sV6/CoiYZpLPkNdoOmfAi2eH3BgjxgBCOxIDOmdP7iHTNW0fptL6Dx?=
 =?us-ascii?Q?oatPocDbHmutB2V1aGp/nDQwoAEGLmw5a5gTEKzTYVGTqp0Yg46arDYWbfdQ?=
 =?us-ascii?Q?cXzMW7CCNbK7FNZUEgNBDnj40Jig4AKDKXMfIUYJ6ZkVafPsjjPxufBLTg5R?=
 =?us-ascii?Q?A9o09Fd1N8PMqLG8XhB+dwhvGUQk5W2gW7j3X3VhlgkNMlVriqDDX9F0Lzj2?=
 =?us-ascii?Q?YhLciAtMOqDIcFVqJeZH31KoEbpu2jkfotbx7j+E1vTcAyza9oz+m6WZVlnI?=
 =?us-ascii?Q?ULx2IupMpGq6PCs4BnUA+3aZXQkfSCArd6l7XvVYqm4J81E6fHSjISBAKSS/?=
 =?us-ascii?Q?UgReBOHgUOAGqSkKD8ofyT1lcCF7mXN5OncJ7/2oP7lUiLzfaYyU3PFq5wt+?=
 =?us-ascii?Q?NJ18IJ47s+NKmJMMR9kEeexEOUd6v46uDwlLKG2XY+D30gtmU6S9RAMuGjop?=
 =?us-ascii?Q?ujLcnN6MDXMgNNhDrn8HJHDOIa21vCueoGQq0yu4DeO/raPRGQcnCtYF50Rj?=
 =?us-ascii?Q?nnGBzr5WelwvwTSCXXtecAE836clwL/otga0pArQ1PvTQ1yCVQK41yzVKzOR?=
 =?us-ascii?Q?7YPedAdjeQg8jiqRYvGU+Pdh9/CfkC8ztVoSY6NpgxAQXHT19mr84DPzzc15?=
 =?us-ascii?Q?EzfIKPInPG+uMeu50O9FAKpHKG3N0veBrYfOafEBF7pjCK+JyAp6wks9ea6k?=
 =?us-ascii?Q?rbJmm2HLqvJvACM7ApddmCm3tNycHdIjLpvC8qMWRj2jUXZ6E4l4/0WwMHpN?=
 =?us-ascii?Q?rB0OLaHscvk/3VoOxxaZk3NzlZI0FM/BIJnhiwFGB6mGIyQk+Xelt8q8sLmJ?=
 =?us-ascii?Q?8tNfXX26AT/yVy3fcn8eVUhiYwyaCfbGFFc38kkhbms/KVAAzFMfv92Yidzp?=
 =?us-ascii?Q?OqYYLZH2OSV6xaUgn17oYRquBQQ47zwjEUqHQLuJK3E4ovNHdVACO2/Ms7Wv?=
 =?us-ascii?Q?rbLwmohvN7cUCVYsP3p0hSpA+WeLqTahuj24gJbj9Nov8piJ1MyLqTWnYGrL?=
 =?us-ascii?Q?upeB19z1YVtS5E2i3rbWYJYjLG7dibXvw+aBNAMQIN8hXM/S2L8lpyc1JYJR?=
 =?us-ascii?Q?4j28lyDAD9AK4x0j/S5CmCaUOKDb1BxesDXwR17A5x/RASPny/1+2VWJZyEk?=
 =?us-ascii?Q?tbF81DmwxfRnuPvlbaaRHqkubdJdNbOGJ2/QhOX8b58oe4evEqWEO7w7KNgq?=
 =?us-ascii?Q?R8kF/FJ9vgXUYUeUOK3/C8lMDaUNUxnM/e/W7ZIVrTldlUR1vgiTwmvfE0Pz?=
 =?us-ascii?Q?CxMCSNuLluR7m9AbR6BkIr2T+/xJp4JthknrJjW8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a7a896-3e38-4057-6f8d-08ddb3fbe183
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 15:20:56.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RXPUEGX/oI6VbmphW4t9hHKpweCeaOnXhjEBCBy42Rqok5gglf7aRfpwMyDtbglNah/zGP56GYm+79SqBAnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625

On 09.06.25 18:25:23, Koralahalli Channabasappa, Smita wrote:
> On 6/9/2025 5:54 AM, Jonathan Cameron wrote:
> > On Tue, 3 Jun 2025 22:19:47 +0000
> > Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:

> > > +static int __cxl_region_softreserv_update(struct resource *soft,
> > > +					  void *_cxlr)
> > > +{
> > > +	struct cxl_region *cxlr = _cxlr;
> > > +	struct resource *res = cxlr->params.res;
> > > +
> > > +	/* Skip non-intersecting soft-reserved regions */
> > > +	if (soft->end < res->start || soft->start > res->end)
> > > +		return 0;
> > > +
> > > +	soft = normalize_resource(soft);
> > > +	if (!soft)
> > > +		return -EINVAL;
> > > +
> > > +	remove_soft_reserved(cxlr, soft, res->start, res->end);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int cxl_region_softreserv_update(void)
> > > +{
> > > +	struct device *dev = NULL;
> > > +
> > > +	while ((dev = bus_find_next_device(&cxl_bus_type, dev))) {
> > > +		struct device *put_dev __free(put_device) = dev;
> > This free is a little bit outside of the constructor and destructor
> > together rules.
> > 
> > I wonder if bus_for_each_dev() is cleaner here or is there a reason
> > we have to have released the subsystem lock + grabbed the device
> > one before calling __cxl_region_softreserv_update?
> 
> Thanks for the suggestion. I will replace the bus_find_next_device() with
> bus_for_each_dev(). I think bus_for_each_dev() simplifies the flow as
> there's also no need to call put_device() explicitly.

That change makes path #1 obsolete (see comments there too). I would
prefer to remove it.

Thanks,

-Robert

