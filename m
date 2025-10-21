Return-Path: <linux-fsdevel+bounces-64801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA56BF43E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 03:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D6E18A802B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 01:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A264225761;
	Tue, 21 Oct 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="COXsVuQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AA20E6E2;
	Tue, 21 Oct 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009801; cv=fail; b=cbjGMTin22wr8hCZMzgEpm3WnjvhuhQBGbXlIZTWKze9t1GLjP2KxEwip2oICOpJ/lehWgESOwd2yj/rP22F9V47ZE1BEpyDVtuzrVtFP29pv0GaZvasDMbegoHXfP9r3Hmm7PcDYrCqoXjQGx/dCLT1EdVM+rialBc+4GcpcBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009801; c=relaxed/simple;
	bh=l2kIZFU22crPJrOines8HiEag8TQa6ftaGB5DAlCL5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UrSxyIVTIzA2WPauJINEVkAr+UsYxDCLjuoQNQmMAVF99OpLZs/To+As/Prf8Ye4CQ04Z4/aAHSfCGmx5z8lScp5bVSSqF2iqQvcAVatuYW6p/zoxunpnTJOYTERPMfY1KnCSd2Ip7oLLtn9lCtdr3ne4gBGA6TrW8MF1fOuOHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=COXsVuQS; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8mAQCITcF1kKGBq1Q/39j5rOrtlXudUJD2hjGFHERC2uW9/quLnSdJReCls0pYzk6G+K5eE3bR1S1YzihF+t+N/fmQizi2HUFupIHuRFGhAFre+W6Kq1eezPVj2IuobTo/I5NeYPDKyIGBxoi4tnqlLlf797JyF6Mu8U6yxlF0//OPVkcpR8mQ0IRPd0p0A+op62P+LddV0vBkU/IRRuOlXdGMNnMVX36cXieWfAd9VTjitz3vwS/90JxmBUDIkLC0r05ulORKBCH1scew9C0CFVfkl/LKmop67p5vEv7yQ4KIZAEWa2rkrmi68N1FyhLyw2UtyFuGWKl3QEEm2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndHhpSnnPUbdjpOM16EeVy2xWgF8r3Fo1nMRHq+ZMZw=;
 b=rMYy6HPoBDwO9T+msDbZWU0C0RP2MXueqCf8EQ6eksgBk+CtrxFrkzGVks9cpCPJbo4cjBseXkaJF7ccpsqWZaL8FVde+ycCOQUMpp63bpvP0HDEmEicwFagw+XvMDLBku+kDlliH+wzAtewmttvycL/YC7GosqnaJGrPRKQnhtB9b3Pf+SPvhSky5+dat7cUsWBszY+K67qTfEZQW6pOwPzwzvoaM83LaAgPzruXSgbn3KkN4MIbBBT1h/EFIgNgNtOcwXAYeElBNugboI2ZEkpKBZL4pwRHYMmzcDP/yz6dlFmCf1OSa4l3rE8/GI/LAxANru7nNie9/bUNk+V4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndHhpSnnPUbdjpOM16EeVy2xWgF8r3Fo1nMRHq+ZMZw=;
 b=COXsVuQS6rrsBHU8ARsDGVLC7K8qjDJtAjML/KVYtNqKJX7m2XA0znyokGy287qZtkuBsv5pWsOWcPxOS8GrSo6n6l9YXsaIeSiOBeHQ28JE/fAumU7HZYXvSgQcn1BJgqZXg7mbMgLy+Fdee5wQ50CX1HRp4rtKOsZqjXkEHhgqBldI8e1DnwK2vXjP44p+w2EVbJ646KGaLz+pkcCHsfHXekyog3265TuHMJsHJysQf4bCQdVpe7ifwVsstyWCkXjuKRgOqjx5ty/6SxyAfHpHMoo0U6+MoNlrgVsrNlZHi5n77COmUs8/ej9uijruZFUlY6brs7/Fr5Ht5iGUHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 01:23:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 01:23:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yang Shi <shy828301@gmail.com>
