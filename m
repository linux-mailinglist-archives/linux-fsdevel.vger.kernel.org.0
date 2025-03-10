Return-Path: <linux-fsdevel+bounces-43660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA2A5A33B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A016FFC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE223815E;
	Mon, 10 Mar 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RYFFg7Lc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HAUQlo1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988A22FF4E;
	Mon, 10 Mar 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632017; cv=fail; b=W9chBfErJAP21So3WlQIKHGHQ1dBz4fsuHdk4w47NGOgJtqqX0Ozh8Zq9VJIKEuzNB7QTm7s1oEGxf1L9daYKqcfRM6T180WVQPSw3USxHEN43GQs4Tz4SYHv/cTEQ6SXPlfvV/uZ/2hpYhM6NfK/Ob/bZ6pk4aBEYfipYwskBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632017; c=relaxed/simple;
	bh=+i3jkP9dd5LWiPva+E88ZtcGjwHDAjFueIx3u2RtcEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJkmK1jvcNeuHeJqrKpv/1QniOp/c8ZNinBjx1mJ+gDajBv6cpGrGmVoD/P2zwLez4QxwoIBYtrXFdSiNPyjw50ZOIXom4XkZ3mOUGaMyW7hbaXWiWE8d7cgddWZY9gBPSqX/Lin7zeGS1KKfn9XAGaYlMnP8Tb9/Zrgf5uwRzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RYFFg7Lc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HAUQlo1T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfg8n032542;
	Mon, 10 Mar 2025 18:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hK2bDxiHXaAyONxr58sgAAYu5QQccYefG1PbdKl7CxM=; b=
	RYFFg7Lcx8QiieFDQPaKq5FrahpvQqZNSCLfYK4ywvC4lsg8kuM2unQDM/YbOGOB
	PIyfmI7c8vhrIX2IZD4Cq2BP3TYfwH5Pv1p3n45b63ePOqD1ObqxdHmFwcnFfebG
	XmoLH3O3tyPv0j2gOJ7HsMhFwMEfwB21D3Mnp8qDY9DrF+v1M4x0U9Xr+ujNTZhZ
	/tRCYdbSyIMagCeeIv/190xP2m5Yuk9ca9H3DIfiFoJLDOyewKE0GwPPrHxEtO0i
	V4j+mDFKLLGm0XsjOYrX9mTuKXIyjKf4R0dD5/ko+KdRbcHyk4K3VoYVjOXkaXt9
	UwscNF6Rupuy4/np4oa33Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxck9y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIUCs5021718;
	Mon, 10 Mar 2025 18:40:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmnfs5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PilfmAi+derum1WqPSx/lsqUAu8WbgdElQlp4cfhwFmQuAYqk5c6atQmtYp3KxVruBxg7YkVyBNR5gYrP50uki7o7I0lFI9LZ5chW0BG7qPusDOPrXh3YVSVonTuWwvJj1Oyrugq3IYvJvzdRmuwbL8weRBAwIZMa0QXfIfG6DLnRzEgIQXiFyg3ycg+vwj4o+gmGjUt41pLh8HRP4cZkWqWxxDXms0E68qqQGpdhRn/KuW/lcjzUfwwrmv8kPB9jM4VTXh/SpE5jd0GAd4Vn4ZOVx/3BlQEsYosEcZQlCqC9MtsQdY7KyF2fFQrqq0CyWriqnRiC96IMa+OJVP8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK2bDxiHXaAyONxr58sgAAYu5QQccYefG1PbdKl7CxM=;
 b=lB/GFxJHWXS7eFvDaXmZmsFbPQ1Ab75WM2EOCDhSWVuPfoTXAaNUni9ZsY7vd3TVoa12WYXUMU6PDUzP8Yt9AxXfLPCyKhELBICz+Lf6Xj7YSAWounnOyTU1S+qrPVkFUofbifvkOxBm+qAAtEiwRYHJk/TMMyIFNHWzaSR/RgGvURVAFcoBRb+O6zi+cyXu5XTKo93cNmGYLvdCsekNK2iPkFIeeGlGNMcjv45gnpCDhid0VChTYSkg7/QWFqI9VK2C/zRiby+HQ4GKhF2zl+sh52NApXW4itFnVZZ06waw86OnkSxjIDIGYyT5Pt3KDrqINSFhXKPdeP0M+12mTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK2bDxiHXaAyONxr58sgAAYu5QQccYefG1PbdKl7CxM=;
 b=HAUQlo1T5gum9MZ3XzIlNGEwefhL7rXny5e97hieAqYPiNHkXaswCYv3jXe9Eb8u+ADZHn1FmHiaMGd464vMFJXtG9sKwqCiWbr6CdDX0AAAoltt3tY47Jqk9piq6UoB2pNaM+Mw5SFmi0ZCw+pH7BN2UDXU9ciOxdnCwpsirlM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Date: Mon, 10 Mar 2025 18:39:39 +0000
