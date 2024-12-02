Return-Path: <linux-fsdevel+bounces-36277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E79E0A3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 18:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7275E163E18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A41DC19A;
	Mon,  2 Dec 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="K+bs8LdK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4E1DAC97;
	Mon,  2 Dec 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161124; cv=fail; b=ngaM3i+LKzt7XVKGJVgPJHXHYm4PzWVLFNI+3ccWCASLfnJy1KJWiY+LnrPUIlIU+CFG0ybQhY4cJFDn/wwdx3DIqdPu786/0qMKfU1igaOzFRkHrP4mwhaGSn2Ec1BWNurKNzmCYkkatKYYAZkLLiRS4BNoM3ww2XtiSPR3hzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161124; c=relaxed/simple;
	bh=xBmYlKRhY+AvqDYj/ObnKuYOJHjRQUqKHXtzU/ffiLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=roR/UvSaVLrnH3LBEG5PzW2AMF+6JL00yvl9MdvYSMR2mpfCFMGf1Rl+OKZKy9PktNySvf6NkQpcxoltaaFuk1v61nNSrK7fFVobr5Bz2qj3abz5G9ukHrXS6Epm2yv8dKOS+nA3VebHhBujmSUd6fNcG4niQro5STLoNCJ038c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=K+bs8LdK; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Gwi7V020269;
	Mon, 2 Dec 2024 09:38:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=xBmYlKRhY+AvqDYj/ObnKuYOJHjRQUqKHXtzU/ffiLY=; b=
	K+bs8LdK5IBIheuH7YTIA2ptzhL548NHCSTsbj/L6GxKuBydxIzn830So06QHnqX
	BMVAOWCzdxhMWHNtBf5XIGciwLxtrE9OAI2jpWuE9cOrj34k5o95COqpafa797CM
	7h8Uz+rvlwxP7B2+342HhT28/WCHDGoRQhwRsMvToTuGk/VcDwHpI3MyM9IiDPJV
	Qmj9vXl6IM4z0RBCE6AFKf7m8tseMgmNjTa0Xhza6S0a33JmZi2uiNXsvHJhshbw
	2qSxFcZX+8dWb0hB0BenndYdM6QVn1GosTkE3LC72Tn6Z6ZR6oiYgjIdfnM+xCkX
	AFqap3dbFbAx9x/6wF2b1g==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 439962uc93-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 09:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwMTpS6ltLfhjZsspSmf8oMtrKQVdJMFeRtqb1gUE0yzy3HGqIpXhDG/xWFxvjhfIybte/nW4NpdX3DI+7XvevZ7PCkusqVH2MQrcC+iXLSdlEJp//uYsT9UZGpnnPhBHouPAe5do7fTNBod8a37mEUYL9+t1bGe1Wj6VMfGwdwXK9aPNgXep9pl7CknfOO0RSqDtkvJWAHK/R1JzzvRfaaDjSa5tTNroIJWe6aNBDUjWPZtI0HrphF/mwmazpJuN+fHJd8qWc9DwXnzpRSmmukZAZTh/g7qWmqVAUGXKW4j5OPoQBRa9r5y/asGKmOxpnI5fIIB+Hx/xig91xZI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBmYlKRhY+AvqDYj/ObnKuYOJHjRQUqKHXtzU/ffiLY=;
 b=lzXqamrxvm3MKpblv7KqXptCZc0dygWxQ6r4mCDU7lnhGPDIP3rZpSTNeOzHjGZ/QMzSyb51YmeOj86HEm32+yB0wbGeVcZiD5G2hGKYrZlUk2m3LGM/LVipwpEiva+IS+c+rNb5fkuqvL+8FJVVgg0YUWlOt4+sQ91a+LTpwcKfLKp2ixr5x0/gsYfPNnCCZSACuruBj0hI87nibR0yHGuY7WIeYOIelGST5zs7366H1hQtmZXrT/zGUIOuZ8adIvom1C2/x+ixEyGXxUyAVtPKhyFwijxtzEYILaFjRUKNkS5llZhlz9hGUzpeTy2+3DWGPGc9kFZYeg/ERYpu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BLAPR15MB4019.namprd15.prod.outlook.com (2603:10b6:208:274::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:38:35 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 17:38:35 +0000
From: Song Liu <songliubraving@meta.com>
To: Jan Kara <jack@suse.cz>
CC: Song Liu <songliubraving@meta.com>,
        Alexei Starovoitov
	<alexei.starovoitov@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>, Song Liu
	<song@kernel.org>,
        bpf <bpf@vger.kernel.org>,
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
        Christian Brauner <brauner@kernel.org>, KP
 Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        "repnop@google.com" <repnop@google.com>,
        Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify
 fiter
Thread-Topic: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify
 fiter
Thread-Index: AQHbPTJZqeNX/hCyTk2z4ZUDy/y7a7LF4v0AgARvTICAABfpAIACjCGAgAZRRAA=
Date: Mon, 2 Dec 2024 17:38:34 +0000
Message-ID: <50444DD4-34E5-4F75-AE02-5DF1D28EF12E@fb.com>
References: <20241122225958.1775625-1-song@kernel.org>
 <20241122225958.1775625-3-song@kernel.org>
 <CAOQ4uxhfd8ryQ6ua5u60yN5sh06fyiieS3XgfR9jvkAOeDSZUg@mail.gmail.com>
 <CAADnVQK-6MFdwD_0j-3x2-t8VUjbNJUuGrTXEWJ0ttdpHvtLOA@mail.gmail.com>
 <21A94434-5519-4659-83FA-3AB782F064E2@fb.com>
 <20241128171001.xamzdpqlumqdqdkl@quack3>
In-Reply-To: <20241128171001.xamzdpqlumqdqdkl@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BLAPR15MB4019:EE_
x-ms-office365-filtering-correlation-id: 080c84d0-fa9c-49a6-8c98-08dd12f825b8
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkZEL2Y3QzlibEo2eWp6Ym1zNE91dWxrbmUyT0lramY2S1pnREo5OWtWam1P?=
 =?utf-8?B?NG1FelpvL2h1eGZhSk5WTWl6RnVsSW92ekIzSEcrWDVFK2sxS1MrcXBKYkwr?=
 =?utf-8?B?TzhTb3VTMHdtMnJTME5qMHNqSG5HRUF6VzlOQWo3bkFOMFFrL3V0OXNuMXN5?=
 =?utf-8?B?WWlIRUlKZ29IazltN1VodWdvQVdzMEwzN1ViRzlOZlQrSjl2a3NPK1BTUWgv?=
 =?utf-8?B?QitKdytZN1dXZWlnODhyVTJuSFBreGZnRy8zekVFY3cxcGpGOVFhcUttTGxL?=
 =?utf-8?B?MlNuZlJOd1Nqbi9vWVUvZ2FGdHFEUGZlRElDTmdCdVFhOUFONUN1TVRuVTR2?=
 =?utf-8?B?RUdZY2lzY1FVVS9ObDh6OW5HSmFkMDArd09pdEc3S2UyZVZMelNDdjdXSGw3?=
 =?utf-8?B?ZHJFNmkxSFNaRWI4elF5WWY3T1czYzZIMFRGZjQ3ay9LWitxMGwxc1VaWm85?=
 =?utf-8?B?UW1Jb3Z1RnU1QjB1d2czbXFwWlN5K0RoRXB1Z1NCVHZmcTlaZlFOcjdVNCtJ?=
 =?utf-8?B?VGJEek8xbkJVY1JtR0YrZ28rU1ZjS2twc2NDZDNhbHVKdHhFSjFLV20vTXZ5?=
 =?utf-8?B?d1BndWdSMitHQ1E4R0ppSkh4WUlnQVdHaTZ0cXoyNy9mTnpYRUxRUHRYMUhN?=
 =?utf-8?B?dk1LTW5rK1VjbFJjVXZ5eDM4ejJLbzRmb3k4bENzQXhhbFloTFpSQWRYVVdu?=
 =?utf-8?B?b2MvUjdpQWd6Vi82QW1JcWhic21DMEVXeFNDUU9VVktiV3ZYait6QVZUZk9V?=
 =?utf-8?B?ZW12eHhIeVFuWTZaeHdwNmo4K3hLaFR2MS9xQTk4UXRRbFkvcm5EeklDWnhr?=
 =?utf-8?B?Z0Y4MDUrSWFTaXh0SU9Jem1QanNsQ3RYN1ppMmQrbGM1OVRmS1ZCSXdPZEdz?=
 =?utf-8?B?QjIwNitjNGdUSDBkYmUwbTU4eCtZZDVjZmd5TGxHMlJXWEVVNmEvN0tUbnBX?=
 =?utf-8?B?SnpMSW5VZWJwdVNRZXM5MFh3TnRJZ09VYVlDd2lxZGEwNDVBSVd5T2x2d2RZ?=
 =?utf-8?B?VG94alpNeU1JSU5SS3RVVjh3TTZQaEJYZjVNd2lUaXhIWnlhT1JtYjVxRWM2?=
 =?utf-8?B?UXZEa1BlQmZJblVhb01KTlo1ZVhpQ0hGcUExUFJSNURoV3FPakJUWDU0Mk5u?=
 =?utf-8?B?K0tlaGhLQUdoVTNZaDh5YUVibU9JQ2NZNCs0SnJ4Sk9DeEthMHJvUDN6N0pa?=
 =?utf-8?B?M1JLMmtiQnB5aExncjBmUGZwcHFsNkRFQ3QvbTMrdjdIRzN3NHlrcFN4MVVN?=
 =?utf-8?B?SEZhUmxaeUpUcUNJZWFQTEpCdWpneUlvSS9mRFVyMENHM3FKY1BaSjdmS2o2?=
 =?utf-8?B?SkcvaVNCb0dCTi9MeWZtRnhpL2tEOFd2S0VaRmQyRGpNRXBVekw4b3dNeFVr?=
 =?utf-8?B?cmpzVk5rVnc1LytQaldZVndxVm5VTGEybTJna3Z3WWVUQXArUzBvcnllNHkv?=
 =?utf-8?B?anloRkNCdjNFUWV3bC95aVhPLytZREF3MmlBaml3WmpWYi9OMXJLQW1RRHZZ?=
 =?utf-8?B?TlI5Uy9JdHorMXZ4cm9GakZoajFaZUhEdUVIaURBL3BHNDVsb2szUnVsdUdj?=
 =?utf-8?B?Y25MY0gzRDF2NTJuOTlvb3BNM2dFcWlwblFZM2V5NzFvKzJmM2pXcVpSQXRH?=
 =?utf-8?B?MHRiZ0R6QmN2S2d1UUJOSEZ1aUl6WjFxa1VOUmcrakNjZGcrSm9JdXNDa2JT?=
 =?utf-8?B?dU1HalFOenVwMUNmQy9uZENaWTR4U3NkOHhCQ0tHOUNsbWMrMXc5cDkzcWdh?=
 =?utf-8?B?SGpETnF1RVNhV082UFpYa3luKzFPWFQ0bHpNVWVQOGYrMmVFNWlJS2tzSGh4?=
 =?utf-8?B?TGtQdzl6SkhGSDBSTXVOejdWR0tZb05HMjBRL1ZtL0d1Uk00bzFMck9GZENS?=
 =?utf-8?B?ZVY3WFMybE1nQ3IwYnRtSGhEUlZpTE01UTdpK3ZGZlBvcnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEMxN2xZZzFyUlFOQy9VYUM5Mm83YStyYkJFYmQrU1lzUVRBTjlWQmxGcnBT?=
 =?utf-8?B?VVg1QTdGVUZSQWV4dkpSSVRDcXVqRjEwSnZBOVpuaHQ1N3FJcHZvd3BxZ0lR?=
 =?utf-8?B?NDdsYnRZVTNBUlhCcmsrMnFxT2t1ZWdlZkplenhrTWJlbnkrejU1S2RUak5w?=
 =?utf-8?B?eXY1V1pZaW9xcmZwS0lOWjV1L3VnRFpjK1dPaXNWQjFNNld5a01XbnNXb0ox?=
 =?utf-8?B?eStXcnVrT3ZETldoWVJGdWNjakhOODRiUGxkLzhOTGxOcEphbm90bks4Ri9a?=
 =?utf-8?B?YkR3QjZWWkpqZGhUdnNqcngwc1dQQ2dIU2QyOXhuUHlFd055bjBTSXZGQVFX?=
 =?utf-8?B?cWJZUmZKOTAzQWdRTTF1TkZEbWtlejVDUWE3ZjRnbDNGTUFXVlVseWZENVIw?=
 =?utf-8?B?aTA5b1V2QXpaNVd3V1NMTDJNUzU4Z1lpbzhtaW11SkhkbE11bWlQMW1oa0pz?=
 =?utf-8?B?Ump1ZU85bUg0NnFJcGprVTNOOHFTOE93ekJON3pjS2M3bmJIWExyeGNGNTAr?=
 =?utf-8?B?R0R2TjZwZGZ6eXVsamhmQUtjNU5GbUdMcjFhNFhYTExWUWNWUjhuZG5OL1lW?=
 =?utf-8?B?RVVsNS9zWTYrM25QZHRpRENkRGVUU0kxRFo3NHRaZnFTM2tyRkw1YkJJQzJY?=
 =?utf-8?B?YUxVdEdNNjlvQWVDMjlXYUJBaG1Kd3dHc24ySGFIZWJuYzFvQTlVSEk5ZWth?=
 =?utf-8?B?T3BqY2h4SWNPUjkrZFV1d1JPM2ZjQnFoTHRXdlYraGsvaFIxRnJLVEpHSllu?=
 =?utf-8?B?Wjk3ZmtjTUlzZGlOcGxlYnB3QnlXOCszSi84NkxubytlNHhzc0dXeks0RGZx?=
 =?utf-8?B?K1Z4ZkRaNktCQlBzVm5oeWNmQ0E0WEphRlRsZTg3QkNURnZ6SG5Fd09UcC9v?=
 =?utf-8?B?OWtpeFZVVnJUc1YvK3dqR00xSE51L29nTUVSRVFYOWF4em01eFkwNFRJQ0lo?=
 =?utf-8?B?NTAwL2tXWGNLQkhCbXljbGZOTGtOMGdRUlMyY2FsalRoUDhKek8wTlFvcjVv?=
 =?utf-8?B?UXJ2eCtCaGttRVBmVWg2cUV5dFBGMVp5NGszbmsxU1hPRjZqWEtMZW1qazRi?=
 =?utf-8?B?NXdzZHQ0MjM0WHZ0NGpMTHJsOGxnV2gxYXdsTjlaTVFqNjVVZDBzMmEwa0JB?=
 =?utf-8?B?R0p1c3ZJcnNlMk9VQ3Y2d3dTYnV4eGlSUmRZenQ1a2tSWllCeVlGK3pSNEl3?=
 =?utf-8?B?d1c4WGNMbnVLZ3FUVzRpc1BJTjJxZHJ3bDVqbTB1b2lpT0hwUklIVFU3bkpQ?=
 =?utf-8?B?WHZvRFNZS2RRQmlFaWo2amozM1c0V1BOcGE0a0loVDkwa0czNnovZ05rUVMv?=
 =?utf-8?B?Y0k1VU9abDVRaUxJKytQc0JZcTVxUEpLcUVDNlFmY09SMHluZ2hyRWtOS1FI?=
 =?utf-8?B?RzVpL25STU9tVlRkWE0xZlh2MkZqUW54TEdlREFFOUpUZk02SmE1SVpZM1la?=
 =?utf-8?B?OVZ4ZjlMbTZ5M3pWTmkwVHhmTElhTlpuUlovZ04zYzU5ckQwSCtnQ3hyTUh5?=
 =?utf-8?B?c2lyMWU0THVsb2ZlN3Z0Q2RxUWVTOGJFYy9UZlgzUkR6SjkwYkc3bkkxeGVl?=
 =?utf-8?B?Z2dIY1NweVc4N3dxTWNuNGdoSmpGOGR5elVORysxSytPcjk3RS85YjF1WEFV?=
 =?utf-8?B?d3NMQU52ZmIvWExFdytGUW04UUlhOE9BVWJYSmc5R1dNMEp3dkRWMkkybzNv?=
 =?utf-8?B?MUpZQUp4dUtZVnNqTGJVY3J4UG1sTmhIOUdKR28vdUdEb3pqUFlVVGo5Y2FH?=
 =?utf-8?B?Z2dpR2hTT3NwS1FhTWY3ajBQRXhYaGR1aFJKLzJMN3liUHVFd053Q09zazZo?=
 =?utf-8?B?NStGMnBKenhvbnpLTjZDQk9uMDJsY3Robzl3RnRoQ2krNURpQlB0Tmk3eGZS?=
 =?utf-8?B?cXJDSXdYT1ZTc1p2SkgyWFV6MDRucXJ5cXJWTllsQ01mUUFvNit0dm04a2ZR?=
 =?utf-8?B?eVk5RGFualNrU1lYK2NFVWdKdnlxMzNjWjNROHBsVHJTNUJWUjIrZjR1am9s?=
 =?utf-8?B?R2VTS0tBQ2FhZHY4NGlFK1dqRk00YXRyS1ZlTTJnUkZ6OEwyZTZvSHBoYkkr?=
 =?utf-8?B?c1lKWmFZNmgrVjBvU2dNblBMdkcyV0oybTRlbmpBNy9CekxWdmpKTzRLdmJn?=
 =?utf-8?B?dUV5UThVNWtKdFdnUUJaMEJCWUorMjNUbDdaVFBpM2RWZTVlK3ZDTXFoZWpR?=
 =?utf-8?Q?AQ//c5Q2lLVA/C1lIp7agEM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <403260747599E54985EC3BBCD5DA9098@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 080c84d0-fa9c-49a6-8c98-08dd12f825b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 17:38:34.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Scw+E+evJJBIMuwd2bXnWWVDIAhsNyEJbPfxgmNaXXUWGi6r5pZ1eeK5R2FGaTFJFPKibw8jK6wSCB9As8VH6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4019
X-Proofpoint-GUID: -RZphlj_lpa_9tGFv5lMCD7x9HpS8RcW
X-Proofpoint-ORIG-GUID: -RZphlj_lpa_9tGFv5lMCD7x9HpS8RcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gTm92IDI4LCAyMDI0LCBhdCA5OjEw4oCvQU0sIEphbiBLYXJhIDxqYWNrQHN1c2Uu
Y3o+IHdyb3RlOg0KPiANCj4gT24gV2VkIDI3LTExLTI0IDAyOjE2OjA5LCBTb25nIExpdSB3cm90
ZToNCj4+PiBPbiBOb3YgMjYsIDIwMjQsIGF0IDQ6NTDigK9QTSwgQWxleGVpIFN0YXJvdm9pdG92
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+IA0KPj4gWy4u
Ll0NCj4+IA0KPj4+Pj4gKw0KPj4+Pj4gK3N0YXRpYyB2b2lkIHNhbXBsZV9maWx0ZXJfZnJlZShz
dHJ1Y3QgZmFub3RpZnlfZmlsdGVyX2hvb2sgKmZpbHRlcl9ob29rKQ0KPj4+Pj4gK3sNCj4+Pj4+
ICsgICAgICAgc3RydWN0IGZhbl9maWx0ZXJfc2FtcGxlX2RhdGEgKmRhdGEgPSBmaWx0ZXJfaG9v
ay0+ZGF0YTsNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgICAgcGF0aF9wdXQoJmRhdGEtPnN1YnRyZWVf
cGF0aCk7DQo+Pj4+PiArICAgICAgIGtmcmVlKGRhdGEpOw0KPj4+Pj4gK30NCj4+Pj4+ICsNCj4+
Pj4gDQo+Pj4+IEhpIFNvbmcsDQo+Pj4+IA0KPj4+PiBUaGlzIGV4YW1wbGUgbG9va3MgZmluZSBi
dXQgaXQgcmFpc2VzIGEgcXVlc3Rpb24uDQo+Pj4+IFRoaXMgZmlsdGVyIHdpbGwga2VlcCB0aGUg
bW91bnQgb2Ygc3VidHJlZV9wYXRoIGJ1c3kgdW50aWwgdGhlIGdyb3VwIGlzIGNsb3NlZA0KPj4+
PiBvciB0aGUgZmlsdGVyIGlzIGRldGFjaGVkLg0KPj4+PiBUaGlzIGlzIHByb2JhYmx5IGZpbmUg
Zm9yIG1hbnkgc2VydmljZXMgdGhhdCBrZWVwIHRoZSBtb3VudCBidXN5IGFueXdheS4NCj4+Pj4g
DQo+Pj4+IEJ1dCB3aGF0IGlmIHRoaXMgd2Fzbid0IHRoZSBpbnRlbnRpb24/DQo+Pj4+IFdoYXQg
aWYgYW4gQW50aS1tYWx3YXJlIGVuZ2luZSB0aGF0IHdhdGNoZXMgYWxsIG1vdW50cyB3YW50ZWQg
dG8gdXNlIHRoYXQNCj4+Pj4gZm9yIGNvbmZpZ3VyaW5nIHNvbWUgaWdub3JlL2Jsb2NrIHN1YnRy
ZWUgZmlsdGVycz8NCj4+Pj4gDQo+Pj4+IE9uZSB3YXkgd291bGQgYmUgdG8gdXNlIGEgaXNfc3Vi
dHJlZSgpIHZhcmlhbnQgdGhhdCBsb29rcyBmb3IgYQ0KPj4+PiBzdWJ0cmVlIHJvb3QgaW5vZGUN
Cj4+Pj4gbnVtYmVyIGFuZCB0aGVuIHZlcmlmaWVzIGl0IHdpdGggYSBzdWJ0cmVlIHJvb3QgZmlk
Lg0KPj4+PiBBIHByb2R1Y3Rpb24gc3VidHJlZSBmaWx0ZXIgd2lsbCBuZWVkIHRvIHVzZSBhIHZh
cmlhbnQgb2YgaXNfc3VidHJlZSgpDQo+Pj4+IGFueXdheSB0aGF0DQo+Pj4+IGxvb2tzIGZvciBh
IHNldCBvZiBzdWJ0cmVlIHJvb3QgaW5vZGVzLCBiZWNhdXNlIGRvaW5nIGEgbG9vcCBvZiBpc19z
dWJ0cmVlKCkgZm9yDQo+Pj4+IG11bHRpcGxlIHBhdGhzIGlzIGEgbm8gZ28uDQo+Pj4+IA0KPj4+
PiBEb24ndCBuZWVkIHRvIGNoYW5nZSBhbnl0aGluZyBpbiB0aGUgZXhhbXBsZSwgdW5sZXNzIG90
aGVyIHBlb3BsZQ0KPj4+PiB0aGluayB0aGF0IHdlIGRvIG5lZWQgdG8gc2V0IGEgYmV0dGVyIGV4
YW1wbGUgdG8gYmVnaW4gd2l0aC4uLg0KPj4+IA0KPj4+IEkgdGhpbmsgd2UgaGF2ZSB0byB0cmVh
dCB0aGlzIHBhdGNoIGFzIGEgcmVhbCBmaWx0ZXIgYW5kIG5vdCBhcyBhbiBleGFtcGxlDQo+Pj4g
dG8gbWFrZSBzdXJlIHRoYXQgdGhlIHdob2xlIGFwcHJvYWNoIGlzIHdvcmthYmxlIGVuZCB0byBl
bmQuDQo+Pj4gVGhlIHBvaW50IGFib3V0IG5vdCBob2xkaW5nIHBhdGgvZGVudHJ5IGlzIHZlcnkg
dmFsaWQuDQo+Pj4gVGhlIGFsZ29yaXRobSBuZWVkcyB0byBzdXBwb3J0IHRoYXQuDQo+PiANCj4+
IEhtbS4uIEkgYW0gbm90IHN1cmUgd2hldGhlciB3ZSBjYW5ub3QgaG9sZCBhIHJlZmNvdW50LiBJ
ZiB0aGF0IGlzIGEgDQo+PiByZXF1aXJlbWVudCwgdGhlIGFsZ29yaXRobSB3aWxsIGJlIG1vcmUg
Y29tcGxleC4NCj4gDQo+IFdlbGwsIGZvciBwcm9kdWN0aW9uIHVzZSB0aGF0IHdvdWxkIGNlcnRh
aW5seSBiZSBhIHJlcXVpcmVtZW50LiBNYW55IHllYXJzDQo+IGFnbyBkbm90aWZ5ICh0aGUgZmly
c3QgZnMgbm90aWZpY2F0aW9uIHN1YnN5c3RlbSkgd2FzIHByZXZlbnRpbmcNCj4gZmlsZXN5c3Rl
bXMgZnJvbSBiZWluZyB1bm1vdW50ZWQgYmVjYXVzZSBpdCByZXF1aXJlZCBvcGVuIGZpbGUgYW5k
IGl0IHdhcyBhDQo+IHBhaW4uDQo+IA0KPj4gSUlVQywgZnNub3RpZnlfbWFyayBvbiBhIGlub2Rl
IGRvZXMgbm90IGhvbGQgYSByZWZjb3VudCB0byBpbm9kZS4NCj4gDQo+IFRoZSBjb25uZWN0b3Ig
KGhlYWQgb2YgdGhlIG1hcmsgbGlzdCkgZG9lcyBob2xkIGlub2RlIHJlZmVyZW5jZS4gQnV0IHdl
DQo+IGhhdmUgYSBob29rIGluIHRoZSB1bm1vdW50IHBhdGggKGZzbm90aWZ5X3VubW91bnRfaW5v
ZGVzKCkpIHdoaWNoIGRyb3BzIGFsbA0KPiB0aGUgbWFya3MgYW5kIGNvbm5lY3RvcnMgZm9yIHRo
ZSBmaWxlc3lzdGVtLg0KPiANCj4+IEFuZCB3aGVuIHRoZSBpbm9kZSBpcyBldmljdGVkLCB0aGUg
bWFyayBpcyBmcmVlZC4gSSBndWVzcyB0aGlzIA0KPj4gcmVxdWlyZXMgdGhlIHVzZXIgc3BhY2Us
IHRoZSBBbnRpVmlydXMgc2Nhbm5lciBmb3IgZXhhbXBsZSwgdG8gDQo+PiBob2xkIGEgcmVmZXJl
bmNlIHRvIHRoZSBpbm9kZT8gSWYgdGhpcyBpcyB0aGUgY2FzZSwgSSB0aGluayBpdCANCj4+IGlz
IE9LIGZvciB0aGUgZmlsdGVyLCBlaXRoZXIgYnBmIG9yIGtlcm5lbCBtb2R1bGUsIHRvIGhvbGQg
YSANCj4+IHJlZmVyZW5jZSB0byB0aGUgc3VidHJlZSByb290Lg0KPiANCj4gTm8sIGZzbm90aWZ5
IHBpbnMgdGhlIGlub2RlcyBpbiBtZW1vcnkgKHdoaWNoIGlmIGZpbmUpIGJ1dCByZWxlYXNlcyB0
aGVtDQo+IHdoZW4gdW5tb3VudCBzaG91bGQgaGFwcGVuLiBVc2Vyc3BhY2UgZG9lc24ndCBuZWVk
IHRvIHBpbiBhbnl0aGluZy4NCg0KVG8gZ2V0IHNpbWlsYXIgbG9naWMgZm9yIHRoZSBmaWx0ZXIg
KG1vZHVsZSBvciBCUEYpLCB3ZSB3aWxsIG5lZWQgDQphbm90aGVyIGNhbGwgYmFjay4gV2Ugc2hv
dWxkIGFkZCB0aGlzLCB0aG91Z2ggd2UgbWF5IG5vdCB1c2UgaXQgDQppbiB0aGUgc3VidHJlZSBt
b25pdG9yaW5nIGNhc2UuIA0KDQo+IA0KPj4+IEl0IG1heSB2ZXJ5IHdlbGwgdHVybiBvdXQgdGhh
dCB0aGUgbG9naWMgb2YgaGFuZGxpbmcgbWFueSBmaWx0ZXJzDQo+Pj4gd2l0aG91dCBhIGxvb3Ag
YW5kIG5vdCBncmFiYmluZyBhIHBhdGggcmVmY250IGlzIHRvbyBjb21wbGV4IGZvciBicGYuDQo+
Pj4gVGhlbiB0aGlzIHN1YnRyZWUgZmlsdGVyaW5nIHdvdWxkIGhhdmUgdG8gc3RheSBhcyBhIGtl
cm5lbCBtb2R1bGUNCj4+PiBvciBleHRyYSBmbGFnL2ZlYXR1cmUgZm9yIGZhbm90aWZ5Lg0KPj4g
DQo+PiBIYW5kbGluZyBtdWx0aXBsZSBzdWJ0cmVlcyBpcyBpbmRlZWQgYW4gaXNzdWUuIFNpbmNl
IHdlIHJlbHkgb24gDQo+PiB0aGUgbWFyayBpbiB0aGUgU0IsIG11bHRpcGxlIHN1YnRyZWVzIHVu
ZGVyIHRoZSBzYW1lIFNCIHdpbGwgc2hhcmUNCj4+IHRoYXQgbWFyay4gVW5sZXNzIHdlIHVzZSBz
b21lIGNhY2hlLCBhY2Nlc3NpbmcgYSBmaWxlIHdpbGwgDQo+PiB0cmlnZ2VyIG11bHRpcGxlIGlz
X3N1YmRpcigpIGNhbGxzLiANCj4+IA0KPj4gT25lIHBvc3NpYmxlIHNvbHV0aW9uIGlzIHRoYXQg
aGF2ZSBhIG5ldyBoZWxwZXIgdGhhdCBjaGVja3MNCj4+IGlzX3N1YmRpcigpIGZvciBhIGxpc3Qg
b2YgcGFyZW50IHN1YnRyZWVzIHdpdGggYSBzaW5nbGUgc2VyaWVzDQo+PiBvZiBkZW50cnkgd2Fs
ay4gSU9XLCBzb21ldGhpbmcgbGlrZToNCj4+IA0KPj4gYm9vbCBpc19zdWJkaXJfb2ZfYW55KHN0
cnVjdCBkZW50cnkgKm5ld19kZW50cnksIA0KPj4gICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGxpc3RfaGVhZCAqbGlzdF9vZl9kZW50cnkpLg0KPj4gDQo+PiBGb3IgQlBGLCBvbmUgcG9zc2li
bGUgc29sdXRpb24gaXMgdG8gd2FsayB0aGUgZGVudHJ5IHRyZWUgDQo+PiB1cCB0byB0aGUgcm9v
dCwgdW5kZXIgYnBmX3JjdV9yZWFkX2xvY2soKS4NCj4gDQo+IEkgY2FuIHNlZSB0d28gcG9zc2li
bGUgaXNzdWVzIHdpdGggdGhpcy4gRmlyc3RseSwgeW91IGRvbid0IGhhdmUgbGlzdF9oZWFkDQo+
IGluIGEgZGVudHJ5IHlvdSBjb3VsZCBlYXNpbHkgdXNlIHRvIHBhc3MgZGVudHJpZXMgdG8gYSBm
dW5jdGlvbiBsaWtlIHRoaXMuDQo+IFByb2JhYmx5IHlvdSdsbCBuZWVkIGFuIGV4dGVybmFsIGFy
cmF5IHdpdGggZGVudHJ5IHBvaW50ZXJzIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+IA0K
PiBTZWNvbmQgaXNzdWUgaXMgbW9yZSBpbmhlcmVudCBpbiB0aGUgQlBGIGZpbHRlciBhcHByb2Fj
aCAtIGlmIHRoZXJlIHdvdWxkDQo+IGJlIG1vcmUgbm90aWZpY2F0aW9uIGdyb3VwcyBlYWNoIHdh
dGNoaW5nIGZvciBzb21lIHN1YnRyZWUgKGxpa2UgdXNlcnMNCj4gd2F0Y2hpbmcgdGhlaXIgaG9t
ZSBkaXJzLCBhcHBzIHdhdGNoaW5nIHRoZWlyIHN1YnRyZWVzIHdpdGggZGF0YSBldGMuKSwgdGhl
bg0KPiB3ZSdkIHN0aWxsIGVuZCB1cCB0cmF2ZXJzaW5nIHRoZSBkaXJlY3RvcnkgdHJlZSBmb3Ig
ZWFjaCBzdWNoIG5vdGlmaWNhdGlvbg0KPiBncm91cC4gVGhhdCBzZWVtcyBzdWJvcHRpbWFsIGJ1
dCBJIGhhdmUgdG8gdGhpbmsgaG93IG11Y2ggd2UgY2FyZSBob3cgd2UNCj4gY291bGQgcG9zc2li
bHkgYXZvaWQgdGhhdC4NCg0KRm9yIHRoZSBzdWJ0cmVlIG1vbml0b3JpbmcgZXhhbXBsZSwgbWF5
YmUgIm1vbml0b3IgdGhlIHdob2xlIHNiIA0KYW5kIGZpbHRlciB0aGUgZXZlbnRzIiBpcyBub3Qg
dGhlIHJpZ2h0IGFwcHJvYWNoLiBNYWludGFpbmluZyBhIA0KbWFyayBvbiBlYWNoIGRpcmVjdG9y
eSB1bmRlciB0aGUgc3VidHJlZSBtaWdodCBiZSBhIGJldHRlciBhcHByb2FjaC4gDQpBbnkgY29t
bWVudHMgb3Igc3VnZ2VzdGlvbnMgb24gdGhpcz8NCg0KVGhhbmtzLA0KU29uZw0KDQo=

