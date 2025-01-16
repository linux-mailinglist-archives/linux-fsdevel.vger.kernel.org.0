Return-Path: <linux-fsdevel+bounces-39440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D61A142A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 20:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C3F1691E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368E234D00;
	Thu, 16 Jan 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="p3rvieCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2018.outbound.protection.outlook.com [40.92.58.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5614AD2B;
	Thu, 16 Jan 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057168; cv=fail; b=QVkpxpRetrTCkUaRq1SOk2GobHK79eT5RnpuJqtwqHVMxpiKtTTZaIAXDP4be+obdU3Xjt5GsKTDkjL44ndfpJNXl7pqXQt140Ys8+hHUWSxkTp8lYRs+F5ybGNEUrK7wRV7BcCLxV3PVy7L8d0g/uI6c1funFfsJor/O+PCUzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057168; c=relaxed/simple;
	bh=c7Z8awd9MY3QqV1zdPXn3UNG+gcQkACnM+O8JL1EYsw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fziLFolTtDWfH7IkRoDUelHXC9BeIdx4oi5T5KvyAtWLMny9U0WO2+EeEH6DJswwqeLDY6bOkK4PaX6eXt0TJ3UvsoOJFGW5uA+goMOZK3PKfo3T7b8uS/ChH5xiaduRVCSLIwLDrldK7lSA+/cgB48A2VgRbNJmkLh35Qz1N34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=p3rvieCF; arc=fail smtp.client-ip=40.92.58.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBVqgifwB4aX6DOcUwI8UOcbRV7LtLsMyLzk/7tec2Fj3YSLVuRSxBH3LEk8PYR2q7tVejQINYtqINXjO4mbF3sDaKAI+HkkvGUN1fxTPZUVA3uYPAwBRB06nWKm2h7bYBecgCXinbHhVl+uZVFrRnXs4bGjQBHAtXD/NWDk4zj57VGQb3BER0mPNKdLdDc7xEgSyCmCCjOGSZ9p1u7ldTbZ/32PmG1fqW+V3Udx6lUGJ3R/iGuAx9Fj17ep6W/JPLu5pkBO5qREJhVjiE8NvzPYQRtTYS+eGUnhbUY/jTsAS6Mj3o3265vkvqLG3Fw1+p1uvX1+s3ZvNz2hKxgDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYGpbKTvwHstBs14GpDgeJGnswRm+Gi4wYr+Q90plmM=;
 b=p4KBFFh9oqDhzW85c8eBtGEwxY6EFtfqjsRJoSLf3nXRgeGP7d9n3bB/Z/0EJpStus2gcISDltxlvrX0AjtIVfOJ9Ulk9a3F2I4gwXozJpDLilngKbtxUUGrfyNlteZhJN07MQ3SSFU/DMsGVUMdb1iPzPgx60ZunneVWQ9EQtxB3rqS1f42fn38Klzk6FjIc7lqIz8Z9tmY8YITMkzdHL+B4UXTNuJ9ZEzfFpcmiHL5THSOtfI2pWJETLkli+xHh3yOydXjo0iF5jHmfZTh5C29VLV9ModQzahCrQmSEnEqZ/ytB8IcmWkQYTGYE1SdaipllGRnfizPx7QFiHRekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYGpbKTvwHstBs14GpDgeJGnswRm+Gi4wYr+Q90plmM=;
 b=p3rvieCFSqoQgGVXop7hWq1qEmMmEC39rv0yXtTDluwO03iSi+UYgvkaKg7gl7ao1b3apTzlYBECjG/O1fzwD6pKxkVQCHsIJ/NJDJA4Lgpda8ikCfDOSNFJLuw+5v+ewdNV7RZWexl0Ed2EBWY9nbFb2sIgo5mOI6871YiwY+l5PmEvM18iqovibPfBgwyIHwQ7rE08dI/cKtL0j0oFJ6P8uh7UOiu1Kpe2V8/ENtwjGPVyKaptj+uJeKVfMLnp7EPe4fGj9kvSI0yXgU1e2xOeEtd6zI/vacgSFgVdzOoZNg+/ETaqKRoAmYZoay//OdBGx9N1cjzbC9DnaPRVMg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AM9PR03MB8055.eurprd03.prod.outlook.com (2603:10a6:20b:414::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Thu, 16 Jan
 2025 19:52:43 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:52:43 +0000
