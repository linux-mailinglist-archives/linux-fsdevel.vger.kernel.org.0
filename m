Return-Path: <linux-fsdevel+bounces-5155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FB5808ABA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CF91F20623
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E744367
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fb6CnTdf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="thc5X8wG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9938211F;
	Thu,  7 Dec 2023 04:43:43 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7CIBTt002956;
	Thu, 7 Dec 2023 12:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hqcYnu0YZQwF3cLdau4ojXv9XYnINgzb54kI2ALZTGY=;
 b=Fb6CnTdfOxDSxofPQMwXviz+8SgwMK/43La31iTtp9uYsYoQn4F1R3DYRywdy8ikR8UM
 7kv+GI79Y/vmZlkzF7j2N2RfbHwM00fznNt3gArtHmtsjb6V0H4GjM07dCM/LV40JXXw
 iqlKwav4Jqm2Q0eqREMyuyY+PldU9u4jILtmDMAoOjJHn3ifcljOKLW4y08/7stqX0vM
 RLL1eW647ElhXGrqOYooCGUMFTMV0e3MtN29gB8JHnB975EqXoB0erOxIbslLPRCzFAn
 50JNtpNBJ3mnxxBan13WYhYzpDQmQHykMMBydlZiyX5hTMoPcVtLmuFyDKQs4ZrYyE0t oQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvkqp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 12:43:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7BK54N039577;
	Thu, 7 Dec 2023 12:43:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan7cydu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Dec 2023 12:43:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBJYjowVCaRtJjWGPRulQ4yDg1pG+CaS8Jt7QnRJ5/21xjVQbtXs5k3do2iSf86Pzrz9ydV0MDx7Upb5HrNMEjMgGDkhsYWBd65GYBpo6PMNv0kmSTkumOuRJ8qiuJJqJ1VZVWPnEXEMQGKHS20G5TEDV5Yz/Ok6DFBweWVqCnuinRTJ+2XrSQduof+0iieVlGEuUza4F7K3c0UhCKy5/4+nvC6jCmwnFKkBCy/6LboomOh22p4LGxfxc36zg2Wqlao4GqT6bdO3OZzi52DnLvE71FCJ3Sh/uBUvIIgRSBGWBo8n2aV3Z0OmN4WizIkZqp1j/FmJjtAhs3K4zWz/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqcYnu0YZQwF3cLdau4ojXv9XYnINgzb54kI2ALZTGY=;
 b=bMXqg+KRXwHkyqLapDf3Fj0tuUix6MDNZvTaP65kIhxyR/GnQrODOqR2H3ubHbGSf5RJD1zXvFbCHD9mvfHrjP+5KQ55ufvdh7Gxdd1AYjiL/QN8Zi96OtZAT71WEclnj3/jiSRVzBoVieRqUf4dQSC2AEkz6DjckXJ9jfJF64HvskLNFe7+WSWdk8c+s1OYbXoxFGyu4n0qHni8a0p+g2QAPFQ2RlBewRD3NQmhCMOi1+5Vb7D34tNd9/CQ+x0zJwVRbZBiXgSSXiPw9ZgB2y6QHReAJmlbegxerqI1gNVHEsu+1ouuarHoVmE26BK+AVqwER4yJxGCZZvf6dNIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqcYnu0YZQwF3cLdau4ojXv9XYnINgzb54kI2ALZTGY=;
 b=thc5X8wGqAHCsGpBnP6RyslC9t14eEk+0CQ2ewtDr3cnlEc4imMGicGYLm+r0JjrBfRzVJruuwsXDIFgg1LQ7VK+qwqFtQcbjFsY0e5FNcapG6Mv7gs0xd4Y8dBA/sdLkhluOiDTSOU/xrVKQfO4I6y3gAPj5mL1DEJ36fQQLbs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5097.namprd10.prod.outlook.com (2603:10b6:610:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 12:43:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 12:43:16 +0000
Message-ID: <fe6a98a8-5f53-47d4-8ae3-08e47dd383c2@oracle.com>
Date: Thu, 7 Dec 2023 12:43:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
To: Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
 <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
 <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>
 <ZWpZJicSjW2XqMmp@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZWpZJicSjW2XqMmp@dread.disaster.area>
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
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: cc51c643-07f5-4f26-17a9-08dbf7221557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uNqOW4CGUbmnsGkmDhwbew+pE0SzCfhNDHlAxxwF2IHyGzJiw600vEtTGW5cKaLBFd3l55NqvKCmPnKTohiB1nbfh3OQemM1FLg04589AwMGG1ZpXUQXOYFRRr7QdwQuUR6zhA0W/Lts50sokPzWOuHvA/U1cQXNbTTEyZCRyN+WyaPgNTprN8UKtlY34URxnJ97R+/8vx0XpfqEJDJFy498IY6G8PPBmYNTxUDNojlzBv1i5ZbzakaiEQ4Y5eGVtK8p2rl7MLWhI8vDBaXJEAZOym78WrGGzpgh2Hx/bagOirraH46uMjxtQ8cSpssHyoCYRR27x6yFWtyjODJpwmm1yVwNthhmxR5VEqg6VDPTCLMFIFzFBJDjLOJGXVB0Yr3GlcSUqGLtBWnQHffPVI2seQr8ASPZ698xvhXyOI7MTxPdJKGgrmnPdSiDlpojDYgjNUFCThq2cQ09+g5DkPo99qiLgW80vam0PEPFteG7DIUf6vcCJ4eKK+/fCugnUUy0Fw2qO1P6wYg8CsN/ny/qlnravKpTXN6XIFxpVgRljib799BSqSyAVShW6C1LZXzkXxXqXiGbr8938wN8UjoYD2swT4ENHO4UrsZapZZoGCDBupg0oQswtZtRGaq2M3Jkp7k55usXTR9bXuGa6A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(7416002)(5660300002)(2906002)(4326008)(8936002)(83380400001)(38100700002)(8676002)(6506007)(53546011)(36756003)(36916002)(54906003)(316002)(478600001)(6666004)(6512007)(86362001)(41300700001)(31696002)(2616005)(66556008)(6916009)(66476007)(26005)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SW8yVmVOV3hKKzRxTFc0MEhnN3VFQURiVlVKWExGVWFSd2dBRERTRkxXMkxF?=
 =?utf-8?B?U3RkOGF5MnZrMGV1TTM0NEZEMGVId3JLaGVOd3JSaUJiZTI4d3NFSWVuamta?=
 =?utf-8?B?T2tRbHZmUWdabHpEazZ5RFUxOXh4Mkk3L1V4R3RZUk1QQnl0akpPV1B2VTh5?=
 =?utf-8?B?eDZTRDFoQ3VYcmFhUG44VjJxME5YNk4veFVaNnY1RUVwWlNDalpxUEdGODFF?=
 =?utf-8?B?MnY4YVkxQU5rSDN2VlJ2Nkl2UHMwY0dSNVpNNUtoTFlueXZ5RWVVcGRMeUdi?=
 =?utf-8?B?NmF5RWJhOTZ3Sk83NStSS25kaDQ3ck0wZlRYaEgzUzQrbXZ6eU9MWjB6Y3BZ?=
 =?utf-8?B?MXU1cnB5aC9GeGZCM0ptNlhlMEtxdlo0SjVMeCttYWhTUWFZTGQxMFI5c1FE?=
 =?utf-8?B?Sk9WeldOY3dZMytEbnBXQXZiOVN3SFhGblJvajdGSVQzdkdiNWZKVm9QM1l6?=
 =?utf-8?B?VG9jNy92bVE4eUZwSkl4d3MrRDlRVDZ3Y2ZxTlRuS0ZKREp3MzlZZWlaUU03?=
 =?utf-8?B?VHdXb0RuR3k4cy9UL0dzSjNEUkVjMXFnS0xBNElycnRVeVN6ajQySEh1RkhM?=
 =?utf-8?B?ZWMzeGJvR1NwV1EvTVZUSGZCcHJCOFhzSWljTXhid3Y1alVQVFZicFNmR1dZ?=
 =?utf-8?B?dTZSME02WDVaUVo4cGtQOGRmRXUrYWZIZk9qenIzRlQ4NnB6cS9zTWtZVndY?=
 =?utf-8?B?SGRuU3lobFI1dXNVMUZOTHdiUFh3Z0hyRHZqeEFtbmtrVnZyUnMyL29CQlo3?=
 =?utf-8?B?b3FpaUg3NzdYZ3R3ZS9hVkRoc2c3Qkd5cTdDSWJodm9WNU4xYit6RllQb2tT?=
 =?utf-8?B?L291MmJFRitXaUh3OFFnU0dmMHl5RHFraURGYmlZMjRhRVhEQk9OUHRhQW1I?=
 =?utf-8?B?bSsyM0kzSXlCMmRMcjBZOHZMUFFlWCtENXdTUVFVTStQeUVjZzg3STBlZnhu?=
 =?utf-8?B?VmFWTlFIVm1qc2JnUmdVQ205azl4dnI3Ky9DVFhHaGhiY3B0SlNrMGpEeWFo?=
 =?utf-8?B?L2NRNmsvSjI0dml2YlBrcFhxNFFDUGFvcXZMRWtKUkdZNFBVbmdXdFIrK01R?=
 =?utf-8?B?TDJQK2llSkFoTmM4QnBxbGV2VzM3dDlTallscGk0U3BZcFR6d3dLZnErbmd5?=
 =?utf-8?B?MlovWDBNVGJEdHhFcGJBNnRudjM1dURGaUh3RGwwc01VRG1RTXdGSmI0QXUx?=
 =?utf-8?B?aFRIQi9lQzFyckpsWEVPZm5tZlNyZjNCeW40RFdHRnoycnFTeTRLem1tMEdm?=
 =?utf-8?B?WndxUFIrK05NZGp4NkVHYVRFa3AvREN6N042ZVZaeWNiM1d0UHBnbHNTQ2l5?=
 =?utf-8?B?LzFWZWVJdXBtNml3YWFKWWV6SkVCQkQyOU9WTTZoeGExSi82WVlUMUMwb2RG?=
 =?utf-8?B?SXNQRkhzbVhXWG5RMDZZemJQUjZuWFhuVEIzYjNBSU9odUsvcTAzdzA0Yk1H?=
 =?utf-8?B?Y3E3amFGcXlvOHRRdXd5aGxiaFRsYnVOa3RQamhLTWg2eWMwZTRZZVkwdEdM?=
 =?utf-8?B?UDNVL2F3WlgvNmdON0dXWjY3anNTeXZVcTM2K1lHU0RVekJpdHRhMTZINUF5?=
 =?utf-8?B?TnFBWWJLTDBFMVlsckltd1NzNHRueFNaZ0NpbzNyaXVsMXRFWnV6MHhRYnhx?=
 =?utf-8?B?WWlMVWZlQmhSSm1aTFlHMlNocGx2SGVDQ1J6RGsreDNNOUh1TWRqYWtDMzBj?=
 =?utf-8?B?TXh3YjlUQVNpRnFiR1RtTDFsVEtUUDFRdWJqakhTUFNITUlRTENEbmxDKy8r?=
 =?utf-8?B?Q1RXd3BpQThHV3FEVkVCVGhHWjVjem02MEZmdnI3enVITkg3NDhMVkR6a3g3?=
 =?utf-8?B?emd3ajlWOGs0cnhXMDRPVXZBTXdRaUt6NUlteGpYRTNVcm15OHVuNGY4Zjh0?=
 =?utf-8?B?b3hJTllUN3dRMjFHVXFmbjNjSlhwYXAyb2pFS0czZlFqZTUxQkIwbEdkNVpT?=
 =?utf-8?B?b3BvdkluS3JsZ1FvTmhIdGVISFR2SG9Gd3NKdXNUanV6ZGN1d3ByUUtzS2l5?=
 =?utf-8?B?UWxzQkFmNXBSQ1pUdEpDcENWTzVQMEVkNEV5eTd3a1NwNXJZd3Z0anhPd1pk?=
 =?utf-8?B?LzEvUWlxRlZ6MEh6dHVMbzZ4Yk1udVdmZ3dVNHFwZm9uNmVvNUpDUWFsOGhp?=
 =?utf-8?Q?7qsjnNyRYoe6qqz10VMgPHtrH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?K1RlSDh5SlEzeEhYT2NrRGNjMDUybytySU5EZjVRR0tRVlFReERaKzFNT29W?=
 =?utf-8?B?Q1hpTmRSUE9HV0lPaWhyNm96UytRck5zbnBEUVBQMkkyUHNaaTgrdW1EUG1u?=
 =?utf-8?B?NnhtV0FQWE5QYXErN0NOS0RPV3NGSVZUM3dtWlVYaUlaWUxSNzY3V2czbFVZ?=
 =?utf-8?B?OU5DMGRmT2tYYVRLd3ZIU0loVW9rM1NzZlM1NnFwUXgvbklhRkl1STlMSm05?=
 =?utf-8?B?bmpiMG40bTBLRGNkcUhhcTZ1d0JWaENVVGNEVitmM28rS29iSlJiWlJxSU1x?=
 =?utf-8?B?elJjSytIY29FRWVNWjlNbzlWQnVkTWk0d3lMQzRidnJqWURMUWorZjA5bkNL?=
 =?utf-8?B?b0xndlBoMGlPdU50SkhXVHhOdEMxNUxpV21YcHZJRTFzc1ZsUjBjOUduMkd5?=
 =?utf-8?B?b1NZc1QwRHg2ZTdoRDd0MndyQW1DeU5HczhaZ1NMZittb2xiKzlkcFoyMkxl?=
 =?utf-8?B?OElWRVZkSHRwK0hLUDVmSmp2Qk8vbUhMYWNlTS9nQWFpTC83N1dOWFhhU0Y3?=
 =?utf-8?B?RkRsZjVNVkNXYW9ZWXBxcTAzNEc3TU5jYmZtSEFMYWhaY0RSOVdRblVMd3Vk?=
 =?utf-8?B?NTV3MzZNWnQxOVJieFpzWEtEU2puK08wdzZZNFhZYWgyU3doVWlJKzh5RVYv?=
 =?utf-8?B?SkZCYXVPREozaHNqbXhqRXdyMU1HcFVkQlVPa1NqRXhDSERtT05wV3MxakRB?=
 =?utf-8?B?ZlREYXp4c2l0T1ovUGlZZkJsODQ4SjN2RTZVL3Brb29jRDZnMTdWTURDUFN6?=
 =?utf-8?B?WkxScklrd28vMHRLT0JadGpzUFZhOUpULzNFUER1UytnL1ZwSzVxL1hIV0xX?=
 =?utf-8?B?SHVHcmhtR2NIOHdPZXo2RWdheXNVNWhRYTBXT0JDSHdGVUJVSjVCOUREV2pp?=
 =?utf-8?B?NnRFaXpYTkU3YzdjY0h6dEdCSmd3N2VZaDJpajN4ZmJoSjNiU0V2aHhyMk56?=
 =?utf-8?B?NW42ampiY1MzVjg3UHRraWVKQ1IwM0I3OHRQYklreVZRNTI2TUcxM3Q4WnNV?=
 =?utf-8?B?ZXcrUUtMZm02Tm5lZEtac29XMFlNSkJQUm9sM2pQejBTaHhibkFyaGtGa2Vv?=
 =?utf-8?B?T3ZCMmZKbVJ3Zjd5YUNtSHlMWHEyMWloNkVwUjlBUHBMQ1pPRUdlQjZwei96?=
 =?utf-8?B?L0ZZZkw0aVVrdWdvQW0vRmNzUld3VEJaMkhCL1d4NlNqTDZ5YkVxbFUrbWxZ?=
 =?utf-8?B?ZnlHR0VkZW1MU0Q3b2tKcC9IL0d2b1ZieHZSeTI3c0ZaN0dXeWNRSlhPYXpG?=
 =?utf-8?Q?AJWEtHcnnvfcyKW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc51c643-07f5-4f26-17a9-08dbf7221557
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 12:43:16.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWo3nBU5QP6tezFyrYDxi5DE6jaGC2hgpXPa9nxJL2PTjGac2FeU1sjCF/o+yzI19CKurx8GtuxxMkl8nreFVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070104
X-Proofpoint-GUID: Qzwe3sJ9Cfv9dhocsmpohaUUNG9TDh4B
X-Proofpoint-ORIG-GUID: Qzwe3sJ9Cfv9dhocsmpohaUUNG9TDh4B

On 01/12/2023 22:07, Dave Chinner wrote:
> RWF_ATOMIC is no different to RWF_NOWAIT. The API doesn't decide
> what can be supported - the filesystems themselves decide what part
> of the API they can support and implement those pieces.
> 
> TO go back to RWF_NOWAIT, for a long time we (XFS) only supported
> RWF_NOWAIT on DIO, and buffered reads and writes were given
> -EOPNOTSUPP by the filesystem. Then other filesystems started
> supporting DIO with RWF_NOWAIT. Then buffered read support was added
> to the page cache and XFS, and as other filesystems were converted
> they removed the RWF_NOWAIT exclusion check from their read IO
> paths.
> 
> We are now in the same place with buffered write support for
> RWF_NOWAIT. XFS, the page cache and iomap allow buffered writes w/
> RWF_NOWAIT, but ext4, btrfs and f2fs still all return -EOPNOTSUPP
> because they don't support non-blocking buffered writes yet.
> 
> This is the same model we should be applying with RWF_ATOMIC - we
> know that over time we'll be able to expand support for atomic
> writes across both direct and buffered IO, so we should not be
> restricting the API or infrastructure to only allow RWF_ATOMIC w/
> DIO. Just have the filesystems reject RWF_ATOMIC w/ -EOPNOTSUPP if
> they don't support it, and for those that do it is conditional on
> whther the filesystem supports it for the given type of IO being
> done.
> 
> Seriously - an application can easily probe for RWF_ATOMIC support
> without needing information to be directly exposed in statx() - just
> open a O_TMPFILE, issue the type of RWF_ATOMIC IO you require to be
> supported, and if it returns -EOPNOTSUPP then it you can't use
> RWF_ATOMIC optimisations in the application....

Hi Dave,

For rejecting RWF_ATOMIC when not supported for a file, how about 
something like this:

--->8----

diff --git a/block/fops.c b/block/fops.c
index 273bd8f5a370..d9563ef29dde 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -639,6 +637,9 @@ static int blkdev_open(struct inode *inode, struct 
file *filp)
  	if (IS_ERR(handle))
  		return PTR_ERR(handle);

+	if (queue_atomic_write_unit_max_bytes(bdev_get_queue(handle->bdev)))
+		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
  	if (bdev_nowait(handle->bdev))
  		filp->f_mode |= FMODE_NOWAIT;

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4256ec184461..d725c194243c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -185,6 +185,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, 
loff_t offset,
  /* File supports async nowait buffered writes */
  #define FMODE_BUF_WASYNC	((__force fmode_t)0x80000000)

+/* File supports atomic writes */
+#define FMODE_CAN_ATOMIC_WRITE	((__force fmode_t)0x100000000)
+
  /*
   * Attribute flags.  These should be or-ed together to figure out what
   * has been changed!
@@ -3266,6 +3269,10 @@ static inline int kiocb_set_rw_flags(struct kiocb 
*ki, rwf_t flags)
  			return -EOPNOTSUPP;
  		kiocb_flags |= IOCB_NOIO;
  	}
+	if (flags & RWF_ATOMIC) {
+		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
+			return -EOPNOTSUPP;
+	}
  	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
  	if (flags & RWF_SYNC)
  		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/linux/types.h b/include/linux/types.h
index 253168bb3fe1..49c754fde1d6 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -153,7 +153,7 @@ typedef u32 dma_addr_t;

  typedef unsigned int __bitwise gfp_t;
  typedef unsigned int __bitwise slab_flags_t;
-typedef unsigned int __bitwise fmode_t;
+typedef unsigned long __bitwise fmode_t;

  #ifdef CONFIG_PHYS_ADDR_T_64BIT
  typedef u64 phys_addr_t;


----8<------

My concern is that we need to increase fmode_t in size as all available 
32 bits are used up.

Thanks,
John

