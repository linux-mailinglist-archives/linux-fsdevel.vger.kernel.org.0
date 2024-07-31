Return-Path: <linux-fsdevel+bounces-24712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38855943907
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 00:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24591F2350B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 22:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B29816D9A8;
	Wed, 31 Jul 2024 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="FA3YRJav";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="YRnS9tRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86116C86D;
	Wed, 31 Jul 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465359; cv=fail; b=BqbhRVYko+GCChqndplqctRWLmCDR0lvBf1O7aqPRrHGJd2IO1Av0EnJYK3lQgtiCnqgNgsWHijywuADFr1M35bHmX1v5D3vjgasZe6Bosx1q++u3LUU+KyMNIPQ72pIEZ/VM2KpkJ+xOLwDmtxfCJCd2m51dAUXnUGTklzXggk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465359; c=relaxed/simple;
	bh=ma1ebKw1c7G5LLa8DR7fD8peTxkvxIASwEiE/Bt+JPU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=frWiR4P332ZsiEnverJtLqObBXAoOksOxe96Kt0U+taNgl7resvHWoOKHXnzx8cU/jrwungpw00/LUIizjy5WKReVcofBZXInOWixpiA6jIOU1mjfCku9rBAfkP05Cs31U+HRrDwIRoSTEO+qFTnr0LnUzohHIycT4ozvSvMUxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=FA3YRJav; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=YRnS9tRK reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108159.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VE9d93016978;
	Wed, 31 Jul 2024 15:14:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS1017; bh=YflLRIY8DI4aO
	nDtpKIdHMlIeX9xbOo9BxY47Q3hTZc=; b=FA3YRJavQesdmoJjqmh/qOSleM+7z
	ZUXKYDAVheHNps1OPbz7caIwzjroKUpvftByLuIQkZZXtZ6EBqPy1+4ESephvHDO
	7PzwQqRwOR8mLYLCPl5gVcXScmWgBbeCTkcjegtyhJ3WlHQh8I7UXK+rik9FdC0s
	SpOsCvSPBfjkGYVFQA7NU3WkNvZGIIu0if5JmpbNjXzvXfLYtaPB6yOKcG2qeOJJ
	Wmu/U/4ipZ2yX6enLNNpd1lHChsnadSGk4G3id+/5Nx9qXDhgXIOqo2UhyMaDx41
	UIPdEMw3E5WiNZlRJxFISr+dJog7epwjts/sIipAv7AwCLfhaQSafqgsg==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 40mxussq3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 15:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unmyrvE//DFsr5AiOdskbe6iiBzx6aa1aPC8BlHwgWxgyNXpHaJV40JUoKNuzVtUtQV096Kx/Vqm1gDQ4PECFxPFv0Ahc7EXtOFIV3ewVk9ntcn1vQp8OVXB2KIfI9FeSFD8bpzRHanyRQ4371D6f6jHOid8/wv4WNb27kXpBdyWkFBTO+Shk0mi9DSxB9m/GAUlkVM2X9HTskLgidkpQK+y44mFx2zJr1fv+Fomuitzi7oUIpd9SLolIjMZVKbksTOqQX/9ricjItBIHBKOJipluOXT6vTxuQxeAKFpjfBoA53CdQrDF9qp/Rb6iYy+R2fez3R2Glb3cIy7aVbccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YflLRIY8DI4aOnDtpKIdHMlIeX9xbOo9BxY47Q3hTZc=;
 b=vzxDdKe8l72cICbyDOwwbbJP/ATjkKcxMT9eXwLB1QpwP7Pbpzu18dlQjkLhxuqjpQDRKHjtgzOwUtpNvhmTWb7JgbXTvkt1cR12/jx1CtR7Pqr7tFAnkcV0DEP+dBnOD/Pf4lE9vmAMoID/DnD5rZUFaxypJADu69hZJbU44D7VXsMmlSYqnQtW1F9sdbchIbS9UUJm8OU+zOV7VuQXOwCtTmOYBxcCibWcdWCBSHb8KSv1BB/RVKDiXGRAxF2PQBA7MgAXJR3RLswzTnERfg8jDwxih4QEeju8c/mGM2/XDg7+klNZpEap1lEPweMG1+ctDoCdwZstOahVzkbuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YflLRIY8DI4aOnDtpKIdHMlIeX9xbOo9BxY47Q3hTZc=;
 b=YRnS9tRKV0sgOI+A968lcWoQmRu2BLsnhcgaZmI1hKHXf36PFlEsZAusGhMZJhBMzctocdGqjQP00LO6835FePNM7nEt26sNJT+SBkc5zOeQcGdVF25lTIkhAzllNeXvziNiWv0jJcmkyWBe+wK/vSd93Igd7R8YyVgBT8NWBL8=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by SJ2PR05MB10356.namprd05.prod.outlook.com (2603:10b6:a03:557::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 22:14:15 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 22:14:15 +0000
From: Brian Mak <makb@juniper.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman
	<ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa45b6H7qt2DxWIUm3KHixJZvP5w==
Date: Wed, 31 Jul 2024 22:14:15 +0000
Message-ID: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|SJ2PR05MB10356:EE_
x-ms-office365-filtering-correlation-id: eca11b77-1aa5-464d-410f-08dcb1ae1d23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?E6NRzAH+Vop0fauMNDXWcjP1VFJrg63VZ0WFLq2j3dvs9ue5IxnoSMeESvwK?=
 =?us-ascii?Q?kgzgyoTByHPmoevnyNPZ4RQOADFdP1XEwZ8TIAdHzEVChO0FgE6qHCAnTniF?=
 =?us-ascii?Q?QLpYE8JWcbIbOjvOxjKqoFAgQiusDl+ZT9tMlNYJtRcyixG5/lCvWET4YZ+2?=
 =?us-ascii?Q?iIeePylDm3xLu//qcvvpY6owe/04q9FDRVgBHD60vhfU7AEtYPO2KhafJoNU?=
 =?us-ascii?Q?0/d766ipFSwv5zaBHeoxBXSb9F3SirQH/h2ib+3ndscgHazE6kVh7nHMTroj?=
 =?us-ascii?Q?U4/C/SAUwkT8fA8Onldf/WFOzcOdPeIwFmgXWYCS4cA0s0NbAEKZQxTHBgt/?=
 =?us-ascii?Q?920afxzbMPcXNHPIopeTd3jnC/K3vWvims9dCynP3WmQmTAOvp4PaJlQ9SNm?=
 =?us-ascii?Q?rplRXFHplazc5JAyultq/M5UYy1UMSG2thsjPA8aw6x7brZAlKOD5UpxDzcl?=
 =?us-ascii?Q?611Jg0nVzt7znVxWPHBI560ZeXrw/HlJigqJaQfdlzYltsMOHWtMUHl3fTD+?=
 =?us-ascii?Q?sliCTnD3raw00hxxmK4gOMwipK7G76CHKsb0SQDn7hab+S4YjogSC9gWzjJm?=
 =?us-ascii?Q?PttF6Ven3u4W52gikuyzlYx6YQTFNlPl1QiKZk1JC7rsURuThELINCawbPEI?=
 =?us-ascii?Q?PQJILDrhlrPCeFSzIWHTwB/Q2+c89hnolG78mAdV2vbzDGnl+4/ULZxEPvqs?=
 =?us-ascii?Q?evhgJfYD/hVNAofecUMGoTiLNe7ySQomkwE8/pDGF4QSdSi/Mlu008m8ydOa?=
 =?us-ascii?Q?fgiFoCdV6tHSOGrR1ObRfVSMk65qEjmzH7aIQkfdxxXhJm8/of0E9prJ7tXp?=
 =?us-ascii?Q?o5HpE++FofG+3bGonoIvb6hHtRiY8liSN5mng8nz/isWjf//g5Qs6pgiYzZ7?=
 =?us-ascii?Q?iKWCkickQdgWWHnq+HE4BFYE+m15Bq8HgclaUFyF+k1/NyN0NEFpkXyIDeAf?=
 =?us-ascii?Q?E+q2s2cT1p5wZupNTALRk4k/x8CgX1S3zZ9vSnzl09Hb8bSSTKPRiGbR8qsu?=
 =?us-ascii?Q?mN0ImhNdGYB4+G3ousl48d59jxCxrTkPtbtrLj/jLuoyXwVZzmafN0/v2YOI?=
 =?us-ascii?Q?AbHNb8J5hDBw6ieFpS/gIDCwrtZM/sQHgCHKu0KiB5AA2T2sp4V5Nc/0yGD4?=
 =?us-ascii?Q?3hwMoZVp+t662B8JIhtQUmL3MfwLYyEXQjTIDuRpCxXhLtKFkQm1ofltWqiz?=
 =?us-ascii?Q?c5k8fEyA/Z9WB79BOsoMQlgQvec5/uzzmTnoPdfzf2E5iJqYqJdHK5bot/fB?=
 =?us-ascii?Q?WoeLU7hCI3P+c2pjdC6SNICZjbzxbJ5NSVh4M2rideGG5B04QMpI41Q0zaIb?=
 =?us-ascii?Q?Kz5kgllmOGloLooeTkQBkRozzXAxE9Z/OnGHHKJQ5MpQiEkUlNvX4OD9KIk1?=
 =?us-ascii?Q?H1JdOGX8uDLhFlx4GhP6y4wnvaeF9BPBoXwIqBg1gHG+sHanOA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?adEd+BMlz+TJvP1HvXUcOCMc7qh8qM4qXRQUOX+myLis3BBZQ9bRlKSQO7Mn?=
 =?us-ascii?Q?vK3YnbgBK0dUznfxuhpxB1tzdghXqO8s4N48YlJ20z6/r9hlC8UEGHzonIoy?=
 =?us-ascii?Q?DeG5R+YCnysa0SM8rvE0cTD9TYsRCZ8Ui6BLdskqWxucv6KzH+ByoABuJIm9?=
 =?us-ascii?Q?Yb6vm+EofcxnlqutFuzj6fDoF3kQiGHHM5pV479M/PUbzrJjPlsrJl0hK/8e?=
 =?us-ascii?Q?4eBpHpugvfyh4S/WDYnVTe7qOgucU6Nl/Y35wSk3RW2rlzlzg5PTHzBYmoxS?=
 =?us-ascii?Q?FIKiWVf64fiKhhzY6BRDbLAEgSlSf5F5Xd2h/AQksjIn0sntbXrdhFv49wVW?=
 =?us-ascii?Q?wlXC7elJQmg6OTCz4bH3p4786oLPweitWMNC1xFrB8OqgJxXMR5sr4isFIxq?=
 =?us-ascii?Q?4qBe0Yw6u9IHOeKOQmtSF1af0gIuk6yGP9KRCg0lqVb4e6LYWLFcRtix1tfX?=
 =?us-ascii?Q?tq68SFsWaSO3ARE2grhFPiM0s000U0UOf0yKFgTvVUg7wv+OyYgTj8K8EOCs?=
 =?us-ascii?Q?AJ/+3G8O2Vax136MAzha9GaveQACZcyDQaWQ52UFnxvumpw7speLJm0NbJfO?=
 =?us-ascii?Q?632ZSICEBrkBytjRsSE4oblPSqp3TKhq2APxOgMjXjde58UP/VpG6pl/gsY3?=
 =?us-ascii?Q?zzBFDg5utSoBKFssLXxZjMNUaZr15Q2ij8mkxV7/08ArYtCfifYX8PnPKaT5?=
 =?us-ascii?Q?cOdG3mzrWVMyx4VYXDE7w4mmQSfFsZtCF5ooXqpg3jNOnv/mp0o6EalzYoPU?=
 =?us-ascii?Q?ju2eGiGKYlJ0mzbcmYBZoiNCKKPvQv12Rvj4MMqahEVXNVi3dyE+nG/7heq4?=
 =?us-ascii?Q?LXXBZG+yuJHYje5zCBSk+RzioXDk08TkZnFhlmUrDBporh5h2MTohxu/pF21?=
 =?us-ascii?Q?jIj5XBfboE4pE4Dsfse/ahh1yw+KZjbVHB5U06ViLfjcEKpvcI4SMlic7I9H?=
 =?us-ascii?Q?gRFbSbpPlPnz3/5PB3LDZrSbw7ngXlz0nozlOSVdIZdxGVllPkEloZzxgNwt?=
 =?us-ascii?Q?9bNmVchAYF993RwUmsSg5Zni/zoONZ3V16oBtY2HLm1vcXGsjljjMcUnD/Rk?=
 =?us-ascii?Q?VLY6SP376QfkrbMWAWR4H2B9fMpmWevbHcsMJEnI+Q13cz2fNFR2wQGkw62/?=
 =?us-ascii?Q?DqReerBBm8A3J2BlCJVGKsuvqz2ZkpTTu6LnicMLICNcsaAEC8TNW7w1x47L?=
 =?us-ascii?Q?mYqdKzgeWcxymWqsAiWfgkA/TD4v52bHwqZjdl5yxlC9RNwWT4YTmPpXZw6G?=
 =?us-ascii?Q?LaMP/GOfvR7jhxunS6OujGkVxSQgvHMShjk5zanhAN5c+xS6Wa9qmb3/l6d7?=
 =?us-ascii?Q?UfCGjEpwiTYLkhG/a4+sGQZANMOBkNcnZXqikuYUehW3uFrBScMEklq2+xf5?=
 =?us-ascii?Q?zI/Xf7+jrGjx5hz1UZg4OPToHEvNEz9VvFqRMkEMBCnZi7tDQhY+a99K5GBD?=
 =?us-ascii?Q?CqQGvpt27uilWZC8RH6miWiqTCwOqBMcZbunAQVaB1DPPEW7u6MFJYb+fvHy?=
 =?us-ascii?Q?2YUQ8ZP7zn5xeMLyj8IW5H92bnU9t4nH1Fjw5/z9aoLoQTi5MA4DKVMh2+qI?=
 =?us-ascii?Q?B5e00S1B34VIhB/8Z84iXUFnvNjM9XcXC8y7Ty4X?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C62EEFADFD9394895817721668CD1B3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB6743.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca11b77-1aa5-464d-410f-08dcb1ae1d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 22:14:15.0865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjHPvamN6l8U2OKkYXHYju5A8UluCyD/ofQh3GA2r6d5ejCQ0+3GmqdRVk3oJGoJe/ISJ0OJScfQGTWzxUk54Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR05MB10356
X-Proofpoint-ORIG-GUID: vYo-ZZqU-OVkY9aLgfGgBKuVvcMJlDV6
X-Proofpoint-GUID: vYo-ZZqU-OVkY9aLgfGgBKuVvcMJlDV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 spamscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=745 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407310156

Large cores may be truncated in some scenarios, such as daemons with stop
timeouts that are not large enough or lack of disk space. This impacts
debuggability with large core dumps since critical information necessary to
form a usable backtrace, such as stacks and shared library information, are
omitted. We can mitigate the impact of core dump truncation by dumping
smaller VMAs first, which may be more likely to contain memory for stacks
and shared library information, thus allowing a usable backtrace to be
formed.

We implement this by sorting the VMAs by dump size and dumping in that
order.

Signed-off-by: Brian Mak <makb@juniper.net>
---

Hi all,

My initial testing with a program that spawns several threads and allocates=
 heap
memory shows that this patch does indeed prioritize information such as sta=
cks,
which is crucial to forming a backtrace and debugging core dumps.

Requesting for comments on the following:

Are there cases where this might not necessarily prioritize dumping VMAs
needed to obtain a usable backtrace?

Thanks,
Brian Mak

 fs/binfmt_elf.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 19fa49cd9907..d45240b0748d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/debugfs.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -37,6 +38,7 @@
 #include <linux/elf-randomize.h>
 #include <linux/utsname.h>
 #include <linux/coredump.h>
+#include <linux/sort.h>
 #include <linux/sched.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/task_stack.h>
@@ -1990,6 +1992,22 @@ static void fill_extnum_info(struct elfhdr *elf, str=
uct elf_shdr *shdr4extnum,
 	shdr4extnum->sh_info =3D segs;
 }
=20
+static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma_meta=
_rhs_ptr)
+{
+	const struct core_vma_metadata *vma_meta_lhs =3D *(const struct core_vma_=
metadata **)
+		vma_meta_lhs_ptr;
+	const struct core_vma_metadata *vma_meta_rhs =3D *(const struct core_vma_=
metadata **)
+		vma_meta_rhs_ptr;
+
+	if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
+		return -1;
+	if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
+		return 1;
+	return 0;
+}
+
+static bool sort_elf_core_vmas =3D true;
+
 /*
  * Actual dumper
  *
@@ -2008,6 +2026,7 @@ static int elf_core_dump(struct coredump_params *cprm=
)
 	struct elf_shdr *shdr4extnum =3D NULL;
 	Elf_Half e_phnum;
 	elf_addr_t e_shoff;
+	struct core_vma_metadata **sorted_vmas =3D NULL;
=20
 	/*
 	 * The number of segs are recored into ELF header as 16bit value.
@@ -2071,11 +2090,27 @@ static int elf_core_dump(struct coredump_params *cp=
rm)
 	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
 		goto end_coredump;
=20
+	/* Allocate memory to sort VMAs and sort if needed. */
+	if (sort_elf_core_vmas)
+		sorted_vmas =3D kvmalloc_array(cprm->vma_count, sizeof(*sorted_vmas), GF=
P_KERNEL);
+
+	if (!ZERO_OR_NULL_PTR(sorted_vmas)) {
+		for (i =3D 0; i < cprm->vma_count; i++)
+			sorted_vmas[i] =3D cprm->vma_meta + i;
+
+		sort(sorted_vmas, cprm->vma_count, sizeof(*sorted_vmas), cmp_vma_size, N=
ULL);
+	}
+
 	/* Write program headers for segments dump */
 	for (i =3D 0; i < cprm->vma_count; i++) {
-		struct core_vma_metadata *meta =3D cprm->vma_meta + i;
+		struct core_vma_metadata *meta;
 		struct elf_phdr phdr;
=20
+		if (ZERO_OR_NULL_PTR(sorted_vmas))
+			meta =3D cprm->vma_meta + i;
+		else
+			meta =3D sorted_vmas[i];
+
 		phdr.p_type =3D PT_LOAD;
 		phdr.p_offset =3D offset;
 		phdr.p_vaddr =3D meta->start;
@@ -2111,7 +2146,12 @@ static int elf_core_dump(struct coredump_params *cpr=
m)
 	dump_skip_to(cprm, dataoff);
=20
 	for (i =3D 0; i < cprm->vma_count; i++) {
-		struct core_vma_metadata *meta =3D cprm->vma_meta + i;
+		struct core_vma_metadata *meta;
+
+		if (ZERO_OR_NULL_PTR(sorted_vmas))
+			meta =3D cprm->vma_meta + i;
+		else
+			meta =3D sorted_vmas[i];
=20
 		if (!dump_user_range(cprm, meta->start, meta->dump_size))
 			goto end_coredump;
@@ -2128,10 +2168,26 @@ static int elf_core_dump(struct coredump_params *cp=
rm)
 end_coredump:
 	free_note_info(&info);
 	kfree(shdr4extnum);
+	kvfree(sorted_vmas);
 	kfree(phdr4note);
 	return has_dumped;
 }
=20
+#ifdef CONFIG_DEBUG_FS
+
+static struct dentry *elf_core_debugfs;
+
+static int __init init_elf_core_debugfs(void)
+{
+	elf_core_debugfs =3D debugfs_create_dir("elf_core", NULL);
+	debugfs_create_bool("sort_elf_core_vmas", 0644, elf_core_debugfs, &sort_e=
lf_core_vmas);
+	return 0;
+}
+
+fs_initcall(init_elf_core_debugfs);
+
+#endif		/* CONFIG_DEBUG_FS */
+
 #endif		/* CONFIG_ELF_CORE */
=20
 static int __init init_elf_binfmt(void)
@@ -2144,6 +2200,10 @@ static void __exit exit_elf_binfmt(void)
 {
 	/* Remove the COFF and ELF loaders. */
 	unregister_binfmt(&elf_format);
+
+#if defined(CONFIG_ELF_CORE) && defined(CONFIG_DEBUG_FS)
+	debugfs_remove(elf_core_debugfs);
+#endif
 }
=20
 core_initcall(init_elf_binfmt);

base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
--=20
2.25.1


