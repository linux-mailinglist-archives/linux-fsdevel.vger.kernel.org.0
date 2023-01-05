Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521065EA78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 13:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjAEMMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 07:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjAEMMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:12:50 -0500
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 04:12:47 PST
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B510644C4B;
        Thu,  5 Jan 2023 04:12:47 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5ddd79e3.dip0.t-ipconnect.de [93.221.121.227])
        by mail.itouring.de (Postfix) with ESMTPSA id A3384127843;
        Thu,  5 Jan 2023 13:07:07 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 4EFA9EEBBE3;
        Thu,  5 Jan 2023 13:07:07 +0100 (CET)
Subject: Re: [PATCH v2 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
To:     David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, hannes@cmpxchg.org, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        pasha.tatashin@soleen.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com, bagasdotme@gmail.com,
        suleiman@google.com, steven@liquorix.net, heftig@archlinux.org,
        cuigaosheng1@huawei.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
References: <20230105000241.1450843-1-surenb@google.com>
 <20230104173855.48e8734a25c08d7d7587d508@linux-foundation.org>
 <CAJuCfpGHMeWSSp+ge3pPppLrQ5BpGiga=fjKmDk65GTjFDV=3w@mail.gmail.com>
 <ed9dc172-e519-3fd5-afa4-0089b083ee10@redhat.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <22aab888-75c1-ffad-d72b-f87c9d9d80c8@applied-asynchrony.com>
Date:   Thu, 5 Jan 2023 13:07:07 +0100
MIME-Version: 1.0
In-Reply-To: <ed9dc172-e519-3fd5-afa4-0089b083ee10@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-01-05 10:03, David Hildenbrand wrote:
> On 05.01.23 03:39, Suren Baghdasaryan wrote:
>> On Wed, Jan 4, 2023 at 5:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> On Wed,  4 Jan 2023 16:02:40 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>>>
>>>> free_anon_vma_name() is missing a check for anonymous shmem VMA which
>>>> leads to a memory leak due to refcount not being dropped.  Fix this by
>>>> calling anon_vma_name_put() unconditionally. It will free vma->anon_name
>>>> whenever it's non-NULL.
>>>>
>>>> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
>>>
>>> A cc:stable is appropriate here, yes?
>>
>> Hmm. The patch we are fixing here was merged in 6.2-rc1. Should I CC
>> stable to fix the previous -rc branch?
>>
> 
> No need for stable if it's not in a release kernel yet.

Commit d09e8ca6cb93 is in 6.1. The fix applies cleanly.

cheers
Holger
