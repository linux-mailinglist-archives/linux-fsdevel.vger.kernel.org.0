Return-Path: <linux-fsdevel+bounces-37584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DF49F4244
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B1F1888F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF51DE3D9;
	Tue, 17 Dec 2024 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLSmlK/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081F1DE2B1;
	Tue, 17 Dec 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412471; cv=fail; b=RHO2x7R1hFPbsOXtzjRjYcz9m838mlVSSRcak3QdBsQMwS1/TD1DLzIYwuPSd7urlE+SGXHLDSfqrHejnlWi38w2cFhWpYrsNhw3f7tUkzblf81hY9lLinMLs0je5+r6HCNoVQY1NlraoLIwk8vOYTmBVN0PliORNwHGgo51Rj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412471; c=relaxed/simple;
	bh=/9nCN1XQPfgyA5VlyoRarJnrFqQw20cJtW1L8P7Lq0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YiyoWWK8TZdMNDFXW2fHKcpDxsv1qt72HK2mhIZU7gysLi7rHZBJH3hcDt+WXJgJJop4UGb+lbE2tw/fJqLlV4+sAEoTQ1I1EdheZ1HebH7WIwhzoPA8z6VIlSotNF29UATTkUP0oiP0/+RUSq9Z5tp9UfQMX21/9kzIcZz6hb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LLSmlK/L; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/O4KcL0S2UBwEvonloLZ0oqEvS4VcJEEi5ZaCm+pibJaOF4EumsRJpI/JhPllMLdGrw6Qod4g99nwjzf95TqhuEIM/Mo+n8pLfn5xNqOacucjjpRajJOQCV8M/3od6uRHJwtwxPPSrn0n/xgALMHQD38L53fRwTNi2B1kxQr1ZhlpSPcxJFbVrx2BHIjEDoreRmHpryKoH2Ui8Ca1fjdMelgWJ97rzWtVKRERt2G+e8XyW8FO4PiWosDnSjRy7Ndllo+tKkLTeJopAH9yz/te4yGecUAsfzP0uryQ67+pRD1N8+qbTgNoGk4MJHVFn7CA2SXMD0loaoQ00FK33KLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaSh+cBcmD4fAyVgZBd8ptmSZOPC9ILTc9cpqUKZh8s=;
 b=YMNwrH1EXtt9QQDyu+i6BS7A+r5bX+0BIQAXem1wfrogVBzKR+W0B3PUFjKS2IJM0dR0UR84gRfHf7CxXrREnRk3E7wqfGYxtU0LOnRBUXhvn9hz3t2J3d4t8yqeZ4QzOzJudcX2HqcLcfs1e0UYe2ZwERg/p/ChwJsdNqosmrRrTIsXK6tUide4oKnsL+6JMvDuRpQl3kRxVTMUKfjxx+GmTPCwE1hDWoD/i37z8iVVLzw5yMSTyhPmpfbpnyIrG81HYApr0/Su27i84thg/t/Gxq4Udg8o2cgoQZGf4qXObeitmwAhrB0hj6h5QXM2ijAfQoTLsbBEzbsMkR3P7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaSh+cBcmD4fAyVgZBd8ptmSZOPC9ILTc9cpqUKZh8s=;
 b=LLSmlK/LjITICPJUbSqXY1OE7ZL9gTscmjMIT0yNzLHeXIXpV71erhtBdjIdEOGZhmwCoB4U12NoeZPub685r1AEVpe6W5FzsRKR7HU+/0SXko6Dn+e9vXkoe0JwL9S36J//2PUMDBot0XyfOZITQot1Ph8Lcuabqr3wfFG7ewbJ2a9F7qj4EfGHrVIS9VcZ+mMP5IlluYCTrUcj9mg2bhrWz7wRACrn4xozmeZb9qXCoE33PFwR2/QuOJXzDMqa3O1GQrGBElzJQ9WVFfP2CUbUeawPXFjq7xS/oarq8FrLZsj8CoARMk/nCjuQYBbr5Rvf20yRCl3A83WQ5+boGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:14:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:14:27 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com
