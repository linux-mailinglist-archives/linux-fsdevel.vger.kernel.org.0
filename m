Return-Path: <linux-fsdevel+bounces-40457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B452A23767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65EC83A312E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4421F1311;
	Thu, 30 Jan 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CATsvf6w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dg2W1QnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E6012C499;
	Thu, 30 Jan 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738277609; cv=fail; b=TkNTDvC6tzw0moWQIcJWFygVP7PZYs3E3fI1n6FvQWb+sLevftuuam8W/Bzr747WLQsH63qiO/rcq491wsDivahG/aUO1zyd+GdtG3E3oncC9q7wflhN06f4RAoAHaDiioaRFBCwo1Z0n2f6eQMXozFxI7R2wj5jLctnIxQZSr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738277609; c=relaxed/simple;
	bh=2YMMNTqQ51FzeYmD+DMPeVkbJAWtgDVBbRt7j/OwjIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Du19oPYOw8aIGp7i8y6L4fMuvLvoykUFyDehxfTXnpU7U8xuNjk3KdNXZJnKjX00wckels2/tXh2dHFenDvji+cFlbN2KLXPF525AZfbhJWtmXzqT4SxLn81/GWrLXCqDGjonxlPXfL9CROw9YQtpSX79FKsQo++mfVTYPLEx4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CATsvf6w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dg2W1QnL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UMF6Xd020935;
	Thu, 30 Jan 2025 22:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Uu0ylInvjJ8pzuYF6L
	xUr815f4XZ4Y9PDmAktcs8BgE=; b=CATsvf6w0UtPpk0UJ+9gSocN9777uapVW1
	w5cJWg7jJ1hemIHkNDsKZLKkg4qoMjDzWpEQtVpkSHDkj9u/XnSuKpX44jnJ/vTY
	JbCUd1NAzVMVnJHUrBTJ5enEx8SUXrEYQIuxUnzWU7ro25K87NIPiYvqSM5OEJmE
	iVGZAsfWY6Wpgh5BergMZ3vj2I+4N+PI8u0otg0WpshEof6PTNHNS6DPvx3oQPe4
	SnClxSL9d44V0H3P1TYHd3F48TaLHQkAxRsGPQmKtK8ltDhi4EYp1WfhJ4jezvMK
	b6I1aDCrzYX2YBWWiuSEJ1kfMBnt4PQU+tkzOUq3bhj6zl4Qn43w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ghxar29w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 22:53:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50ULm2uE009040;
	Thu, 30 Jan 2025 22:53:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44gg1fp6wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 22:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2N/bMbN+RbcAXQ2+WZqpwpCoJtaugqtSUuMX5GnyJJGt68rU5j+hmJDjiXwa/X2ga5p7Mki0KM0GP8/h3st1Pj7MOFOnCDS7uY4TKcniB2mCE1DPndWl1UpPxB0XtCJJlkYai1Q7OhfPpiBICb83u7r6jiiePjT+IUulbHKykjtgciYIWHHc3J/cfxqYkZIl6XJhWxdGR9D8vI4PY5IjRmTNZf0XQoiFxujHtOCAkqnn2GIvDkh0htnSBmgB0573dAsOF8BuaSk9VIgEFgrpGFw8tjDffZHDQuhvuzQUfRoOHJ1rGoG8jw6Uf2zLP8LehOdDwBT3wF/76jS0zHXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu0ylInvjJ8pzuYF6LxUr815f4XZ4Y9PDmAktcs8BgE=;
 b=vC7j6dU9VTYSbnerdnIOJipy3VEEIWcsvh0Hm4HkDlcnUVP0Ypb8ai8cj2k4G1T+51KdS9+3aDnDxKarLZIHUyoJSRYkaK/rOQJPWJ23c02js45i29yo/LhuDbi5xCP+Xx7UjTcIYi2YY7GQK5V6laeAfWsoImvcymgkcPY9DVd1840QucLZ+Mt6sjmFPfzRnZRiuRuPG7dYQGS0ZQX3BKuB3G5/3BX1vxpM9qzdO9oOpzxgSsfxddaOBgtLfPkjevKBtave9snFBBwqc3iLeuaMerbdyDzAzJNG6qZFYCohjpCLu9JemOwLZoEQjORSafS1aWZ+G47jIWIPQ6CHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu0ylInvjJ8pzuYF6LxUr815f4XZ4Y9PDmAktcs8BgE=;
 b=Dg2W1QnLPiq2eUysCRZU1U2v70Mfr56hI+nYdvqrIgdcuXrb/qrNuEN5pQj2XtUaPDGEdVUX0/kGFLtLH35kwHvpA1K2Wjm1zlpNbWYejl8e2Ece6anQnbVvkav7koeZa4goHHt8/g4631F46bboriz51IRfg9DZjKewC4ljMOk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 22:53:05 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 22:53:05 +0000
