Return-Path: <linux-fsdevel+bounces-7684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D25829570
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF34F28984A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E713AC1A;
	Wed, 10 Jan 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B+KLrwdo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="akMR8jFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B1CA4A;
	Wed, 10 Jan 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40A8qV0F026163;
	Wed, 10 Jan 2024 08:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=D/oV1V5CqZfxaNSGprerwuhAQb5jgee+fzydaJceHvA=;
 b=B+KLrwdoyeRuQBI62T8hUYcbAybM4JHlpu0Wz7iiicKo/7PjUTzk59Gbvus59GzzJBxP
 Morj2Bv4PY2ypd6melY8qR3PloS0ewBZXDvsJSWdM/+yW15/2EB1q3X53TeqGkgTYZ85
 mfiRUyDycKD6NSCiLpt4+eTfE2KZrCG0/oLwZDU6yaSux8L/GszU1SbxxMOB3lSyFGqX
 gg8buXsbEXu9JpN6SAdd9gzd61wKwnZMgRxIH95E3gugdOOfgudsBKYMeqSsPoLDd8kf
 rgd642G7y191x+K3WrEdxh95vl+uKR4PVY4Ht/PEyc/+9wFIkN7ec6QUXsiHhDBKpfyw AA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhr3wg05f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 08:55:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40A715uD012275;
	Wed, 10 Jan 2024 08:55:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuwj2ph5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 08:55:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbk/iLBVsO7sI1x2PfK/uT8fv0NRXQDuL8QoTx8k/gQ+It4zO0VQKHVs4B0EUb1qHePq1euI30BT/QwVv6EmEStLQKUIHn9/bq4VXVZfbVYXly2bdNINw+0R7TKbbKnuIgLinDREkhjCHWmjFpmVih520EJKZ+rm9pDJmiBHNjAzk+GXHGQMQr/R9u+zWNJe7B9gUWDxWAiKxXcsQSs1xo4dkv5fX6M8v4aJylqsSw/VwJNNVo3PqQA3xR+fWtkAS9NT2Jzotu5ZGv8grudQf0uTCq81ri+qa6zK/k3UnvrSPOXpm8SIiYwUuIU5diLm/W2xb4NWPrqMUPGcXsL5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/oV1V5CqZfxaNSGprerwuhAQb5jgee+fzydaJceHvA=;
 b=ZCgSNuHaM5Z9qvsQgjsBa8lU7Z1DSQeb9DaiCbWCk50XzW0+81KdOF1iF/vN0TSdLVHOQGPLuxqdPMwOoy+2dLx9B6QSoqXCwmzxheE6h+0+zRc03hEtbNKIz98uwuPwZzLiLMkG8xk+hMl1q9/DixT56Xt5+R9WbtDfB9Zka7PrTCSmNdDjRCoR5UI9/26+2GZezA9zMfQXRlr4UK/vaGeJkLRPgDI7xmRarpDjrfLDjXhS/UkQmWH1QwQqP8j/1v+oLCkMcrZ4ro6Lzcc3pu2Yd5k0ZEaG7JzYYl5kL6GgZHo8+7NopeyN3HDTd5LyXB3jTBHOW/2OOAkeolmx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/oV1V5CqZfxaNSGprerwuhAQb5jgee+fzydaJceHvA=;
 b=akMR8jFBW2mjInrK+JiOMT6NqWaAh7/jcWu1PRcdNaargjqq8r7gz+Sirb6sJER/AUmDiQWKjLj82FG4LwxEkkjg0iHOtKfSFvpGrGduO/mNf+zQpr1z1V/DKk75mID76O1+oENCUm7XeYvjGE9dcr2BYqNtGcyI4TOZLEsdhS0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB6992.namprd10.prod.outlook.com (2603:10b6:a03:4ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 08:55:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 08:55:12 +0000
Message-ID: <aaa33b4f-dea7-4596-82ce-8c7e6cdaa6ef@oracle.com>
Date: Wed, 10 Jan 2024 08:55:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
        axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
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
 <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e378bf-63f3-4550-4db7-08dc11b9dafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aJiPN11Qbv4U14S61fQuIwT2KvsSx6X8r65b/18sDra8Cbm6mEgJut8qOEirqRCM1GQ1ypfCbvPMEsdpGmb810TZ35L+b12pbPHlnrw/IpF0Gn5MkfohAv57PQXm4qpJuEI89eAyThx9uqQyPy5YNlGgEJfa9ja43+ddMi9fUL5oeFuSXgNDooeOYk0p2i6KCNwHvGdTzRbb6jXkERl9uMpfT+SSCrgOWyDGgbwZj7RkufB+9ofJfRBQzA5P1ObIF+hvX93OmgbMRzLCFJl3SS6vdkWY6lP+cf3Z9J2UWxiBpWlgE/5kiRAxnu7NXCHv+9Q66neQwQN9pUcNpfUJH0GNOWAkBe5OaNxZJdikJlQUNGoIIjt3vLi2tejU+3wgWLbr84yeXlOpicLqOVCtmwFkVpXuVGNnVTN/dNjYQ0xhsad3+AjtNMVIaORqfLiqOQydM9Li6qQxiglhCvZr1IvQM8q536e9yhAKWj4ijTS7jKOACdB8NNYa5US9mhmfx1FgAqjx4zw8aiE0jd0aBmludl0/kK5yckgyVG78DhIWwp4+yICrGK7Jg6uFZsJCF6zcksfDA+ELgKYaracp5kanr1qmea3MhgXOPL57XzGVY2+0lbqBlCvNPdjTcNO/mo5Q3SsSYg7jZw0cF0KJrg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(7416002)(5660300002)(66946007)(2906002)(41300700001)(38100700002)(6486002)(36756003)(53546011)(86362001)(83380400001)(6512007)(31696002)(36916002)(6666004)(6506007)(66476007)(26005)(478600001)(66556008)(8676002)(316002)(6916009)(2616005)(8936002)(4326008)(54906003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UE1YTllvejBkOElaazJKa3RTNGl0K01uTzRpbC93ZWN4cXpOOU93Tk40VG9t?=
 =?utf-8?B?T0hVdzVueVNUMG4wMlQ4c1ZWZWtIaGtJT1F1SURTQjE3aHZWMDdnbmkvNUtX?=
 =?utf-8?B?L2tRZGlKMThkbnFUWlZtOTFqYzM2MXFlR09TdklWcTd3WEFHc2VNRXorc3VG?=
 =?utf-8?B?b3hFbkVyNENudXVvSzF0ZWVuUlJRRUsxVlVJL0hINEFTdzhDMUc1azBwWTQ5?=
 =?utf-8?B?eWtCMXRVcmNkTzlWVXpVVTlOcmUvRm9DelJEWmE0OEdQZWFmWEtpMGZYYzBU?=
 =?utf-8?B?UUlQcXhYbGloQmgrOTltZkZNZnBXTFhCdzZYdHlwNklJbzQ4T1B3VlpuM0FT?=
 =?utf-8?B?dk9zTkJRTlFuaGJnY2huWnF2dHE2R2p0ZCtPa1VqQmpNYnFJTkQ3OUwyUVNB?=
 =?utf-8?B?akRzdHh0ZHIzWk50OHlMU3BSdytMWnZ4eWkxYWVzc29MRmwyUncvRDgyOU5p?=
 =?utf-8?B?SHYvMU84OEZCajlxL2hiN3d0Z296YW1Uck1mTnNJbGhMWDVnbHN3d1VlZWZB?=
 =?utf-8?B?OHd2SFB0NVpySjRrMldqbTdrdWEybWFTVXBXalhXYmxFV0xlNmJ3MTA0dE52?=
 =?utf-8?B?UXErTGtVK2ZNUnlnQjIrWFVQNFV6VkR0M0dpV3plNDYvdkdvT20wOUZJY3pB?=
 =?utf-8?B?QWwyd251OHhNRFNRakdzTWFoSmM3MkVyalRMVXg3TlJ4Y3VadUVZZ29ENkt4?=
 =?utf-8?B?ZEhCRkl0NEhuUk1UM1pIVXFpZVkxRnB3ekw1MjZzWmtTSmRsME9jdEJOcEk5?=
 =?utf-8?B?Q0gycytpTDBDR2kyWEo2YTVJS1kwZ1hOLzYrUForT0JaajFzTXdrV3dBVmhM?=
 =?utf-8?B?S05SYkRtNFRHOTNTeGlKTllUVjlIcFh1bzlVR2VCdUxnUjNESWw1TjdJUC9a?=
 =?utf-8?B?eXN4MzlLZTRQeEhJdDI5dkdGb2tIdWNVWTF1b1dzZFZ3NFR0dDIxN3hNN1J6?=
 =?utf-8?B?TlpEd2JYY3pPZ0JFaUVxcHp5b0FFeWNDUm5wQjA4OFF1L203dzFKYmxhaXlR?=
 =?utf-8?B?Z0VBOVZLTEpmM3J5OXV1OTJTazhFdWRMVWxEQmk0K2V6MG1Tc3ZSR0tsRTdu?=
 =?utf-8?B?azFwSGNETk5wQmdxTUJwR2Q4SWtPWkhpbnQza3hyTmo0UWZwTVlqSUluLzh3?=
 =?utf-8?B?eTg0L2FuVGdmZGI4S1hacDV5ZGw0aUxyQklCRHdLRTNRam1FSm96bUdzNHdt?=
 =?utf-8?B?VWY0aXJMbXFRNDFSb2krKzM0V0ZtZ1Zwb1pWakE4ZUxJaUdzWUhUQ3FxSEdD?=
 =?utf-8?B?VkVicGpMdUVnTjBFd00rTVphQVlYZWpBeU03V21sUklTeVNWMFpGSFJML0RK?=
 =?utf-8?B?TUR2YjNvbkt0Mit0L0FYd2ptb01wejk5OUV1QzBHbVQ2a09yT3p1dUpnZG0r?=
 =?utf-8?B?ZUJ0UWJnYk5zd3lUSm5CeStWZGtCdUh3RU1wTU5Pb0x2N2NFVjZoNTlkTTBz?=
 =?utf-8?B?TGpWMWg0dEJscVRGVkVWdlE2UXA4aG00ZmxFUlVhUGVCNE9WTi96WGlZV3lE?=
 =?utf-8?B?TzVyWWxMalJWVlA2N01uY3FLc2JDdTVGWjhuRkdXZ1FPTHBmbFhIUGJ0ZUY5?=
 =?utf-8?B?bE1malZ1cWlwa1FsL2lGVUFwOUI3dDZ1c243dHo4U2M2ZHc1RVdKdjNHVi9k?=
 =?utf-8?B?ZkhqNTgxd2hYNUZjd0J2S0ZrUE9WNThSZUJ3dmNQcC9mSFpiWVpPUXZ5SzI5?=
 =?utf-8?B?b25ObmwzSkRscXd4Z3g5aDBFY1lSQ0hmZm1xK1dOWFg3ajZEMVNmVWh5WTRD?=
 =?utf-8?B?RnNSbFJQUkV0cW15TlRxVXR2bEFWcFI4QmEyWEJkRDRITFFLaDNXa0ZFTjFX?=
 =?utf-8?B?MmV5Ry90U1ludmxJNGVCRmxQOExxUElJVzY3SmNyUGIySlk5a2pjR3hoM1Zn?=
 =?utf-8?B?T045dGJycUJwaVJFOThNRnBsQ3lMUU5zVlRBMHVuM1RuQXFwc1ExTXdWb01P?=
 =?utf-8?B?OW83b0JGOWRKQjMwQ0h0MUhmQTVvTXVKdWJWK2U5WHBKbWRJbStSNDJnQU1v?=
 =?utf-8?B?UFFVYnM4ZXE4WVNCdUtaOHFWdzlBNlozanJFRU5iMXE0ZlE4YUY5SEEvVzkr?=
 =?utf-8?B?eEJ5QjVHM3JjT0g5OFF5NmVEamlWMWEvZXZ3VGs5enR2ZDA3NUVXTVVjYUVt?=
 =?utf-8?B?WlA3VytUVGxGbXBWSUc1TDgzK29sWDlvV3VtZGxWMGxFbWNZdWUyQ3hWVHp1?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8YDyxOM9CdeyP0y3+lVViOeu1KnfQl6NoqUPr8CH0sJ9pmG+IubBcANb+ZnpHFU1rM59F7NjsHLZzQeLi94Ygg7t5FD/J+T0MwNKDlouRoY5Rh31LMcbvxTV3As4/nXwLFRGzeHWjVU65rXf0+ikQC/ZRknpobYPfqlrHLCNCWhYcAb1Y8bK1BC2arRvvwfrnhjVHFy6QyyvrHtvSG4y2rkNzUSLHIXVVf3KNOxaWBMM5w8u+gJsSwnfYja5WQD3tIEza2oiv4LTEjY0XYB3vrtPryE8U3/yD7XsHhsrD5T3FN5TiM4YtGeorea+HfCUkaDWETuqq96mtryhx3Pa+cj9I1zDPhCQZ3FcTHlIElsPJ/j/hSC7JNmQOnWzMn6MJmo9wYg7AohVbCwRfhG+beMxQQ0dl803r8i7KSVF3B7EgHO+62qMNHsgEQCdH5gMTkySpQIM2ZJkMhgZqqzeKzjua9jAjVbdwV2Tpq8hN+teQh8vA6bKxRoxE3NAAMPdwlBXmvKol+hPAANw375GDVfvcAL9iZ0UHhwMRnFrEMxLLbLoXvJ4oOJ3uuvgGiYwZEP60pCxJG+/65vq/yNsa0mfP1IsbJTRRREnGNcKJic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e378bf-63f3-4550-4db7-08dc11b9dafd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 08:55:12.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOS6gHbBqaCjhW8KJRaJ1LqpBg1atkwy1F2d+73qALXnC5RJUvJZhMpICQ6eIeDv/A1Z53Yk/sk9ZSI8KIzLwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6992
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_02,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100072
X-Proofpoint-GUID: HweSHLUbVkVvX-qJ7P4uZFxvEWpgBhrE
X-Proofpoint-ORIG-GUID: HweSHLUbVkVvX-qJ7P4uZFxvEWpgBhrE

On 09/01/2024 23:04, Dave Chinner wrote:
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -118,7 +118,8 @@ struct fsxattr {
>>         __u32           fsx_nextents;   /* nextents field value (get)   */
>>         __u32           fsx_projid;     /* project identifier (get/set) */
>>         __u32           fsx_cowextsize; /* CoW extsize field value
>> (get/set)*/
>> -       unsigned char   fsx_pad[8];
>> +       __u32           fsx_atomicwrites_size; /* unit max */
>> +       unsigned char   fsx_pad[4];
>> };
>>
>> /*
>> @@ -140,6 +141,7 @@ struct fsxattr {
>> #define FS_XFLAG_FILESTREAM    0x00004000      /* use filestream allocator
>> */
>> #define FS_XFLAG_DAX           0x00008000      /* use DAX for IO */
>> #define FS_XFLAG_COWEXTSIZE    0x00010000      /* CoW extent size
>> allocator hint */
>> +#define FS_XFLAG_ATOMICWRITES  0x00020000
>> #define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for this   */
>>
>> /* the read-only stuff doesn't really belong here, but any other place is
>> lines 1-22/22 (END)
>>
>> Having FS_XFLAG_ATOMICWRITES set will lead to FMODE_CAN_ATOMIC_WRITE being
>> set.
>>
>> So a user can issue:
>>
>>> xfs_io -c "atomic-writes 64K" mnt/file
>>> xfs_io -c "atomic-writes" mnt/file
>> [65536] mnt/file
> Where are you going to store this value in the inode?  It requires a
> new field in the inode and so is a change of on-disk format, right?

It would require an on-disk format change, unless we can find an 
alternative way to store the value, like:
a. re-use pre-existing extsize or even cowextsize fields and 'xfs_io -c 
"atomic-writes $SIZE"' would update those fields and 
FS_XFLAG_ATOMICWRITES would be incompatible with FS_XFLAG_COWEXTSIZE or 
FS_XFLAG_EXTSIZE
b. require FS_XFLAG_EXTSIZE and extsize be also set to enable atomic 
writes, and extsize is used for atomic write unit max

I'm trying to think of ways to avoid requiring a value, but I don't see 
good options, like:
- make atomic write unit max some compile-time option
- require mkfs stripe alignment/width be set and use that as basis for 
atomic write unit max

We could just use the atomic write unit max which HW provides, but that 
could be 1MB or more and that will hardly give efficient data usage for 
small files. But maybe we don't care about that if we expect this 
feature to only be used on DB files, which can be huge anyway. However I 
still have concerns – we require that value to be fixed, but a disk 
firmware update could increase that value and this could mean we have 
what would be pre-existing mis-aligned extents.

> 
> As it is, I really don't see this as a better solution than the
> original generic "force align" flag that simply makes the extent
> size hint alignment a hard physical alignment requirement rather
> than just a hint. This has multiple uses (DAX PMD alignment is
> another), so I just don't see why something that has a single,
> application specific API that implements a hard physical alignment
> is desirable.

I would still hope that we will support forcealign separately for those 
purposes.

> 
> Indeed, the whole reason that extent size hints are so versatile is
> that they implement a generic allocation alignment/size function
> that can be used for anything your imagination extends to. If they
> were implemented as a "only allow RAID stripe aligned/sized
> allocation" for the original use case then that functionality would
> have been far less useful than it has proven to be over the past
> couple of decades.
> 
> Hence history teaches us that we should be designing the API around
> the generic filesystem function required (hard alignment of physical
> extent allocation), not the specific use case that requires that
> functionality.

I understand your concern. However I am not even sure that forcealign 
even gives us everything we want to enable atomic writes. There is an 
issue where we were required to pre-zero a file prior to issuing atomic 
writes to ensure extents are suitably sized, so FS_XFLAG_ATOMICWRITES 
would make the FS do what is required to avoid that pre-zeroing (but 
that pre-zeroing requirement that does sound like a forcealign issue...)

Furthermore, there was some desire to support atomic writes on block 
devices with no HW support by using a CoW-based solution, and forcealign 
would not be relevant there.

Thanks,
John


