Return-Path: <linux-fsdevel+bounces-56502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543CB17DF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2297168E6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493A1F463C;
	Fri,  1 Aug 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="mSKK+Tan"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83222E55B
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035414; cv=fail; b=fNVw9QmT2UOC56rcFXRIEwpPpv/RcwqPlULipKJakDmstTbhp+qo2bLZamhIMtV02GV/ZPEEbsSFxWWFaEJSA0vGhdVACV0X2oVqXKH61e9W/cPlerzDqiYzwALopHgdCuoNUCAUFzPv5obBtktBECUqa8O9aUXIVHHgg9r4iGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035414; c=relaxed/simple;
	bh=jmKlaMip7ZKKz8xwL9tQtNC9APaM4BY1DWVCL/qS5vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IiLaloJ3weam0bmE4bNAqyrYXm6H9TEx8yW+6H4LIlKujpfhPiXIGU7gzfGr/4Jh76PEovQHQrEmjMXNtbWtzuKCZ1efwiY7s4onQG2uhJEyWcvzwfI8ByHe/y1bbkEgAvWLi/q3IfYwXM9iPHL15aWLQDPRGhLkqfZ6emnAsuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=mSKK+Tan; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5712t2DZ006635;
	Fri, 1 Aug 2025 08:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=Lfuh/S7
	2+V011drHMK7vJehiEWefA8ekHQs+RqQ+0CU=; b=mSKK+Tansu4J9cjG0dnVb8J
	t/gfxKDlyL00fvjv4oTVJHLuBfwIlZJLCgDgzeEkX6nD03Xv/SOm8NwSbKcXOWWq
	MC0UGZbSwQBQTYrPsIu+wEWLnM8Ub5k9nKWrECMxZ+9HdyMHXfdGtwNcvr8f+GOB
	eesadNqAMynSCsggnxwr5hiyFOXSrP5UEw+IwRHAxVxI/z2+uHYdpp9diNE8VYRf
	8+dlBjyRRypSffZLDO8qTNdS9vl04fv8rSkHTmYdcydoqpO6dMsPFiieG4kaexgT
	fvFmcBjHPYm0tnCpCF580RVXo+fFD1NPNFSC4Zzcc/JROppKrkTZalaUwFFpIpQ=
	=
