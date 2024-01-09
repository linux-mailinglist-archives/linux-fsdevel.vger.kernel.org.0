Return-Path: <linux-fsdevel+bounces-7632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B69828A84
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0815A1C246D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C13B195;
	Tue,  9 Jan 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aJgcC22B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZnapEF3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E43AC01;
	Tue,  9 Jan 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409GVw9L012603;
	Tue, 9 Jan 2024 16:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TRw/SKsPpW4pxlI1gr96xtH3FmBkK/rPPrrDjfKHKwg=;
 b=aJgcC22BE/Z1syD7xYg3aVXF6pVxaxHBAhmltRfeZVl5f6eKRIVrNqwcFv3OqpEt2sZH
 AjVyRj+xYrusDJzNWcVHwmWjWLJK0+5+nBguqUffpLvoKb+AxUS5zTbTld2lD7b2lLnZ
 W+GDdNsXljlfGoomhfFOSs6EFtuQsAAZJpdPw+PToBp0kC1uVldRnRPmcXe7dbs3UGcg
 gckPSrVAJBCLkpJIqHuKYcssvrogEBHVObQVHRzTeMmVwU+k7RNcs9k8iH0tmCp/2S2y
 tFjv7pi1nQa6w/fEq3t3Gg5gyzzpeOpa0foVlf4jdWF1RNYFx8dnYhzg6uRDO+zAIKEC pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh9r982fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 16:52:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409GUsSP035187;
	Tue, 9 Jan 2024 16:52:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu4rgbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 16:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jobSVEt5/pkQpUR7h2P/AC/1BbVVamcVw6jGJbVKX83tPiemQ3tnp8VmKW4xX4ME24wWOOB3arZL5QU5B+kjgdYanf5fkyJ663km1pz98tcx/Tq7SX3pSUeIeH/AnphOqLEKxG+opsrIwaEdJz0x34TZKAngdQJULfoUtbk5HJ6L8GNw1NNCBmZBvbPNaFSZ+2X4HuKcbiHHmHbCWwbyfUQDSdldj4+blFZYc0OAmnUvg5GL2NvHCw4pEvf87SymgAMCYYtvCyMSxMtOMegHVOoelV/VcSytUtWM32xZAkhlrDxnLgTCowzw8NnR1ZER3T+goNsQUPPBBLmoYqcJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRw/SKsPpW4pxlI1gr96xtH3FmBkK/rPPrrDjfKHKwg=;
 b=nANw8TDRVXchlKST6rAOojDrnkOe75ZrCDaFS1ECnnqTgDjS9QUrn5PpPIiC/xs6HGYsGRLb0ZMgI2wd81EUcDlhs9pNthhfu8Bun/EBBykckRvqb6eYVV79FrTcnsfiX9zPxj4cjUFaLKuggHJrwb05neL4WTIwgw3cUg6fO4M/n78+Jpp4xzpggOIu7yL5aNEW7SokX5WaDkeA+2o86eyv/d1G111J3SLLr/6I1t4vfKekBB+4GeOgraX0WMzsvzfb2VlIPVLOq7p+2x28QYsbyJW/7Ur1LsplbOZx+6Xq67yAtTf5YXFmiuYb6JaQ3+7lvXQq2rNv3TaXCUOkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRw/SKsPpW4pxlI1gr96xtH3FmBkK/rPPrrDjfKHKwg=;
 b=ZnapEF3sZmHYPQRNQgGqIYtJHAIWz2qeEfr2dn1dmS5ytxTheZGjrT9fiwmdkwqt60dQSM3HlfGp2Fk+AzXfPOLm++flRCCxVSMrOK2fUKWGFKmwzm18E0R/Be78Xl0TtPefulxiDki+t43ypPcpy1/B8Cr4I4LgHK0eqLtYePE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5853.namprd10.prod.outlook.com (2603:10b6:510:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 16:52:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 16:52:34 +0000
Message-ID: <d2324bad-f0f8-43ba-9f72-870e2e276fd3@oracle.com>
Date: Tue, 9 Jan 2024 16:52:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, bvanassche@acm.org, ojaswin@linux.ibm.com
References: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
 <20240109160223.GA7737@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240109160223.GA7737@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b37859-908c-4c04-02d3-08dc1133608d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QsoAiOFqowGVO3j2a2KyITZn9t9SyqCzYtSx1CNSnYpxGM0mWRJrXVfoL8RCSTk+cik+tRRY3h8khn4IKdCKkE9uiTDd6blmp/Nyv7fEFN40pYPcf84PoS0aXEoDOR0ki/E97b05icLRLjc65MDcKoshjci6YqlKSY8YOKbvMv47iK+AqfSdpiWf6lShK3Z1zIZ8WR0OJOYWYDUncWXeYFOtC+X8I/xhN4s7v86XVV5yGXYRAp4/t8t5aaNpigvSdYcxV8jZ/+4YbJAMBjiIwMafGSOKY8gV3pYhWd3MN+vw5tczu7GhOGifBIDSQqcBDAwGvBKk7JulELzrCCxmQ3QT4edcFO4YQBEfq8ro33lFkErsxVRSrZwa6Zr+c7ZYZSiz5xh7LRWFHoa71AsoKqeYipsQEDs5rvkBqjBelK4CBfakoHgrINJ/BgTvXx+IiSMMaQxsXY0HntpY1nRfEnUoTyWOuz/jWEkNiM27sQEwnO1q5C/Lq2IWjHPdoezQTuB+medf3K9EEr2LvcZN1OPOYP0dy+zYtN9TDBEF7BVRJf9/rPJiu9edqtwcdTjQz/ZNpiRuMjJVOCThzChQll+B0zNbVgjh9btrUXeA5bOr1vXl5RUZqgfjmHY5svQQa3dCnE5V9dnHpbWZy68ObA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(7416002)(5660300002)(86362001)(6486002)(31696002)(6506007)(2616005)(26005)(53546011)(36916002)(8676002)(6666004)(6512007)(478600001)(4326008)(8936002)(36756003)(66476007)(66946007)(316002)(66556008)(41300700001)(38100700002)(83380400001)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1hYQ1NVODlwVU1hWkFxc2ZZSHlNamg3YlVsb1lyZWhEWE1sOUozKzJEUDBp?=
 =?utf-8?B?cEQ1SWF4dkRaTWN0QjhOZmtGd2lKVC9ncWx4RHJVY3FoTWlXNDkwUWJHUUNX?=
 =?utf-8?B?QWxSdzltZVF5MVBTQlV5dWNsWFNHUFRoN1lxaXFvcUtmYnVpcjJBSGdpZW9D?=
 =?utf-8?B?dTF3QytpM3JONFlpRVVlN1l2aVdoZFhvaXVVQVI4NkdqR2o4YW9PNjlKQU5r?=
 =?utf-8?B?Nm5KYXpKTmdQZzBmTmNVMUxXK0xBcERSTk5TKzJlODZSQ3BFQ0FSNGVzeXNs?=
 =?utf-8?B?YzNoWXNObnpvMjVGMXVGc3NaSWM3S0ZDZ2Fvb1UzWm1UWEJZUFAza1pLZWVZ?=
 =?utf-8?B?Mzd2NTFHUnZ6aW1FVjNwR2lFWVBBMWxVc2FJaURMZXFIRkpwc2ZXMnJZUkJN?=
 =?utf-8?B?cEhNcXpWMUUzc284eW84RnVwN2pxem95RW41VUFMVW5uVlFGeWRGcmJBU3dM?=
 =?utf-8?B?V1IrYllTR0RCTzlJbU52TDRoVW16dGlqZ2pCUE1xaDFUSnVSYmpxdG5XdHNt?=
 =?utf-8?B?cllYTU5VRXFnMEduTDFFcXNwa1dremhjNGZBTG5ZMDAvS2ZiSlhkWlRXZ3Ro?=
 =?utf-8?B?bzN5WHlHSmNwNW5sT1dLSjVreisxSVBkemw3WS85cEFCd3hubHNJaFZ2SzZ3?=
 =?utf-8?B?UEZCWHUwZ0VTcDNZcndWanllMlE0UHpuenhZSDZoblVhdWhzSkk0UXQ4YlpG?=
 =?utf-8?B?REZPNDJIK0ZJWktQb0hmcWIyMEkyT2tvejdYU0pXczBxaWV4dzBZN3RnRUk1?=
 =?utf-8?B?aTI5Wk15OGMwczVwZnlXM1UrOHZXSHFhV1hudWU3ejFJbDJJMVhyQTFHU3ov?=
 =?utf-8?B?SWdDT2hUWVBsSHZrVUhDRVV3Q25WVzFxS29qQWVMenNEVDA0UUN1alNncXF0?=
 =?utf-8?B?UXpEQ2ZzVm1TNVdhdzcraldnb0xxTHArenYybk5UcllpSHV1SXNNdVVYT0Zu?=
 =?utf-8?B?MEVnVTEzandPbjBIelJzMG1QU3FjOGZ6d2U3RUpxQW14TE1pYkRtOFlyZlR5?=
 =?utf-8?B?OVA0b3Z2YXVQL3BzSGhNNk1EOXd1dENlUFF2a2FFZnd0QUZpNFdTQVpBMjF2?=
 =?utf-8?B?V3lGVzdiNWJjUTFxcnFCTnhiL1BkZVhkam9PNlRVNVBBRWVYZmJYR0haZVM0?=
 =?utf-8?B?YWZCVUMzbjRPaTBFRmZmWE1UeXp5M1pXOTZEd2N5bjZIN0JzQmNmT281anFs?=
 =?utf-8?B?SVlJZWRLMUpodVVBaHpiaHR1eFJKYVczTy9oZ1R1b3FZVCtMbWZ1MitmamhU?=
 =?utf-8?B?RzdyaTNxRTl5cUExZUNjMDNMS2E2cHlKeGNtbW1yWTZEeHNQM3hwc1BiaElk?=
 =?utf-8?B?SGtiajJqbC9vZW03NVpiQzh6U1JGd3RSQk0vc3YxV3pxcEI3THdHOUhVYkZr?=
 =?utf-8?B?Si9zMTVhamh6cEpZVEJEYmNSeHF4bmhNcHZJNDhDbDJqVy9WUFhwaDZDRzlp?=
 =?utf-8?B?VFk0TERvK01uWDlFNXlKdHN2bEZyQlFGOWdFcHA4a21IckNkTUJTVTVFYWNU?=
 =?utf-8?B?OTJvZU1ZZ0ZzRlJDcmZORWMvV21yOUUyUnpwOTI1N1FaNVFVMDUxTUVONW9j?=
 =?utf-8?B?bUFHbjdPVzRDdytVVjdLSVZmTU5sVTh0eU9Tc21ENFlDMko4K25aWkhacnZH?=
 =?utf-8?B?emZQMzFvYkVIeUlaaDgrUGFaanZsRENFVkNZMnI1dEFwdVVMN2RwSFNKQXl3?=
 =?utf-8?B?WHFyVUd3bEZPbjJQK1JEYlNPNDRGWWhkd3ptS0VoM2oweFJGc3dBQjI4UFY2?=
 =?utf-8?B?S1poNVVRbVFjdHhmOGxkdGI1ekxyOUt4eVhKSHhnc29nY0hLbEFYS0F3MFFD?=
 =?utf-8?B?T2Fidk05ZktkcU5FeGtPemRvczcrWHgvYk5oSFYvbGw0VlJNbTYxZ3RPdnNj?=
 =?utf-8?B?N0RRRHY2UGxvT2dzb09WQnVrT3JxcTdRQUpoWDdEdUMrZmsyelZKNXlabmRx?=
 =?utf-8?B?dktGZlQvWU5wV3lJMFZqN2x0VzFPYVE0dnZTL3c2S1NheUJZclpDOHdHenhN?=
 =?utf-8?B?QXN6OWYzaFRLN1BMdHJIWHA2KzVYQ1hnZE5sMzdvNHNVbVRDU0o5REh6bnlU?=
 =?utf-8?B?K1VGTHJhTHFLMzhwaWc4RGYwUGM5Z1NJZEhqV0x4MjRCZzN1REkva29yR1BM?=
 =?utf-8?B?c1NuTXdoOEMzK1FzRVhkMGJXNWdNRGNLZUxKNlF0dDNSTWY1OElLQS9HSE95?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zzzVALVMAYrpdVgbC6CoSC/miACLmIuIfJuP9Cm6mJtUzDNtGlPFirnf4NAdKwURfNm0Y5WwaRpkt764ZJ1eTJ6S66Lq8F+DV3nk6aDKX0HxsN4eUs9bnSbgv4b3FofkwfBSWQFehVLwpBT8EkwEeUl3/saS2BLd5UrXNIYLoTjzLfFkLS0a+ulVxYAl+wHgk+xgU4+xdwazf8qNC2XH32766Z6amLvlpiEDyxDU/e3U/HrxWEMrO9IdxIiRciRUwdCntCFZP5sOr3T/3/Ti5ZtULU/fWHYeTD8UQV1XycRKxWiqk2hzbY9xzZ4STURDEfhwzPPq84OfeI3vswmaM5lVXifAcweUqfFOu1oyHQR/DOviLRfnTwSs9EcePQYk+izY0WldSfFC0cIBKP62ParnLN7SbnciLK5nhQRYG5xjffXCVRFjJGgJym+TVg4XVNHBEJuqfhwmHdd+0SIV5tC9vmcSDOZd4Pb0gSIqo6/ajc9/A+WvUh8D2ZFEkY41AoKNEWsizKMup+f6/lhcSVV+rxQCkxYzz/PcdQfQ5JCRhxMrC5JFitouHn4rm8XRXCpnk2V9oh5Nqcmfe9EvqU1k3uiD1wIExnJ71upRJwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b37859-908c-4c04-02d3-08dc1133608d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 16:52:34.3079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gx3T4XwrLoXYVVDJpkglJeBkMENIie2MEsX4/ZSkNr4oXRVPlIhwCnml08gjWzPvf0dgFRSFA+ipVmSbf+/GGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_08,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090137
X-Proofpoint-ORIG-GUID: -xYDjIPMCokqDYasswAVH6HvrDT3nXV8
X-Proofpoint-GUID: -xYDjIPMCokqDYasswAVH6HvrDT3nXV8

On 09/01/2024 16:02, Christoph Hellwig wrote:
> On Tue, Jan 09, 2024 at 09:55:24AM +0000, John Garry wrote:
>> So a user can issue:
>>
>>> xfs_io -c "atomic-writes 64K" mnt/file
>>> xfs_io -c "atomic-writes" mnt/file
>> [65536] mnt/file
> Let me try to decipher that:
> 
>   - the first call sets a 64k fsx_atomicwrites_size size

It should also set FS_XFLAG_ATOMICWRITES for the file. So this step does 
everything to enable atomic writes for that file.

>   - the secon call queries fsx_atomicwrites_size?

Right, I'm just demo'ing how it would look

> 
>> The user will still have to issue statx to get the actual atomic write
>> limit for a file, as 'xfs_io -c "atomic-writes"' does not take into account
>> any HW/linux block layer atomic write limits.
> So will the set side never fail?

It could fail.

Examples of when it could fail could include:

a. If user gave a bad size value. So the size should be a power-of-2 and 
also divisible into the AG size and compatible with any stripe alignment.

b. If the file already had flags set which are incompatible with or not 
supported for atomic writes.

c. the file already has data written. I guess that's obvious.

> 
>> Is this the sort of userspace API which you would like to see?
> What I had in mind (and that's doesn't mean it's right..) was that
> the user just sets a binary flag, and the fs reports the best it
> could.  But there might be reasons to do it differently.

That is what I am trying to do, but I also want to specify a size for 
the atomic write unit max which the user could want. I'd rather not use 
the atomic write unit max from the device for that, as that could be 
huge. However, re-reading a., above, makes me think that the kernel 
should have more input on this, but we still need some input on the max 
from the user...

Thanks,
John