Date: Thu, 30 Jan 2025 22:53:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Message-ID: <b396487f-b906-410d-9ff4-6956d99e2771@lucifer.local>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <20250130143754.1b8bb87bfb15175dd434529b@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130143754.1b8bb87bfb15175dd434529b@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0626.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: a30238bc-f663-497d-93b5-08dd4180dad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W0FQlc4DIicyHUS4QIZARtAhrc9vnJ9aBWkQl3BN+wegZhs3WoY6DInondbu?=
 =?us-ascii?Q?cleEKunx0sePIZi8MgqheDxr8oIsWkAwmBfVRpO1l7wV6iTSngeQ9RNQbyZs?=
 =?us-ascii?Q?V8+6F9pIdBEfEcPT6Ulbb3JIKhi0BnGHHH443yO/ljV6v7hE7Set39YDKyH2?=
 =?us-ascii?Q?WVh0atq0qKt0bopHL1mGiO/aE0u9jAx8wrSfEwOGvhhYifFAO/f34DrkoaUM?=
 =?us-ascii?Q?LnE5UeNpGfiMNMN5LRJuHbHDomMF956RdrjYnzQC+z30CcEnVs+POM/rw/Q2?=
 =?us-ascii?Q?bYcLX3KfY0o9JAdXm4qwVW18qmfUqZpm2TbWjiRBrxvPbwzmiSZetrW+kCTt?=
 =?us-ascii?Q?SL7qI3Dus8FcUK8SVpxNbslcH7PvkqApXrxt7lrfHonwR/mYccqMTdItBGOW?=
 =?us-ascii?Q?YRZpQSRvaoHTiPAqajhxdFmAICY7gi0KngJDl9C4a+PLF5aPtlIqsAJaTIu0?=
 =?us-ascii?Q?CVnT/2rCUUrIR/xGnUeOPMn+5+s61ew8lliWxAKL3P+cRWvjcjroJXqnJdGA?=
 =?us-ascii?Q?xZGTA8c7vAG+puqh8UzHmAFbeBX09+/xkPBLY/s9Wqq6uTyv4VpgfvOaOzCf?=
 =?us-ascii?Q?ARBgx+i5z9/HhWWqKQQDhI1nXH8+iDruqRJNrD6pG37+Z46Zj1SIbS5i8mtR?=
 =?us-ascii?Q?gHj8a+ioxCnQY9k19fg+6lfY1mCQnCTNgRwVWkrOWuWiLXXnrlD/7gnZwa8d?=
 =?us-ascii?Q?vssRiSEcgNfmvW8G1EzuRZo0MbtWH7CJdSdexkTavQbcPHZLbxHGNI7igrs0?=
 =?us-ascii?Q?8bnxCm1QmDHXNjUsFoTQg3PecovrluaELjPonGlJXlISypcV7EfrjJRRpO6M?=
 =?us-ascii?Q?l/Z1F98q/YOx6Hi6YvflqRvjdFxIVhNjTU0Rvo6XR90qQ+N04k3rSDLH9tWM?=
 =?us-ascii?Q?PVEZEB+WVaIGa9VKXKI0943CM1FVwddqlS2epb7E4aJMMmXAFJyE66Na8eMI?=
 =?us-ascii?Q?MgZ3PX72HpuARQVNEtcyaieheCBOoPo74gqj4RvFfnV2WgfuMBI74SREmTAu?=
 =?us-ascii?Q?MqiY5pSVU9Z20d6gmFx4fi72X3KUEOErV7OmD9KTMDakQYOrBUajVM4YYg3y?=
 =?us-ascii?Q?CbZc1q2EPrqD3WNzlwZJp4ZEbe2fqDUMhdXox7PkkZrcVJb6w+bg3ix+b6hl?=
 =?us-ascii?Q?nc9GPOuzsjskxw3kHmzzuETPtHCBYyhTbbLsMiKRBDBnaO126QwrvZaTIKnF?=
 =?us-ascii?Q?7zCwEdalLAsctch3hKndg19r7oD70rxdIY3JD2Y3zq2/x99BMa21jJm9TUW2?=
 =?us-ascii?Q?dx8mNbWh1o5Y3AGdSoBhfT7+qAWsKhgrotkWrgYfHQebX2BXpERN/BXwwxVL?=
 =?us-ascii?Q?fYTO0UoSxtIeQi2YHaYUUFKwKHO4PBI0fnYDt+CJ0QGnxm423pt86TsFcD3p?=
 =?us-ascii?Q?CMfVSK0AcHzFQGZdijgqBfKBpP0D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vZhUYAl4KsV73UngiVyLxsmXG2sk33O0NOinRoEEuKcsXv01dq9yuAa8r95M?=
 =?us-ascii?Q?cHHgQ4N75QtERMY9w5YyBP5outuzsR3QfisLlx+EtnBysMyQeGcanhNH8Usc?=
 =?us-ascii?Q?4e25TfIIUZg0uu73p0JGResizJbp1YPYNQfiX87jb0AfHFIFfVRo1fnHYccP?=
 =?us-ascii?Q?KXIosl5xhZ7pjD1mn9y7WMlBoGKvUOuCR6zSp3+4x6r4uatf45COgRTARKOZ?=
 =?us-ascii?Q?czjmn4ScQ1LM++iAvfK526Fqz+75N5FIIwrS6dwfyoffn3T0d7OgldMKNEWg?=
 =?us-ascii?Q?JT8ZZ/VxUstidALVwNW82vdnhYrvKbbxS4KUqhN1OiWYG+KoX8lUZcEWC8pc?=
 =?us-ascii?Q?GB63mqKh3tYTKTamw22Px9IjwqvvZKaDgVonpI23WeYFQGMeIeROsHHeG85V?=
 =?us-ascii?Q?y/4lmxmTWyv5qja+E2XZ/0Z/Ts/COeEBViWCpcU/bPN9XVX24AVhxQPqG0GO?=
 =?us-ascii?Q?i/S2kl8nhVXD2vsm7PlEjAdWs8I1WxaUzAUAb2dSrpI4c5glSFSAy2+PV4n3?=
 =?us-ascii?Q?buR4WGpzz1UgAfAcToSm2ujaQSxB1bMZ1AflL/3MediqEbPtHJDz0BlNhMyP?=
 =?us-ascii?Q?G7qgktC9zamxNPsIB4hOWpDXboUtkDJZSQJPb86BJfqfnXsF1UHL0vv7E81E?=
 =?us-ascii?Q?57hI6almxsBs50ou9yyBFfSMTQqTNuMD2lB4xc8Ok6U9M25kArUk8AzOnHLM?=
 =?us-ascii?Q?RplQYrUE0/I0eRL5eAwzB+QHicPEFz+oAShlA1YiF2maGB5CKod4xElYJwoO?=
 =?us-ascii?Q?KjrMxGW7uNP/QjwFmUezyPDknqHJc7WZNpMpd09eYT2yIenxsQXrYw+RR1Nj?=
 =?us-ascii?Q?tyv3vEgQrZkM6phIBSn9zasPMxvlABbsE072QJelsyG5q37j6xK+oONiLbfS?=
 =?us-ascii?Q?N2SZGGn0JgpRnYdghkYnLRhB0DKOYi3heWkC+MJX0ZOxT+01D5wpaqo+Wj8m?=
 =?us-ascii?Q?0S4ZubTtoUVQAaJQPPQ8c3fjFf1Lb8n5n5dLmGceyM1vg9LYx/YXcYTz+KP1?=
 =?us-ascii?Q?QLCKaUiXVpz8quHQmNGpDGV3pkVPuPp8XNQgdcB0UYZsNQOOlp4Qq8QTCvOF?=
 =?us-ascii?Q?cj8DlXv0FgADQ3Qh1KPV2C7zEa45HHWQ8xaWarH3QILuEMFLaqJ9KAZvlx/y?=
 =?us-ascii?Q?w6KCto4OZsrJ9cz9RJYEPZUnkyXWrimH4R9lNtTbU2/LLvJ7QIcZThDgR948?=
 =?us-ascii?Q?IGY1gz8HMtR0xfidDy8Uz4LjNqZ5hWXfTSRrGIvwcy7zytT2Y4HDQ2hAokzW?=
 =?us-ascii?Q?VNMy2SVY4bb6OeD9LJmJ3v8L8z2Gz5U+A/d3q6RzZrUvvAus9wW9GTLFVgYm?=
 =?us-ascii?Q?qgRZb1N+A5XZ/9oCHgair5bu6GokotyVgE35Gbpasn0PmKfdzPpGQQ5zm+VD?=
 =?us-ascii?Q?r2CNV/IGn2ssMSOzp24vf8XA8pFSGLyh51dt4XJ7ba7aFzESQHwPe3TmfYm8?=
 =?us-ascii?Q?TQ5lv2NMGV6SSecwXSkOXcz5kXdxdYIJlljoZ/pMtuaUwldVwm2cOaEF5AYx?=
 =?us-ascii?Q?uLCtNV/yBbc0wmkDNWpKT1f5OlZ49OwuIpqu7RK/kPgS/rIdSGFdflZqFPpS?=
 =?us-ascii?Q?wlECIyjqaC9hhvfXldRt2PtIelwePREr5HQ55Om0CUExkA1PPfCXAnI5pW+w?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	er3p3P0q2wsCqrJ2hJMzfSZn+Al1AyNNHG/UDno1Ic2aVFXw64A9oND92DNsz5ymz/BlnFUgIh9NpwheBWbmOMpArzGRMXJggly0YF8LCGAn/yGycKU3SDtuvviGLvvYZ5u6/FQZ0aPVpuKS72H4lmubX9FopkLvzzGsHGny7CNy+PEmkWEssCbcWUzWqZONb5HQYHTjJ9uy/EHgWd6AJozOeE81jPi9/yV9w4zA+kXrI0eBbNUlqjrtcmJ3YmEFUPoPGRRLVMc4BOJJj2Fet873I3MQ/AReAmQMkv2C6f2muyXobKbQXuNABq7s8XfwOO0sV+1WvCSZLMqSp5KnugIJrOoFcFQw0+Mh+GcDhmkWy5ToQQX5cgRyR9s4dxLFrU8jarZuPDWUUhgK1pfp19y5UqYF0cFE/k/CFWhIrp2uAY0DN9+BwGG28C8H//iq2t6B0/atnFH7RQ3O7kON5b/1vwTC0xC0MacSLf8IPzkMeJ13THJHqu69Uf1BPHnybmPU5xvBT1CA4Z2fievh2g9+BXa3PhzWDPUH3R64Bl4GvazppC5KtYBD+dGAZEgNkF8E0GUQ/ga6AoS9MqO3113F76sYWGB8GgzwAigK/5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30238bc-f663-497d-93b5-08dd4180dad7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 22:53:04.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+V97EUKRSxelvHv4/Wm8kDQ+iQyq+knyRcN1tMluwviUgzf020jzUBDnKpgpjPyzK/XwUoxl6H6GyB/esSlvY5PuqxZVIaCBTllGFofFeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501300177
