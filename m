Return-Path: <linux-fsdevel+bounces-10621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8884CDDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF811F22FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5617FBB5;
	Wed,  7 Feb 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dOKdYlKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031AB7F7EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319280; cv=none; b=YZvLdkppvjboihXp45yiVfdkVG9gJN4pRhZrOMXLwGw1BAoHUBgmucaPan/eo1jh07uGWzaZZtnXz3qvLuiyylgT+VxZ7lyH+6kf0odZ3ZDqOzhyekjCDwLAstG6hl4K/L7qn/0lj38RfXGb+/OVwrx3tm3NdPGJptgLqB4PCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319280; c=relaxed/simple;
	bh=JPR+3qEr1xbqWmLp/7UMRRu35URQqE3BUcnR+vKiBTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdZrEKQvyeHhg5UXrZaFYjgwInTUEHsUwvhgXVrYfmhQlNDzyQPlv/QnT8J+BjnHbtCFAvyoQUW0kPU6o41a4xA+0KgcOX+apN6/mqXKK0tGfZoL9aPhZ6+BFXrK0NwRebaNu6NzXQ/d56hK9Is9ZGwOrx+WRQRs4wXJTDtGtZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dOKdYlKU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60481f30c2dso8600687b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707319278; x=1707924078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd9LzoF3Qcikc6QqNUOfmmz6AfgfuMOnEaN/8Dvg2lo=;
        b=dOKdYlKUIDp9KW4au6XXYa8NsQV5/DwXjUGQTupdIiPQzRPjnGpLVyM8jmrhs7Sp35
         yklzwkkVTLCWYoyE0CqZ7f2d0t9w1m8n6p59+lU1l56hG1CDl2+685KzVT7FKH8xhFn6
         AlXnK616om/p7BJDJNIHc0xNsSzoBS5nYnWc/cZGYrukMRoUbi6a4hhHL5lK0ESL+uiH
         pRu/MIWUd5KAR/sUPv9cUn3Fw7i7OG3NgJNOsN/0DTQ0cxPpaUW5cpp1c08JC5/6f83p
         4qxK1CjnfSdRQgGt2lRcyXUK13WzU8/L1CbeTXu5Lb+KQspJr+0lbTq1yBdohpB1i6Gl
         4mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319278; x=1707924078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd9LzoF3Qcikc6QqNUOfmmz6AfgfuMOnEaN/8Dvg2lo=;
        b=qUzluCpLt1eTrIQvF0b2GsYpII/uhxxCy54kOfQChPlNd2kzUPpt6H1b6M7zlfYXDf
         +vs1WzDKxBIwUXYTFTDX3En6QfwJyY3Tl5c/cSQVYt+RNKT5chyzLwXZoH4DWxtLXfm8
         BvPHg4jtmtvMSOPtdCct3pfxbU+Yf/BsoH3g8XVs/B5Hr3jhM5LIU089DcnfICkihViK
         6U7fdpkBeJScT8phtsQPWw5mYuirhV84d5B+Z9gmTR/XZEXFRvW7ACvFZTYCD+cRnV6o
         qDg5UkXeQI0s67KGhmWY0XQRm4ITNMN3jgll+mJrmUn8FkMnwOtgFf8g5n1WtGM6p1O8
         XF/w==
X-Gm-Message-State: AOJu0YzazgkcFEux4SqpJ/fyV37J3+8ow9NAXo2XtP59noJ2UWRNFiYV
	CdzNkk+s/gG3JUuOvZs20GWif+Og3u3q9bzl2D9QNUi1J2aIGZ6Pq2L70BDZxEGmEKV7K+99Y26
	i4ozELEeQvpoSrTHyXgbhS4LT9hy1BzcGbbD8
X-Google-Smtp-Source: AGHT+IEkvoMMB8s8FTe5701UT+q7iWJTZFp1gA0vH5f2XPg6Xh+N3IH9AX1nXc4sEpNTVPWBiTfsTDHbhRKvBSRjGkk=
X-Received: by 2002:a25:c513:0:b0:dc2:4450:92f2 with SMTP id
 v19-20020a25c513000000b00dc2445092f2mr5130232ybe.22.1707319277895; Wed, 07
 Feb 2024 07:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp> <202402070622.D2DCD9C4@keescook>
In-Reply-To: <202402070622.D2DCD9C4@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 10:21:07 -0500
Message-ID: <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Kees Cook <keescook@chromium.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:24=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Sat, Feb 03, 2024 at 07:52:54PM +0900, Tetsuo Handa wrote:
> > A regression caused by commit 978ffcbf00d8 ("execve: open the executabl=
e
> > file before doing anything else") has been fixed by commit 4759ff71f23e
> > ("exec: Check __FMODE_EXEC instead of in_execve for LSMs") and commit
> > 3eab830189d9 ("uselib: remove use of __FMODE_EXEC"). While fixing this
> > regression, Linus commented that we want to remove current->in_execve f=
lag.
> >
> > The current->in_execve flag was introduced by commit f9ce1f1cda8b ("Add
> > in_execve flag into task_struct.") when TOMOYO LSM was merged, and the
> > reason was explained in commit f7433243770c ("LSM adapter functions.").
> >
> > In short, TOMOYO's design is not compatible with COW credential model
> > introduced in Linux 2.6.29, and the current->in_execve flag was added f=
or
> > emulating security_bprm_free() hook which has been removed by introduct=
ion
> > of COW credential model.
> >
> > security_task_alloc()/security_task_free() hooks have been removed by
> > commit f1752eec6145 ("CRED: Detach the credentials from task_struct"),
> > and these hooks have been revived by commit 1a2a4d06e1e9 ("security:
> > create task_free security callback") and commit e4e55b47ed9a ("LSM: Rev=
ive
> > security_task_alloc() hook and per "struct task_struct" security blob."=
).
> >
> > But security_bprm_free() hook did not revive until now. Now that Linus
> > wants TOMOYO to stop carrying state across two independent execve() cal=
ls,
> > and TOMOYO can stop carrying state if a hook for restoring previous sta=
te
> > upon failed execve() call were provided, this patch revives the hook.
> >
> > Since security_bprm_committing_creds() and security_bprm_committed_cred=
s()
> > hooks are called when an execve() request succeeded, we don't need to c=
all
> > security_bprm_free() hook when an execve() request succeeded. Therefore=
,
> > this patch adds security_execve_abort() hook which is called only when =
an
> > execve() request failed after successful prepare_bprm_creds() call.
> >
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>
> This looks good to me.
>
> Given this touches execve and is related to the recent execve changes,
> shall I carry this in the execve tree for testing and send a PR to Linus
> for it before v6.8 releases?
>
> There's already an Ack from Serge, so this seems a reasonable way to go
> unless Paul would like it done some other way?

Please hold off on this Kees (see my email from yesterday), I'd prefer
to take this via the LSM tree and with the immediate regression
resolved I'd prefer this go in during the upcoming merge window and
not during the -rcX cycle.  Or am I misunderstanding things about the
state of Linus' tree currently?

--
paul-moore.com

