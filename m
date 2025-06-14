Return-Path: <linux-fsdevel+bounces-51672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2787ADA03A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 00:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF517A62FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE81FDE33;
	Sat, 14 Jun 2025 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="yp8K/Noj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AFB179A3
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749939481; cv=fail; b=qKIm8rmcwy74bjPJ7eDxBM1+71WXclXa+ILyaytgCc93w8yPGS4hT0irFeFGEFYTIJJ1KjWeTu467x3gBMO/AvlogNCIKdoYHdo29Rzbm/gzX5a4UwYMonmPJDoUF04yE6mpAO/6xxTfwfQD7M7/UNvBFZ/UDYSTMtAJI7eX5AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749939481; c=relaxed/simple;
	bh=T4DY2S17DePXJe7OoJukq3UVfjWi4aFb028vm7ZOuNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2cC7JiuGqPUfQ0duX6RdaZPaQ9SSnhYbFdyYHSln5hMPZADE9UCpXh7J/mYCaUaOlcAzLS4Q7XLkea6VwccoaSOUzZDha0V9NSg7FE/8dCfdYfyvq1XaJvaFu+RKdUvBllLDoVp8gHPLkHDyudsmGi3EsyGslktFT9cg6oiZk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=yp8K/Noj; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96]) by mx-outbound15-45.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 14 Jun 2025 22:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUbnZMbr/WfgIxssY1vZM1isbt56TjVivluM6eQFvfd/QKphe+FOloQKFcjDcyAmvAougWinicR0lr0roIYbZZff69TBFpJJz0e7u2ff6FxsDGr+Kib0EnZbn76GUrV0cl9LPEPt5lYFZ5N4iSRoXfNI457XqFIxkfDMUrkHp5/NfjprsFtJGaFOvBH7mLyU6nqRWZ+wp9iiiVwcXTAdGmBK0oK+iwUpjsUo1QMUh2bvFKZ/j/NyrN0JViPGALYZMETPzue5uvHfBN97CiR89TR0+hq+Wf09YUQkBRPapQ0Nn+gV3FvZzy20Zrdemn0O2cDhA4tQ+z3dd5a3spQeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co+4tPcsian7zqRAhabqZfu6t6W1bDkPF5kEtvc5SDU=;
 b=I+TqCUPo9y+CHGfv/opcVNKhNXZUxtXgaPqG1zvdoc4RI/bcdai/OFy/ir3PW+3LCkjOFzJC50ME2Z0kIzTTJKu4afi7/w7Sx4vRw9sV85obxHI5W74wXaE7/3fGmg9ADpxADY0x8c98tJqvUpeAIadRs2WoWPygKivP2JdNOkGKvCx9WOhe8rwoW81GGMS09NeQ/a093VcGeG9PNFSL9DZ5uksgTf3KPhHbFfVmxH0vjXmBaZzr4bhsyxBE68gXANqI4fASKMX6xa4kfYyM3ctZ81rlGnSLjFxCjONuPVcSPSiMAgnsrHZz7UdhCjDAhoage0OeiNXIMxXYA5d7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co+4tPcsian7zqRAhabqZfu6t6W1bDkPF5kEtvc5SDU=;
 b=yp8K/NojANYWNf2YbV/8JGz/AKQvnFI7NevtFtMVKPjjcs1UEoensziplPYGsVnku049qOTw5XZKOdjGR3oIwZDx3yxI7KvMTObLu/p1WCBQTF545PJyRbCbf++uK0sNpOp0IaeOXaU44UVU4w5HWFRzu36kDODShPACzRYKbno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CH4PR19MB8769.namprd19.prod.outlook.com (2603:10b6:610:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.16; Sat, 14 Jun
 2025 21:44:15 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.8835.026; Sat, 14 Jun 2025
 21:44:14 +0000
Message-ID: <b3ab81e1-760d-4e25-861d-a9ff243fe699@ddn.com>
Date: Sat, 14 Jun 2025 23:44:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix the io_uring flag processing in init reply
To: Feng Shuo <steve.shuo.feng@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: mszeredi@redhat.com
References: <83907912-d8eb-462c-8851-2c6f44755d68@gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <83907912-d8eb-462c-8851-2c6f44755d68@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::27) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|CH4PR19MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8a5cef-e52c-4e6c-bf25-08ddab8c9b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0twUE9jYjNzZjJzVW9VQ3FjSFFKb2JEL0hzSnB1VUFTMEJUdlN0UEs3Q0tJ?=
 =?utf-8?B?bFpWait2SDgzOTQ3SHhuVEM3bEJyY01xY3QrM0ZkQkk1c3U5SndKN2NaN0FB?=
 =?utf-8?B?QmJDa0VjeW9SU2VpYkY3ZElMSnRXckVvUm9tSk5YTVFQVDNoZXdLZlhaRmVq?=
 =?utf-8?B?cnV0ckp3ZmF0ODdXRGNSdi8yU2gyR0ErNE1WM1lLRHZ6NlRqZlpqZjFHeUxh?=
 =?utf-8?B?RGJtdk1iTE5OWkZrYWVqOGJ1WlRkWlFIQ25rZkN2QW0wSWVIaTZET3krR2px?=
 =?utf-8?B?QTZNZ0JsNmJRQlo1STA3R1BsYkpzM1VwMHlSSDJHcTd6cUpGODNBQjFvOXdr?=
 =?utf-8?B?cDdFWFNDZ0syWS8rS1FJNzhtY2V6K2Roa2NzNFNGUVpNb3BaeXZwdjFuT0Jo?=
 =?utf-8?B?T1VERDc1c0toNDRUMU5jNEZSSUx6clNJTXRHLyt1dEVreWttK0VRNDM5YXgw?=
 =?utf-8?B?ZFhKUlBQNHR3dDRjVnB4Y0E2K2hOdjlIMWhsTWVZeXkvNDJrNUgwNG9DSlJo?=
 =?utf-8?B?SmZ2b0NnbnBiWlFsWFBMVCt6Y3FOa1hkd1JIdGVMWTVZY3hhS3FtNjlmV2hS?=
 =?utf-8?B?T05naS9pTncwRGpBRGY3Z1ZOb3R4S25BdU0vU3RUUnMrVmVOS1RLNDFSU0pY?=
 =?utf-8?B?emVCOUJFcU9VT1Z4dm5EZitXbzRjMnlpb0RLdEc1dDgvS1dQUFVLTVZ5ODFs?=
 =?utf-8?B?K1dQVVlPOS9xbVkzTVMwNFNNTDhOSDF4bGc2bHp3RGFrMzFseUtTcXVBRGFl?=
 =?utf-8?B?ZisvNUphSlZ1R3JDWmlvMFRRM3RoR1VnZHBBM2gwZm9JWUlNcW41STBLTDZJ?=
 =?utf-8?B?cjRQelpNbXBoT1NrUjI5OXovTURBSUhhQ0s0TnlqWEN2MHVEQWZGMXBad3h3?=
 =?utf-8?B?SVdMRlRqWnBhYVAzVUROTmtkNzJWZFVKcEV4MGZUVEVkcGhsN3dCbGFpdGZ2?=
 =?utf-8?B?cEhrL2luWGV5NXBidExkL0xyOFNjNzlxMFREc1JiOFUvdzBxMlg3RWNlM0Jh?=
 =?utf-8?B?blNScm9nUzV1L0hQOHFucWtDajE2RXluS3RROTczdSttbUMzejVRdmFiay9v?=
 =?utf-8?B?SGhQbTBIL09halEybGY2WU82Rno0WDl4QmN4aEQwVTh2WlFkL0plb1JTenpp?=
 =?utf-8?B?cEJCajlVRUNlaStsTXZsOTI5blBQV0FCVVQvL21tUHlxbkh6Y0xhdEY3ZHVQ?=
 =?utf-8?B?N2JCN1c2ZHJiS01FSWd5L0VyMzNFdXFWRUlWcE5rRkRZbzlSdklubEVmZTdw?=
 =?utf-8?B?RjNsdEVZQy91NUF2Y2NmRGdrL1pMTDhKUENCQUpnUXNRdklRWTBYU0s0T284?=
 =?utf-8?B?eEtoeElPTmtSbnVrUlp4YXczWXJOZ2NoendDMDAzbjVOMUp1aGtmWW5lcGpP?=
 =?utf-8?B?NWtpRW4zakkycHB1a29rTC82VjRPRDh3SXdYcm5La3VsRkpBaHVTT2RmZmh3?=
 =?utf-8?B?YU1SaXA2cUNnVTFkQlZzSDR6UkU2NXUzaTFYZkcwVFlrU2UvNEMvTTYyWHpE?=
 =?utf-8?B?NFFMS25FZ1U1RGNZZEVkZXpZYXR4ZUFXdGZNTnVsbUFhUS9JTFlML3UxWUI0?=
 =?utf-8?B?V0JXVlFuS20vUUpQUlFMQ3VraDR2ZDN6ZkdoWk5tWHhGYjBLT0J3TTRjaUM5?=
 =?utf-8?B?V0Z2amlWRkFLa2hYellSYmM1ZVN2MjViRW1tV0ZyRHlBR2lPcU5qb2dRV0JR?=
 =?utf-8?B?NjMzNEhaMXZ2M1g2bkFpaDM0VmFiczBIMnlBQjRpVFloVlRGQVBZcXlXNHRi?=
 =?utf-8?B?dTZHQTdNT2EwRVVsMDE2bjFWY3p1V2cvVEtDTkJBYWRYRDgxMVZSRTNRekZZ?=
 =?utf-8?B?WWdDZGpRTDBkUDRVOUtVa0ZJRHYvVHpyVjBveDNvWmNNY00zeWpsWEtWOEdE?=
 =?utf-8?B?dHd4eVFGSER6dmNtUGxhNWJYcGRRQkV6RHRRcnZzMHZSV3B5MFEzaDJGNjRM?=
 =?utf-8?Q?b4TU6kZP4UE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFo5WGYxWG1uV1oraHZHTTJDUkdGVjdZaXd4aS9kTk1uS2FRSlB1WS9SZDdH?=
 =?utf-8?B?NkduTFptZ2xqRGxpODE5Ky8xRFZ1ZUducEIwVENTc0RyTnpGVGpDajM5Vi9P?=
 =?utf-8?B?alpaM2lBUG1GMEpGOHVXeWFGYzVVK3pJZUZoRlY3emhUN2wrb25GN0V1VTJG?=
 =?utf-8?B?czZxU1owZVNtcnlsYXliSUxneER3bVpXNm4xZGZmOXh1bXg5WUtxdnZFU0o2?=
 =?utf-8?B?VTlUSnIvenRVcWprUmJVMzBzNFVReTIxQkpTbVA0R0NsT25vcjljRERFcDBT?=
 =?utf-8?B?N3RabDVMVlUxblRnWG10T3VVTUtwc0sybUZnekw0bmZQTFZ2S1BiUkRtMjZ2?=
 =?utf-8?B?bkZRZlFDbS83T1J3eGdhS1IrOTBIUFZiRkdQdXBMS3k0OXVRdFJDZnhLMTlT?=
 =?utf-8?B?VUlaQW9yZkNrdDlheDhqeWRFakRvSGFTQ3E0TXhiN2pwbk1YL010dVVwTlly?=
 =?utf-8?B?cVQzTUREd3E2NHZmaG9UVzliblBEeDFkSDdxYnBaSzZEMHF4N2RPS3M2MHd2?=
 =?utf-8?B?emNXTzJlSVlFREpDQzE5ckhmVXpBaGVURklobzJzdGZVN2xZQmY0bDdWK2pa?=
 =?utf-8?B?MHE4S2dsQVdDSDRhVWN3OUV4dlJGZWhyaEFmbDRvRDFsTldqY3I4SStWZXJo?=
 =?utf-8?B?MmJZVE44M0xXUnEzWWRVYlBwQThxV0RHZllUeTUvcVkvUlY2WHIvWGhNYlVo?=
 =?utf-8?B?d3F2OE1YTGJtK3hLWXczc2FRMjRNWW8ySGJ5eTFQaUJ3NlNIZkxBalloMWZs?=
 =?utf-8?B?cXdaT0NacG1qdjFFSXRiOTFwdlVlMURWWUxlVDUzNGwyZERrUUdkRW9LWTR0?=
 =?utf-8?B?NkJ1Sm8xY0E1ZGw4bVFLOW91Q1dnckJRS2dDd1Z4bDRiQm1PYUlBbUIwVVdj?=
 =?utf-8?B?QjF5RzBLVEhaYXk4ZWRIckFQOHlsMTV5ay9PRjN6R2VwK2gwYmFFS2dQdlFY?=
 =?utf-8?B?SGJsZHhMNW0vc2FLNGJJc1lSZVl3WlRJM3hqaFB6N2s0MkxEbXJqNGR6MFdC?=
 =?utf-8?B?ZHZ6cjhhNk8zMkMxeDdXVEJxN29XWEgyeFlOc0V6R3JKQjZNNi9jMitIYjJl?=
 =?utf-8?B?Z3dwQlVKRkRxMkhVSWEzbnJDYkZEN1BTUE51SWlaSnAvUVZCSlR1VHNnekJ5?=
 =?utf-8?B?WlV6Mm5qYkhaZ0tkZk9ST2FTYTR4S1h5THZqWjB0QU5TaHBOZXB4ckxNR2VG?=
 =?utf-8?B?eHgxNVNtSm14T3o5ZzQvcWVPV28wU05sblBiekRGZTVNNDZkek9TVEVEL1Jv?=
 =?utf-8?B?K1lTUVFLYmMxQWR6cHo1dEhuSnBQakt5MThJems5TFArZ0oyaTRzQTByaGEv?=
 =?utf-8?B?aW96QU15VFlJdXJHUWRyODRocXBvUUVJZGRlWURKZVphdnlJdUJMMTFjSHhC?=
 =?utf-8?B?cWZTSDNWMGdoOVZmOVh2RldVZ3gwbGpvYWo1eXNMT25EU2ZTckM0WE5PVnU4?=
 =?utf-8?B?bHRWWjRYdWRzRmlhYVZvLzhUUVNHNW9pTW1taHJBcndxaGFaUWdNSVJsR2Ft?=
 =?utf-8?B?R0oxL1d1cFBoeVQ2SEk5M1BJeE4zMXpCSklyNFh0a1B3N2FyellNUXBNWGxy?=
 =?utf-8?B?RmhLaEUyd01TQU9PVzVub3NaMTRSSTJuV0JiaEpUZHJKbU9uTjNBUTRwN3k3?=
 =?utf-8?B?NkZaZGlnQThONjA2ZjdrbFRFWTRDSVFuN0JrRmo0MFVxcVhtTlp5Y002NVNO?=
 =?utf-8?B?a3J4YjBSUUhoVlh2Z3JLWmRRQVpBdXc1VE9NZVhoaFhLV2lZMjF0ZCtab0Y4?=
 =?utf-8?B?RWFDVGw1YVhmcU5KYWNac1M0bE9FOVpaMm9Lb1FBdUxUL2NTNzFkbm5Bd2Ex?=
 =?utf-8?B?MHNER1RUUHdJOHFNc29sRDhmSWpudS9pMTF3YWczTVQ0angrN1hhblNuWGNF?=
 =?utf-8?B?OHlmUFh4N2s4K0gvQjF4dFoxL1ViK0JpVTFmOUliRWdjcTRHMXNGcjg5NVAr?=
 =?utf-8?B?OGgxTkRoK1lUN2RNYjFKRW5FUTdKdlZjTndja1dtekhCYXM3N2tzcVFESGUr?=
 =?utf-8?B?VWtQNUxMWUxZV1VXNDNVYnFtMldxaFp1TzhDeDg4blRkYk0xanJQZHNJNDhs?=
 =?utf-8?B?TnF2TGtpSWVCYkZFQ2RrRUtOM2ZKZFh1elVXL2NZUXNBeDkySHlGWW5VUnNs?=
 =?utf-8?B?WStRS3RLODFreU9oYjl4SFVmNWhINC9yS3dKcWJ5bk00K3M0a3kxbEFWQ0JD?=
 =?utf-8?Q?Y8DtSnaTK9MrLv+Vq24ebwMNjfhcPpUfA5QjVzhM2Isn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jBhO2siuksFlNijaTGgM/1IhExPtfSJBcq6lMass+CEbXRJoGrmaWe8gRKkz8rya3uQsKHXlI46BSSMdqa+dTjRgemfxtyi7DDkSpURI1ajGAtoui/JOECJECfBxUXpTxAyAYyP+LyvBnqC3uxF+ONEprQ+LZbBmHM6dy0+kAUGMJOdt70UQU333GPZoG/JQX0jZdUnrGBXVafLb0xaXpbggGIoTrQWtYTdXBDdCC7TPyJPVSKNsDQbbuOK3s8GFq1Sy2meZ7q4nNpb3Gi0d9P9S5hZBgyYdyjAJVmOMNKRpPXtGO8sfxrFr5d3zpt8ieDQFUYDy9lQBmt/f70Cxe695pgeY1YNFcUP/Sxl2LeuqoGJaTMzIZeMMDkkwxEoRgmV6lf9FEXQPYLEddbX1uuNzb4KirLsxrKwba6llhc5d4FQyoxeUJ3KjeUTRa95HgUvwBflhNZMGaA6tjhfBwCQDSxMJHu/I+EEmzLGZMe9c3T/cvITJDlYvQcTE/hULC74VpV2yoTWahheugYSHYOY+2JavLTGFaHGfoxEVSD1ajsZ4bhn2/sh6Iwtt/CiN8GtRGbiEiaaOtAj7D7j64EIALUdEMAtOxrCsXw8JSnyxHmq3tExkYO/dxXsx82v7uBVee5erUAWvFgu16EO0yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8a5cef-e52c-4e6c-bf25-08ddab8c9b25
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 21:44:14.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz1EJP2W72Tdp/9v6JPQcuFzjO+xusJANmGeUwQYDkurT1GjH05RpNhEE4FU7k+kULKlh4Nm+oRsGsnHcp4imA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR19MB8769
X-OriginatorOrg: ddn.com
X-BESS-ID: 1749939478-103885-7670-27039-1
X-BESS-VER: 2019.1_20250611.1405
X-BESS-Apparent-Source-IP: 40.107.220.96
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmZoZAVgZQ0NLUMCXFLDHR0t
	zMKAkIUxJNTMwsk0zM0ywSTU2STJVqYwH0P81yQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.265339 [from 
	cloudscan14-150.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 6/14/25 17:41, Feng Shuo wrote:
> [You don't often get email from steve.shuo.feng@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Fix the expression of the io_uring flag processing.
> 
> Signed-off-by: Feng Shuo <steve.shuo.feng@gmail.com>
> ---
>  fs/fuse/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index bfe8d8af46f3..ef0ab9a6893c 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1434,7 +1434,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>                                 else
>                                         ok = false;
>                         }
> -                       if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> +                       if ((flags & FUSE_OVER_IO_URING) && fuse_uring_enabled())
>                                 fc->io_uring = 1;
> 
>                         if (flags & FUSE_REQUEST_TIMEOUT)
> --
> 2.43.0

Hi Shuo,

I don't think it is a 'fix', because the '&' operatpr has higher
precedence, for readability you are definitely right.

Maybe something like

fuse: Add parentheses around bitwise operation in conditional

Add parentheses around the bitwise AND operation in the io_uring
condition check for better readability.


With an updated commit message/subject:

Reviewed-by: Bernd Schubert <bschubert@ddn.com>


Thanks,
Bernd

