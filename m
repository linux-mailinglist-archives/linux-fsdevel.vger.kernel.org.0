Return-Path: <linux-fsdevel+bounces-11550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F28549FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3711C26BDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CB5338F;
	Wed, 14 Feb 2024 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uml+4kgu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VFoEK07e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7631A58B;
	Wed, 14 Feb 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915783; cv=fail; b=b5YFa3mPHPzSU2GlpwR9ad1kzrBkV0T0PRpTESiqevJMTa0zKdnXFPLU5ou6e2RaDbzQJaWP/9rfS2emgmgZ9n5i5CJyf9b+O28lz7tEDjj/7Ye2suucQbPfGyOG048S7kmcnRapGepSpE8c3WDrLyAt/9V+a8WbbGs2L+xZvhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915783; c=relaxed/simple;
	bh=8w5jMmBTbTRb0x0wyI7JnbHSZ7WI821ei4ootLcByN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K9kUqe5ALEptLVee2ucdL3qoesBOnhxey34EX6ukYTFLmTQWmBe9eO/3bXDB7DuH96VX9rnN//pKjlNvruuE8XVA0cOjnBWIRAGUtWOQoGkdEqDMrCZuZ2HSKNPPY54L628qaRSmoZnVZlt2d7hOg7TBrXmEZiXbV61y2HNl5ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uml+4kgu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VFoEK07e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EAZXmX008755;
	Wed, 14 Feb 2024 13:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ce8Q95IId3pmV4SAWa6+fk90rFVkwmdggmmNgyQ1+t4=;
 b=Uml+4kguYXoLZQoSjkZPf7BLqwlqGonQkebzHOJbVjVPlsZXJ92jNvxa2plYOJQoXluu
 bYHXGQj0+zLaulmlG0bQzXo6fajf6uHrB3fvt3Y3v7CO7YEEc5PDJO1MZPnnnveHgJuF
 XlNFnQ7vj0//1L82K0829S2jNaRMsBLVKZ6BzZQJ9ruw0aQquTnb9rd0WB7miAwddZYz
 coyKGv3VCZy9MUlqDF/8ji0fyGHqDwXjBKXyorDiYTg8YwCJURZExsbeQAA3AIAIQeep
 jEQndZck9qGg6VLc/E7nDuVYtindx6YeHx6Wyn+vBaMErP2AClRRV4hT3qMQlXNXA5lL QQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8uvyr9pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 13:02:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EBYHie013874;
	Wed, 14 Feb 2024 13:02:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apbpdfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 13:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOFermQX72WIxDWa9buECny4RLsQaaHncpCXB3G588LpwCxa8RC6xQui+fYPgXQ8p6Ogx3dxo+nSRtIdRDWzplvFqlAc1FEWge9BBFCSTjrGRjVIujVkKZCKJfkOvjQEV/QBe7vqMuy0L4P4oWS/VMpjh0z8X4i6rcO5gERt4nUdrCQ7mXAVTgPf+eapDK/yQrrmqmZDmpmTa0frEgWjdN9YTsXbLkt2nQuUd7kAh6oUQys27TZEszk7f2qlVfJbyWnmmT2LxNs15yjezQVu44qS/C/HMnuW+3729N4KLQZFUSElmSbmT/XF/N3HcB5Y6dm5LbprHx2Iey5A9x3ZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce8Q95IId3pmV4SAWa6+fk90rFVkwmdggmmNgyQ1+t4=;
 b=WlT23XJHDE0NRkxxbAEbMJncB0P80C3rzw2r6jGqbKH8rcGUTTr66oSCXOOL/Lc0q5LWJduPEIb9KQOXTBCaV1l9cd5m9LpOkb7vLXRrVQiqNgBC17lbbsjDek8Yv1GKYt4SmYngJr270L8valoRTl9+Q4gHm/o9n2BBJEzMk0jh9DYx4oRJdv/IUFRtCdNusHFcXuftFZZP4TYqX69Kqrj9ub4XTPHCY1duo52+Nu0NURMpY71Z3425Bg5Lt5WxccQeLo0edI+Ap6J5NdyvkMkizsAyS0h7xzuoVgCmjCv5SbpTpLq3/xFXmCeFDDaBdSfzZY2BZ1bc/nR/Fz/TNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce8Q95IId3pmV4SAWa6+fk90rFVkwmdggmmNgyQ1+t4=;
 b=VFoEK07eK+LFiZMW9QI9iKxdGiq8+gTc6ib4Q6f/wXH+9w+H27M2PF3K2Grt54uHlhAFuALsyUeNC2P2nNI8EO8VBO1hO+iozJQV4+H3ynlWZhdK3g7vBT+MYD1PzbtYOchqNhisL325dqmqHFpj5DFjuEzE814nqyPCyoy7UDQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7252.namprd10.prod.outlook.com (2603:10b6:8:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 13:02:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 13:02:26 +0000
Message-ID: <8332ea29-ac17-4b1a-8ed9-e566d03fd220@oracle.com>
Date: Wed, 14 Feb 2024 13:02:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: alan.adamson@oracle.com, axboe@kernel.dk, brauner@kernel.org,
        bvanassche@acm.org, dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        jack@suse.cz, jbongio@google.com, jejb@linux.ibm.com,
        kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, ojaswin@linux.ibm.com, sagi@grimberg.me,
        tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-15-john.g.garry@oracle.com>
 <20240214122719.184946-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240214122719.184946-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0061.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2947dbee-84fa-4890-e3ca-08dc2d5d317c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dt8ImYVWEt1WTRINsnkeYzYJwTiAQLhpIlD0T5zfj6xFr0afnA+Pc+UsdMJOmSwIPp2zFXqR7/LcTwV/pGl61MTLPriVms0M4hRp8AQNqUY2pqjUnjtPcEKKayuQ9/SccHVq4HP7SlbgUgwvw2z5TvgwrFiiyCGhp78UU5wQ05clF4GCKNq/6kuaRMevitiJM6J0p2GgCwumnniONVao+EjcudYPE29kwkNT9PCxNq4cAS2ZEVTOOf0OrzqC2qlCI7GGRqkMPkb+uJmlrfox8KjNDfcoMo1xS8XCf+hS6sS1nUvubP2+x5Xksa6dTS76gWtuy0ecNrB/3i5v5NWcIGzRNh/jYxVZK4dcrdX2WiF+WSuDLEiZPxp39j6rDKoohLsJ+k0KnxJzK0I6GHdGZcL/ssh5BQ8bUC1yWi8Sx01uS/vgyYwT1wh89GPCnfIycJrdK9EUAFmAzPx/OzZOtSve617wEzRM1/8aOSi3anpRLKLCURsM72SuQEUo+rGbSi4zcbcNSECK1jVl4Vsjsb6nu+Lwiw0MiB2ky0YG7QH5+Kt2lQWxJU+yCf2hdMAT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(8936002)(6666004)(6486002)(53546011)(478600001)(2906002)(26005)(2616005)(6512007)(4326008)(5660300002)(66476007)(7416002)(66946007)(66556008)(316002)(86362001)(31696002)(83380400001)(8676002)(6506007)(38100700002)(6916009)(36916002)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2RYMUhJZWdSWlZlZzBhR2FSRFNpTm13YTM5Mk1qcDI5SUZKdEo1SkkzaCsz?=
 =?utf-8?B?QkJKa1FRbmU0UFV6WUxyWkJRaTIrKzJTZEFmNkdOdXRFa2IxcG5sQk9MNFAx?=
 =?utf-8?B?Yk1nbDZZSERRWjNLaGhiQm5ZMG5zQ2xLN29NZjI5aUJqc0g2WDZMaGUvL1Fj?=
 =?utf-8?B?N3NnVjNmdlZ5Ym5pVXVCRmEyUHhVUHduNnhmbEV3Y01mZVRUM2YycVVGVnE3?=
 =?utf-8?B?TUJleEs5eUowTVNGa3hrNEQ2TXN1alMyd0N1UDcvVDMzQUF2YjRqNW9VL01C?=
 =?utf-8?B?SG8rUEpnUXFJcUVYandBRjYxZTc3TjJMR2tvNEQvTklYM3BkWlVQNzlycVQ0?=
 =?utf-8?B?ZDlBM2wyQUc2QitONnFobW9LVmdKK2JGWEtmODhUYUZwQ0xnSUxpUUYrNkQw?=
 =?utf-8?B?d1IvS01MQjcwdHFSNk14QnB4V2hiRGNucUYvY1lYdUJ5ajB5RHpGbEpjRGZY?=
 =?utf-8?B?ajFzUk1RYmY3R053Unh4eDdTbGliR2Z5QjNqTmJtN2VCMUVMSFhBL0ZPVFFk?=
 =?utf-8?B?YzlPRVU4UklXWHdjcC80cGlzNm9hM3Y4cktuMHNaR0l4UHdPcmVUcXJ6Vjdl?=
 =?utf-8?B?ZnRkOFB3bUZoMzh4dlZpSDA0cGswU3RQNFBQY09FSms1cnpYc2FlSnhPMjVt?=
 =?utf-8?B?UjdzUWxpdlZlK2owMFU0d0ZWeGdOT2pPNXVIc0VTRTNYRWVvY3BTSnlOYVBH?=
 =?utf-8?B?QUJXVXRBTGhNQVJrbW1weFkwa1JkSVEzQnZDUmFMeDdZYWlNcGpLTUtIQklu?=
 =?utf-8?B?WEtWeGQ0N0F5NExKNHdaY1EvcWQxbG9kT1daL1FwZm14TW42K3ZhcXMxdkpY?=
 =?utf-8?B?eUFuTzBqVDhSZ0pLZ1NUdEtZeUwrM1o2d0dIbTcvekxVOGtmbUdOY1ZTWmNo?=
 =?utf-8?B?UFUzZFNzS25ibStVWEdSYjBUSnhZVExacEM5aUYyUDZETmtQMEdZTU44L3lW?=
 =?utf-8?B?K0FSMUlRZWkzREZUZGluVkM3YmdZN1h1YW9MTGpHdVM1OGVzSE1UTHIrZmFZ?=
 =?utf-8?B?TysvR0t0MCtIWis1bkkvaHFxQXpuZmxxUU9Kck5KNUFxTlY3bkw3c2hFeEJt?=
 =?utf-8?B?QVdKZlBvQkRIUjNuSzlUTzdaeDRWU0U3SGY1cUFNbFZQeTg2RU44RWc5SzVm?=
 =?utf-8?B?d2IvTEUvSHFERE0raU9aT3dpY0dCbEFqN0h4bENWMUt4UFNPMkg5bUxzMGJp?=
 =?utf-8?B?ZS9jQTFVbSsvQUNuUWRoREphMmNWeWVlZlJFaHVxM2szQ2owNTdUTU1wRzEx?=
 =?utf-8?B?NFp0aFY4OW55T1BLV1hjWmJNM1gwWHZRQjFJUjltTytLelVwV292RlBxWjIz?=
 =?utf-8?B?RExZOUZKRkxzUFIxci96N0RKalBEQzd3MmtOZVRHL2xwZDFZY2RGeU4rQ0c3?=
 =?utf-8?B?bkR5cGl1TGN5Mk8vMTRVd0Q0YWpwVks2dXJVQVkyUGE2MGFKWVVVM1UyM0F1?=
 =?utf-8?B?QllpTGxtTHBkSU5CWmZ4ZW5rV2ZJT0NPSlhZd001bjlob3QzMFFZc01HSkhz?=
 =?utf-8?B?Zm9ESXVGWXFyQVh3T3EzYWFxYU9rclR1ZFc0VmNmc0NhVTdQM3ZmRjZqblZs?=
 =?utf-8?B?QTJObVJ3L1RRM3RYWXBEeGRXaTh0U04yKzd0L0FDdE5mM3duQlVMTVk4Z0g4?=
 =?utf-8?B?MkRqb3l3RWxQYlFQVnBNdTU5TzVmR0d1b25UU2NvQ28rUUsxTFUvUm9rUm5D?=
 =?utf-8?B?MnVoY1RWalVDa0NzZUVaMndSSGExenROU3o1NjVLcWhxcSs4NnpUaUgyN0ZD?=
 =?utf-8?B?c29Qd0ljeTJkeWRpNnNGNUh6TG9nbXcycHhPZVR6b1FUSFZZK0hJdkgxZ1VQ?=
 =?utf-8?B?OWJJdHhVZy8vR1RpcFFSWTBqOXozN0lpM0FEcWdnV1BZZnh3K1RwSXlLek5F?=
 =?utf-8?B?YXdoSm5VUW9Rcy9SY3dzbS9ITUlFUnhoMFp1SGRyVzUza1c3eUdXRkZPU2V5?=
 =?utf-8?B?cEEwdEZjQnZ4b0tUamE3bW9Sd3hnSmp3SjdsT3NON3JUVEFEdlJYdWFxOGRF?=
 =?utf-8?B?eG9JdmRSUmNRcENZTUt0ZHZ6T1RRQ2xPcGZvUTI1Ty94dHFRY3V3UVoxVUdT?=
 =?utf-8?B?dTE1VzFZT1MvZk1yZVVFRzFER1dRajRtKy9nVmsvY2IydFJwZ1ZLczFrcS9P?=
 =?utf-8?B?RHBNSW1jdmttaDRPSE5JcnV1eVVwMlNYUHl3UWtZLzIvZXBCOXJFQ1NCU0RN?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/81/r913BXzr+meQpUU2qnmlGxcHct4br28QsLb0QfWHb8A/8ZrsYSymZNMmQQfqNfJg5bWY4VkdNvIbbAQua/j87y1pzCfa0dmNqQcHPdBlMyFxoU7mFLaW4xhup7HmVholmIIunIqMDYzKqu1DeTw/5bgGqVqVOEbIkmSYl9zkuvwGIzVxlpXOoOSJrjaSerCHKlv0z6QHd9MbJAUnB7oFikVFB6hg4zJ42fsmBAs9BrIOh3rlkPxpYorPXbEE+b5zFfcn8aJR3fd1TnMswjXxqJbpMyMXQUAwZRNKPrt2GKZvZmByGsgPwCt+DigOlovwzcIre2jEFFYdDER/GhSS2Y7rfClJDnY+CQDWLnKkEh+1gIbyXrec7PBVPHLwXRP07AW7zf0qK5PBBih/vghz1+khjnq6GNpQ9LI/N2R2i3qNoArIC7pv3vA0NEkl0uwyXhCoJIVhQL4TaKZ258Jly38lhJwTb1wcolxVgZv0dTE1z99nHBFTSiKQjMqereFJjQLNVUFUxVVRbLmgP6/mH5LWzp+69PBIpZ8xN0dkmGiJd9KWU2pgnpNm6JmpUoSV4eto3TG5Bu11uSDOltDBM5HTxdkNPKM7lehfjFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2947dbee-84fa-4890-e3ca-08dc2d5d317c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 13:02:26.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfrejtdPtIt82C9k8F2faRcHdnDdzmgEx2zj3utSvqKcxkBzeMjiO82rrOyw8GqnbFFeMxQiim577BHT+9UDgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140099
X-Proofpoint-ORIG-GUID: 9Xtj4XPBCiXEI9r6vhTxHLPBmnAvMV9T
X-Proofpoint-GUID: 9Xtj4XPBCiXEI9r6vhTxHLPBmnAvMV9T

On 14/02/2024 12:27, Nilay Shroff wrote:
>> Support reading atomic write registers to fill in request_queue
> 
>> properties.
> 
> 
> 
>> Use following method to calculate limits:
> 
>> atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
> 

You still need to fix that mail client to not add extra blank lines.

>> atomic_write_unit_min = logical_block_size
> 
>> atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
> 
>> atomic_write_boundary = NABSPF
> 
> 
> 
> In case the device doesn't support namespace atomic boundary size (i.e. NABSPF
> 
> is zero) then while merging atomic block-IO we should allow merge.
> 
>   
> 
> For example, while front/back merging the atomic block IO, we check whether
> 
> boundary is defined or not. In case if boundary is not-defined (i.e. it's zero)
> 
> then we simply reject merging ateempt (as implemented in
> 
> rq_straddles_atomic_write_boundary()).

Are you sure about that? In rq_straddles_atomic_write_boundary(), if 
boundary == 0, then we return false, i.e. there is no boundary, so we 
can never be crossing it.

static bool rq_straddles_atomic_write_boundary(struct request *rq,
unsigned int front,
unsigned int back)
{
	unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
	unsigned int mask, imask;
	loff_t start, end;

	if (!boundary)
		return false;

	...
}

And then will not reject a merge for that reason, like:

int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int 
nr_segs)
{
	...

	if (req->cmd_flags & REQ_ATOMIC) {
		if (rq_straddles_atomic_write_boundary(req,
			0, bio->bi_iter.bi_size)) {
			return 0;
		}
	}

	return ll_new_hw_segment(req, bio, nr_segs);
}


> 
> 
> 
> I am quoting this from NVMe spec (Command Set Specification, revision 1.0a,
> 
> Section 2.1.4.3) : "To ensure backwards compatibility, the values reported for
> 
> AWUN, AWUPF, and ACWU shall be set such that they  are  supported  even  if  a
> 
> write  crosses  an  atomic  boundary.  If  a  controller  does  not  guarantee
> 
> atomicity across atomic boundaries, the controller shall set AWUN, AWUPF, and
> 
> ACWU to 0h (1 LBA)."
> 
> 
> 

Thanks,
John


