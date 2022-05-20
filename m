Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3421A52E4FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbiETG3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 02:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345817AbiETG3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 02:29:30 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461F914C773;
        Thu, 19 May 2022 23:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUgcfFT8R+wKxNEb7QThBqUreTWQ8g7RORP7vhl9jZoNh+VekzJw1YHjPtl3nt0EGffcOer6+B7OcZZOuTt+7paSXHDlVajpgY989jK2iaTzNgT+gLgjs0VIi6El35YcWnyNN1qBKXut3XTIsh1M9dKgQhdsK88xXRPo3dVGsFKj5V+OjUqpWtGLDaUPeVXBX3uGH2l7HjESAX8XyvvpmHuhHHz/h31IcMigavTvSZWOkJ7TIUn1mWqUSRQ6fwtbhODDvu8pAPmGT0G8Tkwci3UnMGwr5SIo+2+aVXX1AbZS2eMicKstOsAFgt/5OFLjRrkkCosnsxbIFLR4tXhLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbHbPLiJpa/HyDLtdxyhgztgfUdoVwbXkv5/zsw6aMc=;
 b=Nb/floog+tdkwjAsr91wF0e41a0ePTa1x8D0RYsuwRfLgVlNytToeJMuQYuuSBF5E6gRUVaSbhpEZMjWw/q8QsEQCxWSDS2FfBnRQGRnh26UTZa6MguCSoOFNoWIZ4HfRWsxXoyZIYleWQprkwdmwdw7OFXNfp/K1y4KUjopacBqeA4Ka6ACMU1iycbzna9ewpuAWXSQVtphO2TqU4mUMK0ZUBdoX5UVzfLBlZz49FQ3xk3d9LTU0Pzim2HQGNhqtFoxHKyAlPF/sPMLQo3AgXmlYt0kqlw4/h8Ljqrqo8yRdp6+/Zt2Q4kcbI4hu26Hg4dlpzfBHFF0Ji09aKuvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbHbPLiJpa/HyDLtdxyhgztgfUdoVwbXkv5/zsw6aMc=;
 b=wDFoZX7f+GbIDbwh2aLsmBYZClvIV4zVvTC1DicTDAoOn2fK3ttEBAEqLsaZobxX+35t/A82EbsqJWrhWQWDdHT8X56HRPF4h2LMF2zqtK4g0cUH7wZVD9ODyJWq553bxJThpPC5VSgMYXF4B1szqO5WHuFjpulJJP7fQbr75fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1315.namprd12.prod.outlook.com (2603:10b6:404:1f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Fri, 20 May
 2022 06:29:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 06:29:26 +0000
Message-ID: <4e35dc30-1157-50b3-e3b6-954481a0524d@amd.com>
Date:   Fri, 20 May 2022 08:29:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] procfs: Add file path and size to /proc/<pid>/fdinfo
Content-Language: en-US
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Colin Cross <ccross@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20220519214021.3572840-1-kaleshsingh@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220519214021.3572840-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::27) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40043f3e-713e-4085-ce2f-08da3a2a15e3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1315:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB131550335EABD2DC65C3FAA883D39@BN6PR12MB1315.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d14YZn+irmJVw34RjNcmW/gCfI3fQ87go371MwkzyiYWn6Ub+//5nuMkUQYZ1SSWQuPUCrUYz/sHws1p3Uo4olFMkteDLWEYEY/H0u3ME0yk0T1l6TGDUSL/IO0NzvLExg1SG67agPM07OWYzW9DJXd0rOSKcoJ+NQdndiliaZuT+uOHUTtTd37EGTw3tgo5ZMCtC0nHW0PCMJA21KfTgGrLZSRpklnyU7GJt46uSb8oDsBiHEe5MIEoT1haUdpXEeVktO2t/HEQZVaovLmhuVKwsirSxeOu/3cQceh7TdWqmO7TmOVLE3n+XgFNxD88B5JMpyZuC3JBM4uAwABN2Pj6fbGufevnvyIuij62uaI6Pnq71Mg0ANRzbg2g+Ax/cBVp38OoNafMwBSRYnMliOcrbVd+t61s3+3GUyXB9fD8Pj9H/0Iu3Wwc1WwbgRBj5Rf7rJFj3gSElhPVgZz+KmOdHwC6WFESqZo5BPwE6ysGQyM+MZozN5Kp53zu8rKNQWWJz/Co1N3yXhVhxo501Kup9iuDtybXQz29SDzbIKsM9BzJMgCS426K7joN4ryP0aC6spTmKfEKZcADCF0qYfTQn0JB0vhO70lTmq94m0LlWOpZsNIQZmCv1zKKDZUAcFzqSrkEKWQdqIWAKU1O/f0va5ZyPkJIF6RFEIE5C3IAG56jb9tMtTLUuOl7g/4eQJNRPFkHenwA4q/H2fQdy72fwNWvfNDNbm5u9R73e3GOdu8SkQKnrXTRDgNFH3W/NLAndzSV3rD9UZAecwkc84nDYydZaPBsT4UiRVgX3H3n0WjK8NIMy4pmUE8y3oOGUiyOVfTDfSnIF/c9B0xMg8X4g9tiRAt0eQ1F8SCc+rE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(2906002)(36756003)(8676002)(4326008)(2616005)(6506007)(6486002)(966005)(7416002)(8936002)(6512007)(66556008)(54906003)(66946007)(5660300002)(508600001)(45080400002)(38100700002)(86362001)(316002)(66476007)(31696002)(6666004)(6916009)(31686004)(186003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXp1ZkRMVU9NRmZCSzdGMGlzazFnVHBTVEVYQmhUNEdBU01EcjM3Z29QV2dt?=
 =?utf-8?B?ajBZdjUvSUdjbXFaT0xIYmJEeFoybXQxbmMya1MwaEkrbXhjWWptdU5KYi9S?=
 =?utf-8?B?THIwRGwrMmNheU1PTG5BZlhreFpxTnhKNnZ1QXc1UTdSNm5tejhEbmdCeXdN?=
 =?utf-8?B?anIrZ0E2Ti8valdmRHA2ZU5KM244OXBnclpQVG9TRXkvNE41cFFrQVRta0p0?=
 =?utf-8?B?MXhqeHBTaWx0dWlGbHVZSHJtMi83YW1Ld1RqYXJnWGVFQ2RjQ25DOW9ITXdp?=
 =?utf-8?B?cWJNQS9DMTdvVXIvcTJlb3dkOWVmY3VSTEFRQzNtRlNlcmgrQWQyNjdPQjZE?=
 =?utf-8?B?bzJPZncvVFlXTWRtaXVNUGwwWTZCZEFGSEFWUTRwL3ArYmJUWVNKNXpyTHpK?=
 =?utf-8?B?OThJRlZ0R2pOUnZDSTVWbkJZTmlzcFZ1YmpHeGUvcmQyb2Z0MVVwdVJ2QjJG?=
 =?utf-8?B?U0tzb2VIZTVzUEprWXFZQUlGUnlLMmsyU1crVVp1aDZ1TTgyY0RmMjBZMndT?=
 =?utf-8?B?TUtTNmQ2M1prcDFHQ2JhWDlUd002TGlRZUI2d2VQb25kTDJaa2ZGUTdqWWN1?=
 =?utf-8?B?RWlkeEY4bE5OZ1JFWDRxNUx2Nm5kUjhOKzhCMnlvanpGN0NPTlJjMWxYdGt6?=
 =?utf-8?B?Nm9OdStadFk5T1NQRndBTSsyTXVhc2J4YVFFYTYxckRkSVNzK25xTllMbFJi?=
 =?utf-8?B?dEdNdHlPd2tZWWRWMjdJY2haUzlVWWVUZnR1b2cxV29DRnZXdWJ3OUlLM0ZP?=
 =?utf-8?B?R292T3k5NlMydXVyNHBrZEY4VTBzM2RpK2NFTGpHRmtEdWJNczlHMGVRNmQy?=
 =?utf-8?B?bkRKYnFFNFJqVUN0MFlaWnVIRnQ5eHlhNHhBaDZYaUVWZElEWU5WYkZ5cU0y?=
 =?utf-8?B?dzBGZUYrT0NlVEx1VE44NjRYZ0EzSDZsaEY0TWZtS3pmNTE3ckZhS1dyWktN?=
 =?utf-8?B?ZVFFMUVjTUNJbUxmbzF5dkREQU0zUkxYd2Y0S2w0K3MzWDdLbTZnR3h6cEd1?=
 =?utf-8?B?Z0lpbFA5WEh0NzBLcHQxQnlFUnJPZVFHSDlGdmUyazRGUFNHZGxleTdnK3RM?=
 =?utf-8?B?cVJQbkp2S1BhS3Y2Wnk3SGF0V3d3dHd0NU93MmsxOTRtZnJFK3lLb0ZYRXhS?=
 =?utf-8?B?U1FYcFhUUnV6V09NcnNEZ2VJdmJTZ2NYOWE2TXZSaG4rckEwSmhlNG5KL0dp?=
 =?utf-8?B?K3FyZDAxNjFYNHNBZzUwc1VkWnUvcGZVVEV5UE90SU1nUjdKZnVrd0xJcTA3?=
 =?utf-8?B?ODB2YVMvSFhqSW5wTWtVZk1BNE9EcFlaMkM3RGl3RVQxaWhUU0lvRndzNWJs?=
 =?utf-8?B?d0QxVkhHcFljU0VkMFJxRmg2bml2WWNGVFZEWnNDWGovQUx3aUJxckpmMG00?=
 =?utf-8?B?WW0xR0hjMzN4NFFhUk9Jek40Ujg4dFdTTXlXV29xZjVTVnNzVjhDK1QrU0Ro?=
 =?utf-8?B?WDExZDZhS2I1dnZhZ0ZkeHhXVkgraWJTSytyQzQ0ODdTWWxYNm5GVFNjbnBG?=
 =?utf-8?B?TXVXbVd1dTczbXQrK2h2L0wvY2FjbmltU0s1RS96R1YyditnaC9zZHpPeXlX?=
 =?utf-8?B?aVAwOU1GWmlZQWhMOUg3ek52REdlaXhoeUdGVXpPTkttcndQVzF2NDdRZ01Q?=
 =?utf-8?B?bGl3bytXeGc0aStPQTJkM29Ic20yUnBnbUFSUTFEVDFzQ3A1VDVqWFo4a0xs?=
 =?utf-8?B?dDI0aVVOUll2K0hWVFNZbmNkanFGOWI1Y2VydmZaOGRPNVpqRzZmbVplMk1x?=
 =?utf-8?B?d050QVVjajROZUt0QjFINk5hNFZJRk5mNGlxTUN2VnhFZ3hZU2NpaEUyZUI5?=
 =?utf-8?B?bGFDV2x3L3ZnVVlsSnRvUnIyaktjQisyNm00RCtsSXgvYXR6Vit3YzdaWlcv?=
 =?utf-8?B?cmQ4d2RkL0Z3Rm9Kc3pkYjM0TVFGZGpmYzZIYTVwOWgrREEzZFd4SFd1Qm1T?=
 =?utf-8?B?K2daR29NeEVrQndXWVlKV1BjNTZtQTdHdFN6dGk4MzczMlpaSXNHbldSUXFD?=
 =?utf-8?B?N0NHTGd1ZDdlZTlTNXYzcGpoMnFzWngwSmk0OUUzaU5sUUUrSlBnZi82ZG94?=
 =?utf-8?B?cUNGYkhRb29nU1JTaHBXbEdPTlNJZm5semwrb0ZqY2pNc2o1RUZKMC9LWkw1?=
 =?utf-8?B?UXJWY0I3WGZXNTNTMHl5amxZWTR4QXZWVWx1LzlPOFh4ZkFwczY3VjB0Vm9Q?=
 =?utf-8?B?Q0QzcGtqckI2QjlaMzZHc01oUlM1KzQ5Z0NrTWZLR3c0ejYrZzVrQXE0U1BF?=
 =?utf-8?B?RGtzMmtZd2RiUjliRXJLbmFwS0dvOTBOZStOU040ODN1WWI5MWo0TjJUQnJU?=
 =?utf-8?B?UmRrb2FrclpDbCs0Z25sSWp0endGN2kvaVBvUm94NmtiSHRpOTJwYlpCZjF5?=
 =?utf-8?Q?VhoBvsR6+H+F767+5Tp6Y3wCyG55ZeafLeU35Apumovd8?=
