Return-Path: <linux-fsdevel+bounces-25224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28548949F52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 07:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32FF282B8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB431917D2;
	Wed,  7 Aug 2024 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="WEXpk3J4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04914F215
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009560; cv=fail; b=ntq3xaGAxWUMvtxmB9sR6tVYy8CDiQOhuVh/tCLj7i7YLg7l4qk0Sftl87922E0rBP45UGdzFfOG1ZHeWyn3P2akSSfqZQGXMHuDkrwN9+7GBtj91BsurruorkX0+fAel5RixWK1NnXBXn/P3Rt91zMmGi0VnzOBdQMzktavfDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009560; c=relaxed/simple;
	bh=ZcAEUTeOX3VJykrZM8ImDOH/pc8jCIcAOUlTnASB9mY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WOJE7LBduf+4cJ1zEo9tnXbmNOYrt+faEgqlxxRmxMhWQiJb3zay/UTjqglhSVWWLx1R+XR84f8GWMKCaJyLY1M7q43BTZNs2GWf3wHh75tHNvrobjHzBftUYjrerCyA+1Qs34/qpK6p+XC1PaRtqKCZKnMPMXkrOmAhH9/GmOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=WEXpk3J4; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4774OmuV025093;
	Wed, 7 Aug 2024 05:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=X2I+si+Df8AJgtDYH5CQjn250B+Zs
	5sx/ON1CsboFtc=; b=WEXpk3J4tka47mO6jrWASeRvDmZevbUf/UdIyc3yu7tSW
	7FOjF71o6Z4OrR0XN2zUXQkv2w4FAGff++wt++EmpSUBCRiOp0SyOTia4Weh8Jh/
	vr/oLcma8cYvVxQnjc80BdjSqhaV0gWVDtx/dOh+lNJ90/Aqd6/9kW48m2h2e1fa
	g0yie7ERBHxbQPxHjZqjuffLRCq7EuuXHX88fCRAmtEmNlxspjmnsplgFs1VU+2V
	yIyz1KOmcp92z+isFDFRgyVu8lMae9Oprk8lcnLqcp+Pu8/t8c60BL8vObLCwj1r
	X9AEwCs2XROJJWVC5vwOUMD57P5pVrCThNEqq9D3w==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2105.outbound.protection.outlook.com [104.47.26.105])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 40sbb3u77g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 05:45:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpYu+WxZWqfRBgcDghDMCAEsEpBgfz4RZ/SK+VTZXbm1XMPWNO/Nsq/ldleeeSyb9bSjRzgEofWhrk+HgrR+jrzKgmpvtYFGejnfl/ZFuqW550Kcd83rumeVkn1poUmhTErg5PYRjzgOr6V0gHYSNlq3EXcvL2lG5yS3igVC362CQM91eRQs9JbS0Ms9FZBVKOo9/kmfrujqxskXBLUsrgEIxZzhGeA45D8N7tlBql4u+jhx1/c8ljhkR0AUpa1ifEWI+mfuYXMRCrscV5pmTTUdTV9417wSkRKWfU3ie5GDVxXTMW3luMwBELSYOqhZX4nm0r/rR581Z3d6qJQrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2I+si+Df8AJgtDYH5CQjn250B+Zs5sx/ON1CsboFtc=;
 b=hkFuhfVs/uTk5RrZgu/6Fa3Mb5eE11p7eYUa+HzL9QLrpQik8aq3y/rBfiAsNkW1d+acelTXHuv6IbC0W3THYXfDIIhtpR9SViHATVcvUuqTqmKHiHKFd1XAOgTfhQei8krIyt9Vq5b+IzF/RkIUvzj67sfVQ4U2lqu1vBgn9lBTlEkudGnksYWYghsj4W5qufSGSMoE4nSphT9MZUaGG7MReDAvo0SlpjzYqDa3W5Ke1zmOJKGztMKwhj6kTe1unQnMut68NtqYo+9yTbNdp9Az+dr4vXkUoYCy2Nrz9fTOLGhExIwHnK6lZSKJ8pA1PBVl7nfdY616SE1DyIW9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7207.apcprd04.prod.outlook.com (2603:1096:400:45b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.9; Wed, 7 Aug
 2024 05:45:33 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 05:45:33 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 2/2] exfat: do not fallback to buffered write
