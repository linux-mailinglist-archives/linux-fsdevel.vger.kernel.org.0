Return-Path: <linux-fsdevel+bounces-31692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54899A262
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E6F28704C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35632141C7;
	Fri, 11 Oct 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fx5Y6LZ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G89zZ7Bk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2F216A3E;
	Fri, 11 Oct 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644791; cv=fail; b=Alc+N6lw6QxpwNGvDx9YFRVGvNyoUMSIVebZfYkzN8XekS2WwybsB+nGGYqHAZJj/12VgFbAEq0SZQVoRrwS9YBSaPpYBLol/CodL+QwHs2+bAqf14uGchaez2Ul8g/2dHIA1e1seTnreZeo4PcNBxeYQouCS1jco0NE/rCKXjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644791; c=relaxed/simple;
	bh=crBvDB53mKcdWE/b14vL7ki8GPoLhouRy/fOrmcCw90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3/ZJYwvy2M3PtKUaObr/z0Wn+UH8w25xbCSAy28OMUfO2uYuLPJD5vHzR1pki/JlH1E92U2vEd8UNmr1RkyhtFF7liEHn6qdPGzf8Zk36XTTqrxNj6IPA+UBiKz72IoaXvTOYKZUTETolXIGHAf6b+ubOklTuwxPCs+AkCypN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fx5Y6LZ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G89zZ7Bk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8BfSk006323;
	Fri, 11 Oct 2024 11:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YXP4oBBbOFFH5eJ5/mE7kNI6rApLZ6pu5Gss4+TGeF8=; b=
	Fx5Y6LZ3ATP+G237AJMLART6XsbnQfZu6lwXek9eJs21ssdeFbxxkO8pl19tuh6W
	/j8VPbtvd4jsYCje6+VtWMMgb3r2arPD9SNIILjXTzn0dMNJVgmNEjLXybAX7+iB
	FEoF3nCwho1MMoPx/RWuBujAbwPwfPgf7+G+/ITyDKek02oaXO31NYMN/9bsNpcy
	46dQMpuKyk6bKA/CDUyVPxy1uiZe4mL8DeyL6yF1xCWlplak/HU0NPeWtIWtkSKE
	2Ml4EvxHR/XYsOgri1hIct+blYTKt8y/PAST0dSFfp/Zbd7O+/8Mg/c9HEKIQtIj
	s3SE3lnG46RMekQC3foLWg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pmep6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:06:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8sowt020588;
	Fri, 11 Oct 2024 11:06:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwb96y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTZFToNKIM/DdiKK8PMgHpQ3CQGpv3IuL4f4YumhOPy+XBCSZn1fUJMPwB/YFung6DFmIUUjZB3cmcVWy7ObeKQxphRD1HCa7d8riCQ9ndVY0qFp1BPuQuOrLgF3qFs60+JDaFYc8zOrSNWpJIvXYpHO+jDm0Ss4Z3y7f+iRGAH+/XDfQY7LeBfO/MkIwxvzv1e8HvWBVkl3jR+AQtSN7lyWm0mJGYXHrs9S4lHiytz/bbKY7IFaV4CJCexFVdtkcNamD8ZoSUmxnD0wq3rJDcurBUeGn7UtZAE67ldKubgpg4zvKb6FkemHT/0ztE9OW74c+6Ci0LGOQAn2og8DbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXP4oBBbOFFH5eJ5/mE7kNI6rApLZ6pu5Gss4+TGeF8=;
 b=fxITaIlInh+VDePjoBT9X4zT1J/wCPsuQeUwyILcUgDccFg6pJfDCvFSvwnl/IWuxCgxtBOad3zrM9M/grX9EMlJcu7h/sOHoGzpy2M6OQKym7/rcatmp0bRliAxP0VZGwPXsUBZ8yUnE18Ppm53GnRb7lFCfUC5tJQEZyNuAkSIgVME0tWbOzx18vEsEYfR079bpGA42f6TcrN3HkuVO2r97Fm22xryq5adeVb7o3H/GB0O/Z3m7zWgF/3zkUa7EyfhUcurqfYuTDtyJ4amF4BLCiIKp2yMgZRiLzbOT2Yb4G6KHWVpYh618/PjCg0sXc4ZafTUqCDbJMxfnSRuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXP4oBBbOFFH5eJ5/mE7kNI6rApLZ6pu5Gss4+TGeF8=;
 b=G89zZ7Bk3PLzwmV2Li+sLT0cT7hr4/H10MgLgU1n4rDw2DCy1PKax6v4jWntXHMa/l/jkAPSLtIkB3dJADyBJbTxnfE0bT+KPLM6Hy2kLvxVYb3x7iaVRAE2Tag8rvpjYoeiPL6E4IhJ25UJXSrc+WRuPeZ1VAKYT+aOST1MrDU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 11:06:12 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 11:06:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Date: Fri, 11 Oct 2024 12:05:57 +0100
