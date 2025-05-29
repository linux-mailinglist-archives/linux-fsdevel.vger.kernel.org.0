Return-Path: <linux-fsdevel+bounces-50096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731FCAC8227
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDA41714EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B918230BFD;
	Thu, 29 May 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d6f1/Cgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2637C218EBA;
	Thu, 29 May 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748543282; cv=fail; b=aCZkjFAQQenEJmkxqqtElydbcasFuUX+/H/jR7Rt/aX7GNALgDUFI117GryWfVHMvvnFqkE9UfBWwHK22BTxR3doeoUkSfwQ9TgIxy/wu1XDTMr+gnLSeWeK7tniXGAjq4aQCyjJoR9Xp5XWbahDgsn5dELfvhNpOFi+FPmoi7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748543282; c=relaxed/simple;
	bh=t2/fK6tYKPPtctfG89M65g6tTEgK4TDU6VdUf38mSIM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=T555U8QeZ0qGZy6Z1n4Cu5+bMOK6RfmwfKidRGpRnjr8naotnVzQP5l6kDlc6Cyv57tU4wt/FloqRO8TvyRXojOifwBeg/J6d+KHcaKYqZHFlj9HZUpT6pR6aneWQQmKnp2QjK1YHsUwekLVW3jW2vWQP2KZD3jHtBpLr0sIECg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d6f1/Cgb; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDIxFA002734;
	Thu, 29 May 2025 18:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=t2/fK6tYKPPtctfG89M65g6tTEgK4TDU6VdUf38mSIM=; b=d6f1/Cgb
	stf5v+02cg7eXYkjKuWzx2MPftllf9vB1cvoJokwGseq2AZ8W3BKqk9q3yihlyb1
	Ss6gPLgkZSVom1Ua3sUz/80F+pkVXGPip2rbo5hV335CSEDFhvOaS1DFlsuxiQ2i
	4ARymQggQAnsQeEIML1keTv2AKDgr7Qozri50rJ3gwAyc8O4TEG3ixwJMmbxW4sk
	0KLSZ+XA+LiDSLXpjecKhVNn1tM4f9KZlaGAUXCmDblr0/CbqDX1DAvvVQuo95mX
	MA/aIfUk+uoN7VuLDxODM6QDvnWUjh3fCyCoV+0nEFcIyNJZFNR7hGWewL9YAs24
	cbvVgcAPD6jy9g==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gq9k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:27:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ox30JpkOn3aqIrHStYymLzcR7kjMUPzj3lygfa5koTVAmP7/HnfRhpLvqXrHo5+DjSDn18/0odVHKZc7KTXz44UzY4vKMjiSAqDyBr3iiAtOsr0kZwQcDPUyXsgqV1QefaqqedgzMrSftUnyLZnBHymdP3vr2PqpYIJB/EDzhPWuFYUmcQXCvlRw5EjWmkjU0rxmlcT1K2ThpjHkyerwoAt/1ZlbHWFJOlaWAdwMEyQJ4RKkEw368912wTq4LZGLkMs+bQ4H6s8UHd7bZgxyMMVvPMSfv3pagH65e34V+L6yEwZOHc3ZGKBsHXzO23863R5eNIdAR5c3gavOZrdXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2/fK6tYKPPtctfG89M65g6tTEgK4TDU6VdUf38mSIM=;
 b=w9b1/L5FrCZJfp4h0q5qcPBRi63zh3fmhWEFUcEmgXk+w6R0apyyOrjSgnWYziim49FJqOTj59hRAHboTXs6m0A9yunIz0MTaEwksr64fj35PyPGkiFIQhbxsTb377titGSQENCMBcoPGkF85Imbsr8cXSJUuYATKD2bMsKonz6Ck7HjIOhmneC4ZGiUepXAtHN42EN86Sr9HW132BstrcdgudIZ2nM3BLQfOtZPhebJ5qpHBE7D+QzjFg6thl8PKb0KrS++XiedLJQi5SVzUbEYPAKQQ+B09z6MYfFP+VtSO+hRMRYvh7Yt7pcqDTCaOXP0O/CAn8pr0idlZI1FeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB5678.namprd15.prod.outlook.com (2603:10b6:806:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 29 May
 2025 18:27:50 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 18:27:50 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kees@kernel.org"
	<kees@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 1/2] hfsplus: make splice write available
 again