X-MS-Exchange-AntiSpam-MessageData-1: 9U5E0eeqH8uiLg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40043f3e-713e-4085-ce2f-08da3a2a15e3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 06:29:25.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlAlIRkuByxzRffjDqYa46Xl5xpGJeJpAu551ByIULurg5UBvsqCKr9DnAnm2k9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1315
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 19.05.22 um 23:40 schrieb Kalesh Singh:
> Processes can pin shared memory by keeping a handle to it through a
> file descriptor; for instance dmabufs, memfd, and ashsmem (in Android).
>
> In the case of a memory leak, to identify the process pinning the
> memory, userspace needs to:
>    - Iterate the /proc/<pid>/fd/* for each process
>    - Do a readlink on each entry to identify the type of memory from
>      the file path.
>    - stat() each entry to get the size of the memory.
>
> The file permissions on /proc/<pid>/fd/* only allows for the owner
> or root to perform the operations above; and so is not suitable for
> capturing the system-wide state in a production environment.
>
> This issue was addressed for dmabufs by making /proc/*/fdinfo/*
> accessible to a process with PTRACE_MODE_READ_FSCREDS credentials[1]
> To allow the same kind of tracking for other types of shared memory,
> add the following fields to /proc/<pid>/fdinfo/<fd>:
>
> path - This allows identifying the type of memory based on common
>         prefixes: e.g. "/memfd...", "/dmabuf...", "/dev/ashmem..."
>
>         This was not an issued when dmabuf tracking was introduced
>         because the exp_name field of dmabuf fdinfo could be used
>         to distinguish dmabuf fds from other types.
>
> size - To track the amount of memory that is being pinned.
>
>         dmabufs expose size as an additional field in fdinfo. Remove
>         this and make it a common field for all fds.
>
> Access to /proc/<pid>/fdinfo is governed by PTRACE_MODE_READ_FSCREDS
> -- the same as for /proc/<pid>/maps which also exposes the path and
> size for mapped memory regions.
>
> This allows for a system process with PTRACE_MODE_READ_FSCREDS to
> account the pinned per-process memory via fdinfo.

I think this should be split into two patches, one adding the size and 
one adding the path.

Adding the size is completely unproblematic, but the path might raise 
some eyebrows.

>
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20210308170651.919148-1-kaleshsingh%40google.com%2F&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C95ee7bf71c2c4aa342fa08da39e03398%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637885932392014544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=kf%2B2es12hV3z5zjOFhx3EyxI1XEMeHexqTLNpNoDhAY%3D&amp;reserved=0
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>   Documentation/filesystems/proc.rst | 22 ++++++++++++++++++++--
>   drivers/dma-buf/dma-buf.c          |  1 -
>   fs/proc/fd.c                       |  9 +++++++--
>   3 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 061744c436d9..ad66d78aca51 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1922,13 +1922,16 @@ if precise results are needed.
>   3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
>   ---------------------------------------------------------------
>   This file provides information associated with an opened file. The regular
> -files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
> +files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'size',
> +and 'path'.
> +
>   The 'pos' represents the current offset of the opened file in decimal
>   form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
>   file has been created with [see open(2) for details] and 'mnt_id' represents
>   mount ID of the file system containing the opened file [see 3.5
>   /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
> -the file.
> +the file, 'size' represents the size of the file in bytes, and 'path'
> +represents the file path.
>   
>   A typical output is::
>   
> @@ -1936,6 +1939,8 @@ A typical output is::
>   	flags:	0100002
>   	mnt_id:	19
>   	ino:	63107
> +        size:   0
> +        path:   /dev/null
>   
>   All locks associated with a file descriptor are shown in its fdinfo too::
>   
> @@ -1953,6 +1958,8 @@ Eventfd files
>   	flags:	04002
>   	mnt_id:	9
>   	ino:	63107
> +        size:   0
> +        path:   anon_inode:[eventfd]
>   	eventfd-count:	5a
>   
>   where 'eventfd-count' is hex value of a counter.
> @@ -1966,6 +1973,8 @@ Signalfd files
>   	flags:	04002
>   	mnt_id:	9
>   	ino:	63107
> +        size:   0
> +        path:   anon_inode:[signalfd]
>   	sigmask:	0000000000000200
>   
>   where 'sigmask' is hex value of the signal mask associated
> @@ -1980,6 +1989,8 @@ Epoll files
>   	flags:	02
>   	mnt_id:	9
>   	ino:	63107
> +        size:   0
> +        path:   anon_inode:[eventpoll]
>   	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
>   
>   where 'tfd' is a target file descriptor number in decimal form,
> @@ -1998,6 +2009,8 @@ For inotify files the format is the following::
>   	flags:	02000000
>   	mnt_id:	9
>   	ino:	63107
> +        size:   0
> +        path:   anon_inode:inotify
>   	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
>   
>   where 'wd' is a watch descriptor in decimal form, i.e. a target file
> @@ -2021,6 +2034,8 @@ For fanotify files the format is::
>   	flags:	02
>   	mnt_id:	9
>   	ino:	63107
> +        size:   0
> +        path:   anon_inode:[fanotify]
>   	fanotify flags:10 event-flags:0
>   	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
>   	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> @@ -2046,6 +2061,8 @@ Timerfd files
>   	flags:	02
>   	mnt_id:	9
>   	ino:	63107
> +        size:   0
> +        path:   anon_inode:[timerfd]
>   	clockid: 0
>   	ticks: 0
>   	settime flags: 01
> @@ -2070,6 +2087,7 @@ DMA Buffer files
>   	mnt_id:	9
>   	ino:	63107
>   	size:   32768
> +        path:   /dmabuf:
>   	count:  2
>   	exp_name:  system-heap
>   
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index b1e25ae98302..d61183ff3c30 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -377,7 +377,6 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
>   {
>   	struct dma_buf *dmabuf = file->private_data;
>   
> -	seq_printf(m, "size:\t%zu\n", dmabuf->size);
>   	/* Don't count the temporary reference taken inside procfs seq_show */
>   	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
>   	seq_printf(m, "exp_name:\t%s\n", dmabuf->exp_name);
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 913bef0d2a36..a8a968bc58f0 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -54,10 +54,15 @@ static int seq_show(struct seq_file *m, void *v)
>   	if (ret)
>   		return ret;
>   
> -	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n",
> +	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\nsize:\t%zu\n",
>   		   (long long)file->f_pos, f_flags,
>   		   real_mount(file->f_path.mnt)->mnt_id,
> -		   file_inode(file)->i_ino);
> +		   file_inode(file)->i_ino,
> +		   file_inode(file)->i_size);

We might consider splitting this into multiple seq_printf calls, one for 
each printed attribute.

It becomes a bit unreadable and the minimal additional overhead 
shouldn't matter that much.

Regards,
Christian.

> +
> +	seq_puts(m, "path:\t");
> +	seq_file_path(m, file, "\n");
> +	seq_putc(m, '\n');
>   
>   	/* show_fd_locks() never deferences files so a stale value is safe */
>   	show_fd_locks(m, file, files);
>
> base-commit: b015dcd62b86d298829990f8261d5d154b8d7af5

