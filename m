Return-Path: <linux-fsdevel+bounces-24895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E0E9462B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 19:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FAC1C215C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDDC136344;
	Fri,  2 Aug 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="ITPNldFm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="FRNQ/Gxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905321AE02E;
	Fri,  2 Aug 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620830; cv=fail; b=NbP0tcBTXnsGNYvgpPBnWE31ldunV3xMGZLRulN55WqR6LtQeo/tFwPjcHtVN843SEYk/RrLBh3pk2ZRULJwu+15Gl3ebEhwOHOalI/J0/4PP8+dfnf48MAJNdGCZNS5/gn1hDZ27HQtBc/Dub+2nY1/L1p4t495eZYO9mPZyMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620830; c=relaxed/simple;
	bh=N16vighlsk/BHsnZ81c+Tz18bJ/ZOZCr6TGLwj23Mxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ISdMaIbGUdc567JSMdnG9MYJR32spp4N8I5tFO5uRez9fZjy5lMP1ACrKFkypmctIRJSsvvMdyOnI1B7ZQHqmp5B7QXRHXCL7EJwLpVI0sCbmLV9k4X46ckfGDCrC1YsHVqdFI941ZeDiEMEQAbP8ylYAo8+NLxuYWNS6pR8PDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=ITPNldFm; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=FRNQ/Gxg reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108163.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472AbO7x028422;
	Fri, 2 Aug 2024 10:46:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=ombVgKo25z79oMVjNDNM37lNdjQMNNqYX+GVWimDW3Y=; b=ITPN
	ldFm35XPCKETwLC8BBSYnIuD+geD08vlBFgaBS2WFfUGnQFYojyf3DKLZrxKcxUR
	QiC8+BqbzCmSCD2HXSKah4zFSPGmiEFUQFukY/IUXnKBR4dqOzzWAWe9T0vA5QIA
	Nt65nz1eCcX+k8ULwQ0R2c57tZafHfk6BfrwrWwXx55gbdlafRkQ+jDx00K68W75
	Ofv+3/Zs7t2p/ssu7pC6x708rtayJfPU3bppFCWvzi8iukpZVTtNnr3fkkoljdDZ
	l2DNGtnTGlLQXsUuAQQO9xgT5NB+gCh0j1MjAdduqBnlHT4h6way9hEAZJ1MHu41
	5JNbcICyaoWhRjJPLw==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 40rjd8k6ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 10:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXNruORQkodkXrOC6YoDTAcnAewNHpBTw/RSy3qO51Wa/zH0DZZNHXQFj17ceRNTTGxncYvmw8ZTwECniamASO3s60+whZo9XPqCFqMIVFo0vpJDVT4cC7XABECQ2W7Z3+VTubajz4Q3GUszLAm3sAk7yGfv6JT/fSivYZ2SevWP3LsWPeTIR3GHyTY8C+YwDKZXoNihjQ4Kr9hr/+w4M7hUGVtb2/eTb9UgEdhbVrRp1OfrDlV2UgAjUQfB6n1yCCIPxQKt56qk1zizDErw9tiQ4dyGg9dcTMJ0IYOurzGprYJ1t9DPZejFAIvaud+o67RicJQ5E33yUL9GYUB2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ombVgKo25z79oMVjNDNM37lNdjQMNNqYX+GVWimDW3Y=;
 b=Umb5FNIZa5l8uJyijpxbOHgK89kGML6Q+zBPyTDBUs7lQ6kM2MlxO6uYcvJqNgGxuCozGa5Do8cQ5P1I+x90yqiDR69NgrB7keTCYHg1nV4c4/ZpocOdo9UVL9D+DYA6pRWmwGDAyjdhn3pGOdnoW7s6cNGvu4ie+Y4wHsKWjmeftDVrvj9Kmon+Cz2W/WxmhuIYtGJhENLcI1SSUArfCwGkA48ONqLr4gbMy29UrgIF7ufOvFFKolcPbLDVWObZg1BZRlEFD4eeBWoghp+HfiEGpftKJxctXLKQj34XQC/d6Z8VbYy9W6263f41iwLSWyjyksEXIDiV/KPPHnbh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ombVgKo25z79oMVjNDNM37lNdjQMNNqYX+GVWimDW3Y=;
 b=FRNQ/Gxg9v4D7VLULw7EVAEjRnWTTl4zBlyMkWB205uW+7cr6+M1YbgXAh/MYniwwPp9mwqvEAsyiIz/Mg1UF060TqGnryNUOwf5STYI960ii+ZQ6CByn2uM3FLVNCSDAb0JBm8jcVcbX4oVelkS0YDMfvFl/TDGcQ2gW0gQTo4=
