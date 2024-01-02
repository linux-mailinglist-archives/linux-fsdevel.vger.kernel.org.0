Return-Path: <linux-fsdevel+bounces-7132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D982201F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A5C1F23C78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC0154A7;
	Tue,  2 Jan 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZY9jdDSw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d86QoFZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A815491;
	Tue,  2 Jan 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4029SuS7027880;
	Tue, 2 Jan 2024 17:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cu+m3YOnuPexoBHA7mEWSRcpGkL8k88MGvwslZEUHwA=;
 b=ZY9jdDSwosS06SzYUqp/cTj9/zcRd14vAJTw58PcT6cSFxum2Mis8v06Ip5v6ZlGGwcB
 xNDvIoSX5SjqC31ZYbhwl7wdDdvyzDGyLziyVFR+uRfTeF6Wz9dnxen3MnAh1Fk/bT+G
 cSU/VNapsha7Ll1I8TN3kPcrXohYkqZf0WDhmxI/Wdy2ixxMJXV+n547ETmb0PrRJb8o
 iiqSvS02xt/yFOL086hk6Dtgw6dFiLAQ/hC4isKVyPrr0CQDu+iIeaAus5JIDNs97Izk
 6IaXjKnASkuCnEWmc46iF/vQmgdTOHKVp5bPJlgtMshUmfU+lg18v356GYKXrDm6pOwJ eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa03ueyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 17:10:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 402GRaBB013865;
	Tue, 2 Jan 2024 17:10:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3va9ndqy7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jan 2024 17:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogz3R1wWlsyEw8avoIop/JV2QYCkya7XZNriNgmZX89/Z/GZ7T+kvqkvLJs2++A4AaZqYnoOWTTwtaO5q+VFMu739CvxIMHnQDjnZD7IJ4nn5Bg3ZoBcVUjTo07EuEvrZ+qSyWiT/NUhXn0/JHXnJnCFGZmmRo+hquwGg1sWyD8Iwa5X7/P1o8uaH41qfScxnXORev39tir/5niX3ZGu8P+gBxO6xk1kwwU7OIIERVTyiZI6H1sFnN3TVfUCkxVYpUp1i5NFhMm3O7ZQmn6ywLuWmFaM4dmsgI0vw6suyU/voTZG/CEYE6gsHT90f4Oc5Zw5GLS7mfMAVGvjnUrT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu+m3YOnuPexoBHA7mEWSRcpGkL8k88MGvwslZEUHwA=;
 b=Ya9e/Y2iBJjC16KyKGLUieVuVGoj2Em4qTGRbd1Z66oW8SQz4IyGJovWorLz15Ci1IttIK2sD2jaXSFU6kckJE1VFnS3l6uPNN7gRyAalcR46m0Ny8KZd2xjo3uEp1rcmg3EVCj7J/jFbwcj5V71QbvTHtFPfACjzIAY6JMdWJ3BrtVOxxcd35BC9lUbx4lxW+LhIQSNVw+uajgr8YBQSHHgMsC4WR7bSUfSPmfZmAJj3EhQq0c38YSPv61T0qrisyOc6rasGDJwBUjxPpt7QVBKo3oHS+S7hlTaYmhoHIIqXhJvC9ygOgEEdqltdVChsmbcFso8z/qgqwvIF6Zz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu+m3YOnuPexoBHA7mEWSRcpGkL8k88MGvwslZEUHwA=;
 b=d86QoFZfWItJyaUanptuNwk+W2MKxrEdaJ/F2jdq6N+CvB9zsDXuBHqDkgjARultl8oBAyOMApEyL7yHgZASR960vaDdJxd+IQnTJAx8FHktxYk2bfBhg1bvu6asuSXFdO3aN8NFUQ1xL/6CPvIBNi51P2/cGeM1u0WB39O/GdA=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:10:18 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::bd88:5306:d287:afb0]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::bd88:5306:d287:afb0%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 17:10:18 +0000
