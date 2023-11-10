Return-Path: <linux-fsdevel+bounces-2710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B7F7E7A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B0AB20F41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E11D307;
	Fri, 10 Nov 2023 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2vsan3Cr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X+EyXlTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3136FD8;
	Fri, 10 Nov 2023 08:45:18 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF1A265;
	Fri, 10 Nov 2023 00:45:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZJW5016187;
	Fri, 10 Nov 2023 08:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=C6nMsQI74kuOH+iGeUJauLvQvefNCXdr8wQtN8/EEUk=;
 b=2vsan3Crngr9jkIhwIU85qfekQgIegwSh/jNPM/qFwlQeYyEKcY4AlMd2fqkXefzPXJj
 Tm9decxpIDNOFr9HBHMZWrurgsrzcoyX3pgLtrwq1ri98WAIvw+H5dORq6B58Lspfxcy
 +/kI2B3EyLlmMmd0foweeIQCcF3cnVlUaQ/L6r4LnZVB6qTRlDYk8HNvzeBRCly7Fv8l
 Ia8TIqfR+zNsmeN7dIFhS6w+d7WntSbYSFY03bilO66hJZxqlfYdiHvscx71h2vEiguL
 dsJZZoRlQsr6eGrS4NkXrDyEr3RzLumgLzLU8Bkv4IebvHgiBHexK+jOA9wSwQtsubjr kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26wqv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 08:44:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA76oau004090;
	Fri, 10 Nov 2023 08:44:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w20kw8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 08:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHpwcGF8xS/deKfYFU0vskJ20NlKieCUKa3AJy+5aM0Hnf4ac3/WB3pv0C5L/YutejRjZC/r+i4F89Oqu5M/mxGNx5mRQFWVFRryaJSU8qa243tp8529/lT66gvbnQ3MgO/1jPcqNYZfyVPHz5lnDA38iBIQTA4Ixj6FbtM+NvMLz4PA6zdHWWwhVMpfDBbRqAm8ntP/3M8nScSpzT2XnUB7wN4p+p0ZrKsGYRnxLL7xVM/tD6QUGEynoIRe6Of37PxnBh3lX9saD/Vp8WuW8gg34jqI325Zy4UjkZSzX4APVvzHD22aUIx/t5oMXTQLW34xiZYjxinwvXaxa1+aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6nMsQI74kuOH+iGeUJauLvQvefNCXdr8wQtN8/EEUk=;
 b=BesdPtXNjH/FQYrZsG+v5ww4xuPNwAeDrCh8RaW2G3hzl1eM5JxJtXuNwRt/58v5dmgysUpRpEe2JrxQdmJjjEOCIdtHogE13Krd2g//pZ2nA6GoDiko2Bo3Z6stjCrAfriQI0HLXLTn+QfwgJQFwW56J6Fg9sLU7N6prZYz8KLKq8pARq94ItpchHPpWXdYdk4CCvczK+EvEprk33B50ACCUTuLPR+GotP+wz5ew2nV7mXXZv1/g+3I/wiHZNITpay6esG/tvKt+OIYksQ11fQ2T3x5hO5OjiUocHdg8BurNiKDS57Jnms0VKdr82Xgs/c0q5gNKgDPNFqqTCQewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6nMsQI74kuOH+iGeUJauLvQvefNCXdr8wQtN8/EEUk=;
 b=X+EyXlTRFL68HHyP8er9b34Gyv97No0G2v90mP2nUjVAG3Nib+Cy33RR/CqIVOprKgxZLppTBfGkgoxnfUH98sYkdbe51/j7Y4ptaKLXUSwZRsqdWTFU3BbJbonTrpOKaAE6i6Tzl9WHL0Gh4zYwM//6LrrUt8SleNuW51N98GY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6226.namprd10.prod.outlook.com (2603:10b6:510:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 08:44:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 08:44:51 +0000
