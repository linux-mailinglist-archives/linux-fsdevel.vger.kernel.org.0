Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D756D0AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jul 2022 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGJSF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jul 2022 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGJSF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:05:26 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8153512D28
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jul 2022 11:05:25 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10bec750eedso4465449fac.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Jul 2022 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Z/YsUfcFwxJoiJ1+MQBfM9fcMWRpcdGDtozm7kgPY+8=;
        b=Tn/o2YulKyUTbOjIPmRD7hESSMQfS3T9FRv5cCqkxO59wible3qmao2vFzULOX+0XI
         gGEH8LOsNbIL3PPHsRrGonYndbOXBUQQy2z/HO7XJ8BRZntLgB4yDQrVO1oFuE+dHuCp
         BMspGGSqcdQNe7obeG74ZhUZ0Yk8hQYfEanMJjR9LbGnFSjR+ZzvdxKBbPeKDdB9dfhB
         pwbgna0MjVzpnjP1ia0RPupVIA1eEUVhiuXG2y938x0Sn82aPq8eEZN6/fgjNhZ6iK4X
         97hcwJ3/TGHKDivkn6u4D1vOdza+DcLexvtb544Znuq+GcS3S45r6EV66f0OpV+MwshM
         PHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Z/YsUfcFwxJoiJ1+MQBfM9fcMWRpcdGDtozm7kgPY+8=;
        b=uOA3taHRPsVNu5IbDi4uQWzNJJNx70HHCJYN4kMdEFj90CFbfnT91xJ2dxdbFvyZ5B
         H0uFBc/0V7tHOB3wbLlWDAWIa4vLlG0RCrKhm3YZjNnK94ytaiEEong6x48/An9P2lxA
         7kXf1VS9KCodJ5v4l6cWXdFc5OYYhqtEmOAZg7mmg/ph24SzdCzQxyp4MtOvdN344uZS
         gw9/HmTbBiN7toXHGByAlE3oQjB/zIVUGr4BHcYBjb75ArTOzM55MzyfvK1fEfZSXfmX
         2ZcYj0V1f+kI40JhfcyXiifc7htXUpfnMFHEA5MUeBxx+LmhCBY3EoNYsIeXqL0dEqle
         A3tQ==
X-Gm-Message-State: AJIora/jrkZPYRcmOYr8u2NvCPggS9/tGBVukc6MPHNYQ+HGJ5pt7G72
        84hW/VQKyhbswPE9RRxq3tAztu5G0dR93w+2EXZ3jLDI/rdh6A==
X-Google-Smtp-Source: AGRyM1uPAG3wEahJDwVgPFGiCsk00vL8tD4kGwjwts1V27wAwaOMu6aoatZ4bVZ4g4E8KA2ybyxTENB797yjvDZUia8=
X-Received: by 2002:a05:6870:709f:b0:fe:2006:a858 with SMTP id
 v31-20020a056870709f00b000fe2006a858mr5421343oae.128.1657476324742; Sun, 10
 Jul 2022 11:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <YrKWRCOOWXPHRCKg@ZenIV> <20220622041552.737754-1-viro@zeniv.linux.org.uk>
 <20220622041552.737754-37-viro@zeniv.linux.org.uk>
In-Reply-To: <20220622041552.737754-37-viro@zeniv.linux.org.uk>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 10 Jul 2022 20:04:48 +0200
Message-ID: <CA+icZUVHKgHD7OQo-nLFJUTQw_kRW2HhJRZAHKEj-KvJc4NNkQ@mail.gmail.com>
Subject: Re: [PATCH 37/44] block: convert to advancing variants of iov_iter_get_pages{,_alloc}()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008fcffa05e3774745"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000008fcffa05e3774745
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 22, 2022 at 6:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... doing revert if we end up not using some pages
>

With the version from latest vfs.git#for-next as from [1] (which
differs from this one) I see with LLVM-14:

