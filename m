Return-Path: <linux-fsdevel+bounces-8814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E8E83B32D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E8283869
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964F134756;
	Wed, 24 Jan 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YnkeMOQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0455134740
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129279; cv=none; b=R13WJUlUxLwcFRga/fUpTMkvKMJ8LZUK93lvzxOzumwXWBA82kNP/APCVr5GZ9+uUAipOPmCiMhl9gjDQDdBi8wEug+LN9cewxC7Pi4Hyq/GsGw7/UCJ0GfPRoSkOVte9KwciAQ7LIOmOZGxKDKmSlbbxhdFON1rKegUOZwVI8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129279; c=relaxed/simple;
	bh=7cPnVJTTwAqS5m/D9fwBaWJXEtqGZq8IcE/AOficsKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egU+/eKbb5fAJjqdLVGRn2cRCWjFdgZhsASVDJKFJ9ccfaq4wpCFt4Va+IqTUDQV9Q1sEnlxtg5duXTDpWZ8um8btNMqs5NjjXGrSRLvkvObDWsK/m9vS00hbjh0vqVrd8YYcwxZuvVCuyhuZnTDZWkFgG42GW2p9UjIns9gMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YnkeMOQP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e76626170so65473075e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 12:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706129273; x=1706734073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk3ry+wMmO/dN2zz3UHRD0lGEi4syprX1/TUT7irM/o=;
        b=YnkeMOQPe4m5grduY3ML49cp1V6TQEZ8/WAXrhcdpjomsFSMM3GhT5nQ+hcqv7Tta+
         hd7W73nWI1F1vyNGBYxRhp19a8kD3T5prqxJ1Tjs05//MXsYHM2bANw5wFZEZRf9F0qU
         kSm+YkwNNZ9p2uiZl84Tew61wP+x9ru1IMHgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129273; x=1706734073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk3ry+wMmO/dN2zz3UHRD0lGEi4syprX1/TUT7irM/o=;
        b=GTbCkFf8Y6h1srF1eiEm4Aq3aQ/qEcPHL/BEhxocUBUpGskMwS0NE/0DNPPStdjs/J
         At2pdFq0PoU8cfR7IINPDyo9ecZvR5OPzOhWJbXoMlUq48JvIv+nMebOSVC5uLh/QyDj
         iuXCy299+PyUgk/6yI7Ea6x41/SSTvb+CD1ARb5x9SsrS6MGP1BBWiL8JoRCRV9awKGK
         Kxl8B4mEkVsyf0JI6VFKZn2pKc/Xqk1f1FjmEBGPlIoGjso6mP08vYgOzfqwZvgmaKXS
         eMI7+vsfiFDzAfvuGgWqxybMvSLRl3+wNLFDGwoeaOPH0bwG5Ta+n6N0Odt9pR0Omw0c
         O3rw==
X-Gm-Message-State: AOJu0YzgdRooHoxkaAuzHA6c7GMtH+Liz8BvT6Cqq/SNYZBaSXJRMOKI
	3CXPy8BwJA+eHfFi4yJkDrMH8xFTUYhjRr6K2HjVYYhKZAi9sRxF4u7K8Zua09lYVWTxy7KDNnD
	YxW61Gg==
X-Google-Smtp-Source: AGHT+IH3qX5SVI8LFR+vCVykQaA4raUN5lpjm5B3viwTsoDsCLgR2Z4PmTYrWw1ZwMf4sQYC3RZWlw==
X-Received: by 2002:adf:f0d2:0:b0:337:5280:a2c with SMTP id x18-20020adff0d2000000b0033752800a2cmr730753wro.85.1706129272720;
        Wed, 24 Jan 2024 12:47:52 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id qx28-20020a170907b59c00b00a28a297d47esm251375ejc.73.2024.01.24.12.47.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 12:47:51 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso65641665e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 12:47:51 -0800 (PST)
X-Received: by 2002:a05:600c:4ec9:b0:40e:a3aa:a463 with SMTP id
 g9-20020a05600c4ec900b0040ea3aaa463mr1545745wmq.20.1706129271244; Wed, 24 Jan
 2024 12:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
In-Reply-To: <202401241206.031E2C75B@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 12:47:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Message-ID: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, Josh Triplett <josh@joshtriplett.org>, 
	Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
>
> Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.

Well, we could just remove the __FMODE_EXEC from uselib.

It's kind of wrong anyway.

Unlike a real execve(), where the target executable actually takes
control and you can't actually control it (except with ptrace, of
course), 'uselib()' really is just a wrapper around a special mmap.

And you can see it in the "acc_mode" flags: uselib already requires
MAY_READ for that reason. So you cannot uselib() a non-readable file,
unlike execve().

So I think just removing __FMODE_EXEC would just do the
RightThing(tm), and changes nothing for any sane situation.

In fact, I don't think __FMODE_EXEC really ever did anything for the
uselib() case, so removing it *really* shouldn't matter, and only fix
the new AppArmor / Tomoyo use.

Of course, as you say, not having CONFIG_USELIB enabled at all is the
_truly_ sane thing, but the only thing that used the FMODE_EXEC bit
were landlock and some special-case nfs stuff.

And at least the nfs stuff was about "don't require read permissions
for exec", which was already wrong for the uselib() case as per above.

So I think the simple oneliner is literally just

  --- a/fs/exec.c
  +++ b/fs/exec.c
  @@ -128,7 +128,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
        struct filename *tmp = getname(library);
        int error = PTR_ERR(tmp);
        static const struct open_flags uselib_flags = {
  -             .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
  +             .open_flag = O_LARGEFILE | O_RDONLY,
                .acc_mode = MAY_READ | MAY_EXEC,
                .intent = LOOKUP_OPEN,
                .lookup_flags = LOOKUP_FOLLOW,

but I obviously have nothing that uses uselib(). I don't see how it
really *could* break anything, though, exactly because of that

                .acc_mode = MAY_READ | MAY_EXEC,

that means that the *regular* permission checks already require the
file to be readable. Never mind any LSM checks that might be confused.

           Linus

