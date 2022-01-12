Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAE48CB7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356449AbiALTFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 14:05:15 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63144 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356445AbiALTFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:05:13 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CGxclH001641;
        Wed, 12 Jan 2022 19:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uFcRKuR7HH5rvXdeloawgpFNk9MN4vlQVZns6nruJM4=;
 b=i3PDCx1Y/2p6Tkq2oPSwgeG7hnmalfFuZfi/qBI32cPPd71zeucgj1YrbQN/bB30Sqjf
 B0W5eea71BFlDk4ob4sYFsBwp0hZWqxh/bU7gIxUj5Ao0FBA7a/8spSVhu0uiaofuQ2y
 PwWcte8wKbN9d8fyZUfxtuJjrwnIysNgpeDHR3J9Kw40zzm/7Pe7Fpn37CDH+4yJZIaZ
 2H//c9Ukg25rF69Psb99qHXrgerpmEJpVsK/zoNX7A2e36EWiN/kGH7IT3fSLJJE2fWi
 c/BH6ZeiQdJVzfnWPxk4RxdEGQRqeXcqoxE4aMEsVojgAMgFOZwkd78/VCPTsAFdbs8+ Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbyhau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 19:05:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20CJ1gex140661;
        Wed, 12 Jan 2022 19:05:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 3df42q2nk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 19:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRSZMG6t0arcVaQ7eoyYL76c+SI4w7XD4/1GE+Aoy3Xjc4qB6DAH5kyqahyx+hsqsBQ6npNTYA6T2eKZAn+D7QjCMRPfcE0nrS+2LelineDpsh3xHDUq21UmI499PGIIdWP9jQc+EGLGZIAmFJw/prg4PSnrWxCDKiAwypt/yDHOgd7eWqNL8wSugEWZgfueXVXLC8JarlfOZGprTPzVhCDjzrsxffaabQFJgf+5MrhcUILXmIivbuB7l6CJKI3J5NxbCdTqMr5sXIYIV7BPSV/F4PDNEbQ8HloBUvdEW8COqTi3Ri+REnVe47UPqJHDhBeKaGLkj97gx3RXzUBUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFcRKuR7HH5rvXdeloawgpFNk9MN4vlQVZns6nruJM4=;
 b=V/tUhA/Xhnrr+v3wXMqCYz7jIbdkoB77yKTO63RpnuEO5qdX+sXFfpbJzdrg0PsHOthPFG7Ev+ULQWslpfSrFEX8x/NwmYAUQOLlxMMsR5RK3f+7OFTja403olvnhqebYArAUP/vF6rnnNfokAL/irLxGD6iyFYmRt5SD+WextAzFHeG3khHsHTDz09ixSXIxzkkTHBtkuqGCXkTYOMwcqhGKuYIUscP9fXR0WSqmew//lZhXwB0W8PM/7JuLhMykSQ3xkmHXUHhy9fHVrADkiqv285F7BYE/KioUydukORc5ztvu3uHlFnyXxj8duNhTeUumj/f1Q64/9m2yoCOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFcRKuR7HH5rvXdeloawgpFNk9MN4vlQVZns6nruJM4=;
 b=B5KQcVgzE8dc24wptniI9j0gLjbkE2+NS/hf5eD8ZWzoAyXT/rFjSC/jxpD5WvzIJzZeTxlp+ejjMbG4MHw2XRkoFfP6oW+yb2emfuSDihYM2K/+OvdB6VM5FxTqZGHB1NksKbu4Gh31Abh45sOPZI/wAmVnwiW+qGw8BrG4fy0=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BY5PR10MB3906.namprd10.prod.outlook.com (2603:10b6:a03:1f7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 19:05:05 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2531:1146:ae58:da29%7]) with mapi id 15.20.4888.009; Wed, 12 Jan 2022
 19:05:05 +0000
Message-ID: <ad62d8d1-f566-ab6f-8c74-38ba2d053d89@oracle.com>
Date:   Wed, 12 Jan 2022 11:05:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH RFC v9 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1641840653-23059-1-git-send-email-dai.ngo@oracle.com>
 <20220112185912.GB10518@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220112185912.GB10518@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0031.namprd05.prod.outlook.com
 (2603:10b6:803:40::44) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e44f74a7-44a7-48b4-b4a3-08d9d5fe71b6
