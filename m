Return-Path: <linux-fsdevel+bounces-7372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D458243CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 15:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2781C21FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BE9225D2;
	Thu,  4 Jan 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="odwmHuiR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G0BPEt9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF9224E9;
	Thu,  4 Jan 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404CRtVj032570;
	Thu, 4 Jan 2024 14:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=qjyjA+Cg+63vc1XiDKRpzDFLNrfnWqjhOr6IPRCILU0=;
 b=odwmHuiR3x5cl6MpmIDCnKC0T4bsc2dRTHuOcXZhF6RoeV2ZZ/5lPfXfMXg8hzgLFxxw
 o41PT+tXz7CqGUkz9sRVae3IsIOqiyzKRiQzwukBXoZHEvxyGAnxr1Phe8r2BxYPArO2
 84tOm50qIBGSKyCOLtiWKv03Fk+grI0vQ1ALY3IZ9cE8fQZnLXUgpj8NDBGTeWV8NX4D
 2DN518JBX585iXaDK0GYGAsTFAOXlJur4ZxqWdCZNUZPkWsfiWdy2ZF5Ef4jP6tMq/4F
 8qAql4tHAV5bp8EjlDRSTRddC8nAWVd9b4nXY2MRdbwuJ/dYiHigmY7m200wOgmD8sSh rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab3ay60f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 14:27:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404EFNQw025975;
	Thu, 4 Jan 2024 14:27:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdx900ud0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 14:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy9XqO7pm+LrBrimEq5Lu9YtoDfbpZ2Uzo77K5ey9XAU2Nx+gY8mW1YiZXd6XbYIpQSJuSEOfmYrzHyA5wsLNUgfttRX98B6rw020zh2XpnC5NT7EwJZdMWbh4QtSkLEe0UcYppA95CeMwWjn514AyDRFxzTB+W9Gj2WF59zLdEipI58CF8B5VJ/ukwI/1KEd45oz3TrFzPrq+UEmmNXwyx2f4uKt5kF7X6KI/oMRnpzIzLa5O4Ode3RvUSZP8zIswlEGYFWeStuiPnAy5QtUuPgk1oxvLWv/E04ONFWFd8buEhio3eosKVjEJyXC6FA/UKYwKfkDbHjg19XvyyR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjyjA+Cg+63vc1XiDKRpzDFLNrfnWqjhOr6IPRCILU0=;
 b=ExHKG4zd6sPRZnlzqlcUbrLSCzkjdAsNjxZ55/6+UF7qG8mF4cINZ7PimJPp6HmB4XHXX/tpUa8OvisHRkFh+z46DVYwawl1xCsb/bNPijx9jStwgNVU6JneDdQ9fr6z3ECxvaY7NYW1WM3gH9IS7VrOdtilLrdUIBHxwklw75DJFqK2pySqRZlTKwqk70vdrv5y3ijybESm9o28I0CjYE2eEZ1JLUEoWn1155CBm40jvhguOT4V8ze5qzwE1RH+bkA3S6kK3qcrPJ6QMeiCBYgTlZ339K8nryQFiO6Rh+JV33Lsdzgz+kze5p+bDyNAroRkyKPNzJMKKRWphiGV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjyjA+Cg+63vc1XiDKRpzDFLNrfnWqjhOr6IPRCILU0=;
 b=G0BPEt9lwMpKE1hhkW7W/5HIy/lwagxV2843n+rRdnQOievLZ2HHve8bMGz4JrlmhHukZ+yNhjwlBfRwOgBncnoxm2jB8INqc7mC78LCLp3bKxDz/k5PBTSJe/xMxOVGxhBt/JC/U9efGwNTZ+8ZjKCBbgcWahcsxBWBIio/zlE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 14:27:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 14:27:16 +0000
Date: Thu, 4 Jan 2024 09:27:12 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chuck Lever <cel@kernel.org>, jlayton@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [PATCH v2 1/2] exportfs: fix the fallback implementation of the
 get_name export operation
