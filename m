Return-Path: <linux-fsdevel+bounces-47700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FF8AA446E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 09:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F005A1895012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422C20E334;
	Wed, 30 Apr 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L6VWgMbS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="III6pEct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6F1D88D0;
	Wed, 30 Apr 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999544; cv=fail; b=pUZFdohyxU42fDHUB9+S9dUpKyTR3u/895AyWKVewYOGLuA4B+4mSfDYp+g5xnAp+2vOpMsIv2+PZKWPrP9x66bjx++vnz7bcr8kT6wp+LYS47BsZJoH9LUFqb9NhJwVgNw/aNqPEv9//y3IklH+1Vku14D3qkHwNPmDCryLAfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999544; c=relaxed/simple;
	bh=i7a4bF1nB/jGrOhGjxAfRinmoou22zMVSD7k+j6OJHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1WSH1UfBryIWTGD3BDz8XYxdgVeu+W3o1x8b9WurLaWu3tyVjxxQqReNlacyxvsi8jDFH67uQzQwSiaVxsoVHmTjslVwLjzFsesC/kEz/V4SW4BC9TpP3kbwTF+BLm4OmdwEsoEsRuWLYqbdXnYZ62fJiXqlRo3s7YIkwCOrUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L6VWgMbS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=III6pEct; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U6QvtQ008436;
	Wed, 30 Apr 2025 07:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=s5rWyrEwvVWGonk2ZJd+stV9Y0TR+kX7/ZxvUfWEpXg=; b=
	L6VWgMbSrE55c16O21Z5Ah0e5iysdXjLbmHyrSfPvoDMQyqMEs10AVL89ROf8jsa
	6EApLQ/eDw6jKilnPkhfw690bsUNZuZ0/8nsm7nCqQDv2BBnEHD6eC9fryaEDT5J
	4BdEflCqKB3A35nh0528mMisUzOmDhBOz+80s/1ey2JS75jBrSuuqUssei/74R6q
	KRaXio+PJZBy0JMTSY/jDUerqlnlVU5TIuer/16t/RQHix4Z3GsdKT7SW2fhAmf3
	eCIvZLjwk06q7EaTZQTowFQyGQ6cYsfrpz6ahy/ANFAqwiGcS1h2W0Ie04tNHwza
	ZjnnNBq9PUrhkAVPPzfzsQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uugm7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 07:52:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53U61824013828;
	Wed, 30 Apr 2025 07:52:08 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010003.outbound.protection.outlook.com [40.93.10.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxb015v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 07:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOLV6g9w6XY69Y4s7mosxzcvHXyxd59DmZm8jTsnUMMLrrdHAFds6bPZ9ArBS8nFh0+QTKovy2JWQ8ZVSyfGlk1QztLh0lQ/qNNTF4x1DZC8ewBOb2zLCSJsW++9gf56PaHRp3KF56Bmys9ZiS6vrG1kdrQ+OP33aWHmb4tOQItdOyWhPVCXoeQRBuWbR1M6XIB7JkOnLZ/uA7k8u1YLLI6FxK8nA4QLx3LG7GH3ndGV50R8GKZLSisRYEjKSNIb6UomIMMeYFNN7TqORARAxAFWwcBpAnW7JhlqryoxMGy0qIRp3MnK/sj1uKvisy6DOB87Rf8FdWGPNOoE0qtIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5rWyrEwvVWGonk2ZJd+stV9Y0TR+kX7/ZxvUfWEpXg=;
 b=oKyILKkKMZ1af2/Np40qbbOTIXvbIIlrbCs5zksjwE00D5YccJotg0lHSjM7NIZcVREVpHFVkZO07Kbzl31omV0Kbgusyx3jvda7UwZJtvG+IyUD3HLF3DokBwgyb4bzlv/1UDzWwH3J0/GOMZSHcIF0QWQFWbcm8vFjqPYY47yJMV13bd8LV2CisQTE1gG7h53lxHkdvgrS/6CkJ62jglkiQRI9+7Ou1xIMpYLi41WWyZokm/GVibVElaGEUNyM6qFStTbSesHxTjRIVVpvNU3h1kxkatCqpG1vJyziaobtEsufdRisE5seBuuDko2pzWTP5ZaxMonK1lpnkMRuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5rWyrEwvVWGonk2ZJd+stV9Y0TR+kX7/ZxvUfWEpXg=;
 b=III6pEctLILEPEPlHo8Nb6Qiewhl26/WwM2YuBiKbDWxKRaP7SB4cb3IRcMSPzKZ9eoIX3mc/6fR7cb/bVvQueCmqgxsfd0CHuyMhwTEF3/d/4fuwZJzhdKskOtkSTq6NrrTutZa1eWZes5K6lZDumyBSm4DPupOa+3Y8mPT05k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 07:52:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 07:52:05 +0000
Message-ID: <a8ef548a-b83e-4910-9178-7b3fd35bca14@oracle.com>
Date: Wed, 30 Apr 2025 08:52:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/15] xfs: add xfs_compute_atomic_write_unit_max()
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-14-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250425164504.3263637-14-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0239.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: a95188d3-2f09-4eb8-c30a-08dd87bbe634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhZdDFMNGgyZ1lkdnl0TkYvcVI2anQ5bndIZnNTWjZMdDBNTktSbGRucGZ0?=
 =?utf-8?B?TzlMeTdsTksrRUsvUjZ6NUg2aEgxY1lYanNNME5ucmg0WVlya0xPdlQrbW5w?=
 =?utf-8?B?OS9SVVRUSTZ3bCt2bWEya3dsQjl4ODByQXowNDNmSHRxOGVkY0lCUUVUVlFT?=
 =?utf-8?B?NGc2b3luMkVpTEVpR3Y1NXROaXgwWEM5dUF0MUV1VWtkUkkva3VXZXdzV2cv?=
 =?utf-8?B?N3Q2akxFUHlkcGkvZHpHcGlSQWFsZ29XSS9HZm5LQVFOZzBOUGhLTWpkWS9D?=
 =?utf-8?B?TWVpWGFWd04vU2xGek0vaXFWbStKVUdGUFBYOVc5VWYvM3UvdDh3QityL2ZU?=
 =?utf-8?B?M1E3SHZYYmJZUXVXQm1TZm1kRGQ5bDBNTDRkTDRYRG5TU0FGTncxcjFCMFVZ?=
 =?utf-8?B?djFPTFJwMld0WklwaWdBZjdJTkh1dktqRHU5b1RQVW9RclRsYjZNdVJYa2k3?=
 =?utf-8?B?OS9PVlAraE5kcnR3TENPSmFlWmZCWEM4aEVCYXJxL1ZmTzBuaEJEOU5qQUFs?=
 =?utf-8?B?NFpUQk5wK1ZhT1djS1VnbHhaamNCcmp5bVo0ZTl2ZFdyaEo5cmdJYUxWSlZB?=
 =?utf-8?B?L1IzZHorL3Erd3JHMkdPcjJVMTFiK0NTOGk0R2d0KzJwTXdzSlVtWUpoSU9L?=
 =?utf-8?B?YkhBOTdGaEg3Y3dFNFdlcUU4RDlvZy80UlIxRGoraTBqbGhrQ01MNDB4Smgw?=
 =?utf-8?B?alZabUFJYXNseDFoU0k0RHVHcThoVUwvWTJGQUVWWE9rbWFSaDRxaEwxVVJZ?=
 =?utf-8?B?VXB2cWlZUTVWNzVyZGZEcVRHaTdINU5OTGN3OHdoczd1d0IxVGo1dkFyQ3Nl?=
 =?utf-8?B?b05VYkFLeHc1dHlIZHcvYmhVdDdPenJBNm5xSkNUTVl2ZVQyQ1l1VVdhejBl?=
 =?utf-8?B?YTVxaWtUT0xMRUdnVldGbzNVUEZUSXNNTC93ZmQzTmtRRk00cytxVzJTWHln?=
 =?utf-8?B?WENnY3crakp0MzZNVjlSaEgxbHJ5c1Q4eVVqY013cUtSbi9QV28wOXJmOEY0?=
 =?utf-8?B?bktUdzNncE5ZYnpkRXN5dGlMUDlYclZXcm8vOTNSbWJiWk5EQms0SGVhR2gy?=
 =?utf-8?B?V05IMVkwVmxVT3FhZzZUTUNMbmpCakVYTkRYeGZ4SlBXSHZtZ0Q1Vk9PQ2ZG?=
 =?utf-8?B?UFZXT0RVTENKaCtEQjkzTFhyT0hsTlluTDNxTFFvTHpSek1aOWVGRlVPRWZw?=
 =?utf-8?B?ZTE0anh5N3dXL2VJOFAvb3pucmJta0VWamtHZS9jT3NsTU5SMWdSVnZwL0tL?=
 =?utf-8?B?MFVwSFZFSEdvdVM1WTd5cTZQSHBzV1lic2Jac2JoZHZnbE1LZVp0T293dE8y?=
 =?utf-8?B?RFFxVlhxRHpDYUZYQjRxa1ROOC9qMkpaQW0rWlBYSXMyYXVrRmJKSHJFZFpK?=
 =?utf-8?B?RTQzNVFKa2FKbE9GWnhLM3ZqRldQa0gweUNkZ1FNMWRLOXZRWGdBd3pIaTFp?=
 =?utf-8?B?cHlWb1dSSlBzdm5scGlIeC9UaFJNRDJqRy85bW9SQlhEQXcrSzZTWXdGTmU2?=
 =?utf-8?B?ZGNFUHhjZi93elNtS2VKbkk5ZndsT081aTdSYTY4Lzk0VjRDdFpHTDl0MWtw?=
 =?utf-8?B?REFudFVPOS94RjEwMTV3cTRBUjlOeDdwa2dMT1JwRXRpTnRuRlBBRXByYW43?=
 =?utf-8?B?Z0ZYZ3hQUjVqSUVQQVVJQnV3QmZ5NHZFdThHZkZXL0NzZW5taTRVWkQxa2lo?=
 =?utf-8?B?SG1KNDNMNlFyRDlVNGhBN1k3Ri9sK1UweTJNQWExMHRQTGRDQVpEeE5oa0ls?=
 =?utf-8?B?V0lLMDVZd0U5Nm50Mi93ZUJxR29HMkM1d054WGtGYWp1emFSSzhCK2lUY05G?=
 =?utf-8?B?MVpOb215d0dvdVBhUVNIQWExR2J3Y09MZEU2eThpdlNFSXlXTjMxdjVKUnJx?=
 =?utf-8?B?bUg4YnlzdGRUckxSeEVpdEJ1bSttZlR4TmRxT21Lbys4a1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1dQa2tWOFNSOHFMaXZybWVmQVQwdlByS2JuVDFxOXZHcEt3ZE02TTU4SGhE?=
 =?utf-8?B?YmRBUjlkQjNlOG9XNWdRNFFRRGdMVGt1RWl3K0xzQnk5UnlpUlN2ZHFBeGxp?=
 =?utf-8?B?b1dCNk9La1Q0QUxLM0RzRU4wb3ZIVi9NRFMrSDlveDBkS2lEUGVqaWQ2ei9F?=
 =?utf-8?B?VmtsNGx2ZmVtV1lKNjVOSWtKS3o3b3E3NlNSQklDTzhlT1pzRE1JaU91Ylkr?=
 =?utf-8?B?ZzBSSEEvL1JER1U1bEUwR0RXVHJPNFN4U09uTUYxYjRwS3FTb3Blc1hYOXE5?=
 =?utf-8?B?WDd0U1JuOVJVemlkNWpmTWs4cEp6VzhFc0FteEtVWkJERThOL3RGejY5dUQ2?=
 =?utf-8?B?WkJEa3lSM29SS2lZY05Dc2NyYy90SHE1Mjh2YUZsVVY4RXZHVHBHdUNqbk0w?=
 =?utf-8?B?VjB5ZnRWYW9odHRodGI5bVBPVmlETzlJZEdXalB3WDRnOEJ4dmdMdGFmOUtn?=
 =?utf-8?B?NU9ZcUdJdmpqcVB5Y2VIRTNvNXlqTzJmRVAzZHI1bUlQOVF3bno3OW5xVHEr?=
 =?utf-8?B?akZTcW85MnZsV2dXc1hseTBPK1BXSktLeXhVTDF1dGxrQnY3UndLR2dQbHB6?=
 =?utf-8?B?VGgrS2xQVDdmSHIxc0VOeTdIZnErS3VyQjJVMHkxRjFSS1hwRnJhUE5iWHJy?=
 =?utf-8?B?VzFhTmdTazFJRlZDclZGeUc3aDd0ZzQ0T3crdG9KcVJnK2M0dzY0Qkk4b0ti?=
 =?utf-8?B?WDhnNE9xTURoWGNTRDJBSnFJcUNGdDdyU1JSaU51Q0VzUU14YkpKZEdLblRP?=
 =?utf-8?B?blZmZ0NTRHNKU1RQNFYySUQrMmtXSmpFa3hhOGdaN0J1SjQxMkJvYURKYUVL?=
 =?utf-8?B?ZDJOWFJwZzdQamw5UjNEaXZnZGdqVHJRc1MvclN3cWpsdm9QMmowSjFiTWRV?=
 =?utf-8?B?Rm5oRXVjeXZtY2c4ZUs2Q3BNQXpRM1JtaGVqWUtkRFFYTFJvSE9UTkZkTGho?=
 =?utf-8?B?OGRWcFFqcUdjSFVwMGcwZzBZc25vZWN4SnhaSzRaZHoyV05oUGZtc0NhYU9K?=
 =?utf-8?B?b2JSdVJvaVdFVHoxNUZxRjhVdjZJdGs1eWVxQmdxRUdRcnlXMlVVUXpyOHVF?=
 =?utf-8?B?WE8rZCtUNnVodXM1QjV5alZqTmxwdktjL3NZYnBnUEtwT1BKdTExSnkxeTRt?=
 =?utf-8?B?bE1US1JWTEdkYUx4bUFwSnZtTW9BNFlTWVhZeXQ3TUhQZjVqTGo4K0lhYS9H?=
 =?utf-8?B?Q1djb09pbk9HTW43Mm5WMEhZeHJGdWpvK3dzTW9OeUdjUmhWOHJpeXFReXJX?=
 =?utf-8?B?djVtdUpSd3kzZSt2STdJUktmaXFNNlFsZ1NORlRoT2taVUs3ci9VWUllRHpL?=
 =?utf-8?B?bjRBT2kyQlJGdFhxSUN4emN1enBNZ25EcUdKYVVkbXQvVTlLWkE1UStlbGxW?=
 =?utf-8?B?MWhhMTJ4VTJoTDlBaTdYV0FrRmJtMnRqZE1DTk1wWk5XbmtJa0dRaW5Lb3ZX?=
 =?utf-8?B?WFZwU0p4M1RxNHRhUEp1d0ZJRW5yYkwrODhQejcrQ3BEQ2k4NGtnYTZ3OGRp?=
 =?utf-8?B?Tm1ZcTRCQ0U4dC9PVDNhQnQ3TTREcU1ZWGdxdHdsSzJwL0k2Yk9nVGpoa0Fa?=
 =?utf-8?B?cm9qWlFRRDc5RVhnaEszSE9DWDlUZWNLQmpyeHJ4YXJMWjZlZDBLd0NJZEFa?=
 =?utf-8?B?MUNzdndHQUpORW81Z2hlVHNFRGlNNUkycFlRZHFmOHB6N3F6TGVxbkdvdmpZ?=
 =?utf-8?B?SGw0UU1hLzBkbktlY0pXMkxTUGF1SjQxalR4eXhBdnoxVU9kRUkxT0g0Y28y?=
 =?utf-8?B?ajlTc1FTVXdJV3VIckJlbFlSZ0lXQ3Y5YlRTUngzWXRKRDZ4WUVjaTFNdEJn?=
 =?utf-8?B?VTJWd0oxNWozWisrRDUrNTBVMmhWTE5nL3h5ZDE0VXBaSXRocTJYZ3ZUVERB?=
 =?utf-8?B?V1N3UldXSWtEMWNBTDRPTEZLb1FpcTJuaCtsazJaN3UwVzI5M0paQTFyMkh3?=
 =?utf-8?B?QkZMMUhESnQxRDBVeUFXK2Z3akJBR2RISlozT1ZZQ3BQK205SDhIQzFidWlu?=
 =?utf-8?B?QUwwam12ZjI0ODdNVDJrb2ZCc2NlMTZ5MC9kM3BUYUVPaHhWQlZjT1ByeXhU?=
 =?utf-8?B?bFZpUUgvWCs4QmNpRFNJcHMrZGlYUjNOcUxzUUJVTTIvcUwyMG8rTHMrTlcx?=
 =?utf-8?Q?zhJeE3/U7ueyythdiH8n/V/Ow?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lyxS0CX9ydNSkYqWxwJe7aE0NtFg6HsI0LCh8kVYHW9EcVAzS5cQM2R79N6MdQNsPYFAozciUpBqVk2Z1RFrjByzOPp7AOpkr01U6xFRaobG+9t0AXvXoHsTXrF9SniBMrxMIgBfY8gO4nQoh+JDGu5vK8ZvFSQ8UoyhkBy6FQzoXDZxAHOKMI8E9cjDSWDBlrKYptTy5uXmaSsw70EZBp0xZ6fyJu60EHyDk9/gaaaDxI/kpwt/9H09PTA7ENL4xmU1p0fvHQw+wbf7CXFrnjVNQJ2LNu+9mvT0erC7cE5OgOIFljmrUhYnQZKMlXIzlIJFY1giXGEtegTkPB+NR4OqZRlKq1n8i/3U2IFXQ175tAXD1FUvhuqgIK6DWL9THUJaENC6BNrVWkuEufjrygpFH0CHK10FYLfIbTeAzCzgJgz+XCphOFV8aMjL8cJO3Ga4dtm4jfqRBx8OzuFu61wq8mNsdAYLjGXJZUJVZuhs9WdBfqGV9NUBrzbJlaSMAJyWcf4apr+Z4zGJHJTh4ttrJVinfdLpbrmQ+wG0LRM1T3s23tf8Dyj9TGQcB8JKcOOnDMrH+Ch5EOKdOgy3IWAoY5D11MRTnkaxO2Njgbg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95188d3-2f09-4eb8-c30a-08dd87bbe634
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 07:52:05.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVNo34XT72zI2t0OjKYXAUEt2RxgWWtLzhrgSENDCGwFooQPLe5aNxeBwqyF7CZ+QecDrohqP38mXvWmNz5ONw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300053
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA1NCBTYWx0ZWRfX0DnjEIxGHQxu 8a+n37BxDu2U+1MhdsCAU7hzOH4/wzA6sgx9scc0Oz4UDWFRF4Z7OE142QQafTS6k8YzBefxQyr V0I6CJTqtFiLnUSLRq17XKomSR0zH2Ty/0xuKxQwTU+S8mAuOEOWM80AakPoP63IHHT/oS2w8T4
 m1NSwSRp+zn0FoRRKAphaYkJLPvUXoLmJk6HC2x3cCU72c71Jb9h7P9cYQQRh4pKQkyHed9PvmI WsVl6azix5rpr3Pr/h+OJAEbj4540Qjo4bhXJkcvScr3jakCoHdq7UKy4pCcoNemBF/KzMy+3M5 Ps6sbJewr1gY2eYdi0I0qgRr6R+IMXmUkdgEVqHLJRDRgry+lFSCD6ozDVpmaw/J0akvO3Mg0gM
 ZPuCxMDvnljPizcBhbpjFUbwimn8qJ2kTzZ+S3YEXQbooEQYyNgzfka3YPimn6IsYqwE56bh
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=6811d6a9 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=Mbe5jph_HTKKUiXpZ-IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _BihqHxmRT9bGTaRv7eR0ooS3Buy3TuA
X-Proofpoint-GUID: _BihqHxmRT9bGTaRv7eR0ooS3Buy3TuA

On 25/04/2025 17:45, John Garry wrote:
> +static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
> +{
> +	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
> +		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
> +	return mp->m_ag_max_usable;

I think that this should be rounddown_pow_of_two(mp->m_ag_max_usable)

ditto for rt

I will fix (unless disagree).

