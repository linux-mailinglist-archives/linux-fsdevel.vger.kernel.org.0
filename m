Return-Path: <linux-fsdevel+bounces-18142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C7A8B608A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2891D1F2207B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00DE12A170;
	Mon, 29 Apr 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCFt/uYr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d8bBaizj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820F1292DC;
	Mon, 29 Apr 2024 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412969; cv=fail; b=pzcO37zCxjuh0gxtBIpihgcGj18NeoGOBZJ/wl34DgKug/Q+G1grrbOJo/esDYVlPwGOMTGP1GU3Q2/5IIYV06TpIYBXo8JBxjakgJtEs39D5b9bjOoDp9Crq56aYIgUACe2cBxHo68l/4PrxFTItDYuKGLrcGXgcBL7sUSos3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412969; c=relaxed/simple;
	bh=0WZ139grn3c2NSb5G2oObtKn5U2rJXKAgC49Le+Q5Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L+MYdQhWE2ak+H7UyiFwt/u45wnH0lGMtWBpolfGw4bquFtjkBfUfyUjs2MgX8P9Ff7L2afLosAif00R9xlWTqUsihYqxK8BtGCNqFFE/A5FS117+EN8FCU/+nPXdbJwdMRYtS9Ue4UZ73nzPt6VpXDvenc3XcLgOySzXaBam2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lCFt/uYr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d8bBaizj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGxZ3g008529;
	Mon, 29 Apr 2024 17:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=bQca/KQRMd05SKmt7x3nXh2+RrWgjSRx4vJxErKEjkw=;
 b=lCFt/uYrxscEkyYGAGJ1xC5rMdepnDuEdONaiVDsQsgS6MAcob4IXiVsVjHuxpK7ogxF
 rTL3c2arNfH6zdyAbpD3blnU985SWlAuuH9Ldpvu5Ynpf4TDcHXGDuxMMgImxI8bdStQ
 ly37rXlaSbv+OblXwA5SsZsX2yOdjI2o9/HWQpLrS9aO5iWFog6cUfmWWP3QYOQZMMLl
 PjrHPjuXhXYlsw2HBGinpxm186DQlDkAuKvniQM3hnp+H5jVs4PElBkh/3Ge3Ed5yfFs
 UH2AvnTAkatAtudf+Mf70FlnWYYXUM7ktEJlGR9TyoduQFFmCk14Vm1R2Xq1OITizazP Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9ck8xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43THkxUT004324;
	Mon, 29 Apr 2024 17:48:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtc7ns0-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNzhdnqXyhMEWtjFWHDD7iJ62Xhe+c/tDLYJBm//L4sJvpa5UD2jbRXso0VrohdBTzx8/19scNq3dTZUqHtrw1H7CKrIjgydD3RxG6vY/OO4ERYUHJ5urT2pTPfDeJ/LeGy88Ypl9jC7cGqJ1nsXCwW4JcZorFPtSVLMf+ouPgBPG2FOxMUeg1SJ7IsIFy74DoiaByDEAS7u70ITSkL+iDpf2LHzkyLN/NML/m2yNUE00hc+7ETRmqAbzdZl/022rrf7NVsV81dNeSWLnSNfh3IhHv7duSj7bC8eX4Qyt2Zm4WPpLwRZKWE8zFHFOEyHfLCmWLTbdFoYKGyU9Q03JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQca/KQRMd05SKmt7x3nXh2+RrWgjSRx4vJxErKEjkw=;
 b=F4XJXHsd2lKcu/2l1h1/fHFc3ryrmPWJXR4+2nSLTv4swQ/3/ntEpMeRI63jCSYek4xsSN020Y2zDSw2fR/+wgxeGW3xhCfxfXBpp6nB2HwgwBOwB6uqrZavuBUI644S8HmOMIfY2NQX+c+bOOcZVe8taIP9hJbb7Syn9uqoBG7HH1SbB4aK50jOhcK+3TDbFGgS366+4NCE5wFpijzImTYQ2/qcFAR4Ue/2h+repsEUQ9oGw325aJXuALxXotbnXBI94EHwgoJXi9o0uc+//uIYZTlcZKtD4M+9VW9XTqt0Sj//FHuixq/RtSINlLc3hriD+7PZDhZ1XAWi+xb8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQca/KQRMd05SKmt7x3nXh2+RrWgjSRx4vJxErKEjkw=;
 b=d8bBaizjIQvb7+rN2FtHRd543eGEwxIhXi8AqiZko52r7j/RDNRsrBe9V6IJWuLAxUT1+/BewylGYbB+OXDAj9JNR7NRSgyy9pAgfEt8epqKaaFEk/k/rQqWoajuy3F7eEG7iyDBi6XwssSJBNl16Q4wlCWYcGXgyCvF/RA8IOw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, Dave Chinner <dchinner@redhat.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 05/21] xfs: make EOF allocation simpler
