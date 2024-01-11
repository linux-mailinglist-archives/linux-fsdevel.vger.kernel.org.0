Return-Path: <linux-fsdevel+bounces-7802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90282B283
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 17:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C171F25225
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDD4F8A2;
	Thu, 11 Jan 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Twzddbih";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XS4aKgkv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A015EBE;
	Thu, 11 Jan 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BG7TwW027131;
	Thu, 11 Jan 2024 16:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RsTtolez5NfOpxlYyXDYFTxNBSDAZvQHIsCsjntxnEY=;
 b=TwzddbihyWw88ZTyOjAL3Wv9CE08PpZO1efhu13i5nMbNAtvkYaCwJWc4ux4WT13aWdt
 9WpC+Ag685vJtSBVmwL74hAZTbJw+5UOa5+3Zi1lq07CbJdUE1/Uu7P0+rb7scBv4DeG
 akLCYxTIENWNddkACl91VLm+jjER7AcdJ5OvAe6zKj6ZMPH3qz0MQkYhnsV1lLY7Upew
 F3hanqxs6jn4XtqxlOUMuufImrHrYpg07PH7Lf/9IDkLQHxGuWGOcT26vOe8sVyYMdlX
 kLLcNDFZ5YMcBQPLF6fkhKj5MxZK34lNfehmdlZuBCpLmkT2w0JL7bEVJeiatWUI0nWZ bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjkjt00h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 16:11:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40BFfWMd035095;
	Thu, 11 Jan 2024 16:11:47 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfuu7vaf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 16:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig9r5pBDG+ip0YwLc7DIFki5u1ph02q2i9/nuvI0fPglWrhDNuudzMEf9tpzKO/R2jJDi6dYRqaMXM+QQtEAAbTGqq7iSGp06J/2LA4+lz9G7j4o5+CYq3QpUsRTunM6uKnRrhvP/fTKDxLwglhES7uDgbMp5FrZzl+xjHQlHgkdAGzMkIsWFz0Cx9F4O8qp6h8aIFTAoq11swg+1+ScUJ5ZJuA7JqttslO+59jQm+jaQ3k5YtfInlvEu66SMKuKSlB1Z2VhDK2cJ5oXFffXWJJ4pcGDNjDNUfVCjMUsTgpPpVx+GK1QLDyTg3JG7jsf6dLuUuM0xbUgXXrFEhv/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsTtolez5NfOpxlYyXDYFTxNBSDAZvQHIsCsjntxnEY=;
 b=X3kbSAPgfOcLh7QZCa3kgO9iDJTtqVwxTjBtZKsqqngk5+kx/vgOQVY78J2eUfQusz6SYW4n4ZVa2RjVe0owcnzPQy4F1BqoRr20FIHLx6RuKFmu5d3gqqtaY8RuZ+gMtbOJRgEp+hdxZeilc6XGqWr1iXssDUYIGROGId9dmvQDYTJvSMealB8EVA0bWgLS3tcKloWZd9O0WVagPt1EVEZsGZ0Fflpjk2bQUE1DwEuCclA/tX62zLPto4K0vaWt2x2FgAKNYwHSOTtML/La7spnUeNZTJcPdEHs96OCqWPQnEulxGkR1qJPuY6m6a7c89xQd8LMoT5Z3ifSPTSaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsTtolez5NfOpxlYyXDYFTxNBSDAZvQHIsCsjntxnEY=;
 b=XS4aKgkvhumOj9Mdrtz9U4UghzR4XdXmDV94HgTynWLnmSC1E4ricN0XRzGo8GpVwfSQA+ladrB8EUH2ntrZa5t7P/rhqCE2PTYj5iru8KTdGJ9i29AHJjwZrJ22pjt5sMY3RXtqB+E05Dh5RTzt3io33eI8A+ZC0NiKuX30Ja0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7312.namprd10.prod.outlook.com (2603:10b6:208:3fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 16:11:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5d80:6614:f988:172a%4]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 16:11:44 +0000