Subject: [PATCH v4 10/25] mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
Date: Tue, 17 Dec 2024 16:12:53 +1100
Message-ID: <aaa23e6f315a2d9b30a422c3769100cdfa42e85a.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0005.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3fad04-c653-4db0-dc1a-08dd1e59add1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZmYDa4cXf0EXnax6NFfPTUNdIDNBChsELUiVcoBHSWM1WO8iTOIbw9dbp37?=
 =?us-ascii?Q?yGkBtDPV5Ubt31WqJn7Sfm0pTqrr1qL+22C2qMxENxELhiDIT8SDYN03U1Lh?=
 =?us-ascii?Q?u4ox6o3txGzf/LjyU+0S6KgXxst3wonMl9H8a3RVmSNRzplStWP/SvLH6hGP?=
 =?us-ascii?Q?4Hi/y6tpgdqhlhJCFXAcaI/Oko5H/pLS5LniEEwe32dJq5YIOot/GSPRnh8E?=
 =?us-ascii?Q?Mrk6uTSHMZC00uaUSe6JyPNFbIWgcIF6NNjqLcnBzpkFfCxZNTco5iaa2euX?=
 =?us-ascii?Q?43fhzjqp4F1PyqeuW6fRTxHpDv+vS9cTdKsI4rvolp+Z7cT0kUxO3RnI6wJH?=
 =?us-ascii?Q?Dvrkfr5JT8HTUxQSKGntb32sI814WVI2kRDnh1oEs10k0OM2wjpiTxjGuQPB?=
 =?us-ascii?Q?lpwtbWu75pKo8Auwe+ihSHoJ+GGorC/o+qa0WeqstxO1dPjITmgq3B7DlAK8?=
 =?us-ascii?Q?AhNctr2XJH9T9iYzxT6srYy819BceDnRC1ZSz8jCi3Fq8Si8SRjW7M3R6gt2?=
 =?us-ascii?Q?UuScuccGlFGtBcpJJw+wAN9Q27e9HQk5TqfO09lFSLDHGJ0hYhcc+CnDzHXj?=
 =?us-ascii?Q?kdx7TPHY8qM84mbU4qyCVmIq8EuAmQjpo0lU3hm3HbUlHrAzyG29hMh9pTIp?=
 =?us-ascii?Q?rPHizWMj7OJYIrg3re9Bij5xmqlSpz2KsUkCt/ZDKrSLK0F+0ygrf4RFyje8?=
 =?us-ascii?Q?I5RCeQ00c8SJZOZopJGD5S2wTWWUWT4Rmzym0zAr83rKwHmu/4L6AwdNhPeW?=
 =?us-ascii?Q?2UrFw/dT9NJRjE41sYnE5QlAScAlgD30e2Ja1KEzuIGvA8JSAqPJWrCMQTtH?=
 =?us-ascii?Q?ymIlzorwEh4cIZy92K1xHE7HJGpGmQeLlIkB0mddg6/TYdeo3sbYFzKbtln4?=
 =?us-ascii?Q?EWk5Fv02Aaz58duxJxoJkb+W8S41S8YACiiY+uMa0f+uyo9YuFkCjj/6Iy3r?=
 =?us-ascii?Q?p1bQmZ4v18buN2dtmDm0BEMqwwnr1Du717lS0yyHFQ7SJGQpmektlt3xvdY2?=
 =?us-ascii?Q?XOwwXhgW5tKykj+kMy2YKdPRuWHIxfQJh6n6oI2OoB6k8Ejhopt6imyIHzdB?=
 =?us-ascii?Q?anj6diRa6PxP+7vEdCebGw2VgVk3DDww3sDvd9P+KewijuaBoizpNDrrbjsi?=
 =?us-ascii?Q?a/LQI046CnYezRuFW6urYu6NSdb8PLLd7Il/DzfhmE2jpFHWT1p7fztdBlmS?=
 =?us-ascii?Q?2DlDdOf8K9fdMX4wnyVEYfctbWudBDB23mDOQL+NBlHCrZlb5YhR5M/s7n+u?=
 =?us-ascii?Q?HUiJTXuz722fugPK8oz07Jvntbt8lWbjsix1Vr/CjUfmpXImLPm9BRPMiuNF?=
 =?us-ascii?Q?w7gN8FeBlh056TfMhpox6jlGPxlL2wXqEZmSz7zupJ4u5kctR332wQVHZWkH?=
 =?us-ascii?Q?LGMcqvk/4hiS8FldmUJyU0Jfa7sW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fnxc5f9Cjr5mEiK0BtcOITZuMYawuMOYmGZZRMUoiwXolXLT4BrVkyNlkAue?=
 =?us-ascii?Q?Qbwyw7dR0hprz5kXX6XVpLf8optoZeQftO5nh8Xw03KpDfD/dHTg/+gC0SzK?=
 =?us-ascii?Q?mzPgReZCnf57bcri91qpig0yi6lbsUb8LF0FgCQkZqjcfRYi3n1MRE6piBtW?=
 =?us-ascii?Q?18MBaxtjU4ihBtdy31s/MKUhgx5FTvjXw7x4w3ZUyMtmv3pZFPKsa0hACiUQ?=
 =?us-ascii?Q?FQyteKPOSOo/kdJVC4mhX2ogP0CzbnIYPySCiV9Afz+q4kQWMsSMZEOCoSI1?=
 =?us-ascii?Q?brqTk/v8VZNGmRvYuViNFF+Ksl0UkA+t5ZU+zjfasgwfKB7eLiZfygkXRqIK?=
 =?us-ascii?Q?2JwRNaNyjpT+49GTP/HC19ILUODR+TI+Qw6yqyl4FOPJjuEr7SRtEh00QsY0?=
 =?us-ascii?Q?kNB8QATvfpz7vYobiQiQsbJxnPigZjr8QQW42WIqJKA/F0tByNHtAXG9rG/2?=
 =?us-ascii?Q?HAQvWK/yldckhgACJohO6y1wOs5/CCfCKbx2JyHEhT225sKTFSFuTRviml2z?=
 =?us-ascii?Q?1MSraLdHmnKwHy3tEYNNFBWyzalkktsuN0CYTq7sya/u9U9Hd7Upp+smBMpl?=
 =?us-ascii?Q?W0EdRQX1GIWvHdiE/NTefJakqdmfqT/qEIJ7AabAGDAau+/dDiUAlpMF9NDr?=
 =?us-ascii?Q?q5M4zeL2CAZD3/HMCnMFfiEeQCMB2IEYxT6cFcksyU4/tBVaHLDbu8EwA5+G?=
 =?us-ascii?Q?8IzFsSfLCenqYOveIuf9//1KdyW3p1m1lF30IqXJ896e1vYdNFcurMAaow3V?=
 =?us-ascii?Q?IuArJd4pr98OS/WB3OLue44lLQDAatm0NRciynofjmRIHRbwPTKNGslKnX5P?=
 =?us-ascii?Q?iRrc7MKkOJMhTRx2TCPHZB58ltnmiLVgmd/BlQ8T4yr5VZvX++i0woODtUd6?=
 =?us-ascii?Q?cNJDwS2eo2CJRE8Tm4VjWJ9yfeE8sPYrjlILvj4l/ORYNThhQowDehZEE16F?=
 =?us-ascii?Q?Ep/TOYD/1l9aUnS8gGYV8QVjUo9gu7nJ27CvCH3tytgLWCCiHpDt3heJ54hX?=
 =?us-ascii?Q?NrQYylj3U4QmY1k8pDxNWiLIjV9gSE2q9Ds4o66mI/QnKP9kYLnywULuWIV3?=
 =?us-ascii?Q?n4smxUsOLkHZHMa0/draGFzywU4TXokfW26YPH67XuOF92tdBnOjB/bWWtOU?=
 =?us-ascii?Q?GyXRliptu/SfWpG3jLV9srmys5xQLtMs9y/6XCS+gtBrAs/DvfkJ4IDfJ7sN?=
 =?us-ascii?Q?P7JKbiyGhmwOyR8k1MV86UVt94vdWdX04ZmXdhpTD60iZrpPt/THLwg34VMa?=
 =?us-ascii?Q?N1w3E6VxpzBjCJRP1sF+yWRrD2cd+d7qppfxeByKWJ6/6SeKkz/05s9pVYrX?=
 =?us-ascii?Q?w+FYHHDleYJk4eM/WvgQAXzPHOhfwgs/nyR8RJJAOMNzF5Gb6J+Og2gDi9EO?=
 =?us-ascii?Q?IR9exLsXhPlnReV01n5K2Rc/GxDchVPMDRPycbc4rHcmLRM9RRxVdy1yAs2J?=
 =?us-ascii?Q?nbLemLyNIVrgIkX9HmUVQtHhMbun+glmpSnxEkkwAhnNEMNEuhYj3EcqyxQB?=
 =?us-ascii?Q?RtimW+9IVVa5DPn/0BL34iANqgp5qvyqg7RurTDiIyrKqnYzd1nPV6OOa6cu?=
 =?us-ascii?Q?mXuNLwzOhiRvg1yyyE45JsNxo7zYecQLHvixjS1a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3fad04-c653-4db0-dc1a-08dd1e59add1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:14:27.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7IU1rlWvaFoKdupaHWizYoZo6EMMKaxzBW2umaJWGpoJPYPbVha0pm/OWAGAFymJZy1Rzn7jGIn0FCzYu2i8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

Currently ZONE_DEVICE page reference counts are initialised by core
memory management code in __init_zone_device_page() as part of the
memremap() call which driver modules make to obtain ZONE_DEVICE
pages. This initialises page refcounts to 1 before returning them to
the driver.

This was presumably done because it drivers had a reference of sorts
on the page. It also ensured the page could always be mapped with
vm_insert_page() for example and would never get freed (ie. have a
zero refcount), freeing drivers of manipulating page reference counts.

However it complicates figuring out whether or not a page is free from
the mm perspective because it is no longer possible to just look at
the refcount. Instead the page type must be known and if GUP is used a
secondary pgmap reference is also sometimes needed.

To simplify this it is desirable to remove the page reference count
for the driver, so core mm can just use the refcount without having to
account for page type or do other types of tracking. This is possible
because drivers can always assume the page is valid as core kernel
will never offline or remove the struct page.

This means it is now up to drivers to initialise the page refcount as
required. P2PDMA uses vm_insert_page() to map the page, and that
requires a non-zero reference count when initialising the page so set
that when the page is first mapped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v2:

 - Initialise the page refcount for all pages covered by the kaddr
---
 drivers/pci/p2pdma.c | 13 +++++++++++--
 mm/memremap.c        | 17 +++++++++++++----
 mm/mm_init.c         | 22 ++++++++++++++++++----
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0cb7e0a..04773a8 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -140,13 +140,22 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	rcu_read_unlock();
 
 	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
