Return-Path: <linux-fsdevel+bounces-55277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBF8B0927B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2923AC912
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3A2FF475;
	Thu, 17 Jul 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZm+A8Ho";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U79/iEYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B22FE322;
	Thu, 17 Jul 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771467; cv=fail; b=HZXlt3h8bV1g5aXtRCTC5uRy2xyEHz68YmJpDp5xbYK4qD9oHndkjI8bjM02pVZ4J0Yq7Eshdxaj5BzeTgkMzZSZLZRf14ozj3XPGqNU2RuUv+AuuOWGjeuFNi5tUUQLlVKQJjJHDSY/xzZcbMrFxoyWudy0i9FsMcXk3v2kFSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771467; c=relaxed/simple;
	bh=mPKNVCoo6VgnYdRC/VhfHz7Hivt73lXo0LJZrDM9VMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfjH4uDVQa769kPlnOwO6KsZlCkYXq/pBFJRS8jXApIV4ODj3l2GnqB8FXttz0E/+9imVRMPWBgFQ+4lRLioQrEzG4HkoNenUJoUp5vJdd8gOmtUME3+qIylvdxH+umPzfg4BkG5Osg4xM77V3TznCnP80/XpBEYL9DDWBnGn/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MZm+A8Ho; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U79/iEYV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGBxpo019289;
	Thu, 17 Jul 2025 16:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cyHUroS0vUU6u4a7R46IBnQRuXpNm2xQdytXkd1rXKU=; b=
	MZm+A8HoWiTgXdxqMkVQjUIk15zbn/oulbrnlPgNbbCjBvztuc2iHAof+k2IXQcz
	sw3Jjmf2+jgjcmRSZJBxqIVONh8K01GqeuMgRo6fmOKegfylF7G3PVS2+jig1jjd
	R/0yxIVAQFcSYyjvt8Tfe6elgLB7T61WfnQMqb2VvOArq+GlJNx814GAnVs4jGWP
	HqVdK3pIPC4xXqn/s34ScAE6Ev3HBda8Gj9+tcjS/RgWPJE9Sg8LT6h9eJmXa/sT
	dgGy/mSMDfOu/YYJcV8ol8ekpkzZSOHdHOsLjpsoXLRlneowhUoJ//B7dWnxp52J
	PZ6xA2NHFjl7NKVswLu3Aw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b3kb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFPWRN013052;
	Thu, 17 Jul 2025 16:56:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cgs44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7Z2E5LA/wA+d9voFJMNy7YwCG1ZmsF0GObCxGN7LCW7GRAUFGaUVE+mtAJ4FAbf7BEARtjs16XMpyriM52Bzw2pas/uK954o2xySL/tnBs1n4KQDEc4w+IV5+8ocJD3n+kwIFEwkROu3d8sMMSX83RcASUt5RlxnRP7tLBSnx7C+TpHfFvkvoXZ0hOdV1yYdujAqi9WpYt1knhu/NMwtmUYDKG3WPVCu5pMFwnCjJp8y+RYkaAc/AKLlrMHHthriCdgnNj15egNWeifRzW0YYx9UzqpjsdbFmvFmJWBvPx5C08Xs0jHWpN9PSjVCrujIPuRBS3HpuRvMNd6n9VA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyHUroS0vUU6u4a7R46IBnQRuXpNm2xQdytXkd1rXKU=;
 b=BvrE5gGOmhN65I3EIqPwiaRBdlfwJme3z0eymwTDzK6l2sMnX3+RzSUAgQ79R2TfiuscLJmFFlFszPCzyAA3MOvD0ykmqFz27EuC/yYsKtnRMj9cAWqfoRBMntK1U2AokQHN9YzZj6gketo69RmkDj7mP6s48uvT0fgvGMQvg6YBAYhE/m1szAQGdF2rPl8HGUyEOrxPPrhR2K9QwcodrLhR1nnHCDBWR7RLwXS+h3YlXe75JtEA3Ikt6NF+929ArFxITQocbW0+DQkwJ45i8jFdAEZL3XOPAdcGk7xKvSbQWiZowkdz6XuolWjl2T0QF8KyPCD9rBv3RJVC05uYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyHUroS0vUU6u4a7R46IBnQRuXpNm2xQdytXkd1rXKU=;
 b=U79/iEYV9CsSdyTi/kO1PD07xW4sEk+y8Hyfi5ARQexFjYzH+nlu7jQzlCbQ8LNglUhMfogzPExhR15hbiYZPXLPzgv8WcSuJl0VNeOEepfpQmZt+HgiLwzkH0crI2ZbEWjj/pyGeR/VKziKqr0Uk82ClVqb2G4grGj2pjf9mIw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7098.namprd10.prod.outlook.com (2603:10b6:510:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 17 Jul
 2025 16:56:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 09/10] mm/mremap: permit mremap() move of multiple VMAs
