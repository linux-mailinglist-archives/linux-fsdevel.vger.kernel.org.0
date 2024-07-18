Return-Path: <linux-fsdevel+bounces-23889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C558934543
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 02:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4961F21ED4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 00:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12122A21;
	Thu, 18 Jul 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iE6rsGtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0F197
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721261090; cv=none; b=LRcSVxB3IFcRguy614Qyd2V62XAsDJHfbwecGmBJmb+V0m16qyIjrzCvqRui8ifx3IE7j7m6+7Ya5Nl6y8PrzK+sY8Jpq1Z9YSiWPXS7uNpb8DmdcCwL6gyEEN2krx+FGV+KW7mEdoRuemOiowANuLxnnlAQ+NbcfP/5HRfFXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721261090; c=relaxed/simple;
	bh=FAj1MClzOnm7txs8nlFo1G77N9NS2dCzEHAW+o9TMto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt6KIGn9UDTc99xIuTrXXdrkEjuajXOHUb2lssRpNnhJfEk/nXZec1zCX4c4ug22kkcnxOOIGBk7vsfI3HFlsEAKH5bZPGr5loMHCtpG6Awpj+pDvB35Bn3QIzge9cdQgX9ZR9+AbkHb5OhpuRxO04QelNXgC1VdMqTyG4Bg3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iE6rsGtt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea33671ffso224694e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721261086; x=1721865886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgh/5TL5RuPEkrIYyZ+YL3lfHWM6eC22E94AhsG1cyU=;
        b=iE6rsGtt4tI9s13ZeRpYW6N7GXXikpHJOxduC05ahwLSXy2XjgO1QAo78BFEWjMJK3
         4mJXXJht5D8SGxeNV2uJ0qa5fLR1DMEk3xNA0SpvJnalJiHMul9p7RPQDWKycnbeHGZd
         Y/kzmRQhyAktb5DcBQkazVsCwEL852ekBlkj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721261086; x=1721865886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgh/5TL5RuPEkrIYyZ+YL3lfHWM6eC22E94AhsG1cyU=;
        b=sx7RmMN2skMkHYq3rIundRaImgoFvL+iQy//adM/yBfyt2oHDpOfBQy8Bpu1Np0fsL
         PQonrTJL+UVvvItL0sHQ72iil6KOA7lpn7ebUwlJdwYdxn5bZ5IvXWwe9gPmIo39tBTm
         arIHynP/ljV7h5mBOivB37w0TfA5roETHieWYPUhFdV4ismzx02eg/t35gdOeaeFh+Gw
         LftBKq0waOc2ihLC6N+MDg7JOWeuG7SFeDrcnpuKcCBl9cN3pxIqZuF1lXCdvTyGMZr4
         NCIPcHwelhEU/mSZXcjjLGBmSt5Thmmx7C+BJObrjQZBP2hjI5nc9WAFJNVY7G29AE+l
         i6QA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3GjYVTH8yFDmYHTS/2soyVAhxawrQtMLecmgfzBFXutWeyO4J/PTsQmInvmne/0lxzDu9Cl+N9OTcbgb15CS9hIivfp4uCA0WeDtXQ==
X-Gm-Message-State: AOJu0YyDYYKGGjnktS7y9M64MQgEr1iGnmLOGqjc5PaHWm19hvp3xU2q
	SqkFP0uI0/87iwB9pKgM/eYDfQr4jCrY5KsTzz/VUF8i9pTMr1UhXQwtnD4atuotbqNf8HalS1i
	vLDmPjA==
X-Google-Smtp-Source: AGHT+IFJJTfpksliiMy0BTF6Aumgpfrap0mmGBhcCUvSZ9aP8RjAJnCifJPYca02iiW8QkY0JQy1SQ==
X-Received: by 2002:a05:6512:1082:b0:52e:9b5c:1c6f with SMTP id 2adb3069b0e04-52ee53a6c29mr2560279e87.10.1721261086065;
        Wed, 17 Jul 2024 17:04:46 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59c15a5d898sm6552144a12.39.2024.07.17.17.04.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 17:04:44 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e5929033so20841666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 17:04:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPwUSMHAfF4+JM6VXRLNCpHWu56IGUltx91CVM1TXj3xHlMlkNzLERWLdlfMcmnP03OWQfQ0gnjKSLIiB4Ho7OGGae8plorE+MSEmhxg==
X-Received: by 2002:a17:906:40d5:b0:a77:cd3c:e9b7 with SMTP id
 a640c23a62f3a-a7a0133ac71mr230759566b.57.1721261084140; Wed, 17 Jul 2024
 17:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717111358.415712-1-adrian.ratiu@collabora.com>
 <202407171017.A0930117@keescook> <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>
 <202407171520.FD49AE35@keescook>
