Return-Path: <linux-fsdevel+bounces-21737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92917909523
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 03:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172D9284CA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B34C97;
	Sat, 15 Jun 2024 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rgiqf7Tj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C47173;
	Sat, 15 Jun 2024 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718413441; cv=fail; b=d/41BEFkT97LXA615s0ZXs3NtV3VzzflZ0JvECTSIji/KIl3sGzwm7fYaTo1SSjVACMTRMXEgUczYqPO+acOpHN3GGsfrvUHOHtavLMc86VPznHPiMcLJlk0VeO7efzoXqlDs2m3OqAGWwd3UbMJFL6uYV/509wXB6ppvxiIRO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718413441; c=relaxed/simple;
	bh=Md4OuCGfV1aAK7iAEbju5/Y6nujHjyTJuuDiPquQz5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kw2Q9OfjPcxVqjoHgnzEzatsXyS+bibXfmtlXFLvLDymFKD+Ztx+lwszEDpyJM9y1JGC8Y95mqJKbB8Cs0biceZCVwWmPNJ+ca6oQdhsfSKcEO0VvezkA1IpgRoX3SZmc5FZoPteRIP2+Mfbekq8on4xiwd5pXl4X4oBzfUJlH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rgiqf7Tj; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO+WWhY9ZeazbDTejLCWaem8zcbBQPb/X8COL6yuGxQ/uFIBd7+fNEbx3WdaQMKT3P3EWknZb4zUlChYkn1t5/eJrj/IJ7Mq+Bdu73a3I0QayPbSDyKK2r9FhCUrAevBGNNGVGn4DElM58G8TU0P4afnzPwWDhElcBexiXc8YnjtRTfZxaQTYZITN+/iY02ym60MgAlO5jeDzm6YCbm37VTLKDqtHvAZiGOq3v+e6OeCv7up3VFos8F7vy1YBlH+P0/So1cY5eJUb0meCBS99SXGEq3sZQN35QAIsTPS92UiEma5sQWZta2xS7Mne61yWplWcL+X/fJpxh2BATqe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wQnPu6jsJn/7S2p4Y+wzsRPXeOmTVW9JBsX0vFSDIs=;
 b=P3090PZs5Q/O0HgBr1+fPchyUwo4FQG5alLuvPogfllXJ1dPZU+x3OZFmebaI1PBdo4keFGycG9WQ+UbS3m7C7/bMARILClrTscaUlo8PIBOH+2oI56k62TCXc3ff//DBHbfrCtAqW1n8dgHq/gnGS+UsG/zyHKGPmQULFgUQqselPtKQJf81AVeyX/OsHGcNYh/ifmT8+V1H/VXWQkkmAx62CI+F6Io7dH40S5PnNvgEYh/ST1Q311vagfdq//WkbfWP+VdyjIAymy0Dvoqj1CeX/9Ic1qDIXL8UUIu8QdHB+LPAyu18OiAtcn64M5u5WS3m3CdGAdWyzbLWDmmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wQnPu6jsJn/7S2p4Y+wzsRPXeOmTVW9JBsX0vFSDIs=;
 b=Rgiqf7TjZc4Lpac1yQc7gaPfTDJAO5xNx6WA80R/1cY529vyIYAEYrdLOM3FcYQAdIFsg+1pxDVUzbTjKJ9LCKWt293tydlq22Unpc8yD7L3CkMSNzUW7GdH1hM3a+EIohfDxfmG8z/C7BXNERYbP22iHTIBNWfUZj1Pksg5OgZcDOmgxW1GJc1X9ju708jdjwsQn67vMvH1SlBmsp4BncI92GWevRYiSHvb5qzS8YPkeoda8pVH7BJPToYvUEk4yCSIjz2hGQR28g9/+oK5yxGx/mKGKPNYFeeOWnjwuOSNNo2Uf0hSIvzNcGbEBNauCSx3LXvVJL+9GWaIHNHzOQ==
