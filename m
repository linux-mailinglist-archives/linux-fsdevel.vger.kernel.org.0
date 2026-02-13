Return-Path: <linux-fsdevel+bounces-77068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBfpOEN1jmknCgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 01:50:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891113227D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 01:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9D23059F33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357101CEAA3;
	Fri, 13 Feb 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eVWd66GT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5D38D;
	Fri, 13 Feb 2026 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770943805; cv=fail; b=uSYAEjFZAhYuWdJlaoaWbrb6QkqXW/rm4z67cVStuip+4qzSSyZpNeVGpT+QokhbTR8A18JsnvU2k5Ovajn1eEvoyQc/5KUINRIeGAz3mZTYl30LdVuo7lG2ANCG1sglfzO9UVRc60cJKS3HH2GSOynpMvk5ouWkAZhOeOb1CRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770943805; c=relaxed/simple;
	bh=dSko5vPTGLPz5TEc2CuiHFQz2v2xTV4dIlc8z6IbICU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=RSnFM7Q9PqjllSltCGmBMw4ClztXTLdmJsNsFAifhQXRyOauh7liBwBrg7KDA7n7v/rj5MWpWYnO5rks7+yL+PA/latnRPfxvsZCKJ1KkEPiw57L3aQsjUB5MYUTdP6hq3hNc1f6zTzv5eYrAlP/p5EGWQC8YIBUe+aO+yoZnto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eVWd66GT; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CGVvJO3433326;
	Fri, 13 Feb 2026 00:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=dSko5vPTGLPz5TEc2CuiHFQz2v2xTV4dIlc8z6IbICU=; b=eVWd66GT
	1W9DMoHYZJhnE83JHszZOHHXUvtcEZsi8XYZIJG5SUClp8VeHXqgkSuKwXNyovQ5
	+PdDheHNILIMGjGjRe2IVBDE+y/qSlkEafJHiUl4h6DALf1mHISonRL84lWi0ntu
	AyjzEIRrcrQMQz84Yddmi3D6RdUNnA3RBvfJcbnGbcXh780hI7IUqx7vsq2Xp9Ol
	WTAnnaHhQU/bIQRxa19ZP3tjAG9IjG/ZWWCcsPjN2LdEQhbrrUS96O0buKt3QN+5
	5mkYdLCXtI7BbBablkF56WsgHgWM6IP0KplQPFzHQ6pk3cbk41mJFEg8lkwQ08mS
	04dPjp7IBC2wbg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vdvx6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 00:49:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5Rx78I7wZVoYBjdn4qDSrtth03F0qLs/+na9x1pnJh2T0cugwnZwBGV4LVSBn2zwzI98UAct7YHgnTo8AVZKDMEx4kArvSx9jalgiyK5WOLCvtnSmlKFncDZ2xcpcvA9EZZe+FfiPWuDLkhjGPdPYhfNLZ/DFrTS1EVSXWAU6icctvq7qxT9sJTBxnQ/jyb+ejK95x6baIEHVe+qvasVmMzZudyoewULd7N21jCEHAok4RB/Dv5V4KBYRLabx5FcSoy9y8v600cwb9mS0L6Z9I5fCfySDd6phFQFPNFQ0ZxCIxlYOQXTcYZTacfE1asTRm12P9IzeUzAYjdZzzp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSko5vPTGLPz5TEc2CuiHFQz2v2xTV4dIlc8z6IbICU=;
 b=vuCXwfC/X2Upy1NE+87Cot55t2fym2O49k6kNwhonP0+iJjbv2xwtBsDK/ivFhEzHFlAWf4eG8W3gt1y8xLRT7LrYDIKiiwxSgqiCRKsTotLpL5YOCK6U6kIzPDOPrr5kWMa72if2e1rnF3Ytkja3WS05hHmMn4VNu1rDhhvgqp1+Rv3BBVF5ZpqOzJHs6vQY0LjliPQYw/wJbowlCUkRQW9zBu2OwWNOyTcq559Xbc8scwpKsDJfZw60FhmGtLB1MQj/wBDVSW0cTVvii7IlFKaSo/o2aTUOaL3DIl/a4PfE0VVcbcNG7Bxs1keLI8PoPbcokaE3bCtYvG/W2ZfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB5707.namprd15.prod.outlook.com (2603:10b6:806:34f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Fri, 13 Feb
 2026 00:49:50 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Fri, 13 Feb 2026
 00:49:50 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v3] hfsplus: fix uninit-value by validating
 catalog record size
