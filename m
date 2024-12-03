Return-Path: <linux-fsdevel+bounces-36377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A5B9E2A58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DC2284C9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FD2036EB;
	Tue,  3 Dec 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQH30V0e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eN85Fi2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE851FECC3;
	Tue,  3 Dec 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249163; cv=fail; b=GZ+PKiGzmCzxwiEotXJBKGNGkQONlKmJFGcLEFsQZc5uqpUoVwMstD+4LGyOCH9zXJt0sj8laAj2DMtfIMyHnOW90CyvDNX9YdhH8H9cdJM27gex1HKkYomSne5K8K9GaAQ7KFslErQgBDAwFDu1Tu0QKJB14JiquN5kH+2PL4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249163; c=relaxed/simple;
	bh=ijSqR7vQeesx9ToiOXXWqmTLUzHTbMcyZ/f8EIqPNrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHZ7PJ7X7gbiMChpGT0vt+r+94NCAhVa0o4r5IuOHBsuuCDX4JAmZKd6BFGS/XOIJW2CoDbiWiue+p61sg6WBD6Je1rJ8xVK/9rONy1zvqNd/lRpkOYEQ1v0IAV6zGZmMgkNJ6DahHw5NyRo2zZxoI6eKoW8NrMc84MWLOs+w2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQH30V0e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eN85Fi2F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtY0v030152;
	Tue, 3 Dec 2024 18:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=f8U/gqFVS1QCBDY/iVkzXmoF1Dj4A8+V07OZpj6ShB8=; b=
	RQH30V0e2OB8NtN+txK9AtVkNo/pCz8GS9+IL50Ou1lnOLHm4TSK6ZSmDFhLSmiU
	dU8ufq5Rarg090USVxEzYXPYBhNNGY+FhUTJnXf11v8Q1QHtjOv2QHGeT6OsoL5q
	7tVarRDwp5TU07jkiLyzF1dnJEDovWObGrQUf0pGosK2CZEuEyPpYzA8YqR2ETme
	do8n5BTELp+RpuyZepnFALVYjmLKE0RjHYohnJkJIINkAc8TxCRzMy0o+nKf4iyl
	fRUjBp2J/i6vIEtBp3Tqc8s4oUtOAbaDsA2Io/Tt/91Dh12HZ0HNqLpy7pPcCCuY
	PKfgHZS3xgIHgm/lSTowvQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas6n4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3GT4YF031378;
	Tue, 3 Dec 2024 18:05:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836u8ghx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 18:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vg3VOgVAlcfndi7pvpntjJ1TWo62pOnBvX+iz/zqnmKrWnZyo1xFlYDxh4EjoF11Ccvj88xX2xReSGMiTShu01pTggChpFVAFjoFiIVAYzTLbI0CedQGQd6Q/wlxMv0KpoOI6t1l61HuMMrBYAvd9jHIqT6/acr10EdXJsI9eUP9t41PJThMYGL7EYveNDxBO6+K+93grGhwNXQw3FPdj0CkdUKR72IPpImhoXkU8lOQMokALaV+TheOjd94rXzl/hDNlzbAiKE5uOSpGTNYukP591QPQeOpxFz/o4Zwi19p4duR/GHlvPCzArMQ6Rg7koZ91f8elMSJqGbNsT11kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8U/gqFVS1QCBDY/iVkzXmoF1Dj4A8+V07OZpj6ShB8=;
 b=yAMHz9SPSnVQa1spYY/mq32JSXK1IitWWxjUo83g3NzSRV3ut1nhfojhkZ1R8BFhyQ3EVrtTsrkS7GF2x+IV9giorxrL0EDvH7UkVb3uGsovdDwdxTASuikX7jRtfcWqoGhcgUaBWY06ygDbZEALyc3Vl5f1Mgvdoii7KF3JxhR1xmFcmVhiJKmOI2iHgIqXgrFXAfRtDG4hZt0GZfQx9C9ORai0Xmfl0Ida10EHbthdAgOYox9hYkteoUEcKzt24xCyBe42c8ilH4LHM8B74T2L0TlXHo8bNY8AHSxty8mzoyEEzN4gJKlh9sWWmAhDZSq9bdkyTAJt44bdMsCMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8U/gqFVS1QCBDY/iVkzXmoF1Dj4A8+V07OZpj6ShB8=;
 b=eN85Fi2FmRso12FrFE6LoMNCl2tQZSp/4w8wS8q1YAKDepZU6Gvnf59Ttxbh/k5BmieUOkQE/2YQZS6v/0eROtXkXDZOGFBYCAimBSREVzTCqsOb+kPwCeYpI4i/78bbWENCQyPz6gr8xpkc9UAvj1nuLz4VFsP+03ozABYgkG8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 18:05:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 18:05:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mm/vma: move stack expansion logic to mm/vma.c
