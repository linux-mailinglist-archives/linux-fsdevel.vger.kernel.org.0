Return-Path: <linux-fsdevel+bounces-35719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA69D77B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED7A1620CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4E155744;
	Sun, 24 Nov 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="g9dyqCKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AA2500D8;
	Sun, 24 Nov 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475327; cv=fail; b=emVzydAWVwgkznixft99rCn1punHaWHj2U17qmWSYvyD1lJq/22KdUxoTKLW4HOmmZhUTO2QyC/JddoYu1rP2eVz03EsgEaux7bvuxTeP2p2SuL71Db4VBm5tuIGY+HqNQdwXaQGZYxDI+u9IGKJv3BHW9eAWhyAmY2auG0mmtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475327; c=relaxed/simple;
	bh=vBeLte152+26ovzIkhaQjWI95OF2TZ47t4kDxzs0d4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oYCcdrU1mkvR2yJGlbdIem+lw//WJnXt6V+/WhLXvmTdeJsB+uAUkKLznOXrD+V5XyidxLwZsA6yOHwjugKLDBiMYuuUFpv5VXB7DGpVXFtmDCWKd0mxt39GbevV6nhNWwaLd1nb80CgU1eKgW+9KyplmORzjEvFS/+we8BdW+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=g9dyqCKw; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOCVIAE023448;
	Sun, 24 Nov 2024 11:08:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=vBeLte152+26ovzIkhaQjWI95OF2TZ47t4kDxzs0d4I=; b=
	g9dyqCKwsSGAWmbxX2OMGrHEmVTCXt2UO4fxeoU7QR6tIMfCkjCPtJz4/OgJI21n
	8bmZ9wsFPBpcVlYzC9igXrHIXNU+ciNIujqARl7u7NNMj0rTCR5SoL29Q3cgryeL
	soKBcYhpEU+dEFbOxo+g+8OFbsXV0naQ3Mknow/Iqy4c3ztZw1/u3rVtk5c4Za2x
	QKW3IFzqDVGN/UEtcpEXOjrCz6MX2SjRALnDTc7J+KE+rcgWClyFHzb3Hr23DgBw
	2lXrygRBdUHnK1B8HnsPtrm8f7qlvaz3szdfDLrACa5KifGg7rbmQWd8XYlKtHzJ
	WrV1QN/yxkHM0h+VIqy3LA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 433tpt2nwy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 11:08:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdS3/hmrzvzB7t4BO6K6/P58YulyedTLGiQd53B1KNl4jgYcV5wQphwa3jd20atVvHuLCf4zmI9j86jj88qqOGPvP80AggniZVclL5jrmR/v4wYnc3tRw5hCBakLvie9OmYpPBrf8mJn37dqw1mnPggA49us4lcI4NjZvg3H7CaLfHUcHtqH0ze/BcsoDIpbMkvh7fSOh3k71JS7kFcswrh+IjQiFT/rurAPJVKcywiLOZID9uYZz5E67b+ZIASldYWTfzbXVi4JghnV1Dv3B00ywVcFC5sO5NKwGc5K6+F49gooXTsUvE+e7pgQ8Z/5FEDCD/c56N7bqNnNj4N0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBeLte152+26ovzIkhaQjWI95OF2TZ47t4kDxzs0d4I=;
 b=uUvaGqHJRst1wYi3cF4mAZbdyAcNOpauGtX0Jx92tvo64WPabrHXYLPLka/41Vj45JAufGiSeRz/u8niINb+aZ9gw3XlS0hP4L31dnYLUBieQpBtyzup7QE4EdiKbbTqsFvjKawiNKPLB76gLb+g9mY0OSlRMDLtzVCHTgj82/rMIsUI3FUGL2doBgjHBJVGBCIbuaY0M8651m0jWeT6ux9E6792PuVU51B42/0toX9SzbDXw9UeBP7+Pp79910JaHgxBznKkBm+30vKddowYACHR2/9GOVIh3SBnMtJ7E6FUETSajdqMVezPJpqcAVxiqEmbni5mY1yEQPSWnDtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH0PR15MB6333.namprd15.prod.outlook.com (2603:10b6:610:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Sun, 24 Nov
 2024 19:08:40 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8182.016; Sun, 24 Nov 2024
 19:08:40 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Josef Bacik
	<josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
Thread-Topic: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
Thread-Index: AQHbPTJTRtVL/ndvAkq5U8lEfRXpbLLF+OAAgADVOYA=
Date: Sun, 24 Nov 2024 19:08:40 +0000
Message-ID: <08768205-68CE-499B-A6DC-25E3E530AF91@fb.com>
References: <20241122225958.1775625-1-song@kernel.org>
 <20241122225958.1775625-2-song@kernel.org>
 <CAOQ4uxgKoCztsPZ-X-annfrDwetpy1fcRJz-RdD-pAdMQKVH=Q@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxgKoCztsPZ-X-annfrDwetpy1fcRJz-RdD-pAdMQKVH=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH0PR15MB6333:EE_
x-ms-office365-filtering-correlation-id: 60c926aa-88d7-4e03-91a6-08dd0cbb6839
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUZmS1RNRG1tbmdIQnJ0aGdBRTc5dlJORVo3eTcvWHF2YVVHUVB2Vm5RdFdv?=
 =?utf-8?B?TVJQVFREOTBTdnhNdXppbUFrQTdyS0N3MkEzODJHdGsrZGx6TDRkT2RDQlF0?=
 =?utf-8?B?YXQ2di9tcGtFMWRxMThWNDRhVTlaTWl4SnZkMDNwYmNCOHQwOFkvcFMrSlVw?=
 =?utf-8?B?WTFYOE9KNURxeTJmVkdSRUxmWHRua3A2RExsZWttUmUzWHU2OHZtRzNhOGJx?=
 =?utf-8?B?VEZMVE81RUxrYjN1RW5ZQUJ3SERuMk1KcXMwVlJyUzNNem5RajVmK0ptRDZG?=
 =?utf-8?B?cWhNZk1nRjl1UnpyWTlVV3VWODFnL3E5djJ2S1dkNnRRUVhvWHl5QTNpY3kz?=
 =?utf-8?B?Q2xqRXlFKzBqa2I2ZVp1SDY4OSsvaTIrUm5CVUZ2ZXZxSjVpTmlhOTE3S2lW?=
 =?utf-8?B?Mzl0NXMzVytEUDgyZkNzUTQzVE1XZVh1YStnZDR6ZExOa1ZBMllHYWxmWW9R?=
 =?utf-8?B?RTBWMmVUL1JwaUN4T0FaRGp2R09uOXJ6R0ZxUmRJYlJqQW91UE5Cclg1ZnJE?=
 =?utf-8?B?SWViL0traWhRR2NOcENWdS9YY3hiVGZvZmRWZzA2M3ZuWC9BVk9uOExQWFpV?=
 =?utf-8?B?WmhxdWhsMFpwcXhvRGgzNllCWUZFUnlvVWY2eCtadTlmcDNvL3NtNVhqYWVU?=
 =?utf-8?B?dU1TVHc2NW1oRVZGRUJJUXd5NTlWK1pMVmdwT3MrYWZ0N2lpTUFKZDUrbk50?=
 =?utf-8?B?Z21RVzJwaXBQVnNka0hoZFFjSndPMXpKQnRoKzhsR21sdGRvMXZJRGczU0V4?=
 =?utf-8?B?U0FsRlJFOTl0SVdqc2V4b2luOXF5KzNobFc4a1ZwWTJQemNkenVCTWZnOWlv?=
 =?utf-8?B?YmlsQnZlbWxCMk9objNRUDdINU1xdkZFSzFCODdFZjM5ZE0ySmh3MmhaaTRi?=
 =?utf-8?B?TFdrOEhkT2dqTHQySWRMMDFpYmtoWTIwSXJBR3JjN2k5WnZadDlmVUdKdU9a?=
 =?utf-8?B?Sk1DR29US0NqU2VVSGo5dUxlQ1F2dTdjWkxMSndweUN5cFdhU2xvRTZIaVpD?=
 =?utf-8?B?US92Q2wrb2JzVmFyYmpCT2VpNXpCbHc0dkM3L2YzNmFPNjhYOWpzYVlLK1Ju?=
 =?utf-8?B?cUxPb1B6Q0pwVUZMSncxR3o0a3Ixd01JUzFNZ2NNZVErVlExYWNKQ1hlZG5u?=
 =?utf-8?B?cFJyVDk3a0JxaHNpdW9pN1plTzY5NFkzNndIUjBmeUdRZFpNZGtWbkdWZWVU?=
 =?utf-8?B?ZWw3bGJud0Y2ZElwR3oyQlB6RUpvNWNIQ2tyRXRZWW95V285WVlFRlhuQk0x?=
 =?utf-8?B?QUVMQU5vNzdNZDlEa1VYR2RoNlluTnE5VWZRUm05TjhjcmxiMFdiV2Vtb216?=
 =?utf-8?B?eitCVFpHeFpsWjMxa2RDcy8wL0J4dW5jN1VHRk1pVWlZSTRQYzVyRTRZNEpw?=
 =?utf-8?B?dnM0dTZLMjNKTWNTNHlSaVJSUEtGTVFwVUZUcDdGc3pjd1NSdEZwMDB5YWRy?=
 =?utf-8?B?RmJpVEcrblI0M3p6YW84ZHFwRHNQL0ZsUVBvdzZpTkJmajNTNTBUdGVsb1Va?=
 =?utf-8?B?Njl2RDJqK05Id2lQYnlFT1cxL003eHZuYXdQdk02K0xrc3JRVzEzSER3MzNX?=
 =?utf-8?B?a2JiTnlvWXJ4MkhmUjFDZVVkdTlsb0dXNUNoV09TMEpRY2t6dkhUKy9sMUZ2?=
 =?utf-8?B?M0ZPOEVuN01tTDlaZDdrRmY4R2dpelBJOUVPbGx0L2hJbmhFVEsxT1dIdTU0?=
 =?utf-8?B?NzlJbExOWUdLRUxIYW5Vb1VXQnR4TzIvc1ZpMHQraG12YzdaejNmNmVZMGZJ?=
 =?utf-8?B?VWMreXZLUHZIVUptLzFIYmJBRzJxTnpidkpHUjgyVXlHNmxWZVM1NWZIK29D?=
 =?utf-8?B?TTJVMjRuMmZienp0a0ZKN3dEL2tLRlE1K0ZzcUJydFhqSHB1OEF3bTN0cXFm?=
 =?utf-8?B?MUtVN0hqNDlESUZMWUxNNWRKV3ZEZkZBL25oRmxGdmZ4TUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2I3UnhLSjRGWWFVVFFqb1pqNnUwTFlhV3IvQUhER2dudFJoVmtMeHo5dFVL?=
 =?utf-8?B?c1pCcmJjL1FhaWpJM2plNDlRZmFGNmM4RDdYMkxUcjU5VlpEQXFmVllpellE?=
 =?utf-8?B?c3VOUDhzcUtXcnhlYzJJZlRRVHVYanMwZkgwVEZNZEU3eE5rNGFkUVMrL0I5?=
 =?utf-8?B?ZHY0bDhTdy9vdXVWWWhtVlJwVmxFUWhVUkJiUUI3NlJqODBJelU4bUhkUDZp?=
 =?utf-8?B?ZFZBNUNjd09CdnlLL01BeE1TUUZ6ejkyOG4rR1RyTGdGWVlVNXVCK0hqUlVF?=
 =?utf-8?B?WnZwMDRkSDRuS0w0anZyNVQ0NTVoU2tZaDdtdDdrd0svZm04L29KcmcxTHdj?=
 =?utf-8?B?d0x6eFpTVEpKb2JKSUtiR2FCeXJpSWVqS3VjbjV5eEE1clN4R0xXc1BhZTFj?=
 =?utf-8?B?bEhuTEwxUjZwempiMEs1Z3FLd1FoMFpxWmQ3a1Z3Y1VJeDVYTmRtaytzcGt2?=
 =?utf-8?B?ekFIQUg1cC93dG5URDdMekxOOCtJYVFiZ2pXdjFsQjQrYXZ2VXUzTDZ2aENo?=
 =?utf-8?B?RlhQVjFhcW12R0NPQlZSY0M3eVNtSTZFbGJVMXByaHJZS1R0QmhiTGFaZXBW?=
 =?utf-8?B?THVIWCs4WndwdG90OHh6aHpoMU14aFlFbkhCWWlrZG8wOUxQbnRVYSs4Skxm?=
 =?utf-8?B?aGJlVlNSY29DbkF2TFdHdnJUeE1zU1ZhMDFvbHdxVVNsaktGUFRqaU5iYWg2?=
 =?utf-8?B?bFRjRUNrUEJjY2JTUFB5bmlSZk94WjFkWmI5NEZlRjJ3NnV3M2djdmdTSlhn?=
 =?utf-8?B?OFYxMXlqbTFjQlVvU1c5cDIrMEY5RkE5Y0VEYUdMNk9CRVduMjNZSnlocUpy?=
 =?utf-8?B?OFB3SmFlaEpyTHFkc3FwVTRZY3gwYllWTFoxODZVVGVzY1VDanJNa29mOHUr?=
 =?utf-8?B?VVlUZTd1c0M1N0ZkZWdWWk5pNS9HK21iV1RiN2Q3NVdjcHJlV3l0UHhIUEpl?=
 =?utf-8?B?NUxUOUp4K1ltclQyQ1hBdUNyazhNY1VsWWcvMjRZSmYyUzZxRFFCWkdxYk01?=
 =?utf-8?B?QW9ONWl2TnNuQlJZRWc2U0F4NzRDajduNUtkdXBWcWJNMnB1WUZuSkxxeFJR?=
 =?utf-8?B?bnVhemRwT3NkMEJrakw2bWpKdXI5ME56cHp0cGtmZkJvZnVlbDF2RmFQR1pF?=
 =?utf-8?B?SVlEZjVNbWVnMEdLd0JITzgyU2VEb1haRk9FTUM3S0RxdXZmTFVHMkovL05s?=
 =?utf-8?B?QTRiamRKckk1OWVNYXFyZklMeGl2c1ZjelZDTTk1ZXNMNHJyYm5OUnRqd2hP?=
 =?utf-8?B?MnNRNG9IU3lNbUFzZGNlNFNVaGVpNXFNdVZvY3drWWgyTnRYblFZVzZNWHdY?=
 =?utf-8?B?elVwQjJSaVg0dTZ1ektGZjhzT0NST3VNT0ZNNWNxWUpBdUQ1ZXdPOUpuV2Zy?=
 =?utf-8?B?SjZ4UTNSWGtqckYrMG1oOVdmeXNHczdoYzBEdXNCdjg1OTBTb3dYeFBFQWcr?=
 =?utf-8?B?ZnRQd1N1NVN6b3V0bDQxOEVlSTlwSlFmY1IrUnFWamVHejBTZmkwMzRCS0V5?=
 =?utf-8?B?SEpYWkdVZGpxT21GUVNBVVdremJSdkRCeDFBK1JFU1dJWXhNSC80dnpGaEJV?=
 =?utf-8?B?TFlteW9zc2ZUNkNQNFBhSFB5eEtMc2NlYXcvaTRxTUxDZ2E1OER5djdlL08z?=
 =?utf-8?B?eWRvVm1LS0V6TENZYW5TdkdlZzVEMTA0NFQ0YmdwQTBpckVXS2M0SGFEQVZP?=
 =?utf-8?B?TkVqcEYxK0syV3pqUGMxaHZiNWZBUmx3VEwvMnllK2xFZFhDc3QraTdTRFFB?=
 =?utf-8?B?eitENGIyRGRqWERONnF5NURFdVJkTWtJczN2YThqdTgxUjFmbkc3cUg2RU4x?=
 =?utf-8?B?YndKWDM2djBZOE1GQi9meVVMaStMN1FqemJ5SGJWdVdmSzZZV3c4b0RxOXBE?=
 =?utf-8?B?dUtMa3kvZjFueWlER3RDY2xGRVpTUEJZLzlKR2NpMVc5NmUrbE1oY1VEK2VV?=
 =?utf-8?B?T1U3R0ovRTFWZVNZYUdXY2RXRUtVeFp6SWErWjR4MkVzbG5JSE13UVpPWFNu?=
 =?utf-8?B?NFRQaitwS1hGd0YrT2FPQm1USWNBOGcvUFhFOTZmaDBqUXE4TUdBMFc2NG40?=
 =?utf-8?B?SDN3M2hJSGJiRC9MQ2JkQmFoT3VFZ1dWTWp6S2lOc3NSVkpuS2RWVjQ5ZHEw?=
 =?utf-8?B?YUQydkRCclhCZmxFQS91bVg4QUFhQkV5UEVBNEhmYkNsZkxsTm00TUlxUXZL?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <761B4BAED48DD64887681C9A4DC67A64@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c926aa-88d7-4e03-91a6-08dd0cbb6839
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2024 19:08:40.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8y6PRcQzTuBdQ3joPCTrCECRWtyKWP7CGc0Hy99Vtq5RsU0zA/mIKMKmS/sHWYMiVTo1v6SUMxVxHL4rqkYGBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6333
X-Proofpoint-ORIG-GUID: VP01aV9_xo1Lb0BPTEumT7htqk789B8l
X-Proofpoint-GUID: VP01aV9_xo1Lb0BPTEumT7htqk789B8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDIzLCAyMDI0LCBhdCAxMDoyNeKAr1BNLCBBbWlyIEdvbGRzdGVpbiA8YW1p
cjczaWxAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgTm92IDIzLCAyMDI0IGF0IDEy
OjAw4oCvQU0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4gd3JvdGU6DQoNClsuLi5dDQoNCj4+
IA0KPj4gVG8gbWFrZSBmYW5vdGlmeSBmaWx0ZXJzIG1vcmUgZmxleGlibGUsIGEgZmlsdGVyIGNh
biB0YWtlIGFyZ3VtZW50cyBhdA0KPj4gYXR0YWNoIHRpbWUuDQo+PiANCj4+IHN5c2ZzIGVudHJ5
IC9zeXMva2VybmVsL2Zhbm90aWZ5X2ZpbHRlciBpcyBhZGRlZCB0byBoZWxwIHVzZXJzIGtub3cN
Cj4+IHdoaWNoIGZhbm90aWZ5IGZpbHRlcnMgYXJlIGF2YWlsYWJsZS4gQXQgdGhlIG1vbWVudCwg
dGhlc2UgZmlsZXMgYXJlDQo+PiBhZGRlZCBmb3IgZWFjaCBmaWx0ZXI6IGZsYWdzLCBkZXNjLCBh
bmQgaW5pdF9hcmdzLg0KPiANCj4gSXQncyBhIHNoYW1lIHRoYXQgd2UgaGF2ZSBmYW5vdGlmeSBr
bm9icyBhdCAvcHJvYy9zeXMvZnMvZmFub3RpZnkvIGFuZA0KPiBpbiBzeXNmcywgYnV0IHVuZGVy
c3RhbmQgd2UgZG9uJ3Qgd2FudCB0byBtYWtlIG1vcmUgdXNlIG9mIHByb2MgZm9yIHRoaXMuDQo+
IA0KPiBTdGlsbCBJIHdvdWxkIGFkZCB0aGUgZmlsdGVyIGZpbGVzIHVuZGVyIGEgbmV3IC9zeXMv
ZnMvZmFub3RpZnkvIGRpciBhbmQgbm90DQo+IGRpcmVjdGx5IHVuZGVyIC9zeXMva2VybmVsLw0K
DQpJIGRvbid0IGhhdmUgYSBzdHJvbmcgcHJlZmVyZW5jZSBlaXRoZXIgd2F5LiBXZSBjYW4gY3Jl
YXRlIGl0IHVuZGVyDQovc3lzL2ZzL2Zhbm90aWZ5IGlmIHRoYXQgbWFrZXMgbW9yZSBzZW5zZS4g
DQoNCj4gDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+
DQo+PiAtLS0NCj4+IGZzL25vdGlmeS9mYW5vdGlmeS9LY29uZmlnICAgICAgICAgICB8ICAxMyAr
Kw0KPj4gZnMvbm90aWZ5L2Zhbm90aWZ5L01ha2VmaWxlICAgICAgICAgIHwgICAxICsNCj4+IGZz
L25vdGlmeS9mYW5vdGlmeS9mYW5vdGlmeS5jICAgICAgICB8ICA0NCArKystDQo+PiBmcy9ub3Rp
ZnkvZmFub3RpZnkvZmFub3RpZnlfZmlsdGVyLmMgfCAyODkgKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+PiBmcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnlfdXNlci5jICAgfCAgIDcgKw0K
Pj4gaW5jbHVkZS9saW51eC9mYW5vdGlmeS5oICAgICAgICAgICAgIHwgMTI4ICsrKysrKysrKysr
Kw0KPj4gaW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmggICAgIHwgICA2ICstDQo+PiBp
bmNsdWRlL3VhcGkvbGludXgvZmFub3RpZnkuaCAgICAgICAgfCAgMzYgKysrKw0KPj4gOCBmaWxl
cyBjaGFuZ2VkLCA1MjAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+IGNyZWF0ZSBt
b2RlIDEwMDY0NCBmcy9ub3RpZnkvZmFub3RpZnkvZmFub3RpZnlfZmlsdGVyLmMNClsuLi5dDQo+
PiANCj4+ICAgICAgICBCVUlMRF9CVUdfT04oRkFOX0FDQ0VTUyAhPSBGU19BQ0NFU1MpOw0KPj4g
ICAgICAgIEJVSUxEX0JVR19PTihGQU5fTU9ESUZZICE9IEZTX01PRElGWSk7DQo+PiBAQCAtOTIx
LDYgKzkyNCwzOSBAQCBzdGF0aWMgaW50IGZhbm90aWZ5X2hhbmRsZV9ldmVudChzdHJ1Y3QgZnNu
b3RpZnlfZ3JvdXAgKmdyb3VwLCB1MzIgbWFzaywNCj4+ICAgICAgICBwcl9kZWJ1ZygiJXM6IGdy
b3VwPSVwIG1hc2s9JXggcmVwb3J0X21hc2s9JXhcbiIsIF9fZnVuY19fLA0KPj4gICAgICAgICAg
ICAgICAgIGdyb3VwLCBtYXNrLCBtYXRjaF9tYXNrKTsNCj4+IA0KPj4gKyAgICAgICBpZiAoRkFO
X0dST1VQX0ZMQUcoZ3JvdXAsIEZBTk9USUZZX0ZJRF9CSVRTKSkNCj4+ICsgICAgICAgICAgICAg
ICBmc2lkID0gZmFub3RpZnlfZ2V0X2ZzaWQoaXRlcl9pbmZvKTsNCj4+ICsNCj4+ICsjaWZkZWYg
Q09ORklHX0ZBTk9USUZZX0ZJTFRFUg0KPj4gKyAgICAgICBmaWx0ZXJfaG9vayA9IHNyY3VfZGVy
ZWZlcmVuY2UoZ3JvdXAtPmZhbm90aWZ5X2RhdGEuZmlsdGVyX2hvb2ssICZmc25vdGlmeV9tYXJr
X3NyY3UpOw0KPiANCj4gRG8gd2UgYWN0dWFsbHkgbmVlZCB0aGUgc2xlZXBpbmcgcmN1IHByb3Rl
Y3Rpb24gZm9yIGNhbGxpbmcgdGhlIGhvb2s/DQo+IENhbiByZWd1bGFyIHJjdSByZWFkIHNpZGUg
YmUgbmVzdGVkIGluc2lkZSBzcmN1IHJlYWQgc2lkZT8NCg0KSSB3YXMgdGhpbmtpbmcgdGhlIGZp
bHRlciBmdW5jdGlvbiBjYW4gc3RpbGwgc2xlZXAsIGZvciBleGFtcGxlLCB0byANCnJlYWQgYW4g
eGF0dHIuIA0KDQo+IA0KPiBKYW4sDQo+IA0KPiBJIGRvbid0IHJlbWVtYmVyIHdoeSBzcmN1IGlz
IG5lZWRlZCBzaW5jZSB3ZSBhcmUgbm90IGhvbGRpbmcgaXQNCj4gd2hlbiB3YWl0aW5nIGZvciB1
c2Vyc3BhY2UgYW55bW9yZT8NCj4gDQo+PiArICAgICAgIGlmIChmaWx0ZXJfaG9vaykgew0KPj4g
KyAgICAgICAgICAgICAgIHN0cnVjdCBmYW5vdGlmeV9maWx0ZXJfZXZlbnQgZmlsdGVyX2V2ZW50
ID0gew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgLm1hc2sgPSBtYXNrLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgLmRhdGEgPSBkYXRhLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgLmRhdGFfdHlwZSA9IGRhdGFfdHlwZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIC5k
aXIgPSBkaXIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAuZmlsZV9uYW1lID0gZmlsZV9u
YW1lLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgLmZzaWQgPSAmZnNpZCwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIC5tYXRjaF9tYXNrID0gbWF0Y2hfbWFzaywNCj4+ICsgICAgICAg
ICAgICAgICB9Ow0KDQpbLi4uXQ0KDQo+PiArDQo+PiArICAgICAgIHNwaW5fbG9jaygmZmlsdGVy
X2xpc3RfbG9jayk7DQo+PiArICAgICAgIGZpbHRlcl9vcHMgPSBmYW5vdGlmeV9maWx0ZXJfZmlu
ZChhcmdzLm5hbWUpOw0KPj4gKyAgICAgICBpZiAoIWZpbHRlcl9vcHMgfHwgIXRyeV9tb2R1bGVf
Z2V0KGZpbHRlcl9vcHMtPm93bmVyKSkgew0KPj4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2Nr
KCZmaWx0ZXJfbGlzdF9sb2NrKTsNCj4+ICsgICAgICAgICAgICAgICByZXQgPSAtRU5PRU5UOw0K
Pj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfaG9vazsNCj4+ICsgICAgICAgfQ0KPj4g
KyAgICAgICBzcGluX3VubG9jaygmZmlsdGVyX2xpc3RfbG9jayk7DQo+PiArDQo+PiArICAgICAg
IGlmICghY2FwYWJsZShDQVBfU1lTX0FETUlOKSAmJiAoZmlsdGVyX29wcy0+ZmxhZ3MgJiBGQU5f
RklMVEVSX0ZfU1lTX0FETUlOX09OTFkpKSB7DQo+IA0KPiAxLiBmZWVscyBiZXR0ZXIgdG8gb3B0
LWluIGZvciBVTlBSSVYgKGFuZCBtYXliZSBsYXRlciBvbikgcmF0aGVyIHRoYW4NCj4gbWFrZSBp
dCB0aGUgZGVmYXVsdC4NCg0KU3VyZS4gDQoNCj4gMi4gbmVlZCB0byBjaGVjayB0aGF0IGZpbHRl
cl9vcHMtPmZsYWdzIGhhcyBvbmx5ICJrbm93biIgZmxhZ3MNCg0KQWdyZWVkLiANCg0KPiAzLiBw
cm9iYWJseSBuZWVkIHRvIGFkZCBmaWx0ZXJfb3BzLT52ZXJzaW9uIGNoZWNrIGluIGNhc2Ugd2Ug
d2FudCB0bw0KPiBjaGFuZ2UgdGhlIEFCSQ0KDQpJIHRoaW5rIHdlIGNhbiBsZXQgdGhlIGF1dGhv
ciBvZiB0aGUgZmlsdGVyIGhhbmRsZSB2ZXJzaW9uaW5nIA0KaW5zaWRlIGZpbHRlcl9pbml0IGZ1
bmN0aW9uLiBNYW55IHVzZXJzIG1heSBub3QgbmVlZCBhbnkgbG9naWMNCmZvciBjb21wYXRpYmls
aXR5LiANCg0KPiANCj4+ICsgICAgICAgICAgICAgICByZXQgPSAtRVBFUk07DQo+PiArICAgICAg
ICAgICAgICAgZ290byBlcnJfbW9kdWxlX3B1dDsNCj4+ICsgICAgICAgfQ0KPj4gKw0KDQpbLi4u
XQ0KDQo+PiArDQo+PiArLyoNCj4+ICsgKiBmYW5vdGlmeV9maWx0ZXJfZGVsIC0gRGVsZXRlIGEg
ZmlsdGVyIGZyb20gZnNub3RpZnlfZ3JvdXAuDQo+PiArICovDQo+PiArdm9pZCBmYW5vdGlmeV9m
aWx0ZXJfZGVsKHN0cnVjdCBmc25vdGlmeV9ncm91cCAqZ3JvdXApDQo+PiArew0KPj4gKyAgICAg
ICBzdHJ1Y3QgZmFub3RpZnlfZmlsdGVyX2hvb2sgKmZpbHRlcl9ob29rOw0KPj4gKw0KPj4gKyAg
ICAgICBmc25vdGlmeV9ncm91cF9sb2NrKGdyb3VwKTsNCj4+ICsgICAgICAgZmlsdGVyX2hvb2sg
PSBncm91cC0+ZmFub3RpZnlfZGF0YS5maWx0ZXJfaG9vazsNCj4+ICsgICAgICAgaWYgKCFmaWx0
ZXJfaG9vaykNCj4+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICsNCj4+ICsgICAgICAg
cmN1X2Fzc2lnbl9wb2ludGVyKGdyb3VwLT5mYW5vdGlmeV9kYXRhLmZpbHRlcl9ob29rLCBOVUxM
KTsNCj4+ICsgICAgICAgZmFub3RpZnlfZmlsdGVyX2hvb2tfZnJlZShmaWx0ZXJfaG9vayk7DQo+
IA0KPiBUaGUgcmVhZCBzaWRlIGlzIHByb3RlY3RlZCB3aXRoIHNyY3UgYW5kIHRoZXJlIGlzIG5v
IHNyY3UvcmN1IGRlbGF5IG9mIGZyZWVpbmcuDQo+IFlvdSB3aWxsIGVpdGhlciBuZWVkIHNvbWV0
aGluZyBhbG9uZyB0aGUgbGluZXMgb2YNCj4gZnNub3RpZnlfY29ubmVjdG9yX2Rlc3Ryb3lfd29y
a2ZuKCkgd2l0aCBzeW5jaHJvbml6ZV9zcmN1KCkNCg0KWWVhaCwgd2UgZG8gbmVlZCBhIHN5bmNo
cm9uaXplX3NyY3UoKSBoZXJlLiBJIHdpbGwgZml4IHRoaXMgaW4gDQp0aGUgbmV4dCB2ZXJzaW9u
LiANCg0KPiBvciB1c2UgcmVndWxhciByY3UgZGVsYXkgYW5kIHJlYWQgc2lkZSAoYXNzdW1pbmcg
dGhhdCBpdCBjYW4gYmUgbmVzdGVkIGluc2lkZQ0KPiBzcmN1IHJlYWQgc2lkZT8pLg0KDQpUaGFu
a3MgZm9yIHRoZSByZXZpZXchDQoNClNvbmcNCg0K