Thread-Index: AQHcm7y0dfW39E0SQEWi+5mSKA4eGLV/zdaA
Date: Fri, 13 Feb 2026 00:49:49 +0000
Message-ID: <15388498a6b3abdb489401dcd8731333c8679a02.camel@ibm.com>
References: <20260212011227.65197-1-kartikey406@gmail.com>
In-Reply-To: <20260212011227.65197-1-kartikey406@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB5707:EE_
x-ms-office365-filtering-correlation-id: 07ed8d88-4e44-4a7f-9f79-08de6a99caf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWR2ZlM0UkVNT0lTNEZiM1l6cFpyYVJQMU5rZCs4OTJxVnpzUmVFQjhmSWlL?=
 =?utf-8?B?bzVpc1dEL0oyYmdVOHNMeXV1NlJTRHlKNGZOSkxHbWxjeFNwT1lqbFRNeERs?=
 =?utf-8?B?c0J1MmpsNFgrT05Td0lUZjJJTVdTMGwwVHdpMjJKMEQxUExvMW5KK2FrUnFQ?=
 =?utf-8?B?RXVyMnZkNDVsZTN2L2llWXNmbHhkM1dTbDBpY2Ivakh3WGF1ajZzb0NUTjkz?=
 =?utf-8?B?eEk4ZEFFWXpUZzlPcW5aR254b2FvU3VQRENPdGQ3UmFRTm1BN2picWFHM3I2?=
 =?utf-8?B?TWFTekladXAyT0tkNWFobkJTZitZV0M2NGNVS1AvNUQ0ODNyTWNsdTd0QnJT?=
 =?utf-8?B?aU01S0ppckM3OHMwbXhYSWRlSjdLTkt1NE9kTSt1Q3BPN3RsamJJQzduSlB2?=
 =?utf-8?B?eXA3UEZuUGViaENpWGsydklRbWFETnpBYjRZanBNMk9tVnVudTdsUDdoKzNF?=
 =?utf-8?B?cDZnVHk2Rk9PQVVOQ3ZLdDJURGEvR25aclR3WjZ3UmRHTmtabXljczdYMG5O?=
 =?utf-8?B?TkdLTFQ5RWhoRG1tZnIwOGFKRGRJU09mY0lLaFgzZC9hMlZwbWcvenhuSFZK?=
 =?utf-8?B?Z1pSSE13dUhlYkRyNjBIaWwvbFJ3ZU9vbGkzVUljdE1wQXJSbFZrdnVIZVhB?=
 =?utf-8?B?azd2K0JIc1o0bXEvdmhVTUxjQnJZeFd2aTZHajcydW9TakxLUWhxQjZIa3ZO?=
 =?utf-8?B?eG50ZTBXdWozSzJ3Q1hSdzdOam0zbEhVRUhiTEovSUFTTU9CamxDUldoRk1w?=
 =?utf-8?B?NHlSOVNMZWxWS0p1RzNUQ29CYncwR2piRGRBMFhXZnNYNHJSOTJWWnFLQ3RN?=
 =?utf-8?B?d0xWdGl4RTJKYzErUUlwOEtZdVFTUzhqZVhlWlFFRWdGZmxBb2hiQmtSNjFl?=
 =?utf-8?B?V2lCTGRGQTYyR3ZFVlVrVGt4bEFBZW85ZlhlSk9vdThGeGErTG1hK2ZDYTdF?=
 =?utf-8?B?ZXA3bDVpSEdNampBellmUXJRVjVwOTc2akZBVHBVTE9QcnR1aWdBSXcwT2ls?=
 =?utf-8?B?VHY1TnBwKzZxeitPRk9EemFxck5EWWdkaWxMbnpaY2RTWFhnc0QwQWFWSjAx?=
 =?utf-8?B?cXhuSGQxSjdEbndPN2JvVFczTEZWQkRYSlRuTnQvam1laXBtN0gyY0JrQmF3?=
 =?utf-8?B?OTUzUnFCb3EvV0VMVVJGUE5mb0VUSEhwSEVWSVEvVDZWM09DbkRVZGppMjZK?=
 =?utf-8?B?bFNNUGliNTRuL0wvWkF5TVpaeVZ4Z1hITkhoenY4NEpLRXdiR2I2b00vdDVC?=
 =?utf-8?B?akpOSzB2NzFZSVRVaHJ4VXlOOEFFMEVSaGVrcnpjWGdiMmRwdHpaMlFtTDA1?=
 =?utf-8?B?TDZmQXY0MXl1L3RTVnIvcXR6REw5bE5GSlptM09CTWVJZXpPTWpJdjU3ekxU?=
 =?utf-8?B?dUwrWm9GT2pFdkdSQ3B4QXgvZm1ITklOU00zVmJvZmR4eVY1QzQzZktGTldI?=
 =?utf-8?B?cmRTZmFVbzB0QzZ3Nm1RdEdKK2hEekp0RjllSGJTZUV6Z1NLRGRpbkZtU250?=
 =?utf-8?B?YnZpU0lTeWd2ekRrMnluVVZCNkhHZ01GVEZqUHN5OXhrY2tEUk1CUkQ3Wmg5?=
 =?utf-8?B?d0ZvSStHcERaZUJlY2VpMWRUcitnSlpUdTMrZDFvVm5kY0o2WnhpTnAvNTlH?=
 =?utf-8?B?ZG1hOUJTV25leFVkUXhTOFQ4QTBPYURqTGtXdmJIaEVIalZzd1dEMlJHT2pm?=
 =?utf-8?B?SjFYZUdpVS9IZHBCQnRVa1Y5V2lxTy82UXZVTkxJclJYNTYvTDRNSWZSekR4?=
 =?utf-8?B?QlF5MUlISlFSZDVjaUJ1eVRCT1RhclMyN0UvYmluUGVuVWZkMGR2NFFmZ0dD?=
 =?utf-8?B?Ylo4ajhEMkpaYS9NU0p6YTM5Y2VxRGQvcTF1OFlhd2FkYXFIL0srWmN4emcx?=
 =?utf-8?B?bHBWa1UvVXdqcld2V3ZNMGJ3SHB6NnUwRWR6Nld5ajZqa1lERzcyLzBsdkR0?=
 =?utf-8?B?bUNoZkRvWVFFUTNoRHNkSklYSHlFSEZzQ3A1eWRKY1ZyVmxaSVZNL1hoNkY4?=
 =?utf-8?B?WjdKSU9yK1VqN2ZhVVZyTzl4cVUyNFpwMDVuV3BPSnN3S0FKZmFKNm56Y1Fp?=
 =?utf-8?B?Q1RtZE9tZFBFc0FYSEhmZDA5aG4yRkJPQnNFeWdicy9Dc3IyekpGZjY3ei9s?=
 =?utf-8?B?YUExQzE5WStITTFYQlhMZFFKakVLU0dzWk9oOXUwSVJ6YnFvMkRhVkZESXhO?=
 =?utf-8?Q?JZ6aX8VBZ1txYTyYtE8cWYQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3o1QUduWm0xOWdCczFDSjV4czVUMWRGQ3oxR0ZqMS8xNFYvNm16cWFuR3Av?=
 =?utf-8?B?SnVVRXJpQ1hBOExjSTFRbzdEMUZJdVZYUjZSelpLMk1xQUN6YStZRkRhQkdu?=
 =?utf-8?B?a1NrblpFand1cGRNRHdETnVYbHUweGRVT3Y0Uk1lUlZ5aVJVZ0szbUVqWXc3?=
 =?utf-8?B?UWtaVEt0eVNrVVNDeWxhMk5KSEdUempYRjZmMkdkaG9iQzJ0c0xDU0VDdzZW?=
 =?utf-8?B?TjdjRldpWXVHSGZ3Uy9weFU0d2hvTFVrTFFnWXFlZXBKUCtRWFIrT05XRDQ1?=
 =?utf-8?B?eC9wcDEvaTh0TVQrc3d0Zm9Gdm5SNGJQc2JMR1lYaEF4VVBCZVU2Q294K21Y?=
 =?utf-8?B?bTVzZ29uNnpLbmRtRzZjY1RpY3BGSUhzYjFYOEROMHRvVXhyUlBqeVgwMkJ3?=
 =?utf-8?B?YXBqS0l6UVNZNWNRTE5pUC9VM2hmUVlQUUc5REtjT010ZUVEY284NmtOczZJ?=
 =?utf-8?B?ZG1xbXFjTm83czhsSForMEhkQ3V2cXNtZG1QbGM1eE1TODdWaTJBc0I1RndD?=
 =?utf-8?B?QWFpeG5xeU9pWWNTWEZTMmpnYy9BRHUzMm5MSk1VVExNQVJ4TTFIcWJscm03?=
 =?utf-8?B?bXdVd1ZkaVNCdENySzFKa2hNbGFpQ0Vma2J4OUZrR25NWkR6NDdFSG1jMFdw?=
 =?utf-8?B?dDB3enR0WGxIbGoyQmZPeGlWaDMwYWJJWE41VnZvVzF3RGJBbXRrYmxxRFVP?=
 =?utf-8?B?N096Sm9mY3ZuQ3plY094VEMvOG9EQXpxSURBOEwveDB2bWp2RWFXRmFkQUpY?=
 =?utf-8?B?YXlBNkp4WG5wMW1UNHcvMnQxeUVIWWZqRHpveUtCS2FxN3BCaGlVL1IwTkRU?=
 =?utf-8?B?VWl0WkNEcWFGVURyS1liMnpteXJ0Ym5YbHpScTY0TGVtSXNUN3MvY3ZmU29L?=
 =?utf-8?B?QncvWHYrUUgrazQ2UitucjB2OUMrZzR3SWUySVQrMFQ4T1NRWU0wdzVFbG0w?=
 =?utf-8?B?cHFEdnJjV0lLVWVKbC9FRitMZkRaN1ZxSzd4MzBDMTl6UXZrZDVnalp4em5X?=
 =?utf-8?B?aGRSbzM4ZDJmci9PMzNRZEhyQm8xOGZmL3NoNjg2T1VlMGJPTlQ5K3ZST2xM?=
 =?utf-8?B?V01CcWJSbFViZHBiZUZjNnVtd3JiYlN0emphM09lTGZxUHFpZlZTNnhKYWFq?=
 =?utf-8?B?NVZUSmFMRWtxUjl6TklqZG42Rlh6UlpaTGgzU0I2WTNVMVFBT1hRVGN4STB3?=
 =?utf-8?B?d0JvYUZaR2ZDT2FBV0RMRjNUR3dPSGE2Sit0eURjRzg4bisxWEs5Q2ZqOXY2?=
 =?utf-8?B?Vi9nY1BaYXNHVzBHTjZRR1lQUVFOV0wxMjFKU2lHQjZhV2JUWlRMNDc1aDd3?=
 =?utf-8?B?Y3lXTjExVm9aT0w4dEVtVGJTSVNDYy9lWGc1VmZnSjQrQUQ2a1JXUVZ0T2Zx?=
 =?utf-8?B?ZlJ3ZEFvL3pLaHliM1lydzZlajZtb2RlNzh4RkRMTTg5YXYyM1hxdXhnMEEr?=
 =?utf-8?B?eE5pZEV1OWxzSWltMit3aVBqMzRmNlNxUWZlU2hSUXVLL3VxUG91QkR2djlq?=
 =?utf-8?B?YUdmUDlPVjQxc1lhbnJMaGpwcUZGbG13YkNiOHdJRTgyWHoraW50bzhZNVdx?=
 =?utf-8?B?K2FIWmZGVlRBcUMrK1ZqT1pxQTkwR0tIMnh2ZUsyM1lweWNQT2tScEdibDAw?=
 =?utf-8?B?UjBFaHpZaUlJWXpWTEJCSjNsV1NRTXlpdmhkVWVSbzkxVUgwT1lBRklGNjlP?=
 =?utf-8?B?VFdPZzRvVXA0MWVhSWg1MlYzNjBPa1IwejB0VW0xdEZIb1dxdlArUWpUdytz?=
 =?utf-8?B?YlFKYy8vUkhDb0lPZDFTT2V6dVE0eGlFSmQ4dlVmZWM0U24vQnBwdm1FakNz?=
 =?utf-8?B?bzB3clE0OFpiQm03a1hkMHBKMzBPSTYwWGN3MHdYTnVJazVHSVFXRVFlYTJx?=
 =?utf-8?B?b3NTVXFKc0d2Q2hYdzJqYytqREdhb09ST3A4K1ZCS1hSSDU3djFYOG9qcVBT?=
 =?utf-8?B?MHNlY0dTS2ZEb29PTDhhRUdkSEJEekx5Ui9tSHErdjUvTWd1V3Z5YmZUeHNz?=
 =?utf-8?B?Vlp3emdrNUJrVDNHeUpNMTdFektRK3Qzc3N6VXFMU1p1dnFnSnFHaGFpekY1?=
 =?utf-8?B?a3MrTUFRVndwa1pGS2tEdWRlRkQ0U20zdGFSYXdHMHJZZTNVbVFSZGZUNTV3?=
 =?utf-8?B?NkpnTGlUdWZNanZZVUNGbkduNEhPSHBESnA0aDlSdDdMQUpCRXhuRVdJM0hP?=
 =?utf-8?B?NnBTZExpVWdNLzlwdk5RN084clNIVHR2Rm5lMWtWb0lXUXVFd1orZjh2NHdq?=
 =?utf-8?B?bk1LY1ZuUTRkalVUcEcxTXoyRWV6L2pGVHVWc3htN0xuVVQ3Z3g1TEdtc3hV?=
 =?utf-8?B?QlloZE0vSFpUcmVnSXMxZkg3S3BRaHJ4Q2xHU3hTYWtoM1h5V0dBU1V1bldr?=
 =?utf-8?Q?auz0C475rr4z8j89ASLjXdwFduv/mMCpquv3m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D635C83B27E2047A8353DA50C4C491A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ed8d88-4e44-4a7f-9f79-08de6a99caf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 00:49:50.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trUE3yY3IpeYwYiW9rFiLkNn2hvyIHSBdRyV2sNOimY2Cc9Bl5nNvSVRVIc9i1xH2ovTi9by7DWSHI0ypVshzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5707
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wJlx1pjL9QSGD1SxEQ0OCKlko5NzH_m3
X-Proofpoint-ORIG-GUID: O7Ci6Kb7raowO2LwjczYZV5REDho038V
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698e7531 cx=c_pps
 a=oUdh5d0wO9iyjQqwpg+wBw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=hSkVLCK3AAAA:8 a=b_IiuD9Wi6I2DJurEOgA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAwMyBTYWx0ZWRfXzmTMofQ7ESvB
 BUNZsE8Qhnun9pDIKfV3oxW458MkjBfHW5X3Np5+GwEgGi58q5znZrxPSWt4Thf4wXBBGZEH1C1
 LlsXBL0NYXvi27kFyI94hkfeohWocdYX/oMCU5QbfFM2Ao+lyZZSUg6lMwEM5nvWWC4L72pjKML
 de1jrduWderVDqP5X9D7IpV3pOyVH5ZTrAD1Ciw9N+nq+L/5p9AsljUFUsoeT01JarM8R6SglAB
 I0djhTbpFnuA2bFjrFELD7nxZbrd4+cIFHR5YxK0LZ0l0464M7kKYVPape+SBf7g3wM1/msDlNf
 lWDuRZ4h6uRMVQEOFJHp3SUtCUjF2sQvyLEYVUvZ0Z/5uFcfywZusyp4FobtchpA5md+HZ7GfOh
 skHVzNyrPU3AgQUHKeyXHhHC0G52c6ZHrSHfjCQ6XTxJAWc3w0YvqLw9711gonx+wddPadX5/7I
 qR7jKspNCfSiChpA8Zw==
