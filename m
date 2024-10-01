Return-Path: <linux-fsdevel+bounces-30430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F033598B1A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 02:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A379B211D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 00:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF5B66C;
	Tue,  1 Oct 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YarfAH33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42536C;
	Tue,  1 Oct 2024 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727744203; cv=fail; b=t2ley9PDTY45ymVy6FeKK8EQodHM9WDWYhb+Qa2F8RRMMtFegenI41FqQ9M1XIQcSb2BWeS97bDCXzQdBa5xl3lOMm5IkjKy+S/Z5nwRHKK/FfDpfPeY1Lr0xpwxCWBd4hqfhYTTiiPDX1VYps9KUdAU0x1tsFxFz8xdRbtJgNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727744203; c=relaxed/simple;
	bh=vERcSwmrO8GrEQRqtmQ9eAmIVXSSKSExjF+trTJ60Lc=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=kp1L2Wy5X2qpjkVuCU7metq9JtiMYBSQvqitj0dHtqFQsg/Rr288GaIu2OvqyqEllUpYyMEpKhGXi2wmj0Ap/56r0UFSlLo6IdveWA0rl3NcAPlper+4VAJAFdW+DqMLj1J774ZdFTcz/vTGWbPT3cL5akvgk58Ve9BIkjWbR64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YarfAH33; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UMhqSn018691;
	Mon, 30 Sep 2024 17:56:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=s2048-2021-q4; bh=JNeQXWNEMI/j8YKo1
	1HEZB9VJNTsMLN/6vKuBDUD2FI=; b=YarfAH33fFiLRsvx1jmGGIETsJvWRT9H4
	ybg8gnc74kDVkGwXGJyj8c53sc1hu9QWBa2Cz3dkdFvPsObAnFFFP26+QGsOUavy
	PPRQESK5i71L1IrfrFaqQajibPARlzDPUF+hnEBxUy/td5kOYrOAGnqMNANz0hT1
	ZauphIQQ5ksViGCGY2BI/qTMlJ4XZ/rHNCCGCGkrzGpJwVDb/zlJ2Fzcr5wEXNOe
	8c3Tysnvviyb7ruSxobmgixgTraczgTqnQXlaLI3AJW5pUYIEXSzXYvFHn7M71x1
	fgHcVERrS+WJJWYvhVOiBxX8MORvFu4ZV7GPfyHU/Zu3F6sWs/MeA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41ymcu6tf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MytKEqBM2V15UzEtHN8uCFS86QbDPerPw7cDjAUyHDUNDCyLCpt4fk8H0bx27jRqu3XE8JXpe8k1PlN8qgb9Gcza+2vlYP33seEj9WhqF3w3vAPyG6tYQAvnZGhClED0paJtOlg3gdutuP5K8tyRht7eOsZWzNprCMk5yb6lTFY9hPeM9x92LhynFFMRwiQFu/agxmhQuoOKcwZZYa8cYz6f1FqAoE+rcRjAyjJ1ddMKf/H/aR05Qw8o4h5PcxWqNkT04QvyBAK00gl/BPaFSGNdXg6fzta/efEUPpBnc2fx3VcozgDaUC9UO4d7nfmbQK1Afl1uSGZKszI+TU0i6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNeQXWNEMI/j8YKo11HEZB9VJNTsMLN/6vKuBDUD2FI=;
 b=WBtnNIWdKymcyFe5qlCHyDBoKz1c+0eVWavyDpBhBA8jMK31xWNjyd3OY22Opdf1hkbZkiBGGzxTJ25TBL4IWEy9/cJSW6KjlP0J8PHvrEmstttvMJaSAVyCKp5YNeHd9rdJJToweik7L244yzKHOOK/Zy2obQDEg3ISJiFwQckQMNEDZfXWWmesG3mCQpyACoFJWaF/DOYZtuhY/9r5j2AGMDaksZie2qa7zQpd3DdFDjNjcUSI9uGvU+85FKbcltHqZI2CF/yaCLPqpt5xC3ZUX26SoUoD4snNXlhJyOAvqb14AMSenyzxkqC0PKaFkUwIwaIqiGqVpQpu6H3aRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by CH3PR15MB6348.namprd15.prod.outlook.com (2603:10b6:610:130::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 00:56:15 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::27d6:9fe:3f9f:3d44]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::27d6:9fe:3f9f:3d44%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 00:56:15 +0000
