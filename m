Return-Path: <linux-fsdevel+bounces-67281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B6C3A5ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA673B9D0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5230101B;
	Thu,  6 Nov 2025 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQ+RTIvn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DVA4iR+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C071FDA89;
	Thu,  6 Nov 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426013; cv=fail; b=CsC4LUpdxiGc9iEAPRGANqVZD3TFR7FHTHEcv/1Fa1WU6jQH4nOTv/MFBJh/2e57XWjaMFcrRs60FGLbuzP2tIRvnqhHQ+FoaN7MP/fp2YwjIPtonWUEYowGgq7FZmrLnfOoK8QX9txcxv7BBZYTqCxLZ6JIU6mVdvzlWr9DRrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426013; c=relaxed/simple;
	bh=yJRiJjIVJX5ugUMb+rbFn9Nqj3Oe7zSUgTia9epSWI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bBbZ1BQ1FJ6q8fBcQG0f1Mp1BcAuiMVHdDpsG53knZbkGA1aimc7zIgpSBVa2sZPwRXyzu6pooEHFieNq7Re9wLVSk/u2PSJkGzwXmpt/UiSjY6yNXQRVMqqiowyUrgy/RS4+xXB0HNm3iLRjbwczIBxjonq0yKHeoT4b4+BaUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQ+RTIvn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DVA4iR+/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A61CUM0000531;
	Thu, 6 Nov 2025 10:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mao3WdHLkdfH8B1+duzuaq5WP4IuopouXpNoA8xuH/E=; b=
	jQ+RTIvnhuJ+pNhWNVSgChVyRtiQ+VfBARCKhhq19P/2iAyfDDd2fZsL7noJxLdl
	I5ttof6VGfApI3Xagg+9Ko4crEhBwIPNLyHEWbOVGrvqlmevpLtIdMRHpYieB+El
	L/B1roFdRyt/F/oQq1avyH8eH7mQ1Dj4uqpyqAwrnGjsWBaz+WgGcEr2siFqMgCq
	jLKnlFsxVzFeb5im8+oMPJEtMNscIrtWIV9618loXgcUmCuLU3pwIRc8lVgOMhMh
	O734q53+k7hfjhFl/26aTzLrBz3hzG+N8Vv7fbicsOPJ1kw89wHf56NoBMMhDd0S
	D8IZfCe/fBo5DgPIUKiGuA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8at91qq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A69lLEK010770;
	Thu, 6 Nov 2025 10:46:29 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc8c3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyrSC5hY0yWsHedgaIymlI7tl3hfhUFYaMjyujxzJJsDtyBDz51zFVkWh8FonWbvOLjzRPtLOQN/JCeDz+ivOqMZeVUn5JY7RA+/eAfoFqezO72iOZrbZEw5PtML+PTMwOVruwh/pcM7qNb1r+enB2HaHlzAgV3IfkDX64t3gNsj1LyZJZ1XlEzhZSQ6KFUOVMWnXoico22DVbiqLP3DJSE4lOBsrWEhwiIcjrp9Wa++4s54DCK9R0nm/gfsXazbgUZQDunPruxhb3qzJoSKoNk0E0sLanW4XSpBcIuui8Y4AJpuKQpYyXPhM1OHBHyTWKjH7Abn+XtxJDSzitn22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mao3WdHLkdfH8B1+duzuaq5WP4IuopouXpNoA8xuH/E=;
 b=BlR5JeAFstBZSO5XsGmqL0jn2w+i2f3lnfqlEx9y71rpOOATSQNDfM/GfQplFrQislt/SJ1Q6xj1WQmvlXl6O6Rsy3smaKTGDuoSN3uO1IeH5J1dt0RbYnKqASxHQSlIDnFHo7qclNaw9HOWvvR5ho9u4g9jRrbkybhcntQmDQhoew6nGu46gAGVK/dOR9kUYY5VcllpYyCHk8OEFzR/SbBZkA3BPuFK5A6GnTNwk4YLwt63I0iTSdej9UxCtrMKFocy+noAwgSoKpVH6z7YY/UiyOx22kwBf4ywCd3PKgEZ3w9iXmAEcFonfthMctgd0l7BlpE9SaRZiJ3wPbsnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mao3WdHLkdfH8B1+duzuaq5WP4IuopouXpNoA8xuH/E=;
 b=DVA4iR+/rqj1hNfQB/xxM4yq4S/UGQJ1spwE+CUIcnSjhPiE+l/s7zQQlaCwTsRDFyRtjHWiKhyJWE0on0IF2BaGdS71N8Rz5VQ9lw+akNT+ICNDFHxpiM5K68SpcuPXyR7ZYDH/uIwvXXcwUav9Z3pPvkb/xhWUapmAeb88BTc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8250.namprd10.prod.outlook.com (2603:10b6:208:573::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 10:46:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 10:46:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v2 2/5] mm: add atomic VMA flags, use VM_MAYBE_GUARD as such
