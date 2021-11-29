Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7380E461E98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 19:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379903AbhK2Shp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 13:37:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43582 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378950AbhK2Sfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:35:42 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATHRJNO002230;
        Mon, 29 Nov 2021 18:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Cx21rUvUxjrU7CTi2fpQs7nN14PmWvQvsjfEfoQlwEs=;
 b=C1UkxcevRKZssP3Yq3kptFGzBZIlEjaAjkeD7A929gebhBw5EmwQmqeMVKi8BfY7Hq8i
 F+DieeB/SM2dGACt4azsHTWl8F3MVDtwjOvNxNGX88x0W9rDbO4lWivrcW1jOVYZvQq0
 nlUZdA1R1Fbo+JtxUIF0UmkOjuOv+BcGyMcps3wqfh8bfVK0LUeU0Pl05onBmE8YDvjU
 5wgZ3lQ/+fbIoqlzA4wZmQ/Hafk6dqTvxSdXomdgM3PsBQmqAB9bxOnau3dAndBhDHMB
 yJ70AA67FvRdP0t/qy52ITEc/23QB+bv82mBCk+mxf7BJ3GS0B1/z3T5So+9PMVM1juC Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wb9b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 18:32:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATIBaSn139258;
        Mon, 29 Nov 2021 18:32:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3030.oracle.com with ESMTP id 3ckaqd93pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 18:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6IIUsAXZHrFEG9D0+4pnN3lTRa6zlxc373cPmudtrdDeUivAv83XL7GrLnXpo+vawNZxd8N7ok0UBQXNYHAnrK6veN5tTGT/GWcKuQ5vfngt5q1LrfthnRjSCGNIGt8a5N3QMei/1914ECBTyoTHz8061ecxxihhh6R3Ha37AK7aJaHIkzwCnVjsG9keKDS0F98nvSk5uIqSJhlgrobx42uwOE5dfawFbkaWwfQVyaYTFJtJAJaXsjETpsaG9Egw5ETTd6B7COutt0U1O2eSguCvE1zdLuFYi0TjckS2CW+TTqTf2TvyUfNUCAp3uYk44gh5zTt3oMyKrIpApeD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx21rUvUxjrU7CTi2fpQs7nN14PmWvQvsjfEfoQlwEs=;
 b=Bz7DS0tJgRP/Jv/VAI62oSUktSTp6eyXM/bObt53pz4JZBeCJB4so0vm730XeCHk+i/7+3ILr7HO6K/sKaJ81nO43/zf6uA8Qo93SBfict6eCHPW+1hL6YCfwO86sykHBpbVczQ3NQyL1vd7jXoAr4dlYdPfG/2frUYcTBjsBC4QcwBC/53quiKcYK5kf63JkDEq/+ECf3CQVCizKu/SNGN1MFTbdlqpYb5glsPU7LRlaT2E2aEF6vobbuLxx+nGQvaxUcDSa7T3hxMLjAgYLCe9jEgbaub0z/STntclWH8HWPbBVsCZjltn7r3mXS+wo1IBQ0lUhMq4RlDbE+hMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx21rUvUxjrU7CTi2fpQs7nN14PmWvQvsjfEfoQlwEs=;
 b=UiTu+TG1q8er6g9eX02SfMa5za6OZJDs7J8XzUG/0nmmAyWYAnFRDJaB44YpeTfRO6zPloCTejWPvweZIy9o64ty73U803Wvm5BSwh/Nu2KhqwvbbpHB9dVppn17hsdLKhtGDQ4wveEpeisWXj57aMJI5JmvNligZS0E4v9WLS0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 18:32:12 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%7]) with mapi id 15.20.4690.029; Mon, 29 Nov 2021
 18:32:11 +0000
