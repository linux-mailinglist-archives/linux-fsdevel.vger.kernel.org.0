Return-Path: <linux-fsdevel+bounces-39190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B345A11324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F273A6351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3220C47A;
	Tue, 14 Jan 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gjwdt8ra";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ktjvg4+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FDB2080DA;
	Tue, 14 Jan 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890698; cv=fail; b=JCfXlpAmx3mvH+uS/MN3pS9UfGBXnujQ8qjDgXGNX36AG43DzRlA3S0vWX/KF7Fqd/qXLVEW2Xqt+BgnIZYl61ttDXzSVuc3obEDaVOKh+UPX9PK+6HulPr6wKlmVDNh7R0i5eoOogiAse2qWtEaBUUdPRb0X4truDAVyhQwWqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890698; c=relaxed/simple;
	bh=DGFnLJZOYuqOj7iG4ffoCz5HMBw1G8mKiEUmy9mXzKs=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=dO2Hyxw+Tdu36sL0ZtgbzJogcDidIPl4t8Uf86v59ErbJgWebb+j45P7en8j3SjnUvFEnI3yUFj2eqmaMohbAVT7HFi59qRZcsza4y+2SX6BF4LlHPC5y8okvEXiO8MaEVriTTW8TAVObyIzuW5W/QPQYxecDH8YXf/zJQY+2vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gjwdt8ra; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ktjvg4+J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIXrFo001186;
	Tue, 14 Jan 2025 21:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=OhZB/kdv7kC0vB2h
	qJ4ctQs2MGT+CFOvALms35i8yJQ=; b=Gjwdt8rakj+Gd7du/2qmT6W3lBcVEob9
	YUTaIg2CQoulyTb1uAG9YZeEFwF4v0RI2u4BCKGu9/KrGyyaydeCVk3zKyd7D5SF
	mMiw2l4HNk5eoIXEBTGePaZ3H3canHXxwxbRue2XEW6w4MVwmpgL0xrQxs6C8pHc
	2FGuuS20AQ1jT6ej6fu6hGgwUIwIbmnwZ/TGM9O3wEHn0nvTfcK4kHcG1da695VY
	wMAF47iirZRMwXjjxFl2rDjtcGsfwoIn67d7WW5DAmw+7ep1b+WIY2kVFYivJIvA
	DQ86Zyp7Ignj6bJLtDd7XXimn1Nf3nRozlenwcqokl6wBpIq7/D0Zg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gh8xh59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 21:38:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50EKLBiW029876;
	Tue, 14 Jan 2025 21:38:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f38p01a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 21:38:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFRRONXCwHphONbJfqBvmh2jxuiM/xm7i916EtZowNpFKtpGEtdiNv/Jp6jPgHaDcDS6q+yMMHojc8BFaVAmdzDzfoADsiZg+qXEL7n6+JoGTOnSN+cGe8N3ZF1jJa4lWgZkCLtvt30JM15oVw2GchFtubgiH+yj7WqRfE32lcTD+7Uh6fuf47dSg456FFTYJjoq14H3GRkmy1Xp2XBxjQyvf4uC2hrm+/xlmkCvb/vhTKS6rviT4Ryb3KblyIew2VOui0XzTe0PxWV2NlYDISD6Z59VKtmB3hRx5ZKPNg5sqxiHZrdjpEdvdb5i8LyHaz5t0B+7UenhpV4qXqIK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhZB/kdv7kC0vB2hqJ4ctQs2MGT+CFOvALms35i8yJQ=;
 b=D8DeJE3VQ4z16lq5VhpZ8IB0cpMmZAcaj04UskfkRFqOOsuYXAa6b/9beyu+Ms6bPKbKuIJzxy+jSp9qyuK+QR+BBlKWcet/PBBBToKadVablw76XPDq/OsZACLG60QCsS3te6Ml3pgptIeIorCBHN9LWwxips2tAtCBsy9XgKEtwMTvb/1FwllDwCo8MWzf6DQUu8e5tkaLrYLnFKgE25UTBhTWuJBFiCohxchQcA3VsfkrPKBrY9QFP0TsfkoZS9vOqNHyRZSCFRpmnZI8SgQfUq8pr1qQX8o8FJPi9qADuphXJ9N5Z8KKCP/9x3IXshdlebLIJm4LxhkIP9O+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhZB/kdv7kC0vB2hqJ4ctQs2MGT+CFOvALms35i8yJQ=;
 b=Ktjvg4+Jq2XTcCddHdp2GJVqQiHATgKI7i2BfTJKyfX6UicfFNOIgFgLWS+8ruHoTZwasza6NUhBPkm0kL1iFQWhW2SW7+pdmLhkj8Qawo9kZAEh4A5i8Xl55bdCgu6tiNaMItCVmg1gbEXp3oZhiu2b526wO8Opz2kwQ4cZbxo=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 21:38:06 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%4]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 21:38:05 +0000
