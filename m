Return-Path: <linux-fsdevel+bounces-73266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1AD13A57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82DC1305BA4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153492DF144;
	Mon, 12 Jan 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XPgq5yD6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n9yXYJ9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FF2DECAA;
	Mon, 12 Jan 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230664; cv=fail; b=uknuwKzITO/vLa2qtBsWocp90SxkW9B4p7gmvnz5b5MxM/w1Tg3Lm3JyXHIh82XWGOfnJFbG7dDNF8AZ6etLEJ9ppcW5rt7wGbwlswFuNZNuy+FQT7idL0rqlRDS/MkEbAAtwbDVUjLqhQUVfhHyhu9UB+3XZFifgIWJgOt99xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230664; c=relaxed/simple;
	bh=4kf/hGCIWuTLV5iwIqJ/cKfHr8JeUJPQ0mqUKkxBMmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NyiwO+D0ISfcNBe/Zksa7qOkdDMiWhrsPbv0jMymXqU/b/zBnK1CJFKgxZZjTnsIi40gaFaMpfkxE+T1x28EX4yODvTnvZMBV0UT0t2AtcxMoMXdlpoZXhgbCIfFwhztum9IwP3UxE8T6RCeM+Nsit9NzYauolTmLsuJAPRAyVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XPgq5yD6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n9yXYJ9c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C1m33a317258;
	Mon, 12 Jan 2026 15:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2HVN/Iv8swbJ9Rl1Bq
	bBY6+p3BQiK8GOy38SCNxjMj4=; b=XPgq5yD6xhFmJi6kRZEtbo2cUC2rKZbH2E
	Uxs2/agGxA9MM5zddEMCRSELvtiksAg80Qnl2PHVtJh0q1a7ieQNLkbBB/PFrr4o
	PezKuRVi1pEDDeOOb2xDFiUM15snIkHj5WtlFBjR/4JcmE4mwyR3esEymTrBo9Zq
	9dj+e86NkNWH/uzEAh6N9uj3e8UJAhIxdSKvF17xF2wsWWc+Rrw5d17VlzZ4K7b5
	mPDaxJrMry3uTtJ2HSeXwo6T2s3lVieQY79XT+0NKZGe1TOQxu6XYEQFigI9dEoy
	TfcpYpNefaKXPjpM1IL9DID4omLf/wTj4ybu9eqIXdWJrQCGZGKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrgnssuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 15:10:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CENVsl021296;
	Mon, 12 Jan 2026 15:10:51 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7b9hwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 15:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDAKSfoERz/c8CBsH9WB5Y8QW3yuSGSlEa1kzWnbHpnBIdZuGsHul+UIh0hoI5ebmWKcNGmZTTELiztb5mAx3Q1/PEjUV5+1s0jaRCE1EeDLs1RR7lWjiWo+2Z6pnwPlBY68vsuEbl49Eqgo2oBaC7maYWh3ZA+5gwSY/+fmjIzwmXH2EqEPXwLLyuR3/p3dgrqShL9k9CDCoMMsdXY1BfW6j4gv7TtYZ9aZzVVqIAojcbjBpN4A9U9XwTYl7cMhNtBnPY45aQc3ZtsBODa2GXujsHJ9fqr8uU0gKhrQ/roNyJh8y1I6StjHgWqWh+ojJUqMFuF+2LK9yaoo9X7VPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HVN/Iv8swbJ9Rl1BqbBY6+p3BQiK8GOy38SCNxjMj4=;
 b=l3YI40CVsKM4d9hpNPLY8woCXO5/+89Vp/okiGUr6KPwtbogOR2LrgpWcVb17u4w/2ixe5U9wVyl1QqlZ70pW9kvWJ+gfjsBMuMX9MuZa5NkqLnNubIzMJrLp5d+PNfly8j5fJIXjY9sqY29+FP8M5V9D9ZsMts8B8zu02M5BNMRc6wWkHW+ncwLOZ9chXWz480TYnBVgKUX8FR/D4o1rxMs4tndPY45RZOL7AuyxEpD7rziZ6q7IsNiBzTnW4jYepIhzc3GsYmAho8FQWGbyINqvFfUjjrTQzrDcKspsGr6MrKouc63VcLBcn09a2ydhlWVaVzpigkp9kI756nZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HVN/Iv8swbJ9Rl1BqbBY6+p3BQiK8GOy38SCNxjMj4=;
 b=n9yXYJ9cj9gjDCuybI0oXeUM9XAdgOl2Rb6k4GAd+FxwQOa/5QBqWQqCeH+Rgz14qsRII2/aY5D5bVAzjVMqKoxt8wDyC576OVNLUyo/mm7y6DSYHJ9YB/xTqYaEyyalOItOegUdd43ajQi/d2Q3sfBFcn+rnsePwYaXe1+cAYc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA7PR10MB997774.namprd10.prod.outlook.com (2603:10b6:806:4d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:10:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 15:10:49 +0000
Date: Mon, 12 Jan 2026 15:10:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+bf5de69ebb4bdf86f59f@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] memory leak in __shmem_file_setup
Message-ID: <78d631ec-8f26-48d5-90c8-5123783b6cff@lucifer.local>
References: <6964a92b.050a0220.eaf7.008a.GAE@google.com>
 <654b5d28-5e1b-4773-aca6-ef650fdb0e60@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654b5d28-5e1b-4773-aca6-ef650fdb0e60@lucifer.local>
