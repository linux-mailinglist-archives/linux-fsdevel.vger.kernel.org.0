Return-Path: <linux-fsdevel+bounces-11914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F082859152
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A38E1F2262F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4AA7D41D;
	Sat, 17 Feb 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bi/uAqOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105587AE53
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708191042; cv=none; b=Aihm/A0Oz5BB7e0PbRQzpaM0C/mvSkmPiLfcgNcyQyu84Xlugx8TxPm+7Fg/ArdLvZmHWeVPr5plT441jW4MmniprJMQJ/r7m5z1lDEQ6/uA/0/COQHLM5oOR9y+JjdBq92fDPjCBpbrt7bIdReu1ZKz3yHLuC4m8VOxdPhvltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708191042; c=relaxed/simple;
	bh=LOja8kO+bPgcB2Z5JPm57hcLqR13vkicDYpY8Et/VPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYjnN7QvZ4280s4Iv8TjHkg1shr3ZEb6SSTMLiT6SZwgKHM+TXdDvYV7kWZTCzhx0xknJyeaIbavJR0aqzdD6+F8x1AaN2MBdm0MOyVs6dp9ZDc7acogtr/x4Gw8/is5KHYTVYxNuYP5zTDG6qKrQpK4eBliDhJ5spTMD4FqYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bi/uAqOs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso1795155a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708191038; x=1708795838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ENEM+0IcfLn+I5LWe/2ZiZiMPVjMKDHJxRm8IC5b5Y=;
        b=Bi/uAqOs5rlo1Wqn+5Vo1UAeGQIbnadGPRREJPWjBcqPI9bk7wmPqq8RBkdb6eg+BA
         r5BvIoccnRtNDWJy8STysZIGKWp9GVDdx+I14K+6y9PPk8jkBN9noETfUuH6v7bHKNQA
         xX0znxMAE1DdcpQKnV4gfbJTJ/StDKQ/yt6XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708191038; x=1708795838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ENEM+0IcfLn+I5LWe/2ZiZiMPVjMKDHJxRm8IC5b5Y=;
        b=uzlEGHl1g4XxAPUoMdtSJ5HdjQ+0dooV5gmuDXGClOg+NTBMDUhNtFVZbq+u4yHixF
         jpE56kTz1n5eB/S/GodAmA50bxsOrjsP/HODKjGCUeZrOxvSh/hzhzNqhh9QR7tec+MJ
         hdGWL2tXk6k+M+PKeIFJiWr5GbqrOnPr9v8HEG79t3QdbDp3h/6gMbW8FY59Qv6Srk3o
         IEVrz08fXmgwG+srog6P6ghRm1c+OJc903hiRgKOjAZ4HrrQkhhh1Qgeai3s1617adzy
         YBe6vYOTw4uLx8CmJidjTzuW9tpphDRZZM3RmsgghuBt1nzTXvWP1ZmMUH9kANO/yqt3
         EKJA==
X-Forwarded-Encrypted: i=1; AJvYcCUhR1ek5AUbvfU+SstSM5VowrVa5IyNR9TPf48xEFiXcFPlJmw3krVpxXw8sMtjWuJqXC1wtecG0W7yKxrQ/Ws/78TQGIAoslQAh+1evA==
X-Gm-Message-State: AOJu0YygSp5cGpZJl1vqeXB4kQeE3L8cbXZLet1PG56LEYsYjWwY5vGB
	TnvccIndu3105E4yCfMsy/wzj2k+V8KaGshnSuZsmy0V/RVFuiGk/4yAov7ItR1lGV5GEoLXYmf
	8kLg=
X-Google-Smtp-Source: AGHT+IGlSMj3TtDXUsYKu/jSZY0TpAEDOievVf1YQAFSTW8U+Ikbbg9nt1A6iOHO+Xys88vhR9/NQg==
X-Received: by 2002:a17:906:d7bb:b0:a3d:704:d688 with SMTP id pk27-20020a170906d7bb00b00a3d0704d688mr5689153ejb.47.1708191038033;
        Sat, 17 Feb 2024 09:30:38 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id n26-20020a1709061d1a00b00a3e4ce615dfsm250554ejh.197.2024.02.17.09.30.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 09:30:36 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso234075a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 09:30:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDZiLR5fVAQ0TeRS4oheAbICt7qxyf9935N8E7ZcyOVhB2NtQwM1/niccSwx8mAVQSacbY5rrfkMQWT5lLLlq1p9Hhuf1rNV7dvJkFlg==