Message-ID: <71063aee-8ba9-4a02-8c09-9b3a9982f6e0@oracle.com>
Date: Thu, 11 Jan 2024 16:11:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner
 <david@fromorbit.com>,
        axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, bvanassche@acm.org, ojaswin@linux.ibm.com
References: <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
 <ZZ3Q4GPrKYo91NQ0@dread.disaster.area> <20240110091929.GA31003@lst.de>
 <20240111014056.GL722975@frogsfrogsfrogs> <20240111050257.GA4457@lst.de>
 <d5db2291-36b4-4b22-89f2-1d9e7d30f0f1@oracle.com>
 <20240111144537.GA9295@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240111144537.GA9295@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0489.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 56086ad9-a7d8-4662-f594-08dc12c00154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ze7gLeEmS+NXwY9qfCQO64RPejWTksXIZsVXHysFAbBpskkJwGjiBVbJdcbQ4c7GQoTBp9I72kmM+g5RvqiZLSmgByq89ijb0OSsGTu++2M5nOaXS0E1DX0CqPNcYyMZm4NNVbfHSev3QhhNzXouLc7Cd0e3JGXp7oyVvfYdnBYzQJ6bj7LFCPx0MyCnjH/4iVvqUFHoHflbVV/+HtxdvxOGScPsaH4sDokibBKt4vyrCVCKMQFYaCguhsIYqy7vcxZ8EKmSPKESwLUPtAdXWvR15NsW5zTcV7bSOGta55o25Veut/T3RYzZfn18YlYymFLLEX2JZFY7Y1fMmQUnv0zfewHaQ7rxfd6BOb8OCftJ7VZ9AOxsFOnUcQZnkSDGwX6CL0ajCkGxZTY1dJDqLaPbArqAtwL7XqKpYkkJmer6su/UeMbSS2QU0s8B3anzGeb2AtRFokEFcP4W1TwcUOaAfXAtl3NAzjqnNViDkzi55TWQOMk5utocHFtZ0UePK8qKp1q+BpTDned1/QFgT1BheUhpWmJ+Acw6U8tdciWbvYdHtf1f3vJU3v2JEc/mIzYfya9VoZ9AGodMK9uGFLzzF3BHisYaoS9tXlFuNb9l5YVYSdm7K1MAl5M4SAu2Gd+177uX01taCu7mDkVdaA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(8676002)(8936002)(4326008)(7416002)(54906003)(2906002)(316002)(6916009)(31686004)(66476007)(66946007)(66556008)(6506007)(6512007)(6666004)(6486002)(478600001)(36916002)(36756003)(2616005)(26005)(83380400001)(31696002)(41300700001)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3RXdnh6UVQ3enA0ZTExblZpOVdxblFPUk4xWk8ySmpEd01iWXR0SmFiY1RM?=
 =?utf-8?B?NUZ5b2R5VUwrQjdwcU5IMWxZL3RTemxMQ3JLZVgwbVQzUHRRb2hRL3BEWlFM?=
 =?utf-8?B?cXBuVEQxVmY2ZUNrUFBSS243K0wrNmxUM2dCQWEzeTl4RjFMcSswWngydith?=
 =?utf-8?B?NmdWRTJnZnpRREJNSGZVcTc5dEQ3L2ZTTk9EejJ5MGFCY01McFJrSnVBZTVC?=
 =?utf-8?B?OHhoblE1U0dQb1Q3Yi9sUWFIZmFScFYwOGFuWnlWK1VVNlZ0cEpvRUd3WVJj?=
 =?utf-8?B?UnVOZXpKbEZxWGV3TDdqdmVHS2xWa24xM3ppNE5TTUpSdEdpVGRyQldQZktM?=
 =?utf-8?B?SFBMTmRGUXNLUGFHWVQ5M3pFTnJ3QnV6L2dlbTZndllDVFFVa2VrMlNyY1hv?=
 =?utf-8?B?MG9IZWxVTk9pSjhxU3VkRFRrTHJKTTNuZmFLWTdJZTM3dWFSenE5bHFJVGRQ?=
 =?utf-8?B?YzQ3Z09yK2NJaGRZeHozWkZCY1VFanMzWi85TXg4eVBSZFo1aU54a1JQTFRo?=
 =?utf-8?B?UitXSnl5c3p2WmYrVDdPRmJVSno4NElXWExiQUdTYWhVZ093dmxadkgyUjU1?=
 =?utf-8?B?R3pQS21JSno0aXdQem04b2VMV0ROMy9GRW4vUmhKSFpWNXMySXFYWUJ1eUZs?=
 =?utf-8?B?YWZMaXQ0MXMrU3B2RWZ2d3ByNUZud3B5TVlXMEdxbFJPYWwvck1iN1IrL0Iy?=
 =?utf-8?B?Y0FOWWpDTDNKS1RMcU0zSjdBMm1sajREeDVhcHJmMStZWGN1U1FEcno3aDZ3?=
 =?utf-8?B?R2dyemdOdUtZU0J5RWVDbHovQVFHeGJyQXd6V2I1dHQyNXFHNStPYzFkZUkx?=
 =?utf-8?B?Y2hGbDdZZWNrMERHdENjQTNyaERDL2ZjZloyQjRyUzZlTnpoTVowY2EwZ0Zw?=
 =?utf-8?B?Tis4dVcyd2NjMXZQbk1BU0R5K0JTakx0UVNjNWhPaGVmSmVCL3hoeDYrQm5S?=
 =?utf-8?B?R3N3WjkzOVQ3bUtSWGJreW9ZbzRVQWp4S2FaS0xMZkd3UTFLaFZIOUU2QTli?=
 =?utf-8?B?UWw0WUxxeEo1L3JpZFU2aWlQaElMNHZGcExOMFlJL1FaREJQcHhqTlVaTkg2?=
 =?utf-8?B?UUc4UnNzTHJnNGFVY0FTSjZYclhVODRVeDZIdmFXTWZuaVpneEx2RitqbStW?=
 =?utf-8?B?djBpS0VZSktGWUlOdm10NnJIQ2FuMFJienNkWnA4azZlVXp2LzhIRHc0UTVY?=
 =?utf-8?B?UjR4TEw5bEtQbWp3aWlKS1NJV3lsenB5a1hEcFlaWkJTNjZ2S0RXZ0gzK0hW?=
 =?utf-8?B?a082Sy9kaDMwb3lEOUlIbDlJSWJvcCsrL1czTjZja1JDc0pOMm5ld3EzOEw4?=
 =?utf-8?B?SzhFbWtkbEVQbE9waUVGNmdMbzNpUTJTZVgyVU92NSs2ZEtSZDhic2FBZWJh?=
 =?utf-8?B?U2tPWlF2SWlWdXcyOUE5TzFKbVVQTjkxTVJYVVNFamhWdVJjMnV6czNuRE9Z?=
 =?utf-8?B?NXp5QmJpU0RwcjlkanVJNGloKzJVTEl0bFhmbGRFTXBrQ2VLcVRWY1EwVTV2?=
 =?utf-8?B?UnRRaHR6VGIwb1ZzK210Q3pSUVhPVEJYSFFTQlRaYUlKZVVpSzNjWVFyOVph?=
 =?utf-8?B?TWlzZXdqWXY1REZyQ0QvUVpEZWF4Y0Q2bmUyNXRteFhOdjBXWmc4NVZGbEEy?=
 =?utf-8?B?K0Y3Z3lTQ1dCQ2NDREhUcWVnU0tpRUI2bkJHNzRBUndUY3hwZ1R5NHNnV0th?=
 =?utf-8?B?cXFQV2dQUXNVOXkyUnJLM3VxTzRLMkpTeWxabitXRlpBRnkzUjA4VXdVZnhy?=
 =?utf-8?B?eGtLSDhyMlRPZkxWU1ltOFI2Z2ZhVVEzN2VITmVBYTc1Y2VTWk9Oa2xVeFVk?=
 =?utf-8?B?NHJQNTRaTkQ5ZXcyMFdnWTd6SGJwNnZ4L09HM1YxQXorWEEwWmJ6OE5YTmFV?=
 =?utf-8?B?V2JQZTJSL3hwTkpJNHhWdGJaNGNBWGxRVjBWdmEzdVRRSDJTV2ZaTXV0K0pm?=
 =?utf-8?B?a29kcHRpTThmbHlYaWI1OVU0dDYvMUZCQkZDQ3JnN1ZMTmlyT0dUTDBUOFZR?=
 =?utf-8?B?REttWU9tVUt1YU5TeGRPcE9aeE5QYnU4RksxYTFIN1hvNG9uU2VkL1ZBcGtF?=
 =?utf-8?B?NmlnQVI3RHJEbENYZnlWUmpmbmU1R0xrbGxTVE1hb0hUdTljU2czc1ppMnkr?=
 =?utf-8?B?bVByeVY3bWdicU5wdEtyaVdOS2M2UHhqVFBjNThvZjB6dEo4RlZEcUtEblcv?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qp4q8t0MeK65x0sjpNhOXaF+6mOdKOZHOju6Uc3rOVaU9gIG22pGOGBl1uXw7OqRidiOswSY0z/zjleohuTwT9xo6jexVXJ6OnxojAY/b0YRP3NLddGYX5fvtIHuP6bQ0BWKxYemodIzM2cycDTLmWdmLPqXm89O1oAhtDR0wU5D1MxQWI0Sf/NqV7dTPRktpuUiuMIQXK6x6BabaWApfeGjXBkBQoc1MlG1ylCEOrgQ8eXF+WfvfzOsbvjap/FN8jbMwpFY79IqW4fZVRvu76pQnDqnZKKmZdBSSUGIFMsB7uD9HQoVEh45RSB4sCCF8KipMJu1AURgfeNtBkZd1OJa4wMw2zXTgCkOEw4OOk1eRhkKZRgfMn8NacQtM4FPKoN8UY6NeJxuGWBd6w/C7c5hyEZQidb7xA6UsXoIqO7j+WjOSd2zca+cq28hfN6zj4XmZpFWjyCH3UQbGBVbNReOWeStx4dranyCsRp1iwHVPZNN0NTDg6lRHS4zQ1IKdbm6EiSRQdytzRc9eUSOpVfxdozBpTiCJu53HjaOpgrRNVcoWDMwlfMtr/OoUPO8IPqeUispOeb+RlQl6nTpXUSPrk75Ki9KeUEPPgCoY+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56086ad9-a7d8-4662-f594-08dc12c00154
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:11:44.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgiJ2YNNLSEJKGfa8ctjA5T83wZwb40p1ilGhDkm3kGHIohoIWHGtW/kAW8EhqsuLhG4DRvPSiU8rBsneCY9Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110126
X-Proofpoint-GUID: RP-kC1povyI7qo6ITG8_JDRtnD9ZSXlk
X-Proofpoint-ORIG-GUID: RP-kC1povyI7qo6ITG8_JDRtnD9ZSXlk