5618:  clang -Wp,-MMD,block/.bio.o.d -nostdinc -I./arch/x86/include
-I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi
-I./arch/x86/include/generate
d/uapi -I./include/uapi -I./include/generated/uapi -include
./include/linux/compiler-version.h -include ./include/linux/kconfig.h
-include ./include/linux/compiler_typ
es.h -D__KERNEL__ -Qunused-arguments -fmacro-prefix-map=./= -Wall
-Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -fshort-wchar -fno-
PIE -Werror=implicit-function-declaration -Werror=implicit-int
-Werror=return-type -Wno-format-security -std=gnu11
--target=x86_64-linux-gnu -fintegrated-as -Werror=un
known-warning-option -Werror=ignored-optimization-argument -mno-sse
-mno-mmx -mno-sse2 -mno-3dnow -mno-avx -fcf-protection=none -m64
-falign-loops=1 -mno-80387 -mno-fp
-ret-in-387 -mstack-alignment=8 -mskip-rax-setup -mtune=generic
-mno-red-zone -mcmodel=kernel -Wno-sign-compare
-fno-asynchronous-unwind-tables -mretpoline-external-th
unk -fno-delete-null-pointer-checks -Wno-frame-address
-Wno-address-of-packed-member -O2 -Wframe-larger-than=2048
-fstack-protector-strong -Wimplicit-fallthrough -Wno-
gnu -Wno-unused-but-set-variable -Wno-unused-const-variable
-fno-stack-clash-protection -pg -mfentry -DCC_USING_NOP_MCOUNT
-DCC_USING_FENTRY -fno-lto -flto=thin -fspli
t-lto-unit -fvisibility=hidden -Wdeclaration-after-statement -Wvla
-Wno-pointer-sign -Wcast-function-type -fno-strict-overflow
-fno-stack-check -Werror=date-time -Werr
or=incompatible-pointer-types -Wno-initializer-overrides -Wno-format
-Wno-sign-compare -Wno-format-zero-length -Wno-pointer-to-enum-cast
-Wno-tautological-constant-out
-of-range-compare -Wno-unaligned-access -g -gdwarf-5
-DKBUILD_MODFILE='"block/bio"' -DKBUILD_BASENAME='"bio"'
-DKBUILD_MODNAME='"bio"' -D__KBUILD_MODNAME=kmod_bio -
c -o block/bio.o block/bio.c
[ ... ]
5635:block/bio.c:1232:6: warning: variable 'i' is used uninitialized
whenever 'if' condition is true [-Wsometimes-uninitialized]
5636-        if (unlikely(!size)) {
5637-            ^~~~~~~~~~~~~~~
5638-./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
5639-# define unlikely(x)    __builtin_expect(!!(x), 0)
5640-                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
5641-block/bio.c:1254:9: note: uninitialized use occurs here
5642-        while (i < nr_pages)
5643-               ^
5644-block/bio.c:1232:2: note: remove the 'if' if its condition is always false
5645-        if (unlikely(!size)) {
5646-        ^~~~~~~~~~~~~~~~~~~~~~
5647-block/bio.c:1202:17: note: initialize the variable 'i' to silence
this warning
5648-        unsigned len, i;
5649-                       ^
5650-                        = 0

Patch from [1] is attached.

Regards,
-Sedat-

[1] https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/block/bio.c?h=for-next&id=9a6469060316674230c0666c5706f7097e9278bb

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  block/bio.c     | 15 ++++++---------
>  block/blk-map.c |  7 ++++---
>  2 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 51c99f2c5c90..01ab683e67be 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1190,7 +1190,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>         BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>         pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>
> -       size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +       size = iov_iter_get_pages2(iter, pages, LONG_MAX, nr_pages, &offset);
>         if (unlikely(size <= 0))
>                 return size ? size : -EFAULT;
>
> @@ -1205,6 +1205,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>                 } else {
>                         if (WARN_ON_ONCE(bio_full(bio, len))) {
>                                 bio_put_pages(pages + i, left, offset);
> +                               iov_iter_revert(iter, left);
>                                 return -EINVAL;
>                         }
>                         __bio_add_page(bio, page, len, offset);
> @@ -1212,7 +1213,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>                 offset = 0;
>         }
>
> -       iov_iter_advance(iter, size);
>         return 0;
>  }
>
> @@ -1227,7 +1227,6 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>         ssize_t size, left;
>         unsigned len, i;
>         size_t offset;
> -       int ret = 0;
>
>         if (WARN_ON_ONCE(!max_append_sectors))
>                 return 0;
> @@ -1240,7 +1239,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>         BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>         pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>
> -       size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +       size = iov_iter_get_pages2(iter, pages, LONG_MAX, nr_pages, &offset);
>         if (unlikely(size <= 0))
>                 return size ? size : -EFAULT;
>
> @@ -1252,16 +1251,14 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>                 if (bio_add_hw_page(q, bio, page, len, offset,
>                                 max_append_sectors, &same_page) != len) {
>                         bio_put_pages(pages + i, left, offset);
> -                       ret = -EINVAL;
> -                       break;
> +                       iov_iter_revert(iter, left);
> +                       return -EINVAL;
>                 }
>                 if (same_page)
>                         put_page(page);
>                 offset = 0;
>         }
> -
> -       iov_iter_advance(iter, size - left);
> -       return ret;
> +       return 0;
>  }
>
>  /**
> diff --git a/block/blk-map.c b/block/blk-map.c
> index df8b066cd548..7196a6b64c80 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -254,7 +254,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>                 size_t offs, added = 0;
>                 int npages;
>
> -               bytes = iov_iter_get_pages_alloc(iter, &pages, LONG_MAX, &offs);
> +               bytes = iov_iter_get_pages_alloc2(iter, &pages, LONG_MAX, &offs);
>                 if (unlikely(bytes <= 0)) {
>                         ret = bytes ? bytes : -EFAULT;
>                         goto out_unmap;
> @@ -284,7 +284,6 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>                                 bytes -= n;
>                                 offs = 0;
>                         }
> -                       iov_iter_advance(iter, added);
>                 }
>                 /*
>                  * release the pages we didn't map into the bio, if any
> @@ -293,8 +292,10 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>                         put_page(pages[j++]);
>                 kvfree(pages);
>                 /* couldn't stuff something into bio? */
> -               if (bytes)
> +               if (bytes) {
> +                       iov_iter_revert(iter, bytes);
>                         break;
> +               }
>         }
>
>         ret = blk_rq_append_bio(rq, bio);
> --
> 2.30.2
>

