Return-Path: <linux-fsdevel+bounces-2876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84E7EBA72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 01:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727041F25877
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1C258B;
	Wed, 15 Nov 2023 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CTqZ+CuL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m5khF0Sq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AB23A0;
	Wed, 15 Nov 2023 00:06:18 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85887CF;
	Tue, 14 Nov 2023 16:06:17 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF03oJu020549;
	Wed, 15 Nov 2023 00:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=U+W2uINoSVNwzypgqI2vLoOVhNr7GX7n2B24PhqrUm4=;
 b=CTqZ+CuLJj9byUpe7EKPVByHQG3C40v/MtUA+W/EbFlLrFIu8hEs1e006i3pq3zsbsbd
 6q26nIvGiTCW0kEwvrxg6IvSVxIN5Xxl6ZIRuWLkgKGZd5pV4vLDfOmsfIUgEZt37yDF
 kUWynrfmPiE590fBAwayYsYnbcfu9AoKUSO1RxJaCoL7/klyP/+q/WDO6Ij+X8BJQszJ
 zkbV5Jov4QHdQO9mG+pqUIeXVP8lcwwwaJbqD7DBgL+wdoLWF6xRTIrwCuGxSN2XlUd3
 URGI0C5QrExS8hWDvpy7ESQl6Vlyo5t1B0YqWIi7IKQHNzp2g7c0xAC1iv5De8Zsf+zZ SA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd6x1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 00:06:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AENjpXZ004192;
	Wed, 15 Nov 2023 00:06:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj2wx68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 00:06:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aP2TlwHUpDgtt+TGJbObYFE+ISEr3eRS7MeP1281modv1Ku8V9vcv6qqrF0WU/0Zid/Ld7irI+TNh4QDEWcrC+mZmqS1gBwsoi0jixusgHYMnE9eX6DI7ORuJoW3niIqYD4YhHRAy53E9ZBUBD3UVv6DYK2HokIC8Dk0tE6J5vvm5nc/ZjubWXxgnb1/xHuka7N6tD6rZLWVEggOtu7zEs8X6sR9yUqsK211XReb6pUn5Z0ccKWqwB7UuTRA3s/C6qXVJAU0gk/QY1515ilfzW3HQ8fEee2moPTAk48H2zh80SmNkAAAxL+ZXVwfx8oP411/uqCIpxzs1EWF74nK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+W2uINoSVNwzypgqI2vLoOVhNr7GX7n2B24PhqrUm4=;
 b=D9DeOF9QLqbnFfUFT3X8pQr9tBROIKUn2x/xPZSQzzsWyRfoDILabANEls2zi0FJgV2A4EcBpku4mb59nsg3xOBL0h9TU47OImZ+5zLbPwhqGIxgTmJ/vmOjNyZe9/13Xf5HMFu/DnrE1vE70R5sHF2GDEg1nkk8/3p6HqkPwA1G/sgYuaX4zWTNmx+8falYhfseAMq19xef5Wn29iop8uuHMB7zMJE49KCUmZ/l/1wz1p3ENMQe8+y76wpqr+OfR8NSSYQyui+8d+FR4J6R/4HpNgZvcg1Uk1LLQL2+sPK82DH9rd9bsCBCWQ9H8q26A8q1HWvnUxPJaI9UT5oSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+W2uINoSVNwzypgqI2vLoOVhNr7GX7n2B24PhqrUm4=;
 b=m5khF0SqW+G9LV6V3XJQ4ggFzCZglf6iig1w3RsO0Xuj5L3cR5OwXGdzbp/pHfali3ZLxrDrmf0j4MnD2vdu0K4iRH7QwXVbfgmzu5YToGsOK4Q9LrE3RlRslV/NDJl9aulMAuMwrF3WayLTkG2KinU+8gagIueDVBv1Hcr+UXE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6300.namprd10.prod.outlook.com (2603:10b6:303:1ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 00:06:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1%4]) with mapi id 15.20.6977.019; Wed, 15 Nov 2023
 00:06:09 +0000
