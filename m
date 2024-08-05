Return-Path: <linux-fsdevel+bounces-25045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E4E9484D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 23:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C43B28163A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3B16D9A4;
	Mon,  5 Aug 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="S6ySxs+3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="LRAOsA/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4D16D338;
	Mon,  5 Aug 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722893248; cv=fail; b=mVfe3S6jp5gxJ9yw7shfJHEyTUC1WhSGKcTRAmm1Oyb6CiO+9zC22ydnxRGB72ZD605Pz1BjB1o2wp0qRxI4/5nn3pchsBB6AMrnJgQWJHHH6t6tpkJfq+F18+muGEeE52eZ0EOzBnzZRMVzJWdzMFBn6DVAcJU+3SiPArGL8Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722893248; c=relaxed/simple;
	bh=KsglK3ykFtycTP8U8+8qRrh3xYuD8z60Os1T6t1oFOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WV/SACsze8le/Ot+iQJ2YwdvMd/JSG12adne0THY+I3HANl/Ln+TqHEkz7DdvQoHWrcPNpU0DBSQ2PYnfY7K1uHS4eKlwdc0hQOwzHjIptiYJ/78oaqSPH6Z1rXlDqTabcK2Ml11ZAorH0pDtiEAKrTixg8tyEOGo5wPFKY9Wac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=S6ySxs+3; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=LRAOsA/9 reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108162.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475J2qaD004206;
	Mon, 5 Aug 2024 14:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=2pjfYwY3Y4hlEOycdcbieTb2OjaJSzkCQuhxmhkLYxg=; b=S6yS
	xs+3ivyc1hKtfbT1DejNetxCe3saPMR17OajWmrDk++g746V3rVEbHKN5lq4+XWt
	Sj6rqGuw/XRbfgcetKaIC/ulUPdzD9jytkyEs2FeeBjRCbXOYOIJEmSX4VhW56O/
	O1Ihw3OA0JWQC2wR26sPWqQ5FHQVJ+pu8JUMt3iA3bruPbYHx3AwCS2uOVNvzKPa
	MhwN3ZRKqMgS1hu7PrOWhUwOI+ZpPUxGmadQzFEMudRLe5AQgCY2kTdF6HOZvZCe
	1DJyW4BGBefxnSqtnRgRcpwc2aSUKfg9THGlOqVn/OgH35zWabsnqieorIN4vB9K
	gsf+KGA15bde1rkmJg==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 40sjt5ckjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 14:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8SFitAt/W48n+k+lbICG33ZAe+YC6k2i6JHWFd/3ovn4HZYqEScWd+cRFJX7INKgiOigUNFnkmTgH89gwBkvJkDN4mQVLIVP9jkRxAbWsA5O/JO0DKkpP0hyGF4lK9IF4UFKLuaIu/HmcXQDHkQje1u7EaOUmP6GZa7N5tF+93IjDNKQTammj0yko0I75yeGXSLTQs+/x3vws2AAEKutLNrRVDZydhj5nBwmLGfXr8vvhIHb5fvUB2ZoUJbwvJ2ocQ4cUasZWE+V6BP6elg1bhc65b8GcxlTLAvZd6cAZeliyemrx6/UsU+6pQcAYZwj8uhlRnnaXj1m9Unm+sEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pjfYwY3Y4hlEOycdcbieTb2OjaJSzkCQuhxmhkLYxg=;
 b=mxa7qNcVUc+npY79L7OvOKt0gLWBi9ZKtjtscvQfE92ZWi9Ngv8dV5x5yX1s/r7duxTJm7jjY0FdrKd/ZAkQM+bTe+zLip+w7Fa2sH5ZSNVdsLO+M/kW93aLEMp220KENYjAni6sX9DaBidFK6ToZeDwIq6eZreRczi75AUHo9Vsz9i3FvMjFHMg+23SeGkSh4YUplxf7JscuGx6ZM7PahG2wNLJ/8eY5Nvh/Pn1Kcsu1N0uIDuYYxX1v+51Sf2A3WlH5jyrDS1P86arjFutVKyAJc/mC6gD2LyFTMXNFHBtzWvsdIbWNJDOwS8oMcuHYl3RHDClej7r2VhTYxZjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pjfYwY3Y4hlEOycdcbieTb2OjaJSzkCQuhxmhkLYxg=;
 b=LRAOsA/9A95nLHZIb5In/7nyF81M7j0DcgaA3ge7Ynyf8Oq1Xs1f/fQ7WxyzY4uSkuSuLWE/I8UXdxwl2inaQ2uK2qdIXxKRoNtpZE1QK4oVqWaIMIucY19BUhtlZm5fTLXjq62m1ug+eI7LL+ksP+3dDPyGFdUoZL2T0bVu6xg=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by DS0PR05MB9678.namprd05.prod.outlook.com (2603:10b6:8:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 21:27:10 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 21:27:10 +0000
From: Brian Mak <makb@juniper.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman"
	<ebiederm@xmission.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
Thread-Topic: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
Thread-Index: AQHa5oJN0OUvdCow60G/Xu8XfVXMurIXX7SAgAGUvoCAABS4AIAAJjmA
Date: Mon, 5 Aug 2024 21:27:09 +0000
Message-ID: <7EF72FC0-095B-41EB-BA71-238ADF38D2FA@juniper.net>
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
 <20240804152327.GA27866@redhat.com>
 <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
 <E3873B59-D80F-42E7-B571-DBE3A63A0C77@juniper.net>
 <CAHk-=whGBPFydX8au65jT=HHnjOCCN0Veqy5=yio6YuOiQmJdw@mail.gmail.com>
In-Reply-To:
 <CAHk-=whGBPFydX8au65jT=HHnjOCCN0Veqy5=yio6YuOiQmJdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|DS0PR05MB9678:EE_
x-ms-office365-filtering-correlation-id: cfbc33da-57db-4239-b1ef-08dcb5955d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LDbwmjnMMFI1BkqfQwEwTQvG7WDrrZZ5Z0pZ406T73GzCW0obM/jzAr3RZcJ?=
 =?us-ascii?Q?jCNOp7ibDedxe1a13cYFn/Kl40N8OV1ah6FxaN0NGRAKvSjtrGZlqrfGawiD?=
 =?us-ascii?Q?4PS6t/Mam0hWNAaqHeXaZ79tTYsE9Lr8DwbPT4td03UwO5O3Li2cck3nSgYr?=
 =?us-ascii?Q?CbS8oHfC/hpF5719HswhXCdZXb8cbz8znj0Wc1AxyAUCWsZUdO4zqKUSW6c5?=
 =?us-ascii?Q?fx7zJ3bJpQtB0VmRdzEptirLJYQ4BckWF9YQcpTrRQ+RpG4qrznPDqZiERnW?=
 =?us-ascii?Q?Pe0I7EXL3PJJwBkbS7WAzkl7Jj+1Q9MVoQCkds6OU74cHVOVXP/loiJhNqcl?=
 =?us-ascii?Q?luP44fbI3SvfCvUXiYo1+ITzPieD7s1K2ok3Krnjm+xfdlAXKFihK9KNfOxM?=
 =?us-ascii?Q?B2U4n+B/NWnLHF3qLVpxERLdtQdBIp/Lgy1t4EoEZeAuNUGBk6NkbPG926Le?=
 =?us-ascii?Q?UBVQYvVWdUAQIjsVGWRKlrR4Hbh0QHENiiZcLhBbmBPGm7mYxFa7Djf8MSk6?=
 =?us-ascii?Q?lGV0rQM+iCw3CwGwIWYF71OfNcSr88n7Igw2BNoR4wohWUWJ/3B4JKEyttRn?=
 =?us-ascii?Q?ZI77yAYxlRm06o/MkomYFV+U+2WD6jFIpYJbZhv8bx1L12deTibg9NIU9acm?=
 =?us-ascii?Q?Uyq0ckFforhA40+bYEje4ST/45P2QzzKZOY9afFOAm0ZUwy+2co6dtFGywqT?=
 =?us-ascii?Q?lm+0hzVBS+jmUYTbblmPMFse5tyyaSYBAXJb27MYQms6VcWfH7xD2oTnCXBX?=
 =?us-ascii?Q?hn1DeWjm4u2yxmr4aOZ5jPIUAkVvyN8k5c8WQSXhq4MrKKZeQ09khW65Mxdv?=
 =?us-ascii?Q?j0UvrBIyFh60sVYp4LGq+LC08jjRqaYcOC4TNJ+c07fv6IPH84Ky5Amgvp1F?=
 =?us-ascii?Q?2uV2+0SUPMQk8dUL7c3dGAKAMCvjzA3k7qn51XKWYBvKjc49X8fkjBNICwji?=
 =?us-ascii?Q?LX9YJffBTxS7rZJqle0myPaCLw9d3lm+V2s1TuarzxU0VYksX5qCRW9dZZLe?=
 =?us-ascii?Q?zBN4QEMPbdhtZ9PLipZVTQW0/vtQTH3A3KJEJbTXWUQMOhm0b4H5JGP8gb10?=
 =?us-ascii?Q?nsT3Z1+0EK9F44oHKPXiGQqpBnpqJGpBm6UWZJ3B3/FT4/9A7muxoYyG8KHb?=
 =?us-ascii?Q?KL2md/hHIODT/M3rVf0bveX95Fyf07jw3kuXUpPHNnCWQEK6LwmX/V9EMLBj?=
 =?us-ascii?Q?6/mpU0XqmifTgiwFy2UZCDbtVHWIC0/yTyxXJjWia6e2pvnhJ1k1wEGg1Mr/?=
 =?us-ascii?Q?VGSzFuOkegjqFkjUfDcbYqmpmoxvbsRlM1clXzA8Al6523YiJH5LJAYeZtBY?=
 =?us-ascii?Q?hWlYFOniPrU6P1hJGDFns6LnZ1oeJ0e1n3qCaQMu2OKAFAk1TdLAg+SJ4dlw?=
 =?us-ascii?Q?Kw8kGwY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XmR/3BLkgUu5uYE/YRDxq1Ijp1VMz8GvPd0KjN+R06Egx0f0ON+0D4gGG1wg?=
 =?us-ascii?Q?5rgrcbm1TzbcTIpTa7Dby2LMR8IjQhppkzTG+2KeycBRX+RvE2cMtS+CqnW3?=
 =?us-ascii?Q?3R2MEvXVexmFQ8d1EFQj3F92mIvlUXoJ8CkAm4Ma1OMv0cqfex4pLBoqwUIf?=
 =?us-ascii?Q?IFV2fk4z4NP+5eS4h5bBaBGZ0tmui1jW2hsSZUbO/4QbM6BKx0fy9JbvdBLA?=
 =?us-ascii?Q?4x9P++2EqIrhDQOkgsAD4x+BbOxYRztKvHAYTo0w9YzYAZqEMHPCLBXJ7tOf?=
 =?us-ascii?Q?P4r6PSkUjdfR4dgIg3p/U2HwCy49uLXTI2NP/IJ7kEj814tQOR06ZbRj2iu6?=
 =?us-ascii?Q?KQYx+rlB4ePQMDBTBAncsw+pOkWJjo2FqSXmW6TV9cX+LuUh6sDAwATCk+ds?=
 =?us-ascii?Q?+35wSrqe5Vlm2adX3WwpDqfFoNBjdVqDJcfIOhBwIcuweF1RHkha6zo/mqqc?=
 =?us-ascii?Q?qhWxbAd/foD4eJUovfxEcpZWavlrUrVct4K+LRs0TEp3rr7meyGnZQf6D0iE?=
 =?us-ascii?Q?C8VcQ2bF/iBfJZqGeU4KiPe35ICAx7YTdyJlY5zLZvFx4Nts77JTblV4QyVj?=
 =?us-ascii?Q?3LbwbQZYQRyXbDIrxjaVTMpXp6sXhK0VCEISpNM5kJ4IEV7bxDY90JBKBDak?=
 =?us-ascii?Q?/mh6xh6jgf3dtkt3irTuwq25YPRcJjrVjXjCEqwf4df3A7+0DQrGeIdjFOgj?=
 =?us-ascii?Q?pimPKF/wgVJdeq7qwxcssa9qLSQm+yDqTh86gCtY6XukiVwRkik986RTwiVY?=
 =?us-ascii?Q?8KK7ffjCoEpOcCM8BjYJrsoufUi3y2uXt+XWlGkldUg3adfbiL7ua3djSxxu?=
 =?us-ascii?Q?dqOFxvUtEj+N8acb8f0czy8F7//YUf6vbXhEBNBWnwv1aeHd66RsM2be5E88?=
 =?us-ascii?Q?hniD84g2UVdqT2PAimJofBLkxlVYNhFLdKDTwON50YFM/UFVHVj/0coZt5lE?=
 =?us-ascii?Q?TBVvH2dOaZ0dQ/Zxuaj7WO6SU4OgfskbZoL7fC3g/ipPpYee3KCXv+L4ddsl?=
 =?us-ascii?Q?SN6bh/euuylUTbpzOLQ1naXMttFnglfWxRP7FpOY8MQEah7eiWEz/oezes1i?=
 =?us-ascii?Q?RnpzWQcOPy9QdNf/m+0WIsmm3XXRPBab3f7TFJj3RgEwm4v25PRFjEkbpUmt?=
 =?us-ascii?Q?XiFh7iptyLwoj40dqIjg+nLFsKwOzzDdCU/xlkrJdHzX+PV5ZojRJBATnsVL?=
 =?us-ascii?Q?ahwluIDd6DzQcyH62LJXCe28mCJJYFEXr7J60F7DPQpFkULbO2WCyqIHwC5h?=
 =?us-ascii?Q?wL/3KG2lwVnEOKMvNR/0lxV+fSnsOBO2dhUyDe/qhmoaz1JuPsz74gIpWhqb?=
 =?us-ascii?Q?/f/XHn/KUSjo4iiHi2KoLRrWePKWJSKNn2hd8uirkFc1WIrKjAMEfqb03nF/?=
 =?us-ascii?Q?UDstBuyXcyUjr9lRvNwEhxzuIgj+evHR4jcM1AtnBQCClIhsWA+vjoxsx5lF?=
 =?us-ascii?Q?2svicP+edWA43D9zvNu544NAiXiae8BD3WYD09Kbpp43LMheVFbJ1I3uuaAo?=
 =?us-ascii?Q?MC+m9hEVvd4TIR1k1cda1XQhIYWRgggfmb02aQkJAZiw34xnjhUSsK452TXx?=
 =?us-ascii?Q?4882YpZ93Zitp+qmTVVeFu7/QLWECKLO7PG5xcqM?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F760BA8E508318499C2C067FC3EB0F38@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6743.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbc33da-57db-4239-b1ef-08dcb5955d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 21:27:09.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sq+LlslNYTxjdAJF/Vo0bHFYcmukyM715F+3yrxsuSV9pXLx9YasJU+I2ZjCUIfSYoFDVGrfmQ7NX3w5Zp8Jpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9678
X-Proofpoint-ORIG-GUID: AqfRaCal9FQ7G0tTCrIoKS9Rc26xCDx7
X-Proofpoint-GUID: AqfRaCal9FQ7G0tTCrIoKS9Rc26xCDx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_09,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 adultscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050152

On Aug 5, 2024, at 12:10 PM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:

> On Mon, 5 Aug 2024 at 10:56, Brian Mak <makb@juniper.net> wrote:
>>=20
>> Do you mean support truncating VMAs in addition to sorting or as a
>> replacement to sorting? If you mean in addition, then I agree, there may
>> be some VMAs that are known to not contain information critical to
>> debugging, but may aid, and therefore have less priority.
>=20
> I'd consider it a completely separate issue, so it would be
> independent of the sorting.
>=20
> We have "ulimit -c" to limit core sizes, but I think it might be
> interesting to have a separate "limit individual mapping sizes" logic.
>=20
> We already have that as a concept: vma_dump_size() could easily limit
> the vma dump size, but currently only picks "all or nothing", except
> for executable mappings that contain actual ELF headers (then it will
> dump the first page only).
>=20
> And honestly, *particularly* if you have a limit on the core size, I
> suspect you'd be better off dumping some of all vma's rather than
> dumping all of some vma's.

Oh ok, I understand what you're suggesting now. I like the concept of
limiting the sizes of individual mappings, but I don't really like the
idea of a fixed maximum size like with "ulimit -c". In cases where there
is plenty of free disk space, a user might want larger cores to debug
more effectively. In cases (even on the same machine) where there all of
a sudden is less disk space available, a user would want that cutoff to
be smaller so that they can effectively grab some of all VMAs.

Also, in cases like the systemd timeout scenario where there is a time
limit for dumping, then the amount to dump would be variable depending
on the core pattern script and/or throughput of the medium the core is
being written to. In this scenario, the maximum size cannot be
determined ahead of time.

However, making it so that we don't need a maximum size determined ahead
of time (and can just terminate the core dumping) seems difficult. We
could make it so that VMAs are dumped piece by piece, one VMA at a time,
until it either reaches the end or gets terminated. Not sure what an
effective way to implement this would be while staying within the
confines of the ELF specification though, i.e. how can this be properly
streamed out and still be in ELF format?

> Now, your sorting approach obviously means that large vma's no longer
> stop smaller ones from dumping, so it does take care of that part of
> it. But I do wonder if we should just in general not dump crazy big
> vmas if the dump size has been limited.

Google actually did something like this in an old core dumper library,
where they excluded large VMAs until the core dump is at or below the
dump size limit:

Git: https://github.com/anatol/google-coredumper.git
Reference: src/elfcore.c, L1030

It's not a bad idea to exclude large VMAs in scenarios where there are
limits, but again, not a huge fan of the predetermined dump size limit.

Best,
Brian Mak

>             Linus


