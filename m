Return-Path: <linux-fsdevel+bounces-54624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAF5B01ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E565A29D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048C28FFC6;
	Fri, 11 Jul 2025 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HOq+Lw0K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QOccjnS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC2295DB3;
	Fri, 11 Jul 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233997; cv=fail; b=ncHvyljbExbimyW7Bdn+V+MsB9o16hEp36ugRbDcDwA3mk6qGuozq9yfN7BC5DSo8eJ8aob5853kRvQELrM7f7WtTGa3GP5SC+yS69HnFy2ftuMPRU7HqH6rB/YfJvE/k+Z65+eR/L5N8LHIs4qvgQtYok/Yl6SbzrXotmEm8Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233997; c=relaxed/simple;
	bh=iXvm+GJzmq+6aRoft9XZMiELUBoxj1gUUYDdOebwrr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZuOd+Rt63MHTLex+5F774dQo58+mIQ4QXXhWCbPKjnulELTg9siMB44JNMc6u/fHXGT7++p5auq2AmDfYrlBT6dWIrVeEqEea4BHveZXYH34s3dQZVtUU8IUzZ/UyTnka3REflEg5LNBUbxeZ6kwz2OJso5f90ZRI45CRMjChk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HOq+Lw0K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QOccjnS0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBbiDV015146;
	Fri, 11 Jul 2025 11:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sC+w+4PJixR8ioWtKbBNjGBZm0qH0EN1ahdArU658h4=; b=
	HOq+Lw0KZiyHtjmroJagq2vwlp/IomCLIoUD5rZcJjnO8Cn0Jt47g/J+D2w9+KOQ
	EQiEFP6YbGc6ADXOi6pRcDdcAuw9KX9ARDzA37H1ULQ/tLnWgVkTfkpz1cWPmtwk
	8W4X1VVNR+Xw3jcp9tnam0bb7EBEpzQ0a57PkP7ZTGnTeZ+Y/FCJZ9j/aFggLSQ2
	7kMXo1WOlEYH8Ru3nnbrGDnIXDTEWmK4Ysu3CIH2T2+VNQaDR19+FTKoSj4xidFV
	2TpPOeZUiy7V6h8yEIOfEPh+kSelNrxQAAQXr9xvuA1gaa+WRTppzyHe7XGRvn8Z
	4dp6IXK/x78YFeqvcMKkYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1w1g01w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9nqUR021432;
	Fri, 11 Jul 2025 11:38:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgde6h5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8kR+Be/7qYthlkQzLaDllVTPrK+Kf8f2sqDzKh9GRuzPR4xXze1fv6wqKNmEZRZXhJ5f9yFZ9lUqYqmlz+uBLQSgtq+4P0Gr5GMTHcPRO/gqxk5iz94v2Hu6gi49pHreWTd3q2ImrWIjLqss5kw33pYlwGeAxYcWgabYRfsP1yF3sGB6LLwNfY0F0BR0X+coWWGAtGj9hKWLsQHJ52bmaVIwS2Lz4w5K50jeoglW8ahVlo2bprRK02WAYeSHO5iJdtyEXNcDCZr9EabZy8jGNbE3QEqr64X8ze78/qcITJuapyReiIu2bZ7kjYdbs+IrjyeSM5OuX/i5ktjUbuUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC+w+4PJixR8ioWtKbBNjGBZm0qH0EN1ahdArU658h4=;
 b=AF0sXh2CA4//7ppTsUOz0aIKtJPvN65ThtuWtglLoQgLCBYfX2Xe+X0d2PueGzDc/QUkc2wpfTbPMtipyIBJI9XCcXUTl0tT5yQ5JTRmRYD08L0CQCiezVt+RlW2+l+LqHGDoFGSmoK4pmt9jMUPgx6LA8/AxoZL2WU6ETIJuEj6h8cP1hWbJBTfH9O7BRgQ55D518UIFuzlWnSErohmBJ5aJn1v3G90aohUE3eylZjl1EmWi4DlF9k7jDuP/eLO+sLse2aYKurG2O+hjKfucy1QNe2DsCOWCHDtKadqODkU04N+X5PW9NqHIaLv2CzIDSEaV49h0mNXoJhHcMbbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC+w+4PJixR8ioWtKbBNjGBZm0qH0EN1ahdArU658h4=;
 b=QOccjnS0lDhM9+X4FlseonloVPbP6d6biw6YIH648TfLjEMMGBWVAA2mqL/JO2TBCLWSN//hiUrcifj5wwtYYWWKQ7iZ5pSPQF8lhG1lLvgCodR2Q4O/Dzz8d1oAb/UTVnr7fIw8YJ1ePL6+Cmr8WwEZ7nPMs7ShpF+ll5emdfA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:37 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 03/10] mm/mremap: put VMA check and prep logic into helper function
