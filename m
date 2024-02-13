Return-Path: <linux-fsdevel+bounces-11357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECCA852FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E7428AA61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A23B182;
	Tue, 13 Feb 2024 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ivOCT5SU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AsYsg0Vl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C98364BE;
	Tue, 13 Feb 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825205; cv=fail; b=Fp0kITPBslkDJ1Ok3d/A8ZAK3cSwHQh+5thXlplzace0b+azoXmKGEmV/M6Whtk1kWsQUrBUUSuH4G+rIVgV4xb0WVM30CBJ/zQmHgxJNqefQu7RZJGbvxsOfuNaGlghvYy6QQDHxyvrGL/dqOkxtFopzrCE3Ke1YhvJD9YrdFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825205; c=relaxed/simple;
	bh=felYoefIBtn6r9subdk3iariOAYk2z/QguaXE/SJNj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PZN6DVP59F4OnzQg95ye4SnLhr7Ccve0lo0rMbHqu/5oVAActFSKqDf/Eomi7ER17oz6IrVvVZY/1FDw8JAmeDa+sq5wQFtyeAWYYMa9n375oIATKEzj8VypLt3RH+W2I7hB6lzUd6+DTRq8LKvvl3qWGD3posSuzBP08MZovc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ivOCT5SU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AsYsg0Vl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DBZdDG003084;
	Tue, 13 Feb 2024 11:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=U08ro0OzpnsSyltNg7oZT3s5NQuDe8REyVaCf+Nm2fY=;
 b=ivOCT5SUs0X3Sn1S5eKXHwdbI0EfnaHBPqYlMEMAmLymZo20/Z3rG/QTQTtvvvVKDWqU
 +xMzlhqipkDdss8uNt3UqLmtG+vh2LFAaep3HhY7Cwzdu9sFiQJWhVdRqy2AJF9QVpRK
 BcNjOqhqEKcpyr0sYyqDxOoY23crrvC/s+kSGXkXu0K0maaF4krra9M3Ve2woZ5DkKQl
 jB1ihjdhdziBvNAJe0/mYNWU3qglBmSekapBdOxqrGb02v7IwWCCETRhI7pNwR+Jlm1X
 6LbpxcY1v9QYN9xrszw37uCp8qyV7cHKFKjFwRFkh1jvAMbGuzpSF3TWV03b8SAFJq7f NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w87nxg128-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 11:52:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DBM91i013849;
	Tue, 13 Feb 2024 11:52:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ap9we8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 11:52:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gokur4W4QgGuDtcUx2RSGi2fIDYrd8g7WgaaM5Kx4O1eoLuDk0rp5wWYDBhrSsuKtxrvMc5a1gXV7Nu4kJtf/hoxKbh35ubzvNJb0EFeTcHI0Yz0UFiAeDjqb6tzR2vNqhW1UO+kZBsZ5iu9opAeh2zCp2kXIL5x+7FOc8rETx72rfhIAb5mLcQK1yVip4dPgO9xbMpB3FHjgAY5Hs5gvPHMQeyEJVYbRAMCGUUgvRigGMlUZzHq5gSYamXlumqkY0Nmf6WdngMk+lhQvqRTxqvhgAyku/B916sXZlThDzuWvCLpb5gTB5irenkZ0kxbSv/2qiax4/86A7gOhRiAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U08ro0OzpnsSyltNg7oZT3s5NQuDe8REyVaCf+Nm2fY=;
 b=lqSNe5JOKhqBZf9JwrvTywC7uGUwca37B1oOhMtmN4SBo815TSCJrvi9S5F3WaeGpBq+TZ2Az42cx5BGiJmFTIEnjat3VP2GidG/L47cIPBX/GcWqRAB2t0oEWuyWSa/SgnJ09E5JgwA54sM5Ry1GgPoThlJ9VcowJuOFEgp0D06MuOkxsK15J92+kTVXk9xTTPEcXCjg4H1HRWyeozqCDQstfZnmlUuRja98vsgvCyMQdwVVZH9B0qKJz+cumuZMQG961ZvtqkhwdAvtJezlHJoMJMShih/NBg3nq4kSN0dSPe0bUU/0+UNNZaluSihswBacAEpWM1QV3mwe5TutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U08ro0OzpnsSyltNg7oZT3s5NQuDe8REyVaCf+Nm2fY=;
 b=AsYsg0VlxHc8dMwEBxkDNgG1eoyJ+MWNFSv5hochIGk+8bRcGv65EluZoN1h6XJYwsgngskUkOWuyqB7SBKPOEjRU7SW7kcG6u5hgKy7SbKNq01/99Z7nWSI13B/TfbjaKBmEbc7b3AEh8RvMASsSIKjdtFhmO5YhYl6T1CwdQY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7294.namprd10.prod.outlook.com (2603:10b6:8:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Tue, 13 Feb
 2024 11:52:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Tue, 13 Feb 2024
 11:52:47 +0000
Message-ID: <30909525-73e4-42cb-a695-672b8e5a6235@oracle.com>
Date: Tue, 13 Feb 2024 11:52:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] block: Add fops atomic write support
Content-Language: en-US
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-11-john.g.garry@oracle.com>
 <20240213093619.106770-1-nilay@linux.ibm.com>
 <9ffc3102-2936-4f83-b69d-bbf64793b9ca@oracle.com>
 <e99cf4ef-40ec-4e66-956f-c9e2aebb4621@linux.ibm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e99cf4ef-40ec-4e66-956f-c9e2aebb4621@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a73b58-707d-43d6-7a4d-08dc2c8a4bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ahtEHnJX8aN+XZ/lAkeZiKosWRXFN2Kjv58qtbOe4BVG2iIHKi9aR1SoWEj6J7fjwm5Z8Dqxjna8U60CNC4JTlYsVNUyq/j9n6Dj3+ts7ZyoOEozBWzVRlhXCeE36st1NcZA/AmrhHLCWGQd0dSUXl7eNxi+XmG70YGQAPf+Bg8wCJHCftwpKuAo0ZrZaGXlobHgfGO4X4uowvu/8OO4Vf691cbvUt75p7YVKSrgkGPJ3hR8HF1SA00pkzTSVb21spe/U/7uIHQrCDTwRvCTnVwYFtAMIZi2NSMfMwKpUtMYhgxAxLLMkNlBB7CxKpr7n/YhWOzs3ZDkeksu1sJ51vnagsD+aAmfi2AQFSAkoFhVxXHiL2U3r67FpMG6l6Q1aGv5Nh4LXj62+/q/vXGOajh8cHOoH6JSp+Aj25R1Vxoeg0y9sJEEdN0zqZJphJGaTWdKSDbgtKA2C7UXOilT7LfEd0G71Y0GaGZvS1ZDDfSCl6UYA/cvpOMWss8Zsi5jKaDE7z18UbGIxTzYDJQ1UxMIi6MiEyg4A8r98qrLGtIbw6nVcRC+vBA0RnPHDFZ7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(6486002)(6506007)(66556008)(6666004)(66946007)(478600001)(6512007)(2906002)(26005)(2616005)(6916009)(36916002)(316002)(5660300002)(66476007)(7416002)(8936002)(86362001)(31696002)(4326008)(53546011)(38100700002)(8676002)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cnhHcXdSNkJPU2RkU2RvcHdKbFgvTi91REV3Vm5jK3FvRzhKNnBDZG1iTTI4?=
 =?utf-8?B?R2dCVDZUWUU1a2E2Y0g2Qkhmckh5WU9icjcrWnBUWFA1YS9ZNmZqOHNEWkpY?=
 =?utf-8?B?YmZ4Q2NWUXA0cEhwZlFJOTJWVTZIeEJFNzZCR1RwVUJFa29oU1ZrUmQ1a1Uy?=
 =?utf-8?B?RlZwYktCZ01saVZTdVI1TkpDYVB0aWJUcE1QQkY0U0o2OXZ0MVRENzhUT1dE?=
 =?utf-8?B?c09CNlVLRzQ4M0tNS1RCTHJlRUhFZFdpRzROc3E4REh6RlJJYVYwamZjYnBG?=
 =?utf-8?B?NExkcUNQTS9mSVVzOERDOFRZOFQrRjRQYXZZWnIvT1J5SURNL2dneitQMHd1?=
 =?utf-8?B?NTR0TGdZQVRxMFlZUnN2QlFlUlRoVkV6a3Z6d1NrRFY5WSs2c25Ramc0UjUy?=
 =?utf-8?B?RHNVc1hHa3JadVhQckNTZTcxNTFUUkM5dGdPdkpyUlR5bjdYbXlmUXNyb3Jn?=
 =?utf-8?B?Rlhvb3NSVjd6Q01xL3FsYnpMaDUrUkZKMityTTFxbXlNUG5HMmp5TVFPczhS?=
 =?utf-8?B?RFV0RmhwWXBzV2ExRDkrR2RSbWN6QmpFamlNMFZCRm8wNVdydkJDUFo1dUVL?=
 =?utf-8?B?eG4vTVV0cEVQOUFuRjVFME0yY2lTeFVNbHgwZ1BKWEo3bXF4c2tUZFE2V0tJ?=
 =?utf-8?B?T2RibjEvUzE0WTZacDJLMEdhN0ZVV2F4eS85SDJNTHExdEdOYTFqckpZMUls?=
 =?utf-8?B?WTFsTGwrcVNZTlFkMXE2S2xLMU9QdHd0eVhEaCtRSHlubldsb2dJRWJiWFFI?=
 =?utf-8?B?M0ducGI3dTBtcVhTSUxhc3ZhbUdIN2QwWFFhY0dTNTZUa1dJa2h6Z0JqYkVB?=
 =?utf-8?B?aVpqSmZJejlwTmZZNGdDOVNQOS92VHlXUWVia1NpMVh0VWxOY3kwakZYYS9v?=
 =?utf-8?B?c0xEYW5MR2JjdGF4TjZkQkhqTFJSUHdJNXBVUzlmaFJNWG94OHpaL09helg3?=
 =?utf-8?B?MExrR0FPRVRCZlpuSFl6Q0xQZjZPaHRMNGtHK0F0RnE5QlB4ZmpHNVN3OU9t?=
 =?utf-8?B?cTlMZW14MGViZU5ncHlONGNGcWx5ZlBPYXYrVXBSd0lRVHZBT3BPOWxzUjFF?=
 =?utf-8?B?clh5L1VlVjJqa013Q1VhQmN5YUhYODQ2dzB4TzFiajBCR0tNREUvV1AxNWQ2?=
 =?utf-8?B?TkN6Ry9ZSHpqRHdhU0I5ZWplSDFFZ1YwdVpKSUVmd3M4VzV6eVdvcWwrdVhC?=
 =?utf-8?B?OW53TXdXcUYwYktWeEovdTdSc25aQ3dOWm0wbFBOOGtOa0c3SmEyNFJ1ckJ2?=
 =?utf-8?B?RkMrU3JXOGR6SXkwN2pJRi9BODkwSXJSMG80V3FNcTUwK3RnK21lNjZZVkRi?=
 =?utf-8?B?c2dNZDA0SHE3dHp1Q21PNXJVOHBpVWJmYkJiU0xXZ0dCdjFrclFRL2IyQ29v?=
 =?utf-8?B?S2RtWVR2RHZqb09RVVZuc0FnUGxFTkticGF2L1JTOGV6TEs1OTVBWVJzTmk2?=
 =?utf-8?B?QkF6TDlVa2JyTFQwcVBRMnNrbGdBQUJUeVEyT2tvb1JlSlBIMjhKV2hWdGFm?=
 =?utf-8?B?N3pEQkRjY1dmQzY4L0lzeU8rOStvNmdwK0x2RjJ6eWNOUUd6eTl6b2xWRkZZ?=
 =?utf-8?B?M2FOc0UwK01yaGRHclJNLzc5UGZqVUQzR0hETUNjNnhNR3Q1ZGcyaUFFWXgw?=
 =?utf-8?B?UUIvbmxVSWIwVEJVM3N6Q2JvaWQ1bHJ0ZkN4TXpkUWpyTmx6ZGViUzh2amoy?=
 =?utf-8?B?V0c0MnI4eUc5Y1hJbXA4ZHdwTnEvSGVoc0xBY25peFY4MG1Jc2Y1bTdiM3VL?=
 =?utf-8?B?UmhtMVUwU0tLaklZWmwxTHFmYWtLWnhFbGtLYlhselVmbm91cjd3T2pPdThj?=
 =?utf-8?B?UlhKenRqSTgxVU1KdnlJYitNbnFrODRaOFNmakFJdzc1ZEcxTkdhQ3RjMXM2?=
 =?utf-8?B?QlR6WTAzalR5TkNDRHBZQmZDd2k5RHdKNllZMm42blB6TzJQaWdSYi9zWWcv?=
 =?utf-8?B?Z3k3RkM3VU84NlVVZm9WZDBCZVIyRWxYL0NOSmJoRHQ0R0FhNG56cmczNmNx?=
 =?utf-8?B?bzdCOEQwb1dTTnZVZlBqVU8vSHRyYW5RVG5rQnZiY1RVNDhzbjl1Q0VibjdS?=
 =?utf-8?B?c1J5RmtTSHg2QWp5N013Mlp4OVFTT2dtdHBQcVZYbFR6cnlRNStlVWVPT09N?=
 =?utf-8?Q?vEfyUWF69lQrCjkyDfn0+l0zk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ilnCEJeR+emJQwmPxFqhyeG5qYaCqovl7AGutSk62Ea5l+FVteRGRs1uEm1gDGQxUg3x9lqj3LSy1UCfyMSBR3SWJxqPxyFf1VKJWBwlMaNOHXrGO10OyfjZ7XHcJCK9UmKCo66pBX2Eg/wT5zB3L2gxbPyiIWZwbAFAsNmrGDw1z2gi/DBICi3NUrnEXnZSq5JKBj+eJMYE56tx8jwArkkhiR8/dYtA/gJtRDyfsucjpvYrb4jb21e4AygrPMWap26RQFxL31ilXrMmzqEZdaN3PJuNPJ0O15QuSeWbrX/CX03CxN50fNb1KCi4A6hsjPfE9pz76EutLFIlXkElIv55jCqV4feUywiSiNk6ygNjXUV6KQV64XcoZ/WbUjv3GXWnidWE/uyhojMfCfmdzJ6HXHBmFK00511ybuj0H5zn+QhPbAbxwQK+X/2B7sfQry0z/ch1i2oH/5bihA9h4rcaBXyA3votI2+TKL68ueB6Ar8wIDdnntKuPeYVRSC78xhxEiEOyomtoinUqllySUZJgY7kzI+50uLesYjwmXgsWl/LeRicjReLODZAHAAZCIx4+7bsHMebIr16l3Ge4FD5qoj3vRQ7GNk73/0yEc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a73b58-707d-43d6-7a4d-08dc2c8a4bf2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 11:52:47.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaaC2qwAuZbF8pT22e2eqTC87tKXVrCr2z8bE1VDKA2X6z5fAmWiFAZIrL3HDjLyE7X6M9UGdMGpfrA0d4kEEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130093