Thread-Topic: [PATCH v1 2/2] exfat: do not fallback to buffered write
Thread-Index: AQHa6Ix7gtH00S5OykqLk7pXoBgdWA==
Date: Wed, 7 Aug 2024 05:45:33 +0000
Message-ID:
 <PUZPR04MB631697B79F5ABF65191F259381B82@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7207:EE_
x-ms-office365-filtering-correlation-id: 8ae70fc4-0970-4d5f-43f9-08dcb6a4279f
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4bDIUSL6bXmfiFCj7kffeyjLJFwyediB6kUhg9oMI9COG6tBvh72+qjh2j?=
 =?iso-8859-1?Q?kJT926GiEF9+GUS08JCKnJagOtJcVdt3SvHvGEDO/5H+FjwraE3FwBkGpQ?=
 =?iso-8859-1?Q?k2vzwcdqY4/uVLu34VvNWkwcVbvLfaNlJCunISzu/MKfYPPp+Bv+Cu2bpA?=
 =?iso-8859-1?Q?rlOBzvzhXlKkLKzJOhuaOZIt3GL5EXJ63d17QlGhcK3m+8BY05RG+avRfW?=
 =?iso-8859-1?Q?KUC9h9sYBnYJlsEKuvyA5kt14aTe9sWAZzOg45nqeL2qrVPc1KKlU2a7od?=
 =?iso-8859-1?Q?9+0pEHHfAJb2fnaDBL4t6F4tPRGOy2Mfkm0pK8w0SysjQeYMknOj65lOOS?=
 =?iso-8859-1?Q?txKvPNXUlwRl8F7ZNAxuxptJjzIKvFhMkSnce4fpDcznPJOCM9ox0tiLD4?=
 =?iso-8859-1?Q?mJ61GcNDbsV85bLdIpMfznJuvHSFEN7/oddeHCSle864nIHUX+8TAJQqEQ?=
 =?iso-8859-1?Q?z+rEmhemhsz0s3ln7aaIDhBpJ5XZROownaHBWZe7JXQ5oc7g4WyfmTgyHc?=
 =?iso-8859-1?Q?4sdB7UVpNZ0/hUQrksmjNGAdDLxUK6KtE+pMb44h6U/aHFtX9zIy7OiYVK?=
 =?iso-8859-1?Q?ygqzWrsrvmjl1Z4lGt0XAm7r5wm5hM3QC/3afF5v7UDjJ3VC13Yt/Ziq/r?=
 =?iso-8859-1?Q?LrJAB0sGlZkW4dygw7KdJ29aS66MghRuLAVhJPD5GFxbtm2vQLvfscKrc0?=
 =?iso-8859-1?Q?nrHx0+kZboOe620DQUoHQp64KUGFtkeg/eH39cbOaFu/agmeZMwg3LcwoB?=
 =?iso-8859-1?Q?7Vsy11pkDp1K7Zdr4aLUyl+Z1qMuF0ovdfv5ZsuSvU5a+nt5JKM5FzWxn2?=
 =?iso-8859-1?Q?7uDV0NA+8GxSVNvNceRH6prt04q+FchbjJecyeY4GFHkg+d9/WCj+JQbdi?=
 =?iso-8859-1?Q?jrfbTKQXaoSXTqC2HVDi5mzqt1uFi8333813WwmahzsliyPSyKH9AjLheF?=
 =?iso-8859-1?Q?fAuEXanOWy/LveaR0q4dK5SYUxSGxHHTZ0DDUyDYh4/bXJsfZ6yZ3DLs7Q?=
 =?iso-8859-1?Q?r3SU0uFYLjn9y1OSSqmwSIeMfk7KLSJ6XHuvUkEKDFIpNqyMbAqWSzAq1A?=
 =?iso-8859-1?Q?wbL3xHNAOvv3qHReMwG5lt0bLaCxUnzKgTAmTvs3RptXejuJDX72LUegdn?=
 =?iso-8859-1?Q?AdqgzGWMvtAJ/Fwf9vMoT7M36IDEJG6w2NZHj9WLMXUSIGHeQDRmg1eKiy?=
 =?iso-8859-1?Q?/fiihnhAtVugSzTB3hMgWeOJeGR9187qnk4k9dUi06iSZ0C6xcKYxFSxyZ?=
 =?iso-8859-1?Q?6LmeCMBv5LwOeGHFAlJyHBNpRYw0obULq5aJCoMTQCs4iQz1CNJwHBaWpq?=
 =?iso-8859-1?Q?AV7tQFvGg30fxgMkZ9mAkcjTRMVfi3TspMs5X6ATaFJJ7cCHFzkJwDE4Nl?=
 =?iso-8859-1?Q?PNtX+tMGENtus6VXz+qZZbIM0sWmSVv8XR2s7VUArQUhIovrWRBTTOW9ev?=
 =?iso-8859-1?Q?fJvnc+ManhFpMKLcPvjUM/7+fb2A9NJp6y2KYw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ivTEarJeB5EexbV+31zcNQFzM4GppB0rBOmmrXUbESg6BanQV+ucvCPIsh?=
 =?iso-8859-1?Q?l8wZDO/QzCQsfZtruWX6a80eNRdVaynWTnH7GLep5JCs8mrrajWq4sJgoY?=
 =?iso-8859-1?Q?agztUFZ/bSbBzY3o3sGKtIoUTDTLnsDQj8LR9r1q4rUbvQ/XrhkHr74aTx?=
 =?iso-8859-1?Q?6ovi0VRKeDk2RU/xyQIK0qd9agRQ0k30cx81NXRqmHHITj6CT9uRHiBRSB?=
 =?iso-8859-1?Q?QQrw38mLuAQ2aBkzUGjWpZWFnwlYWFYScUNdVXNl4rqLNZAaa3Jhp/tmlY?=
 =?iso-8859-1?Q?kwh+z14ZY+T8o5NO8ppgnLC4+j5/jCypOBQujvSXGOKr0lfxPouq7FYmoM?=
 =?iso-8859-1?Q?7uAvR4F7i7e0lMK5hco82JCESfBF+V2XG+0w/EXkCRu8HrOCEfcI9goMMc?=
 =?iso-8859-1?Q?JCyAZAaUDQaOfknsrsq539LAuKT8zHHV2QRisJoN/HpN40SlzyyFkgPtpW?=
 =?iso-8859-1?Q?+3DzQuIA1XW1amHjAfA6to8P4RdCViSG6ucv1m0NgRUhWq/784SENnW0vh?=
 =?iso-8859-1?Q?xpIa7bZQO+gZf8/58x+QdXB/iVF9MXd6UJ1IIOlD7nczIevx8Y/SfnfkxA?=
 =?iso-8859-1?Q?ZnzyT8+T6w6X69LfVSfgZDJyHMDlluxo98nv3Q9i13lZhpjpNjbkl29/6v?=
 =?iso-8859-1?Q?t+y2aHsLXmhasl6M8xex4bOr5CrXlVZQcFUa8iNMDjwP72wjL6NtlL5JjZ?=
 =?iso-8859-1?Q?6Q63yHx/c5qNUpegyPaKyxs1AytLnVAQJK362aAfi2qnkSVK7qyblTUX5G?=
 =?iso-8859-1?Q?yQBgwbDE2cxrla1dYY9oMo57tFhV6AgNpM+xv0PFZX16fo6YCamoThARal?=
 =?iso-8859-1?Q?UqdKTXeZmeRoqVlcnfdN3crCXzN5SULn7hj3UGKajhzPadjFPgBL+Coyzz?=
 =?iso-8859-1?Q?BQvTUOFNayCGzN8EZ1WfU0u0f1R1gvNJHl6vChWebiq560YMnAibKEIQZF?=
 =?iso-8859-1?Q?rr4p3QIUkMGSdGWHFZyK2rbWQyjSH96NtYAIk/ns+sfSWKzuJcrQG97udP?=
 =?iso-8859-1?Q?LJDqhtzcPHXQBkypyafYh71cCo0ui5GWwVYd7tNBL2GpslVE3T9+yf9G10?=
 =?iso-8859-1?Q?APd+u5iHDoFEUjk7fpmj5QK/RAhrZXXha9Dqoh9VUGr4AWYoRvIDFcQ1+y?=
 =?iso-8859-1?Q?jgJysMdmqqBrFXCh48+4Bmk1joNRqmC11Srwpxbw5ck9lYu1E5YGo/K1sa?=
 =?iso-8859-1?Q?DSFVM4g9X35Zg59sJiz+BWvClxkpjMCF+GcNyZlrZ83vvWituevhwv18tY?=
 =?iso-8859-1?Q?BmrKD7jxuSw34VdkrJSzGnyjHFPd3HMIVbj77CqBm5BINiiVTQw34BWgjR?=
 =?iso-8859-1?Q?FlkLMdrVP4+XRtVfEnUdzk1/1klZXpL45w2cLO/zIfmD9o2xzwQ2HyXdfA?=
 =?iso-8859-1?Q?yGpN4xEHtwLnpCMQqwhg/gLt4Pbw+uXh5D1FqtTmZHd3V8r2vZsL9sqxPL?=
 =?iso-8859-1?Q?JC8DWAPyRAlj6CzE0MZ1Ec3psgrsnfWGaHYw3MMlf56kYkh9WlEpPs2I6M?=
 =?iso-8859-1?Q?wWPFOJjzhHltqm1T8EtezVRS+Bx17z2ySYykz0lxi/zKXSO77OwnPe0xe+?=
 =?iso-8859-1?Q?HjU9A1dWnlAxlYLxGf8MFd724ewdBmG2EYeuGtEen7st9DTvDS0lA+YFzb?=
 =?iso-8859-1?Q?x3Z8fvBaB/8HB6lNWK+wLq4tI70Bb13oO+xS5Y++XLHFCeLk/FliBXtVHi?=
 =?iso-8859-1?Q?oc2QxmgMFfrexzB1RWc=3D?=
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
	kFs+jeClq0ggQ9oXfkxYL4YpUxxUrBfvUTkNkwucLZELrnrcczyEAeu2uXCUej3p4unm9jXJdswpynRWNznI7fJDFNg+1w9/bcJUMbYldZOnBKe6wrHdsyKm6ucfllG85ji+XyWy5h7iE0e+VJNn/+aRS+DEUrj6dZHhe7EbdWhYL0PYaqWKkcbj1awKxJMbgBv4AF83FGBFNgBnZdCdeTT2l8NSp6cOT8i5qFP4tQ+EpASgGBCqPp20fsW+dgYyzrOhn+Loq8e3fukNgHy0mkHD/jPx3rm7uKwJsvIxxsMp3250fRM54LjfRWgIGEEMcK7K2McxgHyttfvjbew76iKWGiX/enby44DxdxKPxi21MWchsB/UK5QP8iqvbuxeYbDk1Sx8Es8ZYynOsvIlXcnlio6Ob4NqgHBS4XwGyrz2dIMJn0+ajlBQpNZgVEnUwMX9spCmlQj0qVb4tadZWDzawhFVLzB4uGIoFls2mjQbU3Tv1eszD/W8uXMNPfbgpeUA62d1D8CdhAWl7fQWYdeFljIRG03HK932RJ6zLTEye08MapwLY2eML78GJACypmCDVljJ4S8aA1AO1MVDuTcKZwJRj98gi/fSV48r7TTsvbBUmEb2t5aDsC2sB39Z
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae70fc4-0970-4d5f-43f9-08dcb6a4279f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 05:45:33.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cuv05cX0z6D3Y4TqdSWIZvV0rOH9W6WWGA46UVIsND3g88DMjIG24lqcGFyQoGHsYKHNTH+y9skceAGvRLB5Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7207
X-Proofpoint-GUID: VY3FTDEqLnsSgRnW_0UA0c3TVeAPO2UX
X-Proofpoint-ORIG-GUID: VY3FTDEqLnsSgRnW_0UA0c3TVeAPO2UX
X-Sony-Outbound-GUID: VY3FTDEqLnsSgRnW_0UA0c3TVeAPO2UX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_02,2024-08-06_01,2024-05-17_01

