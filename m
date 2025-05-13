Return-Path: <linux-fsdevel+bounces-48892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05C2AB558A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640CD1B4675F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8328E570;
	Tue, 13 May 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1uTxtXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E11213E7B;
	Tue, 13 May 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141568; cv=none; b=mHDKCvoF+Le1ezBPq0XAeKFH6ef88l/lHcMmMiN+mH+tOjdjbohoepjA6mAtc/erKIzyILuMPf12yhDtVKhMAgk2fkpItpvitb//hw1Rv5JxE4k7RIdZhLJZVISL4snan/fAUEY7EH7WNoq77jntKQsJ4/RUZBwUcJpLV3+9hfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141568; c=relaxed/simple;
	bh=4fLD3IdpP6vVXk5/ruBLYk1VyIiGZZJk/ofEm9ybJRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoxqzNqeYJRbm7WXcCa9WSdVDD3Y+X5S/+jbQHmRQnnimF5+/ZKvJF55lq5NmtgNSLpWZKJXOo+77C2WdQ5mB9+ylhmFO5sZRmvK9RwJOxlDLj4Tx6O633WP5S30bq/fvOG+IiOlMkOkk1WaIQWwD6LmbcAig+zDYPtblT/RBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1uTxtXd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so60229885e9.3;
        Tue, 13 May 2025 06:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747141565; x=1747746365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRH4yaq02O4BeoAY/f143mbK8AEXX3uy5ZGAgLBp4KM=;
        b=b1uTxtXdEL1CpB9GB9s/MxPZooV74EiNWTkmBIyRmFx+WivrFCOa31emAxZgdeByUH
         czRXlcm3yilGhLl1kGSUoAqxcne7UjheRZi0kTY8/yq2YvVfu6JRQGLBlEZyjxH4sYOI
         rSLXo291wCzaOmXcmip3uHWqkB0oey1pho3SWBHQOwwCr5FimFbe+vpno0Y+fAwEVlyq
         In2Y/DlZy2y4pw2aNnqhsZjST0k7nS8oSTlwe3cUTI6pBkOOkE6fVoY4NC8psJElB57Z
         PlQPwg3H1S4EtNzF7nNHbjDGwmznBQ7RJdHAmWpft7GSeq8Jj1kBVJDJ/kZiSmADtgKu
         +1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747141565; x=1747746365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRH4yaq02O4BeoAY/f143mbK8AEXX3uy5ZGAgLBp4KM=;
        b=vXYwy691JWJQHFtl0Ygndj5I8rCES7a9XSF0fspTgv3RY6ZnVeKdcJcDdb3ZTFX9Sj
         mVCvhzmPvIqs9p1RuDvl5T49e4XVvQXIIRbY3b8tGJZLRr0Q3dsFtV1Y+ZbZle6H2pbg
         PzPYqepL5InfO/4SQHBoxxTT9ng1vEMpb2p7WWBCuykqlQe+pTM4Coi+DHFj8lbRvxP3
         lYVdFDteCz75EYI/l/ZAAhWzpKaR/Jz9F9ud67kPFAWG2vawZFQuj0t4xzUitOXd99YF
         ILG1DtyZoIu0XMXxkWJGI9B19/fXYFhUiujrDUOJQrLajaTzPFv9YktxGVbx440YJpjD
         47NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQj1AqNjfbShJPeuBRR3he6ldDnjmFw0bNnvQY+vKJkHrsnC70XiQJejxrW2R5eo5N6PEshIobFQ==@vger.kernel.org, AJvYcCUrRoHuvBMJm6MewTz/+ucP/USOSWhzs5fzWYIE/NME0hpo+9bpBGfFEZpbpeskJGmUQEL6v8v00phQMYwVvOJT9P51aAHZ@vger.kernel.org, AJvYcCV27BitRMclAabnLBhxFlC5YeIAslDtiKTshl3PW1YyZI47djPROpw+zdaTiOH5RSOdjwC1OaL43oQhtN26@vger.kernel.org, AJvYcCW6EPEpNpkBvbs3cJLTH0heEhkSKJOp/R3K8vHwSlwvglRX9LEsn0J7iruVwib3glPZPrw15CSWF0VOw6lMNzKG@vger.kernel.org, AJvYcCX4PoeikKYvo5jEogD3efWqeZzBBGontK9LesojPOw2vFsuJm+xt50XGzg/ENaG8M46uTlqoZPuARooAAIN@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvl3MzTPi5ZAFCws0LAeGyXtUW8Fhhadv9dYhEsiK17KslpIP
	H97BNdG6N2/WnKbUFEqIAGUtaz9ocvcxhxj7YIpq1ELAfrnuPi8Q
