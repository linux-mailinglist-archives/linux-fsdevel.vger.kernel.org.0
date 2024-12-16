Return-Path: <linux-fsdevel+bounces-37452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C69F27AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 01:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5711886196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 00:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFA71CA81;
	Mon, 16 Dec 2024 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhFZLlx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDF611E;
	Mon, 16 Dec 2024 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734310542; cv=fail; b=IPGqDsv62/lAGN1WP5pU77cncw/IWC0bXIor8nCrT9BTALb7njKlrQ1ANBtcA2aLYHJikfMbTCA309Jsa+kB8AYB4HcphJ2j/CQcrJd8bm0TB/ODfo+lg5aeHzF2mIY0QK5Pp17NY5enkrPfRfNq+cT0jsw4AyFyEkH2EOysdOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734310542; c=relaxed/simple;
	bh=M/jBtdxfJXzcJVGreDmCrDUql4PgaPnPAFUQ/PUWPI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qdUDtmiYm3KfpggpqfCG3CnGXjiBPeyCKU3ZR5YdKmQkydkIQCX8Gv8vKZrfxR3Dtr3/egPG4DuKhmpXWaasrpp0HXCgGKYppM4ouVC8n7GsXgEN6U/SawR0RRs8ux9xK6Ck9XQPB37zsWoTnByJrTh/5oa1xDBxJeAuAUP9DEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhFZLlx8; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiBhFBGl3VMTFcyaEIiR/Jyr/FJWtLkZsomIJB+l9m//3zbE2whN4+klzRClO8EutNGdQUeDPQ+7cEKJYhNltZCT77birsZ/XD22w2oPEuu8yb6wHoBn7Ff2UjcBczDm0xChN8vBnUrRV6dYtb9V88cpbFoI35fY4YHxoMUXcKqDQM0yXWkdHX/yXUpEmsVG2rBleIChFJ1R0vrYwJ3nMfOKlnNCfNPEXRTB8/6tPCziO3dtyKIPEcPDhY0ZdonNO4gvQGL+9q0phRcdpQ8yzLJcbngNMh0dJGX1OlboED5l/nokMgINFg/iw52krqaSmONCKfFkQOG06v25MQFQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MN+CJaXtlA1XBsuGyZHtUk3wOTxi33O0M+S8PZbfo8=;
 b=ypguJhlZ9+43PfvzV6Ic2/CPsOUVAzd0Y1ncFVDcHcRDbXkeXTDVXAK/fWHs72QGH1CmNNG7uSB+KrLsG5/2Ehvp6vQoYWIqu1uPIOgEKsWsJCSVQz7De0Zhm+sGxk+HapLteNCyJVSO0e/Ze1dIknoKj24rQYFU/qUynMV5zRjs8SPkhMNShSqdC4ENl/WVmpPaVNbngyYlsKoADqIILrrKQZXnAfD4S/4KVmIufGDPtSL7NO+WRhYh7ct/owZFWRKSeoPD1HJ9BGG+x55v2STcYi+Rtd5C84r+FLy2UbF3fjiSLqOHGyclzV30+PLUUxPP8oZdUWgR/dJGZ6FRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MN+CJaXtlA1XBsuGyZHtUk3wOTxi33O0M+S8PZbfo8=;
 b=qhFZLlx82wtcSXDQlMdEgmEGLR9wMBN1cW3+GmBBmBgQe4AaFY1Y3YCxt6cPXwCaVZyqA07TEw06iCSIWtc57L7Vz0TU3m3kdqnMNlwWqkLXq53rKVufDsSBhjNLXVhfSvD9QHfIuV9NPtVu3DI8rqzvVvNDVZ+dtxAvQFqybg5lKQMzHpapjr2Wu862EAnIcpVMfqQrxSpW3gwwzGKJTGD/8MsfXXRz+Vo1Dq8KXsXKG9iOk2frcheCvE6Una6BBgCLBwJ3N79qE0IP8F0C/tvpFgFCUWqe806arjgVA/Ghi4EU9vgYB7l391eYz5aADPoFWiVUlLD/7zYc21jb5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 00:55:35 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 00:55:35 +0000
Date: Mon, 16 Dec 2024 11:55:30 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org, 
	lina@asahilina.net, zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, 
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, 
	mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com, 
	ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu, 
	linmiaohe@huawei.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, akpm@linux-foundation.org, 
	sfr@canb.auug.org.au
Subject: Re: [PATCH v3 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Message-ID: <wysuus23bqmjtwkfu3zutqtmkse3ki3erf45x32yezlrl24qto@xlqt7qducyld>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
 <675ce1e5a3d68_fad0294d0@dwillia2-xfh.jf.intel.com.notmuch>
 <45555f72-e82a-4196-94af-22d05d6ac947@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45555f72-e82a-4196-94af-22d05d6ac947@redhat.com>
X-ClientProxiedBy: SY5P300CA0044.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: ba97cd80-05be-4978-b2da-08dd1d6c5933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vxat8zHSeABYBM+0p1vCH/IMsNy8M82YgbFVYayqgOPCAftgC7Ducy6rrNMf?=
 =?us-ascii?Q?eqdr7agolvu9cZTayaDzY4qBMwe8r7qTT3iDXZ3PLvRs89LiuQFDAogt8737?=
 =?us-ascii?Q?Z0UCDJkjOf64g2ctwmjt1YjeFJKVztbbyeSanzGecnUyJzGDRuXD++g2hx4r?=
 =?us-ascii?Q?MOBT6gPjiHexf0Rh8QLOQXcWktttdv+07kYg/WeEDqH92lh4UAMNVaXn+3Eq?=
 =?us-ascii?Q?jalnkGtCZu5/WdLp0lazGEE0TBco7xAxTU7j8oBi9dAQAvDY1tRCAM1T3JKH?=
 =?us-ascii?Q?GOvuQRc1aqstBdzf3QMMJq8Lz4NNk6ZXKduXLQ3c/2pFicKzCZHZt+OQpmT+?=
 =?us-ascii?Q?1Ulza7fM6kaznLGrywj4N4nU21L1lb7XX73n1nITGSPguWlqB1iSiQNIOJXe?=
 =?us-ascii?Q?mjj0uuUU2Oteg5Rf7F7fNONnTRngqEImplz7YXuDZdnpWYAgCfP4VoKRPIoi?=
 =?us-ascii?Q?726WxCQikwFa6ZjQ9E3dB0fV02lPratzubI7ApuSrb0NRCA4ocQE3ta/COTz?=
 =?us-ascii?Q?oPRiFEp8tYRKlDZ6/s5pjpc9ZrT2jzO+OioCBq8TUwyOTMTvH7jcIpDCLI5r?=
 =?us-ascii?Q?ORPmhfjhlxgJK/lFJJAaVZCrzvZ+8803eJsH/ljRmn33oBHCmkwEY/Gmv00A?=
 =?us-ascii?Q?STQpENkBKmNKnMlmryfrm65OLpC95BPrPVh3iv7zS8ZjiZzv142kCctcxG94?=
 =?us-ascii?Q?wexzlzqyhq8MPDjAbgpsDVoN//fgO4iSx+cw9jTnuAFeJZpFMT4sbLHpcOnQ?=
 =?us-ascii?Q?/Owv3u5ICND0uCtouem1hJ11lQnrKcwqI1QQYyX1k5vmwTKUmGeAlUaBFsBm?=
 =?us-ascii?Q?fuliT78bYX++jXjwF8gpGSiqhu56MZvM0sQrTHG8mxYZE4+BJDxFEZkbOv7q?=
 =?us-ascii?Q?zp7W935ZHRXu9jSq97/mF0nUduUEeO3gVFKf6oSb5eSjI2AunG2hgYqki5kh?=
 =?us-ascii?Q?e+g/lovUCPOs0DQ8t//i9JKhFuHWlgQahDT2RMPHlalg2AozPUr1F8EC5guv?=
 =?us-ascii?Q?qPHlHxdiOR6HE9bPoikP1/ZeqDmcI5hlZDbLCE+RylnyAhYqpd8E1y404hAx?=
 =?us-ascii?Q?wrPFbVQwHL4co/DpubXT4dNigRGMUzGXOdaPZn/skmyynMYgfYjQxu/x20h1?=
 =?us-ascii?Q?y7y/eSslcAsBD0qZ52sa+deYSt57VDQG26yx7uBVfnxQHReNEIcVGf98BnFu?=
 =?us-ascii?Q?jPIkPMB9tEkRB3qQr4H9t+qLI2HJS3EYvw6KxCuoLJLNf1X+8jCvuPVQMX+d?=
 =?us-ascii?Q?yMyTeiRLYdBa3L+ucXxe1Ey/oKCyzyJBlpUrQkwpbJPmfwMr8SZjm9WgMUld?=
 =?us-ascii?Q?g3icLTg5ZDSeoS5/IlMVqy2p+Z5QdXFf7zQXki1MFNZaxKhylES7zm1opF2e?=
 =?us-ascii?Q?06raDMO+00bDqZHHpzWDHcBTx+Az?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/BU0vczWUWjGDRE4jaCAEpSsiXrohOih13LEyC8SaajYsykij4HDxgx6zAqK?=
 =?us-ascii?Q?J6PsAOy75dl3/j+hbiK3SDx39Jre+WqmwI3np1gjYOMZAxPNhw+opbis7RXr?=
 =?us-ascii?Q?3a5ZfA4dJKJsvY8Lu4ft4DTihEjdDTRrM2n/MX1qTkVKSVbTC54/ZLshWkRc?=
 =?us-ascii?Q?NiOAEpcIykpPYm0xmxRSbqIiyL540qUyrTl9H1Faxe3AoRO5/2Qmw7oZaAQL?=
 =?us-ascii?Q?t9wEmznidAbCTlOzh2hTNT0CPUDKrU9zl9FKmaa1bUUqDuWh7ZDH69VmZhA+?=
 =?us-ascii?Q?nMmn8YptVvGsffKwoWgWhN0LMwCHwjQszQOA6UK1UvOOYybIra+JM+xh5YNs?=
 =?us-ascii?Q?RtP6iJDe4s3yuijcSed3RoFEgQyw5Mpnv+2GxRFP8XSYB0EL97wDo5HT14wc?=
 =?us-ascii?Q?uraCkC/4Md+CwZa58UgJPfTR/VYGgYWMsxzrDz/HIfAZ0CQESnumgg4XGDRV?=
 =?us-ascii?Q?MSgJVh9o6v63wcBAWTjrzVzhTZ2k5t2Tby2Mlr22qO32CeXl78UacL1/wpwB?=
 =?us-ascii?Q?Th1hVBb5iTeQPUnYu8evTPNF71511qmKLjtR9ATLFHqCF6GckXinDuMx89fw?=
 =?us-ascii?Q?/pFOAih4s7q6lI0zfo7odGWefI9+LdMwpxLgsCrVE6g8T+pkOGb36hBYyDQc?=
 =?us-ascii?Q?/6jTkfzwmnSfuW3etD1GAYqcEuDllFXXnA/9g0UDMSuIIerBE9wiGaUuuMqZ?=
 =?us-ascii?Q?sYBDMKQaTKf8aaOp2ucM8/rHvtry3/kDCwHxt9f44cFVxaSHxtr0odUIA4LZ?=
 =?us-ascii?Q?PfTWZNkIfO95oEBMm+AOgErwTQTV5pyj3rR+1QxQtgT57GYWFyNaZt27n2lt?=
 =?us-ascii?Q?EINmclJp5eC/nYclWtGqCN55tnqVH2pXTZxvPWiXKhwezsjCXf/6ra4WhzBB?=
 =?us-ascii?Q?qZY+vToqFoTgn+8+dycbhZ5boMxXh1rTktTXSt3QcBBodqj3q5+GxMPs7R4J?=
 =?us-ascii?Q?MHbMvh8ieDBS7p9JI/7ZWsS5r56kQSIDAGhnMLAAMk7kvWHBeerZViSI4wS8?=
 =?us-ascii?Q?Z1jLw3BvISYEiDWfFbRthDFhQ5QN4ssm1j9hZdSv6LI97NaxkxkI9/h6nGr6?=
 =?us-ascii?Q?ANXJFJ/HOlviKCiJ7OM9DLfLwStLJiPgZUz9KoYcsatwB/OkFBmCA5ZzmujP?=
 =?us-ascii?Q?tlgxylZgBEOoxfJgb5urv9fXfU1cT3CcvAv20Q527lQBkyLDOK5VKVrbEp4J?=
 =?us-ascii?Q?cJCqODgSG7rGUSzRJGSOSqWTN2FChOjeNSlc+P3LmZ9u6yqmV99lMLMbTjoW?=
 =?us-ascii?Q?60Q3gLi4qSI+QEox9CtvTaJA4MCHvR2AOiuQXFhnk3U+WYfqwK8TuXOb6coR?=
 =?us-ascii?Q?9qAdeJkyFRGKXne1tIymUnYJ0p/e+T2nC4De9SfMU5OpEGvRRewZV20AJ4QY?=
 =?us-ascii?Q?0rbsYDuh7Zus8b6/VlU2DnqpRUqeJvnaSb05SqrSnUNr6xyKcz3dskkv35Hz?=
 =?us-ascii?Q?NgMUuoBVopVCAArJdSEFY5JhHamJJmWaD+qtf0lwRbbp/iwBTI6iuV7iFIXv?=
 =?us-ascii?Q?9mQ/N/cdSZ/DnIbCfIRPJkkpgxsJ0/b+czuCT1MPyYUEAhDHSB85a3gNSxnk?=
 =?us-ascii?Q?VYarB+hZpfGGA0gAiKyNKKtaHQVWPjU/PO0/SkQu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba97cd80-05be-4978-b2da-08dd1d6c5933
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 00:55:35.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er9plMKG9iEftr4CLVT4FBUcI9i6TH1n/msEMdndTNjEfQxJ80tMAImKDiHGJaG85PeZ46FAcvy+rSUrEMa6Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786

On Sat, Dec 14, 2024 at 04:22:58PM +0100, David Hildenbrand wrote:
> On 14.12.24 02:39, Dan Williams wrote:
> > [ add akpm and sfr for next steps ]
> > 
> > Alistair Popple wrote:
> > > Main updates since v2:
> > > 
> > >   - Rename the DAX specific dax_insert_XXX functions to vmf_insert_XXX
> > >     and have them pass the vmf struct.
> > > 
> > >   - Seperate out the device DAX changes.
> > > 
> > >   - Restore the page share mapping counting and associated warnings.
> > > 
> > >   - Rework truncate to require file-systems to have previously called
> > >     dax_break_layout() to remove the address space mapping for a
> > >     page. This found several bugs which are fixed by the first half of
> > >     the series. The motivation for this was initially to allow the FS
> > >     DAX page-cache mappings to hold a reference on the page.
> > > 
> > >     However that turned out to be a dead-end (see the comments on patch
> > >     21), but it found several bugs and I think overall it is an
> > >     improvement so I have left it here.
> > > 
> > > Device and FS DAX pages have always maintained their own page
> > > reference counts without following the normal rules for page reference
> > > counting. In particular pages are considered free when the refcount
> > > hits one rather than zero and refcounts are not added when mapping the
> > > page.
> > > 
> > > Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
> > > mechanism for allowing GUP to hold references on the page (see
> > > get_dev_pagemap). However there doesn't seem to be any reason why FS
> > > DAX pages need their own reference counting scheme.
> > > 
> > > By treating the refcounts on these pages the same way as normal pages
> > > we can remove a lot of special checks. In particular pXd_trans_huge()
> > > becomes the same as pXd_leaf(), although I haven't made that change
> > > here. It also frees up a valuable SW define PTE bit on architectures
> > > that have devmap PTE bits defined.
> > > 
> > > It also almost certainly allows further clean-up of the devmap managed
> > > functions, but I have left that as a future improvment. It also
> > > enables support for compound ZONE_DEVICE pages which is one of my
> > > primary motivators for doing this work.
> > 
> > So this is feeling ready for -next exposure, and ideally merged for v6.14. I
> > see the comments from John and Bjorn and that you were going to respin for
> > that, but if it's just those details things they can probably be handled
> > incrementally.
> > 
> > Alistair, are you ready for this to hit -next?

Yeah, I'm pretty happy with the series now. It "feels" right.

There's a couple of dumb build bot errors, so I was going to respin to fix
those as well. I got caught up with a few other things so was just letting this
sit awaiting feedback, but I should be able to post a respin early this week.

> > As for which tree...
> > 
> > Andrew, we could take this through -mm, but my first instinct would be to try
> > to take it through nvdimm.git mainly to offload any conflict wrangling work and
> > small fixups which are likely to be an ongoing trickle.
> > 
> > However, I am not going to put up much of a fight if others prefer this go
> > through -mm.
> > 
> > Thoughts?
> 
> I'm in the process of preparing v2 of [1] that will result in conflicts with
> this series in the rmap code (in particular [PATCH v3 14/25] huge_memory:
> Allow mappings of PUD sized pages).
> 
> I'll be away for 2 weeks over Christmas, but I assume I'll manage to post v2
> shortly.
> 
> Which reminds me that I still have to take a closer look at some things in
> this series :) Especially also #14 regarding accounting.
> 
> I wonder if we could split out the rmap changes in #14, and have that patch
> simply in two trees? No idea.

I could split out the first half (patches 1 - 8) into a series to go via
nvdimm.git, because they are actually standalone clean ups that I think are
worthwhile anyway.

The remainder are more -mm focussed. However they do depend on the fs/dax
cleanups in the first half so the trick would be making sure Andrew only takes
them if the nvdimm.git changes have made it into -next. I'm happy with either
approach, so let me know if I should split the series or not.

 - Alistair

> [1]
> https://lore.kernel.org/all/20240829165627.2256514-1-david@redhat.com/T/#u
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

