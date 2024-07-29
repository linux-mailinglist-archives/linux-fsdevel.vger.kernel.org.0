Return-Path: <linux-fsdevel+bounces-24435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0093F485
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037B81C2167B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B1C1474DA;
	Mon, 29 Jul 2024 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qkz8Bgo/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w2YuB/33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915C1474B6;
	Mon, 29 Jul 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253895; cv=fail; b=MRPwuYaYQLCThh/BIizg9JJHgTk2jcEALeDlEjbHw9+CLhqeCXGgeOIsxMXtDypXGtx/PSBrDhyU1vzqPlCcaZQpwglKPjDv1jC4ZYPcPi6G7B+lv0zwdWtAuknYe/nVpGxlmmuVSOqsMf/sIuMhFKLO2QbcD54NVmXpGqk3kHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253895; c=relaxed/simple;
	bh=QGvFHBDuaPu/LVtOxK3O4Wfyh0jw2T2Ga6EOOLbps20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIUygQ9dyYSyECByRIB891NzTihvA5lDUf5KecmpuC2YqHtV9oKAMBn6h3OtAH/W31kZc5UXWGQ9DeGcT9aqV/dBJNszcEaHT5qvHSpqvYT8vXvp8jcdJS9UWnk+j/w0i7XpGSOafdMcCbr7/LbKwMtb7m7CqEweCffVfuasnKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qkz8Bgo/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w2YuB/33; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MXaZ018367;
	Mon, 29 Jul 2024 11:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cDxNkSoIeY29Ui9zcs5X0Vh1jlKEEnhLuoyQyV3JJmk=; b=
	Qkz8Bgo/hJZLua4/yZTqxBLXaMv0M8P9HM4+nYGURvMIO1ufVXP7T3WSffq4wbWE
	+0Oyz4Rtn7ZWCns7aX1TR++9vLs2SLHTdI9+mCzRLxCxlb+QDt4WXJpTlPP1EQ8o
	yyPn3/6t6h1idHRIAh2xHUFe88b4CW4LhY6YoP3SdY1EaSvPj+/j3dn9W+7cpwzM
	/Ian/rTvhWODXEkZDXnnoKyLJylIBi7vz88ZkYvrIGLAfHD2SxYO4lYCSO9FkXEM
	c0r4CLBk1B8YBGdIDfjsLhFzbPJNjApZDXlbs/bP9MtZwt+YKrZhYLYtn6Nyt2JE
	DkXT2hQihE44qRwfGijPVw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs2bdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TBXkeM025722;
	Mon, 29 Jul 2024 11:50:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40npcegnam-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVXmVH8K3ZZPitN9yiw6WvsGyPGdVLEphT/9TWKtCQ9GTL059XqLT2IPEduVap08Aa45CbVmRKMhXyu6g+QTcPficq+cqIUffgQpq1QEe4Lgurt0F9QwHePCRD4nnNYG6G8QRxls7gnlNrO5BGbq3UYK90H248WkAO7DGKPHtvwyX2cneWfJtMnGRLseG6FQGTso+Wm0g9dAu5enJ9gHgrPDt6uN9K35KAyJ0VaHdHXiGJWg83f5vyZtTqlsiyy3c4TcTKh1369GD/lg5bWsp5v074y/m6as8wdaWB+y9c06/JLiR3fA3oham1VKRm7PbSCKEq5ycQSrpoDSxD1LDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDxNkSoIeY29Ui9zcs5X0Vh1jlKEEnhLuoyQyV3JJmk=;
 b=QbLMD5j8bwLlGHyyKkvoIH7+hSn/bSKt7+X9plx0BvOz/AER9TcU0tjCTlo+ACif+uP/0c32E+UO9ZsY2M5esuN7/YMEg1E9z/y9vm2YNpuyMzi903ULnxgYITD5dGrg0JaZzw5/8SHvrHgaOYMVnD9YWFJ7ReFUIDWzNZbUfar/tp45OdiGqx2eWrFju2Na20EE4bmkUSAXZM8sSYR0MJM+yQKrVEJ9cc5HLmByTAr43xYlINH9TlvlN8trol1IzsduZxgsWhM9qUHnqtUmYEohBDgNhc89UaajDzdZsODl+YWm9MYJfWbrvTrPr0xSngpGKcUksPk0E6U5FmZm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDxNkSoIeY29Ui9zcs5X0Vh1jlKEEnhLuoyQyV3JJmk=;
 b=w2YuB/33n2ycRQbXkhSNhaZynxkSisJRB4DZ3hUFCN6vTYRHkkZe82W/wg5v15o1B5m9ArWu1edKUwonIjKzvjPoFTdna6Z4eFQUgDYznDFCqobq6S8MMqYx9xuUVjY4PWDfJhTtAGAtriIrcHD+IX/Euqm8Fcr+vFVF/SJ+qFU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 11:50:54 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 11:50:54 +0000
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
Subject: [PATCH v4 1/7] userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
Date: Mon, 29 Jul 2024 12:50:35 +0100
Message-ID: <50c3ed995fd81c45876c86304c8a00bf3e396cfd.1722251717.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::28) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: ce41b799-98b9-4fdd-c645-08dcafc4b38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7nOOScVXEUCoHAUPpi/otGVvnoaiONZJJc/G7tJqeIpiTcx3Avse1+E8zolA?=
 =?us-ascii?Q?rs3cQhP7inzqQZcco/LWeiR/4678JrHaImexiKEgsOtt8MmjVWPWNm1CUMgC?=
 =?us-ascii?Q?sEilXtXLP8RP6K56uRNpQTs+mmd9G7DNcYji0QrSg1awdxXQbd3aqX7494Vh?=
 =?us-ascii?Q?zk3oex7bwcbJ2MAJCQT/CoufTI94Bmr4GdsPrM/nSx9UjioaM/8XcOwIpVfm?=
 =?us-ascii?Q?bLOF4H4GsF9H3O8raV1ugFxDvrBfMBIvlza54XpsSgqiNW70hx6CB+jJ6yfF?=
 =?us-ascii?Q?IHiE207HAowJxiPnPpA6VPtjxDo7W80tATljkSi2Lwhhpwk7lGMhcVg7DlhC?=
 =?us-ascii?Q?lXbVlSxuPYF50zr7ulKUiitMgFRpTbMkQVt5k7hNhQpntsFrLYzj5GjbPZlA?=
 =?us-ascii?Q?Kex6G1PxhJoNvTPb70rXyZkiaCH3Z6dDzf3zrK36yyxVnafrYqlXhyAR//8R?=
 =?us-ascii?Q?pms71zPEDhWccBsy44NAy1/PEXn1eqc+Utkohaq3UU5lm8Xo/+Jk2xA0yh0y?=
 =?us-ascii?Q?VKw/EWW0GOT6JeTFTxvDX9Yw5Y/C2sKVKGrXyJsqOpJdCT+zqFUkvGj+p7FW?=
 =?us-ascii?Q?hAiL67WgAOd2LtkakOX+VgpIEUwD6r1qqxxr+GfD9pd6D32/UlS9rtJV/lgv?=
 =?us-ascii?Q?AGIwMwmzER3L9t35KsoS+x3OK+g2fKc6eDbhT/6eyUiRsxj5/sY9K29wPfKP?=
 =?us-ascii?Q?MFWmfkp3wI401bhTQNUPyQ2CKpczDdb1uuYu0q2N1pq7LsrErliY0E0ZhogH?=
 =?us-ascii?Q?l77pUgbRTBAx1VRaSMZaKpkyTLWuIYqitfjm4cYiV+cH5N0qCC/j5RRrQFFM?=
 =?us-ascii?Q?73upOM4E/wJC7QeKgI9ch5bAJt9FEAsnO0Go0T7GBqWJkQ4n1In7CvnTLMTU?=
 =?us-ascii?Q?vGQ2vNx7qp/04dqYuB/o/rj0pQMDIjtDTFwxBxnpT0b+9kdB8OPCO+zK5DI4?=
 =?us-ascii?Q?smQ5Db17tQ1zjKyZkIL93Ec9CHA2kNdkXssIG1lIaF36LHKawXShGsAx8LPM?=
 =?us-ascii?Q?HirhEW7+HiBRI97V3+iI+cul7ivE6VDIznmRbHjcgrvSjQlnWvJzXioK8Bb9?=
 =?us-ascii?Q?7iPnwdWVEHcPNyfJwskJxVG4LXKmAggxEwSjoUjAPG/+svhLbxEvijCUndIN?=
 =?us-ascii?Q?ujpY3km5W9Q7MYjqz2kmiDXYLuZh9HVgWjS9xdEEM251/t4r8hWlplIV7Rsv?=
 =?us-ascii?Q?zU9Dll+dQ0wPxF8/gASsADQ3hJshrMqZteHL+ZZcgdRGoPgJf7ui1HoLcrND?=
 =?us-ascii?Q?nv19o0F4ixrmF5/Te6wKTj8yvpIsM8rm7WmAzplFw0Unfh/pwrSMuchQulHz?=
 =?us-ascii?Q?5LaU9rAiVWf4mNME091S2kDWsfrlVObumYbxY6SQCFSXpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HMd9BdT9Mc3bP/Sn6uK4pA2pWAAEiOAzgwwBRqcFANzhuafMW8y1EbiLeOtl?=
 =?us-ascii?Q?oKwBllqepEhJtil6aGa/V564VJEQoH6KsmZWnZXoODL2toA4nZH7d4Jbbjht?=
 =?us-ascii?Q?IrVPWl2MI9d1TP4Q91hi69bdHF9iA205a17Lt1axBOVp8zSL82YjE8WZilyz?=
 =?us-ascii?Q?Xki3e+OuwBNKdekDTFZX/aQwZjlkp5TBaDhteIniAn9GFtsMWATZsetQeX+y?=
 =?us-ascii?Q?ulKbxk8LC3oyzbwedb4AOPxGgXWVHZi8zzALeoxNEGuk0katZSBodNu6ZhOx?=
 =?us-ascii?Q?RW9Hv//0c3arSb+v/rYItBF+g3dapkxyG1lu3d6MTCz4vGow7hFTsK51G8DZ?=
 =?us-ascii?Q?3t2intEwUO6J3oEaIK42LKr/DXhqWkPcRbxw3y42lT3kPT2IkRx+h+nMxSt+?=
 =?us-ascii?Q?PTN2Rwn6sgqAx/n6nRwDVYvZldhCgJSvQOgRsPTV9t/1fzHCwWHeCDcoAZLH?=
 =?us-ascii?Q?8QQL3mKLBtMQS8PrAM/gxXyHNRNCELxCFOhAee3IWYqlanGiA4CwtPGMTqit?=
 =?us-ascii?Q?s7hzrn0vy5lzaxof+tiVZIH0TFZDDAdj5s6AkCGq65Q/j6Xcc4ruyF/Qn24f?=
 =?us-ascii?Q?RPtUKWUMmcBJf6xwaNClJ+/nnS6Vy+reweqNBS+7wzai4sIPj+feR3ZkaBUK?=
 =?us-ascii?Q?5QYobp6PNSTUbLrw5v0XOKAyrwad9sO32im+vxXcHNwHjZj2h1hXC2UzQU/1?=
 =?us-ascii?Q?Wfj7/tUxvmoa2Bn+kQeXyqVCAwlGanfG/jjM+MU7kGtjIMahHA7C42PTTpnc?=
 =?us-ascii?Q?Psap1dPH0lm3sCam48kTe5NH2TlwdQ2DSArdDRcDy8YnwoMxkQyPq8Hz2j8m?=
 =?us-ascii?Q?P6ig+vFTT/gpJe/jjnPNpXFgGbrH9dRLKzt7CtbsaaldCWRdwrdxleJDkNaZ?=
 =?us-ascii?Q?MDBhJSEFr7mDbpGigSIlMfHvYM8GALu59hDUsD+nhRlL10FtbtrvzY6SD4GY?=
 =?us-ascii?Q?a0rW7F6XhW1kX0dX9ZPU1LxBqNvJ3CFJFnbAIotKWDS8KnIrmO4QAmIEwDBM?=
 =?us-ascii?Q?jFHFuOsPOZ5a0RzZjGq7FMa+SdDonokAYyRcY9oxJgu6lK9idbhGnQ7jr5bp?=
 =?us-ascii?Q?ro+rPdxXVXGwu/9/w45ju3PI7Of+JLBM4B5fQKVY6rGhPiORVqzMloQrIGxu?=
 =?us-ascii?Q?iDnb97uRbF91Z9cgXW9dxH+bTK+g8h6qfQJ1ilT09xDa8JUtuGYWMbclyZzu?=
 =?us-ascii?Q?QM6rCZuyYeFJaW6afgp6Bdq6uDNK9bwcGf3l3dIRxUMxBcEgrg10Hg1LfVom?=
 =?us-ascii?Q?oYTwG/ojse3eGWJVNEJXITwFDTk7gCI1NBfTrsBntTbmjIcjy69SDOENx1Ce?=
 =?us-ascii?Q?jdMLwKYHuxp1DxEG/77lbJWyWTRfJr4zU6h70VElNyxSIuZTgIyFQ1CVMQm+?=
 =?us-ascii?Q?bQ+s7kwhM1IC1u8yY1u2pYW+vVzxS7rI2erdn8kJkR4XEAoH/Ywy1KRDmlI8?=
 =?us-ascii?Q?O9NxCzBp7K2KvhG8Py9uB6UUGKr3hZW4ve/QPi/b59ksPUGoBK85wrJW+9JD?=
 =?us-ascii?Q?SYFpqRL90olIcVGQJq8bV1g4RSnpNIQkcsobM9lFnNsG3zNJQCwhDdUvDWc0?=
 =?us-ascii?Q?Owj7TzOgVVjb2U02TWZyChwBrKuELku+evIVRSrme18iEViuMIct1OsVQKtw?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5wBmcG5DtPLD0AeKemk7yFumnsNGHF6LDRK0bPf1noRIyBeJu8aLxJGs/0TKETz87DpE5eP5t9PXP+fYab1YXDtMX6TcLDmXBMSCDRJ1G/FcoryunYNZ91rB5SdJlmW0+ccOx+UDZhaPUErdMcOAxtfOYHOtkuCg2bib2XJ6dSVoZc1qdzl+a32fRV32/T9KAazpW+NEndjvg4npJFw5gxjEqIsuzSx9E0dq0KKXS2YukmTSoAPssrc+ic2PUSl51eiY17pQxoFhuEczpt6rFGWrqEXH3alF5xoE9G0pts3Q3UkrWsrzFcti0NHHFCczqH3oYKKnFyAwD8OanQp3Ag4CdgZP2oru0/YPVBDhW9HtlsZ9eDGyhGbDK2CN8ZqSm+WiZKn7P38PdVNoqdnm4JSChTEbpeIqpZjK83VFLVdRjtSBMEU9LkBNcAwBvJ5FkN95qWC7KtoLCxbWDBIvI6PewgmZAer+WhOxELqpbyxZzC3BXwWS6+7lILuAzqY68v/JoCPpe7fn7l6YPSQrPBICHIQkytbxfoGwwpkSwZa6vmBP5FXWdaYpRL7pLXuLn8ran3KJA0r/dGuGhy7xBx9I+LjF+Ehd/mwMupeWXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce41b799-98b9-4fdd-c645-08dcafc4b38a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 11:50:54.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFm5AzEEhC0eyB7ZiHqFo/j6LmFVCbX2Hk9a5KUZSeLidHUBxCopZgUM66ZuETte7h5QZmNOjA+KHGnh+oI55UZcmQxv9r8BQ9fKi1gKrI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290080