Date: Thu, 17 Jul 2025 17:55:59 +0100
Message-ID: <8cab2f2c202c4208bdfdb562635748bea6eb37bf.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: bcaadae9-028a-4102-a96b-08ddc552defe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvitSUBtqrkdheKPD2U0sMo1Q/5dGp/GZ3hClA3AtazU/izs85Hze399pXv4?=
 =?us-ascii?Q?ucJi7g/Cdf/FptTZe7AIoLiEL4MITqX4UsO8VwCPb/ZhMh5h5/9ZcJi3JoZV?=
 =?us-ascii?Q?zK+XVIlQ871fNtZOrVz8aOu3pPRTUtQImKQfadH5KkZ8PADSvWwXUbyl/07w?=
 =?us-ascii?Q?pQ5vhxlXlqoAy+5J8aA2SrpLdJ6c7lmwG/wQhmF9YsR+ByOjMuoluDjeRj7j?=
 =?us-ascii?Q?cnwBt13Rh1cQ6nLletNKKWq5bs2JEna3aBd6UCqwESOMgQULtjhP9KEsdw+D?=
 =?us-ascii?Q?Y4XQEkSrX1QLDRPmwzl0/3KXe7bc58byU0V2122O+5bQf51H29FxNYoGjr5t?=
 =?us-ascii?Q?Cqs1zIrQDd/C+xgsEqHluvESaCIStO0dns+vh01uH4pJOH+p10e+QfV9HxT4?=
 =?us-ascii?Q?oHLv2kTUC9HSbApvcUDNEisQW1Yp5Mu+svKnbh+g8WbrQXtzRbtldZPWQBW/?=
 =?us-ascii?Q?3cgkcW2KRPtk/NngdZnBLsqWlkSq/CRTuVrzniGEKynzrp1gmc4qGxwZ60pU?=
 =?us-ascii?Q?8Jyyuzw/8Xj4wyYa5IJ0Bz2u/xYB9bSQyxXRCDE2SwSUw56TEvUEFCiCJqlo?=
 =?us-ascii?Q?qJx6tjNkuqZZDcx2fxB4lY/HCuMJZn9SCTVJROv8+RlXghNnEmtk3cF1M5C0?=
 =?us-ascii?Q?OEFUkrPlUlHeSM864DfiNwiVahoQOVhiwuIMRBxpH669t5o2zRAFx2652vRY?=
 =?us-ascii?Q?nDAqquy0tWTxzeUguBQRIuFQHJJ/PXg9ex/CdxbFu9NS8ZQ49/jkHwRTDYIr?=
 =?us-ascii?Q?4F1b4PFPrpNpM3U2LwdONIGEcbaA/d4cLCEahNatAbU4SEdtYVdg+VUyqacM?=
 =?us-ascii?Q?vRDkJ+ioh15UHeAjqfVZs1I1x/oS+oMaTesD8zCIhe2ih8hLICScOXZxoZ7s?=
 =?us-ascii?Q?Tgw22u1dQWSUy65u76lwSFKTdTNtfM0kPICALB4DSJZ6Pvm+zVw7Xw+00BSF?=
 =?us-ascii?Q?/l7fqa905Mhhv+CqNyTOX6BJl76GbJJuFbYzY01fwqhzzCyjCXVkkOAyztAS?=
 =?us-ascii?Q?UkYny7CFGYgJOCF83jMcflN/SCWi/GwX8j8yNMRgaKJeqp+D+99NNu6W82UQ?=
 =?us-ascii?Q?G7zrzuofb+z3cg7G9sp8JlQd3puV+pVCdxcJU9Ro3agF83FTPxsXAKeo4R0f?=
 =?us-ascii?Q?TY+m/I/iWYnW5ZdBeB1C/oaWHhAzPOlpAco1CGgLXsyRSPiZW+apNfmiski+?=
 =?us-ascii?Q?VNuecCNkEfHiMYjEsom+rLB7fVgpj/SNmdH4uA3VFsSuRGeJOxNkPKp2OOSg?=
 =?us-ascii?Q?Ot6BwlzAeYnzMrX+CMFaRwmAYGL03UA+hPuV9mNlMh2xJ2uvr0ydHiLUqNR+?=
 =?us-ascii?Q?I0Icml9WICiAevxGAJvPJCepIA7cjGkYODKMeVzZ2LoHLtYfX9Uot58ebfcS?=
 =?us-ascii?Q?tB8WsvDTJeIZFmMy/AiNNeB30wuTgYBH6+FJdfXSt9uYu3pVX0NsUzOntH7e?=
 =?us-ascii?Q?uedWf7jpyzE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o8Iou3CAUi8GXsTXdaVDQMke9Cwe2JNxRW7RDE/eMLpBmApr2HRZ9RCijVd4?=
 =?us-ascii?Q?rrmMDyXyRVfEjmoEryeP88rXiXW2f5QMhO6YebmmY+Lg1cjMeBTUgz16mfcN?=
 =?us-ascii?Q?9YvY5jWqmmzMKn+D29Fl13VExdR2CY91/aK8i1l6uvNkZDGqDZNGtX/vXFlv?=
 =?us-ascii?Q?13LW3EaMRS1h+2VtEZNT3+JZvFvg6/mhDgsMl2UChF8f740oP9l7milSNYoc?=
 =?us-ascii?Q?rSrltuyNFFfh6JH8RUT5auLDAAZ2YImYCxQUuRp8LpGBlcYG7n5s38+w2x55?=
 =?us-ascii?Q?gqWYCqcKSIZXMj8nolhRrtzw6FPCgCnPPfTWNBjpeVF0WXqSyiIr7aJ9KODO?=
 =?us-ascii?Q?ooTR/IkI6uC1acrv6uT+KLWN4+30ENobEtDRFlpK1Jks5TbJDxaYKHDiwCS3?=
 =?us-ascii?Q?mpmf3+b56WQoph/bvzsIPmMrsqe4Pm6xESsyL3usfV/gd5lu/8S2MEoEB2eY?=
 =?us-ascii?Q?aWj/Mon3QdQFbBzqEE+r6m3O0rXeJb29K6x1CPvY1SNQSNYSSii5hJmrWvyv?=
 =?us-ascii?Q?BjsrQZxhwjAa9B5vpdsasD83/nYetRUYAPFGvVH8/qzM2rmwBlxYqqJG/CUk?=
 =?us-ascii?Q?YF8EAcLYoavHAE6VMKHfpLm/eoKxWIPOfxWjLQ/19MSOdTuuVx/T2X3JTcZ2?=
 =?us-ascii?Q?47A1V8I/7murGTTTyvryC9L7drs1gVwSm2Q291tME6Pgggcza/8iifsVAN4M?=
 =?us-ascii?Q?gwIvex8qtd9KMOfrvDIQUMPA1KQsuDxJe3pG2zzj6iVMc2Wk2qIc6ZCMpaUL?=
 =?us-ascii?Q?0xGC+cHExYgRkBqFN3r/Xn1ff1epx1T16FkhnOmVWKsHEtVvG21tbXUoVzQY?=
 =?us-ascii?Q?Zq+HrbDYZQYBUeHX2foCs8Uh6i76RlRwb0Fp0Mi8+noMa+SABo2SaZ8PLhNY?=
 =?us-ascii?Q?guPJNi+cNVHZlk3mZRC4OMUGJc221ugB5+YwGjAWgrvpRWzPKs9wYGeQeVxn?=
 =?us-ascii?Q?bdJBpZWgtnGqHNuvKqJih7AyHLT+6OwqvbvBxl4H6QUjrWskmRlaFVWaqOts?=
 =?us-ascii?Q?u2FIAv5njg+ZtUQEdZBvBs4Y9eG45pgm2e5uDDiQ9/peZupPRN54cA96LJVv?=
 =?us-ascii?Q?Hu2eRoLVjprYX4J7q4UZ8GzyzEsVcKkcBhMRjD7zG0TM9Gnj78ssy0YRau7o?=
 =?us-ascii?Q?Ga62h4Wds0zwKll+9MZPxQnlRunjYts8Gh5UA8aYfb0EfWv0Q5OHzPtrLTP7?=
 =?us-ascii?Q?U6jupYt2M/mTnWpNoWlwZZfAr/TzsMjMIf9JTkY2htpNJpmL8b+2ISTyXQh8?=
 =?us-ascii?Q?qliedz9/+BI/NznxzLlJKUTEnIH3TtKr8qY5K4j/pskp92+QNFv5zUIVigi4?=
 =?us-ascii?Q?o2Mul8r1Tj0NordFo02g1QSXLEIU1jlXv/7LjIv8duAqm2S6dsZk8KlXwhWj?=
 =?us-ascii?Q?/KdvTBNYMJfNE5+zi5ksmHtetNRtaAFiLpqjb2GoBXKsmZjrFqK1ksZYB6ov?=
 =?us-ascii?Q?k4tFOOGLHbQfaek8b71ly8qI0LAhpKX2JGObJwFK/xOka9/dS6Sj00wMZsPy?=
 =?us-ascii?Q?ZbpZJZ+iI/76/jQtX/Yyd9X4y8/VTPGId1xrBYmf6XXJfzMgZItve+8VHij2?=
 =?us-ascii?Q?g58MupsGax9X3vlpLAhEGhaM3iMo+05NYD121xBZ5e5Rnmri3NOJ0E81fKLJ?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KN1UCHDKxOE+Iw0ErNy4tJg19clM2O+twn+ycZHT5L83W9Jh1AIOyTcbP3QEsN4eKW84cQ/et13DccCx6zov/gjpZlXya3tl9ifVbQebwrw0oy29Ng4MBm8Uol/WCgBCfVJH6SXQaGHicO6hadicsnW773zQy6ccxLkDFDeowbwLaY4eqmui0Y8S7Gfp2urHFKB6Hg9BDXeI9z2M0yi5LyCsFLFQDXk0XsM+UJ8YRLr0MZ/XyqYPZOKZq21Xcp/yLtciz6dW0gjqdM49RW774wbZ2SthBGOlfYgmorQ635gXSOIzCLkjukpSqz1nDZaNK4BSr7aVVSjnP+rU/S0/C4dvg53LDu2YVtfXGwXKrhPuTO0lQ7LZyLslQB337gbxB7lpaQgzmmlIG/a5wq7k2FxucYTqWqoQivEoLMMu1xSfW5FON/lPlBujKF2sVs0oDtILqfA1bHye15rav+XxP+2q3Ld6oJHMiTRQ2ZZp1fxpxsNyrBD8nUw3a/MAasdfsM7ik8RzMwt5EXBHDHSrl/98tjPSndX0BBhpEz1Z1zK05SIRUGG7mU+g8CYPgbCK60HYDswoxcnBIDBVEvFTnM++usD/7eD/H01Ttm6vCWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaadae9-028a-4102-a96b-08ddc552defe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:27.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN5xr6dsJoXNTYuiBvy3XI2sZoVpLMv+qeTwXUzPqKscShGfhdFF+5Cj02CQ2b/mv7YQh4s+Z+DSUEOgU2QAe+hP6yWHvYZiiF0v3UhaZT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfXzLYh1vivhfs/ MS8HRtdGiZCTNn1kroDFSf1LHLLiBFKp16Iuu8VCBWqaqROgFiW3BNxCM0SBmIClakptpHKqQPI ANilB1J0V/Usay5Ejn7MFQxXUV11GCG/OVjPUz3xJhwamHtpe48eSUwOaGYSZN0bWtbWTfwuN2u
 tQdP572fB5Jodz58MQUcGFOphNZcFtPDGN33Iz+76fwQ+eHyw5peO5ffegXI9nzj6sN6VNCsZva gJSXyGdslsm4xLL+Mpg/bQFUvDz1QUERcMaxJKnx5L/hb2YJ0fFhmfQXoWN+fu+LxJshKjgn9Zm naYVi2KsswG8XcLYD8XjGUdzPWCJghVWv8hUZyeVl8lMUhJk8yVg4d3JbLwvntzgjbBHflq2fwA
 HKbOgI6PrNEKF6CvjRo3KCos+Agsw/y2Q+ETq+2qL5d7isJCQ8+TjAGhfc3Rcnnitq9PLWZj
