Return-Path: <linux-fsdevel+bounces-25152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94124949766
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CB01F227CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305DF757F8;
	Tue,  6 Aug 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="2OcOQGFm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="Tfp7tNaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047828DD1;
	Tue,  6 Aug 2024 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968193; cv=fail; b=upza6tph0i3Ffz1WkXKvcZcwu9BZCjT4jneOv81AZFR1WgsvY9zuc7wUjQauSsxGM4dPlX6m/vo2sFStIFYEf+M0HLyFo6K83gZit9mpxX8jvdZ/ZyiBXk3+y/MiMLvs6YJHn94xJ2F/6Ht5whJVmATW5yNHlS+avjEvpYlzG7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968193; c=relaxed/simple;
	bh=Fv5MHucRqaPFSy2AHabe5Zv90sQT9EkLlEH5pCbvL3s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Qur1zFqjpqDFKjVVtrHw3dB8RbMfdYj6k5GOZ6YuBbtQZPtkdRSnQ5BRP6dtAvOkckXwDT5BKQW3M7c7+HAhlr0rQHfZ1eAiyKRVjRZ1Su5i8QTDiNqolmSOqB64h/4Vr+yKgOpHBOE0+FceGxtUotTE/l9xTJAZA9gIS7nr7h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=2OcOQGFm; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=Tfp7tNaY reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108161.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476HM5KO013834;
	Tue, 6 Aug 2024 11:16:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS1017; bh=mGTKIm84tFyM8
	4v3pZ4N/bF9R05k+7q3oK8UgqbbZ98=; b=2OcOQGFmgoSEMLbXsXR4j5ta9kDLm
	6THdtss15eLdQXPaiqjTVaCMz+9s7lgZ8Qy43NTh+K3bxifsxfEdcYcrWt2bjXoe
	TD1UxLuyXS4fn6BkY0v5aKbLyDIyJAPNWKaAQJbOH3MsUdY8k+/lHKl/9PxqvQKY
	Ho5E0v+tQoLAq8eaJi+b4Uu3nfsHMKQ9DHreyu2XRrlHYZJ4MFdB6YWFwMJA+QWu
	BlXcZwoR2eKp58b/4VZMViltEC2fzKSj9p2jlcrWmWunX4woHcSEUNBQQDIOzETe
	5aSLXS1UgBRGNCkzqJjXnv6LblZ/Tcx7oRXNgJywaepWvbmAiAANC7d5w==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 40skntq036-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 11:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds2rKN6rcKR658YgFwq3r5XV1vvpZWNk7ORfpzhHTSiNsPWKwIa4OuQUjZ9MEfN/Y4XV3t5r1VvhSJgCz/jY1v6klcFydyIvECJHDTjy7XMAnaMHz/S9a50/U7pDxZKdEKyMqHZvqm5aZPMJXhLZMxIheuExbGh3M6q5ii1sDFFjiy4xgSeLCwze9vOa6spsKcTLZihuNmOJyS1ZeavzZECiu0eqRiybFQzn6q/DLqTjRAd5jrI62Vi8bOf5ZloXYtk3UIB0KMJXQvk66wq5TTkge2UC9K66z3QNEShIS6yQqMqdeRfydXsoHBt0ChjvJ6JbjuCl52pKdyfq+X9THQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGTKIm84tFyM84v3pZ4N/bF9R05k+7q3oK8UgqbbZ98=;
 b=YcsDrKoIiZMXCbe9vmX2+RkQEYVSO1IYmA45wfQP5UDSkxXdk4Luo2fzMylpQ3Q9I/4OGjTMK844q0rsDZgRjniLyRmRC7dHaowiOnRmhL6E1+LsrBMXDtKATQqnQUIKZ1RJKv9YrFr3GpML0KaJUBb5U/IyJ0yNF54cSObHDkaMSGEQ2xeBcoesyOfcS54k2iRW+isylGLXGgIr02vM5Spfwe6Jet2WixBJnT89Uk9ZMZRJJOvINfU6FBDfmbv6j8xBY9ItsPKFiVovdV8LtAe0Itml2psSvYC3Kj81D+AcrXaHWDlQyRIgJVQcQWHAu+68twY9k1bhf8KCojwyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGTKIm84tFyM84v3pZ4N/bF9R05k+7q3oK8UgqbbZ98=;
 b=Tfp7tNaY2IrkVhceaW5RL6AEzARA4OV5gyHCCjCdK6notXTltzL4GZurhzASG2CGG0ns2bDvpuCX2+J0V58/13h1VCvYPGJ9wrTz+hBMujV7m1hvTI7Jg92VkfH3pp4e8TxlCmfsLKnvjR7cWzKiiigbhbhk15c5uRh0XJJA280=
