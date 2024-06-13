Return-Path: <linux-fsdevel+bounces-21579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 463CE90605E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 03:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B923F1F22381
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 01:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6018D534;
	Thu, 13 Jun 2024 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WYNxuXo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C46FC3
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 01:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241822; cv=none; b=sGCctTMJNAoEtA+9UT+m/11bmrmKFVicaiWr3/r2b72nzdaWoMhej3kw0x5vrmj7LERdcoF/Xf77L2mIpfhbGCf29sOK7C6FwSiTcbwgzkzmEkMCsKd40LEvJHX59SfDomIDbAg0kTBIlZs+Z4OuMtNMzgFyRMuOz869U+06eRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241822; c=relaxed/simple;
	bh=X3gTgy/Iz8ikW8DHOYtGWGNub2BUS0X96bT3zDguhCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njg4t6trBXw34w5lXxB6hogfwovOahqZrw7+DKyp9UocR/2Ko9yycSLG7cgYGbceK45X8eXHAHhtRgD/frH+xKsPHrJ6QqGd80TzDa1D2hvPCtQn842x/Q3BJJ53nplOUyVo51szXxQZism0N7R4o3Q+mXUuh0HuVsUBndtLOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WYNxuXo/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bbf73f334so703652e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718241818; x=1718846618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/kwsnoySuK+lTrV2lby34gpq8HpYhI6IyK65Moq3Wr8=;
        b=WYNxuXo/c2E72jLx6aWM6y6cFhT34IYJcUQP1FBtCwULhXxy4Z7wK5V+mNW/j6zVFI
         j1YAXXIPyuwlXodmopIRnBCLutVfDH1PZRUfTbHEHnZcq9PowNNLcYT9pPqAhARYz6V2
         CFZT4d6GDxRt/IPtbdrCBH12r8OQUD6/CV92w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718241818; x=1718846618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kwsnoySuK+lTrV2lby34gpq8HpYhI6IyK65Moq3Wr8=;
        b=uu7ZLXGE/BNur3SD1viJ5UttJW5zcbCyz1HkrX6HIPovZMbRbASYTpyzJ6cAlIyK8V
         KAZ5taliXY0sy4L3r8C5EExjSnRwLv5UApAHWv0SmDCaN+fyh+MvjNpOksj+Qt4ar1fD
         jlAIZ2FoIwHpb7AWe2H0aVWZE1XKUCDxoIxu+x84SrtkbwfKe+PQLu8Ke5dEMd+sp1Ao
         /t3g148a8tlCoByz31QmYQjoj1EdKiq6jzc0IHfi++j3sSbfIAXDUZn0PWvftIUEm8vE
         H5rRBJ6/AK57O9gOnegIrhvco7xjb0KERJV5zef6zaz9nbc342thCRpA6wByffa4H0ho
         Wj8g==
X-Forwarded-Encrypted: i=1; AJvYcCUndIAE7Yrl+w15j4j1RIPr9Wo9CP/C3ekLmfgsg5n4ftukxruLmeWN+9TQx9rU5+PeB72UIo25U2a8Dc1SyviJNkmXOOD80ZvXxDmaHA==
X-Gm-Message-State: AOJu0YzzVSAlhTywq7IzTRTI7HkqNEeaTma4ub2G1Q4Jv9CaT7Md5dXn
	Zs6ZktuIjDongD9qyfk3aLLxFwXT8IyoYdfWTOyk+DpA37J+UER7sJBuFYyOWE7bRvYzhRDEl8q
	Hm7TSWA==
X-Google-Smtp-Source: AGHT+IGSEmKCLM1OaEYPFrOfpngc9iDMPhiBmLpcU0MZuXbwLD+e2cb5JXG4+xPxqXdLx0z82JdWdQ==
X-Received: by 2002:a05:6512:749:b0:52c:9896:510c with SMTP id 2adb3069b0e04-52c9a3c75dbmr1688702e87.17.1718241817746;
        Wed, 12 Jun 2024 18:23:37 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2871f87sm39936e87.123.2024.06.12.18.23.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 18:23:35 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso4450381fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 18:23:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVx8iCl25KA81BzL7o6CZa0E6A0KaZ+7G+pz3fn+Gmk4SzFqyEmAWvJ3kWRQjapB5vF6dXHHT5HlJIVdh+c6YbCBTrxqsWn1CyNOd95KA==
X-Received: by 2002:a2e:a454:0:b0:2eb:e365:f191 with SMTP id
 38308e7fff4ca-2ebfc9327c1mr19669261fa.15.1718241815089; Wed, 12 Jun 2024
 18:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
In-Reply-To: <20240613001215.648829-2-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 18:23:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
Message-ID: <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000007a12d061abb598e"

--00000000000007a12d061abb598e
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 17:12, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> While I did not try to figure out who transiently took the lock (it was
> something outside of the benchmark), I devised a trivial reproducer
> which triggers the problem almost every time: merely issue "ls" of the
> directory containing the tested file (in this case: "ls /tmp").

So I have no problem with your patch 2/2 - moving the lockref data
structure away from everything else that can be shared read-only makes
a ton of sense independently of anything else.

