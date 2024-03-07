Return-Path: <linux-fsdevel+bounces-13854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DB2874C7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0FF1C23285
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738A1126F3E;
	Thu,  7 Mar 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KqoxyHDQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G4Rqjo+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680F85633;
	Thu,  7 Mar 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807740; cv=fail; b=ayzoGMYKcPKZCU5Tqr0MZasA3wXRv1rJl3722H1upT/oCJcl9JQ8umHmh73Joh4IJpFT3b2EQr6aJixUPN2/3npbPyP/LDFG8nUP47yctjN5FIDxo9U/akZM/RRK48hMZA61DOGtlmZxXwdXfcGvprMqfMJs7pxDeDr9vn+32Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807740; c=relaxed/simple;
	bh=55jeJM1g5A6VAusN1p7e22d3n4uJvoFtYEw3uO1zp3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kLD5PUXKcGeICKkWVhhDXqNdiPPfKsJUeXxhg7k6tC6xCQMTItRO7J5z+CYvTYkF8Fl5LwnlKe1yy6w/A6zQbaII/A/GRIJzW0OqzIYlGx/+jlB6Jj47lwWtBAg4SiKW6bDG2tkG6pK0o+XUB4A7vQ+drR4u+X7yjwOpyDjF3H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KqoxyHDQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G4Rqjo+p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nBhx021901;
	Thu, 7 Mar 2024 10:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=M/Ak8cEE6a2ayzs7J7Mkd+3XV2cgyG5nKpBPkUS/MkE=;
 b=KqoxyHDQRWiHhCldSvSXUa3Vu2ENgyskaey0wVc9Vix6FSfdmejqWUHb5jui8/CPBJJ8
 AOD6hIC30K3XHMvIv/Q52L7HJoCET3Pg2DO77rv4zf5IVhUmaJI7mkYq8iUEQRq0M6Ed
 x4Hc0LeTbuMmhoXAX2M6bD9guV4AeSLfrGAP/4q/ySuZ5C827pPSUYyt6gc4vGluAk4N
 HYo9LJhR96GgbN1r4egTStFnPpKmtAsvw2iYtaF6n4IkU8HzKMc6J9v7+7iQdZ6XXema
 LuLE9pYhFHsHzxL6rigsFrMh9qRrx5X105iloubg9rxhdDm49nxMNLzsS8Og9BXtyxBr YQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthekk5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:35:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427AUNRg005185;
	Thu, 7 Mar 2024 10:35:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7ntkf5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 10:35:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvQ5iN2tgukXJDuTzZNQhuNiPovL0y7YH6/hrQZSiaZSEpTj4RL3Ez0ozeeVWNOe9B0HIpcd9yQWl4gan58OfS9B5WvKKdSxpqam9bChyXFHVNhwWVpHXPjtxYDp2R7jYsFy0/JjAHrfeRlmdvebX42TrwSlbFXuIWUmP/J0hh/h1Byivqb6Yfz8kXXrqOwRmwsXg4PM0V03D2yEAlw4V0eLwhj/3AlAmAPb8IPKShzOzrP+FJM6VxD4RWCwic/J6r9qZuTnVzct5nakmi0rSewUKGdiwuqHVU2fVudS5FLQLcsCWaS/dASO/leMN5LIlb4K5GrnvJShBJf/y6EARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/Ak8cEE6a2ayzs7J7Mkd+3XV2cgyG5nKpBPkUS/MkE=;
 b=RH3aWlU2wOwhX5Y+1Vb+vQE8u3/dPWogYqZaqahdewV/+K76zXA0vNOFcJn6/+V8KjXUFkLfSG9EGMTMZF8ShWzL6h3uXbZJ3RC07BFFdLSK6WPcqC3hIdO10urkc2RxGDFcFpQJbY3GKAVycFKr/hx6qTeomPMO8HFjxhNRa+sBfc3S/Pl7L03rDVgJWrk9XWwNYjQDQ4Bn9G4gVZy3/2j5QH5l05EfQnOSTm5+rQW1LFR7BW35ZyxlfwFWx9znFA2MLb9fXKE1GppnTaugkI7/uhL+3OKQhd9vH5Z38oQExnRUyTGwSZQji6DWw9cytIe9NlGk4/NnADSN6UYuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Ak8cEE6a2ayzs7J7Mkd+3XV2cgyG5nKpBPkUS/MkE=;
 b=G4Rqjo+p7V6kLRo9+LiapnGPP8ili60cbuN3JZNxbVX+oE6afPJWSdX7nngqFE6P6ENjkwxE99Rd1JAtT0/uGM/RL6V2tvl3j79ot1obsw9tAaWrLh55Ke4SgjH9h/f6lFVcW02argFCVtGqYAXR3tTVfsORh312l5h2+l6V8ic=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 10:35:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 10:35:22 +0000