Message-ID: <ZZbAQEgqbV72RJn8@tissot.1015granger.net>
References: <170429478711.50646.12675561629884992953.stgit@bazille.1015granger.net>
 <170429517779.50646.9656897459585544068.stgit@bazille.1015granger.net>
 <CAOQ4uxgMLWGqqoSNvSgB=Qfmw6Brk2eO6yB7FZqX6p-DcTiUtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgMLWGqqoSNvSgB=Qfmw6Brk2eO6yB7FZqX6p-DcTiUtw@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:610:e5::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: f005a4ba-5810-44fc-4dd1-08dc0d314001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mu10JU3y7+SydrNi71C5Q4o7M6qON9o9wozld33Cm7I2RCiv0GXhh3DYIaeRv3c6DtRcf8f2O1wp0wKnToIOu3DyudleulkjtaFlRqd2IxhtKfK2OxWNKukwI8e94YeGxwtQl5pK91LTzfCHLNLVwyqy63esTcPtn1aZP9MVLd4MdxMyIQHezY3KZu0SIvHdPzI9ezYgrgJRuFWzHa5Sex3Ooy672s2KmnZmJZ0Lei+yfoDyT1SJ8CkW8QPfIwllaS9tpCiqpbwTMZiXyuckY1nQdl8znsZYkcQZKfk8hcuae2/PMraAi7ZwC9myfggDL6pftvgqTTgzl/Hqx7Vz3DMadKaKj70qHlSfR1m4gQrMDOvxqjfZa2BlgQ2K94tuApulsE2mAw9g303/e3nCMTM0tAPpCP2O4djJfVzC/Zrw1zAf3gN1PMRFotwoT7yDIRRXUsU6Z/RgfKCqGmpqgK5vhdOXyFxqdY5y+6TO6E+55zWgAoG2S94cDKIbRBGUW2+sGYsTcAJRwaAfy9OUaGW0nTwur3sPHwjstE5XPKgJy99dobAhsYF0ua1BsCLlT64p/ZFHBWrKfSONRY6cYYd27usiv7cLf3pWfgM3JbksYoqXTpffFxHrlhvYqteh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(4326008)(7416002)(44832011)(5660300002)(2906002)(8676002)(8936002)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(6486002)(41300700001)(478600001)(6506007)(6512007)(966005)(53546011)(6666004)(9686003)(26005)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzlvZUxMRndESld6Sm1vOXpETXYxT25VT2c3dUVJajZKeWM2OHBYNnhuUFZs?=
 =?utf-8?B?OHNTemVRQUxXWkUyVEFzTldoWmd1K2p6MExvM0toN3g1NklrdEdmME54d1pN?=
 =?utf-8?B?cWRYOXNFaWViRHVLWEJwemVOaEYzbFBUdlNweU5RZ01DN3NyUjhvWE83WGcv?=
 =?utf-8?B?dUd5cFA2aTNCalpod2dPOVgwMTIvaDhML091RElBa3hDUHdiTERrdGZpcmpX?=
 =?utf-8?B?ZEdaVk9SWHA4cjVNMHFobzRMMkV3QUhnNzFES3JuTXRuanMrQ1FFYWxYcGFu?=
 =?utf-8?B?UXJYUisyZU5LTnNvdmJ5djY5bWZaT0RRVjJzZnFzcXBPZ1BFM2NlRGFuUUwr?=
 =?utf-8?B?TmZoaEpmZFBTRmRtS2x5U0U2RytJTGVGeU93NDI4MHAvY2FsazdQVzNEUmly?=
 =?utf-8?B?bkJRaC84QjZRdTNjckNhMGdtYkQ4YWlFVkUxVHpqSGlkY2N5MFV0SVBnSDZL?=
 =?utf-8?B?SklqRkpGbUxEVXNpQStvMHNkRVR1dW13NXJRajJBVHVzQVhuVXFMcVBmQm1s?=
 =?utf-8?B?OHNySFRQNjR2bHJMMjZlVkl4NEFDZTQ0MTIxd056UDg0TmpKeDRjMlJyeWVZ?=
 =?utf-8?B?NlNFNnkvd3M3MUVRRVB0cHBQY2IzWTJOa01jaTNFVCtDNXpsK0NYQVpRdVdo?=
 =?utf-8?B?N1RVcjRFWkRSMUUrZ0VwaWx6aGd6Ykt3dmZndzZveHpLckI5MTdkeGhRQXFQ?=
 =?utf-8?B?Tk4xVUlhRjErQkxRdFJIUlllcjZLZTdtemZXVlVBdjFPajhPTnFTL3Y0bTFq?=
 =?utf-8?B?a2ZHZTIrSU9udGRUQ1JzMHp3NEI1RmlzSUNrVkY5RGRjSGFUbVZTdTBWYy9h?=
 =?utf-8?B?WXZRZVMwcU91T0pDS0dyMVR0RS9wUVRuNDZlbjFaeHhCZUViUStpWS8xTnhB?=
 =?utf-8?B?WWVCMFFqNmdXNGtxZ0ZHWW9YNGlQeU1IcEJOeFdtRlRUL2RYdmZhQ0xBVEcv?=
 =?utf-8?B?RVBkT1IvQXhCQjVtTWcxdXBIc0VIakx2U1hHWlh3Mk80S3pOam1uUXZlNmRz?=
 =?utf-8?B?N2NVeXJjRHhiMm54YUZuVkZQTmVLNUdOWWZ1WmdjVmg4bm1iVWtabUkwUHRa?=
 =?utf-8?B?NDIvSElnejhQOFl1andPbFE5VjlERzZBbXU5V1BTZDNzdnk0ZldNWHdkVFc1?=
 =?utf-8?B?aGxwNklwWTU3d1RxNzJ4dUhLV2RZOU5hN2dIWW42NjhwdU5GaklCcFdTTlM4?=
 =?utf-8?B?cFJrUFZ3ckV3YXNFS3FYVGg4UTJMTmVtL0laV09DUU0yY2J6OWFFMGxCeHJs?=
 =?utf-8?B?YXpFYlpZcXNDUE4wQlU4YnNrZ0dCWXhVdUFpeWNlUEE0Q0ZHR3I0TlNXc2xv?=
 =?utf-8?B?alJENFNKeXdZTWhwMEFBNmRqb3o1SVNIRHpXbUx0WnBBQzl4aGUyUlhKb1BZ?=
 =?utf-8?B?MnpPOUp2R00vUEtqZi9TeEk2c1dWQ1diQ2FrbzMzM0NQcEZ2RklodG9ZamUv?=
 =?utf-8?B?NzhpRXFRNjZUNkVYNHE4SmNMZlZDbWJCOWFobU5YdDNSMm9LUFBsUEpHekJw?=
 =?utf-8?B?aUFsNXBEaDc5dmJVK0xiTm9iL2tPTFg2T1gwdDVxN25vemRHZmM1a01NeDA3?=
 =?utf-8?B?eHFMelZpaVlyREdFVXVibnF5aEk5WDlSUXdFbzRTUW8rSFRZaGtLdDQzYTVP?=
 =?utf-8?B?cDV1MExsdTQ4NnBaNlFzVmRNMDNuVFhmcS9ZeERZa3VodTR4OE9PMUxwalFZ?=
 =?utf-8?B?aWhCamdXeS9VbGdTd3RWMHBqVnd3MVQ3QUlVSnVIclRJRFliVnpvRDN1c3ZH?=
 =?utf-8?B?bzgyTTFOQktVcG43UTEyT3RxU3NOamR5TS9UWmsxYmhjdUlQa0Q2V2RIVWpt?=
 =?utf-8?B?SG9kRWtYY1E3ZU1yeHhMN09zd0JvRTdFOEhTajhENkUyODEwQzhra2JDQ0ww?=
 =?utf-8?B?TkJLU0QzWk95Vk92ZWRzaE5kUlRrYlV4d3pjRUpmYUl0RjdtNlVid0dHZXEr?=
 =?utf-8?B?ZGIzNlMwQWN2ZlZZdi9nL01ERVExNDRBMUtjZGk3SEtyaFBBMG5ZVzNFV3Yy?=
 =?utf-8?B?NllkSDVjNDZxNEtnWklSczU2a0lzK3Q3RzRWZVpZaXNqQzlRWDRaVDkvQ0hC?=
 =?utf-8?B?bVd2U1BhVUZPMkdEZzRLcmhRSmMzOTI1ZS92ODNJY3pSWmhBY1FEeC9WMUdZ?=
 =?utf-8?B?TGVjU2RWOGowb1VTRW51dVhiRm9ZakpYelhFdmpzbEtXeUZZT2VGM0JvQ3Z1?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nUmUph2pswzG4VKKdHp3JgVF3+WOP2HijqL8RhHJG8ckn/Q2veOr4UEEDojgBN0KNGbVR3zuLEjJMUgZBPWnV1lyKP7zgYB8nALA01oGEeyGTHDCB2hJPm46dLS+JuB3lEfPrm4EDXO2mvFeDoW311+rgdujigIdwK3oXYC7HihgEMWgy1GxBuPQYcy13vR10rjnqTHeF2z4OfCnmPY4bGfQqJeSNYGvt9ItNvtb8CIC5RnQLvnDTGmB3YMjnVtEhre/ZHgHM9jYO2n3KgLlw7tGMgxM15vscAdQqy/w8K+piDumNkAharjqZw222XpVvBmTnUhspcL1YpURsAXB8SrXSxJxUQCY2Lu+v1V97SVD+zDoXiGR05JBGDr25ueKhanukCEtioJqQfS0VvYRfIBT7WnoeAo31oBEcUsMpk3TSLIkCgLkFVzSnhf3FgrvpZs1wqm6xLEMbG+drtzVbGkUY1dcVTUZ7B2hHUuNh/G2SSg30b8MJCAbMHhNGr/rRHKt5y0oqlmzB6rbsIP7TJCxMYOwk9ZEPjFUUn+uUWKzyaTIC26cna63m6xEmmPybQaPG/Ojy91DOSsqT3ziSMoYpkqBcGoFOiy4AKWZUbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f005a4ba-5810-44fc-4dd1-08dc0d314001
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:27:15.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20LBNDFZXsUBXmLtkcglVyJaXwpefmdWQwcqT8M7DQFp66TxopPfRp5FB82ygxZGVYEgmi/jaW+saNHl9PUxbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040113
X-Proofpoint-GUID: y1PbExLu_mpBdLu7ocLZP9Lh3PJzqVNa
X-Proofpoint-ORIG-GUID: y1PbExLu_mpBdLu7ocLZP9Lh3PJzqVNa

On Thu, Jan 04, 2024 at 09:39:04AM +0200, Amir Goldstein wrote:
> On Wed, Jan 3, 2024 at 5:19 PM Chuck Lever <cel@kernel.org> wrote:
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
> >
> > This patch just ensures that we skip '.' and '..' rather than allowing a
> > match.
> >
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Acked-by: Amir Goldstein <amir73il@gmail.com>
> > Link: https://lore.kernel.org/linux-nfs/CAOQ4uxiOZobN76OKB-VBNXWeFKVwLW_eK5QtthGyYzWU9mjb7Q@mail.gmail.com/
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/exportfs/expfs.c |    4 +++-
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
> > +           buf->ino == ino && len <= NAME_MAX) {
> 
> 
> Thank you for creating the helper, but if you already went to this trouble,
> I think it is better to introduce is_dot_dotdot() as a local helper already
> in this backportable patch, so that stable kernel code is same as upstream
> code (good for future fixes) and then dedupe the local helper with the rest
> of the local helpers in patch 2?

There's now no Fixes: nor a Cc: stable on 1/2. You convinced me that
1/2 will not result in any external behavior change.

The upshot is I do not expect 1/2 will be backported, unless I have
grossly misread your emails.


-- 
Chuck Lever

