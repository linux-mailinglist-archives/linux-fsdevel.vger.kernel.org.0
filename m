Return-Path: <linux-fsdevel+bounces-13084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE46D86B123
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2671C2646E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A082C151CEA;
	Wed, 28 Feb 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NXv2qebf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30B155A45
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128908; cv=fail; b=awyKE+dKyjY9qIIYd478sEKbKH5iVEs3LfYbIoZtI6HOuAPRdCXxmY6a3Q1mcmPf0gu+tkwHjQnTl6uoua7CWufyUkpnbga69b7khCHYCDuP0dHvT/Hr61DFTlDb5gWmhU7ogJTq/5U0FoHSrVHnMjxnD3PMFjM82lOqCesbysM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128908; c=relaxed/simple;
	bh=CFnKRQ35vnssr26EvNbQ+yO/ly4OeZPEiDI58STfU0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eAbRXq90VUHSY6Z1Eajk2K3eX31CGdF689Heio8bv3sfijtDxtvLPmkyizyhmE8+IVBEK7w8235kVKIE1PdIYPJjY24oVm9QXRxlF58bCa+L8GM87HSVqRssOUujSZ3nCNHesnxU3YlQGVZEqbhg5MgLVNb9mS21K4mKcagmGVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NXv2qebf; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 41SB4P01031487;
	Wed, 28 Feb 2024 06:01:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Y01z/nFHibwAGs2HNPk5FY6N9xED5KP581+OKUR8j64=;
 b=NXv2qebfDLBw16mWC1Uh9+3eZXpL55qbZZPzdkakWSJOcq8xXiqj1sHvsVxmcnMwTJjj
 ErHo2fzKcO9udIpopdTYFSzlNTsR0RUbBlVigG/eCWKEqtQX0Z4iPxMc1cguB9+Qq9TC
 tFAD0PrcPmWG/ix47Qtf4UFxm2ZN62y5UfvR4FMKlaXAZjcyXXLHsKFB4db7QRr03Qam
 OOx/KJu9Bbx9a1/V4cl/ZWlrBC3JmdwAOPKZxK4/NM0YHGulcW4JXmtJ5yCtVZrfoLlV
 hQbkzWLQNnbgy39ExbqGAWPk080DD9Rcmv1LfRJs92D6TTPRsrxT7kq4saaSdkuWub8s Sw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by m0001303.ppops.net (PPS) with ESMTPS id 3whypwsxfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 06:01:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeHsX3Bxtz4rRYaaR2X2jjMKcCiEkoU2FPTTYemM9G8/qZ9SPoQQWHAfKyqBiWkJaZJwUvaLMYeORVN9JIiGjUMRvgMP4EoLlo65dmtD0w7rKsHYAxBv/sY3H+ExmEHSttnOeFeX5rh8OxUxldEJRg8tVBi+9uZJTYH9KGlPYhGgzJnB4o7o/rwIDT9EvzlbsxlyauG7NOJ/88BZVMyCH0lt3oxEl6pBLU8ZBygEbweRms+67RpjNzsAZBd+cNvt4pQBZ1blw8NQy7elPNRow4Z0tzPyFbu1DdTnvxrJXvC8SkS4hFofViY7uYy3c5qd9jmq8+2m2cN3eOrmFtFkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y01z/nFHibwAGs2HNPk5FY6N9xED5KP581+OKUR8j64=;
 b=HS8Mv0Rycs9iC7ln9tKKv7QJd9vzZF9oIsPKm9j3a2pbdnXCW/ZccxY1sZVUyPhThUgqh6y2hXgDfEiwTN1FJtDEutsttuDfpqii59eYswqe6iW3ya74JWMyCvyZDrbN2lF9wC3/C/4gYHrW5ZYShKdbZGOidqMPvVjutJmGaC8IxSK3Fc/mS8a3TrSoa67S+2QcgtTdsQLQ52UWM24UV/+U2puemxUcsRVU/NmO7Iw8aiK12D4eDVAEUXUfo5Z8RNqJExubHFJ7FfVVgvIjSmDZ5o0wL0FxkPt5kKeo6ik6/hiXKMk4UWOYBhVfHudfsFFkqLYfPBN4woxc4DylOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by IA1PR15MB5983.namprd15.prod.outlook.com (2603:10b6:208:44c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 14:01:05 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::9c98:3298:e8d6:e8e0]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::9c98:3298:e8d6:e8e0%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 14:01:04 +0000
Message-ID: <ab21504d-e188-48b8-92c3-11d96f1a7b47@meta.com>
Date: Wed, 28 Feb 2024 09:01:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Measuring limits and enhancing
 buffered IO
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Chris Mason <clm@fb.com>, Matthew Wilcox <willy@infradead.org>,
        Daniel Gomez <da.gomez@samsung.com>, linux-mm <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jan Kara <jack@suse.cz>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <Zd5lORiOCUsARPWq@dread.disaster.area>
 <CAOQ4uxi=fdjXq7q0_+0mDovmBd6Afb=xteFBSnE-rUmQMJYgRQ@mail.gmail.com>
