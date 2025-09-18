Return-Path: <linux-fsdevel+bounces-62092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B8B83F42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FAF4A638F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D0723D7C8;
	Thu, 18 Sep 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OdHIXAAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA2823184F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189740; cv=none; b=XBAn9LnHloMwMtMDVu+H33+tRGZEkpr4SUSnNU+4Qlp0BXrbogR4LcSdlqbMCxAllhzJcgD+nmCNeUJdHDLL5CvVdumNHY/OPA+uVFosNOFQ8qZlK0PsOdSHURYvYAuEubueMzLpDhM6elN4nq3aL50/21Gr9Cx23yzJlIvBvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189740; c=relaxed/simple;
	bh=uSkwXBn+pGJGDrbS7W1wgZ+i+zz3pflVe6OOIykwqPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGgmrKDkUc6ZTyNt12Gy/csbIEtKTZua8EETzo/6uB9AcaUKspOfsCsnHiFAsKJwxctol/Qk/eJIMAood0KUI3GAKA0/qkMNxngU+iCzfk4HM4++ggEFRRn6djJTppV0jjZRCWbcOirvq4aEKxbQaLvaWqOXJK9HTqtbdodXv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OdHIXAAQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5f7fe502dso4358561cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758189734; x=1758794534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k/y+CueHFBPLkm2YKyl1JPFOQP7wLQAaLIUka3iwZeI=;
        b=OdHIXAAQJJWRiOOpNe9uP3p08jvK9OrsWCM45LowjHyjevMnUzA3I2siZTgwTU3tsU
         cdLLm59AQhJju92BthsszbQx1ze52YZ7ylEfDPwmeZrv7/3HAEOVeOjEojfRywwZlUCb
         3377pgErOsDeXtlocHnBHY5yVLsXLr4ViZ9rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189734; x=1758794534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/y+CueHFBPLkm2YKyl1JPFOQP7wLQAaLIUka3iwZeI=;
        b=ivpSpA1QotuuwkNlEHFUH+Y07Sao+3LlCdx6sGk5sLYPTKjsn5/87f97taLiF9ggk0
         XUH4sp7Q0B4zmAOLrO7EU2yZZgRHPx11gveqJYOlLnVvGgmNkGP6YNRtBWOP7j0D63Ro
         j97/51NvRiDeP5rMYb31YE8/J3cdz8A628urHLlm8O4WvhLuIeCJ1cMLzrAg/+TjnQrQ
         6MTuuN/yB5YotEo0oLS/bkDLb4YgfTCfAuZgfnD/FdtxoVN9lO102mhjaHFCXLPHyMAI
         o6bhtR0TTVWNQIKNGCIBbi5YYnHOyGqLE+ix48h0KmbLcauhtGb4i+cJ3g086lLvCBFz
         8fBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtxlg1KYlsbTLugRr4BD/saTYiFMwzDspvNe4VXCDPVkxnRwZd+LGxRU/ots3MYAAT2/ICB8FQtmV7Na21@vger.kernel.org
X-Gm-Message-State: AOJu0YwscvvFAMOBThQhlzqtACVq5f+7Oaxr8rbHZVGqnmeRiGyFPAXx
	bFvBACeKRK9Uxyjuz5UiFitEf7yMy7R27dh7vsBmO7pjuFPI4/XFzyrNjbF4WfJ7VYrcyht7SoY
	pRYRO3VgFHfs893tPdqJJBTlmScc0D52P13SBwAGr4w==
X-Gm-Gg: ASbGncubTN2Ugn+5kZWhTCtlLVlWp2KhyXT0HN2yr5xVBDgpH6lgRinHSPJmthNEI8N
	TqcAUhZc/QS5iEVkWcFYWSBLDJvEUGh/fOJxiYhTqR5LpQb+xQ5J0ForZzvcsro12YKcD27Ypjy
	ykYL7X5DDHzRkJ7lQpCtcGr2a7uMrDcBbKmkeeZ+4z1LO6k3emaiP9zTz5ukk7HxWYIfd+zjaEc
	gPxb05T1UgFvE8j2ldav7xsHVw4Z9viUJ9Q/zyHBs7tEbJpnG/WWQCIruI=