--0000000000008fcffa05e3774745
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-block-convert-to-advancing-variants-of-iov_iter_get_.patch"
Content-Disposition: attachment; 
	filename="0001-block-convert-to-advancing-variants-of-iov_iter_get_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l5fmj4k00>
X-Attachment-Id: f_l5fmj4k00

RnJvbSA5YTY0NjkwNjAzMTY2NzQyMzBjMDY2NmM1NzA2ZjcwOTdlOTI3OGJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4KRGF0
ZTogVGh1LCA5IEp1biAyMDIyIDEwOjM3OjU3IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gYmxvY2s6
IGNvbnZlcnQgdG8gYWR2YW5jaW5nIHZhcmlhbnRzIG9mCiBpb3ZfaXRlcl9nZXRfcGFnZXN7LF9h
bGxvY30oKQoKLi4uIGRvaW5nIHJldmVydCBpZiB3ZSBlbmQgdXAgbm90IHVzaW5nIHNvbWUgcGFn
ZXMKClNpZ25lZC1vZmYtYnk6IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPgotLS0K
IGJsb2NrL2Jpby5jICAgICB8IDI1ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIGJsb2NrL2Js
ay1tYXAuYyB8ICA3ICsrKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmlvLmMgYi9ibG9jay9iaW8uYwpp
bmRleCAwODI0MzY3MzZkNjkuLmQzYmMwNWVkMDc4MyAxMDA2NDQKLS0tIGEvYmxvY2svYmlvLmMK
KysrIGIvYmxvY2svYmlvLmMKQEAgLTEyMDAsNyArMTIwMCw3IEBAIHN0YXRpYyBpbnQgX19iaW9f
aW92X2l0ZXJfZ2V0X3BhZ2VzKHN0cnVjdCBiaW8gKmJpbywgc3RydWN0IGlvdl9pdGVyICppdGVy
KQogCXN0cnVjdCBwYWdlICoqcGFnZXMgPSAoc3RydWN0IHBhZ2UgKiopYnY7CiAJc3NpemVfdCBz
aXplLCBsZWZ0OwogCXVuc2lnbmVkIGxlbiwgaTsKLQlzaXplX3Qgb2Zmc2V0OworCXNpemVfdCBv
ZmZzZXQsIHRyaW07CiAJaW50IHJldCA9IDA7CiAKIAkvKgpAQCAtMTIxOCwxNiArMTIxOCwxOSBA
QCBzdGF0aWMgaW50IF9fYmlvX2lvdl9pdGVyX2dldF9wYWdlcyhzdHJ1Y3QgYmlvICpiaW8sIHN0
cnVjdCBpb3ZfaXRlciAqaXRlcikKIAkgKiByZXN1bHQgdG8gZW5zdXJlIHRoZSBiaW8ncyB0b3Rh
bCBzaXplIGlzIGNvcnJlY3QuIFRoZSByZW1haW5kZXIgb2YKIAkgKiB0aGUgaW92IGRhdGEgd2ls
bCBiZSBwaWNrZWQgdXAgaW4gdGhlIG5leHQgYmlvIGl0ZXJhdGlvbi4KIAkgKi8KLQlzaXplID0g
aW92X2l0ZXJfZ2V0X3BhZ2VzKGl0ZXIsIHBhZ2VzLCBVSU5UX01BWCAtIGJpby0+YmlfaXRlci5i
aV9zaXplLAorCXNpemUgPSBpb3ZfaXRlcl9nZXRfcGFnZXMyKGl0ZXIsIHBhZ2VzLCBVSU5UX01B
WCAtIGJpby0+YmlfaXRlci5iaV9zaXplLAogCQkJCSAgbnJfcGFnZXMsICZvZmZzZXQpOwotCWlm
IChzaXplID4gMCkgewotCQlucl9wYWdlcyA9IERJVl9ST1VORF9VUChvZmZzZXQgKyBzaXplLCBQ
QUdFX1NJWkUpOwotCQlzaXplID0gQUxJR05fRE9XTihzaXplLCBiZGV2X2xvZ2ljYWxfYmxvY2tf
c2l6ZShiaW8tPmJpX2JkZXYpKTsKLQl9IGVsc2UKLQkJbnJfcGFnZXMgPSAwOwotCi0JaWYgKHVu
bGlrZWx5KHNpemUgPD0gMCkpIHsKLQkJcmV0ID0gc2l6ZSA/IHNpemUgOiAtRUZBVUxUOworCWlm
ICh1bmxpa2VseShzaXplIDw9IDApKQorCQlyZXR1cm4gc2l6ZSA/IHNpemUgOiAtRUZBVUxUOwor
CisJbnJfcGFnZXMgPSBESVZfUk9VTkRfVVAob2Zmc2V0ICsgc2l6ZSwgUEFHRV9TSVpFKTsKKwor
CXRyaW0gPSBzaXplICYgKGJkZXZfbG9naWNhbF9ibG9ja19zaXplKGJpby0+YmlfYmRldikgLSAx
KTsKKwlpb3ZfaXRlcl9yZXZlcnQoaXRlciwgdHJpbSk7CisKKwlzaXplIC09IHRyaW07CisJaWYg
KHVubGlrZWx5KCFzaXplKSkgeworCQlyZXQgPSAtRUZBVUxUOwogCQlnb3RvIG91dDsKIAl9CiAK
QEAgLTEyNDYsNyArMTI0OSw3IEBAIHN0YXRpYyBpbnQgX19iaW9faW92X2l0ZXJfZ2V0X3BhZ2Vz
KHN0cnVjdCBiaW8gKmJpbywgc3RydWN0IGlvdl9pdGVyICppdGVyKQogCQlvZmZzZXQgPSAwOwog
CX0KIAotCWlvdl9pdGVyX2FkdmFuY2UoaXRlciwgc2l6ZSAtIGxlZnQpOworCWlvdl9pdGVyX3Jl
dmVydChpdGVyLCBsZWZ0KTsKIG91dDoKIAl3aGlsZSAoaSA8IG5yX3BhZ2VzKQogCQlwdXRfcGFn
ZShwYWdlc1tpKytdKTsKZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tYXAuYyBiL2Jsb2NrL2Jsay1t
YXAuYwppbmRleCBkZjhiMDY2Y2Q1NDguLjcxOTZhNmI2NGM4MCAxMDA2NDQKLS0tIGEvYmxvY2sv
YmxrLW1hcC5jCisrKyBiL2Jsb2NrL2Jsay1tYXAuYwpAQCAtMjU0LDcgKzI1NCw3IEBAIHN0YXRp
YyBpbnQgYmlvX21hcF91c2VyX2lvdihzdHJ1Y3QgcmVxdWVzdCAqcnEsIHN0cnVjdCBpb3ZfaXRl
ciAqaXRlciwKIAkJc2l6ZV90IG9mZnMsIGFkZGVkID0gMDsKIAkJaW50IG5wYWdlczsKIAotCQli
eXRlcyA9IGlvdl9pdGVyX2dldF9wYWdlc19hbGxvYyhpdGVyLCAmcGFnZXMsIExPTkdfTUFYLCAm
b2Zmcyk7CisJCWJ5dGVzID0gaW92X2l0ZXJfZ2V0X3BhZ2VzX2FsbG9jMihpdGVyLCAmcGFnZXMs
IExPTkdfTUFYLCAmb2Zmcyk7CiAJCWlmICh1bmxpa2VseShieXRlcyA8PSAwKSkgewogCQkJcmV0
ID0gYnl0ZXMgPyBieXRlcyA6IC1FRkFVTFQ7CiAJCQlnb3RvIG91dF91bm1hcDsKQEAgLTI4NCw3
ICsyODQsNiBAQCBzdGF0aWMgaW50IGJpb19tYXBfdXNlcl9pb3Yoc3RydWN0IHJlcXVlc3QgKnJx
LCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsCiAJCQkJYnl0ZXMgLT0gbjsKIAkJCQlvZmZzID0gMDsK
IAkJCX0KLQkJCWlvdl9pdGVyX2FkdmFuY2UoaXRlciwgYWRkZWQpOwogCQl9CiAJCS8qCiAJCSAq
IHJlbGVhc2UgdGhlIHBhZ2VzIHdlIGRpZG4ndCBtYXAgaW50byB0aGUgYmlvLCBpZiBhbnkKQEAg
LTI5Myw4ICsyOTIsMTAgQEAgc3RhdGljIGludCBiaW9fbWFwX3VzZXJfaW92KHN0cnVjdCByZXF1
ZXN0ICpycSwgc3RydWN0IGlvdl9pdGVyICppdGVyLAogCQkJcHV0X3BhZ2UocGFnZXNbaisrXSk7
CiAJCWt2ZnJlZShwYWdlcyk7CiAJCS8qIGNvdWxkbid0IHN0dWZmIHNvbWV0aGluZyBpbnRvIGJp
bz8gKi8KLQkJaWYgKGJ5dGVzKQorCQlpZiAoYnl0ZXMpIHsKKwkJCWlvdl9pdGVyX3JldmVydChp
dGVyLCBieXRlcyk7CiAJCQlicmVhazsKKwkJfQogCX0KIAogCXJldCA9IGJsa19ycV9hcHBlbmRf
YmlvKHJxLCBiaW8pOwotLSAKMi4zNi4xCgo=
--0000000000008fcffa05e3774745--
