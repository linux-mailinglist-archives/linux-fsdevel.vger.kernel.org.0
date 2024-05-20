Return-Path: <linux-fsdevel+bounces-19827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEF08CA274
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BE51F22118
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 19:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65561137C27;
	Mon, 20 May 2024 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N/SBLX17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA91CA81
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231708; cv=none; b=Eus7nC6sERir0EBIjgfOTsrjWBoCEWbKUzxl25RcEDT/bPkNvcLyyPpA9LHr/IjTRX12Ri9fpGKObfvi3wE4GLO0gFS3cMUsuBHNznnpDmgLIwE4T7VtoOfmZJautO1LMykPVVPCI5KZbMuRIVYRk1i1BkQ7vC/yD30Li3oa7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231708; c=relaxed/simple;
	bh=OnOtI1kr5G0EXz9BkTc/VQGlizAhkdD6wAGfVqp2yYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm6U7zq7PNC+9VG7IUJW+jOCzsS9PM6LGXJBBnQ37J00bcT4ai+ApVj0+BW79wy98HULPMn+ruA67mbTjJR6jDSUBxOGUdFiuGz/kNHKHJFivXryi1mLjdMk32YvPc6gRp/TvDzd4dFWQ9078UUoE6So6rmoY6nw1xwQrBojHig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N/SBLX17; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52388d9ca98so6110804e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716231705; x=1716836505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ovmaGqWhxPsIO4hK1dVkzsjhczbUYFtq3QB7tbhy2g=;
        b=N/SBLX17X5kMQq1TQV++sOzDlNALPCpV1Q/AfBjlX1ZUvNW+L0dO1M6mQY5k4Btr30
         EMJu/gKMZrzzzQ13UvKR5fEug0UQKzVuHgMbkKPbXiqfoxTo4/EtwRgA7YNjzrJbkd0c
         am2C2uS8MnLSIC92kJK64FDhWTZMbh1nFNA1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716231705; x=1716836505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ovmaGqWhxPsIO4hK1dVkzsjhczbUYFtq3QB7tbhy2g=;
        b=PfZjNKXXraO6iGLXbuwo724pAfX0rOFSAwyVRqQL/9Gd3z6TtJCs/VcwqjhnfwcZxj
         7N7xlX4ui+iH9h/Sf3abXu+NwA6UIAYWOmoqwlHi7jFIaqJb2U59Q0WjBvzAd1AY6Jst
         t0yS7qsm7n0eQB8VbAAXtKl0JJ95LhXMi/NwVddW/LrJs2ADpwbuJBWiiXkCk8AdW6hi
         nVYuZzOEtG/kq6iQ8qs9Rr1VvxBONZ2/cHOBwht8uQWImGZSS2pXCfGNX9ljIgxGVZ4i
         T4C1YwS2cBRLFl3byoKvt5DmwTNWvQXj9rgkWOydSPtaIC2WLXk0u/oKgbXtHko8bxQ9
         KD3w==
X-Forwarded-Encrypted: i=1; AJvYcCUmJuA9v1vvBxf2Hm8W3l+B2JFjbdBAV3sDBY+90hu6xAn7zGdRSUIo1fB2kwAva7kdIATI30gROQ/64zfLM9RC0/eVu1uYKUBtet4baQ==
X-Gm-Message-State: AOJu0Yw3Jn38fqY6mId2AOGVKExi2BPMhey3B1hhluHTCMeEsfr9IAQG
	GAi90DGlggrbo4We/9tiXKezApQUFpAk2SnxT1peWNwo/PX/Ie/RLLg98jozaVFBms6vfmKGxlw
	nG8ZOYg==
X-Google-Smtp-Source: AGHT+IHyt2DDOxkppkP3DiJ/epjyHJALHIRkMGRK1P0paEck3QtmXes/ocdtCNk0nm1fBIxUp9aESg==
X-Received: by 2002:a05:6512:3c9a:b0:521:7846:69d3 with SMTP id 2adb3069b0e04-5221027858amr30114706e87.55.1716231704886;
        Mon, 20 May 2024 12:01:44 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8bafsm4364277e87.235.2024.05.20.12.01.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 12:01:43 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso55567381fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 12:01:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTm+4tmGA+LtZnZf64oRUFutgnApcpDWmrXZtMMhka3vtAIl0SONKR+zt3zIAz9zsUvI301S1HMb77XdcUlz8hHIL2G56sBB/pvdOXVg==
X-Received: by 2002:a2e:a555:0:b0:2e0:da20:2502 with SMTP id
 38308e7fff4ca-2e52039dad7mr273579421fa.49.1716231702902; Mon, 20 May 2024
 12:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>
 <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner> <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org> <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com> <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org>
In-Reply-To: <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 May 2024 12:01:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
Message-ID: <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: multipart/mixed; boundary="00000000000001c83d0618e7551b"

--00000000000001c83d0618e7551b
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 01:23, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> So what about LEGACY_NO_MODE which would set "i_mode = 0" and mangle the
> WARN_ON appropriately. Like in the patch attached? It works (when
> applied together with the anon_inode name fix).

No, that's horrendous.

We actually have a much better place to handle this nasty thing:
pidfs_getattr() for the returned st_mode, and pidfs_dname() for the
name.