Subject: Re:  [PATCH v3] hfsplus: fix uninit-value by validating catalog
 record size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77068-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,dubeyko.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4891113227D
X-Rspamd-Action: no action

SGkgRGVlcGFuc2h1LA0KDQpMb29rcyBtdWNoIGJldHRlciBub3cuIEJ1dCBJIGhhdmUgb25lIHZl
cnkgbWlub3IgcmVtYXJrLiA6KQ0KDQpPbiBUaHUsIDIwMjYtMDItMTIgYXQgMDY6NDIgKzA1MzAs
IERlZXBhbnNodSBLYXJ0aWtleSB3cm90ZToNCj4gU3l6Ym90IHJlcG9ydGVkIGEgS01TQU4gdW5p
bml0LXZhbHVlIGlzc3VlIGluIGhmc3BsdXNfc3RyY2FzZWNtcCgpLiBUaGUNCj4gcm9vdCBjYXVz
ZSBpcyB0aGF0IGhmc19icmVjX3JlYWQoKSBkb2Vzbid0IHZhbGlkYXRlIHRoYXQgdGhlIG9uLWRp
c2sNCj4gcmVjb3JkIHNpemUgbWF0Y2hlcyB0aGUgZXhwZWN0ZWQgc2l6ZSBmb3IgdGhlIHJlY29y
ZCB0eXBlIGJlaW5nIHJlYWQuDQo+IA0KPiBXaGVuIG1vdW50aW5nIGEgY29ycnVwdGVkIGZpbGVz
eXN0ZW0sIGhmc19icmVjX3JlYWQoKSBtYXkgcmVhZCBsZXNzIGRhdGENCj4gdGhhbiBleHBlY3Rl
ZC4gRm9yIGV4YW1wbGUsIHdoZW4gcmVhZGluZyBhIGNhdGFsb2cgdGhyZWFkIHJlY29yZCwgdGhl
DQo+IGRlYnVnIG91dHB1dCBzaG93ZWQ6DQo+IA0KPiAgIEhGU1BMVVNfQlJFQ19SRUFEOiByZWNf
bGVuPTUyMCwgZmQtPmVudHJ5bGVuZ3RoPTI2DQo+ICAgSEZTUExVU19CUkVDX1JFQUQ6IFdBUk5J
TkcgLSBlbnRyeWxlbmd0aCAoMjYpIDwgcmVjX2xlbiAoNTIwKSAtIFBBUlRJQUwgUkVBRCENCj4g
DQo+IGhmc19icmVjX3JlYWQoKSBvbmx5IHZhbGlkYXRlcyB0aGF0IGVudHJ5bGVuZ3RoIGlzIG5v
dCBncmVhdGVyIHRoYW4gdGhlDQo+IGJ1ZmZlciBzaXplLCBidXQgZG9lc24ndCBjaGVjayBpZiBp
dCdzIGxlc3MgdGhhbiBleHBlY3RlZC4gSXQgc3VjY2Vzc2Z1bGx5DQo+IHJlYWRzIDI2IGJ5dGVz
IGludG8gYSA1MjAtYnl0ZSBzdHJ1Y3R1cmUgYW5kIHJldHVybnMgc3VjY2VzcywgbGVhdmluZyA0
OTQNCj4gYnl0ZXMgdW5pbml0aWFsaXplZC4NCj4gDQo+IFRoaXMgdW5pbml0aWFsaXplZCBkYXRh
IGluIHRtcC50aHJlYWQubm9kZU5hbWUgdGhlbiBnZXRzIGNvcGllZCBieQ0KPiBoZnNwbHVzX2Nh
dF9idWlsZF9rZXlfdW5pKCkgYW5kIHVzZWQgYnkgaGZzcGx1c19zdHJjYXNlY21wKCksIHRyaWdn
ZXJpbmcNCj4gdGhlIEtNU0FOIHdhcm5pbmcgd2hlbiB0aGUgdW5pbml0aWFsaXplZCBieXRlcyBh
cmUgdXNlZCBhcyBhcnJheSBpbmRpY2VzDQo+IGluIGNhc2VfZm9sZCgpLg0KPiANCj4gRml4IGJ5
IGludHJvZHVjaW5nIGhmc3BsdXNfYnJlY19yZWFkX2NhdCgpIHdyYXBwZXIgdGhhdDoNCj4gMS4g
Q2FsbHMgaGZzX2JyZWNfcmVhZCgpIHRvIHJlYWQgdGhlIGRhdGENCj4gMi4gVmFsaWRhdGVzIHRo
ZSByZWNvcmQgc2l6ZSBiYXNlZCBvbiB0aGUgdHlwZSBmaWVsZDoNCj4gICAgLSBGaXhlZCBzaXpl
IGZvciBmb2xkZXIgYW5kIGZpbGUgcmVjb3Jkcw0KPiAgICAtIFZhcmlhYmxlIHNpemUgZm9yIHRo
cmVhZCByZWNvcmRzIChkZXBlbmRzIG9uIHN0cmluZyBsZW5ndGgpDQo+IDMuIFJldHVybnMgLUVJ
TyBpZiBzaXplIGRvZXNuJ3QgbWF0Y2ggZXhwZWN0ZWQNCj4gDQo+IEFsc28gaW5pdGlhbGl6ZSB0
aGUgdG1wIHZhcmlhYmxlIGluIGhmc3BsdXNfZmluZF9jYXQoKSBhcyBkZWZlbnNpdmUNCj4gcHJv
Z3JhbW1pbmcgdG8gZW5zdXJlIG5vIHVuaW5pdGlhbGl6ZWQgZGF0YSBldmVuIGlmIHZhbGlkYXRp
b24gaXMNCj4gYnlwYXNzZWQuDQo+IA0KPiBSZXBvcnRlZC1ieTogc3l6Ym90K2Q4MGFiYjViODkw
ZDM5MjYxZTcyQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gQ2xvc2VzOiBodHRwczovL3Vy
bGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3N5emthbGxlci5hcHBz
cG90LmNvbV9idWctM0ZleHRpZC0zRGQ4MGFiYjViODkwZDM5MjYxZTcyJmQ9RHdJREFnJmM9QlNE
aWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtF
bHZVZ1NzMDAmbT1UOXRnMERLVk9kN2hyUHlOSk14OHA4WXUtRHdhZ0l1SU5zamhVYTM5OFU0TnZE
ci1leUNjMEgya3VsRnVuOVFWJnM9Vzd2c3dmWUpMZ3YzRHRzWWJoT25OS25VV2lzeGoxTFZOU3l0
MVdCVVMzVSZlPSANCj4gRml4ZXM6IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQ0K
PiBUZXN0ZWQtYnk6IHN5emJvdCtkODBhYmI1Yjg5MGQzOTI2MWU3MkBzeXprYWxsZXIuYXBwc3Bv
dG1haWwuY29tDQo+IExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91
cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2FsbF8yMDI2MDEyMDA1MTExNC4xMjgxMjg1
LTJEMS0yRGthcnRpa2V5NDA2LTQwZ21haWwuY29tX1RfJmQ9RHdJREFnJmM9QlNEaWNxQlFCRGpE
STlSa1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAm
bT1UOXRnMERLVk9kN2hyUHlOSk14OHA4WXUtRHdhZ0l1SU5zamhVYTM5OFU0TnZEci1leUNjMEgy
a3VsRnVuOVFWJnM9OHVJd211MEdMOENfZXR6QkhDc21pcDNTU1pUbDd1Wmt5ZVd3eVVkbXFqSSZl
PSAgW3YxXQ0KPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJs
P3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19hbGxfMjAyNjAxMjEwNjMxMDkuMTgzMDI2My0y
RDEtMkRrYXJ0aWtleTQwNi00MGdtYWlsLmNvbV9UXyZkPUR3SURBZyZjPUJTRGljcUJRQkRqREk5
UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09
VDl0ZzBES1ZPZDdoclB5TkpNeDhwOFl1LUR3YWdJdUlOc2poVWEzOThVNE52RHItZXlDYzBIMmt1
bEZ1bjlRViZzPVpMVTZOaEk3Y0JSWTJtMzl0M0E0NWR5czVDN0xyYnY1SlowTHdISEVLdWcmZT0g
IFt2Ml0NCj4gU2lnbmVkLW9mZi1ieTogRGVlcGFuc2h1IEthcnRpa2V5IDxrYXJ0aWtleTQwNkBn
bWFpbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEludHJvZHVjZWQgaGZzcGx1
c19icmVjX3JlYWRfY2F0KCkgd3JhcHBlciBmdW5jdGlvbiBmb3IgY2F0YWxvZy1zcGVjaWZpYw0K
PiAgIHZhbGlkYXRpb24gaW5zdGVhZCBvZiBtb2RpZnlpbmcgZ2VuZXJpYyBoZnNfYnJlY19yZWFk
KCkNCj4gLSBBZGRlZCBoZnNwbHVzX2NhdF90aHJlYWRfc2l6ZSgpIGhlbHBlciB0byBjYWxjdWxh
dGUgdmFyaWFibGUtc2l6ZSB0aHJlYWQNCj4gICByZWNvcmQgc2l6ZXMNCj4gLSBVc2UgZXhhY3Qg
c2l6ZSBtYXRjaCAoIT0pIGluc3RlYWQgb2YgbWluaW11bSBzaXplIGNoZWNrICg8KQ0KPiAtIFVz
ZSBzaXplb2YoaGZzcGx1c191bmljaHIpIGluc3RlYWQgb2YgaGFyZGNvZGVkIHZhbHVlIDINCj4g
LSBVcGRhdGVkIGFsbCBjYXRhbG9nIHJlY29yZCByZWFkIHNpdGVzIHRvIHVzZSBuZXcgd3JhcHBl
ciBmdW5jdGlvbg0KPiAtIEFkZHJlc3NlZCByZXZpZXcgZmVlZGJhY2sgZnJvbSBWaWFjaGVzbGF2
IER1YmV5a28NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gVXNlIHN0cnVjdHVyZSBpbml0aWFs
aXphdGlvbiAoPSB7MH0pIGluc3RlYWQgb2YgbWVtc2V0KCkNCj4gLSBJbXByb3ZlZCBjb21taXQg
bWVzc2FnZSB0byBjbGFyaWZ5IGhvdyB1bmluaXRpYWxpemVkIGRhdGEgaXMgdXNlZA0KPiAtLS0N
Cj4gIGZzL2hmc3BsdXMvYmZpbmQuYyAgICAgIHwgNTkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIGZzL2hmc3BsdXMvY2F0YWxvZy5jICAgIHwgIDQgKy0tDQo+
ICBmcy9oZnNwbHVzL2Rpci5jICAgICAgICB8ICAyICstDQo+ICBmcy9oZnNwbHVzL2hmc3BsdXNf
ZnMuaCB8ICAzICsrKw0KPiAgZnMvaGZzcGx1cy9zdXBlci5jICAgICAgfCAgMiArLQ0KPiAgNSBm
aWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2ZzL2hmc3BsdXMvYmZpbmQuYyBiL2ZzL2hmc3BsdXMvYmZpbmQuYw0KPiBpbmRl
eCA5Yjg5ZGNlMDBlZTkuLmZlNzVmM2YyYzE3YSAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9i
ZmluZC5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvYmZpbmQuYw0KPiBAQCAtMjk3LDMgKzI5Nyw2MiBA
QCBpbnQgaGZzX2JyZWNfZ290byhzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQsIGludCBjbnQpDQo+
ICAJZmQtPmJub2RlID0gYm5vZGU7DQo+ICAJcmV0dXJuIHJlczsNCj4gIH0NCj4gKw0KPiArLyoq
DQo+ICsgKiBoZnNwbHVzX2NhdF90aHJlYWRfc2l6ZSAtIGNhbGN1bGF0ZSBleHBlY3RlZCBzaXpl
IG9mIGEgY2F0YWxvZyB0aHJlYWQgcmVjb3JkDQo+ICsgKiBAdGhyZWFkOiBwb2ludGVyIHRvIHRo
ZSB0aHJlYWQgcmVjb3JkDQo+ICsgKg0KPiArICogUmV0dXJucyB0aGUgZXhwZWN0ZWQgc2l6ZSBi
YXNlZCBvbiB0aGUgc3RyaW5nIGxlbmd0aA0KPiArICovDQoNCldlIG5lZWQgdG8gaGF2ZToNCg0K
c3RhdGljIGlubGluZQ0KPiArdTMyIGhmc3BsdXNfY2F0X3RocmVhZF9zaXplKGNvbnN0IHN0cnVj
dCBoZnNwbHVzX2NhdF90aHJlYWQgKnRocmVhZCkNCj4gK3sNCj4gKwlyZXR1cm4gb2Zmc2V0b2Yo
c3RydWN0IGhmc3BsdXNfY2F0X3RocmVhZCwgbm9kZU5hbWUpICsNCj4gKwkgICAgICAgb2Zmc2V0
b2Yoc3RydWN0IGhmc3BsdXNfdW5pc3RyLCB1bmljb2RlKSArDQo+ICsJICAgICAgIGJlMTZfdG9f
Y3B1KHRocmVhZC0+bm9kZU5hbWUubGVuZ3RoKSAqIHNpemVvZihoZnNwbHVzX3VuaWNocik7DQo+
ICt9DQo+ICsNCj4gKy8qKg0KPiArICogaGZzcGx1c19icmVjX3JlYWRfY2F0IC0gcmVhZCBhbmQg
dmFsaWRhdGUgYSBjYXRhbG9nIHJlY29yZA0KPiArICogQGZkOiBmaW5kIGRhdGEgc3RydWN0dXJl
DQo+ICsgKiBAZW50cnk6IHBvaW50ZXIgdG8gY2F0YWxvZyBlbnRyeSB0byByZWFkIGludG8NCj4g
KyAqDQo+ICsgKiBSZWFkcyBhIGNhdGFsb2cgcmVjb3JkIGFuZCB2YWxpZGF0ZXMgaXRzIHNpemUg
bWF0Y2hlcyB0aGUgZXhwZWN0ZWQNCj4gKyAqIHNpemUgYmFzZWQgb24gdGhlIHJlY29yZCB0eXBl
Lg0KPiArICoNCj4gKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCBvciBuZWdhdGl2ZSBlcnJvciBj
b2RlIG9uIGZhaWx1cmUuDQo+ICsgKi8NCj4gK2ludCBoZnNwbHVzX2JyZWNfcmVhZF9jYXQoc3Ry
dWN0IGhmc19maW5kX2RhdGEgKmZkLCBoZnNwbHVzX2NhdF9lbnRyeSAqZW50cnkpDQo+ICt7DQo+
ICsJaW50IHJlczsNCj4gKwl1MzIgZXhwZWN0ZWRfc2l6ZTsNCj4gKw0KPiArCXJlcyA9IGhmc19i
cmVjX3JlYWQoZmQsIGVudHJ5LCBzaXplb2YoaGZzcGx1c19jYXRfZW50cnkpKTsNCj4gKwlpZiAo
cmVzKQ0KPiArCQlyZXR1cm4gcmVzOw0KPiArDQo+ICsJLyogVmFsaWRhdGUgY2F0YWxvZyByZWNv
cmQgc2l6ZSBiYXNlZCBvbiB0eXBlICovDQo+ICsJc3dpdGNoIChiZTE2X3RvX2NwdShlbnRyeS0+
dHlwZSkpIHsNCj4gKwljYXNlIEhGU1BMVVNfRk9MREVSOg0KPiArCQlleHBlY3RlZF9zaXplID0g
c2l6ZW9mKHN0cnVjdCBoZnNwbHVzX2NhdF9mb2xkZXIpOw0KPiArCQlicmVhazsNCj4gKwljYXNl
IEhGU1BMVVNfRklMRToNCj4gKwkJZXhwZWN0ZWRfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgaGZzcGx1
c19jYXRfZmlsZSk7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgSEZTUExVU19GT0xERVJfVEhSRUFE
Og0KPiArCWNhc2UgSEZTUExVU19GSUxFX1RIUkVBRDoNCj4gKwkJZXhwZWN0ZWRfc2l6ZSA9IGhm
c3BsdXNfY2F0X3RocmVhZF9zaXplKCZlbnRyeS0+dGhyZWFkKTsNCj4gKwkJYnJlYWs7DQo+ICsJ
ZGVmYXVsdDoNCj4gKwkJcHJfZXJyKCJ1bmtub3duIGNhdGFsb2cgcmVjb3JkIHR5cGUgJWRcbiIs
DQo+ICsJCSAgICAgICBiZTE2X3RvX2NwdShlbnRyeS0+dHlwZSkpOw0KPiArCQlyZXR1cm4gLUVJ
TzsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoZmQtPmVudHJ5bGVuZ3RoICE9IGV4cGVjdGVkX3NpemUp
IHsNCj4gKwkJcHJfZXJyKCJjYXRhbG9nIHJlY29yZCBzaXplIG1pc21hdGNoICh0eXBlICVkLCBn
b3QgJXUsIGV4cGVjdGVkICV1KVxuIiwNCj4gKwkJICAgICAgIGJlMTZfdG9fY3B1KGVudHJ5LT50
eXBlKSwgZmQtPmVudHJ5bGVuZ3RoLCBleHBlY3RlZF9zaXplKTsNCj4gKwkJcmV0dXJuIC1FSU87
DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9mcy9oZnNw
bHVzL2NhdGFsb2cuYyBiL2ZzL2hmc3BsdXMvY2F0YWxvZy5jDQo+IGluZGV4IDAyYzFlZWU0YTRi
OC4uNmM4MzgwZjcyMDhkIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2NhdGFsb2cuYw0KPiAr
KysgYi9mcy9oZnNwbHVzL2NhdGFsb2cuYw0KPiBAQCAtMTk0LDEyICsxOTQsMTIgQEAgc3RhdGlj
IGludCBoZnNwbHVzX2ZpbGxfY2F0X3RocmVhZChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPiAg
aW50IGhmc3BsdXNfZmluZF9jYXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdTMyIGNuaWQsDQo+
ICAJCSAgICAgc3RydWN0IGhmc19maW5kX2RhdGEgKmZkKQ0KPiAgew0KPiAtCWhmc3BsdXNfY2F0
X2VudHJ5IHRtcDsNCj4gKwloZnNwbHVzX2NhdF9lbnRyeSB0bXAgPSB7MH07DQo+ICAJaW50IGVy
cjsNCj4gIAl1MTYgdHlwZTsNCj4gIA0KPiAgCWhmc3BsdXNfY2F0X2J1aWxkX2tleV93aXRoX2Nu
aWQoc2IsIGZkLT5zZWFyY2hfa2V5LCBjbmlkKTsNCj4gLQllcnIgPSBoZnNfYnJlY19yZWFkKGZk
LCAmdG1wLCBzaXplb2YoaGZzcGx1c19jYXRfZW50cnkpKTsNCj4gKwllcnIgPSBoZnNwbHVzX2Jy
ZWNfcmVhZF9jYXQoZmQsICZ0bXApOw0KPiAgCWlmIChlcnIpDQo+ICAJCXJldHVybiBlcnI7DQo+
ICANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvZGlyLmMgYi9mcy9oZnNwbHVzL2Rpci5jDQo+
IGluZGV4IGNhZGYwYjVmOTM0Mi4uZDg2ZTJmN2IyODljIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNw
bHVzL2Rpci5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvZGlyLmMNCj4gQEAgLTQ5LDcgKzQ5LDcgQEAg
c3RhdGljIHN0cnVjdCBkZW50cnkgKmhmc3BsdXNfbG9va3VwKHN0cnVjdCBpbm9kZSAqZGlyLCBz
dHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+ICAJaWYgKHVubGlrZWx5KGVyciA8IDApKQ0KPiAgCQln
b3RvIGZhaWw7DQo+ICBhZ2FpbjoNCj4gLQllcnIgPSBoZnNfYnJlY19yZWFkKCZmZCwgJmVudHJ5
LCBzaXplb2YoZW50cnkpKTsNCj4gKwllcnIgPSBoZnNwbHVzX2JyZWNfcmVhZF9jYXQoJmZkLCAm
ZW50cnkpOw0KPiAgCWlmIChlcnIpIHsNCj4gIAkJaWYgKGVyciA9PSAtRU5PRU5UKSB7DQo+ICAJ
CQloZnNfZmluZF9leGl0KCZmZCk7DQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL2hmc3BsdXNf
ZnMuaCBiL2ZzL2hmc3BsdXMvaGZzcGx1c19mcy5oDQo+IGluZGV4IDQ1ZmUzYTEyZWNiYS4uNWVm
YjVkMTc2Y2Q5IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2hmc3BsdXNfZnMuaA0KPiArKysg
Yi9mcy9oZnNwbHVzL2hmc3BsdXNfZnMuaA0KPiBAQCAtNTA2LDYgKzUwNiw5IEBAIGludCBoZnNw
bHVzX3N1Ym1pdF9iaW8oc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc2VjdG9yX3Qgc2VjdG9yLCB2
b2lkICpidWYsDQo+ICAJCSAgICAgICB2b2lkICoqZGF0YSwgYmxrX29wZl90IG9wZik7DQo+ICBp
bnQgaGZzcGx1c19yZWFkX3dyYXBwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYik7DQo+ICANCj4g
K3UzMiBoZnNwbHVzX2NhdF90aHJlYWRfc2l6ZShjb25zdCBzdHJ1Y3QgaGZzcGx1c19jYXRfdGhy
ZWFkICp0aHJlYWQpOw0KDQpEbyB3ZSByZWFsbHkgbmVlZCB0byBkZWNsYXJlIHRoaXMgZnVuY3Rp
b24gaGVyZT8gVGhpcyBmdW5jdGlvbiBoYXMgYmVlbiB1c2VkDQpvbmx5IGluIGhmc3BsdXNfYnJl
Y19yZWFkX2NhdCgpLiBQb3RlbnRpYWxseSwgd2UgY291bGQgaGF2ZSBpdCBoZXJlLiBCdXQgbWF5
YmUNCndlIGNhbiBwdXQgdGhlIGNvbXBsZXRlIHN0YXRpYyBpbmxpbmUgaW1wbGVtZW50YXRpb24g
aW4gdGhlIGhlYWRlciBmaWxlPyBUaGUNCmZ1bmN0aW9uIGlzIHRpbnksIHdlIGNhbiBrZWVwIHRo
ZSB3aG9sZSBmdW5jdGlvbiBpbiBoZWFkZXIgZmlsZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4g
K2ludCBoZnNwbHVzX2JyZWNfcmVhZF9jYXQoc3RydWN0IGhmc19maW5kX2RhdGEgKmZkLCBoZnNw
bHVzX2NhdF9lbnRyeSAqZW50cnkpOw0KPiArDQo+ICAvKg0KPiAgICogdGltZSBoZWxwZXJzOiBj
b252ZXJ0IGJldHdlZW4gMTkwNC1iYXNlIGFuZCAxOTcwLWJhc2UgdGltZXN0YW1wcw0KPiAgICoN
Cj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvc3VwZXIuYyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0K
PiBpbmRleCBhYWZmYTllMDYwYTAuLmU1OTYxMWE2NjRlZiAxMDA2NDQNCj4gLS0tIGEvZnMvaGZz
cGx1cy9zdXBlci5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiBAQCAtNTY3LDcgKzU2
Nyw3IEBAIHN0YXRpYyBpbnQgaGZzcGx1c19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsIHN0cnVjdCBmc19jb250ZXh0ICpmYykNCj4gIAllcnIgPSBoZnNwbHVzX2NhdF9idWlsZF9r
ZXkoc2IsIGZkLnNlYXJjaF9rZXksIEhGU1BMVVNfUk9PVF9DTklELCAmc3RyKTsNCj4gIAlpZiAo
dW5saWtlbHkoZXJyIDwgMCkpDQo+ICAJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiAtCWlmICghaGZz
X2JyZWNfcmVhZCgmZmQsICZlbnRyeSwgc2l6ZW9mKGVudHJ5KSkpIHsNCj4gKwlpZiAoIWhmc3Bs
dXNfYnJlY19yZWFkX2NhdCgmZmQsICZlbnRyeSkpIHsNCj4gIAkJaGZzX2ZpbmRfZXhpdCgmZmQp
Ow0KPiAgCQlpZiAoZW50cnkudHlwZSAhPSBjcHVfdG9fYmUxNihIRlNQTFVTX0ZPTERFUikpIHsN
Cj4gIAkJCWVyciA9IC1FSU87DQo=

