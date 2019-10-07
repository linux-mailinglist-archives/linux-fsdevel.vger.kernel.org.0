Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E22CECA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 21:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfJGTVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 15:21:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38148 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfJGTVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:21:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so14937440ljj.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFolWvA8AaXdh9ZyhMpVCFlYfwdpykqAkgVuEEtjT4c=;
        b=DGDxvoHLenwBiT3keA12cf3qIdtGE8JgVYthwpOS6Y91simLELViZ2X9F16Wk/CPut
         BAEzKUfXIkWVWKJv76bYZYrGW05mS3cOGVy/wnB44wIxnCbAwtIfJjqV6sPfSQ3k4JjF
         WU9fdfY7Scd5Iwr0B/lpOCalbTk3zgbY8AmbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFolWvA8AaXdh9ZyhMpVCFlYfwdpykqAkgVuEEtjT4c=;
        b=T0oFoKcgaZWaLoW3Fk+VrtTMEkWyzwb/kKQWcVTo6QbxjsCzM6JjFJzUnboBkY7SEY
         4nekq6Uu5W7Kuuhl5gpesELKcVvMKPUcn+mjq2iRHvWIe1Rbc99GTSGkKDTOBKyv6Bfh
         HqfKTIuSWZ7pEYxfW46omXquqiLxqC779D29pRZzh7SmKqxX9MgsN+UVg7q2lhsBY/rz
         gbWvlDF1834UxDydqWwToOrOPdTT/X2Qbx+qqyfSxZu5ouNh1e+hYXxk2uY5aQfUUom4
         N+1Z8dMm/fUmkO0qkimkV6+cXiO4nWbVkG86qn5ek7Ek/nExYeHzNN+MdAmnkkNqDbQZ
         tUPA==
X-Gm-Message-State: APjAAAUWQ+b3CU0h+HhCW0JPvFm4njbNyN5zKWwq8/lDGE2RRTl16Snk
        0H00AKlJFpVi4BeislbgjAEYFKs4VBQ=
X-Google-Smtp-Source: APXvYqwYw2I6CnwJu1l9HCMcgmhgta58/Sq8oM835XemKaRqP04CdDxJje4uf2S88GnGKZlKuZUc/Q==
X-Received: by 2002:a2e:780d:: with SMTP id t13mr16989281ljc.251.1570476103444;
        Mon, 07 Oct 2019 12:21:43 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f6sm2967710lfl.78.2019.10.07.12.21.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:21:42 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r2so10079649lfn.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 12:21:42 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr17554989lfh.29.1570476102121;
 Mon, 07 Oct 2019 12:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net>
In-Reply-To: <20191006222046.GA18027@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 12:21:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
Message-ID: <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>,
        Michael Cree <mcree@orcon.net.nz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000323800059456f6b9"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000323800059456f6b9
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 6, 2019 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> this patch causes all my sparc64 emulations to stall during boot. It causes
> all alpha emulations to crash with [1a] and [1b] when booting from a virtual
> disk, and one of the xtensa emulations to crash with [2].

So I think your alpha emulation environment may be broken, because
Michael Cree reports that it works for him on real hardware, but he
does see the kernel unaligned count being high.

But regardless, this is my current fairly minimal patch that I think
should fix the unaligned issue, while still giving the behavior we
want on x86. I hope Al can do something nicer, but I think this is
"acceptable".

I'm running this now on x86, and I verified that x86-32 code
generation looks sane too, but it woudl be good to verify that this
makes the alignment issue go away on other architectures.

                Linus

