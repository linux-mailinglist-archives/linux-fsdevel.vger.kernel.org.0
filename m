Return-Path: <linux-fsdevel+bounces-23165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB5927DD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AD528289B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891D4143866;
	Thu,  4 Jul 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CxocVa0u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wJdrj6XR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B5D142E89;
	Thu,  4 Jul 2024 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121346; cv=fail; b=nAfqE7je8oV58pNNRfiQuAci6GgMhZrNliYwu+Ws92Z438Ya6Clnq2DS27f3dBtxKZU+cdTO5sU4hr7YB5WmvXrOvHbs1RkxClcZtCu2tK06BskFSiuIpJ4B+9405vOf8G2NkRYT+9h71KUOGscpMwfZZsRiNqin5HVaJpbSC70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121346; c=relaxed/simple;
	bh=gD6+QGGz788v09yXysLcxkdvARCr7CaQLlXOeOLO02Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vEd7YBjOULwu8teaW/AG1P1Hj+Er1CXhQth/9XpuwF5jKMMrR8TR/eUV37bHPYdX4do72HnYLEG/YO1wgghQPy5AtqAdh1HPBW60UxiqKrBs/mXU2g2W76XcTCa7eICxxAMT/1yETZEvdhXQyGpHSJTOpj92vwjP1jv6wdHW+xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CxocVa0u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wJdrj6XR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DksdJ016723;
	Thu, 4 Jul 2024 19:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=BOKLu0VV9XRJjZGyfhWv/dmlS9mW+vyZ0HQh/5U2tiE=; b=
	CxocVa0uHGAfenbJG9BLVlgzvjTWIlQDla3pwyksvnc/yHzaIKGCSQfs+LZtjz7o
	2MXv8p31M+D/2Zz8fNUW5muv/DVgyR0kXZPm3wdXy+JN9sRL37IXPZ2Z5UyPD/VY
	WbUOk6Du8B50QkLToGAIv9CF/HWZAPHl2nEyTjJyunbV527oAW3tick/OqDNo/9H
	xLiQyc9Z0qDD8TjWiwbFIjt63zHUt2W4IYO9G0hZfyf7AGErWqivBPPSPyzoEsFd
	UbCDjY5uXC2iwWteJX9utDaVeZqEBCo5CVpNm4uwlhkOzfM75NA1EsokohYYJVBa
	FPXriRPmFhhDj+a7q3lAGQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attjr2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464GW1d9024631;
	Thu, 4 Jul 2024 19:28:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb3mu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMF+Uyj203cnvFpdwIfhZwSw/zb7w/dsSf1hVLYuWxgfDBhXV2drI/sGW/rTIAVdVpIDkiG7uAjwyCjy/ufi4uqgpUbAwWiCjK6uEPtSrMjjf7GnpmNVc57MU+QR2uQvvLv971G7xBKLrKSm2Ycnu0DPcuI5b2jArQDaqXEm4wdHw+O4Pxd8HV3fzbTfPjWVmWd6GBQMtMZjlhGaKYT5uJVM68L4BRwI8uAmfoJqphElv41p21YJ/RQbaspkSLTXXoph3FljBO/+eFZzeYzDr3JBnMegLM8xZ4Tdn1xq5sEKKRiUdfJS945oC1qNwJzq5/yJF6/Lp4ReOh5saQvP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOKLu0VV9XRJjZGyfhWv/dmlS9mW+vyZ0HQh/5U2tiE=;
 b=kLBYqwNMyGst5HAXKLyA1JkkaI1fY9bF+9OoABGG+swc4EFTPzRKoWTKAfrO0y23+jsb8zjp8nz5w/3a5BuXFTrPdX6jMGyM//1mtSMPkComVVV/xh5s9T9h79HNA/Fr9ZzbWb8l9og+C5Jk2b1gTQs1kgUiyd+k3GqMbTcd8aiwTKMNgZEaa/ep+Amm64unfi10WMC3aryD2PV0I7HwU4AbG4PotGSS5kvgthTWiW2o4HFUtX+h3nx6mmTDD/a18FygyNWrGcB0vtJhBJI0DYlyU1BIO1sY+j5s+ZaVPKqFP0Ni5Gmp4rQEaQu9Mj146WtD0zM8Gj1Tg7K11p9ahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOKLu0VV9XRJjZGyfhWv/dmlS9mW+vyZ0HQh/5U2tiE=;
 b=wJdrj6XRMvXNFX36gsl4UQwSFJplupa3byycBO7v125/x2IBhrO+w65JxcXvsPw8VuHO9b9bYF3CRFt9MJvIQbiJaKSoPi46tYjQH3JxoXXNrqK34mPF0BJVh2PHNg1LH0+SNRBi7L9IKGXzaSrvB7VK+UX/hBFD9eE/5kg+jtI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:28:27 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 19:28:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 4/7] mm: move internal core VMA manipulation functions to own file
Date: Thu,  4 Jul 2024 20:27:59 +0100
Message-ID: <8622e12013139411ad44eca5813839c34574974e.1720121068.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a77d7e-6f44-485e-eb50-08dc9c5f7a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?t7WvLzxabg2yYUwy+O9jOwXwx2fZzFuPBy8xMCp8La3M24Jc5hxp6vu35mAI?=
 =?us-ascii?Q?4SG82j4xVgYGqzBp8tLzFaDELqoAXan2z2emlTk9YGix8gN/JRnTl2+HIwOR?=
 =?us-ascii?Q?fyiEmeiHT0l73qnR8CcXOn9uBTk8VwBRyXeXg6n9dwI7RhLIEH2cvHJ9x7Ok?=
 =?us-ascii?Q?/VcD982QjgMiizsd6EdXiLhGkS23xHRc78yuZRLUmDz31Rdm6Ygo8KBt/zN6?=
 =?us-ascii?Q?nYazz71xrMncJ8mXdUzoR022D6FdmpI8oaJ+mZm36aUb+X7A1ntCQskN3nGc?=
 =?us-ascii?Q?phB94731YYAW2T04kNFuBFtYsz8LttMxQfOHCMBHLfWtZS51rp9AXVnErDej?=
 =?us-ascii?Q?Un07uGTZgHq+AhHnsl8jON0hNq66oXZ8CSiLwhe1Ii5+NO9M1Q8jvHw1NqvQ?=
 =?us-ascii?Q?SPVI5oIJYwDDGlw5WJ3mf7lZYj36tHatE++C7tK5Jdq2lq/ulrRHBjp7S1s6?=
 =?us-ascii?Q?AySDETzVTcTaxnTgwV+l7z/DCKr+n1yktdAmrQl6MWEqG2wje+Iq7eG43JCJ?=
 =?us-ascii?Q?7HElm0E+YIt9XzXaN2mAIfAlfIaE9v3PLvWPn5f1Xcq8DmfjPwiJTXYyeDvE?=
 =?us-ascii?Q?34HqY80bP2VsW3THOtNs2xmdF4AXp70eBJLBr1Maz2PYEBifCQpGGS4oJSfL?=
 =?us-ascii?Q?FxBTPWLHHfqXvagp9d3pve/fvsUFXcdTbMLnEudrRmB1a3XxaXcRCxszajv0?=
 =?us-ascii?Q?tWKSzJ4QiGGtosIZu5uxziuEWqVfVZ2tMcTVsRiwsuD3PeM06MK43n4Cz+Ve?=
 =?us-ascii?Q?Cs9WTeTNXfOJNIu36XXe0bjTMfiWmGIJ+7DEc/ssw+3TP24VLouX5qCwqXjr?=
 =?us-ascii?Q?/GZvhDjWBwOv2PzxMsx0iJLkhX2T3r0mzIQ9HpblPb4Qau8gajw8x2CRNaWw?=
 =?us-ascii?Q?y4MwbvNaRrsh4s7XlL7vl8o0YdcXh/c5Av27dkWvu7GFowz71jIfP4zU69Hn?=
 =?us-ascii?Q?YNe79xFhrIIuT8cKbbUDdrkb7pRKuP7N+rbb1kd/7bZfRiycFeZ9fGQ2Ks6u?=
 =?us-ascii?Q?O3+GVB4+0vjjq3VMYUPB5abseK2BMkvjAdLebcS0lpJf/8JfaXtiM9Q50kZI?=
 =?us-ascii?Q?VurwXEEVnOzjdczH/WDjiZOK+TbZA1u1+hy136TL0VBPfUuUDfzRalus+bXs?=
 =?us-ascii?Q?m1RkAysGtA2j8dPBLu8MaOEyIl9q8rJ+ej0ynjzewHDk3U+K0fhjl1ImcPhg?=
 =?us-ascii?Q?tVPmTxowfiMVtoFvlVeopSgXZiUV1i/3pMNhtA5RO4DLgGDzQR2DFbTy4PQx?=
 =?us-ascii?Q?MqEtz6iB3ElNf+ZK63ReeBLgXQOOWS0TnJDNTQD7Zd1qxFNs565s6lqcQTN1?=
 =?us-ascii?Q?KtL/FgbFZ1NEF5YeIEs0wt6CNf7VgOMuQFXCxmEx27lRnw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nr8XQfq3fwcOgeEwYnyWHTYTmAu+wm5zLAvWFQ261CH5mFSsyTGqric0oTCz?=
 =?us-ascii?Q?EF7/ind2yelFVWBWxUuu0c/j0S2DNkDHyh7NxV0a+L2hvd6I4VOUy996jOJI?=
 =?us-ascii?Q?/sHcJEujVkWdUdvkAUAIRP69XUbn7WVPdsL54UpOIHBpzPdpfT8KMV+2fxL8?=
 =?us-ascii?Q?GzlKaMkvfVOaFvtdOebQ695vthsX4fj5oUtXW+mSGkyhr4wjA/NjibCdiR58?=
 =?us-ascii?Q?lqqHjTWkF1sCuhFmT8BBQ/bDVyVyWd0Uag1poGBeJ9vI/73hMKLF6ztKV6F4?=
 =?us-ascii?Q?fmJmyUhjP5NqSe4KGs5ziN5p2FTv28ny2pI5hTvrE/z0V+fDqvmxDeZJAwFX?=
 =?us-ascii?Q?KOlpOPGCUJR1/3cgm7PAE+jjgRBVQQ7jMMWu1JzPRvuaHYLzFp8Pt7dgA/5c?=
 =?us-ascii?Q?pYz5BhDCX4+qhi8fh5A+I0alZijTxi4wezOfppezqxZuA6em3Q51MLqB9vU1?=
 =?us-ascii?Q?sPtgVk6OntVsKph3o6nOWkkUrwW62Ng3V6T6fJTbHRqCtKpToGlKVj/JdfUA?=
 =?us-ascii?Q?1YfzJB4vHT+ZPCh6ZIh7qNWjAZ/yFXrvIVcQLjrsw+WFxdHXZiNA0UkAIvff?=
 =?us-ascii?Q?BnM0+MTIX8YcxjJxTx+qTz0DWZgdo56lqEqYbqNoe6wQIxIxkWH2UJpWyZJS?=
 =?us-ascii?Q?BOE3GMIaf8U52xJEb5ZdGz8rGr7iANqn/ucJGD/2FdDKktZaYl6/3BHYZkUr?=
 =?us-ascii?Q?Xku+OptiAUlpmvihoDwtswTqW/aqRHWbYkteirj0GVquuQICvhOJYo06cICs?=
 =?us-ascii?Q?eCiZEMcQzqdxIFZeS+KstIbpywBlI2/d9QdIDBY/nzAJex2vbNGabuCwMorS?=
 =?us-ascii?Q?43R6w/VHoESin5TTmqJvuk0CZmLvhxJmUJfKUnSi4+d3aJgi5IVIxcabx3vb?=
 =?us-ascii?Q?AsDE88QICtlEzqkLU6nHZpzp3dC8A2mLAgYheGKO2D1wXH88SzDdV4fFPRHa?=
 =?us-ascii?Q?5y1n0ElaozlwKP031JVmU48KdXin9fz7oIj2/AT8v3DJlZWIgByh98ZX1odl?=
 =?us-ascii?Q?D8t0Xy1v0l2vMcpPQi1tdomUS1l2r0WdteKoDXd3M7QKAAClPRueEFIN308o?=
 =?us-ascii?Q?yxr0wKxIAC9vmxP5BOvXDcR0qPn23IAPfgto6xbd7VN2m1/0ix6izkjs6PE3?=
 =?us-ascii?Q?IRWG0r+Gz5CVLcpXZ7vhdyuyoIZ3HCwzky66HQ9dPIpw4PFBY2+rV6dYo36m?=
 =?us-ascii?Q?z5KkvFYbBlXjUNBD04UzY5vJgLzcESKd6xaYEABqQ+vOcqOFN0JAq8UQZUsR?=
 =?us-ascii?Q?IRq5k7IgZYgD1DAQKz2elc6p+b14Bfe17/u0d43LKfC/r30kxeQQCqG4lsBn?=
 =?us-ascii?Q?XoArIJe/ycBsV7IeRnM6Oqf5mDvFnap5wln8OLkK9zsKUIrgla+kjFrYLv3L?=
 =?us-ascii?Q?QaY7jq2G8uFOsX4z7lVjDCXMwRJTGvPv49BxeOcuttrc/FBnCtwKv97eb+9p?=
 =?us-ascii?Q?/OxZ/rfdx5m7TEREb5l1AncQsLJB9DNQt05jzHljOhlvy2162gFiyZ+U0puS?=
 =?us-ascii?Q?B56FBMT69juanK6xU6atutsieUgxUqTSotyE6sRDxvyfWpFasJ8wJaKUOphR?=
 =?us-ascii?Q?2zGImNPErAWIEmArL5ij0sDF6UoT4cltwppQIP+1J/tsNXjemsuJIqWAv45p?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Wr0CYcfVFI9diKgb5FGSygm0sgQHt0iTJ/a23lS353rbJenWD2YbqqWURsz/DVFJRRu32xeNbikswXM0/abwuIYCkI5UvtvLys72H3OzUdy576nPeggwAF58AE+7gDfhNpjCRpRissSIkwN5tYCkWNKBZrv5UrniyMtnV0J6xON2SqWHXu9Ie/M0juj5UIO3M6vmVkBWKeKtzrhpgSzt5QHC5875NEE2UjdQi51De09aW81g0xq6ixlyY28zUhpAbZw8iNQs3dM6G9qgE37nb04nxO/SwjAeCvbu0rPxRgeMdCnHVKlW3vq6A4iY5U/F6mn8uMpks1XNpHXa1HajUQldhvc0a8yLu80Klbiyb0B/NmQqhCvJe7fMo5uYYCfh7yNeMI1k0yGhUpkoGCjDChqTvzGqFKGk5sMV/3LbVqGbB/HrSFvPrKjf+6RamSpzXRnApivhR4pO+KYtz74uYog5a0aJ8OCboZYQG62PiJ2KC1qxz5W78k3qMmvsFtdPETflCiesHnR99McqCexPDKOMrJSc1TlsfX80FuyFHpXqEkHZRvYQ9VeAqg6CwvX8LquRNpvYjwL4aN377BTR5bie8WOBS7Ouw8YV+FHSHVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a77d7e-6f44-485e-eb50-08dc9c5f7a8a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 19:28:27.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43zMdEOfFhAZEhyhgDvQDhVThHTCWUdDDY03yK4HersLMtQj/jxi3+4b+EWqWSyYwEYfvKcKX61L3pANjIKd9/tH9upep25X2M5VRHWAfIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040140
X-Proofpoint-GUID: dMvU5yij-R3pAXehMCgo2c28wfp3HWHh
X-Proofpoint-ORIG-GUID: dMvU5yij-R3pAXehMCgo2c28wfp3HWHh

This patch introduces vma.c and moves internal core VMA manipulation
functions to this file from mmap.c.

This allows us to isolate VMA functionality in a single place such that we
can create userspace testing code that invokes this functionality in an
environment where we can implement simple unit tests of core functionality.

This patch ensures that core VMA functionality is explicitly marked as such
by its presence in mm/vma.h.

It also places the header includes required by vma.c in vma_internal.h,
which is simply imported by vma.c. This makes the VMA functionality
testable, as userland testing code can simply stub out functionality
as required.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h |   35 -
 mm/Makefile        |    2 +-
 mm/internal.h      |  236 +-----
 mm/mmap.c          | 1980 +++-----------------------------------------
 mm/mmu_notifier.c  |    2 +
 mm/vma.c           | 1766 +++++++++++++++++++++++++++++++++++++++
 mm/vma.h           |  364 ++++++++
 mm/vma_internal.h  |   52 ++
 8 files changed, 2294 insertions(+), 2143 deletions(-)
 create mode 100644 mm/vma.c
 create mode 100644 mm/vma.h
 create mode 100644 mm/vma_internal.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418aca7e37a6..69bcf48219fa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -998,21 +998,6 @@ static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
 	return mas_prev(&vmi->mas, 0);
 }
 