Date: Tue,  3 Dec 2024 18:05:11 +0000
Message-ID: <0feb104eff85922019d4fb29280f3afb130c5204.1733248985.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
References: <cover.1733248985.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0450.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::30) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: e2221735-4f24-4201-2249-08dd13c5183b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mO/7ZWbxQ7ryjf1GR7njAiVkUTPrG7h08jewPkfQfeZU37TsdHMNG5C9fm8f?=
 =?us-ascii?Q?kJwEu8X/Ud/ZLn3f/3Xkd85lry0M//G7nswKH6J9cC7oTSWeBeVw6oq3mmQl?=
 =?us-ascii?Q?M/JGR2mlhxiL3usjaujqUhhEoAjguATMpPlxoxm0MBF8EE++xDzdNshg/g7C?=
 =?us-ascii?Q?Bsq3SVSDx/wpj11FpbS+58ixARWWekAgdXLTz/HLjQKf1N3X04aN1/6Zkn5X?=
 =?us-ascii?Q?eyXwNHENAKMk4ChqKSL5CMYk1+OTk4ape2elLiPp4+b/KrOgZLXUACKM+Fg+?=
 =?us-ascii?Q?qsFwlyxxO6oAFrInZCE9CNP4cb7rMQ6Xm6fA7nKkTCncv7zKN0KntoyMm95E?=
 =?us-ascii?Q?PskdfAb5P89DJZPbDr2VaRPfmIlIEWTUBdevqbLcm4VKxcIkbjjpJdNR5RkG?=
 =?us-ascii?Q?4fV4olQAsZA3lR0Of/fT9+PCIHiX0C3iEf714Y4rhQjHEwQJt8/uINygt0vL?=
 =?us-ascii?Q?sC5xoYxH3S43zlbawB7ttE5kUvcLZ6l1ehBk1qCrNEvyJYOGS1bEUa+28DT0?=
 =?us-ascii?Q?0FP9Be697q+mq5hJ595I3wzWIjPVXBUzerllE7JdnG1wpq8C30XcymcRlBws?=
 =?us-ascii?Q?19goL+PGuOrt1Owdqe4XF4tZo4QnWNmqZZ4J3pxyh8vOUjAsGt6VeM6FEnkg?=
 =?us-ascii?Q?lzPlBdk7ShXKYmw0VTntmZ3bbuyUSGZsmYNgXo+ojabydQRWinXTI5auht63?=
 =?us-ascii?Q?L3+pDWT0WY/z+ZMVjlLYxaC9k7UwKEyi5cFVDwsrZDsZra15iN7qoUErXbhZ?=
 =?us-ascii?Q?SwPLoGquB7+fqiyOEgBNrqwQJAkN5i6jtqgVstWjX8BlxWNjNUWEvxiCleFi?=
 =?us-ascii?Q?OXNd7Lxn0xKkCj88/ltjqm7f9onU3owi0WRwOUqEKxTxISiqqcZW5FwzXfIN?=
 =?us-ascii?Q?osec4oLL8KU2XfKgJMR35QCvpREC3b/mqL05B49ktjxXy2/cZcGaiU78cLtd?=
 =?us-ascii?Q?zBx70coMNMPyIBWwp/pzPdC/dCJNTRPO+yo5iXFUernsWgtyzf9urj+CdTyK?=
 =?us-ascii?Q?xKW1EOa9hHf5AGz4OtOiCFj4LLAlUJuxXve5WETwob3eMAPRbKsskUbXP7Vw?=
 =?us-ascii?Q?vwAAKX+6K6mmweKt3zKpC7Pez+diBnXUWC1UFzjMrIcbilAT3thvzU7cvssT?=
 =?us-ascii?Q?7/64MuvQUlpnW8C0nVpO84RlIBgKNIL+WwAJV3wwQ9m7UdpSDTXBidOjGzcO?=
 =?us-ascii?Q?rJN+IgdeEHVPEMs6bUwJhl8L+WnG5BNAEadfaQlXtrrj+mlu2ik+6r4HPhRK?=
 =?us-ascii?Q?l4zpXod5JSnkPymswtsCk1aU92HbkTNtWm8VyYz9etIlf1UgdNDaSKeMfF/x?=
 =?us-ascii?Q?X+m+ljOSg710NxDn/B5kJlcwCddiASTRCAd9D6jVfQqq7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AmVzT7wNXyzQGS0RivGuYDYOofCRdfRagh2NLJU0OoWkq5vUeAwCSkuQSfNK?=
 =?us-ascii?Q?gEDfsL4Do0Pk9DiWmtLbNFP/Be9ne4sH/fiCIOeaUDPGwJX/bzR8rh9JN6dU?=
 =?us-ascii?Q?ARbYNHjoWpMi6/oS+GRPie6x48L+xQ/yVr2PLMqdUBac4bZEgXw/mgs+6ysq?=
 =?us-ascii?Q?xXWBe3q46eKW0Fa7BdqE0clXRFKhWMrYubBKoMp7y1m8F7mBx7SRcnzWsZtO?=
 =?us-ascii?Q?Bmon+0y6DP4uqQfBKqoDKjCQAom1aHgf0juIm80VpHRg48XM4EItVbv7Lgww?=
 =?us-ascii?Q?aJ1Rq5JnEcrbwSRarx0kXhE3uNVBlMRN6Zh4asab4Ged45j/vsJqff5QppOv?=
 =?us-ascii?Q?o6bhEC4C6gqS37qwxR17toguElzegWHgjzxh3F6M4VsRcGLGZyJKDUQwWMcP?=
 =?us-ascii?Q?uWrNEd4MvXyiUeHRnBtUNS2B6lS8muBc6qFl7+jC+a5dCSGYqWZUEYWgiN5H?=
 =?us-ascii?Q?JAcKftzhuq/uLpO75Es0+HwkMHsI3pz5Gi/xZf50vN/4uSiS5idOBzg73m8S?=
 =?us-ascii?Q?UoLh8g267GImc/xe0C67utfU5ytSyGapa5N6f6qld7qHF4T8Ke/0WyNgvrlj?=
 =?us-ascii?Q?cg4cS0a0ZNKuOMtQWBPpUhaLEsdg4kRD8RQfvj+7JYrPiM2XA/MWCbiGC0T/?=
 =?us-ascii?Q?9oAMPtbRfWCXX/dUUFoU+evs3UhlSy1ANVCamJYh5SI/bnVvIqi8mVs+INre?=
 =?us-ascii?Q?zYpk0w7PxthUoo6nv0gbjCiH401QDIUwFlmNx0l4np9wg8HqPS2L72gKrc11?=
 =?us-ascii?Q?UDNFvrP9vPu6KFV6giP4teOzsWIOB+oPoN88LCD4FKvlZ7YtWgTcd7ID+37d?=
 =?us-ascii?Q?wpEknJER/y+sGlsrS66nkLaPcoZOJ6PHipbd3s8mYeIqN8mDGWz4uwRlD987?=
 =?us-ascii?Q?YP628VSDdF/AJIwnM+6h+TdcFxoA5LXxACSNl42NAN6W8EafFfKWLVM9IwOq?=
 =?us-ascii?Q?EN9wofKv9Lm7NRwEiCA3C3ZhaswzEQFgJUormNDFThSzana4+s8fLrnlBMYy?=
 =?us-ascii?Q?VElsBcpIDYYLuFGkLqh1NEOlat2jbzAdk2RkH1BTjJBLHQoTPx+8UJl9r8cV?=
 =?us-ascii?Q?DIKvDhVGzBSg/mBKkNsY3vP/Hk2WGaOtzO1TVUuniAfQBVWdUrXeGT1JgiLl?=
 =?us-ascii?Q?fqA80ELl81B5B32CMPv4+Udo/x2N7BVagiS+ILGiHlj4x9N64xhq+O/adrjj?=
 =?us-ascii?Q?Y5HlTzTdXkzfRmZqtq5hIX59vd3QFJy/pxRS4xgyB7zwV2SdNxs/b6u54N+3?=
 =?us-ascii?Q?LVRA+a7coB8rWhQyqDEJYt5s1lrd1P9QOB3lIvB7p2oMSk6r5YE7kgxaz3/U?=
 =?us-ascii?Q?edk+9VzuHQ/hr+onMkooS7Y+em2kph+C4HH7ldcEhZaYgY9oJ3hoOOYlK3ia?=
 =?us-ascii?Q?DEkGakwRPanJmyusPsnzNBn+wcTOUcaE7+jXEWKtLJ0kQH8fZ6lQ/hwzSCq4?=
 =?us-ascii?Q?7PeaWqPsXcqcK54fFZXqwYJbBLUtMvOt8ZBFs4Z0OCOi9OJSoPZ/lJL4VHTK?=
 =?us-ascii?Q?GadXsc5SOLVMmLXE1LVpzccPWHOPGSd0CwCWktgeI5C0aDPPiNJvENEK0Cim?=
 =?us-ascii?Q?JCE6Ij8k1UdjKQ5Qa5po4/WvSr4cs3FEL3lm4/XqOYkRWRF7oKc86S4HojAR?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oSQLbxK4ZqvrEKo8LFQHwihuY/zkIJlrTfcy/n7DssK+FX9fCL/TIk9ybWTfc5//CQ/cV2wuDsPk3eBNdM6MyV30B+KOnHDcxl5BAtobn+zycoo7ERpkyTDX69QCDVtv5g495CfXqXp792PMYkhy8cVvDp9EzzR5r2G2n6FagUILagUpdyPepOuTrCb+H1WcJFsB/dp7pd9wVw/TfMgNdcY8474W8UiYFtyVl9Od2T68HJ5CPSMDwkdfsC2t8xSEtrXl7rsddARco5nEuEpviY5fuB+c4BpjDCpBXAYKihzzIWL+P2nfzrrc4Uzoy09vr5xHGiwoDGjGRjePwguzxiCStt5kIujPsEK+aBwo0teMXjvWF7W9/EF57GM+MMcsei2P0Obf4ltuwS1rnHEaz0YR4GgMpMgXJZEt3bYjUQ9KhzdqnTPhbsnsaM6Ab5MAoAPeopOAs+JpVJc106IzgO8Ugm3snkGRB/EZFlT1fp1VXOSWeNv1HKiDyFvPlqSl5lS+ml75i+nUvKQjnqmDnurJAzp88PmpRNj2M6njo1GnlLGwib9FgeV17gjV+aTBe4aRPBVl4KydgeSbRSQ7PH+8Kb6IjrAkpvpfc3NkY6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2221735-4f24-4201-2249-08dd13c5183b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:05:39.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZScrNk+VWbsJY5Gs9JK8mI4Ma/+cdQL96X2g9j/OLPAzvk0qtdOdiW4SbF2j0s+B2Tc8J4si4xVAZQMjpgndO6+/Mx48Geh4wX2dRsx1OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_06,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030151