Message-ID: <993cc7b6493e967c6c90b9944e81848de6deeb85.1728643714.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c713d7-4ccb-4b5c-d4c3-08dce9e4b7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbeuINHiXlmOPNah6ABjp6UHikuH2pgWJGL4dxyOsDNuGZk2ysdwESiZoDco?=
 =?us-ascii?Q?u2V993te51+zBceLKT5uxzjuK2PQDfhE1TZK46oQlWMd2VsXdMAs6SiHJfgm?=
 =?us-ascii?Q?JjlTBR3bQatqsNFHYZipnpsmYYkbVU9AyQC8UFwsce/xoNp/LY97WgM8a2W+?=
 =?us-ascii?Q?uorYyZFdDudCEoUan9EXERHCqmlq4cCXaUrNVCyw3VQIdR5HXWAN5AUOKpe3?=
 =?us-ascii?Q?Pms1SIqNArPCy86LgcxUhNt2KHyqgGPX9SLLlf8qlP5bpW/birekfRI47kKv?=
 =?us-ascii?Q?6cjFGIdcMYl26ERafiNirD16kGJ8m/qmFIkJi89zCDSrkdBtcc6/TolhE5sA?=
 =?us-ascii?Q?NOqPoINrga0+IqeorMTOV0YDRqz3S+osGbFTma2id63f/F8305SS8IVEw9lM?=
 =?us-ascii?Q?5niO1YEaCJo9T9b8x+B0rJ/tM2ACLgCqli9C1YhOMz4T1ikkZ1EzalwJPx/h?=
 =?us-ascii?Q?Bbat6qLmIOhXRmq/7KEQdci7oR7awIvKHkWvQ4Vy4fCa/HiEQGs87f5bOv0j?=
 =?us-ascii?Q?3f7pARUuwXMxL6r4albM7OksNMWDig8oxCIUnWyk5LqwL9HtwqdvhfDK0iYP?=
 =?us-ascii?Q?FG+4y+khMWm9PnSShRdXBzF/Uwlkq8Voe1Fnt3mkf/CcY8aHWKM4I2Dp7+We?=
 =?us-ascii?Q?vggBxBKbdWUY13VPguWkBxqJ/EKTRABtfqJOflz4K6eBxSY0opYAX08lMlZF?=
 =?us-ascii?Q?cFWPo6qLNUJMzStZ3xyADyrDw7a/34sWecwby8GWKuPSiUdxa2X7clKL73hK?=
 =?us-ascii?Q?ArbthP17vFM+ITpK4ZoMwx/yBNOLIB7lcFTLH/4lhcA8mDbh9kayV57YCEqu?=
 =?us-ascii?Q?tFf+GT6YDu2ozESjCNP+1eGzQS85C190TBISLJ2bVDf+JWEHkhnddsZxr+ns?=
 =?us-ascii?Q?eJ8i4YLwk1iqnszIaaE3mXrQNKUWwqKtC/+g3GVal21Imds+T76SDTCHd+a7?=
 =?us-ascii?Q?jDhZQQfo07DtR/1FcON7pAGccNNsKZyOjlhKnoO4FVcOCyyv4FUHooZNrbvW?=
 =?us-ascii?Q?s2zUj2T/4Onx0H8BOehuW6a4haweztmyu2Pk8OL5zyNNyzpy/2YzGiFFDtJC?=
 =?us-ascii?Q?+lviOclHykxnWNhNfv582w1/T2gaewJtO15NGgcwqS8vFXl4CWudUgvXF+im?=
 =?us-ascii?Q?Dj9jAUOByG4yXsLghAS93Li3mvlmlbot0r/wv2Z2GGcevtQKJRbw0QuXtbl1?=
 =?us-ascii?Q?QsEFuODbgxoUFPj2Pmf1nDSeYcu3bx4tj05lQDGd9HMWsLUnWEftDkwc4Q85?=
 =?us-ascii?Q?UvC8kH1XrgtMW7swM0WI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xevkg9mlV7VzeNfd0HkLdVBRxlUTuZ1yni+E9wyuLi4hplyFJ2LuyPZ+wAzi?=
 =?us-ascii?Q?RuPxCVRCn/6LGJtVvMGxIhjBqaOiE9NTdvlVecbGuopbGbhpPcT7iGw+olyX?=
 =?us-ascii?Q?DReF2vI1nvAXZMgJBS8kJ8toG+AfUErvTSd59yEWmmAvT30Yit+hPwskaAD2?=
 =?us-ascii?Q?ZwI4Cqafd9Et5mzAjRzpwMrv6jTxXms4lpE4B8nV7pXcbhFVADWQRy+Gjw6L?=
 =?us-ascii?Q?+zYk0umhPhMKzVAXTL55rsh4KV51ts1rap33WVg4ovPewY3R6/rnoRDd4rqz?=
 =?us-ascii?Q?6C384BN7WV8fXsZaWQgcJr/7iZ+b3ryXn1eaV3cgZDgemYKZGBIW3G6HP9h1?=
 =?us-ascii?Q?b37CQPsRsGYKekVBtOcAGxhJ+puUcH8F4oX/xTuvx2yKqtpe80wvsyn2nI7z?=
 =?us-ascii?Q?084IHsCio6am/07cBShsmHjwJI7ZOCajHmJWI9Z0261XMS/E6RzN2r0RY2xy?=
 =?us-ascii?Q?4mZP+/oVHdn1vD1YVwggDYl3EYXx9WU+uBWj7usaVPxXtsRxEQaJkL5W3/ao?=
 =?us-ascii?Q?/tr2XTI0JCZYe+aauL56fmQ1CFHqjGGHGq6eyOwuRXFV5QGAnzlAkoqpRQw9?=
 =?us-ascii?Q?0La+HBthNXE+FXtH8yz1YWmpCIPiDTLeOiPJMD75w2ZE2rlJD0sR6VohgFCL?=
 =?us-ascii?Q?zFhrs1KM17BXLLZiFA9w+pfhjlHd9MCV3470Nc4vvNBuiUuTHnf6GQFz90Nf?=
 =?us-ascii?Q?hdXC2mQpveOY4nGni0FWwAIbeoqF5t/XWYUDXgjFGTKmqzOWyJNiuuIxDbTG?=
 =?us-ascii?Q?YpU68T+QC0ACKUX/E3+zSCDMQfyZMQENnObmAypQapvDa/Tszgjtdija5g5F?=
 =?us-ascii?Q?EAX+XwBln5DD2pRSP4R5oPMtO8eUlHLxwk4R3yrpE4gnwytDAhfyz/9rEMn6?=
 =?us-ascii?Q?8FvCdUwQfsyASPFtQBVnnFQqIg9GdGgRuhS0OFcY2mCD4Oyy7Whj6B1C+f6K?=
 =?us-ascii?Q?vw1utpzovU1kS7K41kf837+oIKNkwmeYU3McczrWDVFmRiPkM+TwydCLAvOM?=
 =?us-ascii?Q?XwmJxEHxPZR/EhEiqtjfU6FoSswbo1xz57KlRbRdRd43pgHp+s/cBW57pDev?=
 =?us-ascii?Q?Gx8MePbd0yRsqgbSVXRlAycOiuUTJV7j6vQeEX9aclmPTQVaq5CwA3T7jmJN?=
 =?us-ascii?Q?e3CDuWIcabcAqFAeFlfQlRQYcUlvl8SxvPtKsKsF0qiamrUCRAKn0opiARRM?=
 =?us-ascii?Q?jejxUrJ7bYzC7GlsxUrYV62z0XFar6evIipaAoQChdtKzvCPLltFqiSPlke2?=
 =?us-ascii?Q?CVG2LZ5/wztzYKVLMq7GprPGNyfN3rAC6p0Qw86vik7DgPxF0TPj5LlnaS7d?=
 =?us-ascii?Q?lk87Kwd4Drd4lcAmg59SC6LnjACIWEUO7uw5JaSdBcj4juy8KGxg1Lyh3py+?=
 =?us-ascii?Q?E9T3bJEKydOkx/Nmqd7mrElMVcHw5mlmJXyFGy3aEYa9P3ZGR9LSGOCUCNK7?=
 =?us-ascii?Q?wVLIAUb5mmnqQeGi/aa/RUGayAcL1qMmGUDyTjYT1yCSxhdZReHuJoVP4BAX?=
 =?us-ascii?Q?ugLD+i22UgQ6kWtphCIIFAacPjG7DnE7+qIHDbvf166dhLcvWZgRG0r9lYYg?=
 =?us-ascii?Q?vhC6fLQLmJYOPn1xCWGqgtZFC8AMJ4y8ZiuJU1efEgz0csNJGosQMVVN4INE?=
 =?us-ascii?Q?ouBwTO+7LjmkUqZgCE3aj3+w2aB854RJwGOMmQb0xRxM7GQ+D4dWr1OJXe4e?=
 =?us-ascii?Q?Wo6ECA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uZS+x+G0xlLJYN14e+oqks9lYvPZIgE1QC+CWMduK90XK+tlb1XLPIbj6jsEpzJLvQk5AoD1GWed8d5snsqFgLIzAEHNX5lK19VhlMLXsQ+z6TuDKL20PR/SPJ/Xfb8n0+1bZY9qjvN1yqI2olV0hkhaAwontqqxh4itoEaNb9IWvyO87BxsIQUF7pRz1fVtQEV0+HSi8JF//oFoprPkUHZDETufxtzbWYCm31qinw9ovy7hJwH3FsPjApBgj+rvH4cuazicHLN6+sov0+UWiNrjjlz4HHJAvin+kL2TZirXs8GRaHr2gJ0t2LI9WDLlJgft1ImgneCTDinrwp8fkley8r72JbC3f1Pup0KNHP2n/xzj67qCq9uxyn1V0StvNal//BAeXT/Fd9r6qivRcnG2hXpwqfpmXS+6c4bHtICLKRfIV3gG/DuzBFR9xQWkRIeeoNp+eihpwla2YofGy6zWRry2uIulyJWYP/kg9VXtbSmgMKWxIUImYKda/4fHtuJ2LvOmgm4jnKhHBfZ3s79zw1vc7dS7ezpnZilpZEQuXr+8Xxn2MKFhJ9TEOIKi9I/+QVZKxRDgQAHSVdDXI7/M7YmXdBpHsWVXLsOCRyk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c713d7-4ccb-4b5c-d4c3-08dce9e4b7b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:06:12.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU/rlA8EuXSvxsiVolwpdCuCfT+701sSsR/fr0elFrwGZaC3PzDG7JaNXxhsTMDJhQe8lEmpNjc8a7GqDpNWodqmi6DSa9AQ+HKQTcKQMG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110076
