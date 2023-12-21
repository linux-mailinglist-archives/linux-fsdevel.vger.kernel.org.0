Return-Path: <linux-fsdevel+bounces-6689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5488E81B696
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7806F1C2188E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532FC7D8B1;
	Thu, 21 Dec 2023 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mjFV/jM5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jfVq7Pi3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496B7BF1D;
	Thu, 21 Dec 2023 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLCiABt026701;
	Thu, 21 Dec 2023 12:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Q2HrQhraHladxfQQC27eYXhOkGDnNzcc1ATRC10iDSk=;
 b=mjFV/jM5PRrWS3rlkSFheDLGY+3thNsSb4RqIbRPt4XKqyyE6ntZkHhLOi7DWFhDPaZe
 QndbUeBQBn78UulgspDBrLxcJw8xGvZLsJnytdbCGGOn0tm46e2y9GMbSb86LHtqwSNk
 42/dQgezglHkKX18JJORBmvccDROHSjf6xO6rzsTZuN1UVlX+lC35h++O9PjvpzKzAUm
 xA3oOewpvTbdYLCmkpsVC3aLLNOQiLmkMWTty4lMvzdAd81TD7UblFZ7bqPcUHW1v1AN
 N/MLvTE94TMubX503RQjdf7g4GqqqqErRBVai3YVwZYD4yHMcLXTowQDiFHLYgfJ6boC Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p4au7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:48:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLCJ4Lr024079;
	Thu, 21 Dec 2023 12:48:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bb1bkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 12:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j99YKb39XPX/N6ThRIaeRwg4lEWlAsHE0pnj7R/ongxuBXDgvzOoNDleSEYGx6SNhQeIqG4sozxQDPXEM3nglhltuDCyi+sCM2XR/TSnn4gQG5vQcOtQ2qdB7rwql6rlrLEMEigLPa3R5ZaJ9hIwVmuO6z3NhPBr09+U6tY7YIOhx0LzGe7C6UwrmFZsscywPze0NPIHP5AlPRIf5r0uXT++Mua7E0fgzKI5m9CPl77RI/K0nAw1Flsn8jmznzv7iCwT/vTJt3laD0VJ12dymh1JLMiyfj+P5vwePepqssxns5deKQEIezkaVfB89IDJ+QV0l7slugvuKfUa57b5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2HrQhraHladxfQQC27eYXhOkGDnNzcc1ATRC10iDSk=;
 b=YOZzuLSlALq9fZiyBhjESr796NFgrFtw1vwBumf6tQGfvppf13Od6s5vqRhw7XHiPGyp7kFAUZKnYTNSlZnMxCp2YeknJbi/EC6KnTmLfNRnpm07jaa6KsLSwSipEiDGSYTFYRQwXyzZutniklVg/lUbxAlaKLxJezmHnuy/Sd0QJ1u/Ge3QUjjiPMiujLFLROm4u8bya2bxXLFcD48NR/sDJzdCht0D3/DZb/UbrU/VsnzNOisF3W74B5zYqWvpgkOl3rW8QVeHKc1mDA0kP2kUUD3HsX2P7vu12dLqNtEnTFGyLx938rV/EN8wx9Au/aGcOHr/kl/1/bfjMRfsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2HrQhraHladxfQQC27eYXhOkGDnNzcc1ATRC10iDSk=;
 b=jfVq7Pi3P9Xj0dQYoVzKckBkOLc9Ik472ze1MLiOIW31GoqTfAozOWGI1zT41RyZg/3hgFACoO7+RoYmq5Wws4Jo0hZ03+HHB+vOEgN/OUnAk1RS9MOdbLmttmleBmi82JhLcuPmlywXJd58AfdCFdv5GZVnLZ5aPqa078Lgesg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5118.namprd10.prod.outlook.com (2603:10b6:5:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 12:48:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 12:48:29 +0000
Message-ID: <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com>
Date: Thu, 21 Dec 2023 12:48:24 +0000
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
        ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
References: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
 <20231221121925.GB17956@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231221121925.GB17956@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0369.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: 63165ebf-a978-4b09-1f9f-08dc022321c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KaF7ZhzKdyYl1ldrwzi+ECYu6lNy9V+Irgp/uzr97YRHNCws5cgZ6fBrzVdjH++WgDSkgmpo6R0bimDfNCi/DlxpYyEIqKjqdw94cbxHHAxagETJxypR5/Uo5aErYMCLL5oh3UgVKu5Rldiyp5aU83TV40ozJN01V/BUU2UNWZZRJeWUbR3rH3ovph9BlQG7scMA0w0Q65M4v2pOpk5LEq0ZMPFBJMkFAuNIzt/mkOIyd4QXke+xEyLw5465EKZ/dQjILYJp2/veuRrCqZPXXtW2vnw/xJiMapVMxEzodYWvLAWAcHfVTRwhCGCACVXpqyr7Qnpb0w22+SmtyhNWFXqXPZRPNthzBgvi5ZCIRwdX4Fp+FSAlJsooRIk+iaLL+z6Kcj6zfreqkYCSGyai7hZa+BNdG0QN7Y3MffUPeoaBLz1DiuSp2+NF3ZT5aOBGpFZaxMrMPKZDUxolhmJu+l4bCz0oO02T9q8tUt+sLWrsJFu2nAapdRJi9Of7YyU+7CiyXyaLphMVi9muSlim1JNRR1dyur/+qu2H6R4IAR4sriHhIPl+vFbdMnoQUc3D5HckQY7HDyZypmPUmK5oqhPUaqjB6AiUkzJ0HMaB1AmPGpB19yXaXcUVxRNJF0TBQ1VhE1Rhkq31krH2Tg3ETg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(86362001)(31696002)(31686004)(478600001)(36916002)(6512007)(6666004)(6506007)(53546011)(6486002)(41300700001)(2616005)(83380400001)(38100700002)(26005)(2906002)(316002)(7416002)(8936002)(66556008)(8676002)(66946007)(5660300002)(4326008)(66476007)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?STc4UFo5a25tSi90b2Z6K3h6bmowMWpQRko1WlRYNU9IRnFUay9BZEx5cWd0?=
 =?utf-8?B?TWxKT0YrSEQ4SGVhY0JONy9mL2FNRnVBSTRzQXlsTzUrbGJlVUt2b2tvRkg1?=
 =?utf-8?B?UjRLeDlURXk0cEU4VXliUFlqc0NVdFgzcHp0NVpsMlB0cStYaXQ3V0pXaC8x?=
 =?utf-8?B?RHpibllBUkJMSmhsemVaK292VUNCcEhwMGNWZjJrOVZ0N2hlTmNJSzNuOGJi?=
 =?utf-8?B?WE5MNk54aFJibGZsNHBkUVZUQVlySUJCRlgrOWdjeVB1MjJvTHA5dndSdnE3?=
 =?utf-8?B?d2M1S3JQZnVhUWtyNHZPcmtZTkh3VWhsS245TDRESHB5UWtFREZQdUN2Tksr?=
 =?utf-8?B?VXFNc3d1NmNkbGF6aDZBNmlUdzlzSkhYc1RuK2YrUGNZbHVmWDZuSjdwKzdF?=
 =?utf-8?B?LzJOek9rK1VBb1EvWkFtUk51OXNES0xnT0tXY0xDUXFFa2RGa3ZLM1Z5cmRW?=
 =?utf-8?B?N1c2Z0szL1B1bHQ3cDVKZGpXT2N4Zyt6cDhRUFhYbUtGeVplcVZzZ0RsdEZ1?=
 =?utf-8?B?SGgrVnpWMDFOc2xVV2lVUFY4NzhpaitEaHdrbHk1QkNHY0FkZnNEdzNXT09Q?=
 =?utf-8?B?S1JqZEJPaE90a2w4cjhzR25LUUs2SUsyMGdLWTlyL2xEOHVyR2poWHA5TWxZ?=
 =?utf-8?B?aVVxNGZIejlsRms1aUt5RGNnU3RsV1gyTWFmQXZ5dGNoS2ZnYTRZamFtL3Bv?=
 =?utf-8?B?L20xenA2dlZMTXJMam9MNXdWVitIOUJTamlYNGtYWlNwQ2ZTdW9FL3psQmNN?=
 =?utf-8?B?aTJlM01ybm0zOVFvcVEvTVFVbStoWlhFNjVWem16ZkZNNmd0bExwZE90eE5V?=
 =?utf-8?B?SFdYaFN3dkJ4U2J5c0pMQmpRU3VIN2Z6TEhiaERBRjJaQlc4a3lKdEF0K3hC?=
 =?utf-8?B?NzZGbHNmeGJBOWxXR3o4RGhJUUpGRk1aTGFtRW5MQmZTTGhZNkpuWnZUQkhB?=
 =?utf-8?B?V1NBOWI4SGtrSFpaa21ITm5iaTVlTkI4OU1NVHhUQ2QwREZkSHgzbnptZjFa?=
 =?utf-8?B?aWVlZEtBZXZMMEtwVmxvZitJaktPckVaREVNZzBwQzNwVGVwcXBSS2VGUSt6?=
 =?utf-8?B?U1FPbm5OL1VoK3J5ZXprVzFRbW9Makc2V0VQVDB5NmtTdkxoc2c0MThBcGRR?=
 =?utf-8?B?bk5OWU5rNXlTV1FUWVdEZ3orV1JRcEdrS1d3bDhGOUxhTDFBZm5wbGFGYkNP?=
 =?utf-8?B?eUxvK25BUyt0SkVnamthenl2Ym1DOEZYYUdzVFNUSHJsdXY3V2NXQ0MySGth?=
 =?utf-8?B?ank4dGVQbXJGMlpOckp3TEZPQU5rZ0VBNGpoTTB6Y2tPZjRUMHhDL2lka3VR?=
 =?utf-8?B?bGpsdncxVWloaldzL0lOUGdRSTBQeUhLRzZjN25XYjRXUDlKN1pZZHZJRDQ4?=
 =?utf-8?B?Sm5Rc1lwTHZwS2o5WVo4cjlhTzdkeG5kaW1kZ1V3NWE3VTZhNWpsWTNNMm9y?=
 =?utf-8?B?aEpuR0hEN1oyamJwUHQzd255RjZacU5jK1NsNDN0dmkvc1JoVVdCZWlmUVBw?=
 =?utf-8?B?QXV4N1VCZERoZnk4L2Ezamh3cUU2WEQ2L2F5dXBqdmZCYXFiRlFDaGQzQWEv?=
 =?utf-8?B?Tm02YTVKYXlvUURETVhnUmFIbGRVdisxN0NSVVNNRmVZR0hZaENzNWxXM2J0?=
 =?utf-8?B?cFZuQ2Z0RVdZZ1pPTzh5R1FnM0lJV2dKMFhuZFl3M1R5RjFuS2JqZXpKL2kz?=
 =?utf-8?B?NGRLWXFDblUrSENKYW5jUmZYLzhWL25aWW5nMTd4UHIwOGdkSCtxM3hSditx?=
 =?utf-8?B?UnZJdFV3Sjg0SkxETTBHOGppVWxXNGg0MjRUUjhHR3JCcjNGYWlwT3FJVzVo?=
 =?utf-8?B?KzFsUXJRY01QSjFGb05CSnB1QVo3MWFYVVNJRDcyMEpHQVp2MkRnL2E3OXcz?=
 =?utf-8?B?QUJGdWhIVFp2Zk9mWCs4UTV5MERCTjZqT2xGTUFueXpLcDJLMFpwUWZWeWQ1?=
 =?utf-8?B?K2JvN25KeFhwWjB1WE50SU5IVHBLWGxpbVVUaHVmTkJoQzdPTmpxL0F0R3dB?=
 =?utf-8?B?aUgwa1FuUXg5OWtWckgzWExQTUhuRDM1SnQ0UVBRZS9HdkxJKzRTZVBLakFU?=
 =?utf-8?B?ajY1cnpxeFlpeUZXckdZT3VlQjJUZ0FhWnMya1NhVGNnZjRrTmlSNldVN1dR?=
 =?utf-8?B?LzRkcTNZVDY2c3pLMFBMbkhRV2xwejhaRXYyYlhiakp6UWp0Y0tmMlZCakp6?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gFuplCkzRNRSgVZ9LYAB4pCTh+ejTDbEFZ/u4Xl78n3C56vBupOpchq5F0JafhnKtO9ozeWT9LmVEQ+7fQriyTATxypHZSUecbAqYXQK3SVS6edj+qQOAa8UDYUhCTgpQegxemDL6AcOsivLenBG792oMWneRaaWLl6lBMGLrzA3bZYwu3QMzt7QDGPE6KZXptTCy8BktpU1LsTvfmldqmoNZxWDC3SIMSaD7ZHbQmGVaqmGFFQc2cHhfPi5gC7LUUZbUPh+Gt2Uufu+Pi3boFRFxVZrPbANZwS4rhowg2PGgU2nRZ3JvH6/YWg3kIjXAoFS8d84tTbsLjiOND7aYNpnLsEeQgN1I+E1n3wA3q5Dc07PmcvPXL19sSeD8GiCkybLdlQDWevaBIpV5KGz6GAsbE+jVYTuKoX+jn9yzSiBz9d0KFMe4txeykuWBhVejK1eKH1TtDeJGMgs2P9qExgil9Zxpe1mr7Yh715/cMkf5yIlTo4qE/CV+ZPKcMKNEcHRgwCKIruY7aek6o14daViFp/0OWoo0dvTKafAh7ViU273TTU/8ftJahISLzkcsNTq3XmXq1vou+PezD7flPdfLvorOIXU/lubQKm8Imo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63165ebf-a978-4b09-1f9f-08dc022321c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:48:29.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9Zay5+ozKvALC3l3QghnO5cCiwQPa56xI9+HxfaqFpRWcllG6rpOBkfiYQhwt9O6iJm0fU3MDGHz31/pefkrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_06,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210096
X-Proofpoint-GUID: dxWLMmXZopIPPW13UE3G1RSgrlF6ukAO
X-Proofpoint-ORIG-GUID: dxWLMmXZopIPPW13UE3G1RSgrlF6ukAO

On 21/12/2023 12:19, Christoph Hellwig wrote:
>> So then we could have:
>> - ubuf / iovecs need to be PAGE-aligned
>> - each iovec needs to be length of multiple of atomic_write_unit_min. If
>> total length > PAGE_SIZE, each iovec also needs to be a multiple of
>> PAGE_SIZE.
>>
>> I'd rather something simpler. Maybe it's ok.
> If we decided to not support atomic writes on anything setting a virt
> boundary we don't have to care about the alignment of each vector,

ok, I think that alignment is not so important, but we still need to 
consider a minimum length per iovec, such that we will always be able to 
fit a write of length atomic_write_unit_max in a bio.

> and IMHO we should do that as everything else would be a life in
> constant pain.  If we really have a use case for atomic writes on
> consumer NVMe devices we'll just have to limit it to a single iovec.

I'd be more inclined to say that SGL support is compulsory, but I don't 
know if that is limiting atomic writes support to an unsatisfactory 
market segment.