Date: Fri, 11 Jul 2025 12:38:17 +0100
Message-ID: <b63a058aa748af435db933e1e9c8fea945fe604c.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0661.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf0766c-e4e3-47d8-de19-08ddc06f79ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8hnPSPjMf11ISpH0O5HKAIOcwhZMwSmZOUGwj2LBz5veKTIu6+dfPCWVyWR?=
 =?us-ascii?Q?SH4X5LlBSG4HofK+wDX4NkWI2r8KRkSU9cr0VPks0sQqb9Zm8yf2trIjeRAL?=
 =?us-ascii?Q?ll8BrG5rzmSEBz4jax9fZOhPmMpjy/8sFIQnfTql9rzFYMJpv1acCydCPyl+?=
 =?us-ascii?Q?muZClbx/a26Z+xoYhK93stxZIjIESmA+QpF//G9FfDuY+gsb1o/6kxCn9ALY?=
 =?us-ascii?Q?lLXv+or6QrVEceNRy96K5sOI2fMdXaoNR8AMtsf5VqacDX/7f161Ielzo4OU?=
 =?us-ascii?Q?y5KeYCRmNN3WCYYBT95zT5RiXrXenPFsUhy7FKxOWhkMC4CVaM76kpcQf8Bx?=
 =?us-ascii?Q?1FDuieUOEzKXK0gmnORqiepgXekmminap96NrPFzHa/WYMLYm+Z5AttyebfQ?=
 =?us-ascii?Q?YGwGzuoHant3MfW8Ov+bVXRqEs3/qnqvRc3qtXlhMorFNy4Ak1EmYCJxJxNT?=
 =?us-ascii?Q?CJu+77yJu1WwzC3hCAcUeLNrIw2MLPKrjU94ldfu14HWm8GzfjcbXy7H3Mq3?=
 =?us-ascii?Q?YqPFbs4A6aakNbD2VNWVZXCtGl5LhctBuUu6cRZ5Z3xKKvftgHdJ9Id47imA?=
 =?us-ascii?Q?0OUd6Qd/Yx2skjxlC8MRcf0XjzeHxBp4q9GlBn2LEZxZCoZD4H5NAn9Nu6Ju?=
 =?us-ascii?Q?Ty2NU+KpDhMcDpG9G/HoZTGzqd4HqDKvm9/SUkJ9+HnJfVgZIRiKJpYJs8Fx?=
 =?us-ascii?Q?ePKGqp5oPEAYRPPeR/9NxEsB0jTJyJ7MQ/jo2J5+WI1Qb/9oc3orodj9GbNf?=
 =?us-ascii?Q?Ir1Wda18zZ6fnqB1Y2avl3Rr2xLtgy35KtV3RD0CbFycnIbKIB8hvJetPa2J?=
 =?us-ascii?Q?dt9brGis6nxSDPotCt2iTrZGhwvEe0OnAukqL2NEWQL1BcKDYhbpG7QxOEUA?=
 =?us-ascii?Q?XtJ/plzClRLiyju19Q+Qjcnk49myJ8SPgGlWsVOKzbflIZyZ71I+tngBap4t?=
 =?us-ascii?Q?WmTWelid9bWJ6Qt5luh9Xt8I+olzRJdyiu2kgQjz6LXQnXDwM982eoLuZ7X+?=
 =?us-ascii?Q?ziRu67SnRjebzq/7N8oaNyLTdmc4GN4TY7yXZ0VkGWrdiVoe2dwsy/LALlnM?=
 =?us-ascii?Q?blu5YHDxl1Lg9DxWSEx21eo1FI/++LFrmKCFRsy6/0fSRr6E9HD8E6fxw5nJ?=
 =?us-ascii?Q?THFudY1NiTu+OsTSqtT6iF7g63NYp1nbfAHHX8b8Ual6e2ZU8DL5BDjvIBaa?=
 =?us-ascii?Q?6Jv3Vpf3wkUiQk4DRz4/GRSLtRyPmEirsV76wAQNee0ZJxsFINqbHbv/pD6w?=
 =?us-ascii?Q?3oDgwvq66gcrCMdT0whfPqAiy0GBEfW2pXyLcGNGtVBMYJVL/ODCCyw9VzQ4?=
 =?us-ascii?Q?x3b6RvHIEfH091Kz4pk+Mda+PKw8tavX0lFQtbI+1tgvaR/8C4XuO3OvXZwV?=
 =?us-ascii?Q?V6YBQKPRhbPYLsH0+sQ5fDNw8lLxfWj3KAt+s2mwkt6l5Km1KYQfXtsozrqd?=
 =?us-ascii?Q?io0wQAV3rDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wcw3jldizyN7kt3zvRaySXLnZQIiPDuLOAENWHF+mek2Qvo2iRBgXaUG7QVx?=
 =?us-ascii?Q?WQFwtBAmlS2nvLKVf2fYX2Zm5DpFOyWyd6bzp9hyZ0Qb6zC0aGrr8GJUBT/t?=
 =?us-ascii?Q?C9nvVKYcpaHUvdZqr2XaWIlsTSuRCWEWZ4aqqu82iUVVjzfgR/lnsRD8Nv8K?=
 =?us-ascii?Q?yPmbcBZA1d0AGmdZLx2TxSlIfkcySLzDDXv3a5oiiMsPFWcV2Ice2Bvb13ur?=
 =?us-ascii?Q?Wub1ddAY1yb5YOSJzGjr+vJWpGMWE0uowApRBMgHpJ7coiql3oOZwWfmDnaI?=
 =?us-ascii?Q?48ARLR3AXMacNCw3PaCCEwbBrZKXO1b1LEc9s4fYOpddASpkr5MAWSpbn5UC?=
 =?us-ascii?Q?uprRtxVEm6srqxXJwX/AGEfKTleoFrXl5mDrrUwcYaNyV2HiCIbh0MIp4ngy?=
 =?us-ascii?Q?/ZiEL71wnSJ3oP6rGILofQZAF6+f28fm63o0PpfKKKcO1PGtyrfBsTTS+hmy?=
 =?us-ascii?Q?c9F+Frh7/IrgD+JVKzu8nd3Ov6mQwoDig/797Xc3EaqxR/aIwPc9ViZmHOmz?=
 =?us-ascii?Q?2kYPkuxNTsAy+Gc2hqAu/ydCHGv3cuaxC+AjLWnCbOVnPgsmZXIjlcfecxoO?=
 =?us-ascii?Q?XNCO2ptUvedpZV5RT5rXzpsXHPpeW9IwpITR33UKwCHvmTj9JmiDv4t6yYe4?=
 =?us-ascii?Q?pI/VgTfqh2KHUPK/5WYNILfw6X94Wz6KrQLkgYdHfeycZB8lkgVJ1DOEgtDD?=
 =?us-ascii?Q?xPbJ9Awxs4EPPVgjc9+A4V4J1HVrU/b2gQml9vUfzgDP4KVZkr6X6b/vd/y/?=
 =?us-ascii?Q?Gls0cQ3VvIPCXprnghplk7wtAV/KWBU9AQ9ztpV7JlBEhnXhQtc6BdpFPPX5?=
 =?us-ascii?Q?Eihd8rDAkon5w8dew+lIq4LMvKMpqfQQcZZUeTqcvAgQQr5vu122d6KqpNst?=
 =?us-ascii?Q?T3iOIMTqTTK/drl/Pm4p20xWOzCsF51zKwGK2/odCKFG/HMarDhiturRkZm/?=
 =?us-ascii?Q?SmGL8EL3MbhTQWlnWLB1UKWjYi6w/r3iMM0BjJ03golkcKxkfcx/uY7p4ief?=
 =?us-ascii?Q?d9TNmL1PERPoQ9Z/ovPDn4RZ9uHFgnYiuW3rWcTJ6PTpgdPrCru0Mq/2Y6DY?=
 =?us-ascii?Q?6FYoE5SbczVvjthSqK1maMcdnprrfAgwc9Wp5g0MLILOMD++hF9WrPX8Oqy0?=
 =?us-ascii?Q?bR8Ild+HGmNJEqO+zTCtm1JKxfJ2bFP3KC+7uT50r/mw5aKkTi1q6aqh0GBK?=
 =?us-ascii?Q?muUYHmwFw75ey8HH3MJye9k5zDQTmrZ4aAwRetE3rRv/AwM/BHgYMEw+jdoc?=
 =?us-ascii?Q?scTZQX3OVRe7VtkcDmQutCvLfPKo2bp873MhlP3j2g+60XC7dJznccHgN2S3?=
 =?us-ascii?Q?15EXSGScF8/YVAstjH66vqUqN4vQAGmh7EqMZI+OUYRnWceQ+OV6DCnQ7613?=
 =?us-ascii?Q?WBVUIK2hudnnS6K3fYn6Byvie+3Bl+vea4FeowYZNz2DwM2SKiUSwarYv3dp?=
 =?us-ascii?Q?uQk79l+51iIA73aaiHr0b+5hzvkg/fz6KGfgt4GNjcptzS5VR61yjSRnwBTb?=
 =?us-ascii?Q?9uqiaHTZHvTDCN2uieYKtnqLvAQF9xiCuteU+rp5xdRvjeC8z5oJpT2C6/Lr?=
 =?us-ascii?Q?FjB4sDjtwIvZzwILRgfofza2nHTp7gvlJe/H9yw19BQXwShkQQ6SNV+bgkd/?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9ESmXMkSIAvaqYVwMJoqtvmhVodsHON9B/lCVxdKzpxHZkN52Wssl50c0dBluXc/OGNY0+9tYK9iS3GKVmd7jgQrgCHuPTYxRD6oi3A8KEs/t4svYouFUzMYOAEKZ1eX/t/Dcu0lIQFRciUQMlkoZtO3LvzA7dCqQGAgR7Vfz9wdPAJzL2AmvkYGbmu1KiNwfRawDnOTgi7cw75zJCxMl4kaAx4nFjm2Pk8iJ28eODKZ/ULEY7Uf98AZg8mFz5mqhgjom782H+L8/zpAgnC1InumSGPKZK2G2VoVAZC9I74nZnMcWusXbVJbNsvOc1NQMd8g4f87i+sVECxjM4U/eAU38RPbwcgaeg4x9Di2jborCZRmd8lELpTVN/Ky7LZJRA80uPBPsGkTE5Npyw1phStOjnSG+4PY02rRgFBZrQxur7gVOLfE/tglhOwyZgYTRo5Z2GfSQj+6ocLIBJdyQUHMM/m2uVOqWx7mB+LOLAxz5umGp4OZl0xrGY7JN7io+3fVuAFVVROxf6PDTa8+HrcujSK9Fo8gkvugjeWz+iPx2uqctXL5mp5WT34a1U/WMDAy4V9JTg+bnuJ9EO9D7JrjQdxxUwE8ceM7TLUcRFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf0766c-e4e3-47d8-de19-08ddc06f79ed
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:37.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tZ0y1pNqBD2LA6QeXqTBYj3hS7n3TrI1i0RASOgoTKLb3LemLBeetFucwI5uuH8B+mQXjIDOy5p+O25CGL/k2W+AfQZ0RWQTrhLSXWoEj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX854cJl6reEI8 vfXeBvJTo1dtJr80HLT5EwIjMSdxd3fLxVENjj8CCYqdmWqS3QokjT7TNTp+YvCsbN9Vo2XMeVZ ESDpWQCFqMbj5o6p24N0L19gkUXGmGcLrc/UaphycvidkWQwlgrAMLasbNBkegMcFjnFopnyPs7
 aa+cfT/thM6DZp0TZrREwYV6OcIgffjhvwKWAan3ycam9E0Pm4gvC+nwIyqCpiEC/f7vbvuTQlt sbqZn4sDvgD85JnlmhKNXqq1dC2LhOBQuSftvtxJzXz0K88xRIQgBJPOJBJi39HWpuT8XuQw9Vj gm8+NMUJEvAGTROBdk8xf7ggPZwoMldQ8lSdRvD0r85n+XDu4ehJFJuA9+8lHUP2+HLKXzJJmlu
 vgedfKOLTOHTQ520rwqEKrBZ3tGsttgVhu4DCwuOmzX6yyBtFWXGN0nSktGTF2zUDtiR123m
