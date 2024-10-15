Return-Path: <linux-fsdevel+bounces-31993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38999EE35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F153A283977
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03FA1AF0C1;
	Tue, 15 Oct 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="E+Q1H99p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3920311;
	Tue, 15 Oct 2024 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000454; cv=fail; b=FkR+BToXTGQyYLP0jMchQtSjiDp1qjsNKosmaLWXEIl3Sod7ld8QyCNQ7v/32XNUT2r1GDMvocscM+Rth6T2oGumTOGIMQ4ZcoYxMqhQCvOlo9clN7M7E0xNCyQ37ngKBhsVZBEgOT5YHqvSu65dfKq+mCM7feF4Hc4dflX7uWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000454; c=relaxed/simple;
	bh=WbJ74eJWY1+wcgsMEeHjnwfGEYlSC65JFVe375AWRck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nxSZnBi1mACN/t7hPpHDL1zjFTM8t5dw0YBp42+QJ5ruJSZGLlhDtvTmpo/ZUNWTnjIPHQFRd/Lu6O0tE8R+5lNz/l0DrOfH69QbLYYgMDbt36OjWtqb8YBFEMQ6qBH2hs3kSdDqwyhHV48gtubr7w0h9fx1hp6kBjCVnZ4xKTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=E+Q1H99p; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6PpDI015942;
	Tue, 15 Oct 2024 06:54:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=WbJ74eJWY1+wcgsMEeHjnwfGEYlSC65JFVe375AWRck=; b=
	E+Q1H99ps5qn4y5CZRnPz8FpkO8t/0HGB3YKSnjbf2X9w/KGNTMy3fMTgT8gTcdm
	b51zOy6HVRNwmOk0OhFN7m3YWAQ5FnCofsY2xEfgYuKMVaM8SfsstIvONlTGyI1u
	AFwx+bzAtf6ql3PFLbHXOBRWNzgGwOcCOTRgW7srL8ZB5S47Yg9xtflCNWeHTf/m
	Za2v5pqrnKMGxHnCLrwZWUaIEZSPdt5HBdic2sV6pc1b4bxPgHhNUZ9VNwIdC2oQ
	gFs5tmW1SPDiH2Pl2xNuSqLNEdvDWybg7MZPaKnru3MhXIbHsMj7x6c6cvkfBg3E
	zOG7iWaaK5kUA6EPwI0faQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 429g0733j4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 06:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClbEcEvwDDGX6Zs9kaWP7esncINyP6SMfYr9PHSKlRpzXHNseuXrseGMT/ORJIalFBIOUFZKiWduwt8FGPQPbjeaQTdf/txf/YaNvZP4qFGjxxN4djRPpaDm2MloWSorPobe4K/z2vDGTlfe/K1CDBjf1bPBZXOt5a/KggBHvvFH1rlaHlft0+oiVGCo2d97SOF4G6O2D5ZJLR2EfmvHTq7LC0WDCkjcvKv3B85gDttem3a1WUA7Rcc8qaU8eoIc0+Llf/V5Wq2FT5zAZj/ZiziXGOxtyEpBGnHVKdtPBRpMzl4S+Rw2ModQjlLvAC8JslNU/DqEQv0uoxLUfb5ugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbJ74eJWY1+wcgsMEeHjnwfGEYlSC65JFVe375AWRck=;
 b=Fr7uWU10Q/Iiz12EdQEiWAMQHbRCRM9MQQ0TH1eJLs9TlxYsrTnTG4QAiW7X5pAJymCBhsLAek6UjEbOG9gY6j1TQyNko7H2RHSxWqIu9J8ygVqPpOnFLJnIqQJ3SojX7Hx1jDoadtZc71Shrnybw4gZ6GYQxU0h20633X5nKBWmGbJGF62F7Qszg3L5Iownh+knZT30GpntHw5/M8hpRkkGrIYX49BN9BhWEbZrwmQkamIsM3fewR8R/OMCGTd9nAPgeVdknZi/auu+eecOd3OBGHj+zLM26nTvJ49w9wLqZQwVPZQn9r3q3RUd/6Ayx97gGRKWYjLsdc/iyPEwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CY8PR15MB5927.namprd15.prod.outlook.com (2603:10b6:930:7e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 13:54:08 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 13:54:08 +0000
From: Song Liu <songliubraving@meta.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Thread-Index:
 AQHbFRSqQ+6V3A7WhE2nOTZ+DtSM+rKHVfgAgAAEFACAAAEygIAAB0MAgAAOLoCAAHiDgA==
Date: Tue, 15 Oct 2024 13:54:08 +0000
Message-ID: <D6F9A273-1D5A-4E4E-89E4-9A44F1AD06E8@fb.com>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org> <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <Zw4O3cqC6tlr5Kty@infradead.org>
In-Reply-To: <Zw4O3cqC6tlr5Kty@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CY8PR15MB5927:EE_
x-ms-office365-filtering-correlation-id: 3e4ea2dd-5e69-4d37-7fa4-08dced20d6fd
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUZDcnNHczRMZUJ1OEl3K29jUzJ1aTRNTlJZZGlJQkoweWxyWCtPc2djbW5F?=
 =?utf-8?B?ckViWGpGMDNTWW5paktGOUtaNEJhVEtxcTJQUVgxeHpuaEpKcW1wemxLdldW?=
 =?utf-8?B?MHZlUEpqYWN0blNtM1N4alp4SjdkL3REOXI1cWdybGxPUmJLNC9rOENGdjZu?=
 =?utf-8?B?YlRvNVlBT0xPYjBPNW9VdjYxUk9nMUpZOXl4R1NIUFBqZE52ZFhncDRGY3g4?=
 =?utf-8?B?WXdGZmNBTHdiSTlkRUxVQmI0Y2RmYVdrUFJUS0xwL3NNSGJyakQ5K0FmWUZB?=
 =?utf-8?B?MU5lU1FhNHUyUHVwQk1BWEdLWDdMcitucU45Witwc1lINW1QSkU4cGdtZ3hv?=
 =?utf-8?B?MlpSeElGQzdKSDVBNWpQYUVuSmpsUG1qei83MUIyQzlYR0tJTG1CbUJYZE9F?=
 =?utf-8?B?Zjg3VGs3ekxCQng5QUtLTWZmQkszUEpOUk5PQ0QwcldPcmg4dDhRR0MydGhp?=
 =?utf-8?B?UlRNY2JKcGNlQVVaQ0NXVUIyNXRTU3kxYkNxcExONzBQUjlJV2hiTFVBdmJR?=
 =?utf-8?B?VEtocjhPdkdtOC9QZHNSL2c5TGl0VVE1RDg5Zit1MHlzZFIvZzc0UHRDK1c1?=
 =?utf-8?B?czhsVXhyTTd1SVdUTFd6Y2ZJR3JVQ3Q0b0NaZVZYT3RqeGtBMk9zdTU3V3Q0?=
 =?utf-8?B?ZmlVMlhzZ2UvcW1TVU9DRG9xcmNlK1RuVk1adjh5eGFkdEk3R0ROQyswTEg3?=
 =?utf-8?B?UE5kNElmclpHVWJ0a1QvRGRoK0RvYzRCa2wyZ081cVdoN2ZjTUFtUFU3Z3Rh?=
 =?utf-8?B?K3owRmc5RXY0ajdMSTJGRVlUb2drelhWWDJEaE1CYmhXNjU2bno4cFJydkhY?=
 =?utf-8?B?Z3d2enlzaEthQUpKQS91MHJOR0dGR1NmU2pzK2p2dHFkdXJueUkxbVIxdG9U?=
 =?utf-8?B?SkRxSE5tMXJkQ0xzbk03Y1E2S1AwUkNWdnUvVWVNY2pPb2VpTWpZN0lyRENq?=
 =?utf-8?B?QXprd0YwRUIxOTVuZGtVQnd4cjNST3MvK284bUQwZURnK2JXSHYwZlYvVE42?=
 =?utf-8?B?TVgwQlB3RGhhM2d1TzBIblRvM1JIdG52UmNIYUN0ODdHUXVJaGZXUGtjZFhw?=
 =?utf-8?B?ei9OSTRGL296SXpoQU5acFRjdzgvOGdnV0JPbDZQaDArMXl0TjlYM1BYc0NV?=
 =?utf-8?B?bENHUDlKcXN2VWxIYmVyQ0VYMUZYRVhhT2RiL09JTW93bFB4NWkrMnhMbkNI?=
 =?utf-8?B?bEROYVE0TmpRTURod2lHalJVTkNtdUNCSG9MS2I3RlBCbG92Ym0wUlJsS0lM?=
 =?utf-8?B?ejliQkdRM0JDaStLbHV0Y2Nnd0VqQysrcThuNVAvTThvb0JEODJCMFgrUHNE?=
 =?utf-8?B?UHVDeWNkRWNvWHhiaWdia2tWdU45eUNvM0p2OVA1WGZ2YVlhUFNDRldtOFZa?=
 =?utf-8?B?VWFTSTFCNU9hZ29hWVhWMWxMU3NYL1VTWXQ3ZHp1QlJXR0M3blkrM3U0dXlK?=
 =?utf-8?B?QjdVcHZZdnhpc0htazBHaWJVM1pzRUE2bnRqTysyTWR6UjlnYzdueDUrNElj?=
 =?utf-8?B?Z1FTWTI5YmRKNnFKZUNGRkNUcS9ZM3lyTmYrQjZQS2Z1Y0ViRjA3aThMZFJu?=
 =?utf-8?B?OExQUGRWdHFNSnJReVRkdFdyOTYwYzFOdnpObGhzUS9nNnpsQ0o5Q0FrbitN?=
 =?utf-8?B?dkV1UEh3a1hrS0ZBb3dNQi9maDhxYzJjY2hvTmR2aWoxeVluaHRRSUVhY1hr?=
 =?utf-8?B?OUx1VnJIenFzdEh6KzMvK2RScXlPb2xZamt0U0dZQjJsQkRQUEx2bTNtZStk?=
 =?utf-8?B?OHVPOGtybUNMTTJSRUNvMXBXVnpETTR5YTF2TVdwYm1RN0ZTek5kODcxdUVC?=
 =?utf-8?B?LzNSY1FSK3ZjU0FJQTRJdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnVVYk95d3FQeW5HenRzMzVUaFZMQjNMSVdvTTRZUy9DS3loeWY5SW9UdGJX?=
 =?utf-8?B?cHRVd2VXQXlUcWF6bGVuL2hYT0FPY0NlZU9oUXpEZUd0dlpGWm9LRFZlSW1v?=
 =?utf-8?B?akYrQTRoVFZWRnBaamlMMktlUXdwWTYraXIwTi9ITFdWbWFBM1pWZm00bUNw?=
 =?utf-8?B?V2NKcDd4N0xhaitLL2RlaDc4cGtaY0JtMUZJUjg4UkxiZjdTbGFHYkdRYWZt?=
 =?utf-8?B?djBkU09wM2lWN0UwYUY4eWNPaUtLZ1JVamJKU3dJOHFRUnZaclBENGpnbHI0?=
 =?utf-8?B?MGloRTdINFFDQ1dxQmY0Y3lKbkY4TkdmR1RCdXZDOGozdDB6dTRoNkg4MDY3?=
 =?utf-8?B?eGl4ZzRYUlZsS01pSGdLNE0xdFZaZHVXZ1U1ZFVzb3ZOYnJ1OENVOWFyUkZz?=
 =?utf-8?B?VUhpeEc2UDRCSnJDdzJMTFBsR01HWlpVcHhZelkyYlZ3UDBmU3QrNm1qRERo?=
 =?utf-8?B?WGpjYmd3MGkrNDlZL2tYckhQSk9mM3hOZUZIOUlmaGJSMDEwdUpFbk9tNWJT?=
 =?utf-8?B?bHF0NGZyV2NSVWpFUzVzWGd0U2lmK3k1M1R0VS9MU2ROeTNKaTJzZXpod2ZY?=
 =?utf-8?B?VnhUSGZ1ZlBLSEowR3hxNUd5MDZTV1dldW5NZTVhMVl2VnZad3pxODBmRDVV?=
 =?utf-8?B?MWt6ZFdzTXF2NkZkempSeDkvWlVTNEYwTUZrQWtNWFJoQUdtSmp3aG5nK2Fk?=
 =?utf-8?B?YW43bU05L2dPejdzWXFnRVZHeGpRa3hXemRzVWREYWdYMFVyT2tFUzUvOXRh?=
 =?utf-8?B?OHJsc2JKcjRNNXpiUE4xekVzQWNqTmh3UTVmNzVjT2JpOVJTeHk4TEVmbnA5?=
 =?utf-8?B?YWl3V2ZoMHpuN1hoSFlDR3NzMG5jUTU4S2pONHk1YjNYNGl0YlVBbGM0YWZ5?=
 =?utf-8?B?Ti9pMFZSMzR3ZHhzTDJHd09ucjV0L1ltb1lOVlExUVFmVVgzZ0dXRTczQkpN?=
 =?utf-8?B?eEpaM2E1clR2SktsNC9JRTBpQ3hlRVlnUllDVGJaWkUxczRZZnpIT1FoUHBQ?=
 =?utf-8?B?N1NoazZoVCtIYkErSVZSQVphdUtCd2d6amxHK2NuTExMazloSzFzbHpHRWZk?=
 =?utf-8?B?VVExSGpSYUs0S0t2Q0FNcmU2c0ozQWRlWXE4TVhhR3NvTlA2UkVhL1pQMkV0?=
 =?utf-8?B?ZUlyZ0RraG8wcUE3Uk84cEtoZmRVSGt2NmcvWGM3bWVyeWhhVmRpTC9CQ3pR?=
 =?utf-8?B?bDEvTm9ZS2tVc0NXVzBaOUJNY1ptanRJeXpPWk4ySVBzb2Y3KzY3cGNmQklw?=
 =?utf-8?B?ZWliS0loSEd2OVBxODZFSG93d3VURURwV3hZTWZIcHhvam0wc0JXVms5aTRa?=
 =?utf-8?B?Rm52bmg4UkY4M211c3c4UE8xcGtqQUEvQ1RvRWNPWGZ0VTUrdG1HWFcvUERW?=
 =?utf-8?B?VzVYWVVDbkszemo3ZGwxbG00RmZ0eHJKQTJpOGVjK2h5WW5zaDRqOUJaMmdt?=
 =?utf-8?B?a20ybnZHaHhVemliOXBsUGZwTkNrQUk5SHpKM2V0Rm9aeUFtZDJVeXdmKzJi?=
 =?utf-8?B?TnY5SFFESCtLdTdJcGQwREVwbVdoVUxXcEF1UWNITXFJZlhscVBnQWJXczJK?=
 =?utf-8?B?RkxRSTZXSnB2MEM4OUd6UXFxQXN5OEFrMmhwMTBJM1FSc08wUm9RNFZHaXYr?=
 =?utf-8?B?cjN2a1JSSGY0Tnp6ZnkzSHBPVVY4NGp5Um5sbFd6YThucWZ0RythNE9wMWJI?=
 =?utf-8?B?VWhYbWlRa0RsaC9iN2lFeEtOOGhDeDlBdm4rdzEvQmNEVGI1WGNHRDA5N2Yy?=
 =?utf-8?B?dTI1R0dLZi80M3dHWmJQMHZ0UEcrVmNaMHRQdVhDT0h2cTZOMS9WcUVxUWNO?=
 =?utf-8?B?ZGd0ZFlrRlVheEQ2aWM2ZjZ0R1FYSnRiT3Y2RFFGNVhibm4vRmVvamV2TlZU?=
 =?utf-8?B?VXBncy9FaHZtOERSSmw1cmIrN052bnZsRXplMUtlTzY3ZlJ2Q1E1NmhnSDcr?=
 =?utf-8?B?ZWZLc1ZtamplYVdOeXdTcnBHdDUvam5pcy8zWFpydTlQelc0MTRmRVhUYlZi?=
 =?utf-8?B?YmNkNXduaDdxZ1JNSGMzY2laaHVTUmFzRjZIT1JDREEzUEVOV0dBT0Zack0x?=
 =?utf-8?B?b0Vua0FQL3VOTGc5bGd2UkpmcndrWko4NHZTQnJYc1BZZzRvVzBUa0hKZFdG?=
 =?utf-8?B?MDFpbjFVSG4xdDVPeGxpMEd2aHNtZjNmSlczOXZ5OEJUeEhHUlpWZnE4ek1k?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC300EC936C9264C815122814F29111D@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4ea2dd-5e69-4d37-7fa4-08dced20d6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 13:54:08.1279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GH/XabYw6oQrp5amDVMVO40FJm7LLPLtF/mw8LAsvw/EBB6XlOg/Wy+8GjLZIWpFtV6D6bfFSS3K1IYs9rmEfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5927
X-Proofpoint-ORIG-GUID: Gfkn0nxqJsGAfdQ3P4EsKEktxB7NmYBk
X-Proofpoint-GUID: Gfkn0nxqJsGAfdQ3P4EsKEktxB7NmYBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQ2hyaXN0b3BoLA0KDQo+IE9uIE9jdCAxNCwgMjAyNCwgYXQgMTE6NDLigK9QTSwgQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgT2N0
IDE1LCAyMDI0IGF0IDA1OjUyOjAyQU0gKzAwMDAsIFNvbmcgTGl1IHdyb3RlOg0KPj4+PiBEbyB5
b3UgbWVhbiB1c2VyLiogeGF0dHJzIGFyZSB1bnRydXN0ZWQgKGFueSB1c2VyIGNhbiBzZXQgaXQp
LCBzbyB3ZSANCj4+Pj4gc2hvdWxkIG5vdCBhbGxvdyBCUEYgcHJvZ3JhbXMgdG8gcmVhZCB0aGVt
PyBPciBkbyB5b3UgbWVhbiB4YXR0ciANCj4+Pj4gbmFtZSAidXNlci5rZnVuY3MiIG1pZ2h0IGJl
IHRha2VuIGJ5IHNvbWUgdXNlIHNwYWNlPw0KPj4+IA0KPj4+IEFsbCBvZiB0aGUgYWJvdmUuDQo+
PiANCj4+IFRoaXMgaXMgYSBzZWxmdGVzdCwgInVzZXIua2Z1bmMiIGlzIHBpY2tlZCBmb3IgdGhp
cyB0ZXN0LiBUaGUga2Z1bmNzDQo+PiAoYnBmX2dldF9bZmlsZXxkZW50cnldX3hhdHRyKSBjYW4g
cmVhZCBhbnkgdXNlci4qIHhhdHRycy4gDQo+PiANCj4+IFJlYWRpbmcgdW50cnVzdGVkIHhhdHRy
cyBmcm9tIHRydXN0IEJQRiBMU00gcHJvZ3JhbSBjYW4gYmUgdXNlZnVsLiANCj4+IEZvciBleGFt
cGxlLCB3ZSBjYW4gc2lnbiBhIGJpbmFyeSB3aXRoIHByaXZhdGUga2V5LCBhbmQgc2F2ZSB0aGUN
Cj4+IHNpZ25hdHVyZSBpbiB0aGUgeGF0dHIuIFRoZW4gdGhlIGtlcm5lbCBjYW4gdmVyaWZ5IHRo
ZSBzaWduYXR1cmUNCj4+IGFuZCB0aGUgYmluYXJ5IG1hdGNoZXMgdGhlIHB1YmxpYyBrZXkuDQo+
IA0KPiBJIHdvdWxkIGV4cGVjdCB0aGF0IHRvIGJlIGRvbmUgdGhyb3VnaCBhbiBhY3R1YWwgcHJp
dmlsZWdlZCBpbnRlcmZhY2UuDQo+IFRha2luZyBhbiBhcmJpdHJhcnkgbmFtZSB0aGF0IHdhcyBh
dmFpbGFibGUgZm9yIHVzZSBieSB1c2VyIHNwYWNlDQo+IHByb2dyYW1zIGZvciAyMCB5ZWFycyBh
bmQgbm93IGdpdmluZyBpdCBhIG5ldyBtZWFuaW5nIGlzIG5vdCBhIGdvb2QNCj4gaWRlYS4NCg0K
QWdyZWVkIHRoYXQgdXNpbmcgc2VjdXJpdHkuYnBmIHhhdHRycyBhcmUgYmV0dGVyIGZvciB0aGlz
IHVzZSBjYXNlLiANCkluIGZhY3QsIHRoaXMgcGF0Y2hzZXQgYWRkcyB0aGUgc3VwcG9ydCBmb3Ig
c2VjdXJpdHkuYnBmIHhhdHRycy4gDQpTdXBwb3J0IGZvciB1c2VyLiogeGF0dHJzIHdlcmUgYWRk
ZWQgbGFzdCB5ZWFyLiANCg0KVGhhbmtzLA0KU29uZw0KDQo=

