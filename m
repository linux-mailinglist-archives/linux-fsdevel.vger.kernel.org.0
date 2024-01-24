Return-Path: <linux-fsdevel+bounces-8794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F134583B11D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212D51C21F5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EAF12AADF;
	Wed, 24 Jan 2024 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AsJ7Elfg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7412A172
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120846; cv=none; b=Er2Xw+S5oTzuJwkrdtC9U2N+9/GiZSzSL0R0mh5Eiv1aHeMKsIvu+SzA/rp3anEG1O7Jp1wULPaXXm36eqNk/W+QqpbH9cfzN3Ieq4L4J+ZmrVJ+6qVM0dlcOcoKNb6Fo3XLqKpz79bIdGTN5HME/L0zkiJMUq9yl6tk7KbsHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120846; c=relaxed/simple;
	bh=MICtpGs6zSqhUr2E+Ne1WpJTzfLWSkf6rVRDqQtRI34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtQafN9PEe3WCYU/fPdDsYUvTuNCVrRrIaWPQ8dGzxmcdqhqM168YsqGIxD2CFiTW9E6ujPMOIpbzqtrPUji1cTQ5mdg++V7v4v7xh/RCmopkHbgKYKXiUfgP4pEqzF7M0pYOu0ByzFbNuNkdOnLNfyAb2OH5rEo/+gbRnQ9SWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AsJ7Elfg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso1817334e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706120842; x=1706725642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3wp26pORWumECbzJWinoQTFNJx6FsiqC4jXvkpoexag=;
        b=AsJ7Elfgk2gwgrhCG9E5cmxqbEPxycaxCInAxXu5l0X3LEja1EwrfWHNsZ4+MB9qrt
         aG3QoyIS++5SReV+44hy7CZLLvyOqa26wWSVt3UycnqM6rvfjvkqVM1dvM4sqPEeNp1P
         1tOXmPlYXRnEX2Iz9bl+igE0TnM3xEjs0gHsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120842; x=1706725642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wp26pORWumECbzJWinoQTFNJx6FsiqC4jXvkpoexag=;
        b=xLlAIzM2s49Ptr7+7tn28AmYQY2S3eEyxRtVqJX9cWMTA4wNiVUoAcskGuNncXnz4N
         duCuRzM5xTBodcdlZ1DQchmHpxS8s8h3tz8dTHYUO3tH38uc8CJKOexg4iMPrsFnTFcA
         Nvf2XuH5OaXqHPWWjKKfZzH1eVxg/I4GWvQkzvh5aFngOAmKVllEShrcaA1v8/jWes4s
         lleVD1wfhUcvekG5izYZmQ1Pcz1zvrxbcwpFbjSxJvw7kHGmW+P9IRdwdtechXQ1Jiuz
         xVH/MVpzcsP/TEdjhubN9U3AERYRusvA5UT6rE9P6KMkfqKr5HY7NwClS8fbbXMjPUh7
         qLSg==
X-Gm-Message-State: AOJu0YxJmPmao1QVLfE06UwklVJqhRIpm1xDjZFEVOXQK5dOEH4teZSZ
	ObwPyof0LdZYj2YnLOGEq2einlJvqKSc2nH4YdlMkoNkz8AjVGHvlRR/SoB60BUr/pKf/wiHhhs
	LymXyRw==
X-Google-Smtp-Source: AGHT+IE6Gx8PfnpYC/oJ1zsWN8GTBlUR0+ClJNvb/bjcZGZYIOlEkWjhl2R2Aa2K9wC/P/Zv2xuyGA==
X-Received: by 2002:ac2:4844:0:b0:510:164a:9d61 with SMTP id 4-20020ac24844000000b00510164a9d61mr304304lfy.75.1706120842576;
        Wed, 24 Jan 2024 10:27:22 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id b8-20020a056512304800b0050eb79db2e6sm2652151lfb.280.2024.01.24.10.27.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:27:21 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf1b770833so18623671fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:27:21 -0800 (PST)
X-Received: by 2002:a2e:8ed3:0:b0:2cf:2a3e:d1a4 with SMTP id
 e19-20020a2e8ed3000000b002cf2a3ed1a4mr557545ljl.3.1706120841173; Wed, 24 Jan
 2024 10:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
In-Reply-To: <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 10:27:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
Message-ID: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: Kevin Locke <kevin@kevinlocke.name>, Josh Triplett <josh@joshtriplett.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000af6da8060fb53687"

--000000000000af6da8060fb53687
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 09:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, I think the goal here should be "minimal fix" followed by "remove
> that horrendous thing".

Ugh. The tomoyo use is even *more* disgusting, in how it uses it for
"tomoyo_domain()" entirely independently of even the ->file_open()
callback.

So for tomoyo, it's not about the file open, it's about
tomoyo_cred_prepare() and friends.

So the patch I posted probably fixes apparmor, but only breaks tomoyo
instead, because tomoyo really does seem to use it around the whole
security_bprm_creds_for_exec() thing.

