Return-Path: <linux-fsdevel+bounces-21221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F490073E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0FE1F26BEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948D9198E7F;
	Fri,  7 Jun 2024 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XQD+bMqI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DgK9vlDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAAF19FA78;
	Fri,  7 Jun 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771259; cv=fail; b=L3EYQYQ+SGtOs6Ef4nfgRL1bR4d3PjHBkRTGYWcuYXmO8eoG2qKfC2OmlHZZLy/4hjWqPgEBizy1gN5e/g4waqOjDeBgxCA7yRwPPXwU4rQgujGqaUT2fc+DtSuq+29gPg58lPrEC5vHBy0UOVcxE8sb5P035s2x75h6E3XAF4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771259; c=relaxed/simple;
	bh=RnMh0YZeJy8q7JdsF9hIiJNZlgaibfSM5m+V68y1h1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTGzwpDSQLWAXywo7hAWJunN6idR4/OUU33UfHafn1tqppH/hA8osG7f0dke5tWMHRkBpo4P78ae5ZHCpM4ZIbCpdg6a4xm76WV3TR33FsWBMMIxwO1t4YZtD5thfTL6UmvwKAm9Tb1DszshD/C092Yu8Ki6EhExDJPkVR1vUdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XQD+bMqI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DgK9vlDM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cuf7d021452;
	Fri, 7 Jun 2024 14:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=wFv5CA8hwZ6yyogfoaBEcrpClZLQUBdq4YjBgutZRj4=;
 b=XQD+bMqIE/jWRRFtUSJi5JaFJ6HvjTTY/JBxAzdaXZVY2QwBVaC3g3GL8FUwlJxg8v5Z
 EsfWnKaeeymQ8QoBzAWD6H52SG6xbSG9kpnFZoTCIj0ZgM4WbzyjeQbzqVqjI344iDnU
 NKqzZQGap3YkdMg8oul2EzaL6CxvZx/4myH44JvmB3mXLTJfcsoIt+qVEw4FCscAco+k
 YAbE8ZFkwUsuL2rYdYPvHyEfJTFDTtLImVpvu5NeqQwoE0uDcH4MWAohRJbCAaWkjzRh
 TGKIwt/F/RVqfF8lH0ENLgNVz6rld0r46m4mqyPZ7pE7Rio6MQSdOw6zTdzWiDwWLP/e +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhduf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DL9r6025127;
	Fri, 7 Jun 2024 14:40:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtd2yuq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2oKgQdzwSydDypmHQbW8zV17pkytlSrC039LHmHCL/jFyDkJ7JrrzSMMq+TTRcvWbqERK+MCahaIEZ724txtzSSF7oyL0vtLwmqgRUtk7+qQl5G1ReN1okqOG6DgeCutJfxGEDx0oP3OZNtywNNgX66iy2qXa7syNovKj8Ep/TiORIFhyA9s80tWzttBgg9bSw2txe1Me0xrZEKu7yCmYNrFbE7GjMydx/hy42N7l76Oj6WUS7K15fM+lKTovA0H3mOgWeg0fgb50b5Rwe1qGIGUKZRMONcJZOCAPnLYjeBdCPlbiQHfGiKPMzbekCKOjcbpKOHNMUNEBCZDh/4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFv5CA8hwZ6yyogfoaBEcrpClZLQUBdq4YjBgutZRj4=;
 b=ncSdTTzL9CzIZrS7pF5dMQc2NcvNMt/7WzFIdbsli+UE6vTQfrbUxmcHmQjF5PCX+3o/MVAYP8uf71Yljj1BbTW0oKcF3a4F6FBBcal+GQaMMDFD2Jhpzqv29vFkozGI3I/49yNGrRZk7zTh0j/6KHePH8YrvRSgKODKd5HbYGTzdRPumKPkwzu7NvnSSTz1eciU+aqzoMMTtgWS7IiDlYT+2HInwvhyOiMfXQ+qGy4XVjw/2RPivT79D0wshIE85rOlzWV/hLWIicmtnKRtgb9Pwsu4MXSfdZ8FIL9RdxhdDoiCvmgMXPprYBfQNIJJWvTufJAacpgAVd2pxi5GLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFv5CA8hwZ6yyogfoaBEcrpClZLQUBdq4YjBgutZRj4=;
 b=DgK9vlDMxn2a/xfKWtVcBpJTejlG/uMcF2vY4UpLN9IALVNhwTPwMFkV9OFzf00cfThZ8OIIwuAp+Ln2FwPH+TP44cCdcuIDemz5ijp7WBgSJPoX0d2bGMHAFOJVI7qW8PddECEVAAvr+4OdkTOLz+5ns8OtVxp2HeVderrDxak=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:40:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:04 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 04/22] xfs: only allow minlen allocations when near ENOSPC
