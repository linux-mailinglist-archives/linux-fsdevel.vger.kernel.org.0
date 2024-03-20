Return-Path: <linux-fsdevel+bounces-14910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B926C8814A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBED284E10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1D54662;
	Wed, 20 Mar 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR87vbT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FBF14A96;
	Wed, 20 Mar 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948789; cv=none; b=vEPMeeU5zVSgi7WqAnaaEtVfx1C7AC6O6Q7l2LYdEx8RDBnmeO6eGsAmKfNT0RUEnk1/PKa1a/+841MqgN818P7or0Yj32rodavJOxaAp/NY0BVevZJ5+2YYlRR6cENWJ3ckNyZYt4aHVel1BOUOSDTzJcOlxDxfNUnf3VMTtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948789; c=relaxed/simple;
	bh=g0nzjCQBRPotfAplkOEZ49775DmzGb/Il5MwgJUi8xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZyvJCFe1n5QZg0cIw+SSiDi8JLViJ/AaFLHVZm2IctQKocYhm0KM+E+9DPF+AECS4MpHlNypyv+4mI01nsO9mWDXOzLPVsisNmMDMBPZ2gqpS7iEOSygS5wlCw4mcI2C/44VoW34KXGawG3ewMZsdyZAYCg3J+4kW6ct5jISbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR87vbT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA874C433B1;
	Wed, 20 Mar 2024 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948789;
	bh=g0nzjCQBRPotfAplkOEZ49775DmzGb/Il5MwgJUi8xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MR87vbT+lZhz1UVK7v/lmHTX5vlSQWodzAC4mrQmpB1cSduWOzLnVhrODFyxiXAy9
	 cmmr2OV+FTM50RZ/lt2qC+DQIjCxQQhIqoLq2V2cNOnmNofwcQWBCUosxkW7OQ+fT3
	 37t9oK8WVVGtLfqqFeFU8uXWyTxKhz1L3Ytr6+A0fUtY/94sJhYhNi6msYPyRplPDA
	 rKZGMWxa6MSYmo4UIe25PQIdKi5enY0xTfwjG3wWlKVJGAhzjNt/d2AAd286jyjCp2
	 xoHIFOYbAi9fA7V0r2/IQIs5hBPTdPMAtvB3zwHTxE1tZ4z1yowXgQhezUPbUROUrY
	 hxBWCI9AlXA4w==
Date: Wed, 20 Mar 2024 16:33:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v5 6/9] rust: file: add `FileDescriptorReservation`
Message-ID: <20240320-papier-seenotrettung-c5eaeda87478@brauner>
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-6-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209-alice-file-v5-6-a37886783025@google.com>

On Fri, Feb 09, 2024 at 11:18:19AM +0000, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Allow for the creation of a file descriptor in two steps: first, we
> reserve a slot for it, then we commit or drop the reservation. The first
> step may fail (e.g., the current process ran out of available slots),
> but commit and drop never fail (and are mutually exclusive).
> 
> This is needed by Rust Binder when fds are sent from one process to
> another. It has to be a two-step process to properly handle the case
> where multiple fds are sent: The operation must fail or succeed
> atomically, which we achieve by first reserving the fds we need, and
> only installing the files once we have reserved enough fds to send the
> files.
> 
> Fd reservations assume that the value of `current` does not change
> between the call to get_unused_fd_flags and the call to fd_install (or
> put_unused_fd). By not implementing the Send trait, this abstraction
> ensures that the `FileDescriptorReservation` cannot be moved into a
> different process.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

This looks ok to me now.

