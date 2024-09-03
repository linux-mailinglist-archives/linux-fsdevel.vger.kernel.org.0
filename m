Return-Path: <linux-fsdevel+bounces-28406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D512F96A0C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FB81C23D14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B7E13CFA6;
	Tue,  3 Sep 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PBzb0spw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hryhyG9T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B31CA69B;
	Tue,  3 Sep 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374058; cv=fail; b=FzqvYm3RhSb3/3B5su1rlyrM4yiA7rM+TOxq7vWKp2tr2skVLXYpSZi0cZU+VO7yuYYloLYZhuLJbhqL1/dP/9vHjoFijvjFX+OKzqMlH05zdVK8J4MruMvIY6dyco7l4g1uUf0nR6oQjkbrokxXUicYFWZ4kVvkMQju09nttKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374058; c=relaxed/simple;
	bh=JxXLMWGOQKfGVZWArwf7za4MknQ1hq2qn1gM2+k5JKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=njIMI98fWegn2t5aGt2ZsnYqvWGXc5/POFSpnnHWiU/88tEsXDRvg0443ZsPB1v57vNb7hxUM+mImT56IvIALYyblpoiV3GPpGwZNtqr5/SIE1q6IGf8OoqcJkWGarC7tShHZlHagTRXthWr0pPLytBv2mN2VlFglWD6sIAW/p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PBzb0spw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hryhyG9T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fTq3007204;
	Tue, 3 Sep 2024 14:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=kTkvtW8bxS4i6RO
	vgZBNutkRczAYoIFklJkbNy5eWdM=; b=PBzb0spw/jOHv4/pA2yKsRaal3ARNE7
	YmqYpTuBA8YrzhhftVTydX3ecCRwoV62HRUG3jyHp8OwHj/yUcq0MFYmKbJPhYKh
	LVIeCDMrWr+GeEbCCy/GMiP5rXftVcNLTM3PFdPUmei0hZEihcf729B6JqKqrLlN
	tUnK3WDPA6Z+2K53toxbokVuR1tJei7uH+WdZuW2g8ipoFimkoEg30qhzgV+lQYh
	ejo3AQzofRJyIxKdJVokjFQyoi2dpX2OQIYaNgHoJxMMwmmsuknz8482wwYGPXXJ
	LeDAqAb/1Wi5ZHCUPEPDWOE3pTyvqlD8a4iAyNtcgALF6GkuSyqDSeA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dk84hrfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 14:34:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483EIkOG036955;
	Tue, 3 Sep 2024 14:34:06 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8snv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 14:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbRKxQWLZph38b+QDNIjgl/5vqyjplO8CtalgUcdg5S5rPa/M8nFqeylxVt0RtKU0s9HJN6z9R/tlbjM7nyuLr369fIhttj/Kdi+7KypYNhIxx9/FCH2P7A1QM2ccWlwsdbkgo9CjuPm1uD7yQLJMtX2tZl0fUXubokLEIoKUEEwnlZBUtoJdJpyOxrJQtVqHRIaiSbVv8P60092YiqDXyXgjazsetTVGfZQqqaKfVrw/1ytk6DKXyU0BxzbAL21h5YZPgZHuLHXPtqCNg850VzJmQxvxRWWf6HJGFDxWzbbpl0sAO7SuLkiUwo+WIgeXqoWM5TVwrD0ZF85h9vkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTkvtW8bxS4i6ROvgZBNutkRczAYoIFklJkbNy5eWdM=;
 b=DKz3hM/XFwEficBOZZcKs6AQi/YAZAPRJa0Krf0pI/ykAXTHemdJzQpIQneUBpkUrNm7+KXFR6ICgF8Az/Wi+5XrfYZ/Xk9cVdL8t8VWjqMm8N5p0Pp1Mc+mPG6ME8rEcOqI2KrLVrp7ui/73uu+x5bg8+cX8wELDdJR8Q3VczVboDHbhfvjcP84AXLeA62DwavWjX/P0K96yhguGFdbWwkvtMfpyY+ptMWsrNVrA6VdNiNn9g19ByJC30+SDDIFHZWjBqfe0HcU4pj/BihJW8SbU17Qmb/ner5P+ClRYPSfBhvXcUpNJ+0HYfhybOjLtUIvunITSRrOfZrAgzASDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTkvtW8bxS4i6ROvgZBNutkRczAYoIFklJkbNy5eWdM=;
 b=hryhyG9TpcTBrIydZX/JoTYPUFe6RJvqMbAHpVnZil2m0Z0Y69JIFcelSBNGG490JTyIyAGlNgOn5U9xFwdMknhafW0Nn6zlT0bWoVMIluUNJ+enfGkUB8Kvi8NhSE4GrrMxu6fgDGKsixQ311qKz3CU2oJEB3e/A+vXxkn9QDQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8002.namprd10.prod.outlook.com (2603:10b6:610:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.13; Tue, 3 Sep
 2024 14:34:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Tue, 3 Sep 2024
 14:34:04 +0000
Date: Tue, 3 Sep 2024 10:34:00 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <ZtceWJE5mJ9ayf2y@tissot.1015granger.net>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <20240831223755.8569-17-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831223755.8569-17-snitzer@kernel.org>
X-ClientProxiedBy: CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eeb0060-96b2-4db6-183c-08dccc2575bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iQAwceTCUK0B1Y4yD87VD00LR84R5yVRrGKDE3zC7CGLdJzif/aBl84bMY0?=
 =?us-ascii?Q?EPGOp5F2iyd+QKZfEw0PoOqDWeCD7GgdmqWU43mwepiN++xKteDk+F7RdM7N?=
 =?us-ascii?Q?VIk39KO2XRsomWCtRgAZjguEss/1I/JtovavqJ3XCWuyzEJLCWYQUEPGLPYH?=
 =?us-ascii?Q?+aktwLYUxNyMB9mqhgiOjMBXxIeoTGELKlzyxH7YJg/Em5JmCR2oFTwEMdlQ?=
 =?us-ascii?Q?TeMGsjDsvTzidqVN/9JJ4XCpBcrcSzLM62NTOBNL+BGU+yJT2AgrPxQMvwf0?=
 =?us-ascii?Q?eQYWBFkxu42AOAdJ7Zc11LbxW5MTIEHgTQ1FudUzr3SMnKtEPKia4F/ZLar5?=
 =?us-ascii?Q?TcmHCWQIVJifYNVfbMFRVONMT72wBzgxpJM/199F38OGmmMAhwO+iYD8WMGx?=
 =?us-ascii?Q?o9yHmLVdJ8Qq3WxDNm9eU7bN2ckiAchtQG/FsDtu1EfayuwWlu7zQthaglJG?=
 =?us-ascii?Q?tl7tofe+F5XlBPPjdzIGH/uKb6ZwXcJFuA/1jZD4OVJDAamaaeGOorX7TheS?=
 =?us-ascii?Q?DCGkSoSnkOBl4y8npd+KXziqV9TlDYlC1IzRZ61XuaKasuigpjXMu4fLNwJx?=
 =?us-ascii?Q?d042ppPq40K/CUfZyoDd4odBNJ/yS3T8hOs5rjctNfX60nuKY4M8ve8DJNaj?=
 =?us-ascii?Q?Mkxt2dgWU0YhDZsT9hkk7TVjoCEp1AA1kz55O/9SwzOos3K36gcr6QqCXpkC?=
 =?us-ascii?Q?v58zu2ZMlkLfF1K/C+0Vv99A7ULZSL2liv6bdpSiqqIEL+pULibk5HHp/fLs?=
 =?us-ascii?Q?1P+jBe84kn1AlHTEtqiEgUTskJZRmc+JDPiqBjdVLIEqDnu7NJewWfE4Ml6w?=
 =?us-ascii?Q?J2UoaCCvwBDjFEsqF8i8N9XjidDgC5U4zFOcsWSxv3lLL9UMgFxuo/UlIoMq?=
 =?us-ascii?Q?WyyFGQn0QTMK+iubu215/1Yeb8Drpz5UEpnsNdi2vQv/Y+ExBsje2T+Qnj/7?=
 =?us-ascii?Q?AojAa4CdrHyFHgHazbQso65qAIf0Fg1lb78IZI4zH6Z59whbQ3D6NlmPVJEG?=
 =?us-ascii?Q?YbiK2XL7Q21k9mJ2FulOlUqOVvo81PjoH+Dx6QQljNcXvVaKtwbXm4WkyE49?=
 =?us-ascii?Q?b71aYWhfPy8zoBqgcf9Lkgy3nd8j5sRwDvyL8Rh9PNkpt7FN6DwaQhAF8BCu?=
 =?us-ascii?Q?pro/euDgcxXOzQGwC5IWW/KIrMa2vtYPDzmPEBv17E7xAG2MWoAnpXPSuZdh?=
 =?us-ascii?Q?QuoOfjhvpnELrbKwaroDrlPSeydGmiDLG/HKgKhUdKZ9iDysjvL41VMHGA9Q?=
 =?us-ascii?Q?E8nUxb9Z5iZQmYxtGohqwVMzWtobm9hY09TEsWUPVa9GKsbgI5ZpnJxBLJT7?=
 =?us-ascii?Q?X5uF/0tP/JLhGWiJ028APDWYiv+jEdZIWk3i9rQ6PQUTxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VG/YEDbGb2FGvH6Q/LQhWvReMEX1f7eAhooWeP5nHRYN6qx1y/TcofhRHM8W?=
 =?us-ascii?Q?EUepuwB5Y5AWr1NqkJbo7cfFIcOfFLc9TYoQkI4c0ab7bgV4couPmRpw1Jlj?=
 =?us-ascii?Q?iWSk1AThtQNbRVF3GLSaFwBIahOoqSg8f71bQiR51lkKiBDVsUAUZk63bBPp?=
 =?us-ascii?Q?fomcaS4eKd1i0HsWj1OCvThib+ll87P1r74ou2Pt31gw6QhtzcHi6sDpJdLK?=
 =?us-ascii?Q?cJCXEDS4Q3lFyqeqjR7kkkE9Aiq+7jyiO5FIGgeguRpY7MlqxzaPZ0GSsPDS?=
 =?us-ascii?Q?Df76F2vkstCaAVtTHJHQhOf33tNWlu5nFh7rIQfBJUYy1AP5OtcxReZFHloL?=
 =?us-ascii?Q?FGHKDFUkb3rLp4/chUruccISs2QHkf2AmG4Z8E4tVhhLuX4I/82lYHbA6Vx4?=
 =?us-ascii?Q?08Kg3TGToDA1tcQIeCOYamqnlwMjPITHV9olkk//tkgc/QlgJeRsxJJB7M6G?=
 =?us-ascii?Q?6Gkwk/9qZ5u3uKRXPMeWPjhvl++PBetWFmffN527hxslA2+azFWSCyU04S4b?=
 =?us-ascii?Q?87aHF6TnqYq/QrH2JoZbYcMVAwwJIHFbkgRvyx360ogAfLvaw+NChB/OyCdW?=
 =?us-ascii?Q?TkKXEJ8hHmec1Itx8wEtpZIgmgcwcFGuAxKBohXH+FxlK4SZW98IJzI89pnS?=
 =?us-ascii?Q?bfXGim/T//8SyLQNS3kqcZbmXLFp7NTzqU3DbllXsrU6ilJvCJXGAPPYOGmh?=
 =?us-ascii?Q?qiODPojG0PrW5+yIFkau8WYIIragZNv6GdfWE8m/HSAVex5jYTCsncvd7VGs?=
 =?us-ascii?Q?DS5z/ZJd12k5LYxe+EpDDoFn5TnMnT9udi4Kyp5brC366d37LIyA94DZMbWx?=
 =?us-ascii?Q?EVrqLsu6XRRByGLmr/rnFYkaWHDA0gTra6W48R/j5A3jn832pXTJfx2iMlZ0?=
 =?us-ascii?Q?ZHiixouVRrVZAE6LbPVENsmQRCnCo5rMKmtzEqFdcRA7x06eEmBTv393lsBO?=
 =?us-ascii?Q?SlY1v7SYHkruyGPwA8vcEEF2BD4LatN3GzMcOv1x/cLmGcLQKZQGsgwNK/Yj?=
 =?us-ascii?Q?RRenFtJDXZAMBeToaLnjPNpyVk2TjRytoXLxKRkH1cQY8lFjhie/S5iLJk79?=
 =?us-ascii?Q?/zQgnRT897N4eS6aZhL+cJ1LR+lmPespFp5PIWRgL+YwUw/1w10nKvRQX35E?=
 =?us-ascii?Q?cHemNyUtPMBQjVqlBX4xUFxOi5wTIMjccwOqwpK7On+5J2KX93w04TfVXvmG?=
 =?us-ascii?Q?VxH2mY6UVXJ9qkPu0I9DWUbpwyBER0+46vVzLuXur62QMv50Ook55g5hiv6A?=
 =?us-ascii?Q?SAL5BY47mAKv90fLk00+ni0wFT1xcwgPeDelo5bzieXG2LPgkvtpnmTX9SLD?=
 =?us-ascii?Q?mCLaOIDzcycsGtLDnrY39OwG2Nu1PkfpjIVpClQZM3fGBVxhzguDKOlsxBts?=
 =?us-ascii?Q?9EW8jo+dw9JQfuE0W6Xle34HemTI8XA3tcUU8HSujQZiV4q+KFJ3I9H0n7rV?=
 =?us-ascii?Q?hMywfU8gVbj+2CfTy4sGSXNdjlBop1wnt4T9vXi4o0hcrB8sNTCviP0A8Dv1?=
 =?us-ascii?Q?AF/bwpFYaFuN1tZJwUY/YbWN0kRui8iAcI//alb44Hv1S9TKLwFNTXqnkmN7?=
 =?us-ascii?Q?RcuMLV/4FRGkyGWQAMqILHeyRKHX36THVXGJeJfjTqlhGbI7XpVv7Ik7rw/r?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HbNdBk8g4bOt3/I9L6pGlbnDxbKpWwm04vwFxNhyxkR3XrIGDK+PCK1QjAYkbKrDR8LtkNe9K37TBgR0EFndRuKOSdHbl6hTdFsKMlvUZ7D6CPNIbo3L/MaPZbRC4ihfTDmv6QUXM9PO1rXjJRwHmq6GBH3FgU2Faj50lq4avvWxqliv1aB4FjC9HbkVKw9M3ZzxYKfbP85Yeu7zKGpTDTA3Wmqrh53W5hkt3z9hvqyYRwBYdO9APeYToaHmdC5FZ9Bukk1GiVI+2dBHkBD54goxSc+jPs/vps45zeNH6dVtb6iR6u+2RpFtlBeY26I8sS85tsEt8ApdWnO4bP9oOy4VxiCkCQwSwHA+pjYgxyEuZsacY3anDYLHcU6w6LBSzaK1PZTLE13uUmIjfVPFObBUTiybrVvkUzs5SwL8Iqg91NbNKvlhbzN8fDVarzBDl3qHBa+D6ohU5/E3Zos1CEa0Uwsw8PXd7bouALSTNXsoOWGKMVrIjE34MfS6CBvPNlNB0/AnxQ1lNa6ouPLCatcN5yHIgtdz0qIMVnZeN2C4tEb0McetKlYfMPriLeSljCMskEi7IyznHXKk3xTJEztGjyge7bTe57kfM2w1n0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeb0060-96b2-4db6-183c-08dccc2575bd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 14:34:04.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7MgDEhrp1R9yoWuuYpltN4ia2lIWDIJjW7wJZnoEAE1C+TEhhZJRbhqSWgQu5mhJsWGr0MWfc4yf2utfjPglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_02,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030118
X-Proofpoint-GUID: Lk6kmFP-2UFIBeC96WW5LW6FNIWfNDiF
X-Proofpoint-ORIG-GUID: Lk6kmFP-2UFIBeC96WW5LW6FNIWfNDiF

On Sat, Aug 31, 2024 at 06:37:36PM -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
> 
> Add server support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when both the client and server are
> running on the same host.
> 
> If nfsd_open_local_fh() fails then the NFS client will both retry and
> fallback to normal network-based read, write and commit operations if
> localio is no longer supported.
> 
> Care is taken to ensure the same NFS security mechanisms are used
> (authentication, etc) regardless of whether localio or regular NFS
> access is used.  The auth_domain established as part of the traditional
> NFS client access to the NFS server is also used for localio.  Store
> auth_domain for localio in nfsd_uuid_t and transfer it to the client
> if it is local to the server.
> 
> Relative to containers, localio gives the client access to the network
> namespace the server has.  This is required to allow the client to
> access the server's per-namespace nfsd_net struct.
> 
> This commit also introduces the use of NFSD's percpu_ref to interlock
> nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> not destroyed while in use by nfsd_open_local_fh and other LOCALIO
> client code.
> 
> CONFIG_NFS_LOCALIO enables NFS server support for LOCALIO.
> 
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Co-developed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/Makefile           |   1 +
>  fs/nfsd/filecache.c        |   2 +-
>  fs/nfsd/localio.c          | 112 +++++++++++++++++++++++++++++++++++++
>  fs/nfsd/netns.h            |   4 ++
>  fs/nfsd/nfsctl.c           |  25 ++++++++-
>  fs/nfsd/trace.h            |   3 +-
>  fs/nfsd/vfs.h              |   2 +
>  include/linux/nfslocalio.h |   8 +++
>  8 files changed, 154 insertions(+), 3 deletions(-)
>  create mode 100644 fs/nfsd/localio.c
> 
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..18cbd3fa7691 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> +nfsd-$(CONFIG_NFS_LOCALIO) += localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 89ff380ec31e..348c1b97092e 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -52,7 +52,7 @@
>  #define NFSD_FILE_CACHE_UP		     (0)
>  
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
>  
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..75df709c6903
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + * Copyright (C) 2024 NeilBrown <neilb@suse.de>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/nfs_common.h>
> +#include <linux/nfslocalio.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +static const struct nfsd_localio_operations nfsd_localio_ops = {
> +	.nfsd_open_local_fh = nfsd_open_local_fh,
> +	.nfsd_file_put_local = nfsd_file_put_local,
> +	.nfsd_file_file = nfsd_file_file,
> +};
> +
> +void nfsd_localio_ops_init(void)
> +{
> +	memcpy(&nfs_to, &nfsd_localio_ops, sizeof(nfsd_localio_ops));
> +}

