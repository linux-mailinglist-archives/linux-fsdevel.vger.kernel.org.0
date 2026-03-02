Return-Path: <linux-fsdevel+bounces-79082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FPJDZsWpmnZKAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 00:00:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 860531E624B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 00:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A94F73047592
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6742282F38;
	Mon,  2 Mar 2026 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JEg+qF4O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xd/f/JBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5039099F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490521; cv=fail; b=rO2MO2r9MIt1wyRmrBfs/ShQ4bYK/il0eL4APeD0Jt+L71eAyFCz8P7KEGTiu//pI7pH/7Vtpuqhd8QmycSCh8vR8YM5P/ww7tDNd9I1wv3sl7MgqNbr9869G3CdTJFfDCVWQDimpJn8hf3HNXfJWnLYx0izTPztk+WhvM1Ra9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490521; c=relaxed/simple;
	bh=vQlvLzNHh9z84KI7UVQ3eq92hiRvDmCBScC2tV26daw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JRHOW4o4yF6pLvlgB7mb7Cq/hZg8I2vXK6d3QB+BykIs+6efY6AQtQu73LLIPdYZzpR8gqmpq7oUy+lXiDPDRlbNTKLWwPEK93v3YnwyMW1iK3N1k8euJx2l8jWF1OOI5vVj9Pvs9BDCwc6u+EHs36cu2aBW3/8oO2UR7IOCc0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JEg+qF4O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xd/f/JBZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622MOCIO2921996;
	Mon, 2 Mar 2026 22:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=peHtRZcVMsHI5Pxh2tk4XMGPmVlqoWXGmXicWQZmYOM=; b=
	JEg+qF4Or1+eX70R1YAEvRrH1j+c/HE21oPlncN+NO9Z7thf9d7GPbK0M/2h9J12
	GUzwMHXSP2+UttB8r0BYFjqsfeDaSViJJtY86NqcwvKM/ewd+08jgZK5cjLAzEgz
	vpRKY8uuSqxwpfopf0v7neHJYXfRLVWjuUoOsvEw03Rus+TLEZT19o9E0h3e2Xc6
	eQDNyn65QGm7Uuh/0yEXCJd5bu0QHCtrpKxI74/hO2BfF7zxyQDdOSN6AzMkvxIc
	xAoEBbAhl9ndP08AL0y8Iei2+ByCQAQiuDW7U8Ye2TdO+ft6UlPBm7idhdR+AV0N
	w+Oq3elgKLbKWMUgQXMAXw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnjnfg2fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 22:28:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622LdVBn034772;
	Mon, 2 Mar 2026 22:28:32 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdjj91-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 22:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNSj23Wt3PhZ1gwICESERQHZKw4YjfN6/MNQ+dnZn5G2+lA3Cn6vkZqMThOsUGuVbgUi65rzq/7Xq0RmN0TSWq1mU4viTDacDhCpeHeEdyffS7faKkaztD+ij5g2wJZ1K3o23gLdbewjRDUjJrapFZXI/RdFVfPVsBc3ncHG8q48Sd6o31FFGB+AxtEzEzX6oYaqIHip6+DD9oJvdLyDaNZuVw0z1xYSjz8a1fQXaFxbys258ulNRVm9kT4RXK2joZoz4GUMnl5FECM+xjkilZHJcvSfAgdbDTHU4ygr7LzQtD5qd/REhZjh8JIF2fLAFFyzjWsegcut9dJLWdzh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peHtRZcVMsHI5Pxh2tk4XMGPmVlqoWXGmXicWQZmYOM=;
 b=Jzp94tnlSJm+ZmC6qNslMdpjT8tgvdi60Yjjihm16GvzSVKPTsYXJDlHzM+tqFvZ4pQVCNpztW5DqHPE2toU0IUjWCGGdjw1ZLwQQbGCk7aHCJXF21AfvuxvHhMl8X4jkiGh9WnqCaLSE1AJEyphhXirFYDQy3fV8sMLzyxdnqOxOeYfG3guRBenfFzK0cb5SqA2pFRjpLSMAvcN6VlyY5T/kCqbXOQlBZgxNa2tkpkeaCQaUxtTulntITV0XDUr+bLNQ1ib4WRlBRXtjovPFryTCHWhv6YtorlR1PT8Tb/RFaf5H08ElWUIbJOsCJp9xFOSpwV/PTpqe2+uEj1pkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peHtRZcVMsHI5Pxh2tk4XMGPmVlqoWXGmXicWQZmYOM=;
 b=xd/f/JBZFe7VTNymnhqQHAdvWmp4QWFNIBJozqqnojXG7BeGxbBcH7NpKYtqg2uFdM0bBqy7m32iLWE7Zs8DREnARgv+zuRw+04D7pq3PK/oOwiFprN7UL6rl4uNgwQYZ0BqiDeRKjD5MEV5qck5pDCS2c1dTvb9MtpV440QISs=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CO1PR10MB4756.namprd10.prod.outlook.com (2603:10b6:303:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 22:28:18 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::10cd:e055:a053:ec92]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::10cd:e055:a053:ec92%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 22:28:18 +0000
