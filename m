Return-Path: <linux-fsdevel+bounces-42631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D8A45374
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 03:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437CF1896A47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D521C9E3;
	Wed, 26 Feb 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="gAM990YF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9332AE7F
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538610; cv=fail; b=KladKVoNXG2+xKApJgcDeNiavOe2G6+lIJvdAKiudKa72Fu4jEasKIor/vd8ZQt6BwudElFyTGB/eF3ymK5OzS78jSfwQQh8zJYIcmG7tpnLHsdbBBVHqv3XBcXRvkJTAyADclSJylvU0iBxsKvyYh/vs85RDj1/r3WIkj7lg+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538610; c=relaxed/simple;
	bh=ElSSDURTypmCPeAWC3B9bFSqSaA4qKs0kRDspXS4kRE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VK5LEAmR0YdBLljdlVqkQaKQyUuTWjhxgln23BWDiz4bwdK7PG5qt1KvrJ6gBFmelsAZxWF1Fu2A32ofILRkR2fR7kw4NahQErAEWHx9e6Qd+i0jE7y1kfYox4pMA232KEeeac8GuNkH/r0L4INmi5UZwjOFz6a39KS1IrSjcRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=gAM990YF; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q2OgxG006775;
	Wed, 26 Feb 2025 02:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	S1; bh=1P27riJcjTGnj5ZemvzYnBNivw4CPu4GQy8tSNws2zs=; b=gAM990YFx
	8AOWc5Avwb1k7GokQBdjPSQfZ03rq1JrGFlIQeymrWpNAHwar4M6zNsX+4GMyzHn
	8v02swBtiLlH/5uh1IQx50Zu26XhcSbzCCPK6jTjCYyHoBwKJUgLPqbYFtswCH2R
	HTAByJg7201dtDXjlT1lLJjxc24DNMth2lCizrCQtAcmsutH860omywabGNe8dCD
	x/p92zvk8BSDw6wO3M2iuCoh+4WYnalXKJJYCmRbIEPIE9zTvsiScDhVMbs9PQn8
	AS5vWlwmG3apnllk52CE3dAxJ80KptBeQUdQJMOPVqiOP2t/pqRGfBykVARsVdIB
	IrTjobX+ZRumg==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2113.outbound.protection.outlook.com [104.47.26.113])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 451psug6tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 02:56:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4A199y8eWOV0SnogcPRivO/h0+9Lrzqb+kdO1u6GWt6YwTjaxBCXS22UHRL3bBgg/XS2zbAJWwq3QEfgYNq6XgwIlMS5wgymrmwVIbylCBLveEmA2/jXmwE7gcjOhJkAkSXhZqUHASGp8Yy7oqYdIXp05GBFy6K4XBr3Wdi1EV6gyaimxKgjssEZlISsRV1nn2k9XagJAiOeNKazfg5UV1hduBR8Ij1n/D4bduL30evybl/oFJN4SRF2dvTFV5CUk4z0Lfjt1Ler5mpuGmJJiwsd2vl4+eL8FC03P527PuO1QkbMBU87lJspI6VRnbPbRbB87x66ZYOhlWZxLVAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P27riJcjTGnj5ZemvzYnBNivw4CPu4GQy8tSNws2zs=;
 b=BaDdRpomcdMRaE3hUk90zhZ0iwfUnyb8ciFZ9SzuvxxHDsY7TeScw18Sh7LHqRgwCxRs2sGGjM+YsF8ojFYW/xjSZt6Im/CUrYImY3CDanAero+UcD7TsI7Y+3tSJTsVM6AqnYh55TGj64cqLHEKjFfdyIXHqw6WkdoMS7IDxNmeSdIzjvQ35h5jRtvE1o1NzD7qnEZuInE24/1PTu8R0/1EXYKMBxU40nZ2QZiwbhw9M6fpZV+ylQ9zuIJCBB+crs83Zlmb35MQJwRRqTizUblp/KFJo0faFzJTPgawCti8AmsnV4aPc3rWhayNJuPAHm9t3fSRSDf7tMVwOSXxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB7002.apcprd04.prod.outlook.com (2603:1096:990:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 02:56:17 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 02:56:16 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix mount options cannot be modified via remount
Thread-Topic: [PATCH v1] exfat: fix mount options cannot be modified via
 remount
Thread-Index: AQHbh/khOzrAmX10nUuQn80gfW4VzQ==
Date: Wed, 26 Feb 2025 02:56:16 +0000
Message-ID:
 <PUZPR04MB6316EECFBF485365FB17D05E81C22@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB7002:EE_
x-ms-office365-filtering-correlation-id: ba1bc2f4-02f8-48d8-3e6f-08dd5611239c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vb53S3PQn5HBZ/sgzLwI+Zd9fwy1IAadMQLHJ0JqQkwpv8D/TL0K/1I23W?=
 =?iso-8859-1?Q?13F7YrHkfOoUik+6Bpica0vMUK0tdNGt6ehCzyXouNwv9KhOVGaM9wMKao?=
 =?iso-8859-1?Q?K74JLvhZ75a7ERx+m+QJBwtyJhJGRKBs3UZ2MztgET6ZYk1UStcy3t//QX?=
 =?iso-8859-1?Q?JVTKBevEAseKArvNRSoXo0GS43HFqoMRBv+88DUjjLoeMjQrvyhWNOz8Gi?=
 =?iso-8859-1?Q?SqRvLT2RxWL9IxjgazfVJiUEfl4TKSsOj5rstHVHGXuiuHOabHNEkDet7M?=
 =?iso-8859-1?Q?+X/UQpU/J18gF2RnYKUA+vACYCWjyjnuVqLHQ39jbvlMOp1NUYOkEfMIUj?=
 =?iso-8859-1?Q?Nr5RuSJoFdTNebrQ/fw+bzq19dbad6ZN5skkDqxesVuxWTRMM3ENWa4SFH?=
 =?iso-8859-1?Q?O3zpYRiH9K7QN35V5NPbakGmDjucht1E7Lwt0REmu0VtTDRS3HlvWmieXJ?=
 =?iso-8859-1?Q?ekK2t2l1ggf6Q7GvF5LqvUa+dK+gJcZnFF0srPJcFgcO4sIqpPVJsXFd8L?=
 =?iso-8859-1?Q?fXCVHotZoFUherhigg0SD3KksSI5lJxT6sJsPOt4XrLd8sSnTzC+P4hgIU?=
 =?iso-8859-1?Q?n2W3dLWJitqU05ncex2zyENfcv2D3NwvaIPWS199VWNuBtGSWx4c3i8ywl?=
 =?iso-8859-1?Q?mHHDNWvNmm0I5HLrWB3MftYKfozEriSBCX58C4pWHbcnVIJVMag9LZimlw?=
 =?iso-8859-1?Q?GnZexqd9r0lvJSSX49e8uq0+YEZjcPQP9QoKUt98pBg49eQDCfTr9vOh7i?=
 =?iso-8859-1?Q?Ti1LQQE/OvCm4tzmYY6jrPZ3JdKEh6Ib0Py1G2DF5XTo2Fpxy+dnr47r88?=
 =?iso-8859-1?Q?qnH0pyEj2uUStdIWtxc94TGyKkCK1bo2Kz4m54+N0Z4hSSurjTWLyD8Sei?=
 =?iso-8859-1?Q?FVPP3tYuyXg0qCPdupSHNihdHVkiQN2i4aBIrTkxn530w8SPH4YEPzbSuy?=
 =?iso-8859-1?Q?08/QsQsIciuSX2NWeQ3c2eVwXkw1eOLbPh+9vJYsHycWCw/L2TZ6wsy9Nq?=
 =?iso-8859-1?Q?kB+/X9eDQEaZ0I4PGZhyipJjdfWX1rT94fWHFdAr9OT3+HoTPzwvOFPKUj?=
 =?iso-8859-1?Q?MQA2SxVQr/GxlWRMqUxvfEs5wOj7/SDEp7RPUsZ+bd8cZ5Dpb/0uNEez++?=
 =?iso-8859-1?Q?BFnzTIOuehMtkhttupXbbeS3e0G3UaHrc4nsefSChSzpEfSBbRNYkZdMyd?=
 =?iso-8859-1?Q?zqfRVZrTs6WQ7cqWeQmsu+3ZVUNRqAg9qq7BbjYy325QWc6RlSTeyqmUvx?=
 =?iso-8859-1?Q?GHTKAd9fvaYfB6OKW3uzVmKbsUxiUnhpd2HEGO6EyWpKAqPytjHfcZ1WkT?=
 =?iso-8859-1?Q?/qQ47Oi0WPjzJMyQ4hwD+oDVxEW1yQUYJgcpnaoTnOKWAq1lzHOzVuVsz5?=
 =?iso-8859-1?Q?72zyCXZAsxMZ6HXTLzn3XrR4+6hCfkSlf+sISwztBMByyRvtAZFMxqguA/?=
 =?iso-8859-1?Q?DmmyH3UGVcPESjN88w7gcDTqhcL0yvN4hOM2NKSO2hG6qyn1GYj2ZS458R?=
 =?iso-8859-1?Q?vJ9asXHSx4piwPc2acSdAY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yJtpfKzBUe4tej6EbXpNDKY4ah0fZEhxNPEYhQPOOxnxLcOOfsCi1g3KfT?=
 =?iso-8859-1?Q?8DvoiL/GsiwRTaGaKryo0dLlhaV8sikNeGuBO9aP3aQ0fghgcFgYx9O4PU?=
 =?iso-8859-1?Q?yl1T+8z5fcsQtzoVIkr0Ehu29M0pMCPA6m3eXdVOh+PnuHw++BWTqFB0P5?=
 =?iso-8859-1?Q?RwpgC6FnwR6m/yDVj0apE538wMOBfulU1sn1sWbYZGNdjnSBbZU/Q3WCrA?=
 =?iso-8859-1?Q?HJ9bS76jEcIc/FW2iIYMU+SJRBd/tESsJso6BmiHyKzVSwufg4ipKS8ANS?=
 =?iso-8859-1?Q?k1j9q0hi+mvoQb/U5rHV1sJZsUcJ2FDVPLBI5aw9ZN+zPnukVeXFtN0m1Z?=
 =?iso-8859-1?Q?OWitJyUWOJ/kUtYeFsKSJcr3xFlfSqt0umDLgTFDhsquFwS/zls43m0Kxh?=
 =?iso-8859-1?Q?G3wML7adkcgNW6N8Kcb5Fbkg/6VEyCnxQSLtahWec0neAJa7aTroSUyTm8?=
 =?iso-8859-1?Q?GkTqmobTvMfMp3G8juv5teZSt0COZg/pJXu+L6dnfZ8QvRL6DnSl2nS34Y?=
 =?iso-8859-1?Q?P9fEim0V8zpB0OxJlMlKmuoUJxKDVEBgVIHdpdLXmHLb3Xda5sX6EZiQsx?=
 =?iso-8859-1?Q?oHLgOKUs77ob8N0NU7X+1WwkF2HZZ1bDYs8EPsXOPXSkFuWLieKhcCGU/V?=
 =?iso-8859-1?Q?MgMV8os2qb0V3gr7inS93VrcBgAk//GRLAC7oxiJioXcnH+85fEIly59kg?=
 =?iso-8859-1?Q?ByM9VWIIbiFIUsCCLFtx4lGCKR8XwJvuoSiBtvcWUOKQHVHLQZNiFf0qNd?=
 =?iso-8859-1?Q?KAGvETVHH3c9VKvvqAqA7pmMkgN91kQjd5ZIamdshaN/uqxMtAhytD5tfu?=
 =?iso-8859-1?Q?OIXUsNYniX6kuk2kMcVJoVDCv8WO2X6iH6026ChCSkcMUUvqx0LBy6XjyN?=
 =?iso-8859-1?Q?OXaFlTjCSFm2qIjadzzBNZ4+WjzrAFLU1DhGTtlvtYTHd1K7idGrM7qavY?=
 =?iso-8859-1?Q?8q7iEQlWpg17J8yRrHyLGRwg5qM9c0T87RGYCEw+2g8HeKAdaJ8GLpE6e+?=
 =?iso-8859-1?Q?Et0Btkrpyvq6capI87b+SdR8z6fafYRYKhshAZAnhePEksP2ZGniUUIDmD?=
 =?iso-8859-1?Q?jqYoArJ0RkNl8ziKxUL3AyBI3fmHpzr/v1vlAPq+1CWB+pavhWK8TDsoWn?=
 =?iso-8859-1?Q?cv0BEck8yiqq10YT59YjccA8fn5zxrrt98lqHJtJWrl2G4Mjzym2bzWcET?=
 =?iso-8859-1?Q?R9cE9x9tF15KHm8Ww0MW2QoqPeIHysGXg9mkByCf61+wHkLRks3bgzmhuz?=
 =?iso-8859-1?Q?mJQ7qV4pFfwzkagNrgiSG+Wgod3TtE+jfgJX6KOJa9jtjqPcqbZZ403C0N?=
 =?iso-8859-1?Q?3JYlRr9OUUvFW6WpTmcArNhvocGamYyAiUyfUN3LktFaKjWNJzn/weL/+i?=
 =?iso-8859-1?Q?PO21y0ovX1ofoe1xO8bglNmwJGQtXpJ63BmLmZX5fsWRy9wgF7E1fDoRD+?=
 =?iso-8859-1?Q?cB6xdabaI+8kh5sbmVWFwi2gDga4Rfmig1Bss35kkBv80K6F3mabyILJhj?=
 =?iso-8859-1?Q?CAAWJwJQX8ENOwPATnspJb0Aw6X58SKorcQdSFq1p/xAdWSkUm3fc7UVYv?=
 =?iso-8859-1?Q?BQC6CVAYWCCMtykokUA5FAuUAENYOKzBtM83dA8ZXNYICIQrEilAHqZfe+?=
 =?iso-8859-1?Q?93pRpJE4mFBJuAxUYm96JO4SBaW0Vejf88GuCQJv81aSxcw9evoRu7mQlT?=
 =?iso-8859-1?Q?9Oc0kT4Q9yBYJOXq9Gs=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316EECFBF485365FB17D05E81C22PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v4HA2zJmjiwX3yX8SljjBVb+FGj1qhAXC7WVZIXsIVoPAv0AjTGylKn/xH333cGUpTEb8L2DwPVsqFfPSnPGltIWfL1PJuw41BmSWuw1RmwVj/YhDfVka0LtX1QJPZ0bomFq049XT//vEMrDLnOofNc2xcy/4GJtWAtLTnywPmmBtfPa1E8hyuesX6hAdei4wX3RDb9avuFeko/cPMErui8tPvwq7v0pM1zhXgE3vfvXkwTY6kFHVYCUYhGK/IKrSLgG3e6qnXdX3vA00hNNpf0m7o54YqxflvU2z9BFkjyX3aWq7teq1t8WFfWMqGj2r4aufoTZIm7MDz2HM10FVU/MGJzacnhKSgWZzN6g9aHIQ/F99IxQLGbfX8bSU4M4Oc47EPrb5Xi9bimJJQsGRXX088JF7jxG9cTdbXkOB5iHV6hqYrQHm8p5fDmI40qv7bvC2WXmT+/nAZYsq4kJEk70yGQ7GM+eIQ9VrAwrIp0jM8LWET0cTinL584apg/+gwNISr632taE1G7x1CY0H0y6c1eM2Do2VPGREyN5n0gAHaGKHtdWyAUtUE9l38qHg8/nVoBrbwZG13DXXB2BRmzgb2lj7IP45jRFvf/JNMbd5MPLackTD0/Jrpnjot5P
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1bc2f4-02f8-48d8-3e6f-08dd5611239c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 02:56:16.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hooZRm7t/aVqEMvRU6N1aQCnwDSSdaKOdt4L5YUQlkdIviwJyd85Eou/EDAm1fYc8yGQ2djZxFU/6jzbS04P5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7002
X-Proofpoint-GUID: H0ctMVPXnda1iZI4piDZj7NGcPTyimUH
X-Proofpoint-ORIG-GUID: H0ctMVPXnda1iZI4piDZj7NGcPTyimUH
X-Sony-Outbound-GUID: H0ctMVPXnda1iZI4piDZj7NGcPTyimUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_07,2025-02-25_03,2024-11-22_01

--_002_PUZPR04MB6316EECFBF485365FB17D05E81C22PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Without this fix, the mount options cannot be modified via remount.=0A=
For example, after executing the second command below, mount option=0A=
'errors' is not modified to 'remount-ro'.=0A=
=0A=
mount -o errors=3Dpanic /dev/sda1 /mnt=0A=
mount -o remount,errors=3Dremount-ro /mnt=0A=
=0A=
The reason is that a new "struct fs_context" is allocated during=0A=
remount, which when initialized in exfat_init_fs_context(), allocates=0A=
a new "struct exfat_sb_info". exfat_parse_param() applies the new=0A=
mount options to this new "struct exfat_sb_info" instead of the one=0A=
allocated during the first mount.=0A=
=0A=
This commit adds a remount check in exfat_init_fs_context(), so that=0A=
if it is a remount, a new "struct exfat_sb_info" is not allocated, but=0A=
the one from the first mount is referenced.=0A=
=0A=
Fixes: 719c1e182916 ("exfat: add super block operations")=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/super.c | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/exfat/super.c b/fs/exfat/super.c=0A=
index 8465033a6cf0..6a23523b1276 100644=0A=
--- a/fs/exfat/super.c=0A=
+++ b/fs/exfat/super.c=0A=
@@ -745,7 +745,7 @@ static void exfat_free(struct fs_context *fc)=0A=
 {=0A=
 	struct exfat_sb_info *sbi =3D fc->s_fs_info;=0A=
 =0A=
-	if (sbi)=0A=
+	if (sbi && fc->purpose !=3D FS_CONTEXT_FOR_RECONFIGURE)=0A=
 		exfat_free_sbi(sbi);=0A=
 }=0A=
 =0A=
@@ -769,6 +769,11 @@ static int exfat_init_fs_context(struct fs_context *fc=
)=0A=
 {=0A=
 	struct exfat_sb_info *sbi;=0A=
 =0A=
+	if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) { /* remount */=0A=
+		sbi =3D EXFAT_SB(fc->root->d_sb);=0A=
+		goto out;=0A=
+	}=0A=
+=0A=
 	sbi =3D kzalloc(sizeof(struct exfat_sb_info), GFP_KERNEL);=0A=
 	if (!sbi)=0A=
 		return -ENOMEM;=0A=
@@ -786,6 +791,7 @@ static int exfat_init_fs_context(struct fs_context *fc)=
=0A=
 	sbi->options.iocharset =3D exfat_default_iocharset;=0A=
 	sbi->options.errors =3D EXFAT_ERRORS_RO;=0A=
 =0A=
+out:=0A=
 	fc->s_fs_info =3D sbi;=0A=
 	fc->ops =3D &exfat_context_ops;=0A=
 	return 0;=0A=
-- =0A=
2.43.0=0A=

--_002_PUZPR04MB6316EECFBF485365FB17D05E81C22PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-mount-options-cannot-be-modified-via-re.patch"
Content-Description:
 v1-0001-exfat-fix-mount-options-cannot-be-modified-via-re.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-mount-options-cannot-be-modified-via-re.patch";
	size=2087; creation-date="Wed, 26 Feb 2025 02:52:19 GMT";
	modification-date="Wed, 26 Feb 2025 02:52:19 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxN2Q2MmZhYjNhMmZkYjgwZWIyMGFhYzZkNzY5MmJlNTk3YjkwZGM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IFR1ZSwgNyBKYW4gMjAyNSAxODoxMjo1NCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjFdIGV4
ZmF0OiBmaXggbW91bnQgb3B0aW9ucyBjYW5ub3QgYmUgbW9kaWZpZWQgdmlhIHJlbW91bnQKCldp
dGhvdXQgdGhpcyBmaXgsIHRoZSBtb3VudCBvcHRpb25zIGNhbm5vdCBiZSBtb2RpZmllZCB2aWEg
cmVtb3VudC4KRm9yIGV4YW1wbGUsIGFmdGVyIGV4ZWN1dGluZyB0aGUgc2Vjb25kIGNvbW1hbmQg
YmVsb3csIG1vdW50IG9wdGlvbgonZXJyb3JzJyBpcyBub3QgbW9kaWZpZWQgdG8gJ3JlbW91bnQt
cm8nLgoKbW91bnQgLW8gZXJyb3JzPXBhbmljIC9kZXYvc2RhMSAvbW50Cm1vdW50IC1vIHJlbW91
bnQsZXJyb3JzPXJlbW91bnQtcm8gL21udAoKVGhlIHJlYXNvbiBpcyB0aGF0IGEgbmV3ICJzdHJ1
Y3QgZnNfY29udGV4dCIgaXMgYWxsb2NhdGVkIGR1cmluZwpyZW1vdW50LCB3aGljaCB3aGVuIGlu
aXRpYWxpemVkIGluIGV4ZmF0X2luaXRfZnNfY29udGV4dCgpLCBhbGxvY2F0ZXMKYSBuZXcgInN0
cnVjdCBleGZhdF9zYl9pbmZvIi4gZXhmYXRfcGFyc2VfcGFyYW0oKSBhcHBsaWVzIHRoZSBuZXcK
bW91bnQgb3B0aW9ucyB0byB0aGlzIG5ldyAic3RydWN0IGV4ZmF0X3NiX2luZm8iIGluc3RlYWQg
b2YgdGhlIG9uZQphbGxvY2F0ZWQgZHVyaW5nIHRoZSBmaXJzdCBtb3VudC4KClRoaXMgY29tbWl0
IGFkZHMgYSByZW1vdW50IGNoZWNrIGluIGV4ZmF0X2luaXRfZnNfY29udGV4dCgpLCBzbyB0aGF0
CmlmIGl0IGlzIGEgcmVtb3VudCwgYSBuZXcgInN0cnVjdCBleGZhdF9zYl9pbmZvIiBpcyBub3Qg
YWxsb2NhdGVkLCBidXQKdGhlIG9uZSBmcm9tIHRoZSBmaXJzdCBtb3VudCBpcyByZWZlcmVuY2Vk
LgoKRml4ZXM6IDcxOWMxZTE4MjkxNiAoImV4ZmF0OiBhZGQgc3VwZXIgYmxvY2sgb3BlcmF0aW9u
cyIpClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KLS0t
CiBmcy9leGZhdC9zdXBlci5jIHwgOCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L3N1cGVyLmMgYi9m
cy9leGZhdC9zdXBlci5jCmluZGV4IDg0NjUwMzNhNmNmMC4uNmEyMzUyM2IxMjc2IDEwMDY0NAot
LS0gYS9mcy9leGZhdC9zdXBlci5jCisrKyBiL2ZzL2V4ZmF0L3N1cGVyLmMKQEAgLTc0NSw3ICs3
NDUsNyBAQCBzdGF0aWMgdm9pZCBleGZhdF9mcmVlKHN0cnVjdCBmc19jb250ZXh0ICpmYykKIHsK
IAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gZmMtPnNfZnNfaW5mbzsKIAotCWlmIChzYmkp
CisJaWYgKHNiaSAmJiBmYy0+cHVycG9zZSAhPSBGU19DT05URVhUX0ZPUl9SRUNPTkZJR1VSRSkK
IAkJZXhmYXRfZnJlZV9zYmkoc2JpKTsKIH0KIApAQCAtNzY5LDYgKzc2OSwxMSBAQCBzdGF0aWMg
aW50IGV4ZmF0X2luaXRfZnNfY29udGV4dChzdHJ1Y3QgZnNfY29udGV4dCAqZmMpCiB7CiAJc3Ry
dWN0IGV4ZmF0X3NiX2luZm8gKnNiaTsKIAorCWlmIChmYy0+cHVycG9zZSA9PSBGU19DT05URVhU
X0ZPUl9SRUNPTkZJR1VSRSkgeyAvKiByZW1vdW50ICovCisJCXNiaSA9IEVYRkFUX1NCKGZjLT5y
b290LT5kX3NiKTsKKwkJZ290byBvdXQ7CisJfQorCiAJc2JpID0ga3phbGxvYyhzaXplb2Yoc3Ry
dWN0IGV4ZmF0X3NiX2luZm8pLCBHRlBfS0VSTkVMKTsKIAlpZiAoIXNiaSkKIAkJcmV0dXJuIC1F
Tk9NRU07CkBAIC03ODYsNiArNzkxLDcgQEAgc3RhdGljIGludCBleGZhdF9pbml0X2ZzX2NvbnRl
eHQoc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCXNiaS0+b3B0aW9ucy5pb2NoYXJzZXQgPSBleGZh
dF9kZWZhdWx0X2lvY2hhcnNldDsKIAlzYmktPm9wdGlvbnMuZXJyb3JzID0gRVhGQVRfRVJST1JT
X1JPOwogCitvdXQ6CiAJZmMtPnNfZnNfaW5mbyA9IHNiaTsKIAlmYy0+b3BzID0gJmV4ZmF0X2Nv
bnRleHRfb3BzOwogCXJldHVybiAwOwotLSAKMi40My4wCgo=

--_002_PUZPR04MB6316EECFBF485365FB17D05E81C22PUZPR04MB6316apcp_--