Cc: linmiaohe@huawei.com, jane.chu@oracle.com, david@redhat.com,
 kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio
 handling.
Date: Mon, 20 Oct 2025 21:23:13 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <A4D35134-A031-4B15-B7A0-1592B3AE6D78@nvidia.com>
In-Reply-To: <CAHbLzkp8ob1_pxczeQnwinSL=DS=kByyL+yuTRFuQ0O=Eio0oA@mail.gmail.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-3-ziy@nvidia.com>
 <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
 <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
 <CAHbLzkp8ob1_pxczeQnwinSL=DS=kByyL+yuTRFuQ0O=Eio0oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:408:fc::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cd381e-6f5f-4bd1-4420-08de1040694b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWphKzlJRXhEU0tJU3lFWHNLcXVVQ3V6TTNySmFSUk91K2htb3FoSnpzWkpO?=
 =?utf-8?B?R3dCTEVLWmh2WnVjRXVIWURpdCtEc2VrOGhGT2xIbGsyVEdHL3NEd0NkamNn?=
 =?utf-8?B?bnIvdW84aDNqbVJXMmFMMHZzZk0vdk9MWWR2RXVnMGIyMjVlNEVFZ0tsekVN?=
 =?utf-8?B?VGJmYnYwTEZmajduRE5IbGhHNDBQZXN6dkE3TWVXcHU0YmRWZ3NzenVuTFV5?=
 =?utf-8?B?T21FTzJ3RHJhQm96YUYwRXNTTTVSeFNFR3dnSFR4amtUVFFyL0wzUVJ1bkV0?=
 =?utf-8?B?SDl2QzNzV240SU5jKzNoU0RYMEFWT3dSdGlqZ3o3UGRzL1ltczhTVy83azIr?=
 =?utf-8?B?b1pkcW5lR2JtR3lBRFZmZFVLUUs4cGlUUnlKNjdZbEdCb1JLdFVVNGNINVQv?=
 =?utf-8?B?SUdWajlTTllnS3V5eDZOekxlMXRtUXBDaVQwWVZjWTdIUjVnYldvRTdQL3NR?=
 =?utf-8?B?V1BwaThhNUxLMDVnaVhQM3dzMkEzN0FvSkhKOUVWQVNYemJNTXRUQUhCMU5X?=
 =?utf-8?B?ZlgyMkNmS1hXVm96b0dCaDhQa2x0QnJUbWZaNEIwd3NzRzRuWmVpdk9vQm1M?=
 =?utf-8?B?UGJpTk4rQXJtcm1uUWgvTTJmaktRU2hmdW9sVmluZmowOFlGQjRtMFZRbmFY?=
 =?utf-8?B?L0tHNUl1SXJzNWVycHNmRTRyVTd3Njd3TzJsVFVLNEU0OW1vS1VGejdyZHFJ?=
 =?utf-8?B?UTV6R0hiYktTMlBVY041OXRXc0lvSUYzVlBhQXJkZkpwdDhLODRrajhzdExm?=
 =?utf-8?B?cHJ3b1VaT3lwT1M3SlBhQThYazFwVmVWRXp1aG5XNDFra25BWlQ2RC9PR0w5?=
 =?utf-8?B?UnNrcHJaV1d2Z3JXak9yUFpHWkF2N1ZNUHdWNEZZMXZwVVVuUW5QSEc3aFlo?=
 =?utf-8?B?VDE0dkpPNmIzT0pWTUhMN0NMR1FFRUdnc05DREdiNktqa3JmTGtKeWU1ajM2?=
 =?utf-8?B?b0pTVUx6N2swaHQrMjlIODZ2T2FQVkVVM3JscnJJQ2pZMFRWTVBQdVEvcTdl?=
 =?utf-8?B?ejFhNEVkL0V1blplNHRROENBdHBXOU5LM0V4SVR1WjlZdnZGQXMzdEtJVVQy?=
 =?utf-8?B?OEo3TDNlenltZTltNDdCREd4Mm5LNzk2NC96QUsvaDNRZnVibFczNE5vMzhF?=
 =?utf-8?B?TStxZVFYbU02VUExUE51M3RsU2doQWVUYTJFckptNGFobGpVeVppeXVtV1dP?=
 =?utf-8?B?c1IweXhMR0RvWC9xUTZUbWYwOGx5dlNoajAwazhHN0F5V051MHh2UTR2bmZi?=
 =?utf-8?B?RXRPbWY4bjU1aVl2dnlNeHBJK2xabEw1dTEyS2JkaVZidTk2Q0VJc3hjeTZN?=
 =?utf-8?B?aGlwSGtvMkJiVnB4UHArUmN2Q0d4TDhPanRqOElrWGtWT2pNYm54R2llZlYy?=
 =?utf-8?B?YTkxWGU2TUxaMmJQcytOQ09PQ3cvSjdqenNEbmZheWFQSFRhaHV4QjcvSFFM?=
 =?utf-8?B?NFhIVjJFOG5FWUJkQ1ZzMVNoMlk2dzZKaTIwUFNIWU9HV0loamRuMXZJTHBI?=
 =?utf-8?B?NDN3ODMxdDBQTEdteTRsa3VXTjZyalpRTElrNndIQXppbmNqYW9DNmpTdGw1?=
 =?utf-8?B?dk54T3Zvcm1qWHduWklGUnVCY2FucUtaT1A0bi9lMkZmNWlqQnREeVVvN0ZZ?=
 =?utf-8?B?V3lDYm1OYjczdjZrRXF3M1lQRHJVWkg4THVTVERZM3IyLy9JWkgzT2IzOUk1?=
 =?utf-8?B?M2MyMmE4WE1hTVJOM0xxOHBSeHhNMDQzUHh3VGxHRUI3MktDT1lEQWZBUnRX?=
 =?utf-8?B?bGI5YzZONUQ5RU0xVkljazljaWlOWFhDVlQxck13SjBqdTBMbWlaclRpYzRB?=
 =?utf-8?B?ckhjYXgxaEkxT3JYdnZzR1FqZTlkT3BCVE5KbU90WitiS3VRalh4SVhuN0Mz?=
 =?utf-8?B?WDlPTmpsR1BLSFBZYnlDSEV6Y2NrK2lWWmpjOE1SRGhkbTUxaUpLVU1MZTda?=
 =?utf-8?B?eUF0WnV5UllkZ0ZsZzU4YnBxZjI3UjlIeE0zVy8vTGNSb0RrTUErTElzT3Zu?=
 =?utf-8?B?amcyRGxKZVJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVViaFFMSVY4R2NjRnhTQWJrUXNOZkpUUmZOd2lid2h4Mit4MkcyejZLNm9k?=
 =?utf-8?B?NVoyV1VrK0N0UEFldVVOb051V2FhZWpVUnhHaUxGb2VJNTZUNTB2a2tTcEt4?=
 =?utf-8?B?THBZZWhIWCtCVHVxek1CQkNLWnZhSXNNWTEyQTVIekp1MzFpcWtjV0s2L0cv?=
 =?utf-8?B?bnZVcjRiMFBONjQzeE5wTGtERGtQMXlqMUtUaDhuVVVRZjhySjNoYlNLWlBQ?=
 =?utf-8?B?Y3lrcHQ0a0hTaGRINW9XY0Ruc0lDWEFRODBGL0ZlMFF4SHdRZStzdWJqLzhN?=
 =?utf-8?B?bXB0THA2OTlBY3lqcHk4cjIzTkhBaHFFOUMzNm1CQURtMzlHeG8wczRJako3?=
 =?utf-8?B?N2puMFROd1E3QzVmYUxTcWcyblNSV29ERHgrRHl2WjZ2Nkt4UTZmVTRvQ29h?=
 =?utf-8?B?SGJSMzR6Y3VpSFQ1RUZOQjhNNFZzQW91dEVkYzVsSWxBVGdRWHRVdDZ2OTl1?=
 =?utf-8?B?QUk1TDgxeGxtUkprNzVFc0YxVHZTenJyQWNPQWZFbjdQa05pMk1TMm5pZXpw?=
 =?utf-8?B?dDFNbWV4YmhFcTg3VkorNmtuM2l3NVVmS05ZR04zUlVIbFJqUExmUHZaV2NM?=
 =?utf-8?B?bURKYTBHRG0xY0JYT1gzZ0xhR2dzMTc0UWJhUmZLMDNsdlBNalY4NW5LelQ5?=
 =?utf-8?B?enZTeDRWNk1YcHlTTlhJM1dLdTZ5OXJQc01DdkJLTXIrVmdlVVFJRDhJQ0Ra?=
 =?utf-8?B?WGdvMVl5NTRDZXlubGR6T2t0SUtHMDQwUEhDWUoreUFkWURvb0YxRUtndld5?=
 =?utf-8?B?RjBHVFdrRkMzdkJPU2ZEb3Vvb3drTGQwRXBYeElOWnBiSDZrbmdsV0xvRnJn?=
 =?utf-8?B?dVRGbWQvQ2hGSU0xRk9aaDUyMEc3UUhHdi9QRjZzTHpqTFdiTGF1T25CSjZF?=
 =?utf-8?B?OUM0ZkFsZ2lkMUFiMytZeVkwT08rQ1M4YnJ3bzlkKzI3YnhUdG5yVklQd2pU?=
 =?utf-8?B?SGFWaWZQTGxWdW9taXR3dFRmSERLK0tEeGNScHd2NmtWZmdTRUpxL3pRdjBQ?=
 =?utf-8?B?RzRTaER0YVNEYUY1N2djYkVCVTNmSFIyL3RiUW5NWWpiSmw3VkxKMjJUQVJT?=
 =?utf-8?B?TnJ5OFNBaEJnYkxDY2lUVE8vUTZCbFY3Zi81TWdERVMxRDYwUmsvS2VVVzJK?=
 =?utf-8?B?ZDBqSjNiSkgydFlXZnVqTHNjOU9yMXdSd2RmY2pYOU5yRzdOM1doVXVwUThB?=
 =?utf-8?B?eklMQWFSalM2Mmw4TkkxL1J5YUJsM2lIM00yQ04xemtCbWRGR3NyS01qWlFC?=
 =?utf-8?B?VTVrb1YrSkFZUTBvaTBkZTd3aTREYjhVSFgxRmpoVG96QmkvRDFYalVkK2xT?=
 =?utf-8?B?Z1RKL3lUTzBBOEgrRHFSanNEeVBkZ1BUeVI1ZFp4U1cyYUdaTFJWeHFtd0JJ?=
 =?utf-8?B?WlF5SEpyS3VWZkIwVFNIVXM4WXpnZG5nbFpxWUFia3RtL09mdWFaMkRHZ0dz?=
 =?utf-8?B?VW5hbFpYenA3eGdTK0cyN25DTWJkYlE3cVZTZCtwMVRPdmlJV29USXB0Mm13?=
 =?utf-8?B?VjVqdlR5U29LQ25LUW5oZ2FrdEdrdVVoNEJ2MlVxbWIydEg1cmV1R2lUUWM0?=
 =?utf-8?B?UkRralN2S080RStTWk8vNnErcUxsMFFPb3lJZi9MSjh6TEhVN3puS2UveURq?=
 =?utf-8?B?emFYVlIzcWRpN0phZWtxeE9obHVRODRHZEUzNUk3aXh6NE5vcEh1UTJaeTh1?=
 =?utf-8?B?ek1kdWZMcDh2RVNTYUlnRmlNakFyUUFTcWdBa0p4eXdoQThLSTh3Skt0Q2lt?=
 =?utf-8?B?QnhsVElPQnZZMm5wSVpsRjkyNFdFLzROWXBCVks2Q2RrcTBLQzMzVFlnNWJi?=
 =?utf-8?B?VjlsQ3NtOFluUlpDcWZ3SmtmMXV3bnFXbXpzc2VTNkEwWHg1VUZPaVYraG4w?=
 =?utf-8?B?OHhNLzNWbnVhSld1OXhuTFZTSktnTjM2SlZnSWVPb05UQ3Z3ajVNZ1N0RkxH?=
 =?utf-8?B?bGdFRE5SWm9mMGtDeXRFa1U2QUtHc3ZVMGp2Y1YvSUZheENvcGx5OXM2eWVJ?=
 =?utf-8?B?NE5ZMU1DNFlDVTRkYUlNbm1aWE9ULzNIaTNKbmpnSHRjMVVlblhXeElYbUVm?=
 =?utf-8?B?ZjkyNEg5UFVHQmUyclBva0tNRDh5bU5HLzZueE03N202YzBLOTVoTFNKWlU0?=
 =?utf-8?Q?mnExDPlWyHHrsR5BShe5Kx26s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cd381e-6f5f-4bd1-4420-08de1040694b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:23:16.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Hdi4yENqcKVSRowzb6bdogNRnIHOfns6EFqhQeD8VquwnQ+wxKleSI4MF9XuYQ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

