Return-Path: <linux-fsdevel+bounces-32946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB69B0FCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8620A28344A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF7C214415;
	Fri, 25 Oct 2024 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISVz63IS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395720C334;
	Fri, 25 Oct 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888332; cv=fail; b=YaTuDbccoG4rjdtOk8GT6qSSrF695XzmuFkRSwFskYJJkr7zUiCFW87VtcespxbE1BmVGPy2bMIuiMWtzJOb7AjO6Rh4DzCpj8HPtUqrr8tXyNt5PoNWDsw4FTELvGd/J68y6KZKvsT8JfkOKTAQ1YvDXSwiuTgvdXpdHZXOFsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888332; c=relaxed/simple;
	bh=79ZP0Yhkz530bsHp346xccelGy3HZcDZF40aXHKA9PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l48v52V4dG0GgRMqzgZJ3oJ10ZnQhE+RQTDTybU/qbWZquw/wV6ecOfjGgskTlz4OD678r+f2NgtYI7y251vRBgqFWNcFlwJqXw3gYUyvEsNIwPxPSeom38aB0tSwVwCvotp1iPkH5tVxtmcohUgAUApL9ZaQAcp3dGTgCF1Vac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISVz63IS; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rv3llqq5GJ5js37wPagTTxJw7MzDlMdH+vLPXZDBVjvMGeryWAloaTCBPUzTZfXWFECyw7zcVgY9K32WhOItxhCvdUDxeDDh71Gju0SbzEjkO00GFlHvyhSj1YdHp0SqxkKOSggWfPgSi5reOXenuELDA0piDtS5Ju0y+Cv0hTHVBHrbRQNyH8WnSqCdx8MUC8LevP3QaaZGsntLuTzWKQnxQUxG0/704pJwo1U073QSGVJOUr6mwqruOoh1+QfOLGQLuY3hfqMWp243PQ11xdmChq4YEGdyr/XF4gt83+X7FeIJeGjnE+WqSxrOKVjns1ew0cbYe7q55XLdQ+7qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSu7SJj7OC5avzwyrKitugf+Rc2jga2LHM/UExRLYyw=;
 b=yTOQXp9vKmqvhLOhC2HAykw5EKlZLMvs3iUap6cxIjyWTXHA5JQUQHX1mtT39JuN4k1oM5RXMFgTLc3DoX/1LkVB7/HuL9qmLzC4RJMTx2tm3Drf2BpVcE2hYUISU3q0Iq4OyZOBF7iHJSMIWrnoQtLl3xEcHWd+J5/3R5fBTq9jJgbmtHraGM6D8eXE74V+ciq3Q7Bo1zAu7yt7l5d9U+rwQjLvc4kGrrFz2OFQEC7Y6iLiWXrP2vPhMwMS6+audqWL9hlzXhOOqjaTkh4/b7CN3jMdhfqErrxibRnhA3UY1mB1Y5H8iUtIRyF1ZOS2km47Tg4f2EfYDtihQzWA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSu7SJj7OC5avzwyrKitugf+Rc2jga2LHM/UExRLYyw=;
 b=ISVz63IS6IbAcimY4wMEjbr9//ghaC/W3S2+TyA7fG/bUXWnAc6ngSq+MWkBMIa0EGkqGTnBYNfKBc4Wtbu2yKP1zgaXDdwL4Ogm+Vzy1NVrB0GT1wA7Fak7TzwyPQ+WDP5zd3WKmmJ8wr6XP9M52CnDW9SGOeegHAoMLq65ebvrOqAjIkbpnIjvS7sa+cKiyqM6e1szbMCmujwXTa943NfZ8mV/brepUXKNE+yzb5uorW6R8Sk0m6h9F6zZZMlmq0tmwloSwNtF1unzpFiPJqtCbsatPSE8f0R7/SBzv7Pta09ROsLghbQ6jGPQ7dJY2OqDOjt1obm2rLZf/o+/8Q==