X-Proofpoint-GUID: 7shM0Y7PWumWJqllj12FQBJWYH6h3Aaz
X-Proofpoint-ORIG-GUID: 7shM0Y7PWumWJqllj12FQBJWYH6h3Aaz
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68792b3f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=b5bszlCp1HiZ-wyHCzYA:9 cc=ntf awl=host:12061

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually?  Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is
faulted, then moved back and a user fails to observe a merge from
otherwise compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

We only permit this for mremap() operations that do NOT change the size of
the VMA and DO specify MREMAP_MAYMOVE | MREMAP_FIXED.

Should no VMA exist in the range, -EFAULT is returned as usual.

If a VMA move spans a single VMA - then there is no functional change.

Otherwise, we place additional requirements upon VMAs:

* They must not have a userfaultfd context associated with them - this
  requires dropping the lock to notify users, and we want to perform the
  operation with the mmap write lock held throughout.

* If file-backed, they cannot have a custom get_unmapped_area handler -
  this might result in MREMAP_FIXED not being honoured, which could result
  in unexpected positioning of VMAs in the moved region.

There may be gaps in the range of VMAs that are moved:

                   X        Y                       X        Y
                 <--->     <->                    <--->     <->
         |-------|   |-----| |-----|      |-------|   |-----| |-----|
         |   A   |   |  B  | |  C  | ---> |   A'  |   |  B' | |  C' |
         |-------|   |-----| |-----|      |-------|   |-----| |-----|
        addr                           new_addr