X-Received: by 2002:a05:6402:128c:b0:564:46d5:3a4b with SMTP id
 w12-20020a056402128c00b0056446d53a4bmr75697edv.16.1708191036200; Sat, 17 Feb
 2024 09:30:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner> <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner> <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com>
In-Reply-To: <20240217135916.GA21813@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Feb 2024 09:30:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
Message-ID: <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: multipart/mixed; boundary="000000000000ec0544061197378c"

--000000000000ec0544061197378c
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 06:00, Oleg Nesterov <oleg@redhat.com> wrote:
>
> But I have a really stupid (I know nothing about vfs) question, why do we
> need pidfdfs_ino and pid->ino ? Can you explain why pidfdfs_alloc_file()
> can't simply use, say, iget_locked(pidfdfs_sb, (unsigned long)pid) ?
>
> IIUC, if this pid is freed and then another "struct pid" has the same address
> we can rely on __wait_on_freeing_inode() ?

Heh. Maybe it would work, but we really don't want to expose core
kernel pointers to user space as the inode number.

So then we'd have to add extra hackery to that (ie we'd have to
intercept stat calls, and we'd have to have something else for
->d_dname() etc..).

Those are all things that the VFS does support, but ...

So I do prefer Christian's new approach, although some of it ends up
being a bit unclear.

Christian, can you explain why this:

        spin_lock(&alias->d_lock);
        dget_dlock(alias);
        spin_unlock(&alias->d_lock);

instead of just 'dget()'?

Also, while I found the old __ns_get_path() to be fairly disgusting, I
actually think it's simpler and clearer than playing around with the
dentry alias list. So my expectation on code sharing was that you'd
basically lift the old __ns_get_path(), make *that* the helper, and
just pass it an argument that is the pointer to the filesystem
"stashed" entry...

And yes, using "atomic_long_t" for stashed is a crime against
humanity. It's also entirely pointless. There are no actual atomic
operations that the code wants except for reading and writing (aka
READ_ONCE() and WRITE_ONCE()) and cmpxchg (aka just cmpxchg()). Using
"atomic_long_t" buys the code nothing, and only makes things more
complicated and requires crazy casts.

So I think the nsfs.c code should be changed to do

-       atomic_long_t stashed;
+       struct dentry *stashed;

and remove the crazy workarounds for using the wrong type.

Something like the attached patch.

Then, I think the whole "lockref_get_not_dead()" etc games of
__ns_get_path() could be extracted out into a helper function that
takes that "&ns->stashed" pointer as an argument, and now that helper
could also be used for pidfs, except pidfs obviously just does
"&pid->stashed" instead.

Hmm?

Entirely untested patch. Also, the above idea may be broken because of
some obvious issue that I didn't think about. Christian?

               Linus

--000000000000ec0544061197378c
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lsqctoqt0>
X-Attachment-Id: f_lsqctoqt0

