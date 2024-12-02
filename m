Return-Path: <linux-fsdevel+bounces-36219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0592C9DF8A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 03:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D897B21380
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 02:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338D1F949;
	Mon,  2 Dec 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="EYbBUHRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A418C31;
	Mon,  2 Dec 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733104807; cv=fail; b=ZWhnB6QJBrI8ieqyp6iyHiCn0Af5ejEJf7FL4mhLNRyftjoYPOkvr2JUCEOOS8BnqdnNMXQFHt5RejVWqUmrNHSjngt+IEdoW/wPHWAPLvJ/mgQ8S44N6vCWqVwB7KcNT99ZZY/oKXMY+/NQ/3R0SVsju2v67Szjc5TCStJpRXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733104807; c=relaxed/simple;
	bh=grkhvcnBdNSmSMtfv5Es69njuVJAeLoUr/mxBs8iMAg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NqJV32lfWsZnCqRCeOFLS7iLVT+e7Gpqnc/0Sfby6Bjz7Xhp2NGx4ISEoeiSOGFwFu4+RBZ18osBSw9wVq5cyYdJC8ZS0wrYxWxf0ix16DKRxiQVZzDuKYXCJ6J0ac40wxcYqGjiRAdq5YFKxVM6DHWVmEPZxNAkgj48OsYCihQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=EYbBUHRq; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B21jMFS005768;
	Mon, 2 Dec 2024 01:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=hb51cFA/jwfsbxFobZMpEvi1FxWwX7g
	j0BWNyzKXxSM=; b=EYbBUHRqjTgpPKjzJqpZfzB2Uyj+ShVhYxHNxDvUbi1jgxy
	jS/o6GBd+IXzusjXrWpvjpSqrM1ot2KHaX2/V+suVCwtFpdUNcKN3WrgeRya40JA
	F/0CR+VzhmaCf0AqOM8tjh+1WL86QY5Dkwq8ELHmWvXJ6kcDFDziV0493GT6Euh8
	UFrJoZ7yUdlmQcetbwuO/EMi0ekie2+gEDp62L1/3PWwUB/bbVzuCUCd+EcWDEIz
	RA5rIPtQJchynQlIcBthH2kZgZq0miYOL9rvltj+EOJrwbg/pzk6SetH6I6WSAiK
	vY+Kpj5LDhNGTqcQM9J5QgowRzbiCpfzq0lS/SA==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2045.outbound.protection.outlook.com [104.47.26.45])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 437qxw18n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 01:59:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6v8rHIGNbw2FzYNxKYsKCm2Jyi3TC/R0xe/h9eWPg7QkFcKGbHQZgdMLoFtps7ACPXwo+UyR0IlJnK3k+MiNNphSQiMeQSdnC5v8mc1D1eiQyAQHqNulzY4mmokwt9BlCIIEUesbV8IRpirAh/+qqvm62CRZoekhkxxNrJYyEAr6kPgUvDElVjmycX2T6GQ6YFVZkDqA0SQwut/rr65uno7DsyAUgQvZ+vhnnuw3uJHsThjPIiZSdtipgjFblOM5TlP2rTRztb+85mBcHOQqX2+XMmI9N3F4613dTzUMsrDcUp2DrbQPDh6/YRWr6vS9ABTRSEAj4Hd/dYiO/c//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hb51cFA/jwfsbxFobZMpEvi1FxWwX7gj0BWNyzKXxSM=;
 b=Q4G6PDKUND7AWj6CXjFm1IbwuaYsCmMCsUld7eqcre99jEx4dTDaimZb5yAnme77eZSH+jU8QdUpMgQeB2u8fe4YsT82bVb8+cAM6ziKVBfl2KMAX2/1ioAoaUZKr1aUcEcZSPJjXnZpW7/mZtHEmm/PeA3ridzU0OROtcrNY94tSzzhFFcu2URU0wG+xw9DVkJfo8UU3O5achVnzQa4as3nSPrdUlu35J6T2Pziy+hmFbJMX0YFqfxiLpAZcnWisQnDJLvfrUmcchTRVtls2ua9icukbFwo7bVLLPmxRVYVjeX94eUYvu+2MpnLJRS9d6SOVZxH7o+jjMG1JbsN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEYPR04MB6457.apcprd04.prod.outlook.com (2603:1096:101:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 01:59:27 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%4]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 01:59:27 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: syzbot <syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [exfat?] general protection fault in
 exfat_init_ext_entry
Thread-Topic: [syzbot] [exfat?] general protection fault in
 exfat_init_ext_entry
