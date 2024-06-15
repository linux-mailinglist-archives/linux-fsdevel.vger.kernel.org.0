Return-Path: <linux-fsdevel+bounces-21739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7CD909535
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 03:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901111C21506
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 01:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C35256;
	Sat, 15 Jun 2024 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rVr2WWKJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62F646;
	Sat, 15 Jun 2024 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718414906; cv=fail; b=KAl2sKYyehg10i5EtCLz5tqzf407MnJMWuW5mv4s+XBRKkNP5qWeuu8Yk57a83tRGfVKLK4BArtC7xF9fh3C4FGJ5nE7uaTwxdFcI9yHKiri+15CF3BeEykQL/n+kLcD0MJqNr4EnHFLQbdFPz70hFhe6m6fj8LELDevSOBhkZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718414906; c=relaxed/simple;
	bh=NWW/aCaCWMWKQp1pLV4X8RbGYCw+aMO6gAIgyhDIyRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GQvWsnfVblJkwTla4YJ3rM5+WzdU3AyXIrR02s+PaT/fU1NjNEMQjT1lqn4/wnoKonWB+SjH0B8x9KlV+8MT6Z7jTp07pKpe+AaBhDhQbCpzFtXpOTncCge6n7+veu/PV34HmRjgLGpAAdVbQCS5Pz8w027+oPVMJFRqt/oKbsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rVr2WWKJ; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqq9eeaOVSx6Bqd0n3SrMSIlVN0NFqENrXqyFNkseALYZOjsa07tX7oMYAf6VztLy/16mZY2MxFN6Oangp28GJJwnA5r7C40OJAiqFWW3Wp+k8qemdziVwpOXAjjyObFt1GX3KAV5Xmc4kEoFPgmknzU0XJRRMpRZes5eMqQXiMwA9f91grALBzJDFOI3O0ahfB15xOyLiXOTc4Pjl7b1Rs702KaxAxETtaLNnY+N+XQ76oBrKK7+TBmauYyRQMDk5daAaL0XWi04g3xBIEHh2yg2fL6m/lBXjGRQy6rvn6C+o9blMGkEVf/apXRxPFd6Mkjpj40U9qV1BIfAVTOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2/rjzXXkpwBA6c6BnfO8fV8uGpWRE1kPpeoc687ayQ=;
 b=gsEp55naFHZn0PdmAmJdZlJ/YiXpFv7EK4m25RB9zcKo8+xUC51/osobBOV9+4ZMRC7E3fPSB10xL/bMzBMS9uATzlsgFm7JSUV6+5iFl3S1QrnGUPS69aE/3EE11A5lTEw7+M3ZrRcqMAixuX/+RA5eFqs9ClKlasVd7Ow154SWX1CEmVIo3mnwwW1vz9ud+JFfI5nlArXU+dDhwcxs5iPTCHeWooMNCtq016Hmvx85MCEAJ6ptuO7wOQBPrz+7VgbhxXI5Gehnx8vz0KDpJQYdyVY8u21bHnfKpBMPs0mO7+w2B5OoH5LPS8qv15tEUHQvfq7p6NE/Uan0RUKrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2/rjzXXkpwBA6c6BnfO8fV8uGpWRE1kPpeoc687ayQ=;
 b=rVr2WWKJ1e7ogsI0y0+9VmEMkpJggje4zW571DonmrOvC3YBx8GSbJW38p6d4/A8n7m7j8IYur+NVYP/JlgmtvqHdkfW4yvrM1vzGyn4oqQtnWTgXz3RTH88Km0+ZiKShVSWDGkyGj0f47KYIXLAe4LBN4cmBf49sTZeCllHKG55bGm2Rwfjav9rxfZqgcWSvp4+T/bffiau1vbMf/wWuHm/5HJKDhDmKxYjmjZsurICHI0kVkvkdzLlCZfz0YEWUfUladXVGHoKPINOa03f6nkmJ/hipQ4EXRcaua8s6GLp+6/fb5UBBuhaFjI7EIe9jkBbtmnkRQGRpLIsQohM7w==
