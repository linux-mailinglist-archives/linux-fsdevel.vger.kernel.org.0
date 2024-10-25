Return-Path: <linux-fsdevel+bounces-32988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDC9B11FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 23:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37D91F22227
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F739216E04;
	Fri, 25 Oct 2024 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWaVlnu7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D982216DF8;
	Fri, 25 Oct 2024 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893108; cv=fail; b=h5Lzbeor/PnJMEVmoh9nDn9/3/rWrnAA+Tya1VioOihXo2z7JVSux6gDdjeBjzelNkUZkwU1toJB3TYBFdf+p8+ZMFPpVBiXnnJLlcCdKzSBEVTJz2jkk0PQuDbQ7wffUahhR3fLyxuKwJ4tfEENlR9vxbPM1pLW4xb1hlYWYFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893108; c=relaxed/simple;
	bh=UPCMcgFMykA1xOAC0+5wCiguhP2QXf6LPoVIrXFtnQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nRwuOkgnIp7KqBjq9Q8i8Gn6sLr6Ber34DJCxaEFp2H8Jis8iAAhrLNOVgdoMbgnz8Vi3WOWW7u7gHqZn2vVTcUjV9lesS16AYQWmQD3h4cl9OPk9SOM0kC8tTVydmgP3iBfxPvRm33XmlJqUq24rMeJ17anL3KnUn2GbxOyrbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWaVlnu7; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcnuoD++LhoZguqIcxPyVYnZpgwp/z8MSjxaLAs+/e5YxSccVbtUzjpuBptpHPvJl6nzVKqa+j1nXUGDL1fld/P/yOTrIbMQxNm3lJ3HscKcydx9NSItHbKEVQvgQmVhtqiZzgAlJNGtEEv0JfuWWR/rsUH1kdEd3mjcbLn3m9HSU2OES9et7Mr7Cl6cWnVaLfcieAAfYBKuw/1MTxV9vRlGrhzlZQ4Nf+1Y6+qjyAdeiRUU10tpyxUpL2nYbZL0qcjTQyV88klM8rkBUwCKz+QhGRImhwVOxsQPW3pjMzfETXKCm/gO0op56kWiTkUb8+kYeyfxsxWhML7D/M2GWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYWgZqA5IxagrEb1ITvcPiuUun/SzZ8c/vvc78nFTRc=;
 b=dUfvgKYd3+4oaTIRoAU+y1ltXldkHkDIHUs192I3IYrcNzduaExmYROozjUp7Fnur5L4Fsd902UYcggSHRQsUmFPlFArWFodUku6SyQ7vi/rejy4gtgQXGrr+BE29szjcoNqUMt5HTm2WElNbdZ+s2MCRoWArcv0vqExSLnCxVLP6oaHXBhA51SIPFvBv9bpwYHKCV3uA++mAD8ijTyZWw14FTzbamjX/6au8b/lRZY4zp/rz3JPPCgFEDBPd8zQRWEIhXPdWaWGdgH6oF779N3/E22R0ReG9MdEc0lpMfT1J89qQQQDQjquHjqvr7USvelWV5vTlVa0WSTiW6Oy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYWgZqA5IxagrEb1ITvcPiuUun/SzZ8c/vvc78nFTRc=;
 b=CWaVlnu75srf1+mbVYkL/X6KBfBZLyoD99CFcv0QtdVnoSFsfYOtTYDrco1A7VSuFUAEjn2kh8xsEaAQtvhzbNBPjXxvX7fSe5UzVvQhevhC5JABKWj8V6GrmztE0BF5TroZ7S6e9fym9SbLb8S2qecg57MJc/3ya4UfssLT1cUzTL2/lHh9pS56xjhTkubNOQz8EvmfjrGr1YbfnEsLc6U2kaGiljpTkiLnJTJjrnCRdhvgpXIjZVVtIueXiWFcuFVP3RZEbRFSawMtnz0lTu1qz9Sixw82uCP9ch2FPsYXvi6NylrGKSkSTVNNcwh+uSi+VnQS5/sYyz3x1bK0UA==
