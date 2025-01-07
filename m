Return-Path: <linux-fsdevel+bounces-38610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4105A04D6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 00:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D185A7A2483
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB81E25FA;
	Tue,  7 Jan 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UkFPzmHL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285A1E260D;
	Tue,  7 Jan 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292253; cv=fail; b=I6O6MMfeWAbVu9hEKruvW9B3rz+SWqnSY0og7awh0Lr9LPxK9p0eRshca6mGZHFiBYnOkbYCap3SvGbuMGSLEDDHuQub6VE8yWXl6/sNaHk0/oZ4vhc6pkwTROHwNitMtR6hHoSxj28mPyJXXUjsiep3vaAGHmTpaKVKquFkTfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292253; c=relaxed/simple;
	bh=aAvzj71F9m88PJRR8hBayMoi9FP80YjM4MkjZlVwmXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZgTQKXVvjQ6PFAWC/1929L/aN8Lpql7lByueoEXdlIKpz8aEYuwQ79bfhaQ80nPKtIspCn2wnnaEALXnyxt3kcjaLe2Jg8E3xDF9OPMJms70kUmZHh1hsbInH5URaUrTjuk1eXSKjAoixNx7FqwLP64hZzvirAb9GdXCfllLN0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UkFPzmHL; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzFaLhP6ypxz2MDZDgfaUH0nZXVcVIPAUQZ6ISYSC0VNYv1X8G23GgjlyT1Cnz19djGROE7SBK1AGQ2bxoiuVEEZ/6OKUWLp0VHX/O2EDlmCS0jLb6+enu7yYF4M8B8roCORLCi3UDGsVhj3LE6d4FY9sBBEcYSXrxDwbKHffRR+VwS3S8d7Z+87kyJD6Z7jda1GZl8l5RQ1d9V7UQxqbsKYRvYy10wi/KLRjMnkOfZJ7m4hhEAqvgtc69RNm8V6sOKLM2BNkqY+kRIJ+uKJKAMU1ysLHj4tkVTpru987+S5KvliEu/xZlhqy+UnwPLMoKAod1l8j4IWCeqmXbPyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W96BnGAw6ZfRgMyb5HqES72Q4ymkGksx0lOoU1Fu/x8=;
 b=YgO5aaU4EJeFURVAhyNOiBJTHen44Vmku4tPehj0JxkvslQGcO5JdVqaI8JHBg+cKfA65sY0waWgyiAgquSssMEE+z5XknTfIgTU4MChk6+Q1BACqrVA71gKfIqD5Sjc2HALMKMaQhoQ2YQePDrRXGjUN5h4RL3FV0YHrCAtArhz0xgyT8M/5ru+I1OFD12NBQhTNXvbPpsEb9OWiBgCCUUZSkQegEbgw9YWV9b6aRQbEbw44QznQlnH5ymd1wOUw7oQOOS1/m/KLxVcjDMY7sCkXUFUl3sosY3S0VlKHS49/76Oa+m6XQzkQBYEw5f1Yzd2jjj4WYBC2rGldS7Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W96BnGAw6ZfRgMyb5HqES72Q4ymkGksx0lOoU1Fu/x8=;
 b=UkFPzmHLHp+uU2RKrmyozre9KGQE9plgR7iH62rjCtB8ZmAE0MTtLpCocGj8QoKMWRySAeDT14X/dvsOgSBItB2acL1HEeYunUD817tLuhiiZZxhTGQARVS2mnhLkWWITS1T78sgWsEobsxxCJIWWenTElO9tdNVnigMI0jviG2T91Ek7acNtFj2u+sPnIsKQOiHFWSGJ3HmztDuBZ5UJh85xEUhU9D4ZkGbfpCwngBEbqyw9NovQ+kDA4fyeJb4HA6OHsAjLLScshgDJFcMI5Ol1zzzKZ+rkW4RvjG6VAcaWG3zbCE6qKqBSLHAci33w9ZCNKinF1CrVhuQUREqiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Tue, 7 Jan 2025 23:24:05 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 23:24:05 +0000
