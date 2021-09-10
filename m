Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FEA4072D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 23:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhIJVMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 17:12:06 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:33770 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhIJVMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:12:06 -0400
Received: by mail-ej1-f44.google.com with SMTP id x11so6963472ejv.0;
        Fri, 10 Sep 2021 14:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UmuHpu0cKxiQt++F9TGuOrk3G7S1/A6mYH0c36xdco=;
        b=LMGsPbnBR4xPj4P/2VKlJK91kBvwIcDypk7lTJ9QzVtaArQNaOuR2udX55GaZ10gYI
         F9m2/0JgvR1YuU28sBnnat1X1WsXP8GcK86EY+XPFDfxJhDFFjMLQ3MxN3mLu2uXpot2
         eFhQWp2nRmiQToyYPAfNfJEYfCosMlBktBs3qlnbtB9q0NLzX4+BTwdwcSyQ1MP+Ei/l
         jfk+UT6WN1yaFXHDcuDr1tp9Rte9CvfnTAGrzO8DQfTCM2N4YvgNWaTbzxegpeA4iYSy
         pKgrAxZoxxgTVmi45l4Sot4Kg5hA4zXr0i6G3JpGVlq9NPBYeRTDJsXLXFPjDe5gnERe
         Fw/g==
X-Gm-Message-State: AOAM530VQ76wXYXd9l+o2C1+zPQfekKo1+FhSX+aXbV3wY8DtiAKcuUM
        4qgPL6wTiJEKHmBuMnE825+ku9s13no=
X-Google-Smtp-Source: ABdhPJznWasfW90FIjz/BZqRStamQExSrh6n2KZMW+zQlaX3aghygulRK5Ci6yyFmhpHNynB+tx60A==
X-Received: by 2002:a17:906:a3d9:: with SMTP id ca25mr3739305ejb.306.1631308253495;
        Fri, 10 Sep 2021 14:10:53 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id i6sm2860344ejd.57.2021.09.10.14.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:10:53 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id w29so3685359wra.8;
        Fri, 10 Sep 2021 14:10:53 -0700 (PDT)
X-Received: by 2002:adf:e349:: with SMTP id n9mr12196570wrj.326.1631308253036;
 Fri, 10 Sep 2021 14:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
 <163111665914.283156.3038561975681836591.stgit@warthog.procyon.org.uk>
In-Reply-To: <163111665914.283156.3038561975681836591.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Fri, 10 Sep 2021 18:10:42 -0300
X-Gmail-Original-Message-ID: <CAB9dFduo9smK9VvPPKYPFXNdyvQu723UsnrfVDRvk8Eq+g7gFg@mail.gmail.com>
Message-ID: <CAB9dFduo9smK9VvPPKYPFXNdyvQu723UsnrfVDRvk8Eq+g7gFg@mail.gmail.com>
Subject: Re: [PATCH 1/6] afs: Fix missing put on afs_read objects and missing
 get on the key therein
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
> The afs_read objects created by afs_req_issue_op() get leaked because
> afs_alloc_read() returns a ref and then afs_fetch_data() gets its own ref
> which is released when the operation completes, but the initial ref is
> never released.
>
> Fix this by discarding the initial ref at the end of afs_req_issue_op().
>
> This leak also covered another bug whereby a ref isn't got on the key
> attached to the read record by afs_req_issue_op().  This isn't a problem as
> long as the afs_read req never goes away...
>
> Fix this by calling key_get() in afs_req_issue_op().
>
> This was found by the generic/074 test.  It leaks a bunch of kmalloc-192
> objects each time it is run, which can be observed by watching
> /proc/slabinfo.
>
> Fixes: f7605fa869cf ("afs: Fix leak of afs_read objects")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> Link: https://lore.kernel.org/r/163010394740.3035676.8516846193899793357.stgit@warthog.procyon.org.uk/
> ---
>
>  fs/afs/file.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index db035ae2a134..6688fff14b0b 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -295,7 +295,7 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
>         fsreq->subreq   = subreq;
>         fsreq->pos      = subreq->start + subreq->transferred;
>         fsreq->len      = subreq->len   - subreq->transferred;
> -       fsreq->key      = subreq->rreq->netfs_priv;
> +       fsreq->key      = key_get(subreq->rreq->netfs_priv);
>         fsreq->vnode    = vnode;
>         fsreq->iter     = &fsreq->def_iter;
>
> @@ -304,6 +304,7 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
>                         fsreq->pos, fsreq->len);
>
>         afs_fetch_data(fsreq->vnode, fsreq);
> +       afs_put_read(fsreq);
>  }
>
>  static int afs_symlink_readpage(struct page *page)

Tested that it prevents the leak of about 49K kmalloc-192 objects for
a run of generic/074.

Reviewed-and-tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc
