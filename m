Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BFA417C92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345693AbhIXUy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 16:54:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3364 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhIXUy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:54:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OKf2r9030103;
        Fri, 24 Sep 2021 20:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5cM1okoj7X//8V7q4Cke4siIP5nVCTbD0HUT8rAcBQQ=;
 b=EBAvJb+5P+46Rn4R9po2yytplffCwBRwLbjPzRNRdpViepH4R9/Bqwgsxjdnw0LHyQ5c
 0msm4uj6gOIRATW6a94uoBqk/QoeP6ozYobp1b4oVKnsdiHS0sS27qVJVlQGQVDbwmPJ
 vbbF4hFyTvViLvQOVgbCCwRPF6Fgp6sxY1N9RH+KPN4poGQNQhSOZsoebe2n7VAoJqeQ
 HFxHIJWlp8PUMhudBo5MTH7WViGnpBo36NQijV3F4zdPNlvEPlKpN6oXX+YaoJdsqxbi
 /JEpJ3AwynyV4pTnBoz9Aum/RaDYWlVVDGhqM+/UE2S/mmmex3yTyREkKiFXV09/cQ+y Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b93eq5q5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 20:53:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18OKowWS158400;
        Fri, 24 Sep 2021 20:53:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3b93fr894v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 20:53:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T53dAOSq1eqW2Ty4xiLDRyIzL0n/6VTIPtxDtPNd+woyI/1oNas67PmlsPZQ1+QQqTsXUSW7g7G2kcj3pbd5j3IXNFDo5QI8BINP0+zyyKr7bASKqF1rq65HFNMc+rIphuhpPszqVAutMAKmsidp17dpiLhTD3FcAgS7yEoLlcrlXFV3FfM86oRXX65b+R6AZd59h7RNVXxOLGZqexoKONk+Lw9DaWo1X4K7nK4Wrtw2falrKy7xUEfA71QjGGnP/cHo4/Wh1XcW+A1sk7tpcV9hTplgjjgjQwtA+YrNksK2e70m1mHqo/7rBUOmL/y7/tOxr/hpzMTYxBX2PKb17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5cM1okoj7X//8V7q4Cke4siIP5nVCTbD0HUT8rAcBQQ=;
 b=VLOdd4egp4I/VPJkAV3k4R0EYVKonsjs1Aly4w/f9Tw1DWVt3r3YyTh1jMaoLMHzSjvj0BvC+ngIw5q9O+s8TNqfDa/XMpD5BDoA87z65nq45au7yHxh6gdiaQYpktce9UQBpo3ebiuxxy8g1+5ygJ64VIB1epq48r2ckUhnDxuBtC2Q35ksEG8HEDjhWHCJzncO5l4CuLzo9UQqG+0ZFHTIAKTaVnzDVepZbrcUTqTtTRF8WHYH5EFlKDl3bArAIjQTrJGV2Ty0yICdxLPMHYE9/3bubHemc7XHoi4dKPLQM3Qbqg5EiivSHGZupGI91aWsjwBrCyX6NqyYtgcOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cM1okoj7X//8V7q4Cke4siIP5nVCTbD0HUT8rAcBQQ=;
 b=mjPVdLNmhFqYCLf+2n3o8vkIXrgLKZYGKKP+q2IakcpzKL0fODGwnzabtOPpZjKIScjcXPoQaSHi3jW4fGSk6LvwC9y925h0dcOfVvnYpdl9nHDrdkBV/MVTJRYmzSqLNnFQ2/2sSNPieEn+vavmvqUovSKPDg1f7bCrs3b6khY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB5488.namprd10.prod.outlook.com (2603:10b6:a03:37e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Fri, 24 Sep
 2021 20:53:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::1c92:fda3:604:a90d%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 20:53:17 +0000
Subject: Re: [PATCH v3 2/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-3-dai.ngo@oracle.com>
 <20210923013458.GE22937@fieldses.org>
 <9e33d9b7-5947-488d-343f-80c86a27fd84@oracle.com>
 <20210923193239.GD18334@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <d0029c41-a686-3491-3249-1780d5586494@oracle.com>
Date:   Fri, 24 Sep 2021 13:53:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210923193239.GD18334@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:806:22::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-137-27.vpn.oracle.com (138.3.200.27) by SA9PR13CA0051.namprd13.prod.outlook.com (2603:10b6:806:22::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.9 via Frontend Transport; Fri, 24 Sep 2021 20:53:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6844e205-4cdc-4247-c4fb-08d97f9d5588
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54882F242A7C46C725DACFBF87A49@SJ0PR10MB5488.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhSlBQ3hU9fq4q5rWqGtC38LdEIWPRaMhYhrYl0qZIZCAtZFeCXLj8wDbolWdhElNUAba6r9oRb3u5CXtgT+1xdKiqBQmhDOPQEdUhiDS8mM7cH4p9nKx7X6+y2jm4ezw5gU7OAnakkZlZuhGqPS0Eml3hWxLa8uHvpCbcaHRjSDPp8LKleH//D/CUrZa8mbZPC+BYKxaqqavlFWvv7tIC0r/eNqRBBB5E/VrU4Qu7xElnaoA2P16ToeiXFvsxVFYQ9+0fm8tboRLKqxawrGKQrQdJ94OWEa15NFgM+GJYdeeMZ3E316+u7+7MSe9IZ2Jwlr0AW1bJu9z/6kFj8JXseI+XnoEDbxA3jCVyaAyp/6SoTG07Hj1jFfJVIya7dyUqzYA59qCgabfbM/ysQbynkRZTlGVkuZ3sxSNav5ZljEMi6NrNRK2ea5cGhyybGrHKEXNfPZV83yYtN3pUMuSHIXREe0mDH7wKdxi5O2mXUlHlYJRV99KwrovzTqmPfCwjQhZTNyvOiDLSHv1ZzhXq43vleY7P61uNTkrF/7KMzcaOMCFgkqH8QFEwHIC6rLFEVi++Ah9HQ5SvbUKbwk5Whta7TeybzxmdTNNAFKc0a92lWQxYLLW4KDWGj5jd7kzJ28bi3kKi+iwvdaWPK3MPe1bsbqNBCW1zzHtXHSk93tjg++PQuhiiytiQk8CZtIoFFbFV5gEKJ94O9PEHuhNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(4326008)(38100700002)(9686003)(2906002)(83380400001)(53546011)(6486002)(31696002)(66946007)(7696005)(186003)(8676002)(66476007)(86362001)(26005)(66556008)(31686004)(36756003)(6916009)(508600001)(956004)(2616005)(8936002)(5660300002)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9vdExmcDc5bUNJZE4ybnBjeDJzclc1NEVZQms1SVkrUlQzekpGSDJKTEtz?=
 =?utf-8?B?bXV5UjQrVUtnRyttSDR5NXpDcVVFdENMR2ZaQnVVdnc5aFB1UFpjSUdwMHM2?=
 =?utf-8?B?ZzBGVytmZmRrc0V3WG9aTHhJMjhHaGgxOVRIZlNPeDFOTG5xZ0E3aTRUSVVs?=
 =?utf-8?B?Z0REVUxwZEs3V1lKOHpnODRkdkIrZk9VcUdrNmZEN0RJSDZ5OGk5ak9LNzBx?=
 =?utf-8?B?ajRqRkxXeVhWU0FSYzY0eTVUYWc3dis4dEFpdEZ2cG5pbTRhV2phU0VUUWlx?=
 =?utf-8?B?NDR4TGt6THNTOTVDUURiYnJHWEoxbVI4SVV0ZXpEMEliVnF1OEFvNFk4ZFBn?=
 =?utf-8?B?SGdDdFdtT0J1V0lScWhsY3dkRzhIQzhTVWkxMStsbHhPTitwZ2xiZytGbVJX?=
 =?utf-8?B?SVRtSlpWQ2RhZWI0NW16c1lNL2I4WW5xWTdWZEl0Q0h6dWJ6QzA2ei84RXY2?=
 =?utf-8?B?Y0o1UXljcEFsSWdOaHAwUFBhKzhlbm1CR2twM3VpNzRKZmxGZldsMnIxYUp1?=
 =?utf-8?B?UDdTQWdBTUQvVHFHK0ZYbGd3cmxHMlZaQkt1cEhzdzk4emNORjZMUEJ3ZkJZ?=
 =?utf-8?B?WWxCY29PUGIwak8yT3l5WWl6YktoaHdSSncwTmFkMEUrWEE2TVE2UFNyTUJB?=
 =?utf-8?B?V1hxMlc1RTRHcHlDWmhOWm9GR1AwRVNMRDJsNnQxVVhqNEl4RS9yTk1WNkhW?=
 =?utf-8?B?NFdVaWtNcmYzdzdZNGVjSFVMT3prZTVnZitteVVodUQ3TXRMT1BTWVd5RDJs?=
 =?utf-8?B?ZHM5V0JKQ2dTT3pGakE0NDl2dHJHRGZCc1FuVDVuS2JJUEpWclc5djhGZFRS?=
 =?utf-8?B?K0hjSzlKV01WVUQ0eWZKR2JwL1RTOUJMRGZRNEZZV3AwZUNRbDhjbDArVUVp?=
 =?utf-8?B?UGhBbnlMMGJxWTNHVGpVZ3NRcjJkN3dmZWhTWTkyOStZMjB0Mll6eEU1NnJB?=
 =?utf-8?B?MmZ5MC9UVVZ3NEZGUG5JQzNtSEhYbTIya1VWZ3ZJZDErdW50Q1NYS0xicHp3?=
 =?utf-8?B?bElQWEYwMHF0andXdXFLMUI5eS85NTBMNWNrY3V4M3VLVDMzZWZYdXNIbEhq?=
 =?utf-8?B?d2tBREFEeXpOa05tM29yd2VYbUlwRzVnMUFkU3haTlNpM3dPQ3ZxeUNJK2xR?=
 =?utf-8?B?WHZWdFo2UHJXaitoMURHdG5XNmRCM1h0Wkd3akNWRkd0NWl5c2RVMkUzTjh3?=
 =?utf-8?B?L0xaTHM5LzRwdUVXVjhtRFpZTWdDYS9DNDZaSklyQTEzRXZWUFBQSWordHkw?=
 =?utf-8?B?U2R6dXlxOVNUdlBrWGtFUjZFWW16b3p6a2MwRWJsRU9rdll1TWZ0cVphaWs3?=
 =?utf-8?B?WnBMTkZGSDJ0OE92M1hXTGRNcXM5UWVlSDdKTUY3NEloS1NiQ2ZKNEZPYVdr?=
 =?utf-8?B?VkFrU04zcHAzUXlIUzFuanRaemU2WGV0WWJtV2p3R2NINUR4U1hrL2dsa2k5?=
 =?utf-8?B?MU4zR2xwanprMVVId3Q0bll2TllEbXVNNmVZc3o1T3c0OVA2bG8zOGpQaWJ1?=
 =?utf-8?B?OXJvNGs0SkNQY3kzdzdtVTNxS2k4RHk0aHJPczVob01PTVlLb29QWTR3MkVq?=
 =?utf-8?B?UWM2TGVXMkdlalhwNnRjT0padU5xUUFyV2NsQkpOYml3VEVYMnIva3U3N0dV?=
 =?utf-8?B?dTFoUDV5NkQ5WHNCbXdHYzFUMUhKcXlVZW5tUmRySDlud3N2Q3dmWGhxQisv?=
 =?utf-8?B?MFJBcCtYWUhyRllKUEFpNFF3VnlzNVl5TXVSNE9wNW4wS3JXSjhhdlAxZHRw?=
 =?utf-8?Q?30Fjnynz9u4oLRnVIfI2LZRo3JxCRJrx8GOO287?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6844e205-4cdc-4247-c4fb-08d97f9d5588
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 20:53:17.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9zqsgiagseGzHclcA6JLLH+Ii0GLyrrFq05/91xCHBRAEbHb3QUbphFgB0W89Nz9Qtl+dOLyQfTh6tAH1N2Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5488
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10117 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240125
X-Proofpoint-GUID: H6nLZnKSEtaJy9hIbUHxxBiPwc3UosbP
X-Proofpoint-ORIG-GUID: H6nLZnKSEtaJy9hIbUHxxBiPwc3UosbP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/23/21 12:32 PM, J. Bruce Fields wrote:
> On Thu, Sep 23, 2021 at 10:09:35AM -0700, dai.ngo@oracle.com wrote:
>> On 9/22/21 6:34 PM, J. Bruce Fields wrote:
>>> On Thu, Sep 16, 2021 at 02:22:11PM -0400, Dai Ngo wrote:
>>>> +/*
>>>> + * If the conflict happens due to a NFSv4 request then check for
>>>> + * courtesy client and set rq_conflict_client so that upper layer
>>>> + * can destroy the conflict client and retry the call.
>>>> + */
>>> I think we need a different approach.
>> I think nfsd_check_courtesy_client is used to handle conflict with
>> delegation. So instead of using rq_conflict_client to let the caller
>> knows and destroy the courtesy client as the current patch does, we
>> can ask the laundromat thread to do the destroy.
> I can't see right now why that wouldn't work.
>
>> In that case,
>> nfs4_get_vfs_file in nfsd4_process_open2 will either return no error
>> since the the laufromat destroyed the courtesy client or it gets
>> get nfserr_jukebox which causes the NFS client to retry. By the time
>> the retry comes the courtesy client should already be destroyed.
> Make sure this works for local (non-NFS) lease breakers as well.  I
> think that mainly means making sure the !O_NONBLOCK case of
> __break_lease works.

Yes, local lease breakers use (!O_NONBLOCK). In this case __break_lease
will call lm_break then wait for all lease conflicts to be resolved
before returning to caller.

-Dai

>
> --b.
