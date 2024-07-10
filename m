Return-Path: <linux-fsdevel+bounces-23485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6D292D3DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41F828A7FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FB91940B1;
	Wed, 10 Jul 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Slec6BHt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2068.outbound.protection.outlook.com [40.107.117.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608719345E;
	Wed, 10 Jul 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620619; cv=fail; b=J4g4I7D3NjYW9OIet39JGfERrlPnP5f0WdeQNKV2J3kgImxq2WvqUYkFG1gK1NUloHUey5uYjORAFrSCvL4gejXuSJZr38oJx1Vsa2IRq9sLFbMFMMTmfg59qHrxfniPIGNVtwRxyvZTj0bkttkWVw0hXXFYjWAbYjMXxJMdY/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620619; c=relaxed/simple;
	bh=q8Wo6KGynKUWZFfQDCK9cidIfGYsf6rBybJ0RDFCO8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJkrqltLJVdi4Omo9hJCnP1r5cJtVwK0g2Ufj2fR8KglWo9vRZOBVX6hBygSlL/7z6T39dCDFetwMzLv0EipQgwS8bNW4deQmYPEKVio6lq2Ntxe/OU88AYWYVnZtrJY/TN1zWhGpSqe265CzUTYN5f7JZAeVxtDBJgvc46zc/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Slec6BHt; arc=fail smtp.client-ip=40.107.117.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYuU/+Vr/j1FBoiakqKsyeoK/KlCf820pLltB2Wj1NlQXFe/DBIpRJ7Yxko5VMAG2Orui+hMgqVRcSeg92VGTRkpjrzSki4f7FNHf0uR+Or48+jZFRHFk2ajnoGe7gSpl8y/WtoGb0RFD5ShYhwRH9up72szwfdADbnxN8+KAvikGvuyED5VppGAZLMry8cYKmFIraire6kTzU/IokrHtrr94antfe2YIZI2vQjOH181p37a64MPMyJ5QOYmRCz6PWgzbvhcCsfYHsn8Fo5z6vyjELmGMNE6HR1CtL8/9brmGF0ABw1sBwkRfb2AiBDLTuk667XGmFnoCvAc9M3Zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGQLyyp4O5Uf6YpKS7Lwp4qMYi9ESWvBfGifXLA6dNc=;
 b=LKTfRrxJQ4BHyK0cSNGSw55ABvKRAcs6LSBkZ5zuB4gOSgkCJ80g4RE0wyw2JcrugKPPIzZ1eUHsd97x99T7NtHfs3hxPni8Wc+drgWCZHGOF7TmzMJXQ4xIZ1uSiGGEfToa8mvXi51nHDTqrf+P8nRo3rt2x1DKeb++E/+HwNOjLbza+6j4F2yOs9+oN6l8YN5qBQoIjXK+lTb3sztOPMrt1HATr/zdTGs/D7czLBeIa6I9Qzjo3MP2Yk5VQY/f+XH6u0Bo40gj8VYmEgrzKthPZUcEBORhMzrcZ6sZx2MbdE6kqRW31I9+GGgrL2vOgUwajxP6CSemRYPka1fpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGQLyyp4O5Uf6YpKS7Lwp4qMYi9ESWvBfGifXLA6dNc=;
 b=Slec6BHtOm8BvZyT4FtWypfXyaH5Gj+65WWNm0+BnWXsZdxtg/2BB4R7aDkMLi5UyDexgWhEUYR2DzglnxjqJIlZ+X6H41iGr8s/FCkhqZz2sjAfWc4oWMXZbeKK/tbOFe2YR8m1nBB2uX+kMKCs279rjwZrnvtlxrdOY9kVcexG5thhKCKehsPttSLxOpQej6kFRNaRxlXllxRPFD3vEhQhIpsGkfMnFDlLXGp8V9SKUN4JsjFH0QioCeZ+eXUobnNBd0nUzZzLEMUS4095I8Qkl+qGL7qIlhbD4RCeMY9gQArwkUjJBDt9hD+/hpjx1c2kPB7qOxiOKV/pcQa1Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB7077.apcprd06.prod.outlook.com (2603:1096:101:1f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 14:10:14 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 14:10:14 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Peter Xu <peterx@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH 1/2] mm: dmabuf_direct_io: Support direct_io for memory allocated by dmabuf
Date: Wed, 10 Jul 2024 22:09:43 +0800
Message-Id: <20240710140948.25870-2-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710140948.25870-1-liulei.rjpt@vivo.com>
References: <20240710140948.25870-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfefde5-2dad-47c5-0a0c-08dca0ea049d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/aGUDZfojbwWYKcNYHVDFmiCyKFIraR2sPvEsUh9bPqEMVkTm4NsMpRBgIH?=
 =?us-ascii?Q?FJgex0cMg/Wxu7n/zIw5B7kH2zn+ICj0vidb2crEgOjpFHaC+aMwcE9khh0i?=
 =?us-ascii?Q?eo3+fHQE7Nh0VbgGh4wOpvMtZ/FNj/thBep1lSOsl1mBiVfklxrFWNK53T0U?=
 =?us-ascii?Q?Q4FDmgc/pfEOD7yI9FN4aujyuh6jfH/KvNEEdNEk9KXxS7KLB7Tjq8w4FZQp?=
 =?us-ascii?Q?KxLpHWsSAlihziPJpSkAf9QpJswImGVKmD65q7/Mxn8ZdPSGjZhhY49Vpv7p?=
 =?us-ascii?Q?C3q5zsV8XyhnudLmL6Trbe0xIkmDtUXAiFpcreBGjEpPKIjZTFrIvPlD7M+j?=
 =?us-ascii?Q?4/yfVCRf7eRUTvduRfA2F0VmaXk2mJ2JHKvcMUBz9wRNnP91PvM+8zVNmRA0?=
 =?us-ascii?Q?WnQFEy/4uyqxfZ52GKcHuwAnsodcEWBUVKbNsWgfHxRowaN1hkDMHMSaJdwm?=
 =?us-ascii?Q?ZkjMG2bXvAMxEYdx5B5JydD/uufvOCnrCFGltUFHv7ftWb/Rs709CX3sWvuZ?=
 =?us-ascii?Q?lDDgJCEHL3bWs0C9Uggbj75cMhgDtprCB5NQDEXiNARcl1riCHZd+2BbKkq6?=
 =?us-ascii?Q?qEhEuVqmxpRPsuhvXdxO3og7KJCNYF4b06heKto1NQzffb2vT6qO48D/k/BC?=
 =?us-ascii?Q?O1x5X+z6GyqnmmGexd0CMBfggZHy7Z3kk9OgHawJdINSy5l/MR3ermHAw2Cg?=
 =?us-ascii?Q?cFnfixSx2/FGk53yZ9Exxtg7pCicSgyskddeCYzoUAA95dFeXgdoh2lDLaFf?=
 =?us-ascii?Q?eYFvagTJ8mSLp46JPGZx0JFAgexWhikL0nxrqJYZUEhtpQUbDYnNc7yhQyzS?=
 =?us-ascii?Q?f1nXRh+BqXPZ0jQT4bWwHwg+KJG7dyybirvthLC/qNbyo6vAelTIpIGztCnF?=
 =?us-ascii?Q?1O62R9Hhjrn2vZB2+LbWp9QhySM7ihcsGBWiTMvE+9TBc7W194Ff/oEh8zDz?=
 =?us-ascii?Q?b78//S34TvgpI8tyTw1RbToRhi/hTCOa/Uz/hoWQmruW0OhLixvOH/8PMy9I?=
 =?us-ascii?Q?q92qLL08FZ0YIi+Kr6TvpbCFS61ieJEmsWUR5DytFGniOIJcXPfD0m6EGx+r?=
 =?us-ascii?Q?34jhLElbHmDoZOhBD0dPFj0r6PbV64p4LqCa2+3eldziTYcGpu1Vk+WcCssN?=
 =?us-ascii?Q?RnGJxHYlYUfx7PtKR0vZM/38xGhKRmnVsL3Tk3kxwfK4jgHdhEbFV7iCVE2A?=
 =?us-ascii?Q?riEeP9zhJmpTc7al7vHyj3KdqZppvQfs0aqH61IhA3PgihCO3s0LmRCLa2Cz?=
 =?us-ascii?Q?saV/tNwIUebXDdprCpnt/VgBgrp29JAdWZFD565IlaXfH8QSxL0sY6cY6M/n?=
 =?us-ascii?Q?0bPMFiQSYViigNyQyv+WBQIKZM9CtSpguseQCApZaqJVsexVICWLOLsaIQ0P?=
 =?us-ascii?Q?A3dt3WwMiVhqeUH2cMBbIXZkvd2xz9jXNs3aVEkJUol8S6MYptV4ompIz7JW?=
 =?us-ascii?Q?r0bRXivU3hg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqdvLa6Suw/HRehljZh1WxQ4ZNEJp6x5N7gjltMqknWku/y/ggrBocwzW++O?=
 =?us-ascii?Q?7297z7sXDkQpY9xP3aApFOKP2qARr60Zp07VkmZqhEGGP8GAv557mLw3fX8e?=
 =?us-ascii?Q?oxNSAtnhj2L2gvC/uc/xxAS4ZvitCWI/xo+UjUOhdMc1jookolYN3zuw3kgy?=
 =?us-ascii?Q?98AejJn/vh1hk0z/tYH3oIKTwxXbZ9mH0+vMd/hSSgqdUYvNbHtUELbGS4B5?=
 =?us-ascii?Q?qaMRIx2H3lqSCWvIoygzv06+sm27+37OMOJfcfSS1msFcXdTPgwYDMp0Qc75?=
 =?us-ascii?Q?3vZSWrdGT1Fgj1+d7vZY9vGtjl0aFrxCNJNw8FX/APDSSgRowldg4frzPsUu?=
 =?us-ascii?Q?5QwWnMQFyQ4jx8PdcJdK3tlTbW6a2oqm3ielGuuGb/KoUl2gYbmxggX6D6zm?=
 =?us-ascii?Q?6NPjuHBHlKHTyYEKyooH3zoEQzlfYeuZoODMeeX1McS4U6C/acJkHC9PkoAi?=
 =?us-ascii?Q?ewCocecMQr/njHlZwXH/GnWfiJctIXNQOdNppeUwsFUef77mtTH2tDd6mIVc?=
 =?us-ascii?Q?rikg2/1taWh7Sd/rQf5ykZUFtvLtIGmrK0O3LD873kYFf9jznuRuOGs2jhRF?=
 =?us-ascii?Q?9caG/hZl/mCJvwOKsbCQP8cacr94oC30i+rtS5wUgts4lDradb5w/BLOxFLf?=
 =?us-ascii?Q?CmUyGVW5crZ0mWoJQS7eMOqAQgS6xV/kMLJuAuOpqk6wkXf1UfCVRIL0hPM1?=
 =?us-ascii?Q?mNkfPsHpLaY3KgTN3m0ctQI9q1c76krVuaYv8Ti9+mCsQCAY0gQQRoS/trQR?=
 =?us-ascii?Q?/TXbvqEyM3pmK5M56iqu1mZjlDIZVILK58rARQbbmtgBEbSJ5S/jRm96W9e6?=
 =?us-ascii?Q?0yJAE6n4QnWxqR8iFoJJ5y1wCbiyunZg5zBYJiE18al1OEfXY1MezeEXXsM1?=
 =?us-ascii?Q?jOtLo/UWBMlVqcPtEbuldE6+PEATXxhEd+mJEyP7vqtnx01Wm+IVvzIW+34Q?=
 =?us-ascii?Q?vk4IR0WS8lIvqdzbqs1zfYWY19DxJmVA4kG97fYv75hZq1VCv5I+MN68MY3M?=
 =?us-ascii?Q?gLnjdEKtTX66lRjb8HtxslnI9crBnH6qKZ8xsKpzeaA2SO4+KOUvDqFFDCjP?=
 =?us-ascii?Q?ybvEgOKqK5jQNUTVCYxRRtBs0Q8XT8j/u2V/hABNB+ysbktRcX6+fGHVSx2o?=
 =?us-ascii?Q?BK/CmsxY3Ituv4Sv79LLREPvxQMbhlClgjzyR4P6N7+VXzf4ZHr5DBwoLbXo?=
 =?us-ascii?Q?NalHcm6qcWBF41ALKBic/gLrPZF0WH3MlblzoRmbisk/d9gHCQ7U9S2xxy2z?=
 =?us-ascii?Q?3sRVsw4edD5J/wwoLTShXVbl2nIFG1IpIDkGltyIzMrsKPGZ9I8dJmaqjtrF?=
 =?us-ascii?Q?WxgVrZF2aqVLMRLA76KP5N8CnYihPuj2ALx3NJquaJjrBE9TuDJoSU2XXRYf?=
 =?us-ascii?Q?Zj5IBVV87i+APu/Lzat06mX7SuvFk+KiMXGmAY4MUOG/rZhLwyARmc+3z//2?=
 =?us-ascii?Q?fiTLHc0t0rG0IqRXhEf28Rk87YU7w6QYo0h8+gmbLk7F2ZtGWRnHf4hYbCHv?=
 =?us-ascii?Q?hAGMtpmLmy1S5+Q9RT8ntuYHQt4+7MHrtOVQfSh33ItJC3pTJ4co89ZfczHF?=
 =?us-ascii?Q?XNH8aRZjlNsX1xgEz6ksuBy0ey8sB9QSyhFep90G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfefde5-2dad-47c5-0a0c-08dca0ea049d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:10:14.1583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGL90Q66LYoNFkc0DM+n5/187aGLq51wvJsu2b4Za5/kfeFoyTt8x30U4YS6JqGlJ9jkH2xpfpwfxgExyoxFUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7077

1.Effects and reasons for lack of support:

Currently, memory allocated by dmabuf cannot be read from files using
direct_io. With the increasing use of AI models in mobile applications,
there is a growing need to load large model files occupying up to 3-4GB
into mobile memory. Presently, the only way to read is through
buffer_io, which limits performance. In low memory scenarios on 12GB RAM
smartphones, buffer_io requires additional memory, leading to a 3-4
times degradation in read performance with significant fluctuations.

The reason for the lack of support for direct_io reading is that the
current system establishes mappings for memory allocated by dmabuf using
remap_pfn_range, which includes the VM_PFN_MAP flag. When attempting
direct_io reads, the get_user_page process intercepts the VM_PFN_MAP
flag, preventing the page from being returned and resulting in read
failures.

2.Proposed solution:
  (1) Establish mmap mappings for memory allocated by dmabuf using the
vm_insert_page method to support direct_io read and write.

3.Advantages and benefits:
  (1) Faster and more stable reading speed.
  (2) Reduced pagecache memory usage.
  (3) Reduction in CPU data copying and unnecessary power consumption.

4.In a clean and stressapptest(a 16GB memory phone consumed 4GB of
  memory). A comparison of the time taken to read a 3.2GB large AI model
file using buffer_io and direct_io.

Read 3.21G AI large model file on mobilephone
Memstress  Rounds    DIO-Time/ms   BIO-Time/ms
             01        1432          2034
Clean        02        1406          2225
             03        1476          2097
           average     1438          2118
Memstress  Rounds    DIO-Time/ms   BIO-Time/ms
             01        1585          4821
Eat 4GB      02        1560          4957
             03        1519          4936
           average     1554          4905

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/dma-buf/heaps/system_heap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 9076d47ed2ef..87547791f9e1 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -203,8 +203,7 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
 		struct page *page = sg_page_iter_page(&piter);
 
-		ret = remap_pfn_range(vma, addr, page_to_pfn(page), PAGE_SIZE,
-				      vma->vm_page_prot);
+		ret = vm_insert_page(vma, addr, page);
 		if (ret)
 			return ret;
 		addr += PAGE_SIZE;
-- 
2.34.1


