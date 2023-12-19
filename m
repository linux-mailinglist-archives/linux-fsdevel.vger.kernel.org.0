Return-Path: <linux-fsdevel+bounces-6509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45F818CFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273461C2492E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FAF20B2F;
	Tue, 19 Dec 2023 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gYiyg0ZH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TJRlh2VY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB820319;
	Tue, 19 Dec 2023 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9x1ip031609;
	Tue, 19 Dec 2023 16:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LzQpi+e0gdQxnPGvXYzAAaCT/hzq1YaG9tRscJnoJsc=;
 b=gYiyg0ZHbmkr/mVmrfpc/nl+HoAKzZIjqhR/nFkFP0U5KTo98eqNOIqF1iCmt0K80pR5
 4S7xhTZGHRs/30ap0ZpjOGSVlG0NGIq1BxW1Lhm0lRraH7VIO6k+OXg0Gn+v6OVi0G2z
 9y4vTfLsIqU2hAEu7o/FKTjg8LJNgSqwFdhu+QFzK6P+YrHstv6yoY0DgYjGoh0C7tEj
 f9ZH/7BiCj8vzhmj3lHElLihgCIZWcmB3668om+FhBsBKSAu0IbzmKZuDq3OqoswTu2/
 TkNJukLZZMDkz1HH70iqlEBm8fksx9kQJp7YAACrLzxEIrYvnVMB+D4/B3pE9Cuh3tbW cQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13guecw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 16:53:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJFvAE3027694;
	Tue, 19 Dec 2023 16:53:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bd6kdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 16:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJblSvHKwZ64Pn1UTyzat5LrqF24SaKu6L64deLdkTvcsQ5KSG8t+o7nkrnn+WC3NKa1GXSWq/GprBz+kVdsy1vpr9UA1D+SLA30qnPjjkF9KQTp2w1aknKEjwM9Jfs1RzdxXGC+z80nKviAQfttW2vhQphMxU1FtNHobc6iN1GqtyoenBwaqLNtIGqAfXIZIvxU2GgAaI0s4FQHatCFoH3f+piFMsZleVdx7qK+39EWQGrd5u5uXCI3zEC703L85dFrWvovR0E08n8GRsEgP4yiXIBMrc+j2DOH6W3NUMkg/w/Ydd3EKJzOudk51B8HDQvOjrLVPZ2VDZIcTrWtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzQpi+e0gdQxnPGvXYzAAaCT/hzq1YaG9tRscJnoJsc=;
 b=PlBH+yD9hFaf3y/v4TVWzIzoNgvqU8fNMPmDedBC7PkJUxt1OR3L3k20yZvtHZkGhcAeCvf0D0XlUilqhIilqADC/4a3mTTwEDiDvsPsJGUcfJOot5VOlUK4ikoiIyAkYnESFN3q6O6/yrW3wKFuVPuuzZHqPa9RIzv5aY7JOUaiMwLyOWdC1heEvZZCntx9DA9gx6T7+yrn1Upb1vJQd8CaCkzGBLzKc771RXB4HfIZk2JwRWZMtzh0bzHKUsr7n6QQJDh6dgTz9XdTE3rmu56avkXsi2z1LCnnaRr0FHrbWG4J2n8mH1b9q1e9G8hgAe5hOgBslHiMH7/76gANSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzQpi+e0gdQxnPGvXYzAAaCT/hzq1YaG9tRscJnoJsc=;
 b=TJRlh2VYuKLoufVS18ly60hcstHYmG42pwhUcJ5UJdYbpXDcgALsUgaspqqY3tUFK0WkPnMqso52mJkFvd1+USFDtsWIOoFw7P1u5KHgBX/Md8Xu0/uCxwF+BonT9PNqtkejfo5oGt8bbEZr4PiIGwxfoZxwZly+8fNVjA7YObI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB7121.namprd10.prod.outlook.com (2603:10b6:930:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 16:53:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 16:53:31 +0000
Message-ID: <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
Date: Tue, 19 Dec 2023 16:53:27 +0000
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
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212163246.GA24594@lst.de>
 <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231219151759.GA4468@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8bf403-3d72-4f2a-8718-08dc00b30830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cf9RgEH+ebjN1wgoEWJ1JARrVDT/TXBUe/aZud/UGLGgvMiGBVq4yG4U2DmVarwDfpXiY8WSup8KHPTulv4w3oQoOplcq2MyC+HfTYa8GMasD/vSBKSwLOmHKgIFXK5WUKidN/37afJZ7QVg/NbAoCiABIFGdABYhz/d8mcTWytswpKUE9W0EuGioYRSyLf5f1xd5DXrhThk6lK0gAdbFc5yyflME7hCQy4yZiC8iGZzGinkHx2LARGTWZQIXaRPldhaXvKbA98b9v63hDJj1lTow/DbRR0Q0M5rDGdR3V35JyA8qGla1MpoeYUuYtR1cXl14gYYCmCHi88Ekv2sC6418U7IFeOxwxENetkPRNB7wznnY3oGhIeAudtqV5yq+vp8OY3tFs0vbl9AOcO5WIu3cHjKRb6HOJAH0CW9VkiqFXpX+bWZERT3AO5HHO5+sP4zkkUPFg2zcc5XIKLzEPEmHmXAHwDUtJduRobRG3OtieblmZQVscDik1k/FveEFNEGboS35dUIXNe0JpSU+cq4vPslgY3oleMv/Sug8ao8lUfz7moMRdAmk3Xyhg20YIXgSoyOGXf7riTZJ2GBUFUCar2ahYSm9kBxGQsAsSD4qsPV6xPdd+EAlLdrvBhVFaeKTgVaaZp+lqhIJAY14w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(53546011)(66476007)(6512007)(36916002)(6506007)(2616005)(2906002)(4326008)(4744005)(316002)(41300700001)(6666004)(7416002)(478600001)(8676002)(5660300002)(6486002)(8936002)(6916009)(66556008)(36756003)(86362001)(66946007)(31696002)(38100700002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDhvSkJ3MHZpL3NhSXZ2Ull5dGlwaHNGWmNLeGdRc2ZjRVhzNDlYQ2E2ZlhX?=
 =?utf-8?B?UU1LaHE4YTNwSWFtQWhmTkRDb2VEWUZ5KzRISFp2Z25Hclk3S3M2cWNZWWNu?=
 =?utf-8?B?Q2ZJTit0NUY3VVMzR0RVbWFtdXc0TkhjQTVLaUhZeWJEUlVsVFFBZ2k4NkhO?=
 =?utf-8?B?aE1uN3RSUnRpdCtIVHY3cXdBNENkcU14K0hqWExhaklDNGUzdUdiTDQ3WnZL?=
 =?utf-8?B?NUlJaTl5T29NK0xaY1pPaGpQWVBiSjJLVGZCM2tWT2taQlJZbEtBTXkzeDk3?=
 =?utf-8?B?SWJJdldMTFEvOFNGMzQrL1h6d1BaRVRTS0xzTTNRQzZabEZpd3o0aFo2M1ky?=
 =?utf-8?B?UU5ITStTMk5veGtqamdsYUNvdFVzbUkyLzR6YVNCS1pqTVFyNHp5ZjdoT2Q5?=
 =?utf-8?B?bWttc1Jxd3hFVFFIbjJHNVpOb2RXQS9ENHVxelZUR3FNL0xYZWhkS3huV2s5?=
 =?utf-8?B?dnZibmR0bVRRS0EyNk9wT0JmWE50RmdPRmpIbkpRWldUc0FTeDhJRC8zYzRT?=
 =?utf-8?B?SVRDdFYxR2lhTkdIWVVnaUVOV1pzeGRkTzBSVzhuSENPYlJPTlF2Mm9WT2cx?=
 =?utf-8?B?ZlR4QmY4SCtnb1J0WkRVZk1ka1pDd3VId2IxZ3BCSGNHRUtGTWVKclV6WjRP?=
 =?utf-8?B?V0d5dnQ5MHd3Y2NOTDRnZEhmZjUrWCt0aGU3NE8zaUw0OEVVQUx1Skx5RWtm?=
 =?utf-8?B?czk3S2dNNitRVVluODBSbHZQZzU0dU9oV0EvNUFDYVBaK2JRY2p3UzRBdXZL?=
 =?utf-8?B?aFVmWTdabHJYaStqOXNTVTRnZDFwRm5ZY1BTVmxaekxCM2ZwS1JieHA1TGxq?=
 =?utf-8?B?YkVRb1JPRGFOdDRHbmxFZjg3MFozaDMrTkJxMnNHelNsWUZKZDg2VndsZDlv?=
 =?utf-8?B?OTFDV1JNRmIyK2VtbnZwL0VZLzQzV2drbnkvUjZGblB3RjEzbWpQelVPTmdm?=
 =?utf-8?B?ODFGejFrTi9LZEZhZCt4VmdGaG1HSUFmUlFnT2JuTmdvRDV0SEVhblhFeldq?=
 =?utf-8?B?Z3RhTlRSS3NrUHJIKzBPcE40alUrZnZ5WTZXZkFGNTEvMjVUcDVlYTdxRkts?=
 =?utf-8?B?RlJ6UEtYTTdISjN6dGFtazFPZGFYR2w3cUJBTXNwdmZIQXRDalZieVdkQnZD?=
 =?utf-8?B?RXpTbU8wMzlXUEVYODJwNDQxVUlzbnViR3E3NmVyYzJkNWtsSkhJOHhnY0FP?=
 =?utf-8?B?QVd3WURERFdzRVJIdThsTUw0b1BVcmk1b1hUMElYdW8yR1VwcG0xQUtjN3ZK?=
 =?utf-8?B?ekJ3a1I4Rzdsc0NKYmNwT2wyVGEwa3h1RDM2RTMwdFRXc0JNcGpUUGljbERS?=
 =?utf-8?B?TTBSTEZQa2M4WW42Nm9sTURoeHY0WFJobFFSU01yVHFxRnIrYzdsSnFjUlpH?=
 =?utf-8?B?U2Y2NE5xNmR0ZkVoOTVWWVZHVjF6QlU2M2FXN3dkZWlQWlIvSUJEZWlycGJj?=
 =?utf-8?B?d0FiSVVKT05xMzUyVFIrMERtRWozYUVIb1lVb0MrMlh0ajBxbTh2WDFBSVpO?=
 =?utf-8?B?Q2tBRzllWkNDakhIRjJuVytCbDRCbFJVTWo1bDZHMG0yQUhpdFViR2d1MzZv?=
 =?utf-8?B?Zm54MVBEZDNZSUxWTXZNWElFTVZCY3o3NUxWbUhhSXVvejFCUlJUMUQ5TFFz?=
 =?utf-8?B?dUVlc0dPVUJFUDAvUVpNQ0JyOTZZZjI1blBGNFhNQ0JuWDAwdExFRlppUXFi?=
 =?utf-8?B?eDVvTk9jZUtoek4vYjFCWWlkZFdCZEYwUzREL2h3VGw0TVYvbE8vTWFmeFBU?=
 =?utf-8?B?M2VnWUVPTDMxZXZSUGp6SktwbitXeEMxZVpyUXN2RDl3MEpiNkZMNzZhaGZy?=
 =?utf-8?B?TlBMRXBuQ1JMYW10ZFVlQU10WjB6SkFkZmxFQTJnQ2t6UXJsYjFjdzBUNGEy?=
 =?utf-8?B?S0VQdjNCeEhxRkFhYWJJTTlNWkZmclZpQ2FIem5aYUlLNlFpTjNBa2FXSDhR?=
 =?utf-8?B?d0pUZVg2eXN4cGZ4VDk1cVFYZ3NrOXpWTW5PcVZyOVpPbFRTTExzMEsvV2s2?=
 =?utf-8?B?ZjlhenRLZm1xTzhUc3pQam40S3M5eTNZR09vdUNncjRvVVJhbkRGeEdCSGF0?=
 =?utf-8?B?RnM1UEZTcmw4SjlPVXJoVnhrVDM0Z3ZpR3krNzl1M01KL05mY1VMSGtOK1Vn?=
 =?utf-8?Q?x5Fmdc9ISyiGz2EBW8iMq3z4Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	veBJmS6x154xeTiX1IlLl4iuA/VsH5Ie85D30/huTbH6IlyuqyTdvMgGvA/it2JZN7scLNrFiSc14GG20Kgmak3UwZzAmfLWdAztCnxWtohLlfOyt1DMOoAWcfs//EuDKEVoXMcxnvNb4e6TQCylE7gdzIQ73vLNWKam6Q1lXoIoqUYfXwDCQBSvFNQ6sUQuuzmyCMBaMBBI3mPrUMM5cMFkbpvFvSneKalLxPFNyCLlp25suWD7LejH4KlMdIqXzi6LI9r39Bj1TTGwJ8fRwsgiZrInJCj+p/6qwwz70eKdygKzaUub1Ck28rjazU2OgsDR8aMlF5uI6xu8YeHQh2bMEJw9Bei6lBx8QFF7uaybUe9s0XV2rcoxtyk+7r3Vi45jFXiIAqU2kwsr9wB7hmyFZvPAqy1h7haahVUKCoEXkPVd990YGF0Cuag7pzVuHo8jejiXVpruXdmrFoHM8iNa1Hj4mIN3uq7Od7/MJY6171usSKbHWB64nQC/laV/dcEx3yZpkmXkCYg3SpzNSids5SnvJ6lFM+p8B7T5KW2jFPokNXlEgnrPav1ktpDWk1GHITSWHnoy8QCXgGFIqAYUvoJ81P1ZU1Wddcy1dGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8bf403-3d72-4f2a-8718-08dc00b30830
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:53:31.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DRUG1txpGtYNC06MaDgXu5nT5xuZnaFTmEFNBhxoYXFKd2welhR/zMt4Kt0lpqqsy5WxgCfWaose9VRsvCkjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=995 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190126
X-Proofpoint-ORIG-GUID: JswKvxbGMOqes8kCXtIivCZdSz4e7x3D
X-Proofpoint-GUID: JswKvxbGMOqes8kCXtIivCZdSz4e7x3D

On 19/12/2023 15:17, Christoph Hellwig wrote:
> On Tue, Dec 19, 2023 at 12:41:37PM +0000, John Garry wrote:
>> How about something based on fcntl, like below? We will prob also require
>> some per-FS flag for enabling atomic writes without HW support. That flag
>> might be also useful for XFS for differentiating forcealign for atomic
>> writes with just forcealign.
> I would have just exposed it through a user visible flag instead of
> adding yet another ioctl/fcntl opcode and yet another method.
> 

Any specific type of flag?

I would suggest a file attribute which we can set via chattr, but that 
is still using an ioctl and would require a new inode flag; but at least 
there is standard userspace support.

> And yes, for anything that doesn't always support atomic writes it would
> need to be persisted.