Date: Mon, 29 Apr 2024 17:47:30 +0000
Message-Id: <20240429174746.2132161-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: aed19173-942c-4a2e-4c2b-08dc68748be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vnbfYk5C+TC4mE9gf9yBCsx5wxWqwCprReXrY/xrAVxiK4eKIQ9eH1oO5tTZ?=
 =?us-ascii?Q?Jv9F11mabN+2npavtY3uT6rd+hwN/J8E9CGiVWSj69dbfC9n99if7UaMKrtd?=
 =?us-ascii?Q?kTBk10+QDssa4fwUCHYRDTOeEfMZGjk6m8UvUZDX8qVh3Lfg8396jguZiYxD?=
 =?us-ascii?Q?InqrRn0SY+GEX9lk0TasxFL5ucFofGaRYLQQAiCq0GH/tA+tkDV9oFNjNeDZ?=
 =?us-ascii?Q?lQT3VSxKe9BDrXtIN1gFBP/KYp5VTQOesBG8jSwkLyfo5a6tGw7F1YadmGhc?=
 =?us-ascii?Q?XU6l1HB130ZTcz5oYIhvvtNGgdLOSbX7j8EUvfmn6aAyi2vvNTozGwVJwVwS?=
 =?us-ascii?Q?FwKBBjLSBLIpukUiJxxzNR6N3yWHd/UnUjAb7CQHZaP+PJpnUl4hFd7qIBGq?=
 =?us-ascii?Q?RwTBFaf6JXPaPMirHtwvWNqAD1fL3hffUU8MLfxnCUmwJ0MFCyDESPo0YNKR?=
 =?us-ascii?Q?dZYE8MUCXAAu5aaf9/XhI/vUZEBLPBAEJP13EXbuZgd4yEnWjSQL1iia7x2s?=
 =?us-ascii?Q?deCa3DtOO7ztFCwZG5hUocUyjJSl/QqFPT4yMwAro6cJzt/bLt1erVShjwM8?=
 =?us-ascii?Q?IdllcydcmLDyd3Mn/2YZurAITFx9cpNE/lK/9OJte6pxJHg0DlaYLOoE4JLx?=
 =?us-ascii?Q?j732VjSgrmfDJkbAwgFFQiB6Qqa0T1zHJqz3LDS4tvQaneF1jSnmXqTMO4Vl?=
 =?us-ascii?Q?zZDGA9G7KqgcwGw8TlRhfcdLUL8RwwJxImVSzb4VFse3O0vK1K34WgRKIqnM?=
 =?us-ascii?Q?VYmLPRMC5ye06K1XuNSOnHaJnghTd9PjcfUs3GhY2bG6h3jaRhL2GtQleWN0?=
 =?us-ascii?Q?S3heGKKc3j1ZI0gEfrNix+ZJNyYF6OcfUoHH/tgfgWYeeFa6F0rw0DrO5mP/?=
 =?us-ascii?Q?RaJhMtyGKBi0xvJ7mZAqi+amQtqmqIwexLKP3cwzimTnExpDWhVzqEq9LhXP?=
 =?us-ascii?Q?Ry06EVsfLtJcT9i5B0fwibWVKEnS5mpGVN2RzSR10FxuBQLfgcin3fz+SWeZ?=
 =?us-ascii?Q?ZABxTcXEosvFF8olDUdqWogYsppyZMwn6DGQo49mcA8ECIFIVkNCLmhA2yhS?=
 =?us-ascii?Q?rmaVef5F5fQJnANXBKgfbd5ND5xL1ubdweKZC8yTCdR32Va19jv/CfyDIL+N?=
 =?us-ascii?Q?7+4/EKIYyTolOjbnrJuUZTLaezIjHNNxYS1kIkh8qQ9WFkbZlhDL6P8NV7y6?=
 =?us-ascii?Q?ieNFX+rEZDTYnzZvK7DO+2QJkzblkVjvUmhdeV9SvRyjAZ0AsuOX8Jwo6Xn/?=
 =?us-ascii?Q?sUgPexb2Y6pPA9OWz7VBuu9z4jJl69Cq4puq070+lg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w/2ogVyCLEUscD4tl8LAkkOqM2zWKFUa+zejva/dvVaKxdDn3J3EEiuTkPBb?=
 =?us-ascii?Q?0zVYm6hRr4Uwqm/GmX9V5iPt9zqieT0KNdlsUqRabL8oUrlx4373teMgSyeZ?=
 =?us-ascii?Q?31U/DbxoC+ViSnwCK/MRQ6tzrdndNT2dRQ+SX8qsloEZMFTUiR7qendQ+Mo0?=
 =?us-ascii?Q?8vNsCGP7ShFa78+aNAfFFCZN72Yv+VyshYbZMDyQ8B4md+wH/kzz6KpLXmmF?=
 =?us-ascii?Q?tLsMphnbby2jImqHicptBdnHi6ZEHlurKGKI65PT5JCc1QtfOlJ48azXcj6Q?=
 =?us-ascii?Q?m6zyXLFe4+Y8Cuad4VbFMOymARM5beDlYooi6WsWrao2tbgkVWIngZ7tEB9w?=
 =?us-ascii?Q?l+G5p9BeigJyOFdYRQNvQvlM5jw0RzBPi8JEkGvKw6tg4mMhDbhZuROEKcyO?=
 =?us-ascii?Q?x63XBsIMFEqNZ1jg6Xg4SeUYa08Zd6XpX5Eke/xV6j/AA0155EAlYi0VJ6Gw?=
 =?us-ascii?Q?cCdkPaZZf91JMvcFPd9o+8RWiIZ7NNzuGxp9HlW79Sh2Hx2VlLD7DLPtZf2T?=
 =?us-ascii?Q?r7hA5OSyMWnt27EJ826ZIDghzoWYaPWRuX2BUtAKJex2BTxhbClynyU95sp6?=
 =?us-ascii?Q?e5PiZ87vEDDJCegI5m2frhgbIghHtjtYcOF63H0jThkugbCdb2BW+c2n0BdJ?=
 =?us-ascii?Q?qqOxA2HZdCriMgsf2T6lDWGzeYzIzqoiB1wxO4MXPnXhdGgF6b2gOiHnhi+A?=
 =?us-ascii?Q?dpFh/MnUreVq+WyR96sQhAmCHNytKo74kPiY8Dsw6DsxQ/qIY4ncO46S4J11?=
 =?us-ascii?Q?/uHljrKuiYJoXOJ7T3ABD/rXWDYz55vassalVEtUTzIByXo98z2ZweO5ZaEm?=
 =?us-ascii?Q?5tvBwLxa5tUbOnQph0tMd8zFUbRDNFg58kMG4z8p7lgezQ0rj9AIEygKRqym?=
 =?us-ascii?Q?pCj+Jx7f2W/Jl/iDraL2Rp8YFzc/NG2HKwWjyfKxtxFzMzNbEMfcNtJplUYv?=
 =?us-ascii?Q?jUy+7Hmt5yMUeX/RMyOAQP9qLUgEwAEOGaAPGYNMVJJnOUoXkPQrkXp/yBT5?=
 =?us-ascii?Q?ngOdo+0cdAJyPcM8ZcWRQecruHE57pZ2qfucm1nrFGh1jxAJAlgXhjRWyzqY?=
 =?us-ascii?Q?TQlMdguiZfsyJnRUrkuGlkc9Ut+MHS/dgrFxWFAmZqUWU8zPRmU7VYjVeF43?=
 =?us-ascii?Q?b2G9zMZ6mHvSaummnBiYb+aUI+CvJ5ULlF0/ZjpP0Kf6T0pOHo3lmd+tJITI?=
 =?us-ascii?Q?zgItiCZ/wPkoWgRaVmy7JAjdl0Z+RZK036NEswwwdnJPNzyz9lXMqbn/+H6a?=
 =?us-ascii?Q?pFlkAIO99t9EOA5+0kGukLS5iacivrr0BgksfK69mFkQIPUicx+ns8nD1UYm?=
 =?us-ascii?Q?fldLCbqjSR62TyiB5XXx3JYz6zUTOCQtZcqOZ5mpcPCKBrCcYNpIH43wH8oZ?=
 =?us-ascii?Q?hw1XhNhERZfoAiOKCWK7GQZX37ED+DsHIfAUasnZS/aQuwidQregU4CAH5L2?=
 =?us-ascii?Q?9MEvoOeHAplYevoI+QW6YXTk9nVAZMCNsxG0WehdH/2tYlRvuW3n2M4p2kxg?=
 =?us-ascii?Q?4RbI/vXgbdCsTtGUNGDtMZBqVKYgAUqepCX/WsHBFdzky6Ics+RMdRf+ppwB?=
 =?us-ascii?Q?FlkGYH88vwa/4ugppwGgaaNeR+d84qjkHA01gXdTH8g8yRFtu+PnhZuwvoyu?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mXjQ+TR+x0oksFDtDwVRBAQh1/2DkId0mAEeiTbFMz8HHfr6wuzHpbi7k8669G2S0nxc3Mk5ZVO7cHsBmbG3qo11cTZlmfwZY7rU6JtH+4JyxkCAjF46gh/TaOeOkIA2gGcyL1aJgxL/rTfRhCzDCPcfutf5b7r18/4dZRDkVByPkw0l9o/G+yXyr9DX79Nn9CklGk6zuVo8fplLr7VpBUY23GsKXxyc+/4LowH3QPUdvO4CrGbHrHwZMlOAW8fXCIWahgtl2MexHME1uVhgzseLSIMkN/EpfDCErT4feIO8ajEe98TuUn8LenR0nCdrBecc3zaoGKADsDuK5ZnKVnCDaFXiS0UDGVy/r80SfiSmzb2ibovPnl/9qSvtoPwWDL7CiqViJkKzAKRMYI70kKsQHOxZEkWhNwF7EJY8PaP6aoFwTQJgDVbULu0dB1wP+YsPIGgtBhtIYCnVqhaCIO+KYnq59uohXL8YHRDBAj8c0ZMjrA6wMMCsQemlVuTlfyU6vjBm+KcGSjA9jZfq2JoUWmucWJCRIliKXjriEQT+La60k+CUF7MIkpHVo+BLUCutqcZ8IO4+knxJeEM6IZVZZiJMkCGL0FZPI/otKgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed19173-942c-4a2e-4c2b-08dc68748be1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:15.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePQkf1OTCzm67dtiCpOmYC7J52pQK4GhzNbVDf3XlHjASvxkK9ArFXmPfSX/IArj86CxjbHiTDQfm7bF8sLteA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-GUID: -VYy1QLgAcCq8jDG_boLqWWgtjpIWCsx
