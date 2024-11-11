Return-Path: <linux-fsdevel+bounces-34185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD09C3829
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E681B216CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 06:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA7149DF4;
	Mon, 11 Nov 2024 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="IgyDUjNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805122914
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305103; cv=fail; b=bjQ+2OcrLws2Zsmp8fZa8cwUMNjh7FRI/NaZyqr7Kkj8/oimwq0E2WJF7a5ZGNLYy/vmSADGolKHEFHnklw+vrB3N14Fd0Cs/oKs7+I+C6u3qlbJlFfufdsAYj6okvFUJP4S/16fm1YgMZyypdeFDJoWCGfJF9MlY0zIqHYTFV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305103; c=relaxed/simple;
	bh=MoL15AyMe02k9ximeRRjEr81g8TtcFz8HRp57dcFERY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GeQsRKco0OvUGhKTpjBgcQG6K2ZgXplhQ7eeAc0AHkuf99YwEDirSzxEibz2O8TTVFk6ue8FDiJuV75e1c+SAsC3zpIQ6GM/9Dl5NF72epXoXza7jzixYAEo4QqB3E9ApCVdLdDPm6pZIgGeAeSKJtwpPK/THAD0qj/bqH8bzw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=IgyDUjNL; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB4PeTx017363;
	Mon, 11 Nov 2024 06:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=dongEbf
	6M3vbIHOFnbJ4WbZqVUr/UJ7cbej4e5dL5z8=; b=IgyDUjNLH86HlyculNL8771
	klz03QdB8rZbDszugVfSAzKrczLUEx6o/VqUAPvLGgZY/Bb35p9zsbggOxLegAJe
	oWczELMymP7NEzxJMUEXT28WmkCYWlwSXUWE1NuAsIO9UAglXpZxWQb3RUhMymtK
	vFplIB7prkatIAifEhtQTwPzpmU3F29pK3fJt0Sy+xgUQhpdHBgVUq4pZ1DnVJBe
	Hy/V+eSn3ZNOzHl/WRCxQJe3eRGBuSmFGrkGz+cEdpRf2Q/v45YGgvluc/I7hkAb
	J3P8Tq1a7CHXp+GlIal/YcEVkVzOZdnr4bfd9nhavgetKh43Xp/Rns8+dsWIhGA=
	=
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2107.outbound.protection.outlook.com [104.47.26.107])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 42t0gu974g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 06:04:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTBgYbo5YNElWvzQ0fvZH4Nbt7D3xCsctwnjAqwptutLvJmYaPB4qOF04TTfOm+8j5Di0pmv679EUYe4SK8UHHV5Dl/NdKuyGcNxvHINSUGT80gdge7F85IE+w163eEsIEYmR5dZc2f/jAp0HOTDocDBAxxuhrCSvU2b8La9oh2L5Ix8wh1h8f/KfqfmSUCgTxPKyj4djYz67UZrGV0E1AtE763a2TOh48bMDqAWiPthxbhgFwO+SA1jrVPObgQB5W9YRqEWtLwyDDLrADAViAaNIHcHp6nwDdJm+U5dhBubDWb/dWcvdm90+cAkl1Zzj1NcjkdU/0fVdYF0QrZheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dongEbf6M3vbIHOFnbJ4WbZqVUr/UJ7cbej4e5dL5z8=;
 b=nEh+fnVkgJVA0DCwA9Hfa83IGnidQB0cZCAMw6+fKOTROq56tAa2MXkz5PEUlMngtg41ZpBZxCib0hKLCwgtib3TYxpP4NgoT3ZM2KPCXXE9gA9sLzbmKCNOIEaHeQ6S/1WYHi9bg2muid6W45IDzi4wA9+ausRtrL/Btf1LPTby9X8dKS28tnfQVXTgjQJ2kuuz4ZW15rIcmB3PEcwfjGl8iVQRJUTSL47lMhquAsisqo7V4jCbkouD6o7jAD5eJobCT4V1Usl5sWJn+XsCPoHiEuFdWBmTgH3eqlHZoyj0K6MpPNl1W6oQ1mHKlGOEbN4Zu9CCod8UI1TKOt9tOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PUZPR04MB6560.apcprd04.prod.outlook.com (2603:1096:301:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 06:04:28 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 06:04:28 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "cpgs@samsung.com"
	<cpgs@samsung.com>
Subject: Re: [PATCH v1 0/6] exfat: reduce FAT chain traversal
Thread-Topic: [PATCH v1 0/6] exfat: reduce FAT chain traversal
Thread-Index: Adsqi1tpQFrMRPIkTR2RKUgj0ngLWgABHjpAAdDBmQAAiwpcfA==
Date: Mon, 11 Nov 2024 06:04:28 +0000
Message-ID:
 <PUZPR04MB631636C18A3CA14BAF366A1C81582@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <CGME20241030061222epcas1p27c3d41fae0ee2e8db3a5fa56fcadecb2@epcas1p2.samsung.com>
	<PUZPR04MB63164B1F3E8FFEA10105095881542@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <1891546521.01731066782150.JavaMail.epsvc@epcpadp2new>
In-Reply-To: <1891546521.01731066782150.JavaMail.epsvc@epcpadp2new>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PUZPR04MB6560:EE_
x-ms-office365-filtering-correlation-id: 727b2983-be24-41e5-d273-08dd0216b38f
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9Ka5BtSRaI+RgZd1nAatj5Ei6962wy/MD61a8Hn7T6gzrdAs+fn2hOzwfq?=
 =?iso-8859-1?Q?Y2hCgGcgHlWBZpjCX3ExK5WFd7EwuGUq7VxP1D96U+BimthJXHPOfQpw4v?=
 =?iso-8859-1?Q?HU0mtP12497iosKxKZsug0iuhm0PXSjzT+oTKlygo/PmJ2pot4SkJ0qPpJ?=
 =?iso-8859-1?Q?JvBXyBj9RynoUIBRW78gBFTHmmGTl/NovAnmuNcQ1VkI+cJWGvXSJLat0B?=
 =?iso-8859-1?Q?tIrwbqOfu7EOgiQIDfHgwAeLnmvKMsimkXDYFpxux8lIdHBqIxiokqa+cZ?=
 =?iso-8859-1?Q?fJR1kF2k3gJpZH47GmjlKMgTr5YUVb6yk4LfJdvweiER0F+exF6kU79ozs?=
 =?iso-8859-1?Q?RUvj4hrlI86taYDRlD3ilh7of3ILliWfpXi3w10V/rI0xVrjd1qwpMl0E0?=
 =?iso-8859-1?Q?BIrfL9e75MQUnqkE94Vw0VNcZ80ddmLEJyQ9kpqGfHF+DbBlXNRBqhChoR?=
 =?iso-8859-1?Q?0vxiI7Ob71XR9O0n3D50hutDxH3GP0O8mh2qbQzYxwXKIDZTIMSLk3JWRn?=
 =?iso-8859-1?Q?v/emP4gFQwA6MNf7Axh6J0hIBypYRsOnS+dUxfl4Kprlvb5sS084g2dMSH?=
 =?iso-8859-1?Q?rcQ881lhSU6MDpnr9K3/1NIvLZKVWDtRDFs1Qq4T+QLOoRrsrsApg6kGFC?=
 =?iso-8859-1?Q?9lhY1oGt+tk8Mlz0DHaNNGa6riKMBpFGySVBPqy9d3AiDgtzfFoySS6i10?=
 =?iso-8859-1?Q?b8bncDH+fn/ev2kJ/0r/fMpqEmaqmqlrplu0fuEoPkaqfNx6R7C9C3XHGy?=
 =?iso-8859-1?Q?RzErFPBH64gkRIlGbaU5N5M9UAI+Y1YwJSRPQfZUnPaTKl1oTa/kltfdS7?=
 =?iso-8859-1?Q?Oc5t/BWinqG/6wjdGWbeuShZUBAf2H3h5DORAQMmz275z2OlCA3iwbGWGj?=
 =?iso-8859-1?Q?icv37S0xU5+ayFr3SSmUHCIp9GHZL2Z/7CaozIb3B1MN5bRk00NVn5naKg?=
 =?iso-8859-1?Q?EwiIS1yJ9wHxADilacPHtl5LXQ+kfGsMUiMCXctloDvICztRJPs3BV3/Ya?=
 =?iso-8859-1?Q?ID3VXpJSQ0ctCjP2ujYvSYic9wtSPPwkh15ooYRZEqwdfslYNQFUlFuvld?=
 =?iso-8859-1?Q?uGwEAclH3F5IV0gHgJqdSKfqeKLdW9ycZPqsU0m5ktD/0vssGnHVzFr4a5?=
 =?iso-8859-1?Q?eGH7l0tFQlI955zCMEl9b2p2uqR8t98P0hSMdACoBq9cls04V5+mrUFDs9?=
 =?iso-8859-1?Q?/ANcxPf7wEP9axq2lHcrOsN6u7xTQbt/7lXbwN4JEREHJdg2xsX+0UWbvp?=
 =?iso-8859-1?Q?YXKebrCaMHmRU1QdMtQeTqufQBUsc6TxMzlXsu85o7Fm4aE11WtkV1KnP3?=
 =?iso-8859-1?Q?RZxHn7PsztLNie42iracs44U9rVHcV+rftR+BOBNWu/kNaheVZUSLQXycK?=
 =?iso-8859-1?Q?xsAcY3jaqJistBJUy/oi9v6fAMbB1EAa7t+jAHN0dKdP+vbihLfiA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?f8LRfZSJKKURuAV8HUM78q+U78evVzA7GQqFnblHkNmoDVvtsufIzBI1gK?=
 =?iso-8859-1?Q?6TgDR1ifoj6E2cyrQduJ4gt7szGMSwGBxBxJFXMQ8n4SpN3Bidk6PcLRX2?=
 =?iso-8859-1?Q?H2MaXXbm+rhb0WakE9GqSrTPAZXijuo1hC30UxOCIhmPRbLwKLCLFd0H/k?=
 =?iso-8859-1?Q?h6hEghyOyCTsYqn9cnIrMzsbvLTqTsBDIq5uPngLS20/nYGOHmXlYIRNg4?=
 =?iso-8859-1?Q?H/h2HAxHKHNyg9iB47IWTM2I+tKwp71I15foKCRxUczWTnfsZ6mwjQw3Ix?=
 =?iso-8859-1?Q?zCAHXbyQeeYh4ZSzisrp660kTJ66QWMrSWEUfs+eRHdWR0KCUbEJKXB+bk?=
 =?iso-8859-1?Q?DoFL2Yq/L1015B7dlkSHghMdqigF7MlkPbbLMckC0zqq1I7g2uk3cNRe16?=
 =?iso-8859-1?Q?L1xsJE8eo2D0aG/ZSucOJv7VrLp2Glenj3x+EhRVM12i4XD4KSXrfYrhAv?=
 =?iso-8859-1?Q?89vbiE5HtqMCJhgqWhVj/3XxEzVF2NQqRLz4u/dO9SdasBepymi7Uudz6W?=
 =?iso-8859-1?Q?K7tI48STIbfFd429mYC4y7vMmRmKjATHjZoXFJ3p/F38+kDYJj3hAdy10f?=
 =?iso-8859-1?Q?Uc7dRj+aISpFepOtn5etbtagrOVN4cwAcwHCcTAQmlr6HmFQ+kB5ML9NGI?=
 =?iso-8859-1?Q?XsuLvVzs63OOhTl8wr3Eq4Chv9z4+oaN8Ju4EaXHDWNFAOOe6igwRkhjji?=
 =?iso-8859-1?Q?sJVPTIGI4oonK8FVpQTyYX6E3dCbJic87Kd133Fda8jwc9XZzGWXh4VRuN?=
 =?iso-8859-1?Q?Mr34KBTROTdrbBxSw77/pZ1lhlUvklwEC07pSSeIzzeiXSiuaJ871S3r/V?=
 =?iso-8859-1?Q?HboX0PUShex9+u3kTABOcFIz2XTg7EU6tagVfvHi57Ivbk+2ZH+jh3ddi1?=
 =?iso-8859-1?Q?6bQq+VZOHqt/kYVTek7D4Hc3wpOt/RlbobahwLJikdTlsAO/6PbuVZ4Uxi?=
 =?iso-8859-1?Q?pQxCR6ut/5idIA11Sp2pLeRimL8YSrK+j1oastXbqTcKiIP3RK4OBPSNTZ?=
 =?iso-8859-1?Q?PBwuD/6aiAf0EWP/o//yLgKLNRsVDvl5URkfH+rnkrbOyRgXNMhWbcuBtm?=
 =?iso-8859-1?Q?/ba0JcLjwK08/1KN0VIY7B971sS9dNJITQqOpq0ZEmrJZ5K52V40s9WwKV?=
 =?iso-8859-1?Q?efrkifawHcjmqn1sAXUzCAzwRdCm+fEl1BFenRNKNQ1jbBUhJVRK87GsFz?=
 =?iso-8859-1?Q?gqt8lDhvY3OjDG63MCzas393/7xl4QIN7Y2vd5Q8PJJGaAk2MTcQp0bTGa?=
 =?iso-8859-1?Q?PYWORg1+iUzHB1okQ3gWipP43FDIZJ5bgV8R3BWn+ww5sfCupsXoO/Woim?=
 =?iso-8859-1?Q?CuB+BmgDGZtZnGnjBSK8TbVGBOHNX3GS1vSY88cl20XRT2hv/cvVYD5jBq?=
 =?iso-8859-1?Q?r1wfLgrD/EziL1Ow/xTQ2VPDPrT+5MLHecBWuXsijMvW9PZMAfqrHXlVlo?=
 =?iso-8859-1?Q?2+92amSUA8bK2+GdAgwL2N2tiq8hlLG/vT7Wptqpf3LqmUv1lOtk8dc2vB?=
 =?iso-8859-1?Q?56DmQrPbNsqOcwdJpRORujYWjQvE4W+RWaMqMHOCajoOhd8vK/p9es9/L7?=
 =?iso-8859-1?Q?IF8GaOBox3i1mnkBj0It2gPdsIJLEQQ+MevnAwivmjIkb4Kso1ykLGBmBl?=
 =?iso-8859-1?Q?AooFOllEzP4gF8ZKbSGQB81GpBoc+9nbwZfkhbl4xEAxOiqya9Pi0g3JbZ?=
 =?iso-8859-1?Q?asRgH7D2paSnmPt0yv8=3D?=
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
	aEcYJd7gyv4g8ZgO2LY5rv5n7TAZa2nVKb2Qmne/Raf0tZkwaWmnF9wDcKwEjKb3s+73sOJruDsKodAs4pQfOYpYkKWghtXyOQqh78Rv6ZpXadn8MtAbrkNg0qCR8BCe9fO6mNYxEyPrsRjRpQwboPoSl4Zl8E1W4nPJhvbs4DzBebU2quNJNaxRLTgX1gnVQlh/mfDx0tmBAEUSxdQoH4JFbbr9AzGNJdsUsEaoMzTSnKOCDiuKQewy+iA/sXBdiwl901+EO0QJzFD2OHwbTJFVEzRgdrck0x0CPg31LOESTv05nwu+BMQneiTqlr/CA70lp/b2cfuByMBVCtQcwKxaH5Tchev8RRM16Oki7Hx4UJpOsQdgXRmrsvLZpQ3W9PHuA+mawf7upUUGLcc8Gk4DImAW8S/y+X7hr8WvCtEUNyYJh7IDkgOwuFqGbOv7t9UOL3G1mWqF2FGNw7VZuwkf063PKGEDnsDfWe65Oft2VtCtEbp5iEcAvnAy+UUC163lu2mA4anYN1w1WuaFn+p0Esht7bvShd5yLucDbt3w+6YPGjvxk1piNF9N9OABXEeMN/JQFM3gi8ZTjNVE+5+NugR2un5pEugN4WIT7trJ/dMWrSfaR458Od2dwd9Z
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727b2983-be24-41e5-d273-08dd0216b38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 06:04:28.1123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GFvFwAZg3kZH3G6nWGt+Q4ms4boSu9d7tBpJCLh6Im0oQp2bYvdlBCHCq9cGgXGX3ODZGooPjH9oTTbRMFkdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6560
X-Proofpoint-GUID: bhvNjLu2N39p_BG2la2NDnMaMo4j-2O4
X-Proofpoint-ORIG-GUID: bhvNjLu2N39p_BG2la2NDnMaMo4j-2O4
X-Sony-Outbound-GUID: bhvNjLu2N39p_BG2la2NDnMaMo4j-2O4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_05,2024-11-08_01,2024-09-30_01

> BTW, only one thing about the patch 'reduce FAT chain traversal',=0A=
> there may be confusion as the concepts of 'dir' and 'entry' within=0A=
> 'struct exfat_dir_entry' have changed from what we previously understood.=
=0A=
>=0A=
> To clarify the changed concept, how about leaving an inline description=
=0A=
> for each of 'dir' and 'entry' in 'struct exfat_dir_entry'?=0A=
=0A=
Thanks for your comment.=0A=
I will add inline descriptions for 'dir' and 'entry'  in  'struct exfat_dir=
_entry' and=0A=
'struct exfat_inode_info'.=

