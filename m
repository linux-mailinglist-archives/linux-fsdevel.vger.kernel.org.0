Return-Path: <linux-fsdevel+bounces-7022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9836981FFFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 15:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF031C225BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C5D11C99;
	Fri, 29 Dec 2023 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iaGFGJtc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R0gnkD0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE111C84;
	Fri, 29 Dec 2023 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8O27q030064;
	Fri, 29 Dec 2023 14:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=03k/bpvdtFLMH9dhNgOcvjN+QL2fpGJos1lHowUI30c=;
 b=iaGFGJtc1nqlmgmKx+xUoRtIwiw3SZddFiAe/D3UMeLDHurNgJoGaaVIl0us/QIBn1lG
 NgFY+0mKtsb5hm7ki/ZY/9Wn2gWE4uvDq/kPPvcxyGmQ9rX9z4bdpKtN3PMN6B9VZcdo
 ziMRqasl7y5aK+yjOyYtq4qriccXot5PR+D4ycjnGfC9esOKfmO+qRV8TgR4sza1qa+I
 LhukCMgDPXKHH2ZpsmIh5GKCvPCaiI76oK44dBPEMY3yvu6LNsXG8jzQIlfXPnuFC3Z6
 VpMujkRUbYwC4xUZUX6U0fZUOm4EnDrUBmPW3wpaAzumPYAZhXLrczPhgilE8dQhshP4 Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5qkd7qbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 14:35:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTDCnHR014948;
	Fri, 29 Dec 2023 14:35:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v5p0dc1rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 14:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH0manMD4nthQyxl/vf5fK0rqJSbc2zO8GhnBp9zs/Pst5egTWPB7Sr70dIbg/IusYjoPpm3P3zuIpdyHY3ZpcbwlpLvcpWNF9WvplFV9Tsoqnb2BaXQG9tS8XB82F2RNDJ3jOgIW61BJo7Q2RVXOPt3EQHDSJIf39wjQ+y8mNnMALPs++7DohCzV5nT5mVBjcMMAZY+HpEUnJ/jeV+qfUlygTMPuzGq+kpzc7Wu45cGyiri+2Vznuupyi8ppWmb8kXy3IM0V0YBA61auOkIJgqjyflsrj5T1YUZOEABhp0FfEz3ggnNesYvLb/M/FqneImyl1D2paAS28iAQbjPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03k/bpvdtFLMH9dhNgOcvjN+QL2fpGJos1lHowUI30c=;
 b=HTPiu8TkTQlmvLbZNOKkjlLJ6DeVnEWf1LmHB8IlQBReP9qE8Gs6dp8/goCrWKSuKrJ1N+GQMzrNUCpvCvV48vkGRDF/zMyT0dm/vuoy/bR76M+MO6lqI4ymRM3NmfzNvkNnSHqtnEzuLRK4OV4gLZ8wUUrvjX2oI4YHWxoQS7UoeQ6Ptfbxu56neVx8Jxuo3HiZLj+qqHvFzzpkJvNS0/o0kiT0nE5Yh1gnAoH4HUOJQW2VQI2HXfWLjWwYniSkM0HkQzDJNI5Ct/1hZJyAIWXhKP1N8XpmxlzgL5rGYV8S6Zlxj02dVMRY4hiBhoE0JPozQRrxdgCBaQoEQyYp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03k/bpvdtFLMH9dhNgOcvjN+QL2fpGJos1lHowUI30c=;
 b=R0gnkD0Q1Mj6/s/pNoeL4Jn40Uh8u3sLtGtTX8VT5waiomTUPxDv1P8MDy7PWqYfWp0UAW9Orm4Npwr4iMqZOrGRsyqXmlLuTfmwphkJ8bJqlQ+SQJXcDK4qUrc/AOhgjZy3HG2hfzMjPtBjrNfg3YwSLDFSsqSJ0NH/QSiIMy4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4287.namprd10.prod.outlook.com (2603:10b6:208:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 14:34:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7135.022; Fri, 29 Dec 2023
 14:34:54 +0000
Date: Fri, 29 Dec 2023 09:34:51 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: trondmy@kernel.org, Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] knfsd: fix the fallback implementation of the get_name
 export operation
Message-ID: <ZY7ZC9q8dGtoC2U/@tissot.1015granger.net>
References: <20231228201510.985235-1-trondmy@kernel.org>
 <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiCf=FWtZWw2uLRmfPvgSxsnmqZC6A+FQgQs=MBQwA30w@mail.gmail.com>
