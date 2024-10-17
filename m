Return-Path: <linux-fsdevel+bounces-32161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649B9A187E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BC628755D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1397D446B4;
	Thu, 17 Oct 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ENv+T7V0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97F1F60A;
	Thu, 17 Oct 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131297; cv=fail; b=Q2IexAFjEFhDLxVMu0Oe75UhHC+slDSahZlhG0hF9dX837n5ZN+c6J59qBU/QG6DOjgn7PLEiIYVBClw6bdCwo3QOnDPw+M/0I3JzOa/KkVPQvo761fbFgaYPZK9wo3nT1WWX6SAsI4d9nTAXPD9M2vsJ2/dXA2uNp8LY8RIKFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131297; c=relaxed/simple;
	bh=fxmc/jERz7MZIyrYQEOYEbD2zeaUwHLQ6QQyiwJF1v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BS4DrJipOXVQh0fKo4sSdfv+M79pngBdODFKsfuSwmWoeIeDhRVx2uFqTCVE5FtnYw7e0kXBhQC1cNr9yhBPUyCXOfm9Q1xDTZ9FIUwJh6RPAw1yw4h8naYniPgLjjq0yg0Pjkcn7wWdfnhrKPBJkQVHrs0sNxkhmOTewj8VTgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ENv+T7V0; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+mkKP5xvs1mh1uFw2X7j7iLQFhciziSA+JxdnHWjpMmUPk5eVrG9s/8gPYZPxdzvHnV+T0hhOhnjvtJ3Xulcof4XViJnsJoLhnln3R2yhh6no5ts9zl4OakpLPRj007OEZlJFL9O1SfE6eam2e/jMPFGKZmJw3T0zRa4Tcgck8BbmAHZOwY1TkQyh0MXDld6Dy7sl7cHlbIb0MZZFjlwGAQVoOLQ/cSi+gmDGPO7waavJopFD8HX0IcjKoHXR2dxQKBINXPNUp1KYM+qKGK/y2lBD9o4kVAvoLmv6aRJozgMCBkqlR7A3ufX/CjuLh9fVlpO383q5nJ1yXvczqRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+xBSbuY3UOfPeSjagH7eOAdMPg7pXNJYPBTMQE6BtU=;
 b=w/rxOkziv5Lcgg4pvVs+L4ysrbuXtOoLqSKWk6nKgsEujeZQg77E3lCxsiJqQCO62UbxUoh9ZDAml78oOcAL/ExLGWxYJz62BEPEhuBBINw9iImVfl8z26Z+9558d62dpFDwl/HueSm4vnP0Mv3HDyNBcXQRcZJks4VCe91TYIHuKshOMnbs7/1t2hnt836sw81xtJ/K1mT3JncMxNDdi1j25mcfRUtYyhQcbryw3IEfOgxBBJosWHWo95RReQ6NCceuX5ARtUj8A7dF/RwJW3s6gZPokvvl8Na4IKUYVKVixUCiXvn9j+LeTaR0TB21bkmt0r4jjsr0ZQGkl/d4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+xBSbuY3UOfPeSjagH7eOAdMPg7pXNJYPBTMQE6BtU=;
 b=ENv+T7V0/yTiPCFQUmC6Qx+ENyQ58v7bJZeqM5dWcsILzT05WPd19D/EuCa1mEbvN+Q4ThxV7/cCzr+mBz3Sl8xctELYnTnEj/0GLRLDQDH0uKCZqVi6DD3CoEAA9aEiDEWC/xJPHtfEFgmWauc37M86DBJ4BKimlXJmnWzhHSisiHeBAp6f0LdH3o3XRimNd+hvkziKvcr/uNr0Z2RcW5gvwxrpDqTDH/XZ9YxuRFkTVaEQckhASuy7leYQoDqn4GuAbBAfsmE2/uY05OG4zyrl0UQLDsVUMO8dT+2FR0C4IteGwtzN2qfASereloF1FyymCJVkyZYOE85USL87rA==
