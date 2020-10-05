Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED968283E47
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 20:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgJES0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 14:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgJES0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:26:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E1DC0613CE
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2020 11:26:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b22so12016414lfs.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2020 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jw8mbZfCh6JO2ak6cXCvlTgq6DIEQ2RIWunEMemss/E=;
        b=Z8iuKnpZHlJKJru1wpu+a3pvw9e6ct4po6P21TWBowM1HmE4S8JmpQbaZdL7CZI2zD
         kx455eVdDK3hkgvEm5YSDR/ymsl7gG7MAW66L7PmQNn7Qpv5lVFcvNnNnQRI2/DWO0rG
         yPafaq3w1HaMepYzGzDaHmUJvZQiFe+b4z80I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jw8mbZfCh6JO2ak6cXCvlTgq6DIEQ2RIWunEMemss/E=;
        b=RoOXN43E96Tk6nG2nzedyg5HK5pjX14mbSdAOyNYcWKGghrdeomKa+fOY4l6THTFJC
         phUGElfqA16Jem63OHABxIi6scf8wpGVB/O5zT3FmcKBk99rzIYM+I214lqRsER1ilSR
         6OXUVb8wg1iHofLUTURamTGq7pAw/fdGfWrfZaYZBAM3UVjRj7JE/6YGHxN0+A3FgZtV
         UhNsOzMH/xT2117W/+YsXBXK3hiwUo1WPW/i2ZkJUg7rJE1BdF+5q15cPau2/5y+lVAt
         py2B6maYqu/Ejh0qmRJWiyD0HjHys+rnORz/aBkK4FW+oeeL+hBA1vS6qwRlmLOaJSYV
         zrbA==
X-Gm-Message-State: AOAM530K+f69MiNVXAB6uZmaXCz+sRFQYR3C/NNizWx2Rcynw3CWX9pF
        vd9YtALG2WzO6bmhnb1zmoLgyJOWko2j3A==
X-Google-Smtp-Source: ABdhPJxYZPFj0sNSQe5B7qlfT+QcluTk6z/n1YUw8Ir6QhTQAk9ZhpLleyNUQBcLkc9b7DzYH8f3ow==
X-Received: by 2002:ac2:5c49:: with SMTP id s9mr242783lfp.14.1601922405769;
        Mon, 05 Oct 2020 11:26:45 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z8sm127881ljh.19.2020.10.05.11.26.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 11:26:44 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a5so2793557ljj.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2020 11:26:43 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr329424ljj.102.1601922403591;
 Mon, 05 Oct 2020 11:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201005121339.4063-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20201005121339.4063-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Oct 2020 11:26:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRkmMvm09+TJtbf+zNYyUB_J0-U=B0bzPte=j0hzPdAw@mail.gmail.com>