Message-ID: <6430d813-cb30-4a66-94e1-ea89bdc921da@oracle.com>
Date: Thu, 7 Mar 2024 10:35:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] fs: xfs: Support atomic write for statx
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-13-john.g.garry@oracle.com>
 <ZejgovFe/pWCQ4uM@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZejgovFe/pWCQ4uM@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 489efb67-c713-482e-8c67-08dc3e924aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	exndVPDrIbvS6trXM6rpfUl+0enDDrM/WwKqyAGU/I2qDrXO2TE9WnaRj0aTeWhE3zk7Zddk8WycQsvZFT6tUVnYXzwgB0GC0OGXLXMn0BuccUx9z6aMACjJUkoW1k8YGSffaAGSaldc9Wn3I9knUG5yNXOI9jS1mkOiYaiNw3MROiiYtgrB1cLp2PDNRw9teiC/7FBXpEgNEGfbgJ9kIIaAbEIG6gI1DcWOs8RMf4nCAfhHqTvFkw/gaPzInfNTDw3CqQMwzSsfT0TjsczlmClENfrN9m9UF3IQfhYv7vN9rIYR4KtI/xiwHBB6CAHoFeTfKfSTzw1JhqkKtmXlPcWvBeot50PPExtMnM1pJcmjx9D3W7ig0NjKNR6lIKxrF89dgmlXrzmRHaVQcDmi98JYFw24wdPEevFCCjbEIVMyxEJd/3vVzBhfEE26Q4+gU9uF37mriKx3ad30bCzK/TSv/9tI7KMMLCYs58nOKU9aEDWs3IkRfMm/4HpTjoJIjDBhuR0Y88iXm7ps5iOhLPoLmLxQtB8wgI65yLoQIpbcoVhnYtO75rGhy4kEUEiXMA2EYDmCy4fgSZblXV1J/fuzH4IY+Y2getY9HQAf0is=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDVsUmhTNVc0TWc5QjBtM3plNHlaK2NJWHFJeWh3bXY2YWhTb1ZIclpHZ1pq?=
 =?utf-8?B?a29PSHEyclVRaFdrSUhXaStWSm90NkpuS3pKTmhBTEdMditURTZKQ2tFSEdn?=
 =?utf-8?B?OUVLT1pOVEpMd0p5UktWK3BXQUo1cWxXOGRCUVVOYTBvTlZLalM5ZXpnUnNn?=
 =?utf-8?B?Tmw4VTJDZDdkajgxai9ZcFU2UTcvU1UzZExtNnFqaEJuZjhmSUlTbWVZdkJk?=
 =?utf-8?B?Q3BEcVMxMkozdG0ybmRPN3pTVVVybmhzb1h3QTVDQkExNGFqeHI4OTBVZ3pO?=
 =?utf-8?B?NitCeCtQZDkzeC9OOEJxMG02MUJUUTZmMjZQWWJOanpTMUVCTFJKN0VwTTVq?=
 =?utf-8?B?V2psLzk0WCsvMC9nVEVxb0hmTHQ4RWlmdGZ1RkNmejFneE9PM3ArTkc3QU9T?=
 =?utf-8?B?S0pvQzVVc2VSS29qSVpqakVWMnJTRjRXc2ZpdFhXY05uVnRJc05OUlBXQitv?=
 =?utf-8?B?dVk2THBGa2p1ck83aDZnL3lsa3A4TEZoYlFBZmlsMVVHc0djbEF1aDZJenRP?=
 =?utf-8?B?ZTRKWk1xcWVEaGxsTVRRSXBnVnV4UW1PUEdFNm9vOGNBUU9rUmEzSVUrQUxZ?=
 =?utf-8?B?Z1dNR2YxamNkTUgyMTBIb08vYlg0TUMxU29nMG1pTnZNMjBDOHlRVjk5VFBT?=
 =?utf-8?B?a1pFNEpseUs2YzhBZ20vNzB0SzdHYm14Wjg0K1g4Y2FFditQSy9kSWJnNng0?=
 =?utf-8?B?TytqbDBES2JjN0lneFN1K29HK3NwV3Q4cVdDWlBaelpnbWRTTXNkYTNWYURy?=
 =?utf-8?B?Wi83c281VjBiZnloemtBQzJJaWtYeXdOaWRYY2tjQmN3aU5ldXA1bkpjUmRS?=
 =?utf-8?B?SHljSTdqNkZqcmU0ZDBFMWo0UVpHMXVqZWd1SXlIRTZFTk84N1lhK1lDYkNP?=
 =?utf-8?B?T0NacnV4Z0d1eXliWHRCb0dCUUsxWm9VaUxIQmpnSnNWRXF6aituTGhzUHlz?=
 =?utf-8?B?UGVIaEs3UkNTYlJWL3pnRGpJRktDZ0dhOEZJYTgvMUZTV3NWQ1M5T2tlWjBl?=
 =?utf-8?B?MHUrZEF0SCs5SHpHaFEvaVJPZU05Sk1xOTNPMlJBM1FnNEdnYW12VjVjR0lU?=
 =?utf-8?B?UlRBRVdOMmcybS9EblB2a2VkNlhIK29EUWhsdVdnZ3Fqb0xoVzJMUTJDKy83?=
 =?utf-8?B?OWhUaldlNVlyRlE1Tnl4WE4wWjBaWnNCTFF6OW94eEdpa3ZKcHlCQnVSUlVO?=
 =?utf-8?B?VHRpdlQ2U0JTb2FGOVJDOXhzUTFmNk1XeWlYT1c3alpuY3BzTGwyTnNRZzlk?=
 =?utf-8?B?RW00bEJEbHlGbVp3Zms5cDMyK0VFSzkxUkhQd2ZYeG1aWUNDMnhIclFQcndM?=
 =?utf-8?B?V3RkcDMzd0tReE1hVjBZOW05UHNocm10azJxbHNpVFpKZlJSdDZwTXBTOXo5?=
 =?utf-8?B?dStZRUhVSmY5UzFsUGlpZDQ0c2JMOHozb3k1Ty9VU2VVZ3VsaW5URTJjcWNz?=
 =?utf-8?B?VkRuckhPSG11NEFvVUwvNU5pVHdsVFpiMHdibnRLNG5XZitKelpReHk4ZTgw?=
 =?utf-8?B?VE4wWEdsRlhuQzVTWGlkZllwZ1RqeWpjOTNtVUlnclVTeW1lanN5UFJ5ajdo?=
 =?utf-8?B?Z0paVFBRSzArL1JIdlFxYVRyMHdCNkFQSlJmcmtnUExSOWpNQXkraDFLL3hC?=
 =?utf-8?B?aTdMRUJPL1k1bFp1TzBNSjlMUEJ2VVFIVE0xZE1rUnhwQmtjUlJYNGtnakhF?=
 =?utf-8?B?Znh2Zlp3Q09IL1VDMmZFNUU5WE1xN0xHZjFKcG1oRXJ4eWQxSDd3Z1MxaFN4?=
 =?utf-8?B?UElPcWRGMWQ4WEpVdFBUZDNWUXlnazFsMy9rTlFSaDNVVURyTlZORFpVb05B?=
 =?utf-8?B?cjZEclRTVk4zMEdTbDhZQ1p6SU5HNUN4Z2laZUpTeDc4NFkzTU9CSEh5ZEsz?=
 =?utf-8?B?VUFGWnYzejZaZHZyNzNQem9ndVVXaVRlSFFUdFpEWWJvYzE0K3lWa3RzZ21T?=
 =?utf-8?B?eXFBMGh6T2xnMFd0VG1aMmo3LzVHTHpaamVOZ0NpL0NnOHJRTkFEbnRlQ3RV?=
 =?utf-8?B?R0ZJVW1iMUpLQmswZU5kemRCUFp5NDZGNHFJZ0hkSHZlYWxYelJtUWtxdU8y?=
 =?utf-8?B?WmpDRS9sR3AzTytYUlpyR0s0R2VLYS95SkhsSWhlSzVzcDZoUUpQbnJaUW9s?=
 =?utf-8?B?UzFYQjNEUGV1amd0d2tRdkFmVWw1Q2txYVlBOVJycmQ3WXdSY3d3OEo4aDRl?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	a9fAwLnu72+lvJJ8gTSB7M2+mBrpWhhBTTVhkvSSksD9R8V0Bb5yNJGbAJfHdvYsICtIvDgDmbCW39CaFqeFZ+7OWS91xmm7MwSfJ2JEqY4FQ3yW/4CviYAgnJXb+KQuxMh1Ns+SGban69xfmfp/c8LFvmjEsTcnWBoJADroKlyx1AdLde/IhTcnfDGyrcX/Nv89ocN5YbHDopKaRoJbQ2t2x3bHwbaUSKM1ki3eg3KLk+prBuTXiJJJxFa0Dw7WQgUoRI54krNYc1KaLNutJbFSQj1RwI9KwqBckkXAFTrkbXiLg1HJj7ekKUWtjanZQUAnCRcz3nvwmhpHYhOdDF9FagzmgR0sTCuU40rUyP2G8Y0ges+un7dQ4rahuDVzESbGUJWTuLIswc2YLPaj0DWf7TYq4Zd7q6LzSS1LYK4ACfY/4USp6EIzdgUMdL7uitmHNJZpH4quA5o4FqwC2lqr2gRsX9q/9g7U5xAakulZsDM92UUtUfbMvN3GFrSQWmALVdwEW38V3fBpCxAHwuspowGk8NjDxZzc+GpQEsCZBXYWVfdM5ZTdbyG3ycWS0DWonb6aSW3LCzqJ7ud1OZ8Q7XDwpymRiWwpFlXhViY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489efb67-c713-482e-8c67-08dc3e924aaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 10:35:21.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8u7q9MM/Lgg87kcuhQF6LFCu4PZBsNlGL3BCEPsoxK6briLdsnUUKZeCGRQBhgnCuwGxO7GKbM3HdosrQ7zuhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070077
