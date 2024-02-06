Return-Path: <linux-fsdevel+bounces-10509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CA84BD59
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 19:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450E21C248B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789D17753;
	Tue,  6 Feb 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LapI9qVO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cLkkLKRB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9AD175A6;
	Tue,  6 Feb 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245113; cv=fail; b=BJ214UtJiWpgspNbOmfzsam0IYHzB/jdwALLh1Y7z2Vv0MXLiUGR1iMM9JYhT3eS4OlHpDY9gj9RM7dls7GSbTll3I3m3Td1AhZFWdB3hmRTtgYhr6i5zk3P5SZ/2KLZUoSA0VvpaGtkX1HNUGtEtXz4c0HyymWAwFtVUibapFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245113; c=relaxed/simple;
	bh=IZd7BKBFOogoccrRRUjFEqCuHsIOhDAbTXPDEc3oZWc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSN/vohoTl1qWKbf7NThGMiSYqnRAXUF1OXGLFvhAS8iuZRlHxPCtOZYXilQvRybXCTlG1yh278kA+jdHrUxWLMFxUo++fgmJp9vu5u99besnz3j0MaVo1mWFxUtEov9+sF/HBdlp5B6U/4yS1p9OXmfNNZAVfq8hLB//yuVtWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LapI9qVO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cLkkLKRB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416ISuWo024279;
	Tue, 6 Feb 2024 18:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ANVAP1fjbDWF/v992aUQ9sF9CKvMW0GnO24CWGIhsAk=;
 b=LapI9qVOJoLh4HIU3LMzsyxzD2soDRPzBIVXLpj4biiLq7BEQkwJgrpHHWEByWKW9Szv
 SY3FClvbllUx+T86uyINp2seazC2XH3EMtMtJ5mmTHYqnj6KNlob65JZ76Y2SxiJcDqD
 1fxJxora19ZLVSPMRab5h4+9wUcs+OaYboTM8u2Yc0O/9316+V7RNsnLL0xfLmR7qg/4
 na0vHeCkyVzU42cGHmLwvmrccI3yLRCobFf0uKuZk0uXo3avZmAAF6yxBF5X+EVwWBZe
 gtPI64G+BEnDEq6CTV2/lj5LE7xTsFNezjQqy8foISmRTihZax9BxHeSktX8ubOa577l Gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdfry5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 18:44:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416I4DcV036823;
	Tue, 6 Feb 2024 18:44:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx7s75w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 18:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs5GhXuE1C+40onVcKnmJh7iCpGejvepz6MBqfZjkj9FH+0Jl5YbfUML6jO9xuTt6CbC4eLt2T6eXXen9o4W9/NG05aepO/gAJjGin+C8k8a3EvVwb8YVO3FbB0qI0KwFqzREY/7XgPj+3gcy6TpCDyYt4/lQxBAqRgV1auCgIligzE1ZfSoIebqKi/fJYpZoQYxBCEbc1Ni0goQHCNllEqut/Scmzei6j3sp2etT/VMWF+KKjjwwxgyKt61K3vsDStBjKgvnvKFhW/uObIe6RFY9vmITDIDNR6Aslt5YDFWYFAvMW/xoAJIPozfhN8I1dsSR+YFm29ThQVe70uMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANVAP1fjbDWF/v992aUQ9sF9CKvMW0GnO24CWGIhsAk=;
 b=XKSdL1rXeVkfYTSTx5TIi5LYlxIh1ROwi0vPFVGFZ3MPK5G/73y4OzV/p/6qXpsbruPSeP26w4samOsH4yfVMUCU8MUG3LS12/LXFqy3zf7ooTPV/cxDNA++pUOYst2dkfkkXT63lMi4y2mdkN9/DXXc2MYlmUzumxQPlTCx4/SHKMjxIUyqe65U2ZAuE9IA8l5A3f6E5AkNsMYISsG52znyrXeJDcHD0jeFeRt/q1pR9PLIgRahPpaRUNIWr6ehXMaLd0OCR5veKYfgE8ZypiM0ZMTerCll2+k6KrQIKGCJIMld5H4fYwJhdxdEiwYj2Gy47pAL9QwwSOexpviKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANVAP1fjbDWF/v992aUQ9sF9CKvMW0GnO24CWGIhsAk=;
 b=cLkkLKRBIwqDO3OAu09xJHvp2ZvoHRb6VfTO4Yw0jrOs+5ARMy361xmCtMwyJs/WjPT47tA2zNSx28SnnVbi3ALW6ecB4CSXpcYALSO7fLAcZn3pCUWCBINOZ3nOyM/zphJ8kbYCa3nBcJ6icUx/NuXyC9IsgyFXNHGBcxatFLU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7902.namprd10.prod.outlook.com (2603:10b6:8:1aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 18:44:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 18:44:42 +0000
Message-ID: <12718838-7038-4d47-9287-e699e8808143@oracle.com>
Date: Tue, 6 Feb 2024 18:44:36 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 00/15] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240129061839.GA19796@lst.de>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20240129061839.GA19796@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 63129165-4f8a-4e2b-40cd-08dc2743ae6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7aR1VHymRfrA5CorLXPq0dIFX6+xHMJovNGHPY58TMNcDcrSU0EG0yjApP8uRRVrpvXpAL0gKt6RbXn5jBRebpqPd/ca7waB4IE/2XKY7F4aKzduOQoNVnyZrag2WeZ2sSOk8waFWETCZVLn8nqiGm2pUYcZmHRupHmT3EZjLYBmzrrHJ0mPUhCjEpCrHsXLBv/4Vj4epRhEF5WpnGhw0FZtBUoDTp7nvqP720JGX8pHYWqubH2GSQ6jdSZwpfTpFKm5LfzDcmIEe6Uslwhg48rdsqPFmKG4H3dT0GQBmhfnajO+UhPK6a9BvASflNrIzpUOLKjtO0yIyEq7Rig/Q7Yz8iRlREMKq45xovodzgPVW/zz1pml4k7OhBWOXeHmnFIJ8SF39jnH+GYGohpJdxEA4lQlrK95wB78OmPwN+NnjaGNVr/N361KbwEqyq1L4iMGONnkvNTKUlidyN49n1G1g/EWU7NtUmiKR0QASbQfKnSLXrXm4S/CGSjqsvcK4mEqtI7pKKBYncZCNFycuGaNMIrxW+bOAreziF7IibOLbs/t8O09/02wuYeR/CEfKkwou8wBpYVBIzBPwGi2GGd2cCdCJTGynOED0tSKJzWohPt1+rOTWnxUVk4H662XkGOyGxrJsn0Fkdr6ZJhwuw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(86362001)(8936002)(8676002)(4326008)(31696002)(7416002)(5660300002)(6486002)(478600001)(6506007)(36756003)(36916002)(53546011)(2616005)(6666004)(6512007)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(2906002)(83380400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWVIbEpNNmhvWHJ0TGR2L2Yvd1BCSkh5UVEwWWJhbUJKejlCc1JWdlcvU0VI?=
 =?utf-8?B?dTVncWdPSEVIU1FPRkkvbDI0d2NZUlhGS05JYW1tcUpWUXJlNDFCUjhScXRF?=
 =?utf-8?B?RVMxcXYvcU5pb3pPMXZPNmxKN1Jod0ppOTFGZlFvNUxnRjBnd2ptTldPbGVB?=
 =?utf-8?B?cFphbGVldWw0N3AyUnArKzI1dmtrU2YraUxCa1A4bmluQVNhdURKRTRQTWtM?=
 =?utf-8?B?aEFaTEFjcG5HL2F2bGpsM0l4UE8yMlBoU21iUGY0L1R6MHVkZzNMQStqREY1?=
 =?utf-8?B?L1FsdE9ZdmdPM3Q1UGRpeEgzem95TG5xRnhXVkZRdFI5S3hPRG11THFpSndX?=
 =?utf-8?B?eDR0ZTJlOU1ScTJkVGFFeUQwVFpPT2dzclVJdkNvSFFlVXNNWkEvQlMvWnZF?=
 =?utf-8?B?NTlqYUJJZEJabmZNVTlDTjZLakxoMzFlUzM4OWozaDNBWGlQcUErWVgzQWQz?=
 =?utf-8?B?S1pwbUd1UTdxYVlJbzQxc09TanpPQTk4Z1J1WlQ5aVNZR3RNbXNsN3M5QXpS?=
 =?utf-8?B?QjdST3lCWmYyTncxVG9xT3oyWTlwMmMxanJNbkhhN2ZoUkp0Nnp1ZFN4dzFC?=
 =?utf-8?B?cEY3Y0lvaER5S052YVoxRGlUTi9vRC8yVXowYmRQcytDN1VnY1N1aDJLdjNB?=
 =?utf-8?B?aE1hRUg1ZFZON2M3Z0dyNzdkVWQvSU5TTWVYM0wyQWUrVFN6d2lmL0FnaXJB?=
 =?utf-8?B?YnlaRXFLall6N0dsaHB2dENya0RYb0lMelBtdmpOK05ORThnSnZSSW92R1Z2?=
 =?utf-8?B?TlkwNDlMZ0k3S3Z3U2lSL2l3dkhiU1BIWTErckdDdzJIRjF4bGQrZ2QzY2Vs?=
 =?utf-8?B?bFhya3E1c04rNjhFM2hQbUVwMnROWmJOSzFIWjZqUGMxam9YTTZZMnBtNzhJ?=
 =?utf-8?B?M2NIcitwRWpFR0l5WnQ3Mmo3TXd0M0lFdGozZ3h4clRBa3d5c2RFK1l6MVVp?=
 =?utf-8?B?WWFhbFNnM0lObmltVnNFWVRKUWdFSUdNK3d0bG9nRG92NUpLeENQV21NVVFz?=
 =?utf-8?B?eVN2RlhXVEttMm9ObGtjUlFWemRXOXN2WTZEdnl6d3cvd1pEMlZHaGMxY0ZR?=
 =?utf-8?B?R1hPbFhVb2xzUHd3NGdrbEZQVWN3Y3lrZzdoTndna0pMQVRyL3FCOTNHMlBl?=
 =?utf-8?B?ZmI0K01uSG5jN2tVZGJlSWp4MzR0MThJUHgxWE5GbVhlTW00L1RTa1RVRm4y?=
 =?utf-8?B?WThKMkd2emV4MENKMTdPZzRKUHZ6cE1KbTJzSXRBelc1NXpONjAzZURiV2Rt?=
 =?utf-8?B?b2FhVHNEMG15d1diZFlybjRrdUFMdjJ6Q0txeVZoMW83MjBRMDJBaHN4VWw3?=
 =?utf-8?B?MmJ6U0IxKzhoL1JQNUxNU2tzdkp6YXlET0ZOeStPYlo2NWRqakZiUVpqd2dP?=
 =?utf-8?B?N2V4TEVidGpEM3l5d3RtYW9tVWVERGowK1VHREU5WEpTdXUraGRHUTJ6S0lQ?=
 =?utf-8?B?U3o0N0ticzY0dHB3VmMyQ3FoSzNidE1mNTdrc0N5SFZtWUp5RVJzQWkwL01V?=
 =?utf-8?B?Q2I0UXQ1M3RDczVFVXBJZzgwc3BORmdGLzlIcHNkYnB2Y2l3ajB6SHo5dkxs?=
 =?utf-8?B?MHRZNk9CSHVOUnplMVNvclliTkdTeXgxOVAwTlpiTHBYbGRFQmxoejk1bERh?=
 =?utf-8?B?UTN6QUpIN1duMFJ4RXRHaGw2bmxXbkowdnZ4K1F1eVRUSzN2dmxXQjNGamlz?=
 =?utf-8?B?WmlIa0tRbEJxb1pKSUExczdMT2Z0ZEFQdi9LdlpDWjFRajM4VEl3Si9BWVdt?=
 =?utf-8?B?YVViRUpKRHEyR2w4and2MzkrQ05rM1hFL210N3ZKRWdUSzQ1eWtQTmRnVFVL?=
 =?utf-8?B?dEh4b2JvcnVHcS9WS3loZjYxVE5OWDdVRjE0RXlKd2lxNlBQZmlVbzR5NUM4?=
 =?utf-8?B?bk9kMGFLbm5QU2wyVjJaYy9HZUtqQVRiczNKS1UrYnF1aG9POXRyeHJiNE5r?=
 =?utf-8?B?cCs1clJOZmk1aTNHc3plMTg2OVhralZKUVEvRFZHVGwyR1RMY25sSnpBTnZm?=
 =?utf-8?B?cUdKK2lYbWVISXRXZGlVQWJoSzVmT0FidTlybTVTaElvZEhrUU5zK09qK2dn?=
 =?utf-8?B?bEhYTHdaT1BzVkJXL3BlbXV6ZVp6enUzS1ppMXJXMllQWGVjS1lRQ1FtaG9F?=
 =?utf-8?Q?q6OkHUi3jipaOykfTxGJFw+93?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vCXVJrPlzNHWUmcOmE7gAI4zK6I6XqV71IeHMj0xurpSSw0KNBoyYfI0bJv8Ame5sykw6KKBx3qh2Czp09EWWiH/JA7McKdX3tp30GUd5ES8uuu+sDihw4WzCcgB5iyUEjowfLw88OExfEp8OKBw+biXr48Ib8W+AtH9yN8pjoOqhK//Aj0OA+9R+SILR36UOYuZ8v742fzyWBy+NBGaH9AnigW7ty+GxuQpraGmFsw/wxcdqw1dezS2kV58kgDRT7fIEEl3+d2XBM2Tou/GWDrnX5iUplDGlw1tIUIP4580ANL7zEoWBV3TlrmRrXDig9Rky5gDaM56aVF+s6oqGN7G9ci2j9wDPZKVBGakWf1aPle/H2xlBv6cxAuy7qrABtXxig0N5WfthPf5WAd5EJUwblPol78Y5RkgruPTHV1V5hKgLg00ducHHe0SlOOuFb/zcPX03hVGPFvDpzbdDT/tMDus/9s/AKfq7wr6cwtjGz0McRWfBl0F2VUH+4FbVdYW0ZTpwKKkaIT+tEDdkqDd65p1BnBS3X2j9Pw+0GLPNaj7tCJ4Hw9uxB+FnFgJfM9jFodcringQjPDdmIdtXRd9ai9WDXHxfHr7JstT9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63129165-4f8a-4e2b-40cd-08dc2743ae6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:44:42.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGMnUfI7n6P740hLMn00wTIVVhPVp/JnBmIxuW9wHoME6WtJSLgkmPo4E1hldcgEOFKdQXCt/ep2rsDgj1GQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_11,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060129
X-Proofpoint-GUID: 1myyke-Cek1EO5mUsaYzQIfvyxfUM6H5
X-Proofpoint-ORIG-GUID: 1myyke-Cek1EO5mUsaYzQIfvyxfUM6H5

On 29/01/2024 06:18, Christoph Hellwig wrote:
> Do you have a git tree with all patches somewhere?
> 

Hi Christoph,

Please let me know if you had a chance to look at this series or what 
your plans are.

BTW, about testing, it would be good to know your thoughts on power-fail 
testing.

I have done much testing for ensuring that writes are properly issued to 
HW with no undesired splitting/merging, etc for normal operation. I have 
also tested crashing the kernel only to see if atomic writes get 
corrupted. This all looks ok.

About PF testing, I have an NVMe M.2 drive, but it supports just 4K 
nawupf. In addition, unfortunately the port on my machine does not allow 
me to power it off, so I need to plug out the power cable to test PF :(

We do also support atomic writes on our SCSI storage servers, but it is 
not practically possible to PF them.

For actual PF testing, I have been using fio in crc64 verify mode with a 
couple of tweaks to support atomic writes.

What I find from limited testing for XFS and bdev atomic writes on that 
NVMe card is that indeed 4K writes are PF-safe, but 16K (this is an 
arbitrary large block size which I chose) is not. But I think all cards 
will be 4K PF safe, even if not declared.

Thanks,
John