Message-ID: <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
Date:   Mon, 29 Nov 2021 10:32:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20211129173058.GD24258@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from [10.65.137.41] (138.3.200.41) by BY5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:a03:1f4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 18:32:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6509019d-778c-422b-933b-08d9b3668eff
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4495:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44954A0A71F8142F5106A6A787669@SJ0PR10MB4495.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A03J14HvRUU7p8GJ25S0aazKQuaVVagxvRxI3sko7Bo98Yh8VLDlz8iaknSfg5hLs4Fca9cdY2gWYT/KVCwGtBZYkxWy2wQtj65laxnGAKp6XEvDgi2/LHiTum0ziI2JJoG8XD8mPb1iGyf6HxBORfSMUqr6HXeyE8nxr6o4Rnb5fjzJvzP3kvZuxYza6N/NpNCIxle86q6Oi+WyQiWR/U6c15+yGLy6/qaAm2geprpFV8WXC6zDvLIweEydlFaGeFsvvfCuBkb5apPg5tZJo1kH2L6NmH4mkJE1XxK5fKeMk98sMdNhGGTc5x2Uq2QDbXCaV8HGPKgUYK6chcLdq6QnR/ygsDrTCe52Zm0PQdh+nQL+xOeljeYY+wFXbtJy0/1J/KSYKlWwkVeLADY8xjUXxCrB6YGIDiffHELA9L3IgroNpTPpFumtCyqH4zrXaFXHpkdXhhFTjg8DMYTXUx3kutUX62lSG6HqF8VeP0h/eNjQrVDVPhgZjLgtUD4AKUpyyiuq87UK30WYDMrMVjm6pMquTD64m99fascXDAUNhPmeTD7zdFMZvrCMct0c1LMTjsSw/6jkG6wUIi6bzAVYiwQGfasv5FW09523wRQZ1dCF5nOEZ0gAk5MWBYhMwilemlnXeuUdQGz1qE8sGl3Kf09Wb0CRn+M4gZrcMxAHTlSYfEB7p++nO88Ojkcv4Tf0XxNpyDaJOsh/43Jnyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(9686003)(36756003)(8676002)(8936002)(2616005)(956004)(4326008)(508600001)(66556008)(66946007)(66476007)(86362001)(31696002)(26005)(6486002)(2906002)(83380400001)(186003)(5660300002)(38100700002)(31686004)(16576012)(53546011)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJGNHpPRFJ3V0pqVHMrTHpBeVFLM091eUlMcHk5YjJlZ0FVdGRUL0pHYlJq?=
 =?utf-8?B?eWt6YUVqM282V1AwK3AvcXZ5NlRpNUw1aXNVT0F5ckl1NUxVQ3QzSXo1eXNr?=
 =?utf-8?B?WHlYTVZBaVVUZUd5RmExWTIrNUJRYnE3UWE2TUt1NkxCS2QxQ20yQzVXSnBR?=
 =?utf-8?B?eGVNOGxBUzg2aGtjQlRDWDE0S3BjQ0ExVmw3aXNHV3FvM092a05Kd09SU3By?=
 =?utf-8?B?R2dPOVpKWTRjdWFFSGNyYjRTMWhtWlBaQklyWDI3bXBVN2lNeURRZ2tNYXNh?=
 =?utf-8?B?RDU2WlR4bC9OWWxWQjVLa3d5ZnpWdW9DcDZRNnFlS1plVHlVQzJMNWs3QXZJ?=
 =?utf-8?B?K3E0cjF2UkVPNnhpWUNwS0xJSlY2ck5YTGlnUTJlMkdTZDQwZ2JZTGFMS3Bm?=
 =?utf-8?B?amcwcVhIWDhSTXdCUzdPNkxEZTZwK3ZSMUYyem5YWVNBRGVyaGlwSml5UER1?=
 =?utf-8?B?SXFXeTBHSkI3M2k2MkFrU3pqY0hURWVOUEkvTGFzTzZEZWhDc0hLc2RoQlZP?=
 =?utf-8?B?eUw5Z1FsNzU0V21HaTBoaU5UdVJKSUdqT05yUE5US090MXR4bXBzcWdROE9y?=
 =?utf-8?B?d0k2cHoxTWVXSUthUWZWWlVYeXllWUZqK2d2TTdhNnFZVG5xQzg4d2Y2V093?=
 =?utf-8?B?TFRrTThlTHg3bjJySFhlaE52QkJMSGIwUE15V2ZiZG9ma0JhN2ZabDNDeFlO?=
 =?utf-8?B?eU4yNTN4cEUzSVpUN0JRWHJyUUhiU2lBUUE4TWRUbHpzcmp3d0M4TDZ3UGVM?=
 =?utf-8?B?MWM1bDJYVjk4VDU4YkJCTVFGOXE5eVlLbU9SNEc4T1dlYTljUUp1dkhuK0F0?=
 =?utf-8?B?MEtKMm1LOHQvQWl4UzFKdFZVOHFEaHpPOXJHYXE0QmYyd3Z2dmdNQ3N1WFRy?=
 =?utf-8?B?TjhGb0pleWNlRXpRS25Od3JZU3A5djQ3WXc5Yzdsb0N1OGh5MW8zUlpjWlFE?=
 =?utf-8?B?RDdYalNNVnhjdlJaUFF4dG90VnVNbmpHS001djlPaUlsVlFmU00yK09xR2pC?=
 =?utf-8?B?aHFtdEVkVVBCa09ZZDA2MTRwT0tOWTdjeklKVlBZc0NUN3dvTU9lQTREc3c4?=
 =?utf-8?B?eG00b3JpYUUvai9PZk1ZWlpRZnJ3L2tHWWdnM0xGdXc4R3R1WkZrMm9lcnRk?=
 =?utf-8?B?UHEvOUc3UFhLRy9zWnhPUFUzcEx3ZWtwbjFBZ2JaTVdCYUU3NGdBQmR3dDVJ?=
 =?utf-8?B?M1IwVmNuRFVvZm96bmFaZEEvenpIWVJUWTkzbCtwdis3NHJ1L0RWVVJWaU03?=
 =?utf-8?B?UzFOb0czN1I0Z2JjQjZacXM0eHBJZFhOTmYzVHU0enYxbmtid0R3NitRWmJr?=
 =?utf-8?B?NWpWVCtIaSt1WFc5bHJXKyt2YWxSZEF6WVBCek42OFlWb1ZzdE9IOUQvRUFq?=
 =?utf-8?B?SWorRWVtRjNSS0hwdElMVEpJU2wwQUVHYS81NG9iSmZIQ0Z0MTNSWm80eWt5?=
 =?utf-8?B?dHNNZ2RKdGM1UlhwdVdlL1cvamkzR21HL1RWMkpzM0RLZVpJNldTVFdVSkpH?=
 =?utf-8?B?NThTNy93cHFwV1pBRE5IdGw3WHJoQW5QeVcwRDNoS3RnaGxnbFRKQzdIZHF3?=
 =?utf-8?B?WXRLcE1qd0k5WUpzMVlzQTBMRkVzMFd6ZXIvUTZnbGV2MkR5bVpHM01idmZR?=
 =?utf-8?B?eEJoM2FXVXBFRnNyUTBMcWwrZWY1ZVVVQVFSUHQraW94WVZQbVhiMHB2Qzhz?=
 =?utf-8?B?M3VHbmhRZ2lUT1hrUTdLTTBZRTdiQlFvTjQydTkwczF5M1lGZUZqYW8rQ0Zr?=
 =?utf-8?B?aVNhYndSd1BOdnJaZXZSZnB1aFZ3enJJNjUwQW45cEhQbGJGbFQ1MzErMXNP?=
 =?utf-8?B?VFJ2SkU0cGpvd1VwS0FlOGVNd0NUbWkvdVdvOE5TTDRUdmJGT0lSaDF4TWxM?=
 =?utf-8?B?RnRXTWUvKzNzK0VFRXY3QzM2dWdpaWhpdElscndDMUR4aFlrUk1WTlRuUm02?=
 =?utf-8?B?WGxocFRQQldtR1gxUjBVeXBBdTFkM2pHWDU2NzU4a0RsL3oveEJmNlhaMjNP?=
 =?utf-8?B?L1ZWdVUxYUhDd3pYVmFJMHhlSkc3UENxZ1N4UUltam45ZG1iRXJvcXI5OVZG?=
 =?utf-8?B?VzFGMHpOTzArU0xFdHhGczRxbUxzbkh2UklzWC9PTHJBbTZWWGJoeWNpTjFv?=
 =?utf-8?B?ellORU82eklLb0FBRnZpOENISFl1dlB6a0ZnSDZZNGEyeGJ0TklUa21RbU5i?=
 =?utf-8?Q?Cs+krxOk/w0/EvepC8a6glM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6509019d-778c-422b-933b-08d9b3668eff
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:32:11.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayIwNuMChh42zZ4ph1nlezLPPdV8bajmocmkAkYrngBb/hYMGgSMdwByzRxEw1hoRDb8JnD1NL17rpzG98BKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290085
X-Proofpoint-GUID: IVl7HW7FAbu42NVimV9-Jc9Zi8TjaBGV
X-Proofpoint-ORIG-GUID: IVl7HW7FAbu42NVimV9-Jc9Zi8TjaBGV
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/29/21 9:30 AM, J. Bruce Fields wrote:
> On Mon, Nov 29, 2021 at 09:13:16AM -0800, dai.ngo@oracle.com wrote:
>> Hi Bruce,
>>
>> On 11/21/21 7:04 PM, dai.ngo@oracle.com wrote:
>>> On 11/17/21 4:34 PM, J. Bruce Fields wrote:
>>>> On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
>>>>> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
>>>>>> On 11/17/21 6:14 AM, J. Bruce Fields wrote:
>>>>>>> On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
>>>>>>>> Just a reminder that this patch is still waiting for your review.
>>>>>>> Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
>>>>>>> failure for me....
>>>>>> Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
>>>>>> all OPEN tests together with 5.15-rc7 to see if the problem you've
>>>>>> seen still there.
>>>>> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
>>>>> 5.15-rc7 server.
>>>>>
>>>>> Nfs4.1 results are the same for both courteous and
>>>>> non-courteous server:
>>>>>> Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
>>>>> Results of nfs4.0 with non-courteous server:
>>>>>> Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>>> test failed: LOCK24
>>>>>
>>>>> Results of nfs4.0 with courteous server:
>>>>>> Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
>>>>> tests failed: LOCK24, OPEN18, OPEN30
>>>>>
>>>>> OPEN18 and OPEN30 test pass if each is run by itself.
>>>> Could well be a bug in the tests, I don't know.
>>> The reason OPEN18 failed was because the test timed out waiting for
>>> the reply of an OPEN call. The RPC connection used for the test was
>>> configured with 15 secs timeout. Note that OPEN18 only fails when
>>> the tests were run with 'all' option, this test passes if it's run
>>> by itself.
>>>
>>> With courteous server, by the time OPEN18 runs, there are about 1026
>>> courtesy 4.0 clients on the server and all of these clients have opened
>>> the same file X with WRITE access. These clients were created by the
>>> previous tests. After each test completed, since 4.0 does not have
>>> session, the client states are not cleaned up immediately on the
>>> server and are allowed to become courtesy clients.
>>>
>>> When OPEN18 runs (about 20 minutes after the 1st test started), it
>>> sends OPEN of file X with OPEN4_SHARE_DENY_WRITE which causes the
>>> server to check for conflicts with courtesy clients. The loop that
>>> checks 1026 courtesy clients for share/access conflict took less
>>> than 1 sec. But it took about 55 secs, on my VM, for the server
>>> to expire all 1026 courtesy clients.
>>>
>>> I modified pynfs to configure the 4.0 RPC connection with 60 seconds
>>> timeout and OPEN18 now consistently passed. The 4.0 test results are
>>> now the same for courteous and non-courteous server:
>>>
>>> 8 Skipped, 1 Failed, 0 Warned, 577 Passed
>>>
>>> Note that 4.1 tests do not suffer this timeout problem because the
>>> 4.1 clients and sessions are destroyed after each test completes.
>> Do you want me to send the patch to increase the timeout for pynfs?
>> or is there any other things you think we should do?
> I don't know.
>
> 55 seconds to clean up 1026 clients is about 50ms per client, which is
> pretty slow.  I wonder why.  I guess it's probably updating the stable
> storage information.  Is /var/lib/nfs/ on your server backed by a hard
> drive or an SSD or something else?

My server is a virtualbox VM that has 1 CPU, 4GB RAM and 64GB of hard
disk. I think a production system that supports this many clients should
have faster CPUs, faster storage.

>
> I wonder if that's an argument for limiting the number of courtesy
> clients.

I think we might want to treat 4.0 clients a bit different from 4.1
clients. With 4.0, every client will become a courtesy client after
the client is done with the export and unmounts it. Since there is
no destroy session/client with 4.0, the courteous server allows the
client to be around and becomes a courtesy client. So after awhile,
even with normal usage, there will be lots 4.0 courtesy clients
hanging around and these clients won't be destroyed until 24hrs
later, or until they cause conflicts with other clients.

We can reduce the courtesy_client_expiry time for 4.0 clients from
24hrs to 15/20 mins, enough for most network partition to heal?,
or limit the number of 4.0 courtesy clients. Or don't support 4.0
clients at all which is my preference since I think in general users
should skip 4.0 and use 4.1 instead.

-Dai