X-MS-TrafficTypeDiagnostic: BY5PR10MB3906:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB390615127977B934EB9867AC87529@BY5PR10MB3906.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+Sr4ZfybZ9uAMyvdWNw7PbfNynp51LOVIw80xh5iv3zZSNrh5nOyVtdNS2F7cTRlodF+7A1rm40eMizWfWcg5zqky5CioYeJPsvaAjz3Wm3yBW6Ezu/Lgu/wYGR7Hf51cnmxnHQz0aLv3O8FthYWQfZ5S3W7dGL++HMTsSgiDd80nJH4ayw2MM2mkgfKO6HXT4GUaiLzmJEJkBE49r+Y1XDHiWEs4LfMbrMXMXjPEVCoSfeRl0+He/Z2kj6WZKUtHhGY00H3Rhu8ter7tt6df/8tYcfMXwtK15Ds0oAe49aSvd7tVm4yQMrSy8h4qMS0NLi567W2X1lT8LiKswWTP+2cmyjxsN2K2iFeRSkLZ/Zf+Im3Krg5oxsyT3q8SLYg8aat0UiG2tuQpcDW2BTvhJfxMc2HwZAIK8R8Eol2EajSKTt1JVE5/yMEdiRyOvgVPK5zfuh1WCqqPl8NxmsAKQC23Z3dL7fLQxFbOA1zPsjIrPigTQa4ajcWWGdVtuSj1mL95Lwt/b0O6rFrIgEyxZpiX800TDthieGXx8IbirHfPdUASXVrTahPFaaE1ScsUCR6UbdUxH1ia/LO6MsJVxJ/JEtMF43GymB1jVvIAwr5qxDVeWZfYBl4oMgFU2N/PHdCeOTHn0qoUOQWStmKzIa1IiEBpDwMTb491PhRo5C2HC8p5K8RtZbIyqJIb4JT7GjbL4oJRpIlcEXSbd8tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(83380400001)(6506007)(2616005)(6512007)(508600001)(31696002)(5660300002)(4326008)(9686003)(6916009)(26005)(86362001)(6486002)(38100700002)(8676002)(31686004)(8936002)(186003)(2906002)(66946007)(36756003)(53546011)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVk0dEZlTGNjRVBkRm9FbmpRQ0JrMThxdkdDeld2THVLeDJXQUYydWF4eXRS?=
 =?utf-8?B?T3lZSkd3TysxSGFuSFBRWGpDSGk2cnR5STRNVmtzcjdKK1FsbUJXUStLaC9V?=
 =?utf-8?B?Tk1YNG82YWNiN2taR1lNWUpJcTdFWVRBdVZNc29mWFRHR1NSNy9oWDJTUjBJ?=
 =?utf-8?B?dkdDK1B6RzV6K3EwckVpZE1JaXY5TjRpd1pDeU4xWlFmcXhSR2pKK2M3bmFl?=
 =?utf-8?B?Nm1iK2h5NTFqMWFRVmRpUFhneG93azNTaForMnpuQ1NxdmJOTThkQ0JQTUJO?=
 =?utf-8?B?bGdsNFFZMkFDSkJlYXRkWXE4WGtCQ3NITW9vVVEwUHhXS2NiY3JXNktyQ043?=
 =?utf-8?B?RXRGUUsvUVoyVVRqbzFZeE05ZktCeElWY3lXSG5VUVVPTmdTNU1iSDQ3SW9X?=
 =?utf-8?B?QzlUdm9zWHlXY1FkUTBJdFpxbmR3R1ZhZk95R1QwaTRRc3JDQUFZRWNsVlF5?=
 =?utf-8?B?WFdLRVltNXFZTHhjTkJTME9TdVhWM0Z4UHJ3SGtzWm5WamEzM2FuK0hyN0xo?=
 =?utf-8?B?WDNERjFubDg0WFBJMmp2clJLd2RRUHFjanFaMVRiZ1daemV5Z0p4MFBjOU5V?=
 =?utf-8?B?QVhNdEdqSm1xK1JqcGEvZURJb0pJbnkxSXE5NDV4V0JZdzZndXB0c2lRMTVY?=
 =?utf-8?B?UlB6OXlTeFlIS3JKWkhZUnNhZ2U4UUdvMzdOWDFkMjhWbFoySzFpN3FFdmNk?=
 =?utf-8?B?ZWJsQmxoeEo3Yjk4enNGTjNZUjVOdU1DR1BFblh5UERQR2ZWVHZjampJRkIw?=
 =?utf-8?B?aXBuRm5leGJpSEJ3SG5tN05DTlhVejl0OCtFMmpGZjVWY0xoanJGYXNLWUY0?=
 =?utf-8?B?ZEVpNWFpZkNUNjVxdndIeFM1elk2YXp1cmsweis3ZGk2Q0FzdGhhT21vaHlY?=
 =?utf-8?B?cnZHUDRnclkydTB3NGFWcEc2S0V4d1NRNWRnQllpdGUweTFPd01ROGxYaG1o?=
 =?utf-8?B?UmlIenFQRW1zZmZPTm8xWU90eGtMbTl4ZXJrWUU0WE5DWXo5UXlwQWRlbUZX?=
 =?utf-8?B?K2FvL0tTT2NlazIvYms4eFpTTHVaenpDaUE4YXBKbUlNRTJYdkEraS9CWkdT?=
 =?utf-8?B?cVFtNlhlUXRoblVCNWRoMWY5NFo3SHJ2OG1NWU9xQUs5MmQ1Y2pSeFNyN3Zk?=
 =?utf-8?B?NUp3VlpINEpMQStVbzdkSzN2OHcxWFcwcUI4MnUxRmFKS0JKcWNiZXR5TUxh?=
 =?utf-8?B?Z2E5VDFtZG5RaWZ0MlJjendwcmxPU1c4TmxUKzJWVGJ4UHRFc0ZReXBtU1BH?=
 =?utf-8?B?Y2ZCazhXeFZxTTdnQkpxU2RUYTNTVmtteUlVZFV5Q25CSVJmYVM3RWNUZVRD?=
 =?utf-8?B?aEpCUGVLdWUwTjdXalUyTjV2RDJYMkxxRjlETXBIM3doaklLd2hpZ2k3VVE4?=
 =?utf-8?B?LzA3MkhJNXVaUDU3N1F6eHc2ZmZoZkl5SFlNdGxRdTA2YnR1VHVLTGNyTlgv?=
 =?utf-8?B?b0lCT0lSQWRqSTQ0NlJRU1ZIZ1pGVnp5NGZPVDJyZ2l6d3diTHJxbUhGM3lo?=
 =?utf-8?B?UzIwRUIwU1EweVo4T0gzdzcwRkJmV1BjeC8zbU16ZkhKNjM1aUMvN3I1eWdt?=
 =?utf-8?B?L2h3OXNNdnRkblhTa1kreldISDJjM1JnTkhGSXlURE85cjZseXpHUUFUdVNr?=
 =?utf-8?B?RE90cHJ6ak5ZS3RMQVhSSDdRaFBiUXlVbmNqQjFFSUZWMnh5V01iWGNzajV0?=
 =?utf-8?B?eXkvZzE4eWwxU0RNTExJVnBTYzB3K1E3NzNTR3BQM3dzQnlRRnFBQ2lkTTFa?=
 =?utf-8?B?cnVJdUNUdDVHaEUvSHFYZkJSMEgvTCtndVFiZ3IyY2ViZ2pFRUFvKzNhcm5v?=
 =?utf-8?B?YnN6RXZlK2Y5aDJtSWhFOHB1MzV5dUpZbW5tM0pwVUE0dkt4VTBpM1BOTGZO?=
 =?utf-8?B?L21ZSzNpaDNKVGRPSVFyZzBDWWxTenM2WVhJSU9YYzROcENCS0FCbXQ2QmJj?=
 =?utf-8?B?LzdhRzFjZ1l3YU1QaHVhMXNhV3ppc25keUY5UEUrTEJDakxLeDdwTy9Jd21k?=
 =?utf-8?B?b3ZzaW84cjhhY3RUN2NBajRiTGM4V3d3T3MzNDY0RkczSVBvcDkvVXJwdEdR?=
 =?utf-8?B?b2E2cTc1am1OZHE3Tm5xaWJMTk1iMy9UNUpXYi9QbXVxdzNESkgzUFQ0dDE2?=
 =?utf-8?B?NTZQVXUwcCszZGYvaUE3YklGejVvOFFpQU9Yc1pxb3hIN2E0RDZIa1FhZTc1?=
 =?utf-8?Q?DCUqHWJFT1xwBFaRTzF/j5s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44f74a7-44a7-48b4-b4a3-08d9d5fe71b6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 19:05:05.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAz19G/y+yaJMCivp1EMY7Yc0WHdC7twowGzji91dCAXkk/vFMUlHYas5b7p1HQv3u6kDVnGf5Nagy1oJ6URUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3906
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=970 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120113
X-Proofpoint-GUID: NP_IJKLP_2yVmWyVbw_JlTku8meJ0iMu
X-Proofpoint-ORIG-GUID: NP_IJKLP_2yVmWyVbw_JlTku8meJ0iMu
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/12/22 10:59 AM, J. Bruce Fields wrote:
> Could you look back over previous comments?  I notice there's a couple
> unaddressed (circular locking dependency, Documentation/filesystems/).

