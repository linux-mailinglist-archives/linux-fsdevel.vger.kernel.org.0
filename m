Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001294230EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhJETsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhJETsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:48:39 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CC6C06174E
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 12:46:48 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 66so427803vsd.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbwUhuMxm8wviya953E+2y/7YeYTSfn0ydblYxORl38=;
        b=IYnkAcTszoNHR7peNGSuJcVo9fQ2RxLSX6x2JohB973rf+/tV/0AciX0CZ/cVUZa0X
         v2byVPDSTkYqRSV18GemThj7pzrmMsA9CNYU2JngTZa4S2BdD18NIhaDVxX4MHi4RXJn
         iKmIK3+zx01+A1KuABHNoFOwukPnO4sEK3RjjuDg6YYMaJkIciYakCKl6SU9rDl9iedE
         kO76hC2Do2ETWeIFeoafnhM/wVhcKAJF49+W1kkpLPRKmpzvvW7Oo8W4YRnVQj15TD7O
         nIVltM+U5OhABIng3iK9Qab5NykMGrd/n7k/M0+WPP9FESp3WQt37qi7kAvvJsgg/1rp
         Xwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbwUhuMxm8wviya953E+2y/7YeYTSfn0ydblYxORl38=;
        b=ZFeADUJQ9FeFSKyFbn+MyouhSmas0qwEjEC6H88aJosdz2QynNncg/E+gT2oiCtwVR
         wMMGZmsdii+i4wQfqrOOu+q7bAHHYaggWZCMlvQTy9p2+uuflxaUtbmWfTr2RqkHttFX
         i3v2ZLwyrYZWdXRK5Ellf6s9e/wj2q1nPx3oBnDFN+XD8RsKyRD6S760XZNxmmTgW7FV
         WBKjI9y5Lw+Srl5P+WlXkzvOfAY5Y2haNw5SWn+LwQK0kvu0D3BoQDuHD4tyEIZBd81o
         IC9qGzvCIpxL5YyPR2/6EBeyrUIoR9g9OuJiMSdz9NGj6SSkl8BdQdnXhE8dtTJj/N8/
         kr9g==
X-Gm-Message-State: AOAM531gzFWKYnyJOUUw36AFcXap7LIzvBre9Jy5J4nowaaBPwBw4tWa
        C+gB7S6PGHB/eiLoqqxbVhV1zrgkTG5uTVM+5gMgxA==
X-Google-Smtp-Source: ABdhPJw1jRFug/BatrjktZwMcZuNKkTNFW8nGYixW20s2h09JWywJiPXGstRD3BEvJViKhu4dWaYW7Km4rlo1NIsaR0=
X-Received: by 2002:a67:df16:: with SMTP id s22mr20626648vsk.47.1633463207755;
 Tue, 05 Oct 2021 12:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210928194509.4133465-1-ramjiyani@google.com> <x49ilybjmdt.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49ilybjmdt.fsf@segfault.boston.devel.redhat.com>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Tue, 5 Oct 2021 12:46:36 -0700
Message-ID: <CAKUd0B_vh5gxsjHVAoC4YTpwUA8vj6qKovza8OM391koM2t+hQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] aio: Add support for the POLLFREE
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff:

On Tue, Oct 5, 2021 at 12:33 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Ramji,
>
> Thanks for the explanation of the use after free.  I went ahead and
> ran the patch through the libaio test suite and it passed.
>

Thanks for taking time to test and providing feedback.

> > -#define POLLFREE     (__force __poll_t)0x4000        /* currently only for epoll */
> > +#define POLLFREE     ((__force __poll_t)0x4000)
>
> You added parenthesis, here, and I'm not sure if that's a necessary part
> of this patch.

I added parenthesis to silence the checkpatch script. Should I just ignore it?
I'll send v2 with the change, if it is required.

>
> Other than that:
>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>
Thanks,
Ramji
