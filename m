Return-Path: <linux-fsdevel+bounces-34019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA4F9C1F37
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 15:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6CC1F24622
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C71F4704;
	Fri,  8 Nov 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aWj2Zg0Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZDd1vjGF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655D1E0B66;
	Fri,  8 Nov 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076129; cv=fail; b=Wtor7PnY4gLxJQl7Zz7ARfH0W/Dsb7CuhktB7Ip3nH3F/Lmds898ViL/9fKKLtQ7FVpkEkeMfItiZC9a7r4OqZ+bhOuotQxYN/Kqy7UXkLQK47JoMhhGSMTxiH5LeAMZB1amHcFBo0Pg8N6tZVdKbzcuX4QgohrCiXf6aNlplRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076129; c=relaxed/simple;
	bh=MNPcgOoI5ka2qwommg1DxKB4+RyHlVslO8gTgGGouRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G6sc64+Q84T52f4nAPLFeidGB30nYxRCN94XN2E+ITsAZpEpisJNkt2RbrtzE95wm8VbvCcnoipnR86VO02MdeHULKxoXA0YooYhqr00DwKHaesq0OKoguv0gI2cd8PxmaOvCmElFUvMGF0x38N3nenZGKoJw7QzXLcbQ2NrdJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aWj2Zg0Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZDd1vjGF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8EBb4v022689;
	Fri, 8 Nov 2024 14:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=QikjxrBEgF5MO3fpTu
	1nWAGICxAZfIjKgeHAW1p+7Yk=; b=aWj2Zg0ZWHZfievhtwKJQIwti7TVcaGMMu
	dLH+TTIHAKYdc8iDUGVL6pxF2in+KLPFfbcT2x79z9UyP5mZp/y8MiGLZgTZXLt0
	nFLdXCOwMRBkVy/XQdINdh9YzSnl+A1K8r3pHCChiH9Bf1swzyCyhoVAuBhx/wpl
	fCpmDFdA65n1m0e5GNEJhNvUiFASCPn8ctorgLcmkQkBFlsZXiLzQlaYwdv00ekU
	NwgBdIAwzfIIzJD9BIwCPFOgPu+1wvUXeDA3ruq8v/tejx1Wsq6NrZw0AYS9ELmO
	2v5cVkNHRnKZXaReO9Xq09q7M0QnTDupxOq17vLnz+ICJjxAy+HQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gkhmjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 14:28:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8D6FgX004960;
	Fri, 8 Nov 2024 14:28:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87evhem-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 14:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtQX5alM9xWal6picyOX/aP0CnFA0YSIoQNV1zSLffVOxaZ1hSeiY27N0wcOE6MfPUCPIoaUEOIhHeOWtbV2JblvWr/BoRwmgzHk/No0/9YcdpXEoJvKqzgd4iOFo0P80Rsrkz8QzA09Y/ouP4HW0dPYuqxBWuXwbr0uIQnTUz5jY87yee8m8tlOFAb86j0HdTryd3W4mSGNvFQOrh2zbv8Nc5MluLdhnyOjGDpJWV4N2i7C4E8P3bTREmVPjY1EXdkrk7JNhfdF3dU/slbxLjbvQstldAi5Dq+fDB7CtFBZzR1CCgWWGpzBKl9jPObsm/iWjRfN22Qr5vdU4+sN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QikjxrBEgF5MO3fpTu1nWAGICxAZfIjKgeHAW1p+7Yk=;
 b=QTEh/Y2yfFM0EZ22dk2dqte543niJM8OR2kzhjWmpxZw7c27gFdxKAqla+ut/nVBQSnjVGytmtPE9IzLeVVlT5lPB6RrY33U+54jzbRp9B1KVIKfpIV2IFm9qptl/IUadyvMk2grgs/Z5k4yBvc35DQ81gBYmiTKkUyBSD+hX/jZ0jBvB/A0Qdo2fbgIwsVp+/kWouPO3+wJIt1QhjHGo6npaGZgICpLyYuVCS5MFBsyFlBs6c1UZ+XZnEKhUtqymKjUkwUU9utkUuNpCrTWtwSMffU9pcU6/GLS/z4097nmNyfefQ/Ud9zQYlbvqs02zFWnJzEsFCqH0M9fQ3IHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QikjxrBEgF5MO3fpTu1nWAGICxAZfIjKgeHAW1p+7Yk=;
 b=ZDd1vjGF9TPSQ84wf0jXUh3odtwcisaFPgwgyZCkVRkfau4OI6dxm3LUlCIsjcUK0FqgSEvf2dsF7BrjNZKz0QgAE6vaveLlCR0IhQ6KVLBxmMreQ5dk284LSKh5Buk+M5XrTiHezwXNx6iBYbFDqxEiBYUBRA+QN8bfxLGNXk8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7717.namprd10.prod.outlook.com (2603:10b6:510:308::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 14:28:17 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 14:28:17 +0000
Date: Fri, 8 Nov 2024 14:28:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <55764300-1b53-4d14-99cc-e735d3704713@lucifer.local>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
 <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
 <20241028-gesoffen-drehmoment-5314faba9731@brauner>
 <c96df57a-fa1b-4301-9556-94a6b8c93a31@lucifer.local>
 <b8f4664c-b8f0-46ca-b9a3-8d73e398b5ca@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f4664c-b8f0-46ca-b9a3-8d73e398b5ca@lucifer.local>
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9b1ba7-b7ff-44cf-8407-08dd0001964b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBYltl5fFxSyrYWL/KVupwjo1wnXAj2qdTx+eAkAd7pC10IEcNLOWeRQHhUj?=
 =?us-ascii?Q?33e9zWDNz4mpZsmLOJlSUHadrbR9zKaaopMy6R+VyUqgPJ5/xJED1MdqlnUU?=
 =?us-ascii?Q?jZ3NG8yPSYCeP/5C5mqEbV11FRh/sbaT4o46CT4PI734EjgSgZliNgQEfqaM?=
 =?us-ascii?Q?1IfIq88Uy419Aqc7YD1JE4KIoiU+LjqxmXpwcvPm0cr084H9jsycDSqc0a3Q?=
 =?us-ascii?Q?KzkrXHEZCuOWEdcoaFPE44fzvBeo2g7XJW8CHtfZbzOHPorMCBuR7DZYclSI?=
 =?us-ascii?Q?+FvXW4xmYrExPbkFUIK92P8J6Ec4iCc3UGQB+UdfLYrwtdfhNbGVG9uRu5MU?=
 =?us-ascii?Q?wChPVZRZ/bn/bIucjs/NbTzP1pPkkG6Fp0mxkXPy8SxV/f1Z0mUwfQ1riUGi?=
 =?us-ascii?Q?Kj3LNbzCy1WVb6t5Vlt2qc1l4uyPaAWgCA4jOQFrGgMb88uFVmI6Mg0lQbD5?=
 =?us-ascii?Q?wtgozpF9DNGnFRg2Ynwn6/CRl5n+BnGDAjZXgRj6wZyam65OQCcC9xjto7aN?=
 =?us-ascii?Q?tYC+ZOFCvs4o58eOqa1fDK8iloVORIYHeN/YmihFNRo9AoDmSZzrmlm7ByyL?=
 =?us-ascii?Q?mZHsCZLj7yx4E3fYQIdu+MpiX/mqXwtWJ7Qff/g7S5nprcO/x0p47QAanyMz?=
 =?us-ascii?Q?4uT1qJUsBT2f0EcjX7mXdwdLhJcSKZ+63WAHfF6ApKhQzXJQvQmy1ZU5kI4+?=
 =?us-ascii?Q?xCmf3mKCWbfJpVO9xAIfwwcT/ngABeh6/P7/p1R0KwkuF5YaG+K/pfxBaeBC?=
 =?us-ascii?Q?SPcqwX+PhHghxghb64rxP7gvI5bbPdmHlbfuOeOl/WRxF6yd5EGsNctwpaJz?=
 =?us-ascii?Q?ABXpVV2S5MD/iBqGWLWbOI6nsUm0pugeMsNlKmQ5ndOsF2eRVsYIv8MrlnLp?=
 =?us-ascii?Q?bWXvWmBmMAnIkT3OQZ2JoZGoKd7dTfamTgHAcMWSnQ1Ej175iEhY1GmFd/sy?=
 =?us-ascii?Q?hGLymTuS5MDNEcT0HnOJtDUibdi6NT+5UW8/sVXlJTA5PTdVm50ZUEqkAwon?=
 =?us-ascii?Q?nlHZIKe7UBsWrsRbV2uuE3bj4ZAYfJTodhlcKECiUShNCUHuD/RE+0qmLoUW?=
 =?us-ascii?Q?bK/wRJ5UE2pb2NxhF1YNByTc6CcFjwkpIcsoLGhy730pgMXoyr7CGoAqg7ZE?=
 =?us-ascii?Q?gRfyWS7gHvM7QApSp47Kel3RX32Vr3uUTif7h/lCQDF5cKh2QPDptc/MLHon?=
 =?us-ascii?Q?H5hfGwt28at7UWilx6nfn1P8nS5P/6z0HmpvKOzCDa033OUKJRs6pcFriB1T?=
 =?us-ascii?Q?ntinRK6BVw0+o/5uqAdMZMW87sx3WOqTFniYDdJAHZ/eFM0CiFaEJq6EI3mA?=
 =?us-ascii?Q?5y0k+mkoxhsR69viMOGYlOXj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wg1mKObycaHXFZ3ZUNcyo/97g8Ge+vfXHJOfV8s2kK1Id9cZQh7Q93h4KTqI?=
 =?us-ascii?Q?ZA001LA/4BoPWyF5DvfKOcMBHXNHs/XOrlNAi+ELRKqejK6vI+9hAthylTyi?=
 =?us-ascii?Q?SZ7xEDoN2lmIFkiHKA31Qb5+cI7nC+MK0jq7V+GFK9mHaoKpex7k3wz75Ej/?=
 =?us-ascii?Q?VmVmY0bkzgDU9j08ql+8SFEx+HaoAOfihQL5duMLIFI3jlK1HzF6VCeBajUK?=
 =?us-ascii?Q?UyVEvKoTqpNhkkzRlfI/X1HcM9M/9hqAXFkPmYAe0UbNI78GlV8gdtr9X4c0?=
 =?us-ascii?Q?agFxVZBUcZEU6I/EbNkC96QlEdi77ljjI+Ql7tsbEi9UxypCfnW5gi2v/bqW?=
 =?us-ascii?Q?88Cdb5h1GFylQOnYKPHjQGOs+Hf2peoCMf4UQa3oc97P+f/tdCQxo8JTLInd?=
 =?us-ascii?Q?uy8ixakgNe60I+7jf86MEVuw9ZCXgRQ0yn7TMwjPmK9kPjv+vnln8px1chiu?=
 =?us-ascii?Q?uVDFUYJJhDiyQDPWNl2n+Y4RqL7Ux/zLpC+VOe/Rg4L7FvstOAJH7EqW7bNF?=
 =?us-ascii?Q?O1LioSEQJStFkPlqjuBhy0M02Lh+hx2bLjlfP8xaLEuTUPiEEa7T+4qnzEfN?=
 =?us-ascii?Q?txPg066thq4wdg0X42RlUlwmGxtjsJ6F/8ROtjadZ6aKjpGXtW/+FlzeaMuf?=
 =?us-ascii?Q?L6LyKHDQlypkAYyWMlLi8Sd0/kvbqfND11s0hNN7nFvOqpWIM+WiyoTNWYPB?=
 =?us-ascii?Q?3kwwIm85QPhd/5X4XljA6ONOedAsXNxoBXXeYGXLt4BisO/7Vy3eJfvKtBlz?=
 =?us-ascii?Q?qESJ32U41Ghi8akVqVeNZsIAm4ZS/ePTS4u3jruM2r8LLezLoNN9jxvkog4f?=
 =?us-ascii?Q?P0435CwAwDPyWv7c8QtMFtplBy52Ji/HTmYrDPy+o6tcyXJpZDucS6K7ejSF?=
 =?us-ascii?Q?2QvAFN5G63rpRMO9nLcCT1AHHiAYtFS0pnLhVA1Pa2Y/PLiaDxl/eeDHtHZd?=
 =?us-ascii?Q?fc46WM4O2pKiENJL6u+4vbWC1kYHAjPu2rJA1NGktYPx+KU2HTibOAJ0RuXl?=
 =?us-ascii?Q?07kwq7iTSe/ilxwuiXNMJSGFrtzowUG70cOqB68uyX0xVAmLoow4s9PqYG4A?=
 =?us-ascii?Q?642KPwNqJ5oXD/hjui/ZDB+48iqezq4C+qqfTrzbog8/8rX0Wg8uV2uuQ1K3?=
 =?us-ascii?Q?iE1Nnb5DUHnLmF/KpToSIhaAGI1T4kKySrAEw2YbsIJz9G0BcJaZDuhELjVp?=
 =?us-ascii?Q?2DEfzADUqeO07Bq7LeDy5A2nub1QZjCGQbC+04MTwkPd5cJo8xVA+dePeR3Z?=
 =?us-ascii?Q?K8lP4tHCwEujyqgHDifGbOPz+EIScyOliWM/+NsrOvyzqYH349CS4Ujcj1x1?=
 =?us-ascii?Q?t8F1ov9OsaV8W5Q2t8ULLoGw5c0iPSq/gUIJM5sYA+m9nIEOxz98LB35AeUi?=
 =?us-ascii?Q?BuQMlCiFjHVBzPbMASHGqKpjd4rIbESyLwyagA8gJrlrxnnvpatepDZ29sG4?=
 =?us-ascii?Q?X+6WVSonJs5lbwa6+IPMqtDuSNJ+L6SFjCPdcy0+Nm6XCsUnF1W933TALGAW?=
 =?us-ascii?Q?VzhHKH53yIUsb5YcyQGjSaYdM5KGnsN2BPdBxAv8QmCmNy6wF4a6Ch+3WnJw?=
 =?us-ascii?Q?fIlRdvFukt0tk6Cf4JEjwMv/jDS4OO72rPmk1YKJYAUHkbSAg5SmD1OiGewt?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OwsWO2xHJ/G0D7tpMPwPrxUyt5SBbfcF2PXLVPlYbUcaUrH70cMdTyDVXBsNVopBt7HKA/lrNUk+WtHIhT+JuOVXGor1PbiRqf1UfUNa+XLfVacgSuXeEG3wjqNizzIEw++uO+Ha6283CiN1Ci6lW3bkrRegUUcB7jPYI+kGHCDmEA9UFHx/K9nTIWfi5XCOMjYyApupzi8ynpByxSPlQoyiEsAlWuu8OQVqecIsQKkI1b/wnbuqyRe+csKCm5Vnv7+B9lTL/v3WO/+WQNmLQOnYkYlcGK7ppCqVm8U9Qtg4pr53etZTOd9vWUD0XYYWlY1ClTaw/fOGj7n6i6J1OgKFIbV5IfrUGcBQG/TPtlD4A2kkmDiSxC9YA461Bof5/zdaCjBkusUxhos9q3GQEyjQhOsISRnMSMTjsD7re8xOMZ+j9UQGTBw1JvjWrbrEcC6R3ggRN+qLMKH/pMdDiJf8jdlTGfI4pA2XP/uldunFvXU+QzTcDVlMlLMwaYHz8nIE+ZJ/cu4p29+3XVGlQ+GlHZQflh7cpxfJ6FiqmPQ3+QwUYl3PfYA30rPQ8N/iaBmxfYNJvTUk8UvXKYfQnvIxyTzE7r2trubQmqdTmXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9b1ba7-b7ff-44cf-8407-08dd0001964b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 14:28:17.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdkN4SsU9BlCxXP5tOaJmPblTJG/YzjLaANeIbCrP6p9bNuziGIXERLAMYd/2lxnLPVzjoXWPY/YFGKJOR8/8L5gTnxZ9+uAxa6zWXFWW2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_12,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080121
X-Proofpoint-GUID: wlSXyZ6MA__d5IR6gfcv9cmHf-Yg5qN9
X-Proofpoint-ORIG-GUID: wlSXyZ6MA__d5IR6gfcv9cmHf-Yg5qN9

On Wed, Oct 30, 2024 at 04:37:37PM +0000, Lorenzo Stoakes wrote:
> On Mon, Oct 28, 2024 at 04:06:07PM +0000, Lorenzo Stoakes wrote:
> > I guess I'll try to adapt that and respin a v7 when I get a chance.
>
> Hm looking at this draft patch, it seems like a total rework of pidfd's
> across the board right (now all pidfd's will need to be converted to
> pid_fd)? Correct me if I'm wrong.
>
> If only for the signal case, it seems like overkill to define a whole
> pid_fd and to use this CLASS() wrapper just for this one instance.
>
> If the intent is to convert _all_ pidfd's to use this type, it feels really
> out of scope for this series and I think we'd probably instead want to go
> off and do that as a separate series and put this on hold until that is
> done.
>
> If instead you mean that we ought to do something like this just for the
> signal case, it feels like it'd be quite a bit of extra abstraction just
> used in this one case but nowhere else, I think if you did an abstraction
> like this it would _have_ to be across the board right?
>
> I agree that the issue is with this one signal case that pins only the fd
> (rather than this pid) where this 'pinning' doesn't _necessary_ mess around
> with reference counts.
>
> So we definitely must address this, but the issue you had with the first
> approach was that I think (correct me if I'm wrong) I was passing a pointer
> to a struct fd which is not permitted right?
>
> Could we pass the struct fd by value to avoid this? I think we'd have to
> unfortunately special-case this and probably duplicate some code which is a
> pity as I liked the idea of abstracting everything to one place, but we can
> obviously do that.
>
> So I guess to TL;DR it, the options are:
>
> 1. Implement pid_fd everywhere, in which case I will leave off on
>    this series and I guess, if I have time I could look at trying to
>    implement that or perhaps you'd prefer to?
>
> 2. We are good for the sake of this series to special-case a pidfd_to_pid()
>    implementation (used only by the pidfd_send_signal() syscall)
>
> 3. Something else, or I am misunderstanding your point :)
>
> Let me know how you want me to proceed on this as we're at v6 already and I
> want to be _really_ sure I'm doing what you want here.
>
> Thanks!

Hi Christian,

Just a gentle nudge on this - as I need some guidance in order to know how
to move the series forwards.

Obviously no rush if your workload is high at the moment as this is pretty
low priority, but just in case you missed it :)

Thanks, Lorenzo

