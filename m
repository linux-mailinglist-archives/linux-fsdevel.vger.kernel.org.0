Return-Path: <linux-fsdevel+bounces-50860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63075AD07C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 19:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A6D3B0F47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B95924DD0E;
	Fri,  6 Jun 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a6Dk/kvw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F20BA38
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232365; cv=fail; b=t82y81uqeQdjkk4IiaMVDkX0wDp9M8Wscx3fjGAr9CbtJ60tA8oaEJysRivSDJ7QsML37IWALAUUyvHb6Fk2vkIfyBk71Rw87Ig75tMN0rRyvxYHDam3/kfQmvwhzrrGKdJXLkxFsj2oZ/lfz6t+yJW23o5cI4zC4PbcMmCc0ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232365; c=relaxed/simple;
	bh=bNYzwWXv7STGki7BPPfcN0XqsPbPiaVGhTZK3zKvjF0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Ebu/b4XcEjOpkLjUMQEcbDGef4Y0NcIfQB0hRUyo2zqteSanyXY+Y2H3AKIDI/eQu1E5uG/D1lwc8PTtb4ADzctEfh7J/X/OkK1N9PhGmTztZWJpuR8pC8hns3ROU1lyx53SloLiZPwr3VsmIsD8u6AGUZylINX7Lln9wTAApr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a6Dk/kvw; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556EMpSQ000624
	for <linux-fsdevel@vger.kernel.org>; Fri, 6 Jun 2025 17:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=bNYzwWXv7STGki7BPPfcN0XqsPbPiaVGhTZK3zKvjF0=; b=a6Dk/kvw
	hTgOwpBU9dYE9mG8nMZslwyI44/+Oh1pss3TD1Ak/psrMydTkI/rOy9BQcCiOWRf
	S+bL1oF5ppYdD4kPNJBr603UcKY63/cCYeqoiUX9zj94mjFCpdHzVtNGasmfb6bq
	q1IRzrWw8lQ8lRvdAIT6sVrVwKGVhsGUAn7irNCkQ9tSVQDYmgu2rXf07/ESEI4s
	CBzYb5oLZMVxHKNjc71IBpEFqu413mdjUKRYWwfr3HNU/Pppp94Rg/NNJCmRR/9H
	Stj9sjSNOTY1Nt1LYtP/gp0FT5bus4x3mucZAh5NPiwDgPbKB8wyBlzPf3MzoEfi
	/km/Mh6nxFmaWg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 473j1y5199-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 17:52:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 556HqgJb005546;
	Fri, 6 Jun 2025 17:52:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 473j1y5195-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 17:52:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOHLkwm7DdBvtvohpKZHCjfggKP9LGuh26ODchNNAs7NdTAGWSKuqWjpIXeHgTP6FU/BgtinTPIEBEw57EUX8Tc6/kM3YUhGGRDBzthRd0usD/xz2gZiC4pmtjhq9SXPqZkBxiCkR+JB+iJG0cYbbUIfXtmXpUuWGys1reUn3gzQ1YLcGMFFTtej/6dZMb9jDvHZ5BPjnEijfuKtc7i1CufwyXNufz1I0h1GEpp+eIJoG7adcGIlV3sIvLh+T9aIpfvciLTlNhDE008yhP6zM5rNFFKVpsqTIn+hnM4D2CEgCR30u1KtwwxB02mS2GZpKSwtUCpAvqG6y8Hn5sxijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xcm/gCcgWhHxXdCY1WZcT30g1gHBbK0Yq/c5tgykN1I=;
 b=C37tjyaZ0KAp5F+7XMHpEWJHy3/kyiN/9AngSbECrki0RHlfxO4OQuFAd42RCwgOjuMu6yBBNTJLDXZI5YyDS6BvvMbXvgemx8riLDGoCrFwgerGrpUjY92pQqINO43lxYaRTt9kr/nTTEN8bICWfoejvn4u/lyBdGAfGT/LvI2zYoYHU6iOUKvdNr7aY69RiYuVbb6kRofu16+WLNiosB2dSvYrs2eG7h0cmgGWcrPeqe/EcwtffK6vqkUAqSVp572w6KSWXsOTHDqb/QEVAsc631TKdx5ErCkyf5iRyIlsAcIatmpHoOQymu3GYz524ybOsS0pJ7SnKHv3OqgQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6213.namprd15.prod.outlook.com (2603:10b6:610:159::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 17:52:39 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 17:52:39 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [HFS] generic/740 failure details
Thread-Index: AQHb1msKldMSRfJNPkiVh/gHk+GTk7P1rGkAgAC+V4A=
Date: Fri, 6 Jun 2025 17:52:39 +0000
Message-ID: <33619f01e6d14d54b1f49890ff25e771db2fcedf.camel@ibm.com>
References: <ab5b979190e7e1019c010196a1990b278770b07f.camel@ibm.com>
	 <7d3c595141e8ce70e0dd4b0b6fe28bfc7649bd2b.camel@physik.fu-berlin.de>
In-Reply-To:
 <7d3c595141e8ce70e0dd4b0b6fe28bfc7649bd2b.camel@physik.fu-berlin.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6213:EE_
x-ms-office365-filtering-correlation-id: c6fb7b32-634d-4c88-b95c-08dda522ee05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFRkV2ptZktrRjhMdlVVL1BQMnJLSWROKzZ0RCtENEllaE9SUzlVMGh4bFhp?=
 =?utf-8?B?c3VENkJWYXRRbE44MFdEYVlLRmVyZ1pPVHB5TnJZbUs0TW9xSzdpVnVSMnB0?=
 =?utf-8?B?SklDd3pxNzlGRTJmT0xNRjRQUnlBZXJYOWMxRmVwTW5LSjFwcjhpdUs2VFNw?=
 =?utf-8?B?QjhWQWl6YnpUbVZZWkxONnAyaXZlNE5sd29MbnBSSWtKWWtZZ05BUEl2elor?=
 =?utf-8?B?dksyT09MbkhlSmFpZHZRNWxhdkMxSDRNK2hjNjB5NUVwY3laUUJmeVJjSGow?=
 =?utf-8?B?ODllWlNrYmFvWXFTNUdCUWJmUzBrTU9EYWVrUXRuTkZMcS91N2NRR0wyN0VX?=
 =?utf-8?B?NSttMEcwZTIvY0dUVXcvdWh1aVFFVzkvc1VEN3JZTS9jc3FtZkdJcFFiY0pz?=
 =?utf-8?B?azRJTG1wT2REaXdOL0ZhaGx3aXYxUmpuVFl5eVdTN2J4TzQ1bGlTL0dydGxZ?=
 =?utf-8?B?anQwME43Y0pUMmdqKzF4c2RrT28rOEVWNVMrQWpqZXVsbytHZ2M3YmR6bUFK?=
 =?utf-8?B?TmNId1Zpd1dTaHU0TklaSTBnem1JZ2NPdXp6dGxFc3NKUHF6S09Za2R2d254?=
 =?utf-8?B?Z01zNEVQaHVLY21uRjdtZEc0L3FkU1BvN0FJYjVIUGdxTlg2M0FtVDQrOVdU?=
 =?utf-8?B?REpuMGNVbWowdjBpN1dwSWd5eVVIcHFRUDVrN2tqekJBU2d1NGlPdkJ2dVZ2?=
 =?utf-8?B?MEV4V1cwWDR5dGgvdHZHWGRyZEFHNmM0UnZ6OHpIVVY2SXVLZ21rRUdxY3Y4?=
 =?utf-8?B?c3JBMGwwZTM5UkRkUHRsejd2Z3RRNzB6d0k4VU5maGNra1l4NFhnS2RLQjdH?=
 =?utf-8?B?VTE5ZE00NFBUUk9TbVZpS2JpR0QxcklZdWFVeDVMckZLNXkyb0hWZ05Wckkz?=
 =?utf-8?B?OE9zRGgxeVRQdVMxb3VQNjB2ajN6NkFWZVhwV25vem5Dd3NFMmh4R09JdUUz?=
 =?utf-8?B?dVpjKy9RVzg2Q2FHNlVYb2FtUElrVzlwSTlYUm9CVUFwSk1BbkxrRFIyR3lo?=
 =?utf-8?B?T1dMZUNCNEhDbEZNaVRQbU5IYWMxYzdjdkpuZnJRODA1VmVHSjVzbjJyZ1hL?=
 =?utf-8?B?QitwMWV0RlcwVURuWVE1dm1yWEZzbDFiK01wY2dGdmdjM1c3TjUySWZ3UWZ6?=
 =?utf-8?B?ZWZ1WTZsZTVNVnlxYStHZHFlc3pRZHJTSllrK0Jnd0ZOeThFcSsxREk1ZGR0?=
 =?utf-8?B?OThpRnlnSzlyVVZ2bEpzMllwTmFCTG14Z0dZaHdZa2V6VjhoemtxbUxHTzBm?=
 =?utf-8?B?aVlySzVZUUo4Yjl4dWRpanFqZkhuQXdKbzA5QUh4TXZObTNHQW1KT0Q5TVAw?=
 =?utf-8?B?cWNsY2NqVlRpdFdod1V4WnRhLzRGQmVqYnRrbVo1NVRuMVJzVXpaNHRkTEY1?=
 =?utf-8?B?MWZlU0tnYWg3K1NncFhQeE9MTFNzSVVJS2tueW9sclNsVTB2OEUwYVlkdzZp?=
 =?utf-8?B?SjRNWjhYWmRtdThsS1Fqc3Zrdk92MEZFb2JMZzRwTjZCWlhJbzUybFJCRVFs?=
 =?utf-8?B?Tjd3SUo2VUpwMCsyUUttTXcxNTJPVHlacmpDMzh4MnVGM21PUmZBV3RKSlpE?=
 =?utf-8?B?NEZKSytFenFLcEo2OU8rQUFtRUxtNlVSQytnU0VlRkZJSXFFc3JaUWxzdnZU?=
 =?utf-8?B?djFVYllxdHNPZzV6cDNvUFQ4NVpZUnF2YUE2TXhtNWJPVGw5cDVQV0dhTkpw?=
 =?utf-8?B?S21PYWtaVU1uUWozdStuQkROMWVEZHF2eDVlTjRYQ1NhSHZvVGZJd0UzbTJn?=
 =?utf-8?B?SnQvcVhkZmdCcDUxbWlhUXZLVHlMRHRsc2hqNE9ZZDNPQk5JMGNUYTZqaWgz?=
 =?utf-8?B?ckcrZDNpTStVZWo3OHB1d1ZsZHFrc0wyYkw4YzV0NXgvNnBPbVRkZW91ekRO?=
 =?utf-8?B?T3l6SjJIMkl1RkRON2JzQ20wVisyODRmTitmRFI2c2Q0aHZmaXIzMnFQSW9J?=
 =?utf-8?B?bUl6UlI5ZkVSNGVUcFN0WUtWQ0llTWM2MXFmcHIwNlZadW5jS3JWQlFuSTM3?=
 =?utf-8?Q?SlRORpLD5nK4vBzLTukPSkpTTE95Y0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGRsS0pvT2x1R1kydXBQSVYxVWdIdmtSTUY4SUFJTFBYR2w2Zm1qWTM2WGV3?=
 =?utf-8?B?SVcyd04xbFlHWmp2ODRVcWFsYkREcWRQTmoybUU0a0MrUnVuWUtGZEtjSVdR?=
 =?utf-8?B?aDBrWTBzdUtITm9tKzlKcGFoZTloRzllWEU0S1ZHb0tKWkd1UnVQZ2FydStz?=
 =?utf-8?B?SlpiQVdGejBEcXhpcU9OMUNNZmMxSFBRK0JqL3poaG1WVk9DQXpFWU9HaGta?=
 =?utf-8?B?Y2NtK2c1N1pXU2p4aXZmcTljSkFvUXZlc2NlU0tvZDFBbWFXVEt4Vko4SGt4?=
 =?utf-8?B?RitjVE0xM1ZSMnhxZmtGelNOZUxRZUh6aUdCSFFYTmV2RGZUdWFnS3A5eUpF?=
 =?utf-8?B?OFo4QVN3TVZWcThGL1pIbG5ZSDRrbHVUbFB0OE8rWEdLc3lzUkkxZVRTZWJR?=
 =?utf-8?B?Z3kxakF0UGM2TEpRUUFyODZrZnVxOTdZUVh3cEFRYzNZNFBHeGZvdGc0akdo?=
 =?utf-8?B?WEhKeDJ3dFNoY25yM2xBMlJLNHVueVFYYmV6ckNNbS9QTU9Na1VHazM0K1dY?=
 =?utf-8?B?aUd6L0pyREFGZmVFWkxCUEF1Y1NId09GS08zNzZKcFNkTFA1THhsTnVLUWxu?=
 =?utf-8?B?WDJ3UGVLWVU5SFAzMWNUdXJrNkhzUXhCZTNwZ3BvK05ETzNuejdaYzdseHNx?=
 =?utf-8?B?dTd2RVdwNDYzZU1MQWlNYzVTb0RJcTEvMldSM2ZrcklTbTAxVnBSMUxXVUhn?=
 =?utf-8?B?dWdSUFIwbUZOVlE2QWt4ZDA0UFJ5WGcyQUt5eGlXVHAwTE5LWVJIMUFWMkVu?=
 =?utf-8?B?b0tEbW1mSkpNS24yK09PZzFHWUh3a21OSkZmS3pmWmpZZ1RlTGgwalo3eGpI?=
 =?utf-8?B?RmFyMVBqRnl2TkxIbzlVOXR4bit4R21jUU5VMjN4cUFNK2hvZWI4TzAvanZC?=
 =?utf-8?B?S2R6akNwTWV0VjczeDc5UmhTL0p2dXFtSGM3MmVCTjlUVUt2RWs4V1MvS1lS?=
 =?utf-8?B?NXUzSk1oTUJWSnVrM2luZnhQcldqeFVPUE43bU0zZk9oeXIvUENYUFkwMjQ3?=
 =?utf-8?B?bGF4ZTN3Rzg3clpzaDZzUG00a3dvUjg0MSsvV3U0dzFUU0hNVHNSUVBlcTkw?=
 =?utf-8?B?TGxuY2FkRUxpNnZFS1VsRCtod20wY2xmODJKUlR4MlFCQkhja21NbG5ieldR?=
 =?utf-8?B?WlNVemk2d3ZsQlBvRkM2L3FsT1hzc0VLYm9hYVFnNVRlemhYMGhBWTA4TTQ4?=
 =?utf-8?B?emNEakVqVjBjUTIzYkJFS2NrMHJNdDBDNlYydG5LeVFHU25ERzM1bHNQdVFD?=
 =?utf-8?B?WkF6em1tTGF5cTBZTTNyVDBWb3kwREUwKy9sYlZmTXBEcVlaY3pGOUhvWktC?=
 =?utf-8?B?TmRmWUJWeEJ2OENjdFk2b3dzVHlINlpVblNlZ2N2SjM2b0JpMktSbUFIdzdi?=
 =?utf-8?B?dUJSemVtak1vRzBtQm1VdnJzNHQreExlTE9VVE9NeUFnZHhWS1pVMzdPRk5E?=
 =?utf-8?B?Zy81NllacGNGcEZ3ZmViaGNTUE1VQ1lGTUVBYUZxbytuZWV1by9FNGR4U0di?=
 =?utf-8?B?ZUVtWEYycU1nM294SkppamttVFhHOHo3eGlmK3p6aENtbm8wUThzS0VtZTNi?=
 =?utf-8?B?Q1JVODROV2VGK0FBL2JRZmRycEt0a1hQcU44QWJxWU9uZGRBaFBYb2tVcE1v?=
 =?utf-8?B?VFU0RDZYUUJ0bmJ4Unh0VWNVcmlvekpiV2xNdDJERHJrSkpWTEJlYVJ6a0NN?=
 =?utf-8?B?MVRoSFNjWnQ3Z0xGN1VMcTlXanRoeHVLT2FxUEowZU1idVREOXNaV2NrSEpw?=
 =?utf-8?B?OUl2TUlnUnR1YU5yRVlTbGZNYWRkTElrRW13OUF2b2poMlV1ZllFNzJCcDlI?=
 =?utf-8?B?YWlacjcwalg1TThIdkdTNDFrZkZrUFdSU2FFVDhvTkNpS01XenV2aTFjUk03?=
 =?utf-8?B?RStwS2VzMUNlQmZETWlzbnlMcWlXUXp3OFNaWHV2U0xOdnZCcnUrZUlkVFpz?=
 =?utf-8?B?dDhHMWxVOE50a3FaZFdrTEFsTFlBUmx5dE81WUFqaFlGTG9xazFNWWx5SWhF?=
 =?utf-8?B?MVo2NVViU3BWMWgvMlViQTNYdmVTcU5Bd09DNm5pVmZlTkRtaHk3TUlGVWJG?=
 =?utf-8?B?ZWZCeU1kUnhUbjIwRWdZeU9aWnVNLzJENm1KcjBRNVRsMFZXYkVoZFpwNFdU?=
 =?utf-8?B?RGpkQ3A1SitBbzBPeUgwdHp1M3BUdXFQK2YvUmFPK0s3cmJaZEU5TGNLK0Mx?=
 =?utf-8?Q?3cZ1l21XDxMeFd0b8wulN8s=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fb7b32-634d-4c88-b95c-08dda522ee05
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 17:52:39.7233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5saNNi4L65SD0zuNDfJo6fsk/MqCoiLUw7NXrvf+5zoDSa75YffpRWL2Y5lj+FNNYW8Aoz6vdcdRRfygOt+ayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6213
X-Authority-Analysis: v=2.4 cv=Nezm13D4 c=1 sm=1 tr=0 ts=68432aea cx=c_pps a=r7BTcVhh5lrtolT442nWtA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=B30_CLukhxq_nLhb0JQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YzyHSZx9TkawISNPHI_-9OIKJGY9dZ0Y
X-Proofpoint-ORIG-GUID: YzyHSZx9TkawISNPHI_-9OIKJGY9dZ0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE1NSBTYWx0ZWRfX70VLXlj6t1eG qPEARzVyQQh60gMgCtKrTF5xWGRQNj9MOlsuoarzj+t8qBc28PRrgjlNpvzw3aNNV8DQ5MMEK6u nsDqgHtce6YSIeNb28r5PjST8FQhxfsdYPvhw5kprsqYb2oVmHY+sCrzehZiqI768gQz8Tqupch
 OrVf9DbyCHazUW1XknZyjNPB23W/IR5cf0LQvcK5SJLvq6iGnchPIc4G8E16QG04fFDh6/CmO+T tHWQd30ypLfWjnVLvukxMO1djDQO5CDh6ssxhQUcHJAoGTBOrTN2Oa8IPOcAxMTaiELGbfBiHPi o1MYP4nyfVW4dP8D6IWzy/TsXWVaEKf8CCRpmHzVFJvddrxEdM1vceU+UdSSC8gAUM2xsBhLkHU
 kdGh9P6awk24KwmiGdwVWT3Jos8Xvf+B2iOKBoS8lNg9tmXcwe5UkHpoKFhOSQm1UZ5UK4Xe
Content-Type: text/plain; charset="utf-8"
Content-ID: <95DD66ED6C7FFF418B31CAC36932FD32@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [HFS] generic/740 failure details
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2506060155

Hi Adrian,

On Fri, 2025-06-06 at 08:31 +0200, John Paul Adrian Glaubitz wrote:
> Hi Slava,
>=20
> On Thu, 2025-06-05 at 22:41 +0000, Viacheslav Dubeyko wrote:
> > It looks like we need to modify the HFS/HFS+ mkfs tool to refuse the re=
format of
> > existing file system and to add the forcing option.
> >=20
> > Adrian, How does it feasible such modification?
>=20
> It would be certainly possible although we would deviate from what Apple
> does upstream with their hfs utilities. I'll add an issue in my repository
> for hfs for Linux [1].
>=20

Could we suggest this option for Apple's repository? Or is HFS tool's code
already obsolete for Apple?

Anyway, we need to have this option. Otherwise, it's too easy to destroy the
existing file system by mistake.

Feel free to assign [1,2] issues for yourself. :)

Thanks,
Slava.

> Adrian
>=20
> > [1] https://github.com/glaubitz/hfs/tree/linux =20

[1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/74
[2] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/215

