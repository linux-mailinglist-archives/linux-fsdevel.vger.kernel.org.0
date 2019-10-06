Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714C6CD9A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 01:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfJFXfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 19:35:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44372 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfJFXfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 19:35:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id q12so2990835lfc.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I541VyUsc39FvItvzf+6+a8hUNrsqYjkEIi3jp2fNe8=;
        b=dRuQMA2y2wlK980QrRzfH0xEaPdZmaKsiQQCv/qmq93BayrBgQjq03QgE6EdBHRoQT
         OZoizuluLCjMPp4szPv9UOuBbzVUypw+Zjz0wmmFn+xCOXWv842CfUdkcpf4pCVrIbHh
         frveB/6637/WgVUn6pMqJQpqOxNxMkXf3rQ+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I541VyUsc39FvItvzf+6+a8hUNrsqYjkEIi3jp2fNe8=;
        b=s10KFjH4DjsbIOapUslHyc9HBnIb5ohcdTNXDC2uaT79xOGNyoS+Y78HzEjCh8looT
         QsAHDlNOX6hLmPhgZ99yb2ePTezKASD3LO7K4rJseI8bBJflpboVd3sOvWuQb6zS6xfg
         LkOdxksRGk8BuiomK/ZDn5iBe9HEcjQ6dHoxd0N1krFCovqXdNtgOLYkJz2H6X1Mv17u
         k9ChaqTT+I19qh1cb+Gfocqq26rfWM2roFNEdJzz0Uq/BTxUTIEd0etjm1oJlDSRV4w9
         PneSDIqUQnF+kcq1jk79+HBzEcvE6HY0GpdrQU+VIllPr/Gh7RkwOBHZohjCY9cRsDIv
         8B9g==
X-Gm-Message-State: APjAAAUKixNg0MHz4zORAaQuheGuUVUZwCxAEslRzBA+ju9oPOGg0jgV
        6yfikZ2/fEA/x8Ry45RqG34PRts/ZKs=
X-Google-Smtp-Source: APXvYqz8OOkie0Pl8SEuQ9FJfdw+tGpeyHuX7VQteutplrb5/aeWzujyf61ohZ+yV0TQnghIsjHqSQ==
X-Received: by 2002:a19:90:: with SMTP id 138mr14185849lfa.111.1570404934054;
        Sun, 06 Oct 2019 16:35:34 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id g26sm2810190lje.80.2019.10.06.16.35.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 16:35:32 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id t8so7898257lfc.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2019 16:35:32 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr15047822lfp.61.1570404932088;
 Sun, 06 Oct 2019 16:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
In-Reply-To: <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 16:35:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
Message-ID: <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000219e680594466412"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000219e680594466412
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 6, 2019 at 4:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ho humm. I've run variations of that patch over a few years on x86,
> but obviously not on alpha/sparc.

Oooh.

I wonder... This may be the name string copy loop. And it's special in
that the result may not be aligned.

Now, a "__put_user()" with an unaligned address _should_ work - it's
very easy to trigger that from user space by just giving an unaligned
address to any system call that then writes a single word.

But alpha does

  #define __put_user_32(x, addr)                                  \
  __asm__ __volatile__("1: stl %r2,%1\n"                          \
          "2:\n"                                                  \
          EXC(1b,2b,$31,%0)                                       \
                  : "=r"(__pu_err)                                \
                  : "m"(__m(addr)), "rJ"(x), "0"(__pu_err))

iow it implements that 32-bit __put_user() as a 'stl'.

Which will trap if it's not aligned.

And I wonder how much testing that has ever gotten. Nobody really does
unaigned accesses on alpha.

We need to do that memcpy unrolling on x86, because x86 actually uses
"user_access_begin()" and we have magic rules about what is inside
that region.

But on alpha (and sparc) it might be better to just do "__copy_to_user()".

Anyway, this does look like a possible latent bug where the alpha
unaligned trap doesn't then handle the case of exceptions. I know it
_tries_, but I doubt it's gotten a whole lot of testing.

Anyway, let me think about this, but just for testing, does the
attached patch make any difference? It's not the right thing in
general (and most definitely not on x86), but for testing whether this
is about unaligned accesses it might work.

It's entirely untested, and in fact on x86 it should cause objtool to
complain about a function call with AC set. But I think that on alpha
and sparc, using __copy_to_user() for the name copy should work, and
would work around the unaligned issue.

That said, if it *is* the unaligned issue, then that just means that
we have a serious bug elsewhere in the alpha port. Maybe nobody cares.

              Linus

--000000000000219e680594466412
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1fmjafm0>
X-Attachment-Id: f_k1fmjafm0

IGZzL3JlYWRkaXIuYyB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvZnMvcmVhZGRpci5jIGIvZnMvcmVhZGRpci5jCmluZGV4IDE5YmVh
NTkxYzNmMS4uZDQ5YzRlMmM2NmE4IDEwMDY0NAotLS0gYS9mcy9yZWFkZGlyLmMKKysrIGIvZnMv
cmVhZGRpci5jCkBAIC03Niw2ICs3NiwxNSBAQAogCXVuc2FmZV9wdXRfdXNlcigwLCBkc3QsIGxh
YmVsKTsJCQkJXAogfSB3aGlsZSAoMCkKIAorLyogQWxwaGEgKGFuZCBzcGFyYz8pIHRlc3QgcGF0
Y2ghICovCisjdW5kZWYgdW5zYWZlX2NvcHlfZGlyZW50X25hbWUKKyNkZWZpbmUgdW5zYWZlX2Nv
cHlfZGlyZW50X25hbWUoX2RzdCwgX3NyYywgX2xlbiwgbGFiZWwpIGRvIHsJXAorCWNoYXIgX191
c2VyICpkc3QgPSAoX2RzdCk7CQkJCVwKKwljb25zdCBjaGFyICpzcmMgPSAoX3NyYyk7CQkJCVwK
KwlzaXplX3QgbGVuID0gKF9sZW4pOwkJCQkJXAorCWlmIChfX2NvcHlfdG9fdXNlcihkc3QsIHNy
YywgbGVuKSkgZ290byBsYWJlbDsJCVwKKwl1bnNhZmVfcHV0X3VzZXIoMCwgZHN0K2xlbiwgbGFi
ZWwpOwkJCVwKK30gd2hpbGUgKDApCiAKIGludCBpdGVyYXRlX2RpcihzdHJ1Y3QgZmlsZSAqZmls
ZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpCiB7Cg==
--000000000000219e680594466412--