X-Proofpoint-GUID: VN1g3t3-iZJZX1V6kEV-GjVWiYqFC14H
X-Proofpoint-ORIG-GUID: VN1g3t3-iZJZX1V6kEV-GjVWiYqFC14H

This patch forms part of a patch series intending to separate out VMA logic
and render it testable from userspace, which requires that core
manipulation functions be exposed in an mm/-internal header file.

In order to do this, we must abstract APIs we wish to test, in this
instance functions which ultimately invoke vma_modify().

This patch therefore moves all logic which ultimately invokes vma_modify()
to mm/userfaultfd.c, trying to transfer code at a functional granularity
where possible.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/userfaultfd.c              | 160 +++-----------------------------
 include/linux/userfaultfd_k.h |  19 ++++
 mm/userfaultfd.c              | 168 ++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 149 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 27a3e9285fbf..b3ed7207df7e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -104,21 +104,6 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
 }
 
-static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
-				     vm_flags_t flags)
-{
-	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
-
-	vm_flags_reset(vma, flags);
-	/*
-	 * For shared mappings, we want to enable writenotify while
-	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
-	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
-	 */
-	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
-		vma_set_page_prot(vma);
-}
-
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
 				     int wake_flags, void *key)
 {
@@ -615,22 +600,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	spin_unlock_irq(&ctx->event_wqh.lock);
 
 	if (release_new_ctx) {
-		struct vm_area_struct *vma;
-		struct mm_struct *mm = release_new_ctx->mm;
-		VMA_ITERATOR(vmi, mm, 0);
-
-		/* the various vma->vm_userfaultfd_ctx still points to it */
-		mmap_write_lock(mm);
-		for_each_vma(vmi, vma) {
-			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
-				vma_start_write(vma);
-				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-				userfaultfd_set_vm_flags(vma,
-							 vma->vm_flags & ~__VM_UFFD_FLAGS);
-			}
-		}
-		mmap_write_unlock(mm);
-
+		userfaultfd_release_new(release_new_ctx);
 		userfaultfd_ctx_put(release_new_ctx);
 	}
 