Date: Thu,  6 Nov 2025 10:46:13 +0000
Message-ID: <94935cf140e3279c234b39e0d976c4718c547c73.1762422915.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0683.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 239e2db9-af1d-458d-7c87-08de1d21bc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dA/9UJ4cxODJBMLA/yhYNx2iRfEKbcoyui6v1mO9oCboQGk2lQottiO5FNZf?=
 =?us-ascii?Q?hBWiE/elfjFCWgF73pXLRdizALvoGy4oAmDVRHOc+nvIa/VfuU3KZWp0bD4g?=
 =?us-ascii?Q?T4b9OWOfFz7PRJNX4wSRLrNmuWlFzMqhv+jy/bCYIfYCtlWVvyI1idifKt+Y?=
 =?us-ascii?Q?EvSEDsGW8zB0kDyzHBkhpuHKEJ9C7LwNxZzLC54Hv9wurP0GwKjlWhSO2MWX?=
 =?us-ascii?Q?GyO5W1LKc8PCUxLBVUsSZ/6bJawli+tgCefGgP1a0OEII/xrndV8OI1KgLyf?=
 =?us-ascii?Q?zJuAgkZM6POif+Byd2TrOryatR0vipcI+fBfpmMBoO0wHmjo+qelhDSm822j?=
 =?us-ascii?Q?Aaaq+v+xBcqpHOe7GUPBffbwbRPsNsRp1toVFx/0S33ceCiXog9BfktyjF7q?=
 =?us-ascii?Q?hf+82f828kgKL0LCMeK8w/yEgtcxldEXd/mByheFgOReA5Wk9lm0eKQUARYA?=
 =?us-ascii?Q?obqIAj1PX4JEb5mCO+jl9SiksHs4Y1ucAopDIZ7vGDMVEKUc9JJt/j1QaGWa?=
 =?us-ascii?Q?tVkXNzNxEf1h4LRo/ivjpsxncci7jz+o+d4klyEk5TltNN7bZ2k4/PjZyEJ8?=
 =?us-ascii?Q?EXDWUGl6MYRGbRIlX49SRbfKoCTgf1nRqOImqYL3YiZcZXnIC0GDJilrMDFE?=
 =?us-ascii?Q?NWisFATS066RmcxGb4CK6UyfFW0hg/2W1kMPJ+4LWT+rElWNXtYbckBVatAk?=
 =?us-ascii?Q?s+O8/w6ckXUw+3Jn1207SB1vOLwk4cj9jy47iO5MpN401si/mkadbCzsvmfN?=
 =?us-ascii?Q?8Ov+l1zUBtU241HgxPN/sGgPKdH8jt7FG4bHunvKg5unm7KutGk/c1up0C2u?=
 =?us-ascii?Q?gmO8eYe4CCQEE7LVzEP0FB/8nuF/PMjprPRC2KSmywhsoVi3ljwnI+uzMiYS?=
 =?us-ascii?Q?PexQeY83UftXF3PObxPphJi9yhR5ZP40ASlfaX4AEAxD71FPRqKfmhLVjwxT?=
 =?us-ascii?Q?k+BnU1vwVbUCDTFhtkBdiqlWEjKjKwkQuGCdehgEPPfWfpTRPFWPF6+3DES7?=
 =?us-ascii?Q?J8IzmcDSmVVrkvg7Eeq4c5rElqJ7qnueSsu+BjLYaNXpiVxzuT4cc3xhd8HK?=
 =?us-ascii?Q?ZyrPQH9HJfraK3GPqZ1h7jHuhPk06NEfUDiD53U40k4yqvFuD5gPOLz/VmbH?=
 =?us-ascii?Q?Mkp/igbIz3oAalwg5hbRUUvRa5eCYTYWQ3Q/TwJyWh9Se7EDloeeLh43VA18?=
 =?us-ascii?Q?W6RAEmNmBaPDkFJN/Nhw63k9oAZFF7Yd8tO7VBIp9oIQJq6IJ0pVBYZKBLqi?=
 =?us-ascii?Q?moNHxSS/cjPxZkzoDDSdmS5GBIBFnYzeDCUJbBk5DoyqpzKlomyaqm/WqB3U?=
 =?us-ascii?Q?9HmZ5uDjrcc1Z1TJ1/DLfqx99zLD91phgPKaOfCM8pAlkB4Vfct+GMXRLeLn?=
 =?us-ascii?Q?HHox93ByNJVcWggX/BaxkyEU3uf1qF+r87qFaVacnHp7TeHU7WMneOJ+6CmF?=
 =?us-ascii?Q?QbAIC2lMCAMekjvlbNfMmDu7xXqQEpWq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aqA8FZY7EEImTIdxtADftp4QfRbcR4SWfRNdzZSkJAIQ1lOw49ZMKZr1vJfG?=
 =?us-ascii?Q?91R32M+/hc5i0xPXXSWq9DtXoQeKhTTdbDhZtRiOj1t+fUf/0EPZTRx791Z7?=
 =?us-ascii?Q?xBI9S9iyJGK5U1pQ9e4n3kYAqYZfudUt4bpj+QG97+V3PSXP3dUSOVYOtp0C?=
 =?us-ascii?Q?fXMwthKuzp4+H+gRLkHJWEnRe5GkroEZy9TCfxWkTpvSl/boscUsMMOIodLb?=
 =?us-ascii?Q?qDePg02uocxW5S/E6a6wrh4Ul/MjgkWEHrsBpBaeWF9YdJIvJX29vaqfLJEB?=
 =?us-ascii?Q?eaGIp9YMAZ1eMCpdth3Eo6SrrNcTjzerV/ncDW2K2p5YS2n0ZK2op5D6Av7J?=
 =?us-ascii?Q?WSrd0m2OxDb8Y/uCXVsVMZTG0yzxYF/CsopYJMY63fCNWixb7IvI4BBGjtRm?=
 =?us-ascii?Q?MAG0wuXPQ3Wsy4UnPjk0Knbyw1+amSukJm0RFdeinz8paCZdk7qKMb+qalle?=
 =?us-ascii?Q?MQ4gTiaOzhH+QB19HJ2Ru9TqaJvGUxVcrP4iPGKWd4xnMk3ntBR/G5dK2hi/?=
 =?us-ascii?Q?kpC9k4m6psUWEQPQjRzWsKEfVMBsFjPTZvvqtgxROYZ09bl7ix0nGtoJfq7k?=
 =?us-ascii?Q?h3sv3FUnKIk04hWqZMTnqTGHKyHFnBG8AjWfQYTZ1c8gPIcGUwwhpe050ZoO?=
 =?us-ascii?Q?xtPFIhEgjnTJFkHv6LCD1MyqoeqOL7vRTPvJrD9OA7t+J5MicFLQsX5FRN6N?=
 =?us-ascii?Q?Jq590ssyvbaMgR/OmP1SmZLo9cNV6GCMNCKngSjyRxISzPgx4izgAvjmoahs?=
 =?us-ascii?Q?sln5iG0Kp2TEx+F7fbiYtpsPkjp4UddTynyX9Jxb7BfABQViU0/fMU+ZGQSY?=
 =?us-ascii?Q?lWmtAZI0D5H/0puZiS+o7M9B5t8DfQ1Mwb0rgAKkPA8Q5jvYQlqJ1nffMeDb?=
 =?us-ascii?Q?T/ZoOVNNjEm6sfksLXOApu7F2iQhQoxBbwhxDFvWc7Q79APXfPH//VMdx0vd?=
 =?us-ascii?Q?1Bu93TtgWaBSyNPiN4t60Oa1mOm5ZWAE4rMfdZUHILmI1/r0Fj+VxViytJp/?=
 =?us-ascii?Q?yiglL77yXHuvuA8ojnSMzBgPMnYfeQlkHiSIGobADesnw2PSc5Jy8VOhJ6/X?=
 =?us-ascii?Q?i3UNePn+Hlo+BRbmdhbXBlJCaRB9eoV65HdCf+6nAdtv18Lg5M9Z1o/iSNHg?=
 =?us-ascii?Q?oGLpudKogA6aCLFSuSBJrNiy6fgxmHmbRmzoJOiqMiMVuUfmbdIBl8O4SjNE?=
 =?us-ascii?Q?axj/Z4TAc8xIWErmxyotBHsqL5bJiO+y+wg1W9QYFWMYCDWhvqutGwddt1xB?=
 =?us-ascii?Q?h517So1IJiVsW3GZFTjNyDwP3L/sJ8XfxEx+4ovdOBWrCReM6VVgcdMKg9Kb?=
 =?us-ascii?Q?aYl0+a9iNA5g4ks9M1yhYkJaqEoHsX9+rmtaRQzAa3p1SK+oiRGSNNwYwks/?=
 =?us-ascii?Q?tivoLS9ZNAYoNg+JXaCpXs8Unn8Ipssxfla5Z/QHhmtP4uON4Nzdc3gAAub0?=
 =?us-ascii?Q?7/3CuUC3CB09PZCyLF8sOusT8qGngihc/lag5NtwDYDZt/vrNWAw83Un8HZ0?=
 =?us-ascii?Q?RioXF3cPZrFrydVNlJSa3SmvvVNuihlvUMDl4ZAQ19OpG0VBHnRbmRAiJReE?=
 =?us-ascii?Q?d+J9z4d9s+hBQnX9DhzGhN7on0ZoXxJIyShoKN9baovKtSbro+w9PRAaSXxC?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1XXBaVDzNWeYoJVV94qDzObpX5PObmMce6Vj/AvgO8TquzChDVZAnTiNCOb0xyjHk5coHNqYMIc0nWvTbmDMualrdXp7jBBYN+NzaNuXHk+5rHtxr4CrzokRys3LJcQlnMRonGhUktEc+jTlpfeo3WcXuOycXSZsbVOYzgPSmuvvRDZTEnoFhgxx6vJu15sJ6548WLPiym87un53ZpJ4pu9seu1b8tX17k+xgIf/Y/0STJida+XJmDnCHpWM96DzsHbzwOIjgfKMCE+m5HWP3ZKN8YMJIlE0IQceNe+pREQ6uLWQCYJlqPPj2DVmVTs/Jm9i6X9fS3E1eCmJn1OO3yRFXSS0doqUlBaZwYLhgOBEOO4QHEDZHLRyAa4ArZEoHKGVNWRX+y/FBofDxxew4tJojyv3FAFYDOf+V98tAhuVAUDQnoCVaB9Qy90OQjG+Kb++WZ+pD2EfCn9CZMVqmQ6gh/Uw1b+C3qfP5x342OaG8VSPTWyoxWR+EswL0oFSwXpYvEIvRf+ZpexSg6pSlBwS37XWpsCRfPrOEBNDP48jWDX7h+zWW48SsQlj7eO3Vo9WWA6RIaTqvH8YilurimfI9VvK4c2AqLrh6iDBV4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239e2db9-af1d-458d-7c87-08de1d21bc2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:46:26.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgtsbZN9qNPXv6n5rFoKqGHe7zbP5CZ1yBWOWAaiQ2zstJiW/p+bPJh9d59gfjIDAZ1AzK7FAd1CHhm44irPw0gJBbEnumAt/vo9zb7z9nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060084
