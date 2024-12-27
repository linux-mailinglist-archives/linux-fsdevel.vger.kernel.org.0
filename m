Return-Path: <linux-fsdevel+bounces-38166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77E9FD6D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 19:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D4F188645D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A3B1F892D;
	Fri, 27 Dec 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UybmpThP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SWGsAXur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F497080D;
	Fri, 27 Dec 2024 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735322404; cv=fail; b=QfoRMf9+1TCy4bW2jqWTsmRoYm+lTbK6CiHbhXueumuUnSI0nSzDb98qIKhYfvpreHqTQKy4XYVa0f20Vs4qGjI0wsiANkedHk99z+I5ayg9dg0WbCE1HXqjtZEvZP55jdQlq8p+c0F+UuzKSGksigQTiFLJD29yYXyf9XQvwwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735322404; c=relaxed/simple;
	bh=tEX8hpa7f46ktKJGq1wJ2Hwq9ySsmgOT1vO8Rvfw42g=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=c4Y9tZfPYfT64IzD8+lQKpYyxvuKk72YdMkAzVsdCvbmboZdv9N14AC/g2VpRROnqVEN7GWQ4pb/P6p4AbKn4VFsttgqn4VUrrZo3sYdUnyV6CK3/yBr6RWcda38Kul4mEICkK+4Ai+Nl/W1shFX+YzH+3ICT772/yrilQaokZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UybmpThP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SWGsAXur; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BRDvMEY024792;
	Fri, 27 Dec 2024 18:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZTjwgvVVkPXekMJuZXdRTq+Pf2uRG0HqQdhuDfjyLHg=; b=
	UybmpThP5HbHhz/xZ0bD7hfiBOqZC3YN98upIbg7qeNsUs1loXfBFqw45c4441c1
	sw0J+VS9zny4Ysq4DDhMZ2kosLjy6qDzkhFJAvMuhaqFusnbI6qP1xajn9Pq9Mk7
	fpczJRA0132etxQzPURCsm7D4q5cfI+tGvlaQBasBydam/BRxcOZ9QoRDNb++mwk
	Ae+66xRC8xkH8SmLan92JwaibFydMoSMOF3IY0N6RcHoGhsCN0tMUNdPHUvLxOX/
	INrLHdQ9AFZ1yCZEbyiciM0jRltx2Usg7X2iY5N2A843a3oVN50FRuZWjALPd+pc
	8RoWc9hT0ZpdCoRXJwvTRQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7rqk6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 18:00:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BRFPM3Y039142;
	Fri, 27 Dec 2024 17:59:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43pp6nscfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 17:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxGnyUSdHRPWrqmQNxaBY4GC9at/76/McPYfxBaA2pPegMf3q5Fe3i7CJ/m0q1r4csW1WuOO5DGPUCgy+RG+hvtNQSzYvBARYbCAgV9FsjHYPaN3wSu8ua+JbGWj2caYWAt5xASnIr1oWFK46SVKrCW6ruwCPjrYxeSgf4DX5okYxZWP+mVLtdDwJMw17R6ePeZ+qlvtnSMjuCvO9RBUnDl5pVWMvcH722TzZIWMSguq+YqqyFlY0fWw4KJOQXz4lVO9LzFJJdaV5UD7pIiiPKJ5iNa8hNLc1JR9dUxOvnKsVQKusAHqbDzOqxusOu9VfsShm1IbARqOoH2kpqrRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTjwgvVVkPXekMJuZXdRTq+Pf2uRG0HqQdhuDfjyLHg=;
 b=KtDZa7V000sf3jjvHASJbNyPBPAq/HBvd4yAGN9iwdoRlODS60Wj2bq8htmk9SfP5ZgCzD5jGhPDsXzzNGJASU5/9dpgPxkDw9ZH7faJzIJllK7Zuon+9F4JQUA1TzG+apppEaHP7bTFxRVtCSqnTeH99eALysM2RN/rAMBJwbkrdErLNzYpXRJoT47mi9YXBOMV78aEjnOXcDqZ4aks2Fh1FoQEc7gG8BtA+slABeo93SgLtPt4eqBMMVtdpjMXSvIvCJVfgTsamNz1JMeAx1mPrQPr2m8y6gwsws+4LPjnD/yoNZx5h1fTP8C+uPxe3gI/PSW4l3cUHVYL+/cVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTjwgvVVkPXekMJuZXdRTq+Pf2uRG0HqQdhuDfjyLHg=;
 b=SWGsAXurHZ08t6uTFgb7BS74VcYDer7upiL8yOxFm+FUVBkh7dCiAY5CN24OOT+MF7AHbfeNIXjPLhbvtFfFqBbbIjB6gK0RHjD4Vz+lLqz1g7V/DDHHo/JUUPFqSX90VZERVaUwMk8pUps42PTlTJu86LPMDIcIZPw1sYlhXpI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 17:59:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 17:59:53 +0000
