Return-Path: <linux-fsdevel+bounces-23283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451D392A37B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D61B212B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312B137C35;
	Mon,  8 Jul 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="drTfydYu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WS2D5iso"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5ED2AF05;
	Mon,  8 Jul 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444487; cv=fail; b=LGICDIH+l2BykKsSxM5FSczg2sb4Iia4c6XiOR5aOTs7SWPNFvvlyt26I1By99CaAHkZ7cyHzaqKp+Do1iP7NZeu8lP2fFwC4q3KxC32Ok6Q9N5I+bMXbpoBClZjRUcBbXggr4ZWD7G9GF0ZM3Fi1FwPbWM/svO+oRNvKSfLFaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444487; c=relaxed/simple;
	bh=16pPAojwyB5xeIN02xkKZtyCBUpXDlRsrkmj81q8BYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XwFN8IuhThUE8b/W/GmM2adNHbVDRdrh6fnp/hB+s6Wj2AdtFkpb8vf2jQxiI0VCgw5ogrCSsxG91W5UNKnsedQLnqcnsS2nEJ59XBCH/YtOuQiZcuKItbsdubrCxm4qXrtiTDYw/HT/hdi4aIAWTMbrApBlzPqpw91RKbiyPLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=drTfydYu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WS2D5iso; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fTXs004156;
	Mon, 8 Jul 2024 13:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4RfiYYUMf9bsyfU
	t6KeULBRP4po9QQVnLV20JJaZYNc=; b=drTfydYuVx9atUv7QJRSfhpz0/IS6dc
	6hXZzylzzaTYxNF4KNZXGlEcn/5Pul4YA/G1bahmazzPFu8UGQiQgZ/hEGEkf1e5
	kSsLcaG82ZKcFPH6nwb+2V6LzVtauwM85+IxVlM/UrejvxYVRPnn3KNMPMTJfKnd
	wAfQW0H9Lm+akadUwN0kXFUV5MOFtXx7o/emfpNkesugqsPr7cBgtm9espEksLuC
	R/BAeOvxp75AeDi3TQgrF2UJewjG0kXPvHHdv9+MTUZbNTjXu7fTSmF7sdg8ZYVC
	OlG3AzStunvJ7GjGRpBFsDmEsx/p5dSH89wnEn2dESUUc+2s93+1H/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8ak2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 13:14:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BadKH005055;
	Mon, 8 Jul 2024 13:14:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvc4fcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 13:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4RkOxnOdADvaTKM0Nn4y6HyZ7NpHUa1P+ZdAR2cxNsCfZ1B4iFbqRGWpmWkdwtr2FSruKtnICXpxy0r2RH0UFWp/0yQEoYDFNsat3jeq03uRPp/O5XBMwhA3/A4GRCii87qE2f/E9kIBb58E061XNyDY6kZDxq+Smpoe/rJKkL55qL1tv6ayJm76K57++ZWmcmPc9yo2Knyzz0tLS0WHTCvLidiWGt8L0hT3T82Mj4wKK2ujL06cYOaSbPMPDMWzq5pdhCNmF9Dx6//GG4jaIIArCFdo8rCafPAQLAY1fTcX3xdsFZgcxn8+kUEbk1B/KRiX17ujUeIILlMZ+TXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RfiYYUMf9bsyfUt6KeULBRP4po9QQVnLV20JJaZYNc=;
 b=enh2hM5Z9k+o52YBDlXz66kiNchWN0ogp/LAiPxJshY4XWNUgbRbUdZAX0HnCGDpMD/WPBNE8cNYqkv5w2d5jcqCLtVR/93IC+NJ+6J3kVRUXAb1K0GAKVu+qjOvRmLwndF9+ButRjGOlPGfPlq/DngeQgzri2ilCPTiI03Pn5fMx/6wlei/a0rIFiOdGZuxkpOlEmkWc+zSrEDEmRk9ueY97DjguZHmHrtsjTednq1XU7+HIw/qo4crNidLsE33l7mZP84IaBljaonFJIb8sKrtOb/I3Qk+f5KCUAPhtMFsi2erh4IaY0npB0kNsa7ZlgcZAnKCzji3Q433stWJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RfiYYUMf9bsyfUt6KeULBRP4po9QQVnLV20JJaZYNc=;
 b=WS2D5isoRopw4Ui98ANontXQEwi8ZOCnyjCzeS8D5EZ3s5uCrcNbJb2ny1g/fYbAA2cVzsn/ioIL3+h1XyC0giGXp8kmLrMvHsvIrpHD8LVTSW00zgo7gT/qzuANCYf7Fle1rnDUGmZo8fb6FqECWe7PYVQxM4/vP9I0DZZoBf4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB6474.namprd10.prod.outlook.com (2603:10b6:806:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 13:14:27 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 13:14:27 +0000
Date: Mon, 8 Jul 2024 14:14:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 7/7] tools: add skeleton code for userland testing of
 VMA logic