X-Proofpoint-ORIG-GUID: qZY_x49ofLCaMb_UVUjzXTk0QA5ljD72
X-Proofpoint-GUID: qZY_x49ofLCaMb_UVUjzXTk0QA5ljD72

Add tests to assert that PIDFD_SELF_* correctly refers to the current
thread and process.

This is only practically meaningful to pidfd_send_signal() and
pidfd_getfd(), but also explicitly test that we disallow this feature for
setns() where it would make no sense.

We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.

We defer testing of mm-specific functionality which uses pidfd, namely
process_madvise() and process_mrelease() to mm testing (though note the
latter can not be sensibly tested as it would require the testing process
to be dying).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |   8 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 4 files changed, 224 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..1640b711889b 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -50,6 +50,14 @@
 #define PIDFD_NONBLOCK O_NONBLOCK
 #endif
 
+/* System header file may not have this available. */
+#ifndef PIDFD_SELF_THREAD
+#define PIDFD_SELF_THREAD -100
+#endif
+#ifndef PIDFD_SELF_THREAD_GROUP
+#define PIDFD_SELF_THREAD_GROUP -200
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..48d224b13c01 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -6,6 +6,7 @@
 #include <limits.h>
 #include <linux/types.h>
 #include <poll.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -15,6 +16,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <linux/kcmp.h>
 
