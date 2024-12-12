Return-Path: <linux-fsdevel+bounces-37124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506EE9EDE93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 05:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EF4188912C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 04:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED4168C3F;
	Thu, 12 Dec 2024 04:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="kW/jL+Dp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606D165EE8;
	Thu, 12 Dec 2024 04:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978458; cv=fail; b=OY/jxD6ZXhurAphkD/xzgqLs5EJxux5WYh2zJ2/k5+HMC1O3AZduuI9e+60lPf62BjSvDLa8dvT4kK218vDbC3tm8hC0jfodlMjOJVLJ2SZMH1GQ5vuqhKjdOD39d8jrAiMHHy6Dskmr+RZsQkpWa/avVUQqoAc17uqqlUkRZN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978458; c=relaxed/simple;
	bh=7vlxB3tAyvN+fB+/xbtXwh43vfnR2A3PAKYRbLhQABk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DSByFweajmVjNGq/P8t1U0LvFsSFRdJeDYatE0uwVQhPjV4pd/qPnY+IIv3QZp9svPJEczV14BV6tK8MbwRsggJRd+JPl0NBLg+O5pgWpnj9HW7FtOED3Li4wmB85SJsxQew9DHgWw8wDPHj5odADd5+0tbhQ1nRT6C3oWsh17Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=kW/jL+Dp; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBM8DpO004886;
	Thu, 12 Dec 2024 03:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=jnJSmUHo0uRXoYQElZm8FIJM2zCkd8x
	X556x7QuIXos=; b=kW/jL+DpsiY11QTceVQsQyHjyO31LCEFzAGD5xyAXkSWie3
	/EqM07GlnO4qTHDAhRfNoyn6Kvjt50fvrdK5A/hzLDUqZ9Jg8kvQctqGASJ0tjAY
	bUFtmlfFKuXIUhekpVzhbm+JBUfvcky/R1v+ygrLHrRW9rFM8ckoE6Y3pPjD9wko
	MEy8QjSXWhFrKNDagk03AnvOOh28DKt9tzRK75kN0Erb90PmAoDrrKfo0rWP2U6c
	BHuwzAK7O4/jAm9UU2piPmekFVQ4V/QtdBfvpB2emjfqRhpYFe03XONb1zvQBKJg
	tYnkxZbKZ1LuYaVGm261TQ9sPSVbyydcUal//WA==