Message-ID: <1f8c8d3f-8f7a-407b-8020-e961fe2f6024@oracle.com>
Date: Wed, 15 Nov 2023 08:06:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] btrfs: move space cache settings into open_ctree
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <cover.1699470345.git.josef@toxicpanda.com>
 <c1f4384e79a163e4aef516472a8d6574dc54545d.1699470345.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c1f4384e79a163e4aef516472a8d6574dc54545d.1699470345.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: a8455e85-d720-466b-d923-08dbe56eab91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n+9IgF8jMOagO1LbMZf3mfR6Sqk8UtAWBZJXdPfbxKLpgNnSMEJnVW8ND8kA6AfrBbEYF0UeAs0UIJIUMJTzwptxSQlwmZ7fisjWqOPm/+bqoipC51C1sExCcCeJafrhAyDbTYfj22pTxS+ehLcVAPdhzclP3weXLtc/08FzNE3g5n7K+rE7LM02bc/0kQB2LBg6Kh+6vpQnc6VSTR5HTMlV8YawuQ5MJYR1gUaYYZS0llBgTwl//Fg4h54VlMqzDMK6KqEN5Qhw/DLWSE0wx6g5UwN4I/kEQKjezJXKG1mnUMyj0gG4BuDidw12PxVvo5EU9naV+1NmDttd6ZO1NW2TxOMaUNWYoh2DxUd9A2necWSNuFHy9TgcqaiZ2sASycFTloxEXs2O+S0l2yprStscTuNMKRlI2S6wP6BuoIn6SL9hHCZp4IH9DQobC3WY83zKRgXJzeGoowAuKzpRTMPrmaVKWbtLyKGWs7gC/N/nDJ2hXn+Ttsgkk9BCmO/mr4GQ7xu2Jd9V63XQy/hr2Qv0SE59a6Vcv8Kb/0dROYPxmQs3Wh64pNI+GrSRpcYfAfC6h8A+5JFLcEkmR7PG+DLa2XUlqaGDCZihCny+Nwh7oQMjsCDq0p/7zVqNtrFwUX0swH+yQGnTvwfCPwhlRQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6506007)(2616005)(6512007)(26005)(478600001)(6486002)(44832011)(86362001)(36756003)(8676002)(8936002)(41300700001)(31696002)(5660300002)(2906002)(66946007)(66556008)(66476007)(316002)(6666004)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWtqMHMxVmI4VEJkVWlHN2dRMlpMVm4rOUlCcnJhRFdpc3pkeTUwRkhSaEhX?=
 =?utf-8?B?Z3daVlR1NnRPQ3pyaTVIMnNtYkp2ZjN6V3B5dnA0aFBzT3BodGpaMW9JdTJT?=
 =?utf-8?B?a1Z2MzBJOGlsb09WdkRNMllkNU5waUpSSlVPemRGTVV3U2FnNHhnMWZTVnkw?=
 =?utf-8?B?VzhKZ1dLZ1BwbWR6ajBnaVpJMGxqU3JWR29SVk56RHFCTm5TMEJ1elBGaUJx?=
 =?utf-8?B?VzVUaFZkZXZERVIxbDRiWTZwa2NLRDQ1R0lIMVpYbXN2SFNWU2R3VlJsK1pk?=
 =?utf-8?B?MEc0T3h5WDJsb3BNNDYybXhHV2hJdzgvbWg1K0tnS3lWdXJiakMvRmZLdmZ0?=
 =?utf-8?B?amp1b21uMHphMnRUNUdqQjIvM2xPWldCZW5xTUhhN2RSVm8wcm51N0IzTkJ4?=
 =?utf-8?B?R3Q1d2x2MGxqUmlnb1l6M0FFVFpiUWV4dkVHaHNMNGUraWkzM1NFR2ZMRmZr?=
 =?utf-8?B?eEllaXNQL281QlNtMjFIdVgxTzVPaXRwYm15ZGdFeGF6ZUFpY3dydWMxR3Ev?=
 =?utf-8?B?RmlSZHhRcFJNZG5Lb01DMkRmUGZvYmhTL3pqa3p5WXZXTXBtdzFUYjJzTlZw?=
 =?utf-8?B?L0xNajJyc2FtT1hvcWdxYjBWNmNnb255YUt3MGhxVElxaDBCQ1VjOVN0b3FQ?=
 =?utf-8?B?RTByc2NvaFgvWHpySG5RY2hJSEFsb2Z0SmZBbVVuQy9qUlc1SCtZVTZGeHR5?=
 =?utf-8?B?aDRIZURVUVVFM1BUYkZlTkduNlM2VGZnUGJrdSthdXM4VGZRQ2pRVWdjLzVM?=
 =?utf-8?B?YzFDM2pCL0I4RmswdjVjWk9qbUFQUGhmSWd2bzBQejVwN0xsWE9pdHgybFpZ?=
 =?utf-8?B?WGtGeUV0MVdnM1d5Rlh0K01MaXpOVXBCcE1tRGZEazJ5SXU1WGd1WHJjcW9O?=
 =?utf-8?B?Z3lGWldiU0lXckFqTE9EelMzU0E3MU56SVM4OVZMU1BEaHZIdUJmTldCTjB0?=
 =?utf-8?B?d2I4RUp5bkliZXVybVpOcE4yYlp5VEcyQ1QreGFVTDZwb2ErNnYycHV4bnBT?=
 =?utf-8?B?MUJ5MFBZcnM1dUpXWkE5bk1udENPVWpHandhcHJ0eE5MV0tkWXlKQlpBZTNR?=
 =?utf-8?B?UFpQWUFvODN1ck4xeVl2ZHpLeDRSV0U2ZmgzUGc2bzFRMEdoMS9HL0tvc3M4?=
 =?utf-8?B?aEFMK1ZBUE1nOG5CV2ZPS2RsRDVwWEpLVlZKUjhhTU05WCtRT21ORDQ4Zktn?=
 =?utf-8?B?REE2Sk50b29ZaGtMc2JhOExuWCtySVArbFg2S0VSaTE0T0lOYit1UCtMc2dL?=
 =?utf-8?B?SHp4c214VWRHMThVWUtnc1ZFSkxMT092c1pZYjVmZTAxeDlHN2cxc1g3Znkv?=
 =?utf-8?B?YkFwTVFMWEh0WUxGdlNsUWhZSEJScm9UM01uVHRsVjI0Mk9QS0JNVEp2eUJD?=
 =?utf-8?B?TVpLVDlKaEEyaVBOeDEvZXQ5MHVEZkhEYyt1aWFKQnB0L2c3c1EvRnJEZ2FD?=
 =?utf-8?B?c1ZXU2dGb0NydnAvc3VkekwvV1oyUDQxQmIrbnB4VWoxRVYyYjVHbFN4S3kx?=
 =?utf-8?B?KzJDWTQxQ0lnQUZNQTlMUlp3VE5vQUZDeEJXTzBjV3YxSHYzWFJZYk5BMTg5?=
 =?utf-8?B?WFdOYjZhWlRzWW1jeXVhVTdkcko5U3p6VWdjakFWbVk2T1NqZU1UbzI2M1J0?=
 =?utf-8?B?RTRSNDdiNGpRUkpHN3B5V1d3M1YxVDQ4SHBkU3FMYW5BcVlJUklmcGVRZ0Ew?=
 =?utf-8?B?aXNwTnBzMWhDUFIwVGJIU1NVTVpRdi9BWjBxeFdsOG1SbVYzS2ZWMHZvMXdh?=
 =?utf-8?B?ejVOc2I5YzA1N1R1eDE4SmcxZkxvM0xRdklWb0dMbVAwY285RS94cEY0UExZ?=
 =?utf-8?B?WDlsOUFRRklsL1RZbG9uNGVTU0NUSXhiK3VKQUsrNmlxR3BSWW1uVjBpNGhI?=
 =?utf-8?B?UXdlTzVUWForRWJjMytZT2pXMmprMW5MQ01iTHlOZ1A3TE5qM2hzM3M4Tzdt?=
 =?utf-8?B?Syt6MVZoMlJiMnEzRTc1YUlKRkFieEpiVmtrbW13TXc0NkN1TU5ZWm9Ldjd5?=
 =?utf-8?B?RVJsYlFVWjQwRTJkL1lnekVLZngwa3R3OStpUWNDRGxIU3VuL3JOTWFnaGZI?=
 =?utf-8?B?WlBiUTZVSGZFbFRWYzFGaHJCK2V5clJFQkhoT0hweWxuUnc3SHZGQWpNUGY5?=
 =?utf-8?Q?ndFqnQcMJ7tA2MhW/9fJiT7zc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PaU3tR+OQsDt+/54HTKzsf/oZH3B4GL7azohbRNJyU9i2HKPczXxNM1DizRU4LW8gKFI3vBy1I8vlkGV+l6jFfgEWpIPnJeIYngLbNXE8ozVI6x62MUP2zhBaZqJufn+5OJxs0npNf+105iy8PlDyVysr9RNb1KYw/F2xET2T0Pv/8Kklrbm0A4Crbg5AZu/LwF8M4NB+n6LbXBLYfT0JFsKWXmfm3uJfE/U0g4/nhdPMsTv3LqJ+t4rCRKZ7OGQGd5zfNXLDb5d59M1kpsqR5WrE2UZ7BC33A/J1J4e8uR1ylWVGxRHKhO6/EHEmmRNIMgyh+XKIqaiyAsTgfqJ3DzxrrLWUG/7QI/hwKC8VRHxWIIScf2tRz97rhGf93FkOyc4fdOowLnfJ3GT4xIIjM/OTWWP0QgqjgKzsho0a33GywxjoD44UZvz9TK3CcUVL2so91eG7l1PDcyITy+h9vdk4P1lqEU4RpqjoxgtigDfXzJfLVLe2eyaOeRwVuF5R4ywRymQtW1QpTKwYoD1BhVjyVTCojP+ha8SJPJY6VXJM7+Ac7SvM9gp7UJz0L0Dhx+mJSLE8BOk1nLcTSuFgBB9Kx25Co5fmUcC8MvIsihHFKlyrcbha69uAcwAQxOBHdRR3C+3BuzbZJOScw7KMV90nU8AROYtNvyPu//8lbPJMp/cVotxJ662am44OkAbnGjfTB7mbIsx6hO84F2Ii9Q32l8SWBnZucbCFS5BNyJfrzyso3p4HNhuMFO9rF7cy0oziHBW5S4eGxcKZP58w9MLwGVYgjlMoFYyB+mpKtH3bAKXD8dmbjRnolReUT9oQgHIlEAxGYkmzBiplQGkpQgzByGHUyumDCyHGMtdTGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8455e85-d720-466b-d923-08dbe56eab91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 00:06:09.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgzKiywPKxfJ2owX92DJjExwREfZXZ5zs7ZjZcT38ZQGzhL9D0617H6QbhNWwxX8104GYdL1GfnE6L6FnwmHAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_23,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140180