Content-Type: multipart/mixed; boundary="------------uhfmymgCLj04b1wzpifcYiA0"
Message-ID: <f8232f8b-06e0-4d1a-bee4-cfc2ac23194e@meta.com>
Date: Mon, 30 Sep 2024 20:56:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Christian Theune <ct@flyingcircus.io>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
 <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
 <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
X-ClientProxiedBy: BN0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:408:e4::6) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|CH3PR15MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: ee72a275-e561-4fa9-d9f4-08dce1b3d9dc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmpWYlVlMkxoYk1WWTBEMUV3Y2gxQ1cveHgrbHFXZElZQktwUFFTbkxSaSs1?=
 =?utf-8?B?YWd5YkJuUXBYbnFTaEx0a2RUS3RXR0FuUGx2YXFWY2VTb21mSzkvOXFuNlJX?=
 =?utf-8?B?bUpWdEFSSDRESmk5KzlOK1YwWHRxV1lvTnZEOWNYdTZ0Y1RIZVZUbjF0c0ds?=
 =?utf-8?B?Zk0rdlB2bTlzaG1nWGMrRTY1YmxHbjh5N0pjdTVNN29hNGh0U0lzM1JuL0tm?=
 =?utf-8?B?M3hqYVZ6a0xhUUxmOUJpb1NubS9HY0o5Tld6YWxGOU1uOUdkclVodXUxNHZD?=
 =?utf-8?B?N1RGUXQzQXA2WFV6emxQbm5Ya3kvODYwSXhVNGc4bEUxV3M0NnZ3aWgzc1Y5?=
 =?utf-8?B?TkppYk8zaFpiNm5LOW02b3k4Y1VSS3k2ejE3cm9PZDJZRGpGeGlZSUdiajJ1?=
 =?utf-8?B?MmRXWE4vQTdUekVPbWFZY1o0Uk1WU2lzU3R0VTdtZnNXYk5CZUJJMUZOVisv?=
 =?utf-8?B?aFlVMEpMWE4xZ2RnYzlSVmFOWWFJSkttKzVEc3ZkeW5ZYVZNamt5S2tNZUsw?=
 =?utf-8?B?MTBIakJJczJRMHBldWVWOVNXbWorQWhoT1pyUE1OckJkVjBmVzZkYStNR2xH?=
 =?utf-8?B?bytEaUJIRU1WTFVnNnJXa0pSdDZtbzY5cno4RUc3cHhsV2hkdjQzTG93ektl?=
 =?utf-8?B?aHU0U2lRNkl6enZZM0RIZlpqMUl1TnkzaHY4UjRaYUJCSXZMZUp0QmJjYXk3?=
 =?utf-8?B?SE9uMjl2cURCcXd6a24zSE9tSjdZanVWZG16VTlreDRPSmlGbWc0NnFaTEgw?=
 =?utf-8?B?UTdBYWw3UnUrM3NBNlQzOEhrMjgrc2h2Q1Erc3p6TVd4RUNvUVA0WWNwdG1i?=
 =?utf-8?B?Ny9HLzVCZmpYRHkwaW9qNkpNNzQ2Z25rUEVQaHZXV3Vza3pEZnJrMXpaV285?=
 =?utf-8?B?amZQY0tZQ3BoU3Y5ek5XbFcvTWxxTXFtVERKQmZXek1UZ3NwNzJjZ2V3Qkpo?=
 =?utf-8?B?ZFJqQit0RTdBNnZUTDZUSmRaZjhUWTlHSE13SmdSWHkxbmdtaDB2bHNBS09v?=
 =?utf-8?B?UWgxd1JOR0RBSTRmeFVMK2RDSUNXL21MNk85cGNYVzdLVGxiODcyQjN3Qlkv?=
 =?utf-8?B?VlZMUFYwRVA2TUlHZXV0Z1BnZ0hKcWtmNjlZYXRPZndwZWVEWGlaOW9SMmdU?=
 =?utf-8?B?M0E5MUU1WTNoZWpHMVROZUNjcWlHVnUwOVZjdTZ0anpqTTQyUWc5Z2I5UlF5?=
 =?utf-8?B?K2l1cEJoTTlXbEJvUkJZQVQwdE9QSFJ3NHJjZ0E0ZTk1Rit0M0tGcmxNdklC?=
 =?utf-8?B?RFVwV3hEeFhWemVwd0tiTjdCelpVQVphVjJsUXRRUWdZUjl1R2pSVkhRWTg4?=
 =?utf-8?B?blFVcTYvbjZjaHF2aTNTVTNPSXVocFJLUkF5cmFUa25IQk9mNWo4eVQyKy9w?=
 =?utf-8?B?ekQ3ODFkVUIwK250YzBydjM4dzU0NzJBSVhYVS9lTUpua3VoYnBKYkVuYlYy?=
 =?utf-8?B?aVoxNDZ5eEVsVHVpY3RuOFZHMWM1RmVnYVQyVXUzU1F6SFJ4a29sYm91YUY3?=
 =?utf-8?B?U1dBUmdsMFhLQTdtMjJQUk8wTTNCY2J6ZjN4Yk9ubExaM1JsTlZBSjF2OC9i?=
 =?utf-8?B?ZVoyYkJ4MnpmeGR5T3hIQ2tRZXpyalFIQjZ5dERXQ3BPZXpqQlVjWUNlb2dT?=
 =?utf-8?B?MU8wTmtFeDJZU0c5R2E2VjhRNjlvakNPbjBjUEFUeUhWZExqQW4wZHJHSjZs?=
 =?utf-8?B?R2l2N05QTVVUUkFsakE5bkJyZmsvK3RLSWsydHN1VUlncFRTRFBXeUxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2lYQjlRZk1ZTC93Q0xXVXUxam0rT0JkcjFuTkxUblBjODB5Q2ZWSDNBdUpP?=
 =?utf-8?B?QUxxVjRuYitOVDFFem9wNzF2cXFCTW1iRForWEtscDI3Mkp3SDJCaWZzNnhr?=
 =?utf-8?B?bXlNYlFXWVRBL2l1ZHIwZ3V0TVhMbDdTRDNHRXBmMkhYa0tQSDNHMlJ5NGVp?=
 =?utf-8?B?RnZYZ01TS2llN0hnK3JBRndweFJzTWZ1VlJ4a0U5SmVVbkJteTJiakxwcHBS?=
 =?utf-8?B?MGVyM3FzUi9sZklhMjJwTXZMRXpiU1p5bC9LUHZYS2w1bVE3SGpRS2s0ZGps?=
 =?utf-8?B?RitNK3dKYzcvYkkyQU0yNFRhVHRoMHY2ZzdXYk85YXcvdWFXRGVTYVZtUGMr?=
 =?utf-8?B?TzFlYk5EU1BQSjRZVlhCOHozTmw1VmtDeU1LbTRwbHRrMmdIclhjZFVRZWRV?=
 =?utf-8?B?TzZua3NkSndKZlpaZ1o1Uld1aEJBM0kzRVp5amxKN0M2azFaSnNadGdBOFg2?=
 =?utf-8?B?Y0ZldXZsc0Q5SFJzbjh3d2xxYW44MmRUZHlkWGNpRXN2MXFqZS9ueDkwS3JJ?=
 =?utf-8?B?Ry9ZUmZzaDJHMHlpVWw5WGF4eTlRQXdnUnFxbGt1UGtjUlBDK1NiSkQxVVlr?=
 =?utf-8?B?SEI1WFphblFEQ2wzdFZLTEY0WE1ydEhyYWhNaTlibytUMlI2OXhxWXMxakdm?=
 =?utf-8?B?SytOV0loY25NTVZ3VTNScnlEaUFCYjM3ZnJOUE5YMGc1bVJocmdrUzFnUGtr?=
 =?utf-8?B?YTV1bkovczRqcGx6aERsMGcwYmxCQ0R0d3Y2amhQbFRzWVZNVEJhSkk1VkI0?=
 =?utf-8?B?amg0WWI5NGJQaGdZdDRJUllUODIxdTNycllrYVp5WC9YVTVFS1NtYmxWUHFp?=
 =?utf-8?B?eFBEZTZ5NGhQVFhaZ2wxdjZmeWY0aERnUCtnSm1rY3JBQ1pqMit0NnIyOTVl?=
 =?utf-8?B?NUI2SkpBV0dhSWMrbEZqU00wMzRSNVU4MmhrRzk0T1lSdCtUblNoamFwWUJW?=
 =?utf-8?B?ejRZcHJvemVURlM0QjB0VG5VWW9lSFpVY09xM3R5ZFoxckFQdmRQVWQwRjFP?=
 =?utf-8?B?WFp3ZUNjVmFRTk0yZndETHgvL3JpanY2YThYSGFSRXBWQlFrbS9BZFBvMXN1?=
 =?utf-8?B?dUpUOUpqNnF2Y3JIU2ZRRXFaeXB5dG85M25RQXRwdU9KZ2JCeWF2ZTI3dlBR?=
 =?utf-8?B?THFFRGM4UHZkZXlsTk5KNVliMW42Rk9HSmk2OVVLOE4zMDZnbVFoaEQ1aUdU?=
 =?utf-8?B?ZVJsb3VQTlNyaWZnN1BhcUdGSGdQRUp6Zy9ESVFCSDlWWlFlL0szVlpzRWRx?=
 =?utf-8?B?TzZqWkJMUm1Bdkw3cFByMHNBNWc1Q0djd1FHZmtFVVhha2Y2Wmh6MWVENTJS?=
 =?utf-8?B?OTBJdUR3T1dIbnNBTzJtNUlLQUlMcExQaWlRMUczbThIeVNFSndYcEZrT0Za?=
 =?utf-8?B?MWlYTmJhTjBxQndiVEZ1TGZXZE9sOGczYzBGZkNoNWFqRndaaGNWOC9VeTlN?=
 =?utf-8?B?V2czVWN4VHZDUEdVMi9WVmJrOGNzd0JIVkxlS2JXR2h0c0JSOGNjQjlZczVV?=
 =?utf-8?B?dWhTdlNaWnI2MWdTOEEwWGdvTXNGMXFjSVIxTFlyNE9JN0ZyYVQwbWo1dnMz?=
 =?utf-8?B?dm9hM3JwYWU2bnpvTkVueGxKZW45cGNUR0VMbTBRTjJvS04rd2xHN2NsRzlX?=
 =?utf-8?B?KzByM2VTK2lMblFkTVhVY3FpYml0WGppTXE3MkMvNUFXWlpJalV0ZGJpeC9s?=
 =?utf-8?B?WVREcDMzWHJUQTFhYitjNlduNmFqOExoTUpvRDQ1ZWJSak1qcUpVb2s3d3lD?=
 =?utf-8?B?RU1zc1E3YWYzbFA2eC9KWUg0SWJuQU5GUWx3Y0M4MnpjQW85N2ZZSFk2MWF3?=
 =?utf-8?B?QXhzalN6c2tuNkczUUMvN3VPeFRKc0xEUHF1YWFrY2tickIxWnlZcm85ZkVQ?=
 =?utf-8?B?MzVNTFd0QUsvcXI1R01qekFhZCswZlN6dldiN2p6U2hNTEY5Y1BMb0g5VmFt?=
 =?utf-8?B?ZDFLdnpvbThkM1cxYnluMnFrTURraHVqR1NYc0RFTHdiMjh3bXJRa3BLQTh2?=
 =?utf-8?B?R3dnWEdRQkdwOWttR1NWMDNOZktZKy9idnBQdTZKay9IT1ROMDFTSjNZY0th?=
 =?utf-8?B?NUZvMnMzWk1xaVo2QXJTVXdzZzczODRNN25aOTBFTXhOMlBmVjJDb1BISXJS?=
 =?utf-8?Q?ahvrS6by+7Sg8xoD8oZ+f3/ka?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee72a275-e561-4fa9-d9f4-08dce1b3d9dc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 00:56:15.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qvSgP0W+PLHPOG09IzlZD8DOHK95bAXCe8DBoXIEqdjRguC2gvPtSTKerNhZ0iv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6348
