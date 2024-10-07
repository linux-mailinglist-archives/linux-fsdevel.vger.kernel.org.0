Return-Path: <linux-fsdevel+bounces-31226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD36993495
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF46D1C23C29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF01DD544;
	Mon,  7 Oct 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eyVyia8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324441D5AB0;
	Mon,  7 Oct 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321354; cv=fail; b=pjY5DALx4bFrBuEX3kdpLn3p/kQT7a7pJT7LpbDpaIGBp617WPaazL9FKsHT/lE6bfjT1phTy8CVsmmtLahqZhll8zs9JS9UTNYSYuiIJBHaQF9i0Sk+/qRPYwwZ0s28/pn2Yp6NZwUMkjenFVeLD1hwzLmOTujmJyMLYIvpSKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321354; c=relaxed/simple;
	bh=h7ArhJjHfM1bqH+GWpesiLLbQCsNb1ePFbu9jRKWPvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7aWNtr5VjnVnmAmBmuoksivHthKTwDYvAAVkBceaDXCQseofKjSWfNRnEtJh9cEI478YaMdWFtp6KeUWgKClEZCNwXZTL336yUTpgKvXKmfYPQmpV0YuuzgTzx9fNLh4m0Ob0pCtmC4ll0msi25ru4vbL/VcxaRAnSeU8cGVjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eyVyia8t; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497GwH9Y013107;
	Mon, 7 Oct 2024 10:15:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=h7ArhJjHfM1bqH+GWpesiLLbQCsNb1ePFbu9jRKWPvo=; b=
	eyVyia8tm0Wi8KY9SacNpFrLFpdSlOXGA9tV3fIJhJYG+lSVBfl+MHRn3skIfe96
	LpKue52RVBEzGb0TgCA6rxaIOGvWoUeE/cD7/tIEbl6b+LlO4sGhAyVfjLt+NVG9
	yg4WfKgn2zQFeenre0G11wiz6iPh9vbkOPHlXBRdWJtzpWSEQtA5p51XOcbyPUBb
	WcyQlcxYKHQEOqIOT0xFLF4cfLh2ojm4t3JALXWmnoDzUL73RlgqFr7twMo5RhIn
	QykoBgL9BERLhCDggdMKGMGKwwcwhPRiDM/jDDwXQfP/B9tSofDAwHlk0/4XSLAK
	9WVZK8xb/Diiosp88E0YcA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 423fkur0e6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 10:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnmojJzyiXFN+pEMjMtndW/BpM3NB3iuS64gdfCNXnl+cXjctQKCGpjj6/MF4/JQv61wHUhpVsMwjmyYi0i5d5JnjPx8jH+Meqj1fMF39osF+0IL/Xf3cjN0ZbOrUlEJ+YzD3S1Xb+ZWGdzm92V0u8wnLORjv85B7pQPfx3kPUHX53ESocrQSV4mK9gM4rbTJ0hMQ/QwBDlehyOylchA1HKEmWBEQRJ56/KlA80vgcv5kOIFlQ7XxiAw/LfWIr4lxEB8Q29UZmmamk58ijqXYxgOuvftVpROkfQiV4ll46Ls9prR5VVGMFmySHpl6UJ0RA6At+iwrm/M3tgWdP9xSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7ArhJjHfM1bqH+GWpesiLLbQCsNb1ePFbu9jRKWPvo=;
 b=RK0qbQduw2vHt0DYnb8oCWj++fslXhHVe3HaAiwQKIlFTvgbClusDCIEmrnpQx7640ObV1Uy6fuCHdJvyEBUrpOyaCDGCZd/yTKtieDpSvQiJv7my/e21I+84zb3SGSlp5RTgbzT70pRhA+za3YLYVg08fDAiGhKj9YaKQ5XHxGJxn8uLTCR4U09WpKDSp/o7IyyaTeEonbzoL00Vvc0yNsI3DUFqp3D0HjwWbEkvFxLBS6xdPhy6lpytzDuMWlaPipclvFk2lAvvLfXX9yrmTkiuGrRMKrzZqbVtEILrNchqA0Dop+3iU5GbG0RbXxUo3X+0OU+bVxiYPRwZ1TUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BLAPR15MB3764.namprd15.prod.outlook.com (2603:10b6:208:27e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 17:15:47 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 17:15:47 +0000
From: Song Liu <songliubraving@meta.com>
To: Jiri Olsa <olsajiri@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux-Fsdevel
	<linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Al
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
	<mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 1/2] fs/xattr: bpf: Introduce security.bpf xattr
 name prefix
