Return-Path: <linux-fsdevel+bounces-18447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75398B9062
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 22:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A01B20EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88429161B6A;
	Wed,  1 May 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OVfwXoDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1A16191B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593901; cv=none; b=BbyhPMOv3o8T1gw7RILcI7L1IBpMrQrS9DyHpdNLyoRyzC4aoP6qczOACa9zioEArmx8YSOvi3U0NkJ883MysYt63ovo4hFB5uH5YUxdK103narvKeSnjxrVXxLUh6kZ9CD0O4jugaKhaCe+luVF7bpda6Kl4aByAcvvYazYv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593901; c=relaxed/simple;
	bh=IErg5JgZ1tt5Cj7bOCZ88y1HXdEMOV4/p7EdFtr+ouw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMCxUuGB0z2MteN2UbGl9qjbROejPMSH9sGuDgYo5tt1Gtbgp8rOsfEM6p2hiCETRtMSXNNaw/bL6OGzJsAj/BFXNO0y1FtggxVf7m2orvmOOlkSqxRb+xZP97zU3V5xLZ3ca3xsI5jFD77LWxEiDBFFFkwY9cNppPSeFrzkCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OVfwXoDu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5f807d941c4so5711184a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2024 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714593897; x=1715198697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6B3Xf7Y8DtHU8X6ec9fpWeWDMwWUAohTamqd+6jpKk=;
        b=OVfwXoDuMvIqm5QQv0xnKq1/+um4wWVHqkU5H3mB9j4CdpAEi85iebfhytTUbygf5E
         KrKk2SpgGv7Oc7aQZOGNt+LZaAtYNjg36ElUOlTXICrWQ7yEkFpl10u/FeYoIRns1Fll
         FNBlBkkylAHau8vIJNYzcWHwUHaUzxakVHQjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593897; x=1715198697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6B3Xf7Y8DtHU8X6ec9fpWeWDMwWUAohTamqd+6jpKk=;
        b=V72x5ljfvRIfT3q1VyMy0LKWbm1MVvaRjNbNSIFjnprn8l/ztNCK2wvMLFzxYgsFDb
         ued+Itwc32YhiEAF7WjgFf9GOJw0OjHdza9ykhFhKwHpez8ygF8WjdRX6tPwzP8PXrwy
         LHEuksdk2X0piTm3k5sYMyvU5lILLXwxubCGBVdA7iI75//Gg7MEAUm005ZOwIwuMqtK
         8XpMKUBAMstK/0YbUltQIceVIVXRt5rjToG6XtGbVKnj/pq4Qllwl0L7yTfgblBHFj9G
         knvi/7hu/0gF7UzjWAiuQ50MnanVYZPSXyQlN0YbtalfjR/id5ZQb/RvrrLHYs28IS5g
         MEbA==
X-Forwarded-Encrypted: i=1; AJvYcCVRdz9wwYpWXvwN1UVcu1de2izyYzmCPAXM+uyfiyuBZbOcP4A3dqNEKsHe/AROPYcYm2LzBXMDS5Vw84ecXouekqRW6tt+qzWMuyp0vA==
X-Gm-Message-State: AOJu0Yx7M2DiENIf1q6/hh8J8HnAwALHX2Rpe8D9TlEu9ASf8SKEHc8R
	kNWq4dEQj03xrVAYSqkuTYRWKnnBxGRqGUylFP0DD0eFS/fekaQRspFHgJPMBA==
X-Google-Smtp-Source: AGHT+IFueDV9pgqBTe9WW+kzPRkaGYU9e4IIONIKkDrAtl9sg/iZA6URogFxsjQdrbrnVvd332CkkA==
X-Received: by 2002:a17:90b:35c9:b0:2b2:aac3:fc2f with SMTP id nb9-20020a17090b35c900b002b2aac3fc2fmr4036614pjb.18.1714593897495;
        Wed, 01 May 2024 13:04:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id nw10-20020a17090b254a00b002b0e8d4c426sm1729700pjb.11.2024.05.01.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:04:57 -0700 (PDT)
Date: Wed, 1 May 2024 13:04:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
Message-ID: <202405011257.E590171@keescook>
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com>
 <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook>
 <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
 <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com>
 <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp>

On Thu, Feb 15, 2024 at 11:33:32PM +0900, Tetsuo Handa wrote:
> On 2024/02/15 6:46, Paul Moore wrote:
> >> To quickly summarize, there are two paths forward that I believe are
> >> acceptable from a LSM perspective, pick either one and send me an
> >> updated patchset.
> >>
> >> 1. Rename the hook to security_bprm_free() and update the LSM hook
> >> description as I mentioned earlier in this thread.
> >>
> >> 2. Rename the hook to security_execve_revert(), move it into the
> >> execve related functions, and update the LSM hook description to
> >> reflect that this hook is for reverting execve related changes to the
> >> current task's internal LSM state beyond what is possible via the
> >> credential hooks.
> > 
> > Hi Tetsuo, I just wanted to check on this and see if you've been able
> > to make any progress?
> > 
> 
> I'm fine with either approach. Just worrying that someone doesn't like
> overhead of unconditionally calling security_bprm_free() hook.

With the coming static calls series, this concern will delightfully go
away. :)

> If everyone is fine with below one, I'll post v4 patchset.

I'm okay with it being security_bprm_free(). One question I had was how
Tomoyo deals with it? I was depending on the earlier hook only being
called in a failure path.

> [...]
> @@ -1530,6 +1530,7 @@ static void free_bprm(struct linux_binprm *bprm)
>  		kfree(bprm->interp);
>  	kfree(bprm->fdpath);
>  	kfree(bprm);
> +	security_bprm_free();
>  }

I'm fine with security_bprm_free(), but this needs to be moved to the
start of free_bprm(), and to pass the bprm itself. This is the pattern we
use for all the other "free" hooks. (Though in this case we don't attach
any security context to the brpm, but there may be state of interest in
it.) i.e.:

diff --git a/fs/exec.c b/fs/exec.c
index 40073142288f..7ec13b104960 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1532,6 +1532,7 @@ static void do_close_execat(struct file *file)
 
 static void free_bprm(struct linux_binprm *bprm)
 {
+	security_bprm_free(bprm);
 	if (bprm->mm) {
 		acct_arg_size(bprm, 0);
 		mmput(bprm->mm);

-- 
Kees Cook