Message-ID: <87ba8ce7-7c2a-4a9a-b91b-69d016d8e951@oracle.com>
Date: Fri, 27 Dec 2024 12:59:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] nfsd: fix initial getattr on write delegation
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
 <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
 <CALXu0Ue5f2XKSSYEo8N73DRJWVNJbesO_17eRgbSbAhXVS6v2w@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CALXu0Ue5f2XKSSYEo8N73DRJWVNJbesO_17eRgbSbAhXVS6v2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:76::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e92785d-8792-45dc-4111-08dd26a0440f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkgvSE5BZEVPSFFrVHVKSXdPYm1tVnlSeG5PQzRqd1BCbTZpWTBOYUg0cHY5?=
 =?utf-8?B?SmNwaHV0cU9URlJLSEkrbDl1S1dtcmVZR1M5dGJaTTdvU2dsWXl3TGRYS3RU?=
 =?utf-8?B?ZWw3QStxdzcwRTZROGVZbGNZT0VDb2hhODlYR3lVbndCTTBYY3g0RW9hM0dm?=
 =?utf-8?B?OFlFdjlweE9UTUZOWTl0MEV2NjVpc0c3cm9hdlBqN0Q5MjQ3QzkxRFgybWM4?=
 =?utf-8?B?MVJ4N0N2cUlpUndBRXQzcC8xOXJqTXY3Z0VNUDRnNXVyYWNOblN4ZmpVL2Uw?=
 =?utf-8?B?cjQ4YURzR2pvVTdDeDMvSG12MEtMWWhWaUdqUXUwaWVXbEVka0FQYXViblV2?=
 =?utf-8?B?MVYwSUJlT054ZmdMOUVLMHJ3cEswc0tYMmY3WVJtNnlHUFljNUd3YktOSzdW?=
 =?utf-8?B?T053S1pWRHozUTFhQ25rRUVjNkhVRzFOZjFNOWFhNUJ6aDNCdUdmOGVpY1FQ?=
 =?utf-8?B?QlMvKytqbXFERTkxdUNZYUlsTGpzQ0JTZWtnQm9aSTB0QUlIck1SS1FYV1lh?=
 =?utf-8?B?eTZXS0tibTIyTjNvQ2lxQ1lMZjVDVmpJWVlCZDVRaUxTSVF4ZTA0Mmx5bDlm?=
 =?utf-8?B?K0piNG1UejMzd0xNU1BMNWRFcUQ5eER4bzJkeWJhV1hHaXUzb0RRNHdYaFZW?=
 =?utf-8?B?SWwzZmY5K2pMdm52SGJoK1Z5OEd3OEpmMzNyUWNWQmxyS0ZEWUphbkxZczU4?=
 =?utf-8?B?SEJVY1RvSmtncW9vUXFEcHJBRldpQlFSVzNzblFxdm41TnhLN1dNd2lzd0Y3?=
 =?utf-8?B?RHNhQTFUOGpwUUM5dkdhbXVvYmxVaFdwZXJwK2REVGRrZm9iOVNmTittNDVw?=
 =?utf-8?B?ZjlBTEpDbjh3YUlhdzRqbjErVU1vZ3V5dFEwVHhiWm5rR1RHcmRQNFJuOElE?=
 =?utf-8?B?dHZwZWYxTzJBZFVlZ2xMVElNZXhjMTFIaGNpQjZXNWhwSVdMdWF2S1cwdmlz?=
 =?utf-8?B?QUUrUWdqTURwUTlzMmk4QmpXZDFpYjg0VDNKUWNJWFpyY3ZOdXJmWmoybHJX?=
 =?utf-8?B?cWFaMG5kd2lpRi8rTEw3dkl2NElrQytiRk9zYW8yTU5YRThCUlI3NXdQWHBz?=
 =?utf-8?B?Y2wzYnBZaTl0VjRVQkpQeHFTbFVvMURZU0pHK1ZyekZZRmRyUC9LWDVRbWlk?=
 =?utf-8?B?T1g3eDdBWmxDS1NERUZBcUM1ZEFTNHFoK2Z3WDh3S0dKSi82NHV6QTZaMHZi?=
 =?utf-8?B?Wnp1WmRyQTBLNEhIaEpHay9BZWVnOEE2UzEzUGxaTG1IMi8xVVJscS9UbFQ2?=
 =?utf-8?B?anFDK05jRTh1OWwzQ0t5NGxudUh0NlF2cWo4U3Era1FvcGhhaldiV3NGRGlC?=
 =?utf-8?B?MTJsYTJqU1VCV3lOV00vSXNORDAyVTdKZDJOWVVkVi8rb0Nrb1RiUVY0dGRY?=
 =?utf-8?B?ZjZhTExvWThINnVER0hSSHRGNWcxUVMvYkRNR2QrV1RlVmdNWENwRHlraG5R?=
 =?utf-8?B?M3FtR1FXZGxzT1VGZGc0eXJJVCtxUzI4R0N0a0VtVGI2SVdDK21CM3BMSVNE?=
 =?utf-8?B?djU4WXR4UHpVbDg5NW1oTlZkMTBxR2ptZ0YxeURxQUhqMEVyNloxNTFKQURs?=
 =?utf-8?B?cHFicjdteXVuMUJHbmJuSWFNRGdSNE9PNSs4YjB3M1E3M2dSbEcwSlpSSnQ0?=
 =?utf-8?B?bm9xeTdVMUhrS2pidGpHK2NmUVY1UDZkZDNkWnJaTHRGbWlNMFkzN09FMlNz?=
 =?utf-8?B?L0N3U29yT0dXTloyeHhDRnRDWDFOemJIUll4dkkzYUFETEgyNkNndzZnWkNJ?=
 =?utf-8?B?Ni9qSEdhZGJoSFBlRVV1ZnpiK3h1MWFpVElXOTlaSElhYXFtRkd2djFSZXE3?=
 =?utf-8?B?RHRDcWJBU0p6Z2d5VDFBc1pPeFkwNjNXY1pRZFV1b0o4cWJub3p4c0xhTnpa?=
 =?utf-8?Q?5QWF/WsF9AHw9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEtTY3lHYTNHUjZEa2xkVGFtcWxkMDArQU1jRFRLWDNYRkhkNWRwY3M2K2lu?=
 =?utf-8?B?ekJybTZ4WGtmUWpkaFhDbE5PaWdTMDBqUGZGTkdEWmJHQm5LMnpyLzI5QWIw?=
 =?utf-8?B?OGdCSHNQamVIUHAwMGNsekFQbEYzUW0rY2xmK2IwNmJrbW1pYkYrb3RvdGdC?=
 =?utf-8?B?dW5mMEdKaTNNdFllN2FVcENQRXJTVHJjeHluZHhRUWlsL0d5a24rajg5czZm?=
 =?utf-8?B?UUJCRGROakczL0RXNWNZYW96VlM4eFpYQjNIenYrUW1nTnl3RTRyZVhoVU9a?=
 =?utf-8?B?K1NRZGdrK3RXNVNjVzVRRFdvYVhSa3NGeDFObkU0QmNKSzFVWXZ4QzR1bitP?=
 =?utf-8?B?ZGNEMDRwN25CcHZrUXZQcnRXUE1vWTBBYnd3eTZiOERRU1l6MzZuKzBTMWpR?=
 =?utf-8?B?V1hZR2hWQUR1OEZTT3BscWgyaUdrck9FTFd6UTZBWHJuQmsyYTlLZE1FL1Va?=
 =?utf-8?B?bDZFZG03d2NGM2hMUTZCLytFV1BOSWprU1B3WjMvVGR6RW5XbkYxZU8wOEtV?=
 =?utf-8?B?VVhOZERCbjJ4RWN1dGpyS0pGc1dQZnZZU3pNTnhYSDVKYWlLNVBLK1YxM055?=
 =?utf-8?B?NXpNMVJVb3hMY1ZkdFVMbXZ5YllBRFZIbjNQQWVJaG9VN0lEdVkvckZaaEVn?=
 =?utf-8?B?Vy9oUWp1MFJRTTlzaVNCbnIyWkc0QnF1b1YwaEFnd1Mvd280UCs3UStCd3Uz?=
 =?utf-8?B?bTFLbzFCNnlsSTJFOUV2MGQ1OWJFaVpUUUJtTUY5eVhUeVhxY3NWQzNOczk2?=
 =?utf-8?B?dXlpSTRUa0RMVmJpZDMyM2d2OW8vTFZLTmZuYmFYdkFuS0Q1Z2xrWEtUS0Zl?=
 =?utf-8?B?aTlUSWxyeGptYW92SWZObUw1Y0hBSlE4RkFERTA1c3JHM1M4RVJucGNndUh1?=
 =?utf-8?B?Y3ZmN0JxN1R0eHhmTllyYkNkRWNDcjBTWG02NGtzbmxtY1hxN3NYcE5vTHQ0?=
 =?utf-8?B?d1hla0s1TkN1VGxBd0x4dlRBR0NDYVlDUEk5OUFzR0lsZE43OVVSZWJiVVBk?=
 =?utf-8?B?d3A5V2g1b0NYVmduYnNlVUx6WkVGeHFzZFlXWTJKOEtjeURCaDVQMnJNKzhW?=
 =?utf-8?B?Ym5ScEVkSkxONTdaeDNZMzE5VndycFFoakFzU1dFOWVxd0hwTWVxYjRLdUtk?=
 =?utf-8?B?VFNJNTk2a25FRnkrNWV4TTU3eWJlaGhJMkc4S0lON0NUZkZoeUJCSlBKdmNu?=
 =?utf-8?B?NUtxdzFwbFRVWmpoTmw0Z0tIR0x6NU0yWW5Jemd2dzI0eDNpQldJN1FQQWVj?=
 =?utf-8?B?cWQzaTgrcUFPNm1LODV1eXhQeEkyWGhJRzlRSmk0aXdCSmxLcDVqTkdZR1I2?=
 =?utf-8?B?QnNLdmZBcklJL2EyTGZZaXZBZGJMOGRST21wRmpRd2l4dFRuS2NXVFNNOERy?=
 =?utf-8?B?aGtFS1hjYm5malR1RDZoWHRuNnBVQU1DcDk1ZjE0WUFpZlkxU2N6Q21yeFll?=
 =?utf-8?B?MUE3dVVBVlRDTFZwcVlCRENTYUhESTNtMGlOVitMcy9VZGRnL3oxN2dGL1hM?=
 =?utf-8?B?Y1ZURmFHM2xaTVVCUlB4b2dvNFl4RDMxbUl3dW1IMXZwV2ljTXNjRGREcERM?=
 =?utf-8?B?d0dtbkRpSzc2YWJYUE10Q2VZWGYxVGRhblVtSVZwMzFaN1kxZDV1YkZtK0V3?=
 =?utf-8?B?eHArdGZxdStUNGRseUhGUGhqbEQxN242MzhXNTA2YjNuZWVOcDFOUENENEQy?=
 =?utf-8?B?N2pKNU9YMm41VlNPV3IxK0R2ZjdJSG9BbXhjRGpBSDNGMUpZRlBvcnE1QmUx?=
 =?utf-8?B?WXQzMG91UEpLcjhMNitybzFxNVZnNGRBci9xZ1dMZ1JManJJMVM5MFBvUGhL?=
 =?utf-8?B?VVkxckJCZ1hJZ1Rkd0hlWUJBTWFJclN4M2RGQWxSQ0p1QURua1FKNTl6aTNk?=
 =?utf-8?B?NS9LcXdqbFZMcE9PS0R5cWliZmxIUTZmSjBUN3hNblV1Y1RocVMrZlJhUjdx?=
 =?utf-8?B?bDJRd1ExQWhDMm1tTlNMYUNNKzJkUk1IZDNOZks1aUhITXpIM1pGTjJxMzZW?=
 =?utf-8?B?ZGxCUUhrQ2NqYW1xWVphbUR1bTk0Nzdqa0owcmlSNTJ4SnRXdy9QZ3JnMzkx?=
 =?utf-8?B?dmR5ZGExM0VsdE5DVnFhQUU2NXlWVzM4OGYxRW55ZFNuTm9HYmI1dmZCVmU0?=
 =?utf-8?Q?5kIJG8tpY67HLXig61uiLJyKa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rUBCF7/regVBYJnWplCsV+bZanQhq/nwCiZjNegoqg8KtINpmwBD8PoRPjqpdDeJvv+fmY3iDPQKHTvhMfc70wKsYaj5kg+LpmKcAWK1kvHhLkIdAlEbw3d9oivzJFlYWK1O2CFcc2YgK4tQgxK+KAlLuUBkMl9AEQcd75fS3zoLckzmuOucdhdDkyakt//Zuuv77lCmJ9bNL64beyb8Uc9BWvxYtJgXXlXfEJWsx3FpbXIm2yQ3AKuap6gmLXvoDticlAmTiu8wyp12pVaeuszHNj3xav1/MdWC+9zo3DblvQij6vzAgP5RyWBZwmpeiW1hrpcvD/RMYNdlJ/2mavcG+iZ7qrZ8yprL89gU0RIle7ZdyUM+2vvvsBEsuFfP5F3M57TAe7vKQIU/iGKu9WKMlmFrdJ31IOyMlZ+MSAEfZzf3sl7H0UT7MhAT24LH88798lKonvnxvVmzHSuzeZnbyRrqvp6vmIWyYqDIsupDUrC1MinKEJC5HZ3JokuI2egfYOuzAPUJnWQsvMiGy4Np2QxfxBc1YV2LMMscAGMjP3P4irNgbRWhGguKgDgj33iji8jtCpcjTSOdwh4XMo/eHLfW507hXwlcD0NHSTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e92785d-8792-45dc-4111-08dd26a0440f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 17:59:53.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32y653Q3PjwGhJeor+Q6AHJK8Cgwo69UH8o8Yq630XXdoWi5TRv97gRGTCoptkVa9b5UkSS6vH0G2K6XTdYPJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-27_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=959
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412270154
X-Proofpoint-GUID: CJEzQZa0kpQdgwgKwe6ZMfe7Au9zFkbU
X-Proofpoint-ORIG-GUID: CJEzQZa0kpQdgwgKwe6ZMfe7Au9zFkbU

On 12/27/24 2:53 AM, Cedric Blancher wrote:
> On Thu, 5 Sept 2024 at 14:42, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> At this point in compound processing, currentfh refers to the parent of
>> the file, not the file itself. Get the correct dentry from the delegation
>> stateid instead.
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   fs/nfsd/nfs4state.c | 31 +++++++++++++++++++++++--------
>>   1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index df69dc6af467..db90677fc016 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
> 
> Is this commit going to be backported to Linux 6.6 LTS?

The quoted patch is

  
https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/fs/nfsd/nfs4state.c?id=bf92e5008b17f935a6de8b708551e02c2294121c

in the master branch of Linus' tree. This commit has the following tag:

   Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write 
delegation")

Commit c5967721e106 was merged in 6.9. Thus bf92e5008b17 won't be
backported to kernels earlier than 6.9 unless they also have commit
c5967721e106. It looks like 6.6 LTS does not have that commit.


-- 
Chuck Lever

