Return-Path: <linux-fsdevel+bounces-39468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485BA14AF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 09:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430691659CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC841F890B;
	Fri, 17 Jan 2025 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="F9WgYT4h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BDF1F869B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101815; cv=fail; b=l4NYJzyC+if8YTwlC8VGpt7lDZ9J2aeX1wcCckigo+L78J89ogERFvnCKzdmO7kAp02i3R2zbzT0zc78nO4brVxL09vx9d/Ayvvc++q9OL0ds+ynEQtJ9RgsHyqSgyOoVnjXx8gs6VVXOPcja+9H+hPags9Ln9GIlMMBEi4Baxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101815; c=relaxed/simple;
	bh=XM7zBuR3ErapLXj314obO2uAAiRMXfdkGUym4Htip8A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MEIYjGXpRGGg7EvkkjaUV0T//6yusw72hQAnFaO62hVMWzThB8onjPkHlRfpipCQM6JSaeubEhVZPQACD01C9pTB7gN70s3rDyIK1aXF4wbtpFLge3d9JaNsVu9wuXglp6RbzNiLReixnNGOY92047Ply6eYOgdHjdYPnNeblrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=F9WgYT4h; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H4P8h8011261;
	Fri, 17 Jan 2025 08:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=MoQ8ebwxlZujHpKwOw+UhAbFj94pSkHo3koEiz5bm4M=; b=F9WgYT4h6
	ibEpZlFWDS30dIy9OL2irvsxcfJC3sx5dJRBlXtr2f/WyO22jKmqeYV9jzGK2Tza
	uZzizxr+Rhp68/4Z2uwNjPgjCdQWMVMfb0OOhKdi5mmDNpVr51Ory4KTHa8dTXPK
	HvNK1Lbv8YZLNagRXOWbMBHbvTEy21FTVilyAmUrWIR/DlRTk6K6cyTvaWgJhg69
	H8fwZEOq24xzDCTT0YKpKBm3NgnPF2IUfcTCawNOJzZ0/4ygOc48XSqk04tXtkZ2
	xTdxHwdexZUwJwwmOfLpIYB+UootJzDd3DaWE8uhHyK0NCxduSQtptdUxmf0CKrU
	AA5WJJqtIC5KQ==
Received: from hk3pr03cu002.outbound.protection.outlook.com (mail-eastasiaazlp17011028.outbound.protection.outlook.com [40.93.128.28])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 443hsnvwhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 08:16:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kykqbps0GW2mhni2TCayOkWg6uxcTOKKF1yTf5yC1ZA8SlLygLO1qGeKhi+pFSEK7X0sahEVtcNXjySu93h3+a55ZA9FB8/W+/r8aPoZYnCbDbiSFi4FlYCfO2aNP8hI7hS+gKr7bTHFh8ONKW7xeizjs5edlZZQNmKsMMZ8uExbDOZ5TCteVKf7ZjpzoC1Z7ZgAmnfwIX5jjL6LkLXlOZZ7y5bG7JVv+jfHfQUO2JKwbgdbHX8lQqSbe56zJi/jMpgyOr3lDxui52UMK/KUq+Vi10wvcubXDX3HK5kdBjQqqWvdeFPbrg3puHNyoOO6+P12ZmlTlkbkLUiNlxPJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoQ8ebwxlZujHpKwOw+UhAbFj94pSkHo3koEiz5bm4M=;
 b=vx9LpmV1TtZEMfH7vg5KYOXh3zTWe0gFnjLJR5JLKLJzGt8VvWoEHTSzBWu9ipkcC4/pdwSJmQHRlijp9GUhF/GgV+Mw3qm4/zfzC/+WHNzm06+3v9AzqAS6O7GmTeXWGcm2fkIuzBF1r2wbtx6L19z0xIuKndicuzMBFKbcb/RYhxgLIRwEHRElXU6BgfCk5ftVCACnZfFnhGXjR0DJfDTcCeYXnke//kA2xI6wu3Tqek7V+YZmMndhhZny1VRVa1aGYv0eSgoLiawaK2dl4GdI5GQmKVJoeDFhWb1zPemyqYXdOrVguz67x04z+QSPuYWLyUj1N0PcW1IUWstG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB5786.apcprd04.prod.outlook.com (2603:1096:101:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 08:16:24 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 08:16:23 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix just enough dentries but allocate a new cluster
 to dir
