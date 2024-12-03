Return-Path: <linux-fsdevel+bounces-36310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B869E1298
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 06:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B6F28208D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432A16FF4E;
	Tue,  3 Dec 2024 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NY6f6TCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E36F2FE;
	Tue,  3 Dec 2024 05:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202122; cv=fail; b=KaMQzZXMJqF9C8fNkqs49yT5ZoDUSot5o3mwDjGgRAxqwVy7VRVg/G5TWYzLr6RMeO9iv7nzSa1D3SSEwLaYF0kih3JVJ1mHF7EDNeUUTJMmA33CSkxswIFO/QxBHv18M8dp5uhF34fA5nfxycnsUBhvm38ORkS/sjbk0Q7RcQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202122; c=relaxed/simple;
	bh=HVmy78erRPlRuoT076t2TO5PslAngXSe7UpadWRveRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aktpomkvRc9mvIxsoyF7GyhoXoxCkImXCCo1zxBNO0P9aH6l0UhyO2d/1KedNv5GSPCa6RZPnI7p9c+xEtmvxY/BsjF22oZjBu+7bLiyDudUY1nsCa8I8YRRYe72OQC/aflvErz51n4jeaYGnWfpPHHlFiK+37jitrp4QNc5EIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NY6f6TCI; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIG938yVTZ4jZTzdmr5aUFsNHVXwNNuASopRH9f6JJYgNTPRg9dmXVnf+19SPzYjEn/C0phHqCOA3cvR9uwBYgV9WnQXDAvxegNWEeJkxcKM/IreK8djaJUd2zxE85dshbOtieAjpxtXbV3T5Lczzt7SYniyuFf490SDZcujQx85A7v2FWc3NXZraqwqESRMuhvRPzzDisEWNuuNO+nIIySUcypC9FBUH2NfkqArWeFswW9WkSKkMFtYPD8iFbNPfIxoo6qfy45tjocj+PvHojdNGmfBdErKvzRXjUzmbLZlOOrZfL9WUqUNVNv93vUwC+lsFR4a5PaMRnSkmcRgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilpaYM/UDZXgtawbog2iIqRviFvZhFt1bSCLIwccudY=;
 b=PXqzVKaT7XkTrSPu4r099YvCC35qLh55+Eb4esjsWZjVDGYCd6U5xfIwshFnmoaS7EfBq8tk2GQrRNb9l0pkX2C4IHmauhA33+gP2Awceh/YdZpPLX5iTy991ZVfSTTx3c06H3oREGwB/EYnKSzxFGdgk/SVwHAYQ4MXHf0iJHy6cbsL4KKnAfLR7THucm8smWs1Nq8lUSvked5pbASIYGKwXvayzpPlIVlbCLjZ3HCpF+IzIdwTJSQBKK5f4Gxx/kTt73hbyoSPd9LO5+8CcsC7YTKG6fl9ISU5y2vm5ARn1lbDnr25YJR1ng1U2RcLEJOMU4F0zHDyRqclmwH8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilpaYM/UDZXgtawbog2iIqRviFvZhFt1bSCLIwccudY=;
 b=NY6f6TCIoqrZuD8KAMPbcrvtTUhU+MYPlRarBHVayBhLuIa/kSWs2bJpJL/jFj0gp66UICcr6vv3Vfue5eyoDeRLnTafWL4Lvf58jAoIv7DGbzASKtS+i3helul2l+kIB2k02z6NySwC96nMFGHY70jncqHXq2BpKHpeOhFS2LU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 05:01:57 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%4]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 05:01:57 +0000
Message-ID: <b8422ee0-974c-43d8-9c1a-3e5e715fbd7d@amd.com>
Date: Tue, 3 Dec 2024 10:31:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com,
 willy@infradead.org, vbabka@suse.cz, david@redhat.com,
 akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 joshdon@google.com, clm@meta.com
