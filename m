Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB56B9DCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCNSDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCNSDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:03:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2616885
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 11:03:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o12so65501061edb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678816978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaNrWV0j7xcmGChzOfmkTnIc3tuBbFeTK4GfA059lX0=;
        b=fGyMzUDIE5GRr0xjxhHRvZJDLx69KUDpAG++nClfKHil4bIX3uGenqCeDh6Un5s8/f
         mafoWdyx7BDOBca8ub7lMRpu2vItR6dgPHgsFBUDs3CD1ovDESqEvY5uLS2mEoVfFgL2
         orSTV8dw9EAGXF2WmZu8EgSGC9PwBo2d9AgEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678816978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaNrWV0j7xcmGChzOfmkTnIc3tuBbFeTK4GfA059lX0=;
        b=iZhuKrvILjs2b2deN3tMsGAvWPKINevbXkYvG72OrBEUAg3gpiRPj88nTf8MxySa59
         6vPT3Clg/N/J6sreszYDzPdNE7ScD5gSIMDByz5ZIrVm9QhL48QHXjoS8YoGoTIh58Ic
         /ARTDdhv8NxZGU5+qdEKZsFURYUg9vekH64l6RAuPfg4BpoaH/Jj201yTBp4qFubZE4x
         EE4v6gB5fvhSqgGPeTf7a5q4PwulOVkCENXHSPsznVxFMHZ6V4xH1idH3ZBGQw40+qsq
         xlctUjierU9TZ0bFNXOkczBP6xYJJrvjei2ZAxLhOmQzbFYq/fwXL4U7mP4I0e/HdAVH
         cBRQ==
X-Gm-Message-State: AO0yUKU6U4dSQTUKKVGwCBwwz+WwzjLgsVa7iQRccIbnqLdwfz+mnkPe
        vKxWEw6E0OQ8YBpp7T49uSMx0tfySaLvV+pTXTdFvQ==
X-Google-Smtp-Source: AK7set9ebiMCohVNGre1ZJitLI5Y55leCZz5nFzjEcuXK7gVBqev4smed9nOQ/Rs7/8zSLbU+FpmLw==
X-Received: by 2002:a17:906:82cb:b0:92c:465d:327e with SMTP id a11-20020a17090682cb00b0092c465d327emr4407525ejy.62.1678816978693;
        Tue, 14 Mar 2023 11:02:58 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709060b1600b0092a7c28c348sm1434525ejg.69.2023.03.14.11.02.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:02:58 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id y4so36065961edo.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 11:02:58 -0700 (PDT)
X-Received: by 2002:a17:906:c30e:b0:8ad:d366:54c4 with SMTP id
 s14-20020a170906c30e00b008add36654c4mr1933623ejz.4.1678816977991; Tue, 14 Mar
 2023 11:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com> <ZBCkDvveAIJENA0G@casper.infradead.org>
In-Reply-To: <ZBCkDvveAIJENA0G@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 11:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
Message-ID: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 9:43=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> The problem is that we might have swapped out the shmem folio.  So we
> don't want to clear the page, but ask swap to fill the page.

Doesn't shmem_swapin_folio() already basically do all that work?

The real oddity with shmem - compared to other filesystems - is that
the xarray has a value entry instead of being a real folio. And yes,
the current filemap code will then just ignore such entries as
"doesn't exist", and so the regular read iterators will all fail on
it.

But while filemap_get_read_batch() will stop at a value-folio, I feel
like filemap_create_folio() should be able to turn a value page into a
"real" page. Right now it already allocates said page, but then I
think filemap_add_folio() will return -EEXIST when said entry exists
as a value.

But *if* instead of -EEXIST we could just replace the value with the
(already locked) page, and have some sane way to pass that value
(which is the swap entry data) to readpage(), I think that should just
do it all.

Admittedly I really don't know this area very well, so I may be
*entirely* out to lunch.

But the whole "teach the filemap code to actually react to XA value
entries" would be how I'd solve the hole issue too. So I think there
are commonalities here.

             Linus
               Linus
