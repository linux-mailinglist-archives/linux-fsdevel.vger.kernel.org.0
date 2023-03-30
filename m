Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3316D1142
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjC3VyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjC3VyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:54:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D210AA7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 14:54:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er13so41196896edb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680213249; x=1682805249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kR7tU9m2ZxkDsCCU2a72DyJf0cLVvSPPhJI2fPviDRI=;
        b=XMb2NdxQZEAc9eMyr8u6HcXc6CYUBLscHCKYV/Gba7s7wy8sXE3/deJEeUoGbQnplO
         BetPYmfLvF6IvQgEBvKlfmLCvQ0nkPv1qA/6Dl6GCRVHPRbjRUtXvxiOgamVxLWG4IHx
         um6q/PyuDwG6Q76UqOuY98fB7EmO3gCW2P9ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213249; x=1682805249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR7tU9m2ZxkDsCCU2a72DyJf0cLVvSPPhJI2fPviDRI=;
        b=PHuTij/GGrEhTClM3/GwCZySMVvU/biBgtbyLbiG0wTj5iqj3kz3RLIQjcSrrExq6J
         RNVKCS2Z0FbWpA2YbYiti+X/w6xGMlrD4JiC9QJrI7mlQlh7KFJKx3u73uy7fxE114fC
         mUTtdJwhifWtYQUay93xvkDRF69vrwd7X62MOFR4kAp+zJySlwZXwztdPnqIWJADvEUq
         8yctRMqTAavEII9G3+eswMPqvf3nzikn2b47trY/pYh9Vr4ZofwIDNJ+4tViiR4TZOdi
         o1KueDmTJdsIuXX1j8/j/p6dsl5NApN6BPtZbPnLR3RffqZ9SnBBhzMgh8xGviNvslZe
         qNzA==
X-Gm-Message-State: AAQBX9d0UK5w3pywodyeE7b84hLZB535zJyb8YaFwHHuA/n5SfVQ+byx
        noHfso//FiZL8f7tt1naAJkp55BSe9APwHXPm//574tC
X-Google-Smtp-Source: AKy350aBOxxv4hO6YE7bTU1MFyOz1mPCeuml9BfLQyoayT4Mn4d+J1U/LatavTBvXU5Scgi3x17pgg==
X-Received: by 2002:a17:906:801:b0:92e:efa:b9b4 with SMTP id e1-20020a170906080100b0092e0efab9b4mr29360872ejd.22.1680213249399;
        Thu, 30 Mar 2023 14:54:09 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a24-20020a509b58000000b005027d356613sm44945edj.63.2023.03.30.14.54.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 14:54:08 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id r11so82215140edd.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 14:54:08 -0700 (PDT)
X-Received: by 2002:a50:9f66:0:b0:502:227a:d0d9 with SMTP id
 b93-20020a509f66000000b00502227ad0d9mr11481270edf.2.1680213248124; Thu, 30
 Mar 2023 14:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230330164702.1647898-1-axboe@kernel.dk> <CAHk-=wgmGBCO9QnBhheQDOHu+6k+OGHGCjHyHm4J=snowkSupQ@mail.gmail.com>
 <de35d11d-bce7-e976-7372-1f2caf417103@kernel.dk>
In-Reply-To: <de35d11d-bce7-e976-7372-1f2caf417103@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Mar 2023 14:53:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC5OBj36LFKYRONF_B19iyuEjK2WQFJpyZ+-w39mEN-w@mail.gmail.com>
Message-ID: <CAHk-=wiC5OBj36LFKYRONF_B19iyuEjK2WQFJpyZ+-w39mEN-w@mail.gmail.com>
Subject: Re: [PATCHSET v6b 0/11] Turn single segment imports into ITER_UBUF
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: multipart/mixed; boundary="000000000000cd508505f8252107"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000cd508505f8252107
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 10:33=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> That said, there might be things to improve here. But that's a task
> for another time.

So I ended up looking at this, and funnily enough, the *compat*
version of the "copy iovec from user" is actually written to be a lot
more efficient than the "native" version.

The reason is that the compat version has to load the data one field
at a time anyway to do the conversion, so it open-codes the loop. And
it does it all using the efficient "user_access_begin()" etc, so it
generates good code.

In contrast, the native version just does a "copy_from_user()" and
then loops over the result to verify it. And that's actually pretty
horrid. Doing the open-coded loop that fetches and verifies the iov
entries one at a time should be much better.

I dunno. That's my gut feel, at least. And it may explain why your
"readv()" benchmark has "_copy_from_user()" much higher up than the
"read()" case.

Something like the attached *may* help.

Untested - I only checked the generated assembly to see that it seems
to be sane, but I might have done something stupid. I basically copied
the compat code, fixed it up for non-compat types, and then massaged
it a bit more.

                 Linus

