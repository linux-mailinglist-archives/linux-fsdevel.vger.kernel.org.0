Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FBE4B8500
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 10:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiBPJ5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 04:57:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiBPJ5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:57:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7D245679;
        Wed, 16 Feb 2022 01:56:54 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G9mxqC029681;
        Wed, 16 Feb 2022 09:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hH1Wrp798if1FKujoCAmaMzoa2xoO6BRstYNvuqNDTA=;
 b=qhtTqeHRiV01RxVnm0LWhlqPGirAARVi+iIMLpSj+4GbKFVjLAR1//JkDvlatVw31f8U
 5k6QwqDjSRrC4OPUi/iXVObkBPrBneFfUcl2QpM5xQRsfcXztS1S6qlZLgVfF/aT+MC9
 NDzjRCPEwZSBkngAEQ+QuoKLPimWCH4psQFtht/tMW/eDapasQc2mxhy6L3Csm4iuzvq
 MK1FWE9p7qJZmWLsmeqiQOaKCGAWpguVxkYcY8xcvdhywawekW99zH6cM0VvtX0MZEqs
 o7xPmOHNJ9CqFRRnzm7lGX88LFl38HGUFLGeFEZ0M7Y4Mzqsbroa6ou7H3191Dq1LNkm /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8ncasbax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 09:56:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21G9tE8I053725;
        Wed, 16 Feb 2022 09:56:48 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by userp3030.oracle.com with ESMTP id 3e8nkxst0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 09:56:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbvwNP53ZXJwcb7wkbZ9Dqd4CluHuW9zTyJZlon0dOEBzxHvTvAu+TcSgF6T1eS7AFCzcHHXQj4Nht+ibBOyBWfiSxIMvfjei76e/E7pcozUm5En98tVvM4IM2iBpiDvgjLj61TZW5KC1QtBB8SpvokTR9t1aXGcIX0V++GGLJUs0TEyViI+toZuD0DV2xNWyZRUDtu+9OGZQACHQB1rf8p2Qg2wScwa0idGQfn/c0c32ROqgkW4j6ipbQ1mpwU3I4sqkTFUPIOr1B83Z41Zd8WJ+A/aMu5qBq5ybo2mh1FRp6vUZOwKQEWa92JBiSLK+0XjmK87p9iQKZklQzGVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH1Wrp798if1FKujoCAmaMzoa2xoO6BRstYNvuqNDTA=;
 b=dRgaqXGZgY/NfK4qqDlT82jxFrDqPA8eHL/M+N8NZlM/nWlcjjIizq93cW541EYZMd7d9JyQrDXd/EI/3Kdu/77zWoph6d9kuiBd6619uKwgUbtfAbgFgn2BJWcoHeJZWDDzBOa5bLdOOyfZz2uyRutzOnQZHwEgFDpj27z9mOUWt5P9piMR5escGJ+DNwpYtznzQGfcgSQlfN3ecJFc0MWROsB4wxH+B/Mof2w04qd96thl94STLT/iW1bLqiIpK5U8IvDbEk/QVQMUCMaZm0NLovTno28ic6mrGLqBAaCoAZijb0i9qoujhP+pmTzT9CG8+OlsqJI9FJF7A8I0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH1Wrp798if1FKujoCAmaMzoa2xoO6BRstYNvuqNDTA=;
 b=Sx1fyxmI4MrUAEAT8o5l3lwwMD9nQh/O8giYY1U6IalWkvpw4W43Xsi+BrGdBr/0/rNJA+bsCprWzGgXxjfGiVp2GLZq+TnhBbDPoEm+bJS2j1K//L8KM2Oq0Dcu+dLka8ONjILgCpuf1xCyPWb1I/e7yxuFr1DhmlGwcUuACOk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by PH0PR10MB5778.namprd10.prod.outlook.com (2603:10b6:510:12b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 09:56:45 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f97f:5d3e:5955:f773]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::f97f:5d3e:5955:f773%5]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 09:56:45 +0000
Message-ID: <b76a9b30-89d0-c4ab-a1c7-0ca1a1ed6281@oracle.com>
Date:   Wed, 16 Feb 2022 01:56:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH RFC v13 4/4] nfsd: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
 <1644689575-1235-5-git-send-email-dai.ngo@oracle.com>
 <FFA33A13-D423-4B15-B8D4-FFDF88CFF9BE@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <FFA33A13-D423-4B15-B8D4-FFDF88CFF9BE@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c3dffed-c9fa-4d8e-291c-08d9f132a3a6