X-Proofpoint-GUID: slcM9c0nE1THh8PRMfCu9KscHYkJdCbe
X-Proofpoint-ORIG-GUID: slcM9c0nE1THh8PRMfCu9KscHYkJdCbe

We build on previous work making expand_downwards() an entirely internal
function.

This logic is subtle and so it is highly useful to get it into vma.c so we
can then userland unit test.

We must additionally move acct_stack_growth() to vma.c as it is a helper
function used by both expand_downwards() and expand_upwards().

We are also then able to mark anon_vma_interval_tree_pre_update_vma() and
anon_vma_interval_tree_post_update_vma() static as these are no longer used
by anything else.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c                        | 205 -----------------------
 mm/vma.c                         | 269 +++++++++++++++++++++++++++----
 mm/vma.h                         |  12 +-
 tools/testing/vma/vma.c          |   5 +
 tools/testing/vma/vma_internal.h |  62 +++++++
 5 files changed, 310 insertions(+), 243 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4df38d3717ff..55a8f2332b7c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -879,211 +879,6 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
 	return vma;
 }
 
-/*
- * Verify that the stack growth is acceptable and
- * update accounting. This is shared with both the
- * grow-up and grow-down cases.
- */
-static int acct_stack_growth(struct vm_area_struct *vma,
-			     unsigned long size, unsigned long grow)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long new_start;
-
-	/* address space limit tests */
-	if (!may_expand_vm(mm, vma->vm_flags, grow))
-		return -ENOMEM;
-
-	/* Stack limit test */
-	if (size > rlimit(RLIMIT_STACK))
-		return -ENOMEM;
-
-	/* mlock limit tests */
-	if (!mlock_future_ok(mm, vma->vm_flags, grow << PAGE_SHIFT))
-		return -ENOMEM;
-
-	/* Check to ensure the stack will not grow into a hugetlb-only region */
-	new_start = (vma->vm_flags & VM_GROWSUP) ? vma->vm_start :
-			vma->vm_end - size;
-	if (is_hugepage_only_range(vma->vm_mm, new_start, size))
-		return -EFAULT;
-
-	/*
-	 * Overcommit..  This must be the final test, as it will
-	 * update security statistics.
-	 */
-	if (security_vm_enough_memory_mm(mm, grow))
-		return -ENOMEM;
-
-	return 0;
-}
-
-#if defined(CONFIG_STACK_GROWSUP)
-/*
- * PA-RISC uses this for its stack.
- * vma is the last one with address > vma->vm_end.  Have to extend vma.
- */
-static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *next;
-	unsigned long gap_addr;
-	int error = 0;
-	VMA_ITERATOR(vmi, mm, vma->vm_start);
-
-	if (!(vma->vm_flags & VM_GROWSUP))
-		return -EFAULT;
-
-	mmap_assert_write_locked(mm);
-
-	/* Guard against exceeding limits of the address space. */
-	address &= PAGE_MASK;
-	if (address >= (TASK_SIZE & PAGE_MASK))
-		return -ENOMEM;
-	address += PAGE_SIZE;
-
-	/* Enforce stack_guard_gap */
-	gap_addr = address + stack_guard_gap;
-
-	/* Guard against overflow */
-	if (gap_addr < address || gap_addr > TASK_SIZE)
-		gap_addr = TASK_SIZE;
-
-	next = find_vma_intersection(mm, vma->vm_end, gap_addr);
-	if (next && vma_is_accessible(next)) {
-		if (!(next->vm_flags & VM_GROWSUP))
-			return -ENOMEM;
-		/* Check that both stack segments have the same anon_vma? */
-	}
-
-	if (next)
-		vma_iter_prev_range_limit(&vmi, address);
-
-	vma_iter_config(&vmi, vma->vm_start, address);
-	if (vma_iter_prealloc(&vmi, vma))
-		return -ENOMEM;
-
-	/* We must make sure the anon_vma is allocated. */
-	if (unlikely(anon_vma_prepare(vma))) {
-		vma_iter_free(&vmi);
-		return -ENOMEM;
-	}
-
-	/* Lock the VMA before expanding to prevent concurrent page faults */
-	vma_start_write(vma);
-	/* We update the anon VMA tree. */
-	anon_vma_lock_write(vma->anon_vma);
-
-	/* Somebody else might have raced and expanded it already */
-	if (address > vma->vm_end) {
-		unsigned long size, grow;
-
-		size = address - vma->vm_start;
-		grow = (address - vma->vm_end) >> PAGE_SHIFT;
-
-		error = -ENOMEM;
-		if (vma->vm_pgoff + (size >> PAGE_SHIFT) >= vma->vm_pgoff) {
-			error = acct_stack_growth(vma, size, grow);
-			if (!error) {
-				if (vma->vm_flags & VM_LOCKED)
-					mm->locked_vm += grow;
-				vm_stat_account(mm, vma->vm_flags, grow);
-				anon_vma_interval_tree_pre_update_vma(vma);
-				vma->vm_end = address;
-				/* Overwrite old entry in mtree. */
-				vma_iter_store(&vmi, vma);
-				anon_vma_interval_tree_post_update_vma(vma);
-
-				perf_event_mmap(vma);
-			}
-		}
-	}
-	anon_vma_unlock_write(vma->anon_vma);
-	vma_iter_free(&vmi);
-	validate_mm(mm);
-	return error;
-}
-#endif /* CONFIG_STACK_GROWSUP */
-
-/*
- * vma is the first one with address < vma->vm_start.  Have to extend vma.
- * mmap_lock held for writing.
- */
-static int expand_downwards(struct vm_area_struct *vma, unsigned long address)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *prev;
-	int error = 0;
-	VMA_ITERATOR(vmi, mm, vma->vm_start);
-
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		return -EFAULT;
-
-	mmap_assert_write_locked(mm);
-
-	address &= PAGE_MASK;
-	if (address < mmap_min_addr || address < FIRST_USER_ADDRESS)
-		return -EPERM;
-
-	/* Enforce stack_guard_gap */
-	prev = vma_prev(&vmi);
-	/* Check that both stack segments have the same anon_vma? */
-	if (prev) {
-		if (!(prev->vm_flags & VM_GROWSDOWN) &&
-		    vma_is_accessible(prev) &&
-		    (address - prev->vm_end < stack_guard_gap))
-			return -ENOMEM;
-	}
-
-	if (prev)
-		vma_iter_next_range_limit(&vmi, vma->vm_start);
-
-	vma_iter_config(&vmi, address, vma->vm_end);
-	if (vma_iter_prealloc(&vmi, vma))
-		return -ENOMEM;
-
-	/* We must make sure the anon_vma is allocated. */
-	if (unlikely(anon_vma_prepare(vma))) {
-		vma_iter_free(&vmi);
-		return -ENOMEM;
-	}
-
-	/* Lock the VMA before expanding to prevent concurrent page faults */
-	vma_start_write(vma);
-	/* We update the anon VMA tree. */
-	anon_vma_lock_write(vma->anon_vma);
-
-	/* Somebody else might have raced and expanded it already */
-	if (address < vma->vm_start) {
-		unsigned long size, grow;
-
-		size = vma->vm_end - address;
-		grow = (vma->vm_start - address) >> PAGE_SHIFT;
-
-		error = -ENOMEM;
-		if (grow <= vma->vm_pgoff) {
-			error = acct_stack_growth(vma, size, grow);
-			if (!error) {
-				if (vma->vm_flags & VM_LOCKED)
-					mm->locked_vm += grow;
-				vm_stat_account(mm, vma->vm_flags, grow);
-				anon_vma_interval_tree_pre_update_vma(vma);
-				vma->vm_start = address;
-				vma->vm_pgoff -= grow;
-				/* Overwrite old entry in mtree. */
-				vma_iter_store(&vmi, vma);
-				anon_vma_interval_tree_post_update_vma(vma);
-
-				perf_event_mmap(vma);
-			}
-		}
-	}
-	anon_vma_unlock_write(vma->anon_vma);
-	vma_iter_free(&vmi);
-	validate_mm(mm);
-	return error;
-}
-
 /* enforced gap between the expanding stack and other mappings. */
 unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
 
