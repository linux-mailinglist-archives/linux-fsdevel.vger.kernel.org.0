Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE10764097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 22:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjGZUh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 16:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGZUh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:37:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40952701;
        Wed, 26 Jul 2023 13:37:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so2527171fa.3;
        Wed, 26 Jul 2023 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690403844; x=1691008644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lwD0XW5XNFFxl46sPGBkyRuR0c2+TXyAF+CGil8NRI=;
        b=WBqtUarSorotOYNCJWkNReSAf19CXEDpnJUFPGIYyvbDGPlIhT1+vr65mlLeyLiFth
         GmCuACdJUKmp+aXMjQJaPSWfUyQzmfkXHGzk1XVUCq+ELSSJcCrHrh6NujIUxHhB+pw6
         nrYhrtteDJSDiCNTnF299w8Z9/ab/lCPugj6dQRq2KaUlgPuKoQROhjcGJ8gNM13Bqq6
         HXJ0oEeCTipLRP3OmuZJqKsKtZxr2J8MAGrlTNRyxx+TIF/yZUzVNn9X44NDKlLi5I1l
         PROjUW0OkV6M0DhbGgLHOtqYwRlhKYlkumzwjTCDK8bK1/gq+2Hvl44iae7i0AeSagm4
         dsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690403844; x=1691008644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lwD0XW5XNFFxl46sPGBkyRuR0c2+TXyAF+CGil8NRI=;
        b=KIeyFqN3IrEPVStL8fHKKTBEc61YjKglY7MV8QLhdRs4w3hHd+BIJd/rGgpRtteHeM
         ULe/wPZ/s22nwauGlOPb/0omYiRFlZTiV+m9BOCEAKxGO/wQtKBhHFd86jipOmVAWmKj
         3WL83AaYdrIZ+GSblrFyYfWz2N5BFlyHHnOfzYdD2Xp7C/9inJ4AAMaQIzEffzmanCp4
         wy2hQSCglKo7ievZpjeCKBLQzEp5LQbg6+eMF4XowBuA0W9vdFr0AvVu/00xJx+1e1bu
         Qv/nEDV28WiypPjauHBQg2owMGaWSMiQZHlnD87S+Z9B3T6awYKQlBqyWpDvlBJdmsja
         K0mA==
X-Gm-Message-State: ABy/qLYXjZhn3ocZZW+AaEQCCUHyP+dx46werLhdSdWxqzC766UPg8aJ
        ha2HAcPhnB+pzl2PHOCHAnUDSWA8p00vyg/hMI4=
X-Google-Smtp-Source: APBJJlEBZjUVEWmH37ptqLNcNX8TxOf/NsFag9dWp+iIhP+gTcIv5RvFOUu1qEFSS9+AlBqg9RVIEdg2dS0OjOpUZFE=
X-Received: by 2002:a2e:8490:0:b0:2b6:9afe:191c with SMTP id
 b16-20020a2e8490000000b002b69afe191cmr129103ljh.7.1690403843955; Wed, 26 Jul
 2023 13:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20571.1690369076@warthog.procyon.org.uk> <416eca24-6baf-69d9-21a2-c434a9744596@redhat.com>
In-Reply-To: <416eca24-6baf-69d9-21a2-c434a9744596@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 26 Jul 2023 15:37:12 -0500
Message-ID: <CAH2r5mtMLQ91znvYP71s_K7uS_HibC_yOpkZea-f=+NteFJyPg@mail.gmail.com>
Subject: Re: [PATCH] crypto, cifs: Fix error handling in extract_iter_to_sg()
To:     David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steve French <sfrench@samba.org>, akpm@linux-foundation.org,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Layton <jlayton@kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Acked-off-by: Steve French <stfrench@microsoft.com>

On Wed, Jul 26, 2023 at 8:56=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 26.07.23 12:57, David Howells wrote:
> >
> > Fix error handling in extract_iter_to_sg().  Pages need to be unpinned,=
 not
> > put in extract_user_to_sg() when handling IOVEC/UBUF sources.
> >
> > The bug may result in a warning like the following:
> >
> >    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 __lse_atomic_add arch/arm=
64/include/asm/atomic_lse.h:27 [inline]
> >    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 arch_atomic_add arch/arm6=
4/include/asm/atomic.h:28 [inline]
> >    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 raw_atomic_add include/li=
nux/atomic/atomic-arch-fallback.h:537 [inline]
> >    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 atomic_add include/linux/=
atomic/atomic-instrumented.h:105 [inline]
> >    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 try_grab_page+0x108/0x160=
 mm/gup.c:252
