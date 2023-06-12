Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73B872C621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbjFLNht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 09:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjFLNhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259DF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686576997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0n3wcj950ttVhtkf85CAuqAYgXIsYoCoCNz8vu5g/s=;
        b=D2owf5eWzNmzRJVjNHV27ezrN8KZuT2qpS4C3ISS1CMXSWPLXQM5ubKbX7r6CRSFdxyDv1
        7bgldJSNTIW6cCDWGJfpi3Ro/JzTZ0v2Fm0p0i1bZ6OKtER1neawyBsz7bHcsQq+fiSwGP
        BbQesmOSYUQEpQkFFSlhGLFKRxJ0UhM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-40ARM7DCPiubuL_9PgYjvA-1; Mon, 12 Jun 2023 09:36:36 -0400
X-MC-Unique: 40ARM7DCPiubuL_9PgYjvA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75ec325d255so52434685a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 06:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686576996; x=1689168996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0n3wcj950ttVhtkf85CAuqAYgXIsYoCoCNz8vu5g/s=;
        b=gXHsGocFtm8LjFgddxxdIK2NrTDFhnCGr57o4pV3j3L7De6bDEwrnLyp0dj1VKvr+u
         ozHzmUXeFEgki0JYGa8qRvwmOjfNwl+7JQnb768IVhIRyR6+QXbHW/Et5Z00jrl+gAwB
         HMp/XVPqg+zDqxzNFvmfhS4fGx6bJPZBm/T4WcmuP3QcQb7uEN+QWWyloa6uETVTxEFW
         d7KzOaV5+DxYLy7mT5PkVNfvdFSE9aV3epRoAJ8u3XxlJUwvvL38N6iLA3D7ieUHaJyH
         vm5jhBgOUq4EEmOilv3VY8bTUNQ0nF+xO+/M7paDlPNSUIxw/cyloYdtB5ZJvgJJZbU4
         6YxA==
X-Gm-Message-State: AC+VfDxFG7D9KZ3s8/21t24BharBdwFFiSlSU/XK5Ybv/OVF2f/oJCme
        U5PKm0CunlfZ32h3Bbj3OxJj8BwL31NoQysRgtGoKqDqUY2BTZdcxaV1lWmT15E1KfLbUH7nXNQ
        1LbmJYPgSrrK59WwkW/K0z6UbWQ==
X-Received: by 2002:a05:620a:3c8d:b0:75b:23a1:82a4 with SMTP id tp13-20020a05620a3c8d00b0075b23a182a4mr9843387qkn.5.1686576995870;
        Mon, 12 Jun 2023 06:36:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68MRm0+7BTnkIe15Rm95OkhI4lciEW6zZvGiDk4zA59PumzG77bi1ZVsiiKv1F8+eYeHA+sQ==
X-Received: by 2002:a05:620a:3c8d:b0:75b:23a1:82a4 with SMTP id tp13-20020a05620a3c8d00b0075b23a182a4mr9843352qkn.5.1686576995644;
        Mon, 12 Jun 2023 06:36:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a167300b0075b23e55640sm2844871qko.123.2023.06.12.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 06:36:35 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:36:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
Message-ID: <ZIcfYQ1c5teMSHAX@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n>
 <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
 <CAJuCfpG3PrbGxpDAEkyGQXW88+otb=FsbrhPJ4ePN7Xhn0a+_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG3PrbGxpDAEkyGQXW88+otb=FsbrhPJ4ePN7Xhn0a+_A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 06:29:43PM -0700, Suren Baghdasaryan wrote:
> On Fri, Jun 9, 2023 at 3:30 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Jun 9, 2023 at 1:42 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> > > > migration_entry_wait does not need VMA lock, therefore it can be dropped
> > > > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VMA
> > > > lock was dropped while in handle_mm_fault().
> > > > Note that once VMA lock is dropped, the VMA reference can't be used as
> > > > there are no guarantees it was not freed.
> > >
> > > Then vma lock behaves differently from mmap read lock, am I right?  Can we
> > > still make them match on behaviors, or there's reason not to do so?
> >
> > I think we could match their behavior by also dropping mmap_lock here
> > when fault is handled under mmap_lock (!(fault->flags &
> > FAULT_FLAG_VMA_LOCK)).
> > I missed the fact that VM_FAULT_COMPLETED can be used to skip dropping
> > mmap_lock in do_page_fault(), so indeed, I might be able to use
> > VM_FAULT_COMPLETED to skip vma_end_read(vma) for per-vma locks as well
> > instead of introducing FAULT_FLAG_VMA_LOCK. I think that was your idea
> > of reusing existing flags?
> Sorry, I meant VM_FAULT_VMA_UNLOCKED, not FAULT_FLAG_VMA_LOCK in the
> above reply.
> 
> I took a closer look into using VM_FAULT_COMPLETED instead of
> VM_FAULT_VMA_UNLOCKED but when we fall back from per-vma lock to
> mmap_lock we need to retry with an indication that the per-vma lock
> was dropped. Returning (VM_FAULT_RETRY | VM_FAULT_COMPLETE) to
> indicate such state seems strange to me ("retry" and "complete" seem

Not relevant to this migration patch, but for the whole idea I was thinking
whether it should just work if we simply:

        fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
-       vma_end_read(vma);
+       if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+               vma_end_read(vma);

?

GUP may need more caution on NOWAIT, but vma lock is only in fault paths so
IIUC it's fine?

-- 
Peter Xu

