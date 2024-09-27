Return-Path: <linux-fsdevel+bounces-30224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61755987F7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 09:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A562B21744
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368E18893F;
	Fri, 27 Sep 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xje0hg07"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2346B13A896;
	Fri, 27 Sep 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422329; cv=none; b=MVNQZUIw18mbEuTMzQl1sZGtRJEZ++cQgU0mZ9W0dWXdkngbJrHzpsQCZLbsMIMxw9BouAiMsX01xyKk2AT5zz3zLGtXuBkyE53B51JiPOqpQsFD4Gy07wTPRMFC7CQRFkeX1LucnQ3SAlEf/exS448ZlvlihCn86meMY7YbpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422329; c=relaxed/simple;
	bh=VO0jVLoDWIAK3ENg+3fmzfUDmQQTlwwKV08HSlrz9P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUzbXlJ8U4uI9AGKd1WC062nV0PELt+/sc7cP/ZG+4ku2/xRBHOsapbpr6SjHWp5kYCOtGgHFrKnfbg3Wf/k3wSXmkfZBJhsUDpcK0jyO/T9gPQ7CX1P/P0p6twQyydHBWmN5ZFVgipNTXndMSjloPgLLOTJJIt6CP5qBfAtbjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xje0hg07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DA3C4CEC7;
	Fri, 27 Sep 2024 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727422328;
	bh=VO0jVLoDWIAK3ENg+3fmzfUDmQQTlwwKV08HSlrz9P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xje0hg076Ht8OtjxwQuVoFw6hWHJEoCeMD6qMtYgseGKGtsWtj66RdFBaf7bw1lNm
	 mruzww+wWAeIViffNRiPOeo5Kj1XhU/M3qD1KQBU/cD8PM8u08G8W0il7RL1I40rhq
	 32NPqNRjRWjnQvGUSrlcWf+Y6zVjKdi77P8PhfOCxqbrazEokZ2iudhETSBFMs03CL
	 0Q0enAQm32WC0Y/C6q0nc6Bat9xIKiUUEUUpMZPyjjkywsmc2oLkZjjFKt6EHUIwie
	 uQvRQwNDUBeNV+wEVRUYzBFV8IVTkJ0liLqSLbld6+CkslBN+hkrIpWnk+bM2GDL6i
	 QMSR/hjF1tgbw==
Date: Fri, 27 Sep 2024 09:32:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
Message-ID: <20240927-ergaben-abdrehen-a02a861abaf5@brauner>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>

On Thu, Sep 26, 2024 at 02:58:56PM GMT, Alice Ryhl wrote:
> Add accessors for the file position. Most of the time, you should not
> use these methods directly, and you should instead use a guard for the
> file position to prove that you hold the fpos lock. However, under
> limited circumstances, files are allowed to choose a different locking
> strategy for their file position. These accessors can be used to handle
> that case.
> 
> For now, these accessors are the only way to access the file position
> within the llseek and read_iter callbacks.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/fs/file.rs | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index e03dbe14d62a..c896a3b1d182 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -333,6 +333,26 @@ pub fn flags(&self) -> u32 {
>          // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>          unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
>      }
> +
> +    /// Read the file position.
> +    ///
> +    /// # Safety
> +    ///
> +    /// You must hold the fpos lock or otherwise ensure that no data race will happen.
> +    #[inline]
> +    pub unsafe fn f_pos(&self) -> i64 {
> +        unsafe { (*self.as_ptr()).f_pos }
> +    }
> +
> +    /// Set the file position.
> +    ///
> +    /// # Safety
> +    ///
> +    /// You must hold the fpos lock or otherwise ensure that no data race will happen.
> +    #[inline]
> +    pub unsafe fn set_f_pos(&self, value: i64) {
> +        unsafe { (*self.as_ptr()).f_pos = value };
> +    }

I don't think we want to expose f_pos with its weird locking rule
through rust wrappers. Ideally, it's completely opaque to the callers
and not accessed directly at all.