X-MS-TrafficTypeDiagnostic: PH0PR10MB5778:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB577811F30589A5A9B23B55BA87359@PH0PR10MB5778.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnW9h9NvyUUDVyYl2nEd5rnIdUwgdb7l3BtAWrbzEkCXj77yOs1LqNWifqwsfyuMB2+zKhwKARDW1WrW2XFjsNz9zwbpwG98CqwVg5MjIVLc7g4n/IWPZEz/yApxhYPGT+jlZPiGd2hEIO5kD1Disz3W6H6MOO6MplrW0C9pwLLA05m+9g56tGUHbflGnxWtVGjPv9c9SaO3rD/9Ibq7M/bf1crpVNNgbQ6HBMKIJHfTMSHPGzcp9N3ttK1NzXOEUzWdT2VnCGa5o4uYLJ0Cp1j6qI+lvSlpBqpRVT0lvaasecPANXxS4NgJsGV3RjQBM/Uzh+iSwYBGxpvBehZ4bSSMOHPbJO8afz5RIdPxbgz3ykxu36RlCA68ZUv+E5/CbR0H8H38PyfMfb+IIkUTqWgf3RR/4C6LZnDXeI4Zsca6wOqHPyTSZ7vuMYhOEHHMrBz2o5L6O0I2MZ0bHC2cSRaJBGHeCdTMgloAaxWpdLzbuXwTwopOcZr9cAea0fiqI5JZ4w+ikEdQIXaHyNAOxLjn35vm6ZW+eEZZgJGPu/vj9sJosX/KbgolDVDTJyZPDFs3nnwuycYt6u/1PzZNyXgqofPwagNqpgNkhgU1GXAtW5KqVbyDA0TnSY9i0LSczhksiYwrZIdjgKVPbMUAt+Mw8aa9w9r3/D98iWmXv/TD1K4OUFQzznZfGV76J5FCbahswyos/oL8IjlW68g/vS7jpZX15LVk5V5h+/Gmxo8qCn2u+TVHPhGiJg5HzL4ZuzBU8ORY1rbP7uyeO2doRZMooJUbGupJ9Q2Bg3lWEg3+1rM1ZLfwG6GVj76VxR7h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(31696002)(53546011)(66476007)(36756003)(86362001)(8676002)(966005)(6862004)(8936002)(66556008)(4326008)(83380400001)(6666004)(2906002)(26005)(6512007)(508600001)(2616005)(6506007)(186003)(9686003)(66946007)(31686004)(38100700002)(6486002)(37006003)(5660300002)(54906003)(30864003)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVhFR1hTNWg1V284aERadENIbE1LWFlnOVZJSUNGbVMwanAwcmdicnRWdDNY?=
 =?utf-8?B?R1lPT2pKQ3JoSTRsUm0ydUhSbkdOM3kxU1dsaFpaM01HL1p2d3E2RUV0MVZ0?=
 =?utf-8?B?YkZtRGpVRVE3QytIRXM4Y3FCdnBKWnFFWU5xODRNRCtpRENsYTNKZmVPbm1M?=
 =?utf-8?B?Yld0ZzNsRzkvWWI3WFFiZS9COWRNRkdhRFJlVDNvMGo0NG5pVlhJNzRCVG4w?=
 =?utf-8?B?dUF2dm1HeW9RTDcwNnR5ck9DNUk1OVQ3RmV0WkpFUXEraXA5a1d1TnNaVnNl?=
 =?utf-8?B?NGwvMlVmYVRvTkxLVjJMUE9wMytCV3lFb3dtZGF5VXVrajdKWW9pckN4Tyt2?=
 =?utf-8?B?bk4zck84OFBUb29EUHBDdGJzVkg4Vm1JcFg2ZmFTdk1rUWR5bWRxR21laE0z?=
 =?utf-8?B?YnZGN1Buc3hkMDEydWRrUE9qS2VORlAzL0E1K29sOGhKeU1nWFBzWjQ3N3Rj?=
 =?utf-8?B?T29ONE81c2I4dUQwbnh0K2NmaTN4RkRhdkthNnRzeERsTWZieHU5WlBpSDho?=
 =?utf-8?B?MStLV1JLczcwRktKcXJjYXhDUGpIQW1rNW12NFJYa1RlSjQzMzAxMk5GQnZ0?=
 =?utf-8?B?RXlVZHhoN0pyZnZXN1AycTE3dmQ1QWFYbUp6biszZ1hjV3VBUURxbnlKYnR6?=
 =?utf-8?B?VE16SzltMCtKL0ZxeURNdzRWTEhsSTVvV2RmRXJIQnBDU2JlWXFNTHdNWDlk?=
 =?utf-8?B?ekh3Y3YzVTdpOUxnYUVVN0ZEQ1BuSnYvbkREdW1pK2Z5VU9PTFg3YTlKa2xU?=
 =?utf-8?B?VSs0QWEvYkVndEg0OU5zZXJZdnNudllLS3FFeVNuSkd2UXZmQmw3Ym9zV3U5?=
 =?utf-8?B?N0pZWnR0eWJnUEN3U3dBakE2VERqTFNFdk5jUkFQSHliNlFzRFNrYWNOWGpr?=
 =?utf-8?B?U1dFWERHRnJpckxrazg4dDVFTEI0VW9ybFBQWGI1ZmdVTk1hem0zTUg5S1Bj?=
 =?utf-8?B?SjRHcXRnTW5YcjRhdXpOa1gvRXFJU3hYb2tUQzVBeVZGanRvRWpwRGFBTDk3?=
 =?utf-8?B?Rjl6N1M2THltdDl1SmtsT1hPRDhDRjJvUFhPaHRQK0c3V1gxZGRPd21ZTjA1?=
 =?utf-8?B?V1lLVzJ6Z0dhT1NwQksyc1YzMTZEYnlqTU1ZR0d4ZWFHeS9XeWkycTN4UFF2?=
 =?utf-8?B?b3E3WVVmS1ROS2tYcFNjcmNXWm5YQzRPdkFKZi9OcW9VTGFRQmc0UDcyUWVJ?=
 =?utf-8?B?Z2x5ZlI1Z1NnQzA5bFQ1MndVWXF5N0pNOFV2dWVoMGI4MElxbUpzWUdneUp1?=
 =?utf-8?B?V3g1T3FQSjlKd1VDMjdubXRWa0JFL3NOMVlRb3FlWnR2a29NSG5PR0xJZUlF?=
 =?utf-8?B?bTZDMHhoSCtyVWpWaHorcVlucTU4SklsQzFjem1rUkJvY1NhTVFiRkMxV0ZT?=
 =?utf-8?B?RUhMdW1IWFpBcmpxZHd1UzRaWlg3bUF3bnBxUjdJa05nRGd3WWNFK1crV2Fr?=
 =?utf-8?B?dmVNSGduMmtqUWQ4RWNHczNJMUQxcy9BWnVsTjkvNStISTVEZ3RMcTlhZ1Bo?=
 =?utf-8?B?SDVwMUVZTXE5b09McFc5SzcycS8xVkd4QnVzRVRybDd2bHFWd29SMGtuOGpM?=
 =?utf-8?B?TE9NQ21BbG9ES3lZcS9FQkNsa2tEeTlBWHl0YjN6T042dkFYS2tkNkJXTlpr?=
 =?utf-8?B?SlFkZU5BemVhNUVLZS9Ra1o3RDcrUXVmODI1QURzTStPUmtDRzVQbERra3I5?=
 =?utf-8?B?dVA0MVpMbTFIZnpOU1Fzd09WeWdQYXJUU2kybkZUYXNib2dFcElNallIVUtE?=
 =?utf-8?B?S3JteFZ6VFhjRS9CTi9pdU5FMWhCWXUwSHFPVlo2TzEvOVMxWllrSlF3ZWtx?=
 =?utf-8?B?ZEZZRTZXSVB3WUdPSE9qUTI3SEw4WkxjNFVLS1Y2Y2ptZGt2ZFpQZVIxZVNk?=
 =?utf-8?B?OUhFNjF0VDJ1WlJnSXlIRHM4cVY3RXpCd2V1K0hnSDZHeXl6UnJ0Qk9qaThR?=
 =?utf-8?B?TTlGYk1zUXhyZU8yKzhlZ2dDU2ptYzUyaG5NTjhHZDRFTkFuRW8wNHFYamtn?=
 =?utf-8?B?clNJWS8vZmU0VDI0UzhBVis0Z3BrQk16Um5ra3BnZDJKc29OdVVpc0E4OXUx?=
 =?utf-8?B?YzRPNzFla2RrU21zMzFUMFE0ZWF0d29PVDJheWM4cXVzM1pISVE5dU41cG9G?=
 =?utf-8?B?R3BKZmlZOHJQQ1RxSXFaZHpJd0x4dmxUY1haREVBZlpERCtKeFI0VFVBRWN3?=
 =?utf-8?Q?DGnpYWU9gOedqvDHLzywm3Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3dffed-c9fa-4d8e-291c-08d9f132a3a6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:56:45.0568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2uNbFtHLLH+h5gicazripAKhWwjIOieuLTJfYfT38PkfIlRZxNu2F5TC5zrTDw5QX1kAgGThNMqcIJ+VYsPdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5778
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10259 signatures=675924
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160057
X-Proofpoint-ORIG-GUID: m4oo9BNl88jqWpiGsWgvEc9jIgNbjfha
X-Proofpoint-GUID: m4oo9BNl88jqWpiGsWgvEc9jIgNbjfha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/15/22 9:17 AM, Chuck Lever III wrote:
>
>> On Feb 12, 2022, at 1:12 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> Currently an NFSv4 client must maintain its lease by using the at least
>> one of the state tokens or if nothing else, by issuing a RENEW (4.0), or
>> a singleton SEQUENCE (4.1) at least once during each lease period. If the
>> client fails to renew the lease, for any reason, the Linux server expunges
>> the state tokens immediately upon detection of the "failure to renew the
>> lease" condition and begins returning NFS4ERR_EXPIRED if the client should
>> reconnect and attempt to use the (now) expired state.
>>
>> Problems such as hardware failures or administrative errors may cause
>> network partitions longer than the NFSv4 lease period. Our server currently
>> removes all client state as soon as a client fails to renew.
>>
>> A server which does not immediately expunge the state on lease expiration
>> is known as a Courteous Server.  A Courteous Server continues to recognize
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server
>> reboots.
>>
>> The initial implementation of the Courteous Server will do the following:
>>
>> . When the laundromat thread detects an expired client and if that client
>> still has established state on the Linux server and there is no waiters
>> for the client's locks then deletes the client persistent record and marks
>> the client as NFSD4_CLIENT_COURTESY and skips destroying the client and
>> all of its state, otherwise destroys the client as usual.
>>
>> . Client persistent record is added to the client database when the
>> courtesy client reconnects and transits to normal client.
>>
>> . Lock/delegation/share reversation conflict with courtesy client is
>> resolved by marking the courtesy client as NFSD4_CLIENT_DESTROY_COURTESY,
>> effectively disable it, then allow the current request to proceed
>> immediately.
>>
>> . Courtesy client marked as NFSD4_CLIENT_DESTROY_COURTESY is not allowed to
>> reconnect to reuse itsstate. It is expired by the laundromat asynchronously
>> in the background.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 440 +++++++++++++++++++++++++++++++++++++++++++++++++---
>> fs/nfsd/nfsd.h      |   1 +
>> fs/nfsd/state.h     |   6 +
>> 3 files changed, 424 insertions(+), 23 deletions(-)
> Hi Dai-
>
> I've applied the first three patches in this series for 5.18.
> I also extracted a small fix from 4/4 that should be separate
> and applied that too. When you resend, please rebase your
> patch(es) on my public for-next branch.

