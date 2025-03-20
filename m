Return-Path: <linux-fsdevel+bounces-44519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B09A6A106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639601899B32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082B1DF248;
	Thu, 20 Mar 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="M2gn+KVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B43597B;
	Thu, 20 Mar 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458634; cv=fail; b=bCuNwphb0ye04FwgS5qmbeP1zqrglAr0XkquVzgewOqftbtH28KJytSFby3TRUWywHCZuMzUvJHTmvt9Nxci5yAy/6hp/Rb2hiBtQ5wIGUi2oCQVVDOC9rXZrP77a0ujNAxkGAz455dNYPhdP/B8eucFCoknKZm/K1G9YFtsCcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458634; c=relaxed/simple;
	bh=FDs+Hx4Tmfky1M9ECReiovMDQQ+U5B1DY21SfpW1BFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fsSOvg8+82jQhuDgLpJelDZJfx9ZqNoyezxOS3WlLliVZiRnJoGIvT8lYyPfqgxdQt6Ptk9f0f1IwMFXdXDrKZ+3QTxqgprMxdLXas4veZXtT+2tJSrNAbaHZ79BvFXzwktOXeHtOTM3AI4V4oZMt1telK8ZPZ3MiI/6cE3uN10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=M2gn+KVz; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K7TOaT012459;
	Thu, 20 Mar 2025 08:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=HotsxcH
	crCuZ3SKRcmMq881fdUBlPWrlBVWFvNAgTic=; b=M2gn+KVzOsTtYXFlYlfLuGL
	dctqvdQWnBRq/mgxTEEWxHtpGSV49i2HwdPMnNuDtMzRziQ/0iqd2oFPtaIwT8x5
	gDo6jU97ipvKaxTVOhFlrlxQ7juoAlAavA4xzuyM7ot8dSOKbK+ykIFJo5cR37Df
	bbFg8O5xY03kz0YO7x75xPz7E91hl0Sq6vMBxtwus93nTm25WOaKTXWFCZQr72L6
	fGLO8IjHoogdWt+lyoFJtWfoO6MbqOIWDbeDqNFqacCzSpjEkv+ZKXAymY3+yOpL
	Nk2uIhOiKQRCNFlkscznjK1ZZBa1CdCkCNnok6ai7Cg8T/1TQeyqk+F+S3zNdvw=
	=
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45d1fmcc1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 08:16:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgUeUgkA39chgRUGG8QRDSQcAP91+h8tAYAe72BD4pWwCU+kYzeuDFeXQx9m98Id9fFZHBhcnTNL54tcJSnm27qet/QaFtb4FZTJY6rxtkS3iWIaVZYzEiHS6Yjk5Ty0Yuy28pGjba56LBRFF1czaF92+u0akuv8v5YygrfjMLNahP3k11+uXaTgBplmJyKaaTAhz3t+y7xCSk2KqjbUxNRBdUh4dTQThkgGxOmJ8Eog0oMg/ObCYEdzp8kVqX7l6/WYZ4D1/KHtPVnegODyS9OKCS4HbkostDe25AMFsrLItS7Ycb7qJTVHaRODLuhV62U7bL70ohwh+aAnc/aFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HotsxcHcrCuZ3SKRcmMq881fdUBlPWrlBVWFvNAgTic=;
 b=yy0WHG3CBllLdskKjpmYcSm5z5qCyBSB3PU+K0+1JV3yev8Jrd5jqMxMQPDJtQB+r+esnh67UYJYfeW6xy+H0Dh+44bYpFbYCquZkqhGsKmnbIOaU3p1dylwG4i12SIuiDd94phELEqjmstRwMJVBGRtVeo9SgbLtz6Bv+6Wxgh7NQAl1z0a+jQivoUfuTP1dk1REeLGLyYUA7kiGZ5xfq5iAOKQp08qIc1gjvQal2igcSA2toDlaxK/ifuOalqDAqMTJbxNxsJwVW447luEjzpcVnKVkEaU4NIDmC3SLHzcX9hiGrM8U0aNy8zdakwiCnN+CpQJOoVb+mZ0KOCz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB6677.apcprd04.prod.outlook.com (2603:1096:101:d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:16:41 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:16:41 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "sjdev.seo@gmail.com" <sjdev.seo@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Yeongjin Gil <youngjin.gil@samsung.com>
Subject: Re: [PATCH] exfat: fix random stack corruption after get_block
Thread-Topic: [PATCH] exfat: fix random stack corruption after get_block
Thread-Index: AQHbmVnc+DxByo40t0K8i54nlxAvsrN7qT6X
Date: Thu, 20 Mar 2025 08:16:41 +0000
Message-ID:
 <PUZPR04MB6316CA3B8281D08C2A85435A81D82@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <CGME20250320052646epcas1p384845fdc17bf572784c99ca81cd4c9dc@epcas1p3.samsung.com>
 <158453976.61742448904639.JavaMail.epsvc@epcpadp1new>
In-Reply-To: <158453976.61742448904639.JavaMail.epsvc@epcpadp1new>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB6677:EE_
x-ms-office365-filtering-correlation-id: d27be951-ce6d-424e-5e7b-08dd67878b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2d/0eIz503CEoevRvK4wUidcVsjFOPnYPfk144hxB0bRm7KkW52G6ctFfR?=
 =?iso-8859-1?Q?8QoRcOTTbWU/LVJBWObqKdO7l+9oE8HavLfxJ/tW6CE5ZmTfG3awV2Nqya?=
 =?iso-8859-1?Q?/d+40nwSiTeNb0Xx0TP/goRZ/tmg4Ax2YyHtgPhNGBsOs+3D5Wbwz8aXeG?=
 =?iso-8859-1?Q?LBYqqXIpSq3X8SWEGWmOqPNh7JLeDPlUl5vzh+5zzdAzwrquWPm5pWx7Y+?=
 =?iso-8859-1?Q?/bmxsQ0QJ2n8J6ShxKKbc83VRTux3oDVCVZailALwRQDEqbzPbjAUImPzM?=
 =?iso-8859-1?Q?/kzRvRxETkj0KwgmVEHHSgt35TckuArZu/p7TbiQw5dU7FgICYM0r+PfsF?=
 =?iso-8859-1?Q?Yz0eSeTIo1Tqyc/OsjEumD5QcxhNvoVZ5TG6c+MbVvujI5bmlk0Od5lkCY?=
 =?iso-8859-1?Q?e8QOgcQDsfPJiMt8fI4x7F3lU95kcIKrFEca1S0icIUk//Csr94FqfZ5Ul?=
 =?iso-8859-1?Q?uISXb3qeHyX4Vc4CwK2hVwoWdZ2AQ9UD6qbO4X76muA2i8OzS4sEIzYl4W?=
 =?iso-8859-1?Q?Uc3ivOQxfBwucsHZ2Vmivm0pZyRvpP8EbY0G0nnS29O/X1sHF6B8LqAPBP?=
 =?iso-8859-1?Q?RQUfS6D1ekHI03stkb7puwmxPNsxJk38J+oL66SWng1+QFNJWaTWr0uCPn?=
 =?iso-8859-1?Q?YuvKfLWtjkJU2kPJnb1Qh15/Wi6eFr/Ch+AbC+dlZ1ixYpgba4RluSxcP3?=
 =?iso-8859-1?Q?Z422ZWfub3QLdCqmMUecxTkRORXmVc7jSVEP+Ccm0njhG9/Jml8hk3ySp1?=
 =?iso-8859-1?Q?7V6MQemqLJpzR2D2Nc0v+UzcEB8SjO7jubgHFvKFZyUDisXs4R+upSaiUE?=
 =?iso-8859-1?Q?ywoDtZeOpE2j5x8gW+JjEmd9zkjbcDEOvrDlrEa8T+g3Pq4+Qn19Tw/iTa?=
 =?iso-8859-1?Q?6uO/Dz/zC1rgcroVdwtQ20B5FRYef66EdIDcaidhoEU+uV66XfkZUS1rWQ?=
 =?iso-8859-1?Q?Fu9JTjaz7YcaGlw098uWvfRkA6ECuhnqSIiZdzA5JqeRflMRw/A3H93LfY?=
 =?iso-8859-1?Q?UjYZ+b6MmqTWzAv2zJFvKYQYdw8O7Dt1sos/u/CilnADdBvLx4mJ6IwjQC?=
 =?iso-8859-1?Q?ovDn8U1QYIKQWhaE9XM9LRl8bDb1BU0Q4F20/i01dXfE0naYchFRTb6mzu?=
 =?iso-8859-1?Q?rFMlqNREJQEkSziuxhYGap6xFqGQN8kTf6Dy3+PNXS2H8XtNpuc3T5X0rW?=
 =?iso-8859-1?Q?Y5jFRjdWFxg8OeNK6gwowhJf52FPD8nNVaKE2gotEpDhoBvaXaE9tx+V4B?=
 =?iso-8859-1?Q?rafckdb2YQLHQh4qnxHMZTtLyw6il0CD+pjXj3CexC9gjKPxOJvOn6UTNS?=
 =?iso-8859-1?Q?/eYi/ryBSWzKTtJY8BPXOD53AT1YsQ8xoiaJnHjjV9Xxg2ZUKff65d9uGT?=
 =?iso-8859-1?Q?I1VycSHjfridiud1KRuYR4C48IAx2/mS5RsHytbt+NfjZwCTbFl+HIOfSJ?=
 =?iso-8859-1?Q?XucSWZghvOTliNw4bVAhVCTcrPMujyyhVGuI1JPdi5+RL3INg2O+1Y6Ptg?=
 =?iso-8859-1?Q?HBDlUcozDphXEI4CcE6PVG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AoVdxVzVbsUDDfnkuWQ7/3K3tsZfj56JBWcQFsiIVvZXRiNyasLTEeZARN?=
 =?iso-8859-1?Q?Xe8uJ27vs1iR2e5+M7vGLDHTUEhXutrN8AdjUfliQelLprfoOfT+q/1nnw?=
 =?iso-8859-1?Q?3HsH/1Rq2qx0sLOJToo/yXXxJXLhlDGjczWjvakcVr0suOJwTqPxsG3MtA?=
 =?iso-8859-1?Q?zBiebZ7EMNwhclW+EJ2oEnQOiqUpYPF4QV0MUFGAE0iuXHVp9vrDzahdQG?=
 =?iso-8859-1?Q?g8PnjX1Ts2v2D9+IKFuLtPEDB6hdYb6f5e90uh0TlnZ0/qRDvfDUNh0Oxz?=
 =?iso-8859-1?Q?6sapvu8xWcp9zhjysGn9n/OUUEq1jlYhnPyDOUgQIatWpqGaP7DO4dQvrk?=
 =?iso-8859-1?Q?K/rLejiAVespALkK4JqTxOpz5mBbZbNpCkuoglVgvJgv5MikzL3iVUUvws?=
 =?iso-8859-1?Q?CpCdH7brVlQBKQbzpYLA8n72M1OigUVrCH6/f+IbI6dldvYXcBACa8nU3i?=
 =?iso-8859-1?Q?yNcevNqA+C/X2jePt8xVbXJPsmw0iduBuR2JXBjaMv4sUuMIxCHPaHzF5M?=
 =?iso-8859-1?Q?wQuuRZkPRHQu4rW9eXtPRMKDzpwZXXawlhDmcxhi2AhaYzyAxT2c7UyrKp?=
 =?iso-8859-1?Q?JgAUUWQqixfJlSdLsMT9wINddeiCjxTZjWkM50vljfFyeQBY7ayIOiwbjE?=
 =?iso-8859-1?Q?FPcc2Z5wcBzmVVSx6PddNzv9r+Dr7NVJpLmGw5vbhO4lOQ5Gu3BokBah2T?=
 =?iso-8859-1?Q?TTY4zSoODujRLflruOBQUuRLgCxulqXNsERpZ8X8QSQoLIUCm6WXadpPje?=
 =?iso-8859-1?Q?PMrO9EmwCCfP/vFwWHKqJryb+v1LaMVv5+qIy/npvtWciZBPGvkQSJoBeU?=
 =?iso-8859-1?Q?3DOoMva2dc/ORMZZAybQKc6hTblh4tlwbGHQagx3ZELJzSFQSoHTF/A6wj?=
 =?iso-8859-1?Q?GW6zOg09UCqp/B5bC6Ks72hagVH0xPCKJOOzK+ukskWWCNORjzokPKbng+?=
 =?iso-8859-1?Q?/FEbx9lg96Q6E7Romjtg5a5bYP8MyJKbSLrxOR19rntaorfVt5USTNpyy4?=
 =?iso-8859-1?Q?w4HJiv3AANCLKQ1ZdrkuX2H8NEjk/87qgY1C4QI4ClUWtWFkNo2yINKfO3?=
 =?iso-8859-1?Q?IlgdjufgHuUi8nN9VeFtsd3GHAtO3742UwlMzUWlx3R2PPtCxoX14qyM4h?=
 =?iso-8859-1?Q?QRULCt2xLhMl8niPRbE4Z2gs23F0xLgony3QZUXM8OwbA8N5BMWmH4C73p?=
 =?iso-8859-1?Q?QPyl2omvtJx/FLKF3/gBW8MvLh527t0Jnj+DtUl6puXTQXldimsd1BVTUc?=
 =?iso-8859-1?Q?gYcvpENDDW9osUCOEEmF99L59f/Ex39XSnPn0MLqdK1nLo4Rfm83EyM/3E?=
 =?iso-8859-1?Q?90s3PY7j4qhKThYyM+Cy0S9v7uwebmo50YNCOaypYrAuvEYtVtfysh2LSl?=
 =?iso-8859-1?Q?SxsxmwGl2INWgGJ7vhLV8DNMhnfg+R8uXDZLEcqDp7YvtNmMoVXsxz20DW?=
 =?iso-8859-1?Q?vRUm6epqQcA8j0SWiVAcLNrv95ycX9n+05ENLKoy/E0h+aTYMwdbQdMOvD?=
 =?iso-8859-1?Q?ACbBg1/5Vwz66S5WFDX4NCA6meJoW7kyfVtXv/7s9MvVBDgqaRH66e22ot?=
 =?iso-8859-1?Q?5tMc00MVRc8Lh0+y05CMxj8fC5AMjYspxm0OD86D1eFHaONUQvkli+sayR?=
 =?iso-8859-1?Q?S14nxNUMLFlpIms8Q/bPdj63o8iZ2JhONxnSp65BhEmdCcHLQayj2infXh?=
 =?iso-8859-1?Q?mtKpKbn/0jOflVlQW0Y=3D?=
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
	ZIo/LShyO8ZYWesB0uzn6FtCpas4LgWD2EEm7j2ssPibEBSMWVuwCzJGapVc6w82Z3YM09/IURA0pZShmfN2qtBSo6cD12iSAqnRzQYeIovtEWPfDfEj8NLt0vJZ0QFHydApUcDSWDK+cx0ure1+C7tpgBMDnTre/JIF4wAQ/zQel5N9huME9WEuyfQYjVe1icyThR+Cce0BJboZEMchA7LK20OVd6zUYXn8L9Uiz+e3gzyobUp6qgWsWhbiMnwkQa145gZuiHwb6J/DMkxeqhBBDLUhmu/IzEJO+zI258Q049VpDM+nqvaSJcpam9gSWjlJvyVAnpjNkuFwc5ocgR8rXYlqjTvCoPtQm7+bR3PuqVY6xx68qAhW2oaVLt25UcTUUalAZugKiVtx1+WiI138ghBWpXgSVH7K4dFI5Fl5MyfMyN9D8mf3cWg9SoKG0PrRCZeJl8ZJPyra9tUFo/Tfhx/prW88ALkLwf18NxWCnqJ93Y08/zyb29TwHtDhvrxVZkprH4MR1E7DJ/qQdkXAHSWWVN2bDY19iecwVnWsXtpJE0NJr0f4A2WPax8Xq2IRu2mNdpI7Mj/tSKurgbbOnlCR13KF/W4MQsaX5ks/X3sdJ6APsX5tKZK7HRGz
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27be951-ce6d-424e-5e7b-08dd67878b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 08:16:41.5037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4CUh9hFY2tD87uOUhDY2pPf2mLrPbi/eKR6ih2ly84wrxOWMO3ZIlMngcGzDnshutSlGlPwwqghyEJPtlknTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6677
X-Proofpoint-GUID: K8nBJNcn_j-t12sT4c9tO_BGuat8LM9o
X-Proofpoint-ORIG-GUID: K8nBJNcn_j-t12sT4c9tO_BGuat8LM9o
X-Sony-Outbound-GUID: K8nBJNcn_j-t12sT4c9tO_BGuat8LM9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01

+                       /*=0A=
+                        * No buffer_head is allocated.=0A=
+                        * (1) bmap: It's enough to fill bh_result without =
I/O.=0A=
+                        * (2) read: The unwritten part should be filled wi=
th 0=0A=
+                        *           If a folio does not have any buffers,=
=0A=
+                        *           let's returns -EAGAIN to fallback to=
=0A=
+                        *           per-bh IO like block_read_full_folio()=
.=0A=
+                        */=0A=
+                       if (!folio_buffers(bh_result->b_folio)) {=0A=
+                               err =3D -EAGAIN;=0A=
+                               goto done;=0A=
+                       }=0A=
=0A=
bh_result is set as mapped by map_bh(), should we need to clear it if retur=
n an error?=0A=
=0A=
+=0A=
+                       BUG_ON(size > sb->s_blocksize);=0A=
=0A=
This check is equivalent to the following condition and is not necessary.=
=0A=
=0A=
                } else if (iblock =3D=3D valid_blks &&=0A=
                           (ei->valid_size & (sb->s_blocksize - 1))) {=0A=
=0A=
=0A=