Message-ID: <6801e4f2-4026-255c-0a43-a9decf73b200@oracle.com>
Date: Fri, 10 Nov 2023 08:44:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-22-john.g.garry@oracle.com>
 <20231109153603.GA2188@lst.de> <ZUz98KriiLsM8oQd@casper.infradead.org>
 <20231109154619.GA3491@lst.de>
 <61b25fe8-22ae-c299-3225-ca835b337d41@oracle.com>
 <20231110062944.GC26516@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231110062944.GC26516@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0133.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a91618d-7be4-431f-c8dc-08dbe1c94d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e0RudUu148UYqeeQcpf9/UiNcl9JmK5i9eSkds+BRJlbfbBO5mWrD3Yn/Xp66GagShzprHLqabWKj7kujEJ0TpdcPyZ9f+hhteAvTxLuVfhkA7MENTVXjI8TXvieCSucTnrbeGbiwJR4ROgjR/aA876tSoHdsP+Oqr9fJ5bDz3HeS8H9guR8y12SmgS1uwgHLZEptUx8atkbIxHCid31OCyPYi3wyLGCsAYwY9P9XugPpGD7i5rE5gz9QmmqMauLM5fVaiHvfcPJ7FmJ/2LlJ6Skojv5r6yvyWRGOkdP2LG/+yA76XvPH7MTFZgs6usRJnJsQw3QzblWkpXPk2t41dG5d4o20aYeDnqYZcKY0BMJ+x/VD+u5AWJHlvfHkVk3ISH8EDIXKdowHh0uYNhvXVf9t+rZzycFNtp9NmaYJTdP8UhA4aWt5GGX5kGyFp8I7yeR8UcdOxr9uEW1QYNi2Ygx2PF/5RQM+HDGFBvstvNcJYvI1DBcmwo4GxUt9lF4pzWoiAMe/RTBi3oFx5rc4qq47VcLxbu/vbYD6nt1n2J/xrUzIy1bPwR9aEmI4sshbguJ6p7ILhUhLwH/N+Jcql/ubJfEzGMR5zGtmF+Ysp2UC/Rd8cqqGc6mw4IONxQvitLvGcPjhu5Gn6YJu5IkDA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(36916002)(53546011)(5660300002)(478600001)(2616005)(6486002)(6666004)(83380400001)(26005)(2906002)(4744005)(66556008)(8936002)(66946007)(41300700001)(66476007)(7416002)(6916009)(4326008)(8676002)(54906003)(38100700002)(6506007)(36756003)(31696002)(86362001)(6512007)(107886003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aVpmNFgzRCtqRXBlMGhlMFNHbVBwRVMvdFVsY053ZFlFaUZ3bk5GMVdmYUZP?=
 =?utf-8?B?WGFKcmptMXJyL2Q2RUlvZDhZbmRjZ0NhZS81UnN4R3dqeWhXRE1yYUF2MEQ0?=
 =?utf-8?B?aWJ6U1dMRElnWVBjNFFpSFdicHZ6cHBkYURQWW1SRlhYSHo3Q29kSDhFK21p?=
 =?utf-8?B?S2JmR2tTaGVzeEtTUnJpNFh3czJUdDdxTXhjQkhDVlYxc2MrWlFrNHVVK09h?=
 =?utf-8?B?Ly9kbmhnc0VsRXRaamNWVEtvRm44VGJNRm1sa0xGeDQvdVRIUDZYcDg3ZFBr?=
 =?utf-8?B?VUJkSUhsd0x6V1Q2RnhoZFp0RXBEYVJ5ZWhhak5xZmc4L0lzZ2ZyU2c1czU0?=
 =?utf-8?B?dEdBeS9EV0xJNWVSR25abEJrTXFUSXRmaWVtU3ZQOEtwVW5saDJEUENENUha?=
 =?utf-8?B?ODg4V3J5VXRpdVpKUU1MNTJKck9qa2J1aUE5VXVGbnRnRkV2K0ZWNW9GbVoz?=
 =?utf-8?B?cE5OdlFHUmxFZExaRnBWdkZuMTJGWUpIbHVVbU9BMURLNm95K2VXUzhjQWxS?=
 =?utf-8?B?N0JyeWE0d203QkVrTmR2N3J3RUcxWU80ZmFOUVFZUlZReFZpQmZUT2dxZlYx?=
 =?utf-8?B?NGY2enpJNHpUU1M5NGxaUFB6N05YazdEMEdyY2oxbmV2dXlwOW84akJ1c2Q2?=
 =?utf-8?B?L09meHlOeUM4elRiQ3JrdDJLQkJGQ01heXpPUTMwSTF1YS9kcmFpWXpIM2Nt?=
 =?utf-8?B?VUFjREhLSlVuYzd4NW5JYXpuYm95WS81Z0F4dFZ0RDdZb3drQW5MVHdxMHZG?=
 =?utf-8?B?ZVI5U3JlTFdrd1J1OS9YUktWTGNBbjE3NHNPWG96MjI3ZGZrVWp3WmV3OUtP?=
 =?utf-8?B?eXpMVnlyMFpLMkxEY29URXdJYmF4UW5QcDhZUXN1KzRLV2VMd2JJUlYrL1Rl?=
 =?utf-8?B?S2srTzI3NTdXd1JUU0JFTVZzM3Uya1JLcHB0VDVvZUJZUDNjSlo2RVRUelR2?=
 =?utf-8?B?K1lYb21TWWtwOHlqcXk4NXlrYzNnK1loUzJIMUJRNDd6MDFYVjY1eWJJVTY2?=
 =?utf-8?B?dXFkbXIwcS9ITjN4S2tmZit5NFR1S25iVFpNcEpOUFRhRFI2NlAxM1gzK2xj?=
 =?utf-8?B?TkhXeEY4Vjl4Yi9paHVyYzJHOUN1UnBnS0JDK25vTml2ZzlsUUJ4bmprbVF1?=
 =?utf-8?B?NmxGK3p5eERSVVNsMmhnK2ZmUGlvdm5hUmZiT1NGcFhBeFhHZXJxcDRMcEJH?=
 =?utf-8?B?WFdCK2Nnc2RjWGllR3FwL1BScFRiRWNvcUk1amVkWENxa2wwUDJ0bUthTzJB?=
 =?utf-8?B?M0o5RWVCc3A2WmR4b0MvZXF4MzJveXE1c3Y2UnlQc01qeTUzTmdEbFlERGJw?=
 =?utf-8?B?dEg2MTlFL05IRktpWEdWeEZXd1FnRWVwUCt6VS9QUFdVWHA3STFjNUpvdFJI?=
 =?utf-8?B?ZFA1ZlUrT0ZGa3I4R2toR2lOYkJ3SnpYa3RjdUpwbmtlODZDZm5NamV2QWxB?=
 =?utf-8?B?VU1OTkpIdnM0QUF3TUhrSG92NDVkR2MvbjBjOXFUK2Fxb2lQN3dtNG5yZDBl?=
 =?utf-8?B?QXJYTXdNdXhHMXF4UHBXY2htK3pCemp5dXQySVltejdTWU4wd0NvTWkvT2lF?=
 =?utf-8?B?aU0vd2RDME4wRlNJVEgra2MreXlOQk4wV2pJa0IwSVFmZ3RUV3ZiYnpSSEps?=
 =?utf-8?B?a3FyMWdndHBXU1kyTE42bWNXWnFCUlBuL1crU1IyZVppb0VHSXpaQnNtL2Qx?=
 =?utf-8?B?M2dmSVFqcUdLY0VuZDhjM3Q1YitaamNFSUs5RUFZdHNPZkNvbVZtZk5TUUll?=
 =?utf-8?B?dWpCUDN6anlxV1VhT2VJajFnMmRoNnVoWkxLRVJHY0RMUi9QbHUvc3Y3VmdB?=
 =?utf-8?B?d0xDdHJaYTJUSUVkSHQ2VjBKV1MxWVRrM3JTcGtWWHZwdEFsdE91dTRBSTk5?=
 =?utf-8?B?MnNWb2hHVFZZY09Jall6ZUczQnJneVg1TnE4QXF1Y0ZWZkNuVXBOVjJtRGkv?=
 =?utf-8?B?c1dTdksyM1hSelRJMXcwNkkvblpTWlRRVi9yWFI4amgwNzRBSFVIcHlPVGdv?=
 =?utf-8?B?N1VtSzJMUlhXUHEyNjFvREJvZnIwTVdYbmRQTGsyd054VDVWTjlBejJjS0RR?=
 =?utf-8?B?SThQUHk5UXNnRzlpdzdGUm5mVTNpWUVJMGUrQzcvSi8xdlY0SDJYalJXWWF4?=
 =?utf-8?Q?m97BJJHy1vEBGWkDHlAqFLTok?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?ZHZ4MHBEMGFGVFNwUWRzMVBjME5EWkRIYmFzRmFVekxub2VCQ2VFRHp4cVkz?=
 =?utf-8?B?QWtXaWhoVVYxRUVvemIxWUxER3F0bFFrc2NPelNOY3BhYWpOSFh4UEVXdE11?=
 =?utf-8?B?cjZVMDB0Uk9iNE9BcWd5QWk1WlAvcSs3Y1diS1FwSGczbWh5RzhSSlNITWlU?=
 =?utf-8?B?N213MmQxSk5oeGlJMU1yQzRDWUFxZXREQmFvMUNnM1Z1Ymk1eHFVMEFsN0pL?=
 =?utf-8?B?VWJkbnJ2NDdIWVJyU3FYbDd0aGpENVlsWGlPbERwaHI0UTNlNVYycGZmRGc5?=
 =?utf-8?B?SGVnQURuR3hhd2FUeHd0NUpqQzZGekpacGhOK1NFc29ncVJJYmVZQURjL3Jy?=
 =?utf-8?B?Vjc0bmphc092Nll4UWJSMmdBeXFuZllCbUFLaUNDeUdLaTFRN051OThlZDlh?=
 =?utf-8?B?Z1NDa2hLTnQvZjUxRXRVblFWOUxBWTZJakFqaEZ3K2FMaEVFQjZ2ekRRSmtY?=
 =?utf-8?B?MFV5SGVCd29hNjVSSE1GL1E1MUlxWWgxc1JhN1RyMEN1elNCbWVyK2o3UVR1?=
 =?utf-8?B?elpyTGo3VDVFNy9NbWYzaFd0NUduK1E3aFYrd2NrSWcvcHlka1g0THlUYjhy?=
 =?utf-8?B?SWwxQ0ZSU1VSVkJqOENoRWMrZTc1K3RMOTNyS0x2NGRSRDZjU0c4Tk9MNUJZ?=
 =?utf-8?B?MHBxcTBIZEJtamNObjl2dno3TVJqL2FIbHpVRE9iSStlYlV1UW9iMHpCTnZQ?=
 =?utf-8?B?YkhiS3Q0WGdYc3ZVUE9NOVJOWUZ2dFdHS2h3TTNxbEo2VlRsSEhJYmxVZGl3?=
 =?utf-8?B?dmYrazlMOGdEbUJTUXFyNmxHdG1kSjlJeWZvZFZweDd2QkpvZ09OcGVSdGpv?=
 =?utf-8?B?cjJJWGo1Rnp6cHl2ckl4Wlp4a25DeGdlNnREZ1dMbmZjaXVHRHUydzdNdG9k?=
 =?utf-8?B?RWNUY2FxeU9xN0xhS01hY09ZYSs3b3ZvZU9XUlN5a1hNZEl2L3A2RWJIZXAz?=
 =?utf-8?B?akxVYWI2VmJMR1pFdFJSOTFvbThuWkE2MmN0V3YxWEdGem41VUpkR21uOTlt?=
 =?utf-8?B?dlloVE1sVzRHUk8wUUQ1N3ZrOFZBdUxKS2dyMzUxazJ5Y0xiUmdYRy85U0hq?=
 =?utf-8?B?d2dNWlg5MGE3MkgwTW1lcXFHTXFoV2toSmh3U3RFbEZRZnhkYkVHSEQyUVVo?=
 =?utf-8?B?WHEwemRPeUo3UCsrUnFVelZubnI4aGVkalhyeXltR2RtSGZYVXA2VDUzVitQ?=
 =?utf-8?B?c1Z0bjFDRVlnRkhzNnZFWTBIZGtmczlOdlg0WW5rMFZKU3c4Q0swQ1YvbnU0?=
 =?utf-8?B?Sy9MNUhGNlRNS1JvZFNPQkR4U3pBbzRGY3ZuMzBNYWZlREVyeksrS1BubGcz?=
 =?utf-8?B?SVM0RkpreW5DK3JhNTBVYUlHQyswNFM4N2dENzArRlhjSkl6dGJhbC9sM3hh?=
 =?utf-8?B?RWlQRFA5SUh1THlyWjZYM2NpdEFhTU5oZ1BkU1J1bS9pZDFiemh2NFgvK3U1?=
 =?utf-8?B?NW1KcGQ4dXBjQVFZNHRyazcrZ2Irb2QrQmw1bWlyS3JDUS9nU0htOVJkaFNx?=
 =?utf-8?Q?CbYqXymvObc0ePldjVLDfJV6ReL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a91618d-7be4-431f-c8dc-08dbe1c94d97
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 08:44:51.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnxioWIhvLGU7/sizUH8RwmPhAdHSmk03310qvcP62bTA7mg2SEt1S9LLy3fvx44XuFmBYlpjWeSf+yJ3yrRgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=852 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100073
X-Proofpoint-GUID: Gmvv2WTGR8HC9hJX3LYFaVeeCqblXb3J
X-Proofpoint-ORIG-GUID: Gmvv2WTGR8HC9hJX3LYFaVeeCqblXb3J

On 10/11/2023 06:29, Christoph Hellwig wrote:
> Yes.
> 
>> As for splitting, it is not permitted for atomic writes and only a single
>> bio is permitted to be created per write. Are more integrity checks
>> required?
> I'm more worried about the problem where we accidentally add a split.
> The whole bio merge/split path is convoluted and we had plenty of
> bugs in the past by not looking at all the correct flags or opcodes.

Yes, this is always a concern.

Some thoughts on things which could be done:
- For no merging, ensure request length is a power-of-2 when enqueuing 
to block driver. This is simple but not watertight.
- Create a per-bio checksum when the bio is created for the atomic write 
and ensure integrity when queuing to the block driver
- a new block layer datapath which ensures no merging or splitting, but 
this seems a bit OTT

BTW, on topic of splitting, that NVMe virt boundary is a pain and I hope 
that we could ignore/avoid it for atomic writes.

Thanks,
John