X-ClientProxiedBy: LO2P265CA0502.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA7PR10MB997774:EE_
X-MS-Office365-Filtering-Correlation-Id: f29c8ade-cee2-4b57-7d91-08de51ecc4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7tBZpyFstkjNfCpIQVUewzTbQwJ8Y6EBKWhsQnh868CEJDXzUrmOJmv26+bW?=
 =?us-ascii?Q?ED77bmqZ8M6jYvciZWUL9nKj9wRbSDPVPvi2L22c+6gtYe+8TKXS9dp3IGNv?=
 =?us-ascii?Q?ilt5yVuEPgITOv91eoP97m3CxmEoC4GujYxysR0lTB0fR8EWHkGyvDd0gJ9C?=
 =?us-ascii?Q?Fmt4tmjUaBVPFBwDoWh8GpCDX29+xrDI+bLXoLu1edXFZSV4a91+niRREtmm?=
 =?us-ascii?Q?5Itcax5t1QYKp0dv9cdTkDKskKe5nQaMDvZEPaNfygpphHDP7qFZcKDdtchz?=
 =?us-ascii?Q?yQ+Q1Uv25cFZ5rVlgNsVeJuBceNItDNrvAJz4ShTBd7gPfAPu8Y1HwjNFi//?=
 =?us-ascii?Q?NfkKb3Xi8Yr8+tLDZQTOxQhN1GxjWY7dcNPO42Nlhe1wnB/kH0Gu7TN48JDn?=
 =?us-ascii?Q?G9QCdS+UHYDcb8iEgoIqSXd9kIOId/cql5kDbs0/g9THxwEV9neoXll+2Wz9?=
 =?us-ascii?Q?wx2RT4v6qiq4j/0Xg7MLSxe3yb0ediYLYMbLcjTt+YWKbzYm0QOuu7hfFb1E?=
 =?us-ascii?Q?dRpaM/PrEQiasrRCKs7Il1ChHQL63Llo4uwupNzx0hwPeGLzhwinPGsGpZG6?=
 =?us-ascii?Q?9MXsSMnApB0omePK/2E6nBf3FTlusFfZflkixcDbAC7QlNko/Mu3/L6Ofrjm?=
 =?us-ascii?Q?78dBAt3O1btHi4jD1rpc+mmf4ie1ZJ5nTdsXn7EBtF8eseF4E+7iYhUBVC3y?=
 =?us-ascii?Q?eGMf4UoLzzoJ1vlnZ4k25tMjk8kaa4oGCbzNjv+dd+//1REat/EOHDSwO6gH?=
 =?us-ascii?Q?sRvobsEiEKNFUVAW1xiBIeNTNRt/WniXHIYCbw8jQn9qiICbfQRd2SkPkdBH?=
 =?us-ascii?Q?FSK0oeAIiWCSbWxNWmCDr78NRejLvzU+QiuffawXgzl1t0TgCILtzrVv3LKD?=
 =?us-ascii?Q?8UrIDVCgOmdStH0x9yJC6f1YHnTYST99kVuOrA4GzO9WY6GtLxKWXyYVGVYE?=
 =?us-ascii?Q?JoCprIRVHNQ8x3j8t68lFNnDB3FR0dpBT/IUlIM67+zlJhZrM42oj95YCtlU?=
 =?us-ascii?Q?6f6u0Q6WHpaf1VckS5L+tCy+p6mw/KTwPbOAaOm0Y2OM1wK0s8v5/IFiTL34?=
 =?us-ascii?Q?R65Ad1y7NyyDDSTSzlwIpUUon32icL3Fe6QA0rU7axumSlANPE2wBHtB9fvA?=
 =?us-ascii?Q?CiN1w8KBqYF1FjIZDp39h0bzEMicX0MUdGn44Kj36t4hG0rhbzF1+hw/o+Xm?=
 =?us-ascii?Q?ZasbXNqXhcOUL3Q+AxIrryPbJihttowKvffcXBd298PrQqtzW/26+/Kyi7as?=
 =?us-ascii?Q?1ARDswYgdkmanLGewVVbp8QHZKoXfBsZ+KyFkpphsrjW+PP1GJpcjkUxymOO?=
 =?us-ascii?Q?nhAAKgb02Upab2TwAKCIDpgwBMUvb+HL9ZFe0bljMZ89CZxHm5mrqh33t+ru?=
 =?us-ascii?Q?CPs8/PPGj4YTSiu41LJNKZIUXJLCNWvIygekUkqEltVOjw1bHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p5sGZnmJf+ULudSJIEGnABsKjUAGKpvHHKZqqHpJEsisb0mBeguJ8sx9Xwgp?=
 =?us-ascii?Q?rwBDYeUGT6USGdNGDZ1jUSizalwXHK991ZCETwPfT2zLEQOkgl1WNqnMIQTs?=
 =?us-ascii?Q?kzxTXJnqg3yW3b2z2QcpnWXx0PNcb8WGLOY9Lgxc00Fi5Fqt8Dg20o+BgWvI?=
 =?us-ascii?Q?DeqfxofjzpoNUpPU0zuiYdSuU+L9ZcDoAMYWSQ3cgN+t/0HnI96UWq2UaDlC?=
 =?us-ascii?Q?iyarfH9/NgmhDQhY1dGTCwrrT/2jm95aK2halxDa3rvWfrAMHLhhDeU8z0ZJ?=
 =?us-ascii?Q?GlWnCPdEw6loG2c2MEH2IJf/bK7lstKiyc6dyQG3XX7lZ2LTpvON9AXHKu0e?=
 =?us-ascii?Q?E+MkmxMDz1+JVA7CvGy20KycurpJTLVHgg5wfF19LvFkvgsSVy708LJRDkn4?=
 =?us-ascii?Q?egUb4FuDEd9hfUvK6IboTm2kh04Bh5xctxxqMaH6v5qJ1z1Ohn8NIm5vTf/y?=
 =?us-ascii?Q?8z1PBNFrF60pmjDKo5iUtA/WHzSnNAtn6LEgQWANQtnSV4rIDZDxsnnjcnKu?=
 =?us-ascii?Q?e6pwovRkw27sODAobyhTers34cY1TODIV6YGFPesJLH9TgQHfHU6+gQ04Stt?=
 =?us-ascii?Q?mLvkuJPs9uGQfO2t9MQarjSMtE+lwANRf/6sPOShYAJL+Oac9kuvlaW/XdQd?=
 =?us-ascii?Q?si1mZjOx5ppK/eGD8h2bxPt0IKlnttot6Mwj/e1r5/b2TJOGMnoPPIERiRrt?=
 =?us-ascii?Q?7mStm8ShBZ4TNrBXFZYsJv7vJqfWG3+drDLiroeC+r1rDK2KjTXVmWCZojzy?=
 =?us-ascii?Q?sSplgfHzXqEgwWSXqDzXD9yLpg8Fk0TWiT29YRvLHfXYQxpc2YzcsPMEQ27K?=
 =?us-ascii?Q?QRMr3h2x4WVJXZm+m28hQlQqlRyeyqEUxFK8aud9gfBg/c8FPHgEp/HtlsMS?=
 =?us-ascii?Q?S4sGERqk+5ZEn9qqQDapV5EtWCv+ect35K93N3/YXd71MTf4Bta9Au9QwVqv?=
 =?us-ascii?Q?9ofMM+fyaRzmd0ZFKwhnLwCJcar/zrsGeSiwW4Q0R54FzHnOom+x9UqzGcgC?=
 =?us-ascii?Q?ty2hf3mgRrh83tLbZTXxaKjm4Kofglht9+5gWezqY/npf03HUsdx5uAtAM4q?=
 =?us-ascii?Q?dIvCRWAJ5W/3QotWMt6OxLWh57JBNc4awpODXkHX58Hzo6AC/+UVR5qqXqVe?=
 =?us-ascii?Q?rPl86NR9seHmWer8dOdH81D5UvRPaEjX97s4tA1i9+X/F+pXEBF0bsGu/jAb?=
 =?us-ascii?Q?pOyCQm9/gh7GsBRgo9sVHPVfwesuAhk/00qX3Kdvy/AveoMxQLNS4epLOzac?=
 =?us-ascii?Q?ws0TaR0YERfSOFFTCPUIq7VPv4Ib2DvjEW/F6AC1vCtXamXIm3bBX3yatd/C?=
 =?us-ascii?Q?JWoSZMcWRd0zcPoI4XASLyFKuEz5tj7nZrF4jSu/+lHStt2S6RqN9pSM/Bb1?=
 =?us-ascii?Q?TWXbzOtpSVa8lOLc9yYtHH++1GlMBlTSQ5fUOkPiom45/EC7ctSfOLhcjOBz?=
 =?us-ascii?Q?wDFlLqQmu0z+GfgXO8xKiBAj5KS/1EYyHjKCLi/ZNTS/46AYcxu/NPkO4lu7?=
 =?us-ascii?Q?0NilWjO+OCmgC8lRAExTUAyRUKWmsDqTFyG1BTgMue/hvY7LVBQ6WNoCf5wB?=
 =?us-ascii?Q?2K9HDf2PFlnTD8RP7YxPFfr6ei6TKOj2h/1d8QTpZRY8YzY196V60xJK8bv/?=
 =?us-ascii?Q?xcxzdGHD6JzAjQnwWtpVA3ujeODru2lAz36EwJHDipGm2nQn2nOAeQ3rGo+f?=
 =?us-ascii?Q?ARWYw/Ws/qonoxLyyRVIbDx19pZdwSXD3m5fiqsHzdxmSA/5SeIf6Mdtl7SR?=
 =?us-ascii?Q?AH3Y8iOCnRDZwPBVM+gf4WQbY2KJMDY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5+hiMjBQ14gHBx7cCVM7Hshun+7Yh/6DHvv59KDRH8rHEj9AEESMOzm2/0gV1i7s3cCnLFYlldbc/9PCG9t/WXKdz3nmTHA10JElojdzJ4TTbTH/HuSt8F4KFA/+LhH0JJDyVX9kpjwUUSsKFEgqK/KlZY0mYFSgK6ME+pamKXFsc0meJwxFcpA8tXuzgoeS3uQYWjX/3JVB+pYzy93s61g2esAjv4TZ675zDws5ZTobEX4D3GJ8iyxcrea0ycdmVfS13ZvDmhigpfLyGlhC5MqHzXPP6XB40qfD4idvwPGFCw9UESNOkNcVFNmmSS2nYex//BEWb33+nrztAQ/bhj3zpiUlrBBPjOmAoTzLrlA956Mx3lKcLqXwWtvru1XNvxk5no7y9hWUSvTiII2cZzsr+JgKhow02NfRkD8oDe17GgMXiuRgp09m4dzagDxnyMTYhMEWIxcL2uOwul84NRzQ9Bk/T2q2uGgeUAPCXcqfGarAlVUiHkB3pSscxVHJ3JEaPkDzT8f8ElDrpkZJkk5CjFOe4vb/x1E7wB0Eib6/B37lhupptj7Xqys2N3HTzSCyxajt6vQwl5kce3y3g4ptCWupQOwgqzRNFmqrOnw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29c8ade-cee2-4b57-7d91-08de51ecc4b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 15:10:49.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw2KWEOvq4WZxPJ0+Yg44vxMUjbpDddgn+3NqUdkopUkS5Xxk8is+XscCEbe0pxGC/c+pFN8C9LO+tA7EAdTLWCyk5HhN1eV0DBMJfayXNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR10MB997774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601120123