-static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
-{
-	return vmi->mas.index;
-}
-
-static inline unsigned long vma_iter_end(struct vma_iterator *vmi)
-{
-	return vmi->mas.last + 1;
-}
-static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
-				      unsigned long count)
-{
-	return mas_expected_entries(&vmi->mas, count);
-}
-
 static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
 			unsigned long start, unsigned long end, gfp_t gfp)
 {
@@ -2537,21 +2522,6 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
-bool vma_needs_dirty_tracking(struct vm_area_struct *vma);
-bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
-static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
-{
-	/*
-	 * We want to check manually if we can change individual PTEs writable
-	 * if we can't do that automatically for all PTEs in a mapping. For
-	 * private mappings, that's always the case when we have write
-	 * permissions as we properly have to handle COW.
-	 */
-	if (vma->vm_flags & VM_SHARED)
-		return vma_wants_writenotify(vma, vma->vm_page_prot);
-	return !!(vma->vm_flags & VM_WRITE);
-
-}
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 extern long change_protection(struct mmu_gather *tlb,
@@ -3262,12 +3232,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
-extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
-extern void unlink_file_vma(struct vm_area_struct *);
-extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
-	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
 extern int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 
diff --git a/mm/Makefile b/mm/Makefile
index d2915f8c9dc0..140a22654dde 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -37,7 +37,7 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o
+			   pgtable-generic.o rmap.o vmalloc.o vma.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/internal.h b/mm/internal.h
index a4d0e98ccb97..1159b04e76a3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -8,13 +8,18 @@
 #define __MM_INTERNAL_H
 
 #include <linux/fs.h>
+#include <linux/khugepaged.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/tracepoint-defs.h>
 
+/* Internal core VMA manipulation functions. */
+#include "vma.h"
+
 struct folio_batch;
 
 /*
@@ -778,37 +783,6 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
 	return list_empty(&area->free_list[migratetype]);
 }
 
-/*
- * These three helpers classifies VMAs for virtual memory accounting.
- */
-
-/*
- * Executable code area - executable, not writable, not stack
- */
-static inline bool is_exec_mapping(vm_flags_t flags)
-{
-	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
-}
-
-/*
- * Stack area (including shadow stacks)
- *
- * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
- * do_mmap() forbids all other combinations.
- */
-static inline bool is_stack_mapping(vm_flags_t flags)
-{
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
-}
-
-/*
- * Data area - private, writable, not stack
- */
-static inline bool is_data_mapping(vm_flags_t flags)
-{
-	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
-}
-
 /* mm/util.c */
 struct anon_vma *folio_anon_vma(struct folio *folio);
 
@@ -1237,80 +1211,6 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 	       pmd_t *pmd, bool write);
 
-/*
- * mm/mmap.c
- */
-struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
-					struct vm_area_struct *vma,
-					unsigned long delta);
-
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
-
-/* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
-*vma_modify_flags_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
-
-/* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}
-
-int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	      unsigned long start, unsigned long end, pgoff_t pgoff,
-	      struct vm_area_struct *next);
-int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff);
-
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
@@ -1437,123 +1337,6 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 	return vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte);
 }
 
-static inline void vma_iter_config(struct vma_iterator *vmi,
-		unsigned long index, unsigned long last)
-{
-	__mas_set_range(&vmi->mas, index, last - 1);
-}
-
-static inline void vma_iter_reset(struct vma_iterator *vmi)
-{
-	mas_reset(&vmi->mas);
-}
-
-static inline
-struct vm_area_struct *vma_iter_prev_range_limit(struct vma_iterator *vmi, unsigned long min)
-{
-	return mas_prev_range(&vmi->mas, min);
-}
-
-static inline
-struct vm_area_struct *vma_iter_next_range_limit(struct vma_iterator *vmi, unsigned long max)
-{
-	return mas_next_range(&vmi->mas, max);
-}
-
-static inline int vma_iter_area_lowest(struct vma_iterator *vmi, unsigned long min,
-				       unsigned long max, unsigned long size)
-{
-	return mas_empty_area(&vmi->mas, min, max - 1, size);
-}
-
-static inline int vma_iter_area_highest(struct vma_iterator *vmi, unsigned long min,
-					unsigned long max, unsigned long size)
-{
-	return mas_empty_area_rev(&vmi->mas, min, max - 1, size);
-}
-
-/*
- * VMA Iterator functions shared between nommu and mmap
- */
-static inline int vma_iter_prealloc(struct vma_iterator *vmi,
-		struct vm_area_struct *vma)
-{
-	return mas_preallocate(&vmi->mas, vma, GFP_KERNEL);
-}
-
-static inline void vma_iter_clear(struct vma_iterator *vmi)
-{
-	mas_store_prealloc(&vmi->mas, NULL);
-}
-
-static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
-{
-	return mas_walk(&vmi->mas);
-}
-
-/* Store a VMA with preallocated memory */
-static inline void vma_iter_store(struct vma_iterator *vmi,
-				  struct vm_area_struct *vma)
-{
-
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
-			vmi->mas.index > vma->vm_start)) {
-		pr_warn("%lx > %lx\n store vma %lx-%lx\n into slot %lx-%lx\n",
-			vmi->mas.index, vma->vm_start, vma->vm_start,
-			vma->vm_end, vmi->mas.index, vmi->mas.last);
-	}
-	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
-			vmi->mas.last <  vma->vm_start)) {
-		pr_warn("%lx < %lx\nstore vma %lx-%lx\ninto slot %lx-%lx\n",
-		       vmi->mas.last, vma->vm_start, vma->vm_start, vma->vm_end,
-		       vmi->mas.index, vmi->mas.last);
-	}
-#endif
-
-	if (vmi->mas.status != ma_start &&
-	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
-		vma_iter_invalidate(vmi);
-
-	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_prealloc(&vmi->mas, vma);
-}
-
-static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
-			struct vm_area_struct *vma, gfp_t gfp)
-{
-	if (vmi->mas.status != ma_start &&
-	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
-		vma_iter_invalidate(vmi);
-
-	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
-	mas_store_gfp(&vmi->mas, vma, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
-static inline
-struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
-{
-	return mas_prev_range(&vmi->mas, 0);
-}
-
-/*
- * VMA lock generalization
- */
-struct vma_prepare {
-	struct vm_area_struct *vma;
-	struct vm_area_struct *adj_next;
-	struct file *file;
-	struct address_space *mapping;
-	struct anon_vma *anon_vma;
-	struct vm_area_struct *insert;
-	struct vm_area_struct *remove;
-	struct vm_area_struct *remove2;
-};
-
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
 
@@ -1642,15 +1425,6 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
-struct unlink_vma_file_batch {
-	int count;
-	struct vm_area_struct *vmas[8];
-};
-
-void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
-void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
-void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
-
 /* mremap.c */
 unsigned long move_page_tables(struct vm_area_struct *vma,
 	unsigned long old_addr, struct vm_area_struct *new_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index c1567b8b2a0a..b74d2967cfc0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -76,16 +76,6 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
-
-static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
-{
-	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
-}
-
 /* Update vma->vm_page_prot to reflect vma->vm_flags. */
 void vma_set_page_prot(struct vm_area_struct *vma)
 {
@@ -101,100 +91,6 @@ void vma_set_page_prot(struct vm_area_struct *vma)
 	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
 }
 
-/*
- * Requires inode->i_mapping->i_mmap_rwsem
- */
-static void __remove_shared_vm_struct(struct vm_area_struct *vma,
-				      struct address_space *mapping)
-{
-	if (vma_is_shared_maywrite(vma))
-		mapping_unmap_writable(mapping);
-
-	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_remove(vma, &mapping->i_mmap);
-	flush_dcache_mmap_unlock(mapping);
-}
-
-/*
- * Unlink a file-based vm structure from its interval tree, to hide
- * vma from rmap and vmtruncate before freeing its page tables.
- */
-void unlink_file_vma(struct vm_area_struct *vma)
-{
-	struct file *file = vma->vm_file;
-
-	if (file) {
-		struct address_space *mapping = file->f_mapping;
-		i_mmap_lock_write(mapping);
-		__remove_shared_vm_struct(vma, mapping);
-		i_mmap_unlock_write(mapping);
-	}
-}
-
-void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
-{
-	vb->count = 0;
-}
-
-static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
-{
-	struct address_space *mapping;
-	int i;
-
-	mapping = vb->vmas[0]->vm_file->f_mapping;
-	i_mmap_lock_write(mapping);
-	for (i = 0; i < vb->count; i++) {
-		VM_WARN_ON_ONCE(vb->vmas[i]->vm_file->f_mapping != mapping);
-		__remove_shared_vm_struct(vb->vmas[i], mapping);
-	}
-	i_mmap_unlock_write(mapping);
-
-	unlink_file_vma_batch_init(vb);
-}
-
-void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
-			       struct vm_area_struct *vma)
-{
-	if (vma->vm_file == NULL)
-		return;
-
-	if ((vb->count > 0 && vb->vmas[0]->vm_file != vma->vm_file) ||
-	    vb->count == ARRAY_SIZE(vb->vmas))
-		unlink_file_vma_batch_process(vb);
-
-	vb->vmas[vb->count] = vma;
-	vb->count++;
-}
-
-void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
-{
-	if (vb->count > 0)
-		unlink_file_vma_batch_process(vb);
-}
-
-/*
- * Close a vm structure and free it.
- */
-static void remove_vma(struct vm_area_struct *vma, bool unreachable)
-{
-	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
-	if (vma->vm_file)
-		fput(vma->vm_file);
-	mpol_put(vma_policy(vma));
-	if (unreachable)
-		__vm_area_free(vma);
-	else
-		vm_area_free(vma);
-}
-
-static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
-						    unsigned long min)
-{
-	return mas_prev(&vmi->mas, min);
-}
-
 /*
  * check_brk_limits() - Use platform specific check of range & verify mlock
  * limits.
@@ -300,891 +196,22 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (do_brk_flags(&vmi, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
 
-	mm->brk = brk;
-	if (mm->def_flags & VM_LOCKED)
-		populate = true;
-
-success:
-	mmap_write_unlock(mm);
-success_unlocked:
-	userfaultfd_unmap_complete(mm, &uf);
-	if (populate)
-		mm_populate(oldbrk, newbrk - oldbrk);
-	return brk;
-
-out:
-	mm->brk = origbrk;
-	mmap_write_unlock(mm);
-	return origbrk;
-}
-
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-static void validate_mm(struct mm_struct *mm)
-{
-	int bug = 0;
-	int i = 0;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mt_validate(&mm->mm_mt);
-	for_each_vma(vmi, vma) {
-#ifdef CONFIG_DEBUG_VM_RB
-		struct anon_vma *anon_vma = vma->anon_vma;
-		struct anon_vma_chain *avc;
-#endif
-		unsigned long vmi_start, vmi_end;
-		bool warn = 0;
-
-		vmi_start = vma_iter_addr(&vmi);
-		vmi_end = vma_iter_end(&vmi);
-		if (VM_WARN_ON_ONCE_MM(vma->vm_end != vmi_end, mm))
-			warn = 1;
-
-		if (VM_WARN_ON_ONCE_MM(vma->vm_start != vmi_start, mm))
-			warn = 1;
-
-		if (warn) {
-			pr_emerg("issue in %s\n", current->comm);
-			dump_stack();
-			dump_vma(vma);
-			pr_emerg("tree range: %px start %lx end %lx\n", vma,
-				 vmi_start, vmi_end - 1);
-			vma_iter_dump_tree(&vmi);
-		}
-
-#ifdef CONFIG_DEBUG_VM_RB
-		if (anon_vma) {
-			anon_vma_lock_read(anon_vma);
-			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-				anon_vma_interval_tree_verify(avc);
-			anon_vma_unlock_read(anon_vma);
-		}
-#endif
-		i++;
-	}
-	if (i != mm->map_count) {
-		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
-		bug = 1;
-	}
-	VM_BUG_ON_MM(bug, mm);
-}
-
-#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
-#define validate_mm(mm) do { } while (0)
-#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
-
-/*
- * vma has some anon_vma assigned, and is already inserted on that
- * anon_vma's interval trees.
- *
- * Before updating the vma's vm_start / vm_end / vm_pgoff fields, the
- * vma must be removed from the anon_vma's interval trees using
- * anon_vma_interval_tree_pre_update_vma().
- *
- * After the update, the vma will be reinserted using
- * anon_vma_interval_tree_post_update_vma().
- *
- * The entire update must be protected by exclusive mmap_lock and by
- * the root anon_vma's mutex.
- */
-static inline void
-anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma)
-{
-	struct anon_vma_chain *avc;
-
-	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-		anon_vma_interval_tree_remove(avc, &avc->anon_vma->rb_root);
-}
-
-static inline void
-anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
-{
-	struct anon_vma_chain *avc;
-
-	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
-}
-
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
-static void __vma_link_file(struct vm_area_struct *vma,
-			    struct address_space *mapping)
-{
-	if (vma_is_shared_maywrite(vma))
-		mapping_allow_writable(mapping);
-
-	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_insert(vma, &mapping->i_mmap);
-	flush_dcache_mmap_unlock(mapping);
-}
-
-static void vma_link_file(struct vm_area_struct *vma)
-{
-	struct file *file = vma->vm_file;
-	struct address_space *mapping;
-
-	if (file) {
-		mapping = file->f_mapping;
-		i_mmap_lock_write(mapping);
-		__vma_link_file(vma, mapping);
-		i_mmap_unlock_write(mapping);
-	}
-}
-
-static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	VMA_ITERATOR(vmi, mm, 0);
-
-	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
-	if (vma_iter_prealloc(&vmi, vma))
-		return -ENOMEM;
-
-	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
-	vma_link_file(vma);
-	mm->map_count++;
-	validate_mm(mm);
-	return 0;
-}
-
-/*
- * init_multi_vma_prep() - Initializer for struct vma_prepare
- * @vp: The vma_prepare struct
- * @vma: The vma that will be altered once locked
- * @next: The next vma if it is to be adjusted
- * @remove: The first vma to be removed
- * @remove2: The second vma to be removed
- */
-static inline void init_multi_vma_prep(struct vma_prepare *vp,
-		struct vm_area_struct *vma, struct vm_area_struct *next,
-		struct vm_area_struct *remove, struct vm_area_struct *remove2)
-{
-	memset(vp, 0, sizeof(struct vma_prepare));
-	vp->vma = vma;
-	vp->anon_vma = vma->anon_vma;
-	vp->remove = remove;
-	vp->remove2 = remove2;
-	vp->adj_next = next;
-	if (!vp->anon_vma && next)
-		vp->anon_vma = next->anon_vma;
-
-	vp->file = vma->vm_file;
-	if (vp->file)
-		vp->mapping = vma->vm_file->f_mapping;
-
-}
-
-/*
- * init_vma_prep() - Initializer wrapper for vma_prepare struct
- * @vp: The vma_prepare struct
- * @vma: The vma that will be altered once locked
- */
-static inline void init_vma_prep(struct vma_prepare *vp,
-				 struct vm_area_struct *vma)
-{
-	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
-}
-
-
-/*
- * vma_prepare() - Helper function for handling locking VMAs prior to altering
- * @vp: The initialized vma_prepare struct
- */
-static inline void vma_prepare(struct vma_prepare *vp)
-{
-	if (vp->file) {
-		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
-
-		if (vp->adj_next)
-			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
-				      vp->adj_next->vm_end);
-
-		i_mmap_lock_write(vp->mapping);
-		if (vp->insert && vp->insert->vm_file) {
-			/*
-			 * Put into interval tree now, so instantiated pages
-			 * are visible to arm/parisc __flush_dcache_page
-			 * throughout; but we cannot insert into address
-			 * space until vma start or end is updated.
-			 */
-			__vma_link_file(vp->insert,
-					vp->insert->vm_file->f_mapping);
-		}
-	}
-
-	if (vp->anon_vma) {
-		anon_vma_lock_write(vp->anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vp->vma);
-		if (vp->adj_next)
-			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
-	}
-
-	if (vp->file) {
-		flush_dcache_mmap_lock(vp->mapping);
-		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
-		if (vp->adj_next)
-			vma_interval_tree_remove(vp->adj_next,
-						 &vp->mapping->i_mmap);
-	}
-
-}
-
-/*
- * vma_complete- Helper function for handling the unlocking after altering VMAs,
- * or for inserting a VMA.
- *
- * @vp: The vma_prepare struct
- * @vmi: The vma iterator
- * @mm: The mm_struct
- */
-static inline void vma_complete(struct vma_prepare *vp,
-				struct vma_iterator *vmi, struct mm_struct *mm)
-{
-	if (vp->file) {
-		if (vp->adj_next)
-			vma_interval_tree_insert(vp->adj_next,
-						 &vp->mapping->i_mmap);
-		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
-		flush_dcache_mmap_unlock(vp->mapping);
-	}
-
-	if (vp->remove && vp->file) {
-		__remove_shared_vm_struct(vp->remove, vp->mapping);
-		if (vp->remove2)
-			__remove_shared_vm_struct(vp->remove2, vp->mapping);
-	} else if (vp->insert) {
-		/*
-		 * split_vma has split insert from vma, and needs
-		 * us to insert it before dropping the locks
-		 * (it may either follow vma or precede it).
-		 */
-		vma_iter_store(vmi, vp->insert);
-		mm->map_count++;
-	}
-
-	if (vp->anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vp->vma);
-		if (vp->adj_next)
-			anon_vma_interval_tree_post_update_vma(vp->adj_next);
-		anon_vma_unlock_write(vp->anon_vma);
-	}
-
-	if (vp->file) {
-		i_mmap_unlock_write(vp->mapping);
-		uprobe_mmap(vp->vma);
-
-		if (vp->adj_next)
-			uprobe_mmap(vp->adj_next);
-	}
-
-	if (vp->remove) {
-again:
-		vma_mark_detached(vp->remove, true);
-		if (vp->file) {
-			uprobe_munmap(vp->remove, vp->remove->vm_start,
-				      vp->remove->vm_end);
-			fput(vp->file);
-		}
-		if (vp->remove->anon_vma)
-			anon_vma_merge(vp->vma, vp->remove);
-		mm->map_count--;
-		mpol_put(vma_policy(vp->remove));
-		if (!vp->remove2)
-			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
-		vm_area_free(vp->remove);
-
-		/*
-		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we are removing both mid and next vmas
-		 */
-		if (vp->remove2) {
-			vp->remove = vp->remove2;
-			vp->remove2 = NULL;
-			goto again;
-		}
-	}
-	if (vp->insert && vp->file)
-		uprobe_mmap(vp->insert);
-	validate_mm(mm);
-}
-
-/*
- * dup_anon_vma() - Helper function to duplicate anon_vma
- * @dst: The destination VMA
- * @src: The source VMA
- * @dup: Pointer to the destination VMA when successful.
- *
- * Returns: 0 on success.
- */
-static inline int dup_anon_vma(struct vm_area_struct *dst,
-		struct vm_area_struct *src, struct vm_area_struct **dup)
-{
-	/*
-	 * Easily overlooked: when mprotect shifts the boundary, make sure the
-	 * expanding vma has anon_vma set if the shrinking vma had, to cover any
-	 * anon pages imported.
-	 */
-	if (src->anon_vma && !dst->anon_vma) {
-		int ret;
-
-		vma_assert_write_locked(dst);
-		dst->anon_vma = src->anon_vma;
-		ret = anon_vma_clone(dst, src);
-		if (ret)
-			return ret;
-
-		*dup = dst;
-	}
-
-	return 0;
-}
-
-/*
- * vma_expand - Expand an existing VMA
- *
- * @vmi: The vma iterator
- * @vma: The vma to expand
- * @start: The start of the vma
- * @end: The exclusive end of the vma
- * @pgoff: The page offset of vma
- * @next: The current of next vma.
- *
- * Expand @vma to @start and @end.  Can expand off the start and end.  Will
- * expand over @next if it's different from @vma and @end == @next->vm_end.
- * Checking if the @vma can expand and merge with @next needs to be handled by
- * the caller.
- *
- * Returns: 0 on success
- */
-int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff,
-	       struct vm_area_struct *next)
-{
-	struct vm_area_struct *anon_dup = NULL;
-	bool remove_next = false;
-	struct vma_prepare vp;
-
-	vma_start_write(vma);
-	if (next && (vma != next) && (end == next->vm_end)) {
-		int ret;
-
-		remove_next = true;
-		vma_start_write(next);
-		ret = dup_anon_vma(vma, next, &anon_dup);
-		if (ret)
-			return ret;
-	}
-
-	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
-	/* Not merging but overwriting any part of next is not handled. */
-	VM_WARN_ON(next && !vp.remove &&
-		  next != vma && end > next->vm_start);
-	/* Only handles expanding */
-	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
-
-	/* Note: vma iterator must be pointing to 'start' */
-	vma_iter_config(vmi, start, end);
-	if (vma_iter_prealloc(vmi, vma))
-		goto nomem;
-
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, start, end, 0);
-	vma_set_range(vma, start, end, pgoff);
-	vma_iter_store(vmi, vma);
-
-	vma_complete(&vp, vmi, vma->vm_mm);
-	return 0;
-
-nomem:
-	if (anon_dup)
-		unlink_anon_vmas(anon_dup);
-	return -ENOMEM;
-}
-
-/*
- * vma_shrink() - Reduce an existing VMAs memory area
- * @vmi: The vma iterator
- * @vma: The VMA to modify
- * @start: The new start
- * @end: The new end
- *
- * Returns: 0 on success, -ENOMEM otherwise
- */
-int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff)
-{
-	struct vma_prepare vp;
-
-	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
-
-	if (vma->vm_start < start)
-		vma_iter_config(vmi, vma->vm_start, start);
-	else
-		vma_iter_config(vmi, end, vma->vm_end);
-
-	if (vma_iter_prealloc(vmi, NULL))
-		return -ENOMEM;
-
-	vma_start_write(vma);
-
-	init_vma_prep(&vp, vma);
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, start, end, 0);
-
-	vma_iter_clear(vmi);
-	vma_set_range(vma, start, end, pgoff);
-	vma_complete(&vp, vmi, vma->vm_mm);
-	return 0;
-}
-
-/*
- * If the vma has a ->close operation then the driver probably needs to release
- * per-vma resources, so we don't attempt to merge those if the caller indicates
- * the current vma may be removed as part of the merge.
- */
-static inline bool is_mergeable_vma(struct vm_area_struct *vma,
-		struct file *file, unsigned long vm_flags,
-		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name, bool may_remove_vma)
-{
-	/*
-	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
-	 * match the flags but dirty bit -- the caller should mark
-	 * merged VMA as dirty. If dirty bit won't be excluded from
-	 * comparison, we increase pressure on the memory system forcing
-	 * the kernel to generate new VMAs when old one could be
-	 * extended instead.
-	 */
-	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
-		return false;
-	if (vma->vm_file != file)
-		return false;
-	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
-		return false;
-	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
-		return false;
-	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
-		return false;
-	return true;
-}
-
-static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
-		 struct anon_vma *anon_vma2, struct vm_area_struct *vma)
-{
-	/*
-	 * The list_is_singular() test is to avoid merging VMA cloned from
-	 * parents. This can improve scalability caused by anon_vma lock.
-	 */
-	if ((!anon_vma1 || !anon_vma2) && (!vma ||
-		list_is_singular(&vma->anon_vma_chain)))
-		return true;
-	return anon_vma1 == anon_vma2;
-}
-
-/*
- * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
- * in front of (at a lower virtual address and file offset than) the vma.
- *
- * We cannot merge two vmas if they have differently assigned (non-NULL)
- * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
- *
- * We don't check here for the merged mmap wrapping around the end of pagecache
- * indices (16TB on ia32) because do_mmap() does not permit mmap's which
- * wrap, nor mmaps which cover the final page at index -1UL.
- *
- * We assume the vma may be removed as part of the merge.
- */
-static bool
-can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
-{
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
-		if (vma->vm_pgoff == vm_pgoff)
-			return true;
-	}
-	return false;
-}
-
-/*
- * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
- * beyond (at a higher virtual address and file offset than) the vma.
- *
- * We cannot merge two vmas if they have differently assigned (non-NULL)
- * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
- *
- * We assume that vma is not removed as part of the merge.
- */
-static bool
-can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
-		struct anon_vma *anon_vma, struct file *file,
-		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-		struct anon_vma_name *anon_name)
-{
-	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
-	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
-		pgoff_t vm_pglen;
-		vm_pglen = vma_pages(vma);
-		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
-			return true;
-	}
-	return false;
-}
-
-/*
- * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
- * figure out whether that can be merged with its predecessor or its
- * successor.  Or both (it neatly fills a hole).
- *
- * In most cases - when called for mmap, brk or mremap - [addr,end) is
- * certain not to be mapped by the time vma_merge is called; but when
- * called for mprotect, it is certain to be already mapped (either at
- * an offset within prev, or at the start of next), and the flags of
- * this area are about to be changed to vm_flags - and the no-change
- * case has already been eliminated.
- *
- * The following mprotect cases have to be considered, where **** is
- * the area passed down from mprotect_fixup, never extending beyond one
- * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
- * at the same address as **** and is of the same or larger span, and
- * NNNN the next vma after ****:
- *
- *     ****             ****                   ****
- *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
- *    cannot merge    might become       might become
- *                    PPNNNNNNNNNN       PPPPPPPPPPCC
- *    mmap, brk or    case 4 below       case 5 below
- *    mremap move:
- *                        ****               ****
- *                    PPPP    NNNN       PPPPCCCCNNNN
- *                    might become       might become
- *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
- *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
- *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
- *
- * It is important for case 8 that the vma CCCC overlapping the
- * region **** is never going to extended over NNNN. Instead NNNN must
- * be extended in region **** and CCCC must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_merge drops the
- * rmap_locks, the properties of the merged vma will be already
- * correct for the whole merged range. Some of those properties like
- * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
- * be correct for the whole merged range immediately after the
- * rmap_locks are released. Otherwise if NNNN would be removed and
- * CCCC would be extended over the NNNN range, remove_migration_ptes
- * or other rmap walkers (if working on addresses beyond the "end"
- * parameter) may establish ptes with the wrong permissions of CCCC
- * instead of the right permissions of NNNN.
- *
- * In the code below:
- * PPPP is represented by *prev
- * CCCC is represented by *curr or not represented at all (NULL)
- * NNNN is represented by *next or not represented at all (NULL)
- * **** is not represented - it will be merged and the vma containing the
- *      area is returned, or the function will return NULL
- */
-static struct vm_area_struct
-*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
-	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
-	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
-	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-	   struct anon_vma_name *anon_name)
-{
-	struct mm_struct *mm = src->vm_mm;
-	struct anon_vma *anon_vma = src->anon_vma;
-	struct file *file = src->vm_file;
-	struct vm_area_struct *curr, *next, *res;
-	struct vm_area_struct *vma, *adjust, *remove, *remove2;
-	struct vm_area_struct *anon_dup = NULL;
-	struct vma_prepare vp;
-	pgoff_t vma_pgoff;
-	int err = 0;
-	bool merge_prev = false;
-	bool merge_next = false;
-	bool vma_expanded = false;
-	unsigned long vma_start = addr;
-	unsigned long vma_end = end;
-	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
-	long adj_start = 0;
-
-	/*
-	 * We later require that vma->vm_flags == vm_flags,
-	 * so this tests vma->vm_flags & VM_SPECIAL, too.
-	 */
-	if (vm_flags & VM_SPECIAL)
-		return NULL;
-
-	/* Does the input range span an existing VMA? (cases 5 - 8) */
-	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
-
-	if (!curr ||			/* cases 1 - 4 */
-	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vma_lookup(mm, end);
-	else
-		next = NULL;		/* case 5 */
-
-	if (prev) {
-		vma_start = prev->vm_start;
-		vma_pgoff = prev->vm_pgoff;
-
-		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
-		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
-					   pgoff, vm_userfaultfd_ctx, anon_name)) {
-			merge_prev = true;
-			vma_prev(vmi);
-		}
-	}
-
-	/* Can we merge the successor? */
-	if (next && mpol_equal(policy, vma_policy(next)) &&
-	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
-				 vm_userfaultfd_ctx, anon_name)) {
-		merge_next = true;
-	}
-
-	/* Verify some invariant that must be enforced by the caller. */
-	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
-	VM_WARN_ON(addr >= end);
-
-	if (!merge_prev && !merge_next)
-		return NULL; /* Not mergeable. */
-
-	if (merge_prev)
-		vma_start_write(prev);
-
-	res = vma = prev;
-	remove = remove2 = adjust = NULL;
-
-	/* Can we merge both the predecessor and the successor? */
-	if (merge_prev && merge_next &&
-	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
-		vma_start_write(next);
-		remove = next;				/* case 1 */
-		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next, &anon_dup);
-		if (curr) {				/* case 6 */
-			vma_start_write(curr);
-			remove = curr;
-			remove2 = next;
-			/*
-			 * Note that the dup_anon_vma below cannot overwrite err
-			 * since the first caller would do nothing unless next
-			 * has an anon_vma.
-			 */
-			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else if (merge_prev) {			/* case 2 */
-		if (curr) {
-			vma_start_write(curr);
-			if (end == curr->vm_end) {	/* case 7 */
-				/*
-				 * can_vma_merge_after() assumed we would not be
-				 * removing prev vma, so it skipped the check
-				 * for vm_ops->close, but we are removing curr
-				 */
-				if (curr->vm_ops && curr->vm_ops->close)
-					err = -EINVAL;
-				remove = curr;
-			} else {			/* case 5 */
-				adjust = curr;
-				adj_start = (end - curr->vm_start);
-			}
-			if (!err)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else { /* merge_next */
-		vma_start_write(next);
-		res = next;
-		if (prev && addr < prev->vm_end) {	/* case 4 */
-			vma_start_write(prev);
-			vma_end = addr;
-			adjust = next;
-			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev, &anon_dup);
-		} else {
-			/*
-			 * Note that cases 3 and 8 are the ONLY ones where prev
-			 * is permitted to be (but is not necessarily) NULL.
-			 */
-			vma = next;			/* case 3 */
-			vma_start = addr;
-			vma_end = next->vm_end;
-			vma_pgoff = next->vm_pgoff - pglen;
-			if (curr) {			/* case 8 */
-				vma_pgoff = curr->vm_pgoff;
-				vma_start_write(curr);
-				remove = curr;
-				err = dup_anon_vma(next, curr, &anon_dup);
-			}
-		}
-	}
-
-	/* Error in anon_vma clone. */
-	if (err)
-		goto anon_vma_fail;
-
-	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
-		vma_expanded = true;
-
-	if (vma_expanded) {
-		vma_iter_config(vmi, vma_start, vma_end);
-	} else {
-		vma_iter_config(vmi, adjust->vm_start + adj_start,
-				adjust->vm_end);
-	}
-
-	if (vma_iter_prealloc(vmi, vma))
-		goto prealloc_fail;
-
-	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
-	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
-		   vp.anon_vma != adjust->anon_vma);
-
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
-
-	if (vma_expanded)
-		vma_iter_store(vmi, vma);
-
-	if (adj_start) {
-		adjust->vm_start += adj_start;
-		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
-		if (adj_start < 0) {
-			WARN_ON(vma_expanded);
-			vma_iter_store(vmi, next);
-		}
-	}
-
-	vma_complete(&vp, vmi, mm);
-	khugepaged_enter_vma(res, vm_flags);
-	return res;
-
-prealloc_fail:
-	if (anon_dup)
-		unlink_anon_vmas(anon_dup);
-
-anon_vma_fail:
-	vma_iter_set(vmi, addr);
-	vma_iter_load(vmi);
-	return NULL;
-}
-
-/*
- * Rough compatibility check to quickly see if it's even worth looking
- * at sharing an anon_vma.
- *
- * They need to have the same vm_file, and the flags can only differ
- * in things that mprotect may change.
- *
- * NOTE! The fact that we share an anon_vma doesn't _have_ to mean that
- * we can merge the two vma's. For example, we refuse to merge a vma if
- * there is a vm_ops->close() function, because that indicates that the
- * driver is doing some kind of reference counting. But that doesn't
- * really matter for the anon_vma sharing case.
- */
-static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *b)
-{
-	return a->vm_end == b->vm_start &&
-		mpol_equal(vma_policy(a), vma_policy(b)) &&
-		a->vm_file == b->vm_file &&
-		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
-		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
-}
-
-/*
- * Do some basic sanity checking to see if we can re-use the anon_vma
- * from 'old'. The 'a'/'b' vma's are in VM order - one of them will be
- * the same as 'old', the other will be the new one that is trying
- * to share the anon_vma.
- *
- * NOTE! This runs with mmap_lock held for reading, so it is possible that
- * the anon_vma of 'old' is concurrently in the process of being set up
- * by another page fault trying to merge _that_. But that's ok: if it
- * is being set up, that automatically means that it will be a singleton
- * acceptable for merging, so we can do all of this optimistically. But
- * we do that READ_ONCE() to make sure that we never re-load the pointer.
- *
- * IOW: that the "list_is_singular()" test on the anon_vma_chain only
- * matters for the 'stable anon_vma' case (ie the thing we want to avoid
- * is to return an anon_vma that is "complex" due to having gone through
- * a fork).
- *
- * We also make sure that the two vma's are compatible (adjacent,
- * and with the same memory policies). That's all stable, even with just
- * a read lock on the mmap_lock.
- */
-static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_area_struct *a, struct vm_area_struct *b)
-{
-	if (anon_vma_compatible(a, b)) {
-		struct anon_vma *anon_vma = READ_ONCE(old->anon_vma);
-
-		if (anon_vma && list_is_singular(&old->anon_vma_chain))
-			return anon_vma;
-	}
-	return NULL;
-}
-
-/*
- * find_mergeable_anon_vma is used by anon_vma_prepare, to check
- * neighbouring vmas for a suitable anon_vma, before it goes off
- * to allocate a new anon_vma.  It checks because a repetitive
- * sequence of mprotects and faults may otherwise lead to distinct
- * anon_vmas being allocated, preventing vma merge in subsequent
- * mprotect.
- */
-struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
-{
-	struct anon_vma *anon_vma = NULL;
-	struct vm_area_struct *prev, *next;
-	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_end);
-
-	/* Try next first. */
-	next = vma_iter_load(&vmi);
-	if (next) {
-		anon_vma = reusable_anon_vma(next, vma, next);
-		if (anon_vma)
-			return anon_vma;
-	}
+	mm->brk = brk;
+	if (mm->def_flags & VM_LOCKED)
+		populate = true;
 
