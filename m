Return-Path: <linux-fsdevel+bounces-2700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D57E794E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 07:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCF1B20FB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 06:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0E26AA5;
	Fri, 10 Nov 2023 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvatlZ5V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DC63C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 06:29:50 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCAC72AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:29:43 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9e623356d5dso42899766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 22:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699597782; x=1700202582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcmqyfHctpbw48XfAyn7aoh36QsCkGs4LisRC+Vd0PQ=;
        b=SvatlZ5Vu0ToV6Mm61UDd/NNU0derkBnX9CjoSFwHEwlRPGELGmveopGS7hos4FCaA
         cod06lDuR8VfCsNX4jnT8okMaEw7XzL9u6oZwuXvTqvbDgc2dHa798q9ifiEhGmINfBH
         wyARk04i31BVm/KSCghgn49nIUWBrzLLWzoyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597782; x=1700202582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcmqyfHctpbw48XfAyn7aoh36QsCkGs4LisRC+Vd0PQ=;
        b=ly4LCi9UP7ooy5lDVLx83GZQTCEouLeL8DCkLd2j8Ym3/0cO4KBrN5z/iL9knjctQk
         kO3oHmQo4Qneqmvk5XYBcgc4PTbImgldzIsaKkQx0limPT834/adySPrWOJPCa/ubTLh
         5VQ85+ozxKNkx58b9UKDHn1tv6NVf6ySKeyIvlHzY/of0XqTXtXxQh500oT9zjX1IMg7
         XCAL3GfxsD9iSkHlbtxRUd59jh5aO2F+j88PjsljiDiwF2JEvE+LcYLKtQHqbbuKlvXX
         2NSAZXcIKKG2q9ic+qN+JzssnnsvA2siRBj2X00hQlRn24K2YXBZB6fJDCoQTqWqXryP
         WOzw==
X-Gm-Message-State: AOJu0Yy5OUtxmCf2Jlk66qyUxd4ZN25R/tfmT0XJ9GRCaak0HU1E1HVD
	fZsg352MoUNzZCp5vUzq5sCEqzOPTcMWf6xvDHrNS3SE
X-Google-Smtp-Source: AGHT+IHTKjnBZ67ELpXkaBcsdWSdRa4PgCTGOxQdUGzvCR7ICBOB8WFlf+5TvbVM8n1PmNuIlBHjPg==
X-Received: by 2002:a17:907:60d6:b0:9b9:f980:8810 with SMTP id hv22-20020a17090760d600b009b9f9808810mr6891953ejc.34.1699595878356;
        Thu, 09 Nov 2023 21:57:58 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id tg13-20020a1709078dcd00b009e655c77a53sm194127ejc.132.2023.11.09.21.57.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 21:57:57 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54366784377so2674496a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 21:57:57 -0800 (PST)
X-Received: by 2002:a50:8e59:0:b0:543:5b61:6908 with SMTP id
 25-20020a508e59000000b005435b616908mr5746604edx.18.1699595876987; Thu, 09 Nov
 2023 21:57:56 -0800 (PST)
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
In-Reply-To: <20231110042041.GL1957730@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Nov 2023 21:57:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
Message-ID: <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000082c7ed0609c6008f"

--00000000000082c7ed0609c6008f
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Nov 2023 at 20:20, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         FWIW, on top of current #work.dcache2 the following delta might be worth
> looking into.  Not sure if it's less confusing that way, though - I'd been staring
> at that place for too long.  Code generation is slightly suboptimal with recent
> gcc, but only marginally so.

I doubt the pure ALU ops and a couple of extra conditional branches
(that _probably_ predict well) matter at all.

Especially since this is all after lockref_put_return() has done that
locked cmpxchg, which *is* expensive.

My main reaction is that we use hlist_bl_unhashed() for d_unhashed(),
and we *intentionally* make it separate from the actual unhasing:

 - ___d_drop() does the __hlist_bl_del()

 - but d_unhashed() does hlist_bl_unhashed(), which checks