Message-Id: <20250310183946.932054-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: ba280c3a-ac25-46e2-ac0c-08dd6002fa8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SA9ZO2uJ15dZ3RgQcaVg5aLoxnF8O6JiP7y9IiWhJgYfVH1xxhnNEPTLFRJM?=
 =?us-ascii?Q?zDG8TyYnoGF5JaasAqZl85/h8MHmKLNZNwDSwwHAWcjt5n7dGJx8Ib1bzQya?=
 =?us-ascii?Q?JhQV4uA7XZ/BKTp277zs4alegXGI4jl6MXbSW8592yiiJolEWYGmNfhqH0wm?=
 =?us-ascii?Q?3kiSqZvWEvFU09iDiyi5GkRwC2HHB/KBNceuL6esdhbyFyoqAyEXmmawA9/+?=
 =?us-ascii?Q?9HJxJ/d5+QI7aOlBY1kLmLoPMgOltPdlMeQSYfu4Dz5gZD3HUs90bfmojcMW?=
 =?us-ascii?Q?QWoTkv/Qcu0EkPCpWFyeJnMomXt0c1dq6abfsIa+mRIkWOHfYSfBkMKLkJVJ?=
 =?us-ascii?Q?0jkQy2sMQB1OTTllHaEwW9EayUDcLmDvIVQ+Ya+6+UkainBoVbPwG7u+KeJZ?=
 =?us-ascii?Q?CunZgADpuQHLLQFDllhO83CnosXhZQUhJmax5YbPMLHQtcvMp+xtHlwgO5zi?=
 =?us-ascii?Q?hOC/hystBwfjo7UbQgeD/O6y52/vtAroSs0P5dTVnRJnvP9qgwWf++BYi8nG?=
 =?us-ascii?Q?w+ZTSQ31GIvcLl0gJi8fpSokaQKJ6QdJCfr3BmtIgfXlrORaXVtMfmYTlvN3?=
 =?us-ascii?Q?qOrCckxL/C/WpSzTXqnW6pdXu/jkPkxZW7NdPK1i6lj7JtjZzoTbIXdvdTJ3?=
 =?us-ascii?Q?91oWqVp1+TGyOzUdEPqv3JCUI+kz5xR6/Hha5p9lGj8Y1AKh2DkAy2uVLgYM?=
 =?us-ascii?Q?aMGxrj884OYrbaarnT/kPSU8keDPLddfK6QphyW5nKO1L9UInVHpaJQ9TsMS?=
 =?us-ascii?Q?vkJ6jkX63J1ildshQvYreLq1JOfLniA8W5KCIt9dJbN6vUTISFC99QTiKWce?=
 =?us-ascii?Q?lvoauSSruKxWIhopcYp2+4V3uxODcz/HMJTwf22Xkq3GlTxWlbzXzsBMc1oD?=
 =?us-ascii?Q?mBIbOIN5PeLa9Js7BJ5001onjLEZoPgtc8YS1UsiEO8nb+u3QOTCWdf1Rq4y?=
 =?us-ascii?Q?62aIwO7TvtvdCSw5mzxkvBt7QamtVhjIVWOwydDVHTeSJEjeFb3LXMWlRorf?=
 =?us-ascii?Q?PvyFccB1+9EYDPsdxOFeqQxU9vGwDR2/CVrMe4RmryE5HOiiO3HpT3NUefqW?=
 =?us-ascii?Q?ph7zPnYXQd9x1l1mDewLtyBOyJ8olFuMth72B0iW0Eaig8cCTv3RoFxfAB3A?=
 =?us-ascii?Q?2NzFY75D7Q6I6o2lkE6OgBl8bErVIAlEIzs6m5ksmwfoASWb5Zu5dSAICtBo?=
 =?us-ascii?Q?3Z7LuEyeNodgHOTiP8G+3FlavbceP7AcWqbz2FY0NOZ4y0xbjAuCF71U7cz5?=
 =?us-ascii?Q?3WL32TNS5m115fV5lcszRqEHxr+UPem7295YeKKTkDuORE7Lcd5lLJMzhYsY?=
 =?us-ascii?Q?a1FZtvJxp3Gu+bB2S9eCZeMXaK6KiwZpOx4C2Somt7NIj95dR/85qvBQ48b3?=
 =?us-ascii?Q?Nk/vPLwyCqnHTodgI2TzZb05M1SL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2hUg8knar1JL4k0Iw1otr7cS58vq2CLba08aGS6NNPGc0oL/PF9KLiYc6Sqg?=
 =?us-ascii?Q?hd52ll0iFhXbE8Upf7grvZcK4jzpCampCSVmYkASs9E0eZM6+jN6KDm2i2W/?=
 =?us-ascii?Q?j3yyiDx4ubN7Hq3hE4vnrPaMpjOLyJbM5Ij7S0njf5MT1IaYgozZsH3fh66p?=
 =?us-ascii?Q?4YU5lE2W6pYiwS/qDp8pD1So+2S8KXjt015lyiT0T2PzisEtTUlQuFje7OKk?=
 =?us-ascii?Q?Xh0t1rD2hRLBw+0+A0sxb2EqXhlZmjF7pYH7S8MPJFjNKy65/ZI3MQiG0Xbg?=
 =?us-ascii?Q?C6sN7Rc5fue08dYg9TKoxNZ2d64pFXO/ss3rTUBUZTPz3sccQzOpIEwA+mBN?=
 =?us-ascii?Q?NN9AVafcp0RdkL5shD53Pmw1fNsmHafN/iSSVxMxP9Qvc74/FWdeP8+621dx?=
 =?us-ascii?Q?ZyVlRgWxrXfkaQ6QqCPgR1EVzHdY0ghIzg8YYnhS2DGRIPEougFoTPBimlDO?=
 =?us-ascii?Q?aNkqLPwBb0a/brOpG4XESfpLWMYfHjAO/1DBadKheI2pIOQadmxnP8G5TMXX?=
 =?us-ascii?Q?QGairOvztbA26wtmJhOQP700heyYxm5iYrEiDjZl5QksxPDp/qoqdjxScTKc?=
 =?us-ascii?Q?U9PF538LBFZAIfQqO6Fxe/DM494v8cE2XY4InQiu6r+IwJ2cDFdtXcE1A0Fh?=
 =?us-ascii?Q?l8CSkWK2mVLwdyNX/L0oHKnv1/APQJJNXOxiCJDW6zaViEFknyCHvsijsVFz?=
 =?us-ascii?Q?d7/FANLzt4IOY3vkHdlwQ79up/MOqz0SbSJlgyY0barZjMw2E7EiFZ8yf7RB?=
 =?us-ascii?Q?n8yrwn10I/jasxaXa3/aNH3+fhJpUFOfvbnQcgrFvW4cfXqHXwY63eQXyJSJ?=
 =?us-ascii?Q?oPAewmZ6CggEaK34lgW7RBGR3PMXDZkwjcDQ3vLa9h9ISW7s3k0QM2ev6zuW?=
 =?us-ascii?Q?pK6XKROqBNpwMORJQqsk8AllOwrRanhMeSzsgpeWIeueerT7/3IXKXavbFyE?=
 =?us-ascii?Q?r2BVIkjlBWbhil0QpFMg93TkIhIPD6x0Oy4L7b84vEulo+xS1iYIs/Ypp3dH?=
 =?us-ascii?Q?1oqIfr1wYoO9GjBTyErAqJ/zfoI/7T5qK7fkyXgJMIZkqNHiZlexIZeqDqSY?=
 =?us-ascii?Q?Q6aASi3QQ/DweJgkrnKP0HqwRZOwidsHZ14y14MbuZ8pHzR268xwBhiZYYYC?=
 =?us-ascii?Q?vPisBrjL17WJC63EhIqCy4GBnT4ugknbseYHuaKGKzdEqyrKcJDQluFBaVX+?=
 =?us-ascii?Q?PZzGi9uSgy3DZsgz4PA2uGiO9etGpo/ToFM/Oxy+iNIXHUxioGAnRwFNEkUe?=
 =?us-ascii?Q?LRybglUfAdIObni43MifqBSttyOsiyh2ojwJq4jaUnwFAO4OlXGId8fLeNOt?=
 =?us-ascii?Q?LrxssrBzKsA35GPVwQsptE7Q+LLyiaL89D0WGfuZblvNlHdZ/51GtXOkqCgX?=
 =?us-ascii?Q?9PWJhyQ3KK9vvnSuxa4fpF7WL6crFlhVYgVK/dANK5f3cEbieA3Nm2piYN+T?=
 =?us-ascii?Q?Sqq+9C1XFIUyFfnQCV3MMDlG4k29qxLWgdwE5JG4HYbImrJlbmPc17tFtIpU?=
 =?us-ascii?Q?nixdSQi9Ja0sg/kjVK8Xj5RZ1RsKyzQpKoX05pI7/JZ7LuJR9SLbIOTMZPsE?=
 =?us-ascii?Q?cM+FBbYUNTKC7kL0QCcG3u6lSJKW2oM4d/6zzWR4sC+roLMcU0VjYci1RC5/?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ARrdJH/6GyTYWMGPGj12N5ua8/D6GQYdSkmXC7yoIsAGQQHpDl8MKgthmCXWVVAuOfdTHbUXfcnJ2H5UL+iO3FvdHJVel9PjCD7QWmPxfGG/UgJKR3m4Uyi4iue3pbi/X63u2n/gJFVvaoKgY4ubblwIwzDH8/sd7HYWcSAahvpfg0fqu6oUBiAy3tPqleF512qHn47KvRcP9f57jtSDH1QTIu80Q9XtNS4bj3ViZ8IVQHtALLyVex2dHg+b41Z5zPEJ7uR3HDt63szRXloIVFbrTAux6ht0TpnZd40iaKIDrKJBAZiBm9fCn4YKEG/hNpPSpE3VTh9FpbPLnO7+npd+AJPs8z9xokV9Wv+p5IMLIK+NRRWPH40/V5MZAeb/S6/ALUnyWSE4BsoYrAD9m1EIncd3XYopDrWUc3mliemH2Y7fDzHDZ2lBiPO0B1PjbupgU3uTxVDngFVYj5cpXQfP341afiQaHhp/0ndD5e6oV0NxLN5ZPDGQC/rvkW5aRN3Ifgah0GFKhhQrcdmau9EVQh+chJTpw+iGhTgAS2tD0Oax9d/sRg/7uP+TVkoj2pi7yK9E7HrJBP1f5I/bj9CzJ6Csntg6M1j1pApHdgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba280c3a-ac25-46e2-ac0c-08dd6002fa8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:06.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHUkmZ0qng83Zr3O1Tid5U5sRQZql2IoOuwvzoJE5usa5RtQuRZPZr59qvTj9K10JnQBYfSWXVVZadqVh7UNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100145
X-Proofpoint-ORIG-GUID: Z-8-Jz6gky3h3JWBIFvw46BNmxzcrSx1
X-Proofpoint-GUID: Z-8-Jz6gky3h3JWBIFvw46BNmxzcrSx1

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index e9791e567bdf..e3e594c65745 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -788,35 +788,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -825,7 +809,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -839,7 +823,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -848,14 +832,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -884,7 +868,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -901,17 +885,46 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