@@ -662,9 +632,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 		return 0;
 
 	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
-		vma_start_write(vma);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
+		userfaultfd_reset_ctx(vma);
 		return 0;
 	}
 
@@ -749,9 +717,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		up_write(&ctx->map_changing_lock);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
-		vma_start_write(vma);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
+		userfaultfd_reset_ctx(vma);
 	}
 }
 
@@ -870,53 +836,13 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 {
 	struct userfaultfd_ctx *ctx = file->private_data;
 	struct mm_struct *mm = ctx->mm;
-	struct vm_area_struct *vma, *prev;
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
-	unsigned long new_flags;
-	VMA_ITERATOR(vmi, mm, 0);
 
 	WRITE_ONCE(ctx->released, true);
 
-	if (!mmget_not_zero(mm))
-		goto wakeup;
-
-	/*
-	 * Flush page faults out of all CPUs. NOTE: all page faults
-	 * must be retried without returning VM_FAULT_SIGBUS if
-	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
-	 * changes while handle_userfault released the mmap_lock. So
-	 * it's critical that released is set to true (above), before
-	 * taking the mmap_lock for writing.
-	 */
-	mmap_write_lock(mm);
-	prev = NULL;
-	for_each_vma(vmi, vma) {
-		cond_resched();
-		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
-		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
-		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
-			prev = vma;
-			continue;
-		}
-		/* Reset ptes for the whole vma range if wr-protected */
-		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, vma->vm_start,
-				      vma->vm_end - vma->vm_start, false);
-		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
-					    vma->vm_end, new_flags,
-					    NULL_VM_UFFD_CTX);
-
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+	userfaultfd_release_all(mm, ctx);
 
