Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98444144AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 05:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAVEUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 23:20:06 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43005 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAVEUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 23:20:06 -0500
Received: by mail-io1-f68.google.com with SMTP id n11so5296678iom.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 20:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BSyh9fpx1icrJEZvncijB+OYRlF+rgS2wDI+RLPolYk=;
        b=QJW4nJcqmQLXLklan2ZphK7rHomMBIkB6vmflcqFmzm777ALtPl/aAjaUmuoIeb7e6
         KzLOkXdbAEjOb+msiCN17avmbV5XTfalkahmtdrE3P4PtaaIv+ldin/dgQdeSaqyVh2v
         Zt5HdIOhO7E3CkR4e0RoOGQS4A7iEGwfveh0/6ztG04kVl7W0/r31RurNInw7OYnL7G+
         ERxK/xVfQydmkRGUVUwM4b+UszPR9NyIX0e5VI7DhuSK736PzrapIZAtg9tXe30ah+hN
         b1aLFX+YFel8BKUF/aPCY/WRb1sG/P4qwz7opI0Z0fkO37v6uSXVBNbR+umZviHCuUpw
         a36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BSyh9fpx1icrJEZvncijB+OYRlF+rgS2wDI+RLPolYk=;
        b=oNrlL23klGlhzunNb5tub489oDnfQYOlUjxOE7Z6f4oYTUKQyzYm1FTODbs0k/Ue/R
         5VN1sgkLCNpf4UztACCvZQkqkawSHj/QKrQQEmak2BL60vjEvrBb0PTRBO7yVKD4rtmO
         kvHAPT41niNa8DrEZg567jgEUliPdblceSqGeZfLzgR+pA9M1LuvpxqVeMJxiKAF6pHK
         GokU6CkcHZZreATlxU5ZbnuVICC1MwYl2HNLAxt/dqcnNCz1zYklumFUgj4BNonZ2lcJ
         wHK9zVHLp/S28zDz69kLmlQn+mWabkbdvSuvSDNKpVWkNanklZPKZoqshvlP8mcnR6LX
         BwHw==
X-Gm-Message-State: APjAAAXldBdQXOGcELwXk+5mv0cVhzcV47BHIOYLXhI35rGfNq1WW24O
        sa1x5M5d4ppOqZnilX/qn++K4iAEzls54rdP8+g=
X-Google-Smtp-Source: APXvYqxyc7mY3NjURi2D3N2tWdnJrBRqiBBkxY7DCxmIFNgRnG/rsf/vtAajcFrFS9Dv1k8hMs+NPcfq1P4lgRq547U=
X-Received: by 2002:a5d:9a85:: with SMTP id c5mr718492iom.266.1579666805589;
 Tue, 21 Jan 2020 20:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20200122023100.75226-1-jglisse@redhat.com>
In-Reply-To: <20200122023100.75226-1-jglisse@redhat.com>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Tue, 21 Jan 2020 20:19:54 -0800
Message-ID: <CAA9_cmfDKan60EnXCptAu9U6XgQgr5-MKfrENDNOSZYmQY9iRA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>,
        Benjamin LaHaise <bcrl@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 6:34 PM <jglisse@redhat.com> wrote:
>
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> Direct I/O does pin memory through GUP (get user page) this does
> block several mm activities like:
>     - compaction
>     - numa
>     - migration
>     ...
>
> It is also troublesome if the pinned pages are actualy file back
> pages that migth go under writeback. In which case the page can
> not be write protected from direct-io point of view (see various
> discussion about recent work on GUP [1]). This does happens for
> instance if the virtual memory address use as buffer for read
> operation is the outcome of an mmap of a regular file.
>
>
> With direct-io or aio (asynchronous io) pages are pinned until
> syscall completion (which depends on many factors: io size,
> block device speed, ...). For io-uring pages can be pinned an
> indifinite amount of time.
>
>
> So i would like to convert direct io code (direct-io, aio and
> io-uring) to obey mmu notifier and thus allow memory management
> and writeback to work and behave like any other process memory.
>
> For direct-io and aio this mostly gives a way to wait on syscall
> completion. For io-uring this means that buffer might need to be
> re-validated (ie looking up pages again to get the new set of
> pages for the buffer). Impact for io-uring is the delay needed
> to lookup new pages or wait on writeback (if necessary). This
> would only happens _if_ an invalidation event happens, which it-
> self should only happen under memory preissure or for NUMA
> activities.

This seems to assume that memory pressure and NUMA migration are rare
events. Some of the proposed hierarchical memory management schemes
[1] might impact that assumption.

[1]: http://lore.kernel.org/r/20191101075727.26683-1-ying.huang@intel.com/
