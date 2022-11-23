Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034C636137
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiKWOMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 09:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiKWOMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430D1CD6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669212694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8/DTsoiDdjjsRtV9pwPMMoAHlpx48KJLm5OuDCWlE6M=;
        b=ImN9HtjAGd1kycPpbn2VPlQDfoA5FI4JEG2SZK0CojefJ88vThg1QNnXwTp6PY4rABU2Gu
        ZEf+XQ4r7fouAxiubqpQ2rsxekt0MJYPJO2mwWgaLLspNH464R2JgUQHEtWBhWMVE/l/6c
        4zRMQy0mAAbJS4SJP4gju+XbG4EY8hQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-XshEzhB4OyCxNif2tJpicw-1; Wed, 23 Nov 2022 09:11:33 -0500
X-MC-Unique: XshEzhB4OyCxNif2tJpicw-1
Received: by mail-qt1-f200.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so17166588qtb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/DTsoiDdjjsRtV9pwPMMoAHlpx48KJLm5OuDCWlE6M=;
        b=pR6G2O0jlR4wOdsixUfMJrDTdejirKDubT/xi1Ik6s+jExwNxhQECN2j6H7eGhyJqZ
         t+xuloG2dQMAdLGS8h+RoLoFTZS3EmMZRf60uCFyhiI4nFCCKW8hPql12SD0l3/somy+
         h7vHGJ+2BeOM8gYpAesFjjNgEbEVMD1EUnPk4/QIK4ycc1KpokJxjNGEbG9hZ3EcXr8W
         Ub4Cxxb/e4J3SiYT2dFwz8n8P8GKiY6q77f4Yfe1HD6hw+hsDM0aPVVcOtDzb6dYQn+l
         xteakuRug2lMQUoMx4CLp/TLSwQifsFs1GACD/t7wChPRlUUBjJbEDSBvtn7WlqkRiej
         4ilQ==
X-Gm-Message-State: ANoB5pkNaqIxMPYoxvWOAhdJwI+ztCpWuGRu2z50XPDiu7pIcekA9ZqQ
        VX8rogChUlyMzbfvwtP3SQvrCBdGfVDIx61s/9FH3wvhjySHDagAhdqwlc+g8N+1BlUsXlU/cxE
        MInh4Py3/JpOOuKSL2qMSfl18Qg==
X-Received: by 2002:a05:620a:215c:b0:6fa:937f:61d4 with SMTP id m28-20020a05620a215c00b006fa937f61d4mr10724842qkm.280.1669212692629;
        Wed, 23 Nov 2022 06:11:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6SUx6m2TjrGKG87f9C4JXPILTeMPN0Mxipek+6Q+wnWntXqutLB5B+k6aNyyqF0614O+yLqQ==
X-Received: by 2002:a05:620a:215c:b0:6fa:937f:61d4 with SMTP id m28-20020a05620a215c00b006fa937f61d4mr10724802qkm.280.1669212692303;
        Wed, 23 Nov 2022 06:11:32 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n30-20020ac81e1e000000b003a50b9f099esm9980897qtl.12.2022.11.23.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:11:31 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:11:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Gofman <pgofman@codeweavers.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v6 0/3] Implement IOCTL to get and/or the clear info
 about PTEs
Message-ID: <Y34qEo6cB3oDwoCe@x1n>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109102303.851281-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 03:23:00PM +0500, Muhammad Usama Anjum wrote:
> Soft-dirty PTE bit of the memory pages can be read by using the pagemap
> procfs file. The soft-dirty PTE bit for the whole memory range of the
> process can be cleared by writing to the clear_refs file. There are other
> methods to mimic this information entirely in userspace with poor
> performance:
> - The mprotect syscall and SIGSEGV handler for bookkeeping
> - The userfaultfd syscall with the handler for bookkeeping

Userfaultfd is definitely slow in this case because it needs the messaging
roundtrip that happens in two different threads synchronously, so at least
more schedule effort even than mprotect.

I saw the other patch on vma merging with SOFTDIRTY, didn't look deeper
there but IIUC it won't really help much if the other commit (34228d47)
can't be reverted then it seems to help nothing.  And, it does looks risky
to revert that because in the same commit it mentioned the case where one
can clear ref right before a vma merge, so definitely worth more thoughts
and testings, which I agree with you.

I'm thinking whether the vma issue can be totally avoided.  For example by
providing an async version of uffd-wp.

Currently uffd-wp must be synchronous and it'll be slow but it services
specific purposes.  And this is definitely not the 1st time any of us
thinking about uffd-wp being async, it's just that we need to solve the
problem of storage on the dirty information.

Actually we can also use other storage form but so far I didn't think of
anything that's easy and clean.  Current soft-dirty bit also has its
defects (e.g. the need to take mmap lock and walk the pgtables), but that
part will be the same as soft-dirty for now.

Now I'm wildly thinking whether we can just reuse the soft-dirty bit in the
ptes already defined.  The GET interface could be similar as proposed here,
or at least a separate issue.

So _maybe_ we can have a feature (bound to the uffd context) for uffd that
enables async uffd-wp, in which case the wr-protect fault is not sending
any message anymore (nor enqueuing) but instead setting the soft-dirty then
quickly resolving the write bit immediately and continue the fault.

Clearing of the soft-dirty bit needs to be done in UFFDIO_WRITEPROTECT
alongside of clearing uffd-wp bit.  So on that part the current GET+CLEAR
interface for pagemap may need to be replaced.  And frankly, it feels weird
to me to allow change mm layout in pagemap ioctls..  With this we can keep
the pagemap interface to only fetch information, like before.

A major benefit of using uffd is that uffd is by nature pte-based, so no
fiddling with vma needed at all.  Firstly, no need to worry about merging
vmas with tons of false positives.  Meanwhile, one can wr-protect in
page-size granule easily.  All the wr-protect is not governed by vma flag
anymore but based on uffd-wp flag, so no extra overhead too on any page
that the monitor is not interested.  There's already infrastructure code
for persisting uffd-wp bit, so it'll naturally work similarly for an async
mode if to come to the world.

It's just that we'll also need to consider exclusive use of the bit, so
we'll need to fail clear_refs on vmas where we have VM_UFFD_WP and also the
async feature enabled.  I would hope that's very rare, but worth thinking
about its side effect.  The same will need to apply to UFFDIO_REGISTER on
async wp mode when soft-dirty enabled, we'll need to bailout too.

Said that, this is not a suggestion of a new design, but just something I
thought about when reading this, and quickly writting this down.

Thanks,

-- 
Peter Xu