I think v9 addresses the circular locking dependency. I will update the
Documentation/filesystems/locking.rst in v10.

>
> I agree with Chuck that we don't need to reschedule the laundromat, it's
> OK if it takes longer to get around to cleaning up a dead client.

Yes, it is now implemented for lock conflict and share reservation
resolution. I'm doing the same for delegation conflict.

-Dai

>
> --b.
>
> On Mon, Jan 10, 2022 at 10:50:51AM -0800, Dai Ngo wrote:
>> Hi Bruce, Chuck
>>
>> This series of patches implement the NFSv4 Courteous Server.
>>
>> A server which does not immediately expunge the state on lease expiration
>> is known as a Courteous Server.  A Courteous Server continues to recognize
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server
>> reboots.
>>
>> The v2 patch includes the following:
>>
>> . add new callback, lm_expire_lock, to lock_manager_operations to
>>    allow the lock manager to take appropriate action with conflict lock.
>>
>> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
>>
>> . expire courtesy client after 24hr if client has not reconnected.
>>
>> . do not allow expired client to become courtesy client if there are
>>    waiters for client's locks.
>>
>> . modify client_info_show to show courtesy client and seconds from
>>    last renew.
>>
>> . fix a problem with NFSv4.1 server where the it keeps returning
>>    SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>>    the courtesy client re-connects, causing the client to keep sending
>>    BCTS requests to server.
>>
>> The v3 patch includes the following:
>>
>> . modified posix_test_lock to check and resolve conflict locks
>>    to handle NLM TEST and NFSv4 LOCKT requests.
>>
>> . separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>
>> The v4 patch includes:
>>
>> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_lock
>>    by asking the laudromat thread to destroy the courtesy client.
>>
>> . handle NFSv4 share reservation conflicts with courtesy client. This
>>    includes conflicts between access mode and deny mode and vice versa.
>>
>> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>
>> The v5 patch includes:
>>
>> . fix recursive locking of file_rwsem from posix_lock_file.
>>
>> . retest with LOCKDEP enabled.
>>
>> The v6 patch includes:
>>
>> . merge witn 5.15-rc7
>>
>> . fix a bug in nfs4_check_deny_bmap that did not check for matched
>>    nfs4_file before checking for access/deny conflict. This bug causes
>>    pynfs OPEN18 to fail since the server taking too long to release
>>    lots of un-conflict clients' state.
>>
>> . enhance share reservation conflict handler to handle case where
>>    a large number of conflict courtesy clients need to be expired.
>>    The 1st 100 clients are expired synchronously and the rest are
>>    expired in the background by the laundromat and NFS4ERR_DELAY
>>    is returned to the NFS client. This is needed to prevent the
>>    NFS client from timing out waiting got the reply.
>>
>> The v7 patch includes:
>>
>> . Fix race condition in posix_test_lock and posix_lock_inode after
>>    dropping spinlock.
>>
>> . Enhance nfsd4_fl_expire_lock to work with with new lm_expire_lock
>>    callback
>>
>> . Always resolve share reservation conflicts asynchrously.
>>
>> . Fix bug in nfs4_laundromat where spinlock is not used when
>>    scanning cl_ownerstr_hashtbl.
>>
>> . Fix bug in nfs4_laundromat where idr_get_next was called
>>    with incorrect 'id'.
>>
>> . Merge nfs4_destroy_courtesy_client into nfsd4_fl_expire_lock.
>>
>> The v8 patch includes:
>>
>> . Fix warning in nfsd4_fl_expire_lock reported by test robot.
>>
>> The V9 patch include:
>>
>> . Simplify lm_expire_lock API by (1) remove the 'testonly' flag
>>    and (2) specifying return value as true/false to indicate
>>    whether conflict was succesfully resolved.
>>
>> . Rework nfsd4_fl_expire_lock to mark client with
>>    NFSD4_DESTROY_COURTESY_CLIENT then tell the laundromat to expire
>>    the client in the background.
>>
>> . Add a spinlock in nfs4_client to synchronize access to the
>>    NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT flag to
>>    handle race conditions when resolving lock and share reservation
>>    conflict.
>>
>> . Courtesy client that was marked as NFSD4_DESTROY_COURTESY_CLIENT
>>    are now consisdered 'dead', waiting for the laundromat to expire
>>    it. This client is no longer allowed to use its states if it
>>    re-connects before the laundromat finishes expiring the client.
>>
>>    For v4.1 client, the detection is done in the processing of the
>>    SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
>>    to re-establish new clientid and session.
>>    For v4.0 client, the detection is done in the processing of the
>>    RENEW and state-related ops and return NFS4ERR_EXPIRE to force
>>    the client to re-establish new clientid.
