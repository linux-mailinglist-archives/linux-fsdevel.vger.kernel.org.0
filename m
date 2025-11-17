Return-Path: <linux-fsdevel+bounces-68778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67194C66007
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6D9B22935B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD132E6B2;
	Mon, 17 Nov 2025 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bc+ueDhb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G+iN8zV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F3C3195E5;
	Mon, 17 Nov 2025 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408459; cv=fail; b=J33MhM7Jm97OQnm4yVCCj/9CPw7zzSYKbygj30QfTBCVzkmyQp5/VT6Y6Zkr8aVPvY7s76ZHQSA+B23qh+gUhU7PsfFVyraSY1dzpTfN2/7kHn/zEQ5eifsieYjt2KBJlkz18Z63BPA1AP6PEawWhGYCfJKk+etmUTRMzXlOhrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408459; c=relaxed/simple;
	bh=ZMvzdBS/ZgSTqAalnzS8YQuyHU/RPxYRub3MTl01blE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uuwB3UMMMT5NZ/nF1QN9zDbNE1j/MXjB8Aj2b2GmfE19Rje1p701fbW+HHAArflU988eIPjeV1rKAbX7jbX5H9gGqrggTDohaqIfghiwgcgiTsan/2AO+ilHLBpfxvtGakNCmEM/dLRfWIBiYKy6wnnwTKyHeYGac8VvVNH9KTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bc+ueDhb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G+iN8zV4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8PFm005382;
	Mon, 17 Nov 2025 19:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VwC8es62ZQgZhk7qbYmYGYthvARKzxeor4smfUntrEE=; b=
	bc+ueDhbpEIK0euuQFPMuJbzqpicGuG9vtJd4QWwbMZAeVNx9cwBgmz0pwcRaQ5X
	p1qOtb3X5Nhkg5oRlu1DQKdN8BJZ+nRuwFheAY3DkKkluCFXfnya4sBfkgFj3ObU
	L74ClJgNBZpMHCBfdMaVnRpN3dIYkm3nu14I1o6trzb/x+HVLcdUB7joFGQguf4t
	wvpcrzu0UFZlcTMEpEYbTrXjuvXNxBf98/OR3ni0VdplcWF3m+fyXa6Vkg8LGa09
	jSPQYJ0BNjdY3hvmyMwVy56E8hzsh6HbH734h3wXO6W0dQVLSkGOzUsVIzp+55/V
	v4wb0Mf1Xq6khdklPCyTlg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuk5ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:40:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHIfemD009714;
	Mon, 17 Nov 2025 19:40:30 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyc5jak-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 19:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRUwjzA5SrVIXv9BTA/avlHqEpGzs8ZGLJb6a1StaYVRI+yfc5cCapWvYYxwWg9ZmLYU8+PJu1BnibYOXY/uWOlV9sNqdYcVL5+KKjwcHCyqtc/HuWX800iJ/3HYDwS/UTJ9A6vURoRXd4bcEGbNn+GLD6vZ2XBCvip+hds5hpnwQJfUUViN4skt2mIXWJAs3n1pICCc9GnkrJLO/EII3+octQBY1usqBetU/UyRzryVgvYA4R6liZJvEKD5rMwxijVJWS5BIb4TBMnYbbs/KSYmzLiB97PM7FZXHw5gbv8+gh41eStVP5k0LmtF0bQe0gvi4bbddaaFOE7CnyzsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwC8es62ZQgZhk7qbYmYGYthvARKzxeor4smfUntrEE=;
 b=fFj2AIv4fOmMijWkv2VlCYzOZv8kGY3JVE1h2rjn+x6xgWbpv3XUtAT0sHXopgma5huF7WzoFvq3jB30p0IMIsfVUb8N+L7FsP4bElQVi+Nm+MccegDByq/ON17grLPdvU0jFMcQb1Q2Zu0Y56ZPZbmMWEfFa0wrrT/JHr+tTYl1rZNDylnwWvty5SUbxuV+1djWo2p1t9u+Z+MD1YPUuMN6MRyb1Z6yh+EpC4h2y8VwKXQ206Bo2884gU4+7rHY54ozCqzLw/7LrxoNfVp82CV169pItHsRXExqR+iiHcPsV68w3VXECW/+kNKE35XjsCKwXF6f7MuMe5SPEDBC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwC8es62ZQgZhk7qbYmYGYthvARKzxeor4smfUntrEE=;
 b=G+iN8zV4bhsPz/7MCXa/qy1iqfBElQU22HIL5nLuHdKsJnrio/HDFJNGwClYK8ApRnJwujg3nSPmQDwY6vEdoFyDjlm3PAMfx+1xOBVP9pXQsYsvB3VIuLPSnthV77J6liZjPPK3gN1VXOAjy9tH3w5cWMvvBb4mzDEahUGPEXs=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 19:40:25 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 19:40:24 +0000