In-Reply-To: <202407171520.FD49AE35@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 17:04:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9qsy-bX65ev8jgDzGM+uTk=Vbix32F8SLfUWegajT+w@mail.gmail.com>
Message-ID: <CAHk-=wi9qsy-bX65ev8jgDzGM+uTk=Vbix32F8SLfUWegajT+w@mail.gmail.com>
Subject: Re: [PATCH] proc: add config to block FOLL_FORCE in mem writes
To: Kees Cook <kees@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, 
	inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007ccffd061d7a5312"

--0000000000007ccffd061d7a5312
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 15:24, Kees Cook <kees@kernel.org> wrote:
>
> > In particular, this patch would make it easy to make that
> > SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE config option be a "choice"
> > where you pick "never, ptrace, always" by just changing the rules in
> > proc_is_ptracing().
>
> So the original patch could be reduced to just the single tristate option
> instead of 3 tristates? I think that would be a decent middle ground,
> and IIUC, will still provide the coverage Chrome OS is looking for[1].

So here's what I kind of think might be ok.

ENTIRELY UNTESTED! This is more of a "look, something like this,
perhaps" patch than a real one.

If somebody tests this, and it is ok for Chrome OS, you can consider
this signed-off-on, but only with actual testing. I might have gotten
something hroribly wrong.

              Linus

--0000000000007ccffd061d7a5312
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lyqie9xt0>
X-Attachment-Id: f_lyqie9xt0

