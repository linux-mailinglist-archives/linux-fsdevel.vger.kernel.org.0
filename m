Return-Path: <linux-fsdevel+bounces-8820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E283B40B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E3B228F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F068E135A40;
	Wed, 24 Jan 2024 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lo+4DfvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1991353F3
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132127; cv=none; b=fxlJVRSgQrIGxQQjDiEjAgolnBYfZX/2L+bJImxu1mu12ARiYxMCO16tivct0iu7u/gRIp8xjBYBCD6Jl9KWdN78RBRmEjYEaFmvphtb3oNHMgJIhtnNIE0BcIsx/FYgqyXiTn0M3wR9azJD3+x8owzrzjvfC/cfGntjsjVOBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132127; c=relaxed/simple;
	bh=vy2eQcXuP8J+89WHubqOmUDL6fntpzonJvK8RD/C8Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngkp9UeNVjZoTEUn5KGvnHNU26bMf7Z3G+biUj3msFLDeO/pXPjNFPWMJC/sTtfDGCNi6vyqZJjVaKrjAU6R8yqaq7eyh/f8EdtrPKByzora4Gv71PRzi5uGmzFSIK59ZQx8wMJaBXdmVlV4D7JvHyp6DEDLWO1HGjXGxoxnHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lo+4DfvP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d74045c463so28784775ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 13:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706132124; x=1706736924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R02kkjm9zZZALeIAu8OyIiBbwYldvv1po8aujCvgxCc=;
        b=Lo+4DfvPcbZAIp9UbKEWYLXIJIcEicEMgfszjEA+dHd4meIfvchp0cmxZPFJi4cdDC
         VvT1GBoOV/cELPKOvtssF0J0xP7v/Pxl0SlcC+YOxsJ+TUkS7cFz8PwzoQgwJmCFUSPG
         fXhWOnwqf7/ylOBk9aydYvu1MyYRXDIun8LRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132124; x=1706736924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R02kkjm9zZZALeIAu8OyIiBbwYldvv1po8aujCvgxCc=;
        b=DV7p4nck8qADVoUx1ymWmOf5PkQn7iXUvMA+QcGnI8HuTCgIZZUIK1o5+ikByusmgg
         MlzXbw9D6u6l8xOxC/HmjOX0BzEVAgZks/7yUEyKGw5THqG8V6Af29A/KHVBLDxI4P32
         KEtddzFsbkKwzomq+Q+LilCYBQ+ez5Gp2OKJVp7Im0MDaux9i4+RVXYlN2UbspFD+JEe
         Uo4f4co+Q9ZimmJsDBbKVgQNWGRLZqmWuqb2oFAE6rE13egYCltGo/CwrydWlTEVMkuA
         s/BEQfXmc2gzvWYEy6uTDfZZDhxy9l/VdE3lWCPdGxCG6p0JbWKss956BehUlUnXieT8
         nBUg==
X-Gm-Message-State: AOJu0Yzr5/d4cT6uXA1emLMwL2sTrcr3ArwAc1W3iZ2iVyeyXTbEr/ro
	qbEqxDFfHYniNy+5KhAdByysdF/VHAFy1i0r2y5DvJQ0vBOE6lxT0Qd/N8KrsQ==
X-Google-Smtp-Source: AGHT+IHcICz0Mfn9SvjnkuBQXJnezLd9Usm4kNxOTm+k+tyC0AhF5zlKsrJeWSD40yUZv9HJJFvwgg==
X-Received: by 2002:a17:902:ee0c:b0:1d5:b82a:939 with SMTP id z12-20020a170902ee0c00b001d5b82a0939mr16459plb.125.1706132124053;
        Wed, 24 Jan 2024 13:35:24 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mj11-20020a1709032b8b00b001d73a2acc2bsm6701572plb.142.2024.01.24.13.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:35:23 -0800 (PST)
Date: Wed, 24 Jan 2024 13:35:23 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Josh Triplett <josh@joshtriplett.org>,
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
Message-ID: <202401241334.670AFDD@keescook>
References: <20240124192228.work.788-kees@kernel.org>
 <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
 <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
 <202401241310.0A158998@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401241310.0A158998@keescook>

On Wed, Jan 24, 2024 at 01:32:02PM -0800, Kees Cook wrote:
> On Wed, Jan 24, 2024 at 12:47:34PM -0800, Linus Torvalds wrote:
> > On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> > > CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.
> 
> For completeness, Fedora hasn't had CONFIG_USELIB for a while now.
> 
> > Well, we could just remove the __FMODE_EXEC from uselib.
> > 
> > It's kind of wrong anyway.
> 
> Yeah.
> 
> > So I think just removing __FMODE_EXEC would just do the
> > RightThing(tm), and changes nothing for any sane situation.
> 
> Agreed about these:
> 
> - fs/fcntl.c is just doing a bitfield sanity check.
> 
> - nfs_open_permission_mask(), as you say, is only checking for
>   unreadable case.
> 
> - fsnotify would also see uselib() as a read, but afaict,
>   that's what it would see for an mmap(), so this should
>   be functionally safe.
> 
> This one, though, I need some more time to examine:
> 
> - AppArmor, TOMOYO, and LandLock will see uselib() as an
>   open-for-read, so that might still be a problem? As you
>   say, it's more of a mmap() call, but that would mean
>   adding something a call like security_mmap_file() into
>   uselib()...
> 
> The issue isn't an insane "support uselib() under AppArmor" case, but
> rather "Can uselib() be used to bypass exec/mmap checks?"
> 
> This totally untested patch might give appropriate coverage:
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index d179abb78a1c..0c9265312c8d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -143,6 +143,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>  	if (IS_ERR(file))
>  		goto out;
>  
> +	error = security_mmap_file(file, PROT_READ | PROT_EXEC, MAP_FIXED | MAP_SHARED);

Actually, this should probably match was load_shlib() uses:

                        PROT_READ | PROT_WRITE | PROT_EXEC,
                        MAP_FIXED_NOREPLACE | MAP_PRIVATE,

-- 
Kees Cook