X-Proofpoint-ORIG-GUID: KSo9gwPwt25Jvl4dPKT8BsVOS7uDtMbZ
X-Proofpoint-GUID: KSo9gwPwt25Jvl4dPKT8BsVOS7uDtMbZ


> @@ -3287,6 +3287,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
>   	fs_info->stripesize = stripesize;
>   
> +	/*
> +	 * Handle the space caching options appropriately now that we have the
> +	 * super loaded and validated.
> +	 */
> +	btrfs_set_free_space_cache_settings(fs_info);
> +
>   	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
>   	if (ret)
>   		goto fail_alloc;
> @@ -3298,17 +3304,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	if (sectorsize < PAGE_SIZE) {
>   		struct btrfs_subpage_info *subpage_info;
>   
> -		/*
> -		 * V1 space cache has some hardcoded PAGE_SIZE usage, and is
> -		 * going to be deprecated.
> -		 *
> -		 * Force to use v2 cache for subpage case.
> -		 */
> -		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
> -		btrfs_set_and_info(fs_info, FREE_SPACE_TREE,
> -			"forcing free space tree for sector size %u with page size %lu",
> -			sectorsize, PAGE_SIZE);
> -
>   		btrfs_warn(fs_info,
>   		"read-write for sector size %u with page size %lu is experimental",
>   			   sectorsize, PAGE_SIZE);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 639601d346d0..aef7e67538a3 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -266,6 +266,31 @@ static bool check_options(struct btrfs_fs_info *info, unsigned long flags)
>   	return true;
>   }
>   
> +void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
> +{
> +	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
> +		btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
> +	else if (btrfs_free_space_cache_v1_active(fs_info)) {
> +		if (btrfs_is_zoned(fs_info)) {
> +			btrfs_info(fs_info,
> +			"zoned: clearing existing space cache");
> +			btrfs_set_super_cache_generation(fs_info->super_copy, 0);
> +		} else {
> +			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
> +		}
> +	}
> +
> +	if (fs_info->sectorsize < PAGE_SIZE) {
> +		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
> +		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
> +			btrfs_info(fs_info,
> +				   "forcing free space tree for sector size %u with page size %lu",
> +				   fs_info->sectorsize, PAGE_SIZE);
> +			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
> +		}
> +	}
> +}
> +
>   static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
>   {
>   	char *opts;
> @@ -345,18 +370,6 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   	bool saved_compress_force;
>   	int no_compress = 0;
>   
> -	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
> -		btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
> -	else if (btrfs_free_space_cache_v1_active(info)) {
> -		if (btrfs_is_zoned(info)) {
> -			btrfs_info(info,
> -			"zoned: clearing existing space cache");
> -			btrfs_set_super_cache_generation(info->super_copy, 0);
> -		} else {
> -			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
> -		}
> -	}
> -
>   	/*
>   	 * Even the options are empty, we still need to do extra check
>   	 * against new flags


btrfs_remount() calls btrfs_parse_options(), which previously handled
space cache/tree flags set/reset. However, with the move of this
functionality to a separate function, btrfs_set_free_space_cache_settings(),
the btrfs_remount() thread no longer has the space cache/tree flags
set/reset. The changelog provides no explanation for this change.
Could this be a bug?

Thanks, Anand









