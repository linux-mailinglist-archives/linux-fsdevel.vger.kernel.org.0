Return-Path: <linux-fsdevel+bounces-8006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE582E233
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 22:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F89B21B6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 21:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7151B590;
	Mon, 15 Jan 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TUe4DxnD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tNQaF/GW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BDE1B582;
	Mon, 15 Jan 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEa4Dj018411;
	Mon, 15 Jan 2024 21:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=a7R1wJ3Rg9bGBKa2cE7yh9WnOHuoBpQWMD/K8lQRNgI=;
 b=TUe4DxnDV/vDbL8vi9fXK6BWUGW6DoCBIjybhhGscP1mljxR/CnlJMedYVXBXqpcaE+v
 iGzXwxgwBsFWFVmNT/fBfWZP/jbTwJBYsP2Ppl11QqBLuZnbfQ8mBHfrkEDn/Ydz4ho+
 k2qv2YVdshXoI8F2jc0o2KNtomCOLu8e+e3CBFoWyaIulzPkN9fNIpMYHWwulkWZ5cY3
 j5wMkSAv9La7cvR5K5JD9eEjSkfv49K6EJmjMR3xnK2eMe/N+q5sNKn0ZonVifun9+po
 iWuyTdVaAx+V38mpNKvBwcuGFVSbFw9NE4/eQ5yRWMyLVuLy+kcLUumVhtzZnbatHjRt hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2hk0rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 21:24:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40FK0hVl004505;
	Mon, 15 Jan 2024 21:24:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgycpfgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 21:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHuSHLWSCp0wKTBWAQLrFwX0xgOhBEM9t/tlEIqaY0tnq1csCDIskMBRc/hVWFlJo9DqfSh+wDFNYhUONpwwEgpA19dYl8L1wlJwLKVmH2ySItLS6Dztmy0UPfhzafc2Nj2ZFspaUosY2I3zNtJ5KQ5SbPwAjzEoicjNbI3iYTwfrX4t9A29uxnppyhwQusSBHyC6JUIjUDFJDnyIB/aBPTr6ez9Mk4lCVEMF8AG5dUGUkEtV1VKiFIl4bAupFhdUyykl50Dq4+yejbvIVoVbvYALejxLw1TD7onhI/9saOUWW6BxfY1yTVX+g5+MuzjNHx6y8bV3fmsbCpp16j3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7R1wJ3Rg9bGBKa2cE7yh9WnOHuoBpQWMD/K8lQRNgI=;
 b=kkbctIoCm6RBeYB/9rV4QFcJSAxblKScgsl4Bm+5bDscmxvzqwtwFWnKEiX9yCbpWi6LgUHTEij7+3JRWn72b7BX1ClPUgv1S0mcBw5JtuwN0cR9QWt4kuaq/ubMMIf+7EGLJvfi8fr/LQY8MHPm8MJcM/SgfQpWwkXYdZwl1Qg/vFXYmSGJAJ8F/bs3jvdNaINxeldo4o9JP3PJ0l4wwWUqkzBnBexiBeZKpNKvfGHh4POy82RlBGf4CSjDH1prDVenoHAUNvIJPPcc0DKprZZPEtE8FOLBlSyjQcRV/SjXJIfTPN8HiFNUVfB9KjYygqClnvtkhlTe077T9IjmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7R1wJ3Rg9bGBKa2cE7yh9WnOHuoBpQWMD/K8lQRNgI=;
 b=tNQaF/GWIYpKNyuoLJfCFQNPEFkW0NzvvU7phgEKlp0oi24uItZiwuvceoUpKdX2ErKLNjpkhm6gHeRYK09I3mysnLUb2PomPicwfGx9Oer5jjOBNVt6vdke1ezv34d23+B2mdzlzQLwNNk2LSK7NU6RmqLtQHNNeqkAUQm8WbA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.24; Mon, 15 Jan
 2024 21:24:40 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 21:24:39 +0000