X-Google-Smtp-Source: AGHT+IHgp/AFyJUMy18N0DoTyIL74jctTmndw1ELh5OALELBkI06nxeU47DDhqmk0wKXdzjS0TLtUiZnb9B3lKmVX40=
X-Received: by 2002:ac8:5881:0:b0:4b7:964d:a473 with SMTP id
 d75a77b69052e-4ba69d34e8fmr58189151cf.52.1758189734199; Thu, 18 Sep 2025
 03:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917153031.371581-1-mszeredi@redhat.com> <175815978155.1696783.12570522054558037073@noble.neil.brown.name>
In-Reply-To: <175815978155.1696783.12570522054558037073@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Sep 2025 12:02:02 +0200
X-Gm-Features: AS18NWCvRpW7HfCO_Kxm8YoE-xpzi0xvVWfvUTmalHsZMoza2IShp6V6s1CnKfY
Message-ID: <CAJfpeguvJNwEy_Vt-d4YhKW8u_qs56pUPVrLrj039VmnA7G=RQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="0000000000008e3af1063f107232"

--0000000000008e3af1063f107232
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 03:43, NeilBrown <neilb@ownmail.net> wrote:
>
> On Thu, 18 Sep 2025, Miklos Szeredi wrote:
> > If a path component is revalidated while taking part in a
> > rename(RENAME_EXCHANGE) request, userspace might find the already exchanged
> > files, while the kernel still has the old ones in dcache.  This mismatch
> > will cause the dentry to be invalidated (unhashed), resulting in
> > "(deleted)" being appended to proc paths.
>
> An inappropriate d_invalidate() on a positive dentry can do worse than
> just adding "(deleted)" to paths in proc.
> Any mount points at or below the target of d_invalidate() are unmounted.
> So I think it is really important to avoid invalidating a positive
> dentry if at all possible.
>
> If I understand the race correctly, the problem happens if an unlocked
> d_revalidate() returns zero so d_invalidate() is called immediately
> *after* d_exchange() has succeeded.  If it is called before, d_exchange()
> will rehash the dentry.

Right.   But as you say, d_invalidate() can have irreversible effects,
so it doesn't really matter when it happens.

> Could the same thing happen on rename without RENAME_EXCHANGE?
> The unlocked d_revalidate() finds that the name has already been removed
> so it requests d_invalidate() which runs immediately *after* d_move()
> has succeeded?

For some reason I thought -ENOENT won't invalidate the dentry, but I was wrong.

> I think the race should be addressed in VFS code as it could affect any
> filesystem which provides ->d_revalidate. I'm not sure how.

Attaching reproducer.   It will trigger immediately on "passthrough_ll
-ocache=never /mnt/fuse", which always revalidates lookups.  Without
"-ocache=never" revalidatation happens after 1s, which makes the race
harder to hit, but it still triggers within half a minute for me.

> Maybe we could make use of LOOKUP_REVAL retries and mandate that if
> LOOKUP_REVAL is set then ->d_revalidate is always called with an
> exclusive lock.  We would still need some way for d_invalidate() it
> decide whether to trigger the retry by causing -ESTALE to be returned.
> Maybe try-lock on s_vfs_rename_mutex could be used.
>
> Or maybe we could sample d_seq before calling ->d_revalidate() and only
> allow d_invalidate() to succeed if d_seq is unchanged.  If it changed,
> we repeat .... something.  Maybe the revalidate, maybe the lookup, maybe
> the whole path ??

Sounds good, will look into this.

Thanks,
Miklos

