Return-Path: <linux-fsdevel+bounces-68779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E5C66010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A0C93586DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87933318144;
	Mon, 17 Nov 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5gzLg61";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BAfyr/bF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665A2FD1BC;
	Mon, 17 Nov 2025 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408535; cv=fail; b=LUzhpNJdxwmL2bvoPy6NYqy5DDrzH8zdBfG4tx4254JEPgQaiQIT5P2A/AmQq2yKhYYsD/lCwsZYV/IRPiFpYTFPAX+4QhoQQxrjVReAbn4O6kW1MGr1d2wXQ8TnrTA7thzS+LF7VZC11kSDwU68YQNC0OzB8jstG4Lfnow7XH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408535; c=relaxed/simple;
	bh=u8hVr/tK3k2bgrh+KKTk/V5qQrrYhhblhLm5gCWmxnU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f7cvAHm4XkdQgJptluBwK8oo1gTCNh8BJOdF8O60A/EFTSZdCufXSNlk2B1MQG6El0QPmi4+CDFsqmkbZAdEAHZO6uM233kSE9WYmIX7bArxSTlCYCik97a6pBguLfXcNFkPHKohO+eRrYb1R2FE8fw3C/scLE1Cg5Hc+V5JTjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5gzLg61; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BAfyr/bF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8H0V005789;
	Mon, 17 Nov 2025 19:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C+1Nn1ldf/uKnLZG/UEE7n2DpjRFQYsC6uPj6+OwSqQ=; b=
	b5gzLg61e7LAm4EJjrXOB3VgSdYjD1olI/5lV9eEH+YE01VGvYyvjNN8s7/Klhgd
	GjzSn7kt9WzYrNp4iLVwv06yZ5osAgmvRKlHKcV9+nHZ8Ri7awNNqaexqiyne5uu
	CpncTHB1n/5JuReXAK+GFl98LF+AkiK0z3tK6JIsVc3o70CmonHC/2ShkDQGHfIM
	2H/OgNfQJnI7fWigBWs83bFmtow7aCW0FkGuPK3Uzene/rUZ3bUOXfYiRtD1QcJF
	Uu1WEEyJqGRLTHfQFo77V3W20buMNN/4PKQI+9pS+Dr9IbUUjsOwoihXho1W/sX9
	7F/HutHU+DLIx/24lalorA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbu876-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:41:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHIfemi009714;
	Mon, 17 Nov 2025 19:41:50 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyc5kvq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:41:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyTPe0pE9ALG52dnd0R3a8aWUBDZXLMqg1QokjCQJS3SK5abjd317p2GjHntZmjmkWUmJyrR5WScvNm8ROO1ttfBP3mZjM77PFb53pq72CI2gc022x97ZTaucvilLWZwpl4g4cn/X2zGAMlGSUgwEIn01IFzCEc3nsj47ysvLisd/TdzK20PL/+NHu75SyZtKdrjeYkhAmMsj7hWYmIWL/7oeO6h9KGN44tnatFpWtHgCxWyqMpce6ssV2mfzqOdwpSZsf8O89PWJ4KASVBbjqaI9UaJzK34i3fI+DqrBpvFnJxAAq6ppozdUlPFRv0Ouugzi8MINV18OtJHaq1wWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+1Nn1ldf/uKnLZG/UEE7n2DpjRFQYsC6uPj6+OwSqQ=;
 b=KFYHMro/WOWtTkCxKCWXjw9TxLNUoVZ6vRE1lYzHrA6kJRKsWjIc2KnNprIweNfxbvW6nl3CSqoSzVk69AVAzL6RHC+/ouZNUqP1HGHYJ5vD1hrXMvuhtBYpETRvqzYAilDMf9/lhb1wbwxSMbTXyKR1Xo+0olzL7wusT+fd9dmrkz71u+iVlqhd4jMbbBrK4AmNS9AUUHv7YPgFbExd7NT80jE3y9a0e9I80cDRj3Qv2HwgNL72LYQjtnDqCrXBYgIGyi2R5aaRUKG5VMlLCfW2AsqoOByXnM0cIRVB+T97DRZ4iH87xivoW/Nk+jKNAr9DJNhG9696qnpe6Vm7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+1Nn1ldf/uKnLZG/UEE7n2DpjRFQYsC6uPj6+OwSqQ=;
 b=BAfyr/bFv70s65vdCwwDQBnRB1IKRBkGC3gYy/y5tMEfdYF++QjuNW+G5yeiBJwWiv5l6Vj9FZTnK1EsY5tuAmFq0dBgIr1LtvGdE86mwRnuiY02rAUhtiC5QonimVopqDFAhjkCXvOt1iGV9oy7DyRP3H5qtkGBrWQAzD2WPwk=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BY5PR10MB4145.namprd10.prod.outlook.com (2603:10b6:a03:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 19:41:46 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 19:41:46 +0000
Message-ID: <cd1e4e2b-a8fb-44f5-b421-f40577b5e795@oracle.com>
Date: Mon, 17 Nov 2025 11:41:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] locks: Introduce lm_breaker_timedout operation to
 lease_manager_operations
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-2-dai.ngo@oracle.com>
 <86aa02b2214a6a775bc2d3fde0d180c2a55cb374.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <86aa02b2214a6a775bc2d3fde0d180c2a55cb374.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:510:23c::24) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BY5PR10MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5187bb-1365-4443-d753-08de261157ef
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?akk1U21NTEtMbE00bzMwYkxwMW8ybldhRWd5ZmpGbHd2MCs3SjM2MUlLTXdj?=
 =?utf-8?B?Q1VZNmNWZEphNmgxNFpKVnR6YWI0anRON1F0UjBQNDU2Sy82eFdza0lNbW1w?=
 =?utf-8?B?Y0Q0OFdQekRjMXFzMWZEVFdTdTRTSFJSUlUzK012cmlwajg4WkkvRlpmOTNE?=
 =?utf-8?B?U3BmQTF0V2pOazU1UmdFa0N2aHExN0pVQUwvOTZaWHFZaHdjKzFNUlRCRS8r?=
 =?utf-8?B?d1Zzams5RklUUFlhZnZLbUdCZmUwcldkSjN5TGxnN3YyTm5HMFFueDdsUWNj?=
 =?utf-8?B?N0E4emtEbFBEZmc1UFNBMnNVcTJOV291MFNWdVF2a3ZKRXpKdDdwZ3UvVnZ5?=
 =?utf-8?B?am1weDdnL21jN1VORi8wQWtqelo2RFFXU1U5dWxwZlJ6d1J5YmdpR1Y2R2tK?=
 =?utf-8?B?aWdNSWxYRGZnR2xzWmRVQ2I3djhBSzVTajZsaWVUWmxqYzduSlJUTUNPdDNi?=
 =?utf-8?B?dldHTDdvSFpWSEZXTHYvUEpxcWF0aGlKWHp6UnRmRXBraTZ4d3FjenNwVGZh?=
 =?utf-8?B?bkZWYnRZcTdTWGU0VktKNzJ5aVBnMDd5MkwrZGhVNWNwZFVlWFFGbjRTZ0Rk?=
 =?utf-8?B?ZVcwTk9qN2JFMTRzcXJKOTRKdThpMjhuK3dTT0tBWWtaeFhIUituemd5M3Vh?=
 =?utf-8?B?Y1pId3VIMXN5eTFseFR5TGlDZE5JeE13QVRyMERpMnJrUUk5RjdHOEtLRmFo?=
 =?utf-8?B?NXBWeU1qb2VxcjNwSW44OGdqR1FWMWdyeGZxTytVU3p4SUFFSnp3SEN5OXMy?=
 =?utf-8?B?MC83QjJDNjRadFBUdU1nZmlYSW03Y1JyWGFZQkdJU0hNanFVODNIU0UyWUNh?=
 =?utf-8?B?cFNGK09FY1NSVEs0dGU0L1BmV3NINFlBbHZkZThjWjF5amQwVzRiZzlVSjZG?=
 =?utf-8?B?OFJZSlJVQWM2bUNweXkvOWxmSXNhaXNCQzlBMzE3MXd6ekJRMFVjc2RITkpz?=
 =?utf-8?B?RmJBSnhORE5nN2hPR2l2SlJhSTluM3pMNTRTbDB2WXRkVG9pM05mTXZFT2JP?=
 =?utf-8?B?bUJYM3RyaXhoU3A4K1JPajlvc2t4ZWFta3dZMzI3cG12Y1VxSUVpMGYzN2g4?=
 =?utf-8?B?K1JiOWNMazd5SlloMGFsaGcrQWNnK0M1TkRDTEliRVU3VlpxM2VsY2RUVURy?=
 =?utf-8?B?TXYzS3BoYUVzYTREalAwZ3RIeDZUM2VQQWo4Qm1scERUWTQzWENQSEp6d3lT?=
 =?utf-8?B?M3hOT1hWenJuMThRRm1wVEl2ZGNLMllBL25yQlhaTzNvSXNFbVFhVVhjS2Nk?=
 =?utf-8?B?Y21YeENCNk9HY1FoSEwwVFVZK0tyUzQ5QjFEUU10MWRLSkNndFNaTzZGMyt3?=
 =?utf-8?B?ekFGSCtLYVFuemhiMVJmeGhZUGFaL21KRjJtZmx5VTF5OTJCSG5LYlBIVjVZ?=
 =?utf-8?B?MHZ2Q24xT25BT2VManNBOTVsYnpNVUdaV2xiNlVaZ3ZMM2VtazdYN2NFbmt3?=
 =?utf-8?B?bVJCZmN4VjNrQnoyYi8wcEhXNmJvejRvc0hHUXJNRW15Y0srMHN5YzNJeVlp?=
 =?utf-8?B?U0VCYjZaTWgvNVA4U0E1cXMyYzQyRjRwVGVQMmxLMnAzam1obEZweE5WcnFG?=
 =?utf-8?B?T3E4UU5ocjFjdklTU3M4VkpzVzdmcmtDZkcreUxxK2VMUWdJTWZydDZYam1C?=
 =?utf-8?B?ZGJETXBNRmNrdGQ1R2FjOUMvcGdST0lXS2pRQWlDVkRnRGlvQy84L1hWU21J?=
 =?utf-8?B?azdhMENEaWFnMy81QUxvemNvaHBvM1J6ZEdPM0Vsb09zdlFIVnZvQXJETzdT?=
 =?utf-8?B?YjhrK1RhUGJ3Q3VPbHJpT0xmb1hicm1ldVZBbFR1S1JqL2tvbENaTk9Ed3A3?=
 =?utf-8?B?OCtkVmRjdHJrVFJHL0l0YlBxTG9kRkJ4bm9RcGdEYldZS3ZqMGRjTElPL0Jr?=
 =?utf-8?B?YUd1dGdibEg0UmdNMUZyQWpETUJCdkoyMzk5OVcyTEpWNllPRTJ3UkNXREdk?=
 =?utf-8?B?VTIrYnlSWUErSFZYc0tIQVhBOEtwSnZZTEhoVnhDdlVNM0svT2tVd1dNa0VC?=
 =?utf-8?Q?Cvj+XAZpjyftx030Xr9MOzeqA0kM9Y=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z293ckI0VndVSzZVWkhxMjFKb2pJNGJHMENIdFV5NzhKL01yTUMzd1hucHM1?=
 =?utf-8?B?d2JVajVGV28reWlzMHA0YUhjT1VIekJPSWtjZ3JIaTFYR3o2UWhjcC9BOU1W?=
 =?utf-8?B?TmFuR0JHNVIrYXBSZitXZGRjSnVlV0NFSzJodmJKaGNvTFpNTXNscnlFVTd2?=
 =?utf-8?B?S3NseTdZNis5eGZrVjU4a3pHSTBDeXBzaUVwdld5cnArTkFlUkZOYUdnR2R0?=
 =?utf-8?B?ZFh2Nk9wSkpnNW10dE1tZkxvbVE0NWFUVWNvSGQxVDdYdHdpQVJLQ3RrRkFD?=
 =?utf-8?B?MEUxVGtkVXlYY1V1MEorS2xnNGljRHNDWmN2T2NvakdwN2R5Zll1WCsvQkZz?=
 =?utf-8?B?cUZ5VnN4SU1WOVpKeW9RNjl6eFYvOGl6RlRJbEpYbklRV1o0UFlrQ1UvYmJy?=
 =?utf-8?B?UGl5MXlxa2ROWTkxa29vbVJwSkdDRHF1d1lHT0hWeDNkaDdRZVFzNnVpVmJI?=
 =?utf-8?B?Wld0RUU3bUE2VS9JeTEzTGNkOUw0VFhoUGppVDVlSDFYSXFOYjgzZ1dPQjBr?=
 =?utf-8?B?bXZXNFozWjBaSzkxK2JsZ295Sm5pYmNBaFhHd0taWUxDekM2azdIdEtYU1JQ?=
 =?utf-8?B?SEZnRDQyd29sV002QWpRUHA1ek9LMGtZblpHaVN4NngzcTdFL0VBWERwUnNN?=
 =?utf-8?B?dFh3Q0hhM0lNUXN4OHJzQU8xRWk5ZU9SUjdKeHRhUGpkOEZ1dnJCVkhPNi92?=
 =?utf-8?B?RnppV3VqTE1yOW5LcStlTUhyTnRieUxhRUN0UmRUaGZVcG9SUWNpR0haUDAy?=
 =?utf-8?B?VkluMWRiYXhZdVNkcmlKNzFQOERrbjlRRjlLQ3p6RC9ZYm9VTCtWRlcrY2U5?=
 =?utf-8?B?RVNuc0NTWHV0T3c4OHl3b3RIbnB1MnQydk9PT1h4bE9RT2JMbEdTNTB1NktR?=
 =?utf-8?B?eGJTd2NUc3E3M0o5ZzdoRHFscGpKZVF2bzlyVzc2QkZUcCsrTDBQVzkyMk9S?=
 =?utf-8?B?K2kxUWQ5N1NISGdmRFVIRkF3S0tiTE1NY0lkU0JSMFNLWWZ0SDFIR1lHTGc4?=
 =?utf-8?B?cnJ4bkhPbm1DU1Z0aTNCT2d3aStERWpCbEhZSEJrZU15WitmeFhNQ0pvVXdx?=
 =?utf-8?B?MEtUOFcxeDJFbFcwNzlwTVAySC84dXU1MGVyKzNpU1JvSEFNMG1BOHR1aVYr?=
 =?utf-8?B?TnlEYUViQkJYaFhlYkJHbXVqRVp0R0E2emhla0lYOGVVcTVvZDRiVUtqeG1p?=
 =?utf-8?B?b3BsN0trQ09ZOHY0WHdFalM3SmNqMks1cXpMT0tyLzI0QytHTUl5VEdUU1ZN?=
 =?utf-8?B?cUZyS3hycVpObjVrTnZNTWNmRmN6NlF2Vml1dXVISkxmVjBQZnJzMldpM1c4?=
 =?utf-8?B?Q0VpY0E5MEs1aFZvM284Q0MrREJMZkR4UHM0NDVoOFlQOHJIK2dTNHVaN0NV?=
 =?utf-8?B?YUxITlcxQ29LOGhUeHZScFFDSFpTUVBXdUFWMFdDVE9JMEZiNWtYR09Md3hN?=
 =?utf-8?B?RzBqc0FnTm5abExLN0loUTJCRnNkUUtaWFJWbTV2UWg2Y1dZUllRRW9MTlNZ?=
 =?utf-8?B?M0EzRml6dnFOemJHaUVKQ0FGZy9JY0JjNHBXYjg1bHN3Z2V2aVBacDJPRlBL?=
 =?utf-8?B?Z3BrekpJV3k1azV1YU5ua3JXQklXQXVMaThsWTFQRVZ5OVllaUxkcXc1THVS?=
 =?utf-8?B?aGlQQjZhVEZ5QU13aHhPTS9kMW12UWdBRGlScm1LWG53YUx0MHE2bEh4Zm4w?=
 =?utf-8?B?b0o4bGQzUHBoSlVGYWQ4bWJ2WGt6d0tRWmVZcmUyNlpjWHo0UjhQbE9hL3U0?=
 =?utf-8?B?RXZxRjlxbWxjdlZ6WTYzbnlLbFZGNUY0RGFpVXp6bW12cHF3YXZEUjRqdTNI?=
 =?utf-8?B?VnFIb2ZiU2lkV2o2aDJYL1BMWUlmVWJxOU9memlGRzZCbVQ4TC9QNGZhMmdQ?=
 =?utf-8?B?SUZBaTNGVzh2YVhrYURLcmFNZ09SUFFiK2FCUFJ6ZFo3ZnlaTW5pTWxhOTg3?=
 =?utf-8?B?OGF2dXdhaGRzSGo0S0tpaGJ4c08rRGRwRDFsYUQ0T0NsZjZJOVBHVHpsNGhS?=
 =?utf-8?B?d3hCSUd6NHhGMXYxS0VRbmp2b0ZNdTA5d2s0djlGU1VHeVR1R0pQVlVoVEJX?=
 =?utf-8?B?QlcxazlQRTN5RHRSS2ExZndGcnduSlRhUGpYd2x1SExHeTE2R0NHYkozSFdm?=
 =?utf-8?Q?mmAhdUk0lp/O8l/NwJKBt3Gl2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5aOR3nv5b6o2iICCw57mbg8LGrbv4yNvgiWBD4RF08GyMXN91SHsfumbLJBzdSkGfS4d3jIJW4Hbs05+Ja0cSbfo6k3z353AsC1JAXJ4z4LsR3UBQcpQJ4yc4i+ZCphINyGyf+j4xl7vdHX11eDZ72+pXDoMsKdDl1LgsxvPC/KYVkHKI8sy51Nad5Rrl9EDNtcKqaWnGC/l/0uKKRmqB74cvZ1LYHksFXouXzfCH5m7DHDbfeJ5//V+MxLubSpETqCw2u4RxoRvwBoWIsJC4UqlVRkuu8lnpc+ZRgXbFgbJueSXKGHn7+VOxq+/eeJI2Hua8wU9nvRl2fuBupdLGZ7UjLxzPW+YxNnnUvF5nTAgIpysn7HNtI1XYXfxYqlLE/zpz2hn5QA4kCTKFGil6oq7jigJo59kfkAfrb/Ci/tOdJfjekvM3Ttfi6MQUYCJ/MY6b7gYjp1QuNq5Fo1VnywK93D2Jv212VMwNu+SUxBi/18OCnEsWSmke22HwCSBF9LNMoy6XtoIjLsXyPErotCBit5goXD6gfolXl6al6nUGM297oAGAGSNAgVGctOtKk+UEa3t052ppThPE01M6dmnZRGb+JJSrd29/8TOLYs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5187bb-1365-4443-d753-08de261157ef
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:41:46.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZhuRPZyeTy62I7vzpXDKGoQRzGNgihwOWI7fMaDxcSPM6/OwMOCm1cohHPsSKul0oxYWIiCwB7oEFJACvgtYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170167
X-Proofpoint-GUID: wiJH9dnILmr8g7R6PFbDPrE7oktzayu3
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691b7a7e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=wg0iEPHttGIzWQ57Ic8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13643
X-Proofpoint-ORIG-GUID: wiJH9dnILmr8g7R6PFbDPrE7oktzayu3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8g6AGrvgnN8m
 EuW3XB4GViLQw+c9gP7gKWSSBPnGjPlrdwpdyvPynLb2LPlKBYrDuL5JhNuZuGuyz/Lmg2IVjH7
 W/NBcM4INJb3vFzi34lsEckuzNm/Wfbd+2IHCemM0CKZCfOQZcXOnHZJcaOGg9XD5U4qMwyZNpf
 VY4+eiuixZxdLg1clFejsbyD5OfiB+Q7rI8LL7ws54Lz0hHESPHRsJEykkazrqoz82Pg+hvgNCC
 3aiuTjRWShiCdVMl/JnM9cuJnnhGg/E5BSoBVFO9nCPVdsBpchmMi4QJEya7/3niTkMnndBhPk6
 fOvGS+1VGEezxtBdUFuT/yY5HEx/2nm2tbCUUTIHSro7Nucv4KeA0Tc3XcSgYyrP9OTQl8mLv5z
 6D2DOCO9D6RsFHvXKPuj79uq5zy49eAj1LvyUHUy44lRMrLsKtM=