X-Proofpoint-GUID: B2IenEawMZLe_dPN3oR-Cr67u0N3uLK_
X-Authority-Analysis: v=2.4 cv=FsIF/3rq c=1 sm=1 tr=0 ts=6870f7c0 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iY89YN1uBm8AvMjWrUYA:9
X-Proofpoint-ORIG-GUID: B2IenEawMZLe_dPN3oR-Cr67u0N3uLK_

Rather than lumping everything together in do_mremap(), add a new helper
function, check_prep_vma(), to do the work relating to each VMA.

This further lays groundwork for subsequent patches which will allow for
batched VMA mremap().

Additionally, if we set vrm->new_addr == vrm->addr when prepping the VMA,
this avoids us needing to do so in the expand VMA mlocked case.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 58 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index a00da0288c37..d57645573e0d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1636,7 +1636,6 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	unsigned long addr = vrm->addr;
 
 	err = remap_is_valid(vrm);
 	if (err)
@@ -1651,16 +1650,8 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 		if (err)
 			return err;
 
-		/*
-		 * We want to populate the newly expanded portion of the VMA to
-		 * satisfy the expectation that mlock()'ing a VMA maintains all
-		 * of its pages in memory.
-		 */
-		if (vrm->mlocked)
-			vrm->new_addr = addr;
-
 		/* OK we're done! */