Received: from CH0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:610:e6::27)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Sat, 15 Jun
 2024 01:03:56 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::4d) by CH0PR03CA0292.outlook.office365.com
 (2603:10b6:610:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Sat, 15 Jun 2024 01:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 01:03:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 18:03:40 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 18:03:39 -0700
Message-ID: <79239550-dd6e-4738-acea-e7df50176487@nvidia.com>
Date: Fri, 14 Jun 2024 18:03:37 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>
CC: Gary Guo <gary@garyguo.net>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<llvm@lists.linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, "Alice
 Ryhl" <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, "Andrea
 Parri" <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David
 Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc
 Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>,
	"Joel Fernandes" <joel@joelfernandes.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	<kent.overstreet@gmail.com>, "Greg Kroah-Hartman"
	<gregkh@linuxfoundation.org>, <elver@google.com>, Mark Rutland
	<mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>,
	<torvalds@linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, Trevor Gross <tmgross@umich.edu>,
	<dakr@redhat.com>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo> <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: aa803fb8-5abd-441f-faa1-08dc8cd7082e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFhsZnkvRlJLT3ZxR2d2OVcwQXFpbGpiTmEydDQ3Mks4TTR6ZHNYQUhuZHdB?=
 =?utf-8?B?clhhUW53RzZjSmlUNURsZXdsRHN3ZXhRZC9UM09ld0xHWFBNQU4zUzJIeHpn?=
 =?utf-8?B?VlVKQjlwRGphcy9uV1o5b0tXN1QwTW14ZTNkUnUzd2ZkNm9IbkdQb3o0cnFm?=
 =?utf-8?B?a1kxbmV4T24xbHZ1RWZGR1ppVGRWZ01ZYkE1UWRsemFsNzlmLzdNSFJ0OCt0?=
 =?utf-8?B?ZHViT04yMFE5RWgyVm11WklEdGtzQis2SmVaTlJtVlFFWUdZS0FMYTk1LzZL?=
 =?utf-8?B?aHdMMnNUcjN1ODAyY2kyd2k5cnVYZ1I5aUpCWmQ1ajVMRnhBYVY1RStjQW40?=
 =?utf-8?B?cmJPbk4yQXFkYi9uZFNrTlJGT3lRRFc3U0UrUFlpVHY2ZlFkYlYwbWlzNzA2?=
 =?utf-8?B?OU9oTEVkQzE5TTA1ZjJhRmtKODBMK0FmOW9RVDVrWXlwZFJaQUhJbU1uNVVX?=
 =?utf-8?B?RkdXbkZ0NUQvSVh6R2FhcWdZeDloYzE5OFNpam1jdWpLMWs2b0tqTXlDZWhi?=
 =?utf-8?B?M2Y3bzJkd0t1R051NFYyT3dNYUZSOUNrL2xhUFZOUGZnTFNLenlrbEVRTUtG?=
 =?utf-8?B?UmdMQnl6YzZDUFgzd3JMVG0zK3RRcTAyNW02UkVLRjBxdGh1cUxkOFc4emJC?=
 =?utf-8?B?QzV4VGpHMDZ0ZDZoa3lxSWVkUEpyYnYzZnhyUFVERGFCNTNGSVJEQ3hTMWRi?=
 =?utf-8?B?OUQ5cDNBalY4UnFtQUlHQ3lHb0c0T0c1NkMrVVFKTzhFcjcwTVBCa0RDelBR?=
 =?utf-8?B?blN3ejVMd28zM1hsU3Q5ZGZrNEd0VXMxajdvQTZ0MlB0RGVqOTMvNm5ZbjZS?=
 =?utf-8?B?Smhac2tjVm5UWHB0aEtKaGt2cVhwblZ1eDNoNDRvcWVta01NRlpVZVVjZVRa?=
 =?utf-8?B?Zldud1dNVzRzVDdRTENTUlhFVkNRcGtLRFpBakVTWmY0bVY4V2t4WkNvMVRh?=
 =?utf-8?B?TjkxNmx5dk9uMEk2K2lyTlE1K3hqVktBK0QzVC9iUGo2VjlwKzdHZExOc1JK?=
 =?utf-8?B?OXZ4NHp6MHNMUEhXTFFNbkJFeEVWQ0FnbGduTlRJZU1sT05oMkhsVjQwaURu?=
 =?utf-8?B?MlNwcjcvUGY5NEFySmdwZE5ucFYwWjcxSS9vYzZGcElyK3JISUZMUGVqRGdy?=
 =?utf-8?B?bnhud1kyWldOWk1WNm5mdHN2L2dsM1B4MGR6Um1oQWhvM0NDT0d6ZXpRZ25C?=
 =?utf-8?B?SHJYMGVUWVVrcW5MemwyQWNzU3hISGt3VkFYazd5ckQ1NGVEcTdoa0tHMXQz?=
 =?utf-8?B?ZkRGYkltbVhhcHpDRjBHZTR4dXd2alVybnRtYXY5MXEyZStpZkVwMEpFUGZU?=
 =?utf-8?B?alZkOFFRcFJNRStTaE1ud0JvcjQxeUFjNXVYZU54OWdwWlhmbG1yZ2REQS9O?=
 =?utf-8?B?WVVScDVsa0lHREFwc05CUnR2Tk1vbGhEOU5zRGI0NmlNdFQ2c2ViYVJFSmJm?=
 =?utf-8?B?cXlrbWlNYTBkbkFFaGREb3ZZSkorZEFSdVRKSUlldzZrMnBRT0lsL01FM3lk?=
 =?utf-8?B?UWQ3WXhQMlh0Vm1jdS94amMrNnFNb0VnbmVoeXNjY3ZkNzczZER0S3NjSVNO?=
 =?utf-8?B?UTZYTmpZMWVRYkoyeTNtaDk0SURCc2FwTEZpTnA0RDNLa01odlQzYUxENGp0?=
 =?utf-8?B?RG9ibUdOQmF1Tjg2dVhLZnlhYzZVL2VuQlRJcmZqTmVzVWlKRDc0MURESlF1?=
 =?utf-8?B?UUgwRC9lTzR0dUtOVWl5Ry93N2FNUk9rYVhBZXIyVkViN1ZWWVFqMFgvTDNn?=
 =?utf-8?B?c0lzYXpCRTI1azhCZm1pOS96bk9GZDVBL2xkNnlVR3lNelNrd2RvUUNTR1J5?=
 =?utf-8?B?aXhmMzRVaUlIL2xSRnZGN0tUMThNeWZ0L1NjZTlTS1F6RE5pTHpZVUx6Yzdh?=
 =?utf-8?B?dnBOQzdubFFmSnc0WHVKbTRqeTNLSTVvSEVEMFVIRk4rRGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 01:03:56.1515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa803fb8-5abd-441f-faa1-08dc8cd7082e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

On 6/14/24 2:59 AM, Miguel Ojeda wrote:
> On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>
>> Does this make sense?
> 
> Implementation-wise, if you think it is simpler or more clear/elegant
> to have the extra lower level layer, then that sounds fine.
> 
> However, I was mainly talking about what we would eventually expose to
> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
> then we could make the lower layer private already.
> 
> We can defer that extra layer/work if needed even if we go for
> `Atomic<T>`, but it would be nice to understand if we have consensus
> for an eventual user-facing API, or if someone has any other opinion
> or concerns on one vs. the other.

Well, here's one:

The reason that we have things like atomic64_read() in the C code is
because C doesn't have generics.

In Rust, we should simply move directly to Atomic<T>, as there are,
after all, associated benefits. And it's very easy to see the connection
between the C types and the Atomic<T> types.


thanks,
-- 
John Hubbard
NVIDIA