Except you also randomly increased a retry count in there, which makes no sense.

But this patch 1/2 makes me go "Eww, hacky hacky".

We already *have* the retry loop, it's just that currently it only
covers the cmpxchg failures.

The natural thing to do is to just make the "wait for unlocked" be
part of the same loop.

In fact, I have this memory of trying this originally, and it not
mattering and just making the code uglier, but that may be me
confusing myself. It's a *loong* time ago.

With the attached patch, lockref_get() (to pick one random case) ends
up looking like this:

        mov    (%rdi),%rax
        mov    $0x64,%ecx
  loop:
        test   %eax,%eax
        jne    locked
        mov    %rax,%rdx
        sar    $0x20,%rdx
        add    $0x1,%edx
        shl    $0x20,%rdx
        lock cmpxchg %rdx,(%rdi)
        jne    fail
        // SUCCESS
        ret
  locked:
        pause
        mov    (%rdi),%rax
  fail:
        sub    $0x1,%ecx
        jne    loop

(with the rest being the "take lock and go slow" case).

It seems much better to me to have *one* retry loop that handles both
the causes of failures.

Entirely untested, I only looked at the generated code and it looked
reasonable. The patch may be entirely broken for some random reason I
didn't think of.

And in case you wonder, that 'lockref_locked()' macro I introduce is
purely to make the code more readable. Without it, that one
conditional line ends up being insanely long, the macro is there just
to break things up into slightly more manageable chunks.

Mind testing this approach instead?

                 Linus

--00000000000007a12d061abb598e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lxckssrl0>
X-Attachment-Id: f_lxckssrl0

IGxpYi9sb2NrcmVmLmMgfCAxNCArKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGliL2xvY2tyZWYuYyBi
L2xpYi9sb2NrcmVmLmMKaW5kZXggMmFmZTRjNWQ4OTE5Li43MGYzODYyMTkwMWIgMTAwNjQ0Ci0t
LSBhL2xpYi9sb2NrcmVmLmMKKysrIGIvbGliL2xvY2tyZWYuYwpAQCAtNCw2ICs0LDkgQEAKIAog
I2lmIFVTRV9DTVBYQ0hHX0xPQ0tSRUYKIAorI2RlZmluZSBsb2NrcmVmX2xvY2tlZChsKSBcCisJ
dW5saWtlbHkoIWFyY2hfc3Bpbl92YWx1ZV91bmxvY2tlZCgobCkubG9jay5ybG9jay5yYXdfbG9j
aykpCisKIC8qCiAgKiBOb3RlIHRoYXQgdGhlICJjbXB4Y2hnKCkiIHJlbG9hZHMgdGhlICJvbGQi
IHZhbHVlIGZvciB0aGUKICAqIGZhaWx1cmUgY2FzZS4KQEAgLTEzLDcgKzE2LDEyIEBACiAJc3Ry
dWN0IGxvY2tyZWYgb2xkOwkJCQkJCQlcCiAJQlVJTERfQlVHX09OKHNpemVvZihvbGQpICE9IDgp
OwkJCQkJCVwKIAlvbGQubG9ja19jb3VudCA9IFJFQURfT05DRShsb2NrcmVmLT5sb2NrX2NvdW50
KTsJCQlcCi0Jd2hpbGUgKGxpa2VseShhcmNoX3NwaW5fdmFsdWVfdW5sb2NrZWQob2xkLmxvY2su
cmxvY2sucmF3X2xvY2spKSkgeyAgCVwKKwlkbyB7CQkJCQkJCQkJXAorCQlpZiAobG9ja3JlZl9s
b2NrZWQob2xkKSkgewkJCQkJXAorCQkJY3B1X3JlbGF4KCk7CQkJCQkJXAorCQkJb2xkLmxvY2tf
Y291bnQgPSBSRUFEX09OQ0UobG9ja3JlZi0+bG9ja19jb3VudCk7CVwKKwkJCWNvbnRpbnVlOwkJ
CQkJCVwKKwkJfQkJCQkJCQkJXAogCQlzdHJ1Y3QgbG9ja3JlZiBuZXcgPSBvbGQ7CQkJCQlcCiAJ
CUNPREUJCQkJCQkJCVwKIAkJaWYgKGxpa2VseSh0cnlfY21weGNoZzY0X3JlbGF4ZWQoJmxvY2ty
ZWYtPmxvY2tfY291bnQsCQlcCkBAIC0yMSw5ICsyOSw3IEBACiAJCQkJCQkgbmV3LmxvY2tfY291
bnQpKSkgewkJXAogCQkJU1VDQ0VTUzsJCQkJCQlcCiAJCX0JCQkJCQkJCVwKLQkJaWYgKCEtLXJl
dHJ5KQkJCQkJCQlcCi0JCQlicmVhazsJCQkJCQkJXAotCX0JCQkJCQkJCQlcCisJfSB3aGlsZSAo
LS1yZXRyeSk7CQkJCQkJCVwKIH0gd2hpbGUgKDApCiAKICNlbHNlCg==
--00000000000007a12d061abb598e--