Received: from BYAPR05MB6743.namprd05.prod.outlook.com (2603:10b6:a03:78::26)
 by MN6PR05MB10826.namprd05.prod.outlook.com (2603:10b6:208:4f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 18:16:02 +0000
Received: from BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf]) by BYAPR05MB6743.namprd05.prod.outlook.com
 ([fe80::12f7:2690:537b:bacf%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 18:16:02 +0000
From: Brian Mak <makb@juniper.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa6Cyx1WRQbgPTh02yjqLwdKd2Cg==
Date: Tue, 6 Aug 2024 18:16:02 +0000
Message-ID: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB6743:EE_|MN6PR05MB10826:EE_
x-ms-office365-filtering-correlation-id: 714f8161-0ad3-466a-0022-08dcb643d470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e3Q1PGb4uR2tAKEhkqfynkAH5PseMAs3rpe76g3On0dbu56J2/whrpSVngDa?=
 =?us-ascii?Q?NA/kzRz2IJu7y5u0YxJR7edzWR53kigxI07Jbgjrn0tI84cWgWcxkNfPi/7h?=
 =?us-ascii?Q?OldjItWz0xPuRZKOqYFwAeT/WWkAXWdxAq0skFY7Fd9gP1xA2+IuYDtcdt6h?=
 =?us-ascii?Q?Ewq3DxNALXaArf4SdzaFsNHDn/jKjWE+FX1YemzEHgnpFzL6YTizMtPBIy9N?=
 =?us-ascii?Q?4fjHSqIsTDGpQE3QLW8Um/PJGUg226+QhuAFBvxiNrunZn7xmph6lqFXGw90?=
 =?us-ascii?Q?sq4cvN+Q9BWXgrDvclU/O8THvW4/waKTCvTSL2W3HyRYMIgRiqgAN94vbjX3?=
 =?us-ascii?Q?wRDgnxLfjL/994I+K0HaXG70hrn5yurF7wPYxqUkz9jvpk3/sCeK4BV/GGQZ?=
 =?us-ascii?Q?divWfXpWBRlynpnu/4HUeo+zGicqoeWrI58Tpt1CC2c8VjYigacq4AcU3Tix?=
 =?us-ascii?Q?rard3T1EodZFbkkc3cZJ/WtR9+nZsb/UToZCs82Yuv5xoMM4MpDfToDVdMXG?=
 =?us-ascii?Q?gyR6YnNOUbDdfSWg84DSN39vPSU0g6t9V0TSy+B008KSWIIsgCZH9JWoaB9m?=
 =?us-ascii?Q?xpslN+osJ1sKGf6D7KJ61Hnfr0dbFKFl+7YI60IFTCjG8PAm8sMQRkJp80zP?=
 =?us-ascii?Q?HXoFHhwIIEUPVdrhSaVXuQDpjVj1JqpNaEKjAKGzWCHbgjlkVGn/TSo37hJ/?=
 =?us-ascii?Q?mQv/QkC7FxngCYrEPZhev3EWj8hEqotUULeHTRPM8C8XX4od50UryKAGQHoO?=
 =?us-ascii?Q?nSKhCsLtu9KKAVkZ+5zS1S1u2SQnuDFH1ozGvQGHFvRBidKqli01iSFjLR9P?=
 =?us-ascii?Q?/kZ1YAj4s443x17Jv/84gVr2j8LEczRxG727S4jYLj4pCxsj4BvStxFHZhgz?=
 =?us-ascii?Q?jFow+kvmMV1y51m6pfOPl8Z6f8/mbg5GirjAA2da0PZZgU/ZLfVK2/3DeSXW?=
 =?us-ascii?Q?ifKOFl8AfGtN4HEkEwefWpCyz/h8aEGmQRPiB9ydrjAfsexd+UwECRGri9ht?=
 =?us-ascii?Q?sW309apWT09Sw3DO4WF1mGUwoKnwMsTNc9H56qvT7fLublmagAhIPH/guc5g?=
 =?us-ascii?Q?J+akJBwt8slO1+OKAD1rSkeXPbfe40ChCgEcXIWJJd3LskD8L9s1hXYtAq4C?=
 =?us-ascii?Q?qq2E4U5/Blz/LfsP7R4KadAUngW5fjhp6BYftpOq01ULiRoIv3z6O7pdK+J3?=
 =?us-ascii?Q?0Vk6d4ziD7Du+rcGRveA+J51oF+tvP3wJ8FGEckAZO/Rv524bdv14bIjoFHC?=
 =?us-ascii?Q?QZHPdlWFcJ6q32YEvbdYzQ9AO32QjmIvgR9jf/FPQawnBXBhplKTgPZXM8bf?=
 =?us-ascii?Q?WFKXu36drif94jnMVnqIChVBNZV6RU4v3JdZKxrrA2aaQRbkUjkpbRWSB/X4?=
 =?us-ascii?Q?xAou37CV5eBE4i1c6uSXhBZ0C0OHylwYePezuEKznVnYWd6bfQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6743.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Mp0zAGZjUr5lvoKFyVDcXx9m5globL0pqD/hhB1mSNCq8Qyf0BEKrFOKACO/?=
 =?us-ascii?Q?YPRMty/I2eidUC51pBuO2JjmBKzeYrEwiczhwZhZcOlyRCm27ZvdtHJOU5AH?=
 =?us-ascii?Q?E/420KB9W2DLOfrUW4PZJqnMs7szuO26SPfiu+v0FSHYye/TdZZ4rkXKb2Ud?=
 =?us-ascii?Q?o8MYVecmWGBqtpQZGGOJ+iHw4HdULck4+ZvsPpZug0+IGTMbf4WxQqODhteO?=
 =?us-ascii?Q?wOAuiHaX19UKlAts3eZe3XtRjJqAHHMu/lEEUJwG53Tr1Vw4EkBcIUvxIOZw?=
 =?us-ascii?Q?rY7dIU8rI5bVzAkTbyXdiX7pILrRaAclY94Ry/QusY1yDbsY0a9e3nd681Ce?=
 =?us-ascii?Q?lyd0ExA/Izk03Q/jYbr+fq3+HHma3q9dLDnP/+6ux/x14Ykg2lTky8Vfu9VE?=
 =?us-ascii?Q?Y67uPj2dTTGmkG6vxivo67KrruyuxEXQzdxXV9npBgTJBE47VXcEFX7T8VD9?=
 =?us-ascii?Q?177LvFZ73YAGQhKy68Zt1DEmART7oseyChnNP0+XiBgAREQZidUlDs8nIn9t?=
 =?us-ascii?Q?9884q8Cj11iIGm/Drm/p6l+WbwH6FmrDryi3T9B5WA4oATy8DVa8ET1l/LZ/?=
 =?us-ascii?Q?GJRAYBx5Ds9+GVzKfnbghna1hwLdLe3U+7W4CWWtg+2b2WFUnTY6cEaBlOuH?=
 =?us-ascii?Q?W+qFaND2qDvCkV7Cdw/SKouJV5elgOnEnK07bNxEzXZgbjoA6l0hlq6wzUWa?=
 =?us-ascii?Q?2uYBO9DLspIUzTV/dkSoKSvpE3PrHxK677F6W01iVrpXwcqY3QmqWkMB3cFU?=
 =?us-ascii?Q?N5MzogMMcKOlS/ArgSzuzV2My5uz5rqBKlafh/2nL6167YL4aQNssf+VPo/V?=
 =?us-ascii?Q?bUg8oti97S71ugY+lbV/Rdb0k8/I3Mqs3cne8p3P4JYG/wGV+xyI6PoGJnL1?=
 =?us-ascii?Q?GD6K0l3e6nOxN4TT1Ob3Qn85suxlnrQeqJlUrlQAOzd1X6r1BT3qQCK2g9mg?=
 =?us-ascii?Q?nMhgg3nOV4j4myYsue8/zma/sILkGT0joyIMQs/Njy0mDX1bTSvzep/ltBEb?=
 =?us-ascii?Q?ZL33uCjThyPbRig8NqxHIZtw8PDLEMSzwyerfbIqiiTddBMl0Z+snChHBGZo?=
 =?us-ascii?Q?/alKhZlw3aJ7B7Qw+LkMyO1gdFKLF9w1qz9/hmuRW4IYjKhX2zAf5LSKGNdC?=
 =?us-ascii?Q?q9nW4rT955XGXPfQ5J3L+Fqi6efv47zE6hwCxWS6S0lEVHVAPNLmsQbJ9Ukf?=
 =?us-ascii?Q?OdlbHd/2DA22jOWW6E5QD3vuqHBrL+qs2TTqagLiZgAkirp7Eon4P68qeH/o?=
 =?us-ascii?Q?oTkHw/X6HOHPyMbPU8QkkvkwPnGDjJT731hDLOVqKjvXONm33+ambh6Z587L?=
 =?us-ascii?Q?Gci1036lXyiZcZO4yqNVt+PLp0nlr2fJkD4LdhAJuP+lzEgJ7l5xBmQFNZBG?=
 =?us-ascii?Q?6w/1NkuVVc3JHZ0AO0JETvmaXtvrq9MC986LnkdW+FrBVOSiFbZUzHEBhZEF?=
 =?us-ascii?Q?cdBp4SxTtdL5wyRV0oPt68nyeQc13T0/qO319aqj94js0Xg1nclG7BOHkHpZ?=
 =?us-ascii?Q?ijBH9icCAUfqIe8YEMRS1Sk4U93a7jnuzkxygU1qcvkdrOPDWvqw+boNQoca?=
 =?us-ascii?Q?cUONt8vMb8T1uhFNLQDb43feEN5KsdZpAikV+eLZ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <917E6BF13970B649A77CFBCA892A0FC4@namprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 714f8161-0ad3-466a-0022-08dcb643d470
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 18:16:02.2558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfegQqhYQPE6CEuiXGT+xZ3jKwLtlVQeWgm9uB12n0wfBwphGoj2TV6lCoIybgSYa1rIw4AUuh8cNHVE0zrlCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR05MB10826
X-Proofpoint-ORIG-GUID: 0xUgFdy3Uz1hOXJTbpNo6dIzrWjmYvl-
X-Proofpoint-GUID: 0xUgFdy3Uz1hOXJTbpNo6dIzrWjmYvl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_14,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060129

Large cores may be truncated in some scenarios, such as with daemons
with stop timeouts that are not large enough or lack of disk space. This
impacts debuggability with large core dumps since critical information
necessary to form a usable backtrace, such as stacks and shared library
information, are omitted.

We attempted to figure out which VMAs are needed to create a useful
backtrace, and it turned out to be a non-trivial problem. Instead, we
try simply sorting the VMAs by size, which has the intended effect.

By sorting VMAs by dump size and dumping in that order, we have a
simple, yet effective heuristic.

Signed-off-by: Brian Mak <makb@juniper.net>
---

Hi all,

Still need to run rr tests on this, per Kees Cook's suggestion, will
update back once done. GDB and readelf show that this patch works
without issue though.

Thanks,
Brian Mak

v3: Edited commit message to better convey alternative solution as
    non-trivial

    Moved sorting logic to fs/coredump.c to make it in place

    Above edits suggested by Eric Biederman <ebiederm@xmission.com>

v2: Edited commit message to include more reasoning for sorting VMAs
   =20
    Removed conditional VMA sorting with debugfs knob
   =20
    Above edits suggested by Eric Biederman <ebiederm@xmission.com>

 fs/coredump.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7f12ff6ad1d3..33c5ac53ab31 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -18,6 +18,7 @@
 #include <linux/personality.h>
 #include <linux/binfmts.h>
 #include <linux/coredump.h>
+#include <linux/sort.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
@@ -1191,6 +1192,18 @@ static void free_vma_snapshot(struct coredump_params=
 *cprm)
 	}
 }
=20
+static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma_meta=
_rhs_ptr)
+{
+	const struct core_vma_metadata *vma_meta_lhs =3D vma_meta_lhs_ptr;
+	const struct core_vma_metadata *vma_meta_rhs =3D vma_meta_rhs_ptr;
+
+	if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
+		return -1;
+	if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
+		return 1;
+	return 0;
+}
+
 /*
  * Under the mmap_lock, take a snapshot of relevant information about the =
task's
  * VMAs.
@@ -1253,5 +1266,8 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		cprm->vma_data_size +=3D m->dump_size;
 	}
=20
+	sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
+		cmp_vma_size, NULL);
+
 	return true;
 }

base-commit: eb5e56d1491297e0881c95824e2050b7c205f0d4
--=20
2.25.1