Thread-Topic: [PATCH v1] exfat: fix just enough dentries but allocate a new
 cluster to dir
Thread-Index: AQHbaLeR+fGzOmL3QkeMJzTQJ3OFnw==
Date: Fri, 17 Jan 2025 08:16:23 +0000
Message-ID:
 <PUZPR04MB6316C98ED4C7811402F3F0F3811B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB5786:EE_
x-ms-office365-filtering-correlation-id: b2ae37c9-f69b-4022-4196-08dd36cf3ae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1AHHaFVJj16uwwxYKAwN5FEXqFMclUluCnXWWPmBTuiimOpD95UBI7T9wG?=
 =?iso-8859-1?Q?ZID08zfmcs0oWXr+JL5g7mxPXGtoB9CDTIIHhwv+zxe1Mxd8U2YFaZ8iXu?=
 =?iso-8859-1?Q?dvlxRBlV365rjAUUDNmbP3mGLfMCoDjfCvwrVdoNAVXJpb6HxlR2g80yyh?=
 =?iso-8859-1?Q?vqu30edrv7QIKhZrCw3Uq4we6Ft1gUDY1GyRvhB4HNC39Ivr783QZQFYD2?=
 =?iso-8859-1?Q?nQ7yM7ngnqsgU4CPqchauCOHIxG9PQGIbwo7xpb5YskqYS88H4xYIjljlF?=
 =?iso-8859-1?Q?8u6Mp9cwPoKpBScm1J+Hk+64IwJAxb8phcNcpeTY3+iDtvlSZNBFqcNYZp?=
 =?iso-8859-1?Q?Fg2oqY9U6b72fKif4+K2zsHCan9zAFjXX58XYo9cEjzKYXX3h3BEmtIsfS?=
 =?iso-8859-1?Q?KWxnr94OGhGzbltlkWBr1PyQflcrSiPyZDZVQ+xYHi+vzK+frwSkLBfj4j?=
 =?iso-8859-1?Q?EOBc/f+KgrgXr18nVHlrJA4MzABcvyLH9dp4jEuiAXEVid0q1ln/6dNbUf?=
 =?iso-8859-1?Q?tc50UyQEx5tHuLD9oaRvi2TeZDZ6P/I8+YRORwsQYPbcOKKSd6OwicaW8h?=
 =?iso-8859-1?Q?I8CvFFfsQVmKovoN39B79yOON2KJG+g6OPnHQqiMlGB1+65DmebtwFb7lk?=
 =?iso-8859-1?Q?JoUrM49jwUeC2k3d7s40iJ6GECiA+Pn9nxVAyGhbULMTZKI5PRwfMZEHsw?=
 =?iso-8859-1?Q?WyG7HZjJQnEhYiDy62k44aNnz6wm+H9pg1amdqoXI9643C+tgC8yQDPWhS?=
 =?iso-8859-1?Q?63nluNzW2XZxwFaQZTEVwliaX8hJ3tfvs0MXv9RSaPYCQgqULOFyZQSzIx?=
 =?iso-8859-1?Q?8bxqUEuwnJgyFaKfCAHc0wuwSK38qd8ELdlP/KQQMZkTm+iCGVbsl4dm99?=
 =?iso-8859-1?Q?1hp0swjkJ1TGcauXnCNfAC7N3MDUHE2I0FR7/ibUiFYS+uwjDyECaSWkSz?=
 =?iso-8859-1?Q?SuKf1liwETU7xSq6RjtjnorPlkivWFeyns0IsfzW7B8tgZO2Rc+C2PmZrV?=
 =?iso-8859-1?Q?p4Xj4X2hd3fmeTQ21T4yVeadlvLBlskB0yREjOZAvQJ5c9Cwr8nkFHqHoD?=
 =?iso-8859-1?Q?2NHvh+v390XOoKJVztfbRnB1He97R00q3aOYIfwMATPVr3j7iqV3BpMcXu?=
 =?iso-8859-1?Q?O/jTwl4RihtDuenOJcSob1L/rYMYUnsvfmPzylHhBVl5WfnEdjB7/unHHl?=
 =?iso-8859-1?Q?/IcSukU4/puM5eTE7vDrdTRkqI3hQm0umxtk5Pp/iD3CKuoDL+rrWnVuEz?=
 =?iso-8859-1?Q?bkbNXzzJSwaWbgEH9eI/FHM0SIpgbjTeR5FpAuw2eVeFf1pgQzA9k8waLV?=
 =?iso-8859-1?Q?2G3YdrU6BAZTI8gOPTPPjkMBICGtsDxt6+WXIBdrmS6a/WxBthaKE61s2O?=
 =?iso-8859-1?Q?7oCgq1PNPsXJeYPCZve4GFdBzVNyHpl1SBy0CcBoLnGtZgin7SCZBn03Ro?=
 =?iso-8859-1?Q?vRkT1P/o1khhDh5iWtLJSaX04pfwuu/ea/i/e+eaVc/IJ7nVGz8InzzHNZ?=
 =?iso-8859-1?Q?vnq/4qVM+IygDYLMkXI9bn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SZpHVZK7JjJjPuOumajCD1D7H6KdJ3R/EF3kCvIfBYYPAuQ+q36SDQQJEP?=
 =?iso-8859-1?Q?k9LzkFSluzZtz0y+RSaFSNCLPvGyCSqrriHzUdIi6l+ImTyGUHKvsAE+0w?=
 =?iso-8859-1?Q?YYYP8D3ki1Qg2DiqdoIEbQNC3sVl3BUP35z2drPUk2i2ACSLGRZwSBN2GT?=
 =?iso-8859-1?Q?7BLtn2B3R4DPQMXwTtY4BvFpFLEow/2UAqOhfijeJZqE0aad4CpPLP1qxH?=
 =?iso-8859-1?Q?BP2QjCUQowZgtMRT2pD+MXoPeydV3nkjueuyh947d3kl4PE4XVfOHCcfdr?=
 =?iso-8859-1?Q?hF+acx01Lew4ZeGH1uzWHgIBod4RmFnMAtjdNEfF73NLJJQ9CJK0Ihb8in?=
 =?iso-8859-1?Q?ohD9G0GEMAUtyLPrYWgb+F0PHDWyoe5m7JgmKfF+nzwhtwtbSbrNUxHuAf?=
 =?iso-8859-1?Q?jllEzD0ZfHInH7hgn47ZoOek6U03w0WH4yMjBSrDmy6YJp5amBqUbnenGn?=
 =?iso-8859-1?Q?lOdvBdX8EbMSxm/7hgHh2mJTq9tz2CGUe96W+BFZFQ7h6STtRAKJixkSHw?=
 =?iso-8859-1?Q?O5CDxORXiSlbTrFUbKqpjEZLq5GUxe4SA9JFYnhN18deQbOp9umuhvBPQz?=
 =?iso-8859-1?Q?vOXjOKLiR0gTNnzQZkG+u1Ranp2QnXYUVaejMS2ilr/guOX/zK4D4h5rY4?=
 =?iso-8859-1?Q?itA3o9zkaa8p1M0I0Cn4iiMzY+pjF+GT3YjoPdy0K3zcXfcjaraA1K5rDb?=
 =?iso-8859-1?Q?hZmt02gyN1kMC9vZqzdAHbambGVT5qgVSvqdfH4GxlJsA7i8sfSpY2SxgV?=
 =?iso-8859-1?Q?NTBReZdcVjGtnkyS1nbK+KZxAkQG0WDTAnj/CnxW+uxroP27kzl87PfNmC?=
 =?iso-8859-1?Q?+TZGik2B3/giovoHudNfx0VSFwTTOoGo/5JtEScD7bOvh1M0TKggeOGaj2?=
 =?iso-8859-1?Q?AvRLAFZ8KViGNlT/ImIXkqi/nNLNEvw3dWhoByKjEm2vh+jjlANV4Xvf1P?=
 =?iso-8859-1?Q?2lLuMBKrPI5ajholCrwTTEvTBZWE3rBDeDcbMyucLhy0kmw2WYcNDes5SO?=
 =?iso-8859-1?Q?il8LL8PH5L5NgDqR5x1VgCrR2BrauxaZTc4sA9HPWK20mD4+3e9X5JEFpw?=
 =?iso-8859-1?Q?b58rJAZc2I4cBp/A412lT+YF/lTuM/5g2UGSRIqoGdKpb/GeOsMWS3xbYh?=
 =?iso-8859-1?Q?OMPn3pa+N042Cjd5+3hSa7pWYwykv/haz0ra4hRrjc7rCJgccS54Fe+GqT?=
 =?iso-8859-1?Q?Q8EO2qQdXx2KxTQCdaaUeTKzSwUHCqs5MuZmRt78Ubz+sOp4btkJRQROAR?=
 =?iso-8859-1?Q?dugYCod4cTqozR+dtrhX4l6bvFDJy09kcpsefHO/yCFJCOV85lm5a9Jmrf?=
 =?iso-8859-1?Q?inxY6H+Up5AbJ6ripud6NkOROsNsvb4drhfEfjC7D53DAB47ueznTUoeGe?=
 =?iso-8859-1?Q?ItCjXJ5ZY0F4DNvN7Kh9DJVyVLAik740VxA4fkWNMmhsE47SV3hiqFKLYm?=
 =?iso-8859-1?Q?YKewBO47qbrCj6qaPiXuOZ1wXix7dHWgWBwX9jrfIgXHuI5dkmbZeAQR9I?=
 =?iso-8859-1?Q?jBK+Hzn2bbhaZn2e33JLPmEAcpBbKuk6G1hDDOx2ZEL9Wn2OyRl3ROa0fM?=
 =?iso-8859-1?Q?cdm8h+q1L7zmyUX1hVrjx+8vG57pdBS6yB3Ftp60JqLFMn6ePvBQ9kgF5i?=
 =?iso-8859-1?Q?SEW0LGSuAAJyBpF02lWuX3Ywv8pLYPMv5O0PfUZGMjwEazbxV0rlnNla2b?=
 =?iso-8859-1?Q?d0kMU9DCNp/h7nuCfmQ=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316C98ED4C7811402F3F0F3811B2PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sw1jLlDsC9tvxkevEEoC54ndxSUeSykNDRYdAbbbSKq2meS4IVef1RbYKa80oa6GryyXvIIiPJaJkdt2jruoTKJj8fyF/fRmwFfD/4zM8NorWe0SUrr6wc0uZ3+almQteUYObKHbosOgajL+ZCxdpX9x1eBnZ0spaAJNsUrJFibohs/kv9mat4lccoaham2wz6mGnfqWZxAthokNHC774atvsPc37KYl7MVp3DLyuSGhMMbMqoX0sLZ6zcaq/iunI6tbTd43xS+thCWT0Ze7aFmnwQbg1pG7TvpGeOu8XtMAwUOTrEmLnMSWcVHf2yshAJ8A0A3znRdtsDLN8REYFgjBc672Nio2YSb93AdLr208fo0Jt6UmAh7hxC7kg2ZoQMv8jmfT7xDoNhfbQjNXU/BY9FSvbL520IOI7UQ61jB2RwBt1vr3kvL2cmPp2rIQCDqzIr0nss8cNr+S2kvcIprvbDrU+aJhmk1ALMKm59TKnaUbxKYwHP5OtWlyF5isvj1NXZeFuz/+Xc8FcVFuvlGBPd3PLjD1PHIyazLA2cFeL9qFsVLs1u7xYFacyJgiyHydYm/3tkghaWit7G9TqLZrXSAwHmPpmFEnLQchancvqcPGG7ZAKhbKDk5hZX/T
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ae37c9-f69b-4022-4196-08dd36cf3ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 08:16:23.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMhwUC36DYSCNgJ1P9rzkSbBvdASJ2lwzOFbrfedPU5pfyq0WhgJVhaH+oLAiCDd1UksbS05AMANt2Vkn1ULqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5786
X-Proofpoint-ORIG-GUID: 7NRuce8mGl8yukskPYJTkJW6q9_iXXVl
X-Proofpoint-GUID: 7NRuce8mGl8yukskPYJTkJW6q9_iXXVl
X-Sony-Outbound-GUID: 7NRuce8mGl8yukskPYJTkJW6q9_iXXVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_03,2025-01-16_01,2024-11-22_01

