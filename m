Return-Path: <linux-fsdevel+bounces-32867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520489AFE93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D726F1F23AE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02351DD86A;
	Fri, 25 Oct 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gYIQWtve";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xcT4YrOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F41D90DC;
	Fri, 25 Oct 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849328; cv=fail; b=JtnoKepeo/vT4fvoeskk481jaVfqZOWHp2XjLSsWFTNUqn86Q2rRdY6e8KVc9b8yXNQaVLbJhi1QkVaCSgmaxrZUIo0iJDyXsxTaojeK2hfWaWsShhoYGY2P4oev6Mlf3KDtCJ7lZcW8iozLG5Yyd/RNV3+v3PtWRbsEmcEhUzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849328; c=relaxed/simple;
	bh=RDYijylasW+Be+VhATzF8NimNslLW/NMpjpOS1eg89I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJWhs1MZQWc1pn9MPKSsKUtfzWj9hPMckt6kmaGImvrUlzadi4xX/ShY7N2NL1/aBlXQ6hjDQ/YUxHlV7ORP6MIlPA2DeHpZ8R5d7teGfIP7sEMlNpw6sNFDDD5c3ke2RgZgceZesJhT5KmkiUQCKCnWvdR9WsS0MPuBfStVfic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gYIQWtve; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xcT4YrOO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BYo0014697;
	Fri, 25 Oct 2024 09:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d+w1NL58a0s/TvcpDRjcjRaE1BTZDAu5TSa+cfzMlM0=; b=
	gYIQWtveTwswJC5LOSgH9ML5sWeC/lu6hm3/MmkOQtLF/2c30wA0eV094VjnVdEx
	ZaSL+VFGO7ctgZBuC3XiQPZrHmiJtlskTHn5SsLaAi1UwRpe42ZlOuJ9qiJAPl37
	OvlKucXkD3WaUI/DPaLLXOJU7Iu21Jwiorl/6+MAm/BFareBRr+0utKIK9XRtAeL
	20J/eZm9M23/nmsNv/cSKg4qcAoUFvqOQoxxrWz3dn6ySGhuXONfg/doPk4eDWrG
	ozbHmzVg06JUHjm9Z9gCpwkU3lwrxllV6nv+/mkRSY8/rrgDzNWlxTU5Imt4Tf8O
	nVWRfVE1MMXC94muw9dRuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asmm29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P91wFN035766;
	Fri, 25 Oct 2024 09:41:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh53wh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itYyxZUieXopytDE0V+mFtth7XKP5bY+J6S0WOrFeKa5CQ9ZjhuQy/AcFzJTr58IgKx1m/0tAGjA6JDwZXBT5znxs9qt8QBuF1C1rYvDgptPX1DTMXlmqzB2QsTx0ZwwdLkhBm8e9NsXUOVs9aYmwiugzB+kkni/5aiGpDVTdVXMglkrUTpgrx8rTZ2gWqXmd3ciFjHmEZmDgpYhaEdOEtsIzcnPFc9H6ZTSFcUyPgf9zgovD1Ff5zYWjwknKc3zZnZOG2Y4rBX2yA8GcCFPbRM25HFCI8Vl7B+SvI/gBPSknK5NqPQXdlGtBktVDagMnsd8jpLZQw6dndrcSolC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+w1NL58a0s/TvcpDRjcjRaE1BTZDAu5TSa+cfzMlM0=;
 b=Ezt4KyUMaZfY4Q9dgmZ8ObbzEA40dJiAylBXJg6jCSiCA2XM9TA/eFIh57xpPUzZvYqbDczfjLMj1QjcB1WHc36EH9k+oBklbwcy1h6tOb6MsJbSL/47USGUyUB8ZEji30iUy2iGXMIZmOeV1QDRB8RmcRHOxus9/miHcxOvYJdX/qqNLct2FuyqDT2Qjv4e7+4x7o6UDUzsr2lBHlADi/M+iHgW490XC8Fx589upR/u1b9zrf93+pF0PBw6UaOHdeBB/7FCubvj0Yhe1iCZ0o4CWL/440WfTWP43Uf9Kko/mSqF9rI9U11WY8Xe8c62YrH76pVPUtR4p91cmxVl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+w1NL58a0s/TvcpDRjcjRaE1BTZDAu5TSa+cfzMlM0=;
 b=xcT4YrOOlVeiTN/GPnHirh6U0uy2G8AWwP5xbY1XNDrBDR9tXj+qvWpxawUKQlfMi+yeWCoTboAmU8J3EtNIrann3S5DoWP7v9nWx/lfXzcUZdlhG4wgviDOrtbqYYh7ldtu9HLvf8sK7O9Tc7766bOgCpwaiXmvP6wGFVrYXE4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6121.namprd10.prod.outlook.com (2603:10b6:208:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 09:41:47 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:41:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
Date: Fri, 25 Oct 2024 10:41:31 +0100
Message-ID: <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d549080-c03a-4610-35b4-08dcf4d93e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0asKowcRPCF9i/rU9emtBThCF7yTp0tVbVugzxD89Or/Ws1vigBDnI1aN66r?=
 =?us-ascii?Q?C5hvKrhR5IsfYqx7uL5rvPZfEZdJiuyFHmAZ5KBmVpUz80NAbgwYQN8oO3qi?=
 =?us-ascii?Q?n5Q0FOPzSVzynWCXGw3+oosiJkfdfv8/kcmHUgi6C2TkJuvMYE9KZQl/Pxhe?=
 =?us-ascii?Q?DN7u1bcugaKbcxusURI7PPyw9OTUbnUU41tbluDmXLgHk+L3D5vtUhKvZvbq?=
 =?us-ascii?Q?HObnVQUiTrlEbRO5c29OzdW7ga3EmGTCcZUl4+g9wVrUcLDCw9nRgd6IqUa8?=
 =?us-ascii?Q?V7BfLgJFr+Vj5GCx5zY/gRpAgdMfzx0FqghXLcG0J/ODGAIXXCiqkzndbLM+?=
 =?us-ascii?Q?9v7BA+UQL1EHKIJ7lDUW6e0nbBi8AUbSGm0dExlAPzYMi/oEZCqF9i/v/2EM?=
 =?us-ascii?Q?IpbK1x0Y9QcMoJwhlogGkX0/pn3fhuYViD+JRcQnbbPy9XwmjfChP+Vu4Xqw?=
 =?us-ascii?Q?QimmxfK0STRPZje0Y+c1rKWRPaBx5OgpYlTYagiPXTE8NdKKM02w7mFDzinC?=
 =?us-ascii?Q?ZwdoXOwd7JgOcg8rr84NO+WPZNWOARkOMW8SQWxCk0lscyZhleCKz8SRIwZu?=
 =?us-ascii?Q?6mLUcnkNtYViQiYi1f716mfvAxAXVTZCE2NqSUNfMD1g+tptbMlsfKBaE0P7?=
 =?us-ascii?Q?XvXROHcHx2gveOBn45mjy5WS3u1apAk2oGtr6DHQ/t3arC2iDzSlRkpL5XgT?=
 =?us-ascii?Q?HT13yxMRqNYKG8A7QZUN/fRftA55QpPdYiVUrDdAEeiDShpYsVJCBXWIIGLO?=
 =?us-ascii?Q?ot1J5LxAjDvj6thNuLLlZP8PYeEPnzPbvM+yaQZtJZ0ncI7QT55SS/8pO9lW?=
 =?us-ascii?Q?oXDEflA1nqEmpY9ubg7N5V1Wpo5CmKKsdaFArEV5+qUvyeWzqRn9zqKrZSH0?=
 =?us-ascii?Q?n3RaGLOYMCFw/8ToOrs9rYjHoGAldWjhQyJ6sohPzWSGT5g6yh2fG1rTaNYr?=
 =?us-ascii?Q?U8buEBDrwhS7TdnDs4DGSgu9CqAS7/+QNYcP2m8RJhf8R+C59eY/9+mSQQl7?=
 =?us-ascii?Q?z8v6a97EbTuzBt6TSxfc1Wfj+L86V0VTvUo6UTMhBqXxLL4sgcs9DcjtLHWi?=
 =?us-ascii?Q?K3DlRK/dOyvoWwRf1UizA18DKLyoyMxwdBdiyJjIqxYoDEtxbexSXT5aCxcz?=
 =?us-ascii?Q?lDWaFvFOqCca9pwhbKlKB1aTAI1pS60xUnalsw6zfLbKdDGfNHr8veuhc0As?=
 =?us-ascii?Q?mu4Ev5ueblwhC15y0L+YyvHx4NLTMlp78AJbTRd7X2IUgOjwNxI4tbq7YZin?=
 =?us-ascii?Q?9GJd2kZ97uBHZSguTIJdvM6hb22l2hHeVABmBhnbYxfK6aa4sRX78OzDhPOH?=
 =?us-ascii?Q?FokiKwRjyeN5HupA5Oj+ML8X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEYUGvaECOaEy+I1/lH2CQETbIVarL+h/AvW2GTdzSLfxthHFvvfM2rW4Tmd?=
 =?us-ascii?Q?rg58Flys8lkbO2ECRSflxU9ZKJHJa5HI1hHi0cVEnhmurXYlwFagRDgRBsnY?=
 =?us-ascii?Q?Eyl1D9nCYVjLRl52c3aIj1seBQJO9dhDl8fv405LiQFSYOrCYUEHrNvINgFv?=
 =?us-ascii?Q?Z+fNpIqSwewp0mtj468i6K8CMsqRdl2GYaqPlZeGJq3oADGEXDCQBKbRpp48?=
 =?us-ascii?Q?RCPXKWGzlFgUBClnME3TWYBMnX5rNMGhW/YEtTz1Z8zgHn+61WHlUQ2h/pNE?=
 =?us-ascii?Q?w/m3c+zyKIz49ARt4AK+LXiEqq+xndgXIYMk4g4jY0f2/ElVHewlRSl003qO?=
 =?us-ascii?Q?gQOmayAs1N0Wor82bGygIRQPKnG4DgJisExT3F185nUvtxd4uFSNd7JSHg7x?=
 =?us-ascii?Q?Z9cPzcjgxwS1AfCGbIOXzsVG6ZjSGUu8dhPIwTUuu9hi64Bgjrf+HTDejPsM?=
 =?us-ascii?Q?1a4mvbuBf1V9ta/YiA0YzLfQu6FkH1mVTe1Xh4dkxnCip5U0Fv9yiraDYHAz?=
 =?us-ascii?Q?Hq7/4MwZR/BzOc9N8Y/8NglSA21E2jEGovZISXpaCyGC8XV8JbMKUSMe1quz?=
 =?us-ascii?Q?IGxavxcwa9K3A+FP5Y2Bn4TgpuQnAHuU+ZctY0YzbcBVmyF0aLveqNvNL52i?=
 =?us-ascii?Q?0yqJom9s4sJ2tv+KX7BJX3fJlwbKVdhAY4vOV0eDyA4he+/dwIGdbcNzG68I?=
 =?us-ascii?Q?Jtg2gAsTtmD7iVgVlcoiNcRC6GvxmyuueMN57pYV21WerVeHmaPGdiYfeNf1?=
 =?us-ascii?Q?y/QYfebzTRVwa3IPsSI4erbAu2Wg9iYpTk90XIGzirEBjPgPA+OsFc8oHFZB?=
 =?us-ascii?Q?WNaIFEDIdvBJrI6BlWBg8khXvPPYqWaE87+c4cZYZjvoxh2C5YnXmcfI46nq?=
 =?us-ascii?Q?rfh+hO/33koETkkehAT4/BE1E3g/HhUWV1wQQoLpJIL1Bm3CRd033Z8S5AwC?=
 =?us-ascii?Q?OxN7nn9kHO8yHCbGOhaE3I131wmEsVLEuCOgi59XesoB1jFTFO3s+XuOwiVl?=
 =?us-ascii?Q?vKcqWbSA8VhTAqKBjIIF5XHG3rODn0szz4hS5jp+k0NZ2TO1i+UxqeCqgxbS?=
 =?us-ascii?Q?tCj/560fziwaS/tc5LJKGQMcu6//BgJQrqDZg95wt+TPhT7SUsb6LHQcosu2?=
 =?us-ascii?Q?/Wb9j6pGOlwvsOT/6QI54HSe5kQ/Z5izyyG1PzbmmBHXCxk0i8lRr7pNBT7L?=
 =?us-ascii?Q?tqawvPUHisAEEBVu+k+bppAJQejt4pU9uSwDtEBL2lhaGcPoUBAkz8Rhwv8v?=
 =?us-ascii?Q?8ZfdpRmXWBizilXpyptivAQxcsFjz252TW1m2x+bKcpcPOftdiD8b72PkZ2o?=
 =?us-ascii?Q?5bejDlx8cIqAvRpc2xjt7cfTVFH0DEoWi9PBlmgKKTbYx66XnoVS0kYT3Wwy?=
 =?us-ascii?Q?0OivKTQ5Q9BiwGTjFvZpUe7wJ4FaE86j5GQcB2JabZydF/2yqSGDWBlRItIe?=
 =?us-ascii?Q?PcrNlHgrqZFkdxWB078a8b8T+6oVE0iacnrJhbgBSh5LaOPwWRaetwt1e1Vf?=
 =?us-ascii?Q?2KhwF5eIcvVihYux4dQfniYkn/Nn2H0eVTwPndUDzvrwPqHtKnrvhLynkrEB?=
 =?us-ascii?Q?vBOjzk3qvYk93efC41jlCOp1k9h0F8STOiUNUy+MTGa7vPXL44y7xd4CruMV?=
 =?us-ascii?Q?MHU+q1PbeKIL2Adz3qvLwhTRvSeCEQWG2c+d2KDX6tNmRORDZr8xk/pbRKj+?=
 =?us-ascii?Q?Wa3mqg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sHsiCFUAZb50zXyMX5clRUZhFdihnQa5SnCXRA1YuEQVwD58oPnZ9IpOVg0R64XBwcvt2ORrpsToBOcGewvERup2U8NtLqbfphNoUC2bkkQlfr5ymuCsQj/yGIXloAQq2VYKzlCElqh5L6g0gT/aHnA0nTOmo2m1ArLhDIQ5rnWXdyJ/n0em5+D2SnwsNZumRw45N4NnRx98tdiQewtqnmYOrNpAKAB32A6GGKkXHDhv/Il3HVZBEkKAq+XpYZRqy3TSpVQkc20BUHUYTKNrENGZ3Axogclh3AO+IbeEab4RzrZMV/bXwG1rrjA02Fp85kaRPUgUHn7xa7usQvnAosHsKWelMVB7JsoRYl02iXhLhe5UYIDsT4uR+8qQ6htUs+PZCpn2sip8kv4lUNB8esih4kKMtxE9bwje2yyDATTlOa5vOpagQQynl2jKW+FlqJE659ZMWaXJm/AuJH2kW6tQBVQTwvm5m7fAyoGPj6P1PpJL8TEGoJiSKI3e9/o04Owgza8nEWOr1jX+WEOJHIjIiNp/KP/NGDYtjX2xWxHeOvIoZaCLRx6XTA/3lSEjz4831A9mCg9MGQO+ZChB61iGx+0+S+a50QNTxENfAhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d549080-c03a-4610-35b4-08dcf4d93e25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:41:46.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jquN5EKyi/ULP0XFZaqcxlMw2O+JAKUkXm6wXP99XaPxxJzVUFXsWJuF3WSErI7mOYWN8oKjmAG96D5YhqL6iPy4uqdhG78jN2lk7JDByvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250073
X-Proofpoint-GUID: daerc3PM5lacqOz2kOHa2IyfqB3VU98K
X-Proofpoint-ORIG-GUID: daerc3PM5lacqOz2kOHa2IyfqB3VU98K

It is useful to be able to utilise the pidfd mechanism to reference the
current thread or process (from a userland point of view - thread group
leader from the kernel's point of view).

Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.

For convenience and to avoid confusion from userland's perspective we alias
these:

* PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
  the user will want to use, as they would find it surprising if for
  instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
  and that failed.

* PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
  have no concept of thread groups or what a thread group leader is, and
  from userland's perspective and nomenclature this is what userland
  considers to be a process.

Due to the refactoring of the central __pidfd_get_pid() function we can
implement this functionality centrally, providing the use of this sentinel
in most functionality which utilises pidfd's.

We need to explicitly adjust kernel_waitid_prepare() to permit this (though
it wouldn't really make sense to use this there, we provide the ability for
consistency).

We explicitly disallow use of this in setns(), which would otherwise have
required explicit custom handling, as it doesn't make sense to set the
current calling thread to join the namespace of itself.

As the callers of pidfd_get_pid() expect an increased reference count on
the pid we do so in the self case, reducing churn and avoiding any breakage
from existing logic which decrements this reference count.

This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
pidfd_getfd() system calls.

Things such as polling a pidfs and general fd operations are not supported,
this strictly provides the sentinel for APIs which explicitly accept a
pidfd.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h        |  8 ++++--
 include/uapi/linux/pidfd.h | 15 +++++++++++
 kernel/exit.c              |  3 ++-
 kernel/nsproxy.c           |  1 +
 kernel/pid.c               | 51 ++++++++++++++++++++++++--------------
 5 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index d466890e1b35..3b2ac7567a88 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,11 +78,15 @@ struct file;
  * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
  *
  * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
- *              @alloc_proc is also set.
+ *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
+ *              thread or thread group leader.
  * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
  *              of a pidfd, and this will be used to determine the pid.
+
  * @flags:      Output variable, if non-NULL, then the file->f_flags of the
- *              pidfd will be set here.
+ *              pidfd will be set here or If PIDFD_SELF_THREAD is set, this is
+ *              set to PIDFD_THREAD, otherwise if PIDFD_SELF_THREAD_GROUP then
+ *              this is set to zero.
  *
  * Returns: If successful, the pid associated with the pidfd, otherwise an
  *          error.
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..0ca2ebf906fd 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -29,4 +29,19 @@
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
 
+/*
+ * Special sentinel values which can be used to refer to the current thread or
+ * thread group leader (which from a userland perspective is the process).
+ */
+#define PIDFD_SELF		PIDFD_SELF_THREAD
+#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
+
+#define PIDFD_SELF_THREAD	-100 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP	-200 /* Current thread group leader. */
+
+static inline int pidfd_is_self_sentinel(pid_t pid)
+{
+	return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
+}
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..3eb20f8252ee 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,6 +71,7 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
 
+#include <uapi/linux/pidfd.h>
 #include <uapi/linux/wait.h>
 
 #include <asm/unistd.h>
@@ -1739,7 +1740,7 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
 		break;
 	case P_PIDFD:
 		type = PIDTYPE_PID;
-		if (upid < 0)
+		if (upid < 0 && !pidfd_is_self_sentinel(upid))
 			return -EINVAL;
 
 		pid = pidfd_get_pid(upid, &f_flags);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dc952c3b05af..d239f7eeaa1f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	struct nsset nsset = {};
 	int err = 0;
 
+	/* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
 	if (!fd_file(f))
 		return -EBADF;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 94c97559e5c5..8742157b36f8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -535,33 +535,48 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
+static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)
+{
+	bool is_thread = pidfd == PIDFD_SELF_THREAD;
+	enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
+	struct pid *pid = *task_pid_ptr(current, type);
+
+	/* The caller expects an elevated reference count. */
+	get_pid(pid);
+	return pid;
+}
+
 struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
 			    unsigned int *flags)
 {
-	struct pid *pid;
-	struct fd f = fdget(pidfd);
-	struct file *file = fd_file(f);
+	if (pidfd_is_self_sentinel(pidfd)) {
+		return pidfd_get_pid_self(pidfd, flags);
+	} else {
+		struct pid *pid;
+		struct fd f = fdget(pidfd);
+		struct file *file = fd_file(f);
 
-	if (!file)
-		return ERR_PTR(-EBADF);
+		if (!file)
+			return ERR_PTR(-EBADF);
 
-	pid = pidfd_pid(file);
-	/* If we allow opening a pidfd via /proc/<pid>, do so. */
-	if (IS_ERR(pid) && allow_proc)
-		pid = tgid_pidfd_to_pid(file);
+		pid = pidfd_pid(file);
+		/* If we allow opening a pidfd via /proc/<pid>, do so. */
+		if (IS_ERR(pid) && allow_proc)
+			pid = tgid_pidfd_to_pid(file);
 
-	if (IS_ERR(pid)) {
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return pid;
+		}
+
+		/* Pin pid before we release fd. */
+		get_pid(pid);
+		if (flags)
+			*flags = file->f_flags;
 		fdput(f);
+
 		return pid;
 	}
-
-	/* Pin pid before we release fd. */
-	get_pid(pid);
-	if (flags)
-		*flags = file->f_flags;
-	fdput(f);
-
-	return pid;
 }
 
 /**
-- 
2.47.0


