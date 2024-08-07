Return-Path: <linux-fsdevel+bounces-25223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932A949F51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498EE282D34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5A190466;
	Wed,  7 Aug 2024 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fTlob7/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0454482D8
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009559; cv=fail; b=iWYsHJM7+V6tcGFaJ3htG/p5iMdaggZQLi76c/vCWFpxgNs387m8rwFW6jk9ZniAkZxlXdgxCCQpHthQwXakgVhmUfkq9G9a+GbiKzTpqrpqQc0IgfzjpLSgygvT6agtmh/mOT+F7+PBfrbCRXRkrdpqnWUY2e1FthvDx5U/Vt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009559; c=relaxed/simple;
	bh=lgU6fGGOJRu5UCXZIoQoAgEe2bTFGsxP3EQi3/Ah5mc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ifE11CgrHwfarb626gsvD8gFfb8hjJ4ubUnoEKNmph75QTSZZbj9tNf5zd74xwi+Ab9CgtohBdyIL8DVmbIe3lVisT2Y1UXVDLGy5f1l27rs4n1q4s0vpaLHY5KBN0qxRFEBShZkRprC25TUTqdPw/gAHrL1ZBY1p4WK0pNM+NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=fTlob7/U; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4775doFt030177;
	Wed, 7 Aug 2024 05:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=eblpkjKZrzZCs1CYHz26oTHDcLdjD
	mQUnYFEso6ttP4=; b=fTlob7/UPZWq6OGEZUazpyoYL1cAOYDZ0355IHlpJ0hWq
	TiNRCdx61Q0Et4fbGEFBsjKwr8ACmUcxTqXtIC3yPB2+bOnf80x72DazD+af5/jL
	/djryiXMt4K4bKpASpPUsyQk4el9rK2tG6xSo6MW1/l2AKW7jIz54XYwcmmGVMJ7
	NqaLQBGzfkUSRNNB/+rDR4eyfI81XVb11TmSgBKdXt6X2HzKCfiYeakizkrz+B1h
	L20rj0CXnpYA88Dyqd77pwQzD8Q3geQLalphWrtMYOH3CUc3SL+NiDqI/Or0AQSp
	qf0kemN0t5vhv4ABSruy2jqaEJ9gq+Mt1xkuqiYkg==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 40saep383b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 05:45:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhVXU9Vusgm3exiFez7w48lLWDSe7Cot9Pxa5aEXFbFnLWWvNCKFiTavOG2g+BOyx6MT69MOdDXtNG2als/m/TFdS6aldM054rofQT7iEERV3KxhXlrJu5qPeUA48iC0kXuVleJy1J2HsR18iVOknIK+W5VDHj7O3WIB8PEungGgGKSdKmP8aX0SVk+JaLk957kuIAUqZhzJ+pg+3xVNuzdznJVPU4UXbORgozeqgiSKjcjvx6IbcUIPkOQUhg7YoGdRiqnS5p5CN6dNI9ICHPkynkTDwpsXl3EcpDT8i7I/KJ0j1PG008MVkRA3BntXuiUrcq1eGaMOWQJZsL3XBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eblpkjKZrzZCs1CYHz26oTHDcLdjDmQUnYFEso6ttP4=;
 b=Bh0evQy1R2SAIC6udPFNE8RJclzRk78CbFt0Zeu70KRREZYSgcRZq/y01qvtzVqR2H1GcBngtfCLGJuYG9b/4iJBXjQfk+qQb3qRI138I7Re0+85yd9VEWUvP/b6/qnhawkM7vArepeTsufo+IlZPiKEH68NyNC90zOWJWUu3V3haFHeXSJmINQ8628pjp86WNQZuaCWNQ6BbkMzRtHxmEfAGD9pXLNgM73iFqtOxJNGgseNTvlk/TvlaA0lRyEMh7QxDznNbqUUafx/YyJICf+uylsKjPAZJPI0LkNJa/5f7aXsybO6VkYFIAVuRb+tk0tVsWrRsOMoZYKEATv+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6886.apcprd04.prod.outlook.com (2603:1096:301:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 05:45:25 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 05:45:25 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 0/2] exfat: direct IO refine and code cleanup
