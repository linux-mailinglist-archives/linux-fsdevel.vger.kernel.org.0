Return-Path: <linux-fsdevel+bounces-20220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40D8CFE95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720C32826F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0513BC3E;
	Mon, 27 May 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="hvfADwP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4113B5B9;
	Mon, 27 May 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807992; cv=fail; b=Jk+G0jhoLJgf7B1l7IIKXBLAXtQuVQi5c4rqArHw87YEce/tLq4cmxqfKnVs/d/91jVMw/Mv+zcTBthpimAjw6XCZDowNtTX+rYVYkBrGxBw2Ny6Tsn1vyXn0O2QV0zOask2Uj9HxeqwpqrV9UsEmi1dD/j8miYjjJnTjqnbBSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807992; c=relaxed/simple;
	bh=2NvcDxZPbNLlp1xt/bbOhn3KsYeab/bF+Z7g3QIvqYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=M6zqqfXiP05/KDHhuhAd61Jby7noCxwrX0H+3K0wBqykH1JXoG7yR51uuwxsSls2xSYacO31tWlensQAZEYdHFqclLuxXQSRwv6WBc4r8uzro4j4e4T77kz2WiZt7QFjN+waCewAngzND21SX4PNOv0wSTOJ0plRVpcQkzYR0zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=hvfADwP4; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAOAkS016951;
	Mon, 27 May 2024 11:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding; s=S1; bh=2
	NvcDxZPbNLlp1xt/bbOhn3KsYeab/bF+Z7g3QIvqYA=; b=hvfADwP4C/l3lW9FC
	SG4N52Wmlu9a+FTJBxfIabyGv1Pi5PTrUtjlDCm8wGpl4/9/vl2MEyaJJWKVMd6B
	ZCsEhDggG4hjvmtwvknW1axj3/ltFcpX/EruIPLhmObYH5wW2uNowku8UULKRCTn
	8XZnQsvSOeb+FQW1Hkyk5GzbbiPnkcU45/h5Eiz32mjNkMSWZ1w6d2aJHfjVeHSs
	gjzwnkMfKQCgP/kmmWoWN6c6yBLD87Z/pN1gotvd5k/t3HxJH4aRjjYX9lfe9OA7
	ykiReAv3s7h41F2UU67Szav3NeBUx1xTrcMDWDsipxYc5z1I40NwvR93hizdeDrL
	CaAnA==
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2169.outbound.protection.outlook.com [104.47.23.169])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yb95gsq0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 11:06:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9kaOikVBsnwzCShpVOZ/aSfLPtHJvxn+E9Eq1WlWs8Z758znR0yroWMG8xBrspC0PK5xz/d+UwQS+WG85eJwD/x5Z2ajlmpXFd5Ca/feP/GwLCCBuecBWmjgIh7lPl31P6hsMi1NleXHmVsO1kJ3EzE2au+Lq3JMHNhDq1Z9alsax0s75NzHelvPhUD5SQ+yBqIm0uKePWY/4ew8OAA4KZLIyBg+1zQCWjj78oXjEEySqodFwLbBjBbR8YdiZ9CrofCvDrdqJQqlBOVlarnM7OM5EVJym02slRRlXL3lzA3aMhERRQgcjw0uYmyTM6Iy2vvEkhKuFH9hUSjQ3rDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NvcDxZPbNLlp1xt/bbOhn3KsYeab/bF+Z7g3QIvqYA=;
 b=nougue/je7GnON+KJd3+4gcdP0Aqa7hrAkuiEoUsBLbw2kXBBv3j+zJijNpg1KmJgp6ao8qHt//e34UdiExAEvnj/irZYQFpWyunYzwOtoRnJsjjzId+eYgN8oOJRgEIkDQITvzyOkDyqSbzZ/BouoaUvEY+Tto8J+7yebX2nV2Es3MgCY+X5Vx/jk569q/A7LrsJZ6V50flON0viyisn4GShuCYeqziR+SmX6W9y5U3O2kr6Wbd951I/t8mTSTa6uDaDpbI6rUiWHldp2HPQ7r25aFy4GYDFSeNbHzQGCvuvY8oLzhWdpk8D/LTLQXCGJud4WCo71SGtfTh+SSqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com (2603:1096:404:c9::14)
 by OSZPR01MB6971.jpnprd01.prod.outlook.com (2603:1096:604:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 11:06:11 +0000
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1]) by TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 11:06:11 +0000
From: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
To: Pavel Machek <pavel@ucw.cz>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner
	<brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Thread-Topic: [PATCH 0/2] Improve dmesg output for swapfile+hibernation
