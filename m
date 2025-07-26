Return-Path: <linux-fsdevel+bounces-56075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD60B129FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48A27AD04D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD24225408;
	Sat, 26 Jul 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KOTDFG16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC212259C;
	Sat, 26 Jul 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753523536; cv=fail; b=kM5LmFjF/bNZBHrfRdjVyT/qoXcygeimfaHoB4YxEsBe0q2jvUFmDuqk2QPT/G2jeBrfpEbk0P9OKmQzfH4DpqYkSJoinkNxOF+r1W57vt6W9zTqIKNuqKLYqEejjnou8WXBJnMdOE1tEOUEUAUZr+7c0xmQ8vSwFxzwJ1UrBAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753523536; c=relaxed/simple;
	bh=6jL4v23CtNyhThshUoDLvwRJ/r25sZhklI85t7tUzR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YeysMO8oJcMQcai0Lc29CYCB4PrZVnp4XfAp/LIhe2TItpQMtLRaRR//rL7oeNjAQ+PrqTqDvHYRrBOlpfG+Wbm3Zlo+jDheuFwj4gw8Ubh6IPvrJ86tZiohRBeCNP81L6Zaa4ZRXXjIWX3YadEOd8eLsArcTpAdgxTb7gMD6bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KOTDFG16; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q7xsi9017527;
	Sat, 26 Jul 2025 02:52:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=6jL4v23CtNyhThshUoDLvwRJ/r25sZhklI85t7tUzR8=; b=
	KOTDFG16tfOEuXf+xRO21WKoQFP9eQXssa+LuLmvNtMvlkMExd5YiMNQ/Qahle2q
	bd+BwEdNDMcmHhCdUoArPjH1n7wOIkkgPTzr8PIeNi5cRM9jwPEupesXrkb5fra6
	k1B7+VeS9b03gDV/smHGx4wSviFUf0KTvhvQHGn9RkwH4BF//pVr5W9V+fEw8WNe
	1AbTKRj6slwlh2PJENKs9jCQ5JDGCvVuMIFtrhJoJMvP6uTo54QFD3nvAL0NTf75
	SVbSBsaSvDIpZKH+QejD6ePzAWkA+NCQgKqrcW0rhFArbSQAyDYn8c8TBNT1aIr8
	LmY0FeE2Hswq0W3Sw4RuFg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 484u318byj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Jul 2025 02:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRvNoFgtmTsrfoyblChPktffQoxq29Ier/fHz11ccV+pBIcTTiy2bPA4GKDRZFsYj0eskT+jHsizKktooI+KFq7InXQpjOf1TL2HvF0sGmXzJYUS4/glGtYq30QAbUHTr6wQpUGRq7ggjDqE2h5Nq1Vxxs01vFp6eG2j+L3TTM/HzVH9Aso4Ma6h7ehVBwNI9N7jGdVBfTZyKp/qVImmUWTwLyboUzzWSuwbBnLwOEzGjsU5GbS5m3U+ZMCDlfkdVOyEyYi6+Op7stASb/UoIpr7y8bgjnOaV5ZJFFj1LjNtI3emyAf6DNUW1N3dbNZhNHtEQxcvZT9D7nSm9V5/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jL4v23CtNyhThshUoDLvwRJ/r25sZhklI85t7tUzR8=;
 b=s3c8DARp/prUnjMQyzCbfp+EcSs9gMRdU3d/562WGNrYtnqCp+L+jMQUuQpZnaO0X57jmPcMrUx7BGXc4wpIQ94VOHAg7XhXoHTjDcdjZTz806gwFJZKwSdPGOrl7HIuD8mJgsm56QbDQDm47nS16xq96q22lFcYFofL0kkuja6CCKFWZizXi6Eg/7XpyGV+2EyZZNHWd/wwe4GlOUsy+m4yWIVrZeDTk2oGneLzfIpkA22zTZZe/+eW5AFUlPRL8BG1DY3Vwp+Po5bM9dPXrPtf4ekqsuWLDA8tnO/kQ3LpWlJlvpv2Mh/4MPbpw+tg/1goDXWgojTuRKmb5tMSYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW5PR15MB5265.namprd15.prod.outlook.com (2603:10b6:303:1a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Sat, 26 Jul
 2025 09:52:06 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8964.023; Sat, 26 Jul 2025
 09:52:06 +0000
From: Song Liu <songliubraving@meta.com>
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
        Tingmao Wang <m@maowtm.org>, Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>,
        Jann Horn
	<jannh@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToCAAEtZgIAARLiAgACMg4CAEH8tgIAACIOAgAB+hYCAAvcGAIAAF8IAgABRvgCAAAcpAIAAI/SAgABcBICABz+ngIAPe6EAgAKjAwA=
Date: Sat, 26 Jul 2025 09:52:06 +0000
Message-ID: <647DB2A9-54C6-4919-BEDD-17E5D1460575@meta.com>
References: <474C8D99-6946-4CFF-A925-157329879DA9@meta.com>
 <175210911389.2234665.8053137657588792026@noble.neil.brown.name>
 <B33A07A6-6133-486D-B333-970E1C4C5CA3@meta.com>
 <2243B959-AA11-4D24-A6D0-0598E244BE3E@meta.com>
 <20250724.ij7AhF9quoow@digikod.net>
In-Reply-To: <20250724.ij7AhF9quoow@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW5PR15MB5265:EE_
x-ms-office365-filtering-correlation-id: 8f3276d8-2232-49a4-ae81-08ddcc2a147e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0pjdHhSemgvbDJXUHU3NXU3ZW1ZSjhOU2JQZVhyL001QjU4T1hacE9icEkr?=
 =?utf-8?B?MWM1S2xQYkFJU1BMWkpOb1RNZzhNOUJ4eDcveUVxQ0l0YWZubmxJWndrZThZ?=
 =?utf-8?B?ODU4SXRjalhPQVd4L296ek9EMXlLeU5CNEpjc0VKeS83c1Q0bjQ0RVRFUFU3?=
 =?utf-8?B?bTR1VVBSN2VndlhkUG9icndqYk9ocjRmVzkrcG9xQ1pVNG5yaFhWRVZMVk52?=
 =?utf-8?B?U2RrQ1VPclFuMFNIM0pXSjFpS0d1NmFnT0trZEsrZzRQUDUrcjQ5ZGpYRjAy?=
 =?utf-8?B?VVlJemdqc0lZK2FSYnZBQnZiRUZ6NmJES2wrQjduVGU0WExHUHhzZ05zUWxn?=
 =?utf-8?B?aWUxcWRrc2RZOGRxdmVzc2t2WUlQbCttSFBpTnNWelE2WE04SFhRU2VTR1ZU?=
 =?utf-8?B?SjlrQ1YvTHVLQVFCcHFJUVVsSVpaQXJCT3NaVlVielVuMXM2aUZEWlhvWm5Q?=
 =?utf-8?B?M1BqZ1FBMDBRblh2UGNMc3FzVURSVmNpM3ZvNUxmR0hJL0owZGpVTFlnWVhG?=
 =?utf-8?B?N3JQdmJiNUYyTEFmcW93QTBPNDBnTC85aW9yRmpqMzJIK2lEM2VlWUd1eWRx?=
 =?utf-8?B?Qmo0d21jdWRuWUJGbm82Slo4WDVhdW5PYnpTUzFlU0MzK0VJZy9VUHppNk9E?=
 =?utf-8?B?NHhjVUdHRDlGMTUwTW0wRVc5MTR5dzY4NkllYzhnT2VNV0tFS0d0WXdmclZk?=
 =?utf-8?B?L3FEV1RqTS8yZDlwYUlNd2UxWGhWNy9BNHFLMVhncTJmYjM0cVJwV3lrQ09U?=
 =?utf-8?B?dS83Y0NMNk1iQnJqOVJhM2ZqSW14TzQ5OUVSZXp2UVNnZ1dNYVJnUC9BdEtO?=
 =?utf-8?B?Nmc2eDdFWHZQbXVTZ00xa1ZxS3U2eXdhNE5LcUtvWlVZOFNsc3RCRFJYeDZx?=
 =?utf-8?B?M1pZT1lZbkRZeHpPczVCWWJXMGozcGFHd3FqWStqNU9RK1VZajNhV0dVd0tn?=
 =?utf-8?B?VHhsaVBCS3pyaHlCWUkzVDZNczA4M3dqRnRBUy9oTFArWVZiYjZBc2hhdUtP?=
 =?utf-8?B?NFBnQnFYNVZGcFFnWkhZSzhMRFZoV3YrNzRWZmtJL2xzWFEraWFxdUN2Lzd4?=
 =?utf-8?B?UnJHbjZIUm9vN3cxeCtmUUxjMGx2eXV0MTlFdjkyamJhcGwzMUFJMUtiby9r?=
 =?utf-8?B?Z0k2amIzdlNXMyswcnFVU2NXTDI4VGd6VHdFeG1qN1dPemdIbW5xN2Q1UWhT?=
 =?utf-8?B?QkdjSEdhc0EyaGhheW9NZlp2Z0IzN3pGbmxsb1pHdzZIQ2FrT2h3RTl0QlNZ?=
 =?utf-8?B?YUlKRS9PL2V6NXM3V3doc1BhZHcxZWNxRkFLb2g0NFJzS0RUbFRWazJDZ2Nh?=
 =?utf-8?B?M3RSV3BFVEt2NVE0ZW40WTVVNUN1dncyTTBUdGl1UXRrSXNCL3N3S2NxUFll?=
 =?utf-8?B?RXNNcElUT0JuaUtTM00wdWQza0ViY1lkUmM2QkJ3cit0bEdvTk9VSXpCRlJu?=
 =?utf-8?B?dTkvVlZRTndTUVFybDJEM1lkV0ZUWGlUdkVZMDY1eCtOYmpyTHIxc2N4OXNQ?=
 =?utf-8?B?czdjVUFGNitNUEIyaDU5SGFSMFZyenJhai9lVlpxdmpoemR6WThid2dDcXFl?=
 =?utf-8?B?Y05xRTdlMWxQb3RJbGRVSHBWbE5HN29NT0tISUdjWFUwMHlLTXlOak5uQnpC?=
 =?utf-8?B?RUlGbVJoeHNZRUVvT2tCYUd1eFZITytZeGtPa25TY3BtYXp6SVZtUmxydTFn?=
 =?utf-8?B?anBwWVYvNHJkN2hMQkpyRzQwSFhzQUFFTTU4alFDY0RFTkx0WEk2L0JURkls?=
 =?utf-8?B?QnRrZUgyY2JoZE03ZkpLMHdNek11MjBEUGtzRE1aV2ZaZjlmSCt5cGx1MVVz?=
 =?utf-8?B?SE03SjcxenIyQ0ZqTHVlWitNQmNQeEs1bFRRU25KUjBITVV1NDFNcXBRUkFV?=
 =?utf-8?B?TnkyWUtwRlFTVUdLdFlZcHc1SUphUUUxRHZ5RHdqWXk1bVJTeWZPd2hQRHY4?=
 =?utf-8?B?QlJiT3RWUHorWkFycXlLZGRITkZmYTY2YzVmVklLc0IwbjV6VDE0dkVSMS9x?=
 =?utf-8?B?MXAwY21IU2R3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGZMOUt5VjloRVdTOXc1dmViVmp6OEdwQjhFVFRQWWUwcnU0ZDBnaVZuS0Jx?=
 =?utf-8?B?dndIMTZkaDBVVFhoVUVJcWpvQ0VIZnhub2tCSy9PQ2hwYjhDeXlaU3EyUnhn?=
 =?utf-8?B?SThFblVLbkR1bUpWVGUwb1Bzbmt6bHV5ckg1L0lUUTZ0akloUHBSRThZTnZX?=
 =?utf-8?B?a1lZNkhoMzdJU2tSaG1lbkhnc3VWOVlRTjU4cFY0NS9sVHZOeEVFaGFUMmJS?=
 =?utf-8?B?WEUxdWQyVkhHdlBQOVFIZ3B0TlptdWxlMEpNVjZTeHVYa3hXREMxRVN1T1VN?=
 =?utf-8?B?NUtqUzA1cHE1cldKRllvclJreUM0cmFnZkcrRFhJelR4enVnMWIwdjBCbjNp?=
 =?utf-8?B?a3dQdHdIcjlMMGJEa003dDdFbEZxdHgzNXprakpKREVzZ2swa2lQYkMzUHZ0?=
 =?utf-8?B?eCtvaDRObWdId2pCYWMyNjJqdVVrdmxydTBqZ1diWHlIQ1NvcFdCbkJMeENS?=
 =?utf-8?B?UFFSSnhNZHo3b0dtenBlVk9XWkdpbDNnL0ZEVHk5ZkwvcnlDUXc5NUd5WE5P?=
 =?utf-8?B?RDZoZXg1OWZqVkU5ZnFyUk1oSEVzKzRRVzFjTEhMbjc4endDZVBKWTZ3Q0dS?=
 =?utf-8?B?YzVWWE4vR3pZKzc3RXJ3cEk0eXZidEp6aHUrdllzM0lZVWM4WGM3VmVKTlV3?=
 =?utf-8?B?MVRJUTBKU0RoWVFPM2NzZjJWRTF5YWhCRmM0UzQyc1ZCZy9TOHhJa2U5NlF1?=
 =?utf-8?B?bEx0Y3lkZVQzajZpN3BQMTUrckpMb0JYZU85QlNJbGc4K2lUNzBPdjFjbGda?=
 =?utf-8?B?bjF0U2JqbHV1UDF4eUdnVC9nSWwvMFprM1AvcEkxSzFlYnIxS2x6VWt5akJp?=
 =?utf-8?B?cUlSb1RjUDdCUWs2RDVldUJSRzFXK3RlWTVWdGJyQjZaL1J3Z1pIL2pidWNw?=
 =?utf-8?B?dndBTjl4YWFrR0JFZzNkZVlPSUlJOFNCZG5GUEtScFloUnhlQ0YzVko2Uk84?=
 =?utf-8?B?M1FjeFExV2VKVjFxR0xtamdxV0xHMmVnL1RFZDRlSXdSUXd5dzAxaHFuSFBl?=
 =?utf-8?B?N2hYTHU4THRZalF0OTAydS8xS2lsZ0NweHRPaHJuMkpxd1dBMnFGZGlnR3VE?=
 =?utf-8?B?R3A3YUVpWURGKzlnY016NEdTcnVKdWtCc2t4bTFreTQ2dEJlNy9EQWJPUmNh?=
 =?utf-8?B?SUwrM0RBcG40SzBJMDFXS1czdlhrY2IwTWZFaU40TWlaclQrOVNGNkVlUkpv?=
 =?utf-8?B?OVV5T0NGM29iUGNKcjBjR051QVFqT0kzb1dsaWJVT1g4TFRsRU00NlNleTB6?=
 =?utf-8?B?c0NKeEhvVDluZXhNUzIrcnQ2VjVscHQ1THFyWDFyRXdxSWtMUXBoMWtMQlFi?=
 =?utf-8?B?UDh3VkpNN0xGN0dxMzhtOUZpOXBzOUFwbjlNS2wvcTJvVGx5NmdEVGpUUTcv?=
 =?utf-8?B?V2tTVUd2ejA4S2VBeWlYczREMWRhVnE2NTN1RmpnU2hsd0Q0dWNEdWZqQlE3?=
 =?utf-8?B?L3c2M2ozK09obnZEc3NiZzlOaDMwM1I2bDduZ2t6VEwvQUlYQnZRZm9NYTBC?=
 =?utf-8?B?ZmMrVEhtWEdjTENFM3hKYXZnQTgxR1VvZEdIaW02TkdUalV5TUZaZ00xUEdO?=
 =?utf-8?B?UDVvQTBmY3JuUitYbnJ2ZUh4MUJTaXUzNU9NQ0hsQTRtZ2JOL1g4TG1Vd2ph?=
 =?utf-8?B?azVXMktxL2R3WW1QU2RXNnBCSjFwUWNoL1VxN3E2YnVaTmVEU2llcFpBOG83?=
 =?utf-8?B?cmdPZk9IQTBUWndjSytSUDIwV2FiSnFwOVhwUmhRb0VBZFBodVoyb2NYcUFV?=
 =?utf-8?B?VHROeDhrZVZJN1dHYUliSXZWakRmSUVHSW5UellCVTIzY1FFS0JRcDdwWnN1?=
 =?utf-8?B?bkhOL1pnU2FiOTJ6ODhpQjR2UTQxaTBIT1F0dmtHT3NjSkJnMTRPZVJOUlE3?=
 =?utf-8?B?REpES2MvdThQNFFNZG0vWjlUcUtHek90NUdMY0ZvU3dZa0RzSkZSSENaeDhI?=
 =?utf-8?B?dlRGNS9QY1M4YlBrakw0eDJHc1EycUZ0Vk9IanRxQTJuME5oU1hwbGFBWU5n?=
 =?utf-8?B?emVicFdDcXRYMEVjZEdxUDhjTUwvZ0NwMHN4VEgvTm5ncjhnMmlnRWFaTFF3?=
 =?utf-8?B?OVV0cDdDNVl1VW94Wjh6N0lFQzNoZXRiODNtZXRqUUMxZDVIUzlZV2FtYzEy?=
 =?utf-8?B?L0kxUnF6N2g0NzhUOWRuQjdaZlBIN3VLY2lCYXA1UjZGd2s3c1lFSTExR05L?=
 =?utf-8?Q?peGVZejHBLe6zLuJwXsSPIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51BE5E43E2EB714E8A3FF0051B7B1C89@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3276d8-2232-49a4-ae81-08ddcc2a147e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2025 09:52:06.0496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gz17heFyiP2EL9nhEfwtpGEueH88FiCM+3cRxeHK31XnVuPqfHcyuh0hcfKvneJTyKkX1cVY8HP9CqZL/pbBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5265
X-Proofpoint-GUID: 6QwXJ0DVLxDtmm34u9I18tJe8t7RJyY_
X-Authority-Analysis: v=2.4 cv=dbOA3WXe c=1 sm=1 tr=0 ts=6884a54d cx=c_pps a=1ly/hjOJrJf5cOyiiSJg0w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=edGIuiaXAAAA:8 a=QgdwMrkc3_hrlATfP9kA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=4kyDAASA-Eebq_PzFVE6:22
X-Proofpoint-ORIG-GUID: 6QwXJ0DVLxDtmm34u9I18tJe8t7RJyY_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDA4NiBTYWx0ZWRfX5iT743pQjG3l 4ABYhq7H2gknrDocWkn7Wm7L3/gyRdtqtva+3ZBqO/QhJ94DdXWG20rIa8KMbw0LizIZBxwuAvp gTyVh+Lglcj1mCchHddVyzJYg0VnBWKkeSlr5vlpKq+Ul9gdvKo47hUUp0ljiFgKR5uWuwvV694
 1IDs1DYLeBK/Z8x2Nak8/MjG2ahEAqCUrRHMoQcRFeIAccuUWU6AjbPQmCrpeWoquF9RX3DPQ+X AP9FyNqtsTd5MAaj6Lhwwlkk2lv6JjYGq/absw4DQzWAByyPYaD85sDADtnsKbwhl39hU6rrZ6V 82h6QGVoPco2KwEY1RKndKiK8SjSG4pwX6d4sVmdbnRGUTk0Oc59zg6jaWWKDXoy+zVLpymzjXt
 CWremTeKJmGBRnYFFQ2SmIebbR3QUbnga1rONGgKCYj9Gmb4LP9CuTFTA+u70c0YiiBOo/3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_02,2025-07-24_01,2025-03-28_01

DQoNCj4gT24gSnVsIDI1LCAyMDI1LCBhdCAxOjM14oCvQU0sIE1pY2thw6tsIFNhbGHDvG4gPG1p
Y0BkaWdpa29kLm5ldD4gd3JvdGU6DQpbLi4uXQ0KPj4+IA0KPj4+IERvIG15IHF1ZXN0aW9ucyBh
Ym92ZSBtYWtlIGFueSBzZW5zZT8gT3IgbWF5YmUgSSB0b3RhbGx5IA0KPj4+IG1pc3VuZGVyc3Rv
b2Qgc29tZXRoaW5nPw0KPj4gDQo+PiBIaSBOZWlsLCANCj4+IA0KPj4gRGlkIG15IHF1ZXN0aW9u
cy9jb21tZW50cyBhYm92ZSBtYWtlIHNlbnNlPyBJIGFtIGhvcGluZyB3ZSBjYW4gDQo+PiBhZ3Jl
ZSBvbiBzb21lIGRlc2lnbiBzb29uLiANCj4+IA0KPj4gQ2hyaXN0aWFuIGFuZCBNaWNrYcOrbCwg
DQo+PiANCj4+IENvdWxkIHlvdSBwbGVhc2UgYWxzbyBzaGFyZSB5b3VyIHRob3VnaHRzIG9uIHRo
aXM/DQo+PiANCj4+IEN1cnJlbnQgcmVxdWlyZW1lbnRzIGZyb20gQlBGIHNpZGUgaXMgc3RyYWln
aHRmb3J3YXJkOiB3ZSBqdXN0DQo+PiBuZWVkIGEgbWVjaGFuaXNtIHRvIOKAnHdhbGsgdXAgb25l
IGxldmVsIGFuZCBob2xkIHJlZmVyZW5jZeKAnS4gU28NCj4+IG1vc3Qgb2YgdGhlIHJlcXVpcmVt
ZW50IGNvbWVzIGZyb20gTGFuZExvY2sgc2lkZS4NCj4gDQo+IEhhdmUgeW91IHRob3VnaHQgYWJv
dXQgaG93IHRvIGhhbmRsZSBkaXNjb25uZWN0ZWQgZGlyZWN0b3JpZXM/DQoNCkluIHRoZSBjYXNl
IG9mIG9wZW4tY29kZWQgcGF0aCBpdGVyYXRvciwgdGhlIGl0ZXJhdG9yIHdpbGwgDQpyZXR1cm4g
YSBzcGVjaWFsIHZhbHVlIGZvciBkaXNjb25uZWN0ZWQgcm9vdHMgYW5kIGRpc2Nvbm5lY3RlZCAN
CmRpcmVjdG9yaWVzLiBUaGVuIHRoZSBCUEYgcHJvZ3JhbSBuZWVkIHRvIGhhbmRsZSB0aGVtIGJh
c2VkIG9uIA0KdGhlIHBvbGljeS4gDQoNClRoYW5rcywNClNvbmcNCg0KDQo=