Message-ID: <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
Date: Mon, 17 Nov 2025 11:40:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:510:23c::8) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CO1PR10MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 79669db9-ae00-419d-6b04-08de26112737
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VnptMjM0a0svaGZDVmFWSHF2WHJFWU9rZlpsUlo1MjVscVFiTEx2NGdvcGxO?=
 =?utf-8?B?VU5aTEJ6QzJ4ZDlsb0k0b1FSWHJxVXRxUVZpcy8yakI1aDg4Rm5CZ1hEZTNp?=
 =?utf-8?B?d0pCR0VBNG9IWjJJTzRFTUVxcDI0cXFoN1JJV2NHYTUrTk84Y1QrZDAwOElK?=
 =?utf-8?B?NWprTTBoMEttbjFYL2hUZmRhNkVMYXJQL0xVUGRaaVNvYmRLU0hmWWEvK1JX?=
 =?utf-8?B?eVF6djh4QW9sTlZrZ09PS04vYm1BeWJQejBRZGVzc3c3WnlMZXlaSXJNa0k2?=
 =?utf-8?B?M3pjeHQ3M0oyaDk2WHpvaGxqemxVbm9DczQ3dStSMEhHMHlrSW5KWW9EdjFO?=
 =?utf-8?B?YzVNVkR6WEFBRnA2OGxrUnRRRGExbnZpNTF4Q3l3dTFub0xkVEhaRGhJVjln?=
 =?utf-8?B?RnNCeHltSFVsR0Jla05xQVVGNnUvc1F0bjJrMVB1bXBUR2hEQkozck95ZWx4?=
 =?utf-8?B?SWVxekdQdWFua1Jrb0pCbjUvWW5VRENPSFdSSmtORERXQjFOVDVBbzVpRG5W?=
 =?utf-8?B?N3lZRXVLZndmSHVuQThvQlRjUEZrdUpzcEZ2eU1Xb0hJNGNvQ3YyVEc4Wk0v?=
 =?utf-8?B?bGo0WWIrbW50bUtZRE0yc1RreGtFYjhSWUEvWTNBZS85SmlNYUhqYkU1dkdH?=
 =?utf-8?B?ZmhwbWxhQUM0OTNMdEpMRjdhSHg0M3A4YW1EeXNxTWRVSjFWbDJrcExPTUEy?=
 =?utf-8?B?V3lJNHFpVWVQT2hsbTFMT2g4eDN6Y3lVc3VrNjhGVUZtd01PcWhSbGhIbTZp?=
 =?utf-8?B?Tks3enc3QW9uZzdXWk9FcmZuc25UN21KT2EzcVBjMXpPQnZ2YzBTRE9jTVdZ?=
 =?utf-8?B?VVdQdDZZSjJzai8rUmpxaFlMVS9UaFl5RzVRTFpLZlNrTHFRZExTUlN4TWFj?=
 =?utf-8?B?ZjZEcGMrUXJ3bzJLNlJmbHdwQWthVUo1NlJEb1o2VHNrM1RYRnpPMThKREtQ?=
 =?utf-8?B?dVQ4ZDltQzJzN0FNNDFJbjZOQ0hQaEVNbUJDWGZyOXpSS3VwL2FTT3hreE1i?=
 =?utf-8?B?R0ZKb1REUCtzZXliR0RrUXI4Wk9lMm96ZVlnUUdjb1FrQ0pvQ0pCMHlrL2hs?=
 =?utf-8?B?U3VWME5obDF6Y1lNMUk1RlpGbHRNRVA4ZDIzS1F6dE0zSmlXNngzWVlobitG?=
 =?utf-8?B?aURTeTIzTkdQVEZYVlUzRnFtK01XcDJJaEtTY1lzV2F0SGxMWlZ0bUxDOGRp?=
 =?utf-8?B?NzZhZWdiRE5kS3MrMFowWTZCZzhUU0I4WU05Q2xzRFdmbVZhRk95Y1VMWXJN?=
 =?utf-8?B?UGZCcGNmaUV0TFRFbjNUaVZmK3llSnU4VEY5OW1aQ3FsM0pSVXZpSnBCaWti?=
 =?utf-8?B?YjIyMkJiU0VzTEcxTUxoKy9RbnFsUXJOaVdTcHRhaGZCeUxFYUdxbHVxN0VS?=
 =?utf-8?B?dFg5VkdwNVVpR3YyYWwzaXlSWHNJOVF1TGIzMG9pUngrR002ajVtbHF4YVFv?=
 =?utf-8?B?RjBYZEZrYkJ5aG5Rd0NBdHRueEJVN09nNlZuRUc2WG1uZFhJOHJ2VjR0SGdM?=
 =?utf-8?B?OENRdjdnQWVwa2F5ZUJxOVlENE1nMzQ1eHVDeHR6WlJOcy81MDd1RVJkVlFm?=
 =?utf-8?B?WlNnZFdqTnpKR3g5WmFGMmt0TnlyaHoyVGpCNmxkVWlBUHRaNys0MnQvem5Y?=
 =?utf-8?B?RmpaZnhCaFNLNmhTOFhsR3hBRFlxc2c1SDNjMi96N1Y1Z2JlR3N4Rm5LdXNt?=
 =?utf-8?B?THV6djB6V2ROdDBXNVVBT04xcVU5OHZBU3gxamFIbDRPZ1NCWTd0QUtzZmJM?=
 =?utf-8?B?VEhYNHdRaTNNazBtdE0wckM4N2JidWVmZ3EzMnBlYWlqQ0R5YytKL2RKVVZV?=
 =?utf-8?B?aE1laGJBdk5lNUcvUTVJK05GRFZkOWZDYi9jcjNRVEROOVJoaEl6OHlPbmpz?=
 =?utf-8?B?dkNPdjFscHQrODY4NDhxMHF4Y1pNUnVnSWhpUHdqc3JzSkRQUzZjMmNDcHBO?=
 =?utf-8?B?UldyS0FDYVdqTmxBU3RLT2QvSjI5cnJ3VzBUL3MyODNYYVZpN2ZoMGhJQ0dq?=
 =?utf-8?Q?AFK9R0ZZ5hUaqLvfFAGUFQMOMz1AJU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UWwvRnlscHViQ0pMR0dueWdwYlVCbklqTldpQlUzYWp3UEdoaEdNaWRQMnNS?=
 =?utf-8?B?aGpnZE5NVWxBN1FQUGVUUUVEWisralVuRnZuNWV1UFRHcVFsbTdVczNsZkNU?=
 =?utf-8?B?T09vcWpDRENLRFRURmRObndvNk94YkYxeEpTcWJNN0llVEZ0dEpua0ZmWHgw?=
 =?utf-8?B?a0VjSGR0Sk5RK0JZcDBQdW9UUlVLVmVmcyt0U2JnQkRmQ1IwcmRha2orTFFv?=
 =?utf-8?B?VmJjS2l2YXpTNkNVcDJEQm50dHBlSDJyNmhaNGt2R2R4bkZVODI4Y1BGTlQ5?=
 =?utf-8?B?YkNlNlpvdk9Cdm01VlNuOVRNcW1ncnJRbmxWR1N0K1NvdWJEOFlMcG05QUVS?=
 =?utf-8?B?dW9YV0FVSjhFZjgrS1BmdVZIWHRBMDlNZ1NQelhCVG9TOHBwQTFsdFp0UmJw?=
 =?utf-8?B?K0lLMmM0aG5mNGVlYUM2dUo5azJKMHNQM2FPTzNUZzM5dkdZalBHUHJFRnZT?=
 =?utf-8?B?UkFsNjdpeDNKK0EyWng0MFVxK0xWcjNBZkpuVEVtOU40a2JRaHlQUUZyWWxn?=
 =?utf-8?B?ZEdkaUJHcXIydFVkV1A5NFFNUjkzY2poYTJIb0ZvMzJabE9yV0JaWmVmdU9U?=
 =?utf-8?B?NU4xVFBWblhwcWlkY1VKZnpkT1d1ak5ZWW9DZzBJWUNOMXlzYXRtRExDQ1Ux?=
 =?utf-8?B?c25XbDIyVldCdnZTTnBMT0N2RWRLVitSV0t5N0pCUi9DTU9EOGcrY1hiblBj?=
 =?utf-8?B?K1JnUUhaYlk1N0hTV0dwNnZnZ2lOcURKUmhoU0srNTV5dXpuWWdNUnFWLzIy?=
 =?utf-8?B?NUNodTVXYnUrWWY3aEZMcG94YWp6a2xoREp1YWZrTDBOUGhwOW1MWHlZc2FI?=
 =?utf-8?B?Q0M5RUQxQlk5RVhXeUhTVC9jRzVpak9tanlod3hBOU5LTDdkMjNEanhJRGd1?=
 =?utf-8?B?a3JEWWJaVndrZzhWOVh4eERhYktsVVdZSHpkUU1uY01BNTRZN3k3bFhrcStH?=
 =?utf-8?B?S1Vka0dlUmR6bVJTSWxQQ3Q4VFJ1ZFJ4aURiQnRlOU1XQWhMLzdwN2NxZWdo?=
 =?utf-8?B?ZURJUVZlN3BNZGVoWEtTTS9XUnZkeDhQY1Nxb1VDQVRDT0JKL0QwZU1PeExS?=
 =?utf-8?B?THRkai9pOWtiNGgzRjBhTDZJVDlsaVpxTmdrNnYycjA2TnI2cytXSFl4NS9v?=
 =?utf-8?B?YjRsNnRjU2hoTXYxaktRM0M2MEdKWjRoTnNJKzV3SVdqTS9nRXNXWjllU0hX?=
 =?utf-8?B?UGdLM2NOaWlEcTV6NElyMlhXT0xDbHJ1SXBuUFRjWjJ2Vlh4Ly96b3gyME1C?=
 =?utf-8?B?TGRxcGgxZWRDSzFEdVorOXl3cm8xNjBpcjF3NXVaU245MEVpT05pSHp5NXdP?=
 =?utf-8?B?cjJmS3laaDQydWRnWnU3WlNRL3Rtc1F4WlFFUllOOFlSbkFZL2RicVFwa3Na?=
 =?utf-8?B?TzMvTThMQnFZRC9Hdm0rRTROZzA2bUVReXRNYm1LT3BjcmNZYUhBb0s5QkFF?=
 =?utf-8?B?ZGcxTnoyblZFd05pYjZIZE9rVWcyeHpXeXdPOWtQUHhnWndwTndoTVc5SGdD?=
 =?utf-8?B?Y2VUS09mc0ZGUzZ4QVdqMERIVTUrWWx5cDQ5dmVabzlNN2JTNW5WVjFDTU9C?=
 =?utf-8?B?ZnE0cjcvWm9YOGp4dDhaVXowZUR3cEZjblBLYVBKaWw4Tnd3QUY4VVg1cnd2?=
 =?utf-8?B?MHowSWwwbU41NDdlRm1qeW1jSkN6b1MwdDY5RjNsMkRPS3RJWnlFaVo1SU8w?=
 =?utf-8?B?MFQ4SW9idURLVHNQbCtqQ29lSW1VbmVPaFlEUTRpZXJ4Rm1YdW1aMGZ5RjlK?=
 =?utf-8?B?Y01vc2huc2ZrMGZ0VjVZUndWaHM5Q1pQOExUZ2FyTjJudUFRcDV1ZUk2dGIx?=
 =?utf-8?B?WVFjd29NRHdLS085a204TGNDTTJ2dHo1N0Q4QzNMajNuUDBodmgyMDFqNVhm?=
 =?utf-8?B?Z3R5dUZYVDE4eE1WNlZlOEFQUkVMUSs1QkNiOXRzZGlibTZZS295MXYyVDly?=
 =?utf-8?B?YTBrMk9SRTZNRkpEZ2g0TmhKU2pLVW5CMmpHSVRVUlFXV3JSSXB3eVdpNEhv?=
 =?utf-8?B?cnpQd1lyNmkvWkRzaVg0MjFLSXNHS1NFWFJ1V2ZscUJzSXRsUzVoYTN6ZE5S?=
 =?utf-8?B?NEliT1htQklzeWZZYWloQjRvY0ZSa0w2K2dhcVU5MDFseUVkenN0ZVhmdktu?=
 =?utf-8?Q?sO0jij4s+cJTjsYFbIbjYppZx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eOhR8dv1rI/YRyhnHJs9UFe0li79G4iXMPci79KYbqo3Bdq9Xr6whHWx8pC1U6w89XmDem+ZvhpaAHiSJl2SkS0iGyfNhehJnMaUBPFJI27Gb3FmZCwgyeHOnTQ6kvyVwweC0+m4WzJDz9lqiblmfx7E0CqcKdbts4xqF4VTogTBEKfmlWWPcKYeX4xnIhLpWO4xNfZWgw4KeO8s5SP5JUNpGjeLfgbJsGwKk0kjy2lvDVegjPjnteUWecVUGj4/lPfIOnnXxizYX4U/BjBmt+ADGi7r7sq5ekIsMW3LRws16kmDzmWTbgCtJdP/qpLsq8yDEvh9+P/MpXSMTTxaVRrv+d4YA+PsrmVGgV9yjQHGlN3HFAlRjcsYX1wXt9ZApSVbosSRH50LT3Y93XdWHv1AiPCafUpjLdz8J2bltOrkOY39tqdqQ4sfcwOp4bexLLHzCOn1vEEPDqOH90cEnagq0BecS82NF00pPCDYWb6hMGZIZObEjQGh2xNDIP5F7N2Bp0cv3g65BG6pHdu/1+K9nVp9qKf5Toqr9ViZ0MY40rhkmZe+XZmHg0bguajgumyPORrZKs7SFYk6OdX8/XiUrmKokfQ+0eHeMi8uvmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79669db9-ae00-419d-6b04-08de26112737
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:40:24.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp6dXqplwVEmwePnncnMd4Ys+utUKN1/lYThpE6PTCEdWQMxyPY+NACsp2QCTGowd5qKw4WnH+UtlYrHOIY7Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX24cMn3UuhbtW
 In8OL3c5ZunS7n4BLblgXXhGrpUGoVAFtzVXwvMmRLMAek6n9mjkGQqYDcj5UkBq4A9KBhuCPAh
 wmcoajaRwgiOczMgorIRrSSfkiWU47hBfyRBGuk3WxrPGw2nQGJdXFajgRAz5XQyIRByaxTQ3Sg
 2U6bk7tv9Rg0uqPQr30218IbZ57eNEuUI8eUtiB14q3mNlRwEzUTxjbeBv8rJgAwFzDUxMAxPLZ
 lyDG81p/blwYvfKL7DM8AC2Ccp6l6PidJY67DteERWXj0i7sV5RErfmvCNsAx4EejkMEfMQzgs+
 pGEQhodLDa9L5hf6YVIsj2c2YYnYho8j6WPPWRFge26YJoCiuHSFVHHmUDV0NpA5KCBzv5r+0KH
 xm5JmFRC1PfYBVRel+Ju1pRoZ6mZwhtkf4P0DiO5OFZUnAEnAcQ=
