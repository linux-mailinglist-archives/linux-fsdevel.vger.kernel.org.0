Return-Path: <linux-fsdevel+bounces-18414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCFF8B86DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E89C1F23A34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784B50269;
	Wed,  1 May 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C2CkX17Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z0GDbvwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BF1FBB;
	Wed,  1 May 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552282; cv=fail; b=KN564l/AinDjPG6mgni20xSxRUx0znZ22+gWLclpWymIMTb6L2IsTYVBQ1u1rgsEjZu4jP+Y8pRONz5fhjh2bzp7rXDwcXQ9tEEzfp4JLaB/VDN4Ku/dqpHdj4cKyf6tTHeBX4Y9NwK6P1/h6SO/P5RSfZCPA+5gBBw7LCkOpKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552282; c=relaxed/simple;
	bh=FgdjWf8Lk3XmoHQpH+f+flNd0+pGcKvxxsASbdF1yYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6AdoJemobrQR9I60kpxaqtZh2kR+v1xotJoSP8SflGhJmpdVh5dR+/oq9K138ItVcItKK1XRErsf72gG3ARVu2eNu2LoUeV785lN6LccHAB4YOQN0Z57mV4LJeEq8Rj0wFYz7N7MrvHNPw5kqnFO5+YREmhpwSOPUA4xviksYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C2CkX17Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z0GDbvwj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4412jUr3023029;
	Wed, 1 May 2024 08:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=B8s1eGv1qEdKW68DtXJeUwdloN5JceN6Vk9mY8iZApg=;
 b=C2CkX17YapDNH+FuBrJfkXN6ElZ4A0qMFpsbHJjcZTEUK/jnIQFFzXweh3fIvZUUtiCa
 Igy/DKUtNMFRnkEl+D3Kbf0+AhbdRwTpEadf6vNu9T4df46+l1BKON7NXO/TbqdVaJy5
 C8RdHJD/RN+y8rGhzzeibt/EQNQa6w5wuCes0yvp2M4Wwag+WZmnjB9jv+DCd2/tDnj4
 kO/qO0XPJpHH5kEB6mzYaIubCH49w755M5RBLTh1XZ9ZeiKkeH1XXxoRKc6Ru3R4Th2w
 dmVITZusuSgBC8ZH9ED3OP2lXHGnEtTWjZ5NNOewfoVp0iVuF0Fj2rXdGcecXEa4GoEL Vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvpt5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 08:30:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4417fKhn008453;
	Wed, 1 May 2024 08:30:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt9453t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 08:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFgLmgrVhlfA3F2Hy4ZyBOLloOoeyohD8FflQTkFxKM7j6nLrz+WDZZGh4NyXede72JYvZsS/3Y8M/agaoTjjYv7OaNR4/TBD/YowAFMk/dxm1zAq1Ac6/e8Hgk4hG88XkCqLtNLa6WgPf1f38AHGxdFHL+VBGeycaAumtKD5Q2SWc5VP9qlvUZyKoTjH/0UrcTUuNGjVw6rj1TbwuwKOP1UFBgNhSp/Ppfuh4FgSxwnAkUvl1NB3iKjiggpftR4JMp77eytQHX3HYBoLt0MQcyq+33rqEaj1fgd6YDtr5GE/mPK1Fj4vEFxQ/HfDYF+sVShT4SxgBhZjldkWYRMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8s1eGv1qEdKW68DtXJeUwdloN5JceN6Vk9mY8iZApg=;
 b=AXET3HuZQzvrwzoEFV9ofr+eI+ZLivYg6omZKdrw9TpTeju1tACHTXz68fggWi64/QGNW8OrvKubtHwF9iMufAPIHaadGOM4dTxUs7G3s3zEXhg3nyy0IYX+p6fuTDThTrmqDWK6YA241y1L8LnN1FkvQ+LvJ3BkMz8h1guW+ke6bOgnCnB+wmY6sU+wZs7OU1plyC/qYhzXN/LDCpNewkyOYtEBSb+87SAu7E1dPuxdtuERHiBxHKJF7xydbDZabGPQAN6X7Pl3sbJ97khESlk7avkIWQBNcElhXs+c3TSFhqUg5/9CZAfUg8BF9XMfH+NOgvd60ja7HVYWvSMdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8s1eGv1qEdKW68DtXJeUwdloN5JceN6Vk9mY8iZApg=;
 b=z0GDbvwjvz6LQanEzXV6rdffPtusu+lO90LpYdoLhvVikur2tSUJh0LDOtmZ1ZK9cAXQMrF1gIVqNGMtJLwtW0ENRxMW+HPKKTjg3tH/O4wVPXQw3ZnFz+oWBWP7S9FEIb6upWVg3KZYglllLNpI2VMqilUyK+zYFNki83JL0og=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7065.namprd10.prod.outlook.com (2603:10b6:8:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25; Wed, 1 May
 2024 08:30:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 08:30:42 +0000
Message-ID: <833f5821-a928-441f-848f-3a846111dcb7@oracle.com>
Date: Wed, 1 May 2024 09:30:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/21] xfs: Do not free EOF blocks for forcealign
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-10-john.g.garry@oracle.com>
 <ZjF2jjtsA/C6ajtb@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjF2jjtsA/C6ajtb@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0237.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c7f599-f7b9-4fc9-6440-08dc69b8fd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eEFIL245a09PNUFlZlNUSjB3VThCL3pkRXFxTmNaWUsyWG1Kb3QzSzBJdmJN?=
 =?utf-8?B?YlFuQ0t5dTA5bWp0M2JrMk1ZYWRUa0NBWWp6dUIwbkl3TUxBazVicXBHejZv?=
 =?utf-8?B?bjM1V28xcUhoK3lTcDUwdVJHMTdyakY4MWJqVHR1UkxvR3Z6dlBHZVVJUHhL?=
 =?utf-8?B?eW1mSjFoaW5DNTNtN3RkQ20xb250RVVwU0Q5WnE3YnUvQlV4QjN2TVVpbERu?=
 =?utf-8?B?MFpoR3FOVjI2cFFmZmlPZGd4cWh2QkdBaVFBRU9FMW01ZlB5cGR1R2trZjhk?=
 =?utf-8?B?MFZqOTlIaDVJRCt0MkFpV0lVT05nTmFKUTQ4VS85UFl1TTlJdFlBSmJEQjRC?=
 =?utf-8?B?WVZKd3dkMzBTNFh3Y0JvQ2JkYmFtdEtQMWZwblVPRzJDOFIweWhRVWRCK01i?=
 =?utf-8?B?WGtYanFDcTJ0aXozQXpVSE5uaTU3ZnRsTU1ZNjl4UWZYL2xEM09BaHBwN1hY?=
 =?utf-8?B?UnFzcHVZN25CTWJtYVBGSzVJNzlsZXU3U1dORGFxUlpXWG1tZk4zeXdJZ05P?=
 =?utf-8?B?bkpoNFlxTS8zc01YWnE3VnI5eEVMYWtZUkt3OHJ6bTljWnpMeXpTWThUdjhq?=
 =?utf-8?B?WHQ5WnJZY0NwSzlGaVpFR2FkRDFERE84VlRrUHRFZ3dod2RHUlVLeUxXaVJX?=
 =?utf-8?B?Q2M3S25rTjcrRjREZSthSHpMUjZFOTBDa2Y3K2lKVFhVZHJjYWw1RDNMVThJ?=
 =?utf-8?B?R2NUV2NDczY5QXhtMHM3MDNwQnRhMWlMNGlUSHZLcitNWVhlTjBURG9ndGRB?=
 =?utf-8?B?RXhZU2RqcW9Sakg3eWxaQ3k4Wm5rZUZDU3R0TEdZSnQwMGUxYTdvcGtDUy9t?=
 =?utf-8?B?VjdsWnVNdzNzQyt4UzJ5R3gxWDRyb21rSms3bkloT0U1M3VDMGV4RW5nZ2JZ?=
 =?utf-8?B?SXNRZ3JHTnRXQnhTM0tGSUtjcHVGcndjYWkwNSttZm92ZStmd2NGT3J4TDBt?=
 =?utf-8?B?U25jV3ErSTh6M3Z6MGxITkRUeUxzOU9hanc4aUxoamVjc2oxa29GNWJzU0gz?=
 =?utf-8?B?U0pjL0I1UXRGTDRsdEFwdURTZlBYbTBoOHMzSHF5N0w0b3dodU5lejR2TUlD?=
 =?utf-8?B?eWsyZVVTc0lBb2NkbzVCakY2Q3p4dEw4ZWxwWjVZWmtIS21MWkg5NWJtY0tW?=
 =?utf-8?B?NUVXZUtGRVZuSmsrT0hmWnFGMlZwbWFIZldobkJYR2lkZVVTZDNIZjU1Nllx?=
 =?utf-8?B?N2NMd2lER0M3NWhaQUFZcXRSM2lQOVN4RmxDUEtUYzNuSGREQnlHWW1LV1Y2?=
 =?utf-8?B?N0I2Qm96L3pMR1ZCeVd0VmF3bEhheVhtN0lIKy9NcXhKRXpBK3VyMUpUSFJN?=
 =?utf-8?B?NExsQlM3WWVST05qK0xZTWlJVEY2eEUxd05wZFVMN3hTaS84Q3JNNDdDOW1H?=
 =?utf-8?B?MVVGemVqNnJWMklYWWRLeERnMStIRFkvZnRsazdzUFcrWFRvYVZ4OUtxd3NY?=
 =?utf-8?B?Wi84YW9Ha05qb1krQitpUW5mZ3d1S3pSVVY5VEt3a1RnZWZRV1F2RFV5bDBU?=
 =?utf-8?B?bUJEYmdUMEZZT29WRW5USXNuMU81MFRoNzZaQUJWUzNBSktGY3E5ZFl4ZjNQ?=
 =?utf-8?B?TUZUYjhIekNZak5EeG1zd1RJR3lidGVmMkJyVXpmVk5LeGNZUHJYQVdiY1Y4?=
 =?utf-8?B?K2I3S0VtZHN0RHNaQ1Q1YUwzVS9LU1FqUnhHb3VPYkhXeitmWjdGc2NlbWsz?=
 =?utf-8?B?a1NLeURiM0JZQXBZMk5CM1p4L1lUeHlmbWtVVEVqTS9xTlFHQy9obGtRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXRDYlZEa1pscy8zYk1IUlp2UG9yNUtScEdLZmplenlFa09QcWV3Z2RUZ1U4?=
 =?utf-8?B?YTg0NlBUOC9zM1pCUzVsVzlBcGR6VjVWQUZocURkVCs5NW9zc013WWNieUwv?=
 =?utf-8?B?TWdZcklOcE56SE0rVzkzN1YzQllCeWpvemdoTVhPTnZEcWRDZXhTUFJydG5Z?=
 =?utf-8?B?YmdyVlFKS1B1U0tOS0kxTXllM0NsTjRhYWYvbHFpbXpXL1AwVnRDbVl0U280?=
 =?utf-8?B?TXFnVHZPVXNUYnhtSXJJTWZkUCs4SFJITEpDeStpWEZFK095UkxnekJGdDUv?=
 =?utf-8?B?WUZPWExTS2VMN2EzMFRYVDhselBMZjlqeHlNdUxRRlVZN1VXelRMdmRhVkE3?=
 =?utf-8?B?WUdENEh3a3kyV2FSMjJyUlN2VE4xY013anpCcHp2a1VyZWNYaWRnZEhiaTFS?=
 =?utf-8?B?eDg4cWR1ZlgxSmlac3JLeEpzRWZpcUpERDRBakk4c093OGxFcjZNbGgzUVZL?=
 =?utf-8?B?azE1UjFCcXErU050eWxoczVhbjdFVVFsUVZOT0NhT0JxeXRSeWdXelltZXdt?=
 =?utf-8?B?RzRBZll3czlpckJWamdCUmd6ZkNlR2tNNktDSVJ0RnZKZytsRi9nOEpZbnVM?=
 =?utf-8?B?YWpTOSsrYkljOFBEaXloZzAvTnMvQXoyNXg0K3JlMUFQaGJMbEE2SUZ0eng5?=
 =?utf-8?B?OVU3UjJYVEZmdDFycWFvcmZmcCtYNFFvd0JsbmVmTTBWYmhVdVlpRU9sVVBs?=
 =?utf-8?B?aUtyUWdFdkIxb1Zma2ZDMW12elFyYlZLQ253QVkvZGJLMTUvM2xBbFFCMjkx?=
 =?utf-8?B?TjZFcGRocU4vUjU3K3RJaFZ3cm5mbjZiTkJERGh6eEROOFc2OGovL1FMcUxY?=
 =?utf-8?B?NC9vOGUzQWg0NFpyZmdjUTNNei9UTlRYeUtxcERmS1J3V3RFQjBqdU1qZGRY?=
 =?utf-8?B?S0NUWVhoTEd2ejhEQ2JnOTdFZzhOMHdoWUkyemxpNnA5c29iTG9SZTdqcDFW?=
 =?utf-8?B?R2lkWVFxL2Nmd2lONGlhb2dSQ1d0MmN2bHg1ZEhGbnRUaElIWXdLWXVGNzIx?=
 =?utf-8?B?ZjliaUZkMytGWWUxVTJlaFBYWU1ObE5zYWNITU5CUEFQbFhFUzBobWx6bTcz?=
 =?utf-8?B?alIxdlVmZXU4SlNRL3ljL1h0ZUhmT09nWkI5V0l0cEc0N3kxUGZsTm5odWlH?=
 =?utf-8?B?REVyUi9YSmw3MDdod01EYWJ6bEpLYTVQM0doQ0tJNDRuTm5zVUZOR2ZXa0Fk?=
 =?utf-8?B?UGU5VFlVQWJHd3FIRkxNQnFzQjhiM2N6MVlxcVRMVVM0MUpaTExhdHhQVEZ5?=
 =?utf-8?B?NzZmd1FidVE5MmxVbGxyTkxZclZBSStCdms1R0xxSUt5VmFTSzVpOTg3NmR0?=
 =?utf-8?B?cE5OT2RMSkxmKzhpNFkrekxSVStVZTh5NmI2SkthVkVoVm1BelJuNDJtVGlJ?=
 =?utf-8?B?OEZJbGJVSnlXRkVIa2Y3T0NGbGpFSTZPeEpERGhQdVBGbXJrd3hBVG5TZTNN?=
 =?utf-8?B?aDljdnZDZ1VTeTZYekNQVkhoRUk1eTlTYjltQVMrS01jMWxiYkVvZzVoNzNE?=
 =?utf-8?B?ZUtIdytYdlFnQWplTjdtZlp0N3Yvd1VYeG43SDF2VklScFJ5Y05DS0x2eWNK?=
 =?utf-8?B?U0hEcXJCYnJrYmhnUmh3bVJEL2RjNEErYVpRQXF2eDZpYXVaTFlrYmJUdHk5?=
 =?utf-8?B?dGF6RnMvT3lndTNvaEplclJZNmhzNGxkS1ZLNWdYRFVpUmxFdHBpSytUM2s5?=
 =?utf-8?B?VG9VUVJpY3hQVWlUWGtGK2ZJbEhPZktEQzRtQWM1ZUF5N1BtVWR0cUhxTmdl?=
 =?utf-8?B?TXBwQ2JHK2VCWnhKeStNdms3bDU4TXVwOGlXL3NKTEZYdkVHMTFVa2VkR3hG?=
 =?utf-8?B?T090UUp5WGJiRHZYOFF1VTVqTDJONFZGWC9ZS3FFQXoyZUYwMmo2cmV5VmY0?=
 =?utf-8?B?OS9UQkdyUjA0dlJyZVNQTGl2K0ZRaDE0TU0yUEJJM0dZSWc0RWRVS3NnbFdz?=
 =?utf-8?B?NHdMUjdoeFRNS2ZlSGJCSXp5S3lSbG1GeEdqWWhRY0cvNUFsS2dySWtoM1h4?=
 =?utf-8?B?ZWNuaENSS1Q0NmdpWFlYSkphWTl5WnI0bnhFWXVhdldtbmlva2YxajZNZjVR?=
 =?utf-8?B?cDlsRVFUbFF1ZDEwM3VDMlgvdEFGamJTRHlJRVRBanFSTDloVEZHM0ZOTmF4?=
 =?utf-8?B?Y3VtODRtRTJCWWo2VTJHZzNER3VuVitaYi9UWjkzbTJxeXNJb0p5L3lwM2hJ?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Em2AfeXH6QaBWL7EyW7nSDyDuUMwAiyBJBOsxe/OCFSBf3JavnfaTurPnYMuL/8SEgdbq61iopKF/NbQ0BQvN/CfEGVsr+ycCKtk5L0H8fn6R/rC4P50+LjVDlpiXqY4VOA4h67W4teqvohEyjAKWzlU3YjOO0dCZtXs0nhKUuWSZrW5ojTQ299A+XSWV3DLS6vEq29cvJjY4ANXPobVgVqX53ko9/j6wPFK+hCZOr+9rFSLZcM6sfuRRb/o22CYz9qW3eU0nmcARdBRhNp133PiYBD0qu/HZWNqMA2R8PWbpeW4aJ1SrewOafRI/KKSy5KGzRpaqMuR+1m7nmJTIj/kxoKV9yVj8aHgGT0+XEbhqSg4zBCMLOHxucl77oG/Q52NZ57rSE/j71jSMqvOEfQ23UfEtWfA20gh7SC+EZb6NPV7/V++pilDmmrmZS9fFevf8zOYe2AIYSxUgVWDKwIl9SX6rjP9W60CISJAzz/bcziYT0vVb9tjQPnJ2muLoSxO+WkqOO4aeZbRATO9h/EYbosOsToY2c/E/+k0wFuUqhDmus93dT3caqcAs04h3Iy/522VjKXPBk3XQY8yjizHjbbNgjlCRYWD0GI0ww8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c7f599-f7b9-4fc9-6440-08dc69b8fd67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 08:30:42.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVlh+RZrxGhZeu8coV+ARTnq53K+QplzeyNc9LbFNiMBiKa34Kc256Jm8DdQ+e5BN7ZUnbzK9ryckxgCsRe9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010059