X-Proofpoint-GUID: JsKvP5fP2wFlZlkeHfu-gx_bh7lOlHRw
X-Proofpoint-ORIG-GUID: JsKvP5fP2wFlZlkeHfu-gx_bh7lOlHRw

On 13/02/2024 11:08, Nilay Shroff wrote:
>> It's relied that atomic_write_unit_max is <= atomic_write_boundary and both are a power-of-2. Please see the NVMe patch, which this is checked. Indeed, it would not make sense if atomic_write_unit_max > atomic_write_boundary (when non-zero).
>>
>> So if the write is naturally aligned and its size is <= atomic_write_unit_max, then it cannot be straddling a boundary.
> Ok fine but in case the device doesn't support namespace atomic boundary size (i.e. NABSPF is zero) then still do we need
> to restrict IO which crosses the atomic boundary?

Is there a boundary if NABSPF is zero?

> 
> I am quoting this from NVMe spec (Command Set Specification, revision 1.0a, Section 2.1.4.3) :
> "To ensure backwards compatibility, the values reported for AWUN, AWUPF, and ACWU shall be set such that
> they  are  supported  even  if  a  write  crosses  an  atomic  boundary.  If  a  controller  does  not
> guarantee atomicity across atomic boundaries, the controller shall set AWUN, AWUPF, and ACWU to 0h (1 LBA)."

How about respond to the NVMe patch in this series, asking this question?

I have my idea on how the boundary is determined, but I think that the 
spec could be made clearer.

Thanks,
John