Same comment as Neil: this should surface a pointer to the
localio_ops struct. Copying the whole set of function pointers is
generally unnecessary.


> +
> +/**
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
> + *
> + * @uuid: nfs_uuid_t which provides the 'struct net' to get the proper nfsd_net
> + *        and the 'struct auth_domain' required for LOCALIO access
> + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
> + * @cred: cred that the client established
> + * @nfs_fh: filehandle to lookup
> + * @fmode: fmode_t to use for open
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it can
> + * avoid all the NFS overhead with reads, writes and commits.
> + *
> + * On successful return, returned nfsd_file will have its nf_net member
> + * set. Caller (NFS client) is responsible for calling nfsd_serv_put and
> + * nfsd_file_put (via nfs_to.nfsd_file_put_local).
> + */
> +struct nfsd_file *
> +nfsd_open_local_fh(nfs_uuid_t *uuid,
> +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> +		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> +	__must_hold(rcu)
> +{
> +	int mayflags = NFSD_MAY_LOCALIO;
> +	struct nfsd_net *nn = NULL;
> +	struct net *net;
> +	struct svc_cred rq_cred;
> +	struct svc_fh fh;
> +	struct nfsd_file *localio;
> +	__be32 beres;
> +
> +	if (nfs_fh->size > NFS4_FHSIZE)
> +		return ERR_PTR(-EINVAL);
> +
> +	/*
> +	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
> +	 * But the server may already be shutting down, if so disallow new localio.
> +	 * uuid->net is NOT a counted reference, but caller's rcu_read_lock() ensures
> +	 * that if uuid->net is not NULL, then calling nfsd_serv_try_get() is safe
> +	 * and if it succeeds we will have an implied reference to the net.
> +	 */
> +	net = rcu_dereference(uuid->net);
> +	if (net)
> +		nn = net_generic(net, nfsd_net_id);
> +	if (unlikely(!nn || !nfsd_serv_try_get(nn)))
> +		return ERR_PTR(-ENXIO);
> +
> +	/* Drop the rcu lock for nfsd_file_acquire_local() */
> +	rcu_read_unlock();

I'm struggling with the locking logistics. Caller takes the RCU read
lock, this function drops the lock, then takes it again. So:

 - A caller might rely on the lock being held continuously, but
 - The API contract documented above doesn't indicate that this
   function drops that lock
 - The __must_hold(rcu) annotation doesn't indicate that this
   function drops that lock, IIUC

Dropping and retaking the lock in here is an anti-pattern that
should be avoided. I suggest we are better off in the long run if
the caller does not need to take the RCU read lock, but instead,
nfsd_open_local_fh takes it right here just for the rcu_dereference.

OTOH, Why drop the lock before calling nfsd_file_acquire_local()?
The RCU read lock can safely be taken more than once in succession.

Let's rethink the locking strategy.


> +
> +	/* nfs_fh -> svc_fh */
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size = nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |= NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |= NFSD_MAY_WRITE;
> +
> +	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> +
> +	beres = nfsd_file_acquire_local(uuid->net, &rq_cred, uuid->dom,
> +					&fh, mayflags, &localio);
> +	if (beres) {
> +		localio = ERR_PTR(nfs_stat_to_errno(be32_to_cpu(beres)));
> +		nfsd_serv_put(nn);
> +	}
> +
> +	fh_put(&fh);
> +	if (rq_cred.cr_group_info)
> +		put_group_info(rq_cred.cr_group_info);
> +
> +	rcu_read_lock();
> +	return localio;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index e2d953f21dde..0fd31188a951 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -216,6 +216,10 @@ struct nfsd_net {
>  	/* last time an admin-revoke happened for NFSv4.0 */
>  	time64_t		nfs40_last_revoke;
>  
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	/* Local clients to be invalidated when net is shut down */
> +	struct list_head	local_clients;
> +#endif
>  };
>  
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 64c1b4d649bc..3adbc05ebaac 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -18,6 +18,7 @@
>  #include <linux/sunrpc/svc.h>
>  #include <linux/module.h>
>  #include <linux/fsnotify.h>
> +#include <linux/nfslocalio.h>
>  
>  #include "idmap.h"
>  #include "nfsd.h"
> @@ -2257,7 +2258,9 @@ static __net_init int nfsd_net_init(struct net *net)
>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
>  	seqlock_init(&nn->writeverf_lock);
>  	nfsd_proc_stat_init(net);
> -
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	INIT_LIST_HEAD(&nn->local_clients);
> +#endif
>  	return 0;
>  
>  out_repcache_error:
> @@ -2268,6 +2271,22 @@ static __net_init int nfsd_net_init(struct net *net)
>  	return retval;
>  }
>  
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +/**
> + * nfsd_net_pre_exit - Disconnect localio clients from net namespace
> + * @net: a network namespace that is about to be destroyed
> + *
> + * This invalidated ->net pointers held by localio clients
> + * while they can still safely access nn->counter.
> + */
> +static __net_exit void nfsd_net_pre_exit(struct net *net)
> +{
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +
> +	nfs_uuid_invalidate_clients(&nn->local_clients);
> +}
> +#endif
> +
>  /**
>   * nfsd_net_exit - Release the nfsd_net portion of a net namespace
>   * @net: a network namespace that is about to be destroyed
> @@ -2285,6 +2304,9 @@ static __net_exit void nfsd_net_exit(struct net *net)
>  
>  static struct pernet_operations nfsd_net_ops = {
>  	.init = nfsd_net_init,
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	.pre_exit = nfsd_net_pre_exit,
> +#endif
>  	.exit = nfsd_net_exit,
>  	.id   = &nfsd_net_id,
>  	.size = sizeof(struct nfsd_net),
> @@ -2322,6 +2344,7 @@ static int __init init_nfsd(void)
>  	retval = genl_register_family(&nfsd_nl_family);
>  	if (retval)
>  		goto out_free_all;
> +	nfsd_localio_ops_init();
>  
>  	return 0;
>  out_free_all:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d22027e23761..82bcefcd1f21 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
>  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
>  
>  TRACE_EVENT(nfsd_compound,
>  	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 01947561d375..3ff146522556 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -33,6 +33,8 @@
>  
>  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
>  
> +#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
> +
>  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
>  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
>  
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 62419c4bc8f1..61f2c781dd50 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -6,6 +6,8 @@
>  #ifndef __LINUX_NFSLOCALIO_H
>  #define __LINUX_NFSLOCALIO_H
>  
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/uuid.h>
> @@ -63,4 +65,10 @@ struct nfsd_localio_operations {
>  extern void nfsd_localio_ops_init(void);
>  extern struct nfsd_localio_operations nfs_to;
>  
> +#else   /* CONFIG_NFS_LOCALIO */
> +static inline void nfsd_localio_ops_init(void)
> +{
> +}
> +#endif  /* CONFIG_NFS_LOCALIO */
> +
>  #endif  /* __LINUX_NFSLOCALIO_H */
> -- 
> 2.44.0
> 

-- 
Chuck Lever