Message-ID: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
Date: Tue, 14 Jan 2025 16:38:03 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Anna Schumaker <anna.schumaker@oracle.com>
Subject: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME operation:
 VFS or NFS ioctl() ?
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:610:38::41) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|PH0PR10MB4614:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ee156a-99f3-4e2a-65fc-08dd34e3baca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3B0dEVFcVNCbi9iUEIvVDZJUjVpWmJmYzZnQUxMeFdZSzJrdHg2eFYwQWVW?=
 =?utf-8?B?WFVMN2ZsTGJMZTZHR1pqMjA1RHpyVjdQYkhndk1nQnFCQTdyL1hHTXY4eml4?=
 =?utf-8?B?MWxNQTNHcUJRa2Q5WStFdGkraTB3VUZSNDZrV2lVanhlQmlFSVNrblM0c01R?=
 =?utf-8?B?cnR0bzdPRGh6SE1OWFhTWk9vQUhMRzVLSUJNS2FVb0xiUHNOZjc1Vmh3Vkg2?=
 =?utf-8?B?eVNFb094TVhldkJqcWhnZGlOWnhzRXZhdmpkR2poM0x3Mk5QMWZMYnhFRTZC?=
 =?utf-8?B?MGswNVN6dnFJU1czNzErcTcwRkdPa3VHbXFZZWZOZmZVQUZsSjMvNlg3MUpD?=
 =?utf-8?B?enhFQ25JVmkzeEVWS1BwQnEwRmpQV0RHUWZjSVluTjZ2SnQvV0tOZ0t1bkJX?=
 =?utf-8?B?QjRmSTVRdnE0UDFESDdUVzNuQ2FyR21xTU5qWmdvU3JlSmhvclpzR3UzUG9i?=
 =?utf-8?B?YXg1M3dGdzkrQythS2lmTWYvZERiUzM4SXphRDIxbVdHVEpKTkVGMk5FUVRt?=
 =?utf-8?B?ekZsaHllY2QyT242NXRvRHRvenI2WnV2Z003RitUZHRDcXZacFhKK2RZdUlU?=
 =?utf-8?B?M0k2K3R2YU1abmdWaXNNcXpzaVowc2prd01MRlpoSEI5TS9wMU9OY04ydGMx?=
 =?utf-8?B?bG9PSzlMbWhJZytzdi93UTkyYlBkMFBqUU41LzVNZ1UwVEdOR1F2U1NYa29t?=
 =?utf-8?B?Mk1KalMvTWkxY3l2RWlBM2pwNXp5Y05UR0VjRlJ4VHNWUWNXMTR6aytDaXow?=
 =?utf-8?B?anVRd1pJYmRoRjd1K2J5ZmlhbG5kOWUwbDlQVjgwNDZxOG0vNHVTNjgvMU5M?=
 =?utf-8?B?RUpXeWFveXBseTRLR0JwL2hBWCtYNmF2ZE9Nbk94YWVUL2d5YkorZ0k1VHpu?=
 =?utf-8?B?dXJEMDQrSHRvUnhUa3p0NmZaSVZZMG5wcTFKTUNEamVLaThtWjMrZHAxdmt1?=
 =?utf-8?B?cVpRdzZoQllvd0dkd1dhOUJBLzlXdkVTVUxSMjYyNElDbC9LaWw3dFh4QWtD?=
 =?utf-8?B?YWxrVzEvaW5PSTBsVUJNanJNOXViL2xFWU5veWVkM083L2VzcGFKdWpWRitE?=
 =?utf-8?B?R1o3d3V2c2ZwdVZ6UHB6NXZJUCtwV0JUUzIwZ2h3enhTS1ZZaU5YWlRTU1RZ?=
 =?utf-8?B?VjA1M1ZWT3F4VVpYdDg3bnNjaXlCR1pyWjR1dkE4ME9YOFAwYkVnamg1Q0xk?=
 =?utf-8?B?Yk1qdG1TT3dpT09odDJhclZjWDdLV1dkSWpTNTRLbVN5TlRaNVIvVlQzREJM?=
 =?utf-8?B?UkIraHQ0VWthd0NOY1lTZTlPc2tLL0IrRlIxYW9uZUdiZWRoU2tSZGhiZXE2?=
 =?utf-8?B?QWVsRnNTWStjMzdPb3k1dVpjc3g4aXllZmk2akcwa1ozSy9uT1BQYU9jNm8z?=
 =?utf-8?B?b1NyaGRmaklUeXM5OFdzUjVUTlJkeXpIdVJLcFBGL21EbTZWZWdacVY4ekJK?=
 =?utf-8?B?Tyt6UXdSb2k3dHJqQXVlOXVqQ0NjMmxEYzYrSEF5NktPNCtWbm1JMG03TUZm?=
 =?utf-8?B?dDZwZEszZnZhdDlSVHdoVDNKYjM0aU5EY01FcU5aKzE3cmVMZG9XV21nK00r?=
 =?utf-8?B?a1k4R25CNUZKc3NQMWFiMHpHT21wZkJjQkdic0hHbDQ2bFBvckc2TVdWV0gx?=
 =?utf-8?B?QWZhS2NHMHBZVVdtT1R0bkFuMXFIK3BxRzh6RDVHQkgxTGRyUU0zRmZPcjB2?=
 =?utf-8?B?dnlGTUtNRmxtbnQ0eFVvdWpwRmRUZmh2TVZydVU1ZlFYQXFsemV5TkExbVZ5?=
 =?utf-8?B?NHFpM3ZTY1ZSdllTNlE5N0dEUjFTYkRpMEFNcFZYdXlXUVc0TDdRakZ4aUtB?=
 =?utf-8?B?UWg5eW5GRzBHYW1WbVlscHZ4RTcyRTloZkdNZWZNTWpKcEc0UTYwOE0zSWRN?=
 =?utf-8?B?ZEJyQytFSEFWV3ViYnkrZXRGOVVFMFNVM1NPeWxoUFovSUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0FJK01lMERPcEZoTzZTV1VmYWlJb2licFpKMk0rbHJEYmVEUHZaZzNyQ0Rz?=
 =?utf-8?B?dHM3SHkySE9jWXJMZWhhME1KZGh4bHVnNm4wNzZ0b0FLRFdvUW9yMjJGT08y?=
 =?utf-8?B?WEdQdVFzWGxYOGowcmtwNHZTMi9RZTNqbmw1UUFLV3BveWpzVlcwZFFxbTIy?=
 =?utf-8?B?RVBXYXFibGRzYllwcFlJaStzR052VW5pKyt3V0VIbjl1UjFiR0Erb0x5Mk8w?=
 =?utf-8?B?M05McXljOUpoRnpNZ3VLZU9QelNhQjdwcVZKcGxZQzhRN3lpTDk4ZGprTi9i?=
 =?utf-8?B?d05NODZ0Uk54RTVWcVlMRjV2WDVGVW11RDFaVzRWZkRQNmcyQWxvM0tCaFBW?=
 =?utf-8?B?RzBHTmhIbWJLdkluRVpFNjh1Rk5Ja014NWcydFBqL0h1UmgyZ2k2Q3ZQQmNv?=
 =?utf-8?B?L2tiMGVBWWZ0eE10dEZ6VnpVMnhSVUJlSUlQcFgvUkJhZ1k3TVZha2VwV21u?=
 =?utf-8?B?N2Vlc0I0c2Q4U3pnM0MvOHRSUzhOZTFOZzhMMklDMWlUQXNnajFLb1orbE1a?=
 =?utf-8?B?UG1ocm9jbDBRbWdHSitIQXNacGRzSnpvYWxtS00vRXo1d1h2ZzR0ZURscjk2?=
 =?utf-8?B?WVZ5d3dBVjdrWE81UHdWUVplQVNadkpVc096aVQ5VW9keGJlQ0Mza0tuV2xT?=
 =?utf-8?B?czRWd3pDSVdjd25DMFpJVHRURXFISTJVN0o1aWYrcHF0OU0rMitTd29BOHlL?=
 =?utf-8?B?RmNKcE44L3J6aXQvVlJMdjRVdStGOEc3T2J5a3B1cUFZVkw4VnFzMHVtK2tB?=
 =?utf-8?B?TlZ6U3RIUzNLL0RDTm1CckI2amkxWkhMdGVBVVhiSnNXTlJzWVQvUUJzUGhz?=
 =?utf-8?B?b2tRZzZuRC9BTzBEeTBZbkQ3TkRrUU5oN0xKVXkwZUpldnlmTVMwMm15R056?=
 =?utf-8?B?OVg5amQ3NmVTUXhZenRLTFJLNmo2Sk5GcU1PeTlkSFRqcEk5bmtZcU0zKzhM?=
 =?utf-8?B?NHdsT2tjWEV6REI3STdsWjF5Wmsra0ZMd3JEWTM3anEyNjQvWXZqNDMyV1Bs?=
 =?utf-8?B?YVo3ZWdsU1dnU3lUZjI1Uy95MCs2b2RscEJ0a3FEVHNBbG9lNzViNkU0RzdP?=
 =?utf-8?B?R1p1TGxUSXBURy9uZ2ZBZ3Vva0UxaDhnUUlnYkNPUndWcWxoeUtNM3lRSDVs?=
 =?utf-8?B?dXI2VUM4bGZGZDZXYzBCTTYrSFovU2xoaU94QUJjakk2TGNaYTczSlFWTndG?=
 =?utf-8?B?NjhoSjRzamVYUkpVYWlIQkNyUWJiMlYrazBwd2hXWVRPMTkrbHBEbUFiMG40?=
 =?utf-8?B?U3Bhemg1bEdWVEFOVlRyVTRidUQ2K205STh2QzB3MWdZc1VrV1JoWFl2VEZN?=
 =?utf-8?B?VEhwQTFXdDFxUjc1WVVZNSt5VkFiUnVDU0NpbmFjUFlKRDM1Ky9RNGVCSmkr?=
 =?utf-8?B?NzF5ckRzSG54SjhpQlpvYnU2QkNwQmY3ZDIyTHdwQ1l6cTExUitFMm5Na0Zz?=
 =?utf-8?B?WWhYcFJaTGFrVCtRS2JRR0VQWGZWNG5saTFBNkRPTEVSK3BYcU5pSVdLZXY2?=
 =?utf-8?B?QUZKRFVKVmtsRFpIQ0FyME05TjZ0aGxxWExTc0lYejFZZXAyUnppK2trem42?=
 =?utf-8?B?VW9jSDRrbVZiNDZXTERvRHlYRUNaOTd5ZjZUcUlmTndmTXJyTnMrVkVHM1Vm?=
 =?utf-8?B?ckNTRHNTZUg0T01tR2JNcjgwNVcyUmkvbWM5eCtJZFdHOXVlWWFRMUl1bkR3?=
 =?utf-8?B?NTdUamVValNQcXpaRS9ib254M1FBRjVuVllYYUtOVUtwSTFqbFFjcWxkUVlM?=
 =?utf-8?B?dE9ZQm9peFhhQTQwL2l0YUlXTWdJMUJoM0c1TElaNWpwWU1DWHRZTnJTUlF6?=
 =?utf-8?B?ZFprT3Nva3RwK282cUdJVVR6bFVlcWRWaWpueHNZZG4rZWZad0FNcVBaVW5J?=
 =?utf-8?B?Vk1GSzdEd1NxNVZjZlRrN1N3UG42MWFEWmMrMEMwRXRlTUlYZEJGRzFHWDR0?=
 =?utf-8?B?dXdSaTJzYW00VW1KR2I0TGo0WllrQ1dZemJ1ZFAvRm9pRHdiZ1RZckpOTkxD?=
 =?utf-8?B?RmN1a0dMYlZQWi9ETlkxMHBOWlBabmpsUitWMHVVZ1BRUENHaWxybkp5K3Nq?=
 =?utf-8?B?MWU1QlNEaVIwYUJuZjJETXVtNFVrTGljR0lsWDFQQzhNUzlXM1EvSmVUbmpx?=
 =?utf-8?B?aS9BaEVaL3R6TzFPcitSKzcrbmpINDZsU29TRE4zM2krWEVHblB6VnlOMlV3?=
 =?utf-8?B?eEZBdlRDTzVxVU0wanlUWTM5TzhKVWlsR3E3dW5KMVViNDRVaVlZaHIwcVRJ?=
 =?utf-8?B?S3hKUUF2a0lyT0ZudTZ2bE16clhRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zAi6q0NqG0IW8nI7Uj3K9+utkORN1K6h07A6zySlAiPM1AlF0hxHqpbnJB0NDszgdzwJU556f9LrJ48ShulaqFeYJ5uohM+MGU/mgfkvfcUhdELqRM3JNLhsTzlmnLLTxsrJjZe5Pi66EmDMbKR2Yn3WplFeueK7irmQwRCI72VXyf3CwpsgCXq3sXqZtEY/sRtlShrrZoWGIZq/C9WgDBip+r6yE5P17CDkPB1TBgbV6YVs03sx67Vqc9IrALk8N/nCjbUTejOUUXIP806WIOeZZlRaYhFjrm4PbF6XM4DJjlKPZFU1HfdiyGsFtv4uQvkNjNS/K/CIgtZR9tNanDHG9WqxiksSWReiiSK+ApghHKJoyWqenSibHNrIh/SB8C73JC5AAiu85DuN7/omddbJN3XWRizEHk6xB+h9NlDnqXK6nMkbuLxkL43/vA83ZCaSY0ZBaH3FPNYNG8TVe2RU62HF2swat561aX+fxTd3jMvLLZVhQM+r/WyUem7ZR+5/lX7cnppe48Ho3Xb8oTWCCOtJnvnhdAxCLpYhh9197VL3i24Q0IBUa+V+TC+k8J445G3O0kh6iOq82owVLJ0TdU30B4rYzyrhnfXrEmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ee156a-99f3-4e2a-65fc-08dd34e3baca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 21:38:05.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZvExqBnanhre2kfNutKwvbdSJW4WrNVi7OHi3Nz5uyudr80RrVs/saeJCF9Qou/55VaMy74x5e2Hix1SV42GrmAMaWrvduihI7jVcItGYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140163