X-Proofpoint-GUID: n6LRfTsT6Tin2j25khOXNtvbCXiwD6eZ
X-Proofpoint-ORIG-GUID: n6LRfTsT6Tin2j25khOXNtvbCXiwD6eZ
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691b7a30 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Tz8Xq4AjvdZb43DjinUA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13643


On 11/17/25 7:55 AM, Chuck Lever wrote:
> On 11/15/25 2:16 PM, Dai Ngo wrote:
>> When a layout conflict triggers a call to __break_lease, the function
>> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
>> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
>> its loop, waiting indefinitely for the conflicting file lease to be
>> released.
>>
>> If the number of lease conflicts matches the number of NFSD threads
>> (which defaults to 8), all available NFSD threads become occupied.
>> Consequently, there are no threads left to handle incoming requests
>> or callback replies, leading to a total hang of the NFSD server.
>>
>> This issue is reliably reproducible by running the Git test suite
>> on a configuration using the SCSI layout.
>>
>> This patch addresses the problem by using the break lease timeout
>> and ensures that the unresponsive client is fenced, preventing it
>> from accessing the data server directly.
> This text is a bit misleading. The client is responsive; it's the server
> that has no threads to handle the client's LAYOUTRETURN.

I will reword to point out the problem is there is no server thread
to service the reply from client in v5.

