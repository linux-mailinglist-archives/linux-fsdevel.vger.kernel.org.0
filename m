Return-Path: <linux-fsdevel+bounces-54937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C1B0579B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDFD561CF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582FB2D660E;
	Tue, 15 Jul 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndD6L7ka";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZKci3Jlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9C23BD0B;
	Tue, 15 Jul 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574645; cv=fail; b=sQI16NsdKj5GBf2SzNRSxZBGgy+H/8gg7cfBGIJLXm5dKPWTEM8YPEbi35K6dLM8439CbPzk6Zet1K7xw2YuZKjmryRbjSa+Rt21eDwCz/m27Sq2H+hb4lF8BYNjrkMSxw8yHuf0XqARFBbVHqfdOd00ko0wYUmstFXVmJkfuwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574645; c=relaxed/simple;
	bh=vfJKK4i6Sih+u4JL6/1wefwYwTtClps/Vq2uMhs++aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tMkgHTHnvA+ysCYPf6OAMtshXRVoIRybdY4Y2K77oRoza5A534tep5GQZL/2FBr8kdxqMRQKVd2FsKChcW3kg3d7gh/nEacLII1HMPXp1KjJQTTU1rGeR1DQblVkb1apAngmc09FQ2GrgszH1e9UP6ZqRTKU9bn11Tixd4XVths=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ndD6L7ka; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZKci3Jlw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9ZJf0022651;
	Tue, 15 Jul 2025 10:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vfJKK4i6Sih+u4JL6/
	1wefwYwTtClps/Vq2uMhs++aM=; b=ndD6L7ka2i85mwwTdRgXZ4lWzIF/FBHnWO
	yOJ6rqO8GeR5R5K/5jLXhfwtGZXMGGtlNBl/U8w/tDgNJRWLp8+ECQnlv9je5zQv
	fZojehetZMJX3AAsZy6eagsZeRb8xNPhFOBGXC7p3EPBKQLHp2027gcb0pvHQ1MH
	RePHnzF6RO4Cgtnxu0p+DRRIp0obf6e68v5IB7Nys1487ohvZ14GeS5Oxl8x50C9
	lqQo/rWHt2N9/IaX+ctw/lohNhlzXwTEFni4dcOM6Jal+sbm/xQINhpoT3aQOigU
	aPMr5TL1l+zbg2irqgiBnpUsvuClHDsPqDy4wNYyUwH8UJ3qtGeQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66x3y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:16:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8IN4H039918;
	Tue, 15 Jul 2025 10:16:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59sr4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:16:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwffCAGX1V8v+z+hvPxvXPYVFAoTtRHtecdEUy/cVHEeB6yjjxqeqycJlkqUnGsZLHY3Dc4UqAl9q5ykqNvODrtzv/zUqzlLQBuCBPFqy1pujjbOrzg++Mzk6AHQ6EEO4HaGBGhPWlbXLkaHskq+2DXcVOY1X9ynlRIi5TmcanJ96M4/ayNcQ30CIm9M0QqloNVzW+VBsrczOUBAKvciHlO5bwRjVb22v1B39Brj5u8+aiaN3lHm3St7mfXKHVNtAqrNfc9fO5h6xcHCoT2/73iLI9VKr4aFOBjPgfOxU/gY0jxVEBVFjZi37ilOaia0FjjTfSGHxBdFN1H90aiSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfJKK4i6Sih+u4JL6/1wefwYwTtClps/Vq2uMhs++aM=;
 b=g+EL6KKSnj/J7BeITTDnFp4wFcxb/PxWnN95GfEkByr1BHofX5Ujfudg84tsV/w0CBUxA4RXzNWrtvQkBgPdt+NfZ0xsz4LHJtoRTDRcvtV55JVGgUCPFNSzVmS1IJzdYwx0HJ6BmOSUuy5Mh4XUAfr8gyDKqN02wf3IEuu/UrhQNFOxONxI7boDgctHm1ScA2qbH41SqNreKAIpOBe9erIBeVoEtmX9ZV3dcl/l/cn1yknrYf0QGlQcsuo4jU9ez6L7p/MaDd7qvnXzUQ92PV1/x5fSyx2v5AdAGtSJ/yJeUR4dOaq0kjHvtNj6IjHKDK3S1q6d5PxH30IO05ziJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfJKK4i6Sih+u4JL6/1wefwYwTtClps/Vq2uMhs++aM=;
 b=ZKci3JlwetSiNXBIC360tEtakMsoN8v0BVdeQ4duBNnbdM2tq95S2Vl96Arr9+UZmXsGI7w24a/B0IvjSXmO/0IT7bYjMyyQMmeOE/iRSQlWPAjU/1o/daHp4zSX4TYBU7CJ0hdq+7vHcDr0+r1rxkmx/pN9pE+86Qmtdks+HBU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5161.namprd10.prod.outlook.com (2603:10b6:610:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 10:16:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 10:16:45 +0000
Date: Tue, 15 Jul 2025 11:16:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org,
        mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org,
        adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com,
        yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org,
        osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com,
        christophe.leroy@csgroup.eu, tjmercier@google.com,
        kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under
 per-vma lock
Message-ID: <10eb7d95-4a02-4d5b-95ef-495bec7226d5@lucifer.local>
References: <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
 <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
 <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fa71bb-f765-462e-34f2-08ddc388b3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ejDwPBWwnBe2NiOpXHw9K/m5ZY5FqyrjEr3GS+zuLY6gnManw1SBvSEpCOrI?=
 =?us-ascii?Q?sm9aMtgUHAQ2Pj4GkQaSgHqvxwHcvr+aT/hQjM1M4BitgCeZq+x2a4/cbXvk?=
 =?us-ascii?Q?enJbY0adJXQp3vaEI6yEVcKJU3CQhMo4Jn0RYJoes9mwk07cPlm6E75tuaWL?=
 =?us-ascii?Q?jjGqjKvLplNbbc4zgTGtQI2irg4faU+3OVBeEqiU/sY5NabtdrbrHjWuQ+8Q?=
 =?us-ascii?Q?9IeDB06HZRuLyaM2AwH3X+PiyJ4yvRV7oGb58b2quND/NQKHglcM8T3HZn2d?=
 =?us-ascii?Q?yO2thLY4OMfGLiQCVS3bT1t7tVI/jKgPyr0i7zOAVjNAfM3BQATZE2bZOiDg?=
 =?us-ascii?Q?qfBPVyy1OtJhY4hai3yfEDnDdYUnIprW5w22fBfig9F2FEFv+7GdSklkMSlh?=
 =?us-ascii?Q?j1hSBLMqJByGpzBRpcVHqRfnjq5J++JIs0agfjmnMC4ipnPin6woP6z4VgfV?=
 =?us-ascii?Q?Epo4fiUNyVCbvdS/Getut/NrvEPKC/u/1+g5bOuwrn+MeUrrfSNdmEbDwCHH?=
 =?us-ascii?Q?sABNHCz6iSYu0BAW2sLmD3AhfoFUVTv1ZrlsuGxpECVHFozr6NKhEa2A18WO?=
 =?us-ascii?Q?NB5vgLIZuqB83XVnA/b5KdRAgT9nq7r0yOHvCdtNIDnvhLjEhVkuPRQvf7cD?=
 =?us-ascii?Q?jT5H/rP4FNGbvIxcmBaMUYkN0hG7QIv2CFzrWoxBTUoXugqP8H290aoBxpQY?=
 =?us-ascii?Q?u2Vlj2cJoBmwEFtbExK/x3Qjct2mGbz74KYOZyktSWCAn0o9rxYKerq+Ckqe?=
 =?us-ascii?Q?M7ZV20vMMaIeQKRoq4Qy9QPEFffDsWNVEWuxjIkf7dl0t5xB3PA3ENRP9Op6?=
 =?us-ascii?Q?LOwVm2eEunsRinBm7r666GYGFbS9A3RslCgT9hKsCkmMvQSrp05Uyq8FnzZi?=
 =?us-ascii?Q?BDELq8MIJGDmcAArwsT6L2o7YduO2oxn4Prh5v/UO16cfmr+I6UZj/jyy+qz?=
 =?us-ascii?Q?lmICdrhZdMCYH0agMC/zYjC+Jq4taPjzzmrU77S4r+4FWoqEloeNXVPqNjp3?=
 =?us-ascii?Q?kTmydqsvurVJs7sjtnq9DnYioFSy/SUaxjFEZLfxvrj78GBk9FhJ5sHLaeyZ?=
 =?us-ascii?Q?FmjnGSIr47nGNNICj3GIlzfZs9IhEooYEMbgG/jjuv96DzapBUBBZ/ylndku?=
 =?us-ascii?Q?YwKSkCCnjFQnwsqL8lggrOD4DpJF6MnYrpYr6OHdHb7nosX/kyHG4HHv6AQe?=
 =?us-ascii?Q?rSFrFNgsX4JUsB7kuyvhA8w5ZKiEVM//kdbgas1v9jZIlhBetStHBqSTbj84?=
 =?us-ascii?Q?ewZUV9OmmqybdseF363UwoZAs7LyFWp5BQqcpPV/e9aVW0eQZ17VYXTKtcuw?=
 =?us-ascii?Q?kYTVdROG82jPqfBpl68J8mdRBOA8AtAD1vsgpB07IKvuUwjgryPE0uwNrJsV?=
 =?us-ascii?Q?UV+GY1SFuNI7SLwPS97voi9YEGySesmoLZxlVbU/dVBE49uIq6lb6i/90KN6?=
 =?us-ascii?Q?RwGsfF0Ylg8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jqzHQMASp/AXEMNzjeJo9OlQAvbpa2b0hwSRA5NOkn859oSrlioC6kXIr4Al?=
 =?us-ascii?Q?ObWetP8NtIJNcLNd0o8mHS4B/H44j2q6JxLyBHiz0OM3SIqEa5jqRaNFmtFn?=
 =?us-ascii?Q?pDkvn2x8ZN+Z00eEdY4T7fRDwSzIZ2Q+aI2ZVXUiRUXyUZTh/+iocJCv5NlH?=
 =?us-ascii?Q?8Id4cyHOP3noJdvqZ11FSQb7KEmru1W8iRoq4yJc45VOcebBAvM2mp3Xbogz?=
 =?us-ascii?Q?g0Loi2z/lwyICfygjjiT+CyPQLcHiRKG5NtT/DkHk0/Wgshz5a4IyPMdGaFO?=
 =?us-ascii?Q?cH2HZjQ0Qu63I1w22U7b02/Dur4w9nQ7tjMsrNcpy5PTIRRueX4oXXkM903t?=
 =?us-ascii?Q?ef4MMqsVWMVioEBnxe5mLMr1Yud+D0h8SQRYOsLblSOPWbj95zwbDkgX3VQP?=
 =?us-ascii?Q?D5CmAyqKQ/UsjqOMqyQQQD4x8RVzHPT68eU7b0F8YPIQ4QNlr26/POwwWd1x?=
 =?us-ascii?Q?9UxuZxjhhoZM+Pa3UcLq3q0lZnbyD2DBl0VOdODxE5orE+tp845qlOCumoJR?=
 =?us-ascii?Q?6HLuw+oqNAnQTm2/TeACKUZRRkdLVutlSCWaxNmun+WEVB6ttTjf7/WYOznT?=
 =?us-ascii?Q?+qQeikWcTp4vqgtGPFDtmf87HtIgTB9Vf63Nma2rjRgfgeTHCGrK1/ORAJIn?=
 =?us-ascii?Q?+aXea6AOUrWAp+DFuXBL2IhbdsJB3UqImzbiptP5MjWtGOVxO54frXXtpciz?=
 =?us-ascii?Q?VMeKlt4vbZpqZhTb6yWgN76eKtz+Km3tkBXiHlzrQP7XpnYDl++pqZutm93E?=
 =?us-ascii?Q?cZKJhG75qReYZgeDODgDD4hv3VwqFWvhF0wBVfFOacu6mZ0YlVo6o+i347/i?=
 =?us-ascii?Q?htSq7CM6CxhRkG6KsoTK6Lv2cPmcrTi5yQHkPCc08RyEXFUy9EkpSv+01bEu?=
 =?us-ascii?Q?21yrMOLggSn97Whb6lAy0A1NsAbEQuBRdAVvWE52vjxTgTtPMn8Os7/ZZGDQ?=
 =?us-ascii?Q?hYQdcOZC+fq5qBlgIDHKfJ6DA9Gc5B63+BSZwD1HjLxJtBtVaZJaCXW28xec?=
 =?us-ascii?Q?opsk6tj9pKjMFavT8k89tN7rmKYrYD1yd5LX8g59Qavb7dP4QvMkcUkSgSuX?=
 =?us-ascii?Q?khF/C7WA+88DVcf65TEapbuYIOFUdO+cEaMxBVtzXiSjRzMx1PXUEFL5CWea?=
 =?us-ascii?Q?4qvQwsAFqlu25x65lLdKH13lLKhUFi3bYzBGfhzOPTpRGqbWThUyEeuhUdfD?=
 =?us-ascii?Q?hqMYk5bzf39WMPslMjlIkmCkm6hV09mwEUF6E2M5YzK6y8njmLH8O10ZMHcM?=
 =?us-ascii?Q?n8hTn8/7PXGTKSz8pSLAXKylVUcZV48v45u3u6XaC8IKIRJcTv34EAcGfhGj?=
 =?us-ascii?Q?oIthcKcyPkkSD5FHcU8Sf4nn1+Gt/9nv/G+NhO6Ac30wQ+qMRgLTbRw16guX?=
 =?us-ascii?Q?LUi3KD6fAqLoNeP8WZUmj7Iq601Vm7F1u0S2qudbpWONPAeWPuVf4Y6suJG3?=
 =?us-ascii?Q?SLPgbUvBya5b/FiQqcNk8y71KgEStx2tcKRALh0Qlv4cEPrwo0bohVHJX8II?=
 =?us-ascii?Q?qazcf/lHScCEKkyoooxEUdzQcAd5bNSTb0Dk4xRdkCgIq9KPich3fAq5DXol?=
 =?us-ascii?Q?vtsYiMd5iS/FPfID5wGf6S1oyVeif3y4KRe5T8dA6g/6RDSDUDhZ+ehVm2w6?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NSaXdaxGS9IdrTJuHevHrGn7H4Z0Z4yh0DzX3nXEAS2fVZNJ9dHOQXnkah/TH9msuYcJFNt+wTI7yV1jh9vO71mo6CslZGTwLk1vSrAO9j5ZZcS6gxNosmK0sCL1yZ0v8oi91L3lQCszUoCvtKiKcqgtopMU0WqPJfEVcTsNMnS6oGhkFiVJ//sMnPA81zJ4lLIWZcDEihZC6R98UWuVq2M1aBcIhPyxhns24+lkaAzjLy7eyL84DTvvYZp+2L95VhWdy4jyOKhj9sZoNRaiTB3q0Zzz0cxA5rjphtq+UThNuJoGGgXDx46WxPO1TV4w9BORQsxICFi5QcaSiwQXNFtw/kxFQcrsLds0IQM2WaIV7tJjKX22ZmQqDTFxIBLosN5eJf9wlFYovUIJY3zyipnkTS3Vm/TeZJM4Z/RdHjD5zXUEvJQ1Hw5RMSwf1r2xIYk/bj/CsmPDB8mUbg00C+NB+8eUpt59f4yn1eXYNZLO+GxIazgcIS7LNyyEU4Q3ea6+LDzOF/ouYb8VfPZKda4I0yLYbHOkbx3qKxEbt7N6hbJ55ZMpHuVY20bkV7oS0RtVjIOh+UATHF+oTx6uIHfDKUCA2BK6Aq7sYjGvO8Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fa71bb-f765-462e-34f2-08ddc388b3dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:16:45.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqWmpHiP2S5QTlX1eL2yAUXpnAECxfVvN95luvNoS4nL6CbImwEQSKA0L4esz/TBvhx6C4NI19PKHIsY2R89IMxW2/pNgUj9AxhUbpj618o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=971 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150093
X-Proofpoint-ORIG-GUID: JuzuFIMqjIupv2QBajYBk6gqJgML-QQs
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=68762a92 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ky5K4A79W2ygxjLqLZcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MyBTYWx0ZWRfX6k5zVqYXsQ7Z crttyKaNDC4rhTOUJNSFc0NipzPNA88TytYmZyqLQYokNK+VMrPLGpTLUx5y1czwucKamEqrbCf /Wt4d6ZBPW9T/QhAsyQRVaApbIw/7kiz650FbOAd7vC30mmTaxyOq1B69lyKGEJV9uLUJlD+84j
 gFrFzpNhPeej272iUKP8BALhNd3Ub8ArruoragPmqhfdlAhhdSv17Iuf2h7ixQbkxyY6DsE4XJc P3oHzXL+nGxxjyqrjjmJz8IV/71C9dPnqcDAbIyYM3ukyHm9bOLt2vaWzEgA6+NFqCg0XvmynDJ T3YW1zA+taxlPUB+ZPSpJW1VnmHXu9sEpKwA0+GeP0M8b7wJVTtn2+C9x4aClL52TXIspRZ6JkZ
 5Qkx28qBd8BKKhS8h7ESDHwNCwoh00/EXYWUc6oFWSayPBNp+/5/dDsaHwQrWexAUSpd6c3Z
X-Proofpoint-GUID: JuzuFIMqjIupv2QBajYBk6gqJgML-QQs

On Tue, Jul 15, 2025 at 11:52:49AM +0200, David Hildenbrand wrote:
> On 15.07.25 11:40, Lorenzo Stoakes wrote:
> > On Tue, Jul 15, 2025 at 10:16:41AM +0200, Vlastimil Babka wrote:
> > > > Andrew, could you please remove this patchset from mm-unstable for now
> > > > until I fix the issue and re-post the new version?
> > >
> > > Andrew can you do that please? We keep getting new syzbot reports.
> >
> > I also pinged up top :P just to be extra specially clear...
> >
> > >
> > > > The error I got after these fixes is:
> > >
> > > I suspect the root cause is the ioctls are not serialized against each other
> > > (probably not even against read()) and yet we treat m->private as safe to
> > > work on. Now we have various fields that are dangerous to race on - for
> > > example locked_vma and iter races would explain a lot of this.
> > >
> > > I suspect as long as we used purely seq_file workflow, it did the right
> > > thing for us wrt serialization, but the ioctl addition violates that. We
> > > should rather recheck even the code before this series, if dangerous ioctl
> > > vs read() races are possible. And the ioctl implementation should be
> > > refactored to use an own per-ioctl-call private context, not the seq_file's
> > > per-file-open context.
> >
> > Entirely agree with this analysis. I had a look at most recent report, see:
> >
> > https://lore.kernel.org/linux-mm/f13cda37-06a0-4281-87d1-042678a38a6b@lucifer.local/
> >
> > AFAICT we either have to lock around the ioctl or find a new way of storing
> > per-ioctl state.
> >
> > We'd probably need to separate out the procmap query stuff to do that
> > though. Probably.
>
> When I skimmed that series the first time, I was wondering "why are we even
> caring about PROCMAP_QUERY that in the context of this patch series".
>
> Maybe that helps :)

Haha well I think it's _still useful_ for avoid contention of the mmap lock. But
we probably just need to bite bullet and lock per-fd for this

>
> --
> Cheers,
>
> David / dhildenb
>