--000000000000323800059456f6b9
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k1gswtlm0>
X-Attachment-Id: f_k1gswtlm0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaCB8IDIzICsrKysrKysrKysrKysrKysrKysr
KysKIGZzL3JlYWRkaXIuYyAgICAgICAgICAgICAgICAgICB8IDQ0ICsrLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9saW51eC91YWNjZXNzLmggICAgICAg
IHwgIDYgKysrKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDQ0IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaAppbmRleCAzNWMyMjVlZGUwZTQuLjYxZDkzZjA2
MmEzNiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaApAQCAtNzM0LDUgKzczNCwyOCBAQCBkbyB7CQkJ
CQkJCQkJCVwKIAlpZiAodW5saWtlbHkoX19ndV9lcnIpKSBnb3RvIGVycl9sYWJlbDsJCQkJCVwK
IH0gd2hpbGUgKDApCiAKKy8qCisgKiBXZSB3YW50IHRoZSB1bnNhZmUgYWNjZXNzb3JzIHRvIGFs
d2F5cyBiZSBpbmxpbmVkIGFuZCB1c2UKKyAqIHRoZSBlcnJvciBsYWJlbHMgLSB0aHVzIHRoZSBt
YWNybyBnYW1lcy4KKyAqLworI2RlZmluZSB1bnNhZmVfY29weV9sb29wKGRzdCwgc3JjLCBsZW4s
IHR5cGUsIGxhYmVsKQkJCVwKKwl3aGlsZSAobGVuID49IHNpemVvZih0eXBlKSkgewkJCQkJXAor
CQl1bnNhZmVfcHV0X3VzZXIoKih0eXBlICopc3JjLCh0eXBlIF9fdXNlciAqKWRzdCxsYWJlbCk7
CVwKKwkJZHN0ICs9IHNpemVvZih0eXBlKTsJCQkJCVwKKwkJc3JjICs9IHNpemVvZih0eXBlKTsJ
CQkJCVwKKwkJbGVuIC09IHNpemVvZih0eXBlKTsJCQkJCVwKKwl9CisKKyNkZWZpbmUgdW5zYWZl
X2NvcHlfdG9fdXNlcihfZHN0LF9zcmMsX2xlbixsYWJlbCkJCQlcCitkbyB7CQkJCQkJCQkJXAor
CWNoYXIgX191c2VyICpfX3VjdV9kc3QgPSAoX2RzdCk7CQkJCVwKKwljb25zdCBjaGFyICpfX3Vj
dV9zcmMgPSAoX3NyYyk7CQkJCQlcCisJc2l6ZV90IF9fdWN1X2xlbiA9IChfbGVuKTsJCQkJCVwK
Kwl1bnNhZmVfY29weV9sb29wKF9fdWN1X2RzdCwgX191Y3Vfc3JjLCBfX3VjdV9sZW4sIHU2NCwg
bGFiZWwpOwlcCisJdW5zYWZlX2NvcHlfbG9vcChfX3VjdV9kc3QsIF9fdWN1X3NyYywgX191Y3Vf
bGVuLCB1MzIsIGxhYmVsKTsJXAorCXVuc2FmZV9jb3B5X2xvb3AoX191Y3VfZHN0LCBfX3VjdV9z
cmMsIF9fdWN1X2xlbiwgdTE2LCBsYWJlbCk7CVwKKwl1bnNhZmVfY29weV9sb29wKF9fdWN1X2Rz
dCwgX191Y3Vfc3JjLCBfX3VjdV9sZW4sIHU4LCBsYWJlbCk7CVwKK30gd2hpbGUgKDApCisKICNl
bmRpZiAvKiBfQVNNX1g4Nl9VQUNDRVNTX0ggKi8KIApkaWZmIC0tZ2l0IGEvZnMvcmVhZGRpci5j
IGIvZnMvcmVhZGRpci5jCmluZGV4IDE5YmVhNTkxYzNmMS4uNmUyNjIzZTU3YjJlIDEwMDY0NAot
LS0gYS9mcy9yZWFkZGlyLmMKKysrIGIvZnMvcmVhZGRpci5jCkBAIC0yNyw1MyArMjcsMTMgQEAK
IC8qCiAgKiBOb3RlIHRoZSAidW5zYWZlX3B1dF91c2VyKCkgc2VtYW50aWNzOiB3ZSBnb3RvIGEK
ICAqIGxhYmVsIGZvciBlcnJvcnMuCi0gKgotICogQWxzbyBub3RlIGhvdyB3ZSB1c2UgYSAid2hp
bGUoKSIgbG9vcCBoZXJlLCBldmVuIHRob3VnaAotICogb25seSB0aGUgYmlnZ2VzdCBzaXplIG5l
ZWRzIHRvIGxvb3AuIFRoZSBjb21waWxlciAod2VsbCwKLSAqIGF0IGxlYXN0IGdjYykgaXMgc21h
cnQgZW5vdWdoIHRvIHR1cm4gdGhlIHNtYWxsZXIgc2l6ZXMKLSAqIGludG8ganVzdCBpZi1zdGF0
ZW1lbnRzLCBhbmQgdGhpcyB3YXkgd2UgZG9uJ3QgbmVlZCB0bwotICogY2FyZSB3aGV0aGVyICd1
NjQnIG9yICd1MzInIGlzIHRoZSBiaWdnZXN0IHNpemUuCi0gKi8KLSNkZWZpbmUgdW5zYWZlX2Nv
cHlfbG9vcChkc3QsIHNyYywgbGVuLCB0eXBlLCBsYWJlbCkgCQlcCi0Jd2hpbGUgKGxlbiA+PSBz
aXplb2YodHlwZSkpIHsJCQkJXAotCQl1bnNhZmVfcHV0X3VzZXIoZ2V0X3VuYWxpZ25lZCgodHlw
ZSAqKXNyYyksCVwKLQkJCSh0eXBlIF9fdXNlciAqKWRzdCwgbGFiZWwpOwkJXAotCQlkc3QgKz0g
c2l6ZW9mKHR5cGUpOwkJCQlcCi0JCXNyYyArPSBzaXplb2YodHlwZSk7CQkJCVwKLQkJbGVuIC09
IHNpemVvZih0eXBlKTsJCQkJXAotCX0KLQotLyoKLSAqIFdlIGF2b2lkIGRvaW5nIDY0LWJpdCBj
b3BpZXMgb24gMzItYml0IGFyY2hpdGVjdHVyZXMuIFRoZXkKLSAqIG1pZ2h0IGJlIGJldHRlciwg
YnV0IHRoZSBjb21wb25lbnQgbmFtZXMgYXJlIG1vc3RseSBzbWFsbCwKLSAqIGFuZCB0aGUgNjQt
Yml0IGNhc2VzIGNhbiBlbmQgdXAgYmVpbmcgbXVjaCBtb3JlIGNvbXBsZXggYW5kCi0gKiBwdXQg
bXVjaCBtb3JlIHJlZ2lzdGVyIHByZXNzdXJlIG9uIHRoZSBjb2RlLCBzbyBpdCdzIGxpa2VseQot
ICogbm90IHdvcnRoIHRoZSBwYWluIG9mIHVuYWxpZ25lZCBhY2Nlc3NlcyBldGMuCi0gKgotICog
U28gbGltaXQgdGhlIGNvcGllcyB0byAidW5zaWduZWQgbG9uZyIgc2l6ZS4gSSBkaWQgdmVyaWZ5
Ci0gKiB0aGF0IGF0IGxlYXN0IHRoZSB4ODYtMzIgY2FzZSBpcyBvayB3aXRob3V0IHRoaXMgbGlt
aXRpbmcsCi0gKiBidXQgSSB3b3JyeSBhYm91dCByYW5kb20gb3RoZXIgbGVnYWN5IDMyLWJpdCBj
YXNlcyB0aGF0Ci0gKiBtaWdodCBub3QgZG8gYXMgd2VsbC4KLSAqLwotI2RlZmluZSB1bnNhZmVf
Y29weV90eXBlKGRzdCwgc3JjLCBsZW4sIHR5cGUsIGxhYmVsKSBkbyB7CVwKLQlpZiAoc2l6ZW9m
KHR5cGUpIDw9IHNpemVvZih1bnNpZ25lZCBsb25nKSkJCVwKLQkJdW5zYWZlX2NvcHlfbG9vcChk
c3QsIHNyYywgbGVuLCB0eXBlLCBsYWJlbCk7CVwKLX0gd2hpbGUgKDApCi0KLS8qCi0gKiBDb3B5
IHRoZSBkaXJlbnQgbmFtZSB0byB1c2VyIHNwYWNlLCBhbmQgTlVMLXRlcm1pbmF0ZQotICogaXQu
IFRoaXMgc2hvdWxkIG5vdCBiZSBhIGZ1bmN0aW9uIGNhbGwsIHNpbmNlIHdlJ3JlIGRvaW5nCi0g
KiB0aGUgY29weSBpbnNpZGUgYSAidXNlcl9hY2Nlc3NfYmVnaW4vZW5kKCkiIHNlY3Rpb24uCiAg
Ki8KICNkZWZpbmUgdW5zYWZlX2NvcHlfZGlyZW50X25hbWUoX2RzdCwgX3NyYywgX2xlbiwgbGFi
ZWwpIGRvIHsJXAogCWNoYXIgX191c2VyICpkc3QgPSAoX2RzdCk7CQkJCVwKIAljb25zdCBjaGFy
ICpzcmMgPSAoX3NyYyk7CQkJCVwKIAlzaXplX3QgbGVuID0gKF9sZW4pOwkJCQkJXAotCXVuc2Fm
ZV9jb3B5X3R5cGUoZHN0LCBzcmMsIGxlbiwgdTY0LCBsYWJlbCk7CSAJXAotCXVuc2FmZV9jb3B5
X3R5cGUoZHN0LCBzcmMsIGxlbiwgdTMyLCBsYWJlbCk7CQlcCi0JdW5zYWZlX2NvcHlfdHlwZShk
c3QsIHNyYywgbGVuLCB1MTYsIGxhYmVsKTsJCVwKLQl1bnNhZmVfY29weV90eXBlKGRzdCwgc3Jj
LCBsZW4sIHU4LCAgbGFiZWwpOwkJXAotCXVuc2FmZV9wdXRfdXNlcigwLCBkc3QsIGxhYmVsKTsJ
CQkJXAorCXVuc2FmZV9wdXRfdXNlcigwLCBkc3QrbGVuLCBsYWJlbCk7CQkJXAorCXVuc2FmZV9j
b3B5X3RvX3VzZXIoZHN0LCBzcmMsIGxlbiwgbGFiZWwpOwkJXAogfSB3aGlsZSAoMCkKIAogCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaCBiL2luY2x1ZGUvbGludXgvdWFjY2Vz
cy5oCmluZGV4IGU0N2QwNTIyYTFmNC4uZDRlZTZlOTQyNTYyIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L3VhY2Nlc3MuaAorKysgYi9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaApAQCAtMzU1LDgg
KzM1NSwxMCBAQCBleHRlcm4gbG9uZyBzdHJubGVuX3Vuc2FmZV91c2VyKGNvbnN0IHZvaWQgX191
c2VyICp1bnNhZmVfYWRkciwgbG9uZyBjb3VudCk7CiAjaWZuZGVmIHVzZXJfYWNjZXNzX2JlZ2lu
CiAjZGVmaW5lIHVzZXJfYWNjZXNzX2JlZ2luKHB0cixsZW4pIGFjY2Vzc19vayhwdHIsIGxlbikK
ICNkZWZpbmUgdXNlcl9hY2Nlc3NfZW5kKCkgZG8geyB9IHdoaWxlICgwKQotI2RlZmluZSB1bnNh
ZmVfZ2V0X3VzZXIoeCwgcHRyLCBlcnIpIGRvIHsgaWYgKHVubGlrZWx5KF9fZ2V0X3VzZXIoeCwg
cHRyKSkpIGdvdG8gZXJyOyB9IHdoaWxlICgwKQotI2RlZmluZSB1bnNhZmVfcHV0X3VzZXIoeCwg
cHRyLCBlcnIpIGRvIHsgaWYgKHVubGlrZWx5KF9fcHV0X3VzZXIoeCwgcHRyKSkpIGdvdG8gZXJy
OyB9IHdoaWxlICgwKQorI2RlZmluZSB1bnNhZmVfb3Bfd3JhcChvcCwgZXJyKSBkbyB7IGlmICh1
bmxpa2VseShvcCkpIGdvdG8gZXJyOyB9IHdoaWxlICgwKQorI2RlZmluZSB1bnNhZmVfZ2V0X3Vz
ZXIoeCxwLGUpIHVuc2FmZV9vcF93cmFwKF9fZ2V0X3VzZXIoeCxwKSxlKQorI2RlZmluZSB1bnNh
ZmVfcHV0X3VzZXIoeCxwLGUpIHVuc2FmZV9vcF93cmFwKF9fcHV0X3VzZXIoeCxwKSxlKQorI2Rl
ZmluZSB1bnNhZmVfY29weV90b191c2VyKGQscyxsLGUpIHVuc2FmZV9vcF93cmFwKF9fY29weV90
b191c2VyKGQscyxsKSxlKQogc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHVzZXJfYWNjZXNz
X3NhdmUodm9pZCkgeyByZXR1cm4gMFVMOyB9CiBzdGF0aWMgaW5saW5lIHZvaWQgdXNlcl9hY2Nl
c3NfcmVzdG9yZSh1bnNpZ25lZCBsb25nIGZsYWdzKSB7IH0KICNlbmRpZgo=
--000000000000323800059456f6b9--