X-Proofpoint-ORIG-GUID: 36uB-ZsAgr9VOQphtRDsMSKw4B9l0LVx
X-Proofpoint-GUID: 36uB-ZsAgr9VOQphtRDsMSKw4B9l0LVx

On Thu, Jan 30, 2025 at 02:37:54PM -0800, Andrew Morton wrote:
> On Thu, 30 Jan 2025 20:40:25 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > If you wish to utilise a pidfd interface to refer to the current process or
> > thread it is rather cumbersome, requiring something like:
> >
> > 	int pidfd = pidfd_open(getpid(), 0 or PIDFD_THREAD);
> >
> > 	...
> >
> > 	close(pidfd);
> >
> > Or the equivalent call opening /proc/self. It is more convenient to use a
> > sentinel value to indicate to an interface that accepts a pidfd that we
> > simply wish to refer to the current process thread.
> >
>
> The above code sequence doesn't seem at all onerous.  I'm not
> understanding why it's worth altering the kernel to permit this little
> shortcut?

In practice it adds quite a bit of overhead for something that whatever
mechanism is using the pidfd can avoid.

It was specifically intended for a real case of utilising
process_madvise(), using the newly extended ability to batch _any_
madvise() operations for the current process, like:

	if (process_madvise(PIDFD_SELF, iovec, 10, MADV_GUARD_INSTALL, 0)) {
	    ... error handling ...
	}

vs.

	pid_t pid = getpid();
	int pidfd = pidfd_open(pid, PIDFD_THREAD);

	if (pidfd < 0) {
	   ... error handling ...
	}

	if (process_madvise(PIDFD_SELF, iovec, 10, MADV_GUARD_INSTALL, 0)) {
	   ... cleanup pidfd ...
	   ... error handling ...
	}

	...

	... cleanup pidfd ...

So in practice, it's actually a lot more ceremony and noise. Suren has been
working with this code in practice and found this to be useful.

The suggestion to embed it as PIDFD_SELF rather than to pass it as a
process_madvise() flag was made on the original series where I extended its
functionality.

So in practice I think it's onerous enough to justify this, plus it allows
for a more fluent use of pidfd's in other cases where one is referring to
the same process/thread, to the extent that I've seen people commenting on
supporting it while sending series relating to pidfd.

Also Christian and others appear to support this idea.

