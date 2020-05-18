Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9C1D78E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgERMpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 08:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgERMpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 08:45:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADD3C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 05:45:15 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e10so8351119edq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPrxUG2VzBC+d21iH+Uuo13Up0+FO8AW/wuv49py0mM=;
        b=OW/PsWN6Hoegb00/LQ25omfqqozJIUQRjqg07PKl4CMUSwLli48y5IpA5+eah0tB8n
         h3Nsrci462IEhg2uDMGdoBRmDyYVSJi6fmZnEGqkSulY3YDlUST1tyLFaU2DilgVhnlS
         Walu9a5WIvRHHQdStNb7uZsOPs0bC19r5fMh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPrxUG2VzBC+d21iH+Uuo13Up0+FO8AW/wuv49py0mM=;
        b=MGmHNcucKp0+l6Gh7Iu5QpbxU7XQ2YCdkuFHAQYm5NvOeUw72GR8s60+sBkoF4p7HU
         sG+Yl1MlAxST21mtarkp2k9+Y89NN1qpHFIR3+9bxedbv6PgBBEXr1KnxbFopYV1n8Xh
         cf8Fp4Ty9cZ+aCnN9O0jfQRMkDW2KYFC9ndLas0VvUsYqrtpTPWHrs0Of4KQ2PlR3b1h
         KNpEbj+6esbW1OE/995ZNTj/hZOZ8vPZn4Ai1XJKM+Qztxb7JNwd8CgO/9yksDrbas0h
         WQQuzR2jn5at3tGXNgz+Ksj57y5qaVt6iD2z+RODbBv6ul9NBsdrRl/kr7zdn7OFhMX2
         fKcw==
X-Gm-Message-State: AOAM5306ZaQcPfruHkzdIF5h5oux7GSfGG4jlIblCUXwNrTWPl4ugHgq
        FC5BEo/BAnDzhFJcQZxPloN5KDp/Wd1hSP7T2YqFUg==
X-Google-Smtp-Source: ABdhPJxxkHRnK0QwvUUSI41SvwLvfgHTYQktHFViaMEDjF9HrsxR+il1tnZE0kfZJEv5vs8Q3zbQm2M7bzD68wUjds8=
X-Received: by 2002:a05:6402:3076:: with SMTP id bs22mr4131739edb.161.1589805913768;
 Mon, 18 May 2020 05:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <87a72qtaqk.fsf@vostro.rath.org> <877dxut8q7.fsf@vostro.rath.org>
 <20200503032613.GE29705@bombadil.infradead.org> <87368hz9vm.fsf@vostro.rath.org>
 <20200503102742.GF29705@bombadil.infradead.org>
In-Reply-To: <20200503102742.GF29705@bombadil.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 May 2020 14:45:02 +0200
Message-ID: <CAJfpegseoCE_mVGPR5Bt8S1WZ2bi2DnUb7QqgPm=okzx_wT31A@mail.gmail.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 3, 2020 at 12:27 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, May 03, 2020 at 09:43:41AM +0100, Nikolaus Rath wrote:
> > Here's what I got:
> >
> > [  221.277260] page:ffffec4bbd639880 refcount:1 mapcount:0 mapping:0000000000000000 index:0xd9
> > [  221.277265] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|lru)
> > [  221.277269] raw: 0017ffffc0000097 ffffec4bbd62f048 ffffec4bbd619308 0000000000000000
> > [  221.277271] raw: 00000000000000d9 0000000000000000 00000001ffffffff ffff9aec11beb000
> > [  221.277272] page dumped because: fuse: trying to steal weird page
> > [  221.277273] page->mem_cgroup:ffff9aec11beb000
>
> Great!  Here's the condition:
>
>         if (page_mapcount(page) ||
>             page->mapping != NULL ||
>             page_count(page) != 1 ||
>             (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
>              ~(1 << PG_locked |
>                1 << PG_referenced |
>                1 << PG_uptodate |
>                1 << PG_lru |
>                1 << PG_active |
>                1 << PG_reclaim))) {
>
> mapcount is 0, mapping is NULL, refcount is 1, so that's all fine.
> flags has 'waiters' set, which is not in the allowed list.  I don't
> know the internals of FUSE, so I don't know why that is.
>
> Also, page_count() is unstable.  Unless there has been an RCU grace period
> between when the page was freed and now, a speculative reference may exist
> from the page cache.  So I would say this is a bad thing to check for.

page_cache_pipe_buf_steal() calls remove_mapping() which calls
page_ref_unfreeze(page, 1).  That sets the refcount to 1, right?

What am I missing?

Thanks,
Miklos