References: <20241127054737.33351-1-bharata@amd.com>
 <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com>
 <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
 <CAGudoHHBu663RSjQUwi14_d+Ln6mw_ESvYCc6dTec-O0Wi1-Eg@mail.gmail.com>
 <CAGudoHHo4sLNpoVw-WTGVCc-gL0xguYWfUWfV1CSsQo6-bGnFg@mail.gmail.com>
 <2220e327-5587-4d3c-917d-d0a2728a0f73@amd.com>
 <CAGudoHFSUoLXjEh8bvULXe2bysiW8S6yTcpgzCAgkuPuJxD6_Q@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAGudoHFSUoLXjEh8bvULXe2bysiW8S6yTcpgzCAgkuPuJxD6_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::32) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d631c2-8c79-44d3-d69a-08dd13579ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3hSSVdpZjJwSXBxdEFyOWw2ZkROUjVzWGZzUWxsemUzaGFaVVBtbWVBcEpQ?=
 =?utf-8?B?b1VSamxFditYUGtDM2VoazIxWG8vSEQrd1l6MFdaZ1NFYUVnSmZtVkxIZVoy?=
 =?utf-8?B?NUY5bWp3YnYxS08vaGc2L0dwNW12WnJvai9YTE04NFpTUDVQdnp1SXF6akdK?=
 =?utf-8?B?N1EwS2lxaHR1WHhJQm5ZTUhjWnVZMFptTDJWa05wZ3BrVjdhNmtnTkUyVWlD?=
 =?utf-8?B?SUFxRDQ3ekFqL2RPa3JCU1JMcFNld2g2L0dGWHBObW11anorbDUxL3luSFox?=
 =?utf-8?B?WHY1LytGQklWeXI0Zk5TZzJwTDRDMktEQndZUDMyeHhyMmJ5RitReVJRbGxT?=
 =?utf-8?B?Q0JPck1LV3ZVTm5iRjBhRkRjUkluSUlzczlCSE5ia3JkaFdLUWUwUWZzK2I0?=
 =?utf-8?B?VHdlRlhmRkhLb1V2Q3J1eXRham9QekRTTU5DOHJwcUgrRlFmc0cyQzkyYmtV?=
 =?utf-8?B?bUVBWG94aXlEc215SWxVOSszU2N5NUZQdFVWRUZDTEhla3NVanhzanlYZ2F1?=
 =?utf-8?B?ZkVQNzU2RHlzVnZMQklXUWZ0bS83V2xLWk83QThMTDQ5Q2JzbExTcG1VQ09l?=
 =?utf-8?B?NVI0YmxGd1ZHaDdsU0MrNWJKT0JBNSt4c2oycDVldG9HK1Vpa1ROR0QyTjdN?=
 =?utf-8?B?NEx2bGpmQ21wOGFwNTdWK0hYa0pLd2NWVkNaY1JIL2ZxODlPVnNMVlNQWEJ5?=
 =?utf-8?B?ZjdQK3pvSTAwU05RS3F3K21qQWd0SnhjdWVqNWJzbU1zTDNaVUlORXlXWUJ6?=
 =?utf-8?B?QzRGbW1nVFkwUUVIRjBhYkR3Mk5FUXM4dXp0ZDBKSHZ3V1BYRXlDRVlzeTFD?=
 =?utf-8?B?bXdKeS9JRXBtcFFwZ0RCRFMvYWdQenpBMnlydkgrVno5QjZ6RUx5UGF6dmdz?=
 =?utf-8?B?NGdUN25OV25ET1NHc2dwelVUNlZ5NS9pNzBQalZONVBZS3hrRVBqbDkzbERo?=
 =?utf-8?B?Q3VHSi81QTdxcUhvUWRES1ZvaGt1YjlwS3NWQ25pNHF3WVF3eEJUaHBXY24y?=
 =?utf-8?B?N1JLSDczRjRjSlhJT3YwTlArekZ0TlVpTktadDBkdFh5VlFzNzVuczFCRWE2?=
 =?utf-8?B?YlFXbC9QSVVOR2ZFdi9JMXdHRVNOM2JxVUp2bkEwdHlkTVRlcWowcUh3YUV3?=
 =?utf-8?B?cGpMQlArNy9wOWl6SVJzNHhtUlRaTDBUM0YxdDF1a010b21PSDcycVZHU3E2?=
 =?utf-8?B?OVRyL0hMWWV0OHZMTDd6VjdTbDlwcEVYa1p5Mk1pcTJ3WnE4TEgrUGdpdE9C?=
 =?utf-8?B?K2NQMFdWaWgvd1RmU1FpZnZVNEdDNUwwQ0lGTjFHR0h6U3RNQlJrOXlLZ25O?=
 =?utf-8?B?ZEdUaDhEYTNwTVVmYmtYN3JQdVFXT0l1YlJ1cVc0YkNEeWV2a3F5cEF0czk3?=
 =?utf-8?B?YjlyUmlhRTVEQ0huL05laVBJWEhiaFo4QXNuaHlnNXRkWTJKeGQrUXgvNlIy?=
 =?utf-8?B?a0ZpQzVTKzJQaXhuWkR1UWxOVVNjN2prRldyb2ZZc3JGamNDV1FFNE1taGhY?=
 =?utf-8?B?eEhtME1hU3F5V09yNzk5YW0wTUhFT3UyMFVuQ3BhR0pNMDlYREk2OGxEYlVW?=
 =?utf-8?B?cklKV0xmS3JRbEFwRmV3SVRCYmxjcmhVSzVNbktTKzR5UFpCKy90TWx2ZnB4?=
 =?utf-8?B?Q1VGa0UyZTZZaFFWVzZ6U3o2b3pvaFA0TzgxOVdnSDU0eHBNaFdjUmZkZ3pq?=
 =?utf-8?B?ZlhJNW05OGRWdmJYWnpldGpDNld1c3MwR3NFMnJpU1JxQmlYWjFOSUJobGJE?=
 =?utf-8?B?MEV0a0NUOTk5Q2N0bnV3cEswWmNqV0pYS1lFcnRBdFdHMHErWktZeE9pbmFS?=
 =?utf-8?B?MHJVTHNXVVVIeVRSbUhMUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VElNb2E2blYvOFlXY3JUT3p5bTJtNzkvMTR3N3hTaDdGbTdiODhucFVBU1lQ?=
 =?utf-8?B?VzZJSjZNSFJpYTJMa2FYWE9QbVovSlYzMDA5QXhxUWZiNTFqWk9Bb2dsNHg5?=
 =?utf-8?B?WkRLWERjcXprdXhVM2JWWVQ0cDl0NUhrc2hFdFAzeXNkMm02R1U0bHpPdGUy?=
 =?utf-8?B?bmgxQ01SbUx4N2FVT1VxajNMMURIblNPUGdRdSsvQjBpbkJTRS9qOEMvQ0Nz?=
 =?utf-8?B?TTlLRkZEOVd2YUNMa1BDM2VOYkRieTgrTEFtTHFCZGpubVFXaTFRSXhPL1Ev?=
 =?utf-8?B?SVBPOWpKaUpWN3VJSUtJdm1KUXJuUFR5eS90M3BWWnZhcFI5Q1VJQkJqMUMw?=
 =?utf-8?B?VW96NzBmL293aUttbFpkQzdWTkpSNFJZdWlXL2EreFlXc2k4WkMvRmtqMVV3?=
 =?utf-8?B?elVjRzRtQkE2ZVlBcDN1OHJyTFVBNHkwak43bytKeStuMnAveW1OY2ZnSjND?=
 =?utf-8?B?Q3BiVUFKcVpyclQxMjlkbVVxOWRwbUpUT0JsaXBGNUxYT25BRHhzZ1F6ODlW?=
 =?utf-8?B?cWpUWXJwWURmUHkweTJXWjZoalRpa2F0SFdvTVFZSjBEcTRYRmtMajZnRUdj?=
 =?utf-8?B?NFFTcUtKcGI2dEt4UFVTcTRWMERSd25ZM3FCSklpYUl2djBBVVlvd3VTeUdI?=
 =?utf-8?B?N0IxU2wxMXRrV3cyUkV0WFZGM2ZZcldEbk9aVWxxbi8rTXgraUJCbm5PVHdG?=
 =?utf-8?B?VUczaEtjM1A4eXduWmtWMEFYYkltbkV6UkhlV1Y5ZVcvbDEvU1BCWEozWDFD?=
 =?utf-8?B?MjZISjE5RzMxUEJlMzE0UEtrYXF1WXFKR1FKV0xWU1h3RUJEdVJpTWtkK0xl?=
 =?utf-8?B?bTJpcWNCU2RFN1BwQ1VTUzV4ZTdhS2hPVkRpZjBZelduUGdkQUkvYTZxWDB3?=
 =?utf-8?B?NkNxN3dkSURobVh6bElLWnFqMnF1b3dwZCtUZ1U4blYxbmV4bTA0ZFdUeFJz?=
 =?utf-8?B?UDJiYjRrQUVUaGw0UEZ4eC9EaHN5YU0zR05uRkxOczF2djhOODdDRG1XaGxW?=
 =?utf-8?B?bDZ0Z3FkYS85Q2NSazNwUjV1Q3VZRTN0S3M0bWVJMklkQzM3UExMVjFSaVZ6?=
 =?utf-8?B?NGRoT0J3Tlgvc3h6SjN4UktlOWM3OHdsZG9jd0tlWWZJWXNJa0JwOUpOdXda?=
 =?utf-8?B?eGdIc1hLankyYlh5Vyt0Uy9BWlp6Z1lWc2lOdlRYUnNaeVo1aVJ5aGVBY1hW?=
 =?utf-8?B?cnhJQlg0UmM0R1ZRZVZwT25iN0p1dUxiTGJKQWs0eVZCUDZSeFdkMVhxeUJ2?=
 =?utf-8?B?RGVJS1JNbHZZd05TWWJZcWxycGpGbWVFL2RyeVp4MHhRVTNLVlMxRUlGTjcy?=
 =?utf-8?B?TG8vWlY2cGx4VGxyOFBPS01HVEpuazl6U1plZDIzbW16LzVCdWpJVVZzQUoz?=
 =?utf-8?B?ZDFnV0FwUnNGMGRJZldTVmsyVDMzTmZIYys0TGtXamhmbnNnRmJNOVBNdkov?=
 =?utf-8?B?bUZCbTFYcmk3Wm1mcGt0VGhPZU5va2JkMkw5d2JzRzFsaUZjR1VqZXNGaXpJ?=
 =?utf-8?B?RXRHQzBCUHNyYVBSd0t1YUNNMk13bWhJM0tTdWhQTXh2RkZnOEtNTGJqMGhp?=
 =?utf-8?B?SlhyVnFvTlFVa0t4MG9UKzE2YXN4MlJ3c1JMdWpKTm95WTllOGNBRm0vcWQ5?=
 =?utf-8?B?ano0cm15b0gyd0VjUVhoREtjZVVnajZ5dmpIamhocnJjMWQ3ejg1N0VDR2F1?=
 =?utf-8?B?WVNHZjY2NU50dU9RR091RjRtaGl4M3hwRk8rNGE4L2xyYXZzL0J4MjJGVjF6?=
 =?utf-8?B?OTc3SXNhVSt5bkJvK0g2UzF4cEFIVnNJMmhPVUhQZkhTNmszSll4UjdMT2dW?=
 =?utf-8?B?cTRZRlQybks1Mk1qRTJzUWU5dEY2RUUyeW5uQlcyK3FuL09BYlViaG9IK0Vr?=
 =?utf-8?B?bFROQmVXRGpLSlVhaW1uc09NclFscjNZU2YzWGk2RXdFelRhU3JZQkVRYnZR?=
 =?utf-8?B?NklpWnNCT3hnb1JjTVFieW9OYlBpdnhaTDlFNXpud3NCcjBWeUdYUUMyVHpP?=
 =?utf-8?B?SDN6WFFvMldBSXhpT3ZZYmpqNXpDVDhNRjVIS1lWaWRTWEVpblNiZUtUbk9k?=
 =?utf-8?B?c0RuNEVXSTZRSkw3V1BzaVFOLzJSWWp0Zzd5d2hteGVnUEhGVGloSThRYmZU?=
 =?utf-8?Q?pttzsrOdKfcy0uMquHGEdnY9L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d631c2-8c79-44d3-d69a-08dd13579ce7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 05:01:57.4950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLPuXnxaA2Vf5kPjNpKLNsGgTBKYaI6prripsYEtKYIXpn91LZaKIntBRSF7L989IdI43XHBD+2y95OLW6QzeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171