Date: Fri,  7 Jun 2024 14:39:01 +0000
Message-Id: <20240607143919.2622319-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0450.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af84841-1472-466c-4e25-08dc86ffb7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5n6OLZh24WDMp4fw4I5chBy7BI45QI/VhFFcB/noO+JELNucbsq2YuI7Q/Yz?=
 =?us-ascii?Q?BvH/prX5zGiSe7sQzQ64IILQOXdEAkMRR1rYjXLtjL9VUcaFOnA3wyidmlIV?=
 =?us-ascii?Q?EYmTPaG9aVpaYWQJm8lLHUh/E8rKUzCFH4zSoB62wlydcAhetbgMH06JdL6r?=
 =?us-ascii?Q?Mu/pzCD+5WnZUSCSMK46U+TjgNqCMH/tXmRlPkD9BKNZC5dEn7YvjA5JB28I?=
 =?us-ascii?Q?41h7dVR3WA8w0JsEUY4aiNoe/uu3QgVZuKSLzZ1FZFUDLrb9soV77qMHi2kC?=
 =?us-ascii?Q?VU3C6RzxUH1kaC2yo+VDn0ArUphkH63E7H12Q76vfAhdYM9CwLbk/PhMNcSd?=
 =?us-ascii?Q?+zv6TSR6ETiOXbQtKEl/46oyVIyIYkQ6C+8bcdnVUsIikFg+tq2OpYVibySA?=
 =?us-ascii?Q?q7sOe6Q2KklESVh00hb8tko9qx00Pwg2LPXm9s+oPxA+aHwDSOrl7AI2jMP4?=
 =?us-ascii?Q?nyR/jcIn67LtC3Rrqr7BXD21ZKk79MAOmQ4Jw4cw2FJSYEqDZ24UKaqHqcxE?=
 =?us-ascii?Q?s2QtODJvQrxUKKRyDDoIJ72Hy8g1pYLRHxoC3o23gSiTZ3OHWVjxDzK5lvAk?=
 =?us-ascii?Q?5XhI09n3JrgUMD1qY67TqDL943ddyJS3Z3Ugm+wXIB3Wlc3KakdfT+Zbq8O8?=
 =?us-ascii?Q?zhtUWfBV8Awz8jwOqGzTIhUfGkSVDtj1B+Xio8cYHwXE0b2E/20iBhgg7+SB?=
 =?us-ascii?Q?pqJRWvY4dLyt4MRoxgwrzSxnMlsQuPiNyTwTZKIw389Krf5t6P4tAUyGrHFe?=
 =?us-ascii?Q?1OndBikrjTNElr3eqWjP02P60dWxgidXPOiurICy4Eo74IBYNQ1k0ELwhpfB?=
 =?us-ascii?Q?sABTnYGf2dljprHUKlY/ZBOoaEAGwlBFypJsjL8AStoO2GkT/eLojy01W2Lt?=
 =?us-ascii?Q?yxKX+EYq4LgBB4Nvs+Ak7McitK+u2r7bSW5GRT3MROI0ian/GjqcDVHdNONJ?=
 =?us-ascii?Q?LzeCxCn+xo+QlH47z2Svnh5QewycTm18KCdT7WyqhtQT9x75kb8HlPEscDMZ?=
 =?us-ascii?Q?+5SqIQXLDpG+us0lICUm6tTCg3sAnoBAXtuTeCdZCL+v8MW4SRJe/heJqkC4?=
 =?us-ascii?Q?CLT41HXWL78VIgDLHmzTS5Nw9iM1RDfmOtV9Dl3nV+60Tn7aE72y5tTVd9J4?=
 =?us-ascii?Q?aEgKtsRODsAt6iB0rXilv+wRbCnMelHmvpopxKH5MtdUEwMgDAJqRKCukXTv?=
 =?us-ascii?Q?EOfDxJHWEX0q5h+9E44MkXk9VIWMtIZIyz1IiFB0oTPX/WRMZ+e8GFUBIY0R?=
 =?us-ascii?Q?IApsgB8Rwqoavn/Pr4jdZHUaGEshpKu/KgAfGGym6fvcmcmiSb24aRihNBDt?=
 =?us-ascii?Q?d8Te9hf/CCe9Hg/bPM3ny6PJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1LWD1cF9TkwpNnvh3oICmP+DJOxTE3av6KKpE3iHCSI0/NeBOH/NkZOKjEVB?=
 =?us-ascii?Q?d0xOvcmJSjE6wtznE6CZHrpXzRAvj5x3H4IUS+p5GJT4QJbnEoCRy5ARMyh1?=
 =?us-ascii?Q?Kj70PCWI9BF4lb0W36Jhkr3mM9Ru//IXa7oYfWlwivUYSkNrvqic3LY2MaXe?=
 =?us-ascii?Q?fe/621gePrHqIIPITMwe+T81me/abmEdnj9pSn71cAu2sjdKBTKjqybjg2GV?=
 =?us-ascii?Q?8I+YKNa82Du+2sOTl19jwrfbys9vlXrWCdwwtO+2JWBDxPjJxDz34Qa6acBz?=
 =?us-ascii?Q?ON3U9irOkHQPhD4Wyp8FGhsMx2qrCK0Jk18QbAwicDNrX3zm2mWmPlCW5Mmx?=
 =?us-ascii?Q?DcrNOOQ1q/sm4NGkYrOUZaRGqsm9ZAi7ZYBD5uor/myvdQVbtHS0a3I6eOAH?=
 =?us-ascii?Q?OQ0bFWmj2Sh/0fqAnn6MaLC8eu6t+JCPgKNk39EgJvCCz6w2f6cm29RfLO90?=
 =?us-ascii?Q?ycfkC1sd4aS5Y3aNngHujYyv0LtcioJ1Hj710H0yrxijzBFOZveMbV0LLyRw?=
 =?us-ascii?Q?SVNXifFfN5Rg81f86eOf3NOaL2awHy/y6Z9ANP//Q5fMORfcxJROasxHtnmR?=
 =?us-ascii?Q?j5p/jV49qjE+1Pc1ok+oCpPy38U68E9N0lFg8OuUPWNBLv6BOqVx0cr8WMmL?=
 =?us-ascii?Q?zsx8bHbNvfknhLzmYS7hMnDOao677PtyDlBlM2rZpe7GGrqNehgDMc7P9CCK?=
 =?us-ascii?Q?M69+Estgi5XFk3Ki4ExX739CYd8RhTVQ+eAXCiPUgyUlLTOMVxNaM0RbWcfp?=
 =?us-ascii?Q?oC7TgK40IJq3r8/qgB6BmyLQSMWxmn08pM7wgaAoam6VFjzX6mcoomK8qXpa?=
 =?us-ascii?Q?J5F3/Jjz3EbJaXjTdMZME+ulOnu5GKSV+YqvdGSv9lHiHE2IF5M0w1o43zcG?=
 =?us-ascii?Q?KCEcodiezHdUSPK2cOG9TVBy9CYd3mSHj2ROWrqMrlNs3GUnUdlbUMTxCNdV?=
 =?us-ascii?Q?UAHXu/7SXiiv7pBfb6VkkyyMtkSUo7ydkZDc09OPU6zm+V4RNBh84b+rP8GT?=
 =?us-ascii?Q?lTugF5VwME1oYFqNlzaQjKNXKzuWMTQDmpV5yzJ3rTZEP0jICmSZOc8z3XcJ?=
 =?us-ascii?Q?XsPb5dYtFng4nFZa+af4qlD66XrmOS7AIAlirTuTZaJP6wFehNZo26H/4tB0?=
 =?us-ascii?Q?jAFgAuBmoA/0HadB+vpQk8KA7U6Hh2XBZ+UPIC3zPeL8+WMsn5qbdcsk77T9?=
 =?us-ascii?Q?VkOOmBLyiMtGSkxQ/g/DAmhTj+qXIMoUj2AiC3ZG8JQVPJoug8yWAqehqmvP?=
 =?us-ascii?Q?nLGwgkM9EkseW7ghbe4iRGgneuWw5xMoLX6eYZgCeZXAAJ0Z0H/dVvufLD9g?=
 =?us-ascii?Q?oxOj2GcpH4xD7SRamFhx2ea2dUsdTd9APoFaMlvVCTZ06f/N1zst8r6U6dVw?=
 =?us-ascii?Q?ZN+SirTwkZ8XgsjGmcA3DZha0in7lIZpgrGhTnmc81NZHF3ziPj0mKurb7c+?=
 =?us-ascii?Q?20ejPBt17zoDqyrD7IGbcMvRm9hXYOI516Lixh86ZiLjEGbKdRb5cXMIkuc3?=
 =?us-ascii?Q?H2OuhEJFlIAR5o+fdCraLXVO+2YizAssPpvxtd0H5Rgt29clFsC8vFvqhH9n?=
 =?us-ascii?Q?SnpgEYdUZD1wh4jK0zgW7VYUDdW/bKnmsMQxDlU5405cMxEFrTpu8TT/VZsT?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kGhmk2TVXwkcZjDZtVi5SW5XG+HncxiZeyNpTnQJq8OjD6lQ/dURRpWu18NB3Og8ViHk4ZkPoZHLK3nFCpP7Xt1jT+AVwD59zzYmRIIlLr+qug9B4MzZ8F9/u5ZkiNv0aq+sqWc6xauFCczvuIRJr35V8MdDEWzW9sKjs4ynuEEzxh+gA20aix/Wr8AHW5ZX7sgorxRByOgiiCTEpEqFYS7NoF/boNy4QkFYiGh1SI22CvwkXoNLYhR7qFqG+aYjJrrBzemjvBcE+v6HNbB7qP18+AyV7h/5KXz/aG1v+r+G/gN3W8OTmn1AsOJamr4IsrF0sYoaZluqcJBObkGZk5hynYcRvsQ+v3Mp+9n0HR7mjraYu02POSHSS1aSpPNbsI7D3JKQsjYZs64j2mIAFETnXesQJMZhLHtzQCEqe5nVPof+x26+0NVjON9AgGLMzTDyMTmw7On2EVeGAxRAFOnoeQ9U68i86DfZduf/9wXmSPPF0OZxHDR7XTNLvjjr+8ts/0jW8XzC0O9JLqY3BpA2HW9BrVQldw8YtNkHeZQWifqFzpqshP5FWHH/lh+kqPK3EUojUMwAFbAvz91ZvxBCyok7BW+tqBFT4JpyfgA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af84841-1472-466c-4e25-08dc86ffb7fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:04.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbh4F7WQE7xWmtEbo32NgGNczbBkCxtKQ9AYUxmsEA7jj1Hucr4GFMl89IGeZgxATUFWSraGNDFKH4aDRUCx2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-GUID: ED30YKw42EUjFlg52iIVMLRip9J_pA6M