-		prev = vma;
-	}
-	mmap_write_unlock(mm);
-	mmput(mm);
-wakeup:
 	/*
 	 * After no new page faults can wait on this fault_*wqh, flush
 	 * the last page faults that may have been already waiting on
@@ -1293,14 +1219,14 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
 	struct mm_struct *mm = ctx->mm;
-	struct vm_area_struct *vma, *prev, *cur;
+	struct vm_area_struct *vma, *cur;
 	int ret;
 	struct uffdio_register uffdio_register;
 	struct uffdio_register __user *user_uffdio_register;
-	unsigned long vm_flags, new_flags;
+	unsigned long vm_flags;
 	bool found;
 	bool basic_ioctls;
-	unsigned long start, end, vma_end;
+	unsigned long start, end;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 
@@ -1428,57 +1354,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
 
-	vma_iter_set(&vmi, start);
-	prev = vma_prev(&vmi);
-	if (vma->vm_start < start)
-		prev = vma;
-
-	ret = 0;
-	for_each_vma_range(vmi, vma, end) {
-		cond_resched();
-
-		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
-		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
-		       vma->vm_userfaultfd_ctx.ctx != ctx);
-		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
-
-		/*
-		 * Nothing to do: this vma is already registered into this
-		 * userfaultfd and with the right tracking mode too.
-		 */
-		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
-			goto skip;
-
-		if (vma->vm_start > start)
-			start = vma->vm_start;
-		vma_end = min(end, vma->vm_end);
-
-		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
-					    new_flags,
-					    (struct vm_userfaultfd_ctx){ctx});
-		if (IS_ERR(vma)) {
-			ret = PTR_ERR(vma);
-			break;
-		}
-
-		/*
-		 * In the vma_merge() successful mprotect-like case 8:
-		 * the next vma was merged into the current one and
-		 * the current one has not been updated yet.
-		 */
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx.ctx = ctx;
-
-		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
-			hugetlb_unshare_all_pmds(vma);
-
-	skip:
-		prev = vma;
-		start = vma->vm_end;
-	}
+	ret = userfaultfd_register_range(ctx, vma, vm_flags, start, end,
+					 wp_async);
 
 out_unlock:
 	mmap_write_unlock(mm);