> >    ...
> >    pc : try_grab_page+0x108/0x160 mm/gup.c:229
> >    lr : follow_page_pte+0x174/0x3e4 mm/gup.c:651
> >    ...
> >    Call trace:
> >     __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
> >     arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
> >     raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inl=
ine]
> >     atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
> >     try_grab_page+0x108/0x160 mm/gup.c:252
> >     follow_pmd_mask mm/gup.c:734 [inline]
> >     follow_pud_mask mm/gup.c:765 [inline]
> >     follow_p4d_mask mm/gup.c:782 [inline]
> >     follow_page_mask+0x12c/0x2e4 mm/gup.c:839
> >     __get_user_pages+0x174/0x30c mm/gup.c:1217
> >     __get_user_pages_locked mm/gup.c:1448 [inline]
> >     __gup_longterm_locked+0x94/0x8f4 mm/gup.c:2142
> >     internal_get_user_pages_fast+0x970/0xb60 mm/gup.c:3140
> >     pin_user_pages_fast+0x4c/0x60 mm/gup.c:3246
> >     iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
> >     iov_iter_extract_pages+0xc8/0x54c lib/iov_iter.c:1831
> >     extract_user_to_sg lib/scatterlist.c:1123 [inline]
> >     extract_iter_to_sg lib/scatterlist.c:1349 [inline]
> >     extract_iter_to_sg+0x26c/0x6fc lib/scatterlist.c:1339
> >     hash_sendmsg+0xc0/0x43c crypto/algif_hash.c:117
> >     sock_sendmsg_nosec net/socket.c:725 [inline]
> >     sock_sendmsg+0x54/0x60 net/socket.c:748
> >     ____sys_sendmsg+0x270/0x2ac net/socket.c:2494
> >     ___sys_sendmsg+0x80/0xdc net/socket.c:2548
> >     __sys_sendmsg+0x68/0xc4 net/socket.c:2577
> >     __do_sys_sendmsg net/socket.c:2586 [inline]
> >     __se_sys_sendmsg net/socket.c:2584 [inline]
> >     __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2584
> >     __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
> >     invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
> >     el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:14=
2
> >     do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
> >     el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
> >     el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
> >     el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
> >
> > Fixes: 018584697533 ("netfs: Add a function to extract an iterator into=
 a scatterlist")
> > Reported-by: syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/linux-mm/000000000000273d0105ff97bf56@goo=
gle.com/
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Sven Schnelle <svens@linux.ibm.com>
> > cc: akpm@linux-foundation.org
> > cc: Herbert Xu <herbert@gondor.apana.org.au>
> > cc: "David S. Miller" <davem@davemloft.net>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: Steve French <sfrench@samba.org>
> > cc: Shyam Prasad N <nspmangalore@gmail.com>
> > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > cc: Jens Axboe <axboe@kernel.dk>
> > cc: Herbert Xu <herbert@gondor.apana.org.au>
> > cc: "David S. Miller" <davem@davemloft.net>
> > cc: Eric Dumazet <edumazet@google.com>
> > cc: Jakub Kicinski <kuba@kernel.org>
> > cc: Paolo Abeni <pabeni@redhat.com>
> > cc: Matthew Wilcox <willy@infradead.org>
> > cc: linux-mm@kvack.org
> > cc: linux-crypto@vger.kernel.org
> > cc: linux-cachefs@redhat.com
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > cc: netdev@vger.kernel.org
> > ---
> >   lib/scatterlist.c |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> > index e86231a44c3d..c65566b4dc66 100644
> > --- a/lib/scatterlist.c
> > +++ b/lib/scatterlist.c
> > @@ -1148,7 +1148,7 @@ static ssize_t extract_user_to_sg(struct iov_iter=
 *iter,
> >
> >   failed:
> >       while (sgtable->nents > sgtable->orig_nents)
> > -             put_page(sg_page(&sgtable->sgl[--sgtable->nents]));
> > +             unpin_user_page(sg_page(&sgtable->sgl[--sgtable->nents]))=
;
> >       return res;
> >   }
> >
> >
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>


--=20
Thanks,

Steve
