Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB3853A775
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354081AbiFAOB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354233AbiFAOAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:00:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEDF91573;
        Wed,  1 Jun 2022 06:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEjKeoJWiOy1KZ8iSsLe3wNF/Udtz6kb5P4ZEnEeYt53kmiX9WeiOPFUKYRYUY4xSJBp/C5oZgNgRGNl4LR5Cv4kjoAxXzWZFjDHCWYb0zAFHbRVG11QEvr040vOGoehvEjtjdKJ/3E/msancZ0dtGTlHMxprvrCGP8ejGibVxft+zO81mgVt/malB8zPOhpC7V6QdoaswOe1W89VOitD3YMbzn9JqV0lVOcM+/L6ZVKpAhW4algBuHdZ6lMS2nF/VcIv9EjKFzo3mhORX0Q6S6OBbOpL6h7VLFrm0K49FknhyhQjZR51LI8tvkL4Okfh24JvCLNlSamF9d/xe5JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJqP1OvV1n+fff+L/BTJPGUrZxXimeTns5PAInVDUuo=;
 b=deLAbU2gu4GazkAcI9QFxDU3ySnySzo8kX3j7NdFqbAanLn/tNLoOIYmcav4fuqXw8Vf/pCm3/UNAl/OM+lVOKvgC2CH6b47dLGbcVQ8iei8jAxWWc2+ATODw9qRqfIaLdch14Tlro402GuZxvpk4avQYVndXknue6va1W329PhrGaN8tPO5mO4iDdmRhU+zlpjuaW4r9f/7nuOko4DmSAuHqEO9P4OqcUKKdLB1DmKYzUb6wk69vNtr2ZJgkxOrFEE5p1RrrofQXrtWg9MdT/F6O00QsNx23Rwq8cIcyD9udNVjb9BwYtGvVcSlXIasHHT2umZ6wnT90Lmv0BfYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJqP1OvV1n+fff+L/BTJPGUrZxXimeTns5PAInVDUuo=;
 b=B/zGJ2UiXDCfO7sXHAbaW62hhluHTqFb0UQU7/3OMR1bCeVMHkTrhaHdwuQswCyJR227Wo0TioFX1MgN3oW+XC8TUjlz/CItaXT/Gfehte9f3qL1w7BS5tnsYKF7klj1stkv5VFrVvJKZZEQ8AqSsrPiopaEsOrfdINsIVQgPwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 13:55:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 13:55:36 +0000
Message-ID: <78efbada-6dd5-ead7-fc10-38b5e1e92fc5@amd.com>
Date:   Wed, 1 Jun 2022 15:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] procfs: Add 'size' to /proc/<pid>/fdinfo/
Content-Language: en-US
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20220531212521.1231133-1-kaleshsingh@google.com>
 <20220531212521.1231133-2-kaleshsingh@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220531212521.1231133-2-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR07CA0045.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7e69550-8df7-490c-4a8e-08da43d66785