Received: from SN6PR05MB6752.namprd05.prod.outlook.com (2603:10b6:805:bc::31)
 by BY3PR05MB8435.namprd05.prod.outlook.com (2603:10b6:a03:3c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Fri, 2 Aug
 2024 17:46:37 +0000
Received: from SN6PR05MB6752.namprd05.prod.outlook.com
 ([fe80::919:cd1e:18d2:5bd2]) by SN6PR05MB6752.namprd05.prod.outlook.com
 ([fe80::919:cd1e:18d2:5bd2%5]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 17:46:37 +0000
From: Brian Mak <makb@juniper.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Topic: [RFC PATCH] binfmt_elf: Dump smaller VMAs first in ELF cores
Thread-Index: AQHa45b60I7pFn286ESFEzPKiZWp67IRtKgWgAD81YCAAXYe14AAGQOA
Date: Fri, 2 Aug 2024 17:46:37 +0000
Message-ID: <565A7C1E-A521-44C1-8192-C1735100AD56@juniper.net>
References: <CB8195AE-518D-44C9-9841-B2694A5C4002@juniper.net>
 <877cd1ymy0.fsf@email.froward.int.ebiederm.org>
 <4B7D9FBE-2657-45DB-9702-F3E056CE6CFD@juniper.net>
 <87h6c2x5ma.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87h6c2x5ma.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB6752:EE_|BY3PR05MB8435:EE_
x-ms-office365-filtering-correlation-id: 62168dec-209d-488e-7e4a-08dcb31b0ed0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0X1uvj5EwvYftmMTVSisemMm5JkI4p0GndUMoFH8z7Iofz3OcAaVLWHKw3GG?=
 =?us-ascii?Q?DTkIQb+uVCMrja78kkQaeufGkP9OiwwiePD+ZCFRMsUvbfqW+2NrAxUakq00?=
 =?us-ascii?Q?T2B9MpQwv75p/eGYhaSDm+E2+eWeQmF4XtCJyJ+SKIKDAXlkSWXjVHweE4R3?=
 =?us-ascii?Q?W4KMxi/fNHp+UWGos/obsE/m/C3eQxN+JNjCQYrO0DFfvmcusSkV9UXEidtU?=
 =?us-ascii?Q?7CBfb2d5q4zdFYcxIj31KdTzowU8BKXH79Kg60v/ekqJX7Ugln43Kf2U+tqm?=
 =?us-ascii?Q?wwbvyqC0t/c4+/syrtcNZPzW4QNx9fgxUZzpepKwsVyS6iCFJ29rQteXd4ZS?=
 =?us-ascii?Q?etXsNMMhE9eGyQF4Ae9aW0D8MzM+k1gQ2K61jRZKIplIN4rDMYZQCAthesog?=
 =?us-ascii?Q?b3ZcFDw5M1uo+W80NLesKBbMIc5KoSoeWFM0p7si8Jcb+2tqx+yfwjSTE0A6?=
 =?us-ascii?Q?9i6XZysdZlH86pzCYs2cxranBnhuscebHXZC96cLWyfSkprOnhU1kjalnN3D?=
 =?us-ascii?Q?WaBFvWN1ATK9EyeI2q1nkgNt1bZtc6D9koVHuB+xxTAqwaU+C/QtutsTZO0h?=
 =?us-ascii?Q?t+KgQrbdiq1HD3xoJIjc9vOuRj+O9vbzx4Usb8UMd6MjEh52W+33JbY47AzV?=
 =?us-ascii?Q?sWBXHfj3Hib3zUJZETIkZiA2avoRuEU3+D3x5JjLfThrcvO9ZnVIblZhuVjr?=
 =?us-ascii?Q?+hAd79bXXsKQirsR4ItSkdPyZifVvb3bnTB1be9fhuhsSEahddaZfAikFTPI?=
 =?us-ascii?Q?XmPaTUfH8y3CI5n4qe0LGv68xQVDFlvw6yS1BWcHKjNwzmQApxte96BXCo65?=
 =?us-ascii?Q?J9yEn08inJPOW6LqEpyNO7dqyprYuTo1gBJp0QWizIrEPwLXpzHA74PzMU1H?=
 =?us-ascii?Q?sTP1hZvetl87xGDnogchk+bacFVdrUn89b1h4TVIcIOfy/U+gI+z321kgh/Q?=
 =?us-ascii?Q?S2zmhNgIklDxXJcJg3nzXf9lhKyEkr+SfdMRoQdcXUzoV56GDrjoalOlm0Xg?=
 =?us-ascii?Q?vTnapWrSUGgIoQju43m45WBU0Br9onWG7RXdqPQzJ1rClIqP1ex/wxzPkFMM?=
 =?us-ascii?Q?Mi0ElkFuKW6fE3jr/e7AmB2LGzFXOOGtxnYY333RuFrOqUznm0Knc1OfUt0L?=
 =?us-ascii?Q?lKRmjkJ7yzlmwO/KGCy1Y1bMBT+UDxW12g24ofIP1pSuzMraiaaeTgrGGVZn?=
 =?us-ascii?Q?DPNEDsGWLXzjzpYXyl52HRna1zhL/s1V3ZP4TX6b2GG0DwEfOX5weAyiKzx3?=
 =?us-ascii?Q?DvEGeKYvBWjXYnjOBzWACDzLcl68uUwKm4QR0c+3sHHcrGhEtFxWz+Xqhvxg?=
 =?us-ascii?Q?Osh6jDtvSWSIB8Ya6+gEds/sIVr+NgW4inScSaXGwsUeGfVBuFTHt5Mnkca6?=
 =?us-ascii?Q?FAQIJMYbq904EDrYQpbm9nuiBYigaBX7fDyE6v8BE0zDHQBazA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR05MB6752.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y6cAct06IOu0YPvTKi9VHfTXfguv88lYBbhJx4ZnnFUUZkSj5VXjOFyMCoRO?=
 =?us-ascii?Q?PimzyLeLcGEcYi1VzPoHacpyi7U/t1Jl6JUK9ZFNTejBOtobLfbRI+pu3XcQ?=
 =?us-ascii?Q?Y5Cyf+p1lWiK4UXd1fO4IBKChcj0tTHzDoXXqRVnuo/U4LnAtStH6wVQdTOz?=
 =?us-ascii?Q?5rcA9j3h56Em84QenlieCMKW06MD1RjnqN1RCjy19YGkgPE5ekpNqadLuNKk?=
 =?us-ascii?Q?uDlQ4FVMeMtz/ipa1hU5vfuhuCGtwPrIcyKWw3D8mnlqGOkcytEdjXO79Aa1?=
 =?us-ascii?Q?9Bft3B+Pl2SckJFjmAkDqs6jVMItzgt0JWhSU9XmVyfpHtnRjRoxOmOikPXt?=
 =?us-ascii?Q?kl/vLJhwqoXN9gY6OiaYF2vGzFbPXbNtgdYu/q7/ivL2pYU1L7m/Drrkb8Hq?=
 =?us-ascii?Q?2gDt5vr6WFRRW3s7644BpqkuX8Q/Nmzn1WNMoD3+GnkyHG5qnc74XlDTtQtS?=
 =?us-ascii?Q?PrryM2A1Ee8UbwAA0+A79eEPGM4BBkl31T8Yiy3Zf2W7z9+KZJETniT5ghRh?=
 =?us-ascii?Q?9sU5W0Gco7Va6i7MnFDIVx3khsSm9SDUg/YU/PRmPnwEZFVNsg2fB1xDtUpH?=
 =?us-ascii?Q?o7dh2Uq2myfHmmPWV/WBlg0wyaoKXhctYcbFHVKb2vRXaGnHBKwZkyOLI5o7?=
 =?us-ascii?Q?JczcYD1F+w+JYNUTcsNXBslRQrvOq0uRwsCnVa95w+0xTS3572Z309An4BU2?=
 =?us-ascii?Q?hCFjTAoOLdUetEl1gZwXHctnxDLtKdhL8LajGRi9lrgp0G8Ls/e0VUvLUs8V?=
 =?us-ascii?Q?0PZIuZ5klnLqCcpPSIgONDKJJFmceiL1qJn4ot5b8TeymCyDdhWx9hXeQENe?=
 =?us-ascii?Q?Q/Thk7QkEYtcCtNKzgCpo4s3FEu59iIJsBq/rlwvpSR5yQYtu4n3BlpmUNe/?=
 =?us-ascii?Q?rn8FDRT/z9jA4s4n8J+SjuXTxbcMHbHKk6aM/MjR/nDsIaF4283oHKaSh4V7?=
 =?us-ascii?Q?/U9CSpxG7Yi8W9rKD/ObX25Ua5zB2+jmvwP0hVtvVcOA//0eFQGWDQSdw5vk?=
 =?us-ascii?Q?fq6Ns5YyCZez43jMiaAPOuOQGoUfdyNPdNzoJUlqs75WpWJNI8pXBiBFcL9T?=
 =?us-ascii?Q?DS7M9iyz6y2mV81jQLcEqz2nzKzOPh2yjCqD1rrh9WHJzAcVTeJMiDNHgaIJ?=
 =?us-ascii?Q?H5uSz0zaWNe9dRA3FsX4GVwa/VAQTDRrZDrpYOHfZBpXYApmRSkYWHr2qxBF?=
 =?us-ascii?Q?imU6PWgQWrcxEek7iV+csT5Yv5NH712FbsfNlvGbaFxLP/l51IgRloX8+6Jd?=
 =?us-ascii?Q?+9XF1lencdT7RlKDV1BzN/x2vqar8x1pRzjUEaRRPxwPHtTFqdfASqq3xpBW?=
 =?us-ascii?Q?saREN3sMekXbhLgDVWlbsSbfBsWlgbp0eJZ/Bh3Vr/jHhOeD5/ELzsC4L0n/?=
 =?us-ascii?Q?pOS8GtO3TEJXFBoLU3zffV4ACFEypfUNxYf2P1+k5x5iQoexSpEZVE5CiDgt?=
 =?us-ascii?Q?Jfy1fd5rZsHu8q0Le9FSztG+wJuAXBH7E69n3N4zZHxUGw8hm56vatlaahRM?=
 =?us-ascii?Q?QbX0BKX0FhFUpwpPGy2I974E1TkNKsSJVxSTHzXUI9MYQGgJk0qHnW+tZkpf?=
 =?us-ascii?Q?MKN3TKKoijJFjQPapFpdomeaUikVyLLfa4gLk3JN?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43845D4144083047BFF673E21078C371@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB6752.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62168dec-209d-488e-7e4a-08dcb31b0ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 17:46:37.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eb89a5mRE90sBzcSUbkERr0mX/TPdS1CTdMfXeMP2aZ/s316zgp+ltdzNbCreCZ/mtisIQDtkalZ7PtT7WMgxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8435
X-Proofpoint-GUID: aJUcd17vSixrcObQPzuwDgP7tpn4fRj8
X-Proofpoint-ORIG-GUID: aJUcd17vSixrcObQPzuwDgP7tpn4fRj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_13,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020122

On Aug 2, 2024, at 9:16 AM, Eric W. Biederman <ebiederm@xmission.com> wrote=
:

> Brian Mak <makb@juniper.net> writes:
>=20
>> On Jul 31, 2024, at 7:52 PM, Eric W. Biederman <ebiederm@xmission.com> w=
rote:
>>=20
>>> Brian Mak <makb@juniper.net> writes:
>>>=20
>>>> Large cores may be truncated in some scenarios, such as daemons with s=
top
>>>> timeouts that are not large enough or lack of disk space. This impacts
>>>> debuggability with large core dumps since critical information necessa=
ry to
>>>> form a usable backtrace, such as stacks and shared library information=
, are
>>>> omitted. We can mitigate the impact of core dump truncation by dumping
>>>> smaller VMAs first, which may be more likely to contain memory for sta=
cks
>>>> and shared library information, thus allowing a usable backtrace to be
>>>> formed.
>>>=20
>>> This sounds theoretical.  Do you happen to have a description of a
>>> motivating case?  A situtation that bit someone and resulted in a core
>>> file that wasn't usable?
>>>=20
>>> A concrete situation would help us imagine what possible caveats there
>>> are with sorting vmas this way.
>>>=20
>>> The most common case I am aware of is distributions setting the core
>>> file size to 0 (ulimit -c 0).
>>=20
>> Hi Eric,
>>=20
>> Thanks for taking the time to reply. We have hit these scenarios before =
in
>> practice where large cores are truncated, resulting in an unusable core.
>>=20
>> At Juniper, we have some daemons that can consume a lot of memory, where
>> upon crash, can result in core dumps of several GBs. While dumping, we'v=
e
>> encountered these two scenarios resulting in a unusable core:
>>=20
>> 1. Disk space is low at the time of core dump, resulting in a truncated
>> core once the disk is full.
>>=20
>> 2. A daemon has a TimeoutStopSec option configured in its systemd unit
>> file, where upon core dumping, could timeout (triggering a SIGKILL) if t=
he
>> core dump is too large and is taking too long to dump.
>>=20
>> In both scenarios, we see that the core file is already several GB, and
>> still does not contain the information necessary to form a backtrace, th=
us
>> creating the need for this change. In the second scenario, we are unable=
 to
>> increase the timeout option due to our recovery time objective
>> requirements.
>>=20
>>> One practical concern with this approach is that I think the ELF
>>> specification says that program headers should be written in memory
>>> order.  So a comment on your testing to see if gdb or rr or any of
>>> the other debuggers that read core dumps cares would be appreciated.
>>=20
>> I've already tested readelf and gdb on core dumps (truncated and whole)
>> with this patch and it is able to read/use these core dumps in these
>> scenarios with a proper backtrace.
>>=20
>>>> We implement this by sorting the VMAs by dump size and dumping in that
>>>> order.
>>>=20
>>> Since your concern is about stacks, and the kernel has information abou=
t
>>> stacks it might be worth using that information explicitly when sorting
>>> vmas, instead of just assuming stacks will be small.
>>=20
>> This was originally the approach that we explored, but ultimately moved
>> away from. We need more than just stacks to form a proper backtrace. I
>> didn't narrow down exactly what it was that we needed because the sortin=
g
>> solution seemed to be cleaner than trying to narrow down each of these
>> pieces that we'd need. At the very least, we need information about shar=
ed
>> libraries (.dynamic, etc.) and stacks, but my testing showed that we nee=
d a
>> third piece sitting in an anonymous R/W VMA, which is the point that I
>> stopped exploring this path. I was having a difficult time narrowing dow=
n
>> what this last piece was.
>>=20
>>> I expect the priorities would look something like jit generated
>>> executable code segments, stacks, and then heap data.
>>>=20
>>> I don't have enough information what is causing your truncated core
>>> dumps, so I can't guess what the actual problem is your are fighting,
>>> so I could be wrong on priorities.
>>>=20
>>> Though I do wonder if this might be a buggy interaction between
>>> core dumps and something like signals, or io_uring.  If it is something
>>> other than a shortage of storage space causing your truncated core
>>> dumps I expect we should first debug why the coredumps are being
>>> truncated rather than proceed directly to working around truncation.
>>=20
>> I don't really see any feasible workarounds that can be done for prevent=
ing
>> truncation of these core dumps. Our truncated cores are also not the res=
ult
>> of any bugs, but rather a limitation.
>=20
> Thanks that clarifies things.
>=20
> From a quality of implementation standpoint I regret that at least some
> pause during coredumping is inevitable.  Ideally I would like to
> minimize that pause, preserve the memory and have a separate kernel
> thread perform the coredumping work.  That in principle would remove the
> need for coredumps to be stop when a SIGKILL is delievered and avoid the
> issue with the systemd timeout.  Plus it would allow systemd to respawn
> the process before the coredump was complete.  Getting there is in no
> sense easy, and it would still leave the problem of not getting
> the whole coredump when you are running out of disk space.

This is actually another approach that we thought about, but decided
against. The fact that it doesn't address running out of disk space is one
thing, but also, if systemd were to respawn the process before the coredump
completes, there would effectively be a doubling of that process' memory
usage. For applications that take up a significant chunk of available
memory on a system, effectively "duplicating" that memory consumption could
result in a system running out of memory.

With this approach, there's two options: to have systemd restart the
process or wait until core dumping is complete to restart. In the first
option, we would be risking system stability for debuggability in
applications with a large memory footprint. In the second option, we would
be back to where we started (either terminate the core dumping or miss
recovery time objectives).

> The explanation of the vma sort is good.  Sorting by size seems to make
> a simple and very effective heuristic.  It would nice if that
> explanation appeared in the change description.
>=20
> From a maintenance perspective it would be very nice to perform the vma
> size sort unconditionally.   Can you remove the knob making the size
> sort conditional?  If someone reports a regression we can add a knob
> making the sort conditional.
>=20
> We are in the middle of the merge window right now but I expect Kees
> could take a simplified patch (aka no knob) after the merge window
> closes and get it into linux-next.  Which should give plenty of time
> to spot any regressions caused by sorting the vmas.

Understood, will get a PATCH v2 sent out with the removal of the knob. I
should note though that the conditional sorting actually gives a second
benefit, which is that in the event there is low available memory,
allocating the sorted_vmas array may fail, allowing for a fallback to
original functionality without any additional memory allocations. However,
in the interest of maintainability, it may be better to just forgo that
benefit.

Thanks for looking this over!

Best,
Brian Mak

> Eric
>=20
>=20
>>=20
>> Please let me know your thoughts!
>>=20
>> Best,
>> Brian Mak
>>=20
>>> Eric
>>>=20
>>>> Signed-off-by: Brian Mak <makb@juniper.net>
>>>> ---
>>>>=20
>>>> Hi all,
>>>>=20
>>>> My initial testing with a program that spawns several threads and allo=
cates heap
>>>> memory shows that this patch does indeed prioritize information such a=
s stacks,
>>>> which is crucial to forming a backtrace and debugging core dumps.
>>>>=20
>>>> Requesting for comments on the following:
>>>>=20
>>>> Are there cases where this might not necessarily prioritize dumping VM=
As
>>>> needed to obtain a usable backtrace?
>>>>=20
>>>> Thanks,
>>>> Brian Mak
>>>>=20
>>>> fs/binfmt_elf.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>> 1 file changed, 62 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>>>> index 19fa49cd9907..d45240b0748d 100644
>>>> --- a/fs/binfmt_elf.c
>>>> +++ b/fs/binfmt_elf.c
>>>> @@ -13,6 +13,7 @@
>>>> #include <linux/module.h>
>>>> #include <linux/kernel.h>
>>>> #include <linux/fs.h>
>>>> +#include <linux/debugfs.h>
>>>> #include <linux/log2.h>
>>>> #include <linux/mm.h>
>>>> #include <linux/mman.h>
>>>> @@ -37,6 +38,7 @@
>>>> #include <linux/elf-randomize.h>
>>>> #include <linux/utsname.h>
>>>> #include <linux/coredump.h>
>>>> +#include <linux/sort.h>
>>>> #include <linux/sched.h>
>>>> #include <linux/sched/coredump.h>
>>>> #include <linux/sched/task_stack.h>
>>>> @@ -1990,6 +1992,22 @@ static void fill_extnum_info(struct elfhdr *elf=
, struct elf_shdr *shdr4extnum,
>>>>     shdr4extnum->sh_info =3D segs;
>>>> }
>>>>=20
>>>> +static int cmp_vma_size(const void *vma_meta_lhs_ptr, const void *vma=
_meta_rhs_ptr)
>>>> +{
>>>> +     const struct core_vma_metadata *vma_meta_lhs =3D *(const struct =
core_vma_metadata **)
>>>> +             vma_meta_lhs_ptr;
>>>> +     const struct core_vma_metadata *vma_meta_rhs =3D *(const struct =
core_vma_metadata **)
>>>> +             vma_meta_rhs_ptr;
>>>> +
>>>> +     if (vma_meta_lhs->dump_size < vma_meta_rhs->dump_size)
>>>> +             return -1;
>>>> +     if (vma_meta_lhs->dump_size > vma_meta_rhs->dump_size)
>>>> +             return 1;
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static bool sort_elf_core_vmas =3D true;
>>>> +
>>>> /*
>>>> * Actual dumper
>>>> *
>>>> @@ -2008,6 +2026,7 @@ static int elf_core_dump(struct coredump_params =
*cprm)
>>>>     struct elf_shdr *shdr4extnum =3D NULL;
>>>>     Elf_Half e_phnum;
>>>>     elf_addr_t e_shoff;
>>>> +     struct core_vma_metadata **sorted_vmas =3D NULL;
>>>>=20
>>>>     /*
>>>>      * The number of segs are recored into ELF header as 16bit value.
>>>> @@ -2071,11 +2090,27 @@ static int elf_core_dump(struct coredump_param=
s *cprm)
>>>>     if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
>>>>             goto end_coredump;
>>>>=20
>>>> +     /* Allocate memory to sort VMAs and sort if needed. */
>>>> +     if (sort_elf_core_vmas)
>>>> +             sorted_vmas =3D kvmalloc_array(cprm->vma_count, sizeof(*=
sorted_vmas), GFP_KERNEL);
>>>> +
>>>> +     if (!ZERO_OR_NULL_PTR(sorted_vmas)) {
>>>> +             for (i =3D 0; i < cprm->vma_count; i++)
>>>> +                     sorted_vmas[i] =3D cprm->vma_meta + i;
>>>> +
>>>> +             sort(sorted_vmas, cprm->vma_count, sizeof(*sorted_vmas),=
 cmp_vma_size, NULL);
>>>> +     }
>>>> +
>>>>     /* Write program headers for segments dump */
>>>>     for (i =3D 0; i < cprm->vma_count; i++) {
>>>> -             struct core_vma_metadata *meta =3D cprm->vma_meta + i;
>>>> +             struct core_vma_metadata *meta;
>>>>             struct elf_phdr phdr;
>>>>=20
>>>> +             if (ZERO_OR_NULL_PTR(sorted_vmas))
>>>> +                     meta =3D cprm->vma_meta + i;
>>>> +             else
>>>> +                     meta =3D sorted_vmas[i];
>>>> +
>>>>             phdr.p_type =3D PT_LOAD;
>>>>             phdr.p_offset =3D offset;
>>>>             phdr.p_vaddr =3D meta->start;
>>>> @@ -2111,7 +2146,12 @@ static int elf_core_dump(struct coredump_params=
 *cprm)
>>>>     dump_skip_to(cprm, dataoff);
>>>>=20
>>>>     for (i =3D 0; i < cprm->vma_count; i++) {
>>>> -             struct core_vma_metadata *meta =3D cprm->vma_meta + i;
>>>> +             struct core_vma_metadata *meta;
>>>> +
>>>> +             if (ZERO_OR_NULL_PTR(sorted_vmas))
>>>> +                     meta =3D cprm->vma_meta + i;
>>>> +             else
>>>> +                     meta =3D sorted_vmas[i];
>>>>=20
>>>>             if (!dump_user_range(cprm, meta->start, meta->dump_size))
>>>>                     goto end_coredump;
>>>> @@ -2128,10 +2168,26 @@ static int elf_core_dump(struct coredump_param=
s *cprm)
>>>> end_coredump:
>>>>     free_note_info(&info);
>>>>     kfree(shdr4extnum);
>>>> +     kvfree(sorted_vmas);
>>>>     kfree(phdr4note);
>>>>     return has_dumped;
>>>> }
>>>>=20
>>>> +#ifdef CONFIG_DEBUG_FS
>>>> +
>>>> +static struct dentry *elf_core_debugfs;
>>>> +
>>>> +static int __init init_elf_core_debugfs(void)
>>>> +{
>>>> +     elf_core_debugfs =3D debugfs_create_dir("elf_core", NULL);
>>>> +     debugfs_create_bool("sort_elf_core_vmas", 0644, elf_core_debugfs=
, &sort_elf_core_vmas);
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +fs_initcall(init_elf_core_debugfs);
>>>> +
>>>> +#endif               /* CONFIG_DEBUG_FS */
>>>> +
>>>> #endif               /* CONFIG_ELF_CORE */
>>>>=20
>>>> static int __init init_elf_binfmt(void)
>>>> @@ -2144,6 +2200,10 @@ static void __exit exit_elf_binfmt(void)
>>>> {
>>>>     /* Remove the COFF and ELF loaders. */
>>>>     unregister_binfmt(&elf_format);
>>>> +
>>>> +#if defined(CONFIG_ELF_CORE) && defined(CONFIG_DEBUG_FS)
>>>> +     debugfs_remove(elf_core_debugfs);
>>>> +#endif
>>>> }
>>>>=20
>>>> core_initcall(init_elf_binfmt);
>>>>=20
>>>> base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d



