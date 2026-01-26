Return-Path: <linux-fsdevel+bounces-75529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCaVBtPPd2mxlQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:34:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84778D1B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6196D3006112
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A9F2D6E6B;
	Mon, 26 Jan 2026 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PSdUUqe5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mmcuB22y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB282BEFEE;
	Mon, 26 Jan 2026 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459663; cv=fail; b=LpZbQu/dslHTwjkQ5c1cVI3bajlED5p4kU/ab+Z3LbYoNAlo9kcbj16AMq/1zkWyAiUmOxmD2winmQxeOm9k2PqVaP3f3wE91xpgL2rfdWvyZiFTFiozZZu+46KHkrGWTwFFit1oeagcaM8V5zOBDCEKoxzuczym8/csOb4PkyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459663; c=relaxed/simple;
	bh=fm8lPi1CWRRVGscwCiPyibAYjRdmswh51JbV0pGed/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7SkouVgrzjK5F2NWHQS1wZ07ulxM3UdwNCJjEa3ZwtCQBV2wJmTe0L8fzh71H3tqKsF9fSRMnZbvImQii2+/yeEI9I77tOX2BMegSPAgLKIPGzi54KG/uvfu7/eAp+AshYcPMTM+TEq9z4hsXZCFzVr/0b73bgm6ilkngMs+Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PSdUUqe5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mmcuB22y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QGW43X1146617;
	Mon, 26 Jan 2026 20:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6AX/E4I9fNjHrn1Nn/G19JUI+1aPym9Iy4xHh6yPUCI=; b=
	PSdUUqe57dHG2PS6qm4fdXMlemSfB8/NlDJiR9M75MDndfYpTmoZcupJYbs4Znof
	Eamxp3x2feU/tIT3pKEWC7tobUaUDTPvpRbpAEdPu5vDcNdt2oR6A6wBwxJ7K16n
	PUkMHCDK78xnRlNXNKv6aIg2w3HO1XBVq7vWO6fwzLLnvr2pyX/MXmvzULddp4Qf
	5GO7a5VIA50VPfTBL5okMZ8HNdneMvRpEep8uiBXzU4kIfpbTqvwpIxkk+Mz946m
	wCbVHrw4zCVXU+VWTwUYOPateVmniTvMVsw2ZBglbzq3HVjoMQL+VvZk5qds3gIw
	S4uV9+B+46xHCML5AImjJw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvp4btthq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 20:34:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QKCsdY010792;
	Mon, 26 Jan 2026 20:34:06 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh8fk5p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 20:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuJkpjWrwpEYQZeKENb6k3NSDN+28JOcAm0s2dGQ3djHhcAfrfjZEQUOkW4JDMXzKWywflMwbdOVrRR/Z7o/jpMxYCxqOvkrvyzhOV+HW8sPHCAiR8M+eDajLYfm/67RK1dANeDjELV3aVl/O/MvZSEpYwH6LPDljEX5Lm7BxzZr1Oq+6e+7FF8r7vWAALN5ofIRvq0UNB8Sihc0/e8WBVP1koj5GQsop/TNH437RNHcOWJQ6U5Zjjg2JDWeWgzHS1andD2tZcbHjAURpX2OYDT+AQt/1IqkKI0ONqhSaVB9VXSsnq6WHNIZ5zH1r8i13zXKAIh4akI4dHKL+of5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AX/E4I9fNjHrn1Nn/G19JUI+1aPym9Iy4xHh6yPUCI=;
 b=HkqrwY+95iYi21wQd3VGcwhuPehypAA8UTs1SrKY1tSwi7Jnm1ILHI/y8lXSCM2V0HZjlN53ja+8y8Wl9yPmRCXG+/850fNc8v24UbS8ruKrTY2PEa8xNgPId+yC8oj4UKLULwfDFfm9+ZxJslGsRiqt09KSaEkC8qczhO9u5kL8cncSJ8qVerhZhFXpGf3JwPMrldFagC8aoBBnUrBAGIonXxvgXEKHAM1GAlxY1feVTlsiSdxD9uXjUA0MckfmM4NkCAqYG6mCB6UoySEWZzgsFV/gTsmHvncGUGLrsljNmIa/iy//l1n0/LoN3gTITIAD06YGv4WdVipEaxU77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AX/E4I9fNjHrn1Nn/G19JUI+1aPym9Iy4xHh6yPUCI=;
 b=mmcuB22yA4gm27l/xSNnEQ6hcU9IbzTqy/1KQRafzhFBDpvtdQc2uiTNymxo9jiT5O3IPk4X8udkbCYZ+Dd/b1GTBUfZIh9K6ih16Bs+5uphBcC36i4aVXjaXakEEi5aA0IBWZZ7ETMYUMVbdqjB1y3X7nnAnfl3nQV30X6ZoKk=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MN2PR10MB4127.namprd10.prod.outlook.com (2603:10b6:208:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 20:34:02 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 20:34:02 +0000
Message-ID: <075db2a1-5cbf-4484-9ecc-57e2fef3c45c@oracle.com>
Date: Mon, 26 Jan 2026 12:33:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260125222129.3855915-1-dai.ngo@oracle.com>
 <4cd265054051f11047276c225c70516bdcc4d8d2.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <4cd265054051f11047276c225c70516bdcc4d8d2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:510:f::24) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MN2PR10MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0633f9-c7b6-4e44-abf5-08de5d1a3daf
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QXMvNVdWOVF5RHJIYkN2clpJelpMbjFMK0M2NHh4eFhtVy91MGNUeUF3Yngv?=
 =?utf-8?B?bGpxQXRtYW1PMGVFS0dQa0VNeUZXdXh6dDRqMHpoS1hGeVROR2ZJSThXdXFJ?=
 =?utf-8?B?eXhSdGp6SjlIcXdFZGY4SHdXanBnTzE2Zld6M3FpYnlNTFlJQ2VPbUREdTRv?=
 =?utf-8?B?S0VWYWFCVUVaU1V6K0dzOCswQThxUTlOdXZWOVFINE1WTG8xcWhHbkNLS1Q0?=
 =?utf-8?B?bTl5di96SUNOU2ZkSXJFTmc4Z2RKM1NPTUltOHJMMVEvd0lLQzd6K2ljYzRp?=
 =?utf-8?B?KzZNdDEzNWx6N0lldElLdjgvN2VsbisxcU9YcDkycGF0OE5jSFlTYWh5dXVa?=
 =?utf-8?B?NVNQeHJhSHpEbytBWEVZS0czdkRuRWhMVTNyZ3pzKzhXeWJ1ZW83U2JZTzlt?=
 =?utf-8?B?a1htUjZTNWYxb3ozMlcyNmNSZkN3a3BZTTN3SzV3LzN4K2dFMjgvSEFNMDJI?=
 =?utf-8?B?bXJRYmwwQllmTUVpRnpmc0NjY1JNTTZHQXdwOEFiUnpLMW9scXRkMVBGTU1G?=
 =?utf-8?B?QWI4U1gwbUJuQ09TVGV4Szdzd0x2MEVLMWhvTDdiNlZ2V1ZQUGNYUGFNTlRo?=
 =?utf-8?B?TlRPVHI1b1NKUTluSk1odnVGREs2VTUrdXROY0EycURVN2ViSjBWMG9ZUWgv?=
 =?utf-8?B?aVgxRXJhSjJqV1E3RUVzSzN0K0dNQlBmZm80QzVNRWRvUzNyanZuVFVuZXlt?=
 =?utf-8?B?cFFlRk1hRk92RnppK3dvSFhSUnBEUkRxWEF3dnJ5QjJMVWZJbUN5Q0RXdG9k?=
 =?utf-8?B?QVBMNlZtZEFHcjM1aUhIQ2hnb3g0YU1xUnQ5eDdxKzN0NlVjQ2tJdDZEM1Y1?=
 =?utf-8?B?MC95bUFtOGc3dlUxdTRDVTVHYzg5YnVhSDVqS3JSVlZ5Q2JiUlBoMkwvcjZm?=
 =?utf-8?B?RjJBa2QzQ0FTUlc4VHhnZmtNZ1ZpYUN2b1NvTXFWVWEwU3QrZmhiOHFMMUZk?=
 =?utf-8?B?VFJlN1lZNHZZNjVGa1JHcWFFZnMraGtKQVk4THFPNG9JemhlMGxDbmp5a3Q5?=
 =?utf-8?B?Q1pGRXNncFh5VCthWjc5anFoRk9LVkhmM2kxTnZrdnViSUFZSmo2OHBTY3hL?=
 =?utf-8?B?UWhQMEZpR1hQbElWQjZDYk1oRGI2dStCKys0dXpPOGxVV2h2aEJEYlEwTzhB?=
 =?utf-8?B?N3h3ckt6bVVsbTBBRERnZnc4VjlZUGhkSnRmUG1CQzRaMmMzUzRGSDNpcUFj?=
 =?utf-8?B?OVJPZERIeXpSTGhKRXU5V0ZWZ0JmNzFpVHBTTTZKQWhiT1hSa29NYlZsSzNk?=
 =?utf-8?B?Q2l0OVQxN0p6K1Q4TzR1cjd6WnlUMlR6QXNRTFNQRkpkRDAvY3RCNkwvODlx?=
 =?utf-8?B?dkd2b2hrbVJZWlpwY202d0Fnc25hbmFIakVwaFRJQXVSVksxYi9GMjJoT2l0?=
 =?utf-8?B?bDlYZTdHNXJjYWhHbDZYNHJoS3N4eUlUWnROdE0wK0pSM2VaRkdUOFR5bWVm?=
 =?utf-8?B?Nk5POG8yUlkybkdjcnV4QkRjV2o2YTg4OGVTMzFFajl6MktNU25BNHd4Qlh6?=
 =?utf-8?B?RWEvYnF3Z2o4eGRaNHNOekpQWHdxNDVqQ3cyTVVPTnhwQ3RmeTZnTitBSkJU?=
 =?utf-8?B?TXluaDNBUjJZZFo1S1UxSERVZVJ1VTQxUDAwd3N6OUFvRUhnOVZpYmhGendx?=
 =?utf-8?B?TWc0K2NJbkkzV0hiTG5hN2pBUURKTlQ2OThBUUdyaHFiUE5XL0Z3WE1JVTBS?=
 =?utf-8?B?UDJWWlJCeHVZdWVIc3V5S0U4Ry9iK0NVdUZCd2h4Zk9NMnhBTVVkTE5TQTgw?=
 =?utf-8?B?bWx2Tit2d3U3TFBlelpBSlFyaVdZNkd5WVduQzZodG5odWVFVEVsVWVXWVNp?=
 =?utf-8?B?QkMrSGNwZTh1RWsxdXk2RnFpV0t0RlNXNGx0OFkycjZQelhWbXBpRDhsUlJi?=
 =?utf-8?B?c2lKdDV2VHJYSmhyNWFGaUQxMTFURC9pNkNWbHh2UVNqQmhaZzNwWXhTUTNZ?=
 =?utf-8?B?YmUvNjlQSW1oenJUYW05ZU1DdlcvUUdTcDJXNWJGUkdkb2Mwb0ExRHNQS2dN?=
 =?utf-8?B?S0xLeGxRenNOYWRSVjVxMXN1RHpUaEp5U1hhMUtkTzFLazZsM09YZHludEM4?=
 =?utf-8?B?a2dBVkJmZTVMd2djNzc1MGlLaTdwZ3RkTlFnMW1iaDRYK3M4aWd3NWV4MXY0?=
 =?utf-8?B?NEJkWFp1bzhoTjlYSTN4bWw5aFNZaWpaSW8zOTBxZ2htdjFnbFRHMlI5SXB3?=
 =?utf-8?B?bHc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M0kxd2I2Z25jSkltOWY1enJjUGp4NDlYWXBnZTYvK1VqVWUyYkxybDZmak9y?=
 =?utf-8?B?MW5LbS8xT1pIeFY5UEtKMUN5bDBoeVhWNzZpa3AxRjlsRGRrQzR2K25qUHhs?=
 =?utf-8?B?dk5CanhYWngwUEF5MHVCS2g4SVBHZnRtdHBxTjY2MnFPcTBFdTFUN3A3aHNq?=
 =?utf-8?B?MU1NWGpZeGE2WnNtRG9oTTdNQXh2NzRDeDJ2Z21Ba0hDaFJBWGJ3VDFQdVhp?=
 =?utf-8?B?NklJU25BeWR3YlZVZGNIbHdpS0ZiOGNET1FIeW9PRExNR3ZUM0ZYZTRnZlJv?=
 =?utf-8?B?UU5lelZ1aTVYU05XeDIvNTFEeXNpYUZUSmY4T0lTRGNTemkzYTlUbzFkc1Iy?=
 =?utf-8?B?My92bnRqWVZHUkFiRWRBVU03Q2l2UkxyY2szR1VHbDZoejhqa3EyUUxLdmlU?=
 =?utf-8?B?SlFhMXVPQ0xJZW1rTjRyRTFiUWpIaXowNlUzeGNvU3hkY3ZRZXg5VUxWYWRZ?=
 =?utf-8?B?V2ZRUjVNSzVBMlg3WXJtUDFaMUJNVUhrVk1pYlZqa3BqdVU3ZXNuZzJwS05P?=
 =?utf-8?B?eERzNWNLa1RhRktEQU1JREhrRkJKWHhHQWtPRW5vVkRBM1QyZHl3YUVzYnFX?=
 =?utf-8?B?eG1XMUpHbzVIZkpLTGkrZW5BNGlhczNyOXA3Vy9UR0ZmeXFFUWpKUkJ6RUx6?=
 =?utf-8?B?bTlzZWVvRGtBakJkV3F2RUpoTjV3bDM5N2lGQWwvcVAvelYvaHVuclBKNVhh?=
 =?utf-8?B?akxqWTlZem0rc1RqZmtpTXdYNDdJR3pwTXRUUklNR0c2OGJiMnNSWEVpWUlt?=
 =?utf-8?B?a2drY2tpanB0WnZsZHBFU2tjRDdZZUFVNTRyZFdjQys5SU52NnF3bTRGY3d3?=
 =?utf-8?B?TU8zck5pc3dqY2pBd0tGVHRvY3NYdGdOd1MzRkdoZW1iNEVGaU1qNjZ1YVVH?=
 =?utf-8?B?UXo4ZnFFbmRTQWZZc005OEdlRWVKQlA3VFArMUhlNXA0RVZMSjBDSWlCS2tN?=
 =?utf-8?B?aXhZVTJsMGFYN3k3dFM1R2cwR2NZUXpCb2RxS2V3OGV6ZFoxYWRqeVc5MEk1?=
 =?utf-8?B?bVpIN3VmQ05JbGY4ZlJWL1hHWE9sSWNiQ1BIcGNvSGQ1Z2R4WG9xOEFDSjMw?=
 =?utf-8?B?dFd2b1I0SHdhbHpHQUFJSWo1RWVCa29BZVJqR0R5dVhzQm1haTVlVnVoVElj?=
 =?utf-8?B?dUpHMGR1bkhsbXNmc2VUZUtzbVZmRE85Q0U2bjcrbTVjSDZBM3pHN29XWmEz?=
 =?utf-8?B?dERicElKMk5vaHVIdDBKV20xK3dlSklVcVhiOWdzUEhPOExpT0dFUzJuQmc5?=
 =?utf-8?B?ZFJHYkZTdGpyVU1BSFFkcjR6QUwzSGRQL3MyaFd1TFNzbmNwRmVBS3dFb09s?=
 =?utf-8?B?eW1GalhlMTVXZGwzc3FKeWU4Uk1IdTI5M2FtemEwS2ZyajdOYk45UEZRTzQ1?=
 =?utf-8?B?akxzRTBMMDhZR2RPaFB4a2FnQVkyWWdDMzBYQTNUNHh2bGF3WWxwRFZ1NzlQ?=
 =?utf-8?B?VlY5MVozemVhTldlaWxkbUNTOUhKclhxZlRhSDVNRTdtTVE3aGs4czZYUWd0?=
 =?utf-8?B?TVRBa0tZVis3dWI1ZjVlVXh4V0VuZERVZlY3TmFBR0J2LzdrVHYrVDFORjlu?=
 =?utf-8?B?QS9rLzJKSWc5QzdSbTJHQ2JJbGVDc3llYnFFK0cxUHl5bmpDMytnbk16Tkpw?=
 =?utf-8?B?YmwxemRuZ0c0b3NzMTAwN2Y1ODQrN1pUQVdaY2RLbjdFeVE0QllJTEJxbHov?=
 =?utf-8?B?eW4vWEpxVVRDWnIxR2wwV1M5ZGk2K1pJY21Ga3V5UmNoNmp5bmlMY1RmTTBu?=
 =?utf-8?B?dW5KVllIbHZOUmNGQmtsYmNlWTB3clJKcnhBcWtUTHlULzBjVHNEV2trTzFS?=
 =?utf-8?B?cnI3SWY5czh2dlpRcVlnWGIrK1plUXFUUjIwcFFoSHEzMkJ0Q0hEemRiVnR5?=
 =?utf-8?B?MHc2WUVneVAvd1lIZ0hlTDJ0TFYrcVNLVHcvYjZKeWhWRWY5TmFUeTBKUEwr?=
 =?utf-8?B?Vk55NzBJb2MzK3d3ektKWUhJODR4ZmtsbHhaaTNxclYvMitXRjlVK2x4bHcx?=
 =?utf-8?B?NlN5VHRUUmZGVjhBbW16SVR0N1lSNTJtVElvRG9GRkY0NzI1aUViRVRUcVNJ?=
 =?utf-8?B?Y2E5Wjd5a1VENTF1aU5xNnQxclV1RnVpUDMwUEhGdjlZMGtFNDB6Z3U5RnYz?=
 =?utf-8?B?UGZWRVlTTklNaktST0pmeFlidC90bFp2Rm5WVDExYzE0bFp3NzloVm43Vng1?=
 =?utf-8?B?VEIvK2g0TFdqSG9ISWNvUkpmS3ZsYmlkS1Y2OGVvbmZ5QWt2NGJHWll6cVBo?=
 =?utf-8?B?N1l0b0FISGlqNU5nZlJQMGpocElBOG1IVU1wbEE0SmZQOHI5L3o4OVRaUVJ4?=
 =?utf-8?B?eEZUVURtSFY1bC9kVkYrSkduZXlMaXhQU1JBTTZaQmhLSkJwdEtZQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ssmnc9crBhd61QXy9MCf+X/n7Jav/9BMNKBmBabvfqZH8/zLJ5Kn9NEUOz/8aYcKObhWvTyHDqOEy1rvxhHm3d4R2OKvnuNWyd3NaEIclpbo+OiBqUpcnDz8lpM1uygov55auKWMYiaEDDO37K0xer4ut9X+QcsuRwX9JMpZ5UITpX9DeyhS8s0vMWnXa09VbAvRL77kkKCpESfUBv0XFo4bwBUYwmqAc8m5d/EY4XlcqO92EEJk2TMpOJo6snKxL/q8rmu7kK/A+fSNGTYyrGZ1HXteTnEjaLcOfHQPmfVzSa7Sxa48BlYbJjMPlPLWCYka2fGR9gUJk99tqwPWkAQYppDpADYvF/mjYczZ5P3arhDEqDIGCSiVoweTCcY6CNczKuK1gr2cWuT/hWIL0uchEeUcQbuuoLBPGuJZwfyoWr3gtIpefiis+4gT1jIoZFeylThnW6z7O0IN0dvPkw6yZ96oJmydOkvSq2RFgJHrEllhqnEGcoNe8VEhmsAyr/suTxamrBQpD39BdHyXRZYWcHyfYGLslQtoyoaExk7DCdrQfoWwFT5gNGt8RTw+XgYWEtA+DXQhoqPj7qn/HCZOY0Sfv/HBox9Lcd1qb4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0633f9-c7b6-4e44-abf5-08de5d1a3daf
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:34:02.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKXJzXN5G5K9jlmpCFXVBz7/M4OgXoVHV1OUok6rsJFEeM3xnxYYZaBQh4gIEux31QJmoP+aXJFwW82v1jSjTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260176
X-Proofpoint-ORIG-GUID: O5TKN_YkGxBCDZd7StzCM_bj8SyT-crr
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=6977cfbf cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=PQvvHKM9O0J6kz48lYMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O5TKN_YkGxBCDZd7StzCM_bj8SyT-crr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE3NSBTYWx0ZWRfX5N4zKApUJ9lm
 wgOQStQOyGn2u/+FNo3hJ8t8T1+MrYIXJ4eeLcC+DhXi+GI3GdvGevFViqDcXECNZVnSy0Tltjm
 dKXmz43wX0tnGRMr52nGTC47Ezl/epqv6kRfhv+Zx6lhPyuvVtBV0ijpqXps0ZyZnloDeyh4Wcq
 tnlMYNAil42tBkvHr2hY7dftdreQMhltQPZuyTRXyRqD9IAmofNX7RqvNPVC6PEDbW7BoVWNXV/
 LuPW2iipWqY4jdCWC0oSLRgt7+Ink55bX+Kb5ROXKssijTwi2mUiLdnSoqmIDBSrtsG+SfARr1u
 fa0A7AyWQzoYmYR6lCcXIVu+jUmX6i+WAZDfyqD6YLtMochR2cLCyOBTyPBzqO2VEJgmO5G7AfN
 nVVm2dr075JoWSsknwqe12t8qqo7v/uWPQy6JDVJGfGEkF1oUEQ1Q+HcmyWVIXkHG6yZs+vCFU/
 L06XwoRwKvy3xvQBdhA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75529-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A84778D1B2
