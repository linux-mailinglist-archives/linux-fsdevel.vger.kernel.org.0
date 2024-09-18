Return-Path: <linux-fsdevel+bounces-29637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B763C97BC2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06C4B26634
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439811898EC;
	Wed, 18 Sep 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F6h4Teq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2D176248;
	Wed, 18 Sep 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662251; cv=fail; b=WjCjLSlqY/oFJ2IMDQghOaIGBExa2RozgpU+DB+F6u7+WOkBFZ5EzcQhPdQkF6jTd5tNlGyKXBPxVVDJk0mts0kRsEmgCqfw9883QJfowQuh5OAitQ8t6h5+bI0+5BHXsUMRZZrwbBaMVGG4wTG9Jm2ufYFkApcZ16kO6N53DX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662251; c=relaxed/simple;
	bh=9wVgA/9ngA8hc5bnSJRjY9H3zZSNt8KGHjRFd9+ZbSU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I2RmdU3ESqDcENs/bOEoLVjW7G+0j8ipkQaBCXjm7PigGhqFEbhk2d0yWeUanvKLHwfund2Q2L0Ja6wF+6l0A1Af7m4URVECkuVD/caqB3xhZ6VwtDIME5icSmMMv09OzLMGroSv5FFSwnoXkprp7Vw2lmAStQwWYiSz4tAqXF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F6h4Teq+; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I5EjqW024907;
	Wed, 18 Sep 2024 05:23:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=5u8o42XBDAn94JOWX47xRTOgYv86fAmr1HrVVTIJgWM=; b=
	F6h4Teq+7RXaYBukqjcfv42HgVHx5VxvUjkURmRC4l1XpsHNq/m92gPMt4pkk/rF
	yBPHdaVt8Ll/DHMxJUAma5BJWbXmmyOmZShX1WdR06B0RAing5sB0+xTBGrYn8FE
	KrpLK8BGHSkyigTpRdyzThA3GZKE2r5QSovYLM9yDXvIQz5RTlYTtLSKWLHijpZz
	F0HHLHF9vGNjZa7yFWZH8+cJLQzhxOIwRhE94Ag/tw/MSkQ1nsOBvyvqBhTkT6Bc
	xMDuTT3A8z9dbLnV3s4B/3KWWdagYcK98hRsLhnaslga2jdBMNXZyF6pwljehAve
	FUipFF0HIhoFNZvlUYH22A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41qrhehxs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 05:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayjdIH9YQ3cuwBtBwEvdW2Dy3EVYrKXY8NkaeHkZrNj9sixFjlCaeZhtogYcK0D3kH2cV61M1JiriINPI6ubr92xslXPo87QfJIGa2NFMd8kg5HC6fatAg8N4Df/CA/uvDixzpDPNesJea+Nwcm7gKoKAMBMSVpYh3ayjjeVehucmUXV0KZk6UWAKgkzeKoGIsrOY6/8nCy/vXuPL0YKJpfIjznCZEbfoInmAG/1Q25yTYj0wIPoIfyhzW1UriqNiNLPCHazkO0M/7aJod3yFYHyp2MT6Li+zWqheVM3qwLTP1YV07YhlscsMZidF+WanIWwFz2nDxo64PgVRcnVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u8o42XBDAn94JOWX47xRTOgYv86fAmr1HrVVTIJgWM=;
 b=sVs+4fbzfn+bk5bY6lMtPxRY663vIObfhR5RZ2o5Jxre7Oj8R/Y4lbLHXGThI3OsOGe4ejNgSNKLgKnZcaIQEzSmYVRdD58v6O6tHgfr0kE/MkwqSAKd0RDw4SBqrQslTiXqkRoAMp7vZlhaOIJ+gLClpSA1cLGroP9SAtxqwRY1pfEbfO17JJgF5EDEPPjUGhtwRgE9o6LAqoTuM7jIw88vWRj1AmVQ/PDLFk3uuP4iJcyGnlPnwlMgx2YYvckl/0qKhmhk4mm69BsgNZQInPc9HdtrxSRqB09K0LeF7jhFX+r7ZZMu4NbC4j2hf3nyHsrHGZ1eeXriIQ9fmZSwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4853.namprd15.prod.outlook.com (2603:10b6:806:1e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 12:23:47 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 12:23:47 +0000
Message-ID: <8148432d-5865-49a2-affb-71fe79df2e4e@meta.com>
Date: Wed, 18 Sep 2024 14:23:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Chris Mason <clm@meta.com>
To: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
Content-Language: en-US
In-Reply-To: <459beb1c-defd-4836-952c-589203b7005c@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: 13175a48-2f53-42bd-72f5-08dcd7dcbeb7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODBkNVFtaU9yK2hzaVMvdnNpMUhrbmxBaU5nVTZPL1BNMkhpWjhJYkZyL0d6?=
 =?utf-8?B?OWJzNHM5cHlwNlNTVjFCWHpjVUZpTCtqZ1daeml0VEFkVmpNT3RjakhGZGhC?=
 =?utf-8?B?WU1UN3dWMTNwL3E4QUgwbURndXJJWU1menNUU2Z2b2VXVWpjcUxsTGNiRXpt?=
 =?utf-8?B?eGtHRFRwYTVXeTg5V3JLdmZPQmNISlVWbzNuOExlTGxsM0J3SG0rR2s3Tm40?=
 =?utf-8?B?bDEwODBBRnUxOUxCNGJGenZvMmNXd095VTFiVGhaTkhFdGtGbGFoWEdLdGVi?=
 =?utf-8?B?cmU4T3VGc3prY216VmJUcUF1bkVHQUw3VkdGSUoxY3lmQjc4N3ZPT21nWmxh?=
 =?utf-8?B?bWZZaHYxMGVTVDA1aUtaQ0hTWithY2VMZnM2TVhNcDdqYUNuUkF4OUhRREgz?=
 =?utf-8?B?V2hkL1FpRWhha3F1MmJHZm9RS05HN0g3ZEdmd2NjRXlRSHRtaWVCc1ZOQUlt?=
 =?utf-8?B?RTdoK2Y1NEtsMXJJV0x6R2JrWlRtL0xUQzZxcTJNVEdkMG5ZTDZVc3A2UThl?=
 =?utf-8?B?Qm0yd29RblNwUE5jSUU1VHhQZmVnRjVOSGwyN3JIYi94bFozMWFBQTAxVmE2?=
 =?utf-8?B?UEs1RVlNMGRBeFc1VjFXM1h6c0Jlb3FmVG1tK0lXZlQyYTlLb2pjUTFUeVRW?=
 =?utf-8?B?YldSeEVKazRyRlhwa0xTWll6K2FmZ0VjRGdSeVlpM09CbWRyWVRYR0NWQmJh?=
 =?utf-8?B?SXVWSHZpekgzKzdVV0ZrbEgvbVExMGxMN3JKOGE1K1c4K1BnYmc1dnZtRlNp?=
 =?utf-8?B?dmpZMjdWaVNsTGpQc0l6UEVtMlNhR2NEem1Jdm9nbTlFMHFzK2VIRnBCVFh1?=
 =?utf-8?B?N0hidVcwaG5CZ3dwTXBmQnI1Mng5Y3ZmSHRyZGVNUVdQM25GcU1RdFpNNmRI?=
 =?utf-8?B?RFdsazFWL0FtcXVzTHBlbmV5VHYyTlRyNXYrVnBhSWxSLzhQMHhwb0FTYk9Z?=
 =?utf-8?B?ZGs5Z1lORkdZZlZxb0M2bmpZWUFKREMxaW1ET2t4NWFYTng1QmFJNjdEanZi?=
 =?utf-8?B?cVJrNE55QVpxSzh0UklTaDRpcHNJN2lISEdkeFNQZlFKZFhMWW5nTzBJUCtj?=
 =?utf-8?B?OUs3YjZrUUpxdEpzVVJrd1dSY0kvRzhWODZncWU2MW5XdGJOK2NDN2M3ZlJJ?=
 =?utf-8?B?UDlucS9VTGNiT0FZT21FRUZFQXNTcmltOHhVYVFST1pHMnFheXAxV21SNWcv?=
 =?utf-8?B?d3JTa29TVjEyYVBIYW9ReVh3NHArMGM2dzIrRmdpVjhibVFGdjNaUjJMMEpI?=
 =?utf-8?B?Zlg5UUVqd3ZYV0d6Z3ZCUkdzZVB0WmlVcGVhcStOVzhYRUJ3dFJVamxuY08r?=
 =?utf-8?B?dVlvR1VsbEpMRUx6Y2h6QzBzMGc5ZmJyZDdHYlNaZ0FkaERJUXlTd2Erb0RC?=
 =?utf-8?B?SEhrZGxUSlpBaHBoN0dUZzlwZElwakxUS1RUZ3AyR0o1cTVuL1lsVm1tOXp1?=
 =?utf-8?B?ZnNxb1dFUU9OMTFidWNVOERKWGs4ajVoTXFlNHRMNHMvRE1RL0FZN01QTHI4?=
 =?utf-8?B?Skx0V3ZzLzkvVUo0bVdWbmxsT0R4ZDdOTFEvRWF5NGZhdk5MWjIwR0VhYkdG?=
 =?utf-8?B?WkhFTFlNWno1dGlSbDdIWXJSOEJDTXVOZFhLTGg0UEw4bXh4V1FiUXp4bWlI?=
 =?utf-8?B?S2QzaDgxUTF4dW1qdzdNa1lSNitIaTAyOVJ0d0NUcFVZNWNpY2J3cWo1RStU?=
 =?utf-8?B?WnlRYVc1QTl2blFkMktrOENPUGIvSTYxT0g2QzRKc2UwM0NETTE1S1FtS29m?=
 =?utf-8?B?Z1dndlRyZ09WTjVqREtLUGd1czdDRDdmN2R0S2w1TkZUL1JmTjV6a1IrVUFu?=
 =?utf-8?B?QXlobzY5N2tPRzdGT0FrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEZOYzFIeU9qYW8zSW42aEtFNTYyaDhhblBEL3dCV0c2WThxM1dBWWtKVGpR?=
 =?utf-8?B?QWNvTGlaTUpzU0phcXBTS0dKNlNWbjk4cllXY1RYYTlSSjJTbld3bjQxMW9U?=
 =?utf-8?B?Q25wUVpWOE96ZHpBNks4dFU2L09VeFpDR05aTDMycHk5WjBOK2huSE1xYWFJ?=
 =?utf-8?B?enRJekh3ZGFqMXd4WjYxRituc2hVbjNwNE4wdWxSVEFqZUxFYXNNY3Mxc1Jj?=
 =?utf-8?B?ODQxeXBOMmwyL25Ka3lvdDJiS2ZMUEIzamRYVFpQN0NjczlkbThnL0hCUStk?=
 =?utf-8?B?WCtqblA4bW9OU2NTWFNiT0g0YkU5NHVYQU5jTkVVV0JqaVN0dDZ2YldyaWFX?=
 =?utf-8?B?UmlIK0p6M1doSTZhWVdWUUdFQk9ySGo4Q2F1TTFlUjVRRy9MYTd0eHVlQWRK?=
 =?utf-8?B?bEJkNGx5ZTh6UWQ1Q0hGS2xsZi9uWnBsdHNJZHR0WkIxVm43a2dPM1hNQWhw?=
 =?utf-8?B?NzBhTVlsV1pES3V2SWNVVGRUYTBvUnVsYTVYUTF6Y3VqUXRKZHpEQ1U5aVJX?=
 =?utf-8?B?SlBqT1pFendKM3d4U1pPS2JRZTk0S3c0YjY0aEd0WGgrQ3U3Yk01OTg3MkpR?=
 =?utf-8?B?OGZVdHV3MVdpSW12bmcxUklKazBXd0JmWnZqMEs5TCtmK1RiWFhPS0JHend0?=
 =?utf-8?B?RTZDLzdXRlFYcnlMRUMrTngwckhKQklUc1Z3OWlLZTkzQTBFSG9rOGt2QXlq?=
 =?utf-8?B?Q1FNUlZlanRWcGN3cFZ4aHRYVVdoTWtKUTB3VUJnaWpGcFJ2emJMYWlJMWtX?=
 =?utf-8?B?VmVwNWk1bFQ2a2VUZFQwaVlaZyszNi9kalhNYnMzTUpXRkRhNGFNSFdxNEh6?=
 =?utf-8?B?dHV0ZTR3OWk3RTNSOUR5QlNxZ09UODVLWFkrRTZHL0creG54OXZlM2FvdllS?=
 =?utf-8?B?RzgxOHBBbEJDM1MxQVpNejRUNGZDK3Zpc2tLc0FGRGRxM0ZvVnNsS1M3WHpt?=
 =?utf-8?B?TjZzOUNEdWpJdG1PYVFQUGlOcWc1UWlNSGlCSWUzRkQ3WlZCQmxYK2hrdFNq?=
 =?utf-8?B?VWNZWjFsVXN1TkljOEJBZS9MSWorTDJoektHTWdVMVVqclFzaEhSRGUrb3h6?=
 =?utf-8?B?T2t5cU5GenUydFV3TGtpdXRrQm5RdTRTakxDTkVDNDlhRGo0SStwVXp1bUNO?=
 =?utf-8?B?U3c4cEVheGFMdHYwKzNQRC9jdjAzdi9WVjJnYUlVY01jcjcvZEdvNHBEVHo0?=
 =?utf-8?B?dktsb0xJbEttUlJzeEtjeE4yS3NVblV0OHJ3dFJjSUZZNC9wamZPTkx5dGI0?=
 =?utf-8?B?bU9wN0hmUjEvU2dzQXVrOVdGV2V3OGR4cW1Ld0tTaGxLTEgzNTJSWUMwR3Ry?=
 =?utf-8?B?RlhMQTNQMTFvWkFpaWlVNXJvS1ViZFNYWnJWQUduci8yMllNVTJ1SDMrUFVE?=
 =?utf-8?B?OW9hNW9zY2dFUkZMU2pFc3hoRFVNU0lWUkorL3d5VnNRbktpT3U5c1paV3c4?=
 =?utf-8?B?MFlVZzhEMFR3NzMvWDdnSEF6ZXNWN1lsZm9lN2xrd1dWWFc2MGFWZTM2dU1u?=
 =?utf-8?B?SU94dHFlYTA4OWo5TThNanVBQUx4OFdOaDQ5Q1V6c3FoWE1FMXRhVGZyeUht?=
 =?utf-8?B?TklCaUNXU3NaU1hCblZQYWE0ZElHUVdEMVVJWm5yemkvU3YvdE5oOXhYSHJ4?=
 =?utf-8?B?SkRROVFoQjlpMlJidmw5Vk1mblNFeHJMQ0FqV0tzMzN3VFByajdYZCtaZjFY?=
 =?utf-8?B?SThOK0d6OHI4S0VKV1ZKOTl6TDY3dlNHSnNieEdJY0c5MmtZVnk1QUV5ZFd5?=
 =?utf-8?B?Z2NWRlhpM0lmd1pQbkRHSnU0MHEwZzljQ2M5aC91VDZwOEVxdTlIWmNZREVl?=
 =?utf-8?B?cUhxbGwweStyNUxoQWJvcXR4by90LzdTeG1sMnhBOGhYNkE1N3drcFpUeGJU?=
 =?utf-8?B?Q04wclRsMzJ4RWdnbk45L0hPamhpOTBqM0VEaFdnOXNXL1FLdTltMzFKV21X?=
 =?utf-8?B?NU1OZ2IrcWVMbnF4UTJ2b0Q2TlF4Y2RuQkhDRzIvSkR4OGJOTW1waTVMNnZn?=
 =?utf-8?B?YnhQQ2ZoUWo2WlRtaXRpMGw0aWlUS2hSdllTOTB2Rkl0S0ZMZ0kwMExGR2x4?=
 =?utf-8?B?QzVaYW1GOFliYk1VbHZ4bFpLY2VnS3dyVGF2enlhZy9iVnF3bGcxU2dKRmZV?=
 =?utf-8?Q?hvnI=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13175a48-2f53-42bd-72f5-08dcd7dcbeb7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 12:23:47.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxq8vKvbM9IdqfD3n9zfM22mIeENw0mnOWSIPUp19atlwiMt/sVxO/5jpG5ohe9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4853
X-Proofpoint-GUID: RKmFRkLPH_XyXU0dBMHM5d-r7M6NGv8A
X-Proofpoint-ORIG-GUID: RKmFRkLPH_XyXU0dBMHM5d-r7M6NGv8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_09,2024-09-18_01,2024-09-02_01

On 9/18/24 5:28 AM, Chris Mason wrote:
> And I attached radixcheck.py if you want to see the full script.

Since the attachment didn't actually make it through:

#!/usr/bin/env -S drgn -c vmcore

from drgn.helpers.linux.fs import *
from drgn.helpers.linux.mm import *
from drgn.helpers.linux.list import *
from drgn.helpers.linux.xarray import *
from drgn import *
import os
import sys
import time

mapping = Object(prog, 'struct  address_space', address=0xffff88a22a9614e8)
#p = path_lookup(prog, sys.argv[1]);
#mapping = p.dentry.d_inode.i_mapping

for index, x in xa_for_each(mapping.i_pages.address_of_()):
    if xa_is_zero(x):
        continue
    if xa_is_value(x):
        continue

    page = Object(prog, 'struct page', address=x)
    folio = Object(prog, 'struct folio', address=x)

    print("0x%x mapping 0x%x radix index %d page index %d flags 0x%x (%s) size %d" % (page.address_of_(), page.mapping.value_(), index, page.index, page.flags, decode_page_flags(page), folio._folio_nr_pages))


