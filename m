Return-Path: <linux-fsdevel+bounces-10034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA382847349
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D85A1C20F11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7201468FF;
	Fri,  2 Feb 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZJA8gBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929891482E8;
	Fri,  2 Feb 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888182; cv=none; b=J9XfisvARrTZ70sosG5ecRm/KK6l6zf6aNhyDESk241AYgT2Bo5D7xU+2mrIgR8PR9es/ZzkNorUrxI8mRIaSzx7lLPaeaTBQwdACQPdhVwII7uJVyY92TQxFPHrTKK/mfo9Gb5vTW2Mp6bKmqWvut+g3sSbJvhZOQFDfAgmdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888182; c=relaxed/simple;
	bh=Wvl87XNvXMMBWBNxLEx5QalHdJhfB/UDqRD0cL5pQrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgooAgqS0FwL95KKIN6l8bWbFtV2cf9tRMOGhXECtvwKKniJUhQvdh8qav/i7H9Z//xkQ0xFs/PiCX3MLawCHW4y1xvWJ1hS5Vs7u4XHnF45fRFpFowavUptoCRFI72nHifCICyorVQIEAmnaBb/Z5jRhTxYFYN56vuhIptCIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZJA8gBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AA4C433F1;
	Fri,  2 Feb 2024 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706888182;
	bh=Wvl87XNvXMMBWBNxLEx5QalHdJhfB/UDqRD0cL5pQrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZJA8gBXms4F+fDYW6PqCtbmIskJoLqLxNLntY0A5nOHSLbtl94NwrJo0pwCAUIO7
	 Gl3OzmnfhgtOfSDB/932KCoZyiuEEnzRIuW+YdF4vmSXUXB6Dfy7ecxygCt6IbHDM6
	 6DBi+PKKKzr5MZlyUGE5zplsn7Fuw+pS/vp/zyz8=
Date: Fri, 2 Feb 2024 07:36:21 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] rust: file: add `Kuid` wrapper
Message-ID: <2024020214-concierge-rework-2ac5@gregkh>
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
 <20240202-alice-file-v4-7-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202-alice-file-v4-7-fc9c2080663b@google.com>

On Fri, Feb 02, 2024 at 10:55:41AM +0000, Alice Ryhl wrote:
> +    /// Returns the given task's pid in the current pid namespace.
> +    pub fn pid_in_current_ns(&self) -> Pid {
> +        let current = Task::current_raw();
> +        // SAFETY: Calling `task_active_pid_ns` with the current task is always safe.
> +        let namespace = unsafe { bindings::task_active_pid_ns(current) };
> +        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and the namespace
> +        // pointer is not dangling since it points at this task's namespace.
> +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
> +    }

pids are reference counted in the kernel, how does this deal with that?
Are they just ignored somehow?  Where is the reference count given back?

thanks,

greg k-h