X-Proofpoint-ORIG-GUID: 611UtNtfMUi_uAk366Hfq7n3fbF_vI5u
X-Proofpoint-GUID: 611UtNtfMUi_uAk366Hfq7n3fbF_vI5u

On 06/03/2024 21:31, Dave Chinner wrote:
>> +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>> +	struct block_device	*bdev = target->bt_bdev;
>> +	struct request_queue	*q = bdev->bd_queue;
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	struct xfs_sb		*sbp = &mp->m_sb;
>> +	unsigned int		awu_min, awu_max;
>> +	unsigned int		extsz_bytes = XFS_FSB_TO_B(mp, extsz);
>> +
>> +	awu_min = queue_atomic_write_unit_min_bytes(q);
>> +	awu_max = queue_atomic_write_unit_max_bytes(q);
> We really should be storing these in the xfs_buftarg at mount time,
> like we do logical and physical sector sizes. 

This has been mentioned previously, and Darrick thought that it was not 
safe. Please see first response in:
https://lore.kernel.org/linux-xfs/20231003161029.GG21298@frogsfrogsfrogs/#t

So if this really is true, then I'll stick with something like what I 
have here and add a comment on that.

However, in this series the block layer does check for out-of-range 
atomic write BIOs in 1/14. So we could store the values in xfs_buftarg, 
as you suggest for the lookup here. If the bdev geometry does really 
change beneath us, worse thing that happens is that we may report 
incorrect values for statx.

> Similar to sector
> sizes, they*must not change*  once the filesystem has been created
> on the device, let alone during an active mount. The whole point of
> the xfs_buftarg is to store the information the filesystem
> needs to do IO to the underlying block device so we don't have to
> chase pointers deep into the block device whenever we need to use
> static geometry information.....
> 
>> +	if (sbp->sb_blocksize > awu_max || awu_min > sbp->sb_blocksize ||
>> +	    !xfs_inode_atomicwrites(ip)) {
>> +		*unit_min = 0;
>> +		*unit_max = 0;
>> +		return;
>> +	}
> Again, this is comparing static geometry - if the block size doesn't
> allow atomic writes, then the inode flag should never be set. i.e.
> geometry is checked when configuring atomic writes, not in every
> place we need to check if atomic writes are supported. Hence this
> should simply be:
> 
> 	if (!xfs_inode_has_atomic_writes(ip)) {
> 		*unit_min = 0;
> 		*unit_max = 0;
> 		return;
> 	} >
> before we even look at the xfs_buftarg to get the supported min/max
> values for the given device.

Thanks,
John

