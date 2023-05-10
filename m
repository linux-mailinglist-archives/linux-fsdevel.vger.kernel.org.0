Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D56FE668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjEJVpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 17:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJVpV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 17:45:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437CB46A9
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 14:45:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-969f90d71d4so404888266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 14:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683755118; x=1686347118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg4iZ/HI0Blb6XBzcbcI5diYEFjNlGnB/Pzpil/jZVo=;
        b=A2y4/B83HvTFSnMTBk8VHtO0cL1+1lzA88NTn16ESPv2pLwq45zriBNreF50kN3nBM
         7QqciVdOv+twhuQ1+dm1Kwes8Bg3YtMUwAuqGnBX8AW+EYhDss2R1z+qL6eQwL+QPM4F
         vN42T3YB/pdATLuwSLmBZuURJz+uORabkZJoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755118; x=1686347118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg4iZ/HI0Blb6XBzcbcI5diYEFjNlGnB/Pzpil/jZVo=;
        b=MkEcWZyjUgB4A1m726Kgz3vovm5toRzm8hXEgmJ27HM7QpElUH07wIp73/5e5AxWbz
         wmBt0k1tF+z9pHVgfo05FbbvEwqQcOKw9k5eb4Y0x//GjRPrzeRVRDqn27JQDLihMmCl
         ehXWa8T+uLSwVymVgMZUHScmTVOC7nmWyebml2gqNLjX2EzAPilk1GT84dO45/ZsFogI
         1IxXoN7jRTcaWZD0Nj/Gzs1wv8qq/jvZFU/briid8JIAhcMFC7g7or4I3qiS/8uUXSjL
         VbS+5ThCiszrfJGgVYsSpHiIAeFIw9K9KdhIPifAO4B4uDinqWgKWtipsnI/DvKZ5k7v
         dJHA==
X-Gm-Message-State: AC+VfDyJDIhCU3K/k1LVR9YJHwdUr6xmZbkwKXgwdQX0Ni3YwSv9R/RJ
        JGUzxKaZMnwk9p3PlIUS2P11pIfUqx1hvXQT4kCvdQ==
X-Google-Smtp-Source: ACHHUZ4X82mbex25ZeAOBZWoy57OqpMz6XucSd6il2s5+qRWVIcni4iN22z1ajBH1BSrw04kHmleiA==
X-Received: by 2002:a17:906:db03:b0:965:4b43:11f1 with SMTP id xj3-20020a170906db0300b009654b4311f1mr16264351ejb.3.1683755118543;
        Wed, 10 May 2023 14:45:18 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id e28-20020a170906845c00b0094e84314762sm3139092ejy.187.2023.05.10.14.45.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 14:45:17 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-969f90d71d4so404882166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 14:45:17 -0700 (PDT)
X-Received: by 2002:a17:907:7282:b0:96a:4654:9a49 with SMTP id
 dt2-20020a170907728200b0096a46549a49mr1324800ejc.67.1683755116622; Wed, 10
 May 2023 14:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230506160415.2992089-1-willy@infradead.org> <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <20230509191918.GB18828@cmpxchg.org> <ZFv+M5egsMxE1rhF@x1n> <CAHk-=wjKVXt+BAh+Gk+Cs9u8s=XzbQyzHhZSW2bPFMX74gPuRw@mail.gmail.com>
In-Reply-To: <CAHk-=wjKVXt+BAh+Gk+Cs9u8s=XzbQyzHhZSW2bPFMX74gPuRw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 May 2023 16:44:59 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgnHtP2uNtnFdQ4Ou-TZynipVVU5Jow+Fr8nhRgewkXAA@mail.gmail.com>
Message-ID: <CAHk-=wgnHtP2uNtnFdQ4Ou-TZynipVVU5Jow+Fr8nhRgewkXAA@mail.gmail.com>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
To:     Peter Xu <peterx@redhat.com>, Andrew Lutomirski <luto@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

On Wed, May 10, 2023 at 4:33=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We'd still keep the RETRY bit as a "this did not complete, you need to
> retry", but at least the whole secondary meaning of "oh, and if it
> isn't set, you need to release the lock you took" would go away.

"unless VM_FAULT_COMPLETED is set, in which case everything was fine,
and you shouldn't release the lock because we already released it".

I completely forgot about that wart that came in last year.

I think that if we made handle_mm_fault() always unlock, that thing
would go away entirely, since "0" would now just mean the same thing.

Is there really any case that *wants* to keep the mmap lock held, and
couldn't just always re-take it if it needs to do another page
(possibly retry, but the retry case obviously already has that issue)?

Certainly nothing wants the vma lock, so it's only the "mmap_sem" case
that would be an issue.

              Linus