--_002_PUZPR04MB6316C98ED4C7811402F3F0F3811B2PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This commit fixes the condition for allocating cluster to parent=0A=
directory to avoid allocating new cluster to parent directory when=0A=
there are just enough empty directory entries at the end of the=0A=
parent directory.=0A=
=0A=
Fixes: af02c72d0b62 ("exfat: convert exfat_find_empty_entry() to use dentry=
 cache")=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/namei.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c=0A=
index 97d2774760fe..ca616f2f2c8a 100644=0A=
--- a/fs/exfat/namei.c=0A=
+++ b/fs/exfat/namei.c=0A=
@@ -237,7 +237,7 @@ static int exfat_search_empty_slot(struct super_block *=
sb,=0A=
 		dentry =3D 0;=0A=
 	}=0A=
 =0A=
-	while (dentry + num_entries < total_entries &&=0A=
+	while (dentry + num_entries <=3D total_entries &&=0A=
 	       clu.dir !=3D EXFAT_EOF_CLUSTER) {=0A=
 		i =3D dentry & (dentries_per_clu - 1);=0A=
 =0A=
-- =0A=
2.43.0=

--_002_PUZPR04MB6316C98ED4C7811402F3F0F3811B2PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-just-enough-dentries-but-allocate-a-new.patch"
Content-Description:
 v1-0001-exfat-fix-just-enough-dentries-but-allocate-a-new.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-just-enough-dentries-but-allocate-a-new.patch";
	size=1093; creation-date="Fri, 17 Jan 2025 08:15:22 GMT";
	modification-date="Fri, 17 Jan 2025 08:15:22 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwNGYzZGUwNzkwNGM3N2RlY2ZiOGUwNTEzOGFkNWVkMGY0MzVhZDNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IEZyaSwgMjIgTm92IDIwMjQgMTA6NTA6NTUgKzA4MDAKU3ViamVjdDogW1BBVENIIHYxXSBl
eGZhdDogZml4IGp1c3QgZW5vdWdoIGRlbnRyaWVzIGJ1dCBhbGxvY2F0ZSBhIG5ldyBjbHVzdGVy
CiB0byBkaXIKClRoaXMgY29tbWl0IGZpeGVzIHRoZSBjb25kaXRpb24gZm9yIGFsbG9jYXRpbmcg
Y2x1c3RlciB0byBwYXJlbnQKZGlyZWN0b3J5IHRvIGF2b2lkIGFsbG9jYXRpbmcgbmV3IGNsdXN0
ZXIgdG8gcGFyZW50IGRpcmVjdG9yeSB3aGVuCnRoZXJlIGFyZSBqdXN0IGVub3VnaCBlbXB0eSBk
aXJlY3RvcnkgZW50cmllcyBhdCB0aGUgZW5kIG9mIHRoZQpwYXJlbnQgZGlyZWN0b3J5LgoKRml4
ZXM6IGFmMDJjNzJkMGI2MiAoImV4ZmF0OiBjb252ZXJ0IGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnko
KSB0byB1c2UgZGVudHJ5IGNhY2hlIikKU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpo
YW5nLk1vQHNvbnkuY29tPgotLS0KIGZzL2V4ZmF0L25hbWVpLmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9leGZh
dC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWkuYwppbmRleCA5N2QyNzc0NzYwZmUuLmNhNjE2ZjJm
MmM4YSAxMDA2NDQKLS0tIGEvZnMvZXhmYXQvbmFtZWkuYworKysgYi9mcy9leGZhdC9uYW1laS5j
CkBAIC0yMzcsNyArMjM3LDcgQEAgc3RhdGljIGludCBleGZhdF9zZWFyY2hfZW1wdHlfc2xvdChz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLAogCQlkZW50cnkgPSAwOwogCX0KIAotCXdoaWxlIChkZW50
cnkgKyBudW1fZW50cmllcyA8IHRvdGFsX2VudHJpZXMgJiYKKwl3aGlsZSAoZGVudHJ5ICsgbnVt
X2VudHJpZXMgPD0gdG90YWxfZW50cmllcyAmJgogCSAgICAgICBjbHUuZGlyICE9IEVYRkFUX0VP
Rl9DTFVTVEVSKSB7CiAJCWkgPSBkZW50cnkgJiAoZGVudHJpZXNfcGVyX2NsdSAtIDEpOwogCi0t
IAoyLjQzLjAKCg==

--_002_PUZPR04MB6316C98ED4C7811402F3F0F3811B2PUZPR04MB6316apcp_--

