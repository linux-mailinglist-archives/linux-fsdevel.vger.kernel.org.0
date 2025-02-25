Return-Path: <linux-fsdevel+bounces-42570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27B3A43C89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B58E420ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C6126773B;
	Tue, 25 Feb 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mbuReyhb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MC9qwU2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA66267389;
	Tue, 25 Feb 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481195; cv=fail; b=nRKmqMEeXXrC5sp89rp+ALWOYP4PegmjYOeEDGkpA19FsQD2BZgbjKXFPOoNNcCaiDJgv+3kQK2wO+0S2KLOWb0Fy0XI10yTFHzO0DBdPAzgvE0p/nBTaZACE1A2XsWb00eazvEXwh4IJtswisfpW3zMEkGWo0Xw16r+/XIP0Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481195; c=relaxed/simple;
	bh=d0bMKHLJm4DQmRGsqswb0clCu0oYff6lHorPZ93WdKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ee9Tmzb7/xTRVlG2+sXHodAV0DiGAiv9M+neXtyjr0kXdN+EAn2n3mbcgsF6vo5Ynm90f6kC5dirC7ZfEZPhYKYyDUvRt/4tEtEiS/wOhHlrhyjWJrnfTa8TY7p3keHa5t0Szm6d/hTyxZFV+yRjRr6yx7J8KWKbH5XsZ3fhJxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mbuReyhb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MC9qwU2H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PABmpI016988;
	Tue, 25 Feb 2025 10:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KSmxf9mrL5Ih6APC0VvNljpqLdFasgZMFOUXwgPiPTg=; b=
	mbuReyhb4mrY/cgUEicZktz14Vo30/T6X2sh01dYnTMcBX+Ifw7h+HNozF8aFRJR
	PQBIFpnKnkN7OCEWI9D5D62ixbCjkXYG4bvh/cYGUHvq+mKWJTlfw5YC/+78vlpS
	oB6lq3p+/BjRkJa8hzqJXmO9U6CneA8QRUczpm8uZSdmxC4eKFQQNYAbX7Cu+rBK
	lwhSKKHGPkMLGPdxIDabTtvru+GcIXbXS8Qcds8ZVvDOa7wsFKUprms2KwM7XFSn
	UD6C8mUZoHiBkm317sVxRe+JHShmnyGCwaj0xawhm7KzEmnmTa9Q8YNhEFnZabUW
	YHRRFrRVQr4d5Dh9ApSRVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9crww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:59:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51P9ufvd012660;
	Tue, 25 Feb 2025 10:59:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51a82up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLcW6bZfzMdim6Ex31GhOdIGYIN8jFVAKhaoFHqxxBbV/fh6y/Qu2yUBYvPCtCEV5wVKop38tK3h3ZfRDfKdt/YXVuuzGhDjdBeJ+JZYZdP0rSg5QohVIhpuc0gopRGEd9JcV+7lpfnfvc4WFGwe6+CZUHFiVyCQ6xBtrx0+clShjWng5BCVwftIelXXcoJJqa4nRaN/sun0tG5GGZRZs1oveQcjD8rCmYgmTf3rCGA7aQhex8ncShmaey4Z4pTv4gy6uucvKMWXy5R8GipsVWpZp+SbqpBxgZURFR+JkVMQufW/UBxvIe/pmDVMjOSZbTqXTMFqS/xNC0Z64pq41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSmxf9mrL5Ih6APC0VvNljpqLdFasgZMFOUXwgPiPTg=;
 b=m1a0vx3dpEct5KpraLviCxmidms4+AelnTTQD3KvCadAUqeGMhrssU1ARjRmsopfus9cRIJc/nxjvYFNUdyXwAUHiTMDneSHJVpn0TTh3sOJWvV7sOdA+rFluI40xNzU0QrBM2CUrH5k4wsDXCeHa9b0JRDU9rxi3FE8pKCYJbQ1KAsYMyE3eZ0rnKFeBdYR8gZo8LJflYuyoEaCYPCGPHtTG6QwW3OA0CSg7BpOLj0DNS6FlDOXMmV/Vwu4wSq4XaDHWCAjK9dNGAJNMPfdjnO2jQIfVU6HjlY9yi1WAY6eg/c2WE5yp9ItMFUTKh0JY+FNPrwZepL0D/z/8Hq1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSmxf9mrL5Ih6APC0VvNljpqLdFasgZMFOUXwgPiPTg=;
 b=MC9qwU2H7LafPOCtaCPRh8EljlzmBw8vCHn92T8rkMsA11gUeTGxmqWjD/sUBtBQ/5C1COcSQ2m0y/gKq4qd2pjJdsCpvt8VePwAD37hfBDx06liTEkgdAFdqXjI6zV65gjVP8/zy2wiaCjRFDHKmJqJfSGsHb4jvmnPy6XcWAU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 10:59:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 10:59:00 +0000