Now, tomoyo *also* uses it for the file_open() callback, just to confuse things.

IOW, I think the right thing to do is to split this in two:

 - leave the existing ->in_execve for the bprm_creds dance in
boprm_execve(). Horrendous and disgusing.

 - the ->file_open() thing is changed to check file->f_flags

(with a comment about how FMODE_EXEC is in f_flags, not f_mode like it
should be).

IOW, I think the patch I posted earlier - and Kees' version of the
same thing - is just broken. This attached patch might work.

And as noted, since it checks __FMODE_EXEC, it now allows the uselib()
case too. I think that's ok.

UNTESTED. But I think this is at least a movement in the right
direction. The whole cred use of current->in_execve in tomoyo should
*also* be fixed, but I didn't even try to follow what it actually
wanted.

           Linus

--000000000000af6da8060fb53687
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lrs46mby0>
X-Attachment-Id: f_lrs46mby0

IHNlY3VyaXR5L2FwcGFybW9yL2xzbS5jICB8IDQgKysrLQogc2VjdXJpdHkvdG9tb3lvL3RvbW95
by5jIHwgNSArKystLQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvYXBwYXJtb3IvbHNtLmMgYi9zZWN1cml0eS9h
cHBhcm1vci9sc20uYwppbmRleCA3NzE3MzU0Y2UwOTUuLjk4ZTExNTBiZWU5ZCAxMDA2NDQKLS0t
IGEvc2VjdXJpdHkvYXBwYXJtb3IvbHNtLmMKKysrIGIvc2VjdXJpdHkvYXBwYXJtb3IvbHNtLmMK
QEAgLTQ2OSw4ICs0NjksMTAgQEAgc3RhdGljIGludCBhcHBhcm1vcl9maWxlX29wZW4oc3RydWN0
IGZpbGUgKmZpbGUpCiAJICogQ2FjaGUgcGVybWlzc2lvbnMgZ3JhbnRlZCBieSB0aGUgcHJldmlv
dXMgZXhlYyBjaGVjaywgd2l0aAogCSAqIGltcGxpY2l0IHJlYWQgYW5kIGV4ZWN1dGFibGUgbW1h
cCB3aGljaCBhcmUgcmVxdWlyZWQgdG8KIAkgKiBhY3R1YWxseSBleGVjdXRlIHRoZSBpbWFnZS4K
KwkgKgorCSAqIElsbG9naWNhbGx5LCBGTU9ERV9FWEVDIGlzIGluIGZfZmxhZ3MsIG5vdCBmX21v
ZGUuCiAJICovCi0JaWYgKGN1cnJlbnQtPmluX2V4ZWN2ZSkgeworCWlmIChmaWxlLT5mX2ZsYWdz
ICYgX19GTU9ERV9FWEVDKSB7CiAJCWZjdHgtPmFsbG93ID0gTUFZX0VYRUMgfCBNQVlfUkVBRCB8
IEFBX0VYRUNfTU1BUDsKIAkJcmV0dXJuIDA7CiAJfQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvdG9t
b3lvL3RvbW95by5jIGIvc2VjdXJpdHkvdG9tb3lvL3RvbW95by5jCmluZGV4IDNjM2FmMTQ5YmYx
Yy4uZThmYjAyYjcxNmFhIDEwMDY0NAotLS0gYS9zZWN1cml0eS90b21veW8vdG9tb3lvLmMKKysr
IGIvc2VjdXJpdHkvdG9tb3lvL3RvbW95by5jCkBAIC0zMjcsOCArMzI3LDkgQEAgc3RhdGljIGlu
dCB0b21veW9fZmlsZV9mY250bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwK
ICAqLwogc3RhdGljIGludCB0b21veW9fZmlsZV9vcGVuKHN0cnVjdCBmaWxlICpmKQogewotCS8q
IERvbid0IGNoZWNrIHJlYWQgcGVybWlzc2lvbiBoZXJlIGlmIGNhbGxlZCBmcm9tIGV4ZWN2ZSgp
LiAqLwotCWlmIChjdXJyZW50LT5pbl9leGVjdmUpCisJLyogRG9uJ3QgY2hlY2sgcmVhZCBwZXJt
aXNzaW9uIGhlcmUgaWYgZXhlY3ZlKCkuICovCisJLyogSWxsb2dpY2FsbHksIEZNT0RFX0VYRUMg
aXMgaW4gZl9mbGFncywgbm90IGZfbW9kZS4gKi8KKwlpZiAoZmlsZS0+Zl9mbGFncyAmIF9fRk1P
REVfRVhFQykKIAkJcmV0dXJuIDA7CiAJcmV0dXJuIHRvbW95b19jaGVja19vcGVuX3Blcm1pc3Np
b24odG9tb3lvX2RvbWFpbigpLCAmZi0+Zl9wYXRoLAogCQkJCQkgICAgZi0+Zl9mbGFncyk7Cg==
--000000000000af6da8060fb53687--

