Return-Path: <linux-fsdevel+bounces-6694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0881B730
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715691F225FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78012760A0;
	Thu, 21 Dec 2023 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lesyGREF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vbe7YFlt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D6745E9;
	Thu, 21 Dec 2023 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLDGE49016831;
	Thu, 21 Dec 2023 13:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LcHtzEAVqU+7oUc4zyPgfvoHAJOf1ieY9UqAAVov8zo=;
 b=lesyGREFYPtKt7LM7eeqEU8aXjM/HOrekIrc9qJj+8+/GXhGZDRGvlR2y2R6JJLwZhQW
 gJBYGgzrJR0acGreRX+RJN5gHP90q8qJJAUj52/ZQMdAP5tz4TwyUA8moJvBjtHBATaN
 q3rKUmBKkAwDaRQBDrdpN0DIp54jEEMH81I6XTSEEvCyU7e7F435rUgQCFRHQUCTp4Xt
 RDzA9yM2pGttpd4eJprq0BQ/0LsLvIg1bsW18EUpPZkqYOzY75Dfu9SqVoEeRwiuWiNE
 hGbfOU6tigNaMfRIJ+mhQYqo2vwlDAiGyzThb3CgJeIoqbtICZWOm6A0/rwUZC/hfRll ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v499qh8nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 13:18:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLCFaj4025087;
	Thu, 21 Dec 2023 13:18:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bgydhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 13:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIcZAHZTz/aQ0flAPS7kuum12Dj9pNn+Ay7ZzF+oo1EYK2Rr0HgPomDIhw++h/TVFDzYaLXCI4qlkU4yzDurBoMcACKMOkUhWB0MBf762/TvhDLoRaTmuH18nNDODGvtBBYKIRdLO51+eqBPN3rqElo1tqJM25OUd1pyymWt8i+tT0E9s8D2Ou92GVk026QwlfkjhnILsQFybZGccwWZdWrKR2PXJgh6G2y/PG251IJuhO5mZJl0mx2G6aKnh1yGOmu/3UJ0oYaDxjY/fq5NHMKXkHRSf3mP7h12STwWyvRw735sUHoaJH8fvhBxGkwqMKPMuUP9+uUAwc1ViNE7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcHtzEAVqU+7oUc4zyPgfvoHAJOf1ieY9UqAAVov8zo=;
 b=izF63HDY/2ybe+n2PPs18NrUgCB6jK1qLnWHEtl9KdGOpQrQMzsCCTpuRgtsI7cUbEQBeV5vhyOEWl3lz8zghHq2LaXDKlcCKyLW2Z1klMIe+OAEtHR3IrZcwKuG1+DIVwd+aC1OC9QzhPIpF3PKWhnpbR2GLPJqr1bGTLlRzBJjSAbqwxCrTTRbXZsWJr0dMXDlja+Tu+r7oQtBKJkXLwTU7+EGdWlgBaVx+/l/+oG1YvAXpUI4cNserU8GnUN8BUYVH56po4cnyGmbUV0ZCXDhLmTUNV/NfjxXYXFy4OXndHUfFmxBil5k6P3RhnGzSlzpWqrp3RGWie4Lu1qkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcHtzEAVqU+7oUc4zyPgfvoHAJOf1ieY9UqAAVov8zo=;
 b=vbe7YFltkaElLVqe4Saw8CXxYp6Wg0ZA1HVVb80vwnyPSeBKBv4K6BC/iqjbw5vsFhoaAuOBnWcbCG/UrLqFmtVEz7N2fTxi/9nQ8clgpV7lxwwQ+Z3Gq1ficejQp9Cti9hmueupvH4mnPK5wYt0z3xgU4aHZ5xBGqDp1tcS1lw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6246.namprd10.prod.outlook.com (2603:10b6:8:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 13:18:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 13:18:38 +0000
Message-ID: <9bee0c1c-e657-4201-beb2-f8163bc945c6@oracle.com>
Date: Thu, 21 Dec 2023 13:18:33 +0000
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
References: <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
 <20231221121925.GB17956@lst.de>
 <df2b6c6e-6415-489d-be19-7e2217f79098@oracle.com>
 <20231221125713.GA24013@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231221125713.GA24013@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: dda84357-558d-4175-8d1e-08dc02275818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AaqW3claCCkXDKKiwhcUS0wZ3ykyp32UbyczAeqbyiszzW0cKhw4cG5BIfSs3E8rzmj+NtJiM9gKx3e9hnxs7MHHXwFWEK6NTsxmNsqH+VT+F2CvlDgOd+ITh6NV/KJ/6BG5KQykfkG9q03Fcf1dUalHiVl+HIc0lhZkqQMDEExLR/wo6dCvuC5UI4bfZWb1ngMhQE+ONuAPl9rDdmJovQkuDgee/dtOuwvHbdi3RdkDJjyfguaNg8FD1Z6nHOVQpElzAjjTEufkUuMzERYRTSuy11p665K/vr63A4ZACyVQm6m/soZ/rvi2L4yvLNZbrSQ72APBFDEBMomMP54yVR75MvBz9+jifoW4Pn1uLP4DATA6siECDggLcmRi/0jwWflP4R9LDBlvdsJRyDPRMzVu1gLHTiKwe2Z3AHNzX9fpIe46+iusChHRPAt7U9IolHI6TIuFga5Ndi8QLlrFz7HqVcj5h111Vy6tHXgNxWsTgJFvxjdv2J6uL5M79eLMzTNbQ2stsRoUCyiYOoHFi7YUmCoVbH2lYDhmPD5SYuoFOaq2Z//9e4pMOK7mBvxqZ2oaQHbPEZEZ10BsxvCZI/ZYKOyUEUO8pkZId0r3zaY99pKtYOzQJ7uFeMdnxrz82FO0e6LZYTvxOCBCp5UG/A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6512007)(6506007)(2906002)(4326008)(8676002)(8936002)(6666004)(26005)(53546011)(36916002)(83380400001)(316002)(66556008)(66946007)(6916009)(66476007)(5660300002)(7416002)(38100700002)(31686004)(2616005)(478600001)(6486002)(31696002)(36756003)(41300700001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emFjbHRQWi83OE1aNGk3dWZuUVZORDRjUmNSUWVvUWs1THVGVFZ6d1RBbVF2?=
 =?utf-8?B?MGJTbG92WmF3MzFvUkFSNHdvUUJzQS9RcXpiT1RqQk1KT2E3UGFxVUtVcDB4?=
 =?utf-8?B?bHA3QUtLMEIwVXNBTWZ2dHJIK3g1eXAyQjQ5RFloQmdXQlNJQ0tqRVlDZ05F?=
 =?utf-8?B?LzZxRGJXSklqQVQvMFhUbWdqVC9OVU84TDVwQnlhM01kNS9IRkRkRGYxTlNH?=
 =?utf-8?B?UUowQUthN21kY2lsZWtCN2VIejJnNHY2ZS9IL0FmUGxheXBLTHlVNVlDUDRq?=
 =?utf-8?B?MlBmaTZnRWE2dHMyTTdXazNJUThJbVd6bVVoTHViVUdTbWd2dnJpUlZXR2ZI?=
 =?utf-8?B?Q3puNHpQOGJKa3lYZ0NGM3hndHFnTldudlRxY2NNWW9vQTJkR28yU0U5OXJn?=
 =?utf-8?B?K0JyajJhTzhhemYyRzRCalNYM2k1aW9RUHJhNmhDVkJ3ZVkxUU5TWitKT3dZ?=
 =?utf-8?B?S01nODl3a0hpaXFpRmhLMCtsaGtRN0JkbEZUUjRrdnVaR3Z6NWxXUytTZkRY?=
 =?utf-8?B?d0hMUzdSMmpNTTJNbXJ2M09QV24wc1BrcGRpbTMrc0tIVnNHdisrWUVNTXl3?=
 =?utf-8?B?QnV4Ym9WNm5yQTJGRFFBQ3o5R1BuQzdydGZGZCt0S0ZXVWZMa0oyQVkvR3Iy?=
 =?utf-8?B?eVhBVjRHZDQ2YmkyK1FUSjJRNkRQbzlVVjRzRkpoc1pCUnVYeGNtVFlkTjBI?=
 =?utf-8?B?MDlkYksyN2RrUFlBV1hZOWM3b29zY0tZdUR0dkx0ZG5zcXZPVzZnOHZpcXpK?=
 =?utf-8?B?bHJxWGJ5RW9yNDQrdTMrdjlSZTY2WU1IVUU4ZXJRSWt4bmMvUUM1V1RxUUJy?=
 =?utf-8?B?RGh4ajVac25sSG5BL3lkK0ZlVi9DYm9wQzJIcDQwNFFrWGk5QjZaSk1EcTV3?=
 =?utf-8?B?bUJpVzhxN29ZcDVMUHVYOUJPbFBvalRRS1hhcUx1bFhZM1NueENMOVdZcGc0?=
 =?utf-8?B?b0N4RjJneHJVdjZ6blN6eHdSMzlicGcybm8ycmFqOUpJRU1mTTdFanhrSklN?=
 =?utf-8?B?UnJTd3dFU3JVWEhrazhYdWN6NlVzSTROWEZxQnV0MzVvWWFnT1c0dUdEYmRk?=
 =?utf-8?B?dTc2c3FZTW9JSmEzVDB1Mnhmd3NiRkFOSWhmOUJJN2c1MU9wZG1yTFVmM1Z0?=
 =?utf-8?B?YXVwSVk2RzRZTzUweEdwbjZxYWMydkJPZjA0NUdrWTNGeGdMMHRVZ0RDTFQ2?=
 =?utf-8?B?ZmRYNEJ3YzI5VUVTUFZydUw5TUxLZkgrZkg0QmpDd1BpMW4wUFFlY1U0ejR0?=
 =?utf-8?B?a0VWZEpyaW5WMkgyTENXRVoxczQrRVhIRWMxRklZTFNSKzJMVndYTktSQjh3?=
 =?utf-8?B?aElycCtWci9MUEZhSFZLT2FDTG5mNXM0SGpCUHovV2JBbFlUNTNvVVhmMHkr?=
 =?utf-8?B?NDBpcDJhcnl5c2pCaXl4MkV5c3hHV29oRURYQTZNQWM0K3I5U0lxNGF2c0ZG?=
 =?utf-8?B?SkJlb09kQ0E0U1ZoVDV5bm5VM0NnRFNDMjczTHNYWE1vakh6MTA1bXVaN2ha?=
 =?utf-8?B?V0V6Yzc2N1hZUTJScnArZEp6dW00UDRSOHIwdHdERnN2ZE5yQ1hKdWptd0Nl?=
 =?utf-8?B?WFU4Vkd6ZzAvRmVrRHBRTERXSk8zZXpWK2ZzMUdRVEJIMm4veVA0eE9mc0F4?=
 =?utf-8?B?OFhQaFRxekJyMkxPUnpGck5XOFBBVDNwaUVGN2VsaTJMWTd3NDQremZKamxm?=
 =?utf-8?B?TWFMM21Ubk1CeVg3blB0RXVMRnltcVhPc0tXVjVWdFZGaXQ2VjZTelE5V0NX?=
 =?utf-8?B?U0QvTXgrem9TVEtEL1Y1VXVyZzNwUXBtcTRad3l5ZGZKYm9WNWlFNENXVy9k?=
 =?utf-8?B?ZmdTTDhhL2RQOFBGZWNxODd4NW54c0dvZUdSbWVDOG1XYm5TK0g1enpTZ2Q2?=
 =?utf-8?B?dUxUZW5KSWZGYk15NmwxWVBkREZoUGFlbE9CYWw4ZkdRKzJIQko5dThodDZH?=
 =?utf-8?B?WFdyL1RRM2ZlZWpaMkRYTWpuSGtnOVA3c1RadlZqbGhwRXdKb3lET1o3ZEM0?=
 =?utf-8?B?TkdWOWw0YjM4TXhoRDZPZ2RFS2lNMWs3dTRFTHYxcklYQTNoS3BQMHBZQkNZ?=
 =?utf-8?B?a3RGcmRiVXU1Y1lQTk82ZjBwazI4R1dGMnZLTE5mNUkrdGZQZWpTcm8xbEF2?=
 =?utf-8?B?SjJsODA4QVFxblZka0xUVmlDSTRPcXp3TVBIbGp5TGdvNUpCS0tFUkdzeVFq?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Up6Ds5TTE+FJHYhpPdBUP1X6wyWNf/esVst+7jKYtGDDrwuOxmU+cWiNIYRBN9+krrGgvXAT0Im2JwWz/v3PSc1qhDrVC3K/r9M3xQeQ5mEGhQCFQYIdhL3dVbBQDq3+rGrarZWO8mli09LxSCX7E40fVbXpuNJ2hzphkq70Hdqa0zBvGhVQszQYKEbLxprSzBtBmARWHSQl+bUUTFU0CL2MHYWLx3YUPnHBW29WPJEhHcq1QfRU/sTS1p78dx9yDjV7shDLjuLhA/NpQTHWe+okGwoQCXO17dyRDS62bnUIH5qdyicy73Ye1gVyyH2vRTuFTwFno9tcOonUJKmWFc0sQMHUamP94ZxvkRP2bsZoh8YvSd0sLJMn3dlAME9NS7OoamgK6HCzt3ZkwLEezc+3hznDY7d0cVMX0h2vCyP54UmR46mnDkU7iBpCbxcLb4FYzsjeRgmZ/wTAl5bC5L9UwVFxuB1ahQf6DQ1C2GZHYgQmGeLIXcoeJcnoEAmU6uWe1J9TJay9Jx5HxnUmjkBNoxTZ+nKpqGZUeC2n8VSZ3clno9SuafmHxCuWXdMpQM4Q6zm5ZCQeKbHGEaYxVJZAFcZGzXe0esO8mJGvWVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda84357-558d-4175-8d1e-08dc02275818
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:18:38.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0iCrBJ+QWaWywveqLgeOq5wmLWPJSjkaNSPek0PSTahHTJAY9GxnDdot2/vWLTbY8MGFQqwrF7Oub0lxrJ5MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_06,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210100
X-Proofpoint-GUID: 852sVdY6CQIeQAg3irpOpOhphX0TDl5Y
X-Proofpoint-ORIG-GUID: 852sVdY6CQIeQAg3irpOpOhphX0TDl5Y

On 21/12/2023 12:57, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 12:48:24PM +0000, John Garry wrote:
>>>> - ubuf / iovecs need to be PAGE-aligned
>>>> - each iovec needs to be length of multiple of atomic_write_unit_min. If
>>>> total length > PAGE_SIZE, each iovec also needs to be a multiple of
>>>> PAGE_SIZE.
>>>>
>>>> I'd rather something simpler. Maybe it's ok.
>>> If we decided to not support atomic writes on anything setting a virt
>>> boundary we don't have to care about the alignment of each vector,
>>
>> ok, I think that alignment is not so important, but we still need to
>> consider a minimum length per iovec, such that we will always be able to
>> fit a write of length atomic_write_unit_max in a bio.
> 
> I don't think you man a minim length per iovec for that, but a maximum
> number of iovecs instead. 

That would make sense, but I was thinking that if the request queue has 
a limit on segments then we would need to specify a iovec min length.

> For SGL-capable devices that would be
> BIO_MAX_VECS, otherwise 1.

ok, but we would need to advertise that or whatever segment limit. A 
statx field just for that seems a bit inefficient in terms of space.