Message-ID: <e1aa10da-046b-48a8-bb49-f494a5a2b383@oracle.com>
Date: Tue, 25 Feb 2025 10:58:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] xfs: Reflink CoW-based atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-7-john.g.garry@oracle.com>
 <20250224203228.GI21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250224203228.GI21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0288.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 061927ab-9ace-431e-6635-08dd558b6877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW1qRy84YTh4bGdZbjY3VnNzeExtNVhOK3hsNkdlM2Z5RzRURjArOThLNGlR?=
 =?utf-8?B?UWZTVFdkRXZsL00yV2NkZ2NyeXVmMHhuV3E0aEZ0bTJRYklYZno4UUxlS2Ni?=
 =?utf-8?B?eEIydVNvWklvd2QrZ0g5RUJ5eFdzSlNxZjM3SmdiWnNqQ2ZSOVJsNWR5TEdO?=
 =?utf-8?B?WjB5bzA5UGVrcFk4SGg2K3NucnhRRVhtWW9ZYm4ydU9hYm5vbkU3ZnpiUStv?=
 =?utf-8?B?eUlsbTBMeXBrSWJ2dUxuWFYzaktzbldEOU1VcGJGTXgwd2lySTZiSXMyeG0z?=
 =?utf-8?B?WDJDdzhTeFE0aHdERkdKYkl5MDhnbzljTVk1UE9OZ0wyY0JCL1JobUJOeksx?=
 =?utf-8?B?R3JvenJteDFSRzJ3amovRVVZb2xkaEtIeEZIZW5zTFBqeTBUWEtZVE5GbmFW?=
 =?utf-8?B?R0FNWVBqRWlIeW5jTjlsL0JKdnBjeE41Tnk4TWdIR3BjcEJ5elJIVEJ3MEZa?=
 =?utf-8?B?VElhTUxqblU5OTVaZlhyYkE3eGpCRTNDUysrZSs4bG8rbjdkZldEN01uUTBx?=
 =?utf-8?B?NCt1TXRwdVNpNGExQkt6bjZFRld4Uno4K09BekVITE92WGZrZ3dlUTBLYXRj?=
 =?utf-8?B?NzNyMU9WSnc1eGFWQjBHOUtVRi9Ja2VFTW1lU1IrQTBtSGEvOEl0alpVTzFZ?=
 =?utf-8?B?NUxPM0NIZTIwOFJVaGx2emdBVWN3TG5RRmhCQlVFdzJXZE5SZWF4cUYvdUhh?=
 =?utf-8?B?MTZWbUxEZUdzT1ZkemFQcWNwVThyZ1IxaWl0R051MjM1eXNzM0dnbXBmWEpX?=
 =?utf-8?B?cmR4OE1BdVU1TkVCdUF4eUtpakJzb3RqR1VURGN3WHhxNlhRdDJ3YU5YcHNo?=
 =?utf-8?B?bDVCSHpJVVJlSUxrN0kvY2lCcG9mWnBSL0dUbjUzWWY0Q0ZiSWhrUjFzT0dD?=
 =?utf-8?B?ZkFyR3VwT3FBS0VGdEtzSHlmV1pMTjl2Wks2MUlaaUh3a2k4R01qKzRWQWcr?=
 =?utf-8?B?cnFoZnpNd3IvdEZtbnI2d0xqYUpKMHA2YkFTOXY5WUVaTlo0cEI4SFkvUTVi?=
 =?utf-8?B?a0grUGhMOVJEaHhNbGlWRlN5bVZhYWVFelZYcjh0NmUxTEY5WkQzM1UrY2hX?=
 =?utf-8?B?ZlhxdkxSSERITUgxbW84VlFnV2lGR3hiMHJ4eEJKTktUUlFEbXhJdHlVWjdR?=
 =?utf-8?B?bDNSTkcyZkI4aDVxK0hQVzBQSTdLTWlkRms4SlpCNWxKak0vQkcvOGVCSnVt?=
 =?utf-8?B?Y1JXQXdSZ3hjcHZSZFI0T0toRUNnY1NJZ1ErRVZDemhBbE04YWdjbXlQblZ6?=
 =?utf-8?B?UisyVDU1UDBWeTdXVUJZSDg3dUo2T3J1YWIwOUVtYjVmQ1k4UlkrOXh3L1Jv?=
 =?utf-8?B?R052ZkNUUFNQOUxySlZHZi84Q0V2dlBKa0lvanNvc2c0QnZZcUhpYThEMkNw?=
 =?utf-8?B?RE9sNW03RDJXVXl5U0Z5VFF2ZkxJNkVMaVpWL29wWHU5d2lmQzBVK0I3V1Jt?=
 =?utf-8?B?akV5VkRrV2lJMWhlaDlBdDdRM2IydHJQN0tqRlpOYVB3aWFCUHI3ZmU3ZDhG?=
 =?utf-8?B?RlhwRWxDanJGSWlpRjArUjlYTG84ek5hQzhuM2ZIZG1saWN3cWNlZnNVR0pa?=
 =?utf-8?B?Ri93cjN1V1dNcFBVRkxIbGV1cjhQdDlYc3JHTVdYMFZoYlZoMElxYzNyOU1a?=
 =?utf-8?B?My9Tc3ArTGE1SjMzN2MvTm9qQ2VDL3l3VE9UUSsxbmc1VHVFOTJQSXhSM3lq?=
 =?utf-8?B?cHdqc01jZk5QSXVJakg0a0s0dVB5eG9DN1JqemJmdUprc1IycldNdElrWE10?=
 =?utf-8?B?cElNN0tST2ltK1FTZXlLYWI0UzhiZzZ4SlRJak5SLzNrQ2ZaZytYZnFHU3pn?=
 =?utf-8?B?QWZSaUEwS2YwR0prY01FVDVwRTlsSElWNWVLbkV6RVJtVkpvZ3RrRStZcHVq?=
 =?utf-8?Q?v86PUsgr30RJg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmVkTGlBbFRGNVNJaWptNkFIT20vT2Q2ZzYvTTcvKytTOGRldWpuV2VZTXZG?=
 =?utf-8?B?UkVjelFqVkZkaTRicktRNlA2akVuSU1HR3g3UkNmMkkrWmNNdHVVZWc1SWg0?=
 =?utf-8?B?UG53UGgrc3JXMjV1UEgwMDYrVkYwMWhDSWVHVkdvZVBkRUtrUHpRSTZPdGs4?=
 =?utf-8?B?am9Lc2VnK1hIWDV3b0hJVkxVWU5TZlNVbExSVkFWODBxdkRpVFdvL01acHd6?=
 =?utf-8?B?dnhiK29rSmVvR2xibm5UYXdTQ0hsNmxIbGRLWkNEUCt4d3htOEppQzZnNmZR?=
 =?utf-8?B?RVgzMzNSVkNCOUJRdUlpYWZ5WVFKOE40NHpRaVhaSmNPQUg5bzA5WDZyMjAr?=
 =?utf-8?B?RzdOeHREOEk4YlM2VndNRmg0b2EzM2Z0VSthWjRQS3JFa0czOFU0aHd5Zjl6?=
 =?utf-8?B?d2d5SVlNV0lOa2Jtc3JlelI0SlFZQzBVVHovME9FbGJoVEhYYzlGYUxwMExm?=
 =?utf-8?B?d3lBVnRpc1VWU21Yem9yUEVaRTdkcXhZNmFVMFA0ZVkzZG5QTFZsY0IzRExL?=
 =?utf-8?B?Y3dNOGE3SzlkM0wwUEdQcFlVOGhaUk8wY1JBYVJPMzFyWkFkMzdCTWNVdTlI?=
 =?utf-8?B?RmZkTVowZ3l2UnhWTzhKR01DR1FsTENtVkx1NnlqWjBGNkFuMWw5N2xPSFJw?=
 =?utf-8?B?OGVJVDlFY0xvMHFYVmhjMTJtR0k2YUdEVG9rRFgvS0JZMlB3dHRLeUkrLzIv?=
 =?utf-8?B?M2d1eFAyelByUVphUUtHaVRFTUpSR1hTLzNRamk1enlMOEQvZ2p3YldPbEZW?=
 =?utf-8?B?eWJvODlrOGtxWWk2dVM0OXhZUTRwWDBnd3B2MUdITTRNMFpzbUF1b05hRlRJ?=
 =?utf-8?B?b3NOd1VIVDZTNXp1b2w5ZzE5QkxVYmVIdnN3ZkZWVEtraDRuNjQzLys5djRx?=
 =?utf-8?B?Zk9ocXRVQTAvWDFKd0o4dHRVYitEcDc3U1VYWXZZelBzVm4zdG5RMEd1WnV3?=
 =?utf-8?B?WmxPaWRFM1NYcjA5NzlieEJHaHBVWmZ3WHBDaUxzV290S2ZyU3kya2lLcVBZ?=
 =?utf-8?B?QVNRbEc2bTREMHBldm5WUnIyVVcxZFZZOE4vdldqam8rOXVSN1M3amFERytx?=
 =?utf-8?B?WjdndEptamlodEhuQlVLbkExV1FERTcwN3Rha05IYTRMZG5jWWdsbDdWbXpt?=
 =?utf-8?B?T1NvWEpYSWp0QmdGMlZiSGZOMm5HZ1d3UktIVk1PQmwvSEd3V2FIMXJYRWtN?=
 =?utf-8?B?ZUJEQ3hDOEIwL2orNWhON1UzakJTU29Wb0ZDVGhjZHdSMkM4THBVaC9GZkNq?=
 =?utf-8?B?b1VoekY4U3EyN2hqOVZpbXZSMzVpL0p5Q1RhNmlvNGJFNTkyVVIrQW13NjVl?=
 =?utf-8?B?cUY5SktLM1dnNmlDaVM2QUM1NkYvVkdnKzNVN0lITXVNTE1LNHhKRHMyaGZE?=
 =?utf-8?B?RkFPUXRYbnNNdDd5TXZBRXQwNkJhaFk0Q1NvUXBJWmNTRllWWmZ3N3FEODhI?=
 =?utf-8?B?WWlJOEhFY1c0dXo1TU9mRGhjejZLM0VVVE1tNFJycURQaTdBUmVkaTlIOWw5?=
 =?utf-8?B?N0FzNTJYMlc3MzFHYkdrbTF2R1JxWml4Vmx6dEptcUlFSHNRSGIxYzFjZnhU?=
 =?utf-8?B?ZFdlSkpFOGJ0MVh0S3Z4aDFYc1NnOHIrYmpZaHNXMTBjS0JGUHJpYVlTVFEw?=
 =?utf-8?B?YVpBUEdFMkI4YVB0b3VNdUVKQm1OMmkwbm5KamlqN0YxVzdrN3Y0dDFLb0ov?=
 =?utf-8?B?NUExcEo2dGN3OFljMm5VQWtXTFFHQzBGZUJXYytOV3hnMmdOU3dIdWlPODhK?=
 =?utf-8?B?VG9IdkhRc0V3NWZlcWpOY29yUW5iSEwxSldHRFJOQlNxSW82bExzck82VjhJ?=
 =?utf-8?B?K3JmQzRMTm04eWNRNjJFMThrTWtib1RXeGlCYnIyMVcvOHNTTFQ0cHdRTzha?=
 =?utf-8?B?Q054NUtoVkJqY25iWldnNlFkL2VWL2NUQzlRUCt0K25WYjBBd2Q4dVhzdXcx?=
 =?utf-8?B?cTN6dDk0OWlaRHRVQmFhYTYyb1MxR2FNZjcyVmF3eU5mT2FVZmV5Qk5ITy9M?=
 =?utf-8?B?L1NvOFQ3b1h1blFRY0JEQzFSa0hybk9nZVVXMERmaFJHdGdBVjQ1UVQycVFR?=
 =?utf-8?B?bGVqeHF3c2JKd2RpTDVaMDl2YWtaYjFaMEUxSXBva2dLRzl6YzhFaXB4SCtX?=
 =?utf-8?B?eDRYN2NDR1VPMU9SdDN1MVJ6VUJKR3NNa2x4dTBZcGgxbkk5SktaaGFPek9R?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bqd740hAs1mz3NbWoYXbbO/ATf5S+H5gN64YsK3+rt4XrC2oDToVRtqSY4MWOx8Jx02mbh0PLNYVbSTG4f/CouAz7VrblabGShpfBvFRFSVpWnluFHzuhkzZhMKs0CK/aZHz6WEN1oua6ycupUSzdAQ+KV/BH3qgBAedah1cigW1DPPggUiwi8rP7vmNCIoZ65Chi1mQxKAKaMKSTyJiMUEioM57bFhr4JYEHLTuyJVUHpgf1yV6pvd8ZSGKlxkoCE7Ii7AU6cm6FFAN0JUGOBGZfuWoTPeSC1SSKu41CXZjw+1oFk2ihld2sciHM5NK7OrVNLLnEoovvzQ5NdIo9dS0wBOcgo//T9d8mxeir0L2rrczRXdgF69YUwKMMvPq98ZXPnVnpfZqYqs3ng48FvdYtD+RhuySteCrq6q1ICjqcd2LC4VtDc/veiTqz7S08XRoz5CjIafXsPfm6FIE3KNNO8KM6YLmFFzD1S+3NNWtT23cwHw8lV2MyInap+Fqmio7Eb62M4tAKSSVimyhM/c4pIMpicWMQFJ+kbQQCDHBZAJjLJ1alLaJsi7a/sHoVuTP9/ajK9s7wzPvzRTFFcKEF4f1keXC0YaWnBZjmT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061927ab-9ace-431e-6635-08dd558b6877
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:59:00.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbl//bCx0osLd85R0xHTHRJ73JKDHo44c6Q03FGVN5cdY22/OannqOyog3pakuupttd8VRF4LdcDmsJGpt0I1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250077
X-Proofpoint-GUID: slxfOzZEDJFtDYYBtq25E60Eijri_ivf
X-Proofpoint-ORIG-GUID: slxfOzZEDJFtDYYBtq25E60Eijri_ivf