X-Proofpoint-ORIG-GUID: -VYy1QLgAcCq8jDG_boLqWWgtjpIWCsx

From: Dave Chinner <dchinner@redhat.com>

Currently the allocation at EOF is broken into two cases - when the
offset is zero and when the offset is non-zero. When the offset is
non-zero, we try to do exact block allocation for contiguous
extent allocation. When the offset is zero, the allocation is simply
an aligned allocation.

We want aligned allocation as the fallback when exact block
allocation fails, but that complicates the EOF allocation in that it
now has to handle two different allocation cases. The
caller also has to handle allocation when not at EOF, and for the
upcoming forced alignment changes we need that to also be aligned
allocation.

To simplify all this, pull the aligned allocation cases back into
the callers and leave the EOF allocation path for exact block
allocation only. This means that the EOF exact block allocation
fallback path is the normal aligned allocation path and that ends up
making things a lot simpler when forced alignment is introduced.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c   | 129 +++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c |   2 +-
 2 files changed, 54 insertions(+), 77 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index d56c82c07505..c2ddf1875e52 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3320,12 +3320,12 @@ xfs_bmap_select_minlen(
 static int
 xfs_bmap_btalloc_select_lengths(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		*blen)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*pag;
 	xfs_agnumber_t		agno, startag;
+	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
 	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
@@ -3339,19 +3339,18 @@ xfs_bmap_btalloc_select_lengths(
 	if (startag == NULLAGNUMBER)
 		startag = 0;
 
-	*blen = 0;
 	for_each_perag_wrap(mp, startag, agno, pag) {
-		error = xfs_bmap_longest_free_extent(pag, args->tp, blen);
+		error = xfs_bmap_longest_free_extent(pag, args->tp, &blen);
 		if (error && error != -EAGAIN)
 			break;
 		error = 0;
-		if (*blen >= args->maxlen)
+		if (blen >= args->maxlen)
 			break;
 	}
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, *blen);
+	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	return error;
 }
 