Message-ID:
 <AM6PR03MB5080A4F12672D91CC52345AA991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Thu, 16 Jan 2025 19:52:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: per st_ops kfunc allow/deny mask. Was: [PATCH bpf-next v6 4/5]
 bpf: Make fs kfuncs available for SYSCALL program type
From: Juntong Deng <juntong.deng@outlook.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com>
 <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com>
 <AM6PR03MB50808DF836B6C08FE31E199C991C2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AM6PR03MB50808DF836B6C08FE31E199C991C2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0288.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::16) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <b12782dc-70e2-4260-90a4-eca46e0a65a2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AM9PR03MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 416d63cb-51e4-4987-ca96-08dd366756be
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799006|8060799006|6090799003|19110799003|18061999003|1602099012|10035399004|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFI5cGxBcHIvZXJkdVowNzFwQXhGVlh3SkRUc2pxak9QeDlnT2N1c0NsdFd4?=
 =?utf-8?B?RDJrLzliQUlUYXFlNjEvSTNwVnFMcUozNEkrQ0JSVit2N1NLcnZFQnBRSXNY?=
 =?utf-8?B?UEMreDZZcTZ5YjV1Ti9scDhHVmYrRzJaZXpTOE9GZ3lwK3Jid3ZURm13MFlq?=
 =?utf-8?B?YVdXeWlUOUdWQnM0Zzk4aUgzZU9IMTAxaHJVLzBpaHdnRFR5NUhjNG4ydHlu?=
 =?utf-8?B?VTRFUDcwUmh2Y2FweXN5ZXRPN0tzM3crb2MrRW1icGRZeUZnUWVoVE00aTRp?=
 =?utf-8?B?a0h1RnBLaTlkWk5weEFnMG9mem1hNXJhYTBSWUhrOWR1bWhmdTJWY3duVTZW?=
 =?utf-8?B?clUxZXFNNk8vZUF0WlBReWx0aENmZVdjOGNpbHcwczNncERHdXJJOC9aNmgw?=
 =?utf-8?B?TjVMRmU2dnluaTdOdDd5VTI4VWp1bis4NjIxK3hVNy9xZ0FNTlR2dWNPTG5a?=
 =?utf-8?B?akVZNENjQ1FCUHJuOWxQeUg3YzhWMXZ6VmsxRmJDMVA3ejlqUGFnZGEvUUpU?=
 =?utf-8?B?SEdhY0d2d2pnaktCTWFUR3lTdmM3MUdFZWhJUm5LeHlQVExEMWhSTVZ3UE9N?=
 =?utf-8?B?UnBhMW03R0tlZ2oxazREbjRYZVpTc1pMQjU5V2ZRYnI2MXdkNk44T3laZmtO?=
 =?utf-8?B?Ni9ybjBoTDdZY1NmQ2NQWVpnU0cyMGlwZUw4cVZqVnRaOVRQMlUyZmFaN2pn?=
 =?utf-8?B?eGw0WjdPNXYvK1gvVURVUTliRFhVczlBbVRNMDdpZkI5YkZieUowUmxSNTk0?=
 =?utf-8?B?dHp4d0NpU2ZicUw4YXdKN0ljbUlaTWU4M2p5eVREQUtFejJPMU9jUzJOOGU2?=
 =?utf-8?B?UFhOS3R5YWJvdWxQUEw4eXdqRitDanRVM0FvdnluazNwcXNNWnVXL3ZabTJh?=
 =?utf-8?B?ZVJ3R0RoVFRuNGZ6cTN2c2lacHZHVU9vcXh4SFJkQzQ1bnowaEsxWm40RWRI?=
 =?utf-8?B?Qk9oVDR3U0RDcXF0Q3J5eVAxSnNGTVZUdW9Xb2NTbHRpdzNKTkMyTnpCREYw?=
 =?utf-8?B?U3lTSkl6THRlY1hhZTk2OHE3YzkxUWMyL29US1RxRzZJWUpSaFFLNVBzdXEw?=
 =?utf-8?B?QVpnMmdkWGFhM0ltK01USmhBVjIvWm9KQ0gvMVFvRTlDZXdUaWdoS3hTcVF0?=
 =?utf-8?B?dmZnM28rNkJ0Si91ZFpiczdURm5ZTjVKdUVaTTk1eGpoUUxWR08wczJrUWt3?=
 =?utf-8?B?Q3ROODk5VGJHaHFweStvdmFUQ01ON1l3ZVpqSUtzZXR5U3YzZXIwcnVINTFU?=
 =?utf-8?B?cjM4bmc1eHhkbi9vakMyeGRjUXR5aDZGVzQzTUtJdnlLbHNTRTd6RjBpZUhN?=
 =?utf-8?B?RXRCRFpNamlyTWdWTDVEbFdMQW1ycllKZWt3blQ3NDhpbVI2TXZUYm5ORzJ3?=
 =?utf-8?B?ZXRKS0pFUlNBejFCdEdLOVYvRXVZS2RkL29CeUd0c09oRmVjWFJJcnkxYnYx?=
 =?utf-8?B?akc2amVDRUVTeER4QjIwN1FNaHAvcEQwK0NtU0NGR1E0TnM2QnVJbHpnZVdr?=
 =?utf-8?B?RUVXM0tBa3NIVmpIaFpkd3RDbERoRXZuRzN4YWNiNUlNajA4aE5uZzVQcXNF?=
 =?utf-8?B?VTJUbms0bWhsMjY3Z1BKQWZBMmtIQUNsd1M4QmxiQStXb253Z2ZwTy9UWW9q?=
 =?utf-8?B?VFVaRFdwN3ladytZQXkxYm9LRmdXSEE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnR1MjFMQldqWDdmWjdaYzFzb2dybHI4RFJwWnFqOXpUVzIyMEIvd0dKcXUr?=
 =?utf-8?B?OTRyTmZIbExUYmFqRzlFYUI5VGVWdmR3MHFzbmtZUi9tQkhuS2NmRUptcWVG?=
 =?utf-8?B?QVVHOE5GMmIxTFNzckZQVTcvdm8xTThFZmtnMGZxbGcyaHRJZVhVYit4dUFZ?=
 =?utf-8?B?Nk91Mi9jMm5keHNxL0tQSmUrZnpNV25rOFBEbFU2MTdld1ZPdHpZQXFHTFM0?=
 =?utf-8?B?eG85dVpTMU9sVm9IRldMOFlpaG1NekxKYWxxd085QXF4WW11VUdUVUc5a1Qz?=
 =?utf-8?B?UXNvZFkrV1JTZDhYTE92TGMvUzNpVEFTcW11bzFNODN6S01KRDRxSHR2WFVK?=
 =?utf-8?B?bC9FSHR6QzdTY3RtSlVvRXVvVlZkbHdvTFdBOGJnalMyV1Y3alZkVVhQVDky?=
 =?utf-8?B?NUNySXVQYjU5a1RqRTc2bkQrWUpYeFQwTjBHdkNBY0lLZTJFcGVVYmRGMldv?=
 =?utf-8?B?RDVvUEN5M3JFNTVJdjI5OFpWV2JZTzVsa202VnNGU2N6bHh6VE0zWndYTlpr?=
 =?utf-8?B?alh1VWdFTFEvNnlORUR2M3VJWDVCY2ozbjBIU0JZR2txTkFLZHNsQkIybVFx?=
 =?utf-8?B?Q0t1ZXk1MmlEdFFpbTlIcEM3MVJJS3dOUlVHVk1XdHNYNXdXd28zeW1RU2Zw?=
 =?utf-8?B?UjR0Ti9TYlpkcUI0cHRvS3FKY0F2aDJhRXFkYWRyYVhjdGFtSklrVGFVaXFY?=
 =?utf-8?B?OTB4YnFYREI2UlVIcWYzVmV4bXNxcG0za05ieUVQRmpPWHZsVjRrLzF2NVIy?=
 =?utf-8?B?L1RGTUR5WWFuRFg0M3crWmFETzBraWNhUW45cjkyOGNKRGJJdm9hNGtoNnoy?=
 =?utf-8?B?cndjbWNWaUJaUTFXcGRCbVlaV25MVmc3L2ZwL0tOTERnc1l0UmNTK1hweU9G?=
 =?utf-8?B?VHBjUTFQY2U0L1BkTzE0ZzNoSGdPS0xyMlBWcHFTKzk4ZUpFWC9jdDZYbDFW?=
 =?utf-8?B?WEdmc25wbURSRXBMWlcyZnNvVHJwZDk5UUZRWERwNDMzMjlmSWZ6RHVON3Ny?=
 =?utf-8?B?VTdoS1hEcjVZUFVEd1RycmNZN2FQU2ZGK1VQcTdnRFJ2TVM5Z3J6TkF3TmMx?=
 =?utf-8?B?Y2VBTEs5SzZROU5rT2Jib0YxWXgzZlhaZkxJYjV4aURPcXY2b2YzYldIMUR5?=
 =?utf-8?B?Y0ZsbHdxWkVwRVZpL25aMVhVNTN2VlVWOHQvaVpQZjc0Z0VpMWk3M1J4bVlz?=
 =?utf-8?B?bEVBSWhERkZrcHYrRGVTUkJLeGJwejc0aGEyOEttV24zVUhWbXpJdGp2eXgz?=
 =?utf-8?B?blZxWi9KTHc5N0c2eW84U3RkN2RseVVmUHY3YUtxRUhmVGFQdUtFZWhveUJw?=
 =?utf-8?B?bVZHODJoV3NWeGNUc3AzTkNsRUNhd2MyY2labTNhQ3JRN1ArRExRTE4ydDdZ?=
 =?utf-8?B?aEt6SWk1S2cwVnVYdFhJdmZzTWovbkgzU3Nyd3NrMjl6MHZGV3ROdDBHNnN4?=
 =?utf-8?B?K0pza3A2c2F6bk9tMWhYTERVSUdmQTdnVkdSU2RyVnB2dXNWWTlBbWxOaVQw?=
 =?utf-8?B?dEl6b1ZPZ2xiejVwNFhZeE5OK1VpVVAxSnIrWUk0cEZIdzFEcW1TMGh4VTJK?=
 =?utf-8?B?c2daWm0zR1FpY3JXK09Rb0hhSC82SS9xL3JBd2RkRmR4NlRYb3oxTEtUUHZN?=
 =?utf-8?B?NEJQb3hWZWZCV2lhOE95TGxXK29QRmxxbWZtekZ6ZFVKaGZaMzAwaFlraldZ?=
 =?utf-8?Q?V8ebl23mqpkkq7gAPw18?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416d63cb-51e4-4987-ca96-08dd366756be
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:52:43.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB8055

