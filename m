Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C977EFCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 06:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347993AbjHQETp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 00:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbjHQETU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 00:19:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD54272D
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 21:19:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso9407575a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 21:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692245953; x=1692850753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jfkifynCzRafY3XbR1SksUBb+gadM/LILOU5DSScwMs=;
        b=d5XbRGfcFBw3RzLytstxp1COH8mGklyUnJoJpnLp1B+WmZwxxX9HYo/f9qxs228e3t
         JV18dt68/KXd8PmpaxUrD1qIVSAJwF70pe3dCu4WbkeuGuteb4rG0mlKIXhrGeHrFL00
         D2AVMTlpGxSI2Ey6wDDvqbTgMQC2wePpIcYrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692245953; x=1692850753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfkifynCzRafY3XbR1SksUBb+gadM/LILOU5DSScwMs=;
        b=EmPdGjx2YDMeI99ZWSEq6g/ycahukugi0ttLje2norAwLCGqSonRrOUKjWPDKzfkr7
         jrM6L1OPx5DjhyMeEiq26/2LiHFuH8tu8T+eMOTpM6KUhW27r+1EJJkJ1VG1aQ4Z4x2s
         X5oZqA037qfhV929AubGad+bITpJIR6Ib8A4US+1KQ1qJwYWr2N5EoDCK+EWC8UT2+BQ
         VFG/l/iHbJp1oitiNNckBilbI7QWQ54LFbY9iGlFIK549oWx+gshT7HJhsxV2l1dDB86
         qSYr8LgkVUrsrPWLLEnRAWammBbEC5r3+8vZeUc0dfO0Z10ayQKDl20AU+MU2mNibvq0
         EzBQ==
X-Gm-Message-State: AOJu0YwCZ2WTZz1gvMZlZfihINqmtICDd/r+7UYZO/+EFA1Wbc8aoe5r
        zVwIFCekHosRJeOzcWE1UPhKbaDjiPsIj6eFVy4T9BGv
X-Google-Smtp-Source: AGHT+IH/KVgdLruGE9nfcrTMe3zHxGtHUBGgdYB6g/pu/qVyxEpSmv0JlBloBaqT0MjbHsjsEq2fKQ==
X-Received: by 2002:a05:6402:545:b0:526:5c70:7311 with SMTP id i5-20020a056402054500b005265c707311mr764663edx.8.1692245953640;
        Wed, 16 Aug 2023 21:19:13 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402165900b0052568bf9411sm4537062edx.68.2023.08.16.21.19.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 21:19:10 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5231410ab27so9423626a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 21:19:10 -0700 (PDT)
X-Received: by 2002:aa7:c505:0:b0:51d:9db8:8257 with SMTP id
 o5-20020aa7c505000000b0051d9db88257mr3222687edq.30.1692245950059; Wed, 16 Aug
 2023 21:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com> <665724.1692218114@warthog.procyon.org.uk>
In-Reply-To: <665724.1692218114@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 06:18:53 +0200
X-Gmail-Original-Message-ID: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
Message-ID: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Howells <dhowells@redhat.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ba4113060316b66b"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000ba4113060316b66b
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Aug 2023 at 22:35, David Howells <dhowells@redhat.com> wrote:
>
> I'm not sure that buys us anything.  It would then require every call to
> iov_iter_is_bvec()[*] to check for two values instead of one

Well, that part is trivially fixable, and we should do that anyway for
other reasons.

See the attached patch.

> The issue is that ITER_xyz changes the iteration function - but we don't
> actually want to do that; rather, we need to change the step function.

Yeah, that may be the fundamental issue. But making the ITER_xyz flags
be bit masks would help - partly exactly because it makes it so
trivial yo say "for this set of ITER_xyz, do this".

This patch only does that for the 'user_backed' thing, which was a similar case.

Hmm?

               Linus

--000000000000ba4113060316b66b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_llenilwk0>
X-Attachment-Id: f_llenilwk0