IGZzL25zZnMuYyAgICAgICAgICAgICAgICAgfCAxMSArKysrLS0tLS0tLQogaW5jbHVkZS9saW51
eC9uc19jb21tb24uaCB8ICAyICstCiBpbmNsdWRlL2xpbnV4L3Byb2NfbnMuaCAgIHwgIDIgKy0K
IDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL25zZnMuYyBiL2ZzL25zZnMuYwppbmRleCAzNGUxZTNlMzY3MzMuLjExMDRkYjY3
YzlhNCAxMDA2NDQKLS0tIGEvZnMvbnNmcy5jCisrKyBiL2ZzL25zZnMuYwpAQCAtMzgsNyArMzgs
NyBAQCBzdGF0aWMgdm9pZCBuc19wcnVuZV9kZW50cnkoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQog
CXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBkX2lub2RlKGRlbnRyeSk7CiAJaWYgKGlub2RlKSB7CiAJ
CXN0cnVjdCBuc19jb21tb24gKm5zID0gaW5vZGUtPmlfcHJpdmF0ZTsKLQkJYXRvbWljX2xvbmdf
c2V0KCZucy0+c3Rhc2hlZCwgMCk7CisJCVdSSVRFX09OQ0UobnMtPnN0YXNoZWQsIE5VTEwpOwog
CX0KIH0KIApAQCAtNjEsMTMgKzYxLDExIEBAIHN0YXRpYyBpbnQgX19uc19nZXRfcGF0aChzdHJ1
Y3QgcGF0aCAqcGF0aCwgc3RydWN0IG5zX2NvbW1vbiAqbnMpCiAJc3RydWN0IHZmc21vdW50ICpt
bnQgPSBuc2ZzX21udDsKIAlzdHJ1Y3QgZGVudHJ5ICpkZW50cnk7CiAJc3RydWN0IGlub2RlICpp
bm9kZTsKLQl1bnNpZ25lZCBsb25nIGQ7CiAKIAlyY3VfcmVhZF9sb2NrKCk7Ci0JZCA9IGF0b21p
Y19sb25nX3JlYWQoJm5zLT5zdGFzaGVkKTsKLQlpZiAoIWQpCisJZGVudHJ5ID0gUkVBRF9PTkNF
KG5zLT5zdGFzaGVkKTsKKwlpZiAoIWRlbnRyeSkKIAkJZ290byBzbG93OwotCWRlbnRyeSA9IChz
dHJ1Y3QgZGVudHJ5ICopZDsKIAlpZiAoIWxvY2tyZWZfZ2V0X25vdF9kZWFkKCZkZW50cnktPmRf
bG9ja3JlZikpCiAJCWdvdG8gc2xvdzsKIAlyY3VfcmVhZF91bmxvY2soKTsKQEAgLTk0LDggKzky
LDcgQEAgc3RhdGljIGludCBfX25zX2dldF9wYXRoKHN0cnVjdCBwYXRoICpwYXRoLCBzdHJ1Y3Qg
bnNfY29tbW9uICpucykKIAlpZiAoIWRlbnRyeSkKIAkJcmV0dXJuIC1FTk9NRU07CiAJZGVudHJ5
LT5kX2ZzZGF0YSA9ICh2b2lkICopbnMtPm9wczsKLQlkID0gYXRvbWljX2xvbmdfY21weGNoZygm
bnMtPnN0YXNoZWQsIDAsICh1bnNpZ25lZCBsb25nKWRlbnRyeSk7Ci0JaWYgKGQpIHsKKwlpZiAo
Y21weGNoZygmbnMtPnN0YXNoZWQsIE5VTEwsIGRlbnRyeSkpIHsKIAkJZF9kZWxldGUoZGVudHJ5
KTsJLyogbWFrZSBzdXJlIC0+ZF9wcnVuZSgpIGRvZXMgbm90aGluZyAqLwogCQlkcHV0KGRlbnRy
eSk7CiAJCWNwdV9yZWxheCgpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uc19jb21tb24u
aCBiL2luY2x1ZGUvbGludXgvbnNfY29tbW9uLmgKaW5kZXggMGYxZDAyNGJkOTU4Li43ZDIyZWE1
MGIwOTggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbnNfY29tbW9uLmgKKysrIGIvaW5jbHVk
ZS9saW51eC9uc19jb21tb24uaApAQCAtNyw3ICs3LDcgQEAKIHN0cnVjdCBwcm9jX25zX29wZXJh
dGlvbnM7CiAKIHN0cnVjdCBuc19jb21tb24gewotCWF0b21pY19sb25nX3Qgc3Rhc2hlZDsKKwlz
dHJ1Y3QgZGVudHJ5ICpzdGFzaGVkOwogCWNvbnN0IHN0cnVjdCBwcm9jX25zX29wZXJhdGlvbnMg
Km9wczsKIAl1bnNpZ25lZCBpbnQgaW51bTsKIAlyZWZjb3VudF90IGNvdW50OwpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9wcm9jX25zLmggYi9pbmNsdWRlL2xpbnV4L3Byb2NfbnMuaAppbmRl
eCA0OTUzOWJjNDE2Y2UuLjVlYTQ3MGViNGQ3NiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9w
cm9jX25zLmgKKysrIGIvaW5jbHVkZS9saW51eC9wcm9jX25zLmgKQEAgLTY2LDcgKzY2LDcgQEAg
c3RhdGljIGlubGluZSB2b2lkIHByb2NfZnJlZV9pbnVtKHVuc2lnbmVkIGludCBpbnVtKSB7fQog
CiBzdGF0aWMgaW5saW5lIGludCBuc19hbGxvY19pbnVtKHN0cnVjdCBuc19jb21tb24gKm5zKQog
ewotCWF0b21pY19sb25nX3NldCgmbnMtPnN0YXNoZWQsIDApOworCVdSSVRFX09OQ0UobnMtPnN0
YXNoZWQsIE5VTEwpOwogCXJldHVybiBwcm9jX2FsbG9jX2ludW0oJm5zLT5pbnVtKTsKIH0KIAo=
--000000000000ec0544061197378c--