X-Proofpoint-GUID: 2rXO11HfEE-llNzGAd1BBNKm7lxW75yc
X-Proofpoint-ORIG-GUID: 2rXO11HfEE-llNzGAd1BBNKm7lxW75yc

On 30/04/2024 23:54, Dave Chinner wrote:
> On Mon, Apr 29, 2024 at 05:47:34PM +0000, John Garry wrote:
>> For when forcealign is enabled, we want the EOF to be aligned as well, so
>> do not free EOF blocks.
> 
> This is doesn't match what the code does. The code is correct - it
> rounds the range to be trimmed up to the aligned offset beyond EOF
> and then frees them. The description needs to be updated to reflect
> this.

ok, fine

> 
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_bmap_util.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
>> index 19e11d1da660..f26d1570b9bd 100644
>> --- a/fs/xfs/xfs_bmap_util.c
>> +++ b/fs/xfs/xfs_bmap_util.c
>> @@ -542,8 +542,13 @@ xfs_can_free_eofblocks(
>>   	 * forever.
>>   	 */
>>   	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
>> -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
>> +
>> +	/* Do not free blocks when forcing extent sizes */
>> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
> 
> I see this sort of check all through the remaining patches.
> 
> Given there are significant restrictions on forced alignment,
> shouldn't this all the details be pushed inside the helper function?
> e.g.
> 
> /*
>   * Forced extent alignment is dependent on extent size hints being
>   * set to define the alignment. Alignment is only necessary when the
>   * extent size hint is larger than a single block.
>   *
>   * If reflink is enabled on the file or we are in always_cow mode,
>   * we can't easily do forced alignment.
>   *
>   * We don't support forced alignment on realtime files.
>   * XXX(dgc): why not?

There is no technical reason to not be able to support forcealign on RT, 
AFAIK. My idea is to support RT after non-RT is supported.

>   */
> static inline bool
> xfs_inode_has_forcealign(struct xfs_inode *ip)
> {
> 	if (!(ip->di_flags & XFS_DIFLAG_EXTSIZE))
> 		return false;
> 	if (ip->i_extsize <= 1)
> 		return false;
> 
> 	if (xfs_is_cow_inode(ip))
> 		return false;

Could we just include this in the forcealign validate checks? Currently 
we just check CoW extsize is zero there.

> 	if (ip->di_flags & XFS_DIFLAG_REALTIME)
> 		return false;

We check this in xfs_inode_validate_forcealign()

> 
> 	return ip->di_flags2 & XFS_DIFLAG2_FORCEALIGN;
> }
> 

So can we simply have:

static inline bool
xfs_inode_has_forcealign(struct xfs_inode *ip)
{

	if (!(ip->di_flags & XFS_DIFLAG_EXTSIZE))
		return false;
  	if (ip->i_extsize <= 1)
  		return false;
  	return ip->di_flags2 & XFS_DIFLAG2_FORCEALIGN;
}

Thanks,
John