ok.

>
> I am still concerned about the increasing size of this patch
> and its complexity in some areas. Generally we don't apply a
> single large patch like this; the changes are broken down into
> a series of much smaller updates. That makes review and later
> debugging much easier for everyone.
>
> Here's a rough example of how this /might/ be done:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-courteous-server

got it.

>
> Others might have different ideas of how to split this up.
>
> I'm gaining more understanding of how this all works. The
> sections dealing with share/deny access are still somewhat
> outside my wheelhouse, so I'm depending on others (Jeff or
> Bruce) to help out in those narrow areas. Breaking this
> large patch into smaller ones will make it easier for them
> to review this work surgically.
>
> A few more comments below.
>
>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 32063733443d..b837ff97e097 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1935,10 +1935,33 @@ find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct net *net,
>> {
>> 	struct nfsd4_session *session;
>> 	__be32 status = nfserr_badsession;
>> +	struct nfs4_client *clp;
>>
>> 	session = __find_in_sessionid_hashtbl(sessionid, net);
>> 	if (!session)
>> 		goto out;
>> +	clp = session->se_client;
>> +	if (clp) {
>> +		clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +		/* need to sync with thread resolving lock/deleg conflict */
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			session = NULL;
>> +			goto out;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			/*
>> +			 * clear CLIENT_COURTESY flag to prevent it from being
>> +			 * destroyed by thread trying to resolve conflicts.
>> +			 */
>> +			clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> I plan to come back to this in a subsequent review once
> some of the lower-hanging fruit has been harvested.
>
>
>> +
>> +			/* let caller knows it's courtesy client */
>> +			set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +	}
>> 	status = nfsd4_get_session_locked(session);
>> 	if (status)
>> 		session = NULL;
>> @@ -2008,6 +2031,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>> 	INIT_LIST_HEAD(&clp->cl_openowners);
>> 	INIT_LIST_HEAD(&clp->cl_delegations);
>> 	INIT_LIST_HEAD(&clp->cl_lru);
>> +	INIT_LIST_HEAD(&clp->cl_cs_list);
>> 	INIT_LIST_HEAD(&clp->cl_revoked);
>> #ifdef CONFIG_NFSD_PNFS
>> 	INIT_LIST_HEAD(&clp->cl_lo_states);
>> @@ -2015,6 +2039,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
>> 	INIT_LIST_HEAD(&clp->async_copies);
>> 	spin_lock_init(&clp->async_lock);
>> 	spin_lock_init(&clp->cl_lock);
>> +	spin_lock_init(&clp->cl_cs_lock);
>> 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
>> 	return clp;
>> err_no_hashtbl:
>> @@ -2412,6 +2437,10 @@ static int client_info_show(struct seq_file *m, void *v)
>> 		seq_puts(m, "status: confirmed\n");
>> 	else
>> 		seq_puts(m, "status: unconfirmed\n");
>> +	seq_printf(m, "courtesy client: %s\n",
>> +		test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags) ? "yes" : "no");
>> +	seq_printf(m, "seconds from last renew: %lld\n",
>> +		ktime_get_boottime_seconds() - clp->cl_time);
>> 	seq_printf(m, "name: ");
>> 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>> 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
>> @@ -2832,8 +2861,22 @@ find_clp_in_name_tree(struct xdr_netobj *name, struct rb_root *root)
>> 			node = node->rb_left;
>> 		else if (cmp < 0)
>> 			node = node->rb_right;
>> -		else
>> +		else {
>> +			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +			/* sync with thread resolving lock/deleg conflict */
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				return NULL;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>> 			return clp;
>> +		}
>> 	}
>> 	return NULL;
>> }
>> @@ -2879,6 +2922,20 @@ find_client_in_id_table(struct list_head *tbl, clientid_t *clid, bool sessions)
>> 		if (same_clid(&clp->cl_clientid, clid)) {
>> 			if ((bool)clp->cl_minorversion != sessions)
>> 				return NULL;
>> +
>> +			/* need to sync with thread resolving lock/deleg conflict */
>> +			clear_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +			spin_lock(&clp->cl_cs_lock);
>> +			if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY,
>> +					&clp->cl_flags)) {
>> +				spin_unlock(&clp->cl_cs_lock);
>> +				continue;
>> +			}
>> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +				set_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags);
>> +			}
>> +			spin_unlock(&clp->cl_cs_lock);
>> 			renew_client_locked(clp);
>> 			return clp;
>> 		}
>> @@ -3118,6 +3175,14 @@ static __be32 copy_impl_id(struct nfs4_client *clp,
>> 	return 0;
>> }
>>
>> +static void
>> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
>> +{
>> +	spin_lock(&clp->cl_cs_lock);
>> +	set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +	spin_unlock(&clp->cl_cs_lock);
>> +}
>> +
>> __be32
>> nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 		union nfsd4_op_u *u)
>> @@ -3195,6 +3260,10 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	/* Cases below refer to rfc 5661 section 18.35.4: */
>> 	spin_lock(&nn->client_lock);
>> 	conf = find_confirmed_client_by_name(&exid->clname, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		nfsd4_discard_courtesy_clnt(conf);
>> +		conf = NULL;
>> +	}
>> 	if (conf) {
>> 		bool creds_match = same_creds(&conf->cl_cred, &rqstp->rq_cred);
>> 		bool verfs_match = same_verf(&verf, &conf->cl_verifier);
>> @@ -3462,6 +3531,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>> 	spin_lock(&nn->client_lock);
>> 	unconf = find_unconfirmed_client(&cr_ses->clientid, true, nn);
>> 	conf = find_confirmed_client(&cr_ses->clientid, true, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		nfsd4_discard_courtesy_clnt(conf);
>> +		conf = NULL;
>> +	}
> I'm seeing this bit of logic over and over again. I'm wondering
> why "set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);" cannot
> be done in the "find_confirmed_yada" functions? The "find" function
> can even return NULL in that case, so changing all these call sites
> should be totally unnecessary (except in a couple of cases where I
> see there is additional logic at the call site).

This is because not all consumers of find_client_confirm wants to
discard the courtesy client. The lookup_clientid needs to return the
courtesy client to its callers because one of the callers needs to
transit the courtesy client to an active client.

>
>
>> 	WARN_ON_ONCE(conf && unconf);
>>
>> 	if (conf) {
>> @@ -3493,6 +3566,10 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>> 			goto out_free_conn;
>> 		}
>> 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &old->cl_flags)) {
>> +			nfsd4_discard_courtesy_clnt(old);
>> +			old = NULL;
>> +		}
>> 		if (old) {
>> 			status = mark_client_expired_locked(old);
>> 			if (status) {
>> @@ -3631,6 +3708,7 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>> 	struct nfsd4_session *session;
>> 	struct net *net = SVC_NET(rqstp);
>> 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct nfs4_client *clp;
>>
>> 	if (!nfsd4_last_compound_op(rqstp))
>> 		return nfserr_not_only_op;
>> @@ -3663,6 +3741,13 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
>> 	nfsd4_init_conn(rqstp, conn, session);
>> 	status = nfs_ok;
>> out:
>> +	clp = session->se_client;
>> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
>> +		if (status == nfs_ok)
>> +			nfsd4_client_record_create(clp);
>> +		else
>> +			nfsd4_discard_courtesy_clnt(clp);
>> +	}
>> 	nfsd4_put_session(session);
>> out_no_session:
>> 	return status;
>> @@ -3685,6 +3770,7 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
>> 	int ref_held_by_me = 0;
>> 	struct net *net = SVC_NET(r);
>> 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>> +	struct nfs4_client *clp;
>>
>> 	status = nfserr_not_only_op;
>> 	if (nfsd4_compound_in_session(cstate, sessionid)) {
>> @@ -3697,6 +3783,13 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
>> 	ses = find_in_sessionid_hashtbl(sessionid, net, &status);
>> 	if (!ses)
>> 		goto out_client_lock;
>> +	clp = ses->se_client;
>> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
>> +		status = nfserr_badsession;
>> +		nfsd4_discard_courtesy_clnt(clp);
>> +		goto out_put_session;
>> +	}
>> +
>> 	status = nfserr_wrong_cred;
>> 	if (!nfsd4_mach_creds_match(ses->se_client, r))
>> 		goto out_put_session;
>> @@ -3801,7 +3894,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
>> 	struct xdr_stream *xdr = resp->xdr;
>> 	struct nfsd4_session *session;
>> -	struct nfs4_client *clp;
>> +	struct nfs4_client *clp = NULL;
>> 	struct nfsd4_slot *slot;
>> 	struct nfsd4_conn *conn;
>> 	__be32 status;
>> @@ -3911,6 +4004,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	if (conn)
>> 		free_conn(conn);
>> 	spin_unlock(&nn->client_lock);
>> +	if (clp && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &clp->cl_flags)) {
>> +		if (status == nfs_ok)
>> +			nfsd4_client_record_create(clp);
>> +		else
>> +			nfsd4_discard_courtesy_clnt(clp);
>> +	}
>> 	return status;
>> out_put_session:
>> 	nfsd4_put_session_locked(session);
>> @@ -3947,6 +4046,10 @@ nfsd4_destroy_clientid(struct svc_rqst *rqstp,
>> 	spin_lock(&nn->client_lock);
>> 	unconf = find_unconfirmed_client(&dc->clientid, true, nn);
>> 	conf = find_confirmed_client(&dc->clientid, true, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		nfsd4_discard_courtesy_clnt(conf);
>> +		conf = NULL;
>> +	}
>> 	WARN_ON_ONCE(conf && unconf);
>>
>> 	if (conf) {
>> @@ -4030,12 +4133,17 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	struct nfs4_client	*unconf = NULL;
>> 	__be32 			status;
>> 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>> +	struct nfs4_client *cclient = NULL;
>>
>> 	new = create_client(clname, rqstp, &clverifier);
>> 	if (new == NULL)
>> 		return nfserr_jukebox;
>> 	spin_lock(&nn->client_lock);
>> 	conf = find_confirmed_client_by_name(&clname, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		cclient = conf;
>> +		conf = NULL;
>> +	}
>> 	if (conf && client_has_state(conf)) {
>> 		status = nfserr_clid_inuse;
>> 		if (clp_used_exchangeid(conf))
>> @@ -4066,7 +4174,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>> 	new = NULL;
>> 	status = nfs_ok;
>> out:
>> +	if (cclient)
>> +		unhash_client_locked(cclient);
>> 	spin_unlock(&nn->client_lock);
>> +	if (cclient)
>> +		expire_client(cclient);
>> 	if (new)
>> 		free_client(new);
>> 	if (unconf) {
>> @@ -4096,6 +4208,10 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>> 	spin_lock(&nn->client_lock);
>> 	conf = find_confirmed_client(clid, false, nn);
>> 	unconf = find_unconfirmed_client(clid, false, nn);
>> +	if (conf && test_bit(NFSD4_CLIENT_COURTESY_CLNT, &conf->cl_flags)) {
>> +		nfsd4_discard_courtesy_clnt(conf);
>> +		conf = NULL;
>> +	}
>> 	/*
>> 	 * We try hard to give out unique clientid's, so if we get an
>> 	 * attempt to confirm the same clientid with a different cred,
>> @@ -4126,6 +4242,11 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>> 		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
>> 	} else {
>> 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
>> +		if (old && test_bit(NFSD4_CLIENT_COURTESY_CLNT,
>> +						&old->cl_flags)) {
>> +			nfsd4_discard_courtesy_clnt(old);
>> +			old = NULL;
>> +		}
>> 		if (old) {
>> 			status = nfserr_clid_inuse;
>> 			if (client_has_state(old)
>> @@ -4711,18 +4832,41 @@ nfsd_break_deleg_cb(struct file_lock *fl)
>> 	return ret;
>> }
>>
>> +/*
>> + * Function returns true if lease conflict was resolved
>> + * else returns false.
>> + */
>> static bool nfsd_breaker_owns_lease(struct file_lock *fl)
>> {
>> 	struct nfs4_delegation *dl = fl->fl_owner;
>> 	struct svc_rqst *rqst;
>> 	struct nfs4_client *clp;
>>
>> +	clp = dl->dl_stid.sc_client;
>> +
>> +	/*
>> +	 * need to sync with courtesy client trying to reconnect using
>> +	 * the cl_cs_lock, nn->client_lock can not be used since this
>> +	 * function is called with the fl_lck held.
>> +	 */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags)) {
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		return true;
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +
>> 	if (!i_am_nfsd())
>> -		return NULL;
>> +		return false;
> As noted in my general comments, this change (and the one
> right below) is a stand-alone fix that I've pulled into a
> separate patch and already applied.

ok.

>
>
>> 	rqst = kthread_data(current);
>> 	/* Note rq_prog == NFS_ACL_PROGRAM is also possible: */
>> 	if (rqst->rq_prog != NFS_PROGRAM || rqst->rq_vers < 4)
>> -		return NULL;
>> +		return false;
>> 	clp = *(rqst->rq_lease_breaker);
>> 	return dl->dl_stid.sc_client == clp;
>> }
>> @@ -4755,7 +4899,7 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
>> }
>>
>> static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
>> -						struct nfsd_net *nn)
>> +			struct nfsd_net *nn)
>> {
>> 	struct nfs4_client *found;
>>
>> @@ -4785,6 +4929,9 @@ static __be32 set_client(clientid_t *clid,
>> 	cstate->clp = lookup_clientid(clid, false, nn);
>> 	if (!cstate->clp)
>> 		return nfserr_expired;
>> +
>> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &cstate->clp->cl_flags))
>> +		nfsd4_client_record_create(cstate->clp);
>> 	return nfs_ok;
>> }
>>
>> @@ -4937,9 +5084,89 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
>> 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
>> }
>>
>> -static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> +static bool
>> +nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
>> +			bool share_access)
>> +{
>> +	if (share_access) {
>> +		if (!stp->st_deny_bmap)
>> +			return false;
>> +
>> +		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
>> +			(access & NFS4_SHARE_ACCESS_READ &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
>> +			(access & NFS4_SHARE_ACCESS_WRITE &&
>> +				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
>> +			return true;
>> +		}
>> +		return false;
>> +	}
>> +	if ((access & NFS4_SHARE_DENY_BOTH) ||
>> +		(access & NFS4_SHARE_DENY_READ &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
>> +		(access & NFS4_SHARE_DENY_WRITE &&
>> +			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * This function is called to check whether nfserr_share_denied should
>> + * be returning to client.
> Nit: The Linux kernel contributor's documentation recommends
> that short explanations should be written in the imperative,
> like so:
>
> "Check whether nfserr_share_denied should be returned."

fix in v14.

>
>
>> + *
>> + * access:  is op_share_access if share_access is true.
>> + *	    Check if access mode, op_share_access, would conflict with
>> + *	    the current deny mode of the file 'fp'.
>> + * access:  is op_share_deny if share_access is false.
>> + *	    Check if the deny mode, op_share_deny, would conflict with
>> + *	    current access of the file 'fp'.
>> + * stp:     skip checking this entry.
>> + * new_stp: normal open, not open upgrade.
>> + *
>> + * Function returns:
>> + *	true   - access/deny mode conflict with normal client.
>> + *	false  - no conflict or conflict with courtesy client(s) is resolved.
>> + */
>> +static bool
>> +nfs4_conflict_clients(struct nfs4_file *fp, bool new_stp,
>> +		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
>> +{
>> +	struct nfs4_ol_stateid *st;
>> +	struct nfs4_client *cl;
>> +	bool conflict = false;
>> +
>> +	lockdep_assert_held(&fp->fi_lock);
>> +	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
>> +		if (st->st_openstp || (st == stp && new_stp) ||
>> +			(!nfs4_check_access_deny_bmap(st,
>> +					access, share_access)))
>> +			continue;
>> +
>> +		/* need to sync with courtesy client trying to reconnect */
>> +		cl = st->st_stid.sc_client;
>> +		spin_lock(&cl->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags)) {
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &cl->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &cl->cl_flags);
>> +			spin_unlock(&cl->cl_cs_lock);
>> +			continue;
>> +		}
>> +		/* conflict not caused by courtesy client */
>> +		spin_unlock(&cl->cl_cs_lock);
>> +		conflict = true;
>> +		break;
>> +	}
>> +	return conflict;
>> +}
>> +
>> +static __be32
>> +nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
>> -		struct nfsd4_open *open)
>> +		struct nfsd4_open *open, bool new_stp)
>> {
>> 	struct nfsd_file *nf = NULL;
>> 	__be32 status;
>> @@ -4955,15 +5182,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
>> 	 */
>> 	status = nfs4_file_check_deny(fp, open->op_share_deny);
>> 	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_deny, false)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> 	}
>>
>> 	/* set access to the file */
>> 	status = nfs4_file_get_access(fp, open->op_share_access);
>> 	if (status != nfs_ok) {
>> -		spin_unlock(&fp->fi_lock);
>> -		goto out;
>> +		if (status != nfserr_share_denied) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> +		if (nfs4_conflict_clients(fp, new_stp, stp,
>> +				open->op_share_access, true)) {
>> +			spin_unlock(&fp->fi_lock);
>> +			goto out;
>> +		}
>> 	}
>>
>> 	/* Set access bits in stateid */
>> @@ -5014,7 +5255,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
>> 	unsigned char old_deny_bmap = stp->st_deny_bmap;
>>
>> 	if (!test_access(open->op_share_access, stp))
>> -		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
>> +		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
>>
>> 	/* test and set deny mode */
>> 	spin_lock(&fp->fi_lock);
>> @@ -5363,7 +5604,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>> 			goto out;
>> 		}
>> 	} else {
>> -		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
>> +		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>> 		if (status) {
>> 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>> 			release_open_stateid(stp);
>> @@ -5597,6 +5838,121 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>> }
>> #endif
>>
>> +static bool
>> +nfs4_anylock_blocker(struct nfs4_client *clp)
>> +{
>> +	int i;
>> +	struct nfs4_stateowner *so, *tmp;
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_file *nf;
>> +	struct inode *ino;
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	spin_lock(&clp->cl_lock);
>> +	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> +		/* scan each lock owner */
>> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
>> +				so_strhash) {
>> +			if (so->so_is_open_owner)
>> +				continue;
>> +
>> +			/* scan lock states of this lock owner */
>> +			lo = lockowner(so);
>> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
>> +					st_perstateowner) {
>> +				nf = stp->st_stid.sc_file;
>> +				ino = nf->fi_inode;
>> +				ctx = ino->i_flctx;
>> +				if (!ctx)
>> +					continue;
>> +				/* check each lock belongs to this lock state */
>> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> +					if (fl->fl_owner != lo)
>> +						continue;
>> +					if (!list_empty(&fl->fl_blocked_requests)) {
>> +						spin_unlock(&clp->cl_lock);
>> +						return true;
>> +					}
>> +				}
>> +			}
>> +		}
>> +	}
>> +	spin_unlock(&clp->cl_lock);
>> +	return false;
>> +}
>> +
>> +static void
>> +nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>> +				struct laundry_time *lt)
>> +{
>> +	struct list_head *pos, *next;
>> +	struct nfs4_client *clp;
>> +	bool cour;
>> +	struct list_head cslist;
>> +
>> +	INIT_LIST_HEAD(reaplist);
>> +	INIT_LIST_HEAD(&cslist);
>> +	spin_lock(&nn->client_lock);
>> +	list_for_each_safe(pos, next, &nn->client_lru) {
>> +		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> +		if (!state_expired(lt, clp->cl_time))
>> +			break;
>> +
>> +		/* client expired */
>> +		if (!client_has_state(clp)) {
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +
>> +		/* expired client has state */
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>> +			goto exp_client;
>> +
>> +		cour = test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +		if (cour &&
>> +			ktime_get_boottime_seconds() >= clp->courtesy_client_expiry)
>> +			goto exp_client;
>> +
>> +		if (nfs4_anylock_blocker(clp)) {
>> +			/* expired client has state and has blocker. */
>> +exp_client:
>> +			if (mark_client_expired_locked(clp))
>> +				continue;
>> +			list_add(&clp->cl_lru, reaplist);
>> +			continue;
>> +		}
>> +		/*
>> +		 * Client expired and has state and has no blockers.
>> +		 * If there is race condition with blockers, next time
>> +		 * the laundromat runs it will catch it and expires
>> +		 * the client.
> Is this comment still true? I thought the laundromat now
> turns such clients into courtesy clients.

Yes. The laundromat will turn expired client with no blockers
into courtesy client. I will replace:

'Client expired and has state and has no blockers.'
with
'Client expired and has state and has no blockers, transits
client to courtesy client'.

>
>
>> +		 */
>> +		if (!cour) {
>> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
>> +			clp->courtesy_client_expiry = ktime_get_boottime_seconds() +
>> +					NFSD_COURTESY_CLIENT_TIMEOUT;
>> +			list_add(&clp->cl_cs_list, &cslist);
> Can cl_lru (or some other existing list_head field)
> be used instead of cl_cs_list?

The cl_lru is used for clients to be expired, the cl_cs_list
is used for courtesy clients and they are treated differently.
Merging two lists together means we have to re-scan the cl_lru
list again to pick the courtesy clients and take appropriate
action which is not very efficient and clean. I don't see any
existing list_head field can be used for this.

>
> I don't see anywhere that removes clp from cslist when
> this processing is complete. Seems like you will get
> list corruption next time the laundromat looks at
> its list of nfs4_clients.

We re-initialize the list head before every time the laundromat
runs so there is no need to remove the entries once we're done.

>
>
>> +		}
>> +	}
>> +	spin_unlock(&nn->client_lock);
>> +
>> +	list_for_each_entry(clp, &cslist, cl_cs_list) {
>> +		spin_lock(&clp->cl_cs_lock);
>> +		if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags) ||
>> +			!test_bit(NFSD4_CLIENT_COURTESY,
>> +					&clp->cl_flags)) {
>> +			spin_unlock(&clp->cl_cs_lock);
>> +			continue;
>> +		}
>> +		spin_unlock(&clp->cl_cs_lock);
>> +		nfsd4_client_record_remove(clp);
>> +	}
> It wasn't clear to me what was going on here. I did a double
> and triple take. But it looks like this is the spot where,
> instead of removing the client record and destroying the
> client, we just remove the client record and leave the
> client in existence.