@@ -1519,7 +1396,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	struct vm_area_struct *vma, *prev, *cur;
 	int ret;
 	struct uffdio_range uffdio_unregister;
-	unsigned long new_flags;
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
@@ -1622,27 +1498,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}
 
-		/* Reset ptes for the whole vma range if wr-protected */
-		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, start, vma_end - start, false);
-
-		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
-					    new_flags, NULL_VM_UFFD_CTX);
+		vma = userfaultfd_clear_vma(&vmi, prev, vma,
+					    start, vma_end);
 		if (IS_ERR(vma)) {
 			ret = PTR_ERR(vma);
 			break;
 		}
 
-		/*
-		 * In the vma_merge() successful mprotect-like case 8:
-		 * the next vma was merged into the current one and
-		 * the current one has not been updated yet.
-		 */
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-
 	skip:
 		prev = vma;
 		start = vma->vm_end;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index a12bcf042551..9fc6ce15c499 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -267,6 +267,25 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
 
+void userfaultfd_reset_ctx(struct vm_area_struct *vma);
+
+struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+					     struct vm_area_struct *prev,
+					     struct vm_area_struct *vma,
+					     unsigned long start,
+					     unsigned long end);
+
+int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       unsigned long start, unsigned long end,
+			       bool wp_async);
+
+void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
+
+void userfaultfd_release_all(struct mm_struct *mm,
+			     struct userfaultfd_ctx *ctx);
+
 #else /* CONFIG_USERFAULTFD */
 
 /* mm helpers */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..3b7715ecf292 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1760,3 +1760,171 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	VM_WARN_ON(!moved && !err);
 	return moved ? moved : err;
 }