>
>
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4layouts.c | 26 ++++++++++++++++++++++----
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index 683bd1130afe..6321fc187825 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -747,11 +747,10 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent starvation of
>> +	 * NFSD threads in __break_lease that causes server to
>> +	 * hang.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -764,9 +763,28 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>>   	return lease_modify(onlist, arg, dispose);
>>   }
>>   
>> +static void
>> +nfsd_layout_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	struct nfsd_file *nf;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (nf) {
>> +		u32 type = ls->ls_layout_type;
>> +
>> +		if (nfsd4_layout_ops[type]->fence_client)
>> +			nfsd4_layout_ops[type]->fence_client(ls, nf);
> If a .fence_client callback is optional for a layout to provide,
> timeouts for such layout types won't trigger any fencing action. I'm not
> certain yet that's good behavior.

Some layout implementation is in experimental state such as block
layout and should not be used in production environment. I don't
know what should we do for that case. Does adding a trace point to
warn the user sufficient?

>
>
>> +		nfsd_file_put(nf);
>> +	}
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break	= nfsd4_layout_lm_break,
>>   	.lm_change	= nfsd4_layout_lm_change,
>> +	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
>>   };
>>   
>>   int
> Since this patch appears to be the first (and only) caller for
> .lm_breaker_timedout, consider squashing patches 1/3 and 3/3
> together.

will fix in v5.

>
> I'm still not entirely convinced of this approach. It's subtle, and
> therefore will tend to be brittle and hard to maintain. Perhaps it
> just needs better internal documentation.

I will add comments to explain the changes better. My main goal for these
patches is to plug the hole where a malicious client can cause the server
to hang in a configuration where SCSI layout is used. Over time, perhaps
we can come up with a better solution for this problem.

-Dai

>
>