This block of code is to handle the race condition where the client
was set to NFSD4_CLIENT_COURTESY and the client re-connects before
the record for the client is created. This race condition is
possible after the nn->client_lock was released. In that case,
the courtesy client is either set to DESTROY_COURTESY or the client
already transited to active (CLIENT_COURTESY is cleared). We check
for this condition and skip calling nfsd4_client_record_remove.
I'll add a comment to note this race condition.

>
> A more explanatory name for @cslist would help readers, IMO.
>
> But maybe this code can be reorganized so that the high-level
> decisions are made clear and the technical details are
> shuffled off into helper functions. I don't have any specific
> suggestions at this point, but I'm going to continue thinking
> about how to make the laundromat a little less cluttered,
> possibly as follow-on work.

If we can defer any work to later phase that would be great!

>
>
>> +}
>> +
>> static time64_t
>> nfs4_laundromat(struct nfsd_net *nn)
>> {
>> @@ -5630,16 +5986,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>> 	}
>> 	spin_unlock(&nn->s2s_cp_lock);
>>
>> -	spin_lock(&nn->client_lock);
>> -	list_for_each_safe(pos, next, &nn->client_lru) {
>> -		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> -		if (!state_expired(&lt, clp->cl_time))
>> -			break;
>> -		if (mark_client_expired_locked(clp))
>> -			continue;
>> -		list_add(&clp->cl_lru, &reaplist);
>> -	}
>> -	spin_unlock(&nn->client_lock);
>> +	nfs4_get_client_reaplist(nn, &reaplist, &lt);
> There's already an "INIT_LIST_HEAD(&reaplist);" right above
> this hunk that is repeated inside nfs4_get_client_reaplist().
> Either one (but not both) can be removed.