X-Authority-Analysis: v=2.4 cv=B/G0EetM c=1 sm=1 tr=0 ts=69650efd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8
 a=4RBUngkUAAAA:8 a=S0uSi4Hoe2pQHC_Xn5UA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22
 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
 cc=ntf awl=host:13654
X-Proofpoint-GUID: s0NUy9Qr93xWDCF78G0LmvWpR6zyO5wb
X-Proofpoint-ORIG-GUID: s0NUy9Qr93xWDCF78G0LmvWpR6zyO5wb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDEyNCBTYWx0ZWRfX9L0nDSYRlIDA
 3QRG03WAfowxLbowS0l4FLPdGzodEa8XGMnve2jwcI645NblyaJGBKKMZe51LkTS0xI1hdJW82N
 f/CVB3pLd2ox+X2DV7GACYzESgK4QykgShv3g1J99EnlPHQIQxJDgbSkYkh6TQn3KAqd4kt6BwD
 3IBsBSCd8zl8PJlimg7l2Q5tdWr54wGx/BJfu1/nviWoXSnWs+M3bN5B7juDMRowjXSXWpyCg62
 ld4HCxgeolofPZcZDrAVK8n++AHCixr23fKwd4rO4EFRsdM0jR0kycBWSn03CyoD2kIotDeW0YN
 XkkIh9t5/uHLjFzyOpaKxG+u5diTFGLctexKSm4KJMlYBFxAXFyLjzUUy1agYzEr8ecYa/DpWMH
 9UGnNDgh84cL0IEpvDXKnqYeoSSoP2JE3IrrAKwua3JKia/R4mR0Hy54ziT/fcpCCRB4agIUTO8
 rs7dTF3VIVqeLrFFGVKjoFRre55NygzT9AfZtThk=