X-Authority-Analysis: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=690c7c86 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=EQ2y6AcogoNLRGTXdlIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 7Gg5ktPcwtAJnTGhg2r8_oKIssax0QAK
X-Proofpoint-ORIG-GUID: 7Gg5ktPcwtAJnTGhg2r8_oKIssax0QAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfXxG3Q4CdGYPar
 GLBYxbpAUV8iWCdeH4fGj3u0j2ZmO6P7IqUg+F8SsYzObED6jcOWkPJ6Y3Fl1gPmqwUIiIn49xg
 Z/kDLZmq14t34B65t+L6IE/HcyJm2mUiHtts2SP7UNoZ9apEIEcoujisukN85nHSL7lKz4v8cJI
 NY/a2tDNGje0GmbIEbz0DDHcX76WWqAEriswD3Y7+/AveQT9IVnAty87usonedIUTCvr/NE+cwv
 a4VZ1Wdv7DzbAXnrYvBfgfTI+CYM+LWeRIaX9Uz7l64TVsyXhW4QMHIYmUquwebtEAq3kssLUKg
 HILPVbDUzes/Jmgxeu90oBnz2OtCuep5zCM3P1eUrvI7EWGJCW2t4NFBonnYZlMvovVoEpqrW3G
 jPlLrPvd8vaXu31pILn20HaFO8od7Q==