fix in v14.

>
>
>> 	list_for_each_safe(pos, next, &reaplist) {
>> 		clp = list_entry(pos, struct nfs4_client, cl_lru);
>> 		trace_nfsd_clid_purged(&clp->cl_clientid);
>> @@ -6021,6 +6368,15 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>> 	found = lookup_clientid(&cps->cp_p_clid, true, nn);
>> 	if (!found)
>> 		goto out;
>> +	if (test_bit(NFSD4_CLIENT_COURTESY_CLNT, &found->cl_flags)) {
>> +		spin_lock(&found->cl_cs_lock);
>> +		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &found->cl_flags);
>> +		spin_unlock(&found->cl_cs_lock);
>> +		if (atomic_dec_and_lock(&found->cl_rpc_users,
>> +					&nn->client_lock))
>> +			spin_unlock(&nn->client_lock);
>> +		goto out;
>> +	}
>>
>> 	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
>> 			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
>> @@ -6525,6 +6881,43 @@ nfs4_transform_lock_offset(struct file_lock *lock)
>> 		lock->fl_end = OFFSET_MAX;
>> }
>>
>> +/**
>> + * nfsd4_fl_lock_expired - check if lock conflict can be resolved.
>> + *
>> + * @fl: pointer to file_lock with a potential conflict
>> + * Return values:
>> + *   %false: real conflict, lock conflict can not be resolved.
>> + *   %true: no conflict, lock conflict was resolved.
>> + *
>> + * Note that this function is called while the flc_lock is held.
>> + */
>> +static bool
>> +nfsd4_fl_lock_expired(struct file_lock *fl)
> I'd prefer this guy to be named like the newer lm_ functions,
> not the old fl_ functions. So: nfsd4_lm_lock_expired()