From: Chris Mason <clm@meta.com>
In-Reply-To: <CAOQ4uxi=fdjXq7q0_+0mDovmBd6Afb=xteFBSnE-rUmQMJYgRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|IA1PR15MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 077ca3ea-efb9-47f3-e09e-08dc3865b3f8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	amCNt5xMF+9yOmMyFCNVEWEiiNAHPgXc3gTniNi3kUzSXVvutJo9KUnDnenx9VRd0vOZ7ravBHJ9c9heQLytm1MC2+5UsgnGwg0AU7IhznwSnn0uAcahx3mVxVGBN9LAE+0So1DUmN3cf+jFa84yn/7c/SljLIDc9uU2WepjbviEwIbhrPJtWnIJX/FHjHf37zn6kNNbW3HbQw2Z+DIWZ1kcf5loSVX+ghmZYsLLNCt9MheZ5W+/OuIrafFpO0UN6vN8abgNnheJwO8OnMGQJOaHraCrBMNfK6qjqCsLmGBPAO5dcV51zgtALNc/RK/thaBTpOSq8owHPMC0SxA+2oi66vn97jOEcGxu7EvgaHcGxXpUNNCGZv+kJubwQ4YQS82aW59onKcVrFVzWJFMEmAh6TlqexNKUosRHQMpgfD8nkddQCOOa4vWyAp9GlI02JbXVtYbDc1MmUfrezwEl6XHFM8xVQiZ/oSBT3oZB/KAHwBU7phS/0pHNZaTK/8rtBFiPWNnauIr4gI8+F7CdGX45OCZn+/usKLja514B7EHlenEUth7dx0vlQ8rapOdMvu9UFtKvMwXr8lkCszn2Mv19kaArhfI419rpnbFbMhzEie27puBFr/oBzVn62LSuIcChS34qRkUAoEqTYSTCA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MklBU0VRLzhOS1IzUklURHBLa2cydC9GTEd0TCtpK3RnOG1LREdFV0d2eDl5?=
 =?utf-8?B?K000MFIzL1FVZ3Y2NVJuVldYMkRQSE92WWxIYnYyQ2hNN1lHUHZpcENGT3Rj?=
 =?utf-8?B?cEJDaHJEYm52YXpTa0p6K3FzV0lOSDBTM1JzWEFZMjVnbzhWdnpDZ3AybVdB?=
 =?utf-8?B?WVZZYUFWK29rbHR4Y3AwYnppMlQraUpNRzFab1U3NlZvZm10SlRObXF2Tk1F?=
 =?utf-8?B?ZGx6TUtWS2JzS2dGelU1cys1ekpheG5BTG1SYWV5T0FkaEJnZTNGY3pscUxm?=
 =?utf-8?B?b0h1NlRMOXhLd3FZU3Q2SVArVHhzU1FyTndXUzIvT1I1UHVPOWRqM0wwd1JO?=
 =?utf-8?B?b3lOVlJwdVpEMVZPcnJTN0h1Zm1GVzQvbUJuS0xyZ05jWjhPWHlBa2hOYytl?=
 =?utf-8?B?UisxeXNsQmh4dU8zSHZWaU9JMStxZ2QrWWhxQnRxMUkzQUJUTFpWN0EzeDRW?=
 =?utf-8?B?SDlYOUM4d0dpRTNkRUtDcFBINVBsV3gxQkFMT2tUazBRU0RpUzAzd2kwU0JT?=
 =?utf-8?B?UTNXRmlxQmdLcWFSS05tckxzb1ArOVMxZEJMV0VmYWptVWY4OXp4alp6MjBx?=
 =?utf-8?B?THFSOGRNZEN4V2dLRFF3UWgzWkJRM2crdW1pdkZVL2VscVcrdTh0cUFENXNv?=
 =?utf-8?B?cGRCWFNsWW1XL1dHdkxGZmZaMkt5dExwanRUdjhWNGppV21zUXltb2JSUFJ6?=
 =?utf-8?B?N3FHQUZHSmJwUjlwZ3NFbnU5N3RTUTNUTGYwNkdMS3JzOFJSUDhEQkZlbFFv?=
 =?utf-8?B?SzJBV3JTOUpwU0RSUlJZVHNKSE1qT25OVzZvSDNSWUkrd2p4MTM5dTZuNUI1?=
 =?utf-8?B?TFRrU2JrWjNMZitUSTgrRm5WNkNnV0lYL01GREVuaXFuR29sTmdNL04wTExS?=
 =?utf-8?B?ZlJRNTEyeU4zM3FXaUNvUFBtaWtHTStoSE9DbFdxWFdlczBrL2dmMGRTQ0Ew?=
 =?utf-8?B?K2FxYXBSQmM0VEpkdGFXT0YwQVZ5aXNlL0pqazZOMCtTNjZteVVqYzlYMjVZ?=
 =?utf-8?B?YXVQSmdsZEUxbEM3MnFKQng0cDhodllPbU5IZWJGcE9WQUVFVGF2Vm45RFJD?=
 =?utf-8?B?dlNKUzZ1QW4vRWhLZHRmalhxZHl1bXcrSzdJRHcrZU82bUx2Y1ZTYUpWRzZW?=
 =?utf-8?B?WVlJOXpDWWc2Sk1VUDFwSXF1YUJpbk90RG9xaHNkYXFaYmJxMkxDblZ5Tjh2?=
 =?utf-8?B?eGhHMkRpcUJLblBHSjdGWFRnYUlGV0tGRXdzZGNIcTc4VnlneFIzNjZzekMv?=
 =?utf-8?B?d0d1M3ZLc3c5MWtrd1F0dVIxQitRd0s4R0lJUk5QOURsT1NnaGJuWlNtUmND?=
 =?utf-8?B?Y2twYUFqblhScFhkR2VyTDBsdTlhSGlLWnVNek1UNERKbW04UXZHeVFDbUhI?=
 =?utf-8?B?QVFUODlEa3pnWDUyaVBCZDFDblQ1RnloRUFLbjh2T0dPcXMvWDZkRXRkeDdw?=
 =?utf-8?B?TlBUM0RGTldGSmxwZGd1dXQ4aUdESWx0cGZpSGxQN1VoYmpTbVRvK2pGSDZu?=
 =?utf-8?B?aWVYR1RPM0lseVY2N1Z5WDlnTnFmalloNllJK05LQkxVSDUyQm1nL1lZSzMv?=
 =?utf-8?B?SHR5cCt6YjVQaW5MQTlaYzc1cG5pV0FybndKVjhNTXI4MHphRW5pcGdlOXJp?=
 =?utf-8?B?MTR2MVdZSlYrMkxWV0RCM1kvK0EwVHB1QStlelZMOWkzZEIxM2NKTHlNeC9M?=
 =?utf-8?B?K3RYdHFXc3dpaXM3MGJ4cXZvL3ZQOEZiQ3Q1TEw1bCs4TVhGZ0J2MHgvVnNx?=
 =?utf-8?B?a1FUMWlvdUZCYzZBTlNQZEhjK2hNeWFLWTVhN1BaSGh2eFRKRHlQUG10OGRR?=
 =?utf-8?B?NEx2THZaaDZPUitnZXgxTWdKOUV4TkpVdWFDdmxIMmR3aS9nQU9uLzhna2lv?=
 =?utf-8?B?Z1lmaG11YzdsN3Zoa1dTYlBUcVlGYU5NUU05NkFqNXdtYWM4ZDJaYnhuS2hY?=
 =?utf-8?B?cVM4NkVTUmpRWk9ISjBMYUwvM0pyVE5xd0VGOUVxQ1BNa3dvSi85dTdnSVBZ?=
 =?utf-8?B?eWU2MWFZSkNjUjlxQzBMOUhiNzdHV29pNDdXVkpHclIvaGZoRGNyc2Rwb2Zy?=
 =?utf-8?B?RWhCNWdxNHQyemxCck1RYTd3OERoRGZ3UDgzOEptd0JhaTNYS1ZyTkIxVVcw?=
 =?utf-8?Q?Qz40=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077ca3ea-efb9-47f3-e09e-08dc3865b3f8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:01:04.7461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzfHFYtXVyrWJDgYP36iMqVB+J6bbLYeEQedWCOlo94LKwUZnycbTIOLrl2MTiXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5983