diff --git a/mm/vma.c b/mm/vma.c
index 50c0c9c443d2..83c79bb42675 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -202,6 +202,38 @@ static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 	flush_dcache_mmap_unlock(mapping);
 }
 
+/*
+ * vma has some anon_vma assigned, and is already inserted on that
+ * anon_vma's interval trees.
+ *
+ * Before updating the vma's vm_start / vm_end / vm_pgoff fields, the
+ * vma must be removed from the anon_vma's interval trees using
+ * anon_vma_interval_tree_pre_update_vma().
+ *
+ * After the update, the vma will be reinserted using
+ * anon_vma_interval_tree_post_update_vma().
+ *
+ * The entire update must be protected by exclusive mmap_lock and by
+ * the root anon_vma's mutex.
+ */
+static void
+anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma)
+{
+	struct anon_vma_chain *avc;
+
+	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
+		anon_vma_interval_tree_remove(avc, &avc->anon_vma->rb_root);
+}
+
+static void
+anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
+{
+	struct anon_vma_chain *avc;
+
+	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
+		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
+}
+
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
  * @vp: The initialized vma_prepare struct
@@ -510,38 +542,6 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
-/*
- * vma has some anon_vma assigned, and is already inserted on that
- * anon_vma's interval trees.
- *
- * Before updating the vma's vm_start / vm_end / vm_pgoff fields, the
- * vma must be removed from the anon_vma's interval trees using
- * anon_vma_interval_tree_pre_update_vma().
- *
- * After the update, the vma will be reinserted using
- * anon_vma_interval_tree_post_update_vma().
- *
- * The entire update must be protected by exclusive mmap_lock and by
- * the root anon_vma's mutex.
- */
-void
-anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma)
-{
-	struct anon_vma_chain *avc;
-
-	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-		anon_vma_interval_tree_remove(avc, &avc->anon_vma->rb_root);
-}
-
-void
-anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
-{
-	struct anon_vma_chain *avc;
-
-	list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
-		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
-}
-
 /*
  * dup_anon_vma() - Helper function to duplicate anon_vma
  * @dst: The destination VMA
@@ -2669,3 +2669,208 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 
 	return gap;
 }
+
+/*
+ * Verify that the stack growth is acceptable and
+ * update accounting. This is shared with both the
+ * grow-up and grow-down cases.
+ */
+static int acct_stack_growth(struct vm_area_struct *vma,
+			     unsigned long size, unsigned long grow)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long new_start;
+
+	/* address space limit tests */
+	if (!may_expand_vm(mm, vma->vm_flags, grow))
+		return -ENOMEM;
+
+	/* Stack limit test */
+	if (size > rlimit(RLIMIT_STACK))
+		return -ENOMEM;
+
+	/* mlock limit tests */
+	if (!mlock_future_ok(mm, vma->vm_flags, grow << PAGE_SHIFT))
+		return -ENOMEM;
+
+	/* Check to ensure the stack will not grow into a hugetlb-only region */
+	new_start = (vma->vm_flags & VM_GROWSUP) ? vma->vm_start :
+			vma->vm_end - size;
+	if (is_hugepage_only_range(vma->vm_mm, new_start, size))
+		return -EFAULT;
+
+	/*
+	 * Overcommit..  This must be the final test, as it will
+	 * update security statistics.
+	 */
+	if (security_vm_enough_memory_mm(mm, grow))
+		return -ENOMEM;
+
+	return 0;
+}
+
+#if defined(CONFIG_STACK_GROWSUP)
+/*
+ * PA-RISC uses this for its stack.
+ * vma is the last one with address > vma->vm_end.  Have to extend vma.
+ */
+int expand_upwards(struct vm_area_struct *vma, unsigned long address)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct vm_area_struct *next;
+	unsigned long gap_addr;
+	int error = 0;
+	VMA_ITERATOR(vmi, mm, vma->vm_start);
+
+	if (!(vma->vm_flags & VM_GROWSUP))
+		return -EFAULT;
+
+	mmap_assert_write_locked(mm);
+
+	/* Guard against exceeding limits of the address space. */
+	address &= PAGE_MASK;
+	if (address >= (TASK_SIZE & PAGE_MASK))
+		return -ENOMEM;
+	address += PAGE_SIZE;
+
+	/* Enforce stack_guard_gap */
+	gap_addr = address + stack_guard_gap;
+
+	/* Guard against overflow */
+	if (gap_addr < address || gap_addr > TASK_SIZE)
+		gap_addr = TASK_SIZE;
+
+	next = find_vma_intersection(mm, vma->vm_end, gap_addr);
+	if (next && vma_is_accessible(next)) {
+		if (!(next->vm_flags & VM_GROWSUP))
+			return -ENOMEM;
+		/* Check that both stack segments have the same anon_vma? */
+	}
+
+	if (next)
+		vma_iter_prev_range_limit(&vmi, address);
+
+	vma_iter_config(&vmi, vma->vm_start, address);
+	if (vma_iter_prealloc(&vmi, vma))
+		return -ENOMEM;
+
+	/* We must make sure the anon_vma is allocated. */
+	if (unlikely(anon_vma_prepare(vma))) {
+		vma_iter_free(&vmi);
+		return -ENOMEM;
+	}
+
+	/* Lock the VMA before expanding to prevent concurrent page faults */
+	vma_start_write(vma);
+	/* We update the anon VMA tree. */
+	anon_vma_lock_write(vma->anon_vma);
+
+	/* Somebody else might have raced and expanded it already */
+	if (address > vma->vm_end) {
+		unsigned long size, grow;
+
+		size = address - vma->vm_start;
+		grow = (address - vma->vm_end) >> PAGE_SHIFT;
+
+		error = -ENOMEM;
+		if (vma->vm_pgoff + (size >> PAGE_SHIFT) >= vma->vm_pgoff) {
+			error = acct_stack_growth(vma, size, grow);
+			if (!error) {
+				if (vma->vm_flags & VM_LOCKED)
+					mm->locked_vm += grow;
+				vm_stat_account(mm, vma->vm_flags, grow);
+				anon_vma_interval_tree_pre_update_vma(vma);
+				vma->vm_end = address;
+				/* Overwrite old entry in mtree. */
+				vma_iter_store(&vmi, vma);
+				anon_vma_interval_tree_post_update_vma(vma);
+
+				perf_event_mmap(vma);
+			}
+		}
+	}
+	anon_vma_unlock_write(vma->anon_vma);
+	vma_iter_free(&vmi);
+	validate_mm(mm);
+	return error;
+}
+#endif /* CONFIG_STACK_GROWSUP */
+
+/*
+ * vma is the first one with address < vma->vm_start.  Have to extend vma.
+ * mmap_lock held for writing.
+ */
+int expand_downwards(struct vm_area_struct *vma, unsigned long address)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct vm_area_struct *prev;
+	int error = 0;
+	VMA_ITERATOR(vmi, mm, vma->vm_start);
+
+	if (!(vma->vm_flags & VM_GROWSDOWN))
+		return -EFAULT;
+
+	mmap_assert_write_locked(mm);
+
+	address &= PAGE_MASK;
+	if (address < mmap_min_addr || address < FIRST_USER_ADDRESS)
+		return -EPERM;
+
+	/* Enforce stack_guard_gap */
+	prev = vma_prev(&vmi);
+	/* Check that both stack segments have the same anon_vma? */
+	if (prev) {
+		if (!(prev->vm_flags & VM_GROWSDOWN) &&
+		    vma_is_accessible(prev) &&
+		    (address - prev->vm_end < stack_guard_gap))
+			return -ENOMEM;
+	}
+
+	if (prev)
+		vma_iter_next_range_limit(&vmi, vma->vm_start);
+
+	vma_iter_config(&vmi, address, vma->vm_end);
+	if (vma_iter_prealloc(&vmi, vma))
+		return -ENOMEM;
+
+	/* We must make sure the anon_vma is allocated. */
+	if (unlikely(anon_vma_prepare(vma))) {
+		vma_iter_free(&vmi);
+		return -ENOMEM;
+	}
+
+	/* Lock the VMA before expanding to prevent concurrent page faults */
+	vma_start_write(vma);
+	/* We update the anon VMA tree. */
+	anon_vma_lock_write(vma->anon_vma);
+
+	/* Somebody else might have raced and expanded it already */
+	if (address < vma->vm_start) {
+		unsigned long size, grow;
+
+		size = vma->vm_end - address;
+		grow = (vma->vm_start - address) >> PAGE_SHIFT;
+
+		error = -ENOMEM;
+		if (grow <= vma->vm_pgoff) {
+			error = acct_stack_growth(vma, size, grow);
+			if (!error) {
+				if (vma->vm_flags & VM_LOCKED)
+					mm->locked_vm += grow;
+				vm_stat_account(mm, vma->vm_flags, grow);
+				anon_vma_interval_tree_pre_update_vma(vma);
+				vma->vm_start = address;
+				vma->vm_pgoff -= grow;
+				/* Overwrite old entry in mtree. */
+				vma_iter_store(&vmi, vma);
+				anon_vma_interval_tree_post_update_vma(vma);
+
+				perf_event_mmap(vma);
+			}
+		}
+	}
+	anon_vma_unlock_write(vma->anon_vma);
+	vma_iter_free(&vmi);
+	validate_mm(mm);
+	return error;
+}
diff --git a/mm/vma.h b/mm/vma.h
index c60f37d89eb1..6c460a120f82 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -139,12 +139,6 @@ void validate_mm(struct mm_struct *mm);
 #define validate_mm(mm) do { } while (0)
 #endif
 