This is a bit messy:

static const struct lock_manager_operations nfsd_posix_mng_ops  = {
         .lm_notify = nfsd4_lm_notify,
         .lm_get_owner = nfsd4_fl_get_owner,
         .lm_put_owner = nfsd4_fl_put_owner,
         .lm_lock_expired = nfsd4_fl_lock_expired,
};

Most NFS callbacks are named nfsd4_fl_xx and one as
nfsd4_fl_lock_expired. I will change nfsd4_fl_lock_expired to
nfsd4_lm_lock_expired as suggested but note this inconsistency
is still there.


>
> As an aside: I harp a lot on names and on patch descriptions.
> Open source code is meant to enable users to make deep changes
> to the software they use. They can't do that if the code is
> obscure or poorly documented. Thus I view naming and
> descriptions as nearly as critical as proper code licensing
> for open source projects.
>
> But also my memory is failing. The source code has to be
> easily legible a year down the road when I have no
> recollection of what it does or why. :-)

Totally agreed.

>
>
>> +{
>> +	struct nfs4_lockowner *lo;
>> +	struct nfs4_client *clp;
>> +	bool rc = false;
>> +
>> +	if (!fl)
>> +		return false;
>> +	lo = (struct nfs4_lockowner *)fl->fl_owner;
>> +	clp = lo->lo_owner.so_client;
>> +
>> +	/* need to sync with courtesy client trying to reconnect */
>> +	spin_lock(&clp->cl_cs_lock);
>> +	if (test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags))
>> +		rc = true;
>> +	else {
>> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
>> +			set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>> +			rc =  true;
>> +		} else
>> +			rc =  false;
> Couldn't you write it this way instead:
>
> 	if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
> 		set_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
> 	rc = !!test_bit(NFSD4_CLIENT_DESTROY_COURTESY, &clp->cl_flags);
>
> This is more a check to see whether I understand what's
> going on rather than a request to change the patch.

