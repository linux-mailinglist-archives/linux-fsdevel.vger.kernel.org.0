Return-Path: <linux-fsdevel+bounces-44520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D56A6A156
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA50C3BACE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7C211A1E;
	Thu, 20 Mar 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="G/V0Cp1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259613A87C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459302; cv=fail; b=uvha30oCpds+z7gMp9mEwLLXNPUCTxftIZebP7IkeGcc+fD84E1kagHwnvACHHXVz0Ytd8ToQDT7FUoY4lA8TZ2E68+nvcHmHz/ZYYtvTkZ6Krsh9ovvW90Zc0YKItLD7TxIjzkP2n51Pfo4SOm7AfYiAh2SoVjbtGpESq26A+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459302; c=relaxed/simple;
	bh=JEnx+5t6CS3fVPvDikvk+OC2TXCyKl33cz9TUoikuO0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nG1iX+RpMPl5I/spdyI8+yLsRiM0Y5VjGMNFF9dFWLrDCcZ1nmWofRwzml5zcVCrSQGI576RsnUBNY8Y16d//6T/Gd7BPuc/6hLxkSCNSxgoUeg0cD6zfVG5yIcyhNyHI19xPf0dETehrGkczUWbEWfS3C4UI8yE6ncjIjnvFc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=G/V0Cp1T; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6c96M001046;
	Thu, 20 Mar 2025 08:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=t//YFQKb2ZmO+5lUIvNabDpOzDD1g
	kT1wxmdb95ah4g=; b=G/V0Cp1TeAqSAEe4hCGadZ6stIaqDeg9b7DY3S10TDdlp
	SuMZH/h8zW6CmzoaNsaG52NFPhK2U1Jh68dC1lhUXE+1IDvmW3dVO2jb+Wy9l0y/
	F7aIKi4ivuOYg56rsmqdTlQ+SGubq7SmVMZmiB9zIfUUtFojkP7L3WZLr6Kr2c+m
	puPE8DbCbOWZHm9AYucoiQVWc1BoiYKi3HveHxx/lABcakPSR5bzuRnxb9C8FtW9
	Hy2KuNOe7SaQkm0PCqZN5nVQy2q3xgxasNitUPzx/99YJqhPO0pb6PyEvEHWoaHu
	BlhpO8KHrZA5uB0AI1yLxpYx90qDNxCDtIaCRaZfg==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2112.outbound.protection.outlook.com [104.47.26.112])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45d1kvvs9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 08:27:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua/yd7KTDuYO6/wYXniGyp4qQjfiS2VpTvYONUZs8e7fJs2JBmMkL4q/LSHgCBOn+G/5YOg+WukliAQ1QaNEePx2CUS/Qu9FBtSMVEz2tBeAMKRKw4VY0YFKtmPJ3TOqVivaUuTDDqtuWOdjjbYIUnurQDZDze82FovHbrlrt7jaj0sZJ60YJIfQHQ/qXJ/7c05sfqJAjTmcIc2ZnNSd2X/l3VwvhkTP1JyoDE7aQNfKi2zlc8BI64gE1nl8cq62qkc3Cfg5oVDWryRea7ip0U3iRY6oNWm71kRvhmZv7IoX2WwP1zzOAgVQ0zSU70J50pp82qhxqoLjWrtC/k4YaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t//YFQKb2ZmO+5lUIvNabDpOzDD1gkT1wxmdb95ah4g=;
 b=sZn8ZowpD9Bm8rAcmhLXRhfShNL87rzQf0v5GV/g4a4TGCnG/PPf03sjjPnrUXIdthS31dNtuEQtZrsDimgXdY/ae1DTfhB5xX9A0uDqf/pPYgK6ZDa7tnWSlDG7rQcYz2aKf4gkgCRxB8F/cy8HXCNoWUShc6ZmLKA9NSJRuufRky0fAiy24omkqgTRMmPsDFcFCOXV2+e84bo6hPr8fwV4NNDQ1k5BC66fmnHVY8YuKxTGXCk+ARWWuLAV79+mfsidwyUbxT9VexoNln1vxiPQYmkV2/dDAj5FrCx81Q5AAAMqfh4zdi0Yq62KWMTfOkmwCIgH9Nv+LzBUy+3wMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB5755.apcprd04.prod.outlook.com (2603:1096:101:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 08:27:45 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:27:44 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v1] exfat: fix missing shutdown check