On 24/02/2025 20:32, Darrick J. Wong wrote:
> On Thu, Feb 13, 2025 at 01:56:14PM +0000, John Garry wrote:
>> For CoW-based atomic write support, always allocate a cow hole in
>> xfs_reflink_allocate_cow() to write the new data.
>>
>> The semantics is that if @atomic is set, we will be passed a CoW fork
>> extent mapping for no error returned.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_iomap.c   |  2 +-
>>   fs/xfs/xfs_reflink.c | 12 +++++++-----
>>   fs/xfs/xfs_reflink.h |  2 +-
>>   3 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index d61460309a78..ab79f0080288 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -865,7 +865,7 @@ xfs_direct_write_iomap_begin(
>>   		/* may drop and re-acquire the ilock */
>>   		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
>>   				&lockmode,
>> -				(flags & IOMAP_DIRECT) || IS_DAX(inode));
>> +				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
> 
> Now I'm /really/ think it's time for some reflink allocation flags,
> because the function signature now involves two booleans...

ok, but the @convert_now arg is passed to other functions from 
xfs_reflink_allocate_cow() - so would you prefer to create a bool 
@convert_now inside xfs_reflink_allocate_cow() and pass that bool as 
before? Or pass the flags all the way down to end users of @convert_now?

> 
>>   		if (error)
>>   			goto out_unlock;
>>   		if (shared)
>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>> index 8428f7b26ee6..3dab3ba900a3 100644
>> --- a/fs/xfs/xfs_reflink.c
>> +++ b/fs/xfs/xfs_reflink.c
>> @@ -435,7 +435,8 @@ xfs_reflink_fill_cow_hole(
>>   	struct xfs_bmbt_irec	*cmap,
>>   	bool			*shared,
>>   	uint			*lockmode,
>> -	bool			convert_now)
>> +	bool			convert_now,
>> +	bool			atomic)
> 
> ...but this can come later. 

Do you mean that this would just be a new flag to set?

 > Also, is atomic==true only for the> ATOMIC_SW operation?

Right, so I think that the variable (or new flag) can be renamed for that.

> I think so, but that's the unfortunate thing about
> booleans.
> 
>>   {
>>   	struct xfs_mount	*mp = ip->i_mount;
>>   	struct xfs_trans	*tp;
>> @@ -466,7 +467,7 @@ xfs_reflink_fill_cow_hole(
>>   	*lockmode = XFS_ILOCK_EXCL;
>>   
>>   	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
>> -	if (error || !*shared)
>> +	if (error || (!*shared && !atomic))
>>   		goto out_trans_cancel;
>>   
>>   	if (found) {
>> @@ -566,7 +567,8 @@ xfs_reflink_allocate_cow(
>>   	struct xfs_bmbt_irec	*cmap,
>>   	bool			*shared,
>>   	uint			*lockmode,
>> -	bool			convert_now)
>> +	bool			convert_now,
>> +	bool 			atomic)
> 
> Nit:        ^ space before tab.

ok

> 
> If the answer to the question above is 'yes' then with that nit fixed,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks, but I will wait for your feedback to decide whether to pick that up.

John

