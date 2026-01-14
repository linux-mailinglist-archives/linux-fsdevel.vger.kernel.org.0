Return-Path: <linux-fsdevel+bounces-73618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A259CD1CC7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9720B3031A11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F199A3793D4;
	Wed, 14 Jan 2026 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ACu/1HJd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fGR137IO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4C376BC5;
	Wed, 14 Jan 2026 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768374822; cv=fail; b=Lju5tOuIKjGEN/kubhMfkHVEPu64KcApOSillt4345dLITFzMut0BzdhaUhU+u+abYvBrkJ3biuUMDoyjpr/5c/6kvwrijuUCcb5VF7GCOj84Y4RGcO9hVQwsV/hNH2+CA7rnnp6af1wucHCdKoAU3j9YV2+rxQsh8LpivzDo4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768374822; c=relaxed/simple;
	bh=3/lGypzSKYBoScCNfRjm7rWfgBfFvnDBo2YxM+Ax6PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EYXR+NWTWlbSScuk+vE9kVYjFIFkiekTrLL2iwyAm0zCZ3zXsVwx+eC/pQ56imOfkcWh9izhiFn+P8uMQ2DV7pXQxhZO0ZiPcOXY5d2DevFSPUI4oqyt7IcTTNpf1NXJAMiZQuJxyLHJqhgQLhAEkX3JXpXH6GsHvqr3dSnsnHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ACu/1HJd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fGR137IO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E2Y3Rm654678;
	Wed, 14 Jan 2026 07:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=cBrf3ZdPsqtWT4qm2B
	3YhY+GmA0S+6TxnQMYiClYWaY=; b=ACu/1HJde0kKoIvNKKjeXrk/IjqVEkT0Fp
	b8gAujBjilPElblHuBU+onQdd6lCky3JwGV1CXEsEeraGZJLw9zaOOj+72kIJ7UV
	3KYzxqIgZrhPI93upvgb1CQQ9Njh/1B++0p/ZypWxJNIiVWV0+CB7/b9OE8gWe/l
	PtPPnWNnXpU2gMsyAw/lZX/k1wG/rrKVSFC8wWbChYU6UmVZSBW1AaxR+Qx+F4eW
	OxFnps945zAbHCwxECzUJ24i6scVlP9mlphmUAeKWKigCsXEVDZ4/AfCPjlOvEqB
	vz4UmWGgYpkh4OSagY5PYlXfIzZ72v3DZJbX7qTNQmv91+omVvPg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkqq54qht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 07:13:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60E5L0Z1008258;
	Wed, 14 Jan 2026 07:13:06 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd79ewqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 07:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmLte4U6fAoXDoyQ2wa+Ef8OoLClCgFmfboT3bVTlwoO57KRhbi0jlaTr9KhfrJsEWfPXVi+TWQwTHmxmEXa4J/+5BgFEBEJnHiQrbEyb4Fc4fBqlITiBfCKc5UKTTsQ2BeyUVsorkHuWsjT40RgkkBAOG50dP4cJz3xLAhHBZSPCn8jbHeSLSs7fhCQpbNYZIgdqjK1fzInYfKZUs0wdN4qGrXsii6O3+gpEw2CLkPhhnjuDSk9G+ywLlAiJLuizlhk5YWiGwXZzLthUYIEpTeuopWTTN2VUl2AqgN82K8BuzTXKsf0hbcYOdLN7fSjnbEECKUyPzC3TegzgwAPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBrf3ZdPsqtWT4qm2B3YhY+GmA0S+6TxnQMYiClYWaY=;
 b=wzvyEXq7YPHzZi7pfvsJEHFCqCARzYKK2wf7BImaqvwEpV2EihG82ZqVsJmehPbpRKSqyf8nt6IU81SrXCfGLV4JQpVSzT8sj9WPGkvuCeHwOJlDNrNsDp/C2DfW0Jq/fa4Sz1XovzPKz/fXsIu/vLiwTJyCpajvW50R8kSCwi6D8eqnCr+hchFBb+tOLazNBhvSTZgasJ8BAT5it7YCiA9NBOHLREj64PKcPL1XO0clY6dC2dAFq4/d8ojL/S43rVtCqIBQZRVZvSNx32BKjuqtoOOKtl0VM5luYHb63SYs/3W67xAtpx0GIRqIET+CJyc1HjXn8O1xl3f1bAMSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBrf3ZdPsqtWT4qm2B3YhY+GmA0S+6TxnQMYiClYWaY=;
 b=fGR137IOcvb8R3C5gH722IBSo8dAu4RWbHtj7H0HxcjBLd7hLCDeaOskZg4ZhbqIs7I1H0kQK3aK3MzUPRucr8vbWLCgmdadI5z2nr2CDyktc2TqvAedz1R554P7rg0JyRMjLE8uLWX/vdsXGE2mw9cnRRKprS47uWFzhFL+pP8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB7499.namprd10.prod.outlook.com (2603:10b6:610:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 07:13:03 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 07:13:03 +0000
Date: Wed, 14 Jan 2026 16:12:55 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] kmem_cache instances with static storage
 duration