+
+static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
+				     vm_flags_t flags)
+{
+	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
+
+	vm_flags_reset(vma, flags);
+	/*
+	 * For shared mappings, we want to enable writenotify while
+	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
+	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
+		vma_set_page_prot(vma);
+}
+
+static void userfaultfd_set_ctx(struct vm_area_struct *vma,
+				struct userfaultfd_ctx *ctx,
+				unsigned long flags)
+{
+	vma_start_write(vma);
+	vma->vm_userfaultfd_ctx = (struct vm_userfaultfd_ctx){ctx};
+	userfaultfd_set_vm_flags(vma,
+				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | flags);
+}
+
+void userfaultfd_reset_ctx(struct vm_area_struct *vma)
+{
+	userfaultfd_set_ctx(vma, NULL, 0);
+}
+
+struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+					     struct vm_area_struct *prev,
+					     struct vm_area_struct *vma,
+					     unsigned long start,
+					     unsigned long end)
+{
+	struct vm_area_struct *ret;
+
+	/* Reset ptes for the whole vma range if wr-protected */
+	if (userfaultfd_wp(vma))
+		uffd_wp_range(vma, start, end - start, false);
+
+	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
+				    vma->vm_flags & ~__VM_UFFD_FLAGS,
+				    NULL_VM_UFFD_CTX);
+
+	/*
+	 * In the vma_merge() successful mprotect-like case 8:
+	 * the next vma was merged into the current one and
+	 * the current one has not been updated yet.
+	 */
+	if (!IS_ERR(ret))
+		userfaultfd_reset_ctx(vma);
+
+	return ret;
+}
+
+/* Assumes mmap write lock taken, and mm_struct pinned. */
+int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       unsigned long start, unsigned long end,
+			       bool wp_async)
+{
+	VMA_ITERATOR(vmi, ctx->mm, start);
+	struct vm_area_struct *prev = vma_prev(&vmi);
+	unsigned long vma_end;
+	unsigned long new_flags;
+
+	if (vma->vm_start < start)
+		prev = vma;
+
+	for_each_vma_range(vmi, vma, end) {
+		cond_resched();
+
+		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
+		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
+		       vma->vm_userfaultfd_ctx.ctx != ctx);
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
+
+		/*
+		 * Nothing to do: this vma is already registered into this
+		 * userfaultfd and with the right tracking mode too.
+		 */
+		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
+		    (vma->vm_flags & vm_flags) == vm_flags)
+			goto skip;
+
+		if (vma->vm_start > start)
+			start = vma->vm_start;
+		vma_end = min(end, vma->vm_end);
+
+		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
+		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
+					    new_flags,
+					    (struct vm_userfaultfd_ctx){ctx});
+		if (IS_ERR(vma))
+			return PTR_ERR(vma);
+
+		/*
+		 * In the vma_merge() successful mprotect-like case 8:
+		 * the next vma was merged into the current one and
+		 * the current one has not been updated yet.
+		 */
+		userfaultfd_set_ctx(vma, ctx, vm_flags);
+
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
+skip:
+		prev = vma;
+		start = vma->vm_end;
+	}
+
+	return 0;
+}
+
+void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
+{
+	struct mm_struct *mm = ctx->mm;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	/* the various vma->vm_userfaultfd_ctx still points to it */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma->vm_userfaultfd_ctx.ctx == ctx)
+			userfaultfd_reset_ctx(vma);
+	}
+	mmap_write_unlock(mm);
+}
+
+void userfaultfd_release_all(struct mm_struct *mm,
+			     struct userfaultfd_ctx *ctx)
+{
+	struct vm_area_struct *vma, *prev;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	if (!mmget_not_zero(mm))
+		return;
+
+	/*
+	 * Flush page faults out of all CPUs. NOTE: all page faults
+	 * must be retried without returning VM_FAULT_SIGBUS if
+	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
+	 * changes while handle_userfault released the mmap_lock. So
+	 * it's critical that released is set to true (above), before
+	 * taking the mmap_lock for writing.
+	 */
+	mmap_write_lock(mm);
+	prev = NULL;
+	for_each_vma(vmi, vma) {
+		cond_resched();
+		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
+		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
+		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
+			prev = vma;
+			continue;
+		}
+
+		vma = userfaultfd_clear_vma(&vmi, prev, vma,
+					    vma->vm_start, vma->vm_end);
+		prev = vma;
+	}
+	mmap_write_unlock(mm);
+	mmput(mm);
+}
-- 
2.45.2