@@ -114,6 +116,94 @@ static int child(int sk)
 	return ret;
 }
 
+static int __pidfd_self_thread_worker(unsigned long page_size)
+{
+	int memfd;
+	int newfd;
+	char *ptr;
+	int err = 0;
+
+	/*
+	 * Unshare our FDs so we have our own set. This means
+	 * PIDFD_SELF_THREAD_GROUP will fal.
+	 */
+	if (unshare(CLONE_FILES) < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	/* Truncate, map in and write to our memfd. */
+	memfd = sys_memfd_create("test_self_child", 0);
+	if (memfd < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	if (ftruncate(memfd, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+	ptr[0] = 'y';
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	/* Get a thread-local duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD, memfd, 0);
+	if (newfd < 0) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	if (memfd == newfd) {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	/* Map in new fd and make sure that the data is as expected. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+	if (ptr[0] != 'y') {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+exit_close_fds:
+	close(newfd);
+exit_close_memfd:
+	close(memfd);
+exit:
+	return err;
+}
+
+static void *pidfd_self_thread_worker(void *arg)
+{
+	unsigned long page_size = (unsigned long)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = __pidfd_self_thread_worker(page_size);
+	return (void *)(intptr_t)ret;
+}
+
 FIXTURE(child)
 {
 	/*
@@ -264,6 +354,57 @@ TEST_F(child, no_strange_EBADF)
 	EXPECT_EQ(errno, ESRCH);
 }
 
+TEST(pidfd_self)
+{
+	int memfd = sys_memfd_create("test_self", 0);
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	int newfd;
+	char *ptr;
+	pthread_t thread;
+	void *res;
+	int err;
+
+	ASSERT_GE(memfd, 0);
+	ASSERT_EQ(ftruncate(memfd, page_size), 0);
+
+	/*
+	 * Map so we can assert that the duplicated fd references the same
+	 * memory.
+	 */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr[0] = 'x';
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Now get a duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD_GROUP, memfd, 0);
+	ASSERT_GE(newfd, 0);
+	ASSERT_NE(memfd, newfd);
+
+	/* Now map duplicate fd and make sure it references the same memory. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ASSERT_EQ(ptr[0], 'x');
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Cleanup. */
+	close(memfd);
+	close(newfd);
+
+	/*
+	 * Fire up the thread and assert that we can lookup the thread-specific
+	 * PIDFD_SELF_THREAD (also aliased by PIDFD_SELF).
+	 */
+	ASSERT_EQ(pthread_create(&thread, NULL, pidfd_self_thread_worker,
+				 (void *)page_size), 0);
+	ASSERT_EQ(pthread_join(thread, &res), 0);
+	err = (int)(intptr_t)res;
+
+	ASSERT_EQ(err, 0);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a4349170a..bbd39dc5ceb7 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -752,4 +752,15 @@ TEST(setns_einval)
 	close(fd);
 }
 
+TEST(setns_pidfd_self_disallowed)
+{
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+
+	errno = 0;
+
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD_GROUP, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..440447cf89ba 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static int signal_received;
+static pthread_t signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
 {
 	if (sig == SIGUSR1)
-		signal_received = 1;
+		signal_received = pthread_self();
+}
+
+static int send_signal(int pidfd)
+{
+	int ret = 0;
+
+	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (signal_received != pthread_self()) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	signal_received = 0;
+	return ret;
+}
+
+static void *send_signal_worker(void *arg)
+{
+	int pidfd = (int)(intptr_t)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = send_signal(pidfd);
+	return (void *)(intptr_t)ret;
 }
 
 /*
@@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
  */
 static int test_pidfd_send_signal_simple_success(void)
 {
-	int pidfd, ret;
+	int pidfd;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
+	pthread_t thread;
+	void *thread_res;
+	int err;
 
 	if (!have_pidfd_send_signal) {
 		ksft_test_result_skip(
@@ -66,25 +98,45 @@ static int test_pidfd_send_signal_simple_success(void)
 		return 0;
 	}
 
+	signal(SIGUSR1, set_signal_received_on_sigusr1);
+
+	/* Try sending a signal to ourselves via /proc/self. */
 	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	if (pidfd < 0)
 		ksft_exit_fail_msg(
 			"%s test: Failed to open process file descriptor\n",
 			test_name);
+	err = send_signal(pidfd);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on sending pidfd signal\n",
+			test_name, err);
+	close(pidfd);
 
-	signal(SIGUSR1, set_signal_received_on_sigusr1);
+	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
+	err = send_signal(PIDFD_SELF_THREAD_GROUP);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
+			test_name, err);
 
-	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
-	close(pidfd);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+	/*
+	 * Now try the same thing in a thread and assert thread ID is equal to
+	 * worker thread ID.
+	 */
+	if (pthread_create(&thread, NULL, send_signal_worker,
+			   (void *)(intptr_t)PIDFD_SELF_THREAD))
+		ksft_exit_fail_msg("%s test: Failed to create thread\n",
 				   test_name);
-
-	if (signal_received != 1)
-		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
+	if (pthread_join(thread, &thread_res))
+		ksft_exit_fail_msg("%s test: Failed to join thread\n",
 				   test_name);
+	err = (int)(intptr_t)thread_res;
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
+			test_name, err);
 
-	signal_received = 0;
 	ksft_test_result_pass("%s test: Sent signal\n", test_name);
 	return 0;
 }
-- 
2.46.2