Message-ID: <aWdB90WCfsArtwOw@hyeyoo>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <CAHk-=wiibHkNcsvsVpQLCMNJOh-dxEXNqXUxfQ63CTqX5w04Pg@mail.gmail.com>
 <20260110061600.GB3634291@ZenIV>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110061600.GB3634291@ZenIV>
X-ClientProxiedBy: SE2P216CA0184.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9f0072-4541-4d62-259b-08de533c5b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/TZS1xx7G19zMAgRDasU9qX1REAEUq4+L6xT5B4nC2Hzo1OWfDr/wJc1qcc?=
 =?us-ascii?Q?UvZndhaZobRR5iHtXDezQlhx2BAjhCMWQ/pTEILyW0YcVj4OyqMaXmm/of3l?=
 =?us-ascii?Q?VtQUN0cxVzqSungwNf0DFJDFNvI2wXWUynVX/jBeV1ff/20crjOxkT+IWZOp?=
 =?us-ascii?Q?/Fryj1TH8UCrDUIfTFHZMT2+Em89rcM7YG2LnnwaBdPkErP3cmHFHnfV2cLT?=
 =?us-ascii?Q?pnIwnFf4M1RmpFejyG64pkazWw7Rxf2SfZn9QoaqJLRqlq11XQjCQmjq5rXn?=
 =?us-ascii?Q?4qOjXC2/GpfaT1+9pitQUjBMkUDg5DMXcyhpedGeQEtI8pFbr3D/ydVufXKQ?=
 =?us-ascii?Q?UIp0VmCV9WqFIhWblgRcl/FUZTnETJnIvmHbl4PY1D2FuKJ0qf4/mBT1taQv?=
 =?us-ascii?Q?2e39lDq/esfhu40HDlcfq7YVsSJRsQJSNFza99uGc9vR1pBh4H+kWC9dvWHC?=
 =?us-ascii?Q?+1pX8+kc0rPONbEVSunbReVT1Jsn3QKxuCy2trXahEIkGhClyYdyAmt6iIsv?=
 =?us-ascii?Q?bIXdSxzDDq12T7uSFRDlhMcXl057BMhWZNcRpXLRJhVSilhLB9m1WhFYM2wW?=
 =?us-ascii?Q?pYTcuB5Vfg9fAqeGQ3s0CVWtzwM8VL/+rcD7ZSQqaEzQ4KRxKMknTzYUjhHI?=
 =?us-ascii?Q?Wc48/n/q4jJx+DNTnb2zESRTKt/LDjTup2GM6YtvMYSZhz/m+2VIEKIwCH/F?=
 =?us-ascii?Q?tYV2+1iekNg49j1dq4HyRY2YgowMozkfNIvJqtIIl/2/DpaZx7PG2lCvKDR8?=
 =?us-ascii?Q?vw/nvThi2WXLEb+xOnHeTs/ElgtOVYIlFecRhQIZcKg1mEVFao44qegy5GMh?=
 =?us-ascii?Q?yPdIj0pTCpVZxrpTZxmvgFNZVo5rBLpmBwclGH7h73/nQfIpQ9Cvo2ky9UQk?=
 =?us-ascii?Q?jbZuU7GnztzWho4ehiErK9ro7IXEzAAXVwArbW5t3yzE8XhfcWZGwy/Ta1Eo?=
 =?us-ascii?Q?QWF1r8sWwl7fup1Xlhff6mIZ8TcPQ1SYwc4qPFSAGvLRpwcY+cnKK6MVY7I4?=
 =?us-ascii?Q?aUDhFjk/BsxdMLNJyKQUxtMBm+0ejmY9T4xLXApp5XFvguLzrdnuBQbVb6qV?=
 =?us-ascii?Q?KywFk23M6nUq/+fqXhpmvajvvTu5RhzFS0Erp+qAVqVnuYcjm9lo9jKGjBpz?=
 =?us-ascii?Q?8A1jhlNWEKkukigCBClZkZ1/JfxXNSjyOC3fx/Lk2daZQAHrMqHxndqJJie/?=
 =?us-ascii?Q?0X6NuX9dlLtgEPtjwPAPncaV3glm0izjTuNKzneOWPijUkAD/eiHEe+kO4I0?=
 =?us-ascii?Q?Fa/sup8nKMnlYiMlg+zzRsV4+wOfYQEYiK+055CVyCkOfC4m8X29bfpdVRA/?=
 =?us-ascii?Q?3hlnFIFD7br5BN+5Lk6HYOSKd+mBVFPcfhaORSfOWl16JJIrRo2N8WrEahzT?=
 =?us-ascii?Q?srOOqT5kV3ll7CW0cVhWDLuklVCLSPDK6n6Y6ZD6x9pXwbewVRErh2fSM75p?=
 =?us-ascii?Q?YReSa4XHvZZl8YOGRCx+u7ig8y81ohVF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5hCHSs/Sqov9RxB8Ow0lOn0nmp2lXbPQRNZoZufX4+aSW539rxMbeUh45qx?=
 =?us-ascii?Q?zmnPtF6BFUXnxV7cu63Vki5FDEBhrCHfEbvvUxlZ7mUwqGCB1cER16/0nuBK?=
 =?us-ascii?Q?Ysvd7Z74dGr6D4ahiDsFTojOl2uP813veSqE4ewLKsVww8n+bl5oO0mH1bcL?=
 =?us-ascii?Q?WU+8UGrf1rCTEYPd2Y9A35ZgJzbzo2x5MpoLT+TX+2HyUz4i9/Gg1zG+eHHG?=
 =?us-ascii?Q?eAKSSXq5ZGuPAeGrMIqHy/E9vaYq2F0R+sE7DFiswLFV/2R6JcipILs1RVen?=
 =?us-ascii?Q?8ehJS7Q1qK/yps63z06awS51IrS9+dzPI+u6WiVNqa9FR7e7PTM5gcA+/U0x?=
 =?us-ascii?Q?1W7FcqwxVT5jxElWXlhcjYl4bwa94qfYCBAOyEyFHHQOkAOmQns9+D0a/hcT?=
 =?us-ascii?Q?n92c5FQ0O41pLyZL8RjdSwjMiMR/e2AJuyjWRhXAfJfWVSuf9b19ehFcqmDM?=
 =?us-ascii?Q?GdWitiVDppEE2VNI1xw427aTTSdKxBwooooD/b/ecdserFoQbou5LGcE8D96?=
 =?us-ascii?Q?/4afj5WhGyMkpa3z22ppymi3d60X/EYnDYsKhdny1b22B8EfjAlxdvY00EtP?=
 =?us-ascii?Q?//N5vMhf5v9jwwrwX9vk015vsLODOhMpbQ0eLfuFIVMIecOb8NxUM8oV0zGf?=
 =?us-ascii?Q?ExHEoy6GXcevDr0fsyMGuOEP1IL1F4lCGVxpH/UW7+3d4Y7Lhtnql2HpqwpP?=
 =?us-ascii?Q?/isfe5H+Wg7uZqj5RoJdgsXiz7jVfwnngJh2mnwbzib6TJJsn3KUAVY1A4T5?=
 =?us-ascii?Q?mj1xLCSDCG+lYAYIh/d9vQkelZtsLcnv5+ZIGhq61ftWHOzmxliwQpfP4QLw?=
 =?us-ascii?Q?Ny2CP8q8YkwrA7J5huCqowC6l3tOaEHLqEPsTOMqDBsuwaxhLF2RjoETI2SR?=
 =?us-ascii?Q?1pLOSKjSfhBLmYrlMQ9wS5BQ+wltEW0kOsKMV5rsr700L25/fXLSqwN65mOc?=
 =?us-ascii?Q?6SuhsinldE1KqrS4zzorIOfJ/b6UY/qeZws9vgzH++u4i6nAGTeci6JHQVeM?=
 =?us-ascii?Q?hezIGMiw1tb7BCWK1ERWuo1MOOqf56Od2v9Wm+3WfuVh+MT3HpQ6N+o+NYzq?=
 =?us-ascii?Q?zon81RaYoDPjdiH4x6SPW0ILeaslwgFE5d2w2D4VwrhTODQwETo8xibGTNij?=
 =?us-ascii?Q?HGBPae32TDTmYxyEH9TYlbWK/170oUVjpSgg7GAmQCXUa12tyq+vj9pPs/6U?=
 =?us-ascii?Q?OFFySLy9dV4/Dx5vUXgthAvOFJMhM8YHrBnHVVeIOiq0P2u1MAu8QqFkA7Mb?=
 =?us-ascii?Q?0Ke1WS/rdO6qKggRifK1Uucb9Ibqh1jqzZkwfXwAQXJCoOj+LvVwQzC57woh?=
 =?us-ascii?Q?e/xjb5Jn+c0lsx4WZSoQB1gzvryICProtTVkoVpXsoWrOMItUmWqDOUWeULI?=
 =?us-ascii?Q?Ec7RTfGOsBpao66qIIaAhj7dpUogt3DWATpRFS3WLwhVGl9HEbzNeu7dUJ7U?=
 =?us-ascii?Q?ODohBgAc7XGpq+Gv6IlFi74Sz4o9QOzJ3j0HdcwTo1r+jCQBZjs08swWf2D7?=
 =?us-ascii?Q?TxsQ0yj1X7Z8wYOD0ghl/3RDvW7gxK98uDIy5ZbWxsUPdhT22w7DxGZ3G6zq?=
 =?us-ascii?Q?hL28vqA5+p/KOZWTaYKKL6sD1MDh9a33ylFuv6/fp9sERnUlL95m1Lup9c4s?=
 =?us-ascii?Q?IfVUVUMQo3fB5VWyYMMkJVRiDfy3iGqsF/QEDwI0sh/EIuXxJiUztZVlyY83?=
 =?us-ascii?Q?eVPmzRE94Eo93iKNoMjYmHhE8FZij0ooBhmYjK7EPQJ2GVGbovAgjRVVgrSA?=
 =?us-ascii?Q?RpjRfzZ1iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UpbxaB2saEXsRUpE/AgRlQUfQKM4i1oK1MWkA8uEfwMzPMxkt6MnVd7vGRVv8tUC/AHrT+DIX2JzM1Ntl6Uek1uaK0vZg/7AxFmcRvOnk4TSFIdpjQj9A6OVgsR6HuWsHL2xYvI34AdrWNyOSz+EHnblcp9dRN7h1hk5vnqYc7PNFtMwEIRrilffepz6IEnoHcEST3QbhyXoKiP6iq0kRMOIlQ68UfmXPY/gGIBUYQ84u1ewfmPzGRbGxFqd8blrQDh5zjOKfFsmsQKj6vffPeukVq6FT+7PCmCGRtRAWhG8LTAZnzyk2BLwb0vi8IKD8F31Nh/lzrFAl9VJGAIFlR97gP0QYXF37nqnR3rnju6o4pOzb7Jqvk++QSuhlVQvvl617JDZ5jhrn8U+W6Gr38j4f8lelPNznLsVFXJSd40Uo2vCmDVxrlWKyvzeXxgEyNMtFV0lpBSoKsxYyq/4QF0V5JDVTMdHqPicnX2vIh7M3XQ8yGbbLa7/Jvnc07xYULsmd46lD21UJKi3mcr+KVTFgT+bS+Xy8Yn0WfXX+PHsSUXfYqj0m+HcFUW8zgnLXOLpuPVYu7GmqW93NSkndszc6/0B+u+uumRtM42XDQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9f0072-4541-4d62-259b-08de533c5b5e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:13:03.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvHOHO36J1fVUHRLWPGY38b/fmmWeqyHAvyyb430LWw6s0V8/9MSpSskUxVGHBIOmiONbYVS3UUD61h2H/wiYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601140054
