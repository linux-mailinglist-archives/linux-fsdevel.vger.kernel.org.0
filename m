Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7466F933C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEFRFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 13:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFRFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 13:05:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6CF18174
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 10:05:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so4523874a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683392707; x=1685984707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BohPGjhU0MW7cH+kq6sMfSx9As3zddOMBgwyOGlEMPA=;
        b=SFCveER3zj+YX4DQ0uYSH4XrGZaZLvB1GmseaA1Lc0ZsMUQMVa7u7IoNmZ2K0N9CAl
         UcBAtFZtQJkN+n4IGOgQ/Qxq3HpfpGrG47MfMn4ihgdjAnZnwO3xktw6tXFp5TPvSgPL
         xLntvXC/WMPutJN+Pf6Lfaw9+4ivwsDxOEQIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683392707; x=1685984707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BohPGjhU0MW7cH+kq6sMfSx9As3zddOMBgwyOGlEMPA=;
        b=aH/VfTU9C3rsD/itTqj0HQkE2iVuet17+c3ppRJBlM63O5BhawsxdKMsZIqLVprg9P
         M/YFTgCD6E+do1zRBbdh3y42uUYlKdWK67HkpsjmNqfVjqchEsaefLXG2NDSTEfakhNe
         Bels14st2/mW1IK8RvG60psv+CevNI2Y5f9G+jAxP2pmRi0Trvhdjogcmz2ajKmZqn2V
         x0WV7edNxKr1nDtphIHTRx/5eIZUtdfiQzyqHjZX2LM+ymL18uxQSf7zcrJuedqiVi4R
         3HgNwXJIqcMwtB/v2b8H4nb7Xpkzy7r+qGBOx6TMP//FXPY3SgqnY7ctoVBc7LXfyT3U
         qQlw==
X-Gm-Message-State: AC+VfDzcAoXO5hDLnOr8wUe/M4nVGx7ekYEvmkLFRAcGXLiazPFozY4O
        XhgwR0j3gfwvml70Cjxwb1IWpaDlhrDOw6Xy10Dqhg==
X-Google-Smtp-Source: ACHHUZ6LJ4MPFvcrIYa/H0BwoX60JttVen1StlQiHa5t5CLWa67n9LnqLEcXwP46bJGaJYWCpnRfmQ==
X-Received: by 2002:a17:907:31c7:b0:965:d18b:f03a with SMTP id xf7-20020a17090731c700b00965d18bf03amr4000997ejb.58.1683392707446;
        Sat, 06 May 2023 10:05:07 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906088d00b0094f1d0bad81sm2523369eje.139.2023.05.06.10.05.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 10:05:05 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so470125066b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 10:05:05 -0700 (PDT)
X-Received: by 2002:a17:906:fd8c:b0:94f:3cf5:6d7f with SMTP id
 xa12-20020a170906fd8c00b0094f3cf56d7fmr4182892ejb.46.1683392704861; Sat, 06
 May 2023 10:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230506160415.2992089-1-willy@infradead.org> <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
In-Reply-To: <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 10:04:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
Message-ID: <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
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

On Sat, May 6, 2023 at 9:35=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yes, the simplest fix for the "wrong test" would be to just add a
> new "out_nofolio" error case after "out_retry", and use that.
>
> However, even that seems wrong, because the return value for that path
> is the wrong one.

Actually, my suggested patch is _also_ wrong.

The problem is that we do need to return VM_FAULT_RETRY to let the
caller know that we released the mmap_lock.

And once we return VM_FAULT_RETRY, the other error bits don't even matter.

So while I think the *right* thing to do is to return VM_FAULT_OOM |
VM_FAULT_RETRY, that doesn't actually end up working, because if
VM_FAULT_RETRY is set, the caller will know that "yes, mmap_lock was
dropped", but the callers will also just ignore the other bits and
unconditionally retry.

How very very annoying.

This was introduced several years ago by commit 6b4c9f446981
("filemap: drop the mmap_sem for all blocking operations").

Looking at that, we have at least one other similar error case wrong
too: the "page_not_uptodate" case carefully checks for IO errors and
retries only if there was no error (or for the AOP_TRUNCATED_PAGE)
case.

For an actual IO error on page reading, it returns VM_FAULT_SIGBUS.

Except - again - for that "if (fpin) goto out_retry" case, which will
just return VM_FAULT_RETRY and retry the fault.

I do not believe that retrying the fault is the right thing to do when
we ran out of memory, or when we had an IO error, and I do not think
it was intentional that the error handling was changed.

But I  think this is all just a mistake from how that VM_FAULT_RETRY
works in the callers.

How very very annoying.

So scratch that patch suggestion of mine, but let's bring in some
people involved with the original fpin code, and see if we can find
some solution that honors that error case too.

               Linus