IGZzL3Byb2MvYmFzZS5jICAgfCAyMiArKysrKysrKysrKysrKysrKysrKystCiBzZWN1cml0eS9L
Y29uZmlnIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hh
bmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL3By
b2MvYmFzZS5jIGIvZnMvcHJvYy9iYXNlLmMKaW5kZXggNzJhMWFjZDAzNjc1Li5mYmU5YTk2YzJk
OTggMTAwNjQ0Ci0tLSBhL2ZzL3Byb2MvYmFzZS5jCisrKyBiL2ZzL3Byb2MvYmFzZS5jCkBAIC04
MzUsNiArODM1LDI0IEBAIHN0YXRpYyBpbnQgbWVtX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwg
c3RydWN0IGZpbGUgKmZpbGUpCiAJcmV0dXJuIHJldDsKIH0KIAorc3RhdGljIGJvb2wgcHJvY19t
ZW1fZm9sbF9mb3JjZShzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IG1tX3N0cnVjdCAqbW0pCit7
CisjaWYgZGVmaW5lZChDT05GSUdfUFJPQ19NRU1fTk9fRk9SQ0UpCisJcmV0dXJuIGZhbHNlOwor
I2VsaWYgZGVmaW5lZChDT05GSUdfUFJPQ19NRU1fRk9SQ0VfUFRSQUNFKQorCWJvb2wgcHRyYWNl
X2FjdGl2ZSA9IGZhbHNlOworCXN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzayA9IGdldF9wcm9jX3Rh
c2soZmlsZV9pbm9kZShmaWxlKSk7CisKKwlpZiAodGFzaykgeworCQlwdHJhY2VfYWN0aXZlID0g
dGFzay0+cHRyYWNlICYmIHRhc2stPm1tID09IG1tICYmIHRhc2stPnBhcmVudCA9PSBjdXJyZW50
OworCQlwdXRfdGFza19zdHJ1Y3QodGFzayk7CisJfQorCXJldHVybiBwdHJhY2VfYWN0aXZlOwor
I2Vsc2UKKwlyZXR1cm4gdHJ1ZTsKKyNlbmRpZgorfQorCiBzdGF0aWMgc3NpemVfdCBtZW1fcnco
c3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsCiAJCQlzaXplX3QgY291bnQsIGxv
ZmZfdCAqcHBvcywgaW50IHdyaXRlKQogewpAQCAtODU1LDcgKzg3Myw5IEBAIHN0YXRpYyBzc2l6
ZV90IG1lbV9ydyhzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAlpZiAoIW1t
Z2V0X25vdF96ZXJvKG1tKSkKIAkJZ290byBmcmVlOwogCi0JZmxhZ3MgPSBGT0xMX0ZPUkNFIHwg
KHdyaXRlID8gRk9MTF9XUklURSA6IDApOworCWZsYWdzID0gd3JpdGUgPyBGT0xMX1dSSVRFIDog
MDsKKwlpZiAocHJvY19tZW1fZm9sbF9mb3JjZShmaWxlLCBtbSkpCisJCWZsYWdzIHw9IEZPTExf
Rk9SQ0U7CiAKIAl3aGlsZSAoY291bnQgPiAwKSB7CiAJCXNpemVfdCB0aGlzX2xlbiA9IG1pbl90
KHNpemVfdCwgY291bnQsIFBBR0VfU0laRSk7CmRpZmYgLS1naXQgYS9zZWN1cml0eS9LY29uZmln
IGIvc2VjdXJpdHkvS2NvbmZpZwppbmRleCA0MTJlNzZmMTU3NWQuLmIyMDFhZTNmZWVhYiAxMDA2
NDQKLS0tIGEvc2VjdXJpdHkvS2NvbmZpZworKysgYi9zZWN1cml0eS9LY29uZmlnCkBAIC0xOSw2
ICsxOSwzOCBAQCBjb25maWcgU0VDVVJJVFlfRE1FU0dfUkVTVFJJQ1QKIAogCSAgSWYgeW91IGFy
ZSB1bnN1cmUgaG93IHRvIGFuc3dlciB0aGlzIHF1ZXN0aW9uLCBhbnN3ZXIgTi4KIAorY2hvaWNl
CisJcHJvbXB0ICJBbGxvdyAvcHJvYy9waWQvbWVtIGFjY2VzcyBvdmVycmlkZSIKKwlkZWZhdWx0
IFBST0NfUElEX01FTV9BTFdBWVNfRk9SQ0UKKwloZWxwCisJICBUcmFkaXRpb25hbGx5IC9wcm9j
L3BpZC9tZW0gYWxsb3dzIHVzZXJzIHRvIG92ZXJyaWRlIG1lbW9yeQorCSAgcGVybWlzc2lvbnMg
Zm9yIHVzZXJzIGxpa2UgcHRyYWNlLCBhc3N1bWluZyB0aGV5IGhhdmUgcHRyYWNlCisJICBjYXBh
YmlsaXR5LgorCisJICBUaGlzIGFsbG93cyBwZW9wbGUgdG8gbGltaXQgdGhhdCAtIGVpdGhlciBu
ZXZlciBvdmVycmlkZSwgb3IKKwkgIHJlcXVpcmUgYWN0dWFsIGFjdGl2ZSBwdHJhY2UgYXR0YWNo
bWVudC4KKworCSAgRGVmYXVsdHMgdG8gdGhlIHRyYWRpdGlvbmFsIGJlaGF2aW9yIChmb3Igbm93
KQorCitjb25maWcgUFJPQ19QSURfTUVNX0FMV0FZU19GT1JDRQorCWJvb2wgIlRyYWRpdGlvbmFs
IC9wcm9jL3BpZC9tZW0gYmVoYXZpb3IiCisJaGVscAorCSAgVGhpcyBhbGxvd3MgL3Byb2MvcGlk
L21lbSBhY2Nlc3NlcyB0byBvdmVycmlkZSBtZW1vcnkgbWFwcGluZworCSAgcGVybWlzc2lvbnMg
aWYgeW91IGhhdmUgcHRyYWNlIGFjY2VzcyByaWdodHMuCisKK2NvbmZpZyBDT05GSUdfUFJPQ19N
RU1fRk9SQ0VfUFRSQUNFCisJYm9vbCAiUmVxdWlyZSBhY3RpdmUgcHRyYWNlKCkgdXNlIGZvciBh
Y2Nlc3Mgb3ZlcnJpZGUiCisJaGVscAorCSAgVGhpcyBhbGxvd3MgL3Byb2MvcGlkL21lbSBhY2Nl
c3NlcyB0byBvdmVycmlkZSBtZW1vcnkgbWFwcGluZworCSAgcGVybWlzc2lvbnMgZm9yIGFjdGl2
ZSBwdHJhY2VycyBsaWtlIGdkYi4KKworY29uZmlnIENPTkZJR19QUk9DX01FTV9OT19GT1JDRQor
CWJvb2wgIk5ldmVyIgorCWhlbHAKKwkgIE5ldmVyIG92ZXJyaWRlIG1lbW9yeSBtYXBwaW5nIHBl
cm1pc3Npb25zCisKK2VuZGNob2ljZQorCiBjb25maWcgU0VDVVJJVFkKIAlib29sICJFbmFibGUg
ZGlmZmVyZW50IHNlY3VyaXR5IG1vZGVscyIKIAlkZXBlbmRzIG9uIFNZU0ZTCg==
--0000000000007ccffd061d7a5312--