X-Proofpoint-ORIG-GUID: ED30YKw42EUjFlg52iIVMLRip9J_pA6M

From: Dave Chinner <dchinner@redhat.com>

When we are near ENOSPC and don't have enough free
space for an args->maxlen allocation, xfs_alloc_space_available()
will trim args->maxlen to equal the available space. However, this
function has only checked that there is enough contiguous free space
for an aligned args->minlen allocation to succeed. Hence there is no
guarantee that an args->maxlen allocation will succeed, nor that the
available space will allow for correct alignment of an args->maxlen
allocation.

Further, by trimming args->maxlen arbitrarily, it breaks an
assumption made in xfs_alloc_fix_len() that if the caller wants
aligned allocation, then args->maxlen will be set to an aligned
value. It then skips the tail alignment and so we end up with
extents that aren't aligned to extent size hint boundaries as we
approach ENOSPC.

To avoid this problem, don't reduce args->maxlen by some random,
arbitrary amount. If args->maxlen is too large for the available
space, reduce the allocation to a minlen allocation as we know we
have contiguous free space available for this to succeed and always
be correctly aligned.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 6c55a6e88eba..5855a21d4864 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2409,14 +2409,23 @@ xfs_alloc_space_available(
 	if (available < (int)max(args->total, alloc_len))
 		return false;
 
+	if (flags & XFS_ALLOC_FLAG_CHECK)
+		return true;
+
 	/*
-	 * Clamp maxlen to the amount of free space available for the actual
-	 * extent allocation.
+	 * If we can't do a maxlen allocation, then we must reduce the size of
+	 * the allocation to match the available free space. We know how big
+	 * the largest contiguous free space we can allocate is, so that's our
+	 * upper bound. However, we don't exaclty know what alignment/size
+	 * constraints have been placed on the allocation, so we can't
+	 * arbitrarily select some new max size. Hence make this a minlen
+	 * allocation as we know that will definitely succeed and match the
+	 * callers alignment constraints.
 	 */
-	if (available < (int)args->maxlen && !(flags & XFS_ALLOC_FLAG_CHECK)) {
-		args->maxlen = available;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	if (longest < alloc_len) {
+		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
-		ASSERT(args->maxlen >= args->minlen);
 	}
 
 	return true;
-- 
2.31.1


