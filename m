Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB34E4A63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 02:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiCWBQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 21:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiCWBQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:16:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E106FA01;
        Tue, 22 Mar 2022 18:14:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MKxQNm017302;
        Wed, 23 Mar 2022 01:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9VBcAj+44WkkuX8n9AKPDmT4LDdePPL1tSBc2R3KZCU=;
 b=iLe6it1DDTYH2v1rHTJet4gHmHKKFOg50Uog5gxQuILpMg6a+nYtPDQ6VsPj7VgRTC6b
 RqjP0wZUrlc8VrEo6AxV185LhzDABWHlMB+V5pgBFD0l/0CvfQa7VBqXId354cmkuZVD
 4Isa8WW2LryeziszwHdBBHAWyn2hdYO+s/0B4v2lXkG9wgqIdtYYAxsnctGMjzZI7kYb
 1zWSPq5jaJxXQF5NwLWNyVNfPWMi5fjz6fnwZLtSx/i3+Rb2T8xeBuH1uNQH4IB2NzL5
 6ZQIdIb60z8AbpHq93pJ2lgEbiOru76ejyt0EAd5vlTjajiNCd6G9YWNn0fkINnWo91X +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcqxbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 01:14:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22N1BDAs039500;
        Wed, 23 Mar 2022 01:14:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 3ew49r8cx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 01:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEfaQt52tbP0cHFlhH/pSbkC5khKOrM0nuvdTqkwMGq2mhcINj8sTaxg4HdwrR4YgODvfUDCUA1gcPx9nN5UDgigI/HsXRtbRS7GCJKBe6wMGFO0yBbkR7AFIt3ZR5pXB35WtqvyoUlCMChEATgonWXmPmPEKE2wT24XTlcnIM8CoKW9smoC/hrVgVrYMtQfCgLH855SozWBloX8scYmwvXLeOL0T12MbMsmQ4aNQTcwWQQf1+UniVVFDxhlFHAbNY75uevIWhzQ73nko74NncPaQaZ9jm59aHGckXfnAAfXfhKzX2vKwy8uqV6WXpClDycyl76Sj9mAs4E1XdjlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VBcAj+44WkkuX8n9AKPDmT4LDdePPL1tSBc2R3KZCU=;
 b=EU2CsqpoCSBw/RPEn/NPtj2Aq46n1LSa2ff36orKoKok6xqUubC9Y8Ji1xMCi8XF7xF+Q825Tz6tU26I893mv6y2DxtAwGAXvGZDKqCOW/0APt3vr2RQ7Hof7NLtuEE4pGOU0AJG7SQ2hRn5KETNvrWNhch4ND88oISOiLHk2XdLTjAYyhV/q8s4/12tjabJY7bbcOZIl4jh1pYMMRCtcKReQ454ZaBEGN7M/76ouOqY5P04mUj1PPwyvTfXzuc3Gl4gGjcf6BU5Lu+aWIGNDrLueXmfFX9dgHIyhOZGw+m1X8D5pCUWr8JqoKR//Ef3FJy9sm2aGjHlLLX9u6tZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VBcAj+44WkkuX8n9AKPDmT4LDdePPL1tSBc2R3KZCU=;
 b=Yw4Kqcs7/0Rzv5poSytZKwSgs74oyKY7kSe7Cq5ezJgD33bVTczWz9hrMRdiDxhe9Zlab2evsgIs5BZtkSNnrxLrNfVgbj5u+d4mkPLfYonBIgp6B0RIAduV/Ap6OXkjkn464ynvm2T+wO7D3AOIYuQ5bxyrXGezeoxocgUHByw=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MWHPR1001MB2221.namprd10.prod.outlook.com (2603:10b6:301:2c::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 01:14:53 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 01:14:53 +0000
Message-ID: <f34df435-0ff2-37de-da4b-d0d0a0eeb8e5@oracle.com>
Date:   Tue, 22 Mar 2022 18:14:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v17 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
 <1647503028-11966-7-git-send-email-dai.ngo@oracle.com>
 <20220322215023.GA13980@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220322215023.GA13980@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52e45d3b-f0cb-4f66-fffd-08da0c6a8908
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2221:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22212FD9C7D1345DC0B07D6B87189@MWHPR1001MB2221.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5h3K/LPSUbntC4T2meyoYNp84euGINu0QqoQnIsfCqGYHLw+WXYTDqo3uhh5jbJaw3KHtWICA+xxPWW2/W3Pxh0LJ90/yFaxnPHbrfcINlAvBcgHkeZMgNHKmYwIPEe9gPznWMgxcds/Faorc3fjD0Lf4j+rFuez02WGSgy1dz1y9Zsc+Ia6KIoYSOGFeBmSEEkCbnDTcqIYJcRDMs/sazQk/wqio2cW+xwrj7jOszirYhAKHz597XoEvuVl4vs3RU2LW0JkhchlQxMkKQ/ErB7RdmItyXH12yJ8J4F9X+3UYb4Luj/kcrwYdgFnmwWph14iS2od4YGiBVRvIVgC7m5xwI5cpjACm72y5x+2njYU7u2JdqMkVKTcEGnq+l/jSsxqKqvnIP6ioaNZPkf9Ogs2eTs4d5YZn+Rp7Bi0+q++FRJzFaLlXyrZkSilthCRk+AE+j6PmLfsPfTDHgay4iSRXmoWmaiRKhnG0Inqok/jyP3jpVKiqfCaTslCAmhyqUJQIK3Qfi5hiHQUAoIFHy8/DDEpXln0xiPCbB/aKeXoWIqE+JAyYoZhBiEwEARuFWXnhv8HwGeuzayyDa9TqlnpFEL3NgpCRVGXsseYUART/o6AE6JWpTlStSWtP+nMsop8cmpfRnGbyOMsConUFDJH3GKcBfq3IkpQP6rH5wYFiB+lRQmQOCpmcJnroqCEaXdMoH4Xw/Nma7hCN0lkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(508600001)(9686003)(6506007)(6512007)(15650500001)(53546011)(186003)(26005)(2616005)(38100700002)(5660300002)(36756003)(86362001)(2906002)(31696002)(6916009)(316002)(6486002)(66946007)(31686004)(66556008)(66476007)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGV6VGxTSTZSZ3JaeCtFY1hlUVBqcVQ4QklubE8wQUhmYlNFZFdaMGo0WkNt?=
 =?utf-8?B?R0puVUVnc0pjd2FPZ25FQmxlOUxReG1qZDZOU0hBUEcxVXdzTERKeitKdUww?=
 =?utf-8?B?TXlqOFpDd0syY3ZmbldMUTl2T1dVU3ovcU1HSTZENFNtb3pzaUcvUlNKTzgy?=
 =?utf-8?B?Zm8vS1dJYXlDem9UYmJra1NLbStxdlV0Z1BhWUhLSklLWDVoTUFOck9PN0xP?=
 =?utf-8?B?Y2FYeHU5Vnk5RzduRngraUtRR1dXcE5pdDNTSDNhU01ITFpIYjNYM0JNUkZF?=
 =?utf-8?B?VmpqTzdpdFJlREhrckpZZ01FMHF0cmlxRkFhTGpQTWt1eTk2WXJrNEsvU2lQ?=
 =?utf-8?B?R0NUZWZMb05veVF4a1hNSjkvOC8rK3BObGVMSjBsOG1YdkV5KzZsUkI4WTJ3?=
 =?utf-8?B?TWlDRENyU0dLQkdBN0NsR3RtbGdRbjRjU3Y5ZnBUWGRRTmo5bkFIdWRaNHRk?=
 =?utf-8?B?LzFoYUJvQzhTb3YxZVVBVU8zdkhxSGxKR0xOZ3VoVGpUdGtxWFlhSjdhMHNq?=
 =?utf-8?B?Z2RJdjhrKzhWZVlrTzIyeVNkK21vbUpnelZodXBlQmJEdkUrR0ErVG1CT2Vi?=
 =?utf-8?B?UnN6ZFFZbnd0MWJxNEh5eWFROGZHWkdSQnpyQzBMdDBERVpMRnRKdkM5TkZQ?=
 =?utf-8?B?cGpzU3NsMnRGaEVmblN1N0drVjdWZ3laejdoWWJiRTFYclRWTUJPN3VkNkNi?=
 =?utf-8?B?VmxidDkwVW93SzlkTTN1MkpNdXNrTTF1TWlGR2xSNjEwczFKNWJrOVZNZE5x?=
 =?utf-8?B?MHFMUms4S1hoQjZFb25XT0hKMG9uVzg3SGpvMHc1QzJMc0xZT3pCdHpqcXhx?=
 =?utf-8?B?d0pIRW9YWTBtZDZna1duY2M5VGR3WEJiOVV4MWR0TGEzS0JsbnR2MGJqZU1L?=
 =?utf-8?B?VTFMVzJ4dzBrOThQK1RZZlVoK2ZTdC9ZZXJUV2dEWFF2MytIT3FnK2NKZk55?=
 =?utf-8?B?cmNTeDVHdkdjL0xpS2VNbS83ZWgwTW56TmpyeTZHZFNVUE5kUlM2NzZMNVNn?=
 =?utf-8?B?VlZubURoM2gxem8wU0dIblh1azNSRHc3a3ZQZ0svS0N6S1JZbVh3Q1NhaHd1?=
 =?utf-8?B?SHZjZUN1MDd2NWw0Skk5c1VnUmNLbFMrZ1liUjcrd1RUZGh5bnJKcll0RGxs?=
 =?utf-8?B?U2hiNDlYbzBQQmJBTkZaZS8yR2JGUmRISzFKYkNOYXEwdDd5Y1Ezbmw1TC90?=
 =?utf-8?B?OGoxd1pST3BSWUhmUkpKRDlRdTIzdEZxVVY4cmFyQzB2QnZKZlJjek1PdVRo?=
 =?utf-8?B?YjNENFNVeGpUR0JNbmI3YlplYXdhZGZ0RjRyRGFTQXBKYW8yay81UmtJanNU?=
 =?utf-8?B?SSs1L0tVZmhCU2NBMkpaV0l1UThEbVMwRzBkNnkxRGRzckV4VDRXZkYra3FO?=
 =?utf-8?B?ZXF4N0dianVzN0FhbUdKalg2dGx5SG9xZU0xK2szNlB0bmQ1cFB3aDhkQ0RJ?=
 =?utf-8?B?RjdWeXR4QU5LZEs5VUh0VDJmTWZ2aUI2RUFnbk1uS2xrVlZoaVdUSUdISmxu?=
 =?utf-8?B?Y0dpRGluV0VwbmY5bER5MVZLWDVEam44SHRQNTRuTDZ4ZU9RYnNha2FGcDgx?=
 =?utf-8?B?TnpJYWxta0JmY2xMb0lHMUNiUyszL0lZNXVxeXFqbGwzN0hyRndjcGo5WEE4?=
 =?utf-8?B?RW5wZDhRT3ZlTFIxVjQvc1dMUTlHSkVwcFhiYm9ydFZrWVNObzBES3NBWUNo?=
 =?utf-8?B?Tm0zbUdWbENCVW9FNUxZM01MVTRZTENoc3VmcTA5cldkb1puR1Q1L1IwY1dU?=
 =?utf-8?B?dW5pZGlXU1I1QkxCaFZOcUEwVmtGOVpzcW9rNzhhU252SEtoTUh3c1hxVVh3?=
 =?utf-8?B?Z2krM01zcW8rVVpWSnNuMUxqZmZuQjJldnlHRU03UGlZRjRxOVFwRFgwMHJK?=
 =?utf-8?B?a2pjWUtpaHZtaHljdlJnQ0xobGxVeHFXZWE1MmZETjhhWjRPdWdhVkh2dnBK?=
 =?utf-8?Q?T41wUNy8/Ud1asDuuOpmYN8hi1p2Ky7Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e45d3b-f0cb-4f66-fffd-08da0c6a8908
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 01:14:53.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RISmlXoN9g8oIRfc9+8Y1l+U+MmIYNsV5tf6b0Qgg5RGfPUXhFAXCxTjm6f1bTdAcc5Odte9jKY62puRz/uKpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2221
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230006
X-Proofpoint-GUID: fOVZ2xhjJ4m7VPmU6wAswrJJSoJiWkQC
X-Proofpoint-ORIG-GUID: fOVZ2xhjJ4m7VPmU6wAswrJJSoJiWkQC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/22/22 2:50 PM, J. Bruce Fields wrote:
> On Thu, Mar 17, 2022 at 12:43:43AM -0700, Dai Ngo wrote:
>> Update find_clp_in_name_tree to check and expire courtesy client.
>>
>> Update find_confirmed_client_by_name to discard the courtesy
>> client by setting CLIENT_EXPIRED.
>>
>> Update nfsd4_setclientid to expire client with CLIENT_EXPIRED
>> state to prevent multiple confirmed clients with the same name
>> on the conf_id_hashtbl list.

This should be nn->conf_name_tree instead of conf_id_hashtbl list.

> I could use a little more "why" here.
>
> I'll give it another read, but right now I'm just not understanding how
> this is meant to work.

Here is the problem description when running pynfs/nfs4.0 CID1 (need to
run CID5 first to create ton of clients) which requires the change in
nfsd4_setclientid to get the test to pass:

1st setclientid(name=clientA,verf=X)
   . find confirmed courtesy client with same name clientA (clientid:1) and
     mark it DESTROY and leave it on the confirmed list.
   . assign new clientA with clientid:2
   . put clientid:2 on unconfirmed list
   . return clientid:2

1st setclientid_confirm(clientid:2)
   . does not find any confirmed for clientid:2
   . find unconfirmed clientid:2
   . does not find any confirmed clientA (find_confirmed_client_by_name)
     since courtesy clientA was marked DESTROY
   . put clientid:2: to conf_name_tree list
   
     PROBLEM: new clientA (clientid:2) and courtesy clientA (clientid:1)
     are both now on the conf_name_tree list.

clientid:2 does OPEN -> stidX
   
2nd setclientid(name=clientA, verf=Y)
   . does not find any confirmed clientA: skip courtesy clientA since it
     was marked DESTROY and does not find confirmed  client:2 due to the
     PROBLEM noted above; duplicate entry in binary tree.
   . create new clientid:3 and put it on unconfirmed list
   . return clientid:3

2nd setclientid_confirm(clientid:3)
   . does not find any confirmed clientid:3
   . find unconfirmed clientid:3
   . does not find any confirmed clientA: skip courtesy clientA since it
     was marked DESTROY and does not find confirmed client:2 due to the
     PROBLEM noted above; duplicate entry in binary tree.
   . put clientid:3 on conf_name_tree list

clientid:3 does CLOSE(stidX) -> NFS4_OK since clientid:2 still valid  <ERROR!>


-Dai

>
> --b.
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 27 ++++++++++++++++++++++++---
>>   fs/nfsd/state.h     | 22 ++++++++++++++++++++++
>>   2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c6b5e05c9c34..dc0e60bf694c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2834,8 +2834,11 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>>   			node = node->rb_left;
>>   		else if (cmp < 0)
>>   			node = node->rb_right;
>> -		else
>> +		else {
>> +			if (nfsd4_courtesy_clnt_expired(clp))
>> +				return NULL;
>>   			return clp;
>> +		}
>>   	}
>>   	return NULL;
>>   }
>> @@ -2914,8 +2917,15 @@ static bool clp_used_exchangeid(struct nfs4_client *clp)
>>   static struct nfs4_client *
>>   find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *nn)
>>   {
>> +	struct nfs4_client *clp;
>> +
>>   	lockdep_assert_held(&nn->client_lock);
>> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	clp = find_clp_in_name_tree(name, &nn->conf_name_tree);
>> +	if (clp && clp->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
>> +		nfsd4_discard_courtesy_clnt(clp);
>> +		clp = NULL;
>> +	}
>> +	return clp;
>>   }
>>   
>>   static struct nfs4_client *
>> @@ -4032,12 +4042,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	struct nfs4_client	*unconf = NULL;
>>   	__be32 			status;
>>   	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	struct nfs4_client	*cclient = NULL;
>>   
>>   	new = create_client(clname, rqstp, &clverifier);
>>   	if (new == NULL)
>>   		return nfserr_jukebox;
>>   	spin_lock(&nn->client_lock);
>> -	conf = find_confirmed_client_by_name(&clname, nn);
>> +	/* find confirmed client by name */
>> +	conf = find_clp_in_name_tree(&clname, &nn->conf_name_tree);
>> +	if (conf && conf->cl_cs_client_state == NFSD4_CLIENT_RECONNECTED) {
>> +		cclient = conf;
>> +		conf = NULL;
>> +	}
>> +
>>   	if (conf && client_has_state(conf)) {
>>   		status = nfserr_clid_inuse;
>>   		if (clp_used_exchangeid(conf))
>> @@ -4068,7 +4085,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	new = NULL;
>>   	status = nfs_ok;
>>   out:
>> +	if (cclient)
>> +		unhash_client_locked(cclient);
>>   	spin_unlock(&nn->client_lock);
>> +	if (cclient)
>> +		expire_client(cclient);
>>   	if (new)
>>   		free_client(new);
>>   	if (unconf) {
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index d156ae3ab46c..14b2c158ccca 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -735,6 +735,7 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
>>   extern int nfsd4_client_record_check(struct nfs4_client *clp);
>>   extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>>   
>> +/* courteous server */
>>   static inline bool
>>   nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
>>   {
>> @@ -749,4 +750,25 @@ nfsd4_expire_courtesy_clnt(struct nfs4_client *clp)
>>   	return rc;
>>   }
>>   
>> +static inline void
>> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
>> +{
>> +	spin_lock(&clp->cl_cs_lock);
>> +	clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
>> +	spin_unlock(&clp->cl_cs_lock);
>> +}
>> +
>> +static inline bool
>> +nfsd4_courtesy_clnt_expired(struct nfs4_client *clp)
>> +{
>> +	bool rc = false;
>> +
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
>> +		rc = true;
>> +	if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY)
>> +		clp->cl_cs_client_state = NFSD4_CLIENT_RECONNECTED;
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return rc;
>> +}
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.9.5
