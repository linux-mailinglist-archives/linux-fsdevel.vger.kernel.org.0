Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105FD1BB4D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 05:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgD1DvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 23:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgD1DvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:51:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A021C03C1AC
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:51:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id f8so15693205lfe.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVBS2zR8u10QnId+SjIws+E/mbDlgxt11FVLpUCy9Fk=;
        b=fSI/ijUiq7Zsrz+mYpIid9wBMr+ufvXZJdEGYfYAV6Wa7WrfJcI8pP8JyJG39ryg8H
         oS3R8qQuk5cLe0fU2CCWNj05+kTTXNRrrHruAKyDUm0TOEQcvdS9B6OBB0/HcU2kGNsZ
         OclGbGyiNhfGDIr+gFIj8hC2fmRzB7XJRVfjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVBS2zR8u10QnId+SjIws+E/mbDlgxt11FVLpUCy9Fk=;
        b=p1nvSar7zMHG1q3QFLwmOHbDYBH9vs4mWnRHDmJ5ynIwqyFeC5gvOqAjb9Iro9tWC5
         uk+tnYoJS/Rs68J50WYHdfs71TXOrRMUyat+KltcbMfBmj6/WBGiWZuZPSJacs5J45yE
         LR7gHrOdhOI759FZt2BiOv+Ecti6LlGWlyw+g3/tKpBkvadL8LFhk0/zARzlXCcSfq32
         qVxjfDyHXBZKI01wJHz2s4zlN+H6/9L8ev+8Z39M61V8oUhtUIxe2Qpvm1FPTaA7yTyA
         0Qr6AcwBNGAsQ7DJjvqRgb1EPjZu8wZHuDAnbM+GQ/dw/79veOHNzg2bZJUZqZpwIzd7
         Jqig==
X-Gm-Message-State: AGi0PuYbtZYHrgY2vraDdgPyrZRy/doXEjhDpIFxp1y4qbAs0VlixuJm
        2vqpvE0Hg3ZnssLvXmb399t+k/x4/Zk=
X-Google-Smtp-Source: APiQypJPa93LuCePJBnLDhldHN1TRTcm+wrzeguPPgx8mmSy1vDEtXZuyz9hzYDKaHK0FGca8+PjzA==
X-Received: by 2002:a19:c216:: with SMTP id l22mr16626626lfc.172.1588045858802;
        Mon, 27 Apr 2020 20:50:58 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n23sm11714531ljj.48.2020.04.27.20.50.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 20:50:57 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id b2so19877747ljp.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 20:50:56 -0700 (PDT)
X-Received: by 2002:a2e:7308:: with SMTP id o8mr16201494ljc.16.1588045856507;
 Mon, 27 Apr 2020 20:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com> <20200428032745.133556-6-jannh@google.com>
In-Reply-To: <20200428032745.133556-6-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 20:50:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
Message-ID: <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/gup: Take mmap_sem in get_dump_page()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
>
> Properly take the mmap_sem before calling into the GUP code from
> get_dump_page(); and play nice, allowing __get_user_pages_locked() to drop
> the mmap_sem if it has to sleep.

This makes my skin crawl.

The only reason for this all is that page cache flushing.

My gut feeling is that it should be done by get_user_pages() anyway,
since all the other users presumably want it to be coherent in the
cache.

And in fact, looking at __get_user_pages(), it already does that

                if (pages) {
                        pages[i] = page;
                        flush_anon_page(vma, page, start);
                        flush_dcache_page(page);
                        ctx.page_mask = 0;
                }

and I think that the get_dump_page() logic is unnecessary to begin with.

               Linus