--0000000000008e3af1063f107232
Content-Type: text/x-c-code; charset="US-ASCII"; name="rename_reval_race.c"
Content-Disposition: attachment; filename="rename_reval_race.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mfp8n3y50>
X-Attachment-Id: f_mfp8n3y50

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxwdGhyZWFk
Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVycm5v
Lmg+CiNpbmNsdWRlIDxlcnIuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CgpzdGF0aWMgY29uc3Qg
Y2hhciAqbmFtZTEgPSAidGVzdF9maWxlMSI7CnN0YXRpYyBjb25zdCBjaGFyICpuYW1lMiA9ICJ0
ZXN0X2ZpbGUyIjsKCnN0YXRpYyB2b2lkICpzdGF0X2xvb3Aodm9pZCAqYXJnKQoKewoJc3RydWN0
IHN0YXQgYnVmOwoJaW50IHJlczsKCgkodm9pZCkgYXJnOwoKCWZvciAoOzspIHsKCQlyZXMgPSBz
dGF0KG5hbWUxLCAmYnVmKTsKCQlpZiAocmVzID09IC0xICYmIGVycm5vICE9IEVOT0VOVCkKCQkJ
ZXJyKDEsICJzdGF0KCVzKSIsIG5hbWUxKTsKCX0KfQoKc3RhdGljIHZvaWQgcmVuYW1lX2xvb3Ao
aW50IGZkKQp7CglpbnQgcmVzOwoJdW5zaWduZWQgbG9uZyBjb3VudCA9IDA7CgljaGFyIHByb2Nf
cGF0aFs2NF07CgljaGFyIGxpbmtbMjU2XTsKCXN0YXRpYyBjb25zdCBjaGFyIGRlbF9zdHJbXSA9
ICIoZGVsZXRlZCkiOwoJc3RhdGljIGNvbnN0IHNpemVfdCBkZWxfbGVuID0gc2l6ZW9mKGRlbF9z
dHIpIC0gMTsKCglzbnByaW50Zihwcm9jX3BhdGgsIHNpemVvZihwcm9jX3BhdGgpLCAiL3Byb2Mv
c2VsZi9mZC8lZCIsIGZkKTsKCglmb3IgKDs7KSB7CgkJcmVzID0gcmVuYW1lKG5hbWUxLCBuYW1l
Mik7CgkJaWYgKHJlcyA9PSAtMSkKCQkJZXJyKDEsICJyZW5hbWUoJXMsICVzKSIsIG5hbWUxLCBu
YW1lMik7CgoJCXJlcyA9IHJlYWRsaW5rKHByb2NfcGF0aCwgbGluaywgc2l6ZW9mKGxpbmspKTsK
CQlpZiAocmVzID09IC0xKQoJCQllcnIoMSwgInJlYWRsaW5rKCVzKSIsIHByb2NfcGF0aCk7CgoJ
CWlmICgoc2l6ZV90KSByZXMgPiBkZWxfbGVuICYmCgkJICAgIG1lbWNtcChsaW5rICsgcmVzIC0g
ZGVsX2xlbiwgZGVsX3N0ciwgZGVsX2xlbikgPT0gMCkgewoJCQlmcHJpbnRmKHN0ZGVyciwgIlxu
Iik7CgkJCWVycngoMSwgIm9wZW4gZmlsZSBpbnZhbGlkYXRlZCEiKTsKCQl9CgoJCXJlcyA9IHJl
bmFtZShuYW1lMiwgbmFtZTEpOwoJCWlmIChyZXMgPT0gLTEpCgkJCWVycigxLCAicmVuYW1lKCVz
LCAlcykiLCBuYW1lMiwgbmFtZTEpOwoKCQljb3VudCsrOwoJCWlmIChjb3VudCAlIDEwMDAwID09
IDApCgkJCWZwcmludGYoc3RkZXJyLCAiLiIpOwoJfQp9CgppbnQgbWFpbih2b2lkKQp7CglpbnQg
ZmQ7CglwdGhyZWFkX3QgdGlkOwoKCWZkID0gb3BlbihuYW1lMSwgT19DUkVBVCB8IE9fUkRPTkxZ
LCAwNjQ0KTsKCWlmIChmZCA9PSAtMSkKCQllcnIoMSwgIm9wZW4gJXMiLCBuYW1lMSk7CgoJaWYg
KHB0aHJlYWRfY3JlYXRlKCZ0aWQsIE5VTEwsIHN0YXRfbG9vcCwgTlVMTCkgIT0gMCkKCQllcnJ4
KDEsICJwdGhyZWFkX2NyZWF0ZSBmYWlsZWQiKTsKCglyZW5hbWVfbG9vcChmZCk7Cn0K
--0000000000008e3af1063f107232--

