Return-Path: <linux-fsdevel+bounces-47849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DADAA6200
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3941B9A7499
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB250225A3C;
	Thu,  1 May 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lY2yZHc7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JCijxmE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6021ADD6;
	Thu,  1 May 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118851; cv=fail; b=Ux9P2qi+PQVkvmR+v7F4WLnTqQMpzijiqbhfmsykat4gupo7Mz9r0H3nXvXjDQJbOd2EruyU5WdSlNAvPydjjqUHk7zw1XlMUttR46AVcM/Ki058sn8Yqp8WayZDr14aUV8NP04ZU0L7X3vkjLPXHz1r/zZbe7xYmrecSQlfC8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118851; c=relaxed/simple;
	bh=e8Rx4wKUghn5UbLRBAKEFYhg4Sjn+njknH+/5eTBz8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FHPGkH2XVfdj8GqnDQKq/VvcGahjD8TsxIOZ0ZGqL0rhtSoglHmc/zyxk7xSQ0PfA8tiZrncAsnSAJKE977bhwOzSV+kmL+EiHrwWjpwGkLguF0O1f2Zz6rBhkAkYZbIOxJ3SDSzY52FDWLYXeWPXN2JtkzQGSfvQl/kO0dsl7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lY2yZHc7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JCijxmE3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541GkA8K025095;
	Thu, 1 May 2025 16:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=; b=
	lY2yZHc7le1/EcMqj5DY9/y8m0lUCHV7k/3+wQcrFUXhk8wgZpwjFMntFsFEw2hd
	u2yhgzmI/gbl9+IMHyWMklaVri0IRzX6QyI+mC/HDJZ3QXlZYTTK9CJE4fkypGFM
	+IKpbkoO6cTfIjlrGCO0ysUZVyb/AB/TK+d8Zjvn3LCAdlOqOIPgPnW9oq3Bxtt1
	JFyqbsuC71Nw9XSF5p985ESGW8evCHgmlwwyEKKkdIM+92RmD3TaO63FzKelxTcO
	NVSvRAScThCgUXJG5upNh0i3XidinEDCukgvsoRrPy4/MJdno3xNYSmFT9fjYEeB
	BhXHc5pBgpM6W+N7Mn9RIQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukkfsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541FbSq7035440;
	Thu, 1 May 2025 16:58:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxchjk1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ped/YB4Cgtatd54PhBBrXojlF1ZJFYbF6pz+xqXbCwlIm5d980mqWWoD3XXNjaUhezS5YFGEo+m+6sizkhwX95Xk6VSWvvLiYPMHGrMgqi+/QH8AMgHK5g0FwTAdilrXxrLF3wyO5lALdY2cmTuKeiJYsEsDCFnbtBWjHyRuLRu2mmZYtc+faVmcZzRz/E+GkRqdrxsCG7LCQS646Ws+liQTMKDhSl7xgr8JevqN3lVCzfixrijTWUgmq3wHcmayp32CkZ9ntyEgVvD7SEL75zKRFcOnTnwy1pv84og26A/iwTHRDIxyrvnl6vcRClz6g3/vlZLdTTuiKX9qkA3U4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=;
 b=M8hpOg9G9s1q3GCPsJCvTocjmGeBruzFkzoiukEy7oa89CR9PVW/NuZ16ThJA1RFPqsCWdRaG+e1CVWU07hNZ45movWf7VUGfCNhLjAtzs4QAD/98d8kqa7IMUB4ARUKuWcbed2hSDocBoczfwz1+P0d31Ofm90EpKNMT20ULuPYlYq70Q4DAYipBTMAkd5ar6H0VrVvrGR9KAAh/CbGsVRPSXq1IxBfDBQMKdL+Ln7GM+m3xc1lgmWgtGjDECeW6BBf2SaMIsycCBxlOg2RE/Nbs71r/aM+gbCdo3MgdI/gSR+haUjBbNaz6cdzSKXCbwmK04Alp6ypkOSKex4U0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh4Wq2DGZT38tbuOYyxQeOzVJZYDrAG4YDFkbHawV2U=;
 b=JCijxmE3gr8tN6hfLk/7je9Dm1qWlMTbQSD8uVrAsPMsiU2eBk8//wAxB8nHHf424JVI/KKlmW7Sc6YrBewPp6N7i/FgtFgCBEWD+aZyW0O3ntETV5tdbghf+QDX/D9vatQM/LLt/3dXqOFmgTy4h6nm4AXXbaM+DxTA023o7Ww=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 16:58:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:58:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 14/15] xfs: update atomic write limits