IGRyaXZlcnMvaW5maW5pYmFuZC9ody9oZmkxL2ZpbGVfb3BzLmMgICAgfCAgMiArLQogZHJpdmVy
cy9pbmZpbmliYW5kL2h3L3FpYi9xaWJfZmlsZV9vcHMuYyB8ICAyICstCiBpbmNsdWRlL2xpbnV4
L3Vpby5oICAgICAgICAgICAgICAgICAgICAgIHwgMzYgKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0KIGxpYi9pb3ZfaXRlci5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAt
CiBzb3VuZC9jb3JlL3BjbV9uYXRpdmUuYyAgICAgICAgICAgICAgICAgIHwgIDQgKystLQogNSBm
aWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaGZpMS9maWxlX29wcy5jIGIvZHJpdmVycy9pbmZp
bmliYW5kL2h3L2hmaTEvZmlsZV9vcHMuYwppbmRleCBhNWFiMjJjZWRkNDEuLjc4OGZjMjQ5MjM0
ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2hmaTEvZmlsZV9vcHMuYworKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaGZpMS9maWxlX29wcy5jCkBAIC0yNjcsNyArMjY3LDcg
QEAgc3RhdGljIHNzaXplX3QgaGZpMV93cml0ZV9pdGVyKHN0cnVjdCBraW9jYiAqa2lvY2IsIHN0
cnVjdCBpb3ZfaXRlciAqZnJvbSkKIAogCWlmICghSEZJMV9DQVBfSVNfS1NFVChTRE1BKSkKIAkJ
cmV0dXJuIC1FSU5WQUw7Ci0JaWYgKCFmcm9tLT51c2VyX2JhY2tlZCkKKwlpZiAoIXVzZXJfYmFj
a2VkX2l0ZXIoZnJvbSkpCiAJCXJldHVybiAtRUlOVkFMOwogCWlkeCA9IHNyY3VfcmVhZF9sb2Nr
KCZmZC0+cHFfc3JjdSk7CiAJcHEgPSBzcmN1X2RlcmVmZXJlbmNlKGZkLT5wcSwgJmZkLT5wcV9z
cmN1KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX2ZpbGVfb3Bz
LmMgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvcWliL3FpYl9maWxlX29wcy5jCmluZGV4IGVmODVi
YzhkOTM4NC4uMDlhNmQ5MTIxYjNkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcv
cWliL3FpYl9maWxlX29wcy5jCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX2Zp
bGVfb3BzLmMKQEAgLTIyNDQsNyArMjI0NCw3IEBAIHN0YXRpYyBzc2l6ZV90IHFpYl93cml0ZV9p
dGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogCXN0cnVjdCBx
aWJfY3R4dGRhdGEgKnJjZCA9IGN0eHRfZnAoaW9jYi0+a2lfZmlscCk7CiAJc3RydWN0IHFpYl91
c2VyX3NkbWFfcXVldWUgKnBxID0gZnAtPnBxOwogCi0JaWYgKCFmcm9tLT51c2VyX2JhY2tlZCB8
fCAhZnJvbS0+bnJfc2VncyB8fCAhcHEpCisJaWYgKCF1c2VyX2JhY2tlZF9pdGVyKGZyb20pIHx8
ICFmcm9tLT5ucl9zZWdzIHx8ICFwcSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlyZXR1cm4gcWli
X3VzZXJfc2RtYV93cml0ZXYocmNkLCBwcSwgaXRlcl9pb3YoZnJvbSksIGZyb20tPm5yX3NlZ3Mp
OwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC91aW8uaCBiL2luY2x1ZGUvbGludXgvdWlvLmgK
aW5kZXggZmY4MWU1Y2NhZWYyLi4yMzBkYTk3YTQyZDUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGlu
dXgvdWlvLmgKKysrIGIvaW5jbHVkZS9saW51eC91aW8uaApAQCAtMjEsMTIgKzIxLDEyIEBAIHN0
cnVjdCBrdmVjIHsKIAogZW51bSBpdGVyX3R5cGUgewogCS8qIGl0ZXIgdHlwZXMgKi8KLQlJVEVS
X0lPVkVDLAotCUlURVJfS1ZFQywKLQlJVEVSX0JWRUMsCi0JSVRFUl9YQVJSQVksCi0JSVRFUl9E
SVNDQVJELAotCUlURVJfVUJVRiwKKwlJVEVSX0lPVkVDID0gMSwKKwlJVEVSX1VCVUYgPSAyLAor
CUlURVJfS1ZFQyA9IDQsCisJSVRFUl9CVkVDID0gOCwKKwlJVEVSX1hBUlJBWSA9IDE2LAorCUlU
RVJfRElTQ0FSRCA9IDMyLAogfTsKIAogI2RlZmluZSBJVEVSX1NPVVJDRQkxCS8vID09IFdSSVRF
CkBAIC0zOSwxMSArMzksMTAgQEAgc3RydWN0IGlvdl9pdGVyX3N0YXRlIHsKIH07CiAKIHN0cnVj
dCBpb3ZfaXRlciB7Ci0JdTggaXRlcl90eXBlOwotCWJvb2wgY29weV9tYzsKLQlib29sIG5vZmF1
bHQ7CisJdTgJaXRlcl90eXBlOjYsCisJCWNvcHlfbWM6MSwKKwkJbm9mYXVsdDoxOwogCWJvb2wg
ZGF0YV9zb3VyY2U7Ci0JYm9vbCB1c2VyX2JhY2tlZDsKIAl1bmlvbiB7CiAJCXNpemVfdCBpb3Zf
b2Zmc2V0OwogCQlpbnQgbGFzdF9vZmZzZXQ7CkBAIC04NSw3ICs4NCw3IEBAIHN0cnVjdCBpb3Zf
aXRlciB7CiAKIHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGlvdmVjICppdGVyX2lvdihjb25z
dCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCiB7Ci0JaWYgKGl0ZXItPml0ZXJfdHlwZSA9PSBJVEVS
X1VCVUYpCisJaWYgKGl0ZXItPml0ZXJfdHlwZSAmIElURVJfVUJVRikKIAkJcmV0dXJuIChjb25z
dCBzdHJ1Y3QgaW92ZWMgKikgJml0ZXItPl9fdWJ1Zl9pb3ZlYzsKIAlyZXR1cm4gaXRlci0+X19p
b3Y7CiB9CkBAIC0xMDgsMzIgKzEwNywzMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW92X2l0ZXJf
c2F2ZV9zdGF0ZShzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsCiAKIHN0YXRpYyBpbmxpbmUgYm9vbCBp
dGVyX2lzX3VidWYoY29uc3Qgc3RydWN0IGlvdl9pdGVyICppKQogewotCXJldHVybiBpb3ZfaXRl
cl90eXBlKGkpID09IElURVJfVUJVRjsKKwlyZXR1cm4gaW92X2l0ZXJfdHlwZShpKSAmIElURVJf
VUJVRjsKIH0KIAogc3RhdGljIGlubGluZSBib29sIGl0ZXJfaXNfaW92ZWMoY29uc3Qgc3RydWN0
IGlvdl9pdGVyICppKQogewotCXJldHVybiBpb3ZfaXRlcl90eXBlKGkpID09IElURVJfSU9WRUM7
CisJcmV0dXJuIGlvdl9pdGVyX3R5cGUoaSkgJiBJVEVSX0lPVkVDOwogfQogCiBzdGF0aWMgaW5s
aW5lIGJvb2wgaW92X2l0ZXJfaXNfa3ZlYyhjb25zdCBzdHJ1Y3QgaW92X2l0ZXIgKmkpCiB7Ci0J
cmV0dXJuIGlvdl9pdGVyX3R5cGUoaSkgPT0gSVRFUl9LVkVDOworCXJldHVybiBpb3ZfaXRlcl90
eXBlKGkpICYgSVRFUl9LVkVDOwogfQogCiBzdGF0aWMgaW5saW5lIGJvb2wgaW92X2l0ZXJfaXNf
YnZlYyhjb25zdCBzdHJ1Y3QgaW92X2l0ZXIgKmkpCiB7Ci0JcmV0dXJuIGlvdl9pdGVyX3R5cGUo
aSkgPT0gSVRFUl9CVkVDOworCXJldHVybiBpb3ZfaXRlcl90eXBlKGkpICYgSVRFUl9CVkVDOwog
fQogCiBzdGF0aWMgaW5saW5lIGJvb2wgaW92X2l0ZXJfaXNfZGlzY2FyZChjb25zdCBzdHJ1Y3Qg
aW92X2l0ZXIgKmkpCiB7Ci0JcmV0dXJuIGlvdl9pdGVyX3R5cGUoaSkgPT0gSVRFUl9ESVNDQVJE
OworCXJldHVybiBpb3ZfaXRlcl90eXBlKGkpICYgSVRFUl9ESVNDQVJEOwogfQogCiBzdGF0aWMg
aW5saW5lIGJvb2wgaW92X2l0ZXJfaXNfeGFycmF5KGNvbnN0IHN0cnVjdCBpb3ZfaXRlciAqaSkK
IHsKLQlyZXR1cm4gaW92X2l0ZXJfdHlwZShpKSA9PSBJVEVSX1hBUlJBWTsKKwlyZXR1cm4gaW92
X2l0ZXJfdHlwZShpKSAmIElURVJfWEFSUkFZOwogfQogCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVk
IGNoYXIgaW92X2l0ZXJfcncoY29uc3Qgc3RydWN0IGlvdl9pdGVyICppKQpAQCAtMTQzLDcgKzE0
Miw3IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgY2hhciBpb3ZfaXRlcl9ydyhjb25zdCBzdHJ1
Y3QgaW92X2l0ZXIgKmkpCiAKIHN0YXRpYyBpbmxpbmUgYm9vbCB1c2VyX2JhY2tlZF9pdGVyKGNv
bnN0IHN0cnVjdCBpb3ZfaXRlciAqaSkKIHsKLQlyZXR1cm4gaS0+dXNlcl9iYWNrZWQ7CisJcmV0
dXJuIGktPml0ZXJfdHlwZSAmIChJVEVSX0lPVkVDIHwgSVRFUl9VQlVGKTsKIH0KIAogLyoKQEAg
LTM3Niw3ICszNzUsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW92X2l0ZXJfdWJ1ZihzdHJ1Y3Qg
aW92X2l0ZXIgKmksIHVuc2lnbmVkIGludCBkaXJlY3Rpb24sCiAJKmkgPSAoc3RydWN0IGlvdl9p
dGVyKSB7CiAJCS5pdGVyX3R5cGUgPSBJVEVSX1VCVUYsCiAJCS5jb3B5X21jID0gZmFsc2UsCi0J
CS51c2VyX2JhY2tlZCA9IHRydWUsCiAJCS5kYXRhX3NvdXJjZSA9IGRpcmVjdGlvbiwKIAkJLnVi
dWYgPSBidWYsCiAJCS5jb3VudCA9IGNvdW50LApkaWZmIC0tZ2l0IGEvbGliL2lvdl9pdGVyLmMg
Yi9saWIvaW92X2l0ZXIuYwppbmRleCBlNGRjODA5ZDEwNzUuLjg1N2U2NjFkMTU1NCAxMDA2NDQK
LS0tIGEvbGliL2lvdl9pdGVyLmMKKysrIGIvbGliL2lvdl9pdGVyLmMKQEAgLTI5MCw3ICsyOTAs
NiBAQCB2b2lkIGlvdl9pdGVyX2luaXQoc3RydWN0IGlvdl9pdGVyICppLCB1bnNpZ25lZCBpbnQg
ZGlyZWN0aW9uLAogCQkuaXRlcl90eXBlID0gSVRFUl9JT1ZFQywKIAkJLmNvcHlfbWMgPSBmYWxz
ZSwKIAkJLm5vZmF1bHQgPSBmYWxzZSwKLQkJLnVzZXJfYmFja2VkID0gdHJ1ZSwKIAkJLmRhdGFf
c291cmNlID0gZGlyZWN0aW9uLAogCQkuX19pb3YgPSBpb3YsCiAJCS5ucl9zZWdzID0gbnJfc2Vn
cywKZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvcGNtX25hdGl2ZS5jIGIvc291bmQvY29yZS9wY21f
bmF0aXZlLmMKaW5kZXggOTVmYzU2ZTQwM2IxLi42NDJkY2VlYjgwZWUgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL2NvcmUvcGNtX25hdGl2ZS5jCisrKyBiL3NvdW5kL2NvcmUvcGNtX25hdGl2ZS5jCkBAIC0z
NTI3LDcgKzM1MjcsNyBAQCBzdGF0aWMgc3NpemVfdCBzbmRfcGNtX3JlYWR2KHN0cnVjdCBraW9j
YiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAlpZiAocnVudGltZS0+c3RhdGUgPT0gU05E
UlZfUENNX1NUQVRFX09QRU4gfHwKIAkgICAgcnVudGltZS0+c3RhdGUgPT0gU05EUlZfUENNX1NU
QVRFX0RJU0NPTk5FQ1RFRCkKIAkJcmV0dXJuIC1FQkFERkQ7Ci0JaWYgKCF0by0+dXNlcl9iYWNr
ZWQpCisJaWYgKCF1c2VyX2JhY2tlZF9pdGVyKHRvKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAJaWYg
KHRvLT5ucl9zZWdzID4gMTAyNCB8fCB0by0+bnJfc2VncyAhPSBydW50aW1lLT5jaGFubmVscykK
IAkJcmV0dXJuIC1FSU5WQUw7CkBAIC0zNTY3LDcgKzM1NjcsNyBAQCBzdGF0aWMgc3NpemVfdCBz
bmRfcGNtX3dyaXRldihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSkK
IAlpZiAocnVudGltZS0+c3RhdGUgPT0gU05EUlZfUENNX1NUQVRFX09QRU4gfHwKIAkgICAgcnVu
dGltZS0+c3RhdGUgPT0gU05EUlZfUENNX1NUQVRFX0RJU0NPTk5FQ1RFRCkKIAkJcmV0dXJuIC1F
QkFERkQ7Ci0JaWYgKCFmcm9tLT51c2VyX2JhY2tlZCkKKwlpZiAoIXVzZXJfYmFja2VkX2l0ZXIo
ZnJvbSkpCiAJCXJldHVybiAtRUlOVkFMOwogCWlmIChmcm9tLT5ucl9zZWdzID4gMTI4IHx8IGZy
b20tPm5yX3NlZ3MgIT0gcnVudGltZS0+Y2hhbm5lbHMgfHwKIAkgICAgIWZyYW1lX2FsaWduZWQo
cnVudGltZSwgaW92LT5pb3ZfbGVuKSkK
--000000000000ba4113060316b66b--
