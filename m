Return-Path: <linux-fsdevel+bounces-50447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B9ACC493
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6299D3A4730
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637822A4EF;
	Tue,  3 Jun 2025 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cQQpPzrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C42C3263;
	Tue,  3 Jun 2025 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947359; cv=fail; b=TWDa8yFofCpPOuTpOerf2x5aX8QEfc5Qiarwbb3gF+Mu8J+lXZfQU/XrN57lchvFyLoa00cONMRGzyDlVe3GO8hQVmcxDMRZbt4zWSlZSa2K4a8utLefQXRgILZlwHtn0GhSyqNmpTXIr5fvYjQlUKEXH9Wpuf2yLqD/kMCAPUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947359; c=relaxed/simple;
	bh=KmQq3fQ8INUNPBlIF5HO47+GmdKdVN90NoIi4O/BsYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CbEhZ56a+aScb+uvpyCz6Juwg1Ss1R19/IXGnTgXo/l2JtnhSsBCTcJMV718MJAYaXLlnrbDv+1YCPsDZekotluymXx+R8qB0cf4O/0RDDMU46Th56uI3IYrF+XUQ0EHNKK/MszROu7vOROmg3rwlWyBeELJNx8UseMLf+98YWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cQQpPzrf; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOYuCfo2fSx45oBHmg8SPwCLQ9/S0pMGq/y71kBnFL/1a1anLTjWnHM8jP6P9gdjk2wROilvQ8B/rRL8crEJPQwXCBmCOK6XupyL4sG+3FnqH1R6+FSi4+Tjrk6aw+9z/sZsiQ13IL8Pd/lwqb6kpL2Vt+f4qFSvXd2bWsTcwpiIPwBZ+LNF7GWW2CVx6XwDQiEH/UipofT8IUro3v3kRBPb6ofjoSW9aQ4o8TDoWJuYgUmcDGf2m5PolzMUVFCLo7J3qe/m6Wo8S4/OExD+VDnQlA2myS4d1vSvGk+MWmt+hbSPcyub4Z0WKiy6aN80L4E3P2vuWwkW00OHJ8SbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8tyd3y/5UeOKysL/tMZuJCliFYoGRCphFtDLv37FzE=;
 b=yifeOnMgVC/wj9Kn9AUyC+d05br07kqlrKq3woKUbhmJFA0cNVRIjk08LxQrLkiOHfptxcfIhy0OqLGShgoqP/3QCEaJ4rwjjmGfb7geHM9p+BY8jNtLMC6squ+uaGuuKlt2S+H9JxY3WgApW2m0jPsWV5+phko92fBz2h7WdsxAbb2+oLL8V76BVJKwyBgmMGV6jLzxrqh98VkSVGAZ+J9u31ujeD80hZY8VXjPXCtm49bhv64hWw+bmSr+qKvjwE0tJlGKr170kcPXNw0+ncEsKxsEJPza88Z59LOi5+gXIxDPF9rECAbYZqKHpGMLAVBBomwp8DSEfXPgsO+suA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8tyd3y/5UeOKysL/tMZuJCliFYoGRCphFtDLv37FzE=;
 b=cQQpPzrfMSuH/TfZ1M+uPOH0KhBWlAiyBp6qKjfA5+2N/TGa58iBLfBfKKHZVrBhSn71FQFADV+/WbiJVcOQJyZfTZ1xBQ1osYk5r8AZiYwPcaqaPBl4XsYenRzRMDxXBbD+oY81rKrF7Au2Y+nGW7k9CxsPauKJoXQfCYpFzC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Tue, 3 Jun
 2025 10:42:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 10:42:35 +0000
Message-ID: <ec85db1b-d536-4954-bad9-d5b1f3388492@amd.com>
Date: Tue, 3 Jun 2025 12:42:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dmabuf: Implement copy_file_range callback for
 dmabuf direct I/O prep
To: wangtao <tao.wangtao@honor.com>, sumit.semwal@linaro.org,
 kraxel@redhat.com, vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
 amir73il@gmail.com
Cc: benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, jack@suse.cz,
 baolin.wang@linux.alibaba.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, bintian.wang@honor.com, yipengxiang@honor.com,
 liulu.liu@honor.com, feng.han@honor.com