On 2025/1/10 20:42, Juntong Deng wrote:
> On 2025/1/9 19:23, Alexei Starovoitov wrote:
>> On Mon, Dec 23, 2024 at 4:51 PM Juntong Deng 
>> <juntong.deng@outlook.com> wrote:
>>>
>>>>
>>>> The main goal is to get rid of run-time mask check in SCX_CALL_OP() and
>>>> make it static by the verifier. To make that happen scx_kf_mask flags
>>>> would need to become KF_* flags while each struct-ops callback will
>>>> specify the expected mask.
>>>> Then at struct-ops prog attach time the verifier will see the 
>>>> expected mask
>>>> and can check that all kfuncs calls of this particular program
>>>> satisfy the mask. Then all of the runtime overhead of
>>>> current->scx.kf_mask and scx_kf_allowed() will go away.
>>>
>>> Thanks for pointing this out.
>>>
>>> Yes, I am interested in working on it.
>>>
>>> I will try to solve this problem in a separate patch series.
>>>
>>>
>>> The following are my thoughts:
>>>
>>> Should we really use KF_* to do this? I think KF_* is currently more
>>> like declaring that a kfunc has some kind of attribute, e.g.
>>> KF_TRUSTED_ARGS means that the kfunc only accepts trusted arguments,
>>> rather than being used to categorise kfuncs.
>>>
>>> It is not sustainable to restrict the kfuncs that can be used based on
>>> program types, which are coarse-grained. This problem will get worse
>>> as kfuncs increase.
>>>
>>> In my opinion, managing the kfuncs available to bpf programs should be
>>> implemented as capabilities. Capabilities are a mature permission model.
>>> We can treat a set of kfuncs as a capability (like the various current
>>> kfunc_sets, but the current kfunc_sets did not carefully divide
>>> permissions).
>>>
>>> We should use separate BPF_CAP_XXX flags to manage these capabilities.
>>> For example, SCX may define BPF_CAP_SCX_DISPATCH.
>>>
>>> For program types, we should divide them into two levels, types and
>>> subtypes. Types are used to register common capabilities and subtypes
>>> are used to register specific capabilities. The verifier can check if
>>> the used kfuncs are allowed based on the type and subtype of the bpf
>>> program.
>>>
>>> I understand that we need to maintain backward compatibility to
>>> userspace, but capabilities are internal changes in the kernel.
>>> Perhaps we can make the current program types as subtypes and
>>> add 'types' that are only used internally, and more subtypes
>>> (program types) can be added in the future.
>>
>> Sorry for the delay.
>> imo CAP* approach doesn't fit.
>> caps are security bits exposed to user space.
>> Here there is no need to expose anything to user space.
>>
>> But you're also correct that we cannot extend kfunc KF_* flags
>> that easily. KF_* flags are limited to 32-bit and we're already
>> using 12 bits.
>> enum scx_kf_mask needs 5 bits, so we can squeeze them into
>> the current 32-bit field _for now_,
>> but eventually we'd need to refactor kfunc definition into a wider set:
>> BTF_ID_FLAGS(func, .. KF_*)
>> so that different struct_ops consumers can define their own bits.
>>
>> Right now SCX is the only st_ops consumer who needs this feature,
>> so let's squeeze into the existing KF facility.
>>
>> First step is to remap scx_kf_mask bits into unused bits in KF_
>> and annotate corresponding sched-ext kfuncs with it.
>> For example:
>> SCX_KF_DISPATCH will become
>> KF_DISPATCH (1 << 13)
>>
>> and all kfuncs that are allowed to be called from ->dispatch() callback
>> will be annotated like:
>> - BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
>> - BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
>> - BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
>> + BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
>> + BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_DISPATCH)
>> + BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_DISPATCH)
>>
>>
>> For sched_ext_ops callback annotations, I think,
>> the simplest approach is to add special
>> BTF_SET8_START(st_ops_flags)
>> BTF_ID_FLAGS(func, sched_ext_ops__dispatch, KF_DISPATCH)
>> and so on for other ops stubs.
>>
>> sched_ext_ops__dispatch() is an empty function that
>> exists in the vmlinux, and though it's not a kfunc
>> we can use it to annotate
>> (struct sched_ext_ops *)->dispatch() callback
>> with a particular KF_ flag
>> (or a set of flags for SCX_KF_RQ_LOCKED case).
>>
>> Then the verifier (while analyzing the program that is targeted
>> to be attach to this ->dispatch() hook)
>> will check this extra KF flag in st_ops
>> and will only allow to call kfuncs with matching flags:
>>
>> if (st_ops->kf_mask & kfunc->kf_mask) // ok to call kfunc from this 
>> callback
>>
>> The end result current->scx.kf_mask will be removed
>> and instead of run-time check it will become static verifier check.
> 
> Sorry, I may not have explained my idea clearly.
> 
> The "capabilities" I mentioned have nothing to do with userspace.
> The "capabilities" I mentioned are conceptual, not referring to the
> capabilities in the Linux.
> 
> My idea is that a similar "capabilities" mechanism should be used
> inside the BPF subsystem (separate).
> 
> I think the essence of the problem is that ONE bpf program type can
> be used in MANY different contexts, but different contexts can have
> different restrictions.
> 
> It is reasonable for one bpf program type to be used in different
> contexts. There is no need for one bpf program type to be used
> in only one context.
> 
> But currently the "permission" management of the BPF subsystem is
> completely based on the bpf program type, which is a coarse-grained
> model (for example, what kfuncs are allowed to be used, which can
> be considered as permissions).
> 
> As BPF is used in more and more scenarios, and as one bpf program type
> is used in more and more different scenarios, the coarse-grained problem
> starts to emerge. It is difficult to divide permissions in different
> contexts based on a coarse-grained permission model.
> 
> This is why I said that the BPF subsystem should have its own
> "capabilities" (again, not part of Linux capabilities, and nothing
> to do with userspace).
> 
> In my opinion, we should separate permission management from bpf program
> types. We need an extra layer of abstraction so that we can achieve
> fine-grained permission management.
> 
> The reason why I have the idea of capabilities is because in my opinion,
> bpf programs need application-like permissions management in a sense,
> because BPF is generic.
> 
> When BPF is applied to other subsystems (e.g. scheduling, security,
> accessing information from other subsystems), we need something like
> capabilities. Each subsystem can define its own set of bpf capabilities
> to restrict the features that can be used by bpf programs in different
> contexts, so that bpf programs can only use a subset of features.
> 
> Another advantage of this approach is that bpf capabilities do not need
> to be tightly placed inside the bpf core, people in other subsystems can
> define them externally and add bpf capabilities they need (Adding
> KF_FLAGS can be considered as modifying the bpf core, right?).
> 
> Of course, maybe one day in the future, we may be able to associate bpf
> capabilities with Linux capabilities, maybe system administrators can
> choose to open only some of bpf features to certain users, and maybe all
> of this can be configured through /sys/bpf.
> 
> So, how do we implement this in the verifier? I think registering the
> bpf capabilities is not an problem, it is consistent with the current
> registration of kfuncs to the bpf program type, we still use
> struct btf_kfunc_id_set.
> 
> The really interesting part is how we allow people from different
> subsystems to change the capabilities of the bpf program in different
> contexts under the same bpf program type. My idea is to add a new
> callback function in struct bpf_verifier_ops, say bpf_ctx_allowed_cap.
> We can pass context information to this callback function, and the
> person who implements this callback function can decide to adjust the
> current capabilities (add or delete) in different contexts. In the
> case of bpf_struct_ops, the context information may be "moff".
> 
> In my opinion, capabilities are a flexible and extensible approach.
> All it takes is adding a layer of abstraction to decouple permissions
> from program types.
> 
> Of course, there are more other technical details that need to be
> figured out, and if you think the bpf capabilities is an interesting
> idea worth trying, I will try to write a minimal POC and send an
> RFC PATCH.
> 
> (Actually I have always wanted to write a POC but in the last two weeks
> I have been busy with my university stuff and really didn't have the
> time, but now I finally have some time to try it)
> 
> Yes, maybe I am a bit too forward thinking, at the moment only SCX has
> hit this "wall", and at the moment we can indeed solve it directly with
> KF_FLAGS or filters.
> 
> But I think the problem will persist and come up again in other
> scenarios, and maybe we can try something new and maybe not just
> solve the SCX problem.
> 
> Does this make sense?
> 
> Maybe we can have more discussion.
> 
> Many thanks.

Hello, I sent a proof-of-concept patch series of BPF capabilities [0].

[0]: 
https://lore.kernel.org/bpf/AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#t

