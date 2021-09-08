Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EED5404037
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350080AbhIHUi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 16:38:27 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:39850 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhIHUi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 16:38:26 -0400
Received: by mail-ej1-f47.google.com with SMTP id a25so6718253ejv.6;
        Wed, 08 Sep 2021 13:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4Zoc2vCb3qYmC7IG2TIAuZ/862n9zER2xELuYf/YB8=;
        b=4LBqOYNLspikz3wJeYXzenCWlLaR0TOrVe9zPHpcqiM+hSjCNP8yFt+hGR6j2jLNue
         sa/8AOGaNRfC0XzKGC5KPVIVPyg5dXkYFIceUV7amMDwu/DiViE/h6y7qQHVCK8cRpPd
         6WGJ8vzT5eNIN2xltXfaqV4gRFtlugJUwzTjEHMXaaqvxMS5bokwKVTcR+TCE4yTAdpS
         3b7Jysk73Zgut5m71Jdl2Fg7Uo+g/wBd3OOfVXP+jH7zFfvSOvGVMy81QrlfiKr+MdEn
         W6hB/bKByqxlJhj6MhtPD5Lz1lNR27sLM6ZyQUfq5iasCWx6UQgp+RE2LxxiemloGA4I
         8W/w==
X-Gm-Message-State: AOAM533eGZ+Lf1yZDpfvomumkfuQMpHL21DlqiPWXNoi5k7jMlQoTisW
        6frTZdzyxawP79/A2g7ypoeZ6udXQNuoQg==
X-Google-Smtp-Source: ABdhPJx6Zm0Ksfdwvqbu9Z95Ggjo9TpSOtBBNqHZ43b8vbyXUAHl3slmUv0Im3YBwIHnG3JB5jTcMQ==
X-Received: by 2002:a17:906:f24d:: with SMTP id gy13mr1729519ejb.395.1631133437312;
        Wed, 08 Sep 2021 13:37:17 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a15sm75360edr.2.2021.09.08.13.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 13:37:17 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id u9so5112725wrg.8;
        Wed, 08 Sep 2021 13:37:16 -0700 (PDT)
X-Received: by 2002:adf:ea4d:: with SMTP id j13mr204857wrn.86.1631133436749;
 Wed, 08 Sep 2021 13:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
 <163111666635.283156.177701903478910460.stgit@warthog.procyon.org.uk>
In-Reply-To: <163111666635.283156.177701903478910460.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Wed, 8 Sep 2021 17:37:02 -0300
X-Gmail-Original-Message-ID: <CAB9dFdtNJBYp-e5TeTUQW5vuHGp6x+j_KPwxnkTuxvdJ-SY3pw@mail.gmail.com>
Message-ID: <CAB9dFdtNJBYp-e5TeTUQW5vuHGp6x+j_KPwxnkTuxvdJ-SY3pw@mail.gmail.com>
Subject: Re: [PATCH 2/6] afs: Fix page leak
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        Markus Suvanto <markus.suvanto@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 8, 2021 at 12:58 PM David Howells <dhowells@redhat.com> wrote:
>
> There's a loop in afs_extend_writeback() that adds extra pages to a write
> we want to make to improve the efficiency of the writeback by making it
> larger.  This loop stops, however, if we hit a page we can't write back
> from immediately, but it doesn't get rid of the page ref we speculatively
> acquired.
>
> This was caused by the removal of the cleanup loop when the code switched
> from using find_get_pages_contig() to xarray scanning as the latter only
> gets a single page at a time, not a batch.
>
> Fix this by putting the page on a ref on an early break from the loop.
> Unfortunately, we can't just add that page to the pagevec we're employing
> as we'll go through that and add those pages to the RPC call.
>
> This was found by the generic/074 test.  It leaks ~4GiB of RAM each time it
> is run - which can be observed with "top".
>
> Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/write.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index c0534697268e..66b235266893 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -471,13 +471,18 @@ static void afs_extend_writeback(struct address_space *mapping,
>                         }
>
>                         /* Has the page moved or been split? */
> -                       if (unlikely(page != xas_reload(&xas)))
> +                       if (unlikely(page != xas_reload(&xas))) {
> +                               put_page(page);
>                                 break;
> +                       }
>
> -                       if (!trylock_page(page))
> +                       if (!trylock_page(page)) {
> +                               put_page(page);
>                                 break;
> +                       }
>                         if (!PageDirty(page) || PageWriteback(page)) {
>                                 unlock_page(page);
> +                               put_page(page);
>                                 break;
>                         }
>
> @@ -487,6 +492,7 @@ static void afs_extend_writeback(struct address_space *mapping,
>                         t = afs_page_dirty_to(page, priv);
>                         if (f != 0 && !new_content) {
>                                 unlock_page(page);
> +                               put_page(page);
>                                 break;
>                         }
>
>
>
>

Reviewed-By: Marc Dionne <marc.dionne@auristor.com>
Tested-By: Marc Dionne <marc.dionne@auristor.com>

Marc
