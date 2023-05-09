Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3365C6FCCDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 19:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjEIRhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 13:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEIRhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 13:37:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD93D2D53
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 10:37:33 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-953343581a4so950046366b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683653852; x=1686245852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM2fcsPFrEudeR9j/MWzHsva1jmiluw7ikgnqGCbGAc=;
        b=JgT304oBsl+sIrPtAWAiS8blGhvHaTi4/qUXfNVkQIgDyaGnVjfotxXs2dWEauuL+G
         +70eGlH5BkaHl7SA9+QpH1OF6C4zLrIdNTiwDQ1tPgBC+dmA9yhPZ4EbPi3ZKca2xBtg
         dPmSlN/3223sWeJ6DDK/b0MzRftqtgugd+bh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683653852; x=1686245852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RM2fcsPFrEudeR9j/MWzHsva1jmiluw7ikgnqGCbGAc=;
        b=LRNGbgf5/ENg39EK/ZxJRgGVd4Ti01OFf0qspLWP41EehUbPSOkEGMK1B16OsjmMkZ
         QmfUgkOTgJiMWYlmgRFGq6f88S1ZixFLvN3AUNrYuI113W26ywdlhk1Fb759XKdOYayA
         W8v/D7LTide6WxZH52q8XIFi+vLXqYEeJhd7z8sEG2uktWY6eHD+hvkQJVvfEtJAhQIT
         utBMvXKsviu62KOdz8eaFKGVBkvaM0rFtHE6fbK6G3j/Slv9sNkrfyUqe32r/VBugNpG
         bVITn28g4sKPaHNXBi4ddkG5/69PA46mhlojrXOj+V/Io2yXh0aEGpiBv4YYKzkU1+hq
         BbLQ==
X-Gm-Message-State: AC+VfDxdtDKm/zMeQ9+HmKfIe0w36fkm1/iGGCtGPbGVbvVv0jz/28yr
        wFukLH94+uv/BJpeLUgFJj4anIMS3Q+DK49+/uMmlg==
X-Google-Smtp-Source: ACHHUZ7XO0xBohmWncPnUSkA8u5U0unHQjT5yj00WONIrZvwWHbXDhVbNdhPZIrLFp5EcUYIjDs8cQ==
X-Received: by 2002:a17:906:9c83:b0:94f:3074:14fe with SMTP id fj3-20020a1709069c8300b0094f307414femr14728836ejc.17.1683653852093;
        Tue, 09 May 2023 10:37:32 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id t17-20020a1709061bf100b00965f1f4bac5sm1545880ejg.124.2023.05.09.10.37.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:37:30 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-965c3f9af2aso904378566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 May 2023 10:37:30 -0700 (PDT)
X-Received: by 2002:a17:906:9b96:b0:958:4b79:b214 with SMTP id
 dd22-20020a1709069b9600b009584b79b214mr13940109ejc.18.1683653849929; Tue, 09
 May 2023 10:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230506160415.2992089-1-willy@infradead.org> <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
 <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com>
 <20230506104122.e9ab27f59fd3d8294cb1356d@linux-foundation.org>
 <7bd22265-f46c-4347-a856-eecd1429dcce@kili.mountain> <d98acf2e-04bd-4824-81e4-64e91a26537c@kili.mountain>
In-Reply-To: <d98acf2e-04bd-4824-81e4-64e91a26537c@kili.mountain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 May 2023 10:37:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whD=py2eMXFNOEQyDUobAXBJ3O0eFAG6yjC=EN4iZrhKw@mail.gmail.com>
Message-ID: <CAHk-=whD=py2eMXFNOEQyDUobAXBJ3O0eFAG6yjC=EN4iZrhKw@mail.gmail.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 9, 2023 at 12:43=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> I ran the new code last night.  There was one more folio bug (but every
> function in the call tree triggers a warning).
>
> fs/nfs/dir.c:405 nfs_readdir_folio_get_locked() warn: 'folio' is an error=
 pointer or valid

Thanks. I fixed that one up too.

In the process I ended up grepping for the other wrappers around
__filemap_get_folio() that also return ERR_PTR's for errors.

I might have missed some - this was just manual, after all - but while
I'm sure smatch finds those NULL pointer confusions, what I *did* find
was a lack of testing the result at all.

In fs/btrfs/extent_io.c, we have

    while (index <=3D end_index) {
        folio =3D filemap_get_folio(mapping, index);
        filemap_dirty_folio(mapping, folio);

and in fs/gfs2/lops.c we have a similar case of filemap_get_folio ->
folio_wait_locked use without checking for any errors.

I assume it's probably hard to trigger errors in those paths, but it
does look dodgy.

Added some relevant people to the participants to let them know...

I wonder if smatch can figure out automatically when error pointers do
*not* work, and need checking for.

A lot of places do not need to check for them, because they just
return the error pointer further up the call chain, but anything that
then actually dereferences it should have checked for them (same as
for NULL, of course).

               Linus