The move will preserve the gaps between each VMA.

Note that any failures encountered will result in a partial move.  Since
an mremap() can fail at any time, this might result in only some of the
VMAs being moved.

Note that failures are very rare and typically require an out of a memory
condition or a mapping limit condition to be hit, assuming the VMAs being
moved are valid.

We don't try to assess ahead of time whether VMAs are valid according to
the multi VMA rules, as it would be rather unusual for a user to mix
uffd-enabled VMAs and/or VMAs which map unusual driver mappings that
specify custom get_unmapped_area() handlers in an aggregate operation.

So we optimise for the far, far more likely case of the operation being
entirely permissible.

In the case of the move of a single VMA, the above conditions are
permitted.  This makes the behaviour identical for a single VMA as before.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 152 insertions(+), 7 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 28e776cddc08..e67cba4e6fc0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -69,6 +69,7 @@ struct vma_remap_struct {
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
+	bool vmi_needs_invalidate;	/* Is the VMA iterator invalidated? */
 };
 
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
@@ -1111,6 +1112,7 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
 
 	err = do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock= */false);
 	vrm->vma = NULL; /* Invalidated. */
+	vrm->vmi_needs_invalidate = true;
 	if (err) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_acct_memory(len >> PAGE_SHIFT);
@@ -1186,6 +1188,10 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
+	/* By merging, we may have invalidated any iterator in use. */
+	if (vma != vrm->vma)
+		vrm->vmi_needs_invalidate = true;
+
 	vrm->vma = vma;
 	pmc.old = vma;
 	pmc.new = new_vma;