I think it works the same. Every time I see a '!!' it gives me
a headache :-)

>
>
>> +	}
>> +	spin_unlock(&clp->cl_cs_lock);
>> +	return rc;
>> +}
>> +
>> static fl_owner_t
>> nfsd4_fl_get_owner(fl_owner_t owner)
>> {
>> @@ -6572,6 +6965,7 @@ static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>> 	.lm_notify = nfsd4_lm_notify,
>> 	.lm_get_owner = nfsd4_fl_get_owner,
>> 	.lm_put_owner = nfsd4_fl_put_owner,
>> +	.lm_lock_expired = nfsd4_fl_lock_expired,
>> };
>>
>> static inline void
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 3e5008b475ff..920fad00e2e4 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
>> #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
>>
>> #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
>> +#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
>>
>> /*
>>   * The following attributes are currently not supported by the NFSv4 server:
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 95457cfd37fc..80e565593d83 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -345,6 +345,9 @@ struct nfs4_client {
>> #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
>> #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
>> 					 1 << NFSD4_CLIENT_CB_KILL)
>> +#define NFSD4_CLIENT_COURTESY		(6)	/* be nice to expired client */
> The comment is a little obtuse. If the client is
> actually expired, then it will be ignored and
> destroyed. Maybe "client is unreachable" ?