On 02-Dec-24 3:38 PM, Mateusz Guzik wrote:
> On Mon, Dec 2, 2024 at 10:37 AM Bharata B Rao <bharata@amd.com> wrote:
>>
>> On 28-Nov-24 10:01 AM, Mateusz Guzik wrote:
>>
>>> WIlly mentioned the folio wait queue hash table could be grown, you
>>> can find it in mm/filemap.c:
>>>     1062 #define PAGE_WAIT_TABLE_BITS 8
>>>     1063 #define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
>>>     1064 static wait_queue_head_t folio_wait_table[PAGE_WAIT_TABLE_SIZE]
>>> __cacheline_aligned;
>>>     1065
>>>     1066 static wait_queue_head_t *folio_waitqueue(struct folio *folio)
>>>     1067 {
>>>     1068 │       return &folio_wait_table[hash_ptr(folio, PAGE_WAIT_TABLE_BITS)];
>>>     1069 }
>>>
>>> Can you collect off cpu time? offcputime-bpfcc -K > /tmp/out
>>
>> Flamegraph for "perf record --off-cpu -F 99 -a -g --all-kernel
>> --kernel-callchains -- sleep 120" is attached.
>>
>> Off-cpu samples were collected for 120s at around 45th minute run of the
>> FIO benchmark that actually runs for 1hr. This run was with kernel that
>> had your inode_lock fix but no changes to PAGE_WAIT_TABLE_BITS.
>>
>> Hopefully this captures the representative sample of the scalability
>> issue with folio lock.

