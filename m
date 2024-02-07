Return-Path: <linux-fsdevel+bounces-10625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0684CE52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB31C23105
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7C48062A;
	Wed,  7 Feb 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LFw9oKbh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B180056
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320637; cv=none; b=ZJYT0JeHBhxma6coe961CKI/ejlueKvawi91eQlkKesuiH1yZVPMB8yGpaDkfi/bXTow58nPApSLbKgNk2QbGUgdc2qNH/KX3ywMQ1xAKfDYgKCMM5/vGFf1f2n4/xfUB+BSHy05DFSMX00C+p5lNi6UazJBfwmL7KAfSgkPFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320637; c=relaxed/simple;
	bh=0vxjX47B6ZgpdmiW7EVKqCFH/j69PxaUc08wp4q8im8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFurMnCOjAuAYqxvx5SrqaoQSlfb2i18BLSQxAEebcXIGUqgg8GlRUhP1XE2lUbrrjVkHxxpbZLfyYF3/Jo6p2TYobC++iwpKyb0wizTdgjpuW7ZawJHaP92KScPLbteFt3mdyTSn4D7vfNYfPR5RXWWrBQr1WYrTGiAgGpdIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LFw9oKbh; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bda4bd14e2so699417b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 07:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707320634; x=1707925434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fT7OrhiRuIZhNQcmagLUCZ3268l7RImx+viDE+2dBHY=;
        b=LFw9oKbh2lMPICDhaQyxT7pKPlavYRiL/Arlh0g7UTbkmB49L4DnCwYdJbT5m+CHle
         19jOhg/eeC+/hlNcLEpMyGSL8CB1tYivigS0KVsO5Msllav3KxkA2b03joaxYwmto723
         oFigIKI5waEKkAGVZm8OJizZRptX8YVHaLEII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320634; x=1707925434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT7OrhiRuIZhNQcmagLUCZ3268l7RImx+viDE+2dBHY=;
        b=LO8N3QCATRzSzcsPBYDFL+5B6nNSjCCNFxuVVn2yUeQ4hBcZskydfglAT7P99kHMu7
         9G6J0XVwbqwX4Eh/6nfAZxe/KOoSsiwFMtwwjZ6vKKkaKC9xalbpXPBCwQdX/JVyCpm0
         JDjttdZzr5Cddh6hQH9nw+HCpzve8jk9iX6xrvc5CAN2DOSwq8IlKpzJj0K1/E8ynbDm
         7oLBwrYKKV9AVydcoAcdnhZngokMCe3u/1SkFbII6zT2UOR4XNhVTPebw/DluhLO9ETh
         RboSzF6YzeWvGFnfkaR4OQA43ILp5CQLZeYaIJbk80768xheAmuKYM9iPDvIbHDgTK+s
         c1nw==
X-Gm-Message-State: AOJu0YyWC6M5QgYQ1tQiMAqQ9IWGGgs/KkSV65qDFJDP8cQZ/9t+hb+B
	UofARpGcVe12vnH4HiR3s7cdbaLSHan8SCRKn93rqPyJhF3ZA1azwCdva+f3Ww==
X-Google-Smtp-Source: AGHT+IF396kKk0rdy004VVPYDuPYv9DwxzXoOR6Kvm9ziqiHthI/RUMfDBLMi4vfaoIZ2sbm9RevTQ==
X-Received: by 2002:a05:6808:f8b:b0:3bf:ede4:9a57 with SMTP id o11-20020a0568080f8b00b003bfede49a57mr1838228oiw.27.1707320633877;
        Wed, 07 Feb 2024 07:43:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3PuW6ws9JWC7eVxAlbqXnDHKSk0P2YmIzFI97ctOQmNTs+74DKsJKO4wYGBbGfO42/jRaojmBW5kV4n2FT4d0tr8kH7r4aQUxMEmIK9FSpzX0+pIMCA15w2h9wknJ03TotrXxVbFLDDJMb3tAR9UBjBQ1lm3zQBDxElQLAnLBo/q7iMfJqxCY2fmPncMLgWFvGjIAikLYHUGWVzwlMWYm3vHqlpF/gcN/FnIldLYt0SP7xo1Z2wH1mPSDaOXCGzltp29+grXhTvd+rvan/N/uNyiAlByd2IkHMNf8nbgttrAyvF0AHMlcB0xUerECuwe2T0UC7sguw0Id8vwFxFwXiSEbTTEOxQmlnfedeEq8E4MuJEWbwVUt6ROZfmwaV08Ju508ne3sow==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o26-20020a629a1a000000b006e0521c2156sm1834465pfe.173.2024.02.07.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:43:53 -0800 (PST)
