Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1F7991FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbjIHWCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 18:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjIHWCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24CD1FC6
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694210511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/Mdr+GzW+sAH8pnXlRdcxL3Lco75+PnNmrEF8RR5jk=;
        b=Uof0oJEqWt2er8EfHUGYqP2gN/brdaUL2+dM82kBRVt3k6zRyMnbww2b37lokiSamrKi58
        dpCn9PId8vXiyiW1I3+v3moEK+S85HGALCJIH+vqAbDIt201LrZwvPQH9KKVfG+sPPBpiR
        3nt7ledm4BI6oRoW2X+FeE8kYeTPVFA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-_DbV6cGQP9uSx9cN2-U1qg-1; Fri, 08 Sep 2023 18:01:50 -0400
X-MC-Unique: _DbV6cGQP9uSx9cN2-U1qg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-770544d0501so53229085a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 15:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694210510; x=1694815310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/Mdr+GzW+sAH8pnXlRdcxL3Lco75+PnNmrEF8RR5jk=;
        b=W7xZidMfyZI+/1hpTcqnWHU1BGo7J6mf2OdlVsk2J6EDxYijINC3UZJPKs1PQlIIZd
         gadIjK+onTQkNTOycii1PiN6VYvmBmnXVf8JJsdWk72XSeV5VqIRf4IF01ZwV6vYJHwV
         WsYEm1JzagATupqEDUCAKK1pLe2lGTuLiNgkZdtZwsMcsvz05cLs8GOUfgJS1W2jBIFl
         oIwWlDykkSNS1JJ4Ezf9E1lJOg6oXboTH7Ajt6CCnQKyBZIJFF2n/VzOAgHj8Z8KdOyr
         0cxdG/Uxzgx6jHRafajj0R2yryMz6Z2SGkS5uTNOqwRwKfEkxtvmuNKoANMRW0Q0glCP
         OgLg==
X-Gm-Message-State: AOJu0YzXc0JsSk6HQai5amylKPJIROLeQUaVCeriYx3uTvs8ZZDd2Ese
        3CdhvuoAdsXMNtatfoPiQrzfHmV3qBU85NFVetW0yW2wTKXkRy8Ort1d4Vo8Wy16SNAh3Bm5csj
        LLpUPMcSFo5GH0vfSwzUa8d/B0g==
X-Received: by 2002:a05:620a:1a20:b0:76d:9234:1db4 with SMTP id bk32-20020a05620a1a2000b0076d92341db4mr3888997qkb.7.1694210510053;
        Fri, 08 Sep 2023 15:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYXsZIB5Fi5tMCsJrBEtgGgvTsQegolX3ll0BuwfoWJhX6998+NmmxiHzd2BWsKmfRMjarkA==
X-Received: by 2002:a05:620a:1a20:b0:76d:9234:1db4 with SMTP id bk32-20020a05620a1a2000b0076d92341db4mr3888960qkb.7.1694210509711;
        Fri, 08 Sep 2023 15:01:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id du32-20020a05620a47e000b0076cc4610d0asm884723qkb.85.2023.09.08.15.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 15:01:49 -0700 (PDT)
Date:   Fri, 8 Sep 2023 18:01:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Anish Moorthy <amoorthy@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 0/7] mm/userfaultfd/poll: Scale userfaultfd wakeups
Message-ID: <ZPuZtm244zhMteqc@x1n>
References: <20230905214235.320571-1-peterx@redhat.com>
 <CAJHvVcjQR95KVfu2qv3hepkLWkH5J8qRG_BazHKSXoGoGnUATg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcjQR95KVfu2qv3hepkLWkH5J8qRG_BazHKSXoGoGnUATg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:18:29PM -0700, Axel Rasmussen wrote:
> On Tue, Sep 5, 2023 at 2:42 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Userfaultfd is the type of file that doesn't need wake-all semantics: if
> > there is a message enqueued (for either a fault address, or an event), we
> > only need to wake up one service thread to handle it.  Waking up more
> > normally means a waste of cpu cycles.  Besides that, and more importantly,
> > that just doesn't scale.
> 
> Hi Peter,

Hi, Axel,

Sorry to respond late.

> 
> I took a quick look over the series and didn't see anything
> objectionable. I was planning to actually test the series out and then
> send out R-b's, but it will take some additional time (next week).

Thanks.  The 2nd patch definitely needs some fixup on some functions
(either I overlooked without enough CONFIG_* chosen; I am surprised I have
vhost even compiled out when testing..), hope that won't bring you too much
trouble.  I'll send a fixup soon on top of patch 2.

> 
> In the meantime, I was curious about the use case. A design I've seen
> for VM live migration is to have 1 thread reading events off the uffd,
> and then have many threads actually resolving the fault events that
> come in (e.g. fetching pages over the network, issuing UFFDIO_COPY or
> UFFDIO_CONTINUE, or whatever). In that design, since we only have a
> single reader anyway, I think this series doesn't help.

Yes.  If the test to carry out only uses 1 thread, it shouldn't bring much
difference.

> 
> But, I'm curious if you have data indicating that > 1 reader is more
> performant overall? I suspect it might be the case that, with "enough"
> vCPUs, it makes sense to do so, but I don't have benchmark data to
> tell me what that tipping point is yet.
> 
> OTOH, if one reader is plenty in ~all cases, optimizing this path is
> less important.

For myself I don't yet have an application that can leverage this much
indeed, because QEMU so far only uses 1 reader thread.

IIRC Anish was exactly proposing some kvm specific solutions to make single
uffd scale, and this might be suitable for any use case like that where we
may want to use single uffd and try to make it scale with threads.  Using 1
reader + N worker is also a solution, but when using N readers (which also
do the work) the app will hit this problem.

I am also aware that some apps use more than 1 reader threads (umap), but I
don't really know more than that.

The problem is I think we shouldn't have that overhead easily just because
an app invokes >1 readers, meanwhile it also doesn't make much sense to
wake up all readers for a single event for userfaults.  So it should always
be something good to have.

Thanks,

-- 
Peter Xu