@@ -3561,78 +3560,40 @@ xfs_bmap_exact_minlen_extent_alloc(
  * If we are not low on available data blocks and we are allocating at
  * EOF, optimise allocation for contiguous file extension and/or stripe
  * alignment of the new extent.
- *
- * NOTE: ap->aeof is only set if the allocation length is >= the
- * stripe unit and the allocation offset is at the end of file.
  */
 static int
 xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	xfs_extlen_t		blen,
-	bool			ag_only)
+	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*caller_pag = args->pag;
+	xfs_extlen_t		alignment = args->alignment;
 	int			error;
 
+	ASSERT(ap->aeof && ap->offset);
+	ASSERT(args->alignment >= 1);
+
 	/*
-	 * If there are already extents in the file, try an exact EOF block
-	 * allocation to extend the file as a contiguous extent. If that fails,
-	 * or it's the first allocation in a file, just try for a stripe aligned
-	 * allocation.
+	 * Compute the alignment slop for the fallback path so we ensure
+	 * we account for the potential alignemnt space required by the
+	 * fallback paths before we modify the AGF and AGFL here.
 	 */
-	if (ap->offset) {
-		xfs_extlen_t	alignment = args->alignment;
-
-		/*
-		 * Compute the alignment slop for the fallback path so we ensure
-		 * we account for the potential alignemnt space required by the
-		 * fallback paths before we modify the AGF and AGFL here.
-		 */
-		args->alignment = 1;
-		args->alignslop = alignment - args->alignment;
-
-		if (!caller_pag)
-			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
-		error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
-		if (!caller_pag) {
-			xfs_perag_put(args->pag);
-			args->pag = NULL;
-		}
-		if (error)
-			return error;
-
-		if (args->fsbno != NULLFSBLOCK)
-			return 0;
-		/*
-		 * Exact allocation failed. Reset to try an aligned allocation
-		 * according to the original allocation specification.
-		 */
-		args->alignment = alignment;
-		args->alignslop = 0;
-	}
+	args->alignment = 1;
+	args->alignslop = alignment - args->alignment;
 