-		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
+		struct page *page = virt_to_page(kaddr);
+
+		/*
+		 * Initialise the refcount for the freshly allocated page. As
+		 * we have just allocated the page no one else should be
+		 * using it.
+		 */
+		VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
+		set_page_count(page, 1);
+		ret = vm_insert_page(vma, vaddr, page);
 		if (ret) {
 			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
 			return ret;
 		}
 		percpu_ref_get(ref);
-		put_page(virt_to_page(kaddr));
+		put_page(page);
 		kaddr += PAGE_SIZE;
 		len -= PAGE_SIZE;
 	}
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547..07bbe0e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -488,15 +488,24 @@ void free_zone_device_folio(struct folio *folio)
 	folio->mapping = NULL;
 	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
 
-	if (folio->page.pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    folio->page.pgmap->type != MEMORY_DEVICE_COHERENT)
+	switch (folio->page.pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
 		folio_set_count(folio, 1);
-	else
-		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		break;
+	}
 }
 
 void zone_device_page_init(struct page *page)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 24b68b4..f021e63 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1017,12 +1017,26 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages are released directly to the driver page allocator
-	 * which will set the page count to 1 when allocating the page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
+	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
+	 * allocator which will set the page count to 1 when allocating the
+	 * page.
+	 *
+	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
+	 * their refcount reset to one whenever they are freed (ie. after
+	 * their refcount drops to 0).
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
+		break;
+	}
 }
 
 /*
-- 
git-series 0.9.1