References: <20250603095245.17478-1-tao.wangtao@honor.com>
 <20250603095245.17478-3-tao.wangtao@honor.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250603095245.17478-3-tao.wangtao@honor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: eee55a24-341f-458c-6d70-08dda28b59eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGxXUjRrTk9TM0pISnFiRlkySnhHZXNpRjJkc3NISWExaW14ekpsVU12Y0Fu?=
 =?utf-8?B?T1BlY3VKNEZwTjUyY1JHQjlCdS8vUllCVkpCZmp3OWJ3akZmSXVQVW8yM0FQ?=
 =?utf-8?B?c0o5cDUwcUFFYWxVNUFiNXBvY0E1OHZaejlJWWZBNllsYVJTRUltTnU5cFhG?=
 =?utf-8?B?VllUM1R1M25rWi8xeE5oUmd2NVhYWjFiOFBLQ3MrUm5PcDdmZldTek1ZMnN4?=
 =?utf-8?B?MmF2L0hVRkRuMEJ6MWpWY3ptN0xuYTlTVDJqUjI2NTZub2ZiNFFtYkozajlS?=
 =?utf-8?B?NEpIaCtiZWJ0elRSeUMwNzYwQUJKWExCNFVURG1xRjM0NENwOWZsQTZQalg2?=
 =?utf-8?B?eTFUNE9qU29yUUcxN0RYSXpFNk51MG9yOENSN0ROUi9PWWQ5Z2VsVUNXYWt4?=
 =?utf-8?B?Wjd4c200T2czMDhNL1hSVVlia0F6NVJMYjNiRWZxbWFObTF2emVrSk1EYXlS?=
 =?utf-8?B?c3dZQ1ZTTlJGTUtTZnR1cHptSjV4dUhCc0pwSHVNcjVOb21id2Vacm5abVoz?=
 =?utf-8?B?Z3loekh3K1lpcjFuTThSQmE2clBRWEt2Vy9YWlQ2L3ArWkU5d252NkJjZjla?=
 =?utf-8?B?aGtrMWRjS3pHVVNkMmpqR2R5QW1vcndVK01MZHA3TGNzQUduM3E3K3BMRXNM?=
 =?utf-8?B?anJHbHplK1g1dWhDdHd2eTVvSEhiVUVKNFdFem05NU5PUzRLNGF2ZWdrcHdP?=
 =?utf-8?B?SzY1QWljRDJVUEtrdEM5VUh6UDZlSGo0OUR6ZzMyK3JvRjB1NnVpL2wwdzR1?=
 =?utf-8?B?SVBaRWRyR2hndWU2eTRKdkdwK3hEdm5RQllLbmc4eDJsSGFqdzl5azlSRzJ4?=
 =?utf-8?B?bzNkbnNhR2tZSUQ3NGNrQXdVcy9TVmRzTjRaby8zR1lCUks5TTV6ZjNpQWRL?=
 =?utf-8?B?bUZTQVNVVHcraC9QSUU0TCtZVkF6M3p5L1NxQkhBR2pDSm84ZFJHbTJ1UjBP?=
 =?utf-8?B?WG1QWjRsbGhKSHBhdDllQ3N3N0lpL3BwVVZmSDlFbFdPZjdOQ0Q0dHZ6dG1z?=
 =?utf-8?B?dGc1U3hvZi81amdDZXFxS29qYTRRdFJhamd4NUNHY0FROXV0TGpiOU1CZzZw?=
 =?utf-8?B?a2h2VWhqdkNsRGV3WndSYWFSUHE5NzhHdWlvZFJrUjdRS1FKNjdxOVNaZVVZ?=
 =?utf-8?B?dmJpU2dqZnZUelliMlVjRjk1bVloVVYrUThwQmJ4VWtmdlR1QnYyK200bkFN?=
 =?utf-8?B?VnlLc3VmcGxNYmVBaEZrQmVCRERUVDZvbytNV0s2RFVtM0crRzBCdGtCczJ2?=
 =?utf-8?B?QjN0RkR2Znhlcnl1MTQyb0lmNFlLVU5PMEVTeWtHcmxKWVlhOVNIOWkwdXBn?=
 =?utf-8?B?TVVJTmVwVFlFenpDL04zYTRCL0FWQ1FYbGU2eFk1SkF1dUFrM1VNSWExZHBm?=
 =?utf-8?B?OWxpSVhLUSs1QjNIbHhCdDByWGg5TUV0NTlxSEZiUjFSOXFIS2gzVHNFVFZI?=
 =?utf-8?B?bThGZnl2ZkZjUzJQQTB3MVFFeDJIcmExVlViUnFob0RSYnVPTzJpMFFESzFJ?=
 =?utf-8?B?NG5GUFdDNkRJOWpaWlpCY1ZndmtWZ0E1UkRqNTFJQzJESFZIQzN5UzdQUVZT?=
 =?utf-8?B?MXFaaVlvOXFGZnNpZU5xNDhlbXg3Z0djK0RiQ1VuY0gvQWpIeVUyaXcvcGgw?=
 =?utf-8?B?cU9nTjVnWEtHRUtRR01HbTFtUzgxT01hdGdhR2ZxbVZ4UzVHQ0V6bzNZQXJp?=
 =?utf-8?B?ZEpkQytHUXJCeVJZQUpwK0NiQ2hvWWZ0Y04xaXd3QW9PNGlMSXNFZ3l2UUZw?=
 =?utf-8?B?cythUlUyaGpnNnRtaVhVQ2FuZWtRNmF4SE1hR3B1STUxellvK1dtZElxdWg5?=
 =?utf-8?B?Y2o3NzU2OHJid0RQOXRYY2wyTWROZ1dwaGdhSzFudURXTExDZGhURjdVYlNF?=
 =?utf-8?B?bmNzTUQvc3RLT2owOFpPMGtyRDFaTkJQeFpIMER5Y3Y0Z2VkOHVHY2Vacll4?=
 =?utf-8?Q?zVtyxkbP/E8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlBjVG5nUlY1QWEybm9JdTY1QnlFTm43MlhXV0JHaUtJcWFoV2F5WWZHUEZS?=
 =?utf-8?B?VlNpYTRxeUhsODVpdS9lWklKQkpzN1YzcUY0VDZhTnRkMnJtRnMyaUtSR3pX?=
 =?utf-8?B?SzFERDNvRVFvb1A0U2hLZlZGdkc2NHkzZGFwelRxSEtQd1pGWnhQNFE1cnRa?=
 =?utf-8?B?ZmdNa2x5dkwzUmpyaFlZaFFZK1NwdWJ0USsrdGFVZ3I4RjcwZDRxNXk0K0tj?=
 =?utf-8?B?aWgydEVkbzd2elFaUFNyZVlkdnp6QUxueWNieHBLQ3o1N3V1WjR0WTJPL3dZ?=
 =?utf-8?B?Z09kVlRxVitFSmIrMkx6WDlHalZlbXFqclpCMko0ZTA1aU1aWlBMWlprQmR4?=
 =?utf-8?B?TmV6TVZLRmoxWS8vYmhVMkk0Zi9NZlBHREJjYW1ob3RRaTAzcEhzOXBGL21z?=
 =?utf-8?B?bHZBTkk4RXF3UTRoRE5VZ1pvNEs2VHlQUGhMbHFYbTUvNjlGWTBGVTJPa3Qv?=
 =?utf-8?B?RU9iMlFrYnJLWklyMFY1em5SV2szN2kzSVY1TlZsZDl5RmJnbkx3VER4ZjJY?=
 =?utf-8?B?b05ITmVrRHR0L3dhZTlsUVJ1ZHcwK1FaT0FJSjJuTkpmTW5ZRUNTNzZGMWJH?=
 =?utf-8?B?bmVibEJGTDM5MjZpdm1MUWlhQXNseFdodUtXV3FYd2szcHlXdk54ZVpkeitj?=
 =?utf-8?B?UkFRRjNVdHd3U29WUXRFNitIMVZoN3ZGczBUQW5BamJ0VlNWbUdaOUgyY28w?=
 =?utf-8?B?QTlHQTQ1ZThJYUIxNEJnMFpYa2c0NDhvUWcvWFRLZzVoSzhzMXBFenQ5VUoz?=
 =?utf-8?B?ZTNPbE1PeUJJak1scVpYVndsTVZZaFA5bHRsRGhGSmplM0lhcVF5Z2U2Tmw1?=
 =?utf-8?B?VFB2RTlKSzhkeE9LS290Z21HV3U4VUdITkIzMFlHMXZqaWdodUZsRmlGUWR6?=
 =?utf-8?B?QzBlWDR2VEhRSjVmQWxWb3BCYkZkOVZ3QU5MbTArM3RoblZWRGpQeDBnUHVZ?=
 =?utf-8?B?SVQvZDNmRCs0dFY2VEtydThaL1Q2dW5PZnB5WWRnK3dKczQvRitOeVVEWUtw?=
 =?utf-8?B?YlpHRUxNMXZqNXZROG5vbmkrYVpuT0pvTDVlYk1MS0FxR1RIVlZ0d0lpdlJx?=
 =?utf-8?B?Y0pXUzlFQ2lsYXY3Ulh0MEo3ZG84aXJabGY2eEdHaUZjc2llclJrUUNPeFgz?=
 =?utf-8?B?eTNSaHBmc3Z4YnpxQ0ZpaE9qY0piWFNqZExzUUovMVFYYmFDcFNQTnBYY1dD?=
 =?utf-8?B?TVBHeVd2Q3ZlWGwvZCtNR3ZTVlY5ekdKQ0lkekQ1QlRDZ3cyMDlPQ2pHRG9P?=
 =?utf-8?B?ZHNwOEhjTjd2NDRiTURNMVlkVlE5ZXdyS2docmJYNnlrbkZ0SExTNEtJaGRK?=
 =?utf-8?B?UDI4aTQzUXZseEtqeWRoVG91M3VOM2ZVZUVIZVQ0THJRN1FQU3AyM09rTGRw?=
 =?utf-8?B?b3VRSkJyUnJaWktnc252YStFa0laTXhKTGNJMWNWOC9OR0xGMjAvNmdERHVT?=
 =?utf-8?B?dDNZMzgyaVpzRXJDTWR6VjllRWVZNEluS2V1aW5yTkFESmFjMzhXbzR1eG1S?=
 =?utf-8?B?ZDBmbjhvZ2Y2ZGlJTWxoeW53ODVXTzJRbCtaNEJQdll3RDFIdUFJR1BQWnVi?=
 =?utf-8?B?dVpJUEtBVVVCaVpvelE2ei9pY0RnYys4MS9DeUR2cTM2eEdEMk05azZoeGZt?=
 =?utf-8?B?NHJSSUc2cWRUaFFOVjFtM1RnMkdoSTlGcUFxUGJGUGIyL1RObnlJTllRWncv?=
 =?utf-8?B?NlVQTGRaZVU1KytaRXhoZGY5VDM0dTAzU0M1MlNFZ1p4NS9PaTRyUlhUcXV1?=
 =?utf-8?B?ZitiU2ZWamZoNXU0MmFBNC8yVUhvd0RXOWwwRDlCMnJaZWlhLzBZdGhFbC9w?=
 =?utf-8?B?WU1zOEhJZG96Und0QXo3VjFYNmRNdnVJR2oveHM1em1KaXFYNEF0Q0hTZ3Bk?=
 =?utf-8?B?clBIREhKN252ZTFDQUtzNHJwSnRRZjNEZlFtYi9OcVJEWEdMWGhDUkhSUWpP?=
 =?utf-8?B?WDNpZWdZSU95aS9EMVhhWGhPZ0xiUDhUMEkyRWdaVlNwd1ErTFhTZzFEejFl?=
 =?utf-8?B?ZXdTTEcwUjFuMExmOGM2RUcyeXRDVTlkSEgrbUZCK2g3azNjdW16UVU1by9l?=
 =?utf-8?B?ZUlIN3FyRnpkS2YxQ1ltR25adkJydnRnZ3BBcWQrZE81WDFNTGRCb3J5bU44?=
 =?utf-8?Q?c1BOZkvIEs880Nn6eKDrR6dPn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee55a24-341f-458c-6d70-08dda28b59eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 10:42:35.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +24txkdycrIt8FJrCmtdPOj9jjG5rNw8iIm6u+Z1YMmMhyn5ep3tP8c2YCMGs1UP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863