Here is the data from offcputime-bpfcc -K run with inode_lock fix and no 
change to PAGE_WAIT_TABLE_BITS. This data was captured for the entire 
duration of FIO run (1hr). Since the data is huge, I am pasting a few 
relevant entries.

The first entry in the offcputime records

     finish_task_switch.isra.0
     schedule
     irqentry_exit_to_user_mode
     irqentry_exit
     sysvec_reschedule_ipi
     asm_sysvec_reschedule_ipi
     -                fio (33790)
         2

There are thousands of entries for read and write paths of FIO and I 
have shown only the first and last entries for the same here.

First entry for FIO read path that waits on folio_lock

     finish_task_switch.isra.0
     schedule
     io_schedule
     folio_wait_bit_common
     filemap_get_pages
     filemap_read
     blkdev_read_iter
     vfs_read
     ksys_read
     __x64_sys_read
     x64_sys_call
     do_syscall_64
     entry_SYSCALL_64_after_hwframe
     -                fio (34143)
         3381769535

Last entry for FIO read path that waits on folio_lock

     finish_task_switch.isra.0
     schedule
     io_schedule
     folio_wait_bit_common
     filemap_get_pages
     filemap_read
     blkdev_read_iter
     vfs_read
     ksys_read
     __x64_sys_read
     x64_sys_call
     do_syscall_64
     entry_SYSCALL_64_after_hwframe
     -                fio (34171)
         3516224519

