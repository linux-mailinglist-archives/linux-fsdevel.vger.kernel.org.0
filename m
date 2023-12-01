Return-Path: <linux-fsdevel+bounces-4557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5E800867
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C07B2111E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59773210E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu1qqeD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3EC1DDCC;
	Fri,  1 Dec 2023 10:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8C3C433C9;
	Fri,  1 Dec 2023 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701426462;
	bh=2fsxldjXdLT1vLmTSL0O0eM3f9o5dOmCk2EixIWt25Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vu1qqeD+amM3RPPGUCpm0/0tkYu09IWWI/UVpYypRMBc8k7lcceWL9aT+Anhls2Nb
	 H84Zcoh4dRCJkFiHHMhr7IrK9+NOhaELc7Y6EpSJX28BEtbjnNImbKm5+IIpBGU+zO
	 ahPXK/We8kIRq5PjejjUVsAsV1u0y8cRPpcq+rpEvsFAM4aA+L/PXC4cD450NjojqV
	 31bUqzomYoF1WEN99f6GzfkrJQJL5OKsyoJCRn0UNEJuCzuMiNpxg32vf62cvjyonk
	 qLJ+d8RxAPLu7xU/yCmxqxXB+B5tBG7QXBDFML1BIauaHVIpZTYYKEuGbrFS1ZF+TA
	 EiSyG+oS1Vwfw==
Date: Fri, 1 Dec 2023 11:27:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: benno.lossin@proton.me, a.hindborg@samsung.com, alex.gaynor@gmail.com,
	arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
	gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 2/7] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <20231201-zacken-gewachsen-73fe323b067b@brauner>
References: <W6StBLpVsvvGchAT5ZEvH9JJyzu401dMqR3yN73NZPjPeZRoaKAuoYe40QWErmPwrnJVTH7BbLKtWXDOMYny5xjwd3CSLyz5IYYReB6-450=@proton.me>
 <20231201090636.2179663-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201090636.2179663-1-aliceryhl@google.com>

On Fri, Dec 01, 2023 at 09:06:35AM +0000, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
> > On 11/29/23 13:51, Alice Ryhl wrote:
> >> +    /// Returns the credentials of the task that originally opened the file.
> >> +    pub fn cred(&self) -> &Credential {
> >> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> >> +        //
> >> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> >> +        //
> >> +        // TODO: Replace with `read_once` when available on the Rust side.
> >> +        let ptr = unsafe { core::ptr::addr_of!((*self.0.get()).f_cred).read_volatile() };
> >> +
> >> +        // SAFETY: The signature of this function ensures that the caller will only access the
> >> +        // returned credential while the file is still valid, and the credential must stay valid
> >> +        // while the file is valid.
> > 
> > About the last part of this safety comment, is this a guarantee from the
> > C side? If yes, then I would phrase it that way:
> > 
> >     ... while the file is still valid, and the C side ensures that the
> >     credentials stay valid while the file is valid.
> 
> Yes, that's my intention with this code.
> 
> But I guess this is a good question for Christian Brauner to confirm:
> 
> If I read the credential from the `f_cred` field, is it guaranteed that
> the pointer remains valid for at least as long as the file?
> 
> Or should I do some dance along the lines of "lock file, increment
> refcount on credential, unlock file"?

The lifetime of the f_cred reference is at least as long as the lifetime
of the file:

// file not yet visible anywhere
some_file = alloc_file*()
-> init_file()
   {
           file->f_cred = get_cred(cred /* usually current_cred() */)
   }


// install into fd_table -> irreversible, thing visible, possibly shared
fd_install(1234, some_file)

// last fput
fput()
// atomic_dec_and_test() dance:
-> file_free() // either "delayed" through task work, workqueue, or
	       // sometimes freed right away if file hasn't been opened,
	       // i.e., if fd_install() wasn't called
   -> put_cred(file->f_cred)

In order to access anything you must hold a reference to the file or
files->file_lock. IOW, no poking around in f->f_cred or any field for
that matter just under rcu_read_lock() for example. Because files are
SLAB_TYPESAFE_BY_RCU. You might be poking in someone else's creds then.