Thread-Index: AQHbREVEo63qIhNfD0+hb+1WJPqW8LLSMqmt
Date: Mon, 2 Dec 2024 01:59:27 +0000
Message-ID:
 <PUZPR04MB6316B2F01962538FF5C00B0C81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <674ceb41.050a0220.48a03.0018.GAE@google.com>
In-Reply-To: <674ceb41.050a0220.48a03.0018.GAE@google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEYPR04MB6457:EE_
x-ms-office365-filtering-correlation-id: 5b6a7d2a-9498-4094-b2be-08dd1274f413
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gjxkUrtkMTMnZmYLiUx24jv5cnQN5Y56vcTH9m9/wHrGluZq7JY5TEaFDJ?=
 =?iso-8859-1?Q?4+5jE/xwRIetz4MGKHjlsMiWTKri/vODfRUVmQwdux/IQHb3Dr1BfOScwz?=
 =?iso-8859-1?Q?vKEDmZmleVSSJ2aBUWJSdix96IJVjf7LmwXf3fvCcN7XDXMPud5loPff9+?=
 =?iso-8859-1?Q?jPd6zWGZpc/o8dUyZeWbqb0r+mrXWqBzRNkaMUPyYtpY0SGbEEmJRQ+RX3?=
 =?iso-8859-1?Q?4lIS0LenrwmYsPinii46nA14bwQ6krr18AdJdJaXKC0qNqKHhKXmIaGex5?=
 =?iso-8859-1?Q?Ls2Q447SdFXIw313hoDQXsPYFai3DpSs25sRuBT+btIzqPsiH8HMmo8/eI?=
 =?iso-8859-1?Q?/uA7TeNxlDBwkSWqZMwr37Db0wy3on54jzOaS03syZeS31GfNanZaMISUV?=
 =?iso-8859-1?Q?ZbDVzqqCvFDEQoCNbJAKOsiHlWD9hEaihJKDxIOCJacTWQdohgvfraHWIy?=
 =?iso-8859-1?Q?SlJk7XuF1P/lj0k8a731DbovVahYcfytY2swAw3y8A2WL0WuD2BtfcWDqX?=
 =?iso-8859-1?Q?/5hx1rJpUUFW388qejykat9H6e5oY/4jUjrTxBNi9gw9MQWMT1bFz/Igtj?=
 =?iso-8859-1?Q?gCmjcg5K9iqoCROnTEb4HP+9mVlVCyaITblm8SII2nErbyHrSQUMKbLEkL?=
 =?iso-8859-1?Q?ymn304aPk79OktVCWLjyKDyc3QGs9GyOEtVC/y/Uwi+N65YHoMqRO16wjL?=
 =?iso-8859-1?Q?h0dtnV2Macd0NAlRHvHMfz76LqhJrJLYHNUx3+/yEeYDhVB3fuzNJpLyQP?=
 =?iso-8859-1?Q?uYnJXgsPtSQJz80YfaPuQO+w6bNDqp/dztISEktqtxGH9RqHPChZHDbex7?=
 =?iso-8859-1?Q?NavB1sCB2BTw+GCqUBk7hgyYQ9KLRYRo/X4i3BiNnfXhVzh6pTbVKvmncf?=
 =?iso-8859-1?Q?VkakcMz/uRhxZzn98nDoiJmm8cKxJ9/uGOScTVTobZNGoPixdQWmV3Ub1v?=
 =?iso-8859-1?Q?eWXMvq0o1BQmzz+vkZ1W97m6QDIJZd6S26CquxjD/axQem/jPTlpLG5Kee?=
 =?iso-8859-1?Q?HH4BRk45xN3/dgL9WYIiFCWLZGlUvub+i8OJjpyThsXB8c760jFBYVi1bx?=
 =?iso-8859-1?Q?qePa7cHczxPv23cPGWDWdWZL442+Mdqv1vc7ogoD8ygItbKSr7aKgRBcAK?=
 =?iso-8859-1?Q?Lfb9sTSrhofc4NH9CdCGxJN4z5iAmAe/WtsTHWriGMkBamVKw5ctxJBq84?=
 =?iso-8859-1?Q?ys0yfWvTiXHDXw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Wa2nOEeVWZQjMABq2ZjZnHZBtyYijmW20G8Qvg39KxV5sInLaPO9XiHkhx?=
 =?iso-8859-1?Q?UfOhF2eASaOY2jfq2idsbvF0myQ3e7BK1fqIkUsAuUMLnY/x63meM/DgVt?=
 =?iso-8859-1?Q?5mleV5yVVhIXlQJhEtQcXO7KV1M3TJABSVB/fuBQLgS+xkmh89zLMHKqpd?=
 =?iso-8859-1?Q?P5r2VPNwaWtBmDNt4oZztDx/c3bHEW69K/PbO66OGclXrIAprFlcDQhEsr?=
 =?iso-8859-1?Q?tO4uwpYyHFJcdoeIFcdDzjP/Go6q8Ma26nz5anDymqyh8bHcawyBOSDzEc?=
 =?iso-8859-1?Q?fj+v6QnRKhhv0E3WtFzHP+AXXuac0yKOgmTaRDrPV8Rx9FOMAyHQ4aYtr8?=
 =?iso-8859-1?Q?dhCDRDTaeHArK4IbiUPl0duW+MH4Vx1GmWKv3K36LRD2sENZRCBu2TPbxy?=
 =?iso-8859-1?Q?BqouXEf6P2qwv/Ij4h1o6iZf5DUAiPpDIOBC9ZhzC7CKygXPtsaaYjY7Ce?=
 =?iso-8859-1?Q?BQiKd/eQTzb7F2B6IBUF3wUTKf9GlgXaDFRnzv4d9DLlZYvmqKabVIhmMj?=
 =?iso-8859-1?Q?0t8MvEuaFrAHrbm9mFj+ZZyj2PS+q75UIKkKCv3RswCcEjdKjiM3fJt5x4?=
 =?iso-8859-1?Q?KafAyCztlfHE93SOmh6fCp6qaKg16E18TNX3UwmDuDyelb+l7W7Hm7szmh?=
 =?iso-8859-1?Q?9MyVRaA5tPlEn8kY6QG2p+VctA3DyJv0YtHdZgLCkHbXwNpK+iIGF+9HaL?=
 =?iso-8859-1?Q?ocEQvNBPHBCOyd2Qv94IBJ5yXQy2odvh6D+4U5c1soBNc1XZX5vdA36s8W?=
 =?iso-8859-1?Q?LDGUSHpMTclwwbtagrpPXK3/gHtthcBAvO6NYBfOAZCiVlYi4LnNfCBKhw?=
 =?iso-8859-1?Q?L1Y/7yPyJ1bPcB7fSj6OWTiaA6bMIqGS8l2UGON2fB98Qk+UusoEFaPgdS?=
 =?iso-8859-1?Q?KzTN1fzHFCF4ugzuu6M6F96eZmLOOFT18eOGx3aQJTtOOkSuN9PhzGHiGF?=
 =?iso-8859-1?Q?FPjRPUfk8NZxjfavimHD95DaTmemivcdnrGqn9l/Bois79m8bztEVXdpX5?=
 =?iso-8859-1?Q?86JtAIzhgLK9WoVjD10Qgatz42cAGrcQYu7MabCoK41OuS/613AJacepQQ?=
 =?iso-8859-1?Q?lOA67Fpx3ZyxKcC7BnfDNj7gRJAu60OZdCxCLjBR04BUYSu2nRmRdVTn4A?=
 =?iso-8859-1?Q?Wdj8ejV+8oUO0oPlMyJz4RUCIzVjGWK/SX6WjycQEnpfjQJ1nPppGHGEjb?=
 =?iso-8859-1?Q?N+hN27UjBVdqVme2kHkXVxrCejsJ9IaEAVna0pKo3xFVMvIQGBezLmTiwT?=
 =?iso-8859-1?Q?Q9DZwDVJ30loCjhxdStvWFeTrmJAif3BYz8RmxJq7ouCnyanhHIaM7qP5t?=
 =?iso-8859-1?Q?5+zmGmkOIx1Lzg2hoFY5ZQdK6s5pm27xV8UP03SVy1byTKms7TtI8Jq2Df?=
 =?iso-8859-1?Q?+IyItEXu8ERxbWpX3fQJecYTymva6Amjssbvom6Tode7Hv25krmEyAtaxi?=
 =?iso-8859-1?Q?m+8OZxTGa/UI2o/I0/9RyhhkYrBqIck0WcAvMzPB8hj40u2Y+lDzDnDr/Z?=
 =?iso-8859-1?Q?CcWIs8lhXH/7BaYfwRBCI5mV7nWOp/QffOP01eNJGXSc9ArcV1WHJ7E03z?=
 =?iso-8859-1?Q?drK49NPUN6EM3e+ADu4wYl6bOAhTyzFnxZtV99imVZBoTgJy6Vg9KgwfSr?=
 =?iso-8859-1?Q?JngfSzojEzouIkivNkS5Ti+0Xotb+OqVisyhJvoMZ76vcsvMHFkT5InyJg?=
 =?iso-8859-1?Q?9DXdNHJn4EpCecqMLcI=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PUZPR04MB6316B2F01962538FF5C00B0C81352PUZPR04MB6316apcp_"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TcGz9GRhyIKEcuPfg/zYyLwkW3lFLGMRJWenzlaF4D+fpgkknjhraL7LE7Xm2pVPdJP6lCJZxqKKTfanv3NokJ3t6nU3ayvM2URlK014Efm+VwY0NY38tO6v/66vvX02Si9sQcaE0E6KOS4lrsirgnwCuSRc5X9DafyP7pqIeY8Vx4Z3lFykizAfnZvgx4vQbuwwjL0oW8p3xJ9j/mjEjm59bvkatoIdKvZjLBL95KfgHgVN3wgeUSKqLQHqnvHbhDHxVGZUiW2scWBBgGV5S/2Hj44bGkaiK+Kcpu2AEFSCOjENoc5RsWNt955uiO5rYYb94o+Zpv5tQP/SJx6q7f7z2UlfUBHSzgm1rrjmMV/CyHf4CkaB5hNa3yUBF1V2EKOiPevUsD9rlVeYEbCtgbHsLI5hb/dT9rR3loN6we+APFf7Fwq1klryoZXuKaj/2d1w7nbTo8rRbz/C+bytDEs+ZFjyK701GLq8FLxWs/wEySp0yDQbW3A8DAO6JPLUOxgt2gYd4izv85/pt/5rail6lLbetqLmJvAhHY+XhnLkucuDgjNAuMEwoxSShLT6w/eX4k2lMn40nJywCALaXtu59XLQNZEz1wrMDvhBSwMOAAdJi3IEkoBQKuI7pBKC
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6a7d2a-9498-4094-b2be-08dd1274f413
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 01:59:27.6341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDw8keroHa0lK2kDD8ePsdBG7Z+yoP4kSIeGr59vTjfvJUOPyH4DIy/A2VKhiBHGSnJZugsbqCxWTm2RVeRStQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6457
X-Proofpoint-GUID: jKo9bw7o4c3-kH9VzeQMSXNxlqqxz_8B
X-Proofpoint-ORIG-GUID: jKo9bw7o4c3-kH9VzeQMSXNxlqqxz_8B
X-Sony-Outbound-GUID: jKo9bw7o4c3-kH9VzeQMSXNxlqqxz_8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-01_20,2024-11-28_01,2024-11-22_01