X-MS-TrafficTypeDiagnostic: DM6PR12MB4450:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB445046A6ED32CEC5F7CC80B283DF9@DM6PR12MB4450.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PcZb7jkDJ3w9q0eU2df2dMizU+u6PqIwLN8iCLbXlKvNWBQx6daFFHtm84My3IdVwD9sLPC8mzsNpZV2AQomPw/CYuRj8lj+SdN3BV9cVqEeNgmu81loCmY1wCaUg3rl04FtdDL4xQKF54TQsh+T/kpl0SOMHkU1/OSKQQJ5wdgfFd8AADuuBBja0IeOJi46hlXgvE/Y8/8KJ2RVjsuxGWIOLpsNeThFc8xtA8TIeoN9IbYqYH9RGrtwThMK36QbgNQRqxD0ak1szEYafhJJ0Lf3edP5NaMrLYVxtsQ2tBtHx5/rwpK6yRrZU757BuOF9+dveRTeAo6FVLUszl3+H12L6y8WtgPRp6xvspY/nJGGvrB2sKpwUtWmve2LRsR3ue37VbRIZXPOJ1DB9udnOVMkK5OaL6+KuERWgGRSLIbFEFnBQ5g1Yz1oSeY4yWWzAXnBDvHRVHIX+UrU2RQu6sQIZBo3h5NNcqwsb6Z2t7IbB4TNs0TuwQUuaL1jKjVLeEpjvGi5pP+15gdlU5FjyD8b/zLxIUfxngr3wgRTQrMeSF+4lb+Jyp6feG59bsS8XcvyFdE657XWfheNhOWnWOrpPH7M3YqsDG13XyxIz3NcU0wJrMhvLpUzR9mEIouEnnymibW+tAP8lXmis5U31rjjYhIi+qltEw57+m/btxFM3iHZY0wl/cPfWEzFEL6Nk5FedOoVBfFl88jE37twTHISC34eL5uOd9MeF2okp1r4/3hSYmvPdehsqt3kq6SpnNfTEb6cOGJxxHAhJqatXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(54906003)(6666004)(6512007)(66476007)(2906002)(36756003)(83380400001)(6486002)(31686004)(31696002)(5660300002)(8676002)(86362001)(4326008)(7416002)(6916009)(316002)(66946007)(66556008)(38100700002)(8936002)(186003)(508600001)(2616005)(66574015)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZaVzB5ZE9GTlBIdWc0blRHcjN0amhXWUhBejJIZkZWUTZueko5RktXZ1R2?=
 =?utf-8?B?SGRlQnpBNm1qcjFINjlJNHp3VTh3TkFuMzJZbEhJaGlZZEJnMURhMFh2ZWVX?=
 =?utf-8?B?MjJXYWhUcU9qcUdTWWg0NENrS0FoMVdBdWRNQTZ4MS9VbEFzYUlzWEZJa0xX?=
 =?utf-8?B?Y0U3eWJzeGxyTVp5OG1rU3hnMXl6YUVFSHI0cTZKbzFBU1Mvd2lSRlZianBk?=
 =?utf-8?B?bHBLL0xscjd3M1RuZk5YZkZja0pKODAvR0Y3QzFObzR6UVF0MnVwRk5Ea0lT?=
 =?utf-8?B?K1dQTUFUay92OTdjcmJNSmVuMGxWSmo0YlVRNWRzQXRCa3FxZ2lWWW9Yc21X?=
 =?utf-8?B?bzFycUJCclQ5Mk92bHc3eGppU3QwY09ibUhHS2xaQlZVWmg1cGt1K3ppUjRo?=
 =?utf-8?B?ek0rWGJ1clkrSjZKT2JBTk5PZnFzTzAydER2WDNHVkZCaHBDOHgvazJPVDhT?=
 =?utf-8?B?MVgwLy93aWMzeW5ETDVnNHM0USs4ZnVaZ3lBeXVlbTZnU0JsWXlxdHlXZWY2?=
 =?utf-8?B?N0tuTlRSZjRpVjY4a0JPU1Y4c0FDbWdMWXRjU3Roam5qQUIyUFlmbUVmSGVy?=
 =?utf-8?B?L05IZ29pYkxYeVlwMGd2enRWNGdKUkl1MU95RUZkN09BZE9PazNqd2h2aDdJ?=
 =?utf-8?B?d2syRzJHdFI0SFNKNG10bFNIVUJibVhBanBhUTdpcW5qRzFqNXF4R05TVXo5?=
 =?utf-8?B?dk01aXA1OCtWR2NPL0Rvb3ljWnNSR1ovMW1rTFlHeEt2NEpqTzlyd0dtWWZW?=
 =?utf-8?B?MWkza3NaUTJycUdNTE1ITjljWkV1SlpDc25NYVhlVDdTTGhtMkZIQS9ITENt?=
 =?utf-8?B?REtVcW42Sy9tc3RzZlF5YThJYlFvVTB6SnNkNHhUelVnb0FrNEF5dytyWFA2?=
 =?utf-8?B?R0VrcGZHWmJDRUlIV1FqYjd5T1llTWtGZHZWZXlRS1pOU2pNVmswWFM0S1k3?=
 =?utf-8?B?MFJtYWpGRVFlbkNjdlJta2hjL2N2dzFmZ2d4Q1NyLzVleGhYdlhsckRUSGxm?=
 =?utf-8?B?TkhkbjFxVzRUTEh6TE1QdWJzLzNyRVRDY1ZYYVdhdlpMa3R3SlhZc21jSllN?=
 =?utf-8?B?L0JnT0NINkxRc1JXTFVTUys2OVlvMm9xaEo2YWgzbzAzUHR0S1ZoN0ZFektt?=
 =?utf-8?B?dHkrcE1JcGZaMXFuWDZTY1FucUYxZ25FeCsrN0hRWlhWOEdwU3dOUkp1eHox?=
 =?utf-8?B?Yzd0eFBGeC84QjExNTY3U2doSU5TcHJLc1FaTnNyN0RoN1BDSm5FbXVPWE1W?=
 =?utf-8?B?TlRVU3luY0kyN2thYWxLcUpFVU51NXpKR2w0Q1lkbFB4ZXVGRjFHMnRlNHRj?=
 =?utf-8?B?c2hEVG1UbjBFMTNodkZBeS9XR2RzMWpYR2l2V0tVRDNxT1IzL1lJZEd4L3RG?=
 =?utf-8?B?MVFiOU1xRTQ5VDl2blRFT29mOXFpbUt3ZnV6bjB4bXVqRldyN01LQUdqZVRl?=
 =?utf-8?B?WS85L003YzJmdFVZbk8wSmdIVC80NjUrazljRXNibGxTcHh5bW1zeVpEZENS?=
 =?utf-8?B?SjZ5ekVub1hoeHQyTVBxRzlsZDE5RncxS2xsb3VxaDFkWTdYSTkxN1dMbFJK?=
 =?utf-8?B?KyttSnhtOW4zd1ZuSmpjS3cxTVVWY1NmS2ZON1JuMGFsZyt0YU0zT1VUOUlB?=
 =?utf-8?B?bkRwOVNpaERmNGxqM0RsSkRYaVJadzl5NGNxL3FJOGJHc3BENkRSR2FxN2FU?=
 =?utf-8?B?SmFSTjlnQWxDWFhoZ1FxeGtCQmh6MnpDM1hRWTFLV1JuSUN5TWJxVyswblI0?=
 =?utf-8?B?Vlg2UC9FRTV5TzVkOXppV3VZSUpzUFRidXJzaVFXS0ZpVjdrMVZiYVRRWFJK?=
 =?utf-8?B?YnA1UXhWK0pTdlJxcFhSb0xkZjRFcFZ0SjcwdFNOTWx4YlJDR3Y1Rmt6Zk03?=
 =?utf-8?B?WnJrZ0RwSVlENkh1eEZWT09RRkJSeXBQQXJUSmphUnlpMVZWNzM1aVp0S2pU?=
 =?utf-8?B?TEZUTXBVM0xFKzNUb1J6Q1BCY3lzZEhYbHZIWkE2UjUrOXpmYmhMZHlLcG0r?=
 =?utf-8?B?ZWRzc0djR2NRT2FrNm13Y1RDMnIrclZWZ0d5NjZCTXFXM3FIS2I5eEV3dU1u?=
 =?utf-8?B?WlJZNGFSejJoV2pjb0tVMmpWZnBvR0pubTlXM05yTm0wek5ZM2lyMkwzSFBv?=
 =?utf-8?B?Y205TEI2UXhNNlI4Q0l1cWZBamdVYklmSm5oQkNXNUV2bTI1ODRZRUxuR3hM?=
 =?utf-8?B?VWI5NUhnRE41dlBZUXpjd2wyQnJwZEtWTzBYMkZ1eXZ3NVVkMi95SFlyWkhS?=
 =?utf-8?B?NGM3MkhsaXdqODREdTlVZ3MzL0pqV2NrZkhXZnlyVVpsTlBDSUw5akVQaXFo?=
 =?utf-8?B?OW4vclJxNUV3b1MxOHdKOEpOZFVBcWpOS0dDYnBnanNQcHo4djBXZHlkSHRh?=
 =?utf-8?Q?ns7XnK2ZxrGuQ0rlxapRnGHH+dwXQUkhStVUAnSWpcvCQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 3KCYxfYe406WtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e69550-8df7-490c-4a8e-08da43d66785
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 13:55:36.8009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA/IRNWAcXv6x9hXXRzqxclpNYt3ke66k0EH5Z5VANWrFkCuMyaOU1AAtQd3Qtd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 31.05.22 um 23:25 schrieb Kalesh Singh:
> To be able to account the amount of memory a process is keeping pinned
> by open file descriptors add a 'size' field to fdinfo output.
>
> dmabufs fds already expose a 'size' field for this reason, remove this
> and make it a common field for all fds. This allows tracking of
> other types of memory (e.g. memfd and ashmem in Android).
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