d_hash.pprev == NULL, and that's done by __d_drop

We even have a comment about this:

 * ___d_drop doesn't mark dentry as "unhashed"
 * (dentry->d_hash.pprev will be LIST_POISON2, not NULL).

and we depend on this in __d_move(), which will unhash things
temporarily, but not mark things unhashed, because they get re-hashed
again. Same goes for __d_add().

Anyway, what I'm actually getting at in a roundabout way is that maybe
we should make D_UNHASHED be another flag in d_flags, and *not* use
that d_hash.pprev field, and that would allow us to combine even more
of these tests in dput(), because now pretty much *all* of those
"retain_dentry()" checks would be about d_flags bits.

Hmm? As it is, it has that odd combination of d_flags and that
d_unhashed() test, so it's testing two different fields.

Anyway, I really don't think it matters much, but since you brought up
the whole suboptimal code generation..

I tried to look at dput() code generation, and it doesn't look
horrendous as-is in your dcache2 branch.

If anything, the thing that hirs is the lockref_put_return() being
out-of-line even though this is basically the only caller, plus people
have pessimized the arch_spin_value_unlocked() implementation *again*,
so that it uses a volatile read, when the *WHOLE*POINT* of that
"VALUE" part of "value_unlocked()" is that we've already read the
value, and we should *not* re-read it.

Damn.

The bug seems to affect both the generic qspinlock code, and the
ticket-based one.

For the ticket based ones, it's PeterZ and commit 1bce11126d57
("asm-generic: ticket-lock: New generic ticket-based spinlock"), which
does

  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
  {
        return !arch_spin_is_locked(&lock);
  }

where we've got that "lock" value, but then it takes the address of
it, and uses arch_spin_is_locked() on it, so now it will force a flush
to memory, and then an READ_ONCE() on it.

And for the qspinlock code, we had a similar

  static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
  {
        return !atomic_read(&lock.val);
  }

thing, where it does 'atomic_read()' on the value it was passed as an argument.

Stupid, stupid. It's literally forcing a re-read of a value that is
guaranteed to be on stack.

I know this worked at some point, but that may have been many years
ago, since I haven't looked at this part of lockref code generation in
ages.

Anway, as a result now all the lockref functions will do silly "store
the old lockref value to memory, in order to read it again" dances in
that CMPXCHG_LOOP() loop.

It literally makes that whole "is this an unlocked value" function
completely pointless. The *whole* and only point was "look, I already
loaded the value from memory, is this *VALUE* unlocked.

Compared to that complete braindamage in the fast-path loop, the small
extra ALU ops in fast_dput() are nothing.

Peter - those functions are done exactly the wrong way around.
arch_spin_is_locked() should be implemented using
arch_spin_value_unlocked(), not this way around.

And the queued spinlocks should not do an atomic_read()of the argument
they get, they should just do "!lock.val.counter"

So something like this should fix lockref. ENTIRELY UNTESTED, except
now the code generation of lockref_put_return() looks much better,
without a pointless flush to the stack, and now it has no pointless
stack frame as a result.

Of course, it should probably be inlined, since it has only one user
(ok, two, since fast_dput() gets used twice), and that should make the
return value testing much better.

               Linus

--00000000000082c7ed0609c6008f
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_los7fhww0>
X-Attachment-Id: f_los7fhww0