On 11/17/25 10:02 AM, Jeff Layton wrote:
> On Sat, 2025-11-15 at 11:16 -0800, Dai Ngo wrote:
>> Some consumers of the lease_manager_operations structure need
>> to perform additional actions when a lease break, triggered by
>> a conflict, times out.
>>
>> The NFS server is the first consumer of this operation.
>>
>> When a pNFS layout conflict occurs and the lease break times
>> out — resulting in the layout being revoked and its file lease
>> removed from the flc_lease list — the NFS server must issue a
>> fence operation. This operation ensures that the client is
>> prevented from accessing the data server after the layout
>> revocation.
>>
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  2 ++
>>   fs/locks.c                            | 14 +++++++++++---
>>   include/linux/filelock.h              |  2 ++
>>   3 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 77704fde9845..cd600db6c4b9 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>   
>>   locking rules:
>>   
>> @@ -416,6 +417,7 @@ lm_change		yes		no			no
>>   lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>> +lm_breaker_timedout     no              no                      yes
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 04a3f0e20724..1f254e0cd398 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -369,9 +369,15 @@ locks_dispose_list(struct list_head *dispose)
>>   	while (!list_empty(dispose)) {
>>   		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>   		list_del_init(&flc->flc_list);
>> -		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
>> +		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
>> +			if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>> +				struct file_lease *fl = file_lease(flc);
>> +
>> +				if (fl->fl_lmops->lm_breaker_timedout)
>> +					fl->fl_lmops->lm_breaker_timedout(fl);
>> +			}
> locks_dispose_list() is a common function for locks and leases, and
> this is only going to be relevant from __break_lease().
>
> Can you move this handling into a separate function that is called
> before the relevant locks_dispose_list() call in __break_lease()?

will fix in v5.

-Dai

>
>>   			locks_free_lease(file_lease(flc));
>> -		else
>> +		} else
>>   			locks_free_lock(file_lock(flc));
>>   	}
>>   }
>> @@ -1482,8 +1488,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> +		if (past_time(fl->fl_break_time)) {
>>   			lease_modify(fl, F_UNLCK, dispose);
>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>> +		}
>>   	}
>>   }
>>   
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index c2ce8ba05d06..06ccd6b66012 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -17,6 +17,7 @@
>>   #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>   #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>   #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>   
>>   #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>   
>> @@ -49,6 +50,7 @@ struct lease_manager_operations {
>>   	int (*lm_change)(struct file_lease *, int, struct list_head *);
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>   
>>   struct lock_manager {

