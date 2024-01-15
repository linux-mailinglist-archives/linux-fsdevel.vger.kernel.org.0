Return-Path: <linux-fsdevel+bounces-8003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18CB82E1FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 21:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DF11C22243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796511AAD2;
	Mon, 15 Jan 2024 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YrtyerLP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kilIMe2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13351AAB9;
	Mon, 15 Jan 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40FEaUaG028507;
	Mon, 15 Jan 2024 20:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=ln3ERbloU450zbAiT7pd5NGB2iyl5Sw4UPmQWIPbWkY=;
 b=YrtyerLPjEb/Y9A4YlzcTzZa1K5jpQU7Dbq7phGKHdfi2yZVdjkPtGBqSDsf5eXtIDIZ
 /BICVCE15U/VPRoyP9PjFcTFXJ6IIqOwoHTgRTgKVdvUdPJeecoFmWoxBqPosWOdIXQ7
 qe3Go93s04ikAHbKYAZFU/TfzsQPQ3VbeWv6PUWzQ+8TLRQKzSnfk3WjfNSMV0yoy5Bm
 YmoBzYnFkesQD38Vuix+FlDD121S18UHUKGt8nYaG5pz89OgYAieToTfvzxS8svGHaRM
 aIXMU7+ELxTNdQopTJvrAj3CHq+Th7GJwp2IDnGu18rsmy7bDWltoQ1Yls4E2dGgUHzh 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkha3b55b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 20:52:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40FIovqo023165;
	Mon, 15 Jan 2024 20:52:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgy6m2qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 20:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbQRfU01HJ1QkPDplX/HRHT8t3AuAa7uu7DOJuzG9e+zjwAC3of9lRiHSLzy8vLEtVWFKYlzY1uEe7J0ki3p4RUfg0wUH7fuv0meiTEUcoLUju0HcP/oK4U2CKbEGoRfthIiy1Lk2WMq0zIOGsBK9ilhqbtEKUIxBOFZgQ8QDKstVuG7JTHWWx2xDzWQ9a2x4z7cjjJ4YvfBCiD2hV37qEpbZWLX/wJ3V3I9z2Vb/Ha9b5dU5CCZmbhmdzoQMt2Hc2pNq381vrW7KDiMcjbpJFWF2D3Lafxk5KMFT4EuA0qnCAN55UcffJ6mC6wm7I4SLt54QphNRrmESCnW9ezL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln3ERbloU450zbAiT7pd5NGB2iyl5Sw4UPmQWIPbWkY=;
 b=ZSH+7g11HkBr8Jz/j7ImKycrAn+VT5oxuqbazidvHkIMhMW+b54H1tc3TN9uqgizIop+h0NAxxkHssvMI9ZJ2TSnuJKReEwXS8afRaRysfdh+VuXbESPFSxyg3+eizHBLb4oHIvEXznfTR7FtsFx1KhsjiaBqd1eHWH//5J0DwpQS5bPGUYc1R2swwcyWKdmkTmLozoXDZjJIIbMVw7VHRJ6CUmzeHmi4DFIrmfGy4Txp1RgyPv1ZBqzucRVTPoShley/kUrZua47fGJjd39TGv16BCfTXl1SXSjvVpSWJHDiSFgvKKqSk/cbfwVf5t7mXjz9iyLjDbnXKyVas6kYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln3ERbloU450zbAiT7pd5NGB2iyl5Sw4UPmQWIPbWkY=;
 b=kilIMe2/PHQ3wcpk1cqvN6OEGNapsCGHMWxyPwWHXmZtFoSRGR+vSnLuddWsNlcDZXmex185IRBlBJrxHIyZWpwv9N0z5ngO67um8RXYXlwzenqEs1cG4FdiawxUNIM/5W/wr2wbvwV4PCN7ybdW9kguUlgwkDt6SVf3JfVweaU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by IA0PR10MB7602.namprd10.prod.outlook.com (2603:10b6:208:488::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 20:52:16 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::abad:34ed:7b04:91c5%7]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 20:52:16 +0000
Message-ID: <c01fde81-9532-4030-a20c-8dda3e743c0d@oracle.com>
Date: Mon, 15 Jan 2024 12:52:14 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: brauner@kernel.org, ",Jorge.Mora"@netapp.com
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: dai.ngo@oracle.com
Subject: nfstest_posix failed with 6.7 kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|IA0PR10MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: e12f58c8-9460-47c3-38bd-08dc160bdb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4LJd121Bd+T73bLxk0lz8kIcsRc4PgQ0QMT5JWygsOn97zQkxu2ekUoG8ArDXduSEYSy017VM6miKBOIKzn90UXEodoXwlCvkEmawrNHBRT2BLfgjtOdqEWI5wTfD7oiJXxfFxx1zFYceAO4dWdQM2we7PNdyrSi6M7jUvlxTCFXv9tC9fAG4o//9Y4qCex2PabOHm7rD+2uklScVZdsgDiYBGJ7klYBhxyG0Y/Bl9+uX3Cltrz0iaXCkizmRgCnMV+i/gmuyDJQDAdVsSX8mwsFyc9vyMamFrxc9vbDRz+OgqKEXUpSN482GpAsnPxwzedBXNQJcBaeGtMgFpzNgcXhF7sSBlAWltFaHO6StGw6CPjIBusRoRDATKckKbDUPjHhNHsB72WOOVVb/DhFTe9mD/u8JUSVMSVYJaEjLhpyL0zVdcIqH5kqPAcSIRYwhQkGZHaaLNroA7rshYQ8xa59z78CJ9jT8HYIKOll1neWNClXNFyfNWPQ8QXOl8kJc9RPqrYZH8SmAqXyC+uJYRj83/HhrlHIBY6DBrJMX2qAsZ9pUm8eAadYItufo9mFyFANp7QrdfthYj3CaNuYF5hy8wLWF0teIkQ6O0iAEkhgu9vidvOWIQBwNOOiiPBi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(8936002)(36756003)(4744005)(4326008)(8676002)(2906002)(41300700001)(26005)(478600001)(38100700002)(2616005)(9686003)(6506007)(6512007)(66946007)(66556008)(54906003)(66476007)(6486002)(31696002)(316002)(31686004)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YmlEVHR2aXlleFF2R21YM3RtUnh0UWJhV29nNWMvdGhoUXZjamdJempHRXQ3?=
 =?utf-8?B?N3FTWXNPWE1Bam1uRlc2VkYxRTlIeW5wRXQ0d0R1QXg0OGhaZklVcmVUcEFR?=
 =?utf-8?B?SzJKYis1RXo0QmJER2ptVmhIR0YrazdKeHRNdGdxMXh3cDRvaUk5Vm9tSU45?=
 =?utf-8?B?dW9xcXFqZnpRWmFLRWJkL1E4MFNVMjhQeCsyRFByU0RFTUhtWTdSMW9NcEZs?=
 =?utf-8?B?cUNVQnYrQkhkZGNUaEczVDBTSEVlNm85NjRvT0ZBZ3Q5em5xdnJ4NmNrTGd5?=
 =?utf-8?B?N0JXQzhCM2t0QnRJTk1HMVlER29DRDlGR0dtVC9hc1hjSTJOUkxtem1DTGgx?=
 =?utf-8?B?TEtKaDViWkpzQUorV3hCZG5kNE1kR2dEY1l2UlJCOGh1ZUNxc0hnWk1BeC9B?=
 =?utf-8?B?V3lMU3RCQ2xGRVVNN3dRams2WHlNQUR2dUFENTVsQWthSXNTam94blRXUTFk?=
 =?utf-8?B?WWUyYmd3VG9nbWxsUXdzdy9NYXl6WDFMT0w5SHd3M3ZCNEhTRVYzSWtKK0dv?=
 =?utf-8?B?WlhmTmJWNlc5VDUxc2N4MlhadHNKcWFXU2NXWlNVUCtoYkNZdSs1enJMK3Fj?=
 =?utf-8?B?b3RBOHVYU2YvV1Q0V1k1bkpSS3FyY3JFTDJ6YkpTSG1CNEtyY0gwanltN3RZ?=
 =?utf-8?B?RTQ1bGcrZWZFSFZDZmwxdS9EUFkxWFl0UFpNSDU1TFVMTWRaM2sxYWlKQnR4?=
 =?utf-8?B?Y0ZOK1VZWTE1ZTFZZDlsM29sRVdTa3MvZEVrQWZqbkVXRnJ3ZDRuRHFpaUVS?=
 =?utf-8?B?K1pBOUpxWndFcFRvbTZ4TEJZYkhjVDEzNURQUXpzTmx5Qk1BcWUvWVo3Z3Ey?=
 =?utf-8?B?Yy9laWFRUHQxNExaMEc4VGUrNCs3aVZoVXZsMWJjS3UvSzN4UlB5dFl6VEZh?=
 =?utf-8?B?YjJocXFoVm9xQm9VcGJ6Z2Z2dmw1UTZScVJNUlJPN1hjcloyUHlsZHFjelN5?=
 =?utf-8?B?am9RVk1FOENTMUZGVXlTNzRqZGg1WHM0N21SYTlhU3d4NGsrcjZ3dUh1bXlP?=
 =?utf-8?B?Q3VQYWJtdGxmM3RKL3V4TDMxK3lRUCt6RzlWdTc4N2FQWGRrMndMaTNLbEZQ?=
 =?utf-8?B?MlI2OU9JZHZqR2ZGWHE0QlJCR09Rc1ZRbWFLUnpQQ2RFRmM2T0RjeC9UT3VD?=
 =?utf-8?B?V3dqMWMvRXMwMHlibWVXNCtmWkxYdlFHakhvZytUWXZvUENicFZWeDJwSmxT?=
 =?utf-8?B?RnNSQWxXTmU3NUJJTFIzOUc0QllFa0R1Z0hEUFM4NTlOZFpsck02VUlha0Zo?=
 =?utf-8?B?aE9NQ1VQa01jSDB0MHN2WFZQSUErK3RCTTFwb3VVN2x3TzFzQVRzM2g5by9k?=
 =?utf-8?B?QWlvUXlzUURVUmo1Y0lzdkQ2eTJKWEdvQmxpa2cveVlTaHBhanFKb3hERkxo?=
 =?utf-8?B?Ti9JWUpmUFhIWWpRZmVPcEo3WHZqV0tPMVJhVGNnR3ZQNlNDeE0rS1hVclhz?=
 =?utf-8?B?OVdTTStQZDNWZEk4UTd5Q1hLQlVHMHNiMXdWakZDUjB2cHZWQVFWeEwzOElH?=
 =?utf-8?B?NFZ2akJ6ZDJGMEZVVUI4WkF6VmI4MlM5aVZxMHBPRS8rVXgxeXpPOVlMcnpz?=
 =?utf-8?B?T3ZtditXWkxNUEMrSUNURzBWc1RpY0xhamRkUFJ6dlVXV3Y0Q0FHVGVlL05Z?=
 =?utf-8?B?enp6cHlzdGJlbURVKzR3QXFJR0NvU2tGa1RZYUtxbmRZWThqL2lLRFJwZVJY?=
 =?utf-8?B?RTlDVmJOZHBhc2tGQ1VueG1ReFFWeEVvS1FUeE1LZTJ4Q2JkQ05DeDgycXV1?=
 =?utf-8?B?NDdGQU5rdDlQYXNFYjFoUUl0UTZUK0FNMGxaTG9CVlVpMTU3TW9ncTYwd0NC?=
 =?utf-8?B?VGUzOEtHSGlxRGNtMmRSSEJOMEtoNTNGek1JbXFaUWduUlhDMERQZG5DaVF3?=
 =?utf-8?B?N1JDNHkvM2xGakIrNFhOSUovRCtjamRxcVkwUWRYR3FXUXNyTDQvZExVaTlU?=
 =?utf-8?B?dUF5QmlXT2VvUkdKSWx1WUprMEZwSFNIRmJZYUxyeE9PckwyalBjL3ZOSGk0?=
 =?utf-8?B?bkxTcHQ0VFAySVFhN0Y0aDR4bEd3ZndRcEMvMitLRlU0bUY0NUoycU5wRm9i?=
 =?utf-8?B?WURQSVI3OGxBSkxzZVVheXV2NHNyZU93Qi8xWGhLd2VYby8yVGE1MHY3THR5?=
 =?utf-8?Q?GeexOytFtvBOQgrQb58bZiaMy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ju9cedk5gxxfzzMtcgS68AlQQlnVwXkIbMu0xknNZeDnCperP7xPBsqfdIBHLhQqCuO5ATPVyqyTOPi/5qFKv5i13HlJCZtgG14Xxq3D8m72ziacJOoifc7zutmLm5iCHjzLrru4tCKvgcOAOUBACn93Acve+KzitFusBo86xZgqboQ8jrY6VyalLs6GMXk+i7OC40swGOqjaz99CDy4dqPKT7EDNIT8LEtI3IxHilb3ONBd1z1Ne/cRaKCST6Yg3VrJkgzB3NMg76eaU2UJmk+507nNskRSbRJpIj3/Z9uLRmG4hzwNNAkJzjWQIqwgCyNkegG8TM9aPjTEzYUnm7u30SdFXJctTlxyL79ESwtrIW9mAvPQbeByIkrZ5rv4Q2tsfUGadLf45097NbB02QzzKyXRAOsrNwPlyGYxB/Mo7zEv8WVypusnzvKR82kmUv1DEylf7uKQvt933JFgGfExL6UZj1QSp7MExOKjs8zpwKBs29DT8IS2l9C28z3WMN9TE743bk7dRJcgCmGPf5bLSUXfa8//4/LoBAEnqSsFFeT4XG3yFv7e5wQvRLZYWmguUub8f3xxW3Zva+KcEPl9zsuuCh3j+Q/3LQOpLWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12f58c8-9460-47c3-38bd-08dc160bdb62
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 20:52:16.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWJflYWv782JzryzsIJhX3cKT2kV/uUJBlW785MnMRSsd2HE+Z1Iq2Oie/1haAxMxkonQXGmS7r2qwgypVnGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_14,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=963 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401150154
X-Proofpoint-GUID: GfSRBuUEIc_MDV4Nk9mCQ09m2QbHJhpg
X-Proofpoint-ORIG-GUID: GfSRBuUEIc_MDV4Nk9mCQ09m2QbHJhpg

The 'open' tests of nfstest_posix failed with 6.7 kernel with these errors:

     FAIL: open - opening existent file should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)
     FAIL: open - opening symbolic link should return an error when O_EXCL|O_CREAT is used (256 passed, 256 failed)

The problem can be reproduced with both client and server running
6.7 kernel.

Bisecting points to commit 43b450632676:
43b450632676: open: return EINVAL for O_DIRECTORY | O_CREAT

This commit was introduced in 6.4-rc1 and back ported to LTS kernels.

I'm not sure if the fix for this should be in the fs or in nfstest_posix.
The commit 43b450632676 makes sense to me. No one should expect open(2)
to create the directory so the error returned should be EINVAL instead of
EEXIST as nfstest_posix expects.

-Dai