Thread-Index: AQHarBuqqIQ7Mttzp0e7Oah3njC7eLGlO2CAgAW3O9A=
Date: Mon, 27 May 2024 11:06:11 +0000
Message-ID: 
 <TYAPR01MB4048D805BA4F8DEC1A12374DF6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <Zk+c532nfSCcjx+u@duo.ucw.cz>
In-Reply-To: <Zk+c532nfSCcjx+u@duo.ucw.cz>
Accept-Language: en-US, ja-JP, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4048:EE_|OSZPR01MB6971:EE_
x-ms-office365-filtering-correlation-id: a48dfd77-1dab-4e5d-da9c-08dc7e3d0470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?0qhFqjLpIpYkQbvrdybVYbedi+gvzP0pjDCFL6wWCU/VquiwSdb7VrNap8tY?=
 =?us-ascii?Q?GzgKmVZzLhY0sRODB913fDfzynxTmzIP9M9kkkDBTLrzxwS2zHFFmgeCzPo+?=
 =?us-ascii?Q?poVG5YD6HX5V+rqCPjc9MjGImYX10GuP7r+2uDiFIO/xSWLaBa9k2FQU26Rx?=
 =?us-ascii?Q?bGCwllulkFP/WIjNRv/vcw72JziTUm4/U48Li2Wac/fU7KPqgh6hJ90TKabW?=
 =?us-ascii?Q?CfHKv6DRWi0uSwENf0SYUbpX6yts3UVzDpDhVeUfU1JVGpE/oB/vUdBkOEMz?=
 =?us-ascii?Q?miUehNnUCcEPvJUlZZBPeAya4RRUYda1aKnALmOuVUeZ9ewqKShXzlznH0eD?=
 =?us-ascii?Q?lqx7dJyJH33RhzHKuO/ZWIX4F1Y9Y3XsXwLYDi+9rLQb5h/b0aYXDE2AlJlc?=
 =?us-ascii?Q?uRuXcviygpw+DW9oDOTRRhR/BlAhd4Px0l98g7jFrLW6IAM4LhGkdE8/TqL+?=
 =?us-ascii?Q?fUCsyWCnKNM1MB3u1DqTVj5C/dLmohbkM5xNAibHMYyzijf6OCALe3zWYdfW?=
 =?us-ascii?Q?6k6R6tifxehM0CQL81e4dGrwXDpidNVlewacBeatDxdBC9xIijaTrluLi67i?=
 =?us-ascii?Q?RsS6lH1ZLmWEqPxVumQ2RlSOYX+ojuLFPAbhedbcC/aEZczPLzf/l7eqISz7?=
 =?us-ascii?Q?Z7eo8pqUUwqx7SjF/inF+/77JVhoUM9+b+4bUPy2yaPrxv+VJZNFBEbaD2A9?=
 =?us-ascii?Q?evv2T6BsTbDsv7IffmCs+qMCcizEX4Xe5bQdBonU8bX8NXs+gyAKXKJWeYPT?=
 =?us-ascii?Q?NIsm4vw1TDyba9cWZWU8NKDfphmZ1ZL50CTsujChtlsOe0Sdczevmahg8x4/?=
 =?us-ascii?Q?mgCk3zP7VNBjpygOxCohi0WBOTXwUUXF+OE1ZEsa/AeZnEMf3qRZiP3GnBsg?=
 =?us-ascii?Q?KhBpL3y6kz0NbvMRTK3JVx6p2N6VOlFMjKC8sqcbiEt03H5Wr7Azkk1nUIO9?=
 =?us-ascii?Q?tzJ8ybUJzWsbW7RGW8hxDjZC4e6oeI6qCFNCI3F+LmLDUrY0cbtr3f/yGPQO?=
 =?us-ascii?Q?wbMlfbJMCC3rmoVl73weVfAP1cgxrrkb06JH67TJ/eEo8Pea8zR2a+s1M9/9?=
 =?us-ascii?Q?eJHnZdofqfZ+qkbCWoJSIU2DAOLF2A8brkLTGNZ+y7uzn5xcx80k/bkQVbP8?=
 =?us-ascii?Q?xWd28U2hPeHE6T/EcNf44jPV+M25kfjgdZIjW147l28t4Ne2nQu7wAufdNkm?=
 =?us-ascii?Q?BlF1N2JBsPRo009/tRDA6ppNzX0eCTGnnlVraGTd1IK/WDWrVsImqZJwfLGy?=
 =?us-ascii?Q?CZlcYj31mmtIecRqssJEu+3McaxOAh+Id6IQPsaw6HGZ2F5XQXwhoV/Ukroa?=
 =?us-ascii?Q?tSCI3ZfA02gX+Kfh+4rVDSr62VgAabAbQDy2SypBeW2Fmw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?fdx6G9y2aFBp4ZGwDvesiTIl/Vx3Vp66+WwCdnDvKvFCPiorFOzLaRvp38gG?=
 =?us-ascii?Q?lXu0HyXEM5HkjpImjfBnQTfP3LizzT6j2w870tmVrOFO/RuVc9Nxptimb5cC?=
 =?us-ascii?Q?ltRhKVTYXTTgr4ign9LTtSRVIw4FmkF1cN5ANPD5b66y8N8KKDZnayxvNIey?=
 =?us-ascii?Q?mvfFaPO4jKxUDFbrR+/50oGvaRpS3N+DoktkIsojOVPiYSXTYybdCbOLxNFc?=
 =?us-ascii?Q?HIdMjT7pZBC07rYfrxAiL3HXhflhS1qI7D808boPgJALwHqyMft9Erh72vVn?=
 =?us-ascii?Q?hSLcI/yeb2OWEYWtYxNBPjGLcpqKcsgPCMNGu2Spaa1McRdtZTArFim4IBiA?=
 =?us-ascii?Q?XBYVOpylh+s1hjTG2/m26p/4xUSP28DTAhmUOfwybVRHPuml+HNBqHyXQRcI?=
 =?us-ascii?Q?0WczBgAflQNo/JaC2uHTRRkJmO9yZfOlDewRveBNV2vvLPB8mDD4WmgG4DD2?=
 =?us-ascii?Q?9bCyPB58ojsVgiUwrv84oKHnQw9b6/cWoYRT35ybNyjIjF+5qd2GDvnOySJI?=
 =?us-ascii?Q?lYud4A85ibsHhG/oPCYpWHT7itWiuMw5syb59iRmdozONfAruMCYMtQuwWIb?=
 =?us-ascii?Q?enJwDRoCqph0SEBzHCbgNdLpw7kk1QzvE/M2PTRfp5fZXl0lHGyuDDm0XTo4?=
 =?us-ascii?Q?LA7EgE7DYsUXSu0FZaF6tLvC27rQiIRF4JGtUl4LCBIjWCSfjVysziUiW8P3?=
 =?us-ascii?Q?T/lDAOz8XrGoefAVYVGFl6TebQdvqihvnZ0HJc1VUCN5wUgrWEhZIeZ3jp7p?=
 =?us-ascii?Q?68YiJ79jYWru/BwU8e4OZdXcYaYfn/pRhKXpJjn0Sz+zOSPIdBcyVEq+S2v4?=
 =?us-ascii?Q?ESq88zGzZoH5t9Gi4p5UdXOM9pwih6pX2j7rNS9g4apQp97Y1JDNBLgt9G2o?=
 =?us-ascii?Q?zMZQT5Fqp4ormhiSjDMGN1h1reaqiB5mph8Lb2yeq0flc5cDCk3cjVUyy4Tb?=
 =?us-ascii?Q?0aKkePLhlIVZ9ATxsSLfEXcEsFY8/1V8s6ub3WC3wST9PxWyFy5eZ7ajufa9?=
 =?us-ascii?Q?SVoGR0X7wQmtn+5CsyY6hxAuG8NKZvcZmLrb9MOBzdXgnuud1Ft/cPP/xh4B?=
 =?us-ascii?Q?fcnghHSBjjYX14pfZVdIsLbhclHD837D96Kdoqe8oIc3kKAhg33tyHUG8MPM?=
 =?us-ascii?Q?p/DylfUd0NI4xmG7gn8zJFFGXkVtJ2zrxqxFNXZjPzL/wnzf0NEVquWvbo3y?=
 =?us-ascii?Q?3KekATyUHWUtyPcf+kbKZyo3ELDzjeguzkyj3VCbvbw8uvIGXhLZy8/wyrL+?=
 =?us-ascii?Q?zb6A4UzQmngO1THQ/+V7KLNfGhKDYBPx+05ykUP69Dllp48byvj3h8R4P9GV?=
 =?us-ascii?Q?mLD0O/dr9LQ2MAzWgGCG5kdmWd9qnWVz9BwzAMzdKcugB9iZj/c7OBicRXqe?=
 =?us-ascii?Q?742E+zjiLOb84QXT0Rqi0ab4BrFo6MmZdkhVD3CMJXi4xqlSPSLoyKZaDUgv?=
 =?us-ascii?Q?6i2HQnBXJuCV1jx8Xs38oOVXM42UPKXMcc25BpAc5IP3L33B02U5tgVeqQxY?=
 =?us-ascii?Q?E8lOhZBmNxBSujwYTdmAInVBqfUN27knJz5QCRJg6OtNRrYF2x8wzafl5Yx9?=
 =?us-ascii?Q?HlOCOmC4GxgSvbRCvPx2k6Sj1VcLNK8k+1WEBvq1?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D7n39ht1WNHaS+G4aaVA+pt8R3IE3dNpsDHPYgcYcTViV/ms2EKwHgZYuPcure65Ohrhj4i5yY0jBHmL05yswXK+SIxHJBoIWxm/nvHejVHUMchFHDCdMTUXZZpuQgQQ16K2Iv478c5LI2+C0ZAdjAv5bYbky934nVROyA97AxU7wT0J+LUltOLsHMMVOG0lcywX4qRAIgTbdSS3APS6KaojWFDnqJ0nbkFgEYooqnHrp8x3doqvgPbzemxRruH78Eb6kDdiwMZfHQYdPUpWVVTECk/e8wz5pEsykM62j2yqIgUEQfojXt7OnshBCGfnPJBxFNDvMsFqPTb8G9APQG5ATgaXFGk3Fiif8l5b+wm0t1scmot3ZrINsj9lbnlwXFnldbINriAoys8jQ+uMz2JrB4J8PlthPfnhm80zsYA5HlsQcuGv8e5N69kICgwEezB4WjsibTTlwvMkaDvlnvHWWdiaxbrndDwBEytT0RPsD/bYwtyKoMlc6stlIkLgS1jrhhKqBQv9NzIFkxT2JL+8q6sJOPT3Nicdu4Yu4dUMcOeDpRUC4rF8Gal5L2FqSC6/iy5qkILrRd4J3CzHPjHE1gR2OFmPZI4vtIs7OgPvwGWZOXh4AjfgUh6cp7VF
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48dfd77-1dab-4e5d-da9c-08dc7e3d0470
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 11:06:11.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZF+nnuh9wPxTocsKtoaSWrF3D1xmvFKDjiR3+t0Gh6+ydAUny7W4Uo4NghQEwug05CBSs1MXmBjj0i0pEWike0B+FgC7N7jobo6sfqr6XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6971
X-Proofpoint-ORIG-GUID: 0eGumd5mIWifSoqH5gVp6QHYmSzu06wS
X-Proofpoint-GUID: 0eGumd5mIWifSoqH5gVp6QHYmSzu06wS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: 0eGumd5mIWifSoqH5gVp6QHYmSzu06wS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_01,2024-05-24_01,2024-05-17_01

Hi Pavel!

On 2024-05-24 04:45, Pavel Machek wrote:
> Hi!
>=20
>> While trying to use a swapfile for hibernation, I noticed that the suspe=
nd
>> process was failing when it tried to search for the swap to use for snap=
shot.
>> I had created the swapfile on ext4 and got the starting physical block o=
ffset
>> using the filefrag command.
>=20
> How is swapfile for hibernation supposed to work? I'm afraid that
> can't work, and we should just not allow hibernation if there's
> anything else than just one swap partition.

I am not sure what you mean.

We can pass the starting physical block offset of a swapfile into
/sys/power/resume_offset, and hibernate can directly read/write
into it using the swap extents information created by iomap during
swapon. On resume, the kernel would read this offset value from
the commandline parameters, and then access the swapfile.

I find having a swapfile option for hibernate useful, in the scenarios
where it is hard to modify the partitioning scheme, or to have a
dedicated swap partition.

Are there any plans to remove swapfile support from hibernation?

--
Sukrit

