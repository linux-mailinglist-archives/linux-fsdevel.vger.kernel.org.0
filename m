Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5928141F708
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 23:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJAVns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 17:43:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45464 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhJAVnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:43:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191KWEHs005267;
        Fri, 1 Oct 2021 21:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s7dmd19wsye8zpHezfYcxjQeY6F8JNcLT+CtrbgotS8=;
 b=e6xxcaFk8qcCjzsl1PilfogbBu8isVlqt2HXgp2HGoDP545G8Vwk7kQCywCHFp/pmozR
 +TUgTqpovAgI2QqReo4H8VkxGpQFiXS3eP/Nnfp2Abormc1W5vxr9n+p03IZEplOicVi
 adlJZ1jJVNYFNqTtq4TA6mPsAgnGQhD+zK4SUl7+RR1vcWXUTrzAvZBwSS65ZrBHss7d
 QhbQhvRFa04+pk/M8CeHEQcfD1zSA/37DBtqRFF/Sttu/ECYk5QkQuYGxfBT783XIYoB
 Fqv1LQfwKJFAMo24W1SHLdl/cUqrgyvE0FsIJ8TyBX6lGODueKEwZeFfL3HlEtWQDjQQ 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bddu92vsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 21:41:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191LaNCh022161;
        Fri, 1 Oct 2021 21:41:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3020.oracle.com with ESMTP id 3bc3cj43sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 21:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW67fruCdORs84Zk5fNh0Nu+IMtascGg7nyxt/fVw67vZOG0u2Y0I/yqTwrlympljzH4iyhuVLAWSXUIn8mt48y/9UgmyN0Ais7J/IFBlCnIMPQ8DcfKbX7qhukyzjOlssc4gjYEoSRVu60kzZ1xMPsNDERLQDrGo27cYR4uA/R6D95o2DFLoT1IzfiRv0vfTIpV/fq9oVUUoaKJOj2QKkAwh0cfb7oq9xMNff4MzrAkBCbq4UX9720LxAPgafHnlPXieb4dPI5DAO5g5WHhFK21RSypZQfmZulxanNIZ5auumBYuCCs5OgnOuGT/Nyrv2hJUKsQtvxcIFt2eBIiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7dmd19wsye8zpHezfYcxjQeY6F8JNcLT+CtrbgotS8=;
 b=kau+lhoPJkP83wA3NyAXfTs/yzu/LeAzYTO1/shTS/DyhCJCGkfoyF6GzMLI/xuSoj6AJTCkP9WWaHyyrT1vaoC0ktIn86KfRS1iHU7DvvzmVkeqbalvy+/C6RxUq+1oT4IImlvjvD9lChfBhYm96advp70YrSVGXDlMJ78GKxRCeGoacTD+Pm+DF68V1pqfe8wNLFPEIM7VgULPuhA0v0cMmmGMnQjdDOwrD3EU5nyk2fpwNzNtMrG+7KrT8h4TnXuyv80+LdXQIhkfkTLTw/emdLva1oXshJJez3EGs4EQB7QxZ/rF9qxnhF5UzOWn5SNRyTiK2GobOljV7ahcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7dmd19wsye8zpHezfYcxjQeY6F8JNcLT+CtrbgotS8=;
 b=ZiYqH50iIG22RAyTV6hmJdoQDfmyeTvy31QKGU0IuEDX+zk0b63GjKjNQV1xRJ8S8vjKmkcH3Y6kNINnTFu6SGW5xT8t1A7yJ+8VcVQRfudEVIEywHqUeClwQjegSQSDH4nMPjw6tSsSv85JZNbzBnev8LSJooI6yjRb1Cg1Nzo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BYAPR10MB2440.namprd10.prod.outlook.com (2603:10b6:a02:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 21:41:56 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::486b:6917:1bf6:c00e%6]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 21:41:56 +0000
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
From:   dai.ngo@oracle.com
Message-ID: <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
Date:   Fri, 1 Oct 2021 14:41:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211001205327.GN959@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
Received: from dhcp-10-159-248-137.vpn.oracle.com (138.3.200.9) by BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 21:41:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be610056-c586-45ef-f5a8-08d985244a35
X-MS-TrafficTypeDiagnostic: BYAPR10MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB24402437D25C351E7DBCE81087AB9@BYAPR10MB2440.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3WQQXHqamoLCzzqV5mDfiXikJwGijEHik7DEe5uzZtrsOjfQC1+U6V4lT0q9t1IWZdszVTt6do+bXnJT1DhbX7XK37OgHcz102txxhepMjRcKYUXfz+rLCLe6ArhWA2/QrC94cZ2fcUqherUkP+thjzYYIiW/OfMCtnCOoMNkCnfjtdJaZv3/g6p3G+C2cHEgZKzOHGVMoLSddwPAL4tvZkKC3WSrBo9At7uMfOl8uRkkOjC6pKQz5l9qUI7hiLfvH6NWJmHXX5DaPGfqPm87cq3e/17YD1mo5Aw0kWd0h5rCSYK27CVuZD7PIpPaipG5F+d6/Iyzo+VTAlxkM0/VkjHWiLxNfR7As+HJYFjcIdtGQeNAPhNLty17oKiQ9VzvMVHki+gKfy2UHAP3q668472rxTZWxW2iHgrcvgBZF1hRkIJRn09YckusrYzMD6nCGvB9z/BT6LQp/G90Hxb6zGAdWt0T8LIotCRZagReJiYtXSLUd87fI+7CpjfuYJ/u80NezMEAdzexXHuQgnDTkfj8k8CsHOsic5qkg4H3SK8o/BjpFR1XyqtCFm3oByyXUXMUsHG/2ETh4mks+BHyLvzw9LGNAOBpH5kwXGK5yqFlrJzhzBxvk4nQBFglUCFVdW/JWyfURnUz6JXgI26pf10aFn27T2+CGBrrni+yX/TIMXbIjT/E29iLrMhR++FmvmWTom2C3pk7O9cCaHTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(38100700002)(316002)(26005)(31686004)(31696002)(2906002)(6916009)(186003)(8676002)(8936002)(7696005)(86362001)(4326008)(6486002)(19627235002)(66556008)(66476007)(9686003)(2616005)(66946007)(956004)(5660300002)(83380400001)(36756003)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVnVHlRMTNQVGJHQ29NQTRVcTczSWFXNThsdXBPdTU0UGl3dytaMkdyRE5T?=
 =?utf-8?B?UUFNZ2hEK2hCVWJnMVVrdkEzclBmMUdNeHExbklueEtQZkpCYll1aDZWTWxQ?=
 =?utf-8?B?YlBlbEVabmVPdUR5elhhbzFuZGxnN2M0TGhmZDRQSnI1VDFLdG95N095SENo?=
 =?utf-8?B?TzBwczZ0dmlzQUs3cUpIbGthYktDUGc2eGl5dHBXL3BMTzhkd0lYOFZYT0xy?=
 =?utf-8?B?K29HWHFHN0xXRFpKL3NheHFpbzlaWXZzRGJxUmgyUzNiSzNRREN2ZmUzM0hm?=
 =?utf-8?B?eWYzTmY0U0djVEhoU3FLS20zckZDL2JUYThUanRnQ1JQTEtkdjNZTXZUZDV1?=
 =?utf-8?B?SjhweDJDQXRCOFpCcjlIUHlxUWR6WEFOTFZ3RUpwS2d4aDFQTW1TMC9NN2ZN?=
 =?utf-8?B?OXc0eEtxSTQzL3RWVmhrSE4vaUlsbndIdXNYWU1va0htYkV2RWNqeUxsUG9p?=
 =?utf-8?B?QmZ4M0FqS0xtUWRqWGVERkRycjU5U3hoTk9yZHRqL2FjZTh2OXJnWGdmZS9z?=
 =?utf-8?B?S3JVa0ltaXBwVnF2SkUvMUZLWXFFcVhQNDdCT1ViOHJuK2R1ZklUbDFtLzVy?=
 =?utf-8?B?Wlo2RTBDVXJtRjBBRnhidEFWZytITnVza1ZBTHBRc2NnVXg4Q3prSDBwLzJR?=
 =?utf-8?B?TjRTSkpYQTYwczc4RFRlVllHTW9pTVIzQU1lWEhwR3lnbURucVhSMUs2U1Fw?=
 =?utf-8?B?YXk3K3NYYmRrWENOMTlpRk1mYTRIaDllOFZydjN0MDRheVphWFYrVWcvWDU3?=
 =?utf-8?B?emlXUk9Dd3YzYURpRjByWnR3TkJOVHdPRXg3THh5Uyt1bGVMb3UvMWRBUzRU?=
 =?utf-8?B?dTJSejE5dWtld2Fyb0dRenBQQ0tUb01aQ1BPQ2FuYi9GdWgvRkIrTktETXBY?=
 =?utf-8?B?ZnFtWll3YUVvQytRT0poUDJNYk1GRUF4aTFGdHNVYlY3VVROajRBN3h4U0pm?=
 =?utf-8?B?akF2MW1BVTZIbWdzNk1VbzRCZWc0UzQ4UXE1UEd2MUdoaVlkUm1oaHBNK3Ey?=
 =?utf-8?B?TEZyYlQ4dTRRNzZhNkoyT3dsRVhrNktHYlJJencyUERDa09IZ2tNS0hFYXZu?=
 =?utf-8?B?TmlGNEhrU2JZTnJUN0ZibFZTSU9ZbHVsWnpYOXA2WGFleUVJd3NEVDlxczE5?=
 =?utf-8?B?WUwrdWVhMi9XcVZnZlBqdHExUWNLd3FleGRNRGhYb21EVlh0Z3hvOVh3dm9v?=
 =?utf-8?B?NERJZkdBbXpDWWEvZFNLaHBlOHBTV1ZmTkZsT1ZCM0p0MmJlSFphVnk5Zjdx?=
 =?utf-8?B?dy9wc08yZEZCM3h2dEZmMDRQMXBSMUpXamNTUzQzUXhBTlR1V0RVUWdWY1Vm?=
 =?utf-8?B?K0l0MFV5elFjTU9oRUI3cExpUklLT05uMGVzc1I0Vys2MWRIUFJyOFJ4OTNJ?=
 =?utf-8?B?UVhEYmNhOFZucHpTeVB0ajhYTVVtcHVQbWVnOERkMFVWa2ljWEVsYmQyM2Zi?=
 =?utf-8?B?TVVxanZ5RlBneklQbGdBOE55dmxuSGcrNUEwTzZJRzBaZWErT1lNSzBST0Nx?=
 =?utf-8?B?WTBkQTR0cGtOdlJaNWZJZ1BRUHcyRXQxOHZtcEVkejVTNkVGbDFBalZ4c0di?=
 =?utf-8?B?ei9JcnN0UDVuQlZ1bHUvbmtuRGdlcHpKdEZvbS84K1psVzh0bWFuYWVRMDUz?=
 =?utf-8?B?TXhXTHJjSDl2Ui9DOWU4K0ZoZjI0TTRKNWRmVkgrVXJGTWdwWDcvUzRSSHYw?=
 =?utf-8?B?ZDFMLzYxNDdtVHVnVWJqaGg1SUJ6LzYxT2U3dE1aSm93cVk2TkZ4cHNzTjJH?=
 =?utf-8?Q?20fLxoNP9R+actqFf9Yw//ErWAo0Mqy+h7ld/Qe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be610056-c586-45ef-f5a8-08d985244a35
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 21:41:56.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4vwrjR9jNy+xn0NWWTPBwWlc7pCd83wradJkel8GJDUW2gW3dYT/Oy4izHc18WuFXgdDp2Ybgw+OBfvi3UnrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2440
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010150
X-Proofpoint-GUID: F5YJ6a6HbqWUCTewuSn-0SgCrdM0Q-iM
X-Proofpoint-ORIG-GUID: F5YJ6a6HbqWUCTewuSn-0SgCrdM0Q-iM
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/1/21 1:53 PM, J. Bruce Fields wrote:
> On Tue, Sep 28, 2021 at 08:56:39PM -0400, Dai Ngo wrote:
>> Hi Bruce,
>>
>> This series of patches implement the NFSv4 Courteous Server.
> Apologies, I keep meaning to get back to this and haven't yet.
>
> I do notice I'm seeing a timeout on pynfs 4.0 test OPEN18.

It's weird, this test passes on my system:


[root@nfsvmf25 nfs4.0]# ./testserver.py $server --rundeps -v OPEN18
INIT     st_setclientid.testValid                                 : RUNNING
INIT     st_setclientid.testValid                                 : PASS
MKFILE   st_open.testOpen                                         : RUNNING
MKFILE   st_open.testOpen                                         : PASS
OPEN18   st_open.testShareConflict1                               : RUNNING
OPEN18   st_open.testShareConflict1                               : PASS
**************************************************
INIT     st_setclientid.testValid                                 : PASS
OPEN18   st_open.testShareConflict1                               : PASS
MKFILE   st_open.testOpen                                         : PASS
**************************************************
Command line asked for 3 of 673 tests
Of those: 0 Skipped, 0 Failed, 0 Warned, 3 Passed
[root@nfsvmf25 nfs4.0]#

Do you have a network trace?

-Dai

>
> --b.
>
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
>> NOTE: I will submit pynfs tests for courteous server including tests
>> for share reservation conflicts in a separate patch.
>>