Thread-Index: AQHb0J83pCna/icp3UyGZydyO8Q/kLPp7YSA
Date: Thu, 29 May 2025 18:27:50 +0000
Message-ID: <fa46baccde906c7e52b1d84264d284be1072ffcf.camel@ibm.com>
References: <20250529140033.2296791-1-frank.li@vivo.com>
In-Reply-To: <20250529140033.2296791-1-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB5678:EE_
x-ms-office365-filtering-correlation-id: 4b44a4c4-f095-4009-ac91-08dd9ede84fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N01oano3UXUrSDNyUWh1QmdYazVLQXp1RWl6OVNNTGNucHFrYXZBT2tIYlph?=
 =?utf-8?B?OFdQeEVob3REdisrYTViQjRlTDFJOVpXbUk2Z3RFUE4zMDF1VUxvZGg2bTVP?=
 =?utf-8?B?ancwS2xQNGdaaUpUZks4UmgwWksyenJwOFpZYTM4QS9wS3QxTzM2NGVkZ05Y?=
 =?utf-8?B?a2JnMXp0djdwMFE0ZDFkbUo5Z2d4bTA0SzYrNk1xalo1OVVUVXBEVHdPaWpU?=
 =?utf-8?B?cXVFd0krRXpZVnlCTXcwWHZqcDlZSHMzYXJXaWJKVTNVYTN6Q09paWxkMUpT?=
 =?utf-8?B?cmZUV0k3T093dXNKU3kvTEFoakh0VTNvOEFXU3pGbEN6azdHQUpGS09RaFU1?=
 =?utf-8?B?cDBiMkFHekhCYlE3cFdZOVhDUnhydXJ4RVVYbVFXbHZtV3k2NEhyMWdqbllU?=
 =?utf-8?B?Um9CK0FPK2FOUzkxSDRNVGxOTWJCcVpHR2pON1ZEdzlVNld0d0xUV05rTExG?=
 =?utf-8?B?bzhuMXh2RUZNTVBwUWFTLzBzcjNyWGxpRlpHZDJUbG9WaXB1VVI0N1QvaTIr?=
 =?utf-8?B?aGJFMkllc2htcklhNXZrekJhdjZXR0E1Y0hKTUNQMExtUFMyNDJVa24yNHRh?=
 =?utf-8?B?SWd0R3dadXRuc2FxaE9XQk5oUldXTzRTcmZMMUplR29oWWpzYW5NNUVXUFRq?=
 =?utf-8?B?WHQwMllyVWNiUE5pOVlpNGNKMFQxbGFZb0xrbmd3dVFCWU9tZ1daSFlYV3Qv?=
 =?utf-8?B?RHdMaHB0angrUXd5MjBPNlZEM0FuV1ljYXlCVTlBZVdsNzdHZ1k4eWtZME5C?=
 =?utf-8?B?eERoUGpMYWxIYW4vcmx5SDRCQlhxeklvelNFMnpOVUpGQk1OMWRPd3pTZnFl?=
 =?utf-8?B?RTlOY2dyN1RRUktRQzV4Sk9tbmY1UkNObXZ0WDhRZHBDViswN3FwTFlpa3hv?=
 =?utf-8?B?aFhxSVIwMHdpSmxpZ3I5WXllSU5kZ2dzaHQzdU9WU3JLb2c2dE8vNGtaS29X?=
 =?utf-8?B?bGhXQ3pCYTZ5TFJMbkpkYlN2ZjZMeWM3by92SS9scWtFNElxZk5oNllqY0VX?=
 =?utf-8?B?VnlTRXZWKzJSZXZKSEVEQ2U2VUY4Ymp3SkY0cldLTzNsQWVDaG1xbW9aL1hJ?=
 =?utf-8?B?eE9rVzBWMGRxV2FvaXQxQ3RPellxbXpUUUNXMjZPVzl1ZFRuVytYTEpjc3Yy?=
 =?utf-8?B?Z0ROZVZiK1ZGb1VGOVJYcmptUnl1STA4V2R6L0lEUWx4LzdDK2xvT1RuM0dn?=
 =?utf-8?B?ZlM3cGd5ek5zTXlzallnRTFDblBqWVI3UjNHRnFYWjM4Y1FNdkxpQU03Zmdm?=
 =?utf-8?B?a25talF4SWZ4RS9wUmdBRHBTNE9TbUp5V2JUaXhRM014dVN2QnNBTVV6TTdH?=
 =?utf-8?B?RHl5NkxlclBQL0ZSUENTNTJrMVdUak9ZU3lIWFA3Wk9ON1VMYUZ0YnZ5emNm?=
 =?utf-8?B?RWVKOStjVmJ4N2dHVm1ROEh0ZEEwampKSXlXKzZybXJGaG5obk9IMFVVWTFu?=
 =?utf-8?B?VGl5dzNxVGM5ZFFkWkJhYmo1Mk5RVHp1dnZ6aThoRGVBT1hHbEJjamhUY1VC?=
 =?utf-8?B?anZueVE2djhwTkFUeWhjVXFKZitwZ2FvZWpJcyt6ZXhFYWQ0dG1pZm5XRGxr?=
 =?utf-8?B?K2c3MXpRS0dneHpEVGx6ZzdOQlUyMnNIZVU1TCs4L3V4bjY4UDh0dUhjSk4y?=
 =?utf-8?B?cVNVUlR6R3hhbVhIQ0RMV3gyaWRoZ3BGWi9iUjVFMmNyU216Y0piNG8zK2Uy?=
 =?utf-8?B?Uy8xdEtuUnowMkQwZnhXYWovYm9jbUM5R0s5dmhOaGVRa3NBUDQ0Y084T0hj?=
 =?utf-8?B?aFdmZEhMZ1B0RjV3dDFIQmg5UGhLODRqUW1UQ3VjTlB6czZPdjN6UWsxL3Bn?=
 =?utf-8?B?ZWwrWlI2dlF1SjByRVF4Tlh0eXBNVjV4M1hiWWVPc2crcHlFdzlJTW8waFNN?=
 =?utf-8?B?V2UwSE9yV3A0bTZvUmZKYzZCSHM3L0U1Y0lkL1gxT3hzbmF6SzVjVlpQSEZR?=
 =?utf-8?B?dTlUKy8zcWwrbGUySEIwYkFCSHMwcnJkRnYvMlQyM3p6d3V3M0RScnhWTytl?=
 =?utf-8?B?b3ZyU3lQY3JRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVVkdTE0QWUrL2V4SkRqYVdudnR3NlgzZW43VGRyU0I2VVdLVUJubVNFNVFk?=
 =?utf-8?B?SGFUUlQvdmhROVc5R3BXcTZuOWFiVis2NGxtbk5pUHV1U21PMUsrd21xMEVC?=
 =?utf-8?B?WENjbFpDdERrd0JLZyt0RFJRTWp5cW1nQXRtdHJwbEtBUHd5eW5NbDNxenZF?=
 =?utf-8?B?aFlKUjJnSTZON2pUMXpxSlNFSmNBd1ZDWHdhajJRRjdXbkdHZWZ4d0RjV0lp?=
 =?utf-8?B?ZXhwMnZjWkdia29HSS9xTitlYXdJTFFoYnYzbVFuZUg0VVlUNUlhSEVQYVlm?=
 =?utf-8?B?MUJzSGJaNlNQeW9VT1ZHTmRMbVRXUmJNVFNWU3JLNWowelprNno5K21jRTRG?=
 =?utf-8?B?WHQ5d3RhdG9sNmpMQnVSb0tUclB6eWE5bU9mSm8yTmZKOEsyY3BRV250empY?=
 =?utf-8?B?SUZCVTV5OVpxa1JabmlBaDQvSkhKa0ZwN0ZvdUpDR3hXOWl4OGVBVG4zT3Nq?=
 =?utf-8?B?MjZ1S3lpK0tYdS9KakJTYWFBRk1aV0VtdEVta0YycUN6YTZXeTdML1Fpb1N0?=
 =?utf-8?B?R3d4WnVMbk1QcFltVW1rQ1ArdnI0OXhDRGF5MHEwNUdLT0ZJS2MxaVN0TXJT?=
 =?utf-8?B?SlNucWpxdXR1QzQyeVVrVVIzd3hGOE82bWx4bmpNeUlGWlkrRnJpd05hRWVr?=
 =?utf-8?B?bVVEQWpUU1dsQmFMSldOL0hrbHdtbFYwZW90QjF2SGxyWFNaUHVTMURtT1Jr?=
 =?utf-8?B?eHBxaEZhZmpRWndNTTFsdWxNSVd4bG82OUNoZGdBOTFJVnR3MVJyRWp6UThF?=
 =?utf-8?B?SXpnQ3ZPRUFQSnFhYlRnMUN6TGtyUTQ0WnVXVmI2YnRoWVU4NUJBN29BK1F0?=
 =?utf-8?B?ZXRwcnAwam03R29nb3J6U3dZVEpDalNoWFYvWnd4OUZ2bW1OTldrcmZzVzdZ?=
 =?utf-8?B?Q3JKY1YvREwyR25jeUN1YTlka2VDUXoxY1FSKzEvblRpVHp4OGVyVVI4djAv?=
 =?utf-8?B?cXFZYlJ2Q3JmbFZVUlVLeUVQdHR0Y0xwekk2M0FVZFhSUXo4VXdOOEZJcUtU?=
 =?utf-8?B?QVQ4eWljWi9hSVBwa3R5ZkV0a3hxcVdIWUZXQm9iQWZyd29OQ3VCRW05ZERh?=
 =?utf-8?B?bml6VE1RNFV5a1J5VUx6OW9CTW9BeDNQRGNwMXQyc053L3I0VkVGZ0ErZitE?=
 =?utf-8?B?VUVCZ2V5TTM2ZkNIZlhCT2djblcwdnhNTlUvdDBoMTEzV0gxT2RpNDJVczRV?=
 =?utf-8?B?V01jU0xPc2VXMkoyUjhlM3FkdGMyUi9ZL3dpMllGQm1SbmwrTEYvZnJEbDRF?=
 =?utf-8?B?NzB5NVlRSllRbmFkZU9PZkpWUXJWMmVOTmEvNHNBaHA3c2Fkd1ppQUx4VldK?=
 =?utf-8?B?bVdKbDVOYktLb0F6ckczcy9jRzVQSnk2Qkc1Z21xZzBKQStjbmVRTnZ4cWlO?=
 =?utf-8?B?eElCNnNKU25nT0hUaWxkSTBYWXZHajZMNXVxV3hDcnFmcWlPN2pqOGo1ZktE?=
 =?utf-8?B?YUljY0J4TzRxQ1E4ZU1ZeGdtckNSeTRlaXpQNHVQUStEVjhzaGluemZpVjg2?=
 =?utf-8?B?ZWZQbCs1eCtnR2FZSy8wUWFJdkEyUDdKQStWMXM0NGdzVUtNQVp5WVp6STB0?=
 =?utf-8?B?TDJac2oxNGxPcTBZVGlNWGd2MXcreEtJb2hmTEJST2VOSlBQVEswL2ZmUDBI?=
 =?utf-8?B?R1ZrUXkzSEJTV25xZjh1dW9PTW1PK1VmM21VWU9xK0xoNG1ZbU14VTRqZ01K?=
 =?utf-8?B?aFdhbGcrRHpNVS8xZUZ1aUUwMzBqTWVraUYxNkxoQ3orVjNGZ3NSV21xSEN0?=
 =?utf-8?B?dkNRaGJhamROOWVaNUQrY1FWbG1yWjE5Y2RhOHJPbDhrNSsraldLMnJjUmVu?=
 =?utf-8?B?bFdaNU5VQ3lUR2VmdlMxNitRWlloZHhEcHlNR3R4WUUyOHBWRTNwWVdRT1U2?=
 =?utf-8?B?eWVqM1FGK3oveWxEekplTWg0WHl3SGxHZklJU2dWOEtrZENaeEZvdU1HVm1x?=
 =?utf-8?B?cjhvVHlOWkV5aSt0d1NRK2JvMWZDTC9Va3IyaElOMVNEU1VIdFVCSXkwNlUw?=
 =?utf-8?B?dVdIcFZTc0JmaDNaZFFWV0dSUE0zNFdmdW1Jb2lpR2g5Vkt0bXJabUtkajNx?=
 =?utf-8?B?U0o2aXNaRWU3SVV2L0t2V1ZRa2VPVi9tQ3ZEMUxjYkx5TnRuU2RiczNPTDdt?=
 =?utf-8?B?RUF4RjRHUk1FN0tzM2hpbDJWc0JTS1FHQlJYc20weFczd2VNYjRTYXVTSUUv?=
 =?utf-8?Q?T35kEVg9Vit2asez51EuVKs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6161BB061725149A420A7C8402A2174@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b44a4c4-f095-4009-ac91-08dd9ede84fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 18:27:50.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNLEVlFouBoW1j4DQNohLhkQ1PabsPkVWd4QXl2GJ0PxnFnjuEIk82/ZhBU1ypDwkEUIHgtX78bQYxcnMv/0gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5678
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=6838a729 cx=c_pps p=wCmvBT1CAAAA:8 a=c9IIyrluMGCWEcvjLZMSIg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=1WtWmnkvAAAA:8 a=SYwEjaAwvO_-fa4-q80A:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE3NSBTYWx0ZWRfX8dqJq2n6cAhF 9/LhoLF+M8vE5eu2kTql+CkHEKrqHvBbdE/WwHi1o1rJuuglHP3SAs7gapeq25W72Pp4fNHVsij 8abXEy78M8OZnt2Jy+ar85aEsz0ng8IdXDi+nTrtSlJjfbEsDM+pRWrc3nHMRkOms1x6KHdd9vb
 rfsno4hYTGAr/fAnnyqVLkClC36fmwqqWNLWzt8Q96uJM2szhUvnlypIQ1tQ7pE22MwL3beSNZk HBDCpAkPQjrzutaOiVeYTLRO84xHzfLAKsinChpPMCfaRdRFVBTMqn/kW/VuvvPb7H3R/+U0iQX qO+wkcUX8LBTefFddiZPY3FYeD7Ud3tn7zaXX+7BYgU9dYnR1W6jpZCqFPYMOJzSyIbnvXSt8uk
 r/gK2SvZrwslaHR4XFdPAt7BdP+o8yEnF9M8ChcqvBaRUhSeGCjSvgSWfvjiqcHa3RmdDEgG
