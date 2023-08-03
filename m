Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03076EE89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjHCPqR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjHCPqQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:46:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA9E2690
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 08:46:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b962535808so16977851fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691077573; x=1691682373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MoBcdPCRF0XjTgUM5UPr0xqiAJMOpt5c2TYsrfgKub0=;
        b=IdyGn6BYXmKPfm91vysECDFly9PZjhmO/0Pha8RvsQLI8Kdsrr3UJMXLMsAsPdszxn
         6NwC8vWfRCwkQRhnyIAAo+kK83DpexZhmwTIhmoKYcBcfY9xkT7SRloiZsVJXrsIVFqp
         Od2OqBAVGgK1RMwFv5eCrhjRSqPUdAvw9SXv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691077573; x=1691682373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoBcdPCRF0XjTgUM5UPr0xqiAJMOpt5c2TYsrfgKub0=;
        b=MjqiD9pOefFwTnsd4cwMRcEdatWFGCUhT1SZtKPeAZnMbYotuEFsCUrN+XDLo3u3sZ
         lfaPDB740sm3KDJAyzmF1/2wmxFBiBHY5RvnekXzmnwM7R7Wi0K8kd7aCH66JdG1wN6x
         aHzpBeqGUiABpfpsl6t0gKIn1TIx8q6EobtmhUdUfG4BKxWTkhBD8qajHmh7c7GDR+cx
         UBSbnz5CuH7b4tJhe591DSifvorofUh01WVntBvMEANwxdIZ7KzbhF/RZ7gssMhzvTzI
         dXIth0ZQ6r/1G6F3w3+tR4UInYV/nZI7zgWdg6et71DGCtT5609JpZq0h278AXufISyT
         YqZQ==
X-Gm-Message-State: ABy/qLYYj8J4IMPLvexOM5nQBAWRhVHw+EmEyoOGd+2VqkfgoGdsQYeC
        YBvw3EGBDlmtwFDsz3y1l22CcTgU90rlBiHIrVbjsFTb
X-Google-Smtp-Source: APBJJlHaJk5QSNUQ5FpftiYS/jtFMTiFxa6jqefgr3Fm8ghHVB+TBFBU1XydO5iopymv3gC5vT17Mg==
X-Received: by 2002:a2e:86c8:0:b0:2b9:c676:434a with SMTP id n8-20020a2e86c8000000b002b9c676434amr7930298ljj.15.1691077573050;
        Thu, 03 Aug 2023 08:46:13 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e2e04000000b002b9b27cf729sm22926lju.52.2023.08.03.08.46.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 08:46:12 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so16539521fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 08:46:12 -0700 (PDT)
X-Received: by 2002:a2e:3c0e:0:b0:2b6:cdfb:d06a with SMTP id
 j14-20020a2e3c0e000000b002b6cdfbd06amr7765701lja.22.1691077571652; Thu, 03
 Aug 2023 08:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner> <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
 <20230803095311.ijpvhx3fyrbkasul@f>
In-Reply-To: <20230803095311.ijpvhx3fyrbkasul@f>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Aug 2023 08:45:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com>
Message-ID: <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f2f075060206ada9"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000f2f075060206ada9
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Aug 2023 at 02:53, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> So yes, atomics remain expensive on x86-64 even on a very moden uarch
> and their impact is measurable in a syscall like read.

Well, a patch like this should fix it.

I intentionally didn't bother with the alpha osf version of readdir,
because nobody cares, but I guess we could do this in the header too.

Or we could have split the FMODE_ATOMIC_POS bit into two, and had a
"ALWAYS" version and a regular version, but just having a
"fdget_dir()" made it simpler.

