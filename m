Return-Path: <linux-fsdevel+bounces-21743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1419095C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 04:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1001C214FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 02:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6846810A1F;
	Sat, 15 Jun 2024 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E9N8rHE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28576D53F;
	Sat, 15 Jun 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419887; cv=fail; b=X/CMkpJNbiG6VH7pyWZDCWYFIhJFOn28Qfi+KYmE/quNkbeGrXFc5IsJWDA0276ZX3eEp/32+L4CBKUOkrTt18ijDJAsGta26aFs4cXBVJNngEyZFpoOq3CICx+7S7TSE4X9WVB3+mMK4+OvOGcy1eZfXokxVwxbzCZNfC68kXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419887; c=relaxed/simple;
	bh=0rs6pxm7cKzwl5pURmKqaKmOZcKSHt5NPNyn80ZT0Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JkYg5nL9Ht0OrjQzCfHJstItcB6AbvVtZeBFtDqV1fe9EtvF7WZ0PeREmHB5yAZPZNUrWh8Bfa9JoheYEwjD/1rFIWKpxG/tym6e7PdyOhUIT0jixa6wpPeq44s8lpLwnYKYK8jcX1Mwfenv0TKenlFqLQwatmVVwnUUzbGOTrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E9N8rHE0; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmTMh4w4etlJhdB2wLUp+81CVmVSIMl6L8aWkDI0orc+L2E2YEIyUv5hkSE8r6Oe8xMaeg0KkkhWKevZvJvO8wI7/aZHnCtL8TrLY9FlF5FgxbAuN1zRaiQp0EITD38F/tD7x988s08rnfiUfFs+XoXzIgFQltRaRvEym4DM0htnIccyIQiO9KUZ/MBNdYhIdXdI8FcHS60a6rynGPhoqkUcNEDWm24MeLgE8QZHUsj2nfnIxPRIjRHY0oEHKDFBKTWZ9VzEvJBYibtQizLzAUsucfOyfO1nPBkt7k4HGkQjTskvt1QjbfA93yLroMTVcKnhcksvySeiOn6jP65Kiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKYJ3/LUSIlGYTS/uyyuzaatAkkwzL7NvAPAeJ56rxw=;
 b=BCBN5aPiz2B2lZGLE/vbZKpGFzvp3xdgoJBGLLcc317OWq1vzUddxbp6I9FJKuOViyFTZY57Zxn7nPpREyLuDqIkQmY919RxGXyi5ocWGefwderhLGtP/qp/wKKs7OBSF7/V42bbtEVMhxp56zvh8bNJUlbn6I+EjOsnUwcz4rzw5vZTeq007bQdXnjOWkmqAJHjvDYMaOgaICgj/7GevGdLB+k5wg+TDy6tySqpcHtDM9x4xP5d8c6bDoAWjjMlwFEKJL1ylZcgtXKFlrgRuRnBWHMhNre+rkrq5OFXhGJxQ4Bws+kYSnWhC8aEdf9sx5tQNhooVEy9iTl5YooovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKYJ3/LUSIlGYTS/uyyuzaatAkkwzL7NvAPAeJ56rxw=;
 b=E9N8rHE0I8OV6E7I3KM0K2UF3JxlI0Wve2WEcOlYqsYyyNv8M8VsfxPphupALt+LlHg+N3O/O0s4xjhMTfC6PbYQFNykYJ07sE9LDfDCnvjvq/1aSdvWxoAByUP6oT1ARfx1XNLc7d+xDIn7M2H77HVWY1HkAXNxtH3vka8urtxuBO2VL8JS/Tb3U+TBgLsPm1tBk7PoGY2qmHoShBzdGrKYGBL1M8edGdmhVCVMS8BNnTMamkNrStcTmzx7HY2NmXCdVlgGU3e7puEfKgOXjVwLa9GUzOZU4nTaVhQMdrtMxgJIHajpnhZ39M3LtxJBmqRSiJynOzeJWpPkR3dOsA==
