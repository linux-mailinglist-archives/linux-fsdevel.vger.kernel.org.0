Return-Path: <linux-fsdevel+bounces-2598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485F7E6FCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050F8281082
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B320327;
	Thu,  9 Nov 2023 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k7I6v4xC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J4vQb4rX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FC71DDE7;
	Thu,  9 Nov 2023 17:01:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A02726;
	Thu,  9 Nov 2023 09:01:57 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9DhepH020202;
	Thu, 9 Nov 2023 17:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=g0Rt0N+KWItTQ4NTaDYxbyAhidZdpBVEIffqu2IMotg=;
 b=k7I6v4xCVP780IQpZQCdk9Nip2SGYozWvMWgfd6dJM9wD/7Ml5zC5WHkDzVCOvGH3uan
 up7B/vWDUIn0Sf4U312PmscO16SSPUUDZD3bPDQ3Q7+/8OcGxU9YEuoqDoFJI9FvZ+lt
 Cn9U0nELEAKMObIEbgRvygrgdzSS8yu8eAtTS0nuULKRPdKnvPtDNrj7b4dRntJR/rMq
 ucuwz9lZk8bZ83UgmPueP9xfKKRamEYi4KFzCFB/hUSwbhb1PTkq39fnH9xY1v0gzHld
 1kjIvKZ9fhEoqU4TDhBo8255sMJta9WLOr2c4tC6XVjbHRKVTXiIHqIpp0Mu+09aNI+Y lA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w204h58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 17:01:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9G3qRZ011123;
	Thu, 9 Nov 2023 17:01:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wqcks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 17:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hStDzThYQow5PJxhpzVD/Z9NbcGmt9lEaNMFCPmZ0zFYZ6MzZkAzkZdVz89d7zChR2C9kOzw9Ynguomf8JbZAbUxXKLYVtNfcQrGmcETEObVjKGBeU7TK8wzY7Bf5dgVLu7S6CM7+x6IFcdPsExCgqelpa6ZnI9lB8+2oC2xCkF8/uWRijXRDaLBUwBrw5UV9Nn7Glby/RdvdXFdjUl+jAp55XRgNRtG1UCmZP6nJ9+heABAfkIR3Xw+ocEgShHKotUEXUn1qgnsadAPs5pjkIXumpbIzuMJG2+1YgLICo30hctDdmRpsJxs+Ul0pr0QZ1YJu8IGEuvGtB6ASHC3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Rt0N+KWItTQ4NTaDYxbyAhidZdpBVEIffqu2IMotg=;
 b=HO2udHxzVqFFruubM3fixaGHSaJAxUVgVk3888rv3PCv7LBaxsCgA33HvXd7lEZM3aqcD3kroDn7noFZZOhjXBCh6ZqynQSFrW5JBuGcb3PSUfNzTMEEj9xiAcZvQOkTqpxRDpj+MZPdyU2OhU+gR9gl/seo7HadqDN3FYkLUuo1yS/yUafuOa/B1/JWVHW6MgZt0MaULy4aXRT7Qp8v1LtvRF+MoKZ5eQb5TzE18B/GvIt9BlJpK3hIkr+ZxMY4wMXOCLKha20qY8oKdLsNCHEwX6eMeiV6hJC0sSYL9tJgzTNhDsFQQc+kbOUVH07UIdos7xxz2zLCplklY6nsuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0Rt0N+KWItTQ4NTaDYxbyAhidZdpBVEIffqu2IMotg=;
 b=J4vQb4rXpORAJCwX7xq5ihB3ZAPb/I/Ly8K/X/H6WFSQQuDTHQswDZcAzvYo1qG7DOaA92ilqyx9DEKid/i0Vqelvnv7vo4ew1US3MGLwCXo8niu3/+wAFvQeoMul1at0ps1/ETJjouf/yjl9+6v4z+619Zx2pA6b6hug9pA0TA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6080.namprd10.prod.outlook.com (2603:10b6:8:c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 9 Nov
 2023 17:01:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 17:01:16 +0000
Message-ID: <b7f1b93a-08ea-07c8-d1da-5c2a31d1be80@oracle.com>
Date: Thu, 9 Nov 2023 17:01:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
 <20231109151013.GA32432@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231109151013.GA32432@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: eaac7e29-3d12-48c2-8928-08dbe1457c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aLgahRlTGGLy4f7TVMQshrA0tD7p0gxBF/vAy292SmDbZi7hNW1THgakCH0eNBQsqe6dsl0tpq7fOUmeZ0ovkDH9QTabg3XMshruVZdRV9os9+wW7PppmP2TtAsWj9h1UIQFTPR0X42sKKZlryXQSCARvNiXhCzFUrfG5gE6LO1r5yfyBGlFYghw5uTFEoVWQOpwYdnWOmpiCC0tdIFB2waYI3qQtEvelDnHuGOvtlhpQ9IUBtXoGC7TxlhlS6ofjcgqB9Q0/JA/GJwesFeb6rzRiw0Cz07+5CeKi4Kj9P40g+ARknh5Um1UuU2mpke011LCSszqMLNnYLmFOOjfrSkqZeVQ1FkhMRGGDQ70oYRVnYIU5ZMYAPNbyfGKY0kx60rq8FO6X5/Z1jdgMeRu6ZsbuM8MVFy7H54pqM0vWymUpwhzS16I58f03LcHFd2tSVjm05Yq2JD7MjgLUenIDt0EykxCEuDcrYE6jWp3lp1rsldxp9uj19gNp8F46JXjRKoSdcvjQvPxG2no9jhCGNs+rH6DoNQ9dTXStTu3sj6dhutkf1Ds0Ue69fIWOWgs7LJI3C+CiqnvAWzfPPXr/FjBBfcbrJmC1fGP7xFAK/C1OQS4oIpM3KFj28hZPGODkl/3/sWnF3cRDc742DQ0lA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(2616005)(86362001)(6916009)(6506007)(7416002)(38100700002)(41300700001)(66556008)(2906002)(4326008)(478600001)(83380400001)(6486002)(36916002)(66476007)(53546011)(36756003)(6512007)(66574015)(5660300002)(8676002)(31696002)(8936002)(26005)(316002)(31686004)(66946007)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M3dZbmprWFJ1SXdKVTdkalErSkJIdGNvZUxuSkZIeU8vSGhBdXl5M01YcE9F?=
 =?utf-8?B?ZXVEQ0hidS9MZTdmR3U5S01pbTBFcCtMZ0QzUTBraTlJaWFJU3EzNGNacnFV?=
 =?utf-8?B?aDBSaW5KWHg3S09uL0lPV1RHL3Zkd3lHTXF3dkEwZTdDVUh0eExkZVpSNXph?=
 =?utf-8?B?RHA0d1djNGEyMHp1dTNvWkhzRmxWTnIxcGdFd1F4ZXZlVk9ZY0dkMnNkdE05?=
 =?utf-8?B?QmZkbHNnczY2eTVCOEovMCtVTEdDWWk5UWZKdGxnMGMyMkxydjBwYTh0d2hL?=
 =?utf-8?B?NVNKekVaREtpcWlEZk9OZFJkVVVOZkc3cjlTY2ViN0FsM0NhY0pnWHJtR0gy?=
 =?utf-8?B?bUJqRHNIS1V3KzhrRzBzV1QzaE5vcnRQaU02RkppNHFDeGdKOEdxdXFaQjNM?=
 =?utf-8?B?ZFNRcUFlQ1ZvNnNSbnNxZVovVzJBK0tNVlVWQk5wZWJDNXZ5TjJPdFlPSzNW?=
 =?utf-8?B?VDU4Z3k1dHhuc283RjV5UFh1UmFwYlh4c0R3NXFBRUF5QitNVHRjTmFoenVX?=
 =?utf-8?B?UkJSTVE4ZXdPekF4R0lndkx6L2tVVDVodFlYTHBHVEpvazJoOTB3dUdVRnhJ?=
 =?utf-8?B?azZyN2FkNXRMbnVhWTVZSTZhQThHRWl4bWxhVmpGcURGMHVQdkIyaWZBWGE2?=
 =?utf-8?B?WnJIOGdGdlVDdlFFY0RwQSt4RkhFNzdtUUpLdVBSZVlyZ1FPQURmTHV5NlEr?=
 =?utf-8?B?NW5qbE0wMjdtR2dCdFUveXR5dzZlYTgyeXZMNEVVNDFwN01SZEo4bWFTamti?=
 =?utf-8?B?V01DQmVQU2tRcy9ZbEtId0QvcmJlaTg3dFRQc2JQQ09nTGVzZ1BDUmZXdWE3?=
 =?utf-8?B?TC9xZ2Vpck1hZDFVS0F3RkYyVU4wR3BvdG9BbldJaGNVckhFOEI2Q0VVYzFJ?=
 =?utf-8?B?bUFNY0JKNERYVlRJSWUyc1NCZzlGM2duTTg0aTVEWjZqSEdzSVM5UEhMdWFH?=
 =?utf-8?B?eE9qempFK2x2US9BbEExYlpXU05yUlZwTkphQzcxU0ZFbVhPL0Nra1ZaMkc4?=
 =?utf-8?B?TElsekpSSW1WY014ZWRUQUpNb3hLWWdHY3BVanJWMEYzMDZxbTYwNzhUZUpO?=
 =?utf-8?B?Nm1aeFZNTmdaL2MwaWZrU0ZmNjB4NDdOOFZkR05waXhwdVZGRERBWmRIWVZt?=
 =?utf-8?B?YTl0V3d0N215QnI2cHl1ZGdqbEpldjlTYy9jUWd3Q0pGUTIyZ0pPRms0THU5?=
 =?utf-8?B?TnVMeDFwM1dRWi9hR3NZcDF2TUhJajhXR3Nzd05hT1FKUVVTVy83a3FGQTVI?=
 =?utf-8?B?SmVWTmcyZGVTWWJGWWNvSlZEd2FkdEpJN2IrWm90VE82YmNDRGZ4aUFXZWJm?=
 =?utf-8?B?NmRjTHJmdWJiL3BMdVU4NWtkamIwanlnUGZMbXo4amVaUEJxTnZRaXh0c2xB?=
 =?utf-8?B?SVkvTlc0Q2JCc3l5UDRvdWpnamxtemRlSzFla05uRjRkL1BqRkVGRW5hWkJt?=
 =?utf-8?B?UjhaR0ZCaUUwRURTcVd3WGVSZVF5QUZXdWNSdTR0NmlGSHNPSlFPWWFEbjlK?=
 =?utf-8?B?ZmVnS3FMbi9UckJIVGNYSWhpanowSmtSWWlpUEtmMEozS0JSQXBEVmFZcmVG?=
 =?utf-8?B?VHJpdVl4MWM2VElJOGZ0MlBUVHVXWStJQmwyRVlDVlh1aTRTenR4U28wNzYv?=
 =?utf-8?B?UlUrMk52ZExjTG9JWElXZ1FYVW5CNFdtTDlRU1NrUWdSTXFnam5aVElnalpu?=
 =?utf-8?B?OGxwbGorNnRLVXR6ckJrcWY0Qis0TXJoYjBTM0xmSFN6ZkYvSnAzaitrUnBp?=
 =?utf-8?B?UGZwZ2p6eXpENTUxbkZqZ3lPQTQxSjhYUGJIVWNUUWN6SnJNRHEyUGMxbzVT?=
 =?utf-8?B?VzlZd3JNSGlDT1o4TjZEUzB3N2RrenpKeTc4d0s1alZtZEVDaVJtdDJ3eUp3?=
 =?utf-8?B?NUU4ZlJ1dnJ4ZTVNUzhTMkllWnpHNko2K3FXUUNkNmhua0VpY3Jzd2RiMFBl?=
 =?utf-8?B?d053cGVObHgzeHVEQnVyeW5HcHZZUEo1ZFU5cVExUkI1eG00Q0dyd2ovRmRX?=
 =?utf-8?B?UkllNzlWVmIzeDNLdU1NN0thLzROMHhyWklTb2pJV0oxcCtmY1pEb2lvNXJm?=
 =?utf-8?B?eVQralUzQzAwYnVTYnBWTXEvYXFQTzRCczhPTmg0a0RPL1VNQmpYRnZrbzRH?=
 =?utf-8?Q?vtUhCc7aVt/FRUL/BS+21VCOj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?cXdiRC85ZGFJbFdhVXJLbTdCU3U4dm9ORExwbWRocFp1SXBJa1JDZk1vMzQz?=
 =?utf-8?B?TGVuV0UrV0NXcnZYM1NwMFBBUVgwWG12Sy9WN3VCdkQvYkZxbDBTYlFVZ2c1?=
 =?utf-8?B?TCsyNnNiM2RPYXNTTWhoNmtMTDJ4dnh2dG1BNzBOaFlVYlovVGlCZ0lhVUdE?=
 =?utf-8?B?eUp5OXRtVTZ6MityZzAwQ1pzU29BWjNWVFpkWFBUTlllQlZoaDRKMmpDSmpX?=
 =?utf-8?B?WjNnSGpLMnFjWFI0eVN6RGY2NW15dEpJcWF6MWRJRjhXemZ4L2E2L2lxRXVH?=
 =?utf-8?B?bEpwbzhJRWRGUWNWQ0loOVlsdjkyQnkvaUdUSlIzUS9aVXVjUGN5Tlc3MkhH?=
 =?utf-8?B?TVJmOFd5VmR6MXRKZ0VIbDVuNmo3VVZrZHFsOVlDOHBlZloxQXA2QzVvMkFZ?=
 =?utf-8?B?RGtwRkdGeldFbE4yYXZPQmhUbEEvcGsyRVl0cGdUY3RNM3RWZnE1MGdLSWVL?=
 =?utf-8?B?ZWcvM3l5VmMyL2lTZEtHcFdDZ0VEQ3NaSWZJZEhZbDE3OC9PUTNkTDlrQ3NL?=
 =?utf-8?B?QkFDUzFFc3JZN1M0bWI4MlFZVm00b2piQ2FNUjRlRk9nejdXTGZWU2R1WmRu?=
 =?utf-8?B?N2tZbGF1TmNrZlhBRWY0Z0NHR1VIMVFLZ2VLWDM4RktQUXlwZHJGcWRwZWsx?=
 =?utf-8?B?azRWNEJJMThzSjB0N3R6Q1cweFNCSHFqQVZnbUMxQlBCZFhENk1UVjc5NENU?=
 =?utf-8?B?M2EyM3RTSUYxN1JDNWQrVG9IelRycVhEcGlMUnNGNldGZGhyT0svUUZoUTQ4?=
 =?utf-8?B?aThTa3A1cUNqc3dGditoaWVtUVFUSnFGY0YwblE5NlIybE16NVMrL1RwZUhF?=
 =?utf-8?B?RHcvc1I0R3lJN1g0VXYrNmYvd3d1UVVqL2JRaVRXOVZ3eGIrNC9sMUhrVU5x?=
 =?utf-8?B?QjhYVC95M0pDem1EV2ZCTWtnUTA2K0NYTHFZWVJrT3NzTC9od29rTXlBZkM4?=
 =?utf-8?B?cm5RZ3N4bDNjMXYvL3hNT0hzSkJyeDArR2ZIK3MwdnJDTXdMRUFsODByN0tr?=
 =?utf-8?B?dG5sMmxWTGFyS0FIVHNYald6WEdrQmh0SGJEVytKTGVjNnp2Sy9LUUFNODZn?=
 =?utf-8?B?N3gyNDhySmJabkc5aFlWcjRLUjFvbSt2TE9aaXRGa25yaDVjQmN1dWZRN3Zq?=
 =?utf-8?B?S1hIbnZXRkljb0FpZi9iUkFWWTlsNWV1cDluaVdzVHEzMDBzaDBJbFFpcjJ0?=
 =?utf-8?B?RXVHNHpGdUJZQkZyTlhTVVNQSVVRczRlMTRVV052ZWNnSllRbDREK2xSa0VK?=
 =?utf-8?B?V2lhR1VySDRKbUdVblFxTUxhelBZNmF5eWdNT0VmRGxYcGc2eWNnanNrSi9y?=
 =?utf-8?B?cEF2U05IbWJVK0c3cDBqWFYwMENSZUxXZkxqMUs3T3BrZGpDQnhhQnR0VjN5?=
 =?utf-8?B?RnlYanczcVA1VTBTWlZ2YkI1eUkyMUsydnpaaWMzR1BONkFSNWxWNU0vY1Vo?=
 =?utf-8?B?b3VmNkhSRlJYVlkyU0o2bmZRODVLUlQ1dFBhNUh3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaac7e29-3d12-48c2-8928-08dbe1457c59
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:01:16.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8qYzLyHgHjBM/zvNAns3zKiJHqR6N218el6wK17aevcMGRo4T/hMuU0NDucbBJNcOjEtrlt1IEpRCcf0b4efw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311090129
X-Proofpoint-ORIG-GUID: KRBFPtmvSldNnwAJavlQI07toVo6ZhHh
X-Proofpoint-GUID: KRBFPtmvSldNnwAJavlQI07toVo6ZhHh

On 09/11/2023 15:10, Christoph Hellwig wrote:
>> Documentation/ABI/stable/sysfs-block | 42 +++++++++++++++++++
>>   block/blk-settings.c                 | 60 ++++++++++++++++++++++++++++
>>   block/blk-sysfs.c                    | 33 +++++++++++++++
>>   include/linux/blkdev.h               | 33 +++++++++++++++
>>   4 files changed, 168 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
>> index 1fe9a553c37b..05df7f74cbc1 100644
>> --- a/Documentation/ABI/stable/sysfs-block
>> +++ b/Documentation/ABI/stable/sysfs-block
>> @@ -21,6 +21,48 @@ Description:
>>   		device is offset from the internal allocation unit's
>>   		natural alignment.
>>   
>> +What:		/sys/block/<disk>/atomic_write_max_bytes
>> +Date:		May 2023
>> +Contact:	Himanshu Madhani<himanshu.madhani@oracle.com>
>> +Description:
>> +		[RO] This parameter specifies the maximum atomic write
>> +		size reported by the device. An atomic write operation
>> +		must not exceed this number of bytes.
>> +What:		/sys/block/<disk>/atomic_write_unit_max_bytes
>> +Date:		January 2023
>> +Contact:	Himanshu Madhani<himanshu.madhani@oracle.com>
>> +Description:
>> +		[RO] This parameter defines the largest block which can be
>> +		written atomically with an atomic write operation. This
>> +		value must be a multiple of atomic_write_unit_min and must
>> +		be a power-of-two.
> What is the difference between these two values?

Generally they come from the same device property. Then since 
atomic_write_unit_max_bytes must be a power-of-2 (and 
atomic_write_max_bytes may not be), they may be different. In addition, 
atomic_write_unit_max_bytes is required to be limited by whatever is 
guaranteed to be able to fit in a bio.

atomic_write_max_bytes is really only relevant for merging writes. Maybe 
we should not even expose via sysfs.

BTW, I do still wonder whether all these values should be limited by 
max_sectors_kb (which they aren't currently).

> 
> 
>> +Date:		May 2023
>> +Contact:	Himanshu Madhani<himanshu.madhani@oracle.com>
>> +Description:
>> +		[RO] This parameter specifies the smallest block which can
>> +		be written atomically with an atomic write operation. All
>> +		atomic write operations must begin at a
>> +		atomic_write_unit_min boundary and must be multiples of
>> +		atomic_write_unit_min. This value must be a power-of-two.
> How can the minimum unit be anythіng but one logical block?
> 
>> +extern void blk_queue_atomic_write_max_bytes(struct request_queue *q,
>> +					     unsigned int bytes);
> Please don't add pointless externs to prototypes in headers.

ok, fine - blkdev.h seems to have a mix for declarations with and 
without extern, so at least we would be consistently inconsistent.

> 
>> +static inline unsigned int queue_atomic_write_unit_max_bytes(const struct request_queue *q)
> .. and please avoid the overly long lines.

ok

Thanks,
John

> 