Message-ID: <fc9c776f-bc8b-4081-ad9e-b4ebc40b9974@oracle.com>
Date: Mon, 2 Mar 2026 17:28:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: use simple_end_creating helper to consolidate
 fsnotify hooks
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org
References: <20260302183741.1308767-1-amir73il@gmail.com>
 <20260302183741.1308767-3-amir73il@gmail.com>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260302183741.1308767-3-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:610:5a::14) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CO1PR10MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1f3a98-54dd-43d4-53cb-08de78ab00cd
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 5jRfE4Jlx+FNLmDXV5OdNdapfOw0CHxwoZjjEt4t/fIBtEHXoIlkVNafa2Mp5rvZhMM19NLRkumBFvvFJ8qHDQvjuIF4LDftvaPKZUJsJ0NAMGQvY/qYR1o3riDo8eW8ZUZD+b0yk5lj4cKi50NBYIkcqbNdNLk+h/lsRTp3SiPKgeHwOeit5/i0iepQ90Ao3o00zcTpFXOE2UvuaN+EKMi8zGWdKa+vgLBCKSGWYFL5Tv+VplIadLoka7hvTn9HexfmCSyHsqj0TyKjUQb8/1ICG3k/SCE8Ir4ciLRdlWS96UEqywJGVmb6KmJdOhJcD2QbeiK/Iws+OscNTuXEUSMcp2GGaXeJVFNC6vlZqdomYHgJnIZTohfT9P22YrCxkRWyJjIdLQQ6rcSSI9ryAmxYMHH3r57oymvWDhk5xMw+2V+n3sB3p9SuICkQ1OSrT1vb6vvlEAtLj2/14GEsnrw9MW2j7hznNkF8C/VpqrnqfX4Y0V77c8iwPIxmqowWfLp+wcowEvMSWLT6EpXGMNbUxQZxG0MLNLXeJPx8x8p0KYQki1NlyiEPp33Kkg+fpdRsdtOCW+NaIVGUrF1acg2ksIm1aopgiyxw5RSpD0HQs9ftlzRN4vfqSgayhYucM57g/H2+iVsE1MKSp8mF0ORjj9ddYBsogaYrefbJPStUdX3tAKMzIjY6HHXuwcVWrg8hR8zaaikpHhC9ZjIh4GUvP9+G2aEVXQvnnPjR3lM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bDZJQ01GaFFFenI2L3lndGwzcVdFb1hZa1kwNXNXdTArWFY1alJGM3p1VUxZ?=
 =?utf-8?B?L29KdC9EV254cE1hWlFOWTJ1RGNIb1lEbExNN2l5YWdtN0JHbUdaemxMVUtZ?=
 =?utf-8?B?ZkhuRkdVYlFYK3hKanN0VlRQSzRJbGM1WUc5TnRFb3liNTVHcEpOckljVGdL?=
 =?utf-8?B?bnowNldiVzZPR3RUUWh2aEJPVzZQcUN0S2hvL1hmcHdsam93aDMyanl0NWs0?=
 =?utf-8?B?cDFHMnBGMjRydWhSY1hJWWgyZXNQZk0wUC9qaDFVd3hkWHN2RTdLSlByd3d1?=
 =?utf-8?B?L3VobHJOL1I4VUxheU0zSjdpODhHNW5YaHhnTjJaOW9hb2xteTlCTFJYa0pK?=
 =?utf-8?B?SWI5eGJ5dHV1QU9QdEZwOFJTdGNMaHZlem5YbjlnWXp5V2lsLzJ4SWEyVkNW?=
 =?utf-8?B?QUh0OHl4RHF0V0JndDJGYmxtYnFCQmt5ekRiOFRCL3lxdDBGWGZWZytValdW?=
 =?utf-8?B?SXNLaDFOUWlKaVhVNDZXdWh6NWQwbXBQNkFjVWYrTEQ0UjBPcTB4RzBsd3pj?=
 =?utf-8?B?TUk1Z2ZGTHFndmRPOEV2eGFZVGhtVU1SV3B0eHIyNHVVVWJvRGUxWHhvUWlF?=
 =?utf-8?B?cC9DREQwMkNCRG5lNDdBT2lDRHdodHhHaEk2b1hCVG9tdlpGTDYzTlUwSWFW?=
 =?utf-8?B?REtpNnpwT0ZCMCtTU1FyY3gwSmlYODQxTzlicEJnbHpKdzRHamplKytqRGJ2?=
 =?utf-8?B?ZUpUbktaTEd4V1VpZVRaOTYwWmNQLzV5cTMyTTNlcXRjdmo2TkVFTldZK2o4?=
 =?utf-8?B?T25lZ3dxOUh5K0dERy9UcEpoejdiYkpPWkNSUDhPa3FRNmFqdlNFOHJTSWVv?=
 =?utf-8?B?S0ovdFN5SHloZXNyL1BBR21kenJ3dGVEWnZUWnM2TWFaWlE5ZW5IR0l0UzdU?=
 =?utf-8?B?clh2QXY1MGVsWkwwOTUwQkxKeXA0S3Q4emJKM3NUZ3hEbnFEdWpTWXNWcjcw?=
 =?utf-8?B?ay9ZTXFMbzNZVnZXSHVicEVZcXppcWp4ZmRFNkdDZXkxT3ZhQnpNaExuRHhi?=
 =?utf-8?B?SGJaTm03aEFHYWkxc3hwWXBZekd0OXYxamxGZ0lzaS9KcXF6UTJlZ0twNjR1?=
 =?utf-8?B?aWd4YzBhdDFIWVllUUNyOVBvdkpJelJKME1Ma2h2VzM0WmpCQTFEczNlcUJm?=
 =?utf-8?B?bkZ5d1pWcVpvWG9vcUVEc1M0SG4vY1ptQ0ovU09LcWxrR0xJaERKTU5CRkkw?=
 =?utf-8?B?Nk13RjV1S0ExS3BGVHcxbTFEZ3dBbjZqR3hlT0FYd0NpVSsxN25CWmp1ZTY0?=
 =?utf-8?B?R2F2YUd5ZnVyZmlqNm1wV1FWNUVKbCt4THpWUWRJMS9ZU2J2aFpZd0pORkNt?=
 =?utf-8?B?WHRHWFNwZE5TdjEzcUxsaWJoRzlHdnpEb2dJdTlXR0FYN09Hdy8vTi9wcmRP?=
 =?utf-8?B?Q3NtMm5DY2kwYUgxbFdhYm04WG55YVEyaDdJdUVjMlNEZFRQVFZLMEwzU2VI?=
 =?utf-8?B?by9JdW5CYjBHdjY3SlQ5dWQ2ZitCOUNjU3REOVZiVnpzaFdtbktkczZKK1FU?=
 =?utf-8?B?dUFYb3dYaVlLSGVIR1ZPQmJCZW1mRUREVkFzaVRFY2JnYkpEU3E4SytqeW5L?=
 =?utf-8?B?TzNJN2EvSWF5dG1TTGFRSTk0Um5IMkVoNVJNRXVmaVZFaWxMZkNOZVdzRG1m?=
 =?utf-8?B?UFVZM1c3NVNCZEE0Wis5ZWU3Z2F0YTlPc25ONFV6OE9YNUhFUmwwM2JlUmdN?=
 =?utf-8?B?M0czTm5Na2tzVkFtUVNJa0MyeE1jNlc0cmtHb2Z2ZTNJM3Y1b01WT1VQV3ZB?=
 =?utf-8?B?MmR2a3k1OXZCdTd2Z0I0MWVqNFdKVUVlMTZXY0s2T09Ob3E4Vzg0RHpSNnNU?=
 =?utf-8?B?T080YkRvbzllTUZRa0lHcUM1Y2RGWENSNTVsNm1wblJQM0lySlE2WVlQcTlD?=
 =?utf-8?B?a2xlSXFIcWtNWFNaeUJ0YkhEbTM3RjZmME0vTUpqUlptOWxGSURIZkszelBJ?=
 =?utf-8?B?N3Q3TUdKbGNZMXQyRkJHRm1lNG5IbFFUZCt6YVV1bXMzVXNva2ozVlNnVnor?=
 =?utf-8?B?a1ROVTRFc1BNMmJCVVZZYlFaQWVvL0tzeis1ZVZ4SDBxc3lwcmlYbzBENE01?=
 =?utf-8?B?NjBzaEpUSzIyWHZiZk9lYlRNK2tvYlpqK094c2FZUGIrRkhDeVdzaXBLVW1r?=
 =?utf-8?B?ODJhSzRmUS9NRENYNDQwVDdLT2M4allnRzBQdDhQc2QvNy9PVnNWOUNnOVEv?=
 =?utf-8?B?OGNGck9xZTg3YWxEeCtIb2c0eVUyN2lLQTRhZFVlcDBKS25oYU4rV214Qk0y?=
 =?utf-8?B?cmJ1VzNVc1Bwc2ZQVjdnM2R0d2I5ZExKT2JxNlJvamFaQzdUVDNVbnVmLzdI?=
 =?utf-8?B?NVhHMy92S1hiQU1IMmkwZTJET3pPK2xKTE9RbnZpQnpjWGxZR3NNdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hw6za0nxjCPrjNuXI3sZNagSHXLmP74KAyQ5GzfuyZE3e+cfdG5PNeSGavmu4kZ9A5UpAxeu4njF60j7gt2fKVv0g8cu4hPry8TCmtJQj0+CLjzi7LsYOryAeclkQrZ0arBDDwLOPjrlBS0WmfwDiihdgdx7jNQelfPa7q/GvBdXtA2OXasdBDDq06ilVtNjd/WVQsMcJld4YYPHOPXgn86AAykQhp40p9Mk0Ly1neFe9svHfxkRiG+EfaOMpAtNVssjChxjuG9eCSMAGWxkRbH0S0Ps/E85u0lafjSwSLIT6PUgw4nDOzlFkK99RvqTY7CmI8FFUlrfrq5VEW1lokhrmltP+Ut327C88MnBAl6GcJRRXPRu39oqd1YL75T7WpYblif7ZLDKWhxLJJPG6sm3JnyirHHopEnFW0jHtA0o31VakJhmqS+cw33vg2ylYjuWFArlSZo1ACjPxT1otE8TCRRqo9Agrpjf0/UnFJ0k5kAPJIGJDF6n/4/AIFeo7ZF4NLQR14Ek3C3pQ9aESDDnPQ2qWY+/2bTs+sGO43Vuk06iigBjq0YkquQRz9y1/qeJ/wj2E7YiMI7wkLOKQ/NBV39augUMpRSVMPEE76g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1f3a98-54dd-43d4-53cb-08de78ab00cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 22:28:18.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NC4Iab06Z6uShFERCNQeYUgjX9FOR5wpK8umOPCXHgwycPGxdUsItgnG1CKSDgcFGpWwz8qlqnKwDoc47T/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603020166