-	prev = vma_prev(&vmi);
-	VM_BUG_ON_VMA(prev != vma, vma);
-	prev = vma_prev(&vmi);
-	/* Try prev next. */
-	if (prev)
-		anon_vma = reusable_anon_vma(prev, prev, vma);
+success:
+	mmap_write_unlock(mm);
+success_unlocked:
+	userfaultfd_unmap_complete(mm, &uf);
+	if (populate)
+		mm_populate(oldbrk, newbrk - oldbrk);
+	return brk;
 
-	/*
-	 * We might reach here with anon_vma == NULL if we can't find
-	 * any reusable anon_vma.
-	 * There's no absolute need to look only at touching neighbours:
-	 * we could search further afield for "compatible" anon_vmas.
-	 * But it would probably just be a waste of time searching,
-	 * or lead to too many vmas hanging off the same anon_vma.
-	 * We're trying to allow mprotect remerging later on,
-	 * not trying to minimize memory used for anon_vmas.
-	 */
-	return anon_vma;
+out:
+	mm->brk = origbrk;
+	mmap_write_unlock(mm);
+	return origbrk;
 }
 
 /*
@@ -1519,85 +546,6 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
 }
 #endif /* __ARCH_WANT_SYS_OLD_MMAP */
 
-static bool vm_ops_needs_writenotify(const struct vm_operations_struct *vm_ops)
-{
-	return vm_ops && (vm_ops->page_mkwrite || vm_ops->pfn_mkwrite);
-}
-
-static bool vma_is_shared_writable(struct vm_area_struct *vma)
-{
-	return (vma->vm_flags & (VM_WRITE | VM_SHARED)) ==
-		(VM_WRITE | VM_SHARED);
-}
-
-static bool vma_fs_can_writeback(struct vm_area_struct *vma)
-{
-	/* No managed pages to writeback. */
-	if (vma->vm_flags & VM_PFNMAP)
-		return false;
-
-	return vma->vm_file && vma->vm_file->f_mapping &&
-		mapping_can_writeback(vma->vm_file->f_mapping);
-}
-
-/*
- * Does this VMA require the underlying folios to have their dirty state
- * tracked?
- */
-bool vma_needs_dirty_tracking(struct vm_area_struct *vma)
-{
-	/* Only shared, writable VMAs require dirty tracking. */
-	if (!vma_is_shared_writable(vma))
-		return false;
-
-	/* Does the filesystem need to be notified? */
-	if (vm_ops_needs_writenotify(vma->vm_ops))
-		return true;
-
-	/*
-	 * Even if the filesystem doesn't indicate a need for writenotify, if it
-	 * can writeback, dirty tracking is still required.
-	 */
-	return vma_fs_can_writeback(vma);
-}
-
-/*
- * Some shared mappings will want the pages marked read-only
- * to track write events. If so, we'll downgrade vm_page_prot
- * to the private version (using protection_map[] without the
- * VM_SHARED bit).
- */
-bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
-{
-	/* If it was private or non-writable, the write bit is already clear */
-	if (!vma_is_shared_writable(vma))
-		return false;
-
-	/* The backer wishes to know when pages are first written to? */
-	if (vm_ops_needs_writenotify(vma->vm_ops))
-		return true;
-
-	/* The open routine did something to the protections that pgprot_modify
-	 * won't preserve? */
-	if (pgprot_val(vm_page_prot) !=
-	    pgprot_val(vm_pgprot_modify(vm_page_prot, vma->vm_flags)))
-		return false;
-
-	/*
-	 * Do we need to track softdirty? hugetlb does not support softdirty
-	 * tracking yet.
-	 */
-	if (vma_soft_dirty_enabled(vma) && !is_vm_hugetlb_page(vma))
-		return true;
-
-	/* Do we need write faults for uffd-wp tracking? */
-	if (userfaultfd_wp(vma))
-		return true;
-
-	/* Can the mapping track the dirty pages? */
-	return vma_fs_can_writeback(vma);
-}
-
 /*
  * We account for memory if it's a private writeable mapping,
  * not hugepages and VM_NORESERVE wasn't set.
@@ -2238,566 +1186,129 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 				anon_vma_interval_tree_post_update_vma(vma);
 				spin_unlock(&mm->page_table_lock);
 
-				perf_event_mmap(vma);
-			}
-		}
-	}
-	anon_vma_unlock_write(vma->anon_vma);
-	vma_iter_free(&vmi);
-	validate_mm(mm);
-	return error;
-}
-
-/* enforced gap between the expanding stack and other mappings. */
-unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
-
-static int __init cmdline_parse_stack_guard_gap(char *p)
-{
-	unsigned long val;
-	char *endptr;
-
-	val = simple_strtoul(p, &endptr, 10);
-	if (!*endptr)
-		stack_guard_gap = val << PAGE_SHIFT;
-
-	return 1;
-}
-__setup("stack_guard_gap=", cmdline_parse_stack_guard_gap);
-
-#ifdef CONFIG_STACK_GROWSUP
-int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
-{
-	return expand_upwards(vma, address);
-}
-
-struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_area_struct *vma, *prev;
-
-	addr &= PAGE_MASK;
-	vma = find_vma_prev(mm, addr, &prev);
-	if (vma && (vma->vm_start <= addr))
-		return vma;
-	if (!prev)
-		return NULL;
-	if (expand_stack_locked(prev, addr))
-		return NULL;
-	if (prev->vm_flags & VM_LOCKED)
-		populate_vma_page_range(prev, addr, prev->vm_end, NULL);
-	return prev;
-}
-#else
-int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
-{
-	return expand_downwards(vma, address);
-}
-
-struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_area_struct *vma;
-	unsigned long start;
-
-	addr &= PAGE_MASK;
-	vma = find_vma(mm, addr);
-	if (!vma)
-		return NULL;
-	if (vma->vm_start <= addr)
-		return vma;
-	start = vma->vm_start;
-	if (expand_stack_locked(vma, addr))
-		return NULL;
-	if (vma->vm_flags & VM_LOCKED)
-		populate_vma_page_range(vma, addr, start, NULL);
-	return vma;
-}
-#endif
-
-#if defined(CONFIG_STACK_GROWSUP)
-
-#define vma_expand_up(vma,addr) expand_upwards(vma, addr)
-#define vma_expand_down(vma, addr) (-EFAULT)
-
-#else
-
-#define vma_expand_up(vma,addr) (-EFAULT)
-#define vma_expand_down(vma, addr) expand_downwards(vma, addr)
-
-#endif
-
-/*
- * expand_stack(): legacy interface for page faulting. Don't use unless
- * you have to.
- *
- * This is called with the mm locked for reading, drops the lock, takes
- * the lock for writing, tries to look up a vma again, expands it if
- * necessary, and downgrades the lock to reading again.
- *
- * If no vma is found or it can't be expanded, it returns NULL and has
- * dropped the lock.
- */
-struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_area_struct *vma, *prev;
-
-	mmap_read_unlock(mm);
-	if (mmap_write_lock_killable(mm))
-		return NULL;
-
-	vma = find_vma_prev(mm, addr, &prev);
-	if (vma && vma->vm_start <= addr)
-		goto success;
-
-	if (prev && !vma_expand_up(prev, addr)) {
-		vma = prev;
-		goto success;
-	}
-
-	if (vma && !vma_expand_down(vma, addr))
-		goto success;
-
-	mmap_write_unlock(mm);
-	return NULL;
-
-success:
-	mmap_write_downgrade(mm);
-	return vma;
-}
-
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
-/*
- * Get rid of page table information in the indicated region.
- *
- * Called with the mm semaphore held.
- */
-static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
-{
-	struct mmu_gather tlb;
-	unsigned long mt_start = mas->index;
-
-	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
-	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
-	mas_set(mas, mt_start);
-	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
-	tlb_finish_mmu(&tlb);
-}
-
-/*
- * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
- * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
- */
-static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		       unsigned long addr, int new_below)
-{
-	struct vma_prepare vp;
-	struct vm_area_struct *new;
-	int err;
-
-	WARN_ON(vma->vm_start >= addr);
-	WARN_ON(vma->vm_end <= addr);
-
-	if (vma->vm_ops && vma->vm_ops->may_split) {
-		err = vma->vm_ops->may_split(vma, addr);
-		if (err)
-			return err;
-	}
-
-	new = vm_area_dup(vma);
-	if (!new)
-		return -ENOMEM;
-
-	if (new_below) {
-		new->vm_end = addr;
-	} else {
-		new->vm_start = addr;
-		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
-	}
-
-	err = -ENOMEM;
-	vma_iter_config(vmi, new->vm_start, new->vm_end);
-	if (vma_iter_prealloc(vmi, new))
-		goto out_free_vma;
-
-	err = vma_dup_policy(vma, new);
-	if (err)
-		goto out_free_vmi;
-
-	err = anon_vma_clone(new, vma);
-	if (err)
-		goto out_free_mpol;
-
-	if (new->vm_file)
-		get_file(new->vm_file);
-
-	if (new->vm_ops && new->vm_ops->open)
-		new->vm_ops->open(new);
-
-	vma_start_write(vma);
-	vma_start_write(new);
-
-	init_vma_prep(&vp, vma);
-	vp.insert = new;
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
-
-	if (new_below) {
-		vma->vm_start = addr;
-		vma->vm_pgoff += (addr - new->vm_start) >> PAGE_SHIFT;
-	} else {
-		vma->vm_end = addr;
-	}
-
-	/* vma_complete stores the new vma */
-	vma_complete(&vp, vmi, vma->vm_mm);
-
-	/* Success. */
-	if (new_below)
-		vma_next(vmi);
-	return 0;
-
-out_free_mpol:
-	mpol_put(vma_policy(new));
-out_free_vmi:
-	vma_iter_free(vmi);
-out_free_vma:
-	vm_area_free(new);
-	return err;
-}
-
-/*
- * Split a vma into two pieces at address 'addr', a new vma is allocated
- * either for the first part or the tail.
- */
-static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		     unsigned long addr, int new_below)
-{
-	if (vma->vm_mm->map_count >= sysctl_max_map_count)
-		return -ENOMEM;
-
-	return __split_vma(vmi, vma, addr, new_below);
-}
-
-/*
- * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
- * context and anonymous VMA name within the range [start, end).
- *
- * As a result, we might be able to merge the newly modified VMA range with an
- * adjacent VMA with identical properties.
- *
- * If no merge is possible and the range does not span the entirety of the VMA,
- * we then need to split the VMA to accommodate the change.
- *
- * The function returns either the merged VMA, the original VMA if a split was
- * required instead, or an error if the split failed.
- */
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name)
-{
-	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	struct vm_area_struct *merged;
-
-	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
-			   pgoff, policy, uffd_ctx, anon_name);
-	if (merged)
-		return merged;
-
-	if (vma->vm_start < start) {
-		int err = split_vma(vmi, vma, start, 1);
-
-		if (err)
-			return ERR_PTR(err);
+				perf_event_mmap(vma);
+			}
+		}
 	}