X-Proofpoint-GUID: GYBLuWPbloqYnvHm4O2dz2h9QuOFGgBw
X-Proofpoint-ORIG-GUID: GYBLuWPbloqYnvHm4O2dz2h9QuOFGgBw

I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] operation over the last few months [2][3] to accelerate writing patterns of data on the server, so it's been in the back of my mind for a future project. I'll need to write some code somewhere so NFS & NFSD can handle this request. I could keep any implementation internal to NFS / NFSD, but I'd like to find out if local filesystems would find this sort of feature useful and if I should put it in the VFS instead.

I was thinking I could keep it simple, and model a function call based on write(3) / pwrite(3) to write some pattern N times starting at either the file's current offset or at a user-provide offset. Something like:
    write_pattern(int filedes, const void *pattern, size_t nbytes, size_t count);
    pwrite_pattern(int filedes, const void *pattern, size_t nbytes, size_t count, offset_t offset);

I could then construct a WRITE_SAME call in the NFS client using this information. This seems "good enough" to me for what people have asked for, at least as a client-side interface. It wouldn't really help the server, which would still need to do several writes in a loop to be spec-compliant with writing the pattern to an offset inside the "application data block" [4] structure.

But maybe I'm simplifying this too much, and others would find the additional application data block fields useful? Or should I keep it all inside NFS, and call it with an ioctl instead of putting it into the VFS?

Thoughts?
Anna

[1]: https://datatracker.ietf.org/doc/html/rfc7862#section-15.12
[2]: https://lore.kernel.org/linux-nfs/CAAvCNcByQhbxh9aq_z7GfHx+_=S8zVcr9-04zzdRVLpLbhxxSg@mail.gmail.com/
[3]: https://lore.kernel.org/linux-nfs/CALWcw=Gg33HWRLCrj9QLXMPME=pnuZx_tE4+Pw8gwutQM4M=vw@mail.gmail.com/
[4]: https://datatracker.ietf.org/doc/html/rfc7862#section-8.1

