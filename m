Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0B3EEB53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhHQLCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 07:02:07 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:50657
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236704AbhHQLCD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:02:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEGFGht/4Oe+sjWgbUh1nZ9ckHeccps989epLX7BkyeRqb4MYxCnAckOgkASxf9nLWhM6SsBYI0H5AJNWb09Ur/AtC5GY+xFywwF6i7mjjHIfFXTaO93MbIMIH9sZcGAAIXhMcHxPyU1+vlTGpbcuRen9IPRHkoRhv1+8NQuCXKMc99k3wt7fky8ZSEs529hiq4pitQwL3502QS4wdlZLgZooyyOkIXxYuaSedMIN+AAjPp3W+meN1nBDvYboAIWtrUQGCzB0dR16DcgGtIXufV/xmHDS1tjOdmin2e7pJ4m50xBRo9GJJTjIv0EFItY/J0w0nvb9D8wWJrQsSlOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DZr5bHdaCjQcs0FIrwXy5nB9FnSjr8ZMgpaKdcNu5s=;
 b=VsyRpe3NymNzES+zEiLabKvi8eW1fOf8xPtoGAX7K3z30LD9HLPTIXv3CDGnzKAi70RR1RstkMy7FVnUVnTUXRoRvGXEFXbfsZ2dKY2DihgZEKXfQWR5eRkbtIkhhVQYXkwcwlA4mDCcsOya554YvtBwrJllA48DVo79jd0RZ1QCy39diTx+NnfOJoaN66N+2zjl38HUVAGWCmAa+cIpzeppkYpoSVLn8rFsyvdTbIyAaYwUsqu5wRMXsLmgJtHALBSxAUQugTOdUrjxMTj9EXSA9x+JpT85n2N1RHpZrqLvbAdGSzv7iTNDmWmq/ZU5IJQy6hqW5nYScra0+c6WOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DZr5bHdaCjQcs0FIrwXy5nB9FnSjr8ZMgpaKdcNu5s=;
 b=DKfYafA94NPUVQJN4xgveTJwxYo6C6bqYJFXN071fIrV/sc1m0aLLKbbAjJOUTSnIFJUAA+HzPE1gS2tUwMNjuk1aRIB5DcjahU7XtRWyB7T+7gko7lIfadViVojD8ZdUIMcTpqj5L0nVmBQRGTXqQT2RJFmUkErZSHnqZf30SY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2483.namprd12.prod.outlook.com (2603:10b6:207:4c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 11:01:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 11:01:26 +0000
Subject: Re: [PATCH v2 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210816194840.42769-1-david@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6e64c3ea-b9c9-decb-36fa-fad713414833@amd.com>
Date:   Tue, 17 Aug 2021 13:01:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210816194840.42769-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:5ed8:be6b:d062:84f3] (2a02:908:1252:fb60:5ed8:be6b:d062:84f3) by FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Tue, 17 Aug 2021 11:01:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd259ed7-e3f1-40c3-b648-08d9616e5bcc
X-MS-TrafficTypeDiagnostic: BL0PR12MB2483:
X-Microsoft-Antispam-PRVS: <BL0PR12MB248352C9A663538177F13FA683FE9@BL0PR12MB2483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pFGeXhge8AgHqKGwahujYplowvXDD/mb6Nx2F1jBNYEQewrwkD59TXhQcOEY7lnHP1dcv0+0g7DZ+/j0i70rW6xc723gDOSLWxBEYUs48fphs+s2zjlCmUYEUjDdrSL4eqpjUmcQurO2DwXlQIgtzZ9iGJZtOxg8rjHOfRl2gUIP7SnUXoO84VIaRiusQ1WAJdhLDoJBU638DcaL5QCc8tPPW6/2nI7V0z5SqCj0E6I6XivloZimgqJeOHafyqDz3dqY62qEIMROCMGIYibHHRB1tW3tIIKDB1thqciIjUM72h3BY7YfbVjFZNRqpDXtkGo9M/qnVS2+iuTcNyLIESqfPqbNZDLxCHAiZhH4mtE1lnMjDnw5tTmkVYnMYBPK1fcPuWSHq9ufWXPkYtaax6qGKI/HqTWbF/EgtqtrEzW3UnxZAfZtoUdSBWmFUe2A2eow4k9GE/imdwaWQNFYK/AZlqVGSyZblCWwYz8x2Bqln9gUw0sTF/6hGcpULvuHMBR516QdWRASmSq0Dh9YFiwWSOhiEIFwHR0OdTN3yXOXJUA+ID6JQAY6H9p//8tXMwk+E/53NqXPnxnFBu15+Yc7XxtvRx9GeeUTEoEPSltZZFcUKgrr3pO0fgDECW74Z8rcE9ZpifZmh15PaTWVpr/yR30V/lu6Ay+0nX2zBm4AlSWrRYjeyETEO54u/ruhwmF9A8GO6aY+eFB6giSOiY96/RGsHl0aKFW4I/1puIyjkT34eNKWHFbv8bKRPFyUJOHgqaRtz8gQWAQuBNXr/kNo/RZ0ES/08jo0TaxKF8vpu7Li6j5qedY+/fs8O6Uuo1y9gwf8F/yd/bbgJ7ep9MnhUnuaqwUF2PNEM0grwvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66574015)(54906003)(7416002)(7406005)(7366002)(2906002)(66556008)(66476007)(2616005)(508600001)(86362001)(5660300002)(316002)(83380400001)(4326008)(966005)(36756003)(66946007)(31696002)(8936002)(6666004)(6486002)(38100700002)(186003)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NnU0thTjJ5ZUh3dTlCU3FjblRwR3Y5ZmNFSGdKZm5aWHFSQ1ZDL2pnN25u?=
 =?utf-8?B?SjFXZzlEZ3ZMbnRlaGZIUFZqV01YOFd6ZHpVWWI0a1lFS25Qb3RYMVE3UXBY?=
 =?utf-8?B?YyszaG5wcEVlMkwvSVJzWCtTNlpNazI1SEc4K2FWdHdHcGV1ZmdZTlB3dXpJ?=
 =?utf-8?B?L0xkZXVQOTduMjZCelJ5N3d2Y2NUaEZ2Y25rL1JUOTZ6Mzd1WERET2xSR1Uv?=
 =?utf-8?B?SExtVUhSL1h6ZTBwMlMwSzdyMkRmMFBRd21lV2Mxb0VpK09FVHdnM21lb0E2?=
 =?utf-8?B?U09XeXg2eUMycnYzTHlGRkFmNFF4U0Nsb1BNMGlrNXRxcmRMNDBPVll3UWhX?=
 =?utf-8?B?aTRWbkp1cDh6TnI0WThJNndpdkZUbjZ1Y3FNR1lUV2U3VG4rNFJ6d1pRbzZm?=
 =?utf-8?B?eVQ2UlgyYTZ2RVdFNWJyR3Y3ZzdxZWxJME5vajE3RFdrNWcyU0J1NnduM08r?=
 =?utf-8?B?MnJrVTJMS29pS1NpaDloQmpkcVgvbXhvMlBKc0pJNGtjS2lmcnpCbFY1L2Rh?=
 =?utf-8?B?cHcrS1o5bHZYcFk0OUdDbWM3OWNLY1h0cXFhSGI3bnBNNXRNRW5RRjJ2aTBr?=
 =?utf-8?B?M3Zva0Jpdzh2Ry9oa0NvTFpDbEMzaGYzNEFYUWx6OUhOYVJrbll0RkVlWGh1?=
 =?utf-8?B?U3FENUZqT0JZdU9yRitEYTFVRU1pZzZLTjJNUllKenNoY2VpZjRWZC8vL3Mz?=
 =?utf-8?B?UmFzT0N5Yy9mRWErNFE5bmd3SDNVejlMMXgxb0U0L2NRYk0zVWZ6cmZieEdN?=
 =?utf-8?B?SmxTOHdsTkZFU2doSkROc1FQYjIzeDRwTVdJNm1kSHJ1czJVT0dEWkxDSWJI?=
 =?utf-8?B?aTc4aWwybldrR1Zka2hlVllHc3hDQ25zSGhEeXlTSE5mT3RMTC92VENteUI0?=
 =?utf-8?B?dWk3VUlaaXUwNlBKR0Frcmw4ejd0bVNJbXdhY1lDdnRqVEg4azYvL2xBMFFV?=
 =?utf-8?B?VzQxNitqa0pNdTJRWnJVNkJPM3AreUxCMWFBRU5hbjF3YUc5ZkswZkIydFVh?=
 =?utf-8?B?ZGZ0WXo1M2o1Y1p0Vk1vSHJRT0JCcTVybFdDOG43ZE1HREdmcHVTaGdUSzJJ?=
 =?utf-8?B?WW04L25GOVZGcVVxcllXQndlSjgrNWVOV3JoWmlIaStnbGtVUmRrckZYVlpy?=
 =?utf-8?B?Q2lxM0VFelo1RWVIVUFHVUtza0hOdWxTaXJiRGIwWVdoU1VYa3pwU1NOem04?=
 =?utf-8?B?RzZIelNuVGhzNXAzNGNVQkc2RmVBVXk2MitlK29BLzJLbHp2M0d0TXJ6Y2pU?=
 =?utf-8?B?OTNYWVVzVjEyTURUa2doUjlBUk1rSldvSkIwanpnakR6UXMyMnhHM2E4QXNj?=
 =?utf-8?B?Y1dvN3h1WjhmNmN6VHNOaXJUeEUyZXl6V3FUODIyeHNyRlBodWd0N3p5VS81?=
 =?utf-8?B?aFhVRTZFaU03c3p5U0dsc2NXZ1I0ZDkxUDEvVVhkVTZGTllJVWpBRHFtTW4v?=
 =?utf-8?B?eHNRVGFsMUpKb0cwSi91eW42cUg2Si83VXRKenRRUEZERTNZRzR5c2JCK3Ra?=
 =?utf-8?B?V1JLWllOUktMM0lRREczMGVGb1pmV0NMQ1J2WFhKUk9hMVFmY2NhTzhCYjNk?=
 =?utf-8?B?NE5tcVpNVmhRcHpzSlN4TitCT1NoQVBsdC9nQUthRHI4REFQVVlKTW02MG9y?=
 =?utf-8?B?em9uMkFJNk5nYksyZ0h4QWxydUpqS3RIQ2R3Z1RYM0FnK0JKTHhnZ3Jrcy8x?=
 =?utf-8?B?NDhXZTVTcVFhY0Qvck03QkN6UHYxSWp1S0NSNWczMDlmTjdVWUZGdEVQM1Iw?=
 =?utf-8?B?YjFIRTQxbWpTaVlIdXJ4WjFyaFpWVFFBRHN6cGlhV296ZnpvR3N2TnplY3FY?=
 =?utf-8?B?NmtBS3V5UkN5N25hSTNMMlZwcDB5YzVOczQxbVRUczlaWWc1V0NYRUs0RVVL?=
 =?utf-8?Q?0RL4G4Tn/ilaS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd259ed7-e3f1-40c3-b648-08d9616e5bcc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 11:01:26.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SAQ76fh03rHHvJts8JqUrv40OkLCuF8rN+y72lPFB9n/BQVBHvRFi7DEP5HE3Nb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2483
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 16.08.21 um 21:48 schrieb David Hildenbrand:
> This series removes all in-tree usage of MAP_DENYWRITE from the kernel
> and removes VM_DENYWRITE. We stopped supporting MAP_DENYWRITE for
> user space applications a while ago because of the chance for DoS.
> The last renaming user is binfmt binary loading during exec and
> legacy library loading via uselib().
>
> With this change, MAP_DENYWRITE is effectively ignored throughout the
> kernel. Although the net change is small (well, we actually add code and
> comments), I think the cleanup in mmap() is quite nice.
>
> There are some (minor) user-visible changes with this series:
> 1. We no longer deny write access to shared libaries loaded via legacy
>     uselib(); this behavior matches modern user space e.g., via dlopen().
> 2. We no longer deny write access to the elf interpreter after exec
>     completed, treating it just like shared libraries (which it often is).
> 3. We always deny write access to the file linked via /proc/pid/exe:
>     sys_prctl(PR_SET_MM_MAP/EXE_FILE) will fail if write access to the file
>     cannot be denied, and write access to the file will remain denied
>     until the link is effectivel gone (exec, termination,
>     sys_prctl(PR_SET_MM_MAP/EXE_FILE)) -- just as if exec'ing the file.
>
> There is a related problem [2] with overlayfs, that should at least partly
> be tackled by this series. I don't quite understand the interaction of
> overlayfs and deny_write_access()/allow_write_access() at exec time:
>
> If we end up denying write access to the wrong file and not to the
> realfile, that would be fundamentally broken. We would have to reroute
> our deny_write_access()/ allow_write_access() calls for the exec file to
> the realfile -- but I leave figuring out the details to overlayfs guys, as
> that would be a related but different issue.
>
> There was a lengthy discussion in [3] whether to remove deny_write_access()
> completely; however, if we decide to go that way, it would ideally be done
> on top, because it could be that some applications even rely on the current
> behavior.
>
> v1 -> v2:
> - "kernel/fork: factor out replacing the current MM exe_file"
> -- Call the function "replace_mm_exe_file()" instead
> -- Add some doc, similar to set_mm_exe_file()
> -- Update patch subject/description
> - "kernel/fork: always deny write access to current MM exe_file"
> -- Introduce dup_mm_exe_file()
> -- Make set_mm_exe_file() return an error to make the code easier to
>     grasp.
> -- Improve comments
> - Added ACKs
> - Mention "sys_prctl(PR_SET_MM_MAP/EXE_FILE)" everywhere instead of
>    only "sys_prctl(PR_SET_MM_EXE_FILE)".
>
> RFC -> v1:
> - "binfmt: remove in-tree usage of MAP_DENYWRITE"
> -- Add a note that this should fix part of a problem with overlayfs

This is unfortunately way beyond my understanding of the fs layer to 
actually review this.

But from the ten mile high view it looks like a really nice cleanup to 
me and makes my live in the DRM subsystem much easier.

Feel free to add a Acked-by: Christian König <christian.koenig@amd.com> 
to the series.

Thanks,
Christian.

>
> [1] https://lore.kernel.org/r/20210423131640.20080-1-david@redhat.com/
> [2] https://lore.kernel.org/r/YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com/
> [3] https://lkml.kernel.org/r/20210812084348.6521-1-david@redhat.com
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Chinwen Chang <chinwen.chang@mediatek.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Kevin Brodsky <Kevin.Brodsky@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shawn Anastasio <shawn@anastas.io>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> Cc: Thomas Cedeno <thomascedeno@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Chengguang Xu <cgxu519@mykernel.net>
> Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: David Laight <David.Laight@ACULAB.COM>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
>
> David Hildenbrand (7):
>    binfmt: don't use MAP_DENYWRITE when loading shared libraries via
>      uselib()
>    kernel/fork: factor out replacing the current MM exe_file
>    kernel/fork: always deny write access to current MM exe_file
>    binfmt: remove in-tree usage of MAP_DENYWRITE
>    mm: remove VM_DENYWRITE
>    mm: ignore MAP_DENYWRITE in ksys_mmap_pgoff()
>    fs: update documentation of get_write_access() and friends
>
>   arch/x86/ia32/ia32_aout.c      |  8 ++-
>   fs/binfmt_aout.c               |  7 ++-
>   fs/binfmt_elf.c                |  6 +--
>   fs/binfmt_elf_fdpic.c          |  2 +-
>   fs/exec.c                      |  4 +-
>   fs/proc/task_mmu.c             |  1 -
>   include/linux/fs.h             | 19 ++++---
>   include/linux/mm.h             |  4 +-
>   include/linux/mman.h           |  4 +-
>   include/trace/events/mmflags.h |  1 -
>   kernel/events/core.c           |  2 -
>   kernel/fork.c                  | 95 ++++++++++++++++++++++++++++++----
>   kernel/sys.c                   | 33 +-----------
>   lib/test_printf.c              |  5 +-
>   mm/mmap.c                      | 29 ++---------
>   mm/nommu.c                     |  2 -
>   16 files changed, 119 insertions(+), 103 deletions(-)
>
>
> base-commit: 7c60610d476766e128cc4284bb6349732cbd6606