Received: from BYAPR06CA0030.namprd06.prod.outlook.com (2603:10b6:a03:d4::43)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 15 Jun
 2024 02:51:21 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::58) by BYAPR06CA0030.outlook.office365.com
 (2603:10b6:a03:d4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Sat, 15 Jun 2024 02:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 02:51:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:51:15 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:51:13 -0700
Message-ID: <9b8981b1-3b7f-4b79-8f3f-b1635f1d905f@nvidia.com>
Date: Fri, 14 Jun 2024 19:51:13 -0700
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
 <c243bef3-e152-462f-be68-91dbf876092b@nvidia.com>
 <Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b07a1e-054a-4bd4-3af7-08dc8ce609e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3k5ZnNjMXJSbENlV3k5VnJ0bHlmMm5hR2MrZEJRY3FhY21FZ2RYRFlFZ1hG?=
 =?utf-8?B?WXd2cEJsY3RqUGdTeml2VVBkWC94Wk82NUNVVlFpUkRPUnhleVlaTk9SS3Ux?=
 =?utf-8?B?QmpKOTkwU3UrZzhIWFN5aHNXbHV0blpKSWxwSG5TeGtnTml1QkdhcTl3OTJR?=
 =?utf-8?B?LzQ3TnFucGw5NTQzMC94OXBHMFZpVTUrK0xLU1E1TlNubVlrVnc3UStFSDI1?=
 =?utf-8?B?cnNIN0xiTHdtOUs1ejBIcjV1cFAvZXdDd2NzZ0lBa1FRT2NOeUJoUHN1RTdp?=
 =?utf-8?B?cnZRZlZGTWNVWS9LR3ROK3gvenNQK0RUclYwNHlpbVI5cVovb1pCVmIzWEF4?=
 =?utf-8?B?R0gzN0JGWDhmQUhmVmlmVWhMcTJPNHpjRHByM0V0eEpqWkRrd202dHNMSUhx?=
 =?utf-8?B?UFJwUXA3NTk4V1BNNERNY0E5K3QzaW5oYVlJbGRjdFdCNnRsQ0NJY1dYeklU?=
 =?utf-8?B?NEZHYjk0L0lYekZURlZDdUZTdnZGcC9QR3NkY0cvVm56NXBvYTZBVFVtOXV6?=
 =?utf-8?B?WTNXbVZtcmR5R3UwSmlIdmlCVytUU2hrRy9XSW8wcFZKUlJCeUI3VkZlZW5j?=
 =?utf-8?B?OGZmVVQ5aXNDRGdGQXEyMGwzTXBBb2RKcjNQOFlKWTlxYlBJZGt3Rzd0a2pL?=
 =?utf-8?B?S1Y0bWs0NGpreWRMZlEzQVRZNmt0M2Y5ZFVEdnVKWHFPdFIwOXRXUjhLL3dp?=
 =?utf-8?B?SG5IcEFmN1dIYURCR09tSFhrYjgxdTVLS0V5Tk1BMjFXOUxSTXJuOS9SdUQw?=
 =?utf-8?B?ZjdydDRjcXhvc0tCSzQ2SXdhcFJidXhPR25mTnlrb1lTQUM4WjIxc21JcEU4?=
 =?utf-8?B?TGxZdFpxM3lNZnl4cVBMalNJTEFsM2Q2ZG52YXZaQnRpbjRxd1NxdzRBSEgx?=
 =?utf-8?B?VkNCS2pQQk14MHFMNmZncUdKdWQ3Z09acFZ5NzUrcmVWZ0dUeVZyVU5mSFJQ?=
 =?utf-8?B?ZS81Z2Y2bytwSDhKdHpITmtYVC9vaDNPNTFqTEdFMnhSbjVHL3ZKa1hUalpK?=
 =?utf-8?B?T2NRT2JHT0dWcVlpVENPVXlzVGtWRGM2bUVRemNKSGpNejF3b3kybzAwaHZQ?=
 =?utf-8?B?M3c1K294WjJDQWFPc2pNbEsvMEV6a3BjUUpnbnJHck9KeGs5M0phQ2NrR2lS?=
 =?utf-8?B?dHE5MTFVR2gzb1cyR3BKYlJUTldRVEdFM0hBNlAxZWRTUWhmRzQ3dDZQNCtL?=
 =?utf-8?B?R2lhaDdvWjN4d1lnbkV6dnpaZHhSUE9JZ1l1ajlwR3JURnBTNkpHL1daa25T?=
 =?utf-8?B?WkVUU2lLWG9PdENOVWlGZlU3L0htb0NsanlrZGNBTnBJK3diM1prUDlMbzNU?=
 =?utf-8?B?Wll2UlNtUmNvc1NuUkpSaUphTlQxUHVyWUlneVVTYmE2UDkwUUlOditiTUtr?=
 =?utf-8?B?TmNWR0xZRmhZaG9HWWlhUi9lMVpUWkdWNnIxakcwcnNnVHZ5ZkJEc2ZNdUJk?=
 =?utf-8?B?TE53UGkrVTY4L1lGWUg0R3Y1aXcxcDBOSmJYa1B2bCtXcW8raVUwYkxWYlJC?=
 =?utf-8?B?ZG9JM2VGS2o1eVFNWW5xbWpRMUVIaUdLc0JGQ256RDBVZnFPbXZuQ3ZYWXk5?=
 =?utf-8?B?QlpDc3BSRmxHNTdvSmZmSENRVlNrYU5qazdFd2RGOUd6MjVDeW8zNHN6UUVM?=
 =?utf-8?B?bENOUU90SzBFMGVUWkkvNEY5OWlNQW9OZjdFT1pEa1IyZFViRnpySlpSQ2dh?=
 =?utf-8?B?R0ZlNS9xdVlZMXM2Zkh0YUxFM3hBUkNrMUtVZmt0b1JSaC9iKzNrNjdtNXFi?=
 =?utf-8?B?REtNaHZ5UGtrQ1hoWldmMzIxeDByM1JmMlJxWnR0WTM2TXRxUmdYcmZSbno2?=
 =?utf-8?B?M2FFNkdWYlZVbDQzV1VialBWekg1LzZyUlNocGliY1Jva1lIaWYxWlNrMHBq?=
 =?utf-8?B?N1E0SzJwT1pYRVBIbFVOUm1KTTRjVHplWklFK3Ewa1JwdWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 02:51:21.4473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b07a1e-054a-4bd4-3af7-08dc8ce609e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

On 6/14/24 7:39 PM, Boqun Feng wrote:
> On Fri, Jun 14, 2024 at 06:28:00PM -0700, John Hubbard wrote:
>> On 6/14/24 6:24 PM, Boqun Feng wrote:
>>> On Fri, Jun 14, 2024 at 06:03:37PM -0700, John Hubbard wrote:
>>>> On 6/14/24 2:59 AM, Miguel Ojeda wrote:
>>>>> On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>>>>>
>>>>>> Does this make sense?
>>>>>
>>>>> Implementation-wise, if you think it is simpler or more clear/elegant
>>>>> to have the extra lower level layer, then that sounds fine.
>>>>>
>>>>> However, I was mainly talking about what we would eventually expose to
>>>>> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
>>>>> then we could make the lower layer private already.
>>>>>
>>>>> We can defer that extra layer/work if needed even if we go for
>>>>> `Atomic<T>`, but it would be nice to understand if we have consensus
>>>>> for an eventual user-facing API, or if someone has any other opinion
>>>>> or concerns on one vs. the other.
>>>>
>>>> Well, here's one:
>>>>
>>>> The reason that we have things like atomic64_read() in the C code is
>>>> because C doesn't have generics.
>>>>
>>>> In Rust, we should simply move directly to Atomic<T>, as there are,
>>>> after all, associated benefits. And it's very easy to see the connection
>>>
>>> What are the associated benefits you are referring to? Rust std doesn't
>>> use Atomic<T>, that somewhat proves that we don't need it.
>> Just the stock things that a generic provides: less duplicated code,
> 
> It's still a bit handwavy, sorry.
> 
> Admittedly, I haven't looked into too much Rust concurrent code, maybe
> it's even true for C code ;-) So I took a look at the crate that Gary
> mentioned (the one provides generic atomic APIs):
> 
> 	https://crates.io/crates/atomic
> 
> there's a "Dependent" tab where you can see the other crates that
> depends on it. With a quick look, I haven't found any Rust concurrent
> project I'm aware of (no crossbeam, no tokio, no futures). On the other
> hand, there is a non-generic based atomic library:
> 
> 	https://crates.io/crates/portable-atomic
> 
> which has more projects depend on it, and there are some Rust concurrent
> projects that I'm aware of: futures, async-task etc. Note that people
> can get the non-generic based atomic API from Rust std library, and
> the "portable-atomic" crate is only 2-year old, while "atomic" crate is
> 8-year old.
> 
> More interestingly, the same author of "atomic" crate, who is an expert
> in concurrent areas, has another project (there are a lot projects from
> the author, but this is the one I'm mostly aware of) "parking_lot",
> which "provides implementations of Mutex, RwLock, Condvar and Once that
> are smaller, faster and more flexible than those in the Rust standard
> library, as well as a ReentrantMutex type which supports recursive
> locking.", and it doesn't use the "atomic" crate either.
> 
> These data could mean nothing, there are multiple reasons affecting the
> popularity of a library. But all the above seems to suggests that you
> don't really need generic on atomic, at least for a lot of meaningful
> concurent code.
> 
> 
> So if we were to make a decision right now, I don't see that generic
> atomics are winning. Of course, as I said previously, we can always add

That does seem to be the case: the non-generic flavor looks more
popular so far.

> them if we have learned more and have the consensus.

Yes, I suppose waiting might be better. I expected the Atomic<T> to
be more popular than it actually is...


thanks,
-- 
John Hubbard
NVIDIA