X-Gm-Gg: ASbGnctw8DIkJfG6mnWVAdBH/y9iPaqqCc2bbEgsTDLyx/71U2QYvbDFsqolt3UZ78g
	GsSMOVNRr3bOh7ALwEGrI63K1tymd6XsOr1pBCM/FUi1yUXoDul56rpZuJ/JGBsxkb1GfXfejqq
	ZVkHfML2YZWRVvl3lfVrjOT7FdR22YDzzmcw1Hp1eCDYK3RtQ554pBO4UQt8uieT6IEwrWUbonD
	qq31RS3UQEM1oontSWYViBVfHm8pbx9PIFbEtTYwQvBLQ8CPjBFQffNSu/H43OSaPXU3M71OoZ2
	yNTUTL4IaAdJHYJxOSgEHL1AxKW2TKzUIFgSIaPpD0YJDyN1Op/tzT5Gi/wy4HyF
X-Google-Smtp-Source: AGHT+IEHBhhE7TvsAD/FnNo4BJJ0fgMjXWx6eOMY8JlawqVvxffhuMX7kttizQAJ+g7X01ahmWKKUQ==
X-Received: by 2002:a05:600c:3587:b0:43c:fdbe:43be with SMTP id 5b1f17b1804b1-442d6dd216fmr140842115e9.27.1747141561377;
        Tue, 13 May 2025 06:06:01 -0700 (PDT)
Received: from f (cst-prg-88-99.cust.vodafone.cz. [46.135.88.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f3c2sm209934765e9.15.2025.05.13.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:06:00 -0700 (PDT)
Date: Tue, 13 May 2025 15:05:45 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jorge Merlino <jorge.merlino@canonical.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, 
	Andy Lutomirski <luto@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, 
	Richard Haines <richard_c_haines@btinternet.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Todd Kjos <tkjos@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Prashanth Prahlad <pprahlad@redhat.com>, Micah Morton <mortonm@chromium.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-hardening@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
Message-ID: <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org>
 <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
 <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>

On Thu, Oct 06, 2022 at 08:25:01AM -0700, Kees Cook wrote:
> On October 6, 2022 7:13:37 AM PDT, Jann Horn <jannh@google.com> wrote:
> >On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.org> wrote:
> >> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
> >> > The check_unsafe_exec() counting of n_fs would not add up under a heavily
> >> > threaded process trying to perform a suid exec, causing the suid portion
> >> > to fail. This counting error appears to be unneeded, but to catch any
> >> > possible conditions, explicitly unshare fs_struct on exec, if it ends up
> >>
> >> Isn't this a potential uapi break? Afaict, before this change a call to
> >> clone{3}(CLONE_FS) followed by an exec in the child would have the
> >> parent and child share fs information. So if the child e.g., changes the
> >> working directory post exec it would also affect the parent. But after
> >> this change here this would no longer be true. So a child changing a
> >> workding directoro would not affect the parent anymore. IOW, an exec is
> >> accompanied by an unshare(CLONE_FS). Might still be worth trying ofc but
> >> it seems like a non-trivial uapi change but there might be few users
> >> that do clone{3}(CLONE_FS) followed by an exec.
> >
> >I believe the following code in Chromium explicitly relies on this
> >behavior, but I'm not sure whether this code is in active use anymore:
> >
> >https://source.chromium.org/chromium/chromium/src/+/main:sandbox/linux/suid/sandbox.c;l=101?q=CLONE_FS&sq=&ss=chromium
> 
> Oh yes. I think I had tried to forget this existed. Ugh. Okay, so back to the drawing board, I guess. The counting will need to be fixed...
> 
> It's possible we can move the counting after dethread -- it seems the early count was just to avoid setting flags after the point of no return, but it's not an error condition...
> 

I landed here from git blame.

I was looking at sanitizing shared fs vs suid handling, but the entire
ordeal is so convoluted I'm confident the best way forward is to whack
the problem to begin with.

Per the above link, the notion of a shared fs struct across different
processes is depended on so merely unsharing is a no-go.

However, the shared state is only a problem for suid/sgid.

Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct is
shared. This will have to be checked for after the execing proc becomes
single-threaded ofc.

While technically speaking this does introduce a change in behavior,
there is precedent for doing it and seeing if anyone yells.

With this in place there is no point maintainig ->in_exec or checking
the flag.

There is the known example of depending on shared fs_struct across exec.
Hopefully there is no example of depending on execing a suid/sgid binary
in such a setting -- it would be quite a weird setup given that for
security reasons the perms must not be changed.

The upshot of this method is that any breakage will be immediately
visible in the form of a failed exec.

Another route would be to do the mandatory unshare but only for
suid/sgid, except that would have a hidden failure (if you will).

Comments?