X-Proofpoint-ORIG-GUID: pP3a6m8YkaN_h5w800cwR-rnjsf5n6tX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA1NSBTYWx0ZWRfX54MUSGBsL63q
 vF+rcnTuQjWJuv5CygaOtQLbo7lgWdnvBqpWq5nVVmzGkB/QEOWfBkclwBMemjzkDUHDxo9E8LJ
 9Itv+HbskOhn+gw/C/AgtdIOOF6EToaNeiT0XZVjs73mZiX2aXIYeKnacK0NuZFw467d79SZvPC
 F8lW/96jdfd8ZbvBaSrtjqGi7rkLpa/qyBTj+tZlODnC3y/YRXqwShXUgi/qPN2yUvhOuC0EKsF
 c3m9c2TowHkHYJOVN2cIa2kP/fQTLw+L5usmJ60nvWSBc3l/nUjMWFIlIZcixu8nUoT+aOqHjp/
 eHblqVhkbzk6/bNaRuQlVD7qU+hoNIjXCS0qeB+U7wRN7160HuUM9J7bnWnG/6x/6SDCiiIr0lO
 77uhB7/scSZRr7yblq1oh/+BweDeLfOY53iz2nfu2JaonlY0qyPZ+5IogIw59YIwZOXPhrZoSQ/
 Om9nkdBV0n3k2RxdN8Q==
