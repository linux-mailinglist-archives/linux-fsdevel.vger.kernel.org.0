Return-Path: <linux-fsdevel+bounces-43790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D196BA5D8CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 10:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE6F189B8C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179C23817B;
	Wed, 12 Mar 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ISd78Nmk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lOxRd/wy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD83238161;
	Wed, 12 Mar 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770265; cv=fail; b=rGa5G2dcVlN6G0wBOP78NloICALMgB/73DieHYwMcPfOmA2tedkec5qRP9Sl6si1l4/uVDGIdU3DuSRybXs1VZnl+6uLFeADHcxvK5jJvUz0osfm1WOOLs9JhyTvllyixMtbSfnu3oHqW+ttBP/IEvzpSV0NCVA/OrIwGHtn8UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770265; c=relaxed/simple;
	bh=i143/E8I6a7VWq7jfnmqInjI/+p8MZeJaLE/g8fDm38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuggYdnuRJuvsD7SoGLAyZXXx9j87NIYd9Y4OHA6x9S3Wjah59XLUALExQzJF2OW6nuVO9yuLEXjjZa6e5dy5BzZrCz1abwCYsXnIzeaZQUP7xdAvmmtJcu5WljP5wYdAKeU66cdE2cx6n6/klBzl1Og8jK6L9vH9P7on93+SKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ISd78Nmk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lOxRd/wy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1fpQO013564;
	Wed, 12 Mar 2025 09:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iHUpXd95x4HvcYVzA/mwDLgMVDcZ7odU37j6+69Kvyk=; b=
	ISd78NmksvPKBUFoCTSsOjFDHotEVQjNaYQQm274su/oB0aS35aECeaHvYqnSlde
	AKyIXrh4drIUuLWMsfy4A0dxFtRhUA4BGmt9/AiInVNGPG3g7pbjNyRFuxVFMu/q
	Uors0935z4ZlTV0vXKVLO7Y4BrXfLAlFi470jEogvSkMtbqa0lz0Eh5oFLrPLd0N
	+os8Gow9wy9EnrLYiKDvvJuyDN9aprfHQtEB90kt7fMeJJak+IQnvas+qI6kDK/y
	S57wjKy7yAyIIp59DOFwmKVv9r9kUTHtUmaQ54m8MdMr1I/Omb7T1xb+VpBeRxTj
	SsPOn6fifGD09gMRctv7AQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4cs7au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 09:04:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C8XODb002236;
	Wed, 12 Mar 2025 09:04:13 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn70t5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 09:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaQgs3OEd5yKyYAUwiMe3j20kJ27F3H6oWBOTVyqbFuKQI9uwhue2aY7+CyzUYLuLuAlLJHBwmYF0pNJ9l/MmCFzMWRNUS2TEcFlZVzZCGuSVAVrsrYuw0mck+jZJBFkLBxqfgSZb9eFoucD6hbcQdao5kLgvwxs8eznahM+TyHEfOE6ZMQDlqwApWgrqpcn+4HGDqrbaHSbaz5C4v8Jx1DJto1v2Ntgd7fNbztB0L98qrFB+wMeQtqhTcA/Lja+zzWCUBgK4cDdjF6MuGGvLKPaB9Yx6rWrae0z68GuGhwp48n6inj2NN203HKLmDskPSvREBaATA9pIvk/I0noNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHUpXd95x4HvcYVzA/mwDLgMVDcZ7odU37j6+69Kvyk=;
 b=d/94Qd2p5CWKrr6mptJPDiqO9Vb1kDn37qICF8DfzPe4TAg908NsaY56yx8pNyKDbwZjcqZiV48sB/raVPmlLwwbQaDxPiQz1jpbIsVyq04U7g/O7Xamv3G1cbHcYQ6I6SHvH1LK7JXK9WN1Z+LZFpTncuHjUxNbX8jfEAUhXAv6HsZ9jOgIqPS15KGTqfQ3jpxiaaJNr/it6qeCCtmijNq4/P5Kv/mZ6iHn6boBogAaKabUFjtDK3cLnesXm+7YXERMZivPgBwG6Yg/ZzXFmL9Fqwf3R9YHoWcukOw7skj56rVGr677549/u4Ybe1BtC7T7dkFZ0kSgBbMqqeXD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHUpXd95x4HvcYVzA/mwDLgMVDcZ7odU37j6+69Kvyk=;
 b=lOxRd/wyZCeyIzrBPaJjG0TfxLX+LGXFc41PRbgf5jJFloVvi2xU+gerXwi30XPRlnxEcF2XM8sJVLf0NboQiTZTDL22LSwX4HvHJsc6XXsUBR6uLU7e2Z32RvRvMOalKnXUB5THxcvTAjBbLTzmtJ4cf5OdugspgkT6jd9uDUQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4776.namprd10.prod.outlook.com (2603:10b6:510:3f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 09:04:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 09:04:11 +0000
Message-ID: <63587581-17a5-431e-9fe3-a1a24ea4fa21@oracle.com>
Date: Wed, 12 Mar 2025 09:04:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] xfs: Commit CoW-based atomic writes atomically
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-8-john.g.garry@oracle.com>
 <Z9E6LmV1PHOoEME7@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9E6LmV1PHOoEME7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d5d772-0563-41a3-05ea-08dd6144da8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXdyRlFscGNwelE1Q2ZQMC9uckNENnNDRUU1Y1dSeGFHTDdUWmRoMHRpL003?=
 =?utf-8?B?NTNWdDkxQnUxWWJ3Q3NCcjc5NHRKV1J2TDVTQWRaMFRyM0JtUG9hclNVZkNU?=
 =?utf-8?B?eldidzZETTI4RUh2elkzVHlKY01WZXFpVkhCNXFqSmx2KzFkaFYyYm1NMjZ0?=
 =?utf-8?B?QzVGRjFTOUhULzFEWllSenRHTHAxUTQ2TWRBTmxCUVhpVmZwcTJzcXhhVmtL?=
 =?utf-8?B?SktSQlRWNnZtTTA4NUdyYmNTU0RSSk50cC9TOE5MbGVPd1JJR0d4aW9XcS9D?=
 =?utf-8?B?bDNqNUswRStMTjdsT24xenFKSTJOclBIWVV1cE03bGZ4M01TR1lVWEgwT0pK?=
 =?utf-8?B?OHB5OUVWWURadnJrdndEQkZ1NWVwSm5ORWxaYmp5VXl1YTQ1TjhjY3BqZzBv?=
 =?utf-8?B?anFpVmgyTEVWR3FXd0pkT3ZtU2pwWFcxRU5rZkxRdU54UGU4VnkralBFOS9y?=
 =?utf-8?B?U2RTb0ZySFFmWmxrQlZSZG5zeWdWNlhzKytXMzNPMGlmRHFWZkt5RDJjUkFm?=
 =?utf-8?B?S2JVUXIycktDbVRFVktxZlJwQStvRmM4d2FiczZUVzJvQ3F3aUdna0xmTkRE?=
 =?utf-8?B?anNydmJSY2NBdXhydWdsZFZnK0RyckE0UG9hYmM5NW1VdmVaOGdZdm1TUmNL?=
 =?utf-8?B?MzZ3aTBrV3dIYmpSdVpHU2JNVmpkVGkyaDJ4YnJaVVk0bS8wdjgrK0NTVWp3?=
 =?utf-8?B?bWRxYWdGTGhHbzl0ZGdGWnhNRkdPZlJRMkNWUXYvbVdzN2lDbGowekNNaXVP?=
 =?utf-8?B?TXkxa2Z4cFhIZ2NhY05Lbi9RS09RVERHL2FNb29TMzNYS1p0aEF2eU1WQ3BS?=
 =?utf-8?B?WURPS3BNb2VROWM1ZHhtdnpTRUxINDFiYTNiWjBHSG5pZnBlNkRmS3c5Q0h1?=
 =?utf-8?B?SHE4emdBR1hOT2hRNzVSbjFoZTlnTEswdFFRVlg2Y1IvYmVHbHRndnN1Tlkv?=
 =?utf-8?B?aXp4S0p2SWVOTFYraWN0L1ZrTDZ2VlhYeVFQSnFzUkJlanFQM0xiUXZ3NVpt?=
 =?utf-8?B?Qkd2RzVFM1J3ajc4cjFQSDZNM0ZUM2lwMTlUZnpydEttOVhnTXBTOVZBUS9M?=
 =?utf-8?B?VEMrbjBldEJkTFZqQzN3eTV1bldoV21MRkFNelkrblhlT29mOVJHREZNT296?=
 =?utf-8?B?VXRXUkN4aml0TzYyVExWVGZCRmo1VEd0SVhoQjNGbDdITmZXYmtZUDB4UmxW?=
 =?utf-8?B?MFNWaTNCSnorYVhSMm9oNnE0N2MwSDNtY1VnNDl4TG5WZ3lZamRJT21LS1l3?=
 =?utf-8?B?Uy9KVWY0Wk9MRG5keXhwa3N6eDNSOWo4UmpDL3o4bVVQQ2JLQ09lZ2REY3FK?=
 =?utf-8?B?THN2NHpWNVQ0SEd6UXlvbEZ2Y3pXMDZmWWoyOVJxUytUS1lHZFVJL0tVNVF3?=
 =?utf-8?B?WFdWUDFMYnBneUpFa05ITjZoMVphczU2OEFMTWNFVUs3aGNxWDU5dHFzcW8v?=
 =?utf-8?B?elFuMlB2dU5pempFYmxEbnhYN21sOWJrTXRqendjYkhPbnRSdW45YVd0NlRP?=
 =?utf-8?B?Nm5KUk4zMktMelcxMnVCVXBydFp3VTY1d1ZvS0JrNHBHUm45dVY4WlJ5amJi?=
 =?utf-8?B?U3pjYVZYbS9Kb3ZCNHg5NTVuZ1ZzSmtTTVdVRS91TXUwUWJibFNkSDkrdEdm?=
 =?utf-8?B?elBpOGtBVlRjeEphQzk5Tm9CcEQ3V0c3dlpTNncrMU1ra1cvVHR0VDdyY1JX?=
 =?utf-8?B?Si9VUTZldnU1YUVBVk9hOXdwR0UySHFvRFNBZ1VJSDUxZC9TOU15Y0ErYWdy?=
 =?utf-8?B?L3lxMk1pNzhrbDFvdU0yMG5EemF2b0lpb0pVMzNPdFdSU0xqVnZKaXpxWW9L?=
 =?utf-8?B?TVUrL0xPOGVJU3ZuTlVKK0ZRd3I2TENuOXRtY0VUQUljUERmdy8xYzFheUho?=
 =?utf-8?Q?J3HMgk1syyJXQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTNPRkhkcWYzSEJibnRRNUxmWFNVN3J4MVQrYkxHMTBZQmVmRCswTnJUTC9C?=
 =?utf-8?B?cUNYVlczd05WQUFMUTZKWkxtS0l6NmEyTituTkNYWi9ua2I2eC9Lcis5U1Mx?=
 =?utf-8?B?MzE3TjNEY0s0cnNXdFdtaVVaQ2hMM2xpS3QrZ2QyUkZHQk5KZmErbGJiMDZx?=
 =?utf-8?B?dC95ZUlNVjFnOW9mY2ZxYk1SMCt3Qy94K1ZwdlowN0ljYkkxazNlTFY0aWFN?=
 =?utf-8?B?eGxyVGRGOFl4ZVJyWWhxQW9WSCswTFh3Zk1OcXhSOGRaS3pwa1ptWmtVczEz?=
 =?utf-8?B?aXVOMXcrTklkYkh4WmQvRFBrNDFTZTJ2UWZKTWMvSm1XSFJOaXR0TEVZeWZo?=
 =?utf-8?B?VXJnOTVuSGhBTFFLWjJQczFVTDF5YU51QVNHOFNCZ25qSlVuUnBZYlpTM3py?=
 =?utf-8?B?RkFuVHZYWnJXNnFHOHhpTHNmRUtqVC96RWU1YnphSTJMYmR3cWNCeHZjMHpv?=
 =?utf-8?B?MXpGSXNKczErUzhyVU5kMWYyRThVbk9WYzh2QmlrVUF4UC9EUy9KRmhOTnFv?=
 =?utf-8?B?ODh3bStjT3QyaVRuRjAxbnVMbHhIaGJGQTNwYXFHTFVNYjBCSnRod0lKelNU?=
 =?utf-8?B?TjhpUFQveUd3Z1d3dk5EdG5MNTZDWC83bGYzVk9Ydk9DOUxhY3pjNHpCQWJP?=
 =?utf-8?B?VWdSMEVFbU4zMWlPYWh5SjFTN1JGUWIyaXgwZTZLb01FYUlNdDFMa0RqVGJj?=
 =?utf-8?B?M1hHZ0xTbXdpeWhGeXB6SjZKd3pENzg5ME94QnMyVG9OMW9SbVBsaEpmMjZ1?=
 =?utf-8?B?QXNnT25IYXNLczlVUDdEdWE5MGtISnZSNndON0p2c2JWRVE2WWh2cjgrQW43?=
 =?utf-8?B?VVc2d0M0ek1DcVFBdUJRV0ZuWFZpOElDREp6OFVaQ2lNNEpudk5hSk1tcmJI?=
 =?utf-8?B?S1pEcUFhQ0VoTk5PZC9tbEZNakptSTVqc0pOMmU2RXBXM1g1ck9SZUpKZzhw?=
 =?utf-8?B?NldKRmhmcStiblZmMFdkMDRZMzlDTmh2SnI5SDUrR2Q3ejh0VU1GdWc4N3JC?=
 =?utf-8?B?SVFwZkdwS2UyaEVjMDdQWTV3K2x3NDE4bmpTNWx0dEdaYlJieDNnSnZUWjVI?=
 =?utf-8?B?WERrcWJjazM4NEJwWTZPZ2hsbTg5ZFcvcXZjOGcwb0l6VDNzM0QzNER3c0dV?=
 =?utf-8?B?WTRMLzFJck5HViswSWtBU2YzSlV2R0p5aDJVd0ltejAwcjFHL295TWtSYW1M?=
 =?utf-8?B?dTdMR1haYVZzMmlTQ3luaitleW5Fa0ZSQ2lXbDRvVFViekw4dU5FclJSNVA1?=
 =?utf-8?B?TjFEbFFjZlQzWWdNanJDYzJ3cTZEWGlXVXYzY0I3NkttNUJlVlBFL0ZhTFNO?=
 =?utf-8?B?V2RYZDFLZE4za3lPZjMrZXFnRFdvdHpaQi9pdmQ5dFZyYkZhWnBHbUJycXVY?=
 =?utf-8?B?cW9DWjdIaDlScEtOamlDZ1VTWG1rMjVTeGFqNHU3czY4V3daZXo5MXgydUVt?=
 =?utf-8?B?ci9oUmpTR1Q3aG0rbE5NVHBTVVU5ckNsT3JUcTNyWVBpQWh0RWY3R0RDYXAz?=
 =?utf-8?B?SU82aG10U3FONitMOTM1YWdIWkxJODNNeUtkeUhxSURHU1BYSlVFVjdmU2JX?=
 =?utf-8?B?REdtQm4yLy8yaHhIQlkwc0t3bnJXM1M5akJZc0hrTmQ3ek9rcE16NEtWTWRU?=
 =?utf-8?B?RkVyeXQ4dzRMT1lFeHA1WG9paDlEcDViTG5Va2Nrbi94Vk9zQ1Z5OEwybHNJ?=
 =?utf-8?B?RzZ5a3J3N3J5alB5WmZzbCtFd1JUOHpJOVZKMWZTd0pIdFBiTlJ1UE85aGNH?=
 =?utf-8?B?UlVuN3RhZ1hTYWs3MjQyTDczM3l0dTNBVFBPOCtHcFhid0l3ODRyMUhCUTN5?=
 =?utf-8?B?cCtMZERkMHdGRXNxN0xtcXBxK2I5WFZDczRVbURYZlBoeFVETU11NFp5amhD?=
 =?utf-8?B?aUg4RmZYbmoyN1JGeHlrYzBQVXJPQkxCODRQaEFJYitWdmhmQWx6bHk3OE1x?=
 =?utf-8?B?K3R4Wm9NcFZOZlJ5N1ZZSkVjbFVYbWoyZ2s3Q25ORGdZOGFWOTdHMnhsWXYx?=
 =?utf-8?B?UHN6SmxrOU5CV1hDVW4xdnpsdkx0QjluaXhPcmk2ejZxUVZvdXRaK1Z4RlJu?=
 =?utf-8?B?L0tlRzZwYUhEYWRKQk9NSm9MR1c4UWVhbjJwSHg2SUQvOGg5YURON3BiMFUr?=
 =?utf-8?B?OE15VVJJeW1kZkh3VTdMZDAvdFV2TVJJL212WkxKNXF2dVVFZElrZG1zM0x0?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TPfVqOcPPkV8aa46zeqUhHxR2oIZ7c7WC4mn9CvqCAnYdX3Vzt+dn7iA0FF9Gx76yZwHj6OJdl5/Vlu8jIuBgwWW56MVhbvzgUhHSY+jfxIOjMqkn0YJnQFBzbndXr/aYWjyOiqIK85D0iOWLYDOs6BTxSkifoORcWb1PPdr+Pzo85gE2mx9AJiQyB0jQFQoapiCvhq6sEwYVuzjE5OdqJC9miqF1JklphppqeNGkdD2w5cTXfLIrtFmlqlocdTp2jm5UYMD1Z+4MD7OFZ5ePTdZMEaP37w4JSaeFOpMOqEvM6rDeNwQSrDFseWd2G9hNFOMX5ng2ZrKv1c/+5vMfy5IBweNOZoTPJh91ywC4+b5G0CMP4cks2lcfKyrzRFoOgs2Xahix/l7P4gLhmx8fBYHUBMfLqRJfS8zheqSk45CPtB3M0Xc966aLn5jiXaSuQ4bwP6kId43VUcvdhVtsLZ0kiS62YhFlKCAaR10MI/bZiRJWm2waH+m8/T3hbAYAUKW9VXUtAHZ+GXyF9pl4wPL01gwI3KjCMEx4DAJbo3fP3uBeWZf6tFSgj5KxmWiwzACd+SlvF++oThyuSBH33r2b11ZpLXJJMcrmb1kDGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d5d772-0563-41a3-05ea-08dd6144da8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:04:11.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOw8fH+/F/NRfLn8FehXIsfMp6kG2qN6hmFKolnGue4UrtWPt1bTlAOf5SLxEbv2alnHa/1mYcAHBPbg6uQQMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120061
X-Proofpoint-ORIG-GUID: uBEW2DUKWfrBQhQxCo9s5y87V6r9bcNi
X-Proofpoint-GUID: uBEW2DUKWfrBQhQxCo9s5y87V6r9bcNi

On 12/03/2025 07:39, Christoph Hellwig wrote:
> On Mon, Mar 10, 2025 at 06:39:43PM +0000, John Garry wrote:
>> When completing a CoW-based write, each extent range mapping update is
>> covered by a separate transaction.
>>
>> For a CoW-based atomic write, all mappings must be changed at once, so
>> change to use a single transaction.
> 
> As already mentioned in a previous reply:  "all" might be to much.
> The code can only support a (relatively low) number of extents
> in a single transaction safely.

Then we would need to limit the awu max to whatever can be guaranteed
(to fit).


> 
>> +int
>> +xfs_reflink_end_atomic_cow(
>> +	struct xfs_inode		*ip,
>> +	xfs_off_t			offset,
>> +	xfs_off_t			count)
> 
> Assuming we could actually to the multi extent per transaction
> commit safely, what would be the reason to not always do it?
> 

Yes, I suppose that it could always be used. I would suggest that as a 
later improvement, if you agree.

Thanks,
John