@@ -1362,6 +1368,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
 				vrm->uf_unmap_early);
 		vrm->vma = NULL; /* Invalidated. */
+		vrm->vmi_needs_invalidate = true;
 		if (err)
 			return err;
 
@@ -1581,6 +1588,18 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
 	return false;
 }
 
+/* Does this remap ONLY move mappings? */
+static bool vrm_move_only(struct vma_remap_struct *vrm)
+{
+	if (!(vrm->flags & MREMAP_FIXED))
+		return false;
+
+	if (vrm->old_len != vrm->new_len)
+		return false;
+
+	return true;
+}
+
 static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 {
 	struct mm_struct *mm = current->mm;
@@ -1595,6 +1614,32 @@ static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 }
 
+static bool vma_multi_allowed(struct vm_area_struct *vma)
+{
+	struct file *file;
+
+	/*
+	 * We can't support moving multiple uffd VMAs as notify requires
+	 * mmap lock to be dropped.
+	 */
+	if (userfaultfd_armed(vma))
+		return false;
+
+	/*
+	 * Custom get unmapped area might result in MREMAP_FIXED not
+	 * being obeyed.
+	 */
+	file = vma->vm_file;
+	if (file && !vma_is_shmem(vma) && !is_vm_hugetlb_page(vma)) {
+		const struct file_operations *fop = file->f_op;
+
+		if (fop->get_unmapped_area)
+			return false;
+	}
+
+	return true;
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
@@ -1644,7 +1689,19 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return -EINVAL;
 
-	/* We can't remap across vm area boundaries */
+	/*
+	 * We can't remap across the end of VMAs, as another VMA may be
+	 * adjacent:
+	 *
+	 *       addr   vma->vm_end
+	 *  |-----.----------|
+	 *  |     .          |
+	 *  |-----.----------|
+	 *        .<--------->xxx>
+	 *            old_len
+	 *
+	 * We also require that vma->vm_start <= addr < vma->vm_end.
+	 */
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;
 
@@ -1744,6 +1801,90 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	return 0;
 }
 
