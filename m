Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70786F1B2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbjD1PJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 11:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346329AbjD1PJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D1E4ECD
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682694537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DExhISWOPFRM66eIMYgYYtNk7dP6IDt4Tq0QUUIwHAo=;
        b=gEkZ624OOLVM0p3o7CYMwd57TpHtoz09D3CWxAM7oGnxlZTEFycsAwD1POpEvpy9fef/j3
        7mfPEjb+wcQ5uCU6Ibv3svdSwcWrb637xVn1Ox+wWy4BYlVN4mRWyqXDDu3S8wOgF/LkcI
        QzoOyPEN2JzHDlVXndBapv74m+D7WbA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-lDfg-eAnNeKtM0NfRXo9fg-1; Fri, 28 Apr 2023 11:08:46 -0400
X-MC-Unique: lDfg-eAnNeKtM0NfRXo9fg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f5382db4d1so3318126f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 08:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682694512; x=1685286512;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DExhISWOPFRM66eIMYgYYtNk7dP6IDt4Tq0QUUIwHAo=;
        b=cGaU49bT2ijygE0n6dahgHhdrMYWsIQe5dOhaiAX9WpitV8rXTsZp+SfbQMSyQHObi
         5OP4jAJ0dGpMdekYuJDAKrRnAJIuv/FGntFxYapHe3khI7KpRIiccOCwlYhDB87kSieC
         D3bFV9a1DC/gxhaKIMxUIWwaQa+UVZTk8jOX2xQLqJArYs67tsoR86YG20Q3s9frUzsR
         7iRFgxVwmX7q99kxKwoo9FaFz7f6aXvnn1sWHPPbNspdcVKbTTsyciF0BGbH3Yyzi/Rt
         NGh1yINA3WpLQRfb25saAMG/YPK7SfSm8ho6mUVbJeX70wqfLahFDtO/BqIBDteMsVNI
         mVSw==
X-Gm-Message-State: AC+VfDwDglTeqdXjyK+cUXkvN222dYuC45ml1bUmfcSCBhUk18SDRWtJ
        k5JP6c6VREbrXRb75Q5d7j1mfsniHyLjaJRgl6oqrjASJ8PFUcqRdvoYYRS8/zRevQ+tsDH8jc/
        dorqDJzUO8TYA1K55HZ3Q5S9wIw==
X-Received: by 2002:a05:6000:18c2:b0:302:df29:cf15 with SMTP id w2-20020a05600018c200b00302df29cf15mr4296525wrq.46.1682694511958;
        Fri, 28 Apr 2023 08:08:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7JEsetdjbnxq4nhUd3NJxaMjjMr8Yxl2UkjyR8Pw66SATsxkmdCLf2lTrLVC98PgEUTzTO1A==
X-Received: by 2002:a05:6000:18c2:b0:302:df29:cf15 with SMTP id w2-20020a05600018c200b00302df29cf15mr4296482wrq.46.1682694511574;
        Fri, 28 Apr 2023 08:08:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:9300:1711:356:6550:7502? (p200300cbc72693001711035665507502.dip0.t-ipconnect.de. [2003:cb:c726:9300:1711:356:6550:7502])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003ef64affec7sm24665739wmg.22.2023.04.28.08.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 08:08:29 -0700 (PDT)
Message-ID: <094d2074-5b69-5d61-07f7-9f962014fa68@redhat.com>
Date:   Fri, 28 Apr 2023 17:08:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <6b73e692c2929dc4613af711bdf92e2ec1956a66.1682638385.git.lstoakes@gmail.com>
 <afcc124e-7a9b-879c-dfdf-200426b84e24@redhat.com>
 <ZEvZtIb2EDb/WudP@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5] mm/gup: disallow GUP writing to file-backed mappings
 by default