Thread-Topic: [PATCH v1] exfat: fix missing shutdown check
Thread-Index: AQHbmWdDiMaE5gEqTkOoI7qdkz+ktw==
Date: Thu, 20 Mar 2025 08:27:44 +0000
Message-ID:
 <PUZPR04MB6316D4A5885812011AD4C06981D82@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB5755:EE_
x-ms-office365-filtering-correlation-id: c1dd5847-b454-4c95-a59d-08dd678916a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lAu4WQEQCrUoeGEm787C7rRyLfyWo7CMMMWvb6S0/WzI9ujm5O2IkcOUAB?=
 =?iso-8859-1?Q?v3+dqIVq/fJtENZ/LJoKr8/3HFIsvonF1Na2OHbm54tHf/9vIVCqiZnDiM?=
 =?iso-8859-1?Q?tuLDb6xM+Hr+cLqQAJbU5F3Ioxl0YByeFVtlgxNrehmZcHi3o6p18s3bZX?=
 =?iso-8859-1?Q?KLfI5CG+i2GyUpPKxyOIsZeX2wJjvWWpPElto+TcFDnyG6zEq6Hu/zsp0O?=
 =?iso-8859-1?Q?5qIy8/r7EbHDGG+JBiNE3WTwhdNLku8Da2SaUOgZQoFIjuZORTveSLKi2L?=
 =?iso-8859-1?Q?mJKGAuisqQL5Rf6R2IHOzCjfmCUieqpseE1zjEgxxuPIRR95b4Wlc0qfSz?=
 =?iso-8859-1?Q?65SShEVURBPPm2038m/7++1W7Z4hV/LDdhkgBD528WUrskkaFrwIXYzHBx?=
 =?iso-8859-1?Q?hfXwyB4syJgLGMy16Y4YLEIyhNdnN8IOZKZBUGdhAjjkV4pRpqt3qCUQNv?=
 =?iso-8859-1?Q?14jrDyLGYAz5qavVYTI0nEbRpMTqiC0VthMgjra/0V5ofrdqonLPYM4qoQ?=
 =?iso-8859-1?Q?b5QpoNTs1M9ZSoqHZuyn+WkNRiqMcIVSm3JPtMkYkyGD80u/l35Pd8yqBl?=
 =?iso-8859-1?Q?ByT2qOd17khJyJy3n+3W6W8SWbj/+4xoYb8ik5gWjiF/1dXwQYnpW/4fSr?=
 =?iso-8859-1?Q?Ij4kqQJxWzEgtjkTQwOcumGKhrp2fIOwGBYOALwFKOmN7lPCV/1elS0vTK?=
 =?iso-8859-1?Q?fthhJRv6PZTq/BZq8WAtvK50c1k8Tbln4UFIKHjsoc9/1bp6LCOA0o5hFA?=
 =?iso-8859-1?Q?d/8RQQahpGLY14VT2dUUznZOMYIH8Uwga1hlcz+bwFKo6MWe+Ogon8pnxU?=
 =?iso-8859-1?Q?bcUBlW6XqXdSTqm5yCyDeV4joNnMPGtes93GC6bbTfRK5dMW3wMsYqMqrI?=
 =?iso-8859-1?Q?zYdec8Jq2bxCZvNKVeLRMbDirJ93+2KrcOsTJlUsXSxTb/1Fkj1UTtenAC?=
 =?iso-8859-1?Q?OjU6L5ifMw8oMaaClPF+bPwHLj79XxxTLOrlIVKQu6txHQ9v065gn4mSA3?=
 =?iso-8859-1?Q?Y5iFv7Zox43qeo012R56xj3I2+iNrnOZp7vHO7R058IF8+YeKgDZ6aW8Tn?=
 =?iso-8859-1?Q?NtV0hpIIbGTv5KYLpSVAJ7bErBPiRUYqctxB6WgvF3yEH0jrmzR6Kk7BI+?=
 =?iso-8859-1?Q?Ywf4ntEH8Km/d/zsakjOxZLC1VNABM13Xn+feITFKC0wFYTPjkaKNQE/yi?=
 =?iso-8859-1?Q?8QUYaE1E18Y7IwSCHGeeMZ+AbaNpYrldlJQlKIu+jcuszZ84Vjt16qQSiI?=
 =?iso-8859-1?Q?qAuqd/ZL7ixhxl+KhwtRlcG4F85srCiyQieeKhO+HTQnV7hqsMpcZwPU+d?=
 =?iso-8859-1?Q?RImv9WnELsqsa8Sb4/DWns5u3KLwtqL1xCftCerGjSzAcGfJD5c2F8JSfy?=
 =?iso-8859-1?Q?Jp2xVnuXIHkAg8Xt62nUWK3pW4qbPP0EOvE4BhYVav0CPST8zGQgHS4TTB?=
 =?iso-8859-1?Q?2XxQt2mOWEpgK+ud1EAcq/ouUKWrZXcIDWY4TakYm+HRpbVTLQPbDGJNvR?=
 =?iso-8859-1?Q?9F5HtanKrznBMrQ43d0Mj4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eIRCI17PjGf6gzlgp5G+EFyvQog3j7fVTA1UNEsrifJoDj3gQ3nssNWY8q?=
 =?iso-8859-1?Q?55cpm6otRzF34lwQxhlZ42MutzUms5uthW7ysEWUa/2A1ieuur1HT1FZyq?=
 =?iso-8859-1?Q?z5IWc2mqeDaP8EDJs8ChwbroasWaw+RJfcOK8n0gPE1TTNjKdCRBamtb1Q?=
 =?iso-8859-1?Q?HRQTJPZy1VAH812OnJ6Q7qYHhqZBmDViVwfAI3aqhg2brczEwEUzpn8EoL?=
 =?iso-8859-1?Q?q7XZSP/4eoOBgmhm+c+NyBIzdnBGBiwIeYEZPCnT0wFYAgPzV82pM6q8Nk?=
 =?iso-8859-1?Q?7CDBhpym6x/xu7odGR8YoQ9iiGdg+Mrn+OcWLjsX6CI7WSz1MbqJzPkPCJ?=
 =?iso-8859-1?Q?qZ+0k9qEsqbEu7Dhb8B4QGNZMTaFvCqUzJZUs9nzoMVUE/e72yROgH98bU?=
 =?iso-8859-1?Q?AOxWY+7HVqDKeThebWyjmsM9VXFz+rBf4Ctqvy+dFan7kXEPyX+3QMUCN5?=
 =?iso-8859-1?Q?W0uk7NHzi/Ms/VPYmu20FsCoOITzJY1gMUHSE06x4njZDRhc3HUV6epDnM?=
 =?iso-8859-1?Q?9Lhsv4CzTA6+aCrJXf1L365NtqdZGOHgCxbYpCqD2DK2x/cfryaCQhZhpU?=
 =?iso-8859-1?Q?pkAY76SohWlsZ1QSp/ZbHZQnAyPNOBbLimjaMuIYiiRo+q8iQLQveE1inH?=
 =?iso-8859-1?Q?8aPvapHU5JyrqU9ixG6oDgPet4rn1r14VjgvOHtvHfGEjfeM+iyxIvMfIM?=
 =?iso-8859-1?Q?PSh5q1WtKM4siTzXffBYEOkwdNvxQbCF/5GKb1P8gj6c+S2gk2fnswLE55?=
 =?iso-8859-1?Q?MEMVA53A6ZxvfcFqeHOs3dAOA4bX4ohSf7dnA9sXe+SWC60ffWdk6X4ObV?=
 =?iso-8859-1?Q?mTnhbs9fGx1HIl5jqEsGJBh2rJf1piJzGPBQMwrtmplSxs1voSOxUFaNIL?=
 =?iso-8859-1?Q?mm/75FkNeFW02VFWjto04uyVJJHLTA/jNc3dmgDqD2oiB14h4Z+nkL+AYZ?=
 =?iso-8859-1?Q?IpTozJjdot5lXt7qEUItEWLElkpQY8C04qcZI1+XP3RQnKBtG4DaRhlY6D?=
 =?iso-8859-1?Q?zR5BiHfh/ETGJjjredF8bZc40e0vhzOzQN7jP/0V1MBbpUkvUqQzKLAILY?=
 =?iso-8859-1?Q?phwWjE5FF2N6csalIpzonH+96MggA/Kvg3JhveLzRDRCMs8GdJjKARo20S?=
 =?iso-8859-1?Q?yIKCxgjw+e0ow8zidKmnR9lYjmhb+63ewS8XroIwAsK/lWRAkUVzkwfkyG?=
 =?iso-8859-1?Q?WgleZKzGeIdW+N1ce3Bafjfrrn76a8RuqLrOJvYeUpPRkGzzjK90zHLhiE?=
 =?iso-8859-1?Q?exJY5k2P9dbAXuPLz0OVhBiTLGyY4RqLPjL7dVhWXhQwwz1knowsflFxWC?=
 =?iso-8859-1?Q?PtXG2irAoEb4DkDWWiFa/LpAgkDPCw4atfFcTgkvBF60d6IDuHzQZi4XP6?=
 =?iso-8859-1?Q?6go83iAApVgapfbBs4LgE0i+9+i/W4nfSM4i/AnTmL4Vv68JmHfV0veHXW?=
 =?iso-8859-1?Q?5ZcvSvvC3AGcLbcNZVuLbij+MNx5Fmp8hj8NqGTA84VZqtmyOyiDJxzhSQ?=
 =?iso-8859-1?Q?Mv/r0/AYeXDJFtVFEd3kGvAkwfBsl+kS8zQZGng22Rk3/mAMkAj1DqBND3?=
 =?iso-8859-1?Q?K07/fDXcW/RpAXmwy7zquHUhY4DJoBeWssGLYfcG9eSIqEiFKXZkqWvR+Z?=
 =?iso-8859-1?Q?R79Bj2T8SnWRRCdytEqQk40ox+sfduWlZhMq8ZTS5tLSlJk5+XHMHcN2wR?=
 =?iso-8859-1?Q?Dgldg6z+3ggVBbM3PDU=3D?=
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
	bAES+tNUTQqUybWtAid9rGIwAZeLwzs1tNHLp58p6jyT48pQYFGdnQanPWmxT07nfvxM2Y1k4T7HXA5xdN7V75PFuJBN+yH59CVuR7M9shVT7VYo1oxKM8wBT/vP7ATmw7Be1H1SNyPjTp9LhRfK+7NdI8sTjUTkupsw+D9RWumQ79bEqykx3sTJz52NZ+Yy7sy5XkKc4IkTRCxRPO9oRW7/L9ke3O/PlwIVDh1HiorrIHrzwjTSZpb1yCYu9eTqhAByPYijbkdo3U5akCEa00AkuDQqkQaqxvfl/6wElNjE0wQScUH9qtROHpJaJB31kEccDy+C/K2q2TB09v8d10geScb52In+m3SwMEUiHJIxJ1vQoGhCiT6FTBKYC4rhbm4bdXDsxJvac42WeRlvyuXDtrAfu+GOytxO2hwmqh/7YVPGmMeURUBctXYzZjE84PfnJ28BjhKh/AGeOSkoHJrwPzyiF5AcJs+da0j6hwW88m/25C8MEPti07U+MMYECG6EKTGdCxxL0UsCnNOr8tVSOhJvMsHHNRwGD+9shySkmFnSGQJLtuHpxXMUmn+J3kEY4RKF9Xa5rHb7PRuuLnBR5G1UqMm2pOEOlar+ERu5XMIsH8So28il+x8L3UjH
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dd5847-b454-4c95-a59d-08dd678916a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 08:27:44.4664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7Twstr2zisTP5qQNkpY0xozznHHeS5YD9mzugWPy8gvmgvaOaPwdHdogOK5CYBs4eIu89Hfyqk1w0ANf8469Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5755
X-Proofpoint-GUID: G_xHtX-vc2_tm520XZNS6rl3b050Dr7_
X-Proofpoint-ORIG-GUID: G_xHtX-vc2_tm520XZNS6rl3b050Dr7_
X-Sony-Outbound-GUID: G_xHtX-vc2_tm520XZNS6rl3b050Dr7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01