Received: from hk2pr02cu002.outbound.protection.outlook.com (mail-eastasiaazlp17010006.outbound.protection.outlook.com [40.93.128.6])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 43cc8hv52g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 03:18:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2MUb9qo4vvKx5FLXzSEExvznt6oNmwmUxI6iyysmizk90bJYxnfevIgQWQNgTXz0F33MO10arkttujV6MI23Kfe0ymflwXXxaZ6nWjGCynLhKMJI0EUlsrS9RP5IgnqIGJS9SpDQrXx5eqd+hsHLXTbBkJLyX8PfZrWg0htaui365mYtWStNo7FUVjWvvydbHj/UGUa8wOWohCszhjbafveXztVrnQTtruLDFt8CKca1uT+epvozEfYnOd8EdUdxftWVMjW8LHN75VWWKvEBtrewv8SDLYriCCYuzvbvKx/fHc2kc49ecQL4hlYbPW0UJ4SOAvl2dKtmB9Fn8wNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnJSmUHo0uRXoYQElZm8FIJM2zCkd8xX556x7QuIXos=;
 b=ROrBHdzX5/lVmb2WLP3EmyVjAjjLOogI7ijOQIjq4qZ/+zYEiivQo/HwhMEiV6E8jEhiVQ7tyKHjNCYA6cOFjerM4hfQqraxGXF6aJPxDoxXrfiwI903qxFf4Acq7zNIlHvmA2JpUFDZy7MAQRey0A10lKjVTYG1ljW9uhepG/FBhww7MRd78Dg2ldlFDmG4hHb7OqWm+mMfksQWeMQXUw1arBnj1PYTR62sJrNKiFj/1o8zKh94iyKVHQoDqkWYufT1ka4iDuw+5+2Es5CiH+sNnEpN6yiqY4vbwFIQ+A2ZH2XZkOB8Yg36VqUi05w4trEVyDX7XwfMDVtVTOHlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB6829.apcprd04.prod.outlook.com (2603:1096:820:d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 03:17:59 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8230.008; Thu, 12 Dec 2024
 03:17:59 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_sync_fs
Thread-Topic: [syzbot] [exfat?] INFO: task hung in exfat_sync_fs
Thread-Index: AQHbTAolB2dOUZDQuEWUFNUD0l+44bLh8H2i
Date: Thu, 12 Dec 2024 03:17:58 +0000
Message-ID:
 <PUZPR04MB6316AD522079C7FEB8E44540813F2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <000000000000e7813b0601a3af69@google.com>
 <6759f407.050a0220.1ac542.000f.GAE@google.com>
In-Reply-To: <6759f407.050a0220.1ac542.000f.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB6829:EE_
x-ms-office365-filtering-correlation-id: b7a834f5-b155-4c30-6576-08dd1a5b945c
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?hbL42boKtmWca8qPoClpgJREWx/26SwNviG7G8+ALLmoPdUsKpSeYofCf+?=
 =?iso-8859-1?Q?sgkXT/xBo7PkHvhmusKoZLWrpdVlB4rb7O29Fysd/PIAUCNsH8330q90ml?=
 =?iso-8859-1?Q?FdEmkwKJ+HzTFgkJyZOOlroCnZGMtd5zSvxAvMTCUe5v/oSMbUi0OpE2DS?=
 =?iso-8859-1?Q?J0ROF4s+bVwgZZxpTlEGQfs4m30IP7vxmPPeDp772l9sW6zkuKyLSYPziP?=
 =?iso-8859-1?Q?atWu1bFyWRefTOqlOI0+bLl9PSsJsjTuQ3/vZLgCHs8zwQaTSsQsYKaAol?=
 =?iso-8859-1?Q?CRR1CcEDALBTygz38y5p2w7nUsfWO2vKz4jilvj7Dslh7H3xZqFabJdPub?=
 =?iso-8859-1?Q?6iP0A7CsrhZ4Zl0GLtZPEgpq/YqgJqqba4Wxw+qN9SJje0738BWHYUmQpm?=
 =?iso-8859-1?Q?6ntt2U9ozKtzxyAm0NLKafygY1QqzgNOvXu3/cyik0dhcJsOMFU35gAhPF?=
 =?iso-8859-1?Q?/BKr+0Ljj6FVGYM/kJ4hRWR3sXjxrrPBEa7nkb0UxHtcHs4FAs/EO2dsF5?=
 =?iso-8859-1?Q?23tdZ/1cgTYc9WumPUhQOeSez4jOVDSsgmN8RKr7fnhqTYqjror5BHBzZj?=
 =?iso-8859-1?Q?to04HOWXOiwssTvWKCwvXKUICUpzUANbHmLigXUh3ViKbu3GfFs/y3Igmj?=
 =?iso-8859-1?Q?hy9FnSAfrreJfoYpXIA7ubBftU/6VedMrFhu1tZVGZy4fl/Ssbvz7DlyST?=
 =?iso-8859-1?Q?K9tuFuTLbKaB0b0qnRlgPejtKw+fzTBXxGZ1yVt6CyaW8Tcji2nU10Mt5J?=
 =?iso-8859-1?Q?bATEduBNzZCcELiUcQ1Bj2Ns1Adg1RLZLWDICQQ8m86oNVf/slK55JlDyK?=
 =?iso-8859-1?Q?FKw5lmVDDVB+HKA2CQV04z3/c3YXfz84Zx4+BwFgiBdnAK9OnBOGeK53/6?=
 =?iso-8859-1?Q?TslPMJ8PUnrBuBdbJbnSQUYLhXO5OjAYXX0KSkFOAwCivIXt7HuT3r6vgh?=
 =?iso-8859-1?Q?WcITdbSjsznLmrmXI/Kj/ZWZIX3oqKpa1uvMbnDr+LT7qmISb7g6NGhSai?=
 =?iso-8859-1?Q?PIfUW9mb2GAUesSL3pZCGNhhP5L10+ddM2KLSLRNEvfcv9A6e6br3jv1Et?=
 =?iso-8859-1?Q?C3/bajoPfjQzdibBD8jjy8mAhF07nBjl6RIRIgImBYQ5IxIgOe27SE7+U1?=
 =?iso-8859-1?Q?/qRSBW534OWzxdwx2bxbR0MixNgeUVVdYlRpg38g7uN/eUbDpUmeeCmcNx?=
 =?iso-8859-1?Q?IzIg8ZZw2gfGlw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kFiAe8Z/SXWKmhktQBbJStVfmvBDHNEe4ZgTwOBAgFAsUqO1mXN3v57HKc?=
 =?iso-8859-1?Q?r+enqGR+isaLYJwnec6Hp+Zbaef4qru7NaK+XuN4VwIedd7r9POeCo/8mz?=
 =?iso-8859-1?Q?PKVogVGL76zSOY5SyiGvfGKunnsGF5qUhvs5lcqtx2h1Hj68oiGE2xi2ZW?=
 =?iso-8859-1?Q?ewoNuzUvQUxObslLMdvMeUazX9/78VKmc9UEe3ylpPrOpeAbMGJRNUIUGR?=
 =?iso-8859-1?Q?7h4Yq5xdntuAcxQU/dTWLjKuYKYb3GaoOMcyJC/tmokcCB4VtbFHak7VcC?=
 =?iso-8859-1?Q?nWAFfE7dBXHp0aqEkn5cg24hgQSvd+CwXgDvZv0xoW+zczuRrnsXFEOxV2?=
 =?iso-8859-1?Q?MCwfyeW2uirZuMutOh3arOvON63hIKaG4EDOFJN8jqMTt+b4jA4PmhXtwH?=
 =?iso-8859-1?Q?ucPxcQIW4oz7r47Avm+gGJdG5YWJUYBlJV/KmV/SenWvh9T3vCTR8LLypT?=
 =?iso-8859-1?Q?qz0VuyVIaslnsKLT670dDCisTGJi8OlwBqzc6Ao9wKUtIBef+JTg7oab8I?=
 =?iso-8859-1?Q?QgmZwN4JClUviZEa4gJLonkDxke2twflSnfxtViXHs64fMtbFhoa2spxbX?=
 =?iso-8859-1?Q?mjjSGovNpEfJ6/BYdVz69VL5d9JT0No20bBva05b6NSD0SRuaAUnQUJddb?=
 =?iso-8859-1?Q?T+M03K9P++eALWAKj1wpsP0oUbcSY/1zk4AqZPATCOJpOSqm02Ykz8/vxu?=
 =?iso-8859-1?Q?CRNj4e9mnbDglvyjVTFNZJ+kEIOTob2IG1UqO3/ocRYECNj5K/Vgv6Lk0l?=
 =?iso-8859-1?Q?gJ1C4x76V7zJASBjkRQCBFK8+pEm21NNSr8s5cvCjMpPDEOWvsXF42MRCO?=
 =?iso-8859-1?Q?QKQEWfHbAjOHsE3UonR/iLtkZXjQLDyJmj7uthqYQEq/4BTlbFHYnTumMO?=
 =?iso-8859-1?Q?d7YJAFQNC9sBeAxQcSSUNuXZwyN+oX5rr9erLQEE8n5JdkRBXpuwAUw4VJ?=
 =?iso-8859-1?Q?o3flchLNA+ti8wl52TPTlTMJEytcpF0YG4Oco1F/Phw1pyVaNXtwUdAdVk?=
 =?iso-8859-1?Q?l37/15kbfa8fXXz1wbkj0GhzBrhOzMPETRgbSc3hnO4dwR3aO+PjayQZA4?=
 =?iso-8859-1?Q?GDfhxpOPcgrd7Ogqi4uAxvS4T77M1W9HhEKH4Yr6zCTdaS7bhpcfwjMeHJ?=
 =?iso-8859-1?Q?ZC6/wTE4Qyjh6oRy2c001SJmKagehfedT8ALmKY8CptqfShIu6NA5wMZjO?=
 =?iso-8859-1?Q?zBgaTdyJRf4IsFsXkhsv0P6IOItUBySfcOqtgPYbXF+sXQ4HXwWf1VAeIl?=
 =?iso-8859-1?Q?DVdTXXI8iOQSa8Cvgl5yUz9k/6SZYnHbDVBGrVwfKLCS+SDtCTvytQh+Rs?=
 =?iso-8859-1?Q?qY/njZLNIzG6GY0/9agiX16V5ecLgwmiZ01o25XPzfgNKrs7NM1UU3n+kL?=
 =?iso-8859-1?Q?jxupTbx5AVtt2t6bhWVcUJsR5kooA+7ypyK3Fy6EBvDfV6mHWXS58nZan2?=
 =?iso-8859-1?Q?96FiKHxMtn/6D1z/7RDT6/a43G0ESXTI1QGBTqAHUpKKjyx/zw4M5GsORb?=
 =?iso-8859-1?Q?LXTFsIdIaNvlXm0Yt9yOrD0GWVvdxdySa5dymEffvzPukre81CImrdyPGR?=
 =?iso-8859-1?Q?3nWJ1L6EvykDjgZRjvu+GD97jpXtoDhDsJmeilBrw2lQLDuaks+fvTCm7f?=
 =?iso-8859-1?Q?daLtWQHXJYzTHtll/2uDdvcMK0YyagKFNLc0BAm+YNIt3XHlUfzomYajIr?=
 =?iso-8859-1?Q?p6DLzv+ITbrxSCe71SM=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316AD522079C7FEB8E44540813F2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	66cq/vkNmdiHPx/dNLJ3ppGw/CHTFTtKqPQU+UbEaxMIS+ozIvC5p4tUc6tEQ6wTazPf2tDy7+5WFWiA815P4qXYsK9H5Hrdo32ndLs0pMbQ4+y3/BCfbTE9/RwuXia0U5nPzSIv/W3Pffx70TLzA0FQDT5FGWV/ZgKAxMk4AJtEGDnRov6T3vWrssTeXl5qpQvl/kzLKk+v+dp4DXnZssqALl4quTpYbKC3rGaf+k3YwVAecLu1Z2gVFlWm3yTnG+BzfrPLOSqc1QMR2GjKwb6Y1RXL3J5byvtXYAlwibZ9aKVRHruPGVb/jd9Q83fQCSEbdwwr4+QPXgzhZTO3mypo4ye/roTGWkM1T+rJLj91LN0E/CPt65P0FwYOOfqH406Ck70E/ANYBPzFVsHk54EWI1YDcSETKUe4URVnnx7OX18hqIlXKMy7/wS7ooUo676F2cT/nv1sdBKTJLSjxv6uq0vscRVhKfW39jW0+c0aSjZUJboYEeZX+TraS6s8yy5/xU7vqnJD0I9IdNlveIVDtRRPIDUVw6++TinAqSaah486sM2Xf6E/rf/nOYr3+qsJ12iZsxaMJHWU8JFHwAR2q6DTXxhM3LwU9r9BEXvrPNezrkgFQu1S00K3AJ5p
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a834f5-b155-4c30-6576-08dd1a5b945c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 03:17:58.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: io67gNnitalkIsHuX0f1JfQo1NEI/PssbW2G9nu1ej7g/pv/cjGP7yo3QjLMUElR03kRoj1Po1I0H8DQXi47GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6829
X-Proofpoint-ORIG-GUID: 8FPX_SF1OIDYQajk8A-xp6psICSCbxVT
X-Proofpoint-GUID: 8FPX_SF1OIDYQajk8A-xp6psICSCbxVT
X-Sony-Outbound-GUID: 8FPX_SF1OIDYQajk8A-xp6psICSCbxVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_13,2024-12-10_01,2024-11-22_01

--_002_PUZPR04MB6316AD522079C7FEB8E44540813F2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB6316AD522079C7FEB8E44540813F2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-add-loop-chek-for-the-cluster-chain-of-root.patch"
Content-Description:
 v1-0001-exfat-add-loop-chek-for-the-cluster-chain-of-root.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-add-loop-chek-for-the-cluster-chain-of-root.patch";
	size=613; creation-date="Thu, 12 Dec 2024 03:17:44 GMT";
	modification-date="Thu, 12 Dec 2024 03:17:44 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlODljMzM2YjgzNWU1YjkxNzBiNTE4Y2Y1ZWVhOThlYTUzZjQ5ZjRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFRodSwgMTIgRGVjIDIwMjQgMTE6MTU6MzcgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogYWRkIGxvb3AgY2hlayBmb3IgdGhlIGNsdXN0ZXIgY2hhaW4gb2Ygcm9vdAoKLS0tCiBm
cy9leGZhdC9mYXRlbnQuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmF0ZW50LmMgYi9mcy9leGZhdC9mYXRlbnQuYwppbmRl
eCA1ZDhiNzQxM2Q4MGQuLjBiNDllNjg3ODIyMiAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvZmF0ZW50
LmMKKysrIGIvZnMvZXhmYXQvZmF0ZW50LmMKQEAgLTQ1NSw2ICs0NTUsOSBAQCBpbnQgZXhmYXRf
Y291bnRfbnVtX2NsdXN0ZXJzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAJCQlicmVhazsKIAl9
CiAKKwlpZiAoaSA9PSBzYmktPm51bV9jbHVzdGVycykKKwkJcmV0dXJuIC1FSU87CisKIAkqcmV0
X2NvdW50ID0gY291bnQ7CiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjQzLjAKCg==

--_002_PUZPR04MB6316AD522079C7FEB8E44540813F2PUZPR04MB6316apcp_--