-		return addr;
+		return vrm->addr;
 	}
 
 	/*
@@ -1716,10 +1707,33 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 	return -EINVAL;
 }
 
+static int check_prep_vma(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma = vrm->vma;
+
+	if (!vma)
+		return -EFAULT;
+
+	/* If mseal()'d, mremap() is prohibited. */
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
+	/* Align to hugetlb page size, if required. */
+	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm))
+		return -EINVAL;
+
+	vrm_set_delta(vrm);
+	vrm->remap_type = vrm_remap_type(vrm);
+	/* For convenience, we set new_addr even if VMA won't move. */
+	if (!vrm_implies_new_addr(vrm))
+		vrm->new_addr = vrm->addr;
+
+	return 0;
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned long res;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
@@ -1733,26 +1747,10 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	vma = vrm->vma = vma_lookup(mm, vrm->addr);
-	if (!vma) {
-		res = -EFAULT;
-		goto out;
-	}
-
-	/* If mseal()'d, mremap() is prohibited. */
-	if (!can_modify_vma(vma)) {
-		res = -EPERM;
-		goto out;
-	}
-
-	/* Align to hugetlb page size, if required. */
-	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
-		res = -EINVAL;
+	vrm->vma = vma_lookup(current->mm, vrm->addr);
+	res = check_prep_vma(vrm);
+	if (res)
 		goto out;
-	}
-
-	vrm_set_delta(vrm);
-	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
-- 
2.50.0