IGluY2x1ZGUvYXNtLWdlbmVyaWMvcXNwaW5sb2NrLmggfCAgMiArLQogaW5jbHVkZS9hc20tZ2Vu
ZXJpYy9zcGlubG9jay5oICB8IDE3ICsrKysrKysrKy0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9h
c20tZ2VuZXJpYy9xc3BpbmxvY2suaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvcXNwaW5sb2NrLmgK
aW5kZXggOTk1NTEzZmEyNjkwLi4wNjU1YWE1YjU3YjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYXNt
LWdlbmVyaWMvcXNwaW5sb2NrLmgKKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9xc3BpbmxvY2su
aApAQCAtNzAsNyArNzAsNyBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIGludCBxdWV1ZWRfc3Bp
bl9pc19sb2NrZWQoc3RydWN0IHFzcGlubG9jayAqbG9jaykKICAqLwogc3RhdGljIF9fYWx3YXlz
X2lubGluZSBpbnQgcXVldWVkX3NwaW5fdmFsdWVfdW5sb2NrZWQoc3RydWN0IHFzcGlubG9jayBs
b2NrKQogewotCXJldHVybiAhYXRvbWljX3JlYWQoJmxvY2sudmFsKTsKKwlyZXR1cm4gIWxvY2su
dmFsLmNvdW50ZXI7CiB9CiAKIC8qKgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9z
cGlubG9jay5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9zcGlubG9jay5oCmluZGV4IGZkZmViY2Iw
NTBmNC4uYTM1ZWRhMGVjMmEyIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL3NwaW5s
b2NrLmgKKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9zcGlubG9jay5oCkBAIC02OCwxMSArNjgs
MTcgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGFyY2hfc3Bpbl91bmxvY2soYXJjaF9z
cGlubG9ja190ICpsb2NrKQogCXNtcF9zdG9yZV9yZWxlYXNlKHB0ciwgKHUxNil2YWwgKyAxKTsK
IH0KIAorc3RhdGljIF9fYWx3YXlzX2lubGluZSBpbnQgYXJjaF9zcGluX3ZhbHVlX3VubG9ja2Vk
KGFyY2hfc3BpbmxvY2tfdCBsb2NrKQoreworCXUzMiB2YWwgPSBsb2NrLmNvdW50ZXI7CisJcmV0
dXJuICgodmFsID4+IDE2KSA9PSAodmFsICYgMHhmZmZmKSk7Cit9CisKIHN0YXRpYyBfX2Fsd2F5
c19pbmxpbmUgaW50IGFyY2hfc3Bpbl9pc19sb2NrZWQoYXJjaF9zcGlubG9ja190ICpsb2NrKQog
ewotCXUzMiB2YWwgPSBhdG9taWNfcmVhZChsb2NrKTsKLQotCXJldHVybiAoKHZhbCA+PiAxNikg
IT0gKHZhbCAmIDB4ZmZmZikpOworCWFyY2hfc3BpbmxvY2tfdCB2YWw7CisJdmFsLmNvdW50ZXIg
PSBhdG9taWNfcmVhZChsb2NrKTsKKwlyZXR1cm4gIWFyY2hfc3Bpbl92YWx1ZV91bmxvY2tlZCh2
YWwpOwogfQogCiBzdGF0aWMgX19hbHdheXNfaW5saW5lIGludCBhcmNoX3NwaW5faXNfY29udGVu
ZGVkKGFyY2hfc3BpbmxvY2tfdCAqbG9jaykKQEAgLTgyLDExICs4OCw2IEBAIHN0YXRpYyBfX2Fs
d2F5c19pbmxpbmUgaW50IGFyY2hfc3Bpbl9pc19jb250ZW5kZWQoYXJjaF9zcGlubG9ja190ICps
b2NrKQogCXJldHVybiAoczE2KSgodmFsID4+IDE2KSAtICh2YWwgJiAweGZmZmYpKSA+IDE7CiB9
CiAKLXN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgaW50IGFyY2hfc3Bpbl92YWx1ZV91bmxvY2tlZChh
cmNoX3NwaW5sb2NrX3QgbG9jaykKLXsKLQlyZXR1cm4gIWFyY2hfc3Bpbl9pc19sb2NrZWQoJmxv
Y2spOwotfQotCiAjaW5jbHVkZSA8YXNtL3Fyd2xvY2suaD4KIAogI2VuZGlmIC8qIF9fQVNNX0dF
TkVSSUNfU1BJTkxPQ0tfSCAqLwo=
--00000000000082c7ed0609c6008f--