So this - together with just reverting commit 20ea1e7d13c1 ("file:
always lock position for FMODE_ATOMIC_POS") - *should* fix any
performance regression.

But I have not tested it at all. So....

                 Linus

--000000000000f2f075060206ada9
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lkvbwqay0>
X-Attachment-Id: f_lkvbwqay0

IGZzL3JlYWRkaXIuYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvcmVhZGRpci5jIGIvZnMvcmVhZGRpci5jCmluZGV4IGIyNjRjZTYwMTE0
ZC4uYTQzOTQ2ZDAyNmJhIDEwMDY0NAotLS0gYS9mcy9yZWFkZGlyLmMKKysrIGIvZnMvcmVhZGRp
ci5jCkBAIC0yNCw2ICsyNCwyNyBAQAogCiAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPgogCisv
KgorICogZmR7Z2V0LHB1dH1fZGlyKCkgaXMgbGlrZSBmZGdldF9wb3MoKSwgYnV0IGRvZXMgdGhl
CisgKiBsb2NraW5nIHVuY29uZGl0aW9uYWxseSwgc2luY2UgaXQncyBhIGNvcnJlY3RuZXNzIGlz
c3VlLAorICogbm90IGEgImZvbGxvdyBQT1NJWCIgaXNzdWUuCisgKgorICogcGlkZmRfZ2V0ZmQo
KSBjYW4gdmlvbGF0ZSB0aGUgUE9TSVggcnVsZXMgb3RoZXJ3aXNlLgorICovCitzdGF0aWMgaW5s
aW5lIHN0cnVjdCBmZCBmZGdldF9kaXIoaW50IGZkKQoreworCXVuc2lnbmVkIGxvbmcgdiA9IF9f
ZmRnZXQoZmQpOworCXN0cnVjdCBmaWxlICpmaWxlID0gKHN0cnVjdCBmaWxlICopKHYgJiB+Myk7
CisKKwlpZiAoZmlsZSkgeworCQl2IHw9IEZEUFVUX1BPU19VTkxPQ0s7CisJCW11dGV4X2xvY2so
JmZpbGUtPmZfcG9zX2xvY2spOworCX0KKwlyZXR1cm4gX190b19mZCh2KTsKK30KKworI2RlZmlu
ZSBmZHB1dF9kaXIoeCkgZmRwdXRfcG9zKHgpCisKIC8qCiAgKiBOb3RlIHRoZSAidW5zYWZlX3B1
dF91c2VyKCkgc2VtYW50aWNzOiB3ZSBnb3RvIGEKICAqIGxhYmVsIGZvciBlcnJvcnMuCkBAIC0x
ODEsNyArMjAyLDcgQEAgU1lTQ0FMTF9ERUZJTkUzKG9sZF9yZWFkZGlyLCB1bnNpZ25lZCBpbnQs
IGZkLAogCQlzdHJ1Y3Qgb2xkX2xpbnV4X2RpcmVudCBfX3VzZXIgKiwgZGlyZW50LCB1bnNpZ25l
ZCBpbnQsIGNvdW50KQogewogCWludCBlcnJvcjsKLQlzdHJ1Y3QgZmQgZiA9IGZkZ2V0X3Bvcyhm
ZCk7CisJc3RydWN0IGZkIGYgPSBmZGdldF9kaXIoZmQpOwogCXN0cnVjdCByZWFkZGlyX2NhbGxi
YWNrIGJ1ZiA9IHsKIAkJLmN0eC5hY3RvciA9IGZpbGxvbmVkaXIsCiAJCS5kaXJlbnQgPSBkaXJl
bnQKQEAgLTE5NCw3ICsyMTUsNyBAQCBTWVNDQUxMX0RFRklORTMob2xkX3JlYWRkaXIsIHVuc2ln
bmVkIGludCwgZmQsCiAJaWYgKGJ1Zi5yZXN1bHQpCiAJCWVycm9yID0gYnVmLnJlc3VsdDsKIAot
CWZkcHV0X3BvcyhmKTsKKwlmZHB1dF9kaXIoZik7CiAJcmV0dXJuIGVycm9yOwogfQogCkBAIC0y
NzksNyArMzAwLDcgQEAgU1lTQ0FMTF9ERUZJTkUzKGdldGRlbnRzLCB1bnNpZ25lZCBpbnQsIGZk
LAogCX07CiAJaW50IGVycm9yOwogCi0JZiA9IGZkZ2V0X3BvcyhmZCk7CisJZiA9IGZkZ2V0X2Rp
cihmZCk7CiAJaWYgKCFmLmZpbGUpCiAJCXJldHVybiAtRUJBREY7CiAKQEAgLTI5NSw3ICszMTYs
NyBAQCBTWVNDQUxMX0RFRklORTMoZ2V0ZGVudHMsIHVuc2lnbmVkIGludCwgZmQsCiAJCWVsc2UK
IAkJCWVycm9yID0gY291bnQgLSBidWYuY291bnQ7CiAJfQotCWZkcHV0X3BvcyhmKTsKKwlmZHB1
dF9kaXIoZik7CiAJcmV0dXJuIGVycm9yOwogfQogCkBAIC0zNjIsNyArMzgzLDcgQEAgU1lTQ0FM
TF9ERUZJTkUzKGdldGRlbnRzNjQsIHVuc2lnbmVkIGludCwgZmQsCiAJfTsKIAlpbnQgZXJyb3I7
CiAKLQlmID0gZmRnZXRfcG9zKGZkKTsKKwlmID0gZmRnZXRfZGlyKGZkKTsKIAlpZiAoIWYuZmls
ZSkKIAkJcmV0dXJuIC1FQkFERjsKIApAQCAtMzc5LDcgKzQwMCw3IEBAIFNZU0NBTExfREVGSU5F
MyhnZXRkZW50czY0LCB1bnNpZ25lZCBpbnQsIGZkLAogCQllbHNlCiAJCQllcnJvciA9IGNvdW50
IC0gYnVmLmNvdW50OwogCX0KLQlmZHB1dF9wb3MoZik7CisJZmRwdXRfZGlyKGYpOwogCXJldHVy
biBlcnJvcjsKIH0KIApAQCAtNDM5LDcgKzQ2MCw3IEBAIENPTVBBVF9TWVNDQUxMX0RFRklORTMo
b2xkX3JlYWRkaXIsIHVuc2lnbmVkIGludCwgZmQsCiAJCXN0cnVjdCBjb21wYXRfb2xkX2xpbnV4
X2RpcmVudCBfX3VzZXIgKiwgZGlyZW50LCB1bnNpZ25lZCBpbnQsIGNvdW50KQogewogCWludCBl
cnJvcjsKLQlzdHJ1Y3QgZmQgZiA9IGZkZ2V0X3BvcyhmZCk7CisJc3RydWN0IGZkIGYgPSBmZGdl
dF9kaXIoZmQpOwogCXN0cnVjdCBjb21wYXRfcmVhZGRpcl9jYWxsYmFjayBidWYgPSB7CiAJCS5j
dHguYWN0b3IgPSBjb21wYXRfZmlsbG9uZWRpciwKIAkJLmRpcmVudCA9IGRpcmVudApAQCAtNDUy
LDcgKzQ3Myw3IEBAIENPTVBBVF9TWVNDQUxMX0RFRklORTMob2xkX3JlYWRkaXIsIHVuc2lnbmVk
IGludCwgZmQsCiAJaWYgKGJ1Zi5yZXN1bHQpCiAJCWVycm9yID0gYnVmLnJlc3VsdDsKIAotCWZk
cHV0X3BvcyhmKTsKKwlmZHB1dF9kaXIoZik7CiAJcmV0dXJuIGVycm9yOwogfQogCkBAIC01MzAs
NyArNTUxLDcgQEAgQ09NUEFUX1NZU0NBTExfREVGSU5FMyhnZXRkZW50cywgdW5zaWduZWQgaW50
LCBmZCwKIAl9OwogCWludCBlcnJvcjsKIAotCWYgPSBmZGdldF9wb3MoZmQpOworCWYgPSBmZGdl
dF9kaXIoZmQpOwogCWlmICghZi5maWxlKQogCQlyZXR1cm4gLUVCQURGOwogCkBAIC01NDYsNyAr
NTY3LDcgQEAgQ09NUEFUX1NZU0NBTExfREVGSU5FMyhnZXRkZW50cywgdW5zaWduZWQgaW50LCBm
ZCwKIAkJZWxzZQogCQkJZXJyb3IgPSBjb3VudCAtIGJ1Zi5jb3VudDsKIAl9Ci0JZmRwdXRfcG9z
KGYpOworCWZkcHV0X2RpcihmKTsKIAlyZXR1cm4gZXJyb3I7CiB9CiAjZW5kaWYK
--000000000000f2f075060206ada9--