Received: from BYAPR06CA0023.namprd06.prod.outlook.com (2603:10b6:a03:d4::36)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 21:51:42 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::4b) by BYAPR06CA0023.outlook.office365.com
 (2603:10b6:a03:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 21:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 21:51:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 14:51:30 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 14:51:29 -0700
Message-ID: <330c0dae-fa8a-49e5-94b4-25b915f74e37@nvidia.com>
Date: Fri, 25 Oct 2024 14:51:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Pedro Falcato <pedro.falcato@gmail.com>, Christian Brauner
	<christian@brauner.io>, Shuah Khan <shuah@kernel.org>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Oliver Sang
	<oliver.sang@intel.com>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
 <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
 <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
 <828674d9-e862-4438-86b6-61977f4cf3b5@nvidia.com>
 <CAKbZUD0fxczjSJo34MnWRNT4M6HTfWN0DRXr9CFe_+cKJW_mog@mail.gmail.com>
 <e5ac648b-88d7-4fa6-8eb4-d061a4b2baac@nvidia.com>
 <31dd0e52-9868-4cb4-aec6-d8749cdd2560@lucifer.local>
 <9de8d876-5729-454b-bf8c-8b0ec8f8ffc1@nvidia.com>
 <239456b7-4045-46cd-a2e7-8445dd6640c6@lucifer.local>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <239456b7-4045-46cd-a2e7-8445dd6640c6@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 525644a4-e635-4cb5-142b-08dcf53f3650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzJ3NXBRa2x2OEwzT3RNRFFuVGVCL0lza0lpNE9sUmZuNDBZTWhFNTNnY21l?=
 =?utf-8?B?blRiRlJFb3RlSk83aEwwZXJwZDZNZ3NLb3pob1NLUnp5dEp5T25SWmJNbmdF?=
 =?utf-8?B?RUE2WVU5Qm5hQjJMWTNvNllIbi81VEFMSCs3bmdPdjR0dEVIZUdMYWRTaW9D?=
 =?utf-8?B?TDlzTnVKR21ZUVNJaDRZSVZBYW1iUSs3blR1ekMrUERaSnF6NUVTbk8ranEv?=
 =?utf-8?B?eWp2cHZRMjZtMzJ1MVN6R1lGZTJUZjEwSXpNQlNQd1Z5c09GSDMrOXpKZElr?=
 =?utf-8?B?amxjeGRrZEhtdmQ2Vjh0N2xzRW5FWnB2VDBFTlgxMXUyZUdrRXk1ZU85Rzk4?=
 =?utf-8?B?aDM3SllQOG1ieTFGT1FDeGdaVVRlSDlzZFM0dzBFeEVIT3dJS1RGWnJBb3cz?=
 =?utf-8?B?WEMvQTA3TnlSV2NqS1FYUVh3ZmFOMEdudTcvaC9KYTdrNnBlOTVWZXc0a0xJ?=
 =?utf-8?B?YjhZdktyQ09vVnVZdXRXSnFZekpZZFQyT3R6L0ptbGErb1A4UUY1cFF4Ukl6?=
 =?utf-8?B?KzE0UWlGSkdYSGJKRUR3MkU5OWIydDM5VTBxc1VqMzdab3JucmM1M1RDVmJF?=
 =?utf-8?B?QWNRRUFEWWJ5bWw2d3dkK2VyZHIzdGRkcGIwa2FleUkxZ0lQcTBtSWhaczdX?=
 =?utf-8?B?SnJKTkVRRk1GemR6c3dEREp3OEkwQ1YxRkdDWks0V0hiOGhDYk93OGxCOEVY?=
 =?utf-8?B?cGFQTHR4L0hSbGlvbjVIS3RXWVVMOVNsNHRhNlBlZWx3TkVDUHVJdUREYTZY?=
 =?utf-8?B?SnJybE5uc0ZWVmVZWVFrbmRUS0VJM0dFRVRkdmpsWFVTUEg0Wk83SXBjbFpt?=
 =?utf-8?B?djY0dHhicUc1MDAwZ2ZOaDZYaEoxQXU2R2hqWWxGU2ZMSHR2MldXb2IxMDAw?=
 =?utf-8?B?dW95NkdjZC9hSnZER3g3elpab3dMMlkyWDZuWGlYUis0ZEFhOGFEYWpiNjFJ?=
 =?utf-8?B?NFJ2cjhnYVY3LzlIRVdySzIyaVdsV1JLUzZmNFBjQlFmeWF1blFERzc0QUpV?=
 =?utf-8?B?SGgwb3pNK21zY2Z0bUtZbTl1L2ZlcHA4Y01xNVJzZ3RObi8zV0JBV2NUUVdl?=
 =?utf-8?B?S05BQk84aDkxTXNXbkkvM0pSSTdabkw0R0t4NEIvZEVzOUwwd1hRV0IrbVF6?=
 =?utf-8?B?YmYrKzlwL3diWjkzcGp4dFFpQmFtYldMc0h5V1gxSk5mVUJRU0RzZTRlRWw2?=
 =?utf-8?B?NXNpejFTanFQRFN5bmEzTys5eTFNZlM0bWp1QlE0TjQ0akdMem41WVFSWlF3?=
 =?utf-8?B?MGxqMjNNeS9HZGI4eEI5T1BrcDZwVmJJRjVkdmJ5V1U5cGhYdjJFYS9JcmlX?=
 =?utf-8?B?KzJqS1h6MW43VEh4UnU2SW5DMi9DZE5UVGV6dSt1L09HQm1YNmMzY2tIelRL?=
 =?utf-8?B?aWkranh4WnNzMWZwUG9zaVdXcEVWblR1S3drTnRpNktndnJzTnlBbXdtZHp0?=
 =?utf-8?B?T1BBUWMrczNXaHl2VFB0UjlkdGJsRzVoY2srYmY3V08wTlBrRnRsdVAwZ0J5?=
 =?utf-8?B?UW81eEhNRGE2R0lZS1hhZ0MvbXJYSW8xY2tIOVE3RXlGelQwYWI5YS95allW?=
 =?utf-8?B?cnlURDhTK1FVMDhZUHZyZkRvdWd0ZzFVUTJYNFpjWWxvOGw3UkJaLzVBVDhP?=
 =?utf-8?B?UmpabStXb2NBdURHaktHUWZOTUc4Wm9TcHlrZVE0YUo0alJWdkpxaktGSmkv?=
 =?utf-8?B?M2k2cHlKcWU2ZmpnQU9oQjdIWnp5MnBKNUt2eVNYTG5zL0JodU9hWSs4UERB?=
 =?utf-8?B?bHVlVG9xdlRxUit4RlFXMU1Hc0h2cnYyRUJKbU9GVHBqMXpBNEJLeU5jVEY3?=
 =?utf-8?B?Qi9Ednd2QnhKWFFBZzU0WkxZVy9tVjZ0WndYR001c0xwdjBDTzlsc0pMOUd2?=
 =?utf-8?B?YXhaRWdGc09jZVo4Y0xqaDh6UUQyK1liZ3h1SWVtOFhhR3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:51:42.2417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525644a4-e635-4cb5-142b-08dcf53f3650
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

On 10/25/24 2:09 PM, Lorenzo Stoakes wrote:
> On Fri, Oct 25, 2024 at 01:31:49PM -0700, John Hubbard wrote:
>> On 10/25/24 12:49 PM, Lorenzo Stoakes wrote:
>>> On Fri, Oct 25, 2024 at 11:44:34AM -0700, John Hubbard wrote:
>>>> On 10/25/24 11:38 AM, Pedro Falcato wrote:
>>>>> On Fri, Oct 25, 2024 at 6:41 PM John Hubbard <jhubbard@nvidia.com> wrote:
>> ...
>> I'll admit to being easily cowed by "you're breaking userspace" arguments.
>> Even when they start to get rather absurd. Because I can't easily tell where
>> the line is.
>>
>> Maybe "-std=c89 -pedantic" is on the other side of the line. I'd like it
>> to be! :)
> 
> Well, apparently not...

