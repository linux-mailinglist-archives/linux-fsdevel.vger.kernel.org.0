Return-Path: <linux-fsdevel+bounces-47067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893AA983B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BFB171779
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758132797B8;
	Wed, 23 Apr 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NjkzdisR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dOkefJaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081A278E79;
	Wed, 23 Apr 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396983; cv=fail; b=c6dQA/bDk/vRIXNt8qjpURHTJowJeLSa+agVL611Lud+Tza5JYLTGAf2Y5IlOa2jhn+iQitKi5vRmBf89A5xtT334x5m6JLFiJx5oWpySEGSF+MM0dhBU/BRJYYSldX+uH+E2TAAQ22ftqBy4xcN/8iZWFY4OTV7P43FGcovdEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396983; c=relaxed/simple;
	bh=quGcJQ+qNXfMDKSFN1059HtV0y3D6XN0aJT7Xqzei7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S/OJgmVf6y3mUXr8zOBL0jvHOkEJUiR3j6WGup8SLZ6FsOKIZI2gGfDUyiy8ek3Np8jVL3bKLllbsc/C5iNQSc82WLQdM0BFh5Z7JgNJTfCiY/p7xqZwDpBvTbRlWBqhxOenUQ7k5DxTVpZY6NaJgvi64zxoM+gjVlvcVMP+wBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NjkzdisR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dOkefJaY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0tpXG014082;
	Wed, 23 Apr 2025 08:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vujF9Kpgnfqxv125qT4vSrvLsJP3I9NkeY8tZKClR5g=; b=
	NjkzdisREd2Cgq34ZQqmkfXBonKnBjuqXxbi9IG+QGxxOXNRv1dMTE5KA7VLe8Rb
	oWbNg1rMKTjGWY1h5qQc+lxgPes+rBakBrMb/yEZb/b3qG2eX9dJ0IlcBqJpaBoE
	Ujbz3ZpG0i/5hDLa2uN7yIgLvtbwkLuqXeS94MB7aZ0qbE+8eMacpVJMe16hS8xH
	z//aMIhUFQi7w5z4PWRAHBH5eKMuB674eRn+kwnH3f9T4rtsXC1Z43/dtPwNGvmt
	8XUwkGnxVVVf+BwU5mZFu43vvh4qhmPbWnPglhK6sBYWRRckgChPv7suy0+Ub+Dn
	ozQ4tgUuSGCgmol9Sbhhww==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe0qa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 08:29:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53N8KcA5028402;
	Wed, 23 Apr 2025 08:29:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx5s9tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 08:29:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjHf0j01f+dXB27Uwm45DtLneJ6RQXv12W9A+YpG4jlZkbqkoI88pMo1U9/UtNGDIM5AagZFe7Z/QoXJ+U+GCVHvXyYHt5DWqHKcNw7dNvpTYI+ssSQk3TQOQIX2LgPx7lARHXvw/g9mj+dRjbExufWNh4rh1WoRp3r+BjmUTXnR3Nm21Mdj0aVMoBr6Yk4YzPS6Gn0RvPlJCH3xoilaM6y2aY8YeixnGFi5yaXnZL4LYWzsBgMQXTuVE+k3stcSfCufML59qSJDANBtXMvn3TCIBwWwhWbddBzj3A/v3MIxM9Z6z7bcMMDM9qlwFUziLVgnZh0jqz8q7V+SqDG/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vujF9Kpgnfqxv125qT4vSrvLsJP3I9NkeY8tZKClR5g=;
 b=UHL0BLo7hcLEdlOgGbgpQrR72xfpWmXQYM3xh3R3YPr+orwc78T6ZiyolSYf/prqFFRR2Zs974rEqtF3vkJTeWNargWPED4E0PUOr8ezL2n2zkGo894SOBVIA312wjgeLCFQDh6dMH/QgPoYuEgkxV4OEMqMW2OwYeT+qjSDdMt8IEls1bBM2gXb6OeoAGOrCer+zDwrqGe1/5fTY3oUVmv8dWJ0ZecongTy9hTZH4K5LMnp8UBaVafbG+uxUsGmTE10BxxPcOatB5SWerFkA5rj9DUovZSe97fR77vvSDzvcA/q2JESkAkUulBHwKwLt6jE2Mev/3KqmnCmOy7YRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vujF9Kpgnfqxv125qT4vSrvLsJP3I9NkeY8tZKClR5g=;
 b=dOkefJaYmIXZXWJIPUXczCwyOrVQE0a8XrUNwDHCC6qqMGQ+ywpINNPZfgVFdSmfs6CdqOnZUbqDRAt8nJbX6F6K5J5hCIYqHzo6aDNbHO8BLXfCXZFjLXo4AlVoQuqxcno42uhuTFGyVOLGHE+wfpUBKIt88h7VGsx2qMUI36k=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by SA2PR10MB4554.namprd10.prod.outlook.com (2603:10b6:806:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 08:28:19 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 08:28:18 +0000
Message-ID: <f27ea8f7-700a-4fb1-b9cd-a0cba04c9e47@oracle.com>
Date: Wed, 23 Apr 2025 09:28:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/15] xfs: ignore HW which cannot atomic write a
 single block
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-6-john.g.garry@oracle.com>
 <20250423003823.GW25675@frogsfrogsfrogs>
 <f467a921-e7dd-4f5b-ac9f-c6e8c043143c@oracle.com>
 <20250423081055.GA28307@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250423081055.GA28307@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0111.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::16) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|SA2PR10MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 239e006c-76ce-4df2-cd0d-08dd8240cd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTBUcGpzRXlzQm84WTFEeGtWZTFoK3lsSDlCM2h2c3phRS9EUXhKUGZDRm91?=
 =?utf-8?B?RThOZlg0MEtKWHBEdlRiQTZkKytEMVdmc25ENEo0N2ZQaDZrTllCMDhobjRj?=
 =?utf-8?B?djBwdUlNWHk0WWo0dG0xMlB0YmkzUi91N2pEL0pxNlpqWnNSK1pISUFXaXhW?=
 =?utf-8?B?UGVxS3AvSVhTK1FOc1p3NVM3QnJTNktLQUh1QUNpSG82Zk9JNUVwUnFYbVpU?=
 =?utf-8?B?ZGloeWRUb2E1ZVpBWmVlMm9jYXRHSnRibXEyZ0FReURXS0tQalV0ampoY1Js?=
 =?utf-8?B?UE05SWpWM1lpaGNKT0RZYUtuMzBNSjVoUkJaTER2b0N3cEFqNzc1ZWRqN0Iv?=
 =?utf-8?B?eDlrbDBGdkFNcE5UMjhzSEsrYzRsY01uUDIwREFvWXZmVVYzU2VtOGREbWV6?=
 =?utf-8?B?YUF4amdNWFVjK09MVWliOXdWUjhPZm1ic2o3d0gweCtEWWd2MFdrdzJjZFhz?=
 =?utf-8?B?UzY1TGhsbXMrYzdQWUdySlRidDZraDlLc3BNY0dWZWY4RTd4NDQ4dm5wMk12?=
 =?utf-8?B?SDhrK1V3K0pjN0toMS9URFJLYkYrTGRrb0RFWEs2dHRBc2ttc3BvMVNkVStk?=
 =?utf-8?B?NDlVcTNYZzg5V2dMVGJnalNuS1NqOHZLUjM5dnZHNld3TjZ3eG5wQ3pETkxu?=
 =?utf-8?B?eU8wRnVkY3AwQTVCeWF0QWZ6NkRYM2pIZWZaSlNCREZzcndScDBHelJ3d2VT?=
 =?utf-8?B?dTd3NHVuNUQyS3pMVDVreXJUY1pGc1ZYYVEvaUJZZXpkT3BwbFpQaTZENUNV?=
 =?utf-8?B?VmllaUoxNmFJM0gycm5kY2JaUnRETm1ORHlZMVpUTnZVWFhVdms2ZXpwSUpZ?=
 =?utf-8?B?WmJWY2p2Z3BrT0hVdXFwMks0Q3JOcGE0enROelJvRko0bWkxbHV4L1lFb0Vp?=
 =?utf-8?B?SEhOSXNoNlBYT2VHYlRkZWRjU0JIYTh1Q1BodDcwdDFlclZGcU5VMDVvR2Nq?=
 =?utf-8?B?VGtxNWVVcklqL1RkNEdkUEhjaEdjL0J3Wlg5MUxGd2NiOU1mdEUzeGlHMGJO?=
 =?utf-8?B?Qlo5K3dOY3dvbzRvWDgxNXR0YktZVlBUMnlxalFyMFBVYUJpaGN2TTRDRkN5?=
 =?utf-8?B?QzlrTTZ3MzlsQTdBUkFNUDZHTFN5UXdjRlBwOUtsSGdZakEvUW1TbmpBNVdC?=
 =?utf-8?B?WnJZSGNWY3ZtcERTTUNvTUFncXNmaEJucjJ0ODFoRmE1OUVLZitJU2ZSdGVR?=
 =?utf-8?B?WmJ6OFYwOTVRWDRMNUQwTGlYNytqTEtjVXNWM0s3YkYrUXRnWGl3OHNuU1VP?=
 =?utf-8?B?NUFWdDYyaTdSMjRtdHV4azZzc3JCNnB6ckxsNnBWWGt4b2tIL09Ia3VQR2J3?=
 =?utf-8?B?QVhUVjVZUWpOWUxoTXdHeXBESU1XUVZrVXd6R3U4dHY1Y1dJUVdJV3k2enlZ?=
 =?utf-8?B?Y1BEV1VPMTMvdGhjb3dEaDlGejF1TWFpMlJEMGI0cjUzbGVTazd4clpyZ0tS?=
 =?utf-8?B?YUpObGxkVDhHeUsvRVBjbXVQZUNTdlJaRURTQkVXc0tkdUlrZE9HK2Vabk9E?=
 =?utf-8?B?d2YxMktzT0l5NVB6RGt6NEFnclhzUDZSMmlWNnlpbi9IeEpFaEV1OUNPVDRG?=
 =?utf-8?B?TTdvRnkxWEJWY3BEWEZEYVEyWVpvbjVsREtFZ2EwYVMvVU1iTFBROWZtNlZT?=
 =?utf-8?B?WTBTcGJTMi8xekRQZDY2MGNVUHFraUtRc0xmVExJbDdsYU01d2lLQUo2RStu?=
 =?utf-8?B?dUlUT1grczViTnpaeHptWWRBcEdBSEhHV1NsSHNEVk40dFo0OVZqS0F5UVNI?=
 =?utf-8?B?dldMOEsxS1NJNHNialRKaFQ5NXRNZmYzOWtkb2grcTQwZmM3RWhMTmUvUDc4?=
 =?utf-8?B?YURUSWFSejQ5ZUhvZFdtNXp0Q2VwdXNqQWRva0p0Y1ZySFdxc3krSEVFL1pJ?=
 =?utf-8?B?aDBWZXg1eElGa0IwTXYzTnd1UXozQ0QvZytCTXdMdHVTMm0zWGhJd2lJbFZt?=
 =?utf-8?Q?2ap/1UTQJL4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c25pRy9YaE8vN25tOW1kV1VRMWFVb0FlY1ZhUndoTTg4RmxoczhJRUFGOFJ4?=
 =?utf-8?B?WXJCWnhFcmxlYUc3bFFQSjdxblVRVndhb2xxZTUzdE54YTBUNjg2WE82Wi9W?=
 =?utf-8?B?aDgwR2lRbGRvWHVvTHExeUt3UFhpaTVjY0l3Tm1ObzUyaHh1L013RXRrNndh?=
 =?utf-8?B?N2ZyL2FyTnlud3g0dVJ3aGhBUjQ1UWVQOS9jUGsrNU9zNXpvWitMNklBTkow?=
 =?utf-8?B?dXJER3RTcHdJZWFkcVVoQlN1UU1vd2xBcDVYUUV3OWo2eHgvSGhkWEQwY05C?=
 =?utf-8?B?bUxRQWR2eWNJKzFTcXB2cnZVNUQ2dUxOcUNBbkFYQVhiK2s3bFkzRFdLcCtI?=
 =?utf-8?B?VU4zeDVCUlJQS1VSeVc3dlliSGxCdVVxTVJlUVZNS1ZXN21GZnluSzB2eDZw?=
 =?utf-8?B?U2NpZEJ1NVZnMXdBaldPckJsK0thcHBwU01MUjRpc0lzdmd0RXFvZUFHNzNH?=
 =?utf-8?B?eHBQSWlHUy8yWjk0dC9RRUtkbFU0RDEyb0JqR0RGS1lyUDZLSTJFdkMwODJ2?=
 =?utf-8?B?aHBCTVo3SGlmak9KZXVtUmhaOG9sYnJxcmNPT21ZNm44NDFoNGYzd3JqV2tN?=
 =?utf-8?B?TzF3ODN5UG42UW9QYnlQQnQ3TEs2djhBZkpaY3FVcVJ4QzlaWlRtSmFWZlZK?=
 =?utf-8?B?alhneFYyRzIwSkxDZ2V0dzd3dmdVQjR6UkEwSUYybnIyQ3B4VkZmVWN6WUpt?=
 =?utf-8?B?bm4xTXJRa0dZeVYyREFTZGtMaDJRc2YydnZURDQrdkpOUDN3RHVBMG9HcjRu?=
 =?utf-8?B?QVN4NmV0YzNVdWErZkZJRm9tQXpNK0VGUjlQM3V6eHQ5Zy9leXgxQUlFMnMv?=
 =?utf-8?B?dk5IcThpOVhDdHNwcWRWRng3dmM2MTFHanpsbHA2TFBXbnRmNjZVM3ZNUnFW?=
 =?utf-8?B?cWVJYVZBdjd3TEVvWTU5VXhReFJuREtCblA4L0tqZEtmUVFJZlNEUzdVZ1Qw?=
 =?utf-8?B?czJ4a0QzZlJxUmRDWk0yVHYyQVhvYVc4b3M3NkM2SlFySE9TYnBQOHRNbFhL?=
 =?utf-8?B?RkY3L3hNUHQxZ2pQVk05YkJKUXU5Y0NrS0VWeFFpNkI2cTltK2VXR0NxaUZq?=
 =?utf-8?B?OWdUcHpLb3VMOGFCQlFFQXU1UHJjN05mc0tqK2YreXZpa1ZMSHpJTkFCRzhq?=
 =?utf-8?B?VXErOXRsTDlUVVlGanZhNHlyclRtblJLaGlFMUxhMTJNSGxCQ3hkRmt5UnRi?=
 =?utf-8?B?bjhHSUZFeVNneVkxTHVBMkZ2Z29uQStYcXE5WCtvYnJoM1Nkb1RzcXVwRUl2?=
 =?utf-8?B?aUVpSFpuRXV5Y01RMFdpMFpGQjJLZjVnWU9WQ3VITkkxRHN1Y3FHRmwvME0v?=
 =?utf-8?B?dFpyMWxneGRiM0RyTjlZUytwcUpjRW9DSEkvQTN1MldvUlZJSk1lVWRTcWRw?=
 =?utf-8?B?MnY0MjRRN05LNjNmV2dUWTNZYU85U0E2ZWRDOFg5M0R2WTl6bS9lTk5EK1FB?=
 =?utf-8?B?TEFWaWU3VmFFOExRZzVHU09QazRrQitsdk9zSWVjUDBNOWZFd3Y0VlUzdGNm?=
 =?utf-8?B?eHhudDE5OXdQV1ZHcjdYZFZ5SW9pbTJsRGlGUzFMQ2t5aHBpSk01U0dZenRm?=
 =?utf-8?B?M0RvbUpOSjVHM3FmSE84S0x0WEVIM2l3aXV0dVJYbXNndTdrZWxDSURUeTJ6?=
 =?utf-8?B?M3JOa0ZaSzE4ZDV0UkZ5VWh5VW9YS0xSeXZndFVvbUN6UDN6WENlWTRCMkhQ?=
 =?utf-8?B?UHduUGpXNExBODlIUnViVXprTWplTjU4VFNQc3NiTklHV3FwNExNTU5RZWtl?=
 =?utf-8?B?Z1JtRkE3alBUK3lDenZsM3pLRVNjM2FQZlNUN3RUeGNURU9uNExTM1BPbTc2?=
 =?utf-8?B?SlJJaDRlaktHdURsTE5oTVRNK1hHV09QMzk2Y0RMRGNCZXkwTFU1THdoRzla?=
 =?utf-8?B?V3FkTkhDN3FQT0VpRTB6aGNudUo5aDc1ZjVRRmZYL2YzcjFHS3BVUkxkZEhi?=
 =?utf-8?B?eVBwZkRNc3JZOHI5SFNETUVBZERGd21TWDEzeUtEcEp6M2NuR1ZUa1ZmY01Z?=
 =?utf-8?B?Mk1TSGx0Z3hIUkZtNE9BNFJKSlI1RndqSUJqM3dyZUtYMHVuY29BQk5xTDEz?=
 =?utf-8?B?UnFodzJNU2V1MlpaZm1DNW42VGowNmdweERsaFhpRkNVcGZqekR1eWdZZEl6?=
 =?utf-8?B?UjFxRmFwczZMQUVGcVhsMVRlMWpSdWNjMXgrc0tBeWlsbmVTK2xzL3Z1SW5w?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pf9I3VdBI15pUZPYfey5JD+jbRRwBumsjshxkbfE95UPElDxECB7w+a0Xloa8Q/RpnuDRD9l0D/I1O2gg8tBu4LJPPP+Qqs5hskGbV44SlNrox5GOSM9dht6sYPe4mNqFhMqS65ybt0P0aqB7g7vAtpsycZAkx3UNM6HyAogOsNcwEQPXoQUAqghyrm3LPGpIiB1+mqRInsSZLKRSP4Yb6s2sZnjnW0gjR5ofxyvfKzIPVXtP+yqZFzQa2OAZWyXkIkMXKmCEKLujQInpixtIcK/X57fOsyzMUkRxGq3Ij3qGBk0NXqgf7NqxDZn9ENOxoUupzohqulRlSTlPMLzM5K+/uIZDlgmJ2HsUMmxJIje4l47lwR9RO98BK5xKDfGQXuE8SgdxQ+X3SUBnWzSHxtiYZyOpDezHwleH1I+MP0zWdpc77xqM/eO891Hr8vhygYQYX7oRbxdAlCbTwWdbN90bGssaZ18bitIvaj3OwfSG7d+bAcZrBx8hW4Aubd/GfugW0agiO4j08XMvNvylgObLpJvewTwtsAeBCE2nLnz+ecgIKocwFOwWoXFKUAn2ISsU+5OfyHq6ggOrho7P1yTUNE2aDlN2j8GDdivWjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239e006c-76ce-4df2-cd0d-08dd8240cd0d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:28:18.8282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei3wG2ic3CTdpiPp1SAhJ6Gt57GZsV4lT+xbqBI9G7q+BzbgK6cir9vUX+Mx+Cw9xXlqA0DVI5Woo7IJHatcug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230057