This patch adds the ability to atomically set VMA flags with only the mmap
read/VMA read lock held.

As this could be hugely problematic for VMA flags in general given that all
other accesses are non-atomic and serialised by the mmap/VMA locks, we
implement this with a strict allow-list - that is, only designated flags
are allowed to do this.

We make VM_MAYBE_GUARD one of these flags, and then set it under the mmap
read flag upon guard region installation.

The places where this flag is used currently and matter are:

* VMA merge - performed under mmap/VMA write lock, therefore excluding
  racing writes.

* /proc/$pid/smaps - can race the write, however this isn't meaningful as
  the flag write is performed at the point of the guard region being
  established, and thus an smaps reader can't reasonably expect to avoid
  races. Due to atomicity, a reader will observe either the flag being set
  or not. Therefore consistency will be maintained.

In all other cases the flag being set is irrelevant and atomicity
guarantees other flags will be read correctly.

We additionally update madvise_guard_install() to ensure that
anon_vma_prepare() is set for anonymous VMAs to maintain consistency with
the assumption that any anonymous VMA with page tables will have an
anon_vma set, and any with an anon_vma unset will not have page tables
established.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 23 +++++++++++++++++++++++
 mm/madvise.c       | 22 ++++++++++++++--------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2a5516bff75a..2ea65c646212 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -518,6 +518,9 @@ extern unsigned int kobjsize(const void *objp);
 /* This mask represents all the VMA flag bits used by mlock */
 #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
 