Thread-Topic: [PATCH v1 0/2] exfat: direct IO refine and code cleanup
Thread-Index: AQHa6IuYFUwB+4AT/0eaMukoFoEgSw==
Date: Wed, 7 Aug 2024 05:45:25 +0000
Message-ID:
 <PUZPR04MB631656C12DC76EFFAF3D181D81B82@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6886:EE_
x-ms-office365-filtering-correlation-id: 7a3a8494-fb03-48fa-b9d2-08dcb6a422c2
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?N6H5jd7c8Z6f22ykDymtTyFf9YsN2cM/YtT4PJRzAot6VrtiYLn9vuOTh/?=
 =?iso-8859-1?Q?uqnm/+MCaYRvZsPQ9goDn7++AcbSyr6idl2Jt7oJYGptibWRS3ZQlE3R+M?=
 =?iso-8859-1?Q?RH7YPrdu9ws7388cZpJZ/HYeLLd50tNSWmx874iFXTBKrJXH3cCf0Vebpy?=
 =?iso-8859-1?Q?CQbBrS38lN9U9vh6WBQ/kcK9mwGFUe1M0BazhATGWGAau/NiADPn5qpBs9?=
 =?iso-8859-1?Q?62arxdD6jY8yl+xDiP6SYvd+XMyMSeCNZp88JLizfh+yAW7gawbyJ8jY7A?=
 =?iso-8859-1?Q?a8FDKx8+qvwHXs/TJd27RHv9Dn6yOeMzNRCcUA6VqaNOLoQc9hNDNCen8J?=
 =?iso-8859-1?Q?sWzsuHCPqqqBJaenFrc9bBw7lC5NEFqE63vlU+aE/hkwkNYAtGWKRPb9Zf?=
 =?iso-8859-1?Q?GHJPSVRF+54sB1YZytwuqJe1H8yihQsqQ9IVGYeONpuaWXD+KackEXcRv3?=
 =?iso-8859-1?Q?ApWBpX79BXSlesIaSda0to3CWnrj0i3qPNWI04c66CSQaG4DgQ9Sf1et3/?=
 =?iso-8859-1?Q?CvUYUn1wc3qIXaB2qy+RpUtBl5N5a0RxQICQK4/cpiDbQEV6KF/fwyIPpE?=
 =?iso-8859-1?Q?J/B6HmKgGkDD0Cd1oEKAQ29D46IPKK2GprbIZSsM8y/8GF5Q4UDXNy8/li?=
 =?iso-8859-1?Q?BlNPWorEzNJX2wpU5Qk0M3YG3qZ+wB0OB54tQ9+xWi5xYCLg7jdcNvQy2y?=
 =?iso-8859-1?Q?eRSQ8kTTpN5y9VgyBEZ6/I3Ve4WEdMAozyysvzfwZqUFw6/LYv76EMfOlu?=
 =?iso-8859-1?Q?FUqnSbR8NtbWV7DyJV93JCJFHHTAeVB8YT9m1swO4k0kvukUtiLdIqFPLo?=
 =?iso-8859-1?Q?A5VBUX0ZaL7Z3tU7rqfm8Ov7HoQvvHFx5htJ8knr2M4DqiXCSRHmjSHrMN?=
 =?iso-8859-1?Q?rqqDXpROsIT3rH1jcUKLe/hzU95FX1WKVVAhvFBXHbhkik15hoEJhgZUzt?=
 =?iso-8859-1?Q?uFabTTMbXqQPR1IEy8p4MeJKIZr4hIoFFQDeNeTS+B6brFAF+ii28Mix8P?=
 =?iso-8859-1?Q?4qKYwyyLyaqW0OPCorf3DMvztbeVUUy4OwU+m/uP0EzeVgM8847JE0qgeW?=
 =?iso-8859-1?Q?xB5+kJiOraxzJi5gmIH/eXB0Ac29jCz15dah5E2ibbNHXkB6XBIcsThm9S?=
 =?iso-8859-1?Q?ZqSLBSOEVsyIHWjRDwmMwx9UYMAFWAvT+qcUQT4DYdIrcAVpjCrJI/CvJn?=
 =?iso-8859-1?Q?e/Lq+LDDXkYYh1/L4sk3MYGvgsrdkFV8pqbAr9zVT14NU89OV/HRiDOkgu?=
 =?iso-8859-1?Q?pAbGtyptkUxknAVK/6HQWqzp15l8smQHsy7V1RUmie6BzjI5eHhz4asLpt?=
 =?iso-8859-1?Q?7HhQthjLyYDKbXpeltudvefcTzLnuNwSMQGIhFkh1mP4VDcicmq9v1v4gq?=
 =?iso-8859-1?Q?UjJc1QdtHe8bdIgMF1MAnniIrbIWB/s+eyxGzcyKZplqqKbdDp9HajD1YI?=
 =?iso-8859-1?Q?VTCDXDBnEmPmXpaSY0EWHoZGWnJb9I6k97uQ9w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6DVV60qX5F3P3bFonOGB1G6uW4e4xpY4/hMoYx9+LshQvrMGgMAbbO1MRz?=
 =?iso-8859-1?Q?IB5MAoG9fD6gPB0vUqfuxOFSE7F6R0E1lekKpsQm9sqbvI7HqQ3JPtIZSj?=
 =?iso-8859-1?Q?QEuObkpXlucNqh8Jsb+Nlw00X6G+c3IvPDe8af8r1gErEGM1aDdEg0y63q?=
 =?iso-8859-1?Q?xflfWzwFmxgdTmNocMCqgutPc8zO5ZRvyoM52R2e89YlXgeprPMH5mluMp?=
 =?iso-8859-1?Q?uGpY844wHUo7MUHk3jIu5vCOGnY0P0Tpe/sARaaDFNmqVBvcw6gTFKVKJm?=
 =?iso-8859-1?Q?0CBZli148jYMhPe4H7/M6qZlpazME8om79vae/TUXwKSf/8K1/FxG4oLlE?=
 =?iso-8859-1?Q?kVOeskDa/odjieWIHs+Hoxslt8ScORnCrVmX7zLRQYMnearxudoSTAFEK2?=
 =?iso-8859-1?Q?rSSznM2ow8ZevBxo5Wm7GjBO/Cy0vvAfVbRdKyQl89oeXpcXBkCVWuqZej?=
 =?iso-8859-1?Q?iuuSIAAalVcW5Ae73yxyMOXA+5+e3tsVCqdEzqVFaao7IuSJfCUB1kEu5j?=
 =?iso-8859-1?Q?QS/kLQj81HP559v+cJeeDZZ5OLN3xzniCRlsziv0fHznrB2NhBfuWbblYI?=
 =?iso-8859-1?Q?fbCHasB46ayjEOKYCbhKME/WVJD4UrIs/2nQ1oV+8AVBeqoqf+I0IjlSvc?=
 =?iso-8859-1?Q?BbSVtPRwn0YogDQ2fxsQs73jXciL9Z9jOGxc9UB0LzuatJMAu5/4YX02Uy?=
 =?iso-8859-1?Q?P/5fjAtJbAriarSJcw34506vodBAUReQwNl1L0mWOI/Bl7lIjLA1mNhKLd?=
 =?iso-8859-1?Q?qLycJjFmm20Ikp2B1nOShsxuXLkD3AHXz5KUjkhHeKkCf9jDtAF6NCRkI0?=
 =?iso-8859-1?Q?JSgaG/fdK9rJyYCGD7wv0MLl+2DtjQBIGpKf3D9ExyQiMBb4eWs6x0I67l?=
 =?iso-8859-1?Q?uHvataBMhDkjtgXBFUod/VKiLBRpSnSySCA5+PevCfh0wEXqVCd9sWdluw?=
 =?iso-8859-1?Q?7gFOS0r2B8Z76hsPrqWbo9rPcfPTrOeqNi0LZLPbnGkRwgAAcmeOj1t4Jh?=
 =?iso-8859-1?Q?n+29YEYLgAvbdhlVIy3iJFdThZRC2gDg9xj3jmiHIbaOMKQFKHvHo34OFz?=
 =?iso-8859-1?Q?gZVcjRVOUTMQylR+JAmOJqLEtOjGcjm1zQq0xgrQSpYhhwGce9anjmivjy?=
 =?iso-8859-1?Q?5kEwbHnJA0Q/f4+n9AqPl58hSBsuAUOwJ12T4lYwY2e6turqGnPTTAeH5l?=
 =?iso-8859-1?Q?srh6EDoMoxlXYf9s75IxKkkKF0/+nNUJU3QVhtVRrb0PFMb3QAsVHRtOKj?=
 =?iso-8859-1?Q?2eXOwgQUnUWsrDdzJPdZBfn3nU1YVGJsN4P426j+0MAuKr8xXtyS4bxkC+?=
 =?iso-8859-1?Q?2gc4swu4o0Zlzu+VXwGCOpTuJGDUUPW7ZoZxD7A+ufk78BhCSABCt/5a6Z?=
 =?iso-8859-1?Q?/JtfnYNd2AaC/poeKHGkxUSn0NezNi4QmHbns1ReLZh00eUewwXXnXnm1s?=
 =?iso-8859-1?Q?Bt80DFaYzDQreSsMZFY2fydd1V6fXHu8NInNjiNr0C8k1QN3+0syxg1njP?=
 =?iso-8859-1?Q?eemnE9zHDXKOHQtoHMP+EvyqEXBgGBYMWmwr1Rmnid8mAEGy9dB1Ff9eHW?=
 =?iso-8859-1?Q?rvj1wnnIPi6QqZ+KMAc0ruTITN6qjxLpjTyqXU15yoC553AETc981ao5Vk?=
 =?iso-8859-1?Q?u/7jPqLbuaUMPWVxdF3ks8f9AL6D1Q99IzTYgHMEV5qxyFTocz8GfmA7vN?=
 =?iso-8859-1?Q?ZOxsm2Xq10krGcW+bRk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N9ciV4jVsON+CjcCSg+ys+1VghFKPVIOc376N8oeY5hFUeJNFr0pt0DUKENUNNSzVnyPqr9QdZlSzelfVHYtlvS5Q+N8IY895dccpCSmVKGkNM2AIqty8B3+nHXP5mKgF54WLzgUqfcC8d81PS4RTgzKp4baOX8BgFtccfxuLbg0paBP6q4+CJEyzpl0sGGoKcBdEi5FYTfCarW8Ef4eMyAud/ZSBrv37sb1VQJM+cI4ZcK2H78819vQiF4az6SvstzSWz+5mmQqVpl7TwNPEXqFFDGYxS2dZEJazCP0aZZs2hSKV4H7b3EZYHMABZ8h1tuDi2RCVwNZUoby9dh0LAy+n+TdRWJ4wH6H/DifFyX7bfS6nIynArstvUCmZnwums+RpZ8DNo5eUZZot8XENqDKSrPiSSnQzYSlXKmUY0vdl/mq0q9fi9jzsV9/oGEeoxARoMM65xGYqcdAd6jyzx47Ix60UK23jk8Z6dgHhCU/uylMbTi5qpe/qzC11eli4/q8E/H5ZD5h3ONfglbFFjlhCsLwAIUw8fZMCP/qK1aGz9wn3ZlVNj/6FeAC374fhI5y17xawFVYNpo1cdr9hqnnS+QrEMB95zD1wlDDX2cGXObhqQo4Yy1Mvhf1c8BO
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3a8494-fb03-48fa-b9d2-08dcb6a422c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 05:45:25.3688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQV0mT/lsm5QTRQU9sddXjcuGx1VzSb35KD/kXdfmvv8oaVCjnefBUPgWtwCxeB3AGYFzssJRElbRubwsxmIRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6886
X-Proofpoint-ORIG-GUID: SUZ0xPIOEfa5LUrgrQRiFrki5VV_TF1t
X-Proofpoint-GUID: SUZ0xPIOEfa5LUrgrQRiFrki5VV_TF1t
X-Sony-Outbound-GUID: SUZ0xPIOEfa5LUrgrQRiFrki5VV_TF1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_02,2024-08-06_01,2024-05-17_01

Drop ->i_size_ondisk and ->i_size_aligned, and remove fallback to=0A=
buffered write in exfat_direct_IO().=0A=
=0A=
Yuezhang Mo (2):=0A=
  exfat: drop ->i_size_ondisk=0A=
  exfat: do not fallback to buffered write=0A=
=0A=
 fs/exfat/exfat_fs.h | 12 +++----=0A=
 fs/exfat/file.c     | 19 ++--------=0A=
 fs/exfat/inode.c    | 85 +++++++++------------------------------------=0A=
 fs/exfat/namei.c    |  2 --=0A=
 fs/exfat/super.c    |  2 --=0A=
 5 files changed, 24 insertions(+), 96 deletions(-)=0A=
=0A=
-- =0A=
2.34.1=