+	anon_vma_unlock_write(vma->anon_vma);
+	vma_iter_free(&vmi);
+	validate_mm(mm);
+	return error;
+}
 
-	if (vma->vm_end > end) {
-		int err = split_vma(vmi, vma, end, 0);
+/* enforced gap between the expanding stack and other mappings. */
+unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
 
-		if (err)
-			return ERR_PTR(err);
-	}
+static int __init cmdline_parse_stack_guard_gap(char *p)
+{
+	unsigned long val;
+	char *endptr;
 
-	return vma;
+	val = simple_strtoul(p, &endptr, 10);
+	if (!*endptr)
+		stack_guard_gap = val << PAGE_SHIFT;
+
+	return 1;
 }
+__setup("stack_guard_gap=", cmdline_parse_stack_guard_gap);
 
-/*
- * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
- * must ensure that [start, end) does not overlap any existing VMA.
- */
-static struct vm_area_struct
-*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-		   struct vm_area_struct *vma, unsigned long start,
-		   unsigned long end, pgoff_t pgoff)
+#ifdef CONFIG_STACK_GROWSUP
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
 {
-	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
-			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	return expand_upwards(vma, address);
 }
 
-/*
- * Expand vma by delta bytes, potentially merging with an immediately adjacent
- * VMA with identical properties.
- */
-struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
-					struct vm_area_struct *vma,
-					unsigned long delta)
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned long addr)
 {
-	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
+	struct vm_area_struct *vma, *prev;
 
-	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
-			 vma->vm_flags, pgoff, vma_policy(vma),
-			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	addr &= PAGE_MASK;
+	vma = find_vma_prev(mm, addr, &prev);
+	if (vma && (vma->vm_start <= addr))
+		return vma;
+	if (!prev)
+		return NULL;
+	if (expand_stack_locked(prev, addr))
+		return NULL;
+	if (prev->vm_flags & VM_LOCKED)
+		populate_vma_page_range(prev, addr, prev->vm_end, NULL);
+	return prev;
 }
-
-/*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
- *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
- */
-static int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+#else
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
 {
-	struct vm_area_struct *prev, *next = NULL;
-	struct maple_tree mt_detach;
-	int count = 0;
-	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
-
-	/*
-	 * If we need to split any vma, do it now to save pain later.
-	 *
-	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
-	 * unmapped vm_area_struct will remain in use: so lower split_vma
-	 * places tmp vma above, and higher split_vma places tmp vma below.
-	 */
-
-	/* Does it split the first one? */
-	if (start > vma->vm_start) {
-
-		/*
-		 * Make sure that map_count on return from munmap() will
-		 * not exceed its limit; but let map_count go just above
-		 * its limit temporarily, to help free resources as expected.
-		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
-			goto map_count_exceeded;
-
-		error = __split_vma(vmi, vma, start, 1);
-		if (error)
-			goto start_split_failed;
-	}
-
-	/*
-	 * Detach a range of VMAs from the mm. Using next as a temp variable as
-	 * it is always overwritten.
-	 */
-	next = vma;
-	do {
-		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
-			if (error)
-				goto end_split_failed;
-		}
-		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
-		if (error)
-			goto munmap_gather_failed;
-		vma_mark_detached(next, true);
-		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
+	return expand_downwards(vma, address);
+}
 
-		count++;
-		if (unlikely(uf)) {
-			/*
-			 * If userfaultfd_unmap_prep returns an error the vmas
-			 * will remain split, but userland will get a
-			 * highly unexpected error anyway. This is no
-			 * different than the case where the first of the two
-			 * __split_vma fails, but we don't undo the first
-			 * split, despite we could. This is unlikely enough
-			 * failure that it's not worth optimizing it for.
-			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long start;
 
-			if (error)
-				goto userfaultfd_error;
-		}
-#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
-#endif
-	} for_each_vma_range(*vmi, next, end);
-
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-	/* Make sure no VMAs are about to be lost. */
-	{
-		MA_STATE(test, &mt_detach, 0, 0);
-		struct vm_area_struct *vma_mas, *vma_test;
-		int test_count = 0;
-
-		vma_iter_set(vmi, start);
-		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
-			BUG_ON(vma_mas != vma_test);
-			test_count++;
-			vma_test = mas_next(&test, count - 1);
-		}
-		rcu_read_unlock();
-		BUG_ON(count != test_count);
-	}
+	addr &= PAGE_MASK;
+	vma = find_vma(mm, addr);
+	if (!vma)
+		return NULL;
+	if (vma->vm_start <= addr)
+		return vma;
+	start = vma->vm_start;
+	if (expand_stack_locked(vma, addr))
+		return NULL;
+	if (vma->vm_flags & VM_LOCKED)
+		populate_vma_page_range(vma, addr, start, NULL);
+	return vma;
+}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
-
-	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
-	if (error)
-		goto clear_tree_failed;
-
-	/* Point of no return */
-	mm->locked_vm -= locked_vm;
-	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
+#if defined(CONFIG_STACK_GROWSUP)
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
+#define vma_expand_up(vma,addr) expand_upwards(vma, addr)
+#define vma_expand_down(vma, addr) (-EFAULT)
 
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
+#else
 
-	__mt_destroy(&mt_detach);
-	return 0;
+#define vma_expand_up(vma,addr) (-EFAULT)
+#define vma_expand_down(vma, addr) expand_downwards(vma, addr)
 
-clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
-	mas_set(&mas_detach, 0);
-	mas_for_each(&mas_detach, next, end)
-		vma_mark_detached(next, false);
-
-	__mt_destroy(&mt_detach);
-start_split_failed:
-map_count_exceeded:
-	validate_mm(mm);
-	return error;
-}
+#endif
 
 /*
- * do_vmi_munmap() - munmap a given range.
- * @vmi: The vma iterator
- * @mm: The mm_struct
- * @start: The start address to munmap
- * @len: The length of the range to munmap
- * @uf: The userfaultfd list_head
- * @unlock: set to true if the user wants to drop the mmap_lock on success
+ * expand_stack(): legacy interface for page faulting. Don't use unless
+ * you have to.
  *
- * This function takes a @mas that is either pointing to the previous VMA or set
- * to MA_START and sets it up to remove the mapping(s).  The @len will be
- * aligned and any arch_unmap work will be preformed.
+ * This is called with the mm locked for reading, drops the lock, takes
+ * the lock for writing, tries to look up a vma again, expands it if
+ * necessary, and downgrades the lock to reading again.
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * If no vma is found or it can't be expanded, it returns NULL and has
+ * dropped the lock.
  */
