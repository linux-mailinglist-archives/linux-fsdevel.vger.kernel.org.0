Return-Path: <linux-fsdevel+bounces-3453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A030B7F4E35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 18:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A69B20D6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F75B5B0;
	Wed, 22 Nov 2023 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lhar+GYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BE61B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 09:21:13 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a00c200782dso405850666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 09:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700673672; x=1701278472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UAX1e5rZEfgaG6yzW79sWZ5cflYPcFMxz77ezc6V0lg=;
        b=Lhar+GYhRpu4Wi9nfGJ7Ws+3PVRecnwR9c5Kbycrh9J+/z0u4uk52jx8UuvQ6Ke32G
         nWce7DDwMi7ik7Gyipddpai8ZRbkkrSU7+DCD5FNhdaGe1c6dpNuvVCcmXFI+CV4juwi
         k8qDs8/h/vehBKw5AE1+qDhkAm826ZgdIU6Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673672; x=1701278472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAX1e5rZEfgaG6yzW79sWZ5cflYPcFMxz77ezc6V0lg=;
        b=m2WUVZsb+p2ATZXSUlUNthmDR3pSSKPow6qIayGojd1ueAIO7CFwtvHVuK49nYr3yj
         IsFLjW7p1qhy7s4hVQKO5Uf/eTbCDcW3rZ6nmz1HkD9keaJ3RtKOZCkXR/K8eeUR6VNA
         2Rtw3Yha+k2CTOF7Ma6CbPFefoOg6z9PVV1YLyHy8XIM827SQirbU6oDUhJjI1b4SbpJ
         Z90UXdUxw55HHolId8SPjWZJ7Wh4vch2Si0nsl+9jOpjKGyaPiYSw/6smWWHAKYVhTkO
         gWhDRJ2dK2yU9cyBXUAK9rSnTJBSFMXWXg4odOUrTwf8/vQ+SGkUat7wgMdgucBbc7PO
         LVgQ==
X-Gm-Message-State: AOJu0Yx2DvyTDDgwnKW9v+WarXTWDT1NvDqbdEUte/2muKAf16eQ1E9u
	T5avsAvo0Q2Knq7emB+Y7IZ8A+j1n6YT0usSrCRBtw==
X-Google-Smtp-Source: AGHT+IHdyJu41muR4orKIGGtVZt19T8WX/DXZsGhDAo3nuHLLcSTJLs+rOiUo0NRNsClYH5pH6u3MQ==
X-Received: by 2002:a17:906:b81a:b0:a03:d6d0:a0c4 with SMTP id dv26-20020a170906b81a00b00a03d6d0a0c4mr1868571ejb.44.1700673671698;
        Wed, 22 Nov 2023 09:21:11 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id w22-20020a170906131600b009de11bcbbcasm6945488ejb.175.2023.11.22.09.21.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:21:10 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso15955a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 09:21:10 -0800 (PST)
X-Received: by 2002:aa7:dacd:0:b0:547:4d34:7696 with SMTP id
 x13-20020aa7dacd000000b005474d347696mr2030726eds.21.1700673670358; Wed, 22
 Nov 2023 09:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031061226.GC1957730@ZenIV> <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk> <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com> <ZV2rdE1XQWwJ7s75@gmail.com>
In-Reply-To: <ZV2rdE1XQWwJ7s75@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Nov 2023 09:20:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
Message-ID: <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000005a07060ac0f22c"

--000000000000005a07060ac0f22c
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Nov 2023 at 23:19, Guo Ren <guoren@kernel.org> wrote:
>
> We discussed x86 qspinlock code generation. It looked not too bad as I
> thought because qspinlock_spin_value_unlocked is much cheaper than the
> ticket-lock. But the riscv ticket-lock code generation is terrible
> because of the shift left & right 16-bit.
> https://lore.kernel.org/all/ZNG2tHFOABSXGCVi@gmail.com

No, it's not the 16-bit shifts in the spin_value_unlocked() check,
that just generates simple and straightforward code:

  a0:   0107569b                srlw    a3,a4,0x10
  a4:   00c77733                and     a4,a4,a2
  a8:   04e69063                bne     a3,a4,e8 <.L12>

