Return-Path: <linux-fsdevel+bounces-37656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D09F560D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB3616B5CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FAF1F8AF6;
	Tue, 17 Dec 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BntSWMOR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B41F893B;
	Tue, 17 Dec 2024 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459890; cv=fail; b=YX1C5TjIX+o8Ck3sEuzAjyl1/EEFcepG1iv/iLW380+9+Lu/2hMIa6pzMyMYUDfjl8BGI5d6WYMFhea67/IXY007OzjEKH1LLCQF1kGx2v0hq0VPkZ77GR3bvPSS8zbG/yu4T+zl1x5UUp4lfKy6sbqXrF1ntBjkDq1XOXZgnDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459890; c=relaxed/simple;
	bh=mZyoARHrnIOps3OAyfWOiFZdh9yljBBCsvSD8lZ4xBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KzXltx/LNDaCHa1yzW7n5KTyHaOQ2QahTDb94TtMld2aYFPIbq1vItsC42YKJv3eSzXUF8U/fWUlJjCYqiUUksuc9TEGUHIvwS3TZG7Ww/k223O2L1KwhhI45pUBRslSNOj/DeWqJz92zCykhpRdvolw1iWLfgSkrpvxBqVB66A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BntSWMOR; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHGsEMW002529;
	Tue, 17 Dec 2024 10:24:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=mZyoARHrnIOps3OAyfWOiFZdh9yljBBCsvSD8lZ4xBM=; b=
	BntSWMORxgLXEdsWDoEeb2mLnXf3iBE2JwihkSE4KPHXc7UbOQ90CdDRltrIvadi
	e0GLAO+bwwmd/rML7qEuxsUbQDw4vxThjiHeS0nUyTzx5WhoGDRF3A6YC1YtSLao
	Jyzx+2mXyNGzg2dG486uHsmHRhbSi3L3kfrN+0g3huB62MicF0J4R28yNcf60ryz
	VkmFXe8mYolwQZrx3l1AF/3ZTlMafPhUNEsfJzNYukM+LkH6hkeB0zJTn8Yktq5P
	eyUM4jlfcwPkJr67DjmdkyoGkhqDiiiz0oDgBGlnC3Ew2sZop7S3Z6DBBiFy+U6T
	7ivtYtBoCjlHo+s5Vzje3A==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43kbgw1s1e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 10:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIdUUi1hdyLrUS/EUjuhbftDyZFuL381MQPsuFYYITsXJsV7pmmnfANE/P53D+wG00HztFvcegMpryPY76Jtxumu7iV1aPnnQ+esGB99r1LiXLo9afhhtoJGEdzuFZJprv+Nr2rVtB6t5fv3H2UGRC6dcove3V7N9j5KlGalOSADdv7SXmUN/BOvJBzJaLKaBzJ7zvWUWheKt0J8Bp3RWf880vpG89Q+6h+coVIKRlgekHo0JiPY85RYlpNlxQX+cv917orACB6igUr8ZoJPOWSNswB7JNo4ed4Q+Ue1SFwg6i6VCtyf9eEq88WWE6iJxr+7fgWKJZmsYj29ACdd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZyoARHrnIOps3OAyfWOiFZdh9yljBBCsvSD8lZ4xBM=;
 b=ch1OlvXb2x87cuksnMlksHPEmCcoXEE89wGW8MIuGzotSqskso/S4KiGFozgiYL/avZ0ZxqsTMbuXVX/ar2VZzJsJGqQn5dL3QSd22odXxVdPKWqxgOUQAHo98ASJ3QNpd+kjZdnRid6za04ZnYs4e+mLrf1eHoPJOURpYG5cShn3SPM0izL31Yq/F7UFFTA10ecwpMjIJKjyXZGFd9TpDcZFGbQj27a9F/HLByIckMUc80NBAJNI3hK+gfPZOq+9cRksSE7Oozcrz3pNP5Bm+jV1zpWiNMM/OD/Fx+WnJ2JXRNuyg6TED04BZFMTa4re3Z7B39dCNXksrt8yo0gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA0PR15MB3951.namprd15.prod.outlook.com (2603:10b6:806:89::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 18:24:43 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 18:24:43 +0000
From: Song Liu <songliubraving@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM
 List <linux-security-module@vger.kernel.org>,
        Kernel Team
	<kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eddy Z
	<eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>,
        Liam Wisehart <liamwisehart@meta.com>,
        Shankaran
 Gnanashanmugam <shankaran@meta.com>
Subject: Re: [PATCH v4 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Topic: [PATCH v4 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Index: AQHbUE5vyorksDdnSkCocDtARlbXhLLqpv4AgAAaOgA=
Date: Tue, 17 Dec 2024 18:24:42 +0000
Message-ID: <7A7A74A6-ED23-455E-A963-8FE7E250C9AA@fb.com>
References: <20241217063821.482857-1-song@kernel.org>
 <20241217063821.482857-5-song@kernel.org>
 <CAADnVQKnscWKZHbWt9cgTm7NZ4ZWQkHQ+41Hz=NWoEhUjCAbaw@mail.gmail.com>
In-Reply-To:
 <CAADnVQKnscWKZHbWt9cgTm7NZ4ZWQkHQ+41Hz=NWoEhUjCAbaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA0PR15MB3951:EE_
x-ms-office365-filtering-correlation-id: 96fc3d8d-e433-410e-81f3-08dd1ec813bc
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnR4MW1MNkIwTGtwK0FrMGVxc1hySFI5Z1hERWNZV3pRVURrQmVNVy9oNzl4?=
 =?utf-8?B?MW9qNGVSMXF0d0RlTVV6dVRhRkMyQVRYVGJHcmt5RnlqSXNPaENYZ2VZU0cv?=
 =?utf-8?B?M3p5d0loL3pxZnVzUjhvNTlQOWZSTUwzQ2t6SVFSWUdKUDhuVlNOS0hQR0RC?=
 =?utf-8?B?Y09vZHN2OVMzTit0QVNHUnNSd21TVlp4N1BYUldNRk5vTGEyMVZndHBpaWR5?=
 =?utf-8?B?bUN4QVFVV3RNWGtKUzNuaVNHQWkrT1ZBTXFLMUVhYXdVaUJuU1RNdVdpRklV?=
 =?utf-8?B?MnRXbm9IS2Zoc2pXSUVvZWtScGJoZEFoTWNtVUJ1VGI1anJrTnFUa3FSeHIv?=
 =?utf-8?B?eDhCUjNKK2xLWXk4UlZ4V0dmR0F5YTN4ME5QOUJtR2FWL2h2WGVMZEpLODJv?=
 =?utf-8?B?SzgxWFVlU2huNFlVZ3R4eXJ0elIxNGtKU2h5SlVmeklzRi92a2VhSW1QeStO?=
 =?utf-8?B?MzQ1em0rTGNLQzQyYU90eWkzY0F1R2Yyc3A3Tk81NVpxM2RWbkdxZFpKT2hT?=
 =?utf-8?B?aG9HUlA3MzlVemlLaHF0OHR5czk2N2xVcFJjUFVSSUIvZ1NyTUFNbnVyeWpE?=
 =?utf-8?B?dXNMZ3Y2VUdCY25zSGw5aEZsVVdJWExPR3pkNWZOZksxbjJtQ1lDWTJ6cksz?=
 =?utf-8?B?T0hCb1JIa1Z1d3ViV29ORzVadk5SZnppTk45MFlJdEl3NDU0RlREbndaclBt?=
 =?utf-8?B?WUdKQ08yelNzTzFHWTN6c3N0RktUOTZLNm5DODNjWkRsR3ZTakRsK21KbS9t?=
 =?utf-8?B?dGRqV0VnMFpTamw3NUFLdWprR09JOGlNZVg0N1BhSDRLaXpNTDZGR0t0cG1o?=
 =?utf-8?B?RkJ5MHdkVk1QVHJCUmdQRXh3TVBiVzNZVytJVTExWVd3bWtibnRwS1gzSFkw?=
 =?utf-8?B?VFE0TXpWeWFNbWRwQWFPQm4vTCtTbXZVR0VSbElkUFFnV0M5Vm5TVzdoVmNu?=
 =?utf-8?B?dEpHUGNhN3BGT3ZLVk80Vy9lT2JicStnbnl2bXhpRkRhM2wvYUNVWm1uVzR5?=
 =?utf-8?B?TG1FcW5LeEpLMGxMdmhYUEI4ZzNhRzZMMEVEMTJCQjJYUml3Lzd1aC9zbXlK?=
 =?utf-8?B?ZmtqUEVxRFZpRzl2YkxNTVpZQXVaNEJQSTF4K1RLdGh3d2xOOExOaG9lYXl1?=
 =?utf-8?B?VkRMdFVrMFQ3Q2lieXVTc245UjlDQUNUdnJ6SnAxSTRvQ2VjSWZDckFWMTJs?=
 =?utf-8?B?YUdTaTFwNmFqaWZXZzVacm9qSmFVVE9CVW9FKzcyd1lXRjlsSjRXZ3ZVK1VK?=
 =?utf-8?B?NGtZV3dRcVk1dWlKVm5Vc2l5WGxaa3IybU5PdFJNTElES0ZBZUs1T0ZIeWRa?=
 =?utf-8?B?TXJMeWxwT2ZLOThORWRMSUdyczhBWDlYNEI4UHVXYk5vcXBFYUlpczMreXgr?=
 =?utf-8?B?bW5rcWU1UERjMHJDc1JrKzh2WnU3WUZ2dTQ4ZTZLN1RNb01BMDdrR1hVTjlY?=
 =?utf-8?B?MUlwWjhJeGJhdGMxR3htdWFWTCtuMmp6eUx1bkxXcWRiMVlaRFNQTEZMYjNj?=
 =?utf-8?B?V0IyK1B1STkvaVlsZFQwMmlBd3FCMFdTaUpUVFVwYUYwSmtpUTVORVIyV1Nn?=
 =?utf-8?B?Mnd2aTlhR3pUa2lYcjV6dW84NkY5T3VPOFRCNmt2Umc2cE5RZkR3dTNIUXpI?=
 =?utf-8?B?R2pqRFlaaisyQlNpdGYzUUJ3S1B0QXo0TGduQU5nMkdtWmdodmQ3TVZndFF5?=
 =?utf-8?B?RnZQZ2Z5eXRVRXBIUmhDVGxublMzMXZZaDVld1NsaXhzRDUrZVlyR3BUZU9n?=
 =?utf-8?B?dk1Vd1F2R2hDdkhzN3JycW1SbHJRT2lwdTZGQ0R4RTJ3cWdrVW9CNzFlN0xZ?=
 =?utf-8?B?WnV2L0IrNlJXUkg4eThPWFFyTU84bXFJMm15TjJaVi9UQ2x2NWlTcnZwRjJq?=
 =?utf-8?B?cVpkVDNIZFN2NWJCN2xydDZmZG45amEydDEwVDlQc1lENm54ckZuUG9vT2xs?=
 =?utf-8?Q?bFga9H2jCwr3a1gEgGAEaQFFS5laqHJM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akgxUjZ1T3RkODNETTdXZ2hFQnplOVhGcHJHWlpTcm5Odnkzb29KL3N2RlMv?=
 =?utf-8?B?SGtMbGgvczA5U3RqR0h2SzRQQXF6NnNqTTZ3ZHlVcGhJWGtjWnJvS0NlUWl3?=
 =?utf-8?B?Rzh1UEhzNWJuWjlMMTdtUW1uSzRYV3J2amVyNGZsNGRmVWxrUXVKOXlNdUJF?=
 =?utf-8?B?WTdIZVhhSlhEcnpQUi9mRnhxM2lhSjlFT1A4LzRIbWRWbTIvdG1TNDFWbWtB?=
 =?utf-8?B?VDEvRHdEYmMxUVgyN3Q4R3JsZ3BrejVNdXJYTTJOT0hpbzU5Y1NISEZ4dW1u?=
 =?utf-8?B?YlFKZjBzU056Z2RtWUZnVUFQNGN6c3B5aHZoanJvcFRtb00wMEsxRkRQWUNx?=
 =?utf-8?B?cnRQK1JBNm5Bb1JqTVhvNHczY1FvN0dod0ExL0xtL0xoTG55SlJYTUk5bENM?=
 =?utf-8?B?ejQ5U2l2WUxEOXlOT2c3QzRXKzdWQ2ErbHRKbEgvckg2aENRWS9NeGZsckVE?=
 =?utf-8?B?K2tXV1BIeENSaE1GWSs3Ky91TU5ZcFEweEJCWktQdS84Z0RnNy96U3hEZDdD?=
 =?utf-8?B?Z21vYkNQZTlaOHJMeVRPUjhUcldpcGdObXdtS0toaUl3U2VqOWJDVldEUnJy?=
 =?utf-8?B?aks5a1lwdEFFYURiY1pwZnBIVi80K2pIMTF4eWViV3ZlOURaTzdQSk5vaVlQ?=
 =?utf-8?B?dDhVeDAvZmQ1aXBsMUFITnR5eEw4em0rZVl5TEpzSVNydS9Oa3c2bHNLeTNU?=
 =?utf-8?B?bmYrbGQybkh5YW9PYVRkLzB4V3VVdzlkbVg4RC9GMnluTUZBd3daTnFpaHhF?=
 =?utf-8?B?WVBNOVBKVmhmMDZhOVlPZXd5b2dEUXFHb1M2aFVVS1Z3SlJ0dEs5dDU4SEJT?=
 =?utf-8?B?YWdKYW1EdzBBYUZsVjJsV2hHMlB0VFBkVmtWdHlkVlA1c3VxVlUxcXgxa0da?=
 =?utf-8?B?NlMrMlRZL0t2c0YyaTRXYmlTZXE3QmJ6NC8rN0dOb2JYQ3pJQmZWb0VrNHNY?=
 =?utf-8?B?dGhZTmo0bDNRblBWVHV5TVl3amhKSk9LZHpWNHRkSDA3RDhpSjcwK3N6NlNX?=
 =?utf-8?B?UW1NbHk1ay9YZTVjUkpWZ21PSjZ4L2thWmVsTGFneXBDV3lCNVBzc3BVNjdP?=
 =?utf-8?B?ZE9tblRaVjRGOGdzT3RQY0F4elRMVVprQ2RIaUxCV2lyQUkwNmVLaStnazV3?=
 =?utf-8?B?akQwMW1wdjlFQTFTaWNMQzhzWEhqRWhibXpiNHhGQ3NDVzBkZnlocG1sZFcy?=
 =?utf-8?B?ajlScTBZejNRQkVvZGZBazlZTmZUeUcwQzlxTTRHUmdJeXVCWVU4UHhHZlZM?=
 =?utf-8?B?Qm5QTysrSE4zRXV2YlBwOFR5NDlhYXlQTGpwTXFhWXBEbi9jWG0yV3VSUyt2?=
 =?utf-8?B?LzN0V3RtVlg2MVFsL2d2RG1SMm91RDQvRkk5VkZCTVJBcExzdmpYNDVmNVV3?=
 =?utf-8?B?VWFqbHZQVEtWWXJ0TGhEcExXMWJzQ3lXUjZ2MGhmY3hOYmZnM3R6Y2dPUWlp?=
 =?utf-8?B?bnRhOGxkTVYyUlF2blYvdmRiVzlidW1JNk1jaHRtb3d2d0RNNjl6SDNGOUtq?=
 =?utf-8?B?aS9ablM2RHMrdklaeTZJZEVaaTZUcGJYY3lBRFZhWmg4b0JxWCtKUWRxT1pj?=
 =?utf-8?B?NTVyT0ZJRThXZVEzS20ybjBmWTAramxYR3RHMUdGMUZscnFCMnA4Nk9rNlZs?=
 =?utf-8?B?YlJ1U0hJd3pRMTZCK29vbTRhdWgvc0t2ZnphOWt0NGcyUTVCbGVrVGJIQ1p2?=
 =?utf-8?B?aWNWZWk0bk11dUJPb1lZckFSOWtsWjJDVUFIUTgzVHNkUXd6cnQ1UENUQytE?=
 =?utf-8?B?MVpPRU1PcjdNTk51eHBPTnFpTGtQaWY3ZE9YM2JpQnlSZXlpNFZoOTFzaDht?=
 =?utf-8?B?YVVPSmVqQ2dnSjNDMFJTMHgveERiUmdNdEd5NkFFT3pkRG5uVHBIQzJjeWxU?=
 =?utf-8?B?VmFPTW5PYWd5RDJ3OHlvSmxYRHllTUR4eHZRSmh5UExFQTV2K1cyY25jRG81?=
 =?utf-8?B?Q25mSFAwMGtIbXlzZWlDR2JLcTVUVzlPWmRKaytEeW1xM3pOYUlXaFNpd2Fu?=
 =?utf-8?B?dDFYRnFqSDZFSDhCL3FoUitqcVZtUDZkbERpbVdFakRBUjlwZlRoZnhNK1lT?=
 =?utf-8?B?dVVvR3BiZWhsbXE5TW9ScDlpRG5uN0t6M3cwZWlCOHBNTCtSWVF1Q3ZNQWhS?=
 =?utf-8?B?WW5mUjc2Q2dLQnhvaHNPZ3Q2eXYveXFwaHhyQlBTMzYzSnhIRWR3UHMyTXQv?=
 =?utf-8?Q?zNS+3zmhgrxCjTcUG7Q1TBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC0571E35401A1478FCAACD85CC0EAF7@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fc3d8d-e433-410e-81f3-08dd1ec813bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 18:24:42.9485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/GSkJ8SuaPavv/WZiQfzqtYyT/E0GrvxEGpYgBGBtYEV8IfU4B9UKDBOqgADM+ZtvLtzxv3k6DXZkFpX7bC2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3951
X-Proofpoint-GUID: VDdYa0JDJhUDBV2dCbMFRG4xDpsUVthl
X-Proofpoint-ORIG-GUID: VDdYa0JDJhUDBV2dCbMFRG4xDpsUVthl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQWxleGVpLCANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQo+IE9uIERlYyAxNywgMjAy
NCwgYXQgODo1MOKAr0FNLCBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBn
bWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBEZWMgMTYsIDIwMjQgYXQgMTA6MzjigK9Q
TSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0KPj4gQWRkIHRoZSBmb2xs
b3dpbmcga2Z1bmNzIHRvIHNldCBhbmQgcmVtb3ZlIHhhdHRycyBmcm9tIEJQRiBwcm9ncmFtczoN
Cj4+IA0KPj4gIGJwZl9zZXRfZGVudHJ5X3hhdHRyDQo+PiAgYnBmX3JlbW92ZV9kZW50cnlfeGF0
dHINCj4+ICBicGZfc2V0X2RlbnRyeV94YXR0cl9sb2NrZWQNCj4+ICBicGZfcmVtb3ZlX2RlbnRy
eV94YXR0cl9sb2NrZWQNCj4+IA0KPj4gVGhlIF9sb2NrZWQgdmVyc2lvbiBvZiB0aGVzZSBrZnVu
Y3MgYXJlIGNhbGxlZCBmcm9tIGhvb2tzIHdoZXJlDQo+PiBkZW50cnktPmRfaW5vZGUgaXMgYWxy
ZWFkeSBsb2NrZWQuDQo+IA0KPiAuLi4NCj4gDQo+PiArICoNCj4+ICsgKiBTZXR0aW5nIGFuZCBy
ZW1vdmluZyB4YXR0ciByZXF1aXJlcyBleGNsdXNpdmUgbG9jayBvbiBkZW50cnktPmRfaW5vZGUu
DQo+PiArICogU29tZSBob29rcyBhbHJlYWR5IGxvY2tlZCBkX2lub2RlLCB3aGlsZSBzb21lIGhv
b2tzIGhhdmUgbm90IGxvY2tlZA0KPj4gKyAqIGRfaW5vZGUuIFRoZXJlZm9yZSwgd2UgbmVlZCBk
aWZmZXJlbnQga2Z1bmNzIGZvciBkaWZmZXJlbnQgaG9va3MuDQo+PiArICogU3BlY2lmaWNhbGx5
LCBob29rcyBpbiB0aGUgZm9sbG93aW5nIGxpc3QgKGRfaW5vZGVfbG9ja2VkX2hvb2tzKQ0KPj4g
KyAqIHNob3VsZCBjYWxsIGJwZl9bc2V0fHJlbW92ZV1fZGVudHJ5X3hhdHRyX2xvY2tlZDsgd2hp
bGUgb3RoZXIgaG9va3MNCj4+ICsgKiBzaG91bGQgY2FsbCBicGZfW3NldHxyZW1vdmVdX2RlbnRy
eV94YXR0ci4NCj4+ICsgKi8NCj4gDQo+IHRoZSBpbm9kZSBsb2NraW5nIHJ1bGVzIG1pZ2h0IGNo
YW5nZSwgc28gbGV0J3MgaGlkZSB0aGlzDQo+IGltcGxlbWVudGF0aW9uIGRldGFpbCBmcm9tIHRo
ZSBicGYgcHJvZ3MgYnkgbWFraW5nIGtmdW5jIHBvbHltb3JwaGljLg0KPiANCj4gVG8gc3RydWN0
IGJwZl9wcm9nX2F1eCBhZGQ6DQo+IGJvb2wgdXNlX2xvY2tlZF9rZnVuYzoxOw0KPiBhbmQgc2V0
IGl0IGluIGJwZl9jaGVja19hdHRhY2hfdGFyZ2V0KCkgaWYgaXQncyBhdHRhY2hpbmcNCj4gdG8g
b25lIG9mIGRfaW5vZGVfbG9ja2VkX2hvb2tzDQo+IA0KPiBUaGVuIGluIGZpeHVwX2tmdW5jX2Nh
bGwoKSBjYWxsIHNvbWUgaGVscGVyIHRoYXQNCj4gaWYgKHByb2ctPmF1eC0+dXNlX2xvY2tlZF9r
ZnVuYyAmJg0KPiAgICBpbnNuLT5pbW0gPT0gc3BlY2lhbF9rZnVuY19saXN0W0tGX2JwZl9yZW1v
dmVfZGVudHJ5X3hhdHRyXSkNCj4gICAgIGluc24tPmltbSA9IHNwZWNpYWxfa2Z1bmNfbGlzdFtL
Rl9icGZfcmVtb3ZlX2RlbnRyeV94YXR0cl9sb2NrZWRdOw0KPiANCj4gVGhlIHByb2dzIHdpbGwg
YmUgc2ltcGxlciBhbmQgd2lsbCBzdWZmZXIgbGVzcyBjaHVybg0KPiB3aGVuIHRoZSBrZXJuZWwg
c2lkZSBjaGFuZ2VzLg0KDQpJIHdhcyB0aGlua2luZyBhYm91dCBzb21ldGhpbmcgaW4gc2ltaWxh
ciBkaXJlY3Rpb24uIA0KDQpJZiB3ZSBkbyB0aGlzLCBzaGFsbCB3ZSBzb21laG93IGhpZGUgdGhl
IF9sb2NrZWQgdmVyc2lvbiBvZiB0aGUgDQprZnVuY3MsIHNvIHRoYXQgdGhlIHVzZXIgY2Fubm90
IHVzZSBpdD8gSWYgc28sIHdoYXQncyB0aGUgYmVzdCANCndheSB0byBkbyBpdD8gDQoNClRoYW5r
cywNClNvbmcNCg0K