At least for the DMA-buf part feel free to add an Reviewed-by: Christian 
König <christian.koenig@amd.com> for this.

Regards,
Christian.

> ---
>
> Changes from rfc:
>    - Split adding 'size' and 'path' into a separate patches, per Christian
>    - Split fdinfo seq_printf into separate lines, per Christian
>    - Fix indentation (use tabs) in documentaion, per Randy
>
>   Documentation/filesystems/proc.rst | 12 ++++++++++--
>   drivers/dma-buf/dma-buf.c          |  1 -
>   fs/proc/fd.c                       |  9 +++++----
>   3 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 1bc91fb8c321..779c05528e87 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1886,13 +1886,14 @@ if precise results are needed.
>   3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
>   ---------------------------------------------------------------
>   This file provides information associated with an opened file. The regular
> -files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
> +files have at least five fields -- 'pos', 'flags', 'mnt_id', 'ino', and 'size'.
> +
>   The 'pos' represents the current offset of the opened file in decimal
>   form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
>   file has been created with [see open(2) for details] and 'mnt_id' represents
>   mount ID of the file system containing the opened file [see 3.5
>   /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
> -the file.
> +the file, and 'size' represents the size of the file in bytes.
>   
>   A typical output is::
>   
> @@ -1900,6 +1901,7 @@ A typical output is::
>   	flags:	0100002
>   	mnt_id:	19
>   	ino:	63107
> +	size:	0
>   
>   All locks associated with a file descriptor are shown in its fdinfo too::
>   
> @@ -1917,6 +1919,7 @@ Eventfd files
>   	flags:	04002
>   	mnt_id:	9
>   	ino:	63107
> +	size:   0
>   	eventfd-count:	5a
>   
>   where 'eventfd-count' is hex value of a counter.
> @@ -1930,6 +1933,7 @@ Signalfd files
>   	flags:	04002
>   	mnt_id:	9
>   	ino:	63107
> +	size:   0
>   	sigmask:	0000000000000200
>   
>   where 'sigmask' is hex value of the signal mask associated
> @@ -1944,6 +1948,7 @@ Epoll files
>   	flags:	02
>   	mnt_id:	9
>   	ino:	63107
> +	size:   0
>   	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
>   
>   where 'tfd' is a target file descriptor number in decimal form,
> @@ -1962,6 +1967,7 @@ For inotify files the format is the following::
>   	flags:	02000000
>   	mnt_id:	9
>   	ino:	63107
> +	size:   0
>   	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
>   
>   where 'wd' is a watch descriptor in decimal form, i.e. a target file
> @@ -1985,6 +1991,7 @@ For fanotify files the format is::
>   	flags:	02
>   	mnt_id:	9
>   	ino:	63107
> +	size:   0
>   	fanotify flags:10 event-flags:0
>   	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
>   	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> @@ -2010,6 +2017,7 @@ Timerfd files
>   	flags:	02
>   	mnt_id:	9
>   	ino:	63107
> +	size:   0
>   	clockid: 0
>   	ticks: 0
>   	settime flags: 01
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 32f55640890c..5f2ae38c960f 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -378,7 +378,6 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
>   {
>   	struct dma_buf *dmabuf = file->private_data;
>   
> -	seq_printf(m, "size:\t%zu\n", dmabuf->size);
>   	/* Don't count the temporary reference taken inside procfs seq_show */
>   	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
>   	seq_printf(m, "exp_name:\t%s\n", dmabuf->exp_name);
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 913bef0d2a36..464bc3f55759 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -54,10 +54,11 @@ static int seq_show(struct seq_file *m, void *v)
>   	if (ret)
>   		return ret;
>   
> -	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n",
> -		   (long long)file->f_pos, f_flags,
> -		   real_mount(file->f_path.mnt)->mnt_id,
> -		   file_inode(file)->i_ino);
> +	seq_printf(m, "pos:\t%lli\n", (long long)file->f_pos);
> +	seq_printf(m, "flags:\t0%o\n", f_flags);
> +	seq_printf(m, "mnt_id:\t%i\n", real_mount(file->f_path.mnt)->mnt_id);
> +	seq_printf(m, "ino:\t%lu\n", file_inode(file)->i_ino);
> +	seq_printf(m, "size:\t%lli\n", (long long)file_inode(file)->i_size);
>   
>   	/* show_fd_locks() never deferences files so a stale value is safe */
>   	show_fd_locks(m, file, files);