(plus two stupid instructions for generating the immediate in a2 for
0xffff, but hey, that's the usual insane RISC-V encoding thing - you
can load a 20-bit U-immediate only shifted up by 12, if it's in the
lower bits you're kind of screwed and limited to 12-bit immediates).

The *bad* code generation is from the much simpler

        new.count++;

which sadly neither gcc not clang is quite smart enough to understand
that "hey, I can do that in 64 bits".

It's incrementing the higher 32-bit word in a 64-bit union, and with a
smarter compiler it *should* basically become

        lock_count += 1 << 32;

but the compiler isn't that clever, so it splits the 64-bit word into
two 32-bit words, increments one of them, and then merges the two
words back into 64 bits:

  98:   4207d693                sra     a3,a5,0x20
  9c:   02079713                sll     a4,a5,0x20
  a0:   0016869b                addw    a3,a3,1
  a4:   02069693                sll     a3,a3,0x20
  a8:   02075713                srl     a4,a4,0x20
  ac:   00d76733                or      a4,a4,a3

which is pretty sad.

If you want to do the optimization that the compiler misses by hand,
it would be something like the attached patch.

NOTE! Very untested. But that *should* cause the compiler to just
generate a single "add" instruction (in addition to generating the
constant 0x100000000, of course).

Of course, on a LL/SC architecture like RISC-V, in an *optimal* world,
the whole sequence would actually be done with one single LL/SC,
rather than the "load,add,cmpxchg" thing.

But then you'd have to do absolutely everything by hand in assembly.

                  Linus

--000000000000005a07060ac0f22c
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lpa0uerf0>
X-Attachment-Id: f_lpa0uerf0

IGxpYi9sb2NrcmVmLmMgfCAxNyArKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGliL2xvY2tyZWYu
YyBiL2xpYi9sb2NrcmVmLmMKaW5kZXggMmFmZTRjNWQ4OTE5Li40ODFiMTAyYTY0NzYgMTAwNjQ0
Ci0tLSBhL2xpYi9sb2NrcmVmLmMKKysrIGIvbGliL2xvY2tyZWYuYwpAQCAtMjYsNiArMjYsMTcg
QEAKIAl9CQkJCQkJCQkJXAogfSB3aGlsZSAoMCkKIAorLyoKKyAqIFRoZSBjb21waWxlciBpc24n
dCBzbWFydCBlbm91Z2ggdG8gdGhlIHRoZSBjb3VudAorICogaW5jcmVtZW50IGluIHRoZSBoaWdo
IDMyIGJpdHMgb2YgdGhlIDY0LWJpdCB2YWx1ZSwKKyAqIHNvIGRvIHRoaXMgb3B0aW1pemF0aW9u
IGJ5IGhhbmQuCisgKi8KKyNpZiBkZWZpbmVkKF9fTElUVExFX0VORElBTikgJiYgQklUU19QRVJf
TE9ORyA9PSA2NAorICNkZWZpbmUgTE9DS1JFRl9JTkMobikgKChuKS5sb2NrX2NvdW50ICs9IDF1
bDw8MzIpCisjZWxzZQorICNkZWZpbmUgTE9DS1JFRl9JTkMobikgKChuKS5jb3VudCsrKQorI2Vu
ZGlmCisKICNlbHNlCiAKICNkZWZpbmUgQ01QWENIR19MT09QKENPREUsIFNVQ0NFU1MpIGRvIHsg
fSB3aGlsZSAoMCkKQEAgLTQyLDcgKzUzLDcgQEAKIHZvaWQgbG9ja3JlZl9nZXQoc3RydWN0IGxv
Y2tyZWYgKmxvY2tyZWYpCiB7CiAJQ01QWENIR19MT09QKAotCQluZXcuY291bnQrKzsKKwkJTE9D
S1JFRl9JTkMobmV3KTsKIAksCiAJCXJldHVybjsKIAkpOwpAQCAtNjMsNyArNzQsNyBAQCBpbnQg
bG9ja3JlZl9nZXRfbm90X3plcm8oc3RydWN0IGxvY2tyZWYgKmxvY2tyZWYpCiAJaW50IHJldHZh
bDsKIAogCUNNUFhDSEdfTE9PUCgKLQkJbmV3LmNvdW50Kys7CisJCUxPQ0tSRUZfSU5DKG5ldyk7
CiAJCWlmIChvbGQuY291bnQgPD0gMCkKIAkJCXJldHVybiAwOwogCSwKQEAgLTE3NCw3ICsxODUs
NyBAQCBpbnQgbG9ja3JlZl9nZXRfbm90X2RlYWQoc3RydWN0IGxvY2tyZWYgKmxvY2tyZWYpCiAJ
aW50IHJldHZhbDsKIAogCUNNUFhDSEdfTE9PUCgKLQkJbmV3LmNvdW50Kys7CisJCUxPQ0tSRUZf
SU5DKG5ldyk7CiAJCWlmIChvbGQuY291bnQgPCAwKQogCQkJcmV0dXJuIDA7CiAJLAo=
--000000000000005a07060ac0f22c--