-/* Required for expand_downwards(). */
-void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
-
-/* Required for expand_downwards(). */
-void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
-
 int vma_expand(struct vma_merge_struct *vmg);
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
@@ -478,4 +472,10 @@ static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
 
 #endif
 
+#if defined(CONFIG_STACK_GROWSUP)
+int expand_upwards(struct vm_area_struct *vma, unsigned long address);
+#endif
+
+int expand_downwards(struct vm_area_struct *vma, unsigned long address);
+
 #endif	/* __MM_VMA_H */
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 39ee61e55634..891d87a9ad6b 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -53,6 +53,11 @@ struct task_struct *get_current(void)
 	return &__current;
 }
 
+unsigned long rlimit(unsigned int limit)
+{
+	return (unsigned long)-1;
+}
+
 /* Helper function to simply allocate a VMA. */
 static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 					unsigned long start,
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 6ad8bd8edaad..fab3f3bdf2f0 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -79,6 +79,11 @@ extern unsigned long dac_mmap_min_addr;
 
 #define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
 
+#define RLIMIT_STACK		3	/* max stack size */
+#define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
+
+#define CAP_IPC_LOCK         14
+
 #ifdef CONFIG_64BIT
 /* VM is sealed, in vm_flags */
 #define VM_SEALED	_BITUL(63)