X-Proofpoint-GUID: IARQy78aQ3nnlSF0kpSgs0WylG0QZsuv
X-Proofpoint-ORIG-GUID: IARQy78aQ3nnlSF0kpSgs0WylG0QZsuv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_22,2024-09-30_01,2024-09-30_01

--------------uhfmymgCLj04b1wzpifcYiA0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/30/24 7:34 PM, Christian Theune wrote:
> Hi,
> 
> we’ve been running a number of VMs since last week on 6.11. We’ve encountered one hung task situation multiple times now that seems to be resolving itself after a bit of time, though. I do not see spinning CPU during this time.
> 
> The situation seems to be related to cgroups-based IO throttling / weighting so far:
> 
> Here are three examples of similar tracebacks where jobs that do perform a certain amount of IO (either given a weight or given an explicit limit like this:
> 
> IOWeight=10
> IOReadIOPSMax=/dev/vda 188
> IOWriteIOPSMax=/dev/vda 188
> 	
> Telemetry for the affected VM does not show that it actually reaches 188 IOPS (the load is mostly writing) but creates a kind of gaussian curve … 
> 
> The underlying storage and network was completely inconspicuous during the whole time.

Not disagreeing with Linus at all, but given that you've got IO
throttling too, we might really just be waiting.  It's hard to tell
because the hung task timeouts only give you information about one process.

I've attached a minimal version of a script we use here to show all the
D state processes, it might help explain things.  The only problem is
you have to actually ssh to the box and run it when you're stuck.

The idea is to print the stack trace of every D state process, and then
also print out how often each unique stack trace shows up.  When we're
deadlocked on something, there are normally a bunch of the same stack
(say waiting on writeback) and then one jerk sitting around in a
different stack who is causing all the trouble.

(I made some quick changes to make this smaller, so apologies if you get
silly errors)

Example output:

 sudo ./walker.py
15 rcu_tasks_trace_kthread D
[<0>] __wait_rcu_gp+0xab/0x120
[<0>] synchronize_rcu+0x46/0xd0
[<0>] rcu_tasks_wait_gp+0x86/0x2a0
[<0>] rcu_tasks_one_gp+0x300/0x430
[<0>] rcu_tasks_kthread+0x9a/0xb0
[<0>] kthread+0xad/0xe0
[<0>] ret_from_fork+0x1f/0x30

1440504 dd D
[<0>] folio_wait_bit_common+0x149/0x2d0
[<0>] filemap_read+0x7bd/0xd10
[<0>] blkdev_read_iter+0x5b/0x130
[<0>] __x64_sys_read+0x1ce/0x3f0
[<0>] do_syscall_64+0x3d/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

-----
stack summary

1 hit:
[<0>] __wait_rcu_gp+0xab/0x120
[<0>] synchronize_rcu+0x46/0xd0
[<0>] rcu_tasks_wait_gp+0x86/0x2a0
[<0>] rcu_tasks_one_gp+0x300/0x430
[<0>] rcu_tasks_kthread+0x9a/0xb0
[<0>] kthread+0xad/0xe0
[<0>] ret_from_fork+0x1f/0x30

-----
[<0>] folio_wait_bit_common+0x149/0x2d0
[<0>] filemap_read+0x7bd/0xd10
[<0>] blkdev_read_iter+0x5b/0x130
[<0>] __x64_sys_read+0x1ce/0x3f0
[<0>] do_syscall_64+0x3d/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
--------------uhfmymgCLj04b1wzpifcYiA0
Content-Type: text/plain; charset=UTF-8; name="walker.py.txt"
Content-Disposition: attachment; filename="walker.py.txt"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwojCiMgdGhpcyB3YWxrcyBhbGwgdGhlIHRhc2tzIG9uIHRo
ZSBzeXN0ZW0gYW5kIHByaW50cyBvdXQgYSBzdGFjayB0cmFjZQojIG9mIGFueSB0YXNrcyB3YWl0
aW5nIGluIEQgc3RhdGUuICBJZiB5b3UgcGFzcyAtYSwgaXQgd2lsbCBwcmludCBvdXQKIyB0aGUg
c3RhY2sgb2YgZXZlcnkgdGFzayBpdCBmaW5kcy4KIwojIEl0IGFsc28gbWFrZXMgYSBoaXN0b2dy
YW0gb2YgdGhlIGNvbW1vbiBzdGFja3Mgc28geW91IGNhbiBzZWUgd2hlcmUKIyBtb3JlIG9mIHRo
ZSB0YXNrcyBhcmUuICBVc3VhbGx5IHdoZW4gd2UncmUgZGVhZGxvY2tlZCwgd2UgY2FyZSBhYm91
dAojIHRoZSBsZWFzdCBjb21tb24gc3RhY2tzLgojCmltcG9ydCBzeXMKaW1wb3J0IG9zCmltcG9y
dCBhcmdwYXJzZQoKcGFyc2VyID0gYXJncGFyc2UuQXJndW1lbnRQYXJzZXIoZGVzY3JpcHRpb249
J1Nob3cga2VybmVsIHN0YWNrcycpCnBhcnNlci5hZGRfYXJndW1lbnQoJy1hJywgJy0tYWxsX3Rh
c2tzJywgYWN0aW9uPSdzdG9yZV90cnVlJywgaGVscD0nRHVtcCBhbGwgc3RhY2tzJykKcGFyc2Vy
LmFkZF9hcmd1bWVudCgnLXAnLCAnLS1waWQnLCB0eXBlPXN0ciwgaGVscD0nRmlsdGVyIG9uIHBp
ZCcpCnBhcnNlci5hZGRfYXJndW1lbnQoJy1jJywgJy0tY29tbWFuZCcsIHR5cGU9c3RyLCBoZWxw
PSdGaWx0ZXIgb24gY29tbWFuZCBuYW1lJykKb3B0aW9ucyA9IHBhcnNlci5wYXJzZV9hcmdzKCkK
CnN0YWNrcyA9IHt9CgojIHBhcnNlIHRoZSB1bml0cyBmcm9tIGEgbnVtYmVyIGFuZCBub3JtYWxp
emUgaW50byBLQgpkZWYgcGFyc2VfbnVtYmVyKHMpOgogICAgdHJ5OgogICAgICAgIHdvcmRzID0g
cy5zcGxpdCgpCiAgICAgICAgdW5pdCA9IHdvcmRzWy0xXS5sb3dlcigpCiAgICAgICAgbnVtYmVy
ID0gaW50KHdvcmRzWzFdKQogICAgICAgIHRhZyA9IHdvcmRzWzBdLmxvd2VyKCkucnN0cmlwKCc6
JykKCiAgICAgICAgIyB3ZSBzdG9yZSBpbiBrYgogICAgICAgIGlmIHVuaXQgPT0gIm1iIjoKICAg
ICAgICAgICAgbnVtYmVyID0gbnVtYmVyICogMTAyNAogICAgICAgIGVsaWYgdW5pdCA9PSAiZ2Ii
OgogICAgICAgICAgICBudW1iZXIgPSBudW1iZXIgKiAxMDI0ICogMTAyNAogICAgICAgIGVsaWYg
dW5pdCA9PSAidGIiOgogICAgICAgICAgICBudW1iZXIgPSBudW1iZXIgKiAxMDI0ICogMTAyNAoK
ICAgICAgICByZXR1cm4gKHRhZywgbnVtYmVyKQogICAgZXhjZXB0OgogICAgICAgIHJldHVybiAo
Tm9uZSwgTm9uZSkKCiMgcmVhZCAvcHJvYy9waWQvc3RhY2sgYW5kIGFkZCBpdCB0byB0aGUgaGFz
aGVzCmRlZiBhZGRfc3RhY2socGF0aCwgcGlkLCBjbWQsIHN0YXR1cyk6CiAgICBnbG9iYWwgc3Rh
Y2tzCgogICAgdHJ5OgogICAgICAgIHN0YWNrID0gb3Blbihvcy5wYXRoLmpvaW4ocGF0aCwgInN0
YWNrIiksICdyJykucmVhZCgpCiAgICBleGNlcHQ6CiAgICAgICAgcmV0dXJuCgogICAgaWYgKHN0
YXR1cyAhPSAiRCIgYW5kIG5vdCBvcHRpb25zLmFsbF90YXNrcyk6CiAgICAgICAgcmV0dXJuCgog
ICAgcHJpbnQoIiVzICVzICVzIiAlIChwaWQsIGNtZCwgc3RhdHVzKSkKICAgIHByaW50KHN0YWNr
KQogICAgdiA9IHN0YWNrcy5nZXQoc3RhY2spCiAgICBpZiB2OgogICAgICAgIHYgKz0gMQogICAg
ZWxzZToKICAgICAgICB2ID0gMQogICAgc3RhY2tzW3N0YWNrXSA9IHYKCgojIHdvcmtlciB0byBy
ZWFkIGFsbCB0aGUgZmlsZXMgZm9yIG9uZSBpbmRpdmlkdWFsIHRhc2sKZGVmIHJ1bl9vbmVfdGFz
ayhwYXRoKToKCiAgICB0cnk6CiAgICAgICAgc3RhdCA9IG9wZW4ob3MucGF0aC5qb2luKHBhdGgs
ICJzdGF0IiksICdyJykucmVhZCgpCiAgICBleGNlcHQ6CiAgICAgICAgcmV0dXJuCiAgICB3b3Jk
cyA9IHN0YXQuc3BsaXQoKQogICAgcGlkLCBjbWQsIHN0YXR1cyA9IHdvcmRzWzA6M10KCiAgICBj
bWQgPSBjbWQubHN0cmlwKCcoJykKICAgIGNtZCA9IGNtZC5yc3RyaXAoJyknKQoKICAgIGlmIG9w
dGlvbnMuY29tbWFuZCBhbmQgb3B0aW9ucy5jb21tYW5kICE9IGNtZDoKICAgICAgICByZXR1cm4K
CiAgICBhZGRfc3RhY2socGF0aCwgcGlkLCBjbWQsIHN0YXR1cykKCmRlZiBwcmludF91c2FnZSgp
OgogICAgc3lzLnN0ZGVyci53cml0ZSgiVXNhZ2U6ICVzIFstYV1cbiIgJSBzeXMuYXJndlswXSkK
ICAgIHN5cy5leGl0KDEpCgojIGZvciBhIGdpdmVuIHBpZCBpbiBzdHJpbmcgZm9ybSwgcmVhZCB0
aGUgZmlsZXMgZnJvbSBwcm9jCmRlZiBydW5fcGlkKG5hbWUpOgogICAgdHJ5OgogICAgICAgIHBp
ZCA9IGludChuYW1lKQogICAgZXhjZXB0OgogICAgICAgIHJldHVybgoKICAgIHAgPSBvcy5wYXRo
LmpvaW4oIi9wcm9jIiwgbmFtZSwgInRhc2siKQogICAgaWYgbm90IG9zLnBhdGguZXhpc3RzKHAp
OgogICAgICAgIHJldHVybgoKICAgIHRyeToKICAgICAgICBmb3IgdCBpbiBvcy5saXN0ZGlyKHAp
OgogICAgICAgICAgICBydW5fb25lX3Rhc2sob3MucGF0aC5qb2luKHAsIHQpKQogICAgZXhjZXB0
OgogICAgICAgIHBhc3MKCmlmIG9wdGlvbnMucGlkOgogICAgcnVuX3BpZChvcHRpb25zLnBpZCkK
ZWxzZToKICAgIGZvciBuYW1lIGluIG9zLmxpc3RkaXIoIi9wcm9jIik6CiAgICAgICAgcnVuX3Bp
ZChuYW1lKQoKdmFsdWVzID0ge30KZm9yIHN0YWNrLCBjb3VudCBpbiBzdGFja3MuaXRlbXMoKToK
ICAgIGwgPSB2YWx1ZXMuc2V0ZGVmYXVsdChjb3VudCwgW10pCiAgICBsLmFwcGVuZChzdGFjaykK
CmNvdW50cyA9IGxpc3QodmFsdWVzLmtleXMoKSkKY291bnRzLnNvcnQocmV2ZXJzZT1UcnVlKQpp
ZiBjb3VudHM6CiAgICBwcmludCgiLS0tLS1cbnN0YWNrIHN1bW1hcnlcbiIpCgpmb3IgeCBpbiBj
b3VudHM6CiAgICBpZiB4ID09IDE6CiAgICAgICAgcHJpbnQoIjEgaGl0OiIpCiAgICBlbHNlOgog
ICAgICAgIHByaW50KCIlZCBoaXRzOiAiICUgeCkKCiAgICBsID0gdmFsdWVzW3hdCiAgICBmb3Ig
c3RhY2sgaW4gbDoKICAgICAgICBwcmludChzdGFjaykKICAgICAgICBwcmludCgiLS0tLS0iKQo=

--------------uhfmymgCLj04b1wzpifcYiA0--