X-Proofpoint-GUID: x_fXAlY-qfiWekG3qaDyAdrsO7BfGj3Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NSBTYWx0ZWRfXwXWeYcXNncAE
 1TGfuCSyIcGhE89SQ9wU2BH/Ok2wDEM9MMBFJjR5IMXp2jUIGFcypO/9amv9Mh6+zy/tHo3RneZ
 RVC05Sv6SQb7yQCsrAjw+vIV0RxHOIfifMOG7bscvrZASROc0ftfhYHskedxouZl4+xBEni6nNG
 nGg9cB4k6vW6sfzNu5IDIc6oXyg9oiOLswj5fhvXasL7HuxEm5V0biMxVfiUVQh05kuxgf8n8Ia
 SpoULn81PqwvA8Q9acZ7A0PQx33DpkVaP2Nhbo3U6Xk/4WIOu4d33U91/S/WX0ZR40gY4pZrqzX
 4hyuBsiD1xu7xz8MK5oM2xpt2DAx9EFrr47FIpu2P+J4xnc4MY9BiipBIb/F9EhSrePq5iTSRib
 W+w84DYqweKJipsCqa1Ey8JA3gzDrLWXdwgGBhOmzDQ+KpoBZxpeemIktqrm+njLLRN4NsS+jnv
 nVWfpCN7WMtYRd2KulbL5CJTgDdrhwUwjVY5XmOA=
