Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B277D4620B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 20:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351157AbhK2To2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 14:44:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42934 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbhK2Tm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:42:27 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVcVO000953;
        Mon, 29 Nov 2021 19:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7q/grigRWMMLj4/NR5FTPoFjQqAWPHC6nZqJpO9znrQ=;
 b=Pzu6C80cDh4rBVxKmRc112OCBNo291FONUbCV8ir5IUNd/4HJ1eki+eLEH9oJVFoLpfs
 Iwgvnz6w7U68dwcEUZHK5UTztugB9gQfX6EbJ0pOCkI7WW7k+JYC7KlNUeuODcCLEU3X
 zFuz5Hqd8YlizjoU7R9Zdc91vh0rd5BZvKAXao8WrJ7shNR6NHxcfjLHqo1TPRKWMBi9
 aausVa5LxP7gt5bv/68tOOxt2ohm8kIzGVU8YZ8KZUL7lQPacw3lsipvKMeV8OtUO983
 WJVpWJtCE+hK+4thZRgeRRmsfWgsWcjL13LACl9TCyD3gggo6+MFy0uYHY0F8CUcWmso 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt7vehy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:39:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJZZmV142065;
        Mon, 29 Nov 2021 19:39:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3ckaqdbxy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlsRSPNxc9Kd9z1/Wd8NgUzM8dfuFT3sFIRmfI3kKeA7x0kHf/ocVMESGP39tmca0plE4bT/m6GagPhtqcJgA72Wh92KPgYYE6rpc03ep0w9vnQ+CWWmPxnYZILgqQPUlHD4AiV4DKczuY/0Rhwtx+xhVUd5C7A9YHQcijC5MmVEAMT56ZMx7OEyWsc9c2MktOVDYqIN1cV3qhzg/h2THTq7vimjj1G2fYQCZE2djuxskzIBqm8OIGT5EUgPIqRA7f2gGwioVxoiJfoGFGgRv5T41kdt+jm/ydhedXHMB2ITbB9iycCWr5Jd0+ilQ1Id50GNtfalKG30xx8i63KvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q/grigRWMMLj4/NR5FTPoFjQqAWPHC6nZqJpO9znrQ=;
 b=CLcfXj0OgrcdBXSV7zB4LzxJyhyPsTHenoYhIV8NpKENcwBH2EMvVGiXHBsWj6FyjF7v0W3WQdOcL/ZBzQkdXYEdAWLWDLZ8EZGBhWZiIzCsw7RdmtkIBn6kmtgtfzh62sQLP67IaJXXPiX36twztzYz5rynOkhliRa9xrCDitS3W/JHwg4GoT/fdqbYK49qmSflk2h93jzg2AxLMZ+NbCKhJ4yHUTmRMU7PAlksSi6uAI6T9Vw9P/BjHHn6hjESmZ146oyayaEpL7Ac5uStsD2QqDULIKL4uB8kUiC9JIy2mJLMCJ0v776sClbdDR4OJ7gILBfRNnmH87uev4Aliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q/grigRWMMLj4/NR5FTPoFjQqAWPHC6nZqJpO9znrQ=;
 b=fbNa9geiL+vtyxGfgVE/pKeo55DnxFNAl9O/XVn1eyUEXA0agUJVZ+8S4HKzXGk+IEP2et8s8d5SDvNvhKAO8Wolq06aW9XQvWDmqhm6f1w23Y9uVGmyEyXoz1lTnG5tw9ywBaWkT1t7xs3ObU23k1GsHS3aYB8dUmqf415xwAg=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4813.namprd10.prod.outlook.com (2603:10b6:a03:2d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 19:39:04 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Mon, 29 Nov 2021
 19:39:04 +0000
Message-ID: <be11cb7b-c9b3-bbea-b4fe-b10af552975d@oracle.com>
Date:   Mon, 29 Nov 2021 11:39:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <20211129191333.GE24258@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211129191333.GE24258@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:806:d0::32) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.41] (138.3.200.41) by SA0PR11CA0057.namprd11.prod.outlook.com (2603:10b6:806:d0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:39:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0295dd95-78e0-4d24-0cbf-08d9b36fe6a1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4813:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB48138DE5073B947A7F3979AF87669@SJ0PR10MB4813.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2s5dpsUgmNrUgVM/bt03r2ZBMiLi6L9d5wEinpkfBPdMm7jCAGQ6qF+CEyXdZYfy16R1fJIHt+psd3kr2V7vj4/G0L00jpwu8oCfAOZluBps004zkkr1FookSS30vBw21+UVH/4e8d0G+/tXu0D2ziZ8cJLDqV30kRtpropZHCwiLdopTyWOGoosWLpv2ViiGVwe5v60xKzqHgyN96yLqe5j2jJgrPzmq6L/PDEijYF+4DGEefIWGufOWMweQDZcImuFQ75q35k5bgcaasE7DU522I8ZNqJbgeZJxiXhlw2Zhref2UHqt4ttUMHo2iwVv962DJk+bOLnfRK/pH5f0hM7gQjwR1yaWC97kLJZTBQfhmvYk58N2gzGiTCB0xrpRU5pm5rQOCf+RDqWsgbOkOHCr+chbzwCMB66WdukMhS5jRwje6T+ObR7ouT0F9tGHIF5z8HVrUnzAtkEYA4ihLfGBV6xZxTbFSasEoqpUdEohwaxhA2f1GFChfEsV9oJWUVT+hIpNzvBSJ+5/zN9UVkbIhzSSSVkI+VeUtW6J4O8fJWQwm/Okb3//VfW4t225NPjWM5Qc8QHdxtVH/m/v/sSNpLK6ItGtQegYK3DRUSh3gQF/bOjFh7XUfYFbAA5kZeS2RDik5qa8OnFiKzi5nbiQHXfPeFmiKiC7il7+px0/PMSxJwDY/uotQhtks7Oubjwjo7geyB7ld5NF6Yk/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(31696002)(508600001)(9686003)(5660300002)(956004)(66946007)(6486002)(2616005)(54906003)(4326008)(16576012)(26005)(66556008)(66476007)(110136005)(316002)(53546011)(2906002)(36756003)(38100700002)(31686004)(186003)(83380400001)(86362001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUV1L1lTbnlOa3V2UzI0TnpQWVFkaW1nNk9nWU1XQ1N6dkt5dlorT0xRRUVU?=
 =?utf-8?B?Y01wNmE5SnhPYzkrSzJySE1CS1dFSk9LWk90VFJlaFlRQ0k5d0NmeUV5SVRh?=
 =?utf-8?B?TE9Oa2pzQVFyWUVDOEhoYnAzaEZtK0FYODRicnc3eXhZMEJoNWNad3JHZlNI?=
 =?utf-8?B?dzFPK3RjcE5QdG05U3RmQjZ1eklKUVkraGNWdy9JMGVYLzdMWUwvZ1diUldS?=
 =?utf-8?B?ZXorbjVlWVhZTTlLN2NRRVNMd05KYis3d2NBQTNLUlczU1NhNGczLy92SU5o?=
 =?utf-8?B?akJ3R1o2Nk5pT0tYQm5rdGEzalh4dDdTU015bTdoQ1BaL2paOHVabEI3NFRs?=
 =?utf-8?B?YUtDeVJMTGk1aFh6VXh6RWdLb2dxM21XdTdsanU3UTZ0MG84TmowZEt3UHBt?=
 =?utf-8?B?cmxSSUVCY1Nwdy9Edi9JRk42VzdhSlEwZmg2c3FjdjQzRTRiMlVqQ09sUHdu?=
 =?utf-8?B?UWFwWHNhVVBGTkU3ZW9qRDNFMHZDOGVjVWhiVmViNEtqbGVNamwzaEtCUDZn?=
 =?utf-8?B?SnFtTHl2cUl2UForWXNJK2hPcmlZSGxkZU9QS0JtZUprYnFtTU00Kyt3T08z?=
 =?utf-8?B?QWdzeW0ydE8raG8yQU5rYlYvTG94SkM0Q0hveGJaV2FCOWJ4Tk4xUVJsbzJE?=
 =?utf-8?B?aGFFd0V1R3VoODAwNGV6UCtIa1FtTjJCeGR0KytGejNGUm1aeXllSzhjNzN4?=
 =?utf-8?B?RlpNYktmSFA5VHlTbWZtM0JuSFFpZlZFcmR4bFZmL2R0c2Jab2pqOGJkek5D?=
 =?utf-8?B?Tlhia21lMXdKSnR2eGdVM2tWQzlCTmI3V0REM2l4QTRReXczY2NYU3lJU2F4?=
 =?utf-8?B?cjBhYjZUdGlkaW82REUxL05ZTEhUdVI3N0wrTkF1R2pTcXRPOUFXUFhtTkRu?=
 =?utf-8?B?V3dkWlVqdVp1YVdGUU9Zbm1KRm4vWWRhOTh5eU1LcUJvRERxd1hxYTFlaExP?=
 =?utf-8?B?cFFhVG5JT2J5QS9ReFVINlZNVE8yNlF1V0hLUzhHNGd3dFVQMmNmaVBiRllq?=
 =?utf-8?B?RjhxOVZicHBwRzMvWS9mZUJsbGo0aUs4THM0SmtKOVNKY2tlN3pLWjBtMm1T?=
 =?utf-8?B?SW9uYmJxL0VjNTBEVDM3YmJiSDJQdXNVbW5Hdkl0OWM1RzZmeWF2NWsrbW02?=
 =?utf-8?B?ZDVPSWpZc3Z4ajdGTmVQVmVtbGVVZ0VWRVFUM2JnSFd6Nm0xcDZHTzZOWE5r?=
 =?utf-8?B?cC9wNWdWTVVFdnBiY2d5NDh2Ym5NT1JPdHlQOUhVeGNNYk50blF0Yy9vczRF?=
 =?utf-8?B?Q1RBZ3oxc2JTK2tWRVQvVERsYWU1U1IyNUl3YjZsd2lqdldsdHo1WVJxOCtv?=
 =?utf-8?B?WEt0Rmh0a2hTUlFsL25qZmVTZlhPQ2QyeDdBdkJoNTMxQ2ZmaG9zanU5YTA3?=
 =?utf-8?B?dS9XWEtzbHhMcEtXSlpHRnJUNWtuNDJLU2FEbDF6U2E4OVZBL0ZZVXI1Rml4?=
 =?utf-8?B?aGRFTEZ3UFhuMHlLRUx3a3FsYmNUZzltTUlKelNNYis0OWpya2xJRnVZNi9O?=
 =?utf-8?B?c254c21QbUNnaXNDSjlsN0dEbURYblc5ZU02TGJ1U2hmeEtwN2FrRWRnWVd0?=
 =?utf-8?B?ZlJrYXhUcHdEZDhTejllTzNYOU9wbmFnSDY5WGcxRW04NnhjSHp6RzZ3c05i?=
 =?utf-8?B?eFVpTENkSU5HdmhudTVrandrSmY0YlBMYUVWMzN6YU9ZUksrRDZvSUMyTGJ2?=
 =?utf-8?B?ZjJYZUd0bDJsWDhscDJoVjJ0bVlBWmlSMDZQdVpGMzRyZUpMNEdzRW15N1dh?=
 =?utf-8?B?UVZOMWdiakFLalI0RERTemlRYTZPQk5iaFJCZkF0TGN2YzZ6aStSWHRUT29R?=
 =?utf-8?B?UnFYVzJvSFJmeWpRSk04Y0lOS2M0QmVjU2tVM3YwVzh5L3pyODZ5TVZWZUhU?=
 =?utf-8?B?VG1yb2xOQlp5VW8xcHk1YW1nenl3d1pLZkluWFF2aHJsMzY2QnFnMnl3SVhs?=
 =?utf-8?B?QVN1cTQ0T1ozODJKRE9UR3YxNzJoUEFOZ0M3OUoza3ZlenRlSDJMM0JtZUR6?=
 =?utf-8?B?bW1xVE5YWXZ4K1I5NS9FODVVMHhncHN0MWRtU2w0ejVUTFhrR3pKWjhqM25v?=
 =?utf-8?B?ZEY5L3hVNG5mTWR5c2dROTlka1FIU1JVS3FBbnlwamJzQWQzenpBRjFaVFFx?=
 =?utf-8?B?WndYMDBGZzk2andOMDRDV1I0VkszZkp6WVFLY0plVk11eTRJU09KNm1TcHph?=
 =?utf-8?Q?ZQaEZx3w+/y72SM9Dvo/hcA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0295dd95-78e0-4d24-0cbf-08d9b36fe6a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:39:04.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AA6OQTUFcW050ghWG/7/77QFAMB7f/xmY++doxlFWAyBVZiZoq8B1jRBVtERwkkMydDstIqiLzCzvKBInS5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4813
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290091
X-Proofpoint-ORIG-GUID: 51a7ye1pDCgTmj7cE0mNoMGFebWJF1Dt
X-Proofpoint-GUID: 51a7ye1pDCgTmj7cE0mNoMGFebWJF1Dt
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/29/21 11:13 AM, Bruce Fields wrote:
> On Mon, Nov 29, 2021 at 07:03:12PM +0000, Chuck Lever III wrote:
>> Hello Dai!
>>
>>
>>> On Nov 29, 2021, at 1:32 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>
>>>
>>> On 11/29/21 9:30 AM, J. Bruce Fields wrote:
>>>> On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
>>>>> Hi Bruce,
>>>>>
>>>>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>>>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>>>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>>> Just a reminder that this patch is still waiting for your review.
>>>>>>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>>>>>>>>>> failure for me....
>>>>>>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
>>>>>>>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
>>>>>>>>> seen still there.
>>>>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
>>>>>>>> 5.15-rc7 server.
>>>>>>>>
>>>>>>>> Nfs4.1 results are the same for both courteous and
>>>>>>>> non-courteous server:
>>>>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>>>>>>>> Results of nfs4.0 with non-courteous server:
>>>>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>>> test failed: LOCK24
>>>>>>>>
>>>>>>>> Results of nfs4.0 with courteous server:
>>>>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>>>>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>>>>
>>>>>>>> OPEN18 and OPEN30 test pass if each is run by itself.
>>>>>>> Could well be a bug in the tests, I don't know.
>>>>>> The reason OPEN18 failed was because the test timed out waiting for
>>>>>> the reply of an OPEN call. The RPC connection used for the test was
>>>>>> configured with 15 secs timeout. Note that OPEN18 only fails when
>>>>>> the tests were run with 'all' option, this test passes if it's run
>>>>>> by itself.
>>>>>>
>>>>>> With courteous server, by the time OPEN18 runs, there are about 1026
>>>>>> courtesy 4.0 clients on the server and all of these clients have opened
>>>>>> the same file X with WRITE access. These clients were created by the
>>>>>> previous tests. After each test completed, since 4.0 does not have
>>>>>> session, the client states are not cleaned up immediately on the
>>>>>> server and are allowed to become courtesy clients.
>>>>>>
>>>>>> When OPEN18 runs (about 20 minutes after the 1st test started), it
>>>>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
>>>>>> server to check for conflicts with courtesy clients. The loop that
>>>>>> checks 1026 courtesy clients for share/access conflict took less
>>>>>> than 1 sec. But it took about 55 secs, on my VM, for the server
>>>>>> to expire all 1026 courtesy clients.
>>>>>>
>>>>>> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
>>>>>> timeout and OPEN18 now consistently passed. The 4.0 test results are
>>>>>> now the same for courteous and non-courteous server:
>>>>>>
>>>>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>>>
>>>>>> Note that 4.1 tests do not suffer this timeout problem because the
>>>>>> 4.1 clients and sessions are destroyed after each test completes.
>>>>> Do you want me to send the patch to increase the timeout for pynfs?
>>>>> or is there any other things you think we should do?
>>>> I don't know.
>>>>
>>>> 55 seconds to clean up 1026 clients is about 50ms per client, which is
>>>> pretty slow.  I wonder why.  I guess it's probably updating the stable
>>>> storage information.  Is /var/lib/nfs/ on your server backed by a hard
>>>> drive or an SSD or something else?
>>> My server is a virtualbox VM that has 1 CPU, 4GB RAM and 64GB of hard
>>> disk. I think a production system that supports this many clients should
>>> have faster CPUs, faster storage.
>>>
>>>> I wonder if that's an argument for limiting the number of courtesy
>>>> clients.
>>> I think we might want to treat 4.0 clients a bit different from 4.1
>>> clients. With 4.0, every client will become a courtesy client after
>>> the client is done with the export and unmounts it.
>> It should be safe for a server to purge a client's lease immediately
>> if there is no open or lock state associated with it.
>>
>> When an NFSv4.0 client unmounts, all files should be closed at that
>> point, so the server can wait for the lease to expire and purge it
>> normally. Or am I missing something?
> Makes sense to me!
>
>>> Since there is
>>> no destroy session/client with 4.0, the courteous server allows the
>>> client to be around and becomes a courtesy client. So after awhile,
>>> even with normal usage, there will be lots 4.0 courtesy clients
>>> hanging around and these clients won't be destroyed until 24hrs
>>> later, or until they cause conflicts with other clients.
>>>
>>> We can reduce the courtesy_client_expiry time for 4.0 clients from
>>> 24hrs to 15/20 mins, enough for most network partition to heal?,
>>> or limit the number of 4.0 courtesy clients. Or don't support 4.0
>>> clients at all which is my preference since I think in general users
>>> should skip 4.0 and use 4.1 instead.
> I'm also totally fine with leaving out 4.0, at least to start.

Ok Bruce, I will submit v6 patch for this.

Thanks,
-Dai

>
> --b.
