Return-Path: <linux-fsdevel+bounces-23490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 142A792D4B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 17:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC49C2863CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB919413D;
	Wed, 10 Jul 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lzfT0C2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2061.outbound.protection.outlook.com [40.107.255.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5819409A;
	Wed, 10 Jul 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624118; cv=fail; b=tdhTji7LMUBLppW/ik//qoVLPbURZ1nJg3GpNIf7iQUWC4XJCMy56LVsOWeSPPJ6dRLw7nN/36A2OtCwtxV3u+HJgDXrU/5DSwmuji5AbL0Efu04SrJNeetd6NP+4mubfjQuLOs3WYNRLYnKPeclMRDv9LHcnL2ie+aKTKtu9Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624118; c=relaxed/simple;
	bh=mYCsrdsWilWMHyZXQ6EExmWyt6hn+EG2Lxir6CPMhok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YjX2gN+C8cSni4lumDCI79xViqr/3Qt7PX1Kkzt5dDFt+bIJnH9yiZzOfT20kjvHKAwMP9JxxEayxI1ahzS5FsDq1TB6kIexJtUAcXk77ffzURSWv3yG2qFQRMCjgvCWRTDUHPYx5cC+TLImWe26h61e/+PjG0kgXpgl57mMg/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lzfT0C2w; arc=fail smtp.client-ip=40.107.255.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKVY2h1tEkay6NN+xveXNtFMxuOZbPrJYqn+Yfy1cBU7xTzFM3+2clmUD81YEkJ/aVub9G53Sn/RgG09QpoBmVS1sKH+zlPRJzYXXxbMesybgfaLXiF6+8JmfSBZVZt15wnqKUgD5qRpRUyLCXLgliJcaR+vCx05Zk7ZUHAko/baBqXqL/TV6e5kEKET+MbNKbQfAn+gVqZi9khsOyEG/BvuZGiumCXK5PIOfPTi8W+dCDC6S/0Xt1462Seu0S3iiAHGadKMk1sFGycMRVJpgrpszXzvwO12Miy/PcyjRGNq9wx6wO0EfpHCSlNvjxHmIo83ykYfvQSrLnctqmMddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVlfc0coSzPYjSH+a6ud02rFix5qTcM5FaKiDhneLXk=;
 b=PQSyT5f8Bv5fGh64kDn4PwxcirmjEryoAj/2MBIxi7zDSt+m+y8660EQkbNEOTx9oBjfeWh3+uNOCSsraWs5hYXP2x4K2fDALZVPgwsBcQXcoewemeLuPFD0IVbofxRPbe++e/AAW7V1tNiXMuXh7CAmhaNCcb6EXWMs1lWXpU56uWtOr30FnNB/tHS+1ITHzgfictoSXP3v2ICVcce4+/ut5cwxfqouVbMz2haB6I3ZSspMZhzCBVFCYFvZ582veqwLeskGI7ORfxUvuFDkq8K8v0LcPtisaiuTOvlStpljcTnFgPtJ+XDnDIAWjccGpTGoZObwDazLggKY0aqgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVlfc0coSzPYjSH+a6ud02rFix5qTcM5FaKiDhneLXk=;
 b=lzfT0C2wtLqJ7LIF5sEhW6S7WlFghQC533CAPRU3uAQkZjR8MpK4lsrB8/nQuoAe2Jt5K2JwU5e0QXNh188rUy4Iu9BO4pksbwd7i+BVJDdUo4cyEFt3aqE4rLOAhB2kNBQ2N4RteMHU+GyMlPH5076lATJ4pdV/xtzS91gDtbrWtcfvJJmuZsfoK0cuiFXd0/PZ4Cvddk+GS07GJGU5pvypo/e+MV7DICwYspqJPnaizemj0ud/VjFPoqxpEvWHficSC2zZP420VaHx+qsB2bHSewJ5/aYo5OG3u77x+gSXIUhXFl/G2hhc1R/gOMUU/T90TT1IuB5/UmKa6cJOlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEYPR06MB5039.apcprd06.prod.outlook.com (2603:1096:101:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 15:07:00 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 15:07:00 +0000
Message-ID: <e8bfe5ed-130a-4f32-a95a-01477cdd98ca@vivo.com>
Date: Wed, 10 Jul 2024 23:06:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrei Vagin <avagin@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Daniel Vetter <daniel@ffwll.ch>,
 "Vetter, Daniel" <daniel.vetter@intel.com>
Cc: opensource.kernel@vivo.com
References: <20240710135757.25786-1-liulei.rjpt@vivo.com>
 <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
 <d70cf558-cf34-4909-a33e-58e3a10bbc0c@vivo.com>
 <0393cf47-3fa2-4e32-8b3d-d5d5bdece298@amd.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <0393cf47-3fa2-4e32-8b3d-d5d5bdece298@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0205.jpnprd01.prod.outlook.com
 (2603:1096:404:29::25) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEYPR06MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: a2f46e14-7361-4eef-3cd6-08dca0f1f2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzdXL2NORHdCV0YzVGFVVURVcTNhSHp5SXJkOFdjNGhMa2VtOWJqMHh4Y1p2?=
 =?utf-8?B?SjVtWStxQ083ZWt0RStZNmJ5cHh5VmtYTHJDa3ZHRDl2Nk1JcUVYUHE2aDVD?=
 =?utf-8?B?cnlNVy9LOXNjWVhuMkFzYW1jUEdsMkRCdEpWVUpHQ0t4RHJIdC9DNnFhL1Jx?=
 =?utf-8?B?NG9RQkJoMnFaTHkzT3dtWmd4VW1IWUpFR2puK2VJRkNtSVM5cFc2Q2x5YnpJ?=
 =?utf-8?B?SHd0WHBEYlYzaCt4YjF6VlI1LzBEb0dDZURTNDQ3YWozdjdrTDlUVFgrOGNT?=
 =?utf-8?B?NEFHN1lwcXlWZjRwb296aERUZjlkYU15RWpWVi84TnhzYUk0bmpLY3E3R3VJ?=
 =?utf-8?B?dCs0UU83eithTE5nVVE1SmFocHBPVjllZ2FJMVFDQjNFVkJJSkM0QlFGNHFS?=
 =?utf-8?B?WmYvNGhHS0ZqM3J6TGxYMndoamlDWk1CVFBra1JLaGpaZzc4U1NieXFIdXBo?=
 =?utf-8?B?ekE2UTRkU0Fta2tZV0Fmd0gvSjErbGJaS0pHOVBWb3FBbktIMzkyZWNsR0pY?=
 =?utf-8?B?bnQ5QVpTTGhKYnNMaFVYWjBVY0p4VjlkbkZRTEp2bCtYc3cyeWFQOHhSeDJX?=
 =?utf-8?B?My9KU1VwUHd4ZmpCUTFTZ05sUG5GZ0tkZXZ6aVBPTFRNd25SK21NZ1p0THJq?=
 =?utf-8?B?VGlwT0tLaUVXbEhRbEExNyt3K2p3UnFtR1RQclU1YWF6L0FHSElsNWc2QnpC?=
 =?utf-8?B?bGxMU05kdW5OQmlldjVqek5XZnpNaDc2ODlBYXdhd1VZWjFBRW5KMXQyZWF5?=
 =?utf-8?B?eFZqZ3N5SU94L3VWZlJzSkd4LzVhOWd2MXJZdzhzMWlOMHh0eCtFeFlUVVJP?=
 =?utf-8?B?TktGdjB3d1dXeTZObWN3bW9ybFBnSElGY1hldWd5S0N2R0tkYWF0MDAwdUNC?=
 =?utf-8?B?b0tnd0hrY0hHdEp2N0k5T1E1MnAzWEdUT1AybFB4T09zRlRDditWN2pseDUr?=
 =?utf-8?B?ME1hMkY0U2w3cXIvbHhTZEJ4QlhFc0QxOFVmQnVzV1U4enBxRXpZTUdqdGZs?=
 =?utf-8?B?cVpVZ1g5Rjl2dnovT0FqRFdZK0VkbHYwdHdzWmEySnA3bjBSZkV0VWhubURP?=
 =?utf-8?B?VU1tcjdlV2QweVpBQ0xobXhFbTVEbnhGUUU2UHBkQ2syVXh0RnBvT2Y4ZnJQ?=
 =?utf-8?B?eUM4eUVyOXQ1aGg2bTY5S1hZWVozRnhCanQrYzRCbjBMTDhnb3FwYW5sTGM2?=
 =?utf-8?B?bVJvdnBrMXNKcVNRS1Zua1QvMFFyODcwRGJGRDhyRzNFR3Z3ZUZ4a3dObzB2?=
 =?utf-8?B?cXBJdWRZL25WMnZIYStNT0ZiaXFjV1MxUmRVb09uV1dTWEMyYzZRZXpVSlJP?=
 =?utf-8?B?N01UNlg1MTgrYW9uNHFTY0RnN0t4Y3hueTJLN0dpU0F2T3lwNE8yT3h2WGc0?=
 =?utf-8?B?ak1PZU12M0FndUtZclkyb3BITml4WTRBTmJSNFI4Wi9pNkR5Mm5TM0t4SnNh?=
 =?utf-8?B?Y0JlVFpxMEpSU051NFlTa1Vvb05SWXBHZEVRcGExWEd2b2pFRGR4NytoUUlm?=
 =?utf-8?B?Vjh0UnJQWEtMZ3ZnL1RYL3Zzbm9NcG1tMldtQlRCdlRyOHdWYjdZc3BndzYy?=
 =?utf-8?B?YXlrb1RvbzNpV1FLeFBDMFpLM3hSa0pEdFROQk1XemJ3K2V1WElOcGpUTFhN?=
 =?utf-8?B?b0M4WTF5VHVObkNsYTIweGhvam1kOHZMVFZTR1REekFucm4zVEZKUS9ZTVh2?=
 =?utf-8?B?WkNoT2ttc2NxSURrVm5mMHNydHJaL0VYS2I3V0xQZTVId0ZSeVl6T283dW5E?=
 =?utf-8?B?U0wxcE0rUGdRZnpwODUwUDV5dWdQRlQ5VXRFb2ZROFhLQi9iTE1RSHFvbWtS?=
 =?utf-8?B?T1QxT0QrVFhvZi82ejNSQXhEeUo5VVZBQ0QvVlh5QTB3M2hweWdNT3htdkNt?=
 =?utf-8?B?SG9PWDgyNGp6L2pQWU5wcTEwK09xOUl1SytTMGhwa2ozb2RDUDJ3VmpKdTBD?=
 =?utf-8?Q?9YuWkts2xXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UytrbXhCZVF0dDNQQlRXNnEzcTNnbld2aEhpRGZKRXpwbDUxL3gybmVFUkxM?=
 =?utf-8?B?SmFVdnpERi8zcXU1M0JGM0ZxZUNiVXUvdmhtZUgwN2VZcnpPTlo1RWxwd3FE?=
 =?utf-8?B?QzJxUmFIa2hDS1k2T1pEbkxNMC9lZzRudEkyY013Q3NLWGZ0TFZINUVqdmRC?=
 =?utf-8?B?bjVuclp0czV1K1RxNjd5K0MrMkk5TkcrN1UzTHpOME5oeVNXc2FkWGV1cGJ5?=
 =?utf-8?B?eElZUUd3clN4b0tLNVdlck9NZDRRNStxWmZXa3pBL2dnOUFQNjFrSVdOWmhL?=
 =?utf-8?B?YnFPRHo1ZjFvU2cxUGdLOWpQMnlFdFJxOWVTd2VmeXpZcVBtNm9iZ3BEanBi?=
 =?utf-8?B?SWZ3R2ZDTlFiQzJ0NjdNdzRDamhhbmhLL0VxQTlEaEdoOSt4eSsvVjlVQWcr?=
 =?utf-8?B?VWVlNWZad2kwVitGRzQydHM5TTBLL1poNVV0ZW0xU1IrcHZabVlKbEFvTk1u?=
 =?utf-8?B?WlRwWWxhK1V2TndWMXBtdkhzYTZtRnBvWVp4SGtjaFFadWR3Zkd0ZkJOTXJh?=
 =?utf-8?B?NXVqNUh3RFhJb1dBNHZ5MmhlNnJjRHljRFgzZEliSi9zU3lFUUJOakVpK1hx?=
 =?utf-8?B?bFBiTlFIQ2RKLzJsNmRWMnlsK3Z2cEVBY1pCKzNIalN5MWdIZEVwd2lDZ214?=
 =?utf-8?B?OEkxUDlXcGxUdldEVnd6R2ZVWGpHU2x0SHFreXhYY0orMTBFQWdVZnowYXRJ?=
 =?utf-8?B?SVN0NnUyWm80NFBNc0ZOMS9FTHNVSjEwdStGQkZkOTRkbjlKalpJbmdJVnRR?=
 =?utf-8?B?SGVua3o4UXJwNnI5N0ZTaWNzQkRTbE1VOGUxdFRNbEdBcnZRMi83c3RRMzZO?=
 =?utf-8?B?WWdJNFJNQ1RFbFhKckMwL21HdVd0K1hVTnRjZjFvc21zWG50OGhjY3BSVWRu?=
 =?utf-8?B?aTkvbEhmd2hydkhCbmVRQlZwbDFmVXV1VmN6bjVCTU1leWVLdXBhMXRpUmZM?=
 =?utf-8?B?ZlVCSzEyeGV1WGRhT25KUXpLR2tRMTVBVHEzOFI2TGU4WitHTjZ0Smc5M0Jk?=
 =?utf-8?B?MnRMS3lnWlZRRTRwWUtCRE5XWkp1UXRVcXlmK28rWnF4MDNBSGZJTm5BdXQ4?=
 =?utf-8?B?RnFmSDJ0N0N2ZUVJK2tiNG9iQWEySHlkM0NRdUEyTkk4eW9mNTV3VGlWNHFm?=
 =?utf-8?B?b2d3ZGdHUE9MaU9lUGw2clh4Z3BWSWdlcVIzR0piT3RxYi8wQzdGYk5HWHBQ?=
 =?utf-8?B?a290VFpzWlFKdVlSRHA1UDNReDFLS0VtQXE1TzBRY2ZOQnZ5dGR3UytkQ2Iy?=
 =?utf-8?B?T0pBUVltN01oZGtRM1lFT3JpeVF4NWpQMEdXemlJd01MY0xEeERTVWpkb0RO?=
 =?utf-8?B?bGVJaXh0V01wbGkzRElpcHpHTmVickUyZmlhNjNnTlc4a1pXSUJTTjhTZFdQ?=
 =?utf-8?B?TXRpOCtwMUZmQTZNTU5sc1k5OWc1ME5mR2FvdUUyUWlKYSttTlBPaHJxQVZI?=
 =?utf-8?B?cktWMDRQR0NEaHcxVitGVllNdk50OUZTaUdOczlud3dERVRkaFV0QkQxek9O?=
 =?utf-8?B?cGdqNjJ6TGpmV01MUmxpa3Fpc1V3NU51SW8xU2tHbHdCNmcwV05yeTkyVFc3?=
 =?utf-8?B?eXptQ0FoYk1rNjE0MUg3a2FqTXpKeHFUTURFWFlzb3NMakNFMG8zMnhSSWlI?=
 =?utf-8?B?RlRtSDZSemdnSXZFV0w4SW1uRmtDRWJIZkhJTmoxY29uUWlaUVhDR01SNG5M?=
 =?utf-8?B?QzJxL1FPSkIrREpjSEVqbitpOFJ3V2packoxb3dHN0lJMXlUTkJCdDdkVTBT?=
 =?utf-8?B?V29xcEZVT3pJMm94QzhpelphSHF6ZW16aGNpL0xwQVJ2dHk2aTJmdTVWZjN5?=
 =?utf-8?B?TmVZaWVBdVNVQzZMMlEzQ0hDUXFZK05oOUwrZld3eFg5clpoZjduMWRJNks0?=
 =?utf-8?B?UzhvVy9ZYUt0YkZwMFVNWlJuS2tvT2F0V01FdnoxdFduTDhGZFR1QnkreW5i?=
 =?utf-8?B?bkF1M1ZkRkdrNzR6cHRCWFhDaERWTTNlSzBpdFl1SmNTUzJIOW5neUpiYlRX?=
 =?utf-8?B?ait1VHpsNkR6SDBLMjdXNmcrZHdabloyNGtMeUlITVFLamF4c3BxZWxJaXhN?=
 =?utf-8?B?ZEk4bEczQldubHYvc2hCQ2d3U2hWMXJTOFAzZGdEdEgyNWFwNTVIMGlnWEV2?=
 =?utf-8?Q?7kg1+KoPNY3zJ5KDQEzWjrZmR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f46e14-7361-4eef-3cd6-08dca0f1f2a4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 15:06:59.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MnnxRukTg8S5Vm9c2CZYMXzyJumCmYKAhNvjLVxvlRydftKcVs1I2rgBbpjnkQ07D663V/z7EvjKmmtrYlspA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5039


on 2024/7/10 22:48, Christian König wrote:
> Am 10.07.24 um 16:35 schrieb Lei Liu:
>>
>> on 2024/7/10 22:14, Christian König wrote:
>>> Am 10.07.24 um 15:57 schrieb Lei Liu:
>>>> Use vm_insert_page to establish a mapping for the memory allocated
>>>> by dmabuf, thus supporting direct I/O read and write; and fix the
>>>> issue of incorrect memory statistics after mapping dmabuf memory.
>>>
>>> Well big NAK to that! Direct I/O is intentionally disabled on DMA-bufs.
>>
>> Hello! Could you explain why direct_io is disabled on DMABUF? Is 
>> there any historical reason for this?
>
> It's basically one of the most fundamental design decision of DMA-Buf. 
> The attachment/map/fence model DMA-buf uses is not really compatible 
> with direct I/O on the underlying pages.

Thank you! Is there any related documentation on this? I would like to 
understand and learn more about the fundamental reasons for the lack of 
support.
>
>>>
>>> We already discussed enforcing that in the DMA-buf framework and 
>>> this patch probably means that we should really do that.
>>>
>>> Regards,
>>> Christian.
>>
>> Thank you for your response. With the application of AI large model 
>> edgeification, we urgently need support for direct_io on DMABUF to 
>> read some very large files. Do you have any new solutions or plans 
>> for this?
>
> We have seen similar projects over the years and all of those turned 
> out to be complete shipwrecks.
>
> There is currently a patch set under discussion to give the network 
> subsystem DMA-buf support. If you are interest in network direct I/O 
> that could help.

Is there a related introduction link for this patch?

>
> Additional to that a lot of GPU drivers support userptr usages, e.g. 
> to import malloced memory into the GPU driver. You can then also do 
> direct I/O on that malloced memory and the kernel will enforce correct 
> handling with the GPU driver through MMU notifiers.
>
> But as far as I know a general DMA-buf based solution isn't possible.

1.The reason we need to use DMABUF memory here is that we need to share 
memory between the CPU and APU. Currently, only DMABUF memory is 
suitable for this purpose. Additionally, we need to read very large files.

2. Are there any other solutions for this? Also, do you have any plans 
to support direct_io for DMABUF memory in the future?

>
> Regards,
> Christian.
>
>>
>> Regards,
>> Lei Liu.
>>
>>>
>>>>
>>>> Lei Liu (2):
>>>>    mm: dmabuf_direct_io: Support direct_io for memory allocated by 
>>>> dmabuf
>>>>    mm: dmabuf_direct_io: Fix memory statistics error for dmabuf 
>>>> allocated
>>>>      memory with direct_io support
>>>>
>>>>   drivers/dma-buf/heaps/system_heap.c |  5 +++--
>>>>   fs/proc/task_mmu.c                  |  8 +++++++-
>>>>   include/linux/mm.h                  |  1 +
>>>>   mm/memory.c                         | 15 ++++++++++-----
>>>>   mm/rmap.c                           |  9 +++++----
>>>>   5 files changed, 26 insertions(+), 12 deletions(-)
>>>>
>>>
>