First entry for FIO write path that waits on folio_lock

     finish_task_switch.isra.0
     schedule
     io_schedule
     folio_wait_bit_common
     __filemap_get_folio
     iomap_get_folio
     iomap_write_begin
     iomap_file_buffered_write
     blkdev_write_iter
     vfs_write
     ksys_write
     __x64_sys_write
     x64_sys_call
     do_syscall_64
     entry_SYSCALL_64_after_hwframe
     -                fio (33842)
         48900

Last entry for FIO write path that waits on folio_lock

     finish_task_switch.isra.0
     schedule
     io_schedule
     folio_wait_bit_common
     __filemap_get_folio
     iomap_get_folio
     iomap_write_begin
     iomap_file_buffered_write
     blkdev_write_iter
     vfs_write
     ksys_write
     __x64_sys_write
     x64_sys_call
     do_syscall_64
     entry_SYSCALL_64_after_hwframe
     -                fio (34187)
         1815993

The last entry in the offcputime records

     finish_task_switch.isra.0
     schedule
     futex_wait_queue
     __futex_wait
     futex_wait
     do_futex
     __x64_sys_futex
     x64_sys_call
     do_syscall_64
     entry_SYSCALL_64_after_hwframe
     -                multipathd (6308)
         3698877753

Regards,
Bharata.