@@ -478,6 +483,8 @@ static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
+extern unsigned long rlimit(unsigned int limit);
+
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	memset(vma, 0, sizeof(*vma));
@@ -1114,4 +1121,59 @@ static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 	return vm_end;
 }
 
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					unsigned long addr, unsigned long len)
+{
+	return 0;
+}
+
+static inline bool vma_is_accessible(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_ACCESS_FLAGS;
+}
+
+static inline bool capable(int cap)
+{
+	return true;
+}
+
+static inline bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
+			unsigned long bytes)
+{
+	unsigned long locked_pages, limit_pages;
+
+	if (!(flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
+		return true;
+
+	locked_pages = bytes >> PAGE_SHIFT;
+	locked_pages += mm->locked_vm;
+
+	limit_pages = rlimit(RLIMIT_MEMLOCK);
+	limit_pages >>= PAGE_SHIFT;
+
+	return locked_pages <= limit_pages;
+}
+
+static inline int __anon_vma_prepare(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = calloc(1, sizeof(struct anon_vma));
+
+	if (!anon_vma)
+		return -ENOMEM;
+
+	anon_vma->root = anon_vma;
+	vma->anon_vma = anon_vma;
+
+	return 0;
+}
+
+static inline int anon_vma_prepare(struct vm_area_struct *vma)
+{
+	if (likely(vma->anon_vma))
+		return 0;
+
+	return __anon_vma_prepare(vma);
+}
+
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.47.1