On 20 Oct 2025, at 19:41, Yang Shi wrote:

> On Mon, Oct 20, 2025 at 12:46=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 17 Oct 2025, at 15:11, Yang Shi wrote:
>>
>>> On Wed, Oct 15, 2025 at 8:38=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> Large block size (LBS) folios cannot be split to order-0 folios but
>>>> min_order_for_folio(). Current split fails directly, but that is not
>>>> optimal. Split the folio to min_order_for_folio(), so that, after spli=
t,
>>>> only the folio containing the poisoned page becomes unusable instead.
>>>>
>>>> For soft offline, do not split the large folio if it cannot be split t=
o
>>>> order-0. Since the folio is still accessible from userspace and premat=
ure
>>>> split might lead to potential performance loss.
>>>>
>>>> Suggested-by: Jane Chu <jane.chu@oracle.com>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>>>> ---
>>>>  mm/memory-failure.c | 25 +++++++++++++++++++++----
>>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index f698df156bf8..443df9581c24 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long p=
fn, struct page *p,
>>>>   * there is still more to do, hence the page refcount we took earlier
>>>>   * is still needed.
>>>>   */
>>>> -static int try_to_split_thp_page(struct page *page, bool release)
>>>> +static int try_to_split_thp_page(struct page *page, unsigned int new_=
order,
>>>> +               bool release)
>>>>  {
>>>>         int ret;
>>>>
>>>>         lock_page(page);
>>>> -       ret =3D split_huge_page(page);
>>>> +       ret =3D split_huge_page_to_list_to_order(page, NULL, new_order=
);
>>>>         unlock_page(page);
>>>>
>>>>         if (ret && release)
>>>> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
>>>>         folio_unlock(folio);
>>>>
>>>>         if (folio_test_large(folio)) {
>>>> +               int new_order =3D min_order_for_split(folio);
>>>>                 /*
>>>>                  * The flag must be set after the refcount is bumped
>>>>                  * otherwise it may race with THP split.
>>>> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags=
)
>>>>                  * page is a valid handlable page.
>>>>                  */
>>>>                 folio_set_has_hwpoisoned(folio);
>>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>>> +               /*
>>>> +                * If the folio cannot be split to order-0, kill the p=
rocess,
>>>> +                * but split the folio anyway to minimize the amount o=
f unusable
>>>> +                * pages.
>>>> +                */
>>>> +               if (try_to_split_thp_page(p, new_order, false) || new_=
order) {
>>>
>>> folio split will clear PG_has_hwpoisoned flag. It is ok for splitting
>>> to order-0 folios because the PG_hwpoisoned flag is set on the
>>> poisoned page. But if you split the folio to some smaller order large
>>> folios, it seems you need to keep PG_has_hwpoisoned flag on the
>>> poisoned folio.
>>
>> OK, this means all pages in a folio with folio_test_has_hwpoisoned() sho=
uld be
>> checked to be able to set after-split folio's flag properly. Current fol=
io
>> split code does not do that. I am thinking about whether that causes any
>> issue. Probably not, because:
>>
>> 1. before Patch 1 is applied, large after-split folios are already causi=
ng
>> a warning in memory_failure(). That kinda masks this issue.
>> 2. after Patch 1 is applied, no large after-split folios will appear,
>> since the split will fail.
>
> I'm a little bit confused. Didn't this patch split large folio to
> new-order-large-folio (new order is min order)? So this patch had
> code:
> if (try_to_split_thp_page(p, new_order, false) || new_order) {

Yes, but this is Patch 2 in this series. Patch 1 is
"mm/huge_memory: do not change split_huge_page*() target order silently."
and sent separately as a hotfix[1].

Patch 2 and 3 in this series will be sent later when 1) Patch 1 is merged,
and 2) a prerequisite patch to address the issue you mentioned above is add=
ed
long with them.

[1] https://lore.kernel.org/linux-mm/20251017013630.139907-1-ziy@nvidia.com=
/

>
> Thanks,
> Yang
>
>>
>> @Miaohe and @Jane, please let me know if my above reasoning makes sense =
or not.
>>
>> To make this patch right, folio's has_hwpoisoned flag needs to be preser=
ved
>> like what Yang described above. My current plan is to move
>> folio_clear_has_hwpoisoned(folio) into __split_folio_to_order() and
>> scan every page in the folio if the folio's has_hwpoisoned is set.
>> There will be redundant scans in non uniform split case, since a has_hwp=
oisoned
>> folio can be split multiple times (leading to multiple page scans), unle=
ss
>> the scan result is stored.
>>
>> @Miaohe and @Jane, is it possible to have multiple HW poisoned pages in
>> a folio? Is the memory failure process like 1) page access causing MCE,
>> 2) memory_failure() is used to handle it and split the large folio conta=
ining
>> it? Or multiple MCEs can be received and multiple pages in a folio are m=
arked
>> then a split would happen?
>>
>>>
>>> Yang
>>>
>>>
>>>> +                       /* get folio again in case the original one is=
 split */
>>>> +                       folio =3D page_folio(p);
>>>>                         res =3D -EHWPOISON;
>>>>                         kill_procs_now(p, pfn, flags, folio);
>>>>                         put_page(p);
>>>> @@ -2621,7 +2630,15 @@ static int soft_offline_in_use_page(struct page=
 *page)
>>>>         };
>>>>
>>>>         if (!huge && folio_test_large(folio)) {
>>>> -               if (try_to_split_thp_page(page, true)) {
>>>> +               int new_order =3D min_order_for_split(folio);
>>>> +
>>>> +               /*
>>>> +                * If the folio cannot be split to order-0, do not spl=
it it at
>>>> +                * all to retain the still accessible large folio.
>>>> +                * NOTE: if getting free memory is perferred, split it=
 like it
>>>> +                * is done in memory_failure().
>>>> +                */
>>>> +               if (new_order || try_to_split_thp_page(page, new_order=
, true)) {
>>>>                         pr_info("%#lx: thp split failed\n", pfn);
>>>>                         return -EBUSY;
>>>>                 }
>>>> --
>>>> 2.51.0
>>>>
>>>>
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