Received: from DM6PR02CA0093.namprd02.prod.outlook.com (2603:10b6:5:1f4::34)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 20:32:07 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::1) by DM6PR02CA0093.outlook.office365.com
 (2603:10b6:5:1f4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22 via Frontend
 Transport; Fri, 25 Oct 2024 20:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 20:32:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 13:31:50 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 13:31:49 -0700
Message-ID: <9de8d876-5729-454b-bf8c-8b0ec8f8ffc1@nvidia.com>
Date: Fri, 25 Oct 2024 13:31:49 -0700
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
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <31dd0e52-9868-4cb4-aec6-d8749cdd2560@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8dee03-c81b-413b-58c2-08dcf5341808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VitYU3BqOVNkV0cyYXdJUlluNTV6eU5ycGd0MVRCUXFBTDdJeFZ0czkyTUY0?=
 =?utf-8?B?ODN0N1IzeEIvb0pJWXpHZWVjT2p4QmNsSE45cEhmSkVBRkdFS0Q5L0NLc1BB?=
 =?utf-8?B?VFB5Z05oais2MG1DKzBOSXgrSkh1Nys2V2lQSzFvemQxRHJuMldHVmpQdXd3?=
 =?utf-8?B?TGdOdXd2bzNmQkNHNkMwT0xrb2VJS0JUZHBhUUV5NjYwWk53d1JEY3dZUnY2?=
 =?utf-8?B?dUQ3T1JpdS9Kckg2QjBHVGdTWjJnNklTTkw1aFRsOS9SeVRrNkh4c3RuTldG?=
 =?utf-8?B?QU9nV05GTlhsS002YUZhd2JSZ3pEMW1tMkdqcXZzZndzRFc1Tys5ZkxMWUNH?=
 =?utf-8?B?enF0M2ZFTmpRRTNHWFRCUW5sVm9hU09xajhhR0F6KzAzQ1RjZ0ZWVmlXVzYw?=
 =?utf-8?B?NU5SdXhjRzdPY0RZNENqTmIxdmJFM092QTRjUFBWQlJHZzhkeTh4WFZjeFoy?=
 =?utf-8?B?Z1ArcFYydU8vK293RjdsR0RJZ0xHeFNRU2sxZlltSmJncTNlam9tcEk5MDgr?=
 =?utf-8?B?bEczMUZ2eUN2RVl6Z0tQOXZ1SlYzVFlIQzB5YldMUmFWQVd3d0Q5ZVR2SU0x?=
 =?utf-8?B?SjBhQWhaV1NRcHhJMGR2OVBaWUlXZFVubE9wRXU1VDFiUFFaQ3ZIQ3I4WGNV?=
 =?utf-8?B?ZHJGK1RpdVRIVmtJOUtyUTJ5LzFPdXc1N09zTmxZbXZmOTJmL0IyaTVPQ2o1?=
 =?utf-8?B?K1k5cWEwUTFheGU3NVpaYXRITW45QmRjRTRJMFlVdm83WWpXSUk5dDRzY0Rw?=
 =?utf-8?B?SkpuNFUwbGVoTWF0NGllTWUvOXU4RnpIMWtBTVE2czY1dno3OElyZHl2SzVR?=
 =?utf-8?B?Qk5GVEE5M3Vacmxydk5WcExXN2Urc0lvd1ppNHJEeUtYN1Axc1VnT3ViRmt1?=
 =?utf-8?B?eUx5VkRna0NoV2I1ZzZHalJZTnlMMnQweWFMZjdub1I3OVUvZlpTRXU3Rmlx?=
 =?utf-8?B?ODV3cFhWaUNrckRoY0x3ZlJKajBKYlA2T3dwSjVRU1ptZlc2dzBwU3RxRE1p?=
 =?utf-8?B?SzI2TUF4TG5rYW9sTlE5MTFMK3BEQzBwd2dVUytCektXNVhXN3dnZDF6cE5C?=
 =?utf-8?B?L3JDRzhNNEM4QzYvZ2hqMmh5Vm05Q3FFTHBCTFk3R3FTMUV4SFV0N0Q5bkdD?=
 =?utf-8?B?WnUvakVEbVU2UmkxK0VnUFczaXJhRnh0RVNGdmhZbG54YjNhdmgyNnIzY0lR?=
 =?utf-8?B?dDVZRmFoNWdUUmhabXo3N0JzMmZTY1ozMDhxektzNlc4NWZzV0FXZGloV1M1?=
 =?utf-8?B?ckY5M0F3cXI0b2pkRjdFUW8za2JZMEF6Z0hMM2tjRm9Gck5iQzBEWmdGN0Vy?=
 =?utf-8?B?MzBsckx6R25vNzdoUTRsVHdmSFJ1WnYxOHorM0NLckRLc2h3Q2NheEFaUmlO?=
 =?utf-8?B?ZzE3eTVjVmM3Ykd1UjNhcFhjTllPZ0YxR09oTmVhWWN0dFE4eklvc3hVcjNN?=
 =?utf-8?B?di9LSGZkckpnRkQ0QXlzcCtiN2p0WVZ6VEd6UW1BNUJlWWZQY0pMRkxoTlUz?=
 =?utf-8?B?WXFNWU1kNWFWcEhDWGFQY2gxa0xoeDJma2NOUE9ob0gxZHJ1eEZMV2ROVWM0?=
 =?utf-8?B?WVNYZE5rSWlMVDBWWlBmQ2RRSDU0VlYrRy9Xai81MjRVa292VVpSWERXOXYz?=
 =?utf-8?B?NENFRmRnZGg4YXNwVVVzWk5QdEI2cWV3K0NpaGZ6QTJhNU5LOW5ndzlaQVAx?=
 =?utf-8?B?UjF2UDY1MmJnNWNYaGI2UDFLenZaV1RMYkFnWHV1OEJmek1oZytydjQ1c2Mx?=
 =?utf-8?B?N2VkTkpPNEE1bWxtdWhGNzVkbHhEY1VmWGE5QUVGMGVLWVdpUGNKek5DcHJw?=
 =?utf-8?B?Vi9BeG5DdkRwakhQTU5NQnZaZXpweHRVTGFBTHY4Y0U5NEtkYVI0REJDemJv?=
 =?utf-8?B?Y2VRSld6VzJoM1MrbWtMN2Z4MnJUR2U2TUkrWERCdnBJUVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 20:32:06.8666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8dee03-c81b-413b-58c2-08dcf5341808
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569

On 10/25/24 12:49 PM, Lorenzo Stoakes wrote:
> On Fri, Oct 25, 2024 at 11:44:34AM -0700, John Hubbard wrote:
>> On 10/25/24 11:38 AM, Pedro Falcato wrote:
>>> On Fri, Oct 25, 2024 at 6:41 PM John Hubbard <jhubbard@nvidia.com> wrote:
...
>>> That seems to only apply to the kernel internally, uapi headers are
>>
>> Yes.
>>
>>> included from userspace too (-std=c89 -pedantic doesn't know what a
>>> gnu extension is). And uapi headers _generally_ keep to defining
>>> constants and structs, nothing more.
>>
>> OK
> 
> Because a lot of people using -ANSI- C89 are importing a very new linux
> feature header.

I'll admit to being easily cowed by "you're breaking userspace" arguments.
Even when they start to get rather absurd. Because I can't easily tell where
the line is.

Maybe "-std=c89 -pedantic" is on the other side of the line. I'd like it
to be! :)