Date: Thu,  1 May 2025 16:57:32 +0000
Message-Id: <20250501165733.1025207-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:408:e6::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a86afc-af97-4e1a-2c6d-08dd88d158e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0QKQfQeUowF76PgnXhdHci7so1KNPON1WIvLa6y8o/cXlFuJLPtJUzyrNzE?=
 =?us-ascii?Q?JiU2PSTyUTmTLdbS+0IymsMHYO50g9qdO0NyaxrPMS6Xl1Ml1zqPNLG+WkqC?=
 =?us-ascii?Q?cBM+15UXHDPWpzoBiK6UWIc4LiD2Iyy8Zq2NDfDdqZwylrbj5l/ETCYfYswj?=
 =?us-ascii?Q?9Lka2XjJpuCWYlvg2G0wKzFRbZLZC5i4xap3jTCPkz651L4BaOsg09GsO6dr?=
 =?us-ascii?Q?b2tF4T4xsh6pOTIx/GheBOAWRIfcAK6XcaX0WDsZ5ikstV8dxxdmSWdGO0AZ?=
 =?us-ascii?Q?YEOCkucHminUThvgRRYzrkiaH6GB5TgRuoJpuMQrTSKDqOOF8LzgYeamGS0s?=
 =?us-ascii?Q?jUg1A1/Y8/sEu7zchVU7yPx9RpTe+DxajUIw0c1Edvgts8raN1fU6AeFvflh?=
 =?us-ascii?Q?f+PkkdDqiIa+ZYw3D+0gqkR1xCvw6VwKnrSns+hVILUytvXLsuj5o6QKi4+P?=
 =?us-ascii?Q?YgvJdN/kyJNED6P2+FbbCX5fGoboKkaCdqB7nSckErUGTnYs4kGjm0eSSmIy?=
 =?us-ascii?Q?ep9VnyJ2wmxyvq2Su41YTkYvmVcZaNAlpgf6E4s6c/u1p1g0d+1lOhTleK7V?=
 =?us-ascii?Q?MBviyUa62nX8X2+dzQTE58eD0iATgIn5exzl9VQQRzSJLnWYERsYZ7dXs+4m?=
 =?us-ascii?Q?Z3CDGV1JQ5P4GKGkncmGqG98GgB6qreLzYFYXAJM7VLkKG/QV5h58q4s3SYQ?=
 =?us-ascii?Q?EmACTeJoRVy7dfaHfLhXOM1ViPLVbZh6ygLpSkxdrPcBtm829HTd91EK3fQO?=
 =?us-ascii?Q?eJLq/s387yJ0q3sWWbSLamGJLVoRdVVkH6x2ol9e/SRPwVPzeaSpfDkVypFd?=
 =?us-ascii?Q?IP/JVUYjTgzzRvvjP9cWY1BcPgEZ2t64Z60VQZaqLJ8F4t61zPq8OnUvYPIW?=
 =?us-ascii?Q?Gq9FELvzzZIfNLPLWfPtWdmJJo0HMqtB9KxL1uRNVq7x1WthL+CCEM8SKIX0?=
 =?us-ascii?Q?H69nxV68GB73fehVTpOiCFIl/cWOlID6UomNbmsrgVwq++GoK8Yzs9Iyq5wr?=
 =?us-ascii?Q?8RKFxEWBmTYVODHJZJ1NEgv+Fg9Pe0vda6uEjerRGE1zesZfuLPi7jdT+EyT?=
 =?us-ascii?Q?5Khv8VKvAfBK6irxDZCPWI+zr7Os8+Rz/+FczzQgUkD30adYLG462CIB9uQt?=
 =?us-ascii?Q?1tsWQCc7ADyB/vxhXq67Sbt+Qduy+jC5BTWauqEdcQpFWJyXNzOYWIqscfWK?=
 =?us-ascii?Q?rKg45vwhKWF2G47fQKWw144nnTlsjlKDmu2CN1ln/9nzK90YwSZ4M/2sCKwj?=
 =?us-ascii?Q?iN3Gm3e1jXeMpEaYdmcBvcvgSJosmsEMM7HgxMWbl30JSAE2T5SAMjeDqkF9?=
 =?us-ascii?Q?UnbiFcCpX2nvrmwKrnddFiXzeCgNmPsGXpmSYZyrxAblY2c/1PyrSCZ8H2Q8?=
 =?us-ascii?Q?LLMkTssAEC2RmQ5ofgjfXrwh6io5o+d/QhJQTs5h0KY0mKnMlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6fPPQvQGM/bMw0a5hu+S5GnwSGowYjLZaIpY4hAQ1ZbSOB3WnBSkuEroPAC?=
 =?us-ascii?Q?oBcN/+6eyWLQDFSfLyt/3954n642tSaRejQv6zO8xk8vfox5UWFud4C1x8Q2?=
 =?us-ascii?Q?4SuaQEf6jykFOeNut6aCVNoBPqzwdsNcNXnCv44YhrP21JD0yuDReyNXXuXE?=
 =?us-ascii?Q?NPIgkEz0J4Lp9OqGH42HmoLEDkmi1FhszC6PYYZUat5nQXg3TiXaln3Ioxr5?=
 =?us-ascii?Q?kTZAQlQpDVTUzAFXVxJ3hoL0gK8FyKUVkyqFIbCaqovoi4whj4e3NJy79v77?=
 =?us-ascii?Q?WJJkU2axZTfq80q5672FSdxX46tMkkM8FNcCb1Y5klSGRIhdxLgO2KUaHosg?=
 =?us-ascii?Q?L614ATw1si+q1L0AyKNJcMOmTCRFhlbkLTZf6RdNIPQntNFDC/naY7BZxfIh?=
 =?us-ascii?Q?PXtx401xWtclUscgIOAd4kXLZl1hVm4RNAbfGNUp4iINlz8vAJBelyJydBDW?=
 =?us-ascii?Q?D/Mz3ybdYKr12+yzL6UP5vGxV7FcoC71/5gHNMIcE9pCcuoXyCFDz7coEwYo?=
 =?us-ascii?Q?gxYy394PWwq9ChspwCZIfoM8TzEdEhXqIL2HG/C7ilwZOsyyVUk5iQGlGnsK?=
 =?us-ascii?Q?AtphGXg39lvciMF/hC9ULT+VXFYjpIpqk/o0aBR9HuWcW8nHvdG9jGaySgIx?=
 =?us-ascii?Q?XegR+W3+fKdF7m/KAGcs7KdWsdU9mFmQy5P3e0tbctCeCBe3Tna7XtG1JaKR?=
 =?us-ascii?Q?pxwSQLcv+bW6/zj9hYSQaljVO+9bybfGEkec2Ie6KOm2ZnkaSaKVxVwHHHRi?=
 =?us-ascii?Q?Aope8xgEJyupxGwatL/D56HLCqZHJd1I8WV66qVdODgFJALm44ya+ol/QIV+?=
 =?us-ascii?Q?7WqfYuMIrFy9r4me/BQP5aBTnPq0QnUpbE83/yCI1t7nKQ7tcy9r+XW68Kn7?=
 =?us-ascii?Q?g/62jZ2yjROv+X6i6JOwFHhDjX50rNknwInPW+UFQDEEe/M3rLkzzkW3Gdq2?=
 =?us-ascii?Q?uBmAPhFyX/ZIEzTxt1sGTLmjRrfGZt6OhUQbe9TVOznzjZjAdjHeAaetcImT?=
 =?us-ascii?Q?BpQH+XqE7RCypxt0Wq65Nbt+A/4Cl7Qa3TgW5167g2U/D2yTYNw5SP49Tuiy?=
 =?us-ascii?Q?Om3gSg6NCh2zmb5HKIRt2sfusH55eaZtaa0+End/OZ4Rwmq37YNLDqj48FDN?=
 =?us-ascii?Q?a6reMQzqEqogvgylLG/8+u/eJjjwYWVcJDH2joQS89sB4N3KFi8dElA/ZkOR?=
 =?us-ascii?Q?Ulk+pDZFKCt+8sG4AVasnMu+o8WVMH5EPfFTY6FmVmCCykcsPWowS4cUWa2O?=
 =?us-ascii?Q?FwOhOxFnH2iuFYpIz9BAE1d1YI0mPHqE1riWw0MOQN4yGSwUpZ2FJS/nBo5g?=
 =?us-ascii?Q?PHGDcdYyBtCTaFTGJfBR9QvvrUwOtmS7as46llAYmKEsR6cyZNA3OVoDWeXF?=
 =?us-ascii?Q?FUSImGEmNCPR2VeGi2GgERcVd5QMalwIYHJnadFOS5VBcBa4smVmR8YVzK7e?=
 =?us-ascii?Q?vQIQSVC8Elp+t5lLJ0t3+HVeGyeRxB5kFAKVga+NDcG94/JRrO9rBKztnSE9?=
 =?us-ascii?Q?6wNEpwNiRG1cq5CriG00pE7ZwPe8aK+VOfPQAv2dTUjWIu50YjiLWfCJBokI?=
 =?us-ascii?Q?BGgKi/0/uEzq6ILBqlCbPF3zQjypictfh6moE9CB/Heqp8xhekS7mmMgYPTg?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cg/FerHAoviEDPDdMpUd7PkDMpOpfFQWYhQtxUSfFnL2CCE1vq5iJ01W7N7yfBsbhMumS7UyCYkddLchB5jMOsKhTpinAa6nxSFPlZ0CblLaXmSWK6d9AgQOOvPdTfCt01M7qZUKNxIAypKnVV3IJWu2iNWRNgnGUnK27Nk1KLCDbj0MSg7yQhptZj/nz7Ojyx9gM8rdSaPfSleCsrz11QVHa7MUli1r+zUilwQy++wfK0t3q6e5abRxcE2H35k/N02JjCtYHqaLZFTFzr+nyGfKwkz2SyznD9bthZiCvL/8cEVmVwTFGxAxZLFFOfMwD6NA6KYyi2K6DJMmtkGDxCQuefW1Zvu1IlZh75FOGeH6aUjyYZ3bRcuqiejYhNzVINMS9Zu5znay7alngVqozR/cAg3ZxsvrB21xOePJl2HSMBAqAIHnrJWeFc8skdvUHjy8ns2NjgGIQLBb8s+ohNErOUfVSo3s7tvbZWuRo/XnrdGOnAZFftUBtBNWGAXlyY9nfQTBxc2HDvklUfWneNKLPEUIWTQK3gwl/hOLBCwg8O3wLa6riFPBmMfRz5hw7fqJ43XW8MZImrTcsGau6tItvgI4govMzUEvsDoXSj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a86afc-af97-4e1a-2c6d-08dd88d158e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:58:07.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvirgYikimPgb2JZmfauZhJflNj2QD5MiIv54TDtu74m3lilbfxfe3fE/t9v5Y21g+5VQBoEzMQS2PinwoeHFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010129
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=6813a839 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-okyUcW3L33xbzEWqc4A:9 cc=ntf awl=host:14638
X-Proofpoint-GUID: 5IifZfovDQKufmBwMjXZIkaDflXu2OgN
X-Proofpoint-ORIG-GUID: 5IifZfovDQKufmBwMjXZIkaDflXu2OgN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfX0e0JtmWhj9Mj a05wyxOMPJd+Y03Bt6BHeJTug0FKVk/8GWl5PjIaJAZ5RTs19kHIvXjroJp0pdPD592sbpF3Nrw RROStm2x8/H8l3zUTMubjEP6zo1KQlZAD95+x67WJhF5kDg8iwqRzR3UQORqG6Sjo2W9X/MyxZl
 o7YGl8b694oNDL293n7KH+MFGc9gIOza7vVWxlujPc5yGwMp/1EyTxYp7/VUGY4j3xweAoVjHg2 svD+v89QgvbEojzUIkVb1MZy1RIteWjMkRDi8PTt/+hDYjmuphUHvV3y1ulGt4UUnC4FFZ3pA3n xsep+zoyJp4GeF+Y5iqG4WOZhrGgLFMKUMs0MAUj9JdGQZ/xME7Q0bhFAXjphkYeQhML0uCLaA5
 dg1lPiBG29I4+GW7c6DhggBxZiUiVBSsJhm8ULDHlUspbrvJtL7nZ5OURXJSZEjI8Lavyzgx