Received: from BN9PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:fb::9)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 02:14:50 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::20) by BN9PR03CA0034.outlook.office365.com
 (2603:10b6:408:fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 02:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 02:14:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 19:14:36 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 19:14:35 -0700
Message-ID: <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
Date: Wed, 16 Oct 2024 19:14:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
CC: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan
	<surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	<pedro.falcato@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Oliver Sang
	<oliver.sang@intel.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa16368-7ff4-4b89-921f-08dcee517ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDdWZWJCWGpINDhoZGx0TkY4UEtHNHhpckRObkI2Qm5Jek1pV0dzdmdoQW5Y?=
 =?utf-8?B?SmE1MWYzeklyajU1VGZVa25ZcHFDdEYwNWtqa1hnNUF5TTFJdmlQSnl3SlYw?=
 =?utf-8?B?NExyT0ovQzlGSjlQZWJiTE5NNzJqMzlDcTJ5RG8vRW5sQ2xYbzBlYjZXdURo?=
 =?utf-8?B?RWxDZnBFNVF3QUQ1cDlIZk5vYWV4bWI5WDgxek1OVGpzb0lFWUhqK2o3TzZw?=
 =?utf-8?B?ZjJVU1BUOERmaGxhdjZSa2Z4WlVpQ3ViTWVWVWRwTzZwRWFXRU1lanNQSFd2?=
 =?utf-8?B?MHhSQStwOHdtckpxZW0yQmpZaXVOd1NZaXp0azh0MjNsWjExc0dwbFg0a012?=
 =?utf-8?B?NWU2QnVxTEpEc3pWUHpvWXVVbkZGRGhsMDEyY1pIUVh1dFc1WlozTHN1UnFY?=
 =?utf-8?B?UnV3bnhyZEl4dUdPVDJoVmlXQzdZcm1QKzljUm9MWWllQndzdHhjT3A3Z202?=
 =?utf-8?B?dllUOFpkVHMrRkFadElJTlE5aHlXdmNBODdxaFNmR1E5UEZKOXZLMERHSkJZ?=
 =?utf-8?B?cXdOcFZoYUNJZExHaGd4akp2UTFNR2dWSlVQWW1GSG5FaENiVXBsKy9lTG0r?=
 =?utf-8?B?bG1IL0t4all6TlR3NkRvTUVZZjkrM0Y3U3lYaVNyOTI0eUc5aXFJOVBJbmJ1?=
 =?utf-8?B?c3ZGN01pZktYeFdjVnB2T1lNNno1bktkTklxYWNHclhXRTBERGFMVStGMEpK?=
 =?utf-8?B?QmxpZEpuK1hjNTR3bTlHUVJUeWJhOUFrREx3RmMvZHN2b3IydXh3ZFQwdjQ0?=
 =?utf-8?B?dDJZdDkyVTB1V3ozZGFnNTBSdEMwVGEvZzgwUE0rZTI5NzRTb25ITjE1K2JD?=
 =?utf-8?B?MktRMEpQdWRNRUE5WDhsOFhyUmVuTkYzc1EycndXK1BRSkQyYlJKeWFmRmkw?=
 =?utf-8?B?c3JOMi9hMlB4RzZWMGhKazhoWWdlOWFJSE5qKzZ1Yk1ESCtZL3B0SHFPNXdQ?=
 =?utf-8?B?NkdJR0pJd0x4c3loTHA1ZXJraHMwQ3lpYjhOWXFpUVRvT0l3S3hYU29ES3dN?=
 =?utf-8?B?TUpuMFl6Q0x2OFRiRWJBTFVqcHZzU1lsOUE1dHZsU1lNUWpydnZkdXdMS3BC?=
 =?utf-8?B?SU8rWGFYR21LWWRFVFIvUjlzUjNzODNpdWh5b1g4UjlyYkxyYmJqdkxObitY?=
 =?utf-8?B?VGlVbGIxYytldVdYWEw1MjBKSEp2L0l6SW9wRk4wWnJraWlNNXc3emw0bGR2?=
 =?utf-8?B?TldtTjdIN0dCQ1U4bWpiMWhEY3JIaktDZE9PdWRlbHlITEdLL1B3YWRadUFi?=
 =?utf-8?B?bTNlY3hSTkJHMUMwMFZhamFCRWVIMUNqK0l1SElmVWNwcWQzaHphM3dmMDEr?=
 =?utf-8?B?YmhBRCtUbVFkaEdpTmNxVTFHaFZDNTlhUEZQeEluam5PekNJQU9QcVJyRHJu?=
 =?utf-8?B?Z3ZPQXU1U0R6d1FjRGJuRGVjcXk5ZzNXVWNKM0xiOXpKN1VKUnB5OFlUb0po?=
 =?utf-8?B?MmVCWXV2amdPb2MwVXA5UERRY1lrdkpPaWhZRDl6T3JsVnloQW5BU1hKQVZ5?=
 =?utf-8?B?SmxYWmtrc3E1Vk1wZ0VmOCs1b3pDZU5ueDFjOXFIMWpwYmNLbUUzK2Q5TzRz?=
 =?utf-8?B?c3Q4aG0xUy9rSzlURmJ6cEYvR01ER0c3aVlaaVdyNWY0emlnQUVHWFN0M3Vv?=
 =?utf-8?B?NXg5OVBGVVBQb052TVo5eWFESU0yRkhPN2NOLzRUUndyUE9QR0xIeG1kMURI?=
 =?utf-8?B?QXQ4YkZLYWtQYldxYm4zMlFVZ2x1Qk9uR1JwN0h5UWZibmJ5V0YyOVN1SmY4?=
 =?utf-8?B?Y0ExdFpMNU5PWEpubE9WbzFIZFd1OS92eEYzQTBTd1FSSEZaZHdhWUdqaFFF?=
 =?utf-8?B?VU1NUk13djU2bkFBbDR4UkdPa01DU0J5OFlVNmZEYzZVeWtwK3oyQStab0tk?=
 =?utf-8?B?MlZnV2F5VDB1elgzbjU1eEcyc1piN2J2aGt4UUVoRkJWdnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:14:49.9101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa16368-7ff4-4b89-921f-08dcee517ae1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984

On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
> On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
>> On 10/16/24 04:20, Lorenzo Stoakes wrote:
...
>>> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
>>> index 88d6830ee004..1640b711889b 100644
>>> --- a/tools/testing/selftests/pidfd/pidfd.h
>>> +++ b/tools/testing/selftests/pidfd/pidfd.h
>>> @@ -50,6 +50,14 @@
>>>    #define PIDFD_NONBLOCK O_NONBLOCK
>>>    #endif
>>> +/* System header file may not have this available. */
>>> +#ifndef PIDFD_SELF_THREAD
>>> +#define PIDFD_SELF_THREAD -100
>>> +#endif
>>> +#ifndef PIDFD_SELF_THREAD_GROUP
>>> +#define PIDFD_SELF_THREAD_GROUP -200
>>> +#endif
>>> +
>>
>> As mentioned in my response to v1 patch:
>>
>> kselftest has dependency on "make headers" and tests include
>> headers from linux/ directory
> 
> Right but that assumes you install the kernel headers on the build system,
> which is quite a painful thing to have to do when you are quickly iterating
> on a qemu setup.
> 
> This is a use case I use all the time so not at all theoretical.
> 

This is turning out to be a fairly typical reaction from kernel
developers, when presented with the "you must first run make headers"
requirement for kselftests.

Peter Zijlstra's "NAK NAK NAK" response [1] last year was the most
colorful, so I'll helpfully cite it here. :)

But seriously...user feedback is rare and valuable. We have some, to the
effect of, "lose that requirement". And we also have an agreement, and
an initial implementation in selftests/mm, on *how* to avoid it [2].

So...let's do it that way? Please?


[1] https://lore.kernel.org/lkml/20231103121652.GA6217@noisy.programming.kicks-ass.net/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e076eaca5906

thanks,
-- 
John Hubbard


