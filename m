Return-Path: <linux-fsdevel+bounces-44521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEEEA6A159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09024463EFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 08:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8054720FA85;
	Thu, 20 Mar 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CALwPTeX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF913A87C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459313; cv=fail; b=WfMFu7iVZdpEeYuRmmZsW9PwWkqS87xL4C538AXersQsVKAwl/Ycofhl3rW8mFGXm/WPMQvdLfqhIGO9MxvIVTSfknTJNbFYEN+cN8fnWfRbO8Q06mC5PUIOE5kxWi4Mr4qKWQmW7JW+b3vJtJSvdTFyscJeDgd5AQa9sNVvneI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459313; c=relaxed/simple;
	bh=IygUK21XMr2IoGBgvhWsTe1Rk/RkgNCIjzy3FxsYlr0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=adzgceg6CBlZlIkjJa1ZviUIgyzQGYEdHCUBJ0TPK/YKC8kFKnLTnaRvmaKiPn/Neoq1VGdvVdvkzo+YZMxaVnKcXlJe50PG0ztR14LzLIdxj5nofpX2Hc4o84Uh8qQRdEahI8yC+tcFkC6A51S9Sm1onrcz3V33bcZqDHeA7fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CALwPTeX; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K70423017064;
	Thu, 20 Mar 2025 08:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=YUvIoVlI2BIbnOYtaw7R2EHh9VKzP
	DVbeGLPxCujWhg=; b=CALwPTeXevT4qBRNpfCAtEnkoOH5Wm9PPEU7wQ1TovBdJ
	Js48FMgXeDOhScktFHj8anufQptmKO9niXEgWNK4lxSgkBKPUlP8Yq9F7sNm1vI9
	Uj5Y3UzRU+I+nLWO471JCr8iHbVkL+HGdkhiZFWugA3uZpDfrsiqHlQ2Zb34Kz7U
	jv5QJlP2YyrJliccd+sS+6UW1zsKBN66i0Bol6KaVy46GKIP1RUqQtK/YWIipHZ7
	EAqANmCCxlgTEoycO7hVWQeKV13eT3wb7jbm8vzS+cILskpEMLGFlTFcpGGoGZHO
	owjwBoXqXz90b5gzDQfqXlos8qubqhZxnrpO8OodA==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45d1k44c53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 08:28:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULyMW/eJM9I8TMSLSJRBunTlueIDIP86TLw+ZKSTrwXLaV0IviQOFaH62vaOqBf1ZYceloPXfWYJFJDN69L+fMntxC8raotv92Jb/5Ng7LdSVW0TZRvyEc+n+cWEYs18hU5V1tZJkl6vL72qYCKBjrfihOqoObthumQDwbb8KCZ6Q1O8Q6BNdEI5HBLLMjbyduYIvBdWR2NtxaNMg4M9njV6ui4Vf95vxnn+XA44Y6ojJ5Tt7B5kFs0VIlBIdOqR0VNjbMq7L6Ba2FD5agFMBGt+OzM5SG9cHC2FbkDQhLA8vtwSgAXM8/mo3AyQrVGafylCrgSE2EMQ1XrMcyqI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUvIoVlI2BIbnOYtaw7R2EHh9VKzPDVbeGLPxCujWhg=;
 b=K+nxFmEcx6Yb19vFdF7rMCHg9hjI5FmwNAltrU3vBLuYN/Ejh5xUUdAMuYCYGy8MOxjc4/vPcRzDLAMH8bMGQo+5N5ej/r1oA4US6UGXcVkQZVImlOq78HPNobMXmBuVKErDgGf1DEw0l3tZ5xSFlsdDnQuB+RWYp6ntWQqdGtMkTSg4jW0uVKa6onppN5PLPk9xArntvGprAbyVRpNE3ktoVBW99g8PZsGawQKDlqIt5mXhoNRHBfK8hqwm29VVE6/ODBJrF/VwG5kXJI3kL0oI3j7hUHJBU01yk8A1OUJEiK+Jbw8pTIgBPl6/IjVShmBLIULo4RERfO8SNq3VUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB5755.apcprd04.prod.outlook.com (2603:1096:101:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 08:27:58 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:27:58 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix the infinite loop in exfat_find_last_cluster()
Thread-Topic: [PATCH v1] exfat: fix the infinite loop in
 exfat_find_last_cluster()
Thread-Index: AQHbmXGUkFBt1y1Y4kqA1kRdXAParg==
Date: Thu, 20 Mar 2025 08:27:58 +0000
Message-ID:
 <PUZPR04MB63160E8D5EF0855E84D9D07781D82@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB5755:EE_
x-ms-office365-filtering-correlation-id: f56f6d28-33f4-47db-7e30-08dd67891f1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6DYpYbqlXe4z1G6K9X7xV1z2pLZv7Me7XZnrjMQw7XLz3A37knw9VtEayg?=
 =?iso-8859-1?Q?s0wBoMQ3S2NtP2jOj1R8fgqz2E656bqmMX7pC+kNYHxw8DI6zM5D06bOnk?=
 =?iso-8859-1?Q?AyEV6dd2ELF+SkpH6kVlbCd/g9F41wYgnlIgI13wsGcKsVTnu0jd1ydA0Z?=
 =?iso-8859-1?Q?v9N9h5QnuARgZo3p9tAOoN03+6NVdf/h0hYZoqxiVOd5GhPL7jnt9DeTBN?=
 =?iso-8859-1?Q?2DdV4iYOLtjDeLAYfhJZjpfQC4EgyrGozdnHWAMEij2yhcyNNWg2muMC3A?=
 =?iso-8859-1?Q?xoalEUpo2L2l+2rL9jPL9e1Up9wXtyaOjOI5pMc6B0FImQyWywY8eoAjFk?=
 =?iso-8859-1?Q?dGo4fumKtLFi9PHRKsHRiq2jQ29+I76m0Bzu09ejqtjf77CXKL8fSsBwsf?=
 =?iso-8859-1?Q?98UFNVCoBpGjxufbh2PjApf+J1JqRk1mvY5vydR9qoF9z7wg4XX0Ctuv9h?=
 =?iso-8859-1?Q?Xf9+gDK2S4IRce7cbaTZ9E6FyONVtn0Ea921MOpO/CNQdReD/wIm6nHicN?=
 =?iso-8859-1?Q?pB5P7+z3XKVCnpRhVuWu45EDMocv/KDlRkH5dtZAjkm6kpDTs/3d+TCDUt?=
 =?iso-8859-1?Q?fHnmWeMzpDZ7whDBw3nVRtE+HOhmM0QCErfqJjBTuVJFxOyz6b3g4AIeqJ?=
 =?iso-8859-1?Q?7e43YepREQcYvOrsF/L2yG7hvsjTzlBOyFoor+XFMqmW4L5CbZ79Ud0FKb?=
 =?iso-8859-1?Q?rl0zaiIzDNhk3c/c4uTT/53NLRUlZx9t5Yv0zuXT5w5fy0oQUd2DZLoGcI?=
 =?iso-8859-1?Q?cKcORU71liVb+pH7X/+k+epf2gnXB+Ymfzyycm+QC8/kXYt6xWsy90A1TF?=
 =?iso-8859-1?Q?qiSGp+n0HWlE86rr8lsoM3VWAHL6V/w6MeYu4gOuwaT5QwLU/b1YOBdTX5?=
 =?iso-8859-1?Q?0sOMwS7CiWO8CUN4rVxqPrcCkOE8Zcl9N89ptJYcfnM59vxZQEpjw3wwUn?=
 =?iso-8859-1?Q?1xmk2hBV3m66Ie9mu0TKfKPClhH9C2PObyU1g9kPc8bzbtmYYpNi2piK6D?=
 =?iso-8859-1?Q?i8pX2lSR9ZoXK0DRCWvqQh3Rnx9oOcqQjwROT+ok18ZkEiUKWccLoKcEWy?=
 =?iso-8859-1?Q?x+0RBOO0ziXrTHMO1zd/nk7ouR1o++6h8a0ryOFpiXLlAOplz7o4ae2TUD?=
 =?iso-8859-1?Q?TurdJkAvocUY3DjKeLnl7suyH4jfUhQ3Q4o3d3piz9D0PVWMRiAkVQI0hG?=
 =?iso-8859-1?Q?xiuku6A3A7/L7Xx1s9aQF7vDHsk+6jYdZFlt2GE65bt9vJKV4bnN4LyKNM?=
 =?iso-8859-1?Q?o+1rnMYS916fLwOkTWBLoHcbHH+meoWXqVg/7qSWLBaQSMbVnflS3//pGK?=
 =?iso-8859-1?Q?udnvdwM1nNUTE/BSY4xY5UwE7oj6cIqWAeHfOVQYpc7Pb1dLLC2k8sA0Os?=
 =?iso-8859-1?Q?GoeHa6aHdj9XysH6yV8K0s8xoDApPHspJmR1wq4i2SAhVR+lT18dn74nVg?=
 =?iso-8859-1?Q?gV6xCyrl70SCMIfr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Lyj1VjSeOOCuQrgVK+LZYjegAY7F1cBiwmTJUcHTfArv2ZLKHOl1m7QbHd?=
 =?iso-8859-1?Q?8ngKURUw5KqZC4OR+G3B/E4ZVFizY9FSKiI9BpxxgxaZAZGu1UsP5xufLK?=
 =?iso-8859-1?Q?znFjpjUWFzW9p++7MLx5V08L0fq2D0Td68iP8Izwsp0h+tmpAOvX3gC0ef?=
 =?iso-8859-1?Q?uqofVjd04sWlDm3PofHGeupM4nqK5JBypJ/i1PF3FG0CVXaNomnQibZ5X0?=
 =?iso-8859-1?Q?vX2fq+u6+D7Q5qvZRp/AeGDrpQ5hKY6HrUE+Q5B3ypa7zc6i91aOEZ3yXP?=
 =?iso-8859-1?Q?LM7gzf0ajy5J7uUKFdqVoe+7vNKAHOGA8TE6AZ5SSrW7y9IwNweK/ArQAn?=
 =?iso-8859-1?Q?V+8PmQQsY/nsJP9VxvECHPNW2okZeEDgLit7PMroaU+3JRi+co0LJxzBSK?=
 =?iso-8859-1?Q?QolGoBgmVFOVy3Nq0jgDLxbKivaHKV1A+e77DwgyiZ+ImCFa/IzaPfuqIf?=
 =?iso-8859-1?Q?/b9UjU+W/snk3rdb1IjPQ6Zb7FLj2umbVhQnU02FWMHWSAjoA2A6Z7P/Fz?=
 =?iso-8859-1?Q?zyn4rNBKWiPTphP8h4lI3v0VhlRtxQCWJXlmX5TX3MZPYjiMsa+7edagB7?=
 =?iso-8859-1?Q?r2VyPQdpIxHEojlRHTFyXmFCTx5XzPt3O4cMhNf4Rw0QRgH58wJujEvMcd?=
 =?iso-8859-1?Q?KK7zU0mJIDgDSXUvUY7pbomANQg7/yOEY7bu6YRmz9FvdCXHAka6TqaAbw?=
 =?iso-8859-1?Q?v0nTw/UaaMo77iOrylV43FK96WKYxBbQ9uxmBNNcKy3d2XLTQi8nekJbHY?=
 =?iso-8859-1?Q?b31+3lmh7Q8ttnx2O7U2LYRzjecqyE/2/q9HM3/9nCa4ABhQ9QBS1J6JSH?=
 =?iso-8859-1?Q?eHoQt74clVVNN0HsIQFTt2Iujoeim0LR50Vx9DwAiGpTlGznz0f/2VTvnT?=
 =?iso-8859-1?Q?D1TC2HI9mjMo0prG7haRk2oE+hWH3ic0z6Tw2LgT7R82ryX/+aU8L/W3in?=
 =?iso-8859-1?Q?KtmCKEEcu+41n8Qt7zpGFKq3C/oCHv/bOCxDBQnZ245iXpNJ9+aO0prVOp?=
 =?iso-8859-1?Q?79TY8nJ/u1BPsIdREg5FOaIrJ+V8+TJNV8vPhLX9HG3ZHDpOrs/0+Okz+Y?=
 =?iso-8859-1?Q?Mrfp9idRYJdyJ7zELx4VOavgqFfZWVL653N/z5j3f4QqGjyaRq2VWV5tKS?=
 =?iso-8859-1?Q?pOJjycGvTW9gCcA5H6t/oLDWiUAk5BS23tFirkhm2VXcKVWu1m7PCZOpv/?=
 =?iso-8859-1?Q?XKNfsEvSLExes/QivoSSqf7ZFUeLM/PM8dXs/uf4FUE9QBjpetsHcY7rjn?=
 =?iso-8859-1?Q?JUgseCujp8saqmXCVhNcYIQh+uM89AgTGDNkStP21Qe2aV1Bk+44NtQhsj?=
 =?iso-8859-1?Q?KQJfJcpABreOSoAIwNwdDg6xargQnzJCTt/1ZmKUb9sB3n5Hol5TYJA2kI?=
 =?iso-8859-1?Q?jEhL6a3Hy4vn9zst+a1VVoFp122xtNAZKqMTEtWv7TIs8TE9ZH1tM0OYNC?=
 =?iso-8859-1?Q?uCp9hNl6sNQi97+cHEW8OTfeWqc4SwMjDcry9Gq78SoBoY9MWhtuDaVI5L?=
 =?iso-8859-1?Q?u7mFypwG1xzeSwioJAaa7g2rvoljYA7ipGVaovupDV6L/cY8n76+tGFt/l?=
 =?iso-8859-1?Q?HsNhezK6TGE2hWmduE5HtRnWwfZCs4j61LWzwMLQXhv6d1sz2ZL5g39q+W?=
 =?iso-8859-1?Q?RUIemNqoGaRvPoKcrNHhyDNHKt95wIFbI1x2PxzBJbwiQLOT49Dm688ORa?=
 =?iso-8859-1?Q?DiSCI4acCR1NTv7NIZQ=3D?=
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
	g9qu/NPsHAu7WaNkLw4luP+pVw02ZHuSBLhZA7q4/oDzKzZxEpUZV894dL7yAONa6JhqjccRAYpG48ZRgnCbHdP4nCFvyIs1oM/+by6CofWy1yY3JPp++rv5cXI6IlvDj7AOZkj6fJaIyyPpUieyF8on5yCK+GqcUEfGRLORZUHHousXQonTWjenU/o3/810ixO6z8+tpxUEIFiqHlWPykFcB3l+HdEMBy/v1/OHpMQzadL9oPvQr0q3RdXtxDtuJq38FLuakVbTVThZCFc6avGU++VpgDoAn+fUVgkSwA/NBeM2AmgT6eBmrVBzWCTpY1YvQYCOy6KuDdgeRrvaKyC1YgpWcRDNNnb7UCcrFUcY+CfAE05uE866fNX8mA5GQjTXkc2BcbYqx0KX0BH4EtTDtTxZwxvQXE2YuTIE4jvtJEwZaDbB2nODP1IeJ3s+Wnuw3Muil5Pno91oEwL/t6GhwsxGMkFYMOtujKb95OZQq4RtyJ3BdSCtPvmK3fozeX+WQJEu1IhgHTU0I3TSbknX/+ZRBm6nZTBlEFJ2dcKWz99XKumyeWrrhE0vtgXiMusv4vezZSzpOlcr6WF5fBIf1sgxJAUf9xww8L5x2SCUTaQ3/RDNRTGq4ebNW21J
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56f6d28-33f4-47db-7e30-08dd67891f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 08:27:58.6255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRiz5w5bs4sr3RbcXi8AeBnGmovHZd9IsSZgYCPrx5JvUv5a8U8Zt3Lc4O9svL6o/4LPINrJo3XXIUINdsuMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5755
X-Proofpoint-GUID: KwHN2iAWa9Byp9O_6zlBzcp0It1rn0Z2
X-Proofpoint-ORIG-GUID: KwHN2iAWa9Byp9O_6zlBzcp0It1rn0Z2
X-Sony-Outbound-GUID: KwHN2iAWa9Byp9O_6zlBzcp0It1rn0Z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01

In exfat_find_last_cluster(), the cluster chain is traversed until=0A=
the EOF cluster. If the cluster chain includes a loop due to file=0A=
system corruption, the EOF cluster cannot be traversed, resulting=0A=
in an infinite loop.=0A=
=0A=
If the number of clusters indicated by the file size is inconsistent=0A=
with the cluster chain length, exfat_find_last_cluster() will return=0A=
an error, so if this inconsistency is found, the traversal can be=0A=
aborted without traversing to the EOF cluster.=0A=
=0A=
Reported-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com=0A=
Closes: https://syzkaller.appspot.com/bug?extid=3Df7d147e6db52b1e09dba=0A=
Tested-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com=0A=
Fixes: 31023864e67a ("exfat: add fat entry operations")=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/fatent.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c=0A=
index b9473a69f104..23065f948ae7 100644=0A=
--- a/fs/exfat/fatent.c=0A=
+++ b/fs/exfat/fatent.c=0A=
@@ -294,7 +294,7 @@ int exfat_find_last_cluster(struct super_block *sb, str=
uct exfat_chain *p_chain,=0A=
 		clu =3D next;=0A=
 		if (exfat_ent_get(sb, clu, &next))=0A=
 			return -EIO;=0A=
-	} while (next !=3D EXFAT_EOF_CLUSTER);=0A=
+	} while (next !=3D EXFAT_EOF_CLUSTER && count <=3D p_chain->size);=0A=
 =0A=
 	if (p_chain->size !=3D count) {=0A=
 		exfat_fs_error(sb,=0A=
-- =0A=
2.43.0=0A=