X-Proofpoint-GUID: 3sOspnDoBV3FdQI-G4f4Rd1rsoNXlU6m
X-Proofpoint-ORIG-GUID: 3sOspnDoBV3FdQI-G4f4Rd1rsoNXlU6m
Subject: Re:  [PATCH 1/2] hfsplus: make splice write available again
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam authscore=99 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290175

T24gVGh1LCAyMDI1LTA1LTI5IGF0IDA4OjAwIC0wNjAwLCBZYW5ndGFvIExpIHdyb3RlOg0KPiBT
aW5jZSA1LjEwLCBzcGxpY2UoKSBvciBzZW5kZmlsZSgpIHJldHVybiBFSU5WQUwuIFRoaXMgd2Fz
DQo+IGNhdXNlZCBieSBjb21taXQgMzZlMmM3NDIxZjAyICgiZnM6IGRvbid0IGFsbG93IHNwbGlj
ZSByZWFkL3dyaXRlDQo+IHdpdGhvdXQgZXhwbGljaXQgb3BzIikuDQo+IA0KPiBUaGlzIHBhdGNo
IGluaXRpYWxpemVzIHRoZSBzcGxpY2Vfd3JpdGUgZmllbGQgaW4gZmlsZV9vcGVyYXRpb25zLCBs
aWtlDQo+IG1vc3QgZmlsZSBzeXN0ZW1zIGRvLCB0byByZXN0b3JlIHRoZSBmdW5jdGlvbmFsaXR5
Lg0KPiANCj4gRml4ZXM6IDM2ZTJjNzQyMWYwMiAoImZzOiBkb24ndCBhbGxvdyBzcGxpY2UgcmVh
ZC93cml0ZSB3aXRob3V0IGV4cGxpY2l0IG9wcyIpDQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8g
TGkgPGZyYW5rLmxpQHZpdm8uY29tPg0KPiAtLS0NCj4gIGZzL2hmc3BsdXMvaW5vZGUuYyB8IDEg
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZnMvaGZzcGx1cy9pbm9kZS5jIGIvZnMvaGZzcGx1cy9pbm9kZS5jDQo+IGluZGV4IGYzMzFlOTU3
NDIxNy4uYzg1YjU4MDJlYzBmIDEwMDY0NA0KPiAtLS0gYS9mcy9oZnNwbHVzL2lub2RlLmMNCj4g
KysrIGIvZnMvaGZzcGx1cy9pbm9kZS5jDQo+IEBAIC0zNjgsNiArMzY4LDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgaGZzcGx1c19maWxlX29wZXJhdGlvbnMgPSB7DQo+
ICAJLndyaXRlX2l0ZXIJPSBnZW5lcmljX2ZpbGVfd3JpdGVfaXRlciwNCj4gIAkubW1hcAkJPSBn
ZW5lcmljX2ZpbGVfbW1hcCwNCj4gIAkuc3BsaWNlX3JlYWQJPSBmaWxlbWFwX3NwbGljZV9yZWFk
LA0KPiArCS5zcGxpY2Vfd3JpdGUJPSBpdGVyX2ZpbGVfc3BsaWNlX3dyaXRlLA0KPiAgCS5mc3lu
YwkJPSBoZnNwbHVzX2ZpbGVfZnN5bmMsDQo+ICAJLm9wZW4JCT0gaGZzcGx1c19maWxlX29wZW4s
DQo+ICAJLnJlbGVhc2UJPSBoZnNwbHVzX2ZpbGVfcmVsZWFzZSwNCg0KTWFrZXMgc2Vuc2UuDQoN
ClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KDQpU
aGFua3MsDQpTbGF2YS4NCg==