+/* These flags can be updated atomically via VMA/mmap read lock. */
+#define VM_ATOMIC_SET_ALLOWED VM_MAYBE_GUARD
+
 /* Arch-specific flags to clear when updating VM flags on protection change */
 #ifndef VM_ARCH_CLEAR
 # define VM_ARCH_CLEAR	VM_NONE
@@ -860,6 +863,26 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
 	__vm_flags_mod(vma, set, clear);
 }
 
+/*
+ * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
+ * valid flags are allowed to do this.
+ */
+static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
+				       int bit)
+{
+	const vm_flags_t mask = BIT(bit);
+
+	/* mmap read lock/VMA read lock must be held. */
+	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
+		vma_assert_locked(vma);
+
+	/* Only specific flags are permitted */
+	if (WARN_ON_ONCE(!(mask & VM_ATOMIC_SET_ALLOWED)))
+		return;
+
+	set_bit(bit, &vma->__vm_flags);
+}
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
diff --git a/mm/madvise.c b/mm/madvise.c
index 67bdfcb315b3..de918b107cfc 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1139,15 +1139,21 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 		return -EINVAL;
 
 	/*
-	 * If we install guard markers, then the range is no longer
-	 * empty from a page table perspective and therefore it's
-	 * appropriate to have an anon_vma.
-	 *
-	 * This ensures that on fork, we copy page tables correctly.
+	 * Set atomically under read lock. All pertinent readers will need to
+	 * acquire an mmap/VMA write lock to read it. All remaining readers may
+	 * or may not see the flag set, but we don't care.
+	 */
+	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
+
+	/*
+	 * If anonymous and we are establishing page tables the VMA ought to
+	 * have an anon_vma associated with it.
 	 */
-	err = anon_vma_prepare(vma);
-	if (err)
-		return err;
+	if (vma_is_anonymous(vma)) {
+		err = anon_vma_prepare(vma);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Optimistically try to install the guard marker pages first. If any
-- 
2.51.0


