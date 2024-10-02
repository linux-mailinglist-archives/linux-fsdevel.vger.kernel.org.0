Return-Path: <linux-fsdevel+bounces-30672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15F98D23B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82724284DDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD501EC00B;
	Wed,  2 Oct 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJhDFvwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27912E1EE;
	Wed,  2 Oct 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868659; cv=none; b=kQfnRlK7oGANitNCzS/7V881Du7olv7YPuihbDffrftk8pAAYFafaRq8/A4A3IZKg4S4YeFBiCRHg87wnQI4qPuE/c3euAiOsl0bhXZtQUHr+uvkYHNRIK6iGvSHm0dpTulIfbq71/4aRzk5AG+XR0L9FUkywcJwFgemrBHt9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868659; c=relaxed/simple;
	bh=xo+Bne4sKMbrVBoeYhb5KBZhjW7/mVg/usF9sSoJXOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNMFVWdP4wrnUinoWJKRYCv6KN87XvpCGrBYYCl3jr7iU1W7EmrRXEzoGMkdFwrvEDX4a9Dj8UgImsyym/Qa2Ys0SxgMHq4at2EaT1aymJfXJYNR0kZYf9hM1SM/6JP1E1nXuhR62uL6Gh9Az7R2I0Z5NGIsuMDNBvRQW9Wmz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJhDFvwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0105FC4CEC5;
	Wed,  2 Oct 2024 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727868659;
	bh=xo+Bne4sKMbrVBoeYhb5KBZhjW7/mVg/usF9sSoJXOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJhDFvwWgTzoieYft47lOcydJQR/qnbgmpFt8IrEmLzHVnAeokEAJmc8kwau0Jql3
	 5Kldy3E4SSg8TS8FQSf5vmyIGAbAEJO2gnTsh8kJVYHs2U10JRV4AV7ohzBHVoyePi
	 YoUxguxCBQaskThPWegy/iUaUPpOQj+LAnrhUjRQb3uFq8OFD7Wkj7LklS2cE0YbL3
	 6v9BmgnAAGeSNGgW+uYYCxesRFK/eE7UCCSLxFxO8HFtpQdwZoVywjhLeeYnENNaz/
	 CCZYdnu4USrn8rSMU5PxuGGnLUWe6qIxJLaDPj6ygIZCZkFHTUQHNYR2yZMpGyq/9W
	 kXFQkKd097puA==
Date: Wed, 2 Oct 2024 13:30:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Bjoern Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add PidNamespace
Message-ID: <20241002-wappnen-kartoffeln-deea146780ef@brauner>
References: <20241002-brauner-rust-pid_namespace-v4-1-d28045dc7348@kernel.org>
 <CANiq72my2N41wRWGFpPhJk_zTTaLJcuvYFekWFyoWrhQRLEfDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72my2N41wRWGFpPhJk_zTTaLJcuvYFekWFyoWrhQRLEfDQ@mail.gmail.com>

On Wed, Oct 02, 2024 at 01:12:08PM GMT, Miguel Ojeda wrote:
> On Wed, Oct 2, 2024 at 1:00 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > +        let pidns = unsafe { bindings::task_active_pid_ns(Task::current_raw()) };
> 
> Missing `// SAFETY` -- I mention it since this will be a warning (thus
> error in `WERROR`) soon.
> 
> > +        let ptr = unsafe { bindings::task_get_pid_ns(self.0.get()) };
> 
> Ditto.
> 
> > +            Some(pidns) => unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns.as_ptr()) },
> > +            None => unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) },
> 
> Ditto.

Ah, good to know.