On 6/3/25 11:52, wangtao wrote:
> First determine if dmabuf reads from or writes to the file.
> Then call exporter's rw_file callback function.
> 
> Signed-off-by: wangtao <tao.wangtao@honor.com>
> ---
>  drivers/dma-buf/dma-buf.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 16 ++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 5baa83b85515..fc9bf54c921a 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -523,7 +523,38 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
>  	spin_unlock(&dmabuf->name_lock);
>  }
>  
> +static ssize_t dma_buf_rw_file(struct dma_buf *dmabuf, loff_t my_pos,
> +	struct file *file, loff_t pos, size_t count, bool is_write)
> +{
> +	if (!dmabuf->ops->rw_file)
> +		return -EINVAL;
> +
> +	if (my_pos >= dmabuf->size)
> +		count = 0;
> +	else
> +		count = min_t(size_t, count, dmabuf->size - my_pos);
> +	if (!count)
> +		return 0;
> +
> +	return dmabuf->ops->rw_file(dmabuf, my_pos, file, pos, count, is_write);
> +}
> +
> +static ssize_t dma_buf_copy_file_range(struct file *file_in, loff_t pos_in,
> +	struct file *file_out, loff_t pos_out,
> +	size_t count, unsigned int flags)
> +{
> +	if (is_dma_buf_file(file_in) && file_out->f_op->write_iter)
> +		return dma_buf_rw_file(file_in->private_data, pos_in,
> +				file_out, pos_out, count, true);
> +	else if (is_dma_buf_file(file_out) && file_in->f_op->read_iter)
> +		return dma_buf_rw_file(file_out->private_data, pos_out,
> +				file_in, pos_in, count, false);
> +	else
> +		return -EINVAL;
> +}
> +
>  static const struct file_operations dma_buf_fops = {
> +	.fop_flags = FOP_MEMORY_FILE,
>  	.release	= dma_buf_file_release,
>  	.mmap		= dma_buf_mmap_internal,
>  	.llseek		= dma_buf_llseek,
> @@ -531,6 +562,7 @@ static const struct file_operations dma_buf_fops = {
>  	.unlocked_ioctl	= dma_buf_ioctl,
>  	.compat_ioctl	= compat_ptr_ioctl,
>  	.show_fdinfo	= dma_buf_show_fdinfo,
> +	.copy_file_range = dma_buf_copy_file_range,
>  };
>  
>  /*
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 36216d28d8bd..d3636e985399 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -22,6 +22,7 @@
>  #include <linux/fs.h>
>  #include <linux/dma-fence.h>
>  #include <linux/wait.h>
> +#include <uapi/linux/dma-buf.h>
>  
>  struct device;
>  struct dma_buf;
> @@ -285,6 +286,21 @@ struct dma_buf_ops {
>  
>  	int (*vmap)(struct dma_buf *dmabuf, struct iosys_map *map);
>  	void (*vunmap)(struct dma_buf *dmabuf, struct iosys_map *map);
> +
> +	/**
> +	 * @rw_file:
> +	 *
> +	 * If an Exporter needs to support Direct I/O file operations, it can
> +	 * implement this optional callback. The exporter must verify that no
> +	 * other objects hold the sg_table, ensure exclusive access to the
> +	 * dmabuf's sg_table, and only then proceed with the I/O operation.

Explain why and not what. E.g. something like "Allows direct I/O between this DMA-buf and the file".

Completely drop mentioning the sg_table, that is irrelevant. Exclusive access depends on how the exporter implements the whole thing.

Regards,
Christian.

> +	 *
> +	 * Returns:
> +	 *
> +	 * 0 on success or a negative error code on failure.
> +	 */
> +	ssize_t (*rw_file)(struct dma_buf *dmabuf, loff_t my_pos,
> +		struct file *file, loff_t pos, size_t count, bool is_write);
>  };
>  
>  /**