X-Proofpoint-ORIG-GUID: cTWs5Z0xikDwW7HP5-kjFjQ29YY5SVJB
X-Proofpoint-GUID: cTWs5Z0xikDwW7HP5-kjFjQ29YY5SVJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_06,2024-02-27_01,2023-05-22_02



On 2/28/24 2:48 AM, Amir Goldstein wrote:
> On Wed, Feb 28, 2024 at 12:42 AM Dave Chinner via Lsf-pc

>> Essentially, we need to explicitly give POSIX the big finger and
>> state that there are no atomicity guarantees given for write() calls
>> of any size, nor are there any guarantees for data coherency for
>> any overlapping concurrent buffered IO operations.
>>
> 
> I have disabled read vs. write atomicity (out-of-tree) to make xfs behave
> as the other fs ever since Jan has added the invalidate_lock and I believe
> that Meta kernel has done that way before.

Hmmm, you might be thinking of my patch to prevent kswapd from getting
stuck on XFS inode reclaim, but I don't think we've ever messed with
write concurrency.  I'm comfortable with the concurrency change in
general, but it's not somewhere I'd be excited about differing from
upstream.

Total tangent, but we only carry two XFS patches right now that aren't
upstream.  I dropped the inode reclaim patch; the problem stopped
showing up in our profiles, and the impacted workloads changed to
rocksdb for other reasons.

We flip XFS discards back to synchronous.  Async disards without any
kind of metering saturate drives when we do bulk deletes, leading to
latency spikes on reads and writes.  There's probably a class of flash
that can handle this, but we don't have it.

Unfortunately I also disable large folios on XFS.  They are corrupting
xarrays on our v5.19 kernel, with large folios from multiple files
interleaved together in the same file.  We'll try again with them on
v6.4 or maybe v6.8, but the repro needs thousands of machines making NFS
noises just to trigger one failure, and I won't be able to debug it
until I can make a more reasonable reproduction.

-chris