Received: from tydpr03cu002.outbound.protection.outlook.com (mail-japaneastazon11013043.outbound.protection.outlook.com [52.101.127.43])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 484n7jnvc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 08:03:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hd5eRyjDyazwM90KpqkeLB94lkzbA3TJjvKBGTLD3BJEeOgpNHon1iqZcVkKu6RMHHnUxAOjgC9L9dcMhwjm4Gre8t0gJfY02ZR98JngItvdwd42KnrAjR3jRFnZAuYdkZEbyZWBamkfFZoUZ76ke4zI/1y+kwiGgg5IY2MIhPkG/amR2y/M6lkHqJLVd9MUemDf3GBSxEb8kYIv0fjepudc3P82qUNRrqR870PLwBiSK9daCpv3BSLhHFe7rHJBAxY0eV9xdTgCqRj/5kx3a8qFtaM4JASidfGzdoGgepjTnNvDChveML9nTtDYXGM4FHyxvN1hRrEMTjXwRqpTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfuh/S72+V011drHMK7vJehiEWefA8ekHQs+RqQ+0CU=;
 b=gnhHpF0aOiKDoKwn2nc32GrN5ipKDSTxfqe0w8KQEqkN2yQWT/E6RJAD/0Gmo9ct1OnsQKEJAfgeDeSZs7NK4odjaqaUp7B0aehnkCWizsP5pJPoABGdlH4NC9S3lErpoBMXb7sa2ls6+2yDL2u3URPf6vvozOb3z7MqYoLRQauC+9KMghPF/4SrdarM68/609nvpAVOsaP/4PjL9VE1RPa9mwsxMw4jHcgsh70IhqmgWxapxenx2tFRnajSTpLQF7kKqoIG1tg3aK8mhZbO2EP42ZED1gqeFYFYuQpvKlENNffGUdsE6MloiXsS6Ise5wZhoTKXf+Oxfjh4S9gmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB8324.apcprd04.prod.outlook.com (2603:1096:990:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 08:02:56 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 08:02:56 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: optimize allocation bitmap loading time
Thread-Topic: [PATCH] exfat: optimize allocation bitmap loading time
Thread-Index: AQHcAnlexXVdV2orAEGaDpRsE4C0gLRNZ6Aq
Date: Fri, 1 Aug 2025 08:02:56 +0000
Message-ID:
 <PUZPR04MB631623977A900687BA21F92E8126A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20250801001452.14105-1-linkinjeon@kernel.org>
In-Reply-To: <20250801001452.14105-1-linkinjeon@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB8324:EE_
x-ms-office365-filtering-correlation-id: 82f0ec08-e523-41f3-9963-08ddd0d1d2f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?p7vwf+OhQXVzFzByPfW9zJ9GM9VNFpppexFb83aujHICQ6kQz7EnO5Qo4W?=
 =?iso-8859-1?Q?8i0Jw7lQfb5f/yLJmhZBB+u4Dl3Kc1eNRdtQr1DfcHkzRLn3GvXoo0uh9i?=
 =?iso-8859-1?Q?QCs3i24LNd1vXI3vRnzgJSBzEUYNkjHEUGvQ6VuHYwIw3uroSnDxBjMoRV?=
 =?iso-8859-1?Q?pphupdsSCvIeRlcF9sqebXxpyBGBZCnhFjml3hf89nczJ4K7HpLFpK5l08?=
 =?iso-8859-1?Q?aPh+qmeXv//lv+i0YpUyCzG21uRrOwybvFnxKmCtMPWtksvKiOuWtvZu0P?=
 =?iso-8859-1?Q?K3iFEDEvYr31P8RhnLUE17mGVxOrIBtWSxVuMZOaYcDSIfQNAv9cszeqP5?=
 =?iso-8859-1?Q?4dbUKdjRkYmVsJwPeoR5NYhFM2sQyUe8WF20s5vi3Wy0g3/T1ivEVie+qG?=
 =?iso-8859-1?Q?gAgFMQqHA+ZYYSZSNd7UYO8Y/DI/jnO6bqCKuQp5K+XjImJP3joimUFHgC?=
 =?iso-8859-1?Q?WmHJ0s3gZ2gFDdRJyWLLvfDBYdReZr7cdpyDaf/3puH3nHifpx5Ine5xiL?=
 =?iso-8859-1?Q?KAhSO8IjEZIr7oFOBizMYSkS1XaYVF6+FCxGcYkpCOzMibniTddTn4Ra9G?=
 =?iso-8859-1?Q?/7DOwaEbbPn2c8HlAmPr1ED8ZN/xf+bNCoqXkPitcmN1vPpH229Tw8ehSU?=
 =?iso-8859-1?Q?VAeGUK8vfiiX8hBsAOJz16pq4gLHGOb88LOgihPJGBG0ZXYFrsJd7jTMTo?=
 =?iso-8859-1?Q?jEOiAXBaTdyqcJMvAyICvUOladzogjCTB5bGG19UsYwIYbIbBL2xMUZ80k?=
 =?iso-8859-1?Q?vGOwmBunw2ov9EHmc0uNXMnf1ynWgSr8dtYTOanxbRdgCXq20WISOl79QO?=
 =?iso-8859-1?Q?zwyz0ileuTqSCcIcdkNLtD0FzEElUQf0nm4OgNqSq4FaJFQiAlE3GaAQ1V?=
 =?iso-8859-1?Q?uBFkazrJ4e2SMZtCrKIZbwdoHbQb6hqQiuifmRm7hv2gECSi/ze58kaIem?=
 =?iso-8859-1?Q?5EvdIthUyyhwGipa1CKUToZi1OAqiRPrEF2pqY3usc4Lf7SBdbt2ZqCIZ1?=
 =?iso-8859-1?Q?UCz+pHDovR14M+KFIvALOcJrPduzUKQEYwnYBtxB+8ntshF5qtbVbzgy+O?=
 =?iso-8859-1?Q?hFbkXAYN2uPhMwLixPV4Qb5BX70SlPPXjvXhK48h0mzhfI1LL2tQKIZSC4?=
 =?iso-8859-1?Q?OxTOAfgsM1OEVDrgeoFXbJBRbVsdLSrGiATEzl/+ZbAzptHNrr1h8ovYNA?=
 =?iso-8859-1?Q?Oj82wpqPjSz696rYt5VTe0EyjavFY7vEY9V6dCFn23qGgbtAt7oELFfNxi?=
 =?iso-8859-1?Q?EwmSvmQPCzsDE9gonkWwg55RmgEno1P/2I4TMAJbdXl8zjT6q/IwIodLtJ?=
 =?iso-8859-1?Q?QJZNQzz62z4y+RFg8k8txnYEaSR7vVMyvOFXidDcO9OWO5rbI24Yv/9gks?=
 =?iso-8859-1?Q?mToyhoW3y8UeUW/Qm8OibrfCKJyy9wGKKB3dAhIldZQ1s2WUOGsf+TwMaU?=
 =?iso-8859-1?Q?qfkbARklixiiZOzc59pbr4FT3lDaiROJouWsVTErRx5qdWkzesDkopt0Yu?=
 =?iso-8859-1?Q?xix+k3ZY+N4fICHBQ2YTFyLlGJaFYFtEyYqhCQny1ozA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gMbQMI3tq/k1QLG49D+KJJW4oV1qQ3EO0ZcCq6Uq7fXAai6wo0opoQtqTn?=
 =?iso-8859-1?Q?f5AXZjBeibZ4Oufafmfw6TZaXU86ot9+vd30TaaYd/k62P0bDk85WbdBLX?=
 =?iso-8859-1?Q?t/wBeZkvCgPjWwRTV+d6hPzbF2fSY2EwGby/IfQ2cd3WGKao9+t8YTnDfE?=
 =?iso-8859-1?Q?Hf0AtEHVnLaRMNsY1P3pKS6X9pLQEJg8GFmNAsOKgYFs2fPkczG3WU1fCW?=
 =?iso-8859-1?Q?9TD6x2Ejk7GmIhR7PYAsy3Bwi0zCt0qb4MGDa3Z8uCz0cHihxYpSmpqxwt?=
 =?iso-8859-1?Q?cS2e75EIg4NbVS5PxQh12XC1EvvEifjWX/0sONW4Ls/BAJb9xWBlDk2BVq?=
 =?iso-8859-1?Q?jRFKtNm33TKup3KkUfCAo/Fdj+ttylSb3z6AgdRLd56tTfb+xoyHopj9ff?=
 =?iso-8859-1?Q?9+cu72L+9vL3vrcZOSGSDQFWqBwAXrNZL4cALXZTo6Mrt+L2FdyjcVTUG3?=
 =?iso-8859-1?Q?vDv/GPBMy3HkQkNRhqzq7jL8VObnnEK2I9sk66HxB08q/c0D2hZ5dRpajh?=
 =?iso-8859-1?Q?uDXT3PNXj4dbOIzUBs9c6/NY4ltLBecVLwhTm+rsuExwm6c0RX+Rn+Yndr?=
 =?iso-8859-1?Q?WcX9jd9Z1tWLpC8/y4kNZYWRFn73LT8NNR8ZcNb2ZNIRnGyOC182gqx95M?=
 =?iso-8859-1?Q?nvX8gWzAwcput1qIhYiev3chR0ovkIQ3Z+/LAH7SgQvo+iL/8VYddqgRSZ?=
 =?iso-8859-1?Q?Hcm5e3XYwIz1Zj7LurjMZAISTazLJhwaAJAGAdt6c8apzCJan57mTTX5Ae?=
 =?iso-8859-1?Q?klX1g0muZIUdn5sVUbQitEv4KDyxjVLVjd/TSp2Cu24BOiOoTy0UxzAk95?=
 =?iso-8859-1?Q?QdbSNTJBJC9nsbAGO/TBB9CWIbSw1cAK01xb3HeuQEmCmAyekuCOs3LIE+?=
 =?iso-8859-1?Q?lWMNOntM6vwDCr1NlytC+rJ7MyJdSiOWV3DTffmE3R173Pn8cwM//IkI7c?=
 =?iso-8859-1?Q?7SXIRzdSr0xdTM/vIVt2/N0vH1+m20Lr4zlaPtuXt6zuBzQ0A0UMlcdHnl?=
 =?iso-8859-1?Q?n8WlPWmMd6qt75p63yMlVJ6wboKZi1exqv6vbDw64VsUYrQH1ddtvlOzUv?=
 =?iso-8859-1?Q?uly1L0FaoYqYoN/bMWa/fPHJHe971mYS7OPsoCBQ8tjvsZKGktB30faJnL?=
 =?iso-8859-1?Q?gVuZ0T5iFLTl6Th3Y19nfC38IL+ZFYPhHLFAbps4uylLS6Kc2lqx5iNTwn?=
 =?iso-8859-1?Q?TRz5Z5t+8oe+mhKDTbfaofqMRUm33bDixsYV3A3bSJ7LyhVpXbOFgMWVMA?=
 =?iso-8859-1?Q?K8l5JhL68KMkCK4y8pf4yFJNNXeP3eNx2MyqfCI9Jp41PM7FxZfRV1v0lA?=
 =?iso-8859-1?Q?EiZQDxgL89qsirR15kMffnIYoAfyqz7Z5iTgZLowYQrJWinosbAqKJo0In?=
 =?iso-8859-1?Q?ccvdO6lBz5TlkXtIWLRNVh/t31OSR6n/pmArOpByfIjOzfdk17jBp5FSqO?=
 =?iso-8859-1?Q?muSS9yh2qAleD2f0658DMXHYwqX0v4Rl/rOfgrZxRJMX3StXdo1zoTWSzU?=
 =?iso-8859-1?Q?We52HV0fQFKSffXBpsdvee0fTs+hnDCEy5qZfPFDqTtyXid+A1Yl5I7Oxy?=
 =?iso-8859-1?Q?eUbTeP8ohMD6PXH2h7kmSHh/f7dpsV+6uPQSjvdA6rozbjpIbAbFUvi5Ob?=
 =?iso-8859-1?Q?E5Bd0vjBygfGCzH7kIMZu0icPNb4+4fZx7THpshwa6DgzBU22ElQ132l0a?=
 =?iso-8859-1?Q?oSMZ4yVTYtUkexrYgNk=3D?=
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
	JD+z71TsmdVKwX2PT66sf6u37SzetRj6dfxEzQ9VKu0Jrx2ifAwYxaBHa3QWi9qIs6ROwOSUdz1kH1fcsgysTrCjbXiU7fEu+amzJvTxGYlfgSSWokH6WH8kjDxLF6vSkVRuJEef1qr/8xyjkVFKx6VNY333bj842zU4jQ5Rt66JDjF4o+Hu78nf+ux3BTy3vPh10EfrFTsRLsQthOv1z4Kg2WsXfjtfhBnWJC9XXK242WaHlH1h/QH4ucxGVFAkSB9rz81Odv9oO4z88fk4AV5+PT0BFSEQVJnnh5fQpDvGcgC3WDAW+Gpvu/XRTTtCh2rO623OtoqvtHw4OxTgAiNGEokd0PSz+dRXvGvwz7+LWQ7ZQ683bU/Q+7sssaBXMAMCnKrMMrnEIMW6Wg+DHoKaCA8sIlDLZUJ5ZJoGv16376AdJo6Sni6alRBylWmrKWQhjxrjcVVyOVmCM/K8wdVfndjLmWhQ9+Oe518Cef5L7QykqTM1AiEnpwqSasAmo4c5tDa/MJw878r4aTlhZcWc16mJI5KdMFsyHDoNs2DOmuwGoJ+ELGH2bu2tjUmlenHWTss0py2V3X38NBg5nvQXjYIOmqExVVCHrZFkCxE63MMYRYuYWIX8LefsyGYx
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f0ec08-e523-41f3-9963-08ddd0d1d2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 08:02:56.1831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Q/9QFdcpmIqplVAuGLMPWvbYXXlFnMrGzOOiJ5ys2GkOmWSK4BCC1Wtuzwrs01Nx0/hHCA60V+jAASNi4CWzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8324
X-Proofpoint-GUID: KF7g1kzAzcWhFXZEXl7T6MuLTXejjRWF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA1NyBTYWx0ZWRfXyltGOsAQOjzl Ab3O1Q7/05+amKCRuQ1c3LmoxlOMdPjAV/hi4oMM+hp6nHnk7WJDkIg9hOaox0ygv3afANxdcPR izTZ1Egq5OyJOMFwk05HAjds7DnMxZtOVweHs5Eu4XKHPqLJpUfZrRPQYLraJ6UUFSdQ6EsEsPi
 NdyMm8s/z9YV0dNqFFL3iDAo+kSvHAp7HC3lBD7rv6xO39vB6wZlnsMiqHHa/uGAJmhVWGfnMYC QPu7+kmCchVrxRaR+BVnBm1HNhns9hDK42ue2ql8sYK2ED+HFaQCFs+4EQ++Bc5p7K/TXSoxqpL FucBKMEM/7UOBq2yS+OoKKEnq6Wf4PHToY2kCQtgy4h2uLjJPsoTSN7Fg5IoYIUVeg5QdLU4Av8
 fv6IJN3zRAXBxsJgOKCG/A648Fy+hPzkjdoyjYC2OnRYlIviZytUVKbVj6NvnpI/sgCinmh5
X-Authority-Analysis: v=2.4 cv=E5nNpbdl c=1 sm=1 tr=0 ts=688c74bc cx=c_pps a=9bbn+oZdIvoMJo80hN3jsg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=o0FRpcE3wDFnCtIvT6MA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: KF7g1kzAzcWhFXZEXl7T6MuLTXejjRWF
X-Sony-Outbound-GUID: KF7g1kzAzcWhFXZEXl7T6MuLTXejjRWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_02,2025-07-31_03,2025-03-28_01

> Loading the allocation bitmap is very slow if user set the small cluster=
=0A=
> size on large partition.=0A=
> =0A=
> For optimizing it, This patch uses sb_breadahead() read the allocation=0A=
> bitmap. It will improve the mount time.=0A=
> =0A=
> The following is the result of about 4TB partition(2KB cluster size)=0A=
> on my target.=0A=
> =0A=
> without patch:=0A=
> real 0m41.746s=0A=
> user 0m0.011s=0A=
> sys 0m0.000s=0A=
> =0A=
> with patch:=0A=
> real 0m2.525s=0A=
> user 0m0.008s=0A=
> sys 0m0.008s=0A=
> =0A=
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>=0A=
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>=0A=
> ---=0A=
>  fs/exfat/balloc.c   | 12 +++++++++++-=0A=
>  fs/exfat/dir.c      |  1 -=0A=
>  fs/exfat/exfat_fs.h |  1 +=0A=
>  3 files changed, 12 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c=0A=
> index cc01556c9d9b..c40b73701941 100644=0A=
> --- a/fs/exfat/balloc.c=0A=
> +++ b/fs/exfat/balloc.c=0A=
> @@ -30,9 +30,11 @@ static int exfat_allocate_bitmap(struct super_block *s=
b,=0A=
>                 struct exfat_dentry *ep)=0A=
>  {=0A=
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> +       struct blk_plug plug;=0A=
>         long long map_size;=0A=
> -       unsigned int i, need_map_size;=0A=
> +       unsigned int i, j, need_map_size;=0A=
>         sector_t sector;=0A=
> +       unsigned int max_ra_count =3D EXFAT_MAX_RA_SIZE >> sb->s_blocksiz=
e_bits;=0A=
> =0A=
>         sbi->map_clu =3D le32_to_cpu(ep->dentry.bitmap.start_clu);=0A=
>         map_size =3D le64_to_cpu(ep->dentry.bitmap.size);=0A=
> @@ -57,6 +59,14 @@ static int exfat_allocate_bitmap(struct super_block *s=
b,=0A=
> =0A=
>         sector =3D exfat_cluster_to_sector(sbi, sbi->map_clu);=0A=
>         for (i =3D 0; i < sbi->map_sectors; i++) {=0A=
> +               /* Trigger the next readahead in advance. */=0A=
> +               if (0 =3D=3D (i % max_ra_count)) {=0A=
> +                       blk_start_plug(&plug);=0A=
> +                       for (j =3D i; j < min(max_ra_count, sbi->map_sect=
ors - i) + i; j++)=0A=
> +                               sb_breadahead(sb, sector + j);=0A=
> +                       blk_finish_plug(&plug);=0A=
> +               }=0A=
> +=0A=
>                 sbi->vol_amap[i] =3D sb_bread(sb, sector + i);=0A=
>                 if (!sbi->vol_amap[i]) {=0A=
>                         /* release all buffers and free vol_amap */=0A=
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c=0A=
> index ee060e26f51d..e7a8550c0346 100644=0A=
> --- a/fs/exfat/dir.c=0A=
> +++ b/fs/exfat/dir.c=0A=
> @@ -616,7 +616,6 @@ static int exfat_find_location(struct super_block *sb=
, struct exfat_chain *p_dir=0A=
>         return 0;=0A=
>  }=0A=
> =0A=
> -#define EXFAT_MAX_RA_SIZE     (128*1024)=0A=
>  static int exfat_dir_readahead(struct super_block *sb, sector_t sec)=0A=
>  {=0A=
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);=0A=
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h=0A=
> index f8ead4d47ef0..d1792d5c9eed 100644=0A=
> --- a/fs/exfat/exfat_fs.h=0A=
> +++ b/fs/exfat/exfat_fs.h=0A=
> @@ -13,6 +13,7 @@=0A=
>  #include <uapi/linux/exfat.h>=0A=
> =0A=
>  #define EXFAT_ROOT_INO         1=0A=
> +#define EXFAT_MAX_RA_SIZE     (128*1024)=0A=
=0A=
Why is the max readahead size 128KiB?=0A=
If the limit is changed to max_sectors_kb, so that a read request reads as =
much=0A=
data as possible, will the performance be better?=0A=