Analysis below.

On Mon, Jan 12, 2026 at 01:28:17PM +0000, Lorenzo Stoakes wrote:
> Hi all,
>
> I have bisected this to commit ab04945f91bc ("mm: update mem char driver to use
> mmap_prepare"), i.e. my patch, so apologies for that.
>
> Will figure out what's happening here and come up with a hotfix.
>
> When I saw /dev/zero I did suspect this exact commit, would have saved me some
> bisecting had I just tested it first but there we are :P
>
> Cheers, Lorenzo
>
> On Sun, Jan 11, 2026 at 11:56:27PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12ec819a580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d60836e327fd6756
> > dashboard link: https://syzkaller.appspot.com/bug?extid=bf5de69ebb4bdf86f59f
> > compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec819a580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bcc19a580000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/aad2d47ff01d/disk-f0b9d8eb.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/c31e7ae85c07/vmlinux-f0b9d8eb.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/5525fab81561/bzImage-f0b9d8eb.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+bf5de69ebb4bdf86f59f@syzkaller.appspotmail.com
> >
> > 2026/01/08 07:49:49 executed programs: 5
> > BUG: memory leak
> > unreferenced object 0xffff888112c4b240 (size 184):

This is just a knock-on from a leaked struct file object.

> >   comm "syz.0.17", pid 6070, jiffies 4294944898
> >   hex dump (first 32 bytes):
> >     00 00 00 00 07 00 0e 02 00 e4 66 85 ff ff ff ff  ..........f.....
> >     98 38 89 09 81 88 ff ff 00 00 00 00 00 00 00 00  .8..............
> >   backtrace (crc 987747be):
> >     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
> >     slab_post_alloc_hook mm/slub.c:4958 [inline]
> >     slab_alloc_node mm/slub.c:5263 [inline]
> >     kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
> >     alloc_empty_file+0x51/0x1a0 fs/file_table.c:237
> >     alloc_file fs/file_table.c:354 [inline]
> >     alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
> >     __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
> >     shmem_kernel_file_setup mm/shmem.c:5865 [inline]
> >     __shmem_zero_setup mm/shmem.c:5905 [inline]
> >     shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
> >     mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
> >     vfs_mmap_prepare include/linux/fs.h:2058 [inline]
> >     call_mmap_prepare mm/vma.c:2596 [inline]
> >     __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
> >     mmap_region+0x19f/0x1e0 mm/vma.c:2786
> >     do_mmap+0x6a3/0xb60 mm/mmap.c:558
> >     vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
> >     ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
> >     __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
> >     __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
> >     __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
> >     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > BUG: memory leak
> > unreferenced object 0xffff888101e46ca8 (size 40):

It's a struct file...

Problem is in __mmap_new_file_vma() we unnecessarily do a get_file() even though
the f_op->mmap_prepare() has provided us a referenced counted file object,
meaning refcount -> 2, and then when we unmap it's 1 and... leak.

Will fix.

> >   comm "syz.0.17", pid 6070, jiffies 4294944898
> >   hex dump (first 32 bytes):
> >     ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 f8 52 86 00 81 88 ff ff  .........R......
> >   backtrace (crc 2d2a393c):
> >     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
> >     slab_post_alloc_hook mm/slub.c:4958 [inline]
> >     slab_alloc_node mm/slub.c:5263 [inline]
> >     kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
> >     lsm_file_alloc security/security.c:169 [inline]
> >     security_file_alloc+0x30/0x240 security/security.c:2380
> >     init_file+0x3e/0x160 fs/file_table.c:159
> >     alloc_empty_file+0x6f/0x1a0 fs/file_table.c:241
> >     alloc_file fs/file_table.c:354 [inline]
> >     alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
> >     __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
> >     shmem_kernel_file_setup mm/shmem.c:5865 [inline]
> >     __shmem_zero_setup mm/shmem.c:5905 [inline]
> >     shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
> >     mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
> >     vfs_mmap_prepare include/linux/fs.h:2058 [inline]
> >     call_mmap_prepare mm/vma.c:2596 [inline]
> >     __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
> >     mmap_region+0x19f/0x1e0 mm/vma.c:2786
> >     do_mmap+0x6a3/0xb60 mm/mmap.c:558
> >     vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
> >     ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
> >     __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
> >     __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
> >     __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
> >     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > BUG: memory leak
> > unreferenced object 0xffff888108f03840 (size 184):
> >   comm "syz-executor", pid 5988, jiffies 4294944899
> >   hex dump (first 32 bytes):
> >     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace (crc 5869ffdf):
> >     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
> >     slab_post_alloc_hook mm/slub.c:4958 [inline]
> >     slab_alloc_node mm/slub.c:5263 [inline]
> >     kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
> >     prepare_creds+0x22/0x5e0 kernel/cred.c:185
> >     copy_creds+0x44/0x290 kernel/cred.c:286
> >     copy_process+0x979/0x2860 kernel/fork.c:2086
> >     kernel_clone+0x119/0x6c0 kernel/fork.c:2651
> >     __do_sys_clone+0x7b/0xb0 kernel/fork.c:2792
> >     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > BUG: memory leak
> > unreferenced object 0xffff888109a7b8e0 (size 32):
> >   comm "syz-executor", pid 5988, jiffies 4294944899
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     f8 52 86 00 81 88 ff ff 00 00 00 00 00 00 00 00  .R..............
> >   backtrace (crc 336e1c5f):
> >     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
> >     slab_post_alloc_hook mm/slub.c:4958 [inline]
> >     slab_alloc_node mm/slub.c:5263 [inline]
> >     __do_kmalloc_node mm/slub.c:5656 [inline]
> >     __kmalloc_noprof+0x3e0/0x660 mm/slub.c:5669
> >     kmalloc_noprof include/linux/slab.h:961 [inline]
> >     kzalloc_noprof include/linux/slab.h:1094 [inline]
> >     lsm_blob_alloc+0x4d/0x70 security/security.c:192
> >     lsm_cred_alloc security/security.c:209 [inline]
> >     security_prepare_creds+0x2f/0x270 security/security.c:2763
> >     prepare_creds+0x385/0x5e0 kernel/cred.c:215
> >     copy_creds+0x44/0x290 kernel/cred.c:286
> >     copy_process+0x979/0x2860 kernel/fork.c:2086
> >     kernel_clone+0x119/0x6c0 kernel/fork.c:2651
> >     __do_sys_clone+0x7b/0xb0 kernel/fork.c:2792
> >     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > BUG: memory leak
> > unreferenced object 0xffff888109b169c0 (size 184):
> >   comm "syz.0.18", pid 6072, jiffies 4294944899
> >   hex dump (first 32 bytes):
> >     00 00 00 00 07 00 0e 02 00 e4 66 85 ff ff ff ff  ..........f.....
> >     68 e6 05 0e 81 88 ff ff 00 00 00 00 00 00 00 00  h...............
> >   backtrace (crc 86e9bbaa):
> >     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
> >     slab_post_alloc_hook mm/slub.c:4958 [inline]
> >     slab_alloc_node mm/slub.c:5263 [inline]
> >     kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
> >     alloc_empty_file+0x51/0x1a0 fs/file_table.c:237
> >     alloc_file fs/file_table.c:354 [inline]
> >     alloc_file_pseudo+0xae/0x140 fs/file_table.c:383
> >     __shmem_file_setup+0x11a/0x210 mm/shmem.c:5846
> >     shmem_kernel_file_setup mm/shmem.c:5865 [inline]
> >     __shmem_zero_setup mm/shmem.c:5905 [inline]
> >     shmem_zero_setup_desc+0x33/0x90 mm/shmem.c:5936
> >     mmap_zero_prepare+0x4e/0x60 drivers/char/mem.c:524
> >     vfs_mmap_prepare include/linux/fs.h:2058 [inline]
> >     call_mmap_prepare mm/vma.c:2596 [inline]
> >     __mmap_region+0x8b8/0x13e0 mm/vma.c:2692
> >     mmap_region+0x19f/0x1e0 mm/vma.c:2786
> >     do_mmap+0x6a3/0xb60 mm/mmap.c:558
> >     vm_mmap_pgoff+0x1a6/0x2d0 mm/util.c:581
> >     ksys_mmap_pgoff+0x233/0x2d0 mm/mmap.c:604
> >     __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
> >     __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
> >     __x64_sys_mmap+0x6f/0xa0 arch/x86/kernel/sys_x86_64.c:82
> >     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >     do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >

