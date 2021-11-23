Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44A14598F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 01:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhKWALP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 19:11:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13726 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhKWALO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:11:14 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AMNia7d015381;
        Tue, 23 Nov 2021 00:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WyaR3crqGdCarPa2yGKmz82ktBLmGEY76ZD7INJzmec=;
 b=Z0dVLFtOsRltjUgv8cKETY5EguBcQN04PTmxMcfdhPMF7gMoXbbOQ63IW5iTzpxdnXbc
 ESK1obGh+SfVtT3wsAk4MCyrAWb4kKAx9Xv8a1lF6tRsX8WjXVtWL+xO4IyZNnuieDdm
 2oypyfH3ARf7GKEzgg8wkk3Gik+AHvx6rr3XufUMVPKMlYThAKH7REw76diDceUTqsVx
 h/Lyzxxr/gbeK4uVAs6Oj7goWNOxo/PJBw/YjsScuL8uk/vwSBbDlvzeRp3K0GgvwNCO
 LUzfOS2r9tkyYwiH9Iqx1fKO5XTAGEpHl5wCkLxlg8bLOV0zAGOjOlAnZRnyvsLH08u/ BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg46f60gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 00:08:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AN06kwR171886;
        Tue, 23 Nov 2021 00:08:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3ceq2dcpfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 00:08:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLLlO63Vhs9bbYsZyPRooPRkte0gOS0zqmEZQTiFjD829NPGtSPiqq1KutktqgFksbTLF5nCQwsMuUalzzgEXpuEK9S6JbV40Eo/LC6ZIJ6uLZ3ew0n19YBXgCI3OE+NepZFW1S7EXO9Rw+RypMA4cJas22ZODD/XgQ8pfT+Fxl7yhr1Fs+Qfqj337Q4flnNQoI50bvPusZPBcZNHTfbSThUV9w3Fmi0IwGjkZk/CmfWewlu4/gYavm71U1r15HFMK60/RTiaf4/D2rKuzP+6VAnYbM6XyU/uDLcgMX7s6lmHL+E9tMbWAVD6BGDH5T+MZlrZQPTHKA8ywN8J7LvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyaR3crqGdCarPa2yGKmz82ktBLmGEY76ZD7INJzmec=;
 b=N1DrsQaUttwCMOJ49uYbAn+7yyaEmhs15MUpRGS7jErMt/iecqC29PHcqklmgQEqadH3QoNCbimJEe56ExskQadluURKIUwusb3BNEfpmKlIHnL43NslGh7fj2/tfJqdqBBOGWe5hOWQSldjuRP+FQtwhdeu0c+spivwgnGFOaulQszjgfQiTAxQEU6nCB2u0Giu1coom+S9Q7UPtZBv1CZ/j7G/ZMPFQHMlBNowZRdlo2RccxNhymkodJAkjVSPOrkA56qWZs24zJ+Nce/HmjG/V+WwiE+eU+xirjtyC/Cj7FJr8oXbXZQs2ckPpkItWAKL2aTb1aGZnin7rs3O2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyaR3crqGdCarPa2yGKmz82ktBLmGEY76ZD7INJzmec=;
 b=CFwdcuo1qGpNAhMMjXg/Y73sJUajqKzNteErfFwXaa5PmwEooEjN13qRBiZeo9X6vkurOb1TujbWq5JmBB98k3aIeZyrC0fkz3f5Z/Nq/2jWHAR9d0zZOpuC6asq4bE9WOFXtXagaAGDfxYXIn6Od8Ub0zEy8WksTjeiIeZPHJk=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5018.namprd10.prod.outlook.com (2603:10b6:610:d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 00:08:02 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8cdd:90da:ec80:7233]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8cdd:90da:ec80:7233%4]) with mapi id 15.20.4713.021; Tue, 23 Nov 2021
 00:08:02 +0000
Message-ID: <d93d2eb8-7d71-43f9-1424-932edaf218e1@oracle.com>
Date:   Mon, 22 Nov 2021 16:07:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] proc: "mount -o lookup=..." support
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <YZvuN0Wqmn7XB4dX@localhost.localdomain>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <YZvuN0Wqmn7XB4dX@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::22) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from [10.65.131.120] (137.254.7.183) by SJ0PR13CA0077.namprd13.prod.outlook.com (2603:10b6:a03:2c4::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.11 via Frontend Transport; Tue, 23 Nov 2021 00:08:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0c0828c-43c0-4ae8-d24b-08d9ae1550f8
X-MS-TrafficTypeDiagnostic: CH0PR10MB5018:
X-Microsoft-Antispam-PRVS: <CH0PR10MB50187B7FAE31BDD93B093F6EDB609@CH0PR10MB5018.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QABhRw+qIoh+O9XOcnQ+Ak3KPnIdeTLXEdmh8OKgh8ck/3A6i8VKcgj+5X9roXcTsJb8ZWd9/ac4apRl5mN+FrugNgQfmgp6Fhg30kxPUvdzX1V3EyQBALqhUmHUfkx1T8ieDvAGnDdSEf5i5ZhQYNCvtsNvKHfuiitmJYLs+zWg2ko93NDTOMxzmdVcZCO9YQLcErP0tOdj+flKIW1Pt5X71r/cc7LynQCXScusoFabJxukztat8aKaIvmalXYk4c0HVMM/axcOzUebFcRWJFTdhVA0bvyo0zU76Sptoi2B57gd0Qrgk/QOe99b1RYim1u94+yKhYg1XrsiI9VZuwg0+aPiy/FqQFih9yWCJapc3kovu3rBecTuSP6Hu+ou7L14/3qdFAur1up6vUuCrJNv1LL2D/agcj0T3ACSFIp4d/1gVNbf1F28j4kQ7zAHXsTJw18Ltjq0ysOyKFq2CQhNP1qtCPkZWLkSHyW9ijOBM/tiicq9om1vwdv5qHbIy45Khrsy2wwY2jKPnnC02WVafJ+1779eIFCiQ+L53GajJGhYvJt84kSh83JoeykldaTFVc68mWpSy65wR9uXVlPWtF/fmbo5qznE8M/w/9m/pwIxHJ066n8W+MbKp/meWG7RHBlu02wwhWbWeEQCu+p7NOCX3RBkAjkPfczRXA5YMlRXbfS3TT2xjDHlRkZ6w3XbyAqxPklMNVt/6iFPpTHHOucSy04WEMfqKB7FygvE3gj+eXm1eT9rO1C9OJBwJqaE1gBfCbe/Tl3yuhw3QQ9gsGDse6B1Em26iwhNfNYV0GbUYjFz8pGhHizW0Tlg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(8936002)(2906002)(30864003)(956004)(16576012)(31686004)(66946007)(66476007)(38100700002)(6486002)(66556008)(2616005)(53546011)(4326008)(26005)(5660300002)(316002)(508600001)(83380400001)(86362001)(966005)(8676002)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhrK3FFUnJlcG5TUmNweTd1L2Nla3UyU2UrZXViM1dhUjYrTnFOSXBjMFBz?=
 =?utf-8?B?OS9kVWYwdnAvS1FoVXg2Z0V5YUtxMVB1bE5pMlowajI3V1dxNjY5NWdKWnpB?=
 =?utf-8?B?ME5abWtOa2F5RFVnMVE4ZE5nR2xWdHpVNkU4TFpSczIyOXI2ODZlUnlqNTdW?=
 =?utf-8?B?L01Gb2tnVDBTdmk5VXhIOW1ObklKWUZjVFJQMEFESFRxVWRVQVhqck12bFIw?=
 =?utf-8?B?cFVZemNZRDAxNVJXUExIU1RacXRWV3BtVVEyc3VSaUVhdUE3amx2bnpyeWE0?=
 =?utf-8?B?ZHV3eTl0bXVRZVg4cEwxeDRGMjQzN3VrL0NEaVNqd2VyTTFvajVZOGZSYUUv?=
 =?utf-8?B?alI1WmxDUG1DbEZQRkZWMmR0VGJGU2ptR2xWRWtXVlV6MFJHeG1nUko5eGJJ?=
 =?utf-8?B?TWhDdFR1OHdoMnF6VWFjMzlkekEycDh1ek0yRFFQUzNyd2FpZWh1MVcyS2wv?=
 =?utf-8?B?SS9mNmJTQyszcWVlcWRPNEhpRWNNQnMvRFdaQysvaStkeDhWSFN0c0FZZWl3?=
 =?utf-8?B?OTdDRkxJaFVkTFFKNE1Gd0xpMTJtTmR3ZEE0TWhaNUhDOFRpVDhBRlZZQW9E?=
 =?utf-8?B?MTZPWlFybk9yR0xaMVB2SXN5aGJTK0ZDRUtUZk1mQkNOVmNVT0ZFMWljMm54?=
 =?utf-8?B?TDdTOGVZQVVjVHJLWXFrV0NXRUw0bnc4eFYyZ25rcXZhTTUxTXBLYUw0b2hG?=
 =?utf-8?B?V1dEWUxjQWEvSGZZRWZxdytNQmYxYlNEQkVsY3Eza3J6Zk1uZlpnbmRZRTRp?=
 =?utf-8?B?anlPdkZFcThoWTNKa3dSMmpWQmdKbE5iVHhQc0YrR0U0WTZLRTVGK3BHekpX?=
 =?utf-8?B?RS9VaDVEZXRpc3g2T1pNVE5CZG5IdE1ablBxbGptZkZJakVZVDhiUFAvcEZ0?=
 =?utf-8?B?bmZlMnVTdFBDKzNKdXNXTlFSMGhKaXdRL2kwUzBVTzhCek1WVXAzSmQ2anNz?=
 =?utf-8?B?MEtxNU5qcXkrVlBZMjhlTHdlZVRCajVMOTFOZGI2R2NJWERQc3Y1VzFIVkw0?=
 =?utf-8?B?ajFnbkNEL1lJcXYzWWtEYy83dSs1TS9nL05hOC9hNStSR25Odll3VCtDNXlX?=
 =?utf-8?B?UVhyUjEyRTBLRkF3UjFZZ0pxSnUzQk1wZXVHZTBTU0tXaGtLbmVGSlZDOEpi?=
 =?utf-8?B?WWEvVVIzVzFLeXo4Y016S2gyaE4wL3BydnJCWnRoeVNpRldzV3RNUDlYMG9T?=
 =?utf-8?B?U1BmS2MzdEJvZExENnlwWGxCY1YxRGlOTkwrSE1tVHVPbmtDR015MjZlMGlv?=
 =?utf-8?B?UTh0Snp2cDh0a01IZ2QrczdIYi9nVjBpTWlQV3pLbU1PYjhka0J5TDU5MTJD?=
 =?utf-8?B?c1NjaHN0dU1hbVJBTGtWMDJ5OUtxZk9JbWZMSEhodFJKWXY4cHBwWElMSzRB?=
 =?utf-8?B?dmI3L2I5VG9MaEhuY213cHVBaHZ3MURVT0tMNGpBZlhpL1cxNG82SUVaMDla?=
 =?utf-8?B?ajA2U0h0OS94KzZpUWM1aitCMUxaZC9uQUZ1aGN3YkpuL1ZZQWhnU0g0NFZi?=
 =?utf-8?B?TEdzMUZ5d25qMVlWU0o3dGFxeDFDWWpQRGdScVp2WXJGV2xrYkJiakZjdFVX?=
 =?utf-8?B?T1FvdlpSdXoyb2FVaXdrYmNpWjY0OTB4ZUlvZlp0cHpIOGZEZU5mdGdNcG9V?=
 =?utf-8?B?dGRWYzRhb0plMHo5cDltRXo5c25IS0xFWEdIYWRDS3dPMEg1TXBYeEwzdXB0?=
 =?utf-8?B?aVBCcmJIbEdCc2dyS09jNUJGNGtWQ01ZejBJVzBGd1FuU0NrNnNZVGhIM3Ir?=
 =?utf-8?B?TTFybFJkdmpMVnVJUk0vYXV4TlVmNXRLTE5XU0NaM2hJVk5lbzNOeGl2Tk1y?=
 =?utf-8?B?c2pFMVdCSmM0UDl5blJVU25nRUNXcDRXS1g1cHFFVGpHWks5d0hFL0gzL0NM?=
 =?utf-8?B?c2V2YWZqM1oyVE9taXVQZjZHcDQwK05nN2FZQ0VIYndDMGlJSlhtUkdMcTdD?=
 =?utf-8?B?SmU3TE5TYWFRVU4rNkxEVG0wSDZqTU1oeVppc2VRUFV4T1FNMkJLRWlvalZ0?=
 =?utf-8?B?enBLditmeE5pbWx0SWIxcHZkbkdFeUdJNTVkNU1IQ0VxNTA5dXpKYzF6TVFY?=
 =?utf-8?B?Z2FodkRpanFUQ0hNaFRSdG9NTDU0b0pqeGdNWlM1blFkZTZ6eCtVUDFYalRn?=
 =?utf-8?B?WjZqSXRTYlJYaTFwV3ZKbkhVK1VGdm1lcjArUUJiV25Bd1pUTUl2YTdBRUZY?=
 =?utf-8?B?SmlQMWY4ZC9OSGJ5Sy9aVklYekhPdHQxVVZ4SUNzQWlsUVh0em9zbUVHNTdi?=
 =?utf-8?B?V1BYejZ0S1AyNnFCZU1rd2l2c1NRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c0828c-43c0-4ae8-d24b-08d9ae1550f8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 00:08:02.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWy8E5ckIlyekiP291ACAwJ5/Oc8f7tQ8d9AzHcLUsjN7ua88P0Fk2jhVBMyUTJ094PK2Pxfx21trvcVXaFf1D+T1s8Yb6GrhEe/4sQGNJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5018
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10176 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111220122
X-Proofpoint-GUID: rRxshvFv32wr1RW76WwgYM8ohEklUgJw
X-Proofpoint-ORIG-GUID: rRxshvFv32wr1RW76WwgYM8ohEklUgJw
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexey,

On 11/22/21 11:23, Alexey Dobriyan wrote:
> Docker implements MaskedPaths configuration option
> 
> 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> 
> to disable certain /proc files. It does overmount with /dev/null per
> masked file.
> 
> Give them proper mount option which selectively disables lookup/readdir
> so that MaskedPaths doesn't need to be updated as time goes on.
> 
> Syntax is
> 
> 	mount -t proc proc -o lookup=cpuinfo/uptime /proc
> 
> 	# ls /proc
> 				...
> 	dr-xr-xr-x   8 root       root          0 Nov 22 21:12 995
> 	-r--r--r--   1 root       root          0 Nov 22 21:12 cpuinfo
> 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 self -> 1163
> 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 thread-self -> 1163/task/1163
> 	-r--r--r--   1 root       root          0 Nov 22 21:12 uptime
> 
> Works at top level only (1 lookup list per superblock)
> Trailing slash is optional but saves 1 allocation.
> 
> TODO:
> 	think what to do with dcache entries across "mount -o remount,lookup=".
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>   fs/proc/generic.c       |   19 +++++--
>   fs/proc/internal.h      |   23 +++++++++
>   fs/proc/proc_net.c      |    2
>   fs/proc/root.c          |  115 ++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/proc_fs.h |    2
>   5 files changed, 152 insertions(+), 9 deletions(-)
> 
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -282,7 +282,7 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
>    * for success..
>    */
>   int proc_readdir_de(struct file *file, struct dir_context *ctx,
> -		    struct proc_dir_entry *de)
> +		    struct proc_dir_entry *de, const struct proc_lookup_list *ll)
>   {
>   	int i;
>   
> @@ -305,14 +305,18 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
>   
>   	do {
>   		struct proc_dir_entry *next;
> +
>   		pde_get(de);
>   		read_unlock(&proc_subdir_lock);
> -		if (!dir_emit(ctx, de->name, de->namelen,
> -			    de->low_ino, de->mode >> 12)) {
> -			pde_put(de);
> -			return 0;
> +
> +		if (ll ? in_lookup_list(ll, de->name, de->namelen) : true) {

This looks a bit odd, what about the following?

     if (!ll || in_lookup_list(ll, de->name, de->namelen))

But this is maybe just a personal preference.

> +			if (!dir_emit(ctx, de->name, de->namelen, de->low_ino, de->mode >> 12)) {
> +				pde_put(de);
> +				return 0;
> +			}
> +			ctx->pos++;
>   		}
> -		ctx->pos++;
> +
>   		read_lock(&proc_subdir_lock);
>   		next = pde_subdir_next(de);
>   		pde_put(de);
> @@ -330,7 +334,8 @@ int proc_readdir(struct file *file, struct dir_context *ctx)
>   	if (fs_info->pidonly == PROC_PIDONLY_ON)
>   		return 1;
>   
> -	return proc_readdir_de(file, ctx, PDE(inode));
> +	return proc_readdir_de(file, ctx, PDE(inode),
> +				PDE(inode) == &proc_root ? fs_info->lookup_list : NULL);
>   }
>   
>   /*
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -190,7 +190,7 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>   extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
>   struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
>   extern int proc_readdir(struct file *, struct dir_context *);
> -int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *);
> +int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *, const struct proc_lookup_list *);
>   
>   static inline void pde_get(struct proc_dir_entry *pde)
>   {
> @@ -318,3 +318,24 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
>   	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
>   	pde->proc_dops = &proc_net_dentry_ops;
>   }
> +
> +/*
> + * "cpuinfo", "uptime" is represented as
> + *
> + *	(u8[]){
> + *		7, 'c', 'p', 'u', 'i', 'n', 'f', 'o',
> + *		6, 'u', 'p', 't', 'i', 'm', 'e',
> + *		0
> + *	}
> + */
> +struct proc_lookup_list {
> +	u8 len;
> +	char str[];
> +};
> +
> +static inline struct proc_lookup_list *lookup_list_next(const struct proc_lookup_list *ll)
> +{
> +	return (struct proc_lookup_list *)((void *)ll + 1 + ll->len);
> +}
> +
> +bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len);
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -321,7 +321,7 @@ static int proc_tgid_net_readdir(struct file *file, struct dir_context *ctx)
>   	ret = -EINVAL;
>   	net = get_proc_task_net(file_inode(file));
>   	if (net != NULL) {
> -		ret = proc_readdir_de(file, ctx, net->proc_net);
> +		ret = proc_readdir_de(file, ctx, net->proc_net, NULL);
>   		put_net(net);
>   	}
>   	return ret;
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -35,18 +35,22 @@ struct proc_fs_context {
>   	enum proc_hidepid	hidepid;
>   	int			gid;
>   	enum proc_pidonly	pidonly;
> +	struct proc_lookup_list	*lookup_list;
> +	unsigned int		lookup_list_len;
>   };
>   
>   enum proc_param {
>   	Opt_gid,
>   	Opt_hidepid,
>   	Opt_subset,
> +	Opt_lookup,
>   };
>   
>   static const struct fs_parameter_spec proc_fs_parameters[] = {
>   	fsparam_u32("gid",	Opt_gid),
>   	fsparam_string("hidepid",	Opt_hidepid),
>   	fsparam_string("subset",	Opt_subset),
> +	fsparam_string("lookup",	Opt_lookup),
>   	{}
>   };
>   
> @@ -112,6 +116,65 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
>   	return 0;
>   }
>   
> +static int proc_parse_lookup_param(struct fs_context *fc, char *str0)
> +{
> +	struct proc_fs_context *ctx = fc->fs_private;
> +	struct proc_lookup_list *ll;
> +	char *str;
> +	const char *slash;
> +	const char *src;
> +	unsigned int len;
> +	int rv;
> +
> +	/* Force trailing slash, simplify loops below. */
> +	len = strlen(str0);
> +	if (len > 0 && str0[len - 1] == '/') {
> +		str = str0;
> +	} else {
> +		str = kmalloc(len + 2, GFP_KERNEL);
> +		if (!str) {
> +			rv = -ENOMEM;
> +			goto out;
> +		}
> +		memcpy(str, str0, len);
> +		str[len] = '/';
> +		str[len + 1] = '\0';
> +	}
> +
> +	len = 0;
> +	for (src = str; (slash = strchr(src, '/')); src = slash + 1) {
> +		if (slash - src >= 256) {
> +			rv = -EINVAL;
> +			goto out_free_str;
> +		}
> +		len += 1 + (slash - src);
> +	}
> +	len += 1;
> +
> +	ctx->lookup_list = ll = kmalloc(len, GFP_KERNEL);
> +	ctx->lookup_list_len = len;
> +	if (!ll) {
> +		rv = -ENOMEM;
> +		goto out_free_str;
> +	}
> +
> +	for (src = str; (slash = strchr(src, '/')); src = slash + 1) {
> +		ll->len = slash - src;
> +		memcpy(ll->str, src, ll->len);
> +		ll = lookup_list_next(ll);
> +	}
> +	ll->len = 0;
> +
> +	rv = 0;
> +
> +out_free_str:
> +	if (str != str0) {
> +		kfree(str);
> +	}
> +out:
> +	return rv;
> +}
> +
>   static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   {
>   	struct proc_fs_context *ctx = fc->fs_private;
> @@ -137,6 +200,11 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   			return -EINVAL;
>   		break;
>   
> +	case Opt_lookup:
> +		if (proc_parse_lookup_param(fc, param->string) < 0)
> +			return -EINVAL;
> +		break;
> +
>   	default:
>   		return -EINVAL;
>   	}
> @@ -157,6 +225,10 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
>   		fs_info->hide_pid = ctx->hidepid;
>   	if (ctx->mask & (1 << Opt_subset))
>   		fs_info->pidonly = ctx->pidonly;
> +	if (ctx->mask & (1 << Opt_lookup)) {
> +		fs_info->lookup_list = ctx->lookup_list;
> +		ctx->lookup_list = NULL;
> +	}
>   }
>   
>   static int proc_fill_super(struct super_block *s, struct fs_context *fc)
> @@ -234,11 +306,34 @@ static void proc_fs_context_free(struct fs_context *fc)
>   	struct proc_fs_context *ctx = fc->fs_private;
>   
>   	put_pid_ns(ctx->pid_ns);
> +	kfree(ctx->lookup_list);
>   	kfree(ctx);
>   }
>   
> +static int proc_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
> +{
> +	struct proc_fs_context *src = fc->fs_private;
> +	struct proc_fs_context *dst;
> +
> +	dst = kmemdup(src, sizeof(struct proc_fs_context), GFP_KERNEL);
> +	if (!dst) {
> +		return -ENOMEM;
> +	}
> +
> +	get_pid_ns(dst->pid_ns);
> +	dst->lookup_list = kmemdup(dst->lookup_list, dst->lookup_list_len, GFP_KERNEL);

If dst->lookup_list is NULL and dst->lookup_list_len is 0 (which seems 
to be the default state if lookup= is not passed), then kmemdup will end 
up calling __kmalloc_track_caller() with size 0. Each of the sl[auo]b 
implementations returns ZERO_SIZE_POINTER in this case, which is just 
((void *)16).

This is safe to pass to kfree et al. I was worried that if 
ZERO_SIZE_POINTER gets copied into the proc_fs_info, then it could get 
dereferenced and cause a nasty crash. But that can only happen if 
Opt_lookup is in ctx->mask, at which point we're guaranteed that 
lookup_list is not ZERO_SIZE_POINTER.

Just wanted to document why this is safe, as it caught my eye at first.

> +	if (!dst->lookup_list) {
> +		kfree(dst);
> +		return -ENOMEM;
> +	}
> +
> +	fc->fs_private = dst;
> +	return 0;
> +}
> +
>   static const struct fs_context_operations proc_fs_context_ops = {
>   	.free		= proc_fs_context_free,
> +	.dup		= proc_fs_context_dup,

 From my reading of vfs_dup_fs_context, it seems like if the dup() 
operation doesn't exist, the operation is simply bailed out and not 
supported.

339  struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
340  {
341  	struct fs_context *fc;
342  	int ret;
343
344  	if (!src_fc->ops->dup)
345  		return ERR_PTR(-EOPNOTSUPP);

So this patch is also adding support for the dup() operation where there 
wasn't before. Is that significant to call out in the changelog or split 
out as a separate patch?

Thanks,
Stephen

>   	.parse_param	= proc_parse_param,
>   	.get_tree	= proc_get_tree,
>   	.reconfigure	= proc_reconfigure,
> @@ -274,6 +369,7 @@ static void proc_kill_sb(struct super_block *sb)
>   
>   	kill_anon_super(sb);
>   	put_pid_ns(fs_info->pid_ns);
> +	kfree(fs_info->lookup_list);
>   	kfree(fs_info);
>   }
>   
> @@ -317,11 +413,30 @@ static int proc_root_getattr(struct user_namespace *mnt_userns,
>   	return 0;
>   }
>   
> +bool in_lookup_list(const struct proc_lookup_list *ll, const char *str, unsigned int len)
> +{
> +	while (ll->len > 0) {
> +		if (ll->len == len && strncmp(ll->str, str, len) == 0) {
> +			return true;
> +		}
> +		ll = lookup_list_next(ll);
> +	}
> +	return false;
> +}
> +
>   static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
>   {
> +	struct proc_fs_info *proc_sb = proc_sb_info(dir->i_sb);
> +
>   	if (!proc_pid_lookup(dentry, flags))
>   		return NULL;
>   
> +	/* Top level only for now */
> +	if (proc_sb->lookup_list &&
> +	    !in_lookup_list(proc_sb->lookup_list, dentry->d_name.name, dentry->d_name.len)) {
> +		    return NULL;
> +	}
> +
>   	return proc_lookup(dir, dentry, flags);
>   }
>   
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -10,6 +10,7 @@
>   #include <linux/fs.h>
>   
>   struct proc_dir_entry;
> +struct proc_lookup_list;
>   struct seq_file;
>   struct seq_operations;
>   
> @@ -65,6 +66,7 @@ struct proc_fs_info {
>   	kgid_t pid_gid;
>   	enum proc_hidepid hide_pid;
>   	enum proc_pidonly pidonly;
> +	const struct proc_lookup_list *lookup_list;
>   };
>   
>   static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
> 