After commit(11a347fb6cef exfat: change to get file size from=0A=
DataLength), the remaining area or hole had been filled with=0A=
zeros before calling exfat_direct_IO(), so there is no need to=0A=
fallback to buffered write, and ->i_size_aligned is no longer=0A=
needed, drop it.=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/exfat_fs.h |  2 --=0A=
 fs/exfat/file.c     | 11 -------=0A=
 fs/exfat/inode.c    | 74 +++++++++------------------------------------=0A=
 fs/exfat/namei.c    |  1 -=0A=
 fs/exfat/super.c    |  1 -=0A=
 5 files changed, 15 insertions(+), 74 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
index 40dec7c0e0a0..344c2f119e3d 100644=0A=
--- a/fs/exfat/exfat_fs.h=0A=
+++ b/fs/exfat/exfat_fs.h=0A=
@@ -309,8 +309,6 @@ struct exfat_inode_info {=0A=
 	/* for avoiding the race between alloc and free */=0A=
 	unsigned int cache_valid_id;=0A=
 =0A=
-	/* block-aligned i_size (used in cont_write_begin) */=0A=
-	loff_t i_size_aligned;=0A=
 	/* on-disk position of directory entry or 0 */=0A=
 	loff_t i_pos;=0A=
 	loff_t valid_size;=0A=
diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
index 8041bbe84745..8cd063a6de4c 100644=0A=
--- a/fs/exfat/file.c=0A=
+++ b/fs/exfat/file.c=0A=
@@ -74,7 +74,6 @@ static int exfat_cont_expand(struct inode *inode, loff_t =
size)=0A=
 	/* Expanded range not zeroed, do not update valid_size */=0A=
 	i_size_write(inode, size);=0A=
 =0A=
-	ei->i_size_aligned =3D round_up(size, sb->s_blocksize);=0A=
 	inode->i_blocks =3D round_up(size, sbi->cluster_size) >> 9;=0A=
 	mark_inode_dirty(inode);=0A=
 =0A=
@@ -244,8 +243,6 @@ void exfat_truncate(struct inode *inode)=0A=
 	struct super_block *sb =3D inode->i_sb;=0A=
 	struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
 	struct exfat_inode_info *ei =3D EXFAT_I(inode);=0A=
-	unsigned int blocksize =3D i_blocksize(inode);=0A=
-	loff_t aligned_size;=0A=
 	int err;=0A=
 =0A=
 	mutex_lock(&sbi->s_lock);=0A=
@@ -263,14 +260,6 @@ void exfat_truncate(struct inode *inode)=0A=
 =0A=
 	inode->i_blocks =3D round_up(i_size_read(inode), sbi->cluster_size) >> 9;=
=0A=
 write_size:=0A=
-	aligned_size =3D i_size_read(inode);=0A=
-	if (aligned_size & (blocksize - 1)) {=0A=
-		aligned_size |=3D (blocksize - 1);=0A=
-		aligned_size++;=0A=
-	}=0A=
-=0A=
-	if (ei->i_size_aligned > i_size_read(inode))=0A=
-		ei->i_size_aligned =3D aligned_size;=0A=
 	mutex_unlock(&sbi->s_lock);=0A=
 }=0A=
 =0A=
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c=0A=
index 82a23b1beaf7..7c62fbc5027f 100644=0A=
--- a/fs/exfat/inode.c=0A=
+++ b/fs/exfat/inode.c=0A=
@@ -258,21 +258,6 @@ static int exfat_map_cluster(struct inode *inode, unsi=
gned int clu_offset,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static int exfat_map_new_buffer(struct exfat_inode_info *ei,=0A=
-		struct buffer_head *bh, loff_t pos)=0A=
-{=0A=
-	if (buffer_delay(bh) && pos > ei->i_size_aligned)=0A=
-		return -EIO;=0A=
-	set_buffer_new(bh);=0A=
-=0A=
-	/*=0A=
-	 * Adjust i_size_aligned if ondisk_size is bigger than it.=0A=
-	 */=0A=
-	if (exfat_ondisk_size(&ei->vfs_inode) > ei->i_size_aligned)=0A=
-		ei->i_size_aligned =3D exfat_ondisk_size(&ei->vfs_inode);=0A=
-	return 0;=0A=
-}=0A=
-=0A=
 static int exfat_get_block(struct inode *inode, sector_t iblock,=0A=
 		struct buffer_head *bh_result, int create)=0A=
 {=0A=
@@ -286,7 +271,6 @@ static int exfat_get_block(struct inode *inode, sector_=
t iblock,=0A=
 	sector_t last_block;=0A=
 	sector_t phys =3D 0;=0A=
 	sector_t valid_blks;=0A=
-	loff_t pos;=0A=
 =0A=
 	mutex_lock(&sbi->s_lock);=0A=
 	last_block =3D EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);=0A=
@@ -314,8 +298,6 @@ static int exfat_get_block(struct inode *inode, sector_=
t iblock,=0A=
 	mapped_blocks =3D sbi->sect_per_clus - sec_offset;=0A=
 	max_blocks =3D min(mapped_blocks, max_blocks);=0A=
 =0A=
-	pos =3D EXFAT_BLK_TO_B((iblock + 1), sb);=0A=
-=0A=
 	map_bh(bh_result, sb, phys);=0A=
 	if (buffer_delay(bh_result))=0A=
 		clear_buffer_delay(bh_result);=0A=
@@ -336,13 +318,7 @@ static int exfat_get_block(struct inode *inode, sector=
_t iblock,=0A=
 		}=0A=
 =0A=
 		/* The area has not been written, map and mark as new. */=0A=
-		err =3D exfat_map_new_buffer(ei, bh_result, pos);=0A=
-		if (err) {=0A=
-			exfat_fs_error(sb,=0A=
-					"requested for bmap out of range(pos : (%llu) > i_size_aligned(%llu)\=
n",=0A=
-					pos, ei->i_size_aligned);=0A=
-			goto unlock_ret;=0A=
-		}=0A=
+		set_buffer_new(bh_result);=0A=
 =0A=
 		ei->valid_size =3D EXFAT_BLK_TO_B(iblock + max_blocks, sb);=0A=
 		mark_inode_dirty(inode);=0A=
@@ -365,7 +341,7 @@ static int exfat_get_block(struct inode *inode, sector_=
t iblock,=0A=
 			 * The block has been partially written,=0A=
 			 * zero the unwritten part and map the block.=0A=
 			 */=0A=
-			loff_t size, off;=0A=
+			loff_t size, off, pos;=0A=
 =0A=
 			max_blocks =3D 1;=0A=
 =0A=
@@ -376,7 +352,7 @@ static int exfat_get_block(struct inode *inode, sector_=
t iblock,=0A=
 			if (!bh_result->b_folio)=0A=
 				goto done;=0A=
 =0A=
-			pos -=3D sb->s_blocksize;=0A=
+			pos =3D EXFAT_BLK_TO_B(iblock, sb);=0A=
 			size =3D ei->valid_size - pos;=0A=
 			off =3D pos & (PAGE_SIZE - 1);=0A=
 =0A=
@@ -464,14 +440,6 @@ static int exfat_write_end(struct file *file, struct a=
ddress_space *mapping,=0A=
 	int err;=0A=
 =0A=
 	err =3D generic_write_end(file, mapping, pos, len, copied, pagep, fsdata)=
;=0A=
-=0A=
-	if (ei->i_size_aligned < i_size_read(inode)) {=0A=
-		exfat_fs_error(inode->i_sb,=0A=
-			"invalid size(size(%llu) > aligned(%llu)\n",=0A=
-			i_size_read(inode), ei->i_size_aligned);=0A=
-		return -EIO;=0A=
-	}=0A=
-=0A=
 	if (err < len)=0A=
 		exfat_write_failed(mapping, pos+len);=0A=
 =0A=
@@ -499,20 +467,6 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, str=
uct iov_iter *iter)=0A=
 	int rw =3D iov_iter_rw(iter);=0A=
 	ssize_t ret;=0A=
 =0A=
-	if (rw =3D=3D WRITE) {=0A=
-		/*=0A=
-		 * FIXME: blockdev_direct_IO() doesn't use ->write_begin(),=0A=
-		 * so we need to update the ->i_size_aligned to block boundary.=0A=
-		 *=0A=
-		 * But we must fill the remaining area or hole by nul for=0A=
-		 * updating ->i_size_aligned=0A=
-		 *=0A=
-		 * Return 0, and fallback to normal buffered write.=0A=
-		 */=0A=
-		if (EXFAT_I(inode)->i_size_aligned < size)=0A=
-			return 0;=0A=
-	}=0A=
-=0A=
 	/*=0A=
 	 * Need to use the DIO_LOCKING for avoiding the race=0A=
 	 * condition of exfat_get_block() and ->truncate().=0A=
@@ -526,8 +480,18 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, str=
uct iov_iter *iter)=0A=
 	} else=0A=
 		size =3D pos + ret;=0A=
 =0A=
-	/* zero the unwritten part in the partially written block */=0A=
-	if (rw =3D=3D READ && pos < ei->valid_size && ei->valid_size < size) {=0A=
+	if (rw =3D=3D WRITE) {=0A=
+		/*=0A=
+		 * If the block had been partially written before this write,=0A=
+		 * ->valid_size will not be updated in exfat_get_block(),=0A=
+		 * update it here.=0A=
+		 */=0A=
+		if (ei->valid_size < size) {=0A=
+			ei->valid_size =3D size;=0A=
+			mark_inode_dirty(inode);=0A=
+		}=0A=
+	} else if (pos < ei->valid_size && ei->valid_size < size) {=0A=
+		/* zero the unwritten part in the partially written block */=0A=
 		iov_iter_revert(iter, size - ei->valid_size);=0A=
 		iov_iter_zero(size - ei->valid_size, iter);=0A=
 	}=0A=
@@ -667,14 +631,6 @@ static int exfat_fill_inode(struct inode *inode, struc=
t exfat_dir_entry *info)=0A=
 =0A=
 	i_size_write(inode, size);=0A=
 =0A=
-	/* ondisk and aligned size should be aligned with block size */=0A=
-	if (size & (inode->i_sb->s_blocksize - 1)) {=0A=
-		size |=3D (inode->i_sb->s_blocksize - 1);=0A=
-		size++;=0A=
-	}=0A=
-=0A=
-	ei->i_size_aligned =3D size;=0A=
-=0A=
 	exfat_save_attr(inode, info->attr);=0A=
 =0A=
 	inode->i_blocks =3D round_up(i_size_read(inode), sbi->cluster_size) >> 9;=
=0A=
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c=0A=
index 6313dee5c9bb..3e6c789a72c4 100644=0A=
--- a/fs/exfat/namei.c=0A=
+++ b/fs/exfat/namei.c=0A=
@@ -372,7 +372,6 @@ static int exfat_find_empty_entry(struct inode *inode,=
=0A=
 =0A=
 		/* directory inode should be updated in here */=0A=
 		i_size_write(inode, size);=0A=
-		ei->i_size_aligned +=3D sbi->cluster_size;=0A=
 		ei->valid_size +=3D sbi->cluster_size;=0A=
 		ei->flags =3D p_dir->flags;=0A=
 		inode->i_blocks +=3D sbi->cluster_size >> 9;=0A=
diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
index 61d8377201f6..05fa638b411a 100644=0A=
--- a/fs/exfat/super.c=0A=
+++ b/fs/exfat/super.c=0A=
@@ -370,7 +370,6 @@ static int exfat_read_root(struct inode *inode)=0A=
 =0A=
 	inode->i_blocks =3D round_up(i_size_read(inode), sbi->cluster_size) >> 9;=
=0A=
 	ei->i_pos =3D ((loff_t)sbi->root_dir << 32) | 0xffffffff;=0A=
-	ei->i_size_aligned =3D i_size_read(inode);=0A=
 =0A=
 	exfat_save_attr(inode, EXFAT_ATTR_SUBDIR);=0A=
 	ei->i_crtime =3D simple_inode_init_ts(inode);=0A=
-- =0A=
2.34.1=0A=