> 
> And let's ignore the hundreds of existing uses... OK.
> 
> The rules, unstated anywhere, are that we must support 1972-era C in an
> optional header for a feature available only in new kernels because
> somebody somewhere is using a VAX-11 and gosh darn it they can't change
> their toolchain!
> 
> And you had better make sure you don't wear out those tape drums...
> 
>>
>>> I don't know what the guidelines for uapi headers are nowadays, but we
>>> generally want to not break userspace.
>>>
>>>>
>>>> I think it's quite clear at this point, that we should not hold up new
>>>> work, based on concerns about handling the inline keyword, nor about
>>>> C89.
>>>
>>> Right, but the correct solution is probably to move
>>> pidfd_is_self_sentinel to some other place, since it's not even
>>> supposed to be used by userspace (it's semantically useless to
>>> userspace, and it's only two users are in the kernel, kernel/pid.c and
>>> exit.c).
>>>
>>
>> Yes, if userspace absolutely doesn't need nor want this, then putting
>> it in a non-uapi header does sound like the right move.
> 
> The bike shed should be blue! Wait no no, it should be red... Hang on
> yellow yes! Yellow's great!

Putting a header in the right location, so as to avoid breakage here or
there, is not bikeshedding. Sorry.

> 
> No wait - did we _test_ yellow in the way I wanted...
> 
> I mean for me this isn't a big deal - we declare the defines here, it makes
> sense to have a very very simple inline function.
> 
> It's not like userspace is overly hurt by this...
> 
> Also I did explain there's no obvious header to put this in in the kernel
> and I'm not introducing one sorry.
> 
> ANyway if you guys feel strong enough about this, I'll respin again and
> just open-code this trivial check where it's used.

No strong feelings, just hoping to help make a choice that gets you
closer to getting your patches committed.



thanks,
-- 
John Hubbard