Update the limits returned from xfs_get_atomic_write_{min, max, max_opt)().

No reflink support always means no CoW-based atomic writes.

For updating xfs_get_atomic_write_min(), we support blocksize only and that
depends on HW or reflink support.

For updating xfs_get_atomic_write_max(), for no reflink, we are limited to
blocksize but only if HW support. Otherwise we are limited to combined
limit in mp->m_atomic_write_unit_max.

For updating xfs_get_atomic_write_max_opt(), ultimately we are limited by
the bdev atomic write limit. If xfs_get_atomic_write_max() does not report
 > 1x blocksize, then just continue to report 0 as before.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: update comments in the helper functions]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c |  2 +-
 fs/xfs/xfs_iops.c | 52 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f4a66ff85748..48254a72071b 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1557,7 +1557,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_hw_atomic_write(XFS_I(inode)))
+	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 77a0606e9dc9..8cddbb7c149b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -605,27 +605,67 @@ unsigned int
 xfs_get_atomic_write_min(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomic_write(ip))
-		return 0;
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a minimum size of one fsblock.  Without this
+	 * mechanism, we can only guarantee atomic writes up to a single LBA.
+	 *
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (xfs_inode_can_hw_atomic_write(ip) || xfs_can_sw_atomic_write(mp))
+		return mp->m_sb.sb_blocksize;
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomic_write(ip))
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (!xfs_can_sw_atomic_write(mp)) {
+		if (xfs_inode_can_hw_atomic_write(ip))
+			return mp->m_sb.sb_blocksize;
 		return 0;
+	}
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a maximum size of whatever we can complete through
+	 * that means.  Hardware support is reported via max_opt, not here.
+	 */
+	if (XFS_IS_REALTIME_INODE(ip))
+		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
+	return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
 }
 
 unsigned int
 xfs_get_atomic_write_max_opt(
 	struct xfs_inode	*ip)
 {
-	return 0;
+	unsigned int		awu_max = xfs_get_atomic_write_max(ip);
+
+	/* if the max is 1x block, then just keep behaviour that opt is 0 */
+	if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
+		return 0;
+
+	/*
+	 * Advertise the maximum size of an atomic write that we can tell the
+	 * block device to perform for us.  In general the bdev limit will be
+	 * less than our out of place write limit, but we don't want to exceed
+	 * the awu_max.
+	 */
+	return min(awu_max, xfs_inode_buftarg(ip)->bt_bdev_awu_max);
 }
 
 static void
-- 
2.31.1