I think "client is unreachable" is not precise and kind of
confusing so unless you insists I'd like to keep it this way
or just removing it.

>
>
>> +#define NFSD4_CLIENT_DESTROY_COURTESY	(7)
> Maybe NFSD4_CLIENT_EXPIRE_COURTESY ? Dunno.

Unless you, or other reviewers, insist I'd like to keep it this way.

>
>
>> +#define NFSD4_CLIENT_COURTESY_CLNT	(8)	/* used for lookup clientid/name */
> The name CLIENT_COURTESY_CLNT doesn't make sense to me
> when it appears in context. The comment doesn't clarify
> it either. May I suggest:
>
> #define NFSD4_CLIENT_RENEW_COURTESY	(8)	/* courtesy -> active */

The NFSD4_CLIENT_COURTESY_CLNT flag does not mean this courtesy
client will always transit to active client. The flag is used to
indicate this was a courtesy client and it's up to the caller to
take appropriate action; destroy it or create client record before
using it.

>
> Nit: If I'm reading the header file correctly, these new
> definitions should /precede/ the definition of
> NFSD4_CLIENT_CB_FLAG_MASK.

fix in v14.

>
>
>> 	unsigned long		cl_flags;
>> 	const struct cred	*cl_cb_cred;
>> 	struct rpc_clnt		*cl_cb_client;
>> @@ -385,6 +388,9 @@ struct nfs4_client {
>> 	struct list_head	async_copies;	/* list of async copies */
>> 	spinlock_t		async_lock;	/* lock for async copies */
>> 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
>> +	int			courtesy_client_expiry;
> New fields need to be named cl_yada. "cl_courtesy_expiry"
> maybe? Also, please make this a time64_t field.

fix in v14.

>
> Or, would it be possible instead to compute the expiry based
> on the time of the last state renewal? Then a new field wouldn't
> be necessary. I'm not sure, on balance, whether that would add
> or reduce complexity.

fix in v14, remove cl_courtesy_expiry and use the time of the
last state renewal. Thanks! we get rid the new field.

-Dai

>
>
>> +	spinlock_t		cl_cs_lock;
>> +	struct list_head	cl_cs_list;
>> };
>>
>> /* struct nfs4_client_reset
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
>