Thread-Topic: [PATCH bpf-next 1/2] fs/xattr: bpf: Introduce security.bpf xattr
 name prefix
Thread-Index: AQHbFRSkfCdOxm4Y2Eq4k2fcm5VQ5bJ6/tIAgACQEQA=
Date: Mon, 7 Oct 2024 17:15:47 +0000
Message-ID: <8F600063-A87F-4613-A0DB-AC964E9C2903@fb.com>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-2-song@kernel.org> <ZwOeXj9GGt7RdqsQ@krava>
In-Reply-To: <ZwOeXj9GGt7RdqsQ@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BLAPR15MB3764:EE_
x-ms-office365-filtering-correlation-id: b8bfdd01-224f-4b6f-d180-08dce6f3af96
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjdhbnJrRk4vYklES2FUbEM3UUVpWk9vODAxaU1xSmg0RUJQZkFmb1RLV1pa?=
 =?utf-8?B?dWZZTXFMbnd0T2g0ZDJaN3crUnlGTmJiYlFlVjFPWmMrSWd6WHFOdlo5T3RX?=
 =?utf-8?B?SzFqS3VWNkVKVGU5SWVQa2c1VWlvNEhyaXNxS2tOanB6bXQxUTB4NXVWSFZt?=
 =?utf-8?B?Q3N0VTRvcmFEdkZRUE1iRlcyenBKanZCRFRKcTRhMENaVUozQjJreVlESnBE?=
 =?utf-8?B?Z05sQ0tVaUgzZkpTVUJKdkxsVEt5M29iRnROL2l0Zm5wWFFlaUNNL01lV0Yy?=
 =?utf-8?B?d1JwTUxnNG9keGN4WWZhb3RlNHhnWGIxQXZSck9lczY0aHZyclJheThNRmta?=
 =?utf-8?B?ZWx3ZEw2bU4rOFVma0tFdnZkOW9JaFVUeCs2QjJDTFVNTVhaM1hSNzQ2aHEz?=
 =?utf-8?B?d1hKNnpYZk5qS3Q5N1lPY2FKMFo1VnNjWjlUNHRhWmorU0FRd0Zic2tRQVpk?=
 =?utf-8?B?NzFBbHdoY1NWR1o5aytkT2wyVDY3TVBYcTdhZS9WdEtzTVhCN2RpcjJwTFJS?=
 =?utf-8?B?b3Vxbit1Y01ualgvSzVGQ21jRlRGZ3ZKYjhDZVY2bis1WVBTc1JSeTBvYlRS?=
 =?utf-8?B?dDRFRTZVOGNWVVAwb2s2Y1lGLzMwWVZrdWJXWDkzY2x2MDdOSThLVTFkS1BK?=
 =?utf-8?B?RzJFeXNvYWZHRHJwYlZlc2g0djBzLzFHaUVnT2o0YkZvc1VSVTA5NC9sQ0Iz?=
 =?utf-8?B?OWdqdHloVUdSeXRPcnlwZFo2cHhQS2Z5aHAwK0JNT2ZHUlZkOGNkZmRocE9r?=
 =?utf-8?B?TDFJTE1oa1UxbVI5dXBnTXhCZmMvZHhXYmZQT28wMUxZSzZhdkc0SVQ2NnpK?=
 =?utf-8?B?cllxekk4WGxnRHBGcW9zMHk0SDJvMWxjdzRqUEd2WlcyMVZtNUU2d3A4bXE0?=
 =?utf-8?B?WElrQVBJeFo1bExWY0ErY2xBOGo3bXk3eXJRc1dqemVkQ1NuY29mZEpXc2Zj?=
 =?utf-8?B?ZVVDTlAvMFZuQXptWGhCOEhCbzFGVHJRYkdSdFlVa3ZOSFpvM3RGTVRab1RY?=
 =?utf-8?B?bjdzV29PUjRCbytMR0VnMXVaci9rclMwaEh4NjJ3ejVjQWlMWEZQVW52dGRN?=
 =?utf-8?B?NEtPN29MTFNSbWJEZUI1K2U1UTViUEdDUU1Mejg1MjRuRGtTUjdONkJJQ2tS?=
 =?utf-8?B?ZXBDUU92eFV2U29pcTkwUjlpajVEQ2VpUTZMZzBrNHJPSEdDazJXTU4xYndh?=
 =?utf-8?B?NXFKaFJ4NHNyMkhZblQ5Y2MxNytySkhkZ0hNMWJzTEdNbjB6YktHSG14YzN3?=
 =?utf-8?B?eWtjS1c0b3p1eDBsM2w2NUhwNERzc2UwcEQ5OW03YVlZMHp2YlN3UldjQmhX?=
 =?utf-8?B?SSs4dElPWU1YQzVySHdLVEY2ZUVXOFpnNUpZbDh0MXVGYjYzYm0zWFlWOTVz?=
 =?utf-8?B?azdRL2VqQnBSSXVpdDRRYXVOeTl6RVpEWkFyb0xpSDdSUkFEUHJlV0JZeXBn?=
 =?utf-8?B?V2JZQm5VUXBINkVoc0R1bXdGQmRmVEoyVjJYS0xMWktkNmkvQVN5aUphZ3hN?=
 =?utf-8?B?aE1HekVhLzAzNDliMjU5RjFCcys4QThTZzl4WWlUTVFrUUkzWGR1aUd1bmlQ?=
 =?utf-8?B?OHlnSU0zTDFQRnhzOXduWmRIREcxTDVKNXQ1MGJXaTJBVGc1eUpEbjVPVndJ?=
 =?utf-8?B?c2FPQjA1SVdjMHBEdUhmU1IzL1RxK0VKYVoxNEt2VENsWHYwbElLQjRhd2VU?=
 =?utf-8?B?Q3lpdm80N29ucG0xQmZKcDJjQlFtSE8xLzVjeTFYT0puMEc5aGppcmtaRU9C?=
 =?utf-8?B?RlZxREJ5L3JxWkxma1F4bkJoT3VUTjd5WmR1YzdJVStmWHM5QlY1V2htbkRi?=
 =?utf-8?B?NVB6TlR2K2pjdWZlSWE3QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWNzZGszUUI2dXZIV3FtcHVBS29STnVzK1daMzZOS0hiazRNbTEzMDF4WENU?=
 =?utf-8?B?ZFMrN3NDbHR5VGdCNjZJckptbU1uWjBTS3o0dzI0aS9TY0paMldadWpNR1By?=
 =?utf-8?B?a0VDZ0haVlJENFFBd0ZBV1IzV3IvcExWZ3FmZDJWcXpTbUQ3bU50UmVKcGl4?=
 =?utf-8?B?TmIvemdBTmErVE55QUwvU0dtRVRtRzlEOGJlVHc0VThQQjE1S2FPb1lQTmxo?=
 =?utf-8?B?N1Nma29iandWTWwvNm1VUXFRNjVTdk1MWE9pRUcvaHBkcm50K0o2cW90cW9z?=
 =?utf-8?B?L1NjUzRWSmszSlVId3ZEZThIUXhhWDViOVZVNjAwMUJPVkc0SERyREUwWUpD?=
 =?utf-8?B?L3FpVXk2cHJURmlaemZ2cDYxMDRKNjJOdElwMWNjYlFrWFJMWURwTzQzYUk4?=
 =?utf-8?B?V0h2WEVVNFc1VW1DbEV4ek1GTk83eXFhb2huNFhOSitTc2Flazlqd0tlWFRW?=
 =?utf-8?B?anB5NEFXMnhoODQ2MmhHUW5tTldMamQ0Z3E4ZEM1R3pZMmNMWlU5dmhhTnBR?=
 =?utf-8?B?MlgxUHVRMzlXWk1KZVV5Wk53b1hzalVBaUJhWlh4ZldCZnM1MjNQdGpib1Nr?=
 =?utf-8?B?aVVHa2cyK0ZaUEFzNG5nNkFQbWJOWStWY1JsbTdrdkxxbXQyWjFqeXhrQXZW?=
 =?utf-8?B?WG9SUGxXK2dRVVJyQ3lWcEViY0NwZXd2TE0zb0FDV05DYmpjTDVnUCttS2I0?=
 =?utf-8?B?a1lZMGFLNEgrWTVRMTNPcFdpYmkzY0V4MjQxM0RnQWhSY1VxcGFEZmhuelJk?=
 =?utf-8?B?LzdFTmdTN0JQZExmZnNFc0RrdE41TlU2bW5wUGZCSVh0aGJWbE91bERpZlRt?=
 =?utf-8?B?aXhLT0VSY1JaMXpFQ0h3ZlYwS3VTL1BGcHQ0bHB1Nkx3eUNlTXQwa1k1bXJy?=
 =?utf-8?B?K0gzU2tBSGJvTUVLTHBVM2RSU2sxOGV6OHcwRjM1QWNhQXc3eGwzWmJhMmg0?=
 =?utf-8?B?Q0JFUko4NHNUSHBaY3RlTW1jZkkvaThSamlxaGszbjROTmJvbmJwUkJaL28v?=
 =?utf-8?B?YXovK09jdDN1enU1SlJ1NjVsT0VRN3p5K244b3VSUGtLZFU0SDhkVnZ5bXVZ?=
 =?utf-8?B?TFZYU3Q4MnFWNnN3L05vWkZ4bGRuU0ZmZlVlbnEyY2FoOWp6T1dCYU9XYjN5?=
 =?utf-8?B?TExUa0gwZ0lxVFl5YkpYY2c4OWxSb0IyckNkazVtS2JacjJOdVAzL1IzbVVy?=
 =?utf-8?B?WFpPUmk3YjRuSjZtRUJzd3BpVEh4NE9pWWNZTWMwcFE4MmlON1FsSHBVeTRZ?=
 =?utf-8?B?eXd6SkNOTmNITm1KU3J2b3FrZnVHN01NZ3RsSG5oZ0pvb09yaWhWU2ZyRWs2?=
 =?utf-8?B?OUQyYkhncVZUSXhhZ1FuUmhwWERXd2g3UXc2ZHYvbWpQV2ZUSkptTUpWVjdJ?=
 =?utf-8?B?NFdER2ttcWxxNmRLd2lxanNmVk4xNno4Z3pUS0ZWekpFQTR4L0dYdGdhRCtH?=
 =?utf-8?B?NDhDcFRocjVKcDVVRGxyVU9uTk5DTC9vb01uMFdIUE9vRmoxLzltN3dSNitN?=
 =?utf-8?B?VENOUFJzdlI0Z04wQ1hZOFZnMTA0TDhYaTQ2bDRqd1RvdmJYQnNkREJHMjAx?=
 =?utf-8?B?UVJmSjdKZlhzeTFSU0x5VEkvdWx0MXNZQzZYdTBCZlVmV3ZJWUcxcm8yQWZ4?=
 =?utf-8?B?TXRMbVVEVUlZVENpcXJ3RGJTckFFRlRWNTNvdnVjNUh6OUVUWXc0d1VmVHpj?=
 =?utf-8?B?WDNuVmEwTkNFdHh3TllEWGZIaXZENXVSL1BBS3ZmZ3BpMTl2ZTljNmtHeVZY?=
 =?utf-8?B?OTNPQURIaDYycDVNR2tLK0s5a1dOalJHdnhVNGhZYUxjRmhJWC9hcFJLdGEz?=
 =?utf-8?B?SmRhTDVHREplbkxiWVluMHhkVlErdTFmQlJPSFRZaHBocDdWV2t2NmM1VldK?=
 =?utf-8?B?bGNsOFQvdzRxdXhCdXAvMEk5ZFZ0SG0xelRnbDdqbWRaNnNnMGUwSHhwdlRj?=
 =?utf-8?B?TUhmdXNvNHlEWFFEQ1BkK1ppbSt2bzZ1bDJxL1FpYVkxbG54d0FjVjBJd3Zw?=
 =?utf-8?B?M1BNKzBtbHRvUWlDUFFtUDVrOURON1dCUGhZN0xXaUJaV1IwbisweGUyUmdI?=
 =?utf-8?B?Mm0rVGlNTzJkZDIyUktNdFZwVVI0L0NmOFBNQVFhN0xtR0x0NlRkVUp2TXEy?=
 =?utf-8?B?dThBdS9ZTTQzOEZPVmM1bU16MTVpVS9ocGhwbUd6RWVwYUdaZGhzVUxWdkUx?=
 =?utf-8?Q?RUSGVgiYNG/QPXQTUx4nGfw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C184EF0ED7342F4592915384CE4A4799@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bfdd01-224f-4b6f-d180-08dce6f3af96
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 17:15:47.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpUadgtb5PQRxj/zpdQ/405rapJ7ECMvnyLmXW3dqZ4AXu4xbWe68RTX/YDYDMkc0vbAVLfduQbQFfxiy6DAtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3764
X-Proofpoint-GUID: p78p2SZIkf8wvqfps-iywGs81z6guR_t
X-Proofpoint-ORIG-GUID: p78p2SZIkf8wvqfps-iywGs81z6guR_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgSmlyaSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQo+IE9uIE9jdCA3LCAyMDI0LCBh
dCAxOjM54oCvQU0sIEppcmkgT2xzYSA8b2xzYWppcmlAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+
IE9uIFdlZCwgT2N0IDAyLCAyMDI0IGF0IDAyOjQ2OjM2UE0gLTA3MDAsIFNvbmcgTGl1IHdyb3Rl
Og0KPj4gSW50cm9kdWN0IG5ldyB4YXR0ciBuYW1lIHByZWZpeCBzZWN1cml0eS5icGYsIGFuZCBl
bmFibGUgcmVhZGluZyB0aGVzZQ0KPj4geGF0dHJzIGZyb20gYnBmIGtmdW5jcyBicGZfZ2V0X1tm
aWxlfGRlbnRyeV1feGF0dHIoKS4gTm90ZSB0aGF0DQo+PiAic2VjdXJpdHkuYnBmIiBjb3VsZCBi
ZSB0aGUgbmFtZSBvZiB0aGUgeGF0dHIgb3IgdGhlIHByZWZpeCBvZiB0aGUNCj4+IG5hbWUuIEZv
ciBleGFtcGxlLCBib3RoICJzZWN1cml0eS5icGYiIGFuZCAic2VjdXJpdHkuYnBmLnh4eCIgYXJl
DQo+PiB2YWxpZCB4YXR0ciBuYW1lOyB3aGlsZSAic2VjdXJpdHkuYnBmeHh4IiBpcyBub3QgdmFs
aWQuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+
PiAtLS0NCj4+IGZzL2JwZl9mc19rZnVuY3MuYyAgICAgICAgIHwgMTkgKysrKysrKysrKysrKysr
KysrLQ0KPj4gaW5jbHVkZS91YXBpL2xpbnV4L3hhdHRyLmggfCAgNCArKysrDQo+PiAyIGZpbGVz
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL2ZzL2JwZl9mc19rZnVuY3MuYyBiL2ZzL2JwZl9mc19rZnVuY3MuYw0KPj4gaW5kZXgg
M2ZlOWY1OWVmODY3Li4zMzljNGZlZjhmNmUgMTAwNjQ0DQo+PiAtLS0gYS9mcy9icGZfZnNfa2Z1
bmNzLmMNCj4+ICsrKyBiL2ZzL2JwZl9mc19rZnVuY3MuYw0KPj4gQEAgLTkzLDYgKzkzLDIzIEBA
IF9fYnBmX2tmdW5jIGludCBicGZfcGF0aF9kX3BhdGgoc3RydWN0IHBhdGggKnBhdGgsIGNoYXIg
KmJ1Ziwgc2l6ZV90IGJ1Zl9fc3opDQo+PiByZXR1cm4gbGVuOw0KPj4gfQ0KPj4gDQo+PiArc3Rh
dGljIGJvb2wgYnBmX3hhdHRyX25hbWVfYWxsb3dlZChjb25zdCBjaGFyICpuYW1lX19zdHIpDQo+
PiArew0KPj4gKyAvKiBBbGxvdyB4YXR0ciBuYW1lcyB3aXRoIHVzZXIuIHByZWZpeCAqLw0KPj4g
KyBpZiAoIXN0cm5jbXAobmFtZV9fc3RyLCBYQVRUUl9VU0VSX1BSRUZJWCwgWEFUVFJfVVNFUl9Q
UkVGSVhfTEVOKSkNCj4+ICsgcmV0dXJuIHRydWU7DQo+PiArDQo+PiArIC8qIEFsbG93IHNlY3Vy
aXR5LmJwZi4gcHJlZml4IG9yIGp1c3Qgc2VjdXJpdHkuYnBmICovDQo+PiArIGlmICghc3RybmNt
cChuYW1lX19zdHIsIFhBVFRSX05BTUVfQlBGX0xTTSwgWEFUVFJfTkFNRV9CUEZfTFNNX0xFTikg
JiYNCj4+ICsgICAgKG5hbWVfX3N0cltYQVRUUl9OQU1FX0JQRl9MU01fTEVOXSA9PSAnXDAnIHx8
DQo+PiArICAgICBuYW1lX19zdHJbWEFUVFJfTkFNRV9CUEZfTFNNX0xFTl0gPT0gJy4nKSkgew0K
Pj4gKyByZXR1cm4gdHJ1ZTsNCj4+ICsgfQ0KPj4gKw0KPj4gKyAvKiBEaXNhbGxvdyBhbnl0aGlu
ZyBlbHNlICovDQo+PiArIHJldHVybiBmYWxzZTsNCj4+ICt9DQo+PiArDQo+PiAvKioNCj4+ICAq
IGJwZl9nZXRfZGVudHJ5X3hhdHRyIC0gZ2V0IHhhdHRyIG9mIGEgZGVudHJ5DQo+PiAgKiBAZGVu
dHJ5OiBkZW50cnkgdG8gZ2V0IHhhdHRyIGZyb20NCj4+IEBAIC0xMTcsNyArMTM0LDcgQEAgX19i
cGZfa2Z1bmMgaW50IGJwZl9nZXRfZGVudHJ5X3hhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwg
Y29uc3QgY2hhciAqbmFtZV9fc3QNCj4gDQo+IG5pdCwgSSBndWVzcyB0aGUgY29tbWVudCBmb3Ig
YnBmX2dldF9kZW50cnlfeGF0dHIgZnVuY3Rpb24gbmVlZHMgdG8gYmUgdXBkYXRlZA0KPiANCj4g
KiBGb3Igc2VjdXJpdHkgcmVhc29ucywgb25seSAqbmFtZV9fc3RyKiB3aXRoIHByZWZpeCAidXNl
ci4iIGlzIGFsbG93ZWQuDQoNCkdvb2QgY2F0Y2ghIFdlIGNhbiB1cGRhdGUgaXQgYXM6DQoNCiAq
IEZvciBzZWN1cml0eSByZWFzb25zLCBvbmx5ICpuYW1lX19zdHIqIHdpdGggcHJlZml4ICJ1c2Vy
LiIgb3INCiAqICJzZWN1cml0eS5icGYiIGlzIGFsbG93ZWQuDQoNClNvbmcNCg0KDQoNCg==