-int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
-		  unsigned long start, size_t len, struct list_head *uf,
-		  bool unlock)
+struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 {
-	unsigned long end;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *prev;
 
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
-		return -EINVAL;
+	mmap_read_unlock(mm);
+	if (mmap_write_lock_killable(mm))
+		return NULL;
 
-	end = start + PAGE_ALIGN(len);
-	if (end == start)
-		return -EINVAL;
+	vma = find_vma_prev(mm, addr, &prev);
+	if (vma && vma->vm_start <= addr)
+		goto success;
 
-	/*
-	 * Check if memory is sealed before arch_unmap.
-	 * Prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
+	if (prev && !vma_expand_up(prev, addr)) {
+		vma = prev;
+		goto success;
+	}
 
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
+	if (vma && !vma_expand_down(vma, addr))
+		goto success;
 
-	/* Find the first overlapping VMA */
-	vma = vma_find(vmi, end);
-	if (!vma) {
-		if (unlock)
-			mmap_write_unlock(mm);
-		return 0;
-	}
+	mmap_write_unlock(mm);
+	return NULL;
 
-	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
+success:
+	mmap_write_downgrade(mm);
+	return vma;
 }
 
 /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
@@ -3460,92 +1971,6 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	return 0;
 }
 
-/*
- * Copy the vma structure to a new location in the same mm,
- * prior to moving page table entries, to effect an mremap move.
- */
-struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
-	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
-{
-	struct vm_area_struct *vma = *vmap;
-	unsigned long vma_start = vma->vm_start;
-	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *new_vma, *prev;
-	bool faulted_in_anon_vma = true;
-	VMA_ITERATOR(vmi, mm, addr);
-
-	/*
-	 * If anonymous vma has not yet been faulted, update new pgoff
-	 * to match new location, to increase its chance of merging.
-	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
-		pgoff = addr >> PAGE_SHIFT;
-		faulted_in_anon_vma = false;
-	}
-
-	new_vma = find_vma_prev(mm, addr, &prev);
-	if (new_vma && new_vma->vm_start < addr + len)
-		return NULL;	/* should never get here */
-
-	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
-	if (new_vma) {
-		/*
-		 * Source vma may have been merged into new_vma
-		 */
-		if (unlikely(vma_start >= new_vma->vm_start &&
-			     vma_start < new_vma->vm_end)) {
-			/*
-			 * The only way we can get a vma_merge with
-			 * self during an mremap is if the vma hasn't
-			 * been faulted in yet and we were allowed to
-			 * reset the dst vma->vm_pgoff to the
-			 * destination address of the mremap to allow
-			 * the merge to happen. mremap must change the
-			 * vm_pgoff linearity between src and dst vmas
-			 * (in turn preventing a vma_merge) to be
-			 * safe. It is only safe to keep the vm_pgoff
-			 * linear if there are no pages mapped yet.
-			 */
-			VM_BUG_ON_VMA(faulted_in_anon_vma, new_vma);
-			*vmap = vma = new_vma;
-		}
-		*need_rmap_locks = (new_vma->vm_pgoff <= vma->vm_pgoff);
-	} else {
-		new_vma = vm_area_dup(vma);
-		if (!new_vma)
-			goto out;
-		vma_set_range(new_vma, addr, addr + len, pgoff);
-		if (vma_dup_policy(vma, new_vma))
-			goto out_free_vma;
-		if (anon_vma_clone(new_vma, vma))
-			goto out_free_mempol;
-		if (new_vma->vm_file)
-			get_file(new_vma->vm_file);
-		if (new_vma->vm_ops && new_vma->vm_ops->open)
-			new_vma->vm_ops->open(new_vma);
-		if (vma_link(mm, new_vma))
-			goto out_vma_link;
-		*need_rmap_locks = false;
-	}
-	return new_vma;
-
-out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
-
-	if (new_vma->vm_file)
-		fput(new_vma->vm_file);
-
-	unlink_anon_vmas(new_vma);
-out_free_mempol:
-	mpol_put(vma_policy(new_vma));
-out_free_vma:
-	vm_area_free(new_vma);
-out:
-	return NULL;
-}
-
 /*
  * Return true if the calling process may expand its vm space by the passed
  * number of pages
@@ -3743,203 +2168,6 @@ int install_special_mapping(struct mm_struct *mm,
 	return PTR_ERR_OR_ZERO(vma);
 }
 
-static DEFINE_MUTEX(mm_all_locks_mutex);
-
-static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
-{
-	if (!test_bit(0, (unsigned long *) &anon_vma->root->rb_root.rb_root.rb_node)) {
-		/*
-		 * The LSB of head.next can't change from under us
-		 * because we hold the mm_all_locks_mutex.
-		 */
-		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_lock);
-		/*
-		 * We can safely modify head.next after taking the
-		 * anon_vma->root->rwsem. If some other vma in this mm shares
-		 * the same anon_vma we won't take it again.
-		 *
-		 * No need of atomic instructions here, head.next
-		 * can't change from under us thanks to the
-		 * anon_vma->root->rwsem.
-		 */
-		if (__test_and_set_bit(0, (unsigned long *)
-				       &anon_vma->root->rb_root.rb_root.rb_node))
-			BUG();
-	}
-}
-
-static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
-{
-	if (!test_bit(AS_MM_ALL_LOCKS, &mapping->flags)) {
-		/*
-		 * AS_MM_ALL_LOCKS can't change from under us because
-		 * we hold the mm_all_locks_mutex.
-		 *
-		 * Operations on ->flags have to be atomic because
-		 * even if AS_MM_ALL_LOCKS is stable thanks to the
-		 * mm_all_locks_mutex, there may be other cpus
-		 * changing other bitflags in parallel to us.
-		 */
-		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
-			BUG();
-		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_lock);
-	}
-}
-
-/*
- * This operation locks against the VM for all pte/vma/mm related
- * operations that could ever happen on a certain mm. This includes
- * vmtruncate, try_to_unmap, and all page faults.
- *
- * The caller must take the mmap_lock in write mode before calling
- * mm_take_all_locks(). The caller isn't allowed to release the
- * mmap_lock until mm_drop_all_locks() returns.
- *
- * mmap_lock in write mode is required in order to block all operations
- * that could modify pagetables and free pages without need of
- * altering the vma layout. It's also needed in write mode to avoid new
- * anon_vmas to be associated with existing vmas.
- *
- * A single task can't take more than one mm_take_all_locks() in a row
- * or it would deadlock.
- *
- * The LSB in anon_vma->rb_root.rb_node and the AS_MM_ALL_LOCKS bitflag in
- * mapping->flags avoid to take the same lock twice, if more than one
- * vma in this mm is backed by the same anon_vma or address_space.
- *
- * We take locks in following order, accordingly to comment at beginning
- * of mm/rmap.c:
- *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
- *     hugetlb mapping);
- *   - all vmas marked locked
- *   - all i_mmap_rwsem locks;
- *   - all anon_vma->rwseml
- *
- * We can take all locks within these types randomly because the VM code
- * doesn't nest them and we protected from parallel mm_take_all_locks() by
- * mm_all_locks_mutex.
- *
- * mm_take_all_locks() and mm_drop_all_locks are expensive operations
- * that may have to take thousand of locks.
- *
- * mm_take_all_locks() can fail if it's interrupted by signals.
- */
-int mm_take_all_locks(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-	struct anon_vma_chain *avc;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_assert_write_locked(mm);
-
-	mutex_lock(&mm_all_locks_mutex);
-
-	/*
-	 * vma_start_write() does not have a complement in mm_drop_all_locks()
-	 * because vma_start_write() is always asymmetrical; it marks a VMA as
-	 * being written to until mmap_write_unlock() or mmap_write_downgrade()
-	 * is reached.
-	 */
-	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
-			goto out_unlock;
-		vma_start_write(vma);
-	}
-
-	vma_iter_init(&vmi, mm, 0);
-	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
-			goto out_unlock;
-		if (vma->vm_file && vma->vm_file->f_mapping &&
-				is_vm_hugetlb_page(vma))
-			vm_lock_mapping(mm, vma->vm_file->f_mapping);
-	}
-
-	vma_iter_init(&vmi, mm, 0);
-	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
-			goto out_unlock;
-		if (vma->vm_file && vma->vm_file->f_mapping &&
-				!is_vm_hugetlb_page(vma))
-			vm_lock_mapping(mm, vma->vm_file->f_mapping);
-	}
-
-	vma_iter_init(&vmi, mm, 0);
-	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
-			goto out_unlock;
-		if (vma->anon_vma)
-			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-				vm_lock_anon_vma(mm, avc->anon_vma);
-	}
-
-	return 0;
-
-out_unlock:
-	mm_drop_all_locks(mm);
-	return -EINTR;
-}
-
-static void vm_unlock_anon_vma(struct anon_vma *anon_vma)
-{
-	if (test_bit(0, (unsigned long *) &anon_vma->root->rb_root.rb_root.rb_node)) {
-		/*
-		 * The LSB of head.next can't change to 0 from under
-		 * us because we hold the mm_all_locks_mutex.
-		 *
-		 * We must however clear the bitflag before unlocking
-		 * the vma so the users using the anon_vma->rb_root will
-		 * never see our bitflag.
-		 *
-		 * No need of atomic instructions here, head.next
-		 * can't change from under us until we release the
-		 * anon_vma->root->rwsem.
-		 */
-		if (!__test_and_clear_bit(0, (unsigned long *)
-					  &anon_vma->root->rb_root.rb_root.rb_node))
-			BUG();
-		anon_vma_unlock_write(anon_vma);
-	}
-}
-
-static void vm_unlock_mapping(struct address_space *mapping)
-{
-	if (test_bit(AS_MM_ALL_LOCKS, &mapping->flags)) {
-		/*
-		 * AS_MM_ALL_LOCKS can't change to 0 from under us
-		 * because we hold the mm_all_locks_mutex.
-		 */
-		i_mmap_unlock_write(mapping);
-		if (!test_and_clear_bit(AS_MM_ALL_LOCKS,
-					&mapping->flags))
-			BUG();
-	}
-}
-
-/*
- * The mmap_lock cannot be released by the caller until
- * mm_drop_all_locks() returns.
- */
-void mm_drop_all_locks(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-	struct anon_vma_chain *avc;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_assert_write_locked(mm);
-	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
-
-	for_each_vma(vmi, vma) {
-		if (vma->anon_vma)
-			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-				vm_unlock_anon_vma(avc->anon_vma);
-		if (vma->vm_file && vma->vm_file->f_mapping)
-			vm_unlock_mapping(vma->vm_file->f_mapping);
-	}
-
-	mutex_unlock(&mm_all_locks_mutex);
-}
-
 /*
  * initialise the percpu counter for VM
  */
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 8982e6139d07..fc18fe274505 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -19,6 +19,8 @@
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 
+#include "vma.h"
+
 /* global SRCU for all MMs */
 DEFINE_STATIC_SRCU(srcu);
 