--000000000000cd508505f8252107
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lfvnkorp0>
X-Attachment-Id: f_lfvnkorp0

IGxpYi9pb3ZfaXRlci5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2xpYi9pb3ZfaXRlci5jIGIvbGliL2lvdl9pdGVyLmMKaW5kZXggMjc0MDE0ZTRlYWZl
Li5lNzkzZDZjYTI5OWMgMTAwNjQ0Ci0tLSBhL2xpYi9pb3ZfaXRlci5jCisrKyBiL2xpYi9pb3Zf
aXRlci5jCkBAIC0xNzMxLDE4ICsxNzMxLDM1IEBAIHN0YXRpYyBpbnQgY29weV9jb21wYXRfaW92
ZWNfZnJvbV91c2VyKHN0cnVjdCBpb3ZlYyAqaW92LAogfQogCiBzdGF0aWMgaW50IGNvcHlfaW92
ZWNfZnJvbV91c2VyKHN0cnVjdCBpb3ZlYyAqaW92LAotCQljb25zdCBzdHJ1Y3QgaW92ZWMgX191
c2VyICp1dmVjLCB1bnNpZ25lZCBsb25nIG5yX3NlZ3MpCisJCWNvbnN0IHN0cnVjdCBpb3ZlYyBf
X3VzZXIgKnVpb3YsIHVuc2lnbmVkIGxvbmcgbnJfc2VncykKIHsKLQl1bnNpZ25lZCBsb25nIHNl
ZzsKKwlpbnQgcmV0ID0gLUVGQVVMVDsKIAotCWlmIChjb3B5X2Zyb21fdXNlcihpb3YsIHV2ZWMs
IG5yX3NlZ3MgKiBzaXplb2YoKnV2ZWMpKSkKKwlpZiAoIXVzZXJfYWNjZXNzX2JlZ2luKHVpb3Ys
IG5yX3NlZ3MgKiBzaXplb2YoKnVpb3YpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7Ci0JZm9yIChzZWcg
PSAwOyBzZWcgPCBucl9zZWdzOyBzZWcrKykgewotCQlpZiAoKHNzaXplX3QpaW92W3NlZ10uaW92
X2xlbiA8IDApCi0JCQlyZXR1cm4gLUVJTlZBTDsKLQl9CiAKLQlyZXR1cm4gMDsKKwlkbyB7CisJ
CXZvaWQgX191c2VyICpidWY7CisJCXNzaXplX3QgbGVuOworCisJCXVuc2FmZV9nZXRfdXNlcihs
ZW4sICZ1aW92LT5pb3ZfbGVuLCB1YWNjZXNzX2VuZCk7CisJCXVuc2FmZV9nZXRfdXNlcihidWYs
ICZ1aW92LT5pb3ZfYmFzZSwgdWFjY2Vzc19lbmQpOworCisJCS8qIGNoZWNrIGZvciBzaXplX3Qg
bm90IGZpdHRpbmcgaW4gc3NpemVfdCAuLiAqLworCQlpZiAodW5saWtlbHkobGVuIDwgMCkpIHsK
KwkJCXJldCA9IC1FSU5WQUw7CisJCQlnb3RvIHVhY2Nlc3NfZW5kOworCQl9CisJCWlvdi0+aW92
X2Jhc2UgPSBidWY7CisJCWlvdi0+aW92X2xlbiA9IGxlbjsKKworCQl1aW92Kys7IGlvdisrOwor
CX0gd2hpbGUgKC0tbnJfc2Vncyk7CisKKwlyZXQgPSAwOwordWFjY2Vzc19lbmQ6CisJdXNlcl9h
Y2Nlc3NfZW5kKCk7CisJcmV0dXJuIHJldDsKIH0KIAogc3RydWN0IGlvdmVjICppb3ZlY19mcm9t
X3VzZXIoY29uc3Qgc3RydWN0IGlvdmVjIF9fdXNlciAqdXZlYywKQEAgLTE3NjcsNyArMTc4NCw3
IEBAIHN0cnVjdCBpb3ZlYyAqaW92ZWNfZnJvbV91c2VyKGNvbnN0IHN0cnVjdCBpb3ZlYyBfX3Vz
ZXIgKnV2ZWMsCiAJCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKIAl9CiAKLQlpZiAoY29tcGF0
KQorCWlmICh1bmxpa2VseShjb21wYXQpKQogCQlyZXQgPSBjb3B5X2NvbXBhdF9pb3ZlY19mcm9t
X3VzZXIoaW92LCB1dmVjLCBucl9zZWdzKTsKIAllbHNlCiAJCXJldCA9IGNvcHlfaW92ZWNfZnJv
bV91c2VyKGlvdiwgdXZlYywgbnJfc2Vncyk7Cg==
--000000000000cd508505f8252107--