--_002_PUZPR04MB6316B2F01962538FF5C00B0C81352PUZPR04MB6316apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

#syz test=

--_002_PUZPR04MB6316B2F01962538FF5C00B0C81352PUZPR04MB6316apcp_
Content-Type: text/x-patch;
	name="v1-0001-exfat-fix-error-handling-for-exfat_find_empty_ent.patch"
Content-Description:
 v1-0001-exfat-fix-error-handling-for-exfat_find_empty_ent.patch
Content-Disposition: attachment;
	filename="v1-0001-exfat-fix-error-handling-for-exfat_find_empty_ent.patch";
	size=769; creation-date="Mon, 02 Dec 2024 01:58:38 GMT";
	modification-date="Mon, 02 Dec 2024 01:58:38 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjNjdmODA1YzIxNGMwYmU0MjRhYjM3YmVkODg5NzQ2YjkxMDU0NzJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+CkRh
dGU6IE1vbiwgMiBEZWMgMjAyNCAwOTo1MzoxNyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjFdIGV4
ZmF0OiBmaXggZXJyb3IgaGFuZGxpbmcgZm9yIGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnkoKQoKU2ln
bmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPgotLS0KIGZzL2V4
ZmF0L25hbWVpLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9uYW1laS5jCmluZGV4IGNhNjE2
ZjJmMmM4YS4uNDFkNTA5MGIyMzdiIDEwMDY0NAotLS0gYS9mcy9leGZhdC9uYW1laS5jCisrKyBi
L2ZzL2V4ZmF0L25hbWVpLmMKQEAgLTM5NSw2ICszOTUsOSBAQCBzdGF0aWMgaW50IGV4ZmF0X2Zp
bmRfZW1wdHlfZW50cnkoc3RydWN0IGlub2RlICppbm9kZSwKIAkJaW5vZGUtPmlfYmxvY2tzICs9
IHNiaS0+Y2x1c3Rlcl9zaXplID4+IDk7CiAJfQogCisJaWYgKGRlbnRyeSA8IDApCisJCXJldHVy
biBkZW50cnk7CisKIAlwX2Rpci0+ZGlyID0gZXhmYXRfc2VjdG9yX3RvX2NsdXN0ZXIoc2JpLCBl
cy0+YmhbMF0tPmJfYmxvY2tucik7CiAJcF9kaXItPnNpemUgLT0gZGVudHJ5IC8gc2JpLT5kZW50
cmllc19wZXJfY2x1OwogCi0tIAoyLjQzLjAKCg==

--_002_PUZPR04MB6316B2F01962538FF5C00B0C81352PUZPR04MB6316apcp_--