-	if (ag_only) {
-		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
-	} else {
+	if (!caller_pag)
+		args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
+	error = xfs_alloc_vextent_exact_bno(args, ap->blkno);
+	if (!caller_pag) {
+		xfs_perag_put(args->pag);
 		args->pag = NULL;
-		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
-		ASSERT(args->pag == NULL);
-		args->pag = caller_pag;
 	}
-	if (error)
-		return error;
 
-	if (args->fsbno != NULLFSBLOCK)
-		return 0;
-
-	/*
-	 * Aligned allocation failed, so all fallback paths from here drop the
-	 * start alignment requirement as we know it will not succeed.
-	 */
-	args->alignment = 1;
-	return 0;
+	/* Reset alignment to original specifications.  */
+	args->alignment = alignment;
+	args->alignslop = 0;
+	return error;
 }
 
 /*
@@ -3698,12 +3659,19 @@ xfs_bmap_btalloc_filestreams(
 	}
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
 
+	/* This may be an aligned allocation attempt. */
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
 
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
+	}
+
 out_low_space:
 	/*
 	 * We are now done with the perag reference for the filestreams
@@ -3725,7 +3693,6 @@ xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t		blen = 0;
 	int			error;
 
 	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
@@ -3736,23 +3703,33 @@ xfs_bmap_btalloc_best_length(
 	 * the request.  If one isn't found, then adjust the minimum allocation
 	 * size to the largest space found.
 	 */
-	error = xfs_bmap_btalloc_select_lengths(ap, args, &blen);
+	error = xfs_bmap_btalloc_select_lengths(ap, args);
 	if (error)
 		return error;
 
 	/*
-	 * Don't attempt optimal EOF allocation if previous allocations barely
-	 * succeeded due to being near ENOSPC. It is highly unlikely we'll get
-	 * optimal or even aligned allocations in this case, so don't waste time
-	 * trying.
+	 * If we are in low space mode, then optimal allocation will fail so
+	 * prepare for minimal allocation and run the low space algorithm
+	 * immediately.
 	 */
-	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
-		if (error || args->fsbno != NULLFSBLOCK)
-			return error;
+	if (ap->tp->t_flags & XFS_TRANS_LOWMODE) {
+		ASSERT(args->fsbno == NULLFSBLOCK);
+		return xfs_bmap_btalloc_low_space(ap, args);
+	}
+
+	if (ap->aeof && ap->offset)
+		error = xfs_bmap_btalloc_at_eof(ap, args);
+
+	/* This may be an aligned allocation attempt. */
+	if (!error && args->fsbno == NULLFSBLOCK)
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
+
+	/* Attempt non-aligned allocation if we haven't already. */
+	if (!error && args->fsbno == NULLFSBLOCK && args->alignment > 1)  {
+		args->alignment = 1;
+		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	}
 
-	error = xfs_alloc_vextent_start_ag(args, ap->blkno);
 	if (error || args->fsbno != NULLFSBLOCK)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 164b6dcdbb44..592ee9c2ae40 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
 		 * the exact agbno requirement and increase the alignment
 		 * instead. It is critical that the total size of the request
 		 * (len + alignment + slop) does not increase from this point
-		 * on, so reset minalignslop to ensure it is not included in
+		 * on, so reset alignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
 		args.alignslop = 0;
-- 
2.31.1