Message-ID: <09d76800-5560-4193-b547-baaaf914581b@lucifer.local>
References: <7989012e4f17074d3b94803dcebb8c3d1365ca1d.1720121068.git.lorenzo.stoakes@oracle.com>
 <20240705182801.95577-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705182801.95577-1-sj@kernel.org>
X-ClientProxiedBy: LO2P265CA0389.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 825be4ea-e89d-4c58-a1fa-08dc9f4fe4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?c/F+8+lqvBeSIOBYp/dM90QBZpppLs5pN4Y5yTH/cMLebjagvQVvapUBT7PM?=
 =?us-ascii?Q?5OhlFxmxiUmZLVU2gplggju6f0BzPdDokK8UZjnhcnQtQhjf5mIF3xY4IGTK?=
 =?us-ascii?Q?dS9p0GEaMB4598muSWyFcIntHBg4ptd8pGo4hL4FezcOHt6V/+O3ZfKAsJ4S?=
 =?us-ascii?Q?fLaMQQH97mPuoGSgWY5yus7mMQRK1+BSht9A7nifZBz8BvWQNaLJmqKo1vwq?=
 =?us-ascii?Q?BgIeeB3vg+/e47xRHG+SQ4iODjd1L7eaYKwnSQJm2M332ISA/7C7Cs/j9PFv?=
 =?us-ascii?Q?UqcHoOlea0YVANMWH7ye5HNFYBEPvdXYp+G+Cm9u+HKmy0PmUF3jpCrA6ci4?=
 =?us-ascii?Q?6B+7ABM9hOD1mTZ4gg2uBotupMOPEXAFLG9NiIGYO4StkTaP1jATdXqqiQSl?=
 =?us-ascii?Q?K2hjj9G4+sLh6YPDeQ8cs8w6RmFHPg9n6q4KHVmcgZP7FnuG/qcnTV1xzBaG?=
 =?us-ascii?Q?Mb2FSiuthC4+goqY5YeDh3khWalZ2GeOn459Yo/YuCezi+8TaMIoVOs1Soev?=
 =?us-ascii?Q?TWRF30nwLhraLO6wufJVMp83JqCrIAJAquIv878tpivUsufj5aLtTlVRe9B8?=
 =?us-ascii?Q?4zZXFEo7Ma72Jv3NkdFHUcG7wB1EElP2VdJZA6oR2lVMBATsp6Bfeo9ym0dz?=
 =?us-ascii?Q?th668Kow2WqtujiPYMqPnZUq46DsegUtxNJNIbt/JvGXpdnMeqMC0CaE5LtN?=
 =?us-ascii?Q?NV4V2IE/ao0qjU1FiLx0DlgZPMq32vRosSMUNoEs/zx/36ipHfwWHp4WkT/g?=
 =?us-ascii?Q?kkhzWhK1hmctUROF6mCUswl56NniqXgdsjllF6fbskgB2gAnfcjEVdmIIVjr?=
 =?us-ascii?Q?M5TZ3+zOdUF274p87dsl/GyT0A92926/+2QKqgbeq95CbgmEf5yuE0elPOO9?=
 =?us-ascii?Q?IS251PK1ed/meT3LntzvoURVfPAvjaGMzscSvpCcWpnFJ6woTC6gZv8gZFaj?=
 =?us-ascii?Q?MEhxjhT447CXFQM7/KjbEixMal9nyDKv+klu/997S4UzAkxkks5VWrg//Cc5?=
 =?us-ascii?Q?Ut2zI4IsFdjxBhFBzp6xoirMhO7PvX1OgkO2UtE/dnJx129r+woPSr2SOOUk?=
 =?us-ascii?Q?wCK1ptqxnKmbMX846lpfe2KGnOFKD7iJihYfDb28AtnmVKqbdHB6kFWdSZC+?=
 =?us-ascii?Q?XHblR/0dZl/zw4Md5WKXUVF54W8BT1WxGFt1Wj902/LsYvRhARQgUBnYu5O5?=
 =?us-ascii?Q?tZQVEyQWmkSlKBNG8wVw2tpQUi1MWGYGNbbi8QsBG0j/37T7UugtFedxzVCu?=
 =?us-ascii?Q?f3sifCwqOxIq17W5RRXmnJYIp3HuX7QYsufEDhwJlEMsq15ekfJxKufsHQId?=
 =?us-ascii?Q?AIPLMGZLAwDxtQr1Ouu8YXH9atW2MgHSyp82uZXrV4VMuw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d1WdiS3pJqLWBh37akIVE7ykFWmauONTHhcL7Gsyp1yF6Eyw93+2lcSyoqI3?=
 =?us-ascii?Q?mHNG3yd7NkMbRv+gGIRFw4QJA/uBeEIe0wAXUIudscWhBUlZV5wqZY7a6hGE?=
 =?us-ascii?Q?Z0t+5bw9MNoAomBV2mlmVuhs6Gg/7y685VpEDVeUfPx7RJJNYy5uU+xKmvlG?=
 =?us-ascii?Q?VQ32WJNh5BEdnVjQQxwuksjGTUF7eWZc4E02yjpJGTZ93ONieu6hDl0RZ8Dc?=
 =?us-ascii?Q?xvJofUa9j+KG7pex2Bwy2fHFBL93ZmMuW7Ukd9/4NAfyxPTUIErIuM2Pln4s?=
 =?us-ascii?Q?GE/Cea2EAAFpRjpgFyyB+eDJRShH5Vb4BzoISST54tc8uESEtMmIT2zxWVYD?=
 =?us-ascii?Q?TRDW0fKb1nn+8dnV3t6QQeMx2sUCQMb5uRkwmZNqxJrMYjk/d/JI6pvNe2K3?=
 =?us-ascii?Q?z9hwtJCOciAGjE9M8S4/Q/+ZQF2xOgNN3krOQHug93VEpKZkFCP8PPfjb5zk?=
 =?us-ascii?Q?OThw1QRcFTk8cofXOxWRvhAeyZBu/lo8kE3HbSP7m0hgaFbwC5CgIelFKQgy?=
 =?us-ascii?Q?R9NnP7oEgI5xxspasS8nSNWG5o2AsGnNnAINqNuYDgd3z9vkhKEUBm7dCmDW?=
 =?us-ascii?Q?nuDUlMwejRKHKdfujpC2UVBHoqFDst+Z3VOm2XGxXiUGgDZZKcYl1qiV2ekN?=
 =?us-ascii?Q?RbulytH3loLSOzfe9buCuS3VBOrZGqcBEjnDCBxmG/RNWjE3snFJBoDI9JnJ?=
 =?us-ascii?Q?6qbXfEp4wlySCH9sjG9glkeDEuQT08KWqAzQiOyjIR5RqPeEv3l+cDURCodq?=
 =?us-ascii?Q?zpzgJ4jTnLi4y2sCRYd7R4GO/6WWgnNI9nkbz0orrskw+6yHM7qEhRZLuhQv?=
 =?us-ascii?Q?HukHqGiYCgWV8CdFbEF2rOPx0Pv5+HoleR2nR6zK5VsEGZ0kdmFqnbUm+hp+?=
 =?us-ascii?Q?IWNGn6vsMtgHi0RXkHc+A0KUpUitzwBB0gf+2YGVGxYermLLxLrdmHf3ZvIq?=
 =?us-ascii?Q?DXGi/M2s1M5aD7gc7+eaaPKNxqA0OhP7medJjDXpgq+3cuZU+Ird1cjjKmhg?=
 =?us-ascii?Q?c5xrVABg2P2E0Ofm9CIoftZ53gjPLW0pBqqYEIKjwaNeU5QU84ffZiVDkenE?=
 =?us-ascii?Q?ZenToiJkMqdXpYX++Nxr1gc0LFyazvsItAzcc4vKn26naAkKmAa39HIx0Xtr?=
 =?us-ascii?Q?lW8R7gHQgONl8QstJ5LM7QCg+uDfOH0x/ksjtzl8T4jWOmWuegI3uOGcEbj6?=
 =?us-ascii?Q?JkaUETZ4WymFUd8SCMXTN8uugpMplmElFUq40qFsS0ZEHdX4rwcdH1JhgurE?=
 =?us-ascii?Q?wL+v3jw1AA3y5XPZzO4I8PDQXdigSkT9dEKl/zLmXBPmeyMKzPwpdyIvQ9bt?=
 =?us-ascii?Q?nlsdixLWcPOUncnFcQvGe/NRKLWJRHFEp03r9fNOONf0wjfZuATq4K7FyTMj?=
 =?us-ascii?Q?qTw/CPdc9IXp2pp6R2t218TXHRHXQRysZK4DrZ86IsYz1Nppocm2eezRVWaK?=
 =?us-ascii?Q?mrDLuI4kJo5n7JE44TbN1hX/KF01Bie+cRKW3/12dlJMptTkZg7UOm61eczJ?=
 =?us-ascii?Q?rAZurMK4xcQvzkvmMAMKsEbm9CiNX2VwSsDMRtIAcHVNy3dAbitCHw9hT+iC?=
 =?us-ascii?Q?9GJ7svnjK1CnykaMP2m9PYI0i/l/d3PXRbINQz3dmc1SfFggHyph9RosJWq+?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MHHS2MjAqyIcC/WqVfi19ch9Z3dxm+z/R4eu0SFcrtz7wN8C7WzSRAD9/QR50g04q3h1lJxoKLJX0I4fbv3M8X44GWK0o5hErwZgAnlB2kT7u6jBy++vnUz+IoYVpBOttzIE76l31EXZbL0+ErJnK2+51ZNaDmgIEWZaUwTfAGgjWachMp1nRgpISafxHI+mCICddDQCWSqqd5QwyVTy4BUGXb73kN2/g0rjjC3NVbqlux8AQFx2U05cxBbbrwjGbGYkyHqwrAwz13KVB2egjeDnsKi558t/Ugwc4PXgkGBfq3rpEx/xrCj6gRMU54SOydwQ+xjJdnG8sn8TteXg4sYEUvPvtMavEOIodOYL2uJiwJdg302fANp387pIXPXQYQz7twtTDYIwCm8TsPC6PBrq0iTltpUaiV9p8KbX/56Xnq7by/PbhoH4rZ8pRS6Nx7AFlh5nfAwAPhqvdX9uvD5QBQ9N8ZQumYxq41X2HOgDq1EPp6JVK9JbNyFrx/IY9USPTZonC4qLMx7dF5LM7GFW1TzRFQaJBLEIQKvOS9aJdLuDuUW9ApHqLcxYMP9wRBXZajCKPNMAjvF4cRoRVF9EgIXKIfP+92jUU8jZwBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825be4ea-e89d-4c58-a1fa-08dc9f4fe4c1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 13:14:26.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ne/QhkjlsHqXBeh0g4JwmM/GYb7NNap7EK4IExAQBBSWdjG4AWaHF7c9HE1frAeQpTyxsCEDbSNkEd6VTcMD1ge0+i9L51HytsIu/AsGtN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6474
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080099
X-Proofpoint-GUID: asQx1wT-imWmqU3qbsfXysmdpgnSCqHL
X-Proofpoint-ORIG-GUID: asQx1wT-imWmqU3qbsfXysmdpgnSCqHL

On Fri, Jul 05, 2024 at 11:28:01AM GMT, SeongJae Park wrote:
> Hi Lorenzo,
>
> On Thu,  4 Jul 2024 20:28:02 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Establish a new userland VMA unit testing implementation under
> > tools/testing which utilises existing logic providing maple tree support in
> > userland utilising the now-shared code previously exclusive to radix tree
> > testing.
> >
> > This provides fundamental VMA operations whose API is defined in mm/vma.h,
> > while stubbing out superfluous functionality.
> >
> > This exists as a proof-of-concept, with the test implementation functional
> > and sufficient to allow userland compilation of vma.c, but containing only
> > cursory tests to demonstrate basic functionality.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> I haven't had a time to review this, and I don't think I will get the time soon
> (don't wait for me).  But, I was able to build and run it as below, thanks to
> the fast runtime of the test ;)
>
>     $ cd tools/testing/vma
>     $ make
>     [...]
>     $ ./vma
>     4 tests run, 4 passed, 0 failed.
>
> So, FWIW,
>
> Tested-by: SeongJae Park <sj@kernel.org>
>

Thanks! :)

>
> Thanks,
> SJ
>
> [...]