Date: Wed, 8 Jan 2025 10:24:00 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] dax: Remove access to page->index
Message-ID: <ivwl5yqx7bfa6hw233gaicmdb3tvqmy6tqsrfbiyghzwlrghxk@yifmg7leosa7>
References: <20241216155408.8102-1-willy@infradead.org>
 <677c78a121044_f58f29458@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <677c78a121044_f58f29458@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY5P282CA0143.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0d344b-97e1-439e-a614-08dd2f7260a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZCQFxwsipJm5s6fX23hWdFSzJVM3M/uWqtp0xaWtyWaJfslvjrvZqBvvb8s?=
 =?us-ascii?Q?q/1O+2U1hcPSgg9FGEL92uUmewnvjw6q7DKNstoTXBWG1fUV68j/5s4AOssS?=
 =?us-ascii?Q?OAO1A/6yUb6XtwgzeVtWhrVgcS8B3upUq2RPbhKF8dS/kHLSHa/O/vO+G5wq?=
 =?us-ascii?Q?tWofT7KEvwrMNE5e+bIFyq+Ijal3zcKeSrfAJnWd0vvxCWi33DnLn8RI8Opq?=
 =?us-ascii?Q?FrkqZLKIeKdn/8rIorkdGIbSQoguClKkyonwsfW+sx9b6BJXMOYR+zbRuZ0x?=
 =?us-ascii?Q?EWkhM08k6KcpcXQsy6V77aJ7ibCcINTyGB2kCkrkFWS16aL4P6/YeHmH5gFB?=
 =?us-ascii?Q?qbOFrJd4UXecScdPDdAC/NGh4GRnKwNpgG2AapIOG/aURd1bAeNnJcs2uGoW?=
 =?us-ascii?Q?GvWX9N5A9x3erycj0p5wt6Fi3XvS5wJ/FP0TWaOJ5xjvZnRDkONk4jdbXRoR?=
 =?us-ascii?Q?WjvH9lNchoaRXysfzwLNrklVj/cOSut2yaol/+JZfv5bPFQRmhnzL5j0dK+j?=
 =?us-ascii?Q?bVmU2dO6wVNWtJF919aJMq6WADg7hqQBRhKRjhk/WFZE4a3DeyOR+7pJnKQw?=
 =?us-ascii?Q?yaxgwonel1ddxGrus4/9t8SPabB6XT04rkZv9OTpDoyJM7cOIPY3pX9wRfQn?=
 =?us-ascii?Q?D1w32D5MU9A/ENwogJ3z3XYW7Q0YgfBE+J4nm4IBMb5rfjIQtW3VNBZGNRQ2?=
 =?us-ascii?Q?lHwL12n3Trn+J1/vx+qXMhrpyqwnEPNjWyZpbtocbJd0A4nPm1+/DeohBkm/?=
 =?us-ascii?Q?FeROS1v3G9LLU0KELblBemY0C29ArXQreRB2GOmtBzODw4TDMeuFSuylzQ5G?=
 =?us-ascii?Q?8vER5KTYnd43g8m0utLGuEQEf63bT+hLXi8uw0bzuAh0t8iWx3VNERTX31uO?=
 =?us-ascii?Q?9lFh03PCdW4A4mIYmSOTXiZDRJiAGm78Gqoj1EXmwiqs1Inw18+1mkA/rzHP?=
 =?us-ascii?Q?LiTW0UY/BBug9uJLLztWa20gJZnbc135pmoMQ4G0HycsKUq24Sye4F2HWd7P?=
 =?us-ascii?Q?XKCsRaOpvEeEfheXlC2Jewv0OQv+fIF6QsLst8QUWSbt9oL1EvogrDRnBDsE?=
 =?us-ascii?Q?jrpVQoDejcuxl1A6zYlvqg7domK07+s/6zGu3Uiao8BrGd9QGPB1o2f0mUry?=
 =?us-ascii?Q?n78eHDBq21jrFoy6W1CxwmB4s7nuFs19KtzkkpQLFSPG4Pqjhqci7W87laHv?=
 =?us-ascii?Q?sCp5nFA7vGL1yy/9FRvTPvG6axqeLYtyIYkTbL4NtsBxmNYbiDU3f+txY26D?=
 =?us-ascii?Q?g4NjrKdo7kJCyuSI9xse1zpwSGJH+5IHx/iIotMy0i/l+I2JIaf8UD0389PP?=
 =?us-ascii?Q?dq3yCFvUjLnlRk8QH/gemkJHwQNT5yhXwzlwufBV1XXAs21tbaTqdWlqvStT?=
 =?us-ascii?Q?ngwJEzn1zlu2VaRLRoXa02so4+yr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o53JtT79CKfzaiz+fo1E0siqpdSQw1CtDkfqiV3Nej0vQUS4UqP+qv8ePBs+?=
 =?us-ascii?Q?BidBjJevuJDMPpZjsD74r4pvTh2ePpObkLtF7+NM1cA9MvQ8BQs0M8BpfXSF?=
 =?us-ascii?Q?ecVe0MTg2Dap8rlMLZuYr6L4l71eJvlv/cwcRLiqCVmBA6rUeXUzWf7xDz3f?=
 =?us-ascii?Q?npBkJhd6wY82oYiQz6l5CUEUfSiUQ0pCmb8o+nK76R3B8yNQ+YvAWqdw22+2?=
 =?us-ascii?Q?VR97WOGxRHSS6XtE64pZz28SoUMmJZLX/1vt9JkpwokofqMdgsMI9HlipzYD?=
 =?us-ascii?Q?Ftxsd1cWAhLe9+HSKnl45hfOzSNRDOA20BTXn6t0vK3NRxIsH70J1DDIiSar?=
 =?us-ascii?Q?XjuUFHZU7PnWOod8J2mCnDGavVFPMVwhaN9Puyxh91OubLRZdLNT2BQzVjKV?=
 =?us-ascii?Q?J1jATULApcnaWvCyUGv3z2lE7i+yCvGiiM9B4T21R6mgaE4egYJtENC5+QYc?=
 =?us-ascii?Q?bPt769mXz2OKMKlPfCOg+k0zZU/yap1dgiN/9nZAqYluGQh5Yg5wSJz2A2tt?=
 =?us-ascii?Q?NC7oVJ5oiP74ai9AOUuaq9QnaMPdYuogPD82GHq2PwhND7w1dLdLQTf+dx8V?=
 =?us-ascii?Q?u0FYad0J0fdWJ8gZPeVQoX+/GmmmZb+P4Bg4SGE4Mna0HSPH8OqsuEAS6VLp?=
 =?us-ascii?Q?93JrLAVjmZ0arXziYJmcNojKNbJXZXa0NyxN0iFKr/JI8u8sXXluFsQQ29xW?=
 =?us-ascii?Q?twqwUjw5E2D5yu+w5u8r1LkokSl+BFfRolA9kUkylkOXIOI9Qv/IeBGQxFS/?=
 =?us-ascii?Q?hPZUZVfdV0Me44INn6/lqTIk+sMWJcO5DG9ZdQUcP/0tHqULFm1utufWWt8t?=
 =?us-ascii?Q?HUkELJVe2sziRIzWKDgUkf3WpOIX4zxuK/YkgHcKcwoOxy37XxpLo84I1U/n?=
 =?us-ascii?Q?nABn2hPf8nhRTeRNf2XETadqs06UrRJ/2RckG3G38n3UARisv0zkBA1tQuns?=
 =?us-ascii?Q?myu/FOqdxOjXWGbZy4Ty16IfutJZaqNa9berpqR1sP/aGf7vUlnM0D6hl31t?=
 =?us-ascii?Q?j1lSUaC6VWZRpN0P9XyX4UGHMLrI8k8C70qQ1VHCaOp67VWLPcnhZK2Mwzlq?=
 =?us-ascii?Q?5QARd4RjMVFDKmOfmKtB6uq171zPpkrBnV+++9n8ZxkIa2bUlh0zSbvqS3yk?=
 =?us-ascii?Q?iSeU+W/77Ef4YaDQPwUa/krnsH8OTWc/GLmbu+uFhaGuzsEW7OivEfIKS9+9?=
 =?us-ascii?Q?RWgyDPgjY4+b5Cz8entAeaTfaJa8dlOr4J1q1t8mgypkC7XdaOSvbHRizWH8?=
 =?us-ascii?Q?KSD8Q66fTHe4pFOEjhsQtdys/XykfxHV5e6bpIReitT01FR4/A6xLRIRBmCN?=
 =?us-ascii?Q?l8xCLfU2u3ssRaKNdnQm3JlY+GzxgQvOEgV9SJ8RuGATYWL1YdvpB8HMOTfk?=
 =?us-ascii?Q?haXTxSJYrn0ZOZFKxMBwBynvx8QcsKmk7q+0UpyBGkpBQK82jdh3NGiP36TO?=
 =?us-ascii?Q?jl9eX3As4QzFxU2Xtv5gQkEJuxtrZKF5t1IGPqB7xSojx+t0vkaxNBo7+ZF3?=
 =?us-ascii?Q?wGeqmlgXAVfsVmVX3a7mwKqLOtUlBdQGUCuljG1gzot6Ji/zSa0jJlNg63h2?=
 =?us-ascii?Q?hSzLqzQkmnaPbaJynZI9iEMv1XbMMvBmggGFLFXO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0d344b-97e1-439e-a614-08dd2f7260a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 23:24:05.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyMJaL3JhPZLn3ulmA1sMRnDWD4GMKCg1W85+ArX3R5KIP8Lpnaty+VPX5uAM8CdBmfdaWy99Dh/R5cKVx1rbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

On Mon, Jan 06, 2025 at 04:43:13PM -0800, Dan Williams wrote:
> Matthew Wilcox (Oracle) wrote:
> > This looks like a complete mess (why are we setting page->index at page
> > fault time?)
> 
> Full story in Alistair's patches, but this a side effect of bypassing
> the page allocator for instantiating file-backed mappings.
> 
> > but I no longer care about DAX, and there's no reason to
> > let DAX hold us back from removing page->index.
> 
> Question is whether to move ahead with this now and have Alistair
> rebase, or push ahead with getting Alistair's series into -next? I am
> hoping that Alistair's series can move ahead this cycle, but still
> catching up on the latest after the holiday break.

The rebase probably isn't that hard, but if we push ahead with my series it's
largely unnecessary as it moves this over to the folio anyway. I've just posted
a respin on top of next-20241216 -
https://lore.kernel.org/linux-mm/cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com/

 - Alistair