Message-ID: <CAHk-=wiRkmMvm09+TJtbf+zNYyUB_J0-U=B0bzPte=j0hzPdAw@mail.gmail.com>
Subject: Re: [PATCH v2] splice: fix premature end of input detection
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d3a66205b0f09f2c"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000d3a66205b0f09f2c
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 5, 2020 at 5:14 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> splice() from pipe should return 0 when there is no pipe writer. However,
> since commit a194dfe6e6f6f720 ("pipe: Rearrange sequence in pipe_write()
> to preallocate slot") started inserting empty pages, splice() from pipe
> also returns 0 when all ready buffers are empty pages.

Well... Only if you had writers that intentionally did that whole "no
valid data write" thing.

Which could be seen as a feature.

That said, if this actually broke some code, then we need to fix it -
but I really hate how you have that whole !pipe_empty() loop around
the empty buffers.

That case is very unlikely, and you have a loop with !pipe_empty()
*anyway* with the whole "goto refill". So the loop is completely
pointless.

Also, what if we have a packet pipe? Do we perhaps want to return at
packet boundaries? I don't think splice() has cared, so probably not,
but it's worth perhaps thinking about.

Anyway, I'd be a lot happier with the patch being structured something
like this instead.. UNTESTED

                Linus

--000000000000d3a66205b0f09f2c
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kfwv84010>
X-Attachment-Id: f_kfwv84010

IGZzL3NwbGljZS5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvc3BsaWNlLmMgYi9mcy9zcGxpY2UuYwpp
bmRleCBjM2QwMGRmYzczNDQuLmNlNzVhZWM1MjI3NCAxMDA2NDQKLS0tIGEvZnMvc3BsaWNlLmMK
KysrIGIvZnMvc3BsaWNlLmMKQEAgLTUyNiw2ICs1MjYsMjIgQEAgc3RhdGljIGludCBzcGxpY2Vf
ZnJvbV9waXBlX2ZlZWQoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwgc3RydWN0IHNwbGlj
ZV9kZXMKIAlyZXR1cm4gMTsKIH0KIAorLyogV2Uga25vdyB3ZSBoYXZlIGEgcGlwZSBidWZmZXIs
IGJ1dCBtYXliZSBpdCdzIGVtcHR5PyAqLworc3RhdGljIGlubGluZSBib29sIGVhdF9lbXB0eV9i
dWZmZXIoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSkKK3sKKwl1bnNpZ25lZCBpbnQgdGFp
bCA9IHBpcGUtPnRhaWw7CisJdW5zaWduZWQgaW50IG1hc2sgPSBwaXBlLT5yaW5nX3NpemUgLSAx
OworCXN0cnVjdCBwaXBlX2J1ZmZlciAqYnVmID0gJnBpcGUtPmJ1ZnNbdGFpbCAmIG1hc2tdOwor
CisJaWYgKHVubGlrZWx5KCFidWYtPmxlbikpIHsKKwkJcGlwZV9idWZfcmVsZWFzZShwaXBlLCBi
dWYpOworCQlwaXBlLT50YWlsID0gdGFpbCsxOworCQlyZXR1cm4gdHJ1ZTsKKwl9CisKKwlyZXR1
cm4gZmFsc2U7Cit9CisKIC8qKgogICogc3BsaWNlX2Zyb21fcGlwZV9uZXh0IC0gd2FpdCBmb3Ig
c29tZSBkYXRhIHRvIHNwbGljZSBmcm9tCiAgKiBAcGlwZToJcGlwZSB0byBzcGxpY2UgZnJvbQpA
QCAtNTQ1LDYgKzU2MSw3IEBAIHN0YXRpYyBpbnQgc3BsaWNlX2Zyb21fcGlwZV9uZXh0KHN0cnVj
dCBwaXBlX2lub2RlX2luZm8gKnBpcGUsIHN0cnVjdCBzcGxpY2VfZGVzCiAJaWYgKHNpZ25hbF9w
ZW5kaW5nKGN1cnJlbnQpKQogCQlyZXR1cm4gLUVSRVNUQVJUU1lTOwogCityZXBlYXQ6CiAJd2hp
bGUgKHBpcGVfZW1wdHkocGlwZS0+aGVhZCwgcGlwZS0+dGFpbCkpIHsKIAkJaWYgKCFwaXBlLT53
cml0ZXJzKQogCQkJcmV0dXJuIDA7CkBAIC01NjYsNiArNTgzLDkgQEAgc3RhdGljIGludCBzcGxp
Y2VfZnJvbV9waXBlX25leHQoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwgc3RydWN0IHNw
bGljZV9kZXMKIAkJcGlwZV93YWl0X3JlYWRhYmxlKHBpcGUpOwogCX0KIAorCWlmIChlYXRfZW1w
dHlfYnVmZmVyKHBpcGUpKQorCQlnb3RvIHJlcGVhdDsKKwogCXJldHVybiAxOwogfQogCg==
--000000000000d3a66205b0f09f2c--