xfstests generic/730 test failed because after deleting the device=0A=
that still had dirty data, the file could still be read without=0A=
returning an error. The reason is the missing shutdown check in=0A=
->read_iter.=0A=
=0A=
I also noticed that shutdown checks were missing from ->write_iter,=0A=
->splice_read, and ->mmap. This commit adds shutdown checks to all=0A=
of them.=0A=
=0A=
Fixes: f761fcdd289d ("exfat: Implement sops->shutdown and ioctl")=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 fs/exfat/file.c | 29 +++++++++++++++++++++++++++--=0A=
 1 file changed, 27 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/fs/exfat/file.c b/fs/exfat/file.c=0A=
index 807349d8ea05..841a5b18e3df 100644=0A=
--- a/fs/exfat/file.c=0A=
+++ b/fs/exfat/file.c=0A=
@@ -582,6 +582,9 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb=
, struct iov_iter *iter)=0A=
 	loff_t pos =3D iocb->ki_pos;=0A=
 	loff_t valid_size;=0A=
 =0A=
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))=0A=
+		return -EIO;=0A=
+=0A=
 	inode_lock(inode);=0A=
 =0A=
 	valid_size =3D ei->valid_size;=0A=
@@ -635,6 +638,16 @@ static ssize_t exfat_file_write_iter(struct kiocb *ioc=
b, struct iov_iter *iter)=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *i=
ter)=0A=
+{=0A=
+	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
+=0A=
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))=0A=
+		return -EIO;=0A=
+=0A=
+	return generic_file_read_iter(iocb, iter);=0A=
+}=0A=
+=0A=
 static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)=0A=
 {=0A=
 	int err;=0A=
@@ -672,14 +685,26 @@ static const struct vm_operations_struct exfat_file_v=
m_ops =3D {=0A=
 =0A=
 static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)=
=0A=
 {=0A=
+	if (unlikely(exfat_forced_shutdown(file_inode(file)->i_sb)))=0A=
+		return -EIO;=0A=
+=0A=
 	file_accessed(file);=0A=
 	vma->vm_ops =3D &exfat_file_vm_ops;=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static ssize_t exfat_splice_read(struct file *in, loff_t *ppos,=0A=
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags)=0A=
+{=0A=
+	if (unlikely(exfat_forced_shutdown(file_inode(in)->i_sb)))=0A=
+		return -EIO;=0A=
+=0A=
+	return filemap_splice_read(in, ppos, pipe, len, flags);=0A=
+}=0A=
+=0A=
 const struct file_operations exfat_file_operations =3D {=0A=
 	.llseek		=3D generic_file_llseek,=0A=
-	.read_iter	=3D generic_file_read_iter,=0A=
+	.read_iter	=3D exfat_file_read_iter,=0A=
 	.write_iter	=3D exfat_file_write_iter,=0A=
 	.unlocked_ioctl =3D exfat_ioctl,=0A=
 #ifdef CONFIG_COMPAT=0A=
@@ -687,7 +712,7 @@ const struct file_operations exfat_file_operations =3D =
{=0A=
 #endif=0A=
 	.mmap		=3D exfat_file_mmap,=0A=
 	.fsync		=3D exfat_file_fsync,=0A=
-	.splice_read	=3D filemap_splice_read,=0A=
+	.splice_read	=3D exfat_splice_read,=0A=
 	.splice_write	=3D iter_file_splice_write,=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=