X-Authority-Analysis: v=2.4 cv=J9KnLQnS c=1 sm=1 tr=0 ts=69674202 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=drOt6m5kAAAA:8 a=sYDH7GT7DCu-enPuqqQA:9 a=CjuIK1q_8ugA:10
 a=RMMjzBEyIzXRtoq5n5K6:22
X-Proofpoint-GUID: pP3a6m8YkaN_h5w800cwR-rnjsf5n6tX

On Sat, Jan 10, 2026 at 06:16:00AM +0000, Al Viro wrote:
> On Fri, Jan 09, 2026 at 07:33:41PM -1000, Linus Torvalds wrote:
> > On Fri, 9 Jan 2026 at 18:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > >         There's an alternative approach applicable at least to the caches
> > > that are never destroyed, which covers a lot of them.  No matter what,
> > > runtime_const for pointers is not going to be faster than plain &,
> > > so if we had struct kmem_cache instances with static storage duration, we
> > > would be at least no worse off than we are with runtime_const variants.
> > 
> > I like it. Much better than runtime_const for these things.
> > 
> > That said, I don't love the commit messages. "turn xyzzy
> > static-duration" reads very oddly to me, and because I saw the emails
> > out of order originally it just made me go "whaa?"
> > 
> > So can we please explain this some more obvious way. Maybe just "Make
> > xyz be statically allocated". Yes, I'm nitpicking, but I feel like
> > explaining core patches is worth the effort.
> 
> Point, but TBH the tail of the series is basically a demo for conversions
> as well as "this is what I'd been testing, FSVO".  In non-RFC form these
> would be folded into fewer commits, if nothing else...
> 
> I'd really like to hear comments on the first two commits from SLAB
> maintainers - for example, if slab_flags_t bits are considered a scarce
> resource, the second commit would need to be modified.  Still doable, but

I think it's okay to introduce a new cache flag as long as it's simpler.
IMHO it's not a scarce resource (yet).

> representation would be more convoluted...
> 
> Another question is whether it's worth checking for accidental call
> of e.g. kmem_cache_setup() on an already initialized cache, statically
> or dynamically allocated.

No strong opinion from me.

> Again, up to maintainers - their subsystem,
> their preferences.

-- 
Cheers,
Harry / Hyeonggon

