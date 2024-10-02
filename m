Return-Path: <linux-fsdevel+bounces-30665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB498D0FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 12:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153871F223B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001A91E6306;
	Wed,  2 Oct 2024 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He6XG6D1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484871E493F;
	Wed,  2 Oct 2024 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864082; cv=none; b=f3CcZ/45u1rFYp8mILvGA/FLP/Soo7gj73m8QtsTcBjyS1LdPwIACbfN86/cDmJYBRyOo7RWeji5J/5xQq2D514v3ZgS/z3i09i+tkecOyNfQpQw7lfe6z+FSn6OA8GiSmKolBIezpgH+nwK1eiqGET1LjX85P2ojZMfwRFB4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864082; c=relaxed/simple;
	bh=xPtbTLmwEY0tdPID7jhVlQ/pbxn+Qy6JsyG8jCuXdik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLwrxQR90zxWBXTRXArFaD3+T0ExsBfX745uWBhJ8e4Qnso23Xenht+BiC/vTEcuVlnKFU0TUJWLjVvIuTAYV1IqeoWYVkvh9TXmsNYLoLV80xH/e27RBHBZObdCYAxuez2VrdtO6IUt8qAuSPM6Wvxyk5RmIKuLbkIQVjMynZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He6XG6D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E535C4CEC5;
	Wed,  2 Oct 2024 10:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727864081;
	bh=xPtbTLmwEY0tdPID7jhVlQ/pbxn+Qy6JsyG8jCuXdik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=He6XG6D1RRg0x6k9lqwKv70AsE67W+ycsfVAC0iO8bsY0cre5fSbzqzr99KwGdY+e
	 Ru0zNLrd38YBZU4b1iqqEKEun4E18mxEFSUUcUc98y8Kw5DbmBEYWvzu7wLd1i95l9
	 3+bcD4ujDW2bT7nYBM2u0WlM90LQxHu/uvGJ+IWeJDyyzHK7kMBS6919xq5DJjsNn+
	 2GY2S71qTYfK90bZ4UOjvCh0P1bKgxoe+7Kp9o6rtUxmPuflP5ilIVBdrTZgmX6FR+
	 dl4vZGDasze+xdoFGnhYnd0/5HouDhraJNkxgvJbr9uKQGqok2HcQA+QVyC542gLxo
	 p7+g4VIXc8cjQ==
Date: Wed, 2 Oct 2024 12:14:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v2] rust: add PidNamespace
Message-ID: <20241002-dehnen-beklagen-f7f6ca460b5b@brauner>
References: <20240926-pocht-sittlich-87108178c093@brauner>
 <20241001-brauner-rust-pid_namespace-v2-1-37eac8d93e75@kernel.org>
 <CAH5fLghaj+mjL63vw7DKCMg3NSaqU3qwd0byXKksG65mdOA2bA@mail.gmail.com>
 <20241001-sowie-zufall-d1e1421ba00f@brauner>
 <CANiq72nJbmhicsNqZHV9=j_imXPPZWxuHiqr=N4wTDxwGaMW5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nJbmhicsNqZHV9=j_imXPPZWxuHiqr=N4wTDxwGaMW5g@mail.gmail.com>

On Tue, Oct 01, 2024 at 05:45:15PM GMT, Miguel Ojeda wrote:
> On Tue, Oct 1, 2024 at 4:17 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Ok. Why does it pass the build then? Seems like it should just fail the build.
> 
> It is part of `make rustfmt` / `make rustfmtcheck`.
> 
> I would be happy to make it part of the normal build if people agree
> -- though it could be annoying in some cases, e.g. iterating small
> changes while developing.

You could consider adding a way to turn it off then instead of turning
it on.

> 
> If we do that, it would be nice if -next does it too, but I think
> Stephen is already building Rust for x86_64 allmodconfig (Cc'd).

Imho, since Rust enforces code formatting style I see no point in not
immediately failing the build because of formatting issues.