In-Reply-To: <ZEvZtIb2EDb/WudP@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.04.23 16:35, Jason Gunthorpe wrote:
> On Fri, Apr 28, 2023 at 04:20:46PM +0200, David Hildenbrand wrote:
>> Sorry for jumping in late, I'm on vacation :)
>>
>> On 28.04.23 01:42, Lorenzo Stoakes wrote:
>>> Writing to file-backed mappings which require folio dirty tracking using
>>> GUP is a fundamentally broken operation, as kernel write access to GUP
>>> mappings do not adhere to the semantics expected by a file system.
>>>
>>> A GUP caller uses the direct mapping to access the folio, which does not
>>> cause write notify to trigger, nor does it enforce that the caller marks
>>> the folio dirty.
>>
>> How should we enforce it? It would be a BUG in the GUP user.
> 
> I hope we don't have these kinds of mistakes.. hard to enforce by
> code.
> 

I briefly played with the idea of only allowing to write-pin fs pages 
that are dirty (or the pte is dirty). If we adjust writeback code to 
leave such (maybe pinned) pages dirty, there would be no need to reset 
the pages dirty I guess.

Just an idea, getting the writebackcode fixed (and race-free with 
GUP-fast) is the harder problem.

>> This change has the potential to break existing setups. Simple example:
>> libvirt domains configured for file-backed VM memory that also has a vfio
>> device configured. It can easily be configured by users (evolving VM
>> configuration, copy-paste etc.). And it works from a VM perspective, because
>> the guest memory is essentially stale once the VM is shutdown and the pages
>> were unpinned. At least we're not concerned about stale data on
>> disk.
> 
> I think this is broken today and we should block it. We know from
> experiments with RDMA that doing exactly this triggers kernel oop's.
> 

I never saw similar reports in the wild (especially targeted at RHEL), 
so is this still a current issue that has not been mitigated? Or is it 
just so hard to actually trigger?

> Run your qemu config once, all the pages in the file become dirty.
> 
> Run your qmeu config again and now all the dirty pages are longterm
> pinned.
> 
> Something eventually does writeback and FS cleans the page.

At least vmscan does not touch pages that have additional references -- 
pageout() quits early. So that other thing doesn't happen that often I 
guess (manual fsync doesn't usually happen on VM memory if I am not 
wrong ...).

> 
> Now close your VM and the page is dirtied without make write. FS is
> inconsistent with the MM, kernel will eventually oops.
> 
> I'm skeptical that anyone can actually do this combination of things
> successfully without getting kernel crashes or file data corruption -
> ie there is no real user to break.

I am pretty sure that there are such VM users, because on the libvirt 
level it's completely unclear which features trigger what behavior :/

I remember (but did not check) that VM memory might usually get deleted 
whenever we usually shutdown a VM, another reason why we wouldn't see 
this in the wild. libvirt has the "discard" option exactly for that 
purpose, to be used with file-based guest memory. [1]

Users tend to copy-paste domain XMLs + edit because it's just so hard to 
get right. Changing the VM backing to be backed from a file can be done 
with a one-line change in the libvirt XML.

> 
>> With your changes, such VMs would no longer start, breaking existing user
>> setups with a kernel update.
> 
> Yes, as a matter of security we should break it.
> 
> Earlier I suggested making this contingent on kernel lockdown >=
> integrity, if actual users come and complain we should go to that
> option.
> 
>> Sure, we could warn, or convert individual users using a flag (io_uring).
>> But maybe we should invest more energy on a fix?
> 
> It has been years now, I think we need to admit a fix is still years
> away. Blocking the security problem may even motivate more people to
> work on a fix.

Maybe we should make this a topic this year at LSF/MM (again?). At least 
we learned a lot about GUP, what might work, what might not work, and 
got a depper understanding (+ motivation to fix? :) ) the issue at hand.

> 
> Security is the primary case where we have historically closed uAPI
> items.

As this patch

1) Does not tackle GUP-fast
2) Does not take care of !FOLL_LONGTERM

I am not convinced by the security argument in regard to this patch.


If we want to sells this as a security thing, we have to block it 
*completely* and then CC stable.

Everything else sounds like band-aids to me, is insufficient, and might 
cause more harm than actually help IMHO. Especially the gup-fast case is 
extremely easy to work-around in malicious user space.


[1] https://listman.redhat.com/archives/libvir-list/2018-May/msg00885.html

-- 
Thanks,

David / dhildenb

