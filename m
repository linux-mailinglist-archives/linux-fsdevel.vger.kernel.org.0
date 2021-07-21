Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E413D0F24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhGUMSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 08:18:50 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35645 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbhGUMSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:18:48 -0400
Received: by mail-ed1-f42.google.com with SMTP id ca14so2287150edb.2;
        Wed, 21 Jul 2021 05:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+axqBBkvP97hz6uB53B9L+3foMfPozHjLnXrv77Domo=;
        b=IGupep5P6MQvzhi5sHAgLAY782DMPqIU+2+EsWoFyR8+cKAfPK8PT4Pdgi3K/f4aH5
         +KnRa+agpbWuAtO2rFnaiSaSrdcC4Z9sGZGFd88ovSJuvoGw91osVMkpTMIZ5TgN83w0
         6QaqaH79O9ZXYy2Ulf8O0j00ZL1z8VMDjFSJGvVIKn0ZQsY/8Bbr6IJUCwWYyfDSkOdN
         cqy61B2GQKW/fDmnwWRybvQhPeSBELnm4EZwnWy+WHK53Fab5J+tCWrykzhxjz3tRbwD
         RmqszfvxDB2VnqO/2SxU2s5s/vB47m5j4Fe1T0Iobe6/h7YsiRMhXIJN7I0UOAnXJpAa
         hMXQ==
X-Gm-Message-State: AOAM531Kj0UOCRaaG08+zqjoq8zJylS3KT0VS/a7qAkZXvoiPn20p6r/
        mOmJ180q/BaID4U2BecMimF29jA8oMgsFg==
X-Google-Smtp-Source: ABdhPJxczKUIgD94AYS0GPwCNg01PE/+bJT0vKP4vCtRaUqy6zTtws9QhbDbiF9zRFFSLAK+oY5YSQ==
X-Received: by 2002:aa7:cf8b:: with SMTP id z11mr49206473edx.54.1626872362930;
        Wed, 21 Jul 2021 05:59:22 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id f5sm8230165ejj.45.2021.07.21.05.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 05:59:22 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id f9so2081984wrq.11;
        Wed, 21 Jul 2021 05:59:22 -0700 (PDT)
X-Received: by 2002:a5d:6caf:: with SMTP id a15mr42893600wra.313.1626872362525;
 Wed, 21 Jul 2021 05:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <162610726011.3408253.2771348573083023654.stgit@warthog.procyon.org.uk>
 <162610727640.3408253.8687445613469681311.stgit@warthog.procyon.org.uk>
In-Reply-To: <162610727640.3408253.8687445613469681311.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Wed, 21 Jul 2021 09:59:11 -0300
X-Gmail-Original-Message-ID: <CAB9dFdsuPd8w18_W-rRSKjv7JNs_iK7S8ujFNgC8LRS1_yD0XA@mail.gmail.com>
Message-ID: <CAB9dFdsuPd8w18_W-rRSKjv7JNs_iK7S8ujFNgC8LRS1_yD0XA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] afs: check function return
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, Tom Rix <trix@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 1:28 PM David Howells <dhowells@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Static analysis reports this problem
>
> write.c:773:29: warning: Assigned value is garbage or undefined
>   mapping->writeback_index = next;
>                            ^ ~~~~
> The call to afs_writepages_region() can return without setting
> next.  So check the function return before using next.
>
> Changes:
>  ver #2:
>    - Need to fix the range_cyclic case also[1].
>
> Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
> Signed-off-by: Tom Rix <trix@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Link: https://lore.kernel.org/r/20210430155031.3287870-1-trix@redhat.com
> Link: https://lore.kernel.org/r/162609464716.3133237.10354897554363093252.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/CAB9dFdvHsLsw7CMnB+4cgciWDSqVjuij4mH3TaXnHQB8sz5rHw@mail.gmail.com/ [1]
> ---
>
>  fs/afs/write.c |   16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/fs/afs/write.c b/fs/afs/write.c
> index 3104b62c2082..1ed62e0ccfe5 100644
> --- a/fs/afs/write.c
> +++ b/fs/afs/write.c
> @@ -771,13 +771,19 @@ int afs_writepages(struct address_space *mapping,
>         if (wbc->range_cyclic) {
>                 start = mapping->writeback_index * PAGE_SIZE;
>                 ret = afs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
> -               if (start > 0 && wbc->nr_to_write > 0 && ret == 0)
> -                       ret = afs_writepages_region(mapping, wbc, 0, start,
> -                                                   &next);
> -               mapping->writeback_index = next / PAGE_SIZE;
> +               if (ret == 0) {
> +                       mapping->writeback_index = next / PAGE_SIZE;
> +                       if (start > 0 && wbc->nr_to_write > 0) {
> +                               ret = afs_writepages_region(mapping, wbc, 0,
> +                                                           start, &next);
> +                               if (ret == 0)
> +                                       mapping->writeback_index =
> +                                               next / PAGE_SIZE;
> +                       }
> +               }
>         } else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
>                 ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
> -               if (wbc->nr_to_write > 0)
> +               if (wbc->nr_to_write > 0 && ret == 0)
>                         mapping->writeback_index = next;
>         } else {
>                 ret = afs_writepages_region(mapping, wbc,
>
>

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