Message-ID: <3ca3cf50-9f2a-4110-b429-e85a2901396c@oracle.com>
Date: Mon, 15 Jan 2024 13:24:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: nfstest_posix failed with 6.7 kernel (resend)
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, Jorge Mora <Jorge.Mora@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <feef41c7-b640-4616-908f-9d8eb97904aa@oracle.com>
 <ZaWgL7RxJtAHeayb@casper.infradead.org>
From: dai.ngo@oracle.com
In-Reply-To: <ZaWgL7RxJtAHeayb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:510:174::14) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS7PR10MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e7c6bd-d365-4470-8af8-08dc161061e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gFrWDADvKyzcsqSt6InhBmkV127M93XKe9EhJgrOrdn1RmOtWJEi46Ip1LYQp3hGz6ucYI2SDKfilbZJ50UfAvmxz3ZFbLypbwmy0TBYToApOEsrPl4GNKLHVqWww9OrrHU19VoPGEZ/3xGtkX/zTCQVjQLVXMeVCsbsGFSUjchPeZ3c1WiFiVHE0fw9QTNYCZcVk5qywnolE9SWG7hs76runYGBDgJf55jP/93V6YCtQZLXRJWv6U9OszwsxcKln0I1vD0zuBtgJTmkfbO9jxP+HNCr2HBz1/el9QVwlEgxhs7UJ+8gy90ueOlNTbwWF72uvhnGzH1c7XCN6v8u+vOETFtZgLlv58vGWs3tzM9f1IvuG2JprjSyks8j3sfk9aV3ockFqxoNHwd68bj7f/nYLjQhXtYkfzLTn9yypfFR37zYVa5+G4ocUeo7icio41M1CoFB3dX5f7hV/pELZiCkWRvu8kuEumeaRf4Bx1W9+s5ppF2YP1MD+PKs4PK3kdczD7C+8g73HYg9SC9Rp0Q/C0qVU7wznVIrmDgrtM5W8S0v/y2Zn2wxltTVDvhQK2jsXtJluFbELnjv3q6J/rnWvQzKCyBV50+SB1cp+Go=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(26005)(6512007)(9686003)(2616005)(38100700002)(4744005)(8676002)(2906002)(54906003)(6916009)(8936002)(4326008)(478600001)(6486002)(66556008)(5660300002)(6506007)(53546011)(66946007)(966005)(66476007)(316002)(41300700001)(36756003)(86362001)(16799955002)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFZGNm1GV1NxMFdQUUJZMllJSmdtZXNOUnVEQ1hGM2FKUEZ2Rms2VWNBWktJ?=
 =?utf-8?B?dTdmc2tjNEsvRkRvRUcrNlZmZDJ4MXdxQ3ZzZ1UzMUdHNFErTElPQ0JYVUpY?=
 =?utf-8?B?ek9oZ3N4NXVraml3bGRhVTFlK2xzM0dycmxaMWsxSmhxajUrSGQzSmtOdVdT?=
 =?utf-8?B?ekN4bERhTmhGVkdvaDhQZVlYQk44Z0dubFJsSFVIaTdOMnVKY21WQVplemxk?=
 =?utf-8?B?YWtxRmROVERRdjlIU2Z0WEcrdjFmUkcrSjM2bmNrSTczU3FTVXNDdnpTc0Fa?=
 =?utf-8?B?bHhBeGo3bFdmVTQ0SGlHaEpFYmNyTlAzT3lScHpNSCtiVnZ2eTVvazg2V2FT?=
 =?utf-8?B?ejJyakczZFloR1gyK1prMHFnN0ZyeElVakJySGVBMStuUGlwYVZOaGUxaWRr?=
 =?utf-8?B?b3RtRmNYU01Db2JCdG80MWwvLzNUekZMZjRGNEZqSDI0OHk4T1RrL3M2eUtC?=
 =?utf-8?B?djRrR1c1VzIrUkU3NFFvdE9wZTE2Uk5lSU9lZ1ZMbVRKRlMzTjZDRXR5dHlk?=
 =?utf-8?B?UFhMWmJGekQ2aUVGT0J4aStsOWhFUEgzbjQvK3EzblY2cjF6K0hlbzJoOGty?=
 =?utf-8?B?ZElleGVQK0RsckQzZU1wTVlUbDQ0SUFwMnQ4cUxENjl0bkNPdnFkbDExZFFH?=
 =?utf-8?B?blhrMnlxMDRISjk0TWZGOHVzdmMxaEV3dXFSSG85NzlmdFVPaW9MNU5lcGVx?=
 =?utf-8?B?UEF5cUZKZVhvM2pVK3ZvNmlPb2NxSUNOSHhUdFpBNTRNNityR1JkZmlXMGM0?=
 =?utf-8?B?dUh3UkJENFRIZUp6OVA3ZWQ2N0Z3ZWU5TW93c2Z3L1ZNQm85dVJqYkpaMTc1?=
 =?utf-8?B?c2g0VjdJR1A5VmdsWGVjcFh4VzErMDRFZUFHNXN5a1U4bHA5eDBCWnlMYlNW?=
 =?utf-8?B?VGQwZTVqRk4yUlBwR2MwNmZ5VnQ5MXZ5VzE0R0dySEkwM2hhR2puV1FtWEho?=
 =?utf-8?B?ZVMvMnpBMjlmVVB5L0c1aGt1OVYzT2hoZ1hQUUttVWZFVFFIeG5oRUJHbWFl?=
 =?utf-8?B?UERJQnlKYWtPYnFYVjd3S0trcU9yTFpCUTJOSXhBQUp1OFJnQ0JnSlVHcCtG?=
 =?utf-8?B?NkFlVHpBbmNMcmNNYnRydy9WWS9JcFdxcUpzbU1Nb2p5eUw0TXNQQ3B4bjdJ?=
 =?utf-8?B?RlFoTmtDWVJGbDRGV2ZOMmJybUZvMGlTYlJka0pCb09HbU5BYjM2SDlJVDQz?=
 =?utf-8?B?blBjZ2tpZ21nK2gzcjR3ZXAwRkgrb2lSK2VDNzBGRXZSS1Z6ckpUU0xEN0xL?=
 =?utf-8?B?NFpZc3hiUmNBbGp1V1RFU1RyaC9JdVhiZkZ5MmhyRXIvS1NCSmZyaU1Ec3Za?=
 =?utf-8?B?NmtEcHlXSXlVckFDdkhBczdLMDk3enNWcVBsbmpWekx1UDRzZ2xLUjVjTzhJ?=
 =?utf-8?B?YnROMWNLeTNvZGZFcVY2OWV0Y25wZ0JRZWkxczFqalRiZFJGU1Vqa20zeXBq?=
 =?utf-8?B?Q2FUU2h3SlY4elZFNVRmRmRYUkVOTlBIclBXWXBVVDl5TzFjVlBPNlBxY0g5?=
 =?utf-8?B?R3BvR2xSRDU2RFFOclZyL1dWMzNhUTIwbGtEQ1l6WU03U1JheVI5KzRGMmk3?=
 =?utf-8?B?OEhkQXN3OS9QWEFpWDhkclh5bCtXMStEMWpqRjRBOEIxN1EyWnFiSysvNDVN?=
 =?utf-8?B?dWRXblZmbEdIOG9saUI1RlNTSFRRUU80NHNJVFpGWXhCVk03UGVOYktNRXJK?=
 =?utf-8?B?akgvOEIxcUNRc1FCMGR1bkl6Z252aUJtYllyOVhVajJCMG1TRk1kbENCbDVn?=
 =?utf-8?B?Y3BxVUZqa21jU1NGOVo3L0xkMURKZXErblcvaElLbXJlSU5Id3puUndXWUNw?=
 =?utf-8?B?MncxUllZTmNFaThzQkFMOXR5Um5zVjkvMHpZalVIQ2dZSWRqNXQ1QlZ5V1Ri?=
 =?utf-8?B?N1ZaQUpBdEhVdmg0blJHTnI2TlB2dUYwTW9VeGdzTjIyZ29QRUxhcTFjRFBL?=
 =?utf-8?B?T3VKL1c4aWNVOFRNVVhJYjg0azVDQ2NWcHZXN3cvd1Q2YUFIV2Y2ZHNaUVBt?=
 =?utf-8?B?Nmx1SFFnd2pqNzR0Tm5oMWg5c0tFWEJQMElsN1FEWFB4UzlCKzJPU2VCeHN2?=
 =?utf-8?B?YUc5dXEwLzZTSXZLbktnN2crUFd3NVYxclZOOEpWclRlcGlERVJKVGpIeDVZ?=
 =?utf-8?Q?yuTZ31bMMwt8jgOta4JrkrhvP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VaJe/tnND3MBt2YI8LpIQRNczd1V1Iso389I9dA6pXBZdGBUIkhPg72shws6hkNa/yRR6tC1KpzpKGD3roqRhJfOfm2Za2wIRBTWfIr92Xna1ybLuXaBBpUBL9uVMT2jPpcSLwTTio3+g9v35Yfbz5a20GZiyvlxQb8Mlsd1EauzTaJturDwSiz7k27eGHAvHcaA7ASMtMKmln0gz6dpqEtOLSwRtOQSiVjgBtkVezjJ0vYQzuo9njkf/qN2AiHtNHaRC8IyT9YMjoTmfSAm8QFJRtNRjBnK9NEGnNLymvDMBExvo3Zfvl9EaDRYTxE+LjsGXAkiIwXtc9VaDBH1miDoqgcM9uqz8CB6k6wMfX77OBVPRi866gA/GDIbsbFiQ6QsVn3Gcs3GbzKsG+Rbmr2bCuSMcMYKtj+CFrswZyALY/46yG6RYgjBeSlZrl3ML8eKJJFbuhcq+v/uGD0UIjoSlrjs8intzUKq3quwzL1otLNz41cHdSOiFwOqgZgtVZlNgoc7kQeBUgN9ywfGKtpGTh6wWsuyhLYdOjgO7A0bp9956gA8k1cCGDs+ejuWhesuDrsCF632Bm/Z9BrIp0+ct04NsdBhYFIbS3mbjkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e7c6bd-d365-4470-8af8-08dc161061e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 21:24:39.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ev4eOLbC6YqYBTp0tM+Q7QKY+S1ipl7IozM1TtXlWbzVTJrpqpbEQ76C2NiLlUJIQEqJFQ4qAxS3RPqyaYyQlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_15,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401150158
X-Proofpoint-GUID: ne2DOxnwgU4A2ccmXHEtdBhjBaCTSv9w
X-Proofpoint-ORIG-GUID: ne2DOxnwgU4A2ccmXHEtdBhjBaCTSv9w


On 1/15/24 1:14 PM, Matthew Wilcox wrote:
> On Mon, Jan 15, 2024 at 01:05:37PM -0800, dai.ngo@oracle.com wrote:
>> (resend with correct Jorge Mora address)
>>
>> The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:
>>
>>      FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
>>      FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
> it might be helpful if you either included a source code snippet of
> "nfstest_posix" or a link to where we can see what it's doing.  or an
> strace of the failing call.
>
This is the link to source code of nfstest:
http://wiki.linux-nfs.org/wiki/index.php/NFStest#Download To reproduce 
the problem run the test as follow: nfstest_posix --server /nfs_server/ 
--export=//home/nfs_share/ --notty --createlog --nfsversion=4.1 
--tmpdir=/var/tmp/nfstestlogs --verbose all --runtest open -Dai


