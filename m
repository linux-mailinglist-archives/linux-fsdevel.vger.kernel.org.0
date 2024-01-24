Return-Path: <linux-fsdevel+bounces-8823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722583B444
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF01C234AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A1A13540D;
	Wed, 24 Jan 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJtreffx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEFC1353FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133033; cv=none; b=g6fGGF97tdgU2Qu5M5spd+qJe9F636rHlk0SHDSUVwOQ/iwQ+t29SSMlOV0R/0GiaJsMPaNcHz1rUxbyJ4l4KUw1cXY/S3Eca4Ah/xo+YZ7zAjOJ51pJtIknpytjXSu0amHemExXAs6dOerm9n4kvY2ODhq1m8Whjsb9TQmLm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133033; c=relaxed/simple;
	bh=SNtidvVWr3ZZm0wIjg04hCXZO3neNf7MHZC1Z9rW0HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP3xWjVA1DHMrXJ/KgwDMvOA5M+eIZaiTLQsvSCXXxCpe0d32kfAzd/0z0noTgL9ig12nYdpSz+f9g+bM9jSPpeOvKY/4FuXRKgx+JzeNSGrddpJWLAXp0k6nzfdJqign2MjJV51Ybu53NcBHMNv3qYoiFkqsj5R4wE7dt8ezdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WJtreffx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7859efea5so7065965ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 13:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706133031; x=1706737831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKbTsnLJkm2iKuMS9jJ6ekbfLtHs2opAYqk/RqQaX2k=;
        b=WJtreffxv2wnpnJN18ddmiRCAwxPEraYOayWdQsD4h31yIxDxwhAlcfDv77CcWsG57
         6w0we8RZsPbaxhDbKN9W7as0PnRPME3TUpic853CnEmY4yCT6aIOCq/ZaHFgSfjspwjM
         ZKJ3NU1rYre6ruPLqZ5vaY23oEcBAGbnDJM8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706133031; x=1706737831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKbTsnLJkm2iKuMS9jJ6ekbfLtHs2opAYqk/RqQaX2k=;
        b=CVmt7jSM/J8vyUvjaBSSJEFXtsPB7lyMu9WY7sg6tLGfCLVAD6BKaNwv+Y9zm95J4u
         haEzKyqaVTW0dSHqMc1dmPio2kD5IfqjKM1jvkFf21yMZSBVY1lZW539p957FgN1VgeM
         tNtE4E0yJeNZejv37laHQd+0tc90GlsNGQB8gtWRMlzgMCp64PMhx0y8i5a+IrQ/9bV/
         3MXfdfcSrgWZnD/+PQT4413aiqHApohAwY6x2prF6WBIA+gPMyQtzu0WxPn/lQ1aOCL+
         jH4xLNOMNraFgw/kZYc3BCglQTLjjaG8ftMSBxc4XqJbelaP6kKpF/EclQa/RmaHSqTZ
         oBrg==
X-Gm-Message-State: AOJu0YzhlggPtLG+PAeMQYpymsbr5HQSRmUX7INjvvaqeOz1e1pQL1eu
	fmZN7VTqEHlg4oLAc858G74fKb7NP6/IXVWvAofnCwHYOnUrpNiYs3m0gIIV1w==
X-Google-Smtp-Source: AGHT+IETCk9PNhDkJerT9hVfN75xLknukOIbsiWCq7ni0ocP8Kl19XxlMkq1LihioaB/wGqFl79jjw==
X-Received: by 2002:a17:902:ce83:b0:1d4:bba1:bc61 with SMTP id f3-20020a170902ce8300b001d4bba1bc61mr22180plg.119.1706133031248;
        Wed, 24 Jan 2024 13:50:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jl16-20020a170903135000b001d75cf0e039sm4692075plb.18.2024.01.24.13.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:50:30 -0800 (PST)
Date: Wed, 24 Jan 2024 13:50:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
Message-ID: <202401241348.1A2860EB58@keescook>
References: <20240124192228.work.788-kees@kernel.org>
 <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
 <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
 <202401241310.0A158998@keescook>
 <CAG48ez1tcxtEwWgxSUqLDcYbrkY=UM3hz22A0BTvTYq4BGpM8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1tcxtEwWgxSUqLDcYbrkY=UM3hz22A0BTvTYq4BGpM8A@mail.gmail.com>

On Wed, Jan 24, 2024 at 10:40:49PM +0100, Jann Horn wrote:
> On Wed, Jan 24, 2024 at 10:32 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Jan 24, 2024 at 12:47:34PM -0800, Linus Torvalds wrote:
> > > On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> > > > CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.
> >
> > For completeness, Fedora hasn't had CONFIG_USELIB for a while now.
> >
> > > Well, we could just remove the __FMODE_EXEC from uselib.
> > >
> > > It's kind of wrong anyway.
> >
> > Yeah.
> >
> > > So I think just removing __FMODE_EXEC would just do the
> > > RightThing(tm), and changes nothing for any sane situation.
> >
> > Agreed about these:
> >
> > - fs/fcntl.c is just doing a bitfield sanity check.
> >
> > - nfs_open_permission_mask(), as you say, is only checking for
> >   unreadable case.
> >
> > - fsnotify would also see uselib() as a read, but afaict,
> >   that's what it would see for an mmap(), so this should
> >   be functionally safe.
> >
> > This one, though, I need some more time to examine:
> >
> > - AppArmor, TOMOYO, and LandLock will see uselib() as an
> >   open-for-read, so that might still be a problem? As you
> >   say, it's more of a mmap() call, but that would mean
> >   adding something a call like security_mmap_file() into
> >   uselib()...
> >
> > The issue isn't an insane "support uselib() under AppArmor" case, but
> > rather "Can uselib() be used to bypass exec/mmap checks?"
> >
> > This totally untested patch might give appropriate coverage:
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index d179abb78a1c..0c9265312c8d 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -143,6 +143,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
> >         if (IS_ERR(file))
> >                 goto out;
> >
> > +       error = security_mmap_file(file, PROT_READ | PROT_EXEC, MAP_FIXED | MAP_SHARED);
> > +       if (error)
> > +               goto exit;
> 
> Call path from here is:
> 
> sys_uselib -> load_elf_library -> elf_load -> elf_map -> vm_mmap ->
> vm_mmap_pgoff
> 
> Call path for normal mmap is:
> 
> sys_mmap_pgoff -> ksys_mmap_pgoff -> vm_mmap_pgoff
> 
> So I think the call paths converge before any real security checks
> happen, and the check you're suggesting should be superfluous. (There
> is some weird audit call in ksys_mmap_pgoff() but that's just to
> record the FD number, so I guess that doesn't matter.)

Yeah, I was just noticing this. I was over thinking. :) It does look
like all that is needed is to remove __FMODE_EXEC.

-- 
Kees Cook