Date: Wed, 7 Feb 2024 07:43:52 -0800
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
Message-ID: <202402070740.CFE981A4@keescook>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook>
 <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>

On Wed, Feb 07, 2024 at 10:21:07AM -0500, Paul Moore wrote:
> On Wed, Feb 7, 2024 at 9:24 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sat, Feb 03, 2024 at 07:52:54PM +0900, Tetsuo Handa wrote:
> > > A regression caused by commit 978ffcbf00d8 ("execve: open the executable
> > > file before doing anything else") has been fixed by commit 4759ff71f23e
> > > ("exec: Check __FMODE_EXEC instead of in_execve for LSMs") and commit
> > > 3eab830189d9 ("uselib: remove use of __FMODE_EXEC"). While fixing this
> > > regression, Linus commented that we want to remove current->in_execve flag.
> > >
> > > The current->in_execve flag was introduced by commit f9ce1f1cda8b ("Add
> > > in_execve flag into task_struct.") when TOMOYO LSM was merged, and the
> > > reason was explained in commit f7433243770c ("LSM adapter functions.").
> > >
> > > In short, TOMOYO's design is not compatible with COW credential model
> > > introduced in Linux 2.6.29, and the current->in_execve flag was added for
> > > emulating security_bprm_free() hook which has been removed by introduction
> > > of COW credential model.
> > >
> > > security_task_alloc()/security_task_free() hooks have been removed by
> > > commit f1752eec6145 ("CRED: Detach the credentials from task_struct"),
> > > and these hooks have been revived by commit 1a2a4d06e1e9 ("security:
> > > create task_free security callback") and commit e4e55b47ed9a ("LSM: Revive
> > > security_task_alloc() hook and per "struct task_struct" security blob.").
> > >
> > > But security_bprm_free() hook did not revive until now. Now that Linus
> > > wants TOMOYO to stop carrying state across two independent execve() calls,
> > > and TOMOYO can stop carrying state if a hook for restoring previous state
> > > upon failed execve() call were provided, this patch revives the hook.
> > >
> > > Since security_bprm_committing_creds() and security_bprm_committed_creds()
> > > hooks are called when an execve() request succeeded, we don't need to call
> > > security_bprm_free() hook when an execve() request succeeded. Therefore,
> > > this patch adds security_execve_abort() hook which is called only when an
> > > execve() request failed after successful prepare_bprm_creds() call.
> > >
> > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >
> > This looks good to me.
> >
> > Given this touches execve and is related to the recent execve changes,
> > shall I carry this in the execve tree for testing and send a PR to Linus
> > for it before v6.8 releases?
> >
> > There's already an Ack from Serge, so this seems a reasonable way to go
> > unless Paul would like it done some other way?
> 
> Please hold off on this Kees (see my email from yesterday), I'd prefer
> to take this via the LSM tree and with the immediate regression
> resolved I'd prefer this go in during the upcoming merge window and
> not during the -rcX cycle.  Or am I misunderstanding things about the
> state of Linus' tree currently?

My understanding was that TOMOYO is currently broken in Linus's tree. If
that's true, I'd like to make sure it gets fixed before v6.8 is
released.

If it's working okay, then sure, that's fine to wait. :)

-Kees

-- 
Kees Cook