X-Proofpoint-ORIG-GUID: ZEoEQrxQYj7K5UTTV1JDe_sH4sw41A7N
X-Proofpoint-GUID: ZEoEQrxQYj7K5UTTV1JDe_sH4sw41A7N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NyBTYWx0ZWRfX43wKYEGqIB1h 8TZP8n0LNKPXRUG5GixXHPUtZSjqxIUduJ9GuGeGmHkzPd9/fiVQKdOJugDBFUxmB/I4/MjcgU8 eNOQ/RTHXS04tOkfrHsCmFIp9pTwn2zEU9CC7UoTLn3ptYlbuYdSB1jgROnMP+ui4zoSTzbdf+B
 G1yGPMexZLz4POrSKSlKDrg4sIHktOBnGb1YubK5UHKqBEM/sxzw4ukTDZU1x8N3/WlFS9rJIcI Dbra55hHbmHJ8NS7wkqHpyG6u8UaioJt2cOxWx9K+sixrg+BGZpg/nO6VSNfD1KKlIpWTazDjiw ldXWXnJF7Xx3fI1NTcAKgTVa6zEhgB17HRvx8wqt3HPdQTdcnbsVBhJL0OFqrr9/6uBjOKMGhlv FE1x157R

On 23/04/2025 09:10, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 08:15:43AM +0100, John Garry wrote:
>> Ideally we could have not set them in the first place, but need to know the
>> blocksize when xfs_alloc_buftarg() is called, but it is not yet set for
>> mp/sb. Is there any neat way to know the blocksize when xfs_alloc_buftarg()
>> is called?
> 
> The buftarg is needed to read the superblock, which is used to determine
> the block size, so no.
> 
> But maybe we should just delay setting the atomic values until later so
> that it can be done in a single pass?  E.g. into xfs_setsize_buftarg
> which then should probably be rename to something like
> xfs_buftarg_setup.
> 

How about just do away with btp->bt_bdev_awu_{min, max} struct members, 
and call bdev_atomic_write_unit_max(mp->m_ddev_targp->bt_bdev) [and same 
for RT] to later to set the mp awu max values at mountfs time? I think 
that would work..