> 
>>> I think this still needs a check if the fs needs alignment for
>>> atomic writes at all. i.e.
>>>
>>> struct statx statx;
>>> struct fsxattr fsxattr;
>>> int fd = open('/foofile', O_RDWR | O_DIRECT);
>>>
>>> ioctl(fd, FS_IOC_GETXATTR, &fsxattr);
>>> statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);
>>> if (statx.stx_atomic_write_unit_max < 16384) {
>>> 	bailout();
>>> }
>>
>> How could this value be >= 16384 initially? Would it be from pre-configured
>> FS alignment, like XFS RT extsize? Or is this from some special CoW-based
>> atomic write support? Or FS block size of 16384?
> 
> Sorry, this check should not be here at all, we should only check it
> later.
> 
>> Incidentally, for consistency only setting FS_XFLAG_WRITE_ATOMIC will lead
>> to FMODE_CAN_ATOMIC_WRITE being set. So until FS_XFLAG_WRITE_ATOMIC is set
>> would it make sense to have statx return 0 for STATX_WRITE_ATOMIC.
> 
> True.  We might need to report the limits even without that, though.

Could we just error the SETXATTR ioctl when FS_XFLAG_FORCEALIGN is not 
set (and it is required)? The problem is that ioctl reports -EINVAL for 
any such errors, so hard for the user to know the issue...

Thanks,
John


