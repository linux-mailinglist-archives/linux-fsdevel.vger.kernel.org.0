Return-Path: <linux-fsdevel+bounces-8819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C283B3EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA2E28632E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB551353F8;
	Wed, 24 Jan 2024 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dRQETGO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151D12BE96
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131926; cv=none; b=BjbqT0TNQda9AdKUPG5+4H5zmx7mMSZPl35zxW9PG477+Ync36SY5Yi5tQuVYmmgCD+FGPtP+m72rguAAJeGaZ9CnA7WQny0VHrjYn4Kig0rRqjLog98ES+jA2T/SGiUOrkLN2nqXPj2kQPzD83qLecWH2hIFQ615vGJTHXAzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131926; c=relaxed/simple;
	bh=5M9uXjAyU3GmwSAcbZBmOIyLRne4uR5a8GDRX0W6Mt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evOFRALsGiIoXT8CZlqQ77dE3AXqfFzUFScVR4teZuAzYFd2AuawiC96JV6qr+4kvzRDO54VAIb920Hcbx3B/lNv6BKUtlpYKwaSy6FaLu6Q7JZcO1Wc0VhH9lJuT0UzY4hofTIHkqtIeOQdLpJXMbMgdOQDOow96a/4tczvjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dRQETGO7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d6ff29293dso41809925ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 13:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706131924; x=1706736724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZl55Py4L+cX7dTYmA9QG7BMCagLiQPFiTbbjgmBFt4=;
        b=dRQETGO7FnwFg8+yI8RCgd9+n5i3i+pTDaMLbL7fivitpnAl1Np5qCjmKri+CFGaEa
         /KT+84zRI5IXupiR96cMHmuuTOUac4tFsStaMPaN8oVwuwoqFG+8aGUZE+eKDtdlVgrs
         3FzTQA7OIl1PFE2K/whZsnukzAtqagkiXLKAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706131924; x=1706736724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZl55Py4L+cX7dTYmA9QG7BMCagLiQPFiTbbjgmBFt4=;
        b=WptY20wtxVvcNyKWT3Aim8H5ZzJYBHxfX1vSe5sM7SEYXutbEnMk9Y/cL4P35zVJwj
         PvTN/YJicHWZT5vAMm02oObxDkuhIldbS3qsASkfwFqzcK8/vobw6OccGBSDvBSTcMqh
         dQPEBi+Lcbg4UIgPEe2rP1SFOHCHuXB96HcgSDM1BQgmURK8ymS+E/STIieuOvTR+Gic
         JVOnziQF6Nc1R4VNrzic2B4njsRtIHKCyWPXaSUDfeUBPQiyY1I68di7JjPGlORPWl8N
         GkqFCNrymAXkfEF3ngqH3IihYWG2WqU9oMFsnqBCjugcswiQUAUREfyll0l9F/7V+55t
         HPmA==
X-Gm-Message-State: AOJu0YyD32fTsiAW6kGPa34gYW3WyZ5qyioHnkCn/80a5kDLsFJdi/sx
	LmLoCmwtkkT6LDsBFSJ/FtMgxjpCY/qnLOdi1Nt3HvrMCpLXfbBWccSScIQ8RtEiiOSZqqCrI9Q
	=
X-Google-Smtp-Source: AGHT+IHG/m3jUrCwz1WR7nv7Vtv0Ytnd4VINI5aC54EhqBwHd/tZzwvFvQAGR+utJefrE8TrLXq/rw==
X-Received: by 2002:a17:902:dac8:b0:1d4:4fc6:8d9 with SMTP id q8-20020a170902dac800b001d44fc608d9mr28810plx.60.1706131924170;
        Wed, 24 Jan 2024 13:32:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001d4ac8ac969sm10831633plh.275.2024.01.24.13.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:32:03 -0800 (PST)
Date: Wed, 24 Jan 2024 13:32:02 -0800
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
Message-ID: <202401241310.0A158998@keescook>
References: <20240124192228.work.788-kees@kernel.org>
 <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
 <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>

On Wed, Jan 24, 2024 at 12:47:34PM -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
> >
> > Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> > CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.

For completeness, Fedora hasn't had CONFIG_USELIB for a while now.

> Well, we could just remove the __FMODE_EXEC from uselib.
> 
> It's kind of wrong anyway.

Yeah.

> So I think just removing __FMODE_EXEC would just do the
> RightThing(tm), and changes nothing for any sane situation.

Agreed about these:

- fs/fcntl.c is just doing a bitfield sanity check.

- nfs_open_permission_mask(), as you say, is only checking for
  unreadable case.

- fsnotify would also see uselib() as a read, but afaict,
  that's what it would see for an mmap(), so this should
  be functionally safe.

This one, though, I need some more time to examine:

- AppArmor, TOMOYO, and LandLock will see uselib() as an
  open-for-read, so that might still be a problem? As you
  say, it's more of a mmap() call, but that would mean
  adding something a call like security_mmap_file() into
  uselib()...

The issue isn't an insane "support uselib() under AppArmor" case, but
rather "Can uselib() be used to bypass exec/mmap checks?"

This totally untested patch might give appropriate coverage:

diff --git a/fs/exec.c b/fs/exec.c
index d179abb78a1c..0c9265312c8d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -143,6 +143,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
+	error = security_mmap_file(file, PROT_READ | PROT_EXEC, MAP_FIXED | MAP_SHARED);
+	if (error)
+		goto exit;
+
 	/*
 	 * may_open() has already checked for this, so it should be
 	 * impossible to trip now. But we need to be extra cautious

> Of course, as you say, not having CONFIG_USELIB enabled at all is the
> _truly_ sane thing, but the only thing that used the FMODE_EXEC bit
> were landlock and some special-case nfs stuff.

Do we want to attempt deprecation again? This was suggested last time:
https://lore.kernel.org/lkml/20200518130251.zih2s32q2rxhxg6f@wittgenstein/

-Kees

-- 
Kees Cook