X-ClientProxiedBy: CH2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:610:4f::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 546a82a0-eefd-4f45-899b-08dc087b529d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	96M/EHe0FIypNUVfW4Y7Xq69b0MCehUJbwaL1pq8ABLg87NQHym7QkJ96fOnRDE15hNR6HpwzhLuxoiNcVALxtnM/FINqm81+LixDzBguKguyZmC1TqzAmncUXjKMMerbD+nHVrDjoLTsNo5RxxEUU9opq9PGIA34PG5yunvV1xVuMAHCVr3bcJMxfH+WZuuiuz4qHjvpO15TcnugWrhK/SdYiHGPNIIVMRxIWLHWawhatzDTHS5AEj3rN7zhYyyz6zSpUXE4/GAWLWoPKhFluqgX8suMui4SYkB5UxxZ9y7jS2r9l1lY17Q+v41RvpM5QNUIYz41GSP6sViUwyhmkxAoSpfv11wa57BzZOihBYETBu/vVHThkUJJigHMG3/hVzvCTWCmtCBB7IT72+KxK+qVKuMRMe6qbPFHpNKTY6F8M2oV7se8AwBS6EPKqmhRUFsJESetv/RfrpyTa0K26w50u7RxaX/qGqZzhdzkI/mvDvrvnvoTtqEArEuHZEVnaJjwIgVriX3dGn2olkcSSa8JZ6tsaBUe11BhGqc1Q8n1q2OO5y2oojIGsP90TK+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66476007)(6486002)(66556008)(6916009)(66946007)(44832011)(4326008)(316002)(8936002)(54906003)(26005)(83380400001)(478600001)(6512007)(9686003)(6506007)(53546011)(6666004)(8676002)(2906002)(5660300002)(41300700001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWExSWhFV0QvalNDTCtIMzdPaHNPay9YN1ZIRXVRZ2ZaUkJ0Mkg3dFB5dzJw?=
 =?utf-8?B?S3JlaFlMK3BuTEU5eVNXZ1p5RWZvaGYxME1jOFpaOVNuOHhkQTRYd2pIWWNK?=
 =?utf-8?B?U3VJcTRRTDdmODQ3R0NGMG4zSFlvUm1OQjBZbVlQT2dFY1J0NkxyM2dZWnRw?=
 =?utf-8?B?S2VtRGFTZ2ZSbStTdDQvRXZTT3kxbWFrbkwvN2VWOXF6eHdERDhCeVF4ZHlN?=
 =?utf-8?B?dEdWcEhDdzNadVV0V0FoQnJhd2laQXlkaXdpYzkzVll1Z0pBMkR3czNIZDhi?=
 =?utf-8?B?Q3hCZll3eHVEMjBQemhjMWdzOHErOFVhTjFqdWJaRTJ2M1E3OGloRXBMVVA2?=
 =?utf-8?B?dFl0QnVSR1ZXVHZKM2Y1cXpzTlArWHdSTmx6cXZNQnBMZFZ4Q0FaSWJJU2tU?=
 =?utf-8?B?dE52clN4UGUzanRDdFAwNG13OExEN0VBNEVkZ2tVQ3llUEU5SU5paEw0Q0p0?=
 =?utf-8?B?YkoxdzJJakQrYTJ6aVZHWXpIOTlwK0c5cUlXa1kwUmtBL1pydzN0OFoxZWow?=
 =?utf-8?B?YTVaU3dxNG9ZbERBNUR5TWFxTmw2akl1YUd4aDVIcFpKb2dBOUIrVUhwY2pl?=
 =?utf-8?B?SFI0a1F0eHF6ZTI5dmdBKytKZHRXckhVMUE3UnZKZ25UaWxlVGg4c3dXSXdz?=
 =?utf-8?B?eFZxVzNTTWJoQXkyeXFZdXR1bklUN0VyUHcrOUZsNGJkMVhJdG5yNzJoTE51?=
 =?utf-8?B?b1FuMTdIMExVSXZIWG1ubmhhOHMzOG15THRFdTNEUmF3NEVGdGNxOUxUNWpa?=
 =?utf-8?B?WU9GcDhqZld1YWJ1WlR6V21PUUpmYWFvelhvbE5TVDVhclVESmJXNjlxenI0?=
 =?utf-8?B?YVVkOHlIZ1BtR2dFNnVTcytjNCttYitVdVBMbG04UkJieU5mYit4SU5MdTF2?=
 =?utf-8?B?MEliSSt2YU93dHdXRE44WUdQaFl3cGREVTFwa29pekxZNjltdW9MTVI0VjFP?=
 =?utf-8?B?R3grWXpZa2l3NUsyeVZwTjR5dk5BNWNPREw1aExCNnNhbjFMcllTbC9YR2hX?=
 =?utf-8?B?RXF5d3F5dkVXMmNzYzV5U2pwQWZsMDQyZkhuMXVFWStUdXVQN2UxaXk4UHV5?=
 =?utf-8?B?MWZRQmpqdDJlUm51eDVwOGFBdWV5TTArNVg5Snl6b0tscnp1Q1FiYms1TDZo?=
 =?utf-8?B?c1dFWEdESVBUM2JhTWY5VjljV3ludmZIYzc2bzVNM1hCVmNZT29qK0ZzVmp6?=
 =?utf-8?B?M2xLaHZtTFpQeURURHUvajF5QjFTT0xxTzgxVXFsbGsxVU1sanJNQ003VzY4?=
 =?utf-8?B?OW5SVkxybHhzZlllVnE0OUx2K1R0WHVIYnU5TVpyM0NSRUtTSTNsTkJ0R0JC?=
 =?utf-8?B?RVR0SHYyV3d4S0tTdUlDRTB1N1dpUmtHbXVTbDdOMjR0RWx6eDlVUmZOSmF5?=
 =?utf-8?B?TVdmQ0V0eUhEQkh0V0tGcFppY1dqZTdHdEY1bVd5dzEyOWp0R2hmZGJxNlVF?=
 =?utf-8?B?K01QbUpvcWhwQXZFWXkrQ0NnR25QWktLcEw1R3NtS3gxVUVzejNPL3FnWmtu?=
 =?utf-8?B?TVE5amVyK3dpMEZRME02cFB1UC9Fd3p3akFaUGc2bXg3QWYyUzg3RXlNNkFn?=
 =?utf-8?B?ZkdqS3Q0Z3hNSi9BVktkNHg2ckR4a01CWEM2bDFnVm9taSsrNnpzNFhpc2sy?=
 =?utf-8?B?eWQ3aXNhNitqU0VCSDBKR0EwTWtKWFJHVFhZMXl5QWF5b3o3Sml2TlFvOWk3?=
 =?utf-8?B?aEIxWk1leTI0dWNQQXFmY2ZuaFlCSzdURW56WEVwbW9ZcWlCQmJRa0pLRksv?=
 =?utf-8?B?SlFSV0FRNU95cjhpZGx0THplKy8rZjhWQVM0cklCRXJTYnBZTGVnRVgzMGls?=
 =?utf-8?B?TCtydURkQmtvdDFnYnFMYTBxdnQ0U3hYckluYlFGYU00UXora1g5R1Z4RkU3?=
 =?utf-8?B?M3o3cUJxU3BQY3BpNklBdC9UVVQvZU1UeUhSVFlQZ1R6dHJvdFFDMzRWREg1?=
 =?utf-8?B?OFJFUEJ6T1VGL1ZOMU4ycHRvT2MvYVVUellDZDZjeWVpWVRvbzRGdG5OSWox?=
 =?utf-8?B?SkJiZEovNWh0RXRueXc5bnJqT00yVkV5cVdVVzZNNEVrSFNlaXRFMEFrK0dk?=
 =?utf-8?B?VG5VRkllcUl0Y1d1ZG1xNDk5WDRQZ1l3MWtIVmpETnJUSkxpYWFQTDlrNGla?=
 =?utf-8?B?K1lmSXh5TmdIQVgyS0o0cEcwWnYxdEFaVkhOUnJCZDhoUU5xa3N6N1dtRkI1?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c56WFXPRn4j4iIuFSQixtCRtYKZ6dNSF9U3e95Sinb0ZPR7fwyGOgXo9iGgC2H4pVd5PrLJ/AScwouyuSGUtQX++eB6FCmtNtkvyIrcQdxzpi/bq40qu/JdZrIJLtEce3PwE5/sjb6kE3842Tio4THWxffnWRbqwvNcekUc+k1fA26IVXVG2T8XbXptaYtYvWjr419lpADXjHZmDQ2Khr5GV0jaUNdU72fj0uLvbtddds6PcX8tvpG07LVsCMBY5drA2qbwk8EvNpA+4f2XTYHCFH8B75xWCkzG43Zx07D5vY9BDTIDkpQsq5hIQ6I1aMWvTlu0VyWC+7gUd/zs8FSKTRAyRldDF5u258KviB8kITJpY3reDIVBS47kqwKFfyaz0+PZ4Cv1bio4RNb6jToA96SSEUqUTFNRmZkeIKHr0tetbphyFc3XJ+UKvd0UV4Ksgg6YlRTQvEbaq+rjYxoy5EZYix8oQ3ZewmdGvvWYcVkbtpMM33D50FMKLVYebE3kM7YJfPqf65I3v2XILZjIN8ks0QP1kMpI7WPwCO2owL4cQkStKkHCM5SuDo7cj6fQjmE17+C+M4ikB/m0qw7rMXl0j5bP6aFziOVdLP2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546a82a0-eefd-4f45-899b-08dc087b529d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 14:34:54.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6u16eiMhfXJNcFF3yw1YC4GkgvrYPrX1X/egLW5s5USM5Ad5/OweJ5ajkr8HrfM+VuQn4PvPap29Kga0xI0yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_05,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290116
X-Proofpoint-GUID: Pk4LUq-F2PjGAsVX_r4YTbbwyEQThopT
X-Proofpoint-ORIG-GUID: Pk4LUq-F2PjGAsVX_r4YTbbwyEQThopT

On Fri, Dec 29, 2023 at 07:46:54AM +0200, Amir Goldstein wrote:
> [CC: fsdevel, viro]

Thanks for picking this up, Amir, and for copying viro/fsdevel. I
was planning to repost this next week when more folks are back, but
this works too.

Trond, if you'd like, I can handle review changes if you don't have
time to follow up.


> On Thu, Dec 28, 2023 at 10:22 PM <trondmy@kernel.org> wrote:
> >
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >
> > The fallback implementation for the get_name export operation uses
> > readdir() to try to match the inode number to a filename. That filename
> > is then used together with lookup_one() to produce a dentry.
> > A problem arises when we match the '.' or '..' entries, since that
> > causes lookup_one() to fail. This has sometimes been seen to occur for
> > filesystems that violate POSIX requirements around uniqueness of inode
> > numbers, something that is common for snapshot directories.
> 
> Ouch. Nasty.
> 
> Looks to me like the root cause is "filesystems that violate POSIX
> requirements around uniqueness of inode numbers".
> This violation can cause any of the parent's children to wrongly match
> get_name() not only '.' and '..' and fail the d_inode sanity check after
> lookup_one().
> 
> I understand why this would be common with parent of snapshot dir,
> but the only fs that support snapshots that I know of (btrfs, bcachefs)
> do implement ->get_name(), so which filesystem did you encounter
> this behavior with? can it be fixed by implementing a snapshot
> aware ->get_name()?
> 
> > This patch just ensures that we skip '.' and '..' rather than allowing a
> > match.
> 
> I agree that skipping '.' and '..' makes sense, but...

Does skipping '.' and '..' make sense for file systems that do
indeed guarantee inode number uniqueness? Given your explanation
here, I'm wondering whether the generic get_name() function is the
right place to address the issue.


> > Fixes: 21d8a15ac333 ("lookup_one_len: don't accept . and ..")
> 
> ...This Fixes is a bit odd to me.

Me too, but I didn't see a more obvious choice. Maybe drop the
specific Fixes: tag in favor of just Cc: stable.


> Does the problem go away if the Fixes patch is reverted?
> I don't think so, I think you would just hit the d_inode sanity check
> after lookup_one() succeeds.
> Maybe I did not understand the problem then.
> 
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/exportfs/expfs.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> > index 3ae0154c5680..84af58eaf2ca 100644
> > --- a/fs/exportfs/expfs.c
> > +++ b/fs/exportfs/expfs.c
> > @@ -255,7 +255,9 @@ static bool filldir_one(struct dir_context *ctx, const char *name, int len,
> >                 container_of(ctx, struct getdents_callback, ctx);
> >
> >         buf->sequence++;
> > -       if (buf->ino == ino && len <= NAME_MAX) {
> > +       /* Ignore the '.' and '..' entries */
> > +       if ((len > 2 || name[0] != '.' || (len == 2 && name[1] != '.')) &&
> 
> I wish I did not have to review that this condition is correct.
> I wish there was a common helper is_dot_or_dotdot() that would be
> used here as !is_dot_dotdot(name, len).
> I found 3 copies of is_dot_dotdot().
> I didn't even try to find how many places have open coded this.


-- 
Chuck Lever