X-Authority-Analysis: v=2.4 cv=Uq5u9uwB c=1 sm=1 tr=0 ts=69a60f10 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=b6KptwVBqja5vwmi2uIA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12261
X-Proofpoint-ORIG-GUID: x_fXAlY-qfiWekG3qaDyAdrsO7BfGj3Z
X-Rspamd-Queue-Id: 860531E624B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79082-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[oracle.onmicrosoft.com:query timed out];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 3/2/26 1:37 PM, Amir Goldstein wrote:
> Add simple_end_creating() helper which combines fsnotify_create/mkdir()
> hook and simple_done_creating().
> 
> Use the new helper to consolidate this pattern in several pseudo fs
> which had open coded fsnotify_create/mkdir() hooks:
> binderfs, debugfs, nfsctl, tracefs, rpc_pipefs.
> 
> For those filesystems, the paired fsnotify_delete() hook is already
> inside the library helper simple_recursive_removal().
> 
> Note that in debugfs_create_symlink(), the fsnotify hook was missing,
> so the missing hook is fixed by this change.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index e9acd2cd602cb..6e600d52b66d0 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -17,7 +17,6 @@
>  #include <linux/sunrpc/rpc_pipe_fs.h>
>  #include <linux/sunrpc/svc.h>
>  #include <linux/module.h>
> -#include <linux/fsnotify.h>
>  #include <linux/nfslocalio.h>
>  
>  #include "idmap.h"
> @@ -1146,8 +1145,7 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
>  	}
>  	d_make_persistent(dentry, inode);
>  	inc_nlink(dir);
> -	fsnotify_mkdir(dir, dentry);
> -	simple_done_creating(dentry);
> +	simple_end_creating(dentry);
>  	return dentry;	// borrowed
>  }
>  
> @@ -1178,8 +1176,7 @@ static void _nfsd_symlink(struct dentry *parent, const char *name,
>  	inode->i_size = strlen(content);
>  
>  	d_make_persistent(dentry, inode);
> -	fsnotify_create(dir, dentry);
> -	simple_done_creating(dentry);
> +	simple_end_creating(dentry);
>  }
>  #else
>  static inline void _nfsd_symlink(struct dentry *parent, const char *name,
> @@ -1219,7 +1216,6 @@ static int nfsdfs_create_files(struct dentry *root,
>  				struct nfsdfs_client *ncl,
>  				struct dentry **fdentries)
>  {
> -	struct inode *dir = d_inode(root);
>  	struct dentry *dentry;
>  
>  	for (int i = 0; files->name && files->name[0]; i++, files++) {
> @@ -1236,10 +1232,9 @@ static int nfsdfs_create_files(struct dentry *root,
>  		inode->i_fop = files->ops;
>  		inode->i_private = ncl;
>  		d_make_persistent(dentry, inode);
> -		fsnotify_create(dir, dentry);
>  		if (fdentries)
>  			fdentries[i] = dentry; // borrowed
> -		simple_done_creating(dentry);
> +		simple_end_creating(dentry);
>  	}
>  	return 0;
>  }

For the NFSD hunks:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