X-Rspamd-Action: no action


On 1/26/26 10:50 AM, Jeff Layton wrote:
> On Sun, 2026-01-25 at 14:21 -0800, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> lm_breaker_timedout: Invoked when a lease recall times out and is
>> about to be disposed of. This function enables the lease manager
>> to inform the caller whether the file_lease should remain on the
>> flc_list or be disposed of.
>>
>> For the NFSD lease manager, this function now handles layout recall
>> timeouts. If the layout type supports fencing and the client has not
>> been fenced, a fence operation is triggered to prevent the client
>> from accessing the block device.
>>
>> Fencing operation is done asynchronously using a system worker. This
>> is to allow lease_modify to trigger the fencing opeation when layout
>> recall timed out.
>>
>> To ensure layout stateid remains valid while the fencing operation is
>> in progress, a reference count is added to layout stateid before
>> schedule the system worker to do the fencing operation. The reference
>> count is released after the fencing operation is complete.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with exclusive
>> access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  2 +
>>   fs/locks.c                            | 29 ++++++++++-
>>   fs/nfsd/blocklayout.c                 | 19 ++++++-
>>   fs/nfsd/nfs4layouts.c                 | 74 ++++++++++++++++++++++++---
>>   fs/nfsd/nfs4state.c                   |  1 +
>>   fs/nfsd/state.h                       |  3 ++
>>   include/linux/filelock.h              |  2 +
>>   7 files changed, 122 insertions(+), 8 deletions(-)
>>
>> v2:
>>      . Update Subject line to include fencing operation.
>>      . Allow conflicting lease to remain on flc_list until fencing
>>        is complete.
>>      . Use system worker to perform fencing operation asynchronously.
>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>        is released after fencing operation is complete.
>>      . Rework nfsd4_scsi_fence_client to:
>>           . wait until fencing to complete before exiting.
>>           . wait until fencing in progress to complete before
>>             checking the NFSD_MDS_PR_FENCED flag.
>>      . Remove lm_need_to_retry from lease_manager_operations.
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..f7fe2c1ee32b 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>   
>>   locking rules:
>>   
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     no              no                      yes
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..28e63aa87f74 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1487,6 +1487,25 @@ static void lease_clear_pending(struct file_lease *fl, int arg)
>>   	}
>>   }
>>   
>> +/*
>> + * A layout lease is about to be disposed. If the disposal is
>> + * due to a layout recall timeout, consult the lease manager
>> + * to see whether the operation should continue.
>> + *
>> + * Return true if the lease should be disposed else return
>> + * false.
>> + */
>> +static bool lease_want_dispose(struct file_lease *fl)
>> +{
>> +	if (!(fl->c.flc_flags & FL_BREAKER_TIMEDOUT))
>> +		return true;
>> +
>> +	if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout &&
>> +		(!fl->fl_lmops->lm_breaker_timedout(fl)))
>> +		return false;
>> +	return true;
>> +}
>> +
>>   /* We already had a lease on this file; just change its type */
>>   int lease_modify(struct file_lease *fl, int arg, struct list_head *dispose)
>>   {
>> @@ -1494,6 +1513,11 @@ int lease_modify(struct file_lease *fl, int arg, struct list_head *dispose)
>>   
>>   	if (error)
>>   		return error;
>> +
>> +	if ((fl->c.flc_flags & FL_LAYOUT) && (arg == F_UNLCK) &&
>> +			(!lease_want_dispose(fl)))
>> +		return 0;
>> +
> Barf. I really don't care for this special-casing inside of
> lease_modify(). That's a fairly low-level lease handling primitive.
> This needs to be handled at a higher level.

I will remove this special-casing in v3.

>
> I also don't quite get what you're doing here. If you skip unlocking
> the lease here, when does it get unlocked?

The lease is removed when ls_fenced is set after fencing operation
completed which is currently checked in lease_want_dispose/lm_breaker_timedout.

>
>>   	lease_clear_pending(fl, arg);
>>   	locks_wake_up_blocks(&fl->c);
>>   	if (arg == F_UNLCK) {
>> @@ -1531,8 +1555,11 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> +
>> +		if (past_time(fl->fl_break_time)) {
>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>>   			lease_modify(fl, F_UNLCK, dispose);
> ISTM that this function is the right place to call lm_breaker_timedout.

I will move lm_breaker_timedout to here in v3.

> Also, it might be best to define a lm_breaker_timedout() for all lease
> types, and just have the common case call lease_modify() as above.

ok, let me send out v3 and see if we still need to do this.

Thanks,
-Dai

>   
>> +		}
>>   	}
>>   }
>>   
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..05ddff5a4005 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>   
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + */
>>   static void
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   {
>> @@ -450,8 +458,13 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>>   
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		ls->ls_fenced = true;
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		nfs4_put_stid(&ls->ls_stid);
>>   		return;
>> +	}
>>   
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>> @@ -475,6 +488,10 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	    status == PR_STS_PATH_FAST_FAILED ||
>>   	    status == PR_STS_RETRY_PATH_FAILURE)
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +	else
>> +		ls->ls_fenced = true;
>> +	mutex_unlock(&clp->cl_fence_mutex);
>> +	nfs4_put_stid(&ls->ls_stid);
>>   
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..4a11ccd5b0a5 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -222,6 +222,27 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>>   	return 0;
>>   }
>>   
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct nfsd_file *nf;
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	u32 type;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		return;
>> +
>> +	type = ls->ls_layout_type;
>> +	if (nfsd4_layout_ops[type]->fence_client)
>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>> +	nfsd_file_put(nf);
>> +}
>> +
>>   static struct nfs4_layout_stateid *
>>   nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   		struct nfs4_stid *parent, u32 layout_type)
>> @@ -271,6 +292,9 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>   
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>> +	ls->ls_fenced = false;
>> +
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -708,9 +732,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
>>   		rcu_read_unlock();
>>   		if (fl) {
>>   			ops = nfsd4_layout_ops[ls->ls_layout_type];
>> -			if (ops->fence_client)
>> +			if (ops->fence_client) {
>> +				refcount_inc(&ls->ls_stid.sc_count);
>>   				ops->fence_client(ls, fl);
>> -			else
>> +			} else
>>   				nfsd4_cb_layout_fail(ls, fl);
>>   			nfsd_file_put(fl);
>>   		}
>> @@ -747,11 +772,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +805,49 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * @fl: file to check
>> + *
>> + * Return true if the file lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	bool ret;
>> +
>> +	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
>> +		return true;
>> +	if (ls->ls_fenced)
>> +		return true;
>> +
>> +	if (work_busy(&ls->ls_fence_work.work))
>> +		return false;
>> +	/* Schedule work to do the fence operation */
>> +	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	if (!ret) {
>> +		/*
>> +		 * If there is no pending work, mod_delayed_work queues
>> +		 * new task. While fencing is in progress, a reference
>> +		 * count is added to the layout stateid to ensure its
>> +		 * validity. This reference count is released once fencing
>> +		 * has been completed.
>> +		 */
>> +		refcount_inc(&ls->ls_stid.sc_count);
>> +	}
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>   
>>   int
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 583c13b5aaf3..a57fa3318362 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..d9a3c966a35f 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>   	time64_t		cl_ra_time;
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	struct xarray		cl_dev_fences;
>> +	struct mutex		cl_fence_mutex;
>>   #endif
>>   };
>>   
>> @@ -738,6 +739,8 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +	struct delayed_work		ls_fence_work;
>> +	bool				ls_fenced;
>>   };
>>   
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..6939952f2088 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -17,6 +17,7 @@
>>   #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>   #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>   #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>   
>>   #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>   
>> @@ -50,6 +51,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>   
>>   struct lock_manager {