Why not? Your arguments are clear and reasonable. Why shouldn't they prevail?

Please don't think that I have some sort of firm position here. I'm simply
looking for the right answer. And if that's different than something I
proposed earlier, no problem. The best answer should win.

...
>>> The bike shed should be blue! Wait no no, it should be red... Hang on
>>> yellow yes! Yellow's great!
>>
>> Putting a header in the right location, so as to avoid breakage here or
>> there, is not bikeshedding. Sorry.
> 
> There are 312 uses of "static inline" already in UAPI headers, not all
> quite as obscure as claimed.
> 

OK, good. Let's lead with that. It seems very clear, then, that a new one
won't cause a problem.

> Specifically requiring me and only me to support ansi C89 for a theorised
> scenario is in my opinion bikeshedding, but I don't want to get into an
> argument about something so petty :)

An argument about the definition of bikeshedding sounds delightfully
recursive, but yes, let's not. :)

...
>>> ANyway if you guys feel strong enough about this, I'll respin again and
>>> just open-code this trivial check where it's used.
>>
>> No strong feelings, just hoping to help make a choice that gets you
>> closer to getting your patches committed.
> 
> I mean, you are saying I am breaking things and implying the series is
> blocked on this, that sounds like a strong opinion, but again I'm not going
> to argue.