Received: from PH7P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::12)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Sat, 15 Jun 2024 01:28:16 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::f0) by PH7P221CA0029.outlook.office365.com
 (2603:10b6:510:32a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Sat, 15 Jun 2024 01:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 01:28:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 18:28:02 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 18:28:00 -0700
Message-ID: <c243bef3-e152-462f-be68-91dbf876092b@nvidia.com>
Date: Fri, 14 Jun 2024 18:28:00 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
To: Boqun Feng <boqun.feng@gmail.com>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo
	<gary@garyguo.net>, <rust-for-linux@vger.kernel.org>,
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
 <79239550-dd6e-4738-acea-e7df50176487@nvidia.com>
 <ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb900a9-a36c-451d-aa63-08dc8cda6e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU5hbDhvUEkwak1JS2hKSWxzNXdRVm9wa2tubzZ1djZ6VjIyZTBjL1ZZd2w2?=
 =?utf-8?B?bTNHZk5ENkpqa2wycElIVGhra2lkdzRmb2U2bk13T0E0eE5xMHRpRnFRSUhN?=
 =?utf-8?B?SnZmTVhXcFZkOS9XdGd2ajdrSkV0VTY5OUdKY1dKUFpRdEQzTWk3RlRYZjNu?=
 =?utf-8?B?WU1pK2EzenpCempuS1YrSjJSZTMxUUdnYnBOa3JCVHduWThocDJWcWZReU9T?=
 =?utf-8?B?UGZOcVI3cXZRUlF3cHpEQ2N2NGxxQnlDZUg1ZG5hUVVOMklYRGxtWnN1RHV0?=
 =?utf-8?B?QWIzL1NGdis4WE5mU25NNXZEeWpONnNWWjZWbERsc1RRK1h0QTQveFdQWDBW?=
 =?utf-8?B?clY0RXI2TVlZaHVPMTR4WHd2M0xsUzU4YmtFZUxHdlhRQ213L1VDQWs3YTZ2?=
 =?utf-8?B?T1BtQjVlUkh0cVFWOWswQmZ2Z2NCRmVFTHEwVjhpeFFiakpDZ3pqMCs2WnRQ?=
 =?utf-8?B?M1lwdTdtaWxRZVNWK1BDYVdxWkdvNEdvMlZMK3p3aVRlZHE4Tk04QkJ3TXpI?=
 =?utf-8?B?OVNYZE9vd1ZtdGgxMEFRUVRuS3l0OTc0dXU5QmtxeWo4K3hqSkpPcDl2amVW?=
 =?utf-8?B?am5mLzdNTGFmb2o1dHRjcGdDUTFXc0hjd0xhaEwrTlV5bHVCdkJZMUJmKzk5?=
 =?utf-8?B?a2RPR3lQemI2TStVR3ZKZGlHS2U2aERUTU9QTEpudGZLT0JNSXEzeDJOVFVK?=
 =?utf-8?B?ZHNMQmNEdHVraWw4aGt6QkFLam9QN1dOYTNld0p5bWFPcHdBckwzOUpGU3Nl?=
 =?utf-8?B?M3pSZGEvRFhJd0JneVFIRFFGZDczZ1J4SnNxRGQwc3lEcE9CQUJQdHdaMzlN?=
 =?utf-8?B?SmJTT1kwT2FuUzN3TGx4bFN5Q2IzWjhaUElncFdOc2UxNkN3bmdIU0toTlg1?=
 =?utf-8?B?OTJFZFJJd1BCYU1YTFVWbWJ0YUl3WXZab0VIcGZGTDJaYjQ1TTl3aGd2a3pn?=
 =?utf-8?B?Q1MxOXdZOWNKM04rYkUxNUNaQVo3QzlWS0wvdXgzWGJZM1FJL2FXQkRMV29U?=
 =?utf-8?B?aUdIN2N1RGNmZ3pFNllZWWNXTnI2eGlBQ2pEeWRnK0RsbG9rK2RGNU9kVzFl?=
 =?utf-8?B?R1Q1QmhxOU5QT0drYkVndEhqcm9lU1pFU05adW9TcDBlOTZ4elpCbVkydmd1?=
 =?utf-8?B?M3VEMVFzeVNuTzd6N2VMN2lzWFVMRDUralB6OUNQVnM2Z1F0ZnRYWDRQSldn?=
 =?utf-8?B?aVZ2N3JObklUNkswb0dJZGl6L0ZKZmxQZjRjd0dPOVFaN0o0cGE4MTRENTlp?=
 =?utf-8?B?bUc0V3BZYWIxbzNlNUNJWmtodlBlZnFTTndOV0c5cnZFNkZScWhEcHN0WWw1?=
 =?utf-8?B?OFhQOE5aT3BSczkvcDFETnRreENvZHhtN1poU2pBWkMwWnN2THZwVTBNTS9W?=
 =?utf-8?B?d2ZWMDRLbGxwYWF5d2ZkS0RubjdYcGxsaWxlOGZ3S0NmWnlEcURlc1JvT2tW?=
 =?utf-8?B?WmY3dkJyL0p4OVQwaXRpejQ5NUsvYVhVdURsQU1LbEJqNnhaSzlpaU5sS3lE?=
 =?utf-8?B?WEN5blFhWUx0bWpzdTQ1bnRKa05tb2l6NXYvcnVQNDBWNEJ5Vys3RnMvZ3JJ?=
 =?utf-8?B?aW45bTVlZWdsUFJkZ3Q2ODlFVHMrQ3Z3bUswazFsNDRMUC9RdE5jSjYyNDdS?=
 =?utf-8?B?ZUkwQTJsRHhBVmI0Y1V4MEhDUXJBdTVHOFIwQkdJd2RxN2dvMVpBR2JocXRj?=
 =?utf-8?B?eTZIbTdLYlV2bTM0NlN2SUNwcWlDL1p6RmlERWVMV0lZV2U5SnEwTnA1NHNW?=
 =?utf-8?B?b0hvRjVkMFZHQzBJY3FzYVlXNFp5M3JmbVZMRjJpTXZJdVptdVhxV3JGam8y?=
 =?utf-8?B?cWFGNDdNN0pZTTFPbGJJUnN4bDdtbVNqYkJMTDROcGlzS09CV05SK2J0bWxi?=
 =?utf-8?B?VVl6QWJkSlFTVGdZYXJkVjBKRjAzMnM4ck5XR3lKVDN2YlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 01:28:15.5600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb900a9-a36c-451d-aa63-08dc8cda6e0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

On 6/14/24 6:24 PM, Boqun Feng wrote:
> On Fri, Jun 14, 2024 at 06:03:37PM -0700, John Hubbard wrote:
>> On 6/14/24 2:59 AM, Miguel Ojeda wrote:
>>> On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>>>
>>>> Does this make sense?
>>>
>>> Implementation-wise, if you think it is simpler or more clear/elegant
>>> to have the extra lower level layer, then that sounds fine.
>>>
>>> However, I was mainly talking about what we would eventually expose to
>>> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
>>> then we could make the lower layer private already.
>>>
>>> We can defer that extra layer/work if needed even if we go for
>>> `Atomic<T>`, but it would be nice to understand if we have consensus
>>> for an eventual user-facing API, or if someone has any other opinion
>>> or concerns on one vs. the other.
>>
>> Well, here's one:
>>
>> The reason that we have things like atomic64_read() in the C code is
>> because C doesn't have generics.
>>
>> In Rust, we should simply move directly to Atomic<T>, as there are,
>> after all, associated benefits. And it's very easy to see the connection
> 
> What are the associated benefits you are referring to? Rust std doesn't
> use Atomic<T>, that somewhat proves that we don't need it.
  
Just the stock things that a generic provides: less duplicated code,
automatic support for future types (although here it's really just
integer types we care about of course).


thanks,
-- 
John Hubbard
NVIDIA