+static unsigned long remap_move(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma;
+	unsigned long start = vrm->addr;
+	unsigned long end = vrm->addr + vrm->old_len;
+	unsigned long new_addr = vrm->new_addr;
+	bool allowed = true, seen_vma = false;
+	unsigned long target_addr = new_addr;
+	unsigned long res = -EFAULT;
+	unsigned long last_end;
+	VMA_ITERATOR(vmi, current->mm, start);
+
+	/*
+	 * When moving VMAs we allow for batched moves across multiple VMAs,
+	 * with all VMAs in the input range [addr, addr + old_len) being moved
+	 * (and split as necessary).
+	 */
+	for_each_vma_range(vmi, vma, end) {
+		/* Account for start, end not aligned with VMA start, end. */
+		unsigned long addr = max(vma->vm_start, start);
+		unsigned long len = min(end, vma->vm_end) - addr;
+		unsigned long offset, res_vma;
+
+		if (!allowed)
+			return -EFAULT;
+
+		/* No gap permitted at the start of the range. */
+		if (!seen_vma && start < vma->vm_start)
+			return -EFAULT;
+
+		/*
+		 * To sensibly move multiple VMAs, accounting for the fact that
+		 * get_unmapped_area() may align even MAP_FIXED moves, we simply
+		 * attempt to move such that the gaps between source VMAs remain
+		 * consistent in destination VMAs, e.g.:
+		 *
+		 *           X        Y                       X        Y
+		 *         <--->     <->                    <--->     <->
+		 * |-------|   |-----| |-----|      |-------|   |-----| |-----|
+		 * |   A   |   |  B  | |  C  | ---> |   A'  |   |  B' | |  C' |
+		 * |-------|   |-----| |-----|      |-------|   |-----| |-----|
+		 *                               new_addr
+		 *
+		 * So we map B' at A'->vm_end + X, and C' at B'->vm_end + Y.
+		 */
+		offset = seen_vma ? vma->vm_start - last_end : 0;
+		last_end = vma->vm_end;
+
+		vrm->vma = vma;
+		vrm->addr = addr;
+		vrm->new_addr = target_addr + offset;
+		vrm->old_len = vrm->new_len = len;
+
+		allowed = vma_multi_allowed(vma);
+		if (seen_vma && !allowed)
+			return -EFAULT;
+
+		res_vma = check_prep_vma(vrm);
+		if (!res_vma)
+			res_vma = mremap_to(vrm);
+		if (IS_ERR_VALUE(res_vma))
+			return res_vma;
+
+		if (!seen_vma) {
+			VM_WARN_ON_ONCE(allowed && res_vma != new_addr);
+			res = res_vma;
+		}
+
+		/* mmap lock is only dropped on shrink. */
+		VM_WARN_ON_ONCE(!vrm->mmap_locked);
+		/* This is a move, no expand should occur. */
+		VM_WARN_ON_ONCE(vrm->populate_expand);
+
+		if (vrm->vmi_needs_invalidate) {
+			vma_iter_invalidate(&vmi);
+			vrm->vmi_needs_invalidate = false;
+		}
+		seen_vma = true;
+		target_addr = res_vma + vrm->new_len;
+	}
+
+	return res;
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
@@ -1761,13 +1902,17 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	vrm->vma = vma_lookup(current->mm, vrm->addr);
-	res = check_prep_vma(vrm);
-	if (res)
-		goto out;
+	if (vrm_move_only(vrm)) {
+		res = remap_move(vrm);
+	} else {
+		vrm->vma = vma_lookup(current->mm, vrm->addr);
+		res = check_prep_vma(vrm);
+		if (res)
+			goto out;
 
-	/* Actually execute mremap. */
-	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+		/* Actually execute mremap. */
+		res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+	}
 
 out:
 	failed = IS_ERR_VALUE(res);
-- 
2.50.1