diff --git a/mm/vma.c b/mm/vma.c
new file mode 100644
index 000000000000..bf0546fe6eab
--- /dev/null
+++ b/mm/vma.c
@@ -0,0 +1,1766 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * VMA-specific functions.
+ */
+
+#include "vma_internal.h"
+#include "vma.h"
+
+/*
+ * If the vma has a ->close operation then the driver probably needs to release
+ * per-vma resources, so we don't attempt to merge those if the caller indicates
+ * the current vma may be removed as part of the merge.
+ */
+static inline bool is_mergeable_vma(struct vm_area_struct *vma,
+		struct file *file, unsigned long vm_flags,
+		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		struct anon_vma_name *anon_name, bool may_remove_vma)
+{
+	/*
+	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
+	 * match the flags but dirty bit -- the caller should mark
+	 * merged VMA as dirty. If dirty bit won't be excluded from
+	 * comparison, we increase pressure on the memory system forcing
+	 * the kernel to generate new VMAs when old one could be
+	 * extended instead.
+	 */
+	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
+		return false;
+	if (vma->vm_file != file)
+		return false;
+	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
+		return false;
+	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
+		return false;
+	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
+		return false;
+	return true;
+}
+
+static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
+		 struct anon_vma *anon_vma2, struct vm_area_struct *vma)
+{
+	/*
+	 * The list_is_singular() test is to avoid merging VMA cloned from
+	 * parents. This can improve scalability caused by anon_vma lock.
+	 */
+	if ((!anon_vma1 || !anon_vma2) && (!vma ||
+		list_is_singular(&vma->anon_vma_chain)))
+		return true;
+	return anon_vma1 == anon_vma2;
+}
+
+/*
+ * init_multi_vma_prep() - Initializer for struct vma_prepare
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ * @next: The next vma if it is to be adjusted
+ * @remove: The first vma to be removed
+ * @remove2: The second vma to be removed
+ */
+static void init_multi_vma_prep(struct vma_prepare *vp,
+				struct vm_area_struct *vma,
+				struct vm_area_struct *next,
+				struct vm_area_struct *remove,
+				struct vm_area_struct *remove2)
+{
+	memset(vp, 0, sizeof(struct vma_prepare));
+	vp->vma = vma;
+	vp->anon_vma = vma->anon_vma;
+	vp->remove = remove;
+	vp->remove2 = remove2;
+	vp->adj_next = next;
+	if (!vp->anon_vma && next)
+		vp->anon_vma = next->anon_vma;
+
+	vp->file = vma->vm_file;
+	if (vp->file)
+		vp->mapping = vma->vm_file->f_mapping;
+
+}
+
+/*
+ * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
+ * in front of (at a lower virtual address and file offset than) the vma.
+ *
+ * We cannot merge two vmas if they have differently assigned (non-NULL)
+ * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
+ *
+ * We don't check here for the merged mmap wrapping around the end of pagecache
+ * indices (16TB on ia32) because do_mmap() does not permit mmap's which
+ * wrap, nor mmaps which cover the final page at index -1UL.
+ *
+ * We assume the vma may be removed as part of the merge.
+ */
+bool
+can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
+		struct anon_vma *anon_vma, struct file *file,
+		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		struct anon_vma_name *anon_name)
+{
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
+	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
+		if (vma->vm_pgoff == vm_pgoff)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
+ * beyond (at a higher virtual address and file offset than) the vma.
+ *
+ * We cannot merge two vmas if they have differently assigned (non-NULL)
+ * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
+ *
+ * We assume that vma is not removed as part of the merge.
+ */
+bool
+can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
+		struct anon_vma *anon_vma, struct file *file,
+		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		struct anon_vma_name *anon_name)
+{
+	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
+	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
+		pgoff_t vm_pglen;
+
+		vm_pglen = vma_pages(vma);
+		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Close a vm structure and free it.
+ */
+void remove_vma(struct vm_area_struct *vma, bool unreachable)
+{
+	might_sleep();
+	if (vma->vm_ops && vma->vm_ops->close)
+		vma->vm_ops->close(vma);
+	if (vma->vm_file)
+		fput(vma->vm_file);
+	mpol_put(vma_policy(vma));
+	if (unreachable)
+		__vm_area_free(vma);
+	else
+		vm_area_free(vma);
+}
+
+/*
+ * Get rid of page table information in the indicated region.
+ *
+ * Called with the mm semaphore held.
+ */
+void unmap_region(struct mm_struct *mm, struct ma_state *mas,
+		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
+{
+	struct mmu_gather tlb;
+	unsigned long mt_start = mas->index;
+
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, mm);
+	update_hiwater_rss(mm);
+	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
+	mas_set(mas, mt_start);
+	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+				 next ? next->vm_start : USER_PGTABLES_CEILING,
+				 mm_wr_locked);
+	tlb_finish_mmu(&tlb);
+}
+
+/*
+ * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
+ * has already been checked or doesn't make sense to fail.
+ * VMA Iterator will point to the end VMA.
+ */
+static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		       unsigned long addr, int new_below)
+{
+	struct vma_prepare vp;
+	struct vm_area_struct *new;
+	int err;
+
+	WARN_ON(vma->vm_start >= addr);
+	WARN_ON(vma->vm_end <= addr);
+
+	if (vma->vm_ops && vma->vm_ops->may_split) {
+		err = vma->vm_ops->may_split(vma, addr);
+		if (err)
+			return err;
+	}
+
+	new = vm_area_dup(vma);
+	if (!new)
+		return -ENOMEM;
+
+	if (new_below) {
+		new->vm_end = addr;
+	} else {
+		new->vm_start = addr;
+		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
+	}
+
+	err = -ENOMEM;
+	vma_iter_config(vmi, new->vm_start, new->vm_end);
+	if (vma_iter_prealloc(vmi, new))
+		goto out_free_vma;
+
+	err = vma_dup_policy(vma, new);
+	if (err)
+		goto out_free_vmi;
+
+	err = anon_vma_clone(new, vma);
+	if (err)
+		goto out_free_mpol;
+
+	if (new->vm_file)
+		get_file(new->vm_file);
+
+	if (new->vm_ops && new->vm_ops->open)
+		new->vm_ops->open(new);
+
+	vma_start_write(vma);
+	vma_start_write(new);
+
+	init_vma_prep(&vp, vma);
+	vp.insert = new;
+	vma_prepare(&vp);
+	vma_adjust_trans_huge(vma, vma->vm_start, addr, 0);
+
+	if (new_below) {
+		vma->vm_start = addr;
+		vma->vm_pgoff += (addr - new->vm_start) >> PAGE_SHIFT;
+	} else {
+		vma->vm_end = addr;
+	}
+
+	/* vma_complete stores the new vma */
+	vma_complete(&vp, vmi, vma->vm_mm);
+
+	/* Success. */
+	if (new_below)
+		vma_next(vmi);
+	return 0;
+
+out_free_mpol:
+	mpol_put(vma_policy(new));
+out_free_vmi:
+	vma_iter_free(vmi);
+out_free_vma:
+	vm_area_free(new);
+	return err;
+}
+
+/*
+ * Split a vma into two pieces at address 'addr', a new vma is allocated
+ * either for the first part or the tail.
+ */
+static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		     unsigned long addr, int new_below)
+{
+	if (vma->vm_mm->map_count >= sysctl_max_map_count)
+		return -ENOMEM;
+
+	return __split_vma(vmi, vma, addr, new_below);
+}
+
+/*
+ * Ok - we have the memory areas we should free on a maple tree so release them,
+ * and do the vma updates.
+ *
+ * Called with the mm semaphore held.
+ */
+static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
+{
+	unsigned long nr_accounted = 0;
+	struct vm_area_struct *vma;
+
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	mas_for_each(mas, vma, ULONG_MAX) {
+		long nrpages = vma_pages(vma);
+
+		if (vma->vm_flags & VM_ACCOUNT)
+			nr_accounted += nrpages;
+		vm_stat_account(mm, vma->vm_flags, -nrpages);
+		remove_vma(vma, false);
+	}
+	vm_unacct_memory(nr_accounted);
+}
+
+/*
+ * init_vma_prep() - Initializer wrapper for vma_prepare struct
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ */
+void init_vma_prep(struct vma_prepare *vp,
+		   struct vm_area_struct *vma)
+{
+	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
+}
+
+/*
+ * Requires inode->i_mapping->i_mmap_rwsem
+ */
+static void __remove_shared_vm_struct(struct vm_area_struct *vma,
+				      struct address_space *mapping)
+{
+	if (vma_is_shared_maywrite(vma))
+		mapping_unmap_writable(mapping);
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_remove(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
+}
+
+/*
+ * vma has some anon_vma assigned, and is already inserted on that
+ * anon_vma's interval trees.
+ *
+ * Before updating the vma's vm_start / vm_end / vm_pgoff fields, the
+ * vma must be removed from the anon_vma's interval trees using
+ * anon_vma_interval_tree_pre_update_vma().
+ *
+ * After the update, the vma will be reinserted using
+ * anon_vma_interval_tree_post_update_vma().
+ *
+ * The entire update must be protected by exclusive mmap_lock and by
+ * the root anon_vma's mutex.
+ */
+void
+anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma)
+{
+	struct anon_vma_chain *avc;
+
+	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
+		anon_vma_interval_tree_remove(avc, &avc->anon_vma->rb_root);
+}
+
+void
+anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
+{
+	struct anon_vma_chain *avc;
+
+	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
+		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
+}
+
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
+{
+	if (vma_is_shared_maywrite(vma))
+		mapping_allow_writable(mapping);
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
+}
+
+/*
+ * vma_prepare() - Helper function for handling locking VMAs prior to altering
+ * @vp: The initialized vma_prepare struct
+ */
+void vma_prepare(struct vma_prepare *vp)
+{
+	if (vp->file) {
+		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
+
+		if (vp->adj_next)
+			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
+				      vp->adj_next->vm_end);
+
+		i_mmap_lock_write(vp->mapping);
+		if (vp->insert && vp->insert->vm_file) {
+			/*
+			 * Put into interval tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(vp->insert,
+					vp->insert->vm_file->f_mapping);
+		}
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_lock_write(vp->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
+	}
+
+	if (vp->file) {
+		flush_dcache_mmap_lock(vp->mapping);
+		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
+		if (vp->adj_next)
+			vma_interval_tree_remove(vp->adj_next,
+						 &vp->mapping->i_mmap);
+	}
+
+}
+
+/*
+ * dup_anon_vma() - Helper function to duplicate anon_vma
+ * @dst: The destination VMA
+ * @src: The source VMA
+ * @dup: Pointer to the destination VMA when successful.
+ *
+ * Returns: 0 on success.
+ */
+static int dup_anon_vma(struct vm_area_struct *dst,
+			struct vm_area_struct *src, struct vm_area_struct **dup)
+{
+	/*
+	 * Easily overlooked: when mprotect shifts the boundary, make sure the
+	 * expanding vma has anon_vma set if the shrinking vma had, to cover any
+	 * anon pages imported.
+	 */
+	if (src->anon_vma && !dst->anon_vma) {
+		int ret;
+
+		vma_assert_write_locked(dst);
+		dst->anon_vma = src->anon_vma;
+		ret = anon_vma_clone(dst, src);
+		if (ret)
+			return ret;
+
+		*dup = dst;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+void validate_mm(struct mm_struct *mm)
+{
+	int bug = 0;
+	int i = 0;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mt_validate(&mm->mm_mt);
+	for_each_vma(vmi, vma) {
+#ifdef CONFIG_DEBUG_VM_RB
+		struct anon_vma *anon_vma = vma->anon_vma;
+		struct anon_vma_chain *avc;
+#endif
+		unsigned long vmi_start, vmi_end;
+		bool warn = 0;
+
+		vmi_start = vma_iter_addr(&vmi);
+		vmi_end = vma_iter_end(&vmi);
+		if (VM_WARN_ON_ONCE_MM(vma->vm_end != vmi_end, mm))
+			warn = 1;
+
+		if (VM_WARN_ON_ONCE_MM(vma->vm_start != vmi_start, mm))
+			warn = 1;
+
+		if (warn) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+			dump_vma(vma);
+			pr_emerg("tree range: %px start %lx end %lx\n", vma,
+				 vmi_start, vmi_end - 1);
+			vma_iter_dump_tree(&vmi);
+		}
+
+#ifdef CONFIG_DEBUG_VM_RB
+		if (anon_vma) {
+			anon_vma_lock_read(anon_vma);
+			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
+				anon_vma_interval_tree_verify(avc);
+			anon_vma_unlock_read(anon_vma);
+		}
+#endif
+		i++;
+	}
+	if (i != mm->map_count) {
+		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
+		bug = 1;
+	}
+	VM_BUG_ON_MM(bug, mm);
+}
+#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
+
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @vmi: The vma iterator
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Will
+ * expand over @next if it's different from @vma and @end == @next->vm_end.
+ * Checking if the @vma can expand and merge with @next needs to be handled by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff,
+	       struct vm_area_struct *next)
+{
+	struct vm_area_struct *anon_dup = NULL;
+	bool remove_next = false;
+	struct vma_prepare vp;
+
+	vma_start_write(vma);
+	if (next && (vma != next) && (end == next->vm_end)) {
+		int ret;
+
+		remove_next = true;
+		vma_start_write(next);
+		ret = dup_anon_vma(vma, next, &anon_dup);
+		if (ret)
+			return ret;
+	}
+
+	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_WARN_ON(next && !vp.remove &&
+		  next != vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
+
+	/* Note: vma iterator must be pointing to 'start' */
+	vma_iter_config(vmi, start, end);
+	if (vma_iter_prealloc(vmi, vma))
+		goto nomem;
+
+	vma_prepare(&vp);
+	vma_adjust_trans_huge(vma, start, end, 0);
+	vma_set_range(vma, start, end, pgoff);
+	vma_iter_store(vmi, vma);
+
+	vma_complete(&vp, vmi, vma->vm_mm);
+	return 0;
+
+nomem:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+	return -ENOMEM;
+}
+
+/*
+ * vma_shrink() - Reduce an existing VMAs memory area
+ * @vmi: The vma iterator
+ * @vma: The VMA to modify
+ * @start: The new start
+ * @end: The new end
+ *
+ * Returns: 0 on success, -ENOMEM otherwise
+ */
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff)
+{
+	struct vma_prepare vp;
+
+	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
+
+	if (vma->vm_start < start)
+		vma_iter_config(vmi, vma->vm_start, start);
+	else
+		vma_iter_config(vmi, end, vma->vm_end);
+
+	if (vma_iter_prealloc(vmi, NULL))
+		return -ENOMEM;
+
+	vma_start_write(vma);
+
+	init_vma_prep(&vp, vma);
+	vma_prepare(&vp);
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	vma_iter_clear(vmi);
+	vma_set_range(vma, start, end, pgoff);
+	vma_complete(&vp, vmi, vma->vm_mm);
+	return 0;
+}
+
+/*
+ * vma_complete- Helper function for handling the unlocking after altering VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+void vma_complete(struct vma_prepare *vp,
+		  struct vma_iterator *vmi, struct mm_struct *mm)
+{
+	if (vp->file) {
+		if (vp->adj_next)
+			vma_interval_tree_insert(vp->adj_next,
+						 &vp->mapping->i_mmap);
+		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
+		flush_dcache_mmap_unlock(vp->mapping);
+	}
+
+	if (vp->remove && vp->file) {
+		__remove_shared_vm_struct(vp->remove, vp->mapping);
+		if (vp->remove2)
+			__remove_shared_vm_struct(vp->remove2, vp->mapping);
+	} else if (vp->insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		vma_iter_store(vmi, vp->insert);
+		mm->map_count++;
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_post_update_vma(vp->adj_next);
+		anon_vma_unlock_write(vp->anon_vma);
+	}
+
+	if (vp->file) {
+		i_mmap_unlock_write(vp->mapping);
+		uprobe_mmap(vp->vma);
+
+		if (vp->adj_next)
+			uprobe_mmap(vp->adj_next);
+	}
+
+	if (vp->remove) {
+again:
+		vma_mark_detached(vp->remove, true);
+		if (vp->file) {
+			uprobe_munmap(vp->remove, vp->remove->vm_start,
+				      vp->remove->vm_end);
+			fput(vp->file);
+		}
+		if (vp->remove->anon_vma)
+			anon_vma_merge(vp->vma, vp->remove);
+		mm->map_count--;
+		mpol_put(vma_policy(vp->remove));
+		if (!vp->remove2)
+			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
+		vm_area_free(vp->remove);
+
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we are removing both mid and next vmas
+		 */
+		if (vp->remove2) {
+			vp->remove = vp->remove2;
+			vp->remove2 = NULL;
+			goto again;
+		}
+	}
+	if (vp->insert && vp->file)
+		uprobe_mmap(vp->insert);
+	validate_mm(mm);
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock)
+{
+	struct vm_area_struct *prev, *next = NULL;
+	struct maple_tree mt_detach;
+	int count = 0;
+	int error = -ENOMEM;
+	unsigned long locked_vm = 0;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+
+	/*
+	 * If we need to split any vma, do it now to save pain later.
+	 *
+	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
+	 * unmapped vm_area_struct will remain in use: so lower split_vma
+	 * places tmp vma above, and higher split_vma places tmp vma below.
+	 */
+
+	/* Does it split the first one? */
+	if (start > vma->vm_start) {
+
+		/*
+		 * Make sure that map_count on return from munmap() will
+		 * not exceed its limit; but let map_count go just above
+		 * its limit temporarily, to help free resources as expected.
+		 */
+		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+			goto map_count_exceeded;
+
+		error = __split_vma(vmi, vma, start, 1);
+		if (error)
+			goto start_split_failed;
+	}
+
+	/*
+	 * Detach a range of VMAs from the mm. Using next as a temp variable as
+	 * it is always overwritten.
+	 */
+	next = vma;
+	do {
+		/* Does it split the end? */
+		if (next->vm_end > end) {
+			error = __split_vma(vmi, next, end, 0);
+			if (error)
+				goto end_split_failed;
+		}
+		vma_start_write(next);
+		mas_set(&mas_detach, count);
+		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		if (error)
+			goto munmap_gather_failed;
+		vma_mark_detached(next, true);
+		if (next->vm_flags & VM_LOCKED)
+			locked_vm += vma_pages(next);
+
+		count++;
+		if (unlikely(uf)) {
+			/*
+			 * If userfaultfd_unmap_prep returns an error the vmas
+			 * will remain split, but userland will get a
+			 * highly unexpected error anyway. This is no
+			 * different than the case where the first of the two
+			 * __split_vma fails, but we don't undo the first
+			 * split, despite we could. This is unlikely enough
+			 * failure that it's not worth optimizing it for.
+			 */
+			error = userfaultfd_unmap_prep(next, start, end, uf);
+
+			if (error)
+				goto userfaultfd_error;
+		}
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+		BUG_ON(next->vm_start < start);
+		BUG_ON(next->vm_start > end);
+#endif
+	} for_each_vma_range(*vmi, next, end);
+
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	/* Make sure no VMAs are about to be lost. */
+	{
+		MA_STATE(test, &mt_detach, 0, 0);
+		struct vm_area_struct *vma_mas, *vma_test;
+		int test_count = 0;
+
+		vma_iter_set(vmi, start);
+		rcu_read_lock();
+		vma_test = mas_find(&test, count - 1);
+		for_each_vma_range(*vmi, vma_mas, end) {
+			BUG_ON(vma_mas != vma_test);
+			test_count++;
+			vma_test = mas_next(&test, count - 1);
+		}
+		rcu_read_unlock();
+		BUG_ON(count != test_count);
+	}
+#endif
+
+	while (vma_iter_addr(vmi) > start)
+		vma_iter_prev_range(vmi);
+
+	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
+	if (error)
+		goto clear_tree_failed;
+
+	/* Point of no return */
+	mm->locked_vm -= locked_vm;
+	mm->map_count -= count;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(&mas_detach, 1);
+	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(&mas_detach, 0);
+	remove_mt(mm, &mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(&mt_detach);
+	return 0;
+
+clear_tree_failed:
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	mas_set(&mas_detach, 0);
+	mas_for_each(&mas_detach, next, end)
+		vma_mark_detached(next, false);
+
+	__mt_destroy(&mt_detach);
+start_split_failed:
+map_count_exceeded:
+	validate_mm(mm);
+	return error;
+}
+
+/*
+ * do_vmi_munmap() - munmap a given range.
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: set to true if the user wants to drop the mmap_lock on success
+ *
+ * This function takes a @mas that is either pointing to the previous VMA or set
+ * to MA_START and sets it up to remove the mapping(s).  The @len will be
+ * aligned and any arch_unmap work will be preformed.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool unlock)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
+		return -EINVAL;
+
+	end = start + PAGE_ALIGN(len);
+	if (end == start)
+		return -EINVAL;
+
+	/*
+	 * Check if memory is sealed before arch_unmap.
+	 * Prevent unmapping a sealed VMA.
+	 * can_modify_mm assumes we have acquired the lock on MM.
+	 */
+	if (unlikely(!can_modify_mm(mm, start, end)))
+		return -EPERM;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma = vma_find(vmi, end);
+	if (!vma) {
+		if (unlock)
+			mmap_write_unlock(mm);
+		return 0;
+	}
+
+	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
+}
+
+/*
+ * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
+ * figure out whether that can be merged with its predecessor or its
+ * successor.  Or both (it neatly fills a hole).
+ *
+ * In most cases - when called for mmap, brk or mremap - [addr,end) is
+ * certain not to be mapped by the time vma_merge is called; but when
+ * called for mprotect, it is certain to be already mapped (either at
+ * an offset within prev, or at the start of next), and the flags of
+ * this area are about to be changed to vm_flags - and the no-change
+ * case has already been eliminated.
+ *
+ * The following mprotect cases have to be considered, where **** is
+ * the area passed down from mprotect_fixup, never extending beyond one
+ * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
+ * at the same address as **** and is of the same or larger span, and
+ * NNNN the next vma after ****:
+ *
+ *     ****             ****                   ****
+ *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
+ *    cannot merge    might become       might become
+ *                    PPNNNNNNNNNN       PPPPPPPPPPCC
+ *    mmap, brk or    case 4 below       case 5 below
+ *    mremap move:
+ *                        ****               ****
+ *                    PPPP    NNNN       PPPPCCCCNNNN
+ *                    might become       might become
+ *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
+ *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
+ *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
+ *
+ * It is important for case 8 that the vma CCCC overlapping the
+ * region **** is never going to extended over NNNN. Instead NNNN must
+ * be extended in region **** and CCCC must be removed. This way in
+ * all cases where vma_merge succeeds, the moment vma_merge drops the
+ * rmap_locks, the properties of the merged vma will be already
+ * correct for the whole merged range. Some of those properties like
+ * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
+ * be correct for the whole merged range immediately after the
+ * rmap_locks are released. Otherwise if NNNN would be removed and
+ * CCCC would be extended over the NNNN range, remove_migration_ptes
+ * or other rmap walkers (if working on addresses beyond the "end"
+ * parameter) may establish ptes with the wrong permissions of CCCC
+ * instead of the right permissions of NNNN.
+ *
+ * In the code below:
+ * PPPP is represented by *prev
+ * CCCC is represented by *curr or not represented at all (NULL)
+ * NNNN is represented by *next or not represented at all (NULL)
+ * **** is not represented - it will be merged and the vma containing the
+ *      area is returned, or the function will return NULL
+ */
+static struct vm_area_struct
+*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
+	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
+	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
+	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+	   struct anon_vma_name *anon_name)
+{
+	struct mm_struct *mm = src->vm_mm;
+	struct anon_vma *anon_vma = src->anon_vma;
+	struct file *file = src->vm_file;
+	struct vm_area_struct *curr, *next, *res;
+	struct vm_area_struct *vma, *adjust, *remove, *remove2;
+	struct vm_area_struct *anon_dup = NULL;
+	struct vma_prepare vp;
+	pgoff_t vma_pgoff;
+	int err = 0;
+	bool merge_prev = false;
+	bool merge_next = false;
+	bool vma_expanded = false;
+	unsigned long vma_start = addr;
+	unsigned long vma_end = end;
+	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
+	long adj_start = 0;
+
+	/*
+	 * We later require that vma->vm_flags == vm_flags,
+	 * so this tests vma->vm_flags & VM_SPECIAL, too.
+	 */
+	if (vm_flags & VM_SPECIAL)
+		return NULL;
+
+	/* Does the input range span an existing VMA? (cases 5 - 8) */
+	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
+
+	if (!curr ||			/* cases 1 - 4 */
+	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
+		next = vma_lookup(mm, end);
+	else
+		next = NULL;		/* case 5 */
+
+	if (prev) {
+		vma_start = prev->vm_start;
+		vma_pgoff = prev->vm_pgoff;
+
+		/* Can we merge the predecessor? */
+		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
+		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
+					   pgoff, vm_userfaultfd_ctx, anon_name)) {
+			merge_prev = true;
+			vma_prev(vmi);
+		}
+	}
+
+	/* Can we merge the successor? */
+	if (next && mpol_equal(policy, vma_policy(next)) &&
+	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
+				 vm_userfaultfd_ctx, anon_name)) {
+		merge_next = true;
+	}
+
+	/* Verify some invariant that must be enforced by the caller. */
+	VM_WARN_ON(prev && addr <= prev->vm_start);
+	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
+	VM_WARN_ON(addr >= end);
+
+	if (!merge_prev && !merge_next)
+		return NULL; /* Not mergeable. */
+
+	if (merge_prev)
+		vma_start_write(prev);
+
+	res = vma = prev;
+	remove = remove2 = adjust = NULL;
+
+	/* Can we merge both the predecessor and the successor? */
+	if (merge_prev && merge_next &&
+	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
+		vma_start_write(next);
+		remove = next;				/* case 1 */
+		vma_end = next->vm_end;
+		err = dup_anon_vma(prev, next, &anon_dup);
+		if (curr) {				/* case 6 */
+			vma_start_write(curr);
+			remove = curr;
+			remove2 = next;
+			/*
+			 * Note that the dup_anon_vma below cannot overwrite err
+			 * since the first caller would do nothing unless next
+			 * has an anon_vma.
+			 */
+			if (!next->anon_vma)
+				err = dup_anon_vma(prev, curr, &anon_dup);
+		}
+	} else if (merge_prev) {			/* case 2 */
+		if (curr) {
+			vma_start_write(curr);
+			if (end == curr->vm_end) {	/* case 7 */
+				/*
+				 * can_vma_merge_after() assumed we would not be
+				 * removing prev vma, so it skipped the check
+				 * for vm_ops->close, but we are removing curr
+				 */
+				if (curr->vm_ops && curr->vm_ops->close)
+					err = -EINVAL;
+				remove = curr;
+			} else {			/* case 5 */
+				adjust = curr;
+				adj_start = (end - curr->vm_start);
+			}
+			if (!err)
+				err = dup_anon_vma(prev, curr, &anon_dup);
+		}
+	} else { /* merge_next */
+		vma_start_write(next);
+		res = next;
+		if (prev && addr < prev->vm_end) {	/* case 4 */
+			vma_start_write(prev);
+			vma_end = addr;
+			adjust = next;
+			adj_start = -(prev->vm_end - addr);
+			err = dup_anon_vma(next, prev, &anon_dup);
+		} else {
+			/*
+			 * Note that cases 3 and 8 are the ONLY ones where prev
+			 * is permitted to be (but is not necessarily) NULL.
+			 */
+			vma = next;			/* case 3 */
+			vma_start = addr;
+			vma_end = next->vm_end;
+			vma_pgoff = next->vm_pgoff - pglen;
+			if (curr) {			/* case 8 */
+				vma_pgoff = curr->vm_pgoff;
+				vma_start_write(curr);
+				remove = curr;
+				err = dup_anon_vma(next, curr, &anon_dup);
+			}
+		}
+	}
+
+	/* Error in anon_vma clone. */
+	if (err)
+		goto anon_vma_fail;
+
+	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
+		vma_expanded = true;
+
+	if (vma_expanded) {
+		vma_iter_config(vmi, vma_start, vma_end);
+	} else {
+		vma_iter_config(vmi, adjust->vm_start + adj_start,
+				adjust->vm_end);
+	}
+
+	if (vma_iter_prealloc(vmi, vma))
+		goto prealloc_fail;
+
+	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
+	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
+		   vp.anon_vma != adjust->anon_vma);
+
+	vma_prepare(&vp);
+	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
+	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
+
+	if (vma_expanded)
+		vma_iter_store(vmi, vma);
+
+	if (adj_start) {
+		adjust->vm_start += adj_start;
+		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
+		if (adj_start < 0) {
+			WARN_ON(vma_expanded);
+			vma_iter_store(vmi, next);
+		}
+	}
+
+	vma_complete(&vp, vmi, mm);
+	khugepaged_enter_vma(res, vm_flags);
+	return res;
+
+prealloc_fail:
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
+anon_vma_fail:
+	vma_iter_set(vmi, addr);
+	vma_iter_load(vmi);
+	return NULL;
+}
+
+/*
+ * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
+ * context and anonymous VMA name within the range [start, end).
+ *
+ * As a result, we might be able to merge the newly modified VMA range with an
+ * adjacent VMA with identical properties.
+ *
+ * If no merge is possible and the range does not span the entirety of the VMA,
+ * we then need to split the VMA to accommodate the change.
+ *
+ * The function returns either the merged VMA, the original VMA if a split was
+ * required instead, or an error if the split failed.
+ */
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name)
+{
+	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	struct vm_area_struct *merged;
+
+	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
+			   pgoff, policy, uffd_ctx, anon_name);
+	if (merged)
+		return merged;
+
+	if (vma->vm_start < start) {
+		int err = split_vma(vmi, vma, start, 1);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	if (vma->vm_end > end) {
+		int err = split_vma(vmi, vma, end, 0);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	return vma;
+}
+
+/*
+ * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
+ * must ensure that [start, end) does not overlap any existing VMA.
+ */
+struct vm_area_struct
+*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
+		   struct vm_area_struct *vma, unsigned long start,
+		   unsigned long end, pgoff_t pgoff)
+{
+	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
+			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/*
+ * Expand vma by delta bytes, potentially merging with an immediately adjacent
+ * VMA with identical properties.
+ */
+struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
+					struct vm_area_struct *vma,
+					unsigned long delta)
+{
+	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
+
+	/* vma is specified as prev, so case 1 or 2 will apply. */
+	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
+			 vma->vm_flags, pgoff, vma_policy(vma),
+			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
+{
+	vb->count = 0;
+}
+
+static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
+{
+	struct address_space *mapping;
+	int i;
+
+	mapping = vb->vmas[0]->vm_file->f_mapping;
+	i_mmap_lock_write(mapping);
+	for (i = 0; i < vb->count; i++) {
+		VM_WARN_ON_ONCE(vb->vmas[i]->vm_file->f_mapping != mapping);
+		__remove_shared_vm_struct(vb->vmas[i], mapping);
+	}
+	i_mmap_unlock_write(mapping);
+
+	unlink_file_vma_batch_init(vb);
+}
+
+void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
+			       struct vm_area_struct *vma)
+{
+	if (vma->vm_file == NULL)
+		return;
+
+	if ((vb->count > 0 && vb->vmas[0]->vm_file != vma->vm_file) ||
+	    vb->count == ARRAY_SIZE(vb->vmas))
+		unlink_file_vma_batch_process(vb);
+
+	vb->vmas[vb->count] = vma;
+	vb->count++;
+}
+
+void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
+{
+	if (vb->count > 0)
+		unlink_file_vma_batch_process(vb);
+}
+
+/*
+ * Unlink a file-based vm structure from its interval tree, to hide
+ * vma from rmap and vmtruncate before freeing its page tables.
+ */
+void unlink_file_vma(struct vm_area_struct *vma)
+{
+	struct file *file = vma->vm_file;
+
+	if (file) {
+		struct address_space *mapping = file->f_mapping;
+
+		i_mmap_lock_write(mapping);
+		__remove_shared_vm_struct(vma, mapping);
+		i_mmap_unlock_write(mapping);
+	}
+}
+
+void vma_link_file(struct vm_area_struct *vma)
+{
+	struct file *file = vma->vm_file;
+	struct address_space *mapping;
+
+	if (file) {
+		mapping = file->f_mapping;
+		i_mmap_lock_write(mapping);
+		__vma_link_file(vma, mapping);
+		i_mmap_unlock_write(mapping);
+	}
+}
+
+int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	VMA_ITERATOR(vmi, mm, 0);
+
+	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
+		return -ENOMEM;
+
+	vma_start_write(vma);
+	vma_iter_store(&vmi, vma);
+	vma_link_file(vma);
+	mm->map_count++;
+	validate_mm(mm);
+	return 0;
+}
+
+/*
+ * Copy the vma structure to a new location in the same mm,
+ * prior to moving page table entries, to effect an mremap move.
+ */
+struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
+	unsigned long addr, unsigned long len, pgoff_t pgoff,
+	bool *need_rmap_locks)
+{
+	struct vm_area_struct *vma = *vmap;
+	unsigned long vma_start = vma->vm_start;
+	struct mm_struct *mm = vma->vm_mm;
+	struct vm_area_struct *new_vma, *prev;
+	bool faulted_in_anon_vma = true;
+	VMA_ITERATOR(vmi, mm, addr);
+
+	/*
+	 * If anonymous vma has not yet been faulted, update new pgoff
+	 * to match new location, to increase its chance of merging.
+	 */
+	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
+		pgoff = addr >> PAGE_SHIFT;
+		faulted_in_anon_vma = false;
+	}
+
+	new_vma = find_vma_prev(mm, addr, &prev);
+	if (new_vma && new_vma->vm_start < addr + len)
+		return NULL;	/* should never get here */
+
+	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
+	if (new_vma) {
+		/*
+		 * Source vma may have been merged into new_vma
+		 */
+		if (unlikely(vma_start >= new_vma->vm_start &&
+			     vma_start < new_vma->vm_end)) {
+			/*
+			 * The only way we can get a vma_merge with
+			 * self during an mremap is if the vma hasn't
+			 * been faulted in yet and we were allowed to
+			 * reset the dst vma->vm_pgoff to the
+			 * destination address of the mremap to allow
+			 * the merge to happen. mremap must change the
+			 * vm_pgoff linearity between src and dst vmas
+			 * (in turn preventing a vma_merge) to be
+			 * safe. It is only safe to keep the vm_pgoff
+			 * linear if there are no pages mapped yet.
+			 */
+			VM_BUG_ON_VMA(faulted_in_anon_vma, new_vma);
+			*vmap = vma = new_vma;
+		}
+		*need_rmap_locks = (new_vma->vm_pgoff <= vma->vm_pgoff);
+	} else {
+		new_vma = vm_area_dup(vma);
+		if (!new_vma)
+			goto out;
+		vma_set_range(new_vma, addr, addr + len, pgoff);
+		if (vma_dup_policy(vma, new_vma))
+			goto out_free_vma;
+		if (anon_vma_clone(new_vma, vma))
+			goto out_free_mempol;
+		if (new_vma->vm_file)
+			get_file(new_vma->vm_file);
+		if (new_vma->vm_ops && new_vma->vm_ops->open)
+			new_vma->vm_ops->open(new_vma);
+		if (vma_link(mm, new_vma))
+			goto out_vma_link;
+		*need_rmap_locks = false;
+	}
+	return new_vma;
+
+out_vma_link:
+	if (new_vma->vm_ops && new_vma->vm_ops->close)
+		new_vma->vm_ops->close(new_vma);
+
+	if (new_vma->vm_file)
+		fput(new_vma->vm_file);
+
+	unlink_anon_vmas(new_vma);
+out_free_mempol:
+	mpol_put(vma_policy(new_vma));
+out_free_vma:
+	vm_area_free(new_vma);
+out:
+	return NULL;
+}
+
+/*
+ * Rough compatibility check to quickly see if it's even worth looking
+ * at sharing an anon_vma.
+ *
+ * They need to have the same vm_file, and the flags can only differ
+ * in things that mprotect may change.
+ *
+ * NOTE! The fact that we share an anon_vma doesn't _have_ to mean that
+ * we can merge the two vma's. For example, we refuse to merge a vma if
+ * there is a vm_ops->close() function, because that indicates that the
+ * driver is doing some kind of reference counting. But that doesn't
+ * really matter for the anon_vma sharing case.
+ */
+static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *b)
+{
+	return a->vm_end == b->vm_start &&
+		mpol_equal(vma_policy(a), vma_policy(b)) &&
+		a->vm_file == b->vm_file &&
+		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
+		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
+}
+
+/*
+ * Do some basic sanity checking to see if we can re-use the anon_vma
+ * from 'old'. The 'a'/'b' vma's are in VM order - one of them will be
+ * the same as 'old', the other will be the new one that is trying
+ * to share the anon_vma.
+ *
+ * NOTE! This runs with mmap_lock held for reading, so it is possible that
+ * the anon_vma of 'old' is concurrently in the process of being set up
+ * by another page fault trying to merge _that_. But that's ok: if it
+ * is being set up, that automatically means that it will be a singleton
+ * acceptable for merging, so we can do all of this optimistically. But
+ * we do that READ_ONCE() to make sure that we never re-load the pointer.
+ *
+ * IOW: that the "list_is_singular()" test on the anon_vma_chain only
+ * matters for the 'stable anon_vma' case (ie the thing we want to avoid
+ * is to return an anon_vma that is "complex" due to having gone through
+ * a fork).
+ *
+ * We also make sure that the two vma's are compatible (adjacent,
+ * and with the same memory policies). That's all stable, even with just
+ * a read lock on the mmap_lock.
+ */
+static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old,
+					  struct vm_area_struct *a,
+					  struct vm_area_struct *b)
+{
+	if (anon_vma_compatible(a, b)) {
+		struct anon_vma *anon_vma = READ_ONCE(old->anon_vma);
+
+		if (anon_vma && list_is_singular(&old->anon_vma_chain))
+			return anon_vma;
+	}
+	return NULL;
+}
+
+/*
+ * find_mergeable_anon_vma is used by anon_vma_prepare, to check
+ * neighbouring vmas for a suitable anon_vma, before it goes off
+ * to allocate a new anon_vma.  It checks because a repetitive
+ * sequence of mprotects and faults may otherwise lead to distinct
+ * anon_vmas being allocated, preventing vma merge in subsequent
+ * mprotect.
+ */
+struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = NULL;
+	struct vm_area_struct *prev, *next;
+	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_end);
+
+	/* Try next first. */
+	next = vma_iter_load(&vmi);
+	if (next) {
+		anon_vma = reusable_anon_vma(next, vma, next);
+		if (anon_vma)
+			return anon_vma;
+	}
+
+	prev = vma_prev(&vmi);
+	VM_BUG_ON_VMA(prev != vma, vma);
+	prev = vma_prev(&vmi);
+	/* Try prev next. */
+	if (prev)
+		anon_vma = reusable_anon_vma(prev, prev, vma);
+
+	/*
+	 * We might reach here with anon_vma == NULL if we can't find
+	 * any reusable anon_vma.
+	 * There's no absolute need to look only at touching neighbours:
+	 * we could search further afield for "compatible" anon_vmas.
+	 * But it would probably just be a waste of time searching,
+	 * or lead to too many vmas hanging off the same anon_vma.
+	 * We're trying to allow mprotect remerging later on,
+	 * not trying to minimize memory used for anon_vmas.
+	 */
+	return anon_vma;
+}
+
+static bool vm_ops_needs_writenotify(const struct vm_operations_struct *vm_ops)
+{
+	return vm_ops && (vm_ops->page_mkwrite || vm_ops->pfn_mkwrite);
+}
+
+static bool vma_is_shared_writable(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & (VM_WRITE | VM_SHARED)) ==
+		(VM_WRITE | VM_SHARED);
+}
+
+static bool vma_fs_can_writeback(struct vm_area_struct *vma)
+{
+	/* No managed pages to writeback. */
+	if (vma->vm_flags & VM_PFNMAP)
+		return false;
+
+	return vma->vm_file && vma->vm_file->f_mapping &&
+		mapping_can_writeback(vma->vm_file->f_mapping);
+}
+
+/*
+ * Does this VMA require the underlying folios to have their dirty state
+ * tracked?
+ */
+bool vma_needs_dirty_tracking(struct vm_area_struct *vma)
+{
+	/* Only shared, writable VMAs require dirty tracking. */
+	if (!vma_is_shared_writable(vma))
+		return false;
+
+	/* Does the filesystem need to be notified? */
+	if (vm_ops_needs_writenotify(vma->vm_ops))
+		return true;
+
+	/*
+	 * Even if the filesystem doesn't indicate a need for writenotify, if it
+	 * can writeback, dirty tracking is still required.
+	 */
+	return vma_fs_can_writeback(vma);
+}
+
+/*
+ * Some shared mappings will want the pages marked read-only
+ * to track write events. If so, we'll downgrade vm_page_prot
+ * to the private version (using protection_map[] without the
+ * VM_SHARED bit).
+ */
+bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
+{
+	/* If it was private or non-writable, the write bit is already clear */
+	if (!vma_is_shared_writable(vma))
+		return false;
+
+	/* The backer wishes to know when pages are first written to? */
+	if (vm_ops_needs_writenotify(vma->vm_ops))
+		return true;
+
+	/* The open routine did something to the protections that pgprot_modify
+	 * won't preserve? */
+	if (pgprot_val(vm_page_prot) !=
+	    pgprot_val(vm_pgprot_modify(vm_page_prot, vma->vm_flags)))
+		return false;
+
+	/*
+	 * Do we need to track softdirty? hugetlb does not support softdirty
+	 * tracking yet.
+	 */
+	if (vma_soft_dirty_enabled(vma) && !is_vm_hugetlb_page(vma))
+		return true;
+
+	/* Do we need write faults for uffd-wp tracking? */
+	if (userfaultfd_wp(vma))
+		return true;
+
+	/* Can the mapping track the dirty pages? */
+	return vma_fs_can_writeback(vma);
+}
+
+unsigned long count_vma_pages_range(struct mm_struct *mm,
+				    unsigned long addr, unsigned long end)
+{
+	VMA_ITERATOR(vmi, mm, addr);
+	struct vm_area_struct *vma;
+	unsigned long nr_pages = 0;
+
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start = max(addr, vma->vm_start);
+		unsigned long vm_end = min(end, vma->vm_end);
+
+		nr_pages += PHYS_PFN(vm_end - vm_start);
+	}
+
+	return nr_pages;
+}
+
+static DEFINE_MUTEX(mm_all_locks_mutex);
+
+static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
+{
+	if (!test_bit(0, (unsigned long *) &anon_vma->root->rb_root.rb_root.rb_node)) {
+		/*
+		 * The LSB of head.next can't change from under us
+		 * because we hold the mm_all_locks_mutex.
+		 */
+		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_lock);
+		/*
+		 * We can safely modify head.next after taking the
+		 * anon_vma->root->rwsem. If some other vma in this mm shares
+		 * the same anon_vma we won't take it again.
+		 *
+		 * No need of atomic instructions here, head.next
+		 * can't change from under us thanks to the
+		 * anon_vma->root->rwsem.
+		 */
+		if (__test_and_set_bit(0, (unsigned long *)
+				       &anon_vma->root->rb_root.rb_root.rb_node))
+			BUG();
+	}
+}
+
+static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
+{
+	if (!test_bit(AS_MM_ALL_LOCKS, &mapping->flags)) {
+		/*
+		 * AS_MM_ALL_LOCKS can't change from under us because
+		 * we hold the mm_all_locks_mutex.
+		 *
+		 * Operations on ->flags have to be atomic because
+		 * even if AS_MM_ALL_LOCKS is stable thanks to the
+		 * mm_all_locks_mutex, there may be other cpus
+		 * changing other bitflags in parallel to us.
+		 */
+		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
+			BUG();
+		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_lock);
+	}
+}
+
+/*
+ * This operation locks against the VM for all pte/vma/mm related
+ * operations that could ever happen on a certain mm. This includes
+ * vmtruncate, try_to_unmap, and all page faults.
+ *
+ * The caller must take the mmap_lock in write mode before calling
+ * mm_take_all_locks(). The caller isn't allowed to release the
+ * mmap_lock until mm_drop_all_locks() returns.
+ *
+ * mmap_lock in write mode is required in order to block all operations
+ * that could modify pagetables and free pages without need of
+ * altering the vma layout. It's also needed in write mode to avoid new
+ * anon_vmas to be associated with existing vmas.
+ *
+ * A single task can't take more than one mm_take_all_locks() in a row
+ * or it would deadlock.
+ *
+ * The LSB in anon_vma->rb_root.rb_node and the AS_MM_ALL_LOCKS bitflag in
+ * mapping->flags avoid to take the same lock twice, if more than one
+ * vma in this mm is backed by the same anon_vma or address_space.
+ *
+ * We take locks in following order, accordingly to comment at beginning
+ * of mm/rmap.c:
+ *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
+ *     hugetlb mapping);
+ *   - all vmas marked locked
+ *   - all i_mmap_rwsem locks;
+ *   - all anon_vma->rwseml
+ *
+ * We can take all locks within these types randomly because the VM code
+ * doesn't nest them and we protected from parallel mm_take_all_locks() by
+ * mm_all_locks_mutex.
+ *
+ * mm_take_all_locks() and mm_drop_all_locks are expensive operations
+ * that may have to take thousand of locks.
+ *
+ * mm_take_all_locks() can fail if it's interrupted by signals.
+ */
+int mm_take_all_locks(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	struct anon_vma_chain *avc;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mmap_assert_write_locked(mm);
+
+	mutex_lock(&mm_all_locks_mutex);
+
+	/*
+	 * vma_start_write() does not have a complement in mm_drop_all_locks()
+	 * because vma_start_write() is always asymmetrical; it marks a VMA as
+	 * being written to until mmap_write_unlock() or mmap_write_downgrade()
+	 * is reached.
+	 */
+	for_each_vma(vmi, vma) {
+		if (signal_pending(current))
+			goto out_unlock;
+		vma_start_write(vma);
+	}
+
+	vma_iter_init(&vmi, mm, 0);
+	for_each_vma(vmi, vma) {
+		if (signal_pending(current))
+			goto out_unlock;
+		if (vma->vm_file && vma->vm_file->f_mapping &&
+				is_vm_hugetlb_page(vma))
+			vm_lock_mapping(mm, vma->vm_file->f_mapping);
+	}
+
+	vma_iter_init(&vmi, mm, 0);
+	for_each_vma(vmi, vma) {
+		if (signal_pending(current))
+			goto out_unlock;
+		if (vma->vm_file && vma->vm_file->f_mapping &&
+				!is_vm_hugetlb_page(vma))
+			vm_lock_mapping(mm, vma->vm_file->f_mapping);
+	}
+
+	vma_iter_init(&vmi, mm, 0);
+	for_each_vma(vmi, vma) {
+		if (signal_pending(current))
+			goto out_unlock;
+		if (vma->anon_vma)
+			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
+				vm_lock_anon_vma(mm, avc->anon_vma);
+	}
+
+	return 0;
+
+out_unlock:
+	mm_drop_all_locks(mm);
+	return -EINTR;
+}
+
+static void vm_unlock_anon_vma(struct anon_vma *anon_vma)
+{
+	if (test_bit(0, (unsigned long *) &anon_vma->root->rb_root.rb_root.rb_node)) {
+		/*
+		 * The LSB of head.next can't change to 0 from under
+		 * us because we hold the mm_all_locks_mutex.
+		 *
+		 * We must however clear the bitflag before unlocking
+		 * the vma so the users using the anon_vma->rb_root will
+		 * never see our bitflag.
+		 *
+		 * No need of atomic instructions here, head.next
+		 * can't change from under us until we release the
+		 * anon_vma->root->rwsem.
+		 */
+		if (!__test_and_clear_bit(0, (unsigned long *)
+					  &anon_vma->root->rb_root.rb_root.rb_node))
+			BUG();
+		anon_vma_unlock_write(anon_vma);
+	}
+}
+
+static void vm_unlock_mapping(struct address_space *mapping)
+{
+	if (test_bit(AS_MM_ALL_LOCKS, &mapping->flags)) {
+		/*
+		 * AS_MM_ALL_LOCKS can't change to 0 from under us
+		 * because we hold the mm_all_locks_mutex.
+		 */
+		i_mmap_unlock_write(mapping);
+		if (!test_and_clear_bit(AS_MM_ALL_LOCKS,
+					&mapping->flags))
+			BUG();
+	}
+}
+
+/*
+ * The mmap_lock cannot be released by the caller until
+ * mm_drop_all_locks() returns.
+ */
+void mm_drop_all_locks(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	struct anon_vma_chain *avc;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mmap_assert_write_locked(mm);
+	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
+
+	for_each_vma(vmi, vma) {
+		if (vma->anon_vma)
+			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
+				vm_unlock_anon_vma(avc->anon_vma);
+		if (vma->vm_file && vma->vm_file->f_mapping)
+			vm_unlock_mapping(vma->vm_file->f_mapping);
+	}
+
+	mutex_unlock(&mm_all_locks_mutex);
+}
diff --git a/mm/vma.h b/mm/vma.h
new file mode 100644
index 000000000000..6efdf1768a0a
--- /dev/null
+++ b/mm/vma.h
@@ -0,0 +1,364 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * vma.h
+ *
+ * Core VMA manipulation API implemented in vma.c.
+ */
+#ifndef __MM_VMA_H
+#define __MM_VMA_H
+
+/*
+ * VMA lock generalization
+ */
+struct vma_prepare {
+	struct vm_area_struct *vma;
+	struct vm_area_struct *adj_next;
+	struct file *file;
+	struct address_space *mapping;
+	struct anon_vma *anon_vma;
+	struct vm_area_struct *insert;
+	struct vm_area_struct *remove;
+	struct vm_area_struct *remove2;
+};
+
+struct unlink_vma_file_batch {
+	int count;
+	struct vm_area_struct *vmas[8];
+};
+
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+void validate_mm(struct mm_struct *mm);
+#else
+#define validate_mm(mm) do { } while (0)
+#endif
+
+/* Required for expand_downwards(). */
+void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
+
+/* Required for expand_downwards(). */
+void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
+
+/* Required for do_brk_flags(). */
+void vma_prepare(struct vma_prepare *vp);
+
+/* Required for do_brk_flags(). */
+void init_vma_prep(struct vma_prepare *vp,
+		   struct vm_area_struct *vma);
+
+/* Required for do_brk_flags(). */
+void vma_complete(struct vma_prepare *vp,
+		  struct vma_iterator *vmi, struct mm_struct *mm);
+
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff,
+	       struct vm_area_struct *next);
+
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff);
+
+int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock);
+
+int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool unlock);
+
+void remove_vma(struct vm_area_struct *vma, bool unreachable);
+
+void unmap_region(struct mm_struct *mm, struct ma_state *mas,
+		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
+
+/* Required by mmap_region(). */
+bool
+can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
+		struct anon_vma *anon_vma, struct file *file,
+		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		struct anon_vma_name *anon_name);
+
+/* Required by mmap_region() and do_brk_flags(). */
+bool
+can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
+		struct anon_vma *anon_vma, struct file *file,
+		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
+		struct anon_vma_name *anon_name);
+
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name);
+
+/* We are about to modify the VMA's flags. */
+static inline struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
+		  struct vm_area_struct *prev,
+		  struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+static inline struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's memory policy. */
+static inline struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or uffd context. */
+static inline struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
+
+struct vm_area_struct
+*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
+		   struct vm_area_struct *vma, unsigned long start,
+		   unsigned long end, pgoff_t pgoff);
+
+struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
+					struct vm_area_struct *vma,
+					unsigned long delta);
+
+void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb);
+
+void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb);
+
+void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
+			       struct vm_area_struct *vma);
+
+void unlink_file_vma(struct vm_area_struct *vma);
+
+void vma_link_file(struct vm_area_struct *vma);
+
+int vma_link(struct mm_struct *mm, struct vm_area_struct *vma);
+
+struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
+	unsigned long addr, unsigned long len, pgoff_t pgoff,
+	bool *need_rmap_locks);
+
+struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma);
+
+bool vma_needs_dirty_tracking(struct vm_area_struct *vma);
+bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
+
+int mm_take_all_locks(struct mm_struct *mm);
+void mm_drop_all_locks(struct mm_struct *mm);
+unsigned long count_vma_pages_range(struct mm_struct *mm,
+				    unsigned long addr, unsigned long end);
+
+static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
+{
+	/*
+	 * We want to check manually if we can change individual PTEs writable
+	 * if we can't do that automatically for all PTEs in a mapping. For
+	 * private mappings, that's always the case when we have write
+	 * permissions as we properly have to handle COW.
+	 */
+	if (vma->vm_flags & VM_SHARED)
+		return vma_wants_writenotify(vma, vma->vm_page_prot);
+	return !!(vma->vm_flags & VM_WRITE);
+}
+
+#ifdef CONFIG_MMU
+static inline pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
+{
+	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
+}
+#endif
+
+static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
+						    unsigned long min)
+{
+	return mas_prev(&vmi->mas, min);
+}
+
+static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
+			struct vm_area_struct *vma, gfp_t gfp)
+{
+	if (vmi->mas.status != ma_start &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+		vma_iter_invalidate(vmi);
+
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_gfp(&vmi->mas, vma, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+
+/*
+ * These three helpers classifies VMAs for virtual memory accounting.
+ */
+
+/*
+ * Executable code area - executable, not writable, not stack
+ */
+static inline bool is_exec_mapping(vm_flags_t flags)
+{
+	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
+}
+
+/*
+ * Stack area (including shadow stacks)
+ *
+ * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
+ * do_mmap() forbids all other combinations.
+ */
+static inline bool is_stack_mapping(vm_flags_t flags)
+{
+	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+}
+
+/*
+ * Data area - private, writable, not stack
+ */
+static inline bool is_data_mapping(vm_flags_t flags)
+{
+	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
+}
+
+
+static inline void vma_iter_config(struct vma_iterator *vmi,
+		unsigned long index, unsigned long last)
+{
+	__mas_set_range(&vmi->mas, index, last - 1);
+}
+
+static inline void vma_iter_reset(struct vma_iterator *vmi)
+{
+	mas_reset(&vmi->mas);
+}
+
+static inline
+struct vm_area_struct *vma_iter_prev_range_limit(struct vma_iterator *vmi, unsigned long min)
+{
+	return mas_prev_range(&vmi->mas, min);
+}
+
+static inline
+struct vm_area_struct *vma_iter_next_range_limit(struct vma_iterator *vmi, unsigned long max)
+{
+	return mas_next_range(&vmi->mas, max);
+}
+
+static inline int vma_iter_area_lowest(struct vma_iterator *vmi, unsigned long min,
+				       unsigned long max, unsigned long size)
+{
+	return mas_empty_area(&vmi->mas, min, max - 1, size);
+}
+
+static inline int vma_iter_area_highest(struct vma_iterator *vmi, unsigned long min,
+					unsigned long max, unsigned long size)
+{
+	return mas_empty_area_rev(&vmi->mas, min, max - 1, size);
+}
+
+/*
+ * VMA Iterator functions shared between nommu and mmap
+ */
+static inline int vma_iter_prealloc(struct vma_iterator *vmi,
+		struct vm_area_struct *vma)
+{
+	return mas_preallocate(&vmi->mas, vma, GFP_KERNEL);
+}
+
+static inline void vma_iter_clear(struct vma_iterator *vmi)
+{
+	mas_store_prealloc(&vmi->mas, NULL);
+}
+
+static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
+{
+	return mas_walk(&vmi->mas);
+}
+
+/* Store a VMA with preallocated memory */
+static inline void vma_iter_store(struct vma_iterator *vmi,
+				  struct vm_area_struct *vma)
+{
+
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
+			vmi->mas.index > vma->vm_start)) {
+		pr_warn("%lx > %lx\n store vma %lx-%lx\n into slot %lx-%lx\n",
+			vmi->mas.index, vma->vm_start, vma->vm_start,
+			vma->vm_end, vmi->mas.index, vmi->mas.last);
+	}
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
+			vmi->mas.last <  vma->vm_start)) {
+		pr_warn("%lx < %lx\nstore vma %lx-%lx\ninto slot %lx-%lx\n",
+		       vmi->mas.last, vma->vm_start, vma->vm_start, vma->vm_end,
+		       vmi->mas.index, vmi->mas.last);
+	}
+#endif
+
+	if (vmi->mas.status != ma_start &&
+	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
+		vma_iter_invalidate(vmi);
+
+	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_prealloc(&vmi->mas, vma);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+static inline unsigned long vma_iter_end(struct vma_iterator *vmi)
+{
+	return vmi->mas.last + 1;
+}
+
+static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
+				      unsigned long count)
+{
+	return mas_expected_entries(&vmi->mas, count);
+}
+
+static inline
+struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
+{
+	return mas_prev_range(&vmi->mas, 0);
+}
+
+#endif	/* __MM_VMA_H */
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
new file mode 100644
index 000000000000..e13e5950df78
--- /dev/null
+++ b/mm/vma_internal.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * vma_internal.h
+ *
+ * Headers required by vma.c, which can be substituted accordingly when testing
+ * VMA functionality.
+ */
+
+#ifndef __MM_VMA_INTERNAL_H
+#define __MM_VMA_INTERNAL_H
+
+#include <linux/backing-dev.h>
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/bug.h>
+#include <linux/cacheflush.h>
+#include <linux/err.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/huge_mm.h>
+#include <linux/hugetlb_inline.h>
+#include <linux/kernel.h>
+#include <linux/khugepaged.h>
+#include <linux/list.h>
+#include <linux/maple_tree.h>
+#include <linux/mempolicy.h>
+#include <linux/mm.h>
+#include <linux/mm_inline.h>
+#include <linux/mm_types.h>
+#include <linux/mman.h>
+#include <linux/mmap_lock.h>
+#include <linux/mmdebug.h>
+#include <linux/mmu_context.h>
+#include <linux/mutex.h>
+#include <linux/pagemap.h>
+#include <linux/pfn.h>
+#include <linux/rcupdate.h>
+#include <linux/rmap.h>
+#include <linux/rwsem.h>
+#include <linux/sched/signal.h>
+#include <linux/swap.h>
+#include <linux/uprobes.h>
+#include <linux/userfaultfd_k.h>
+
+#include <asm/current.h>
+#include <asm/page_types.h>
+#include <asm/pgtable_types.h>
+#include <asm/tlb.h>
+
+#include "internal.h"
+
+#endif	/* __MM_VMA_INTERNAL_H */
-- 
2.45.2