Actually, Pedro's request kicked this off, and I was hoping to dismiss
it--again, in order to help move things along. My opinion is that we
should shun ancient toolchains and ancient systems whenever possible.

Somehow that got turned into "I'm trying to block the patchset". Really,
whatever works, follows The Rules (whatever we eventually understand
them to be), and doesn't cause someone *else* to come out of the
woodwork and claim a problem, is fine with me.

> 
> As with the requirement that I, only for my part of the change, must fix up
> test header import, while I disagree I should be doing the fix, I did it
> anyway as I am accommodating and reasonable.

I agree that pre-existing problems in selftests should not be your
problem.

By the way, I'm occasionally involved in helping fix up various
selftest-related problems, especially when they impact mm. Send me a
note if you have anything in mind that ought to be fixed up, I might be
able to help head off future grief in that area.

> 
> So fine - I'll respin and just open-code this as it's trivial and there's
> no (other) sensible place to put it anyway.
> 
> A P.S. though - a very NOT theoretical issue with userspace is the import
> of linux/fcntl.h in pidfd.h which seems to me to have been imported solely
> for the kernel's sake.
> 
> A gentle suggestion (it seems I can't win - gentle suggestions are ignored,
> tongue-in-cheek parody is taken to be mean... but anyway) is to do

Actually, these come across as sarcasm, especially in the context of
these emails that show you are becoming quite distraught.

I've met you several times at the conferences. We get along well. And
your work is top notch. So please consider that I'm very much supportive
of you and your work here.

I'm still trying to understand why you are recently sending these very
strong emails (Vlastimil also took some heat), but I see that you also
mentioned some long hours.

If my feedback is making things worse here, I'll try to adjust.
Selftests in general are a frustrating area.


thanks,
-- 
John Hubbard


> something like:
> 
> #ifdef __KERNEL__
> #include <linux/fcntl.h>
> #else
> #include <fcntl.h>
> #endif
> 
> At the top of the pidfd.h header. This must surely sting a _lot_ of people
> in userland otherwise.
> 
> But this is out of scope for this change.


