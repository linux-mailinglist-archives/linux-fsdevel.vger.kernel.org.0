Return-Path: <linux-fsdevel+bounces-67141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B096C3614E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 15:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB221A227CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A2432D0EB;
	Wed,  5 Nov 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLG4m9XW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A332D0E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353282; cv=none; b=QjAa1B9sHfl46pa3HQ6vyM/Dr+Ulv8sGzJp93HHasBRK7ACxmNB/zXQXTtxzdy4RDx4IeC/MwMVXZQXFGpdEFb30Kz+DYS83QIUIJ+MfMcxZ5jEi+lfUIx7dGcfVFgguJjeyS7hb/TV/kX7iUDJ9sJAUJzh9cMmLINxizMkgFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353282; c=relaxed/simple;
	bh=Lws3O9Q9eWUWHaR1D9jjGEWwx/Fg3c+pD6vwOq6VklQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnexFXwsDFy0narDb1Scn8gdHk5MUIbMLMG/91zvWsAYpC7fk2yZ3nYBYctLf5VSXd6p66o0Y+RFUrJFlvqrfQ652ecmos7Bh+l+Kyyh/CTuYB1qJQv+5RX/m4sKuofGEyNB1hD8A+yzmezXPzvlvNoUHqu1bOuaKSbkFO/xg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLG4m9XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72CBC116D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762353281;
	bh=Lws3O9Q9eWUWHaR1D9jjGEWwx/Fg3c+pD6vwOq6VklQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eLG4m9XWoTatrjavqtssn5k+xGF+Fior9Mu79vwdT032JLGEUoettavt8SEZnnlXQ
	 9TpVlHTRxRu42t45fqw9RT+vYwqSodHrasC29GJeriemWw5Se8fEiK0NaOD+mePinx
	 tECspgx27qGDxe3gA4E6QzWFA8NcAA1Rwf0PSlARHodGAN338DPS1PsA0tD2s/wdyB
	 GZ6icgXQC4z0vi3T+L+xYt2Ew9F06RYntrZ8rrKcQuyB0nxWl1YBKnmRNmG71c/gvB
	 r3eaOQIw1j6a8/CnIwO1nR4uI8bl59odYarSWc86IqMB63UAFXo9z5X3R3kHrMYjN6
	 2ZhagdvxF+Nog==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37a492d3840so14344721fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 06:34:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2XQpENflU1P5RqK0Y9iiWEzx5fIi54YwDEaIWYd2rnWm1Jv1VFjAvSZpkfLkFNiDYQbTx41ZPAK6lHKRQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf39F4rthDzeseVo52UFPr1Q03jBq+v+j18HL9IssDaOLCwl86
	MMWTMlP5TFtv2pckF4LrRUoL+ZCzJ1r0vW3NwOw5xL2P+GIBI9oh0kow9hLW0f6YO1mFhn8dk/U
	Aj467QZu3Z4+sLo9hLZoLKMsA+YI3g5M=
X-Google-Smtp-Source: AGHT+IEx5VuhTUzWGT5C3xk1ZCwXIz0HqLNQc4gHIQEVN/RV4yl9TQkUcvj3QI9yqUVwVZWCqZOKOmWyJ6CMatr8gc0=
X-Received: by 2002:a05:651c:1504:b0:372:904d:add4 with SMTP id
 38308e7fff4ca-37a51417cf6mr11398531fa.28.1762353280238; Wed, 05 Nov 2025
 06:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk> <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV> <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV> <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
 <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
In-Reply-To: <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 5 Nov 2025 15:34:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEt1i=4iGaum9MoQWMJT55LYxUd6=f+x=NKGCgz5vL4TQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnxYKD_q_DEqIXXuAAuvtynWG7mNNaOqPYQs_wBysPbMIk9Lu8V4S9c-i8
Message-ID: <CAMj1kXEt1i=4iGaum9MoQWMJT55LYxUd6=f+x=NKGCgz5vL4TQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/50] convert efivarfs
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net, 
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 12:48, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Oct 30, 2025 at 02:35:51PM +0100, Ard Biesheuvel wrote:
> > On Wed, 29 Oct 2025 at 20:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Wed, Oct 29, 2025 at 02:57:51PM -0400, James Bottomley wrote:
> > >
> > > > I think this all looks OK.  The reason for the convolution is that
> > > > simple_start/done_creating() didn't exist when I did the conversion ...
> > > > although if they had, I'm not sure I'd have thought of reworking
> > > > efivarfs_create_dentry to use them.  I tried to update some redundant
> > > > bits, but it wasn't the focus of what I was trying to fix.
> > > >
> > > > So I think the cleanup works and looks nice.
> > > >
> > > > >
> > > > > Relying on the -EEXIST return value to detect duplicates, and
> > > > > combining the two callbacks seem like neat optimizations to me, so
> > > > >
> > > > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > > > >
> > > > > but I have to confess I am slightly out of my depth when it comes to
> > > > > VFS stuff.
> > > >
> > > > Yes, ack too.
> > >
> > >         Umm...  FWIW, I've got a few more followups on top of that (see
> > > #untested.efivarfs, current head at 36051c773015).  Not sure what would
> > > be the best way to deal with that stuff - I hope to get the main series
> > > stabilized and merged in the coming window.  Right now I'm collecting
> > > feedback (acked-by, etc.), and there's a couple of outright bugfixes
> > > in front of the series, so I'd expect at least a rebase to -rc4...
> > >
> >
> > I pulled your code and tried to test it. It works fine for the
> > ordinary case, but only now I realized that commit
> >
> > commit 0e4f9483959b785f65a36120bb0e4cf1407e492c
> > Author: Christian Brauner <brauner@kernel.org>
> > Date:   Mon Mar 31 14:42:12 2025 +0200
> >
> >     efivarfs: support freeze/thaw
> >
> > actually broke James's implementation of the post-resume sync with the
> > underlying variable store.
> >
> > So I wonder what the point is of all this complexity if it does not
> > work for the use case where it is the most important, i.e., resume
> > from hibernation, where the system goes through an ordinary cold boot
> > and so the EFI variable store may have gotten out of sync with the
> > hibernated kernel's view of it.
> >
> > If no freeze/thaw support in the suspend/resume path is forthcoming,
> > would it be better to just revert that change? That would badly
> > conflict with your changes, though, so I'd like to resolve this before
> > going further down this path.
>
> So first of all, this works. I've tested it extensively. If it doesn't
> work there's a regression.
>
> And suspend/resume works just fine with freeze/thaw. See commit
> eacfbf74196f ("power: freeze filesystems during suspend/resume") which
> implements exactly that.
>
> The reason this didn't work for you is very likely:
>
> cat /sys/power/freeze_filesystems
> 0
>
> which you must set to 1.
>

Yes, that does the trick, thanks.

But as James argued as well, this should not be an opt-in, at least
not for resume from hibernate: from the EFI firmware's PoV, it is just
a cold boot, and even the tiniest change in hardware state during boot
(docked vs undocked, USB drive plugged in, etc) could potentially
affect the state of the variable store. In practice, we are mostly
interested in some of the non-volatile variables to set the boot order
etc, so bad things rarely happen, but doing the sync unconditionally
is the safest choice here.