Message-ID: <50be9574-b9b6-4752-861f-3e4b4e251207@oracle.com>
Date: Tue, 2 Jan 2024 11:10:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in diNewExt
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
        Edward Adam Davis <eadavis@qq.com>,
        syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <828db1e9-9b98-4797-bd23-08fbae1260d3@suswa.mountain>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <828db1e9-9b98-4797-bd23-08fbae1260d3@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: f5288d17-f42d-4cdc-627c-08dc0bb5b1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8yP1aXI70432/B07QdVuloSjyG+cIrOXMML11Y5xtQ8ujbHKpuYCrCAW4i4TKKv8PXxSf00Bp1mIvzSk4W89HIxFfJXGAtqWMCzp4VoiJLAKxCVr1bMkO4XMK5pF2UxoTCO3Uqtm6QkcTtBVYz0ENgGUl3wFSM5v8s/FrZvWvcWmecPcyX6GsQdWIhiBAMDZXM9USBMYT2v3pi6NgLvPx7JiPqadZ/b7DK2xsFzRf0bfe+i+uJc1QaL8bgNv1hEOXyS1MvfbV60EqcicFtMGAr/Am5I9SM79+/wgbqEPSD8XEBnFVnWmAlrP6d5KuXJOD7oV31xJM4vB3ODovhiAwPjiKSYSj+NV7bzzOIJZoXUBsz0lLqUMcxG/j7rIKguLRJ/8x7eDOLSP8HzF2NqPBIS76gKqDteowL/fLtkBlA3zGlhsBCS354CQ3tbpvNAHHwYpHBsvza4CLMrbDIj7PYkjMt8aOUqtABzlIev8UI2CPK5qpdlTrFNWJ9me5+OSzhiiV+/mlZUT4b0IsVBt7ouHMoxTI5SZVcq7X4BhJ3Ry+p0M0yjOQULCUVPJ7ZJ8pkCg0az0s/HO3nuZBEaCZ/iDeCFa5MOyMrVO4BtDmjPHJFunAwVTahgH/68FoerJSgV1D+aGP/LhFTQdybjNfLMAbdtOQgfeaEKelKvYED0oVC5tUjjUUIfU4T5rUl2/uKlbtXZZLiy9/X7cmlfXcMM89XUeOKXG2fWXW/o+y5w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(4001150100001)(2906002)(5660300002)(7416002)(44832011)(8676002)(4326008)(316002)(66556008)(110136005)(66946007)(66476007)(36756003)(6506007)(8936002)(38100700002)(31696002)(478600001)(966005)(6486002)(86362001)(6666004)(2616005)(6512007)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckZYRG5xckt3bjJYV2VvcFFINm1udjJFVStneGtkVnVMcWVwbDF3eUJWbU5i?=
 =?utf-8?B?bG1tMnhQWWE3SkVGQVBQT0ltWVFKK0IrTDE5Tk11bDUwbk94a3NwT1hMV0Jo?=
 =?utf-8?B?QTFnTUFZVVFvY1hXblhGVmhyT3phOEdERTJ1dUQzZ2lyK3M0QjNzUExlRmc2?=
 =?utf-8?B?aG50NkdVQWQ5WW9hWXZtQmtsdFBNb0R2VVRnRGYrNjdLejB6NFNSVC9Rc1Ey?=
 =?utf-8?B?UVBLK0V1d01USCtyRDZWUnZtOTdFdXNmaDNZUWY4MUVTbTFhL2xBK0lWUGhC?=
 =?utf-8?B?R2E1TU56eXY5bFJaR3ZlVi9wbXREL2RiTmJBV1lMZ3Zlbll1U09LUmtMNzZj?=
 =?utf-8?B?ZkxxWFFJZlR5bTFHMW92MjFzM2tZZ05qQ084dTJaWmMwakUwSVlWbkt3S3Nj?=
 =?utf-8?B?akxseXVSZzNjYVpzcUVhbkNIVGtXYTU4REJrWWhmQTE2SFJzMjZYVEgyTkNX?=
 =?utf-8?B?alNreXdCbDBCZzZHemFhYU83a2lkWDVQa2hPaVZHQXplUmIraHBKeTR2emwx?=
 =?utf-8?B?VTBiaXNZbXFYS0dERXM1dUFmcUJEbVIrSVVtcWNTVGgyaVpkVUpkblFEcUN5?=
 =?utf-8?B?dlo1MVZCNUhtZGdFQ2VLejVWenIrcEs3U1gxUjE4Tk05cklJL1pzNVNBVEtw?=
 =?utf-8?B?dDMrWDY4a2h4WkhDREZWbU1IRXNrWVl4b1FaN0NpRVBZdDZzWnZUZXpVUlNm?=
 =?utf-8?B?RU1oMkl2UmZXRUxMRldWSXBsT244NXBocUMwcWFkM3FuNkVHUit4T1haaEUw?=
 =?utf-8?B?WiswRG9yaFluczRmTHdONFdhTDJvY2JGUXJXY1hDNnppNUt6NUR1dmJmTUsy?=
 =?utf-8?B?KzVaZkdXdTUvTFNXYkluV0pDK3hVVHhSbWNoT0M0MHdnMXZuTmRUUkVqOGF6?=
 =?utf-8?B?VTVSb1lIWkxuVXVhdVRyYmJBWFNGSU5FZ1dITm1VdVZya1dOQ29BaFZ4dDJt?=
 =?utf-8?B?aThkZlh4U1hMd3pQOEpqc2JvWlRiTG1aNkNnMWdvb2poQjFISjVTSGwxazNU?=
 =?utf-8?B?STRKMUNNZjF1U1pCYjZIdEdtV29WZVplYWJvSlJBZGNZaE1UYW5NVDcxWjha?=
 =?utf-8?B?S3BISFVZcW9zMUdwOXpPUmV4eTRnZjZUQ2lLZnBjMDNXcTFISjRaWG1KdCtR?=
 =?utf-8?B?K0hRRDVzaWpoT2NqQ0lyaktQWnJvd1NqdncxSnd3M3VXanVrVGhKbXJ4dTJu?=
 =?utf-8?B?bWt0c2xrUmRXTDJTcHBtUlJaSFBhR1c5MXlwM1lMUzNHZnN6cDV1d1Vva0J0?=
 =?utf-8?B?dnF6Uk9rak9kUDBSQU1zbEpMYUVrcUZSQXRrVmZLZURCUFY1R3ZsMFV4Yzdh?=
 =?utf-8?B?NjhyUUk2bTVHWU5ycTNmN0QxeUpHQjhzbkNZWVlxMmtjTzhRNUV2QWx3UTl2?=
 =?utf-8?B?UjZPWXUxN0J6MkVuNi9TUXFzaHFzdk01Zlk5ZkNxYWE1TjRJelRKK3pOb0JR?=
 =?utf-8?B?Tnh1VmJFVC9aR25KVlFMem5BZldMSGJ0NkZDQlJSTUhGeU5BdWlNRHZ4NTg1?=
 =?utf-8?B?cmg5Umt0NWlNTDV1OStLaUFXLyt3V0x1Y0hkWktOSDZiOFNKT1hDOGVRd3hJ?=
 =?utf-8?B?V2VyR0xrTFVSRzBwUDJNUW1IaWZ3WitTOTZheDhxQ2tBeDlSWlJWaTFwdDFQ?=
 =?utf-8?B?Mm5WSDZpSC9lUDBHR2U4MzEraDRaM0s3T0w0YXIrRVpCb2dXYmNaK2RRVmo1?=
 =?utf-8?B?YTA1Tml0b3J1TG5QV0JjemRwam5iSGFzM25kbXVmRE5Wc3lOeE9nMFJrOTh2?=
 =?utf-8?B?R2R5QjNFVjhhYWpwTTNheDhNRUhIMVdId1lNdU92NDNCS1l1RlRKNG14Y3Ru?=
 =?utf-8?B?Z1lRWUVBbG1vZVdKT2p6bmZSOVo5eW5mbVlQUEJLSmZ1SS81WDFrOUtqYkZP?=
 =?utf-8?B?Q1ByNlNiTEVrNzVpZHE1enJrcU9HVmNFYTF6TmtJUkVVU3crWldOMzlvc0JX?=
 =?utf-8?B?SFVyeExlOXR4cFBqZCtMTDZLWGNKaXBTWmJuQ056MWRMRDNEL3prM3YwRW9S?=
 =?utf-8?B?dlFSbjJ3SDc5UVJSUFJDRTVUNFN4SlVWdjNUU09jZk5RdVdKcHoyRjBDSTh3?=
 =?utf-8?B?YlRTTUR0WmlJeU9YQjJrbXB6eEVuRjJKeUQxWnBzV2NpNXNsVjh2U3hUc1Bx?=
 =?utf-8?B?R3NxVFhpTGNhSUVTZ0RJWWlXaFlsYzFhUmhVSzZhRmU0ZDlxVGN5NWlpN2FV?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xoRkMDL7rfd1T1tBkgQZzO9DnYi0YVkwj868VIRZMi9L/zBqepIhPaDSygwl89VBRLuKIYw/u4uKvfyIQir9thARl2x5kM2favnvm9T+EOWcJGuEsO1G3qNA8n0jTuM55iucGeX437R+t4hWXyj8bI70NXp5h/v6XSbYzd7/awPj3OmVc/gJfbYHjBTvTSPeexeroCbL62FMcDv/H1gdO3HNjyk6RVDMOh/NdrOHnyOuqbrsKqeRXVZE8psxFvnAeBah8xAbbRzdeF8d5TTKX9vIOSnUmoLXQlxzfB0KLCZSygkCCcId21auX2AkzHooWcgQnuEM6XZaPj6AH4WfLXY0g7wpel84F4j8iIXv7xr8J9eRIADllbdG8ZUcXMOJuTsAttcVU1vi8EpIbUB+Ui6+d3a4WRTXCujUklq8caRy/+5UswF7/PUocrqIQBz1lIJTk/0UyBoxpumE4/1kE2U3UVoSG8w7oDEeDq3aoM8hppFmMKhYBVwNFCEr7EdjV8UOHwNUADTpcAGOZHiqta0PMqEy7ccvfqknl5pXQKRE5g8kMbJJmi3WM6koPayBRfyp6cJC+kBg9bdgHNlEpKHCOZpvwTgD6RpLV7k3C+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5288d17-f42d-4cdc-627c-08dc0bb5b1c7
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:10:18.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ewSOKaGMEMuDKTK0qiVap38yfTZN4iIQh0v4Px53SBj/thoUlnRVoe0Xs/z+Wcfq+hHCzl2dbx1OQuCyTXR7lvbMzkLDFPvO7Pj4ayaaDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020129
X-Proofpoint-ORIG-GUID: IHw2F50pCP-Ncijus5LD1ANDwhCmPS3n
X-Proofpoint-GUID: IHw2F50pCP-Ncijus5LD1ANDwhCmPS3n

On 1/2/24 7:29AM, Dan Carpenter wrote:
> Hi Edward,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/jfs-fix-array-index-out-of-bounds-in-diNewExt/20231212-095530
> base:   https://github.com/kleikamp/linux-shaggy jfs-next
> patch link:    https://lore.kernel.org/r/tencent_B86ECD2ECECC92A7ED86EF92D0064A499206%40qq.com
> patch subject: [PATCH] jfs: fix array-index-out-of-bounds in diNewExt
> config: i386-randconfig-141-20231212 (https://download.01.org/0day-ci/archive/20231214/202312142348.6HRZtXTB-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20231214/202312142348.6HRZtXTB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202312142348.6HRZtXTB-lkp@intel.com/

I modified Edward's patch in the jfs-next branch with the corrected test.

Thanks for catching this.

Shaggy

> 
> New smatch warnings:
> fs/jfs/jfs_imap.c:2213 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
> 
> Old smatch warnings:
> fs/jfs/jfs_imap.c:2229 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
> fs/jfs/jfs_imap.c:2304 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
> fs/jfs/jfs_imap.c:2318 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
> fs/jfs/jfs_imap.c:2330 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
> fs/jfs/jfs_imap.c:2332 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
> fs/jfs/jfs_imap.c:2363 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
> fs/jfs/jfs_imap.c:2364 diNewExt() error: buffer overflow 'imap->im_imap.in_agctl' 128 <= 128
> 
> vim +2213 fs/jfs/jfs_imap.c
> 
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2152  static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2153  {
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2154  	int agno, iagno, fwd, back, freei = 0, sword, rc;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2155  	struct iag *aiagp = NULL, *biagp = NULL, *ciagp = NULL;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2156  	struct metapage *amp, *bmp, *cmp, *dmp;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2157  	struct inode *ipimap;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2158  	s64 blkno, hint;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2159  	int i, j;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2160  	u32 mask;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2161  	ino_t ino;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2162  	struct dinode *dp;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2163  	struct jfs_sb_info *sbi;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2164
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2165  	/* better have free extents.
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2166  	 */
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2167  	if (!iagp->nfreeexts) {
> eb8630d7d2fd13 Joe Perches       2013-06-04  2168  		jfs_error(imap->im_ipimap->i_sb, "no free extents\n");
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2169  		return -EIO;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2170  	}
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2171
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2172  	/* get the inode map inode.
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2173  	 */
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2174  	ipimap = imap->im_ipimap;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2175  	sbi = JFS_SBI(ipimap->i_sb);
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2176
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2177  	amp = bmp = cmp = NULL;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2178
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2179  	/* get the ag and iag numbers for this iag.
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2180  	 */
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2181  	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
> f93b91b82fcf16 Edward Adam Davis 2023-12-12  2182  	if (agno > MAXAG || agno < 0)
> 
> The commit introduces this agno > MAXAG comparison.  But Smatch says
> that it should be agno >= MAXAG.
> 
> f93b91b82fcf16 Edward Adam Davis 2023-12-12  2183  		return -EIO;
> f93b91b82fcf16 Edward Adam Davis 2023-12-12  2184
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2185  	iagno = le32_to_cpu(iagp->iagnum);
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2186
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2187  	/* check if this is the last free extent within the
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2188  	 * iag.  if so, the iag must be removed from the ag
> 25985edcedea63 Lucas De Marchi   2011-03-30  2189  	 * free extent list, so get the iags preceding and
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2190  	 * following the iag on this list.
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2191  	 */
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2192  	if (iagp->nfreeexts == cpu_to_le32(1)) {
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2193  		if ((fwd = le32_to_cpu(iagp->extfreefwd)) >= 0) {
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2194  			if ((rc = diIAGRead(imap, fwd, &amp)))
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2195  				return (rc);
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2196  			aiagp = (struct iag *) amp->data;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2197  		}
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2198
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2199  		if ((back = le32_to_cpu(iagp->extfreeback)) >= 0) {
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2200  			if ((rc = diIAGRead(imap, back, &bmp)))
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2201  				goto error_out;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2202  			biagp = (struct iag *) bmp->data;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2203  		}
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2204  	} else {
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2205  		/* the iag has free extents.  if all extents are free
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2206  		 * (as is the case for a newly allocated iag), the iag
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2207  		 * must be added to the ag free extent list, so get
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2208  		 * the iag at the head of the list in preparation for
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2209  		 * adding this iag to this list.
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2210  		 */
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2211  		fwd = back = -1;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2212  		if (iagp->nfreeexts == cpu_to_le32(EXTSPERIAG)) {
> ^1da177e4c3f41 Linus Torvalds    2005-04-16 @2213  			if ((fwd = imap->im_agctl[agno].extfree) >= 0) {
> 
> If agno == MAXAG then we're out of bounds here.
> 
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2214  				if ((rc = diIAGRead(imap, fwd, &amp)))
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2215  					goto error_out;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2216  				aiagp = (struct iag *) amp->data;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2217  			}
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2218  		}
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2219  	}
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2220
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  2221  	/* check if the iag has no free inodes.  if so, the iag
> 

