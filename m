Return-Path: <linux-fsdevel+bounces-25535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C894D26B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D5F1F24C49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732C198841;
	Fri,  9 Aug 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUYbjiwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18036198826;
	Fri,  9 Aug 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214703; cv=none; b=kXMiSLm72F7GJSBRR0TcPKEPF5cctrwGkHYsmm9R/gRfaXmVROwdivj25eHLUs8ibWuS313pbGY0h/5Mt46TyyHKcOfMgAf67OblwQ578YPXrZstGqeRI2EpYFg/lDzb0JZ4/w93dCrmNRZE2Klk5++pPq7rGKoiuj486zBE5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214703; c=relaxed/simple;
	bh=dN87z9k/yj7qsZxmnohhy2NTeMct8Qsja5a/FdCnC7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT1c65Vbsb3OqZL4BwKWuxEREXEkWtmPWCehpYklc+CDKWYyJsllMYXZimMJ8EzR3QeS80jrBsVcVCvfKNSj5dYpNYZEMZHAcQs44UOZxRTSbA8LpDveMicz+bu0XJKyOQjGjWFPHyzRKQMBLBj7/plm1NieZ3SuyoYs3tCBRCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUYbjiwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16A9C32782;
	Fri,  9 Aug 2024 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723214702;
	bh=dN87z9k/yj7qsZxmnohhy2NTeMct8Qsja5a/FdCnC7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUYbjiwlrfkgKzVlWobBOJIbrEgtMbIUyc7EYIZ+vqyMCZFXHdla+WUTziS0VNKK5
	 8oR0MpUDoHZOx6QaOUwUChV4dg3k/FKHbeZGh4xRY6fTpg45YCRpCD6woAQQGZ4X5j
	 BD5dKVymG4Oy/tcRzHonIyGb0hVIi4f71VQdgvn9x+oULlOnUoOhdY79wtgys28qtO
	 EhdrNdSnrY/L8mtfwyM0VTIxKv+aRiM9tY1QlqiXAhIkNEfNW+xQ654Yi56x99WtD6
	 A9Iso6n0iA4Ky9gq4/ajBFxT0lUmyAlk2XB2GRZ0LcKFI//jnh7uG3/iqrtlFN1a35
	 yKpdJDfWuv72g==
Date: Fri, 9 Aug 2024 16:44:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
Message-ID: <20240809-explosionsartig-ablesen-b039dbc6ce82@brauner>
References: <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net>
 <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net>
 <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net>
 <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net>
 <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>

On Fri, Aug 09, 2024 at 04:00:41PM GMT, Jann Horn wrote:
> On Fri, Aug 9, 2024 at 3:18 PM Mickaël Salaün <mic@digikod.net> wrote:
> > Talking about f_modown() and security_file_set_fowner(), it looks like
> > there are some issues:
> >
> > On Fri, Aug 09, 2024 at 02:44:06PM +0200, Jann Horn wrote:
> > > On Fri, Aug 9, 2024 at 12:59 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > [...]
> >
> > > > BTW, I don't understand why neither SELinux nor Smack use (explicit)
> > > > atomic operations nor lock.
> > >
> > > Yeah, I think they're sloppy and kinda wrong - but it sorta works in
> > > practice mostly because they don't have to do any refcounting around
> > > this?
> > >
> > > > And it looks weird that
> > > > security_file_set_fowner() isn't called by f_modown() with the same
> > > > locking to avoid races.
> > >
> > > True. I imagine maybe the thought behind this design could have been
> > > that LSMs should have their own locking, and that calling an LSM hook
> > > with IRQs off is a little weird? But the way the LSMs actually use the
> > > hook now, it might make sense to call the LSM with the lock held and
> > > IRQs off...
> > >
> >
> > Would it be OK (for VFS, SELinux, and Smack maintainers) to move the
> > security_file_set_fowner() call into f_modown(), especially where
> > UID/EUID are populated.  That would only call security_file_set_fowner()
> > when the fown is actually set, which I think could also fix a bug for
> > SELinux and Smack.
> >
> > Could we replace the uid and euid fields with a pointer to the current
> > credentials?  This would enables LSMs to not copy the same kind of
> > credential informations and save some memory, simplify credential
> > management, and improve consistency.
> 
> To clarify: These two paragraphs are supposed to be two alternative
> options, right? One option is to call security_file_set_fowner() with
> the lock held, the other option is to completely rip out the
> security_file_set_fowner() hook and instead let the VFS provide LSMs
> with the creds they need for the file_send_sigiotask hook?

I think it would be fine to stash the credentials in struct fown_struct
same as we do for struct file itself. Calling security_file_set_fowner()
with the irq lock held seems suboptimal to me. Plus, this also means one
less LSM hook and that seems like a win too.