So how about just a patch like this?  It doesn't do anything
*internally* to the inodes, but it fixes up what we expose to user
level to make it look like lsof expects.

                    Linus

--00000000000001c83d0618e7551b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lwfc16630>
X-Attachment-Id: f_lwfc16630

IGZzL3BpZGZzLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL3BpZGZz
LmMgYi9mcy9waWRmcy5jCmluZGV4IGE2M2Q1ZDI0YWEwMi4uNTIzMWRkYjI3ZDI1IDEwMDY0NAot
LS0gYS9mcy9waWRmcy5jCisrKyBiL2ZzL3BpZGZzLmMKQEAgLTE2OSw2ICsxNjksMjQgQEAgc3Rh
dGljIGludCBwaWRmc19zZXRhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgZGVu
dHJ5ICpkZW50cnksCiAJcmV0dXJuIC1FT1BOT1RTVVBQOwogfQogCisKKy8qCisgKiBVc2VyIHNw
YWNlIGV4cGVjdHMgcGlkZnMgaW5vZGVzIHRvIGhhdmUgbm8gZmlsZSB0eXBlIGluIHN0X21vZGUu
CisgKgorICogSW4gcGFydGljdWxhciwgJ2xzb2YnIGhhcyB0aGlzIGxlZ2FjeSBsb2dpYzoKKyAq
CisgKgl0eXBlID0gcy0+c3RfbW9kZSAmIFNfSUZNVDsKKyAqCXN3aXRjaCAodHlwZSkgeworICoJ
ICAuLi4KKyAqCWNhc2UgMDoKKyAqCQlpZiAoIXN0cmNtcChwLCAiYW5vbl9pbm9kZSIpKQorICoJ
CQlMZi0+bnR5cGUgPSBOdHlwZSA9IE5fQU5PTl9JTk9ERTsKKyAqCisgKiB0byBkZXRlY3Qgb3Vy
IG9sZCBhbm9uX2lub2RlIGxvZ2ljLgorICoKKyAqIFJhdGhlciB0aGFuIG1lc3Mgd2l0aCBvdXIg
aW50ZXJuYWwgc2FuZSBpbm9kZSBkYXRhLCBqdXN0IGZpeCBpdAorICogdXAgaGVyZSBpbiBnZXRh
dHRyKCkgYnkgbWFza2luZyBvZmYgdGhlIGZvcm1hdCBiaXRzLgorICovCiBzdGF0aWMgaW50IHBp
ZGZzX2dldGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIGNvbnN0IHN0cnVjdCBwYXRoICpw
YXRoLAogCQkJIHN0cnVjdCBrc3RhdCAqc3RhdCwgdTMyIHJlcXVlc3RfbWFzaywKIAkJCSB1bnNp
Z25lZCBpbnQgcXVlcnlfZmxhZ3MpCkBAIC0xNzYsNiArMTk0LDcgQEAgc3RhdGljIGludCBwaWRm
c19nZXRhdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0
aCwKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZF9pbm9kZShwYXRoLT5kZW50cnkpOwogCiAJZ2Vu
ZXJpY19maWxsYXR0cigmbm9wX21udF9pZG1hcCwgcmVxdWVzdF9tYXNrLCBpbm9kZSwgc3RhdCk7
CisJc3RhdC0+bW9kZSAmPSB+U19JRk1UOwogCXJldHVybiAwOwogfQogCkBAIC0xOTksMTIgKzIx
OCwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHN1cGVyX29wZXJhdGlvbnMgcGlkZnNfc29wcyA9
IHsKIAkuc3RhdGZzCQk9IHNpbXBsZV9zdGF0ZnMsCiB9OwogCisvKgorICogJ2xzb2YnIGhhcyBr
bm93bGVkZ2Ugb2Ygb3V0IGhpc3RvcmljYWwgYW5vbl9pbm9kZSB1c2UsIGFuZCBleHBlY3RzCisg
KiB0aGUgcGlkZnMgZGVudHJ5IG5hbWUgdG8gc3RhcnQgd2l0aCAnYW5vbl9pbm9kZScuCisgKi8K
IHN0YXRpYyBjaGFyICpwaWRmc19kbmFtZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGNoYXIgKmJ1
ZmZlciwgaW50IGJ1ZmxlbikKIHsKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZF9pbm9kZShkZW50
cnkpOwogCXN0cnVjdCBwaWQgKnBpZCA9IGlub2RlLT5pX3ByaXZhdGU7CiAKLQlyZXR1cm4gZHlu
YW1pY19kbmFtZShidWZmZXIsIGJ1ZmxlbiwgInBpZGZkOlslbGx1XSIsIHBpZC0+aW5vKTsKKwly
ZXR1cm4gZHluYW1pY19kbmFtZShidWZmZXIsIGJ1ZmxlbiwgImFub25faW5vZGU6W3BpZGZkLSVs
bHVdIiwgcGlkLT5pbm8pOwogfQogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGRlbnRyeV9vcGVyYXRp
b25zIHBpZGZzX2RlbnRyeV9vcGVyYXRpb25zID0gewo=
--00000000000001c83d0618e7551b--

