Return-Path: <linux-fsdevel+bounces-28214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B2A968203
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DC9B21E73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB11186E38;
	Mon,  2 Sep 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhf0CwZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7018660A;
	Mon,  2 Sep 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266009; cv=none; b=uSMgxGlutMulljBFoLImzboEDGzN3nkv5mDq5enkcyycidvr0cgW7pIDZ/++E72kPqpiMrxDFYjBTUP8bHsuy5JJWqkX26/dWkq7FgpMntW95uN53NKGlhc0wXZN1tPwQuoTc9x0GeB86ruiWuEXKNo4O+riiHCExn2dyrVJzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266009; c=relaxed/simple;
	bh=xVjeuEAK/3aM0vsGYPY4dUHOj95o8OgLHPHyeTgQBDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2CqVj3iyIWYW248ytBCnZbQbftR5bDPqIEUXALHrtA4w0njhq0MXNOn+Rg4XwbueREVP9mFL7bSBZvDGBy3e/QxNdA2Hurkghim94g6X6tPMVJzm9GjcE2675V2oV1DTXKn5BD2ye9XscXeJLGZRCjshnWStyrhuuY5GMYNY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhf0CwZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD7C4CEC2;
	Mon,  2 Sep 2024 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725266009;
	bh=xVjeuEAK/3aM0vsGYPY4dUHOj95o8OgLHPHyeTgQBDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhf0CwZILv2FE3RAkA+PMGNIxZiLaJ/IVq8TExQUefYmf+cEPh741TudQROZG687t
	 a7/kiWXGQptaaCXFdAu92XYaQbA5/vqeCSw+pj1tecKorXSka3TinTFN49IBcL3Xhq
	 cOLs4r/ZnCNdW533F8t1rgsNhYCNSa1aTjOfX7FYX0F9DjJzHYr97pKu6Dd3dKqQXf
	 4JYBaZbbl7lSG5oaNc9m45BpGlTuHDo7c1CXcWIy8wZiIkeOHd/IzS2kkggZJKPnBq
	 9Ze5OaxyuVA4Vk/pkpu1yLunrB2n+raJNSos3VE+uLS9LusBLX7w8xKjfZ/LqWQgvh
	 nwFjO0huovE0A==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve Hjonnevag <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v9 0/8] File abstractions needed by Rust Binder
Date: Mon,  2 Sep 2024 10:33:11 +0200
Message-ID: <20240902-ofenfrisch-deretwegen-52d00d98ba90@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2031; i=brauner@kernel.org; h=from:subject:message-id; bh=xVjeuEAK/3aM0vsGYPY4dUHOj95o8OgLHPHyeTgQBDc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdrfDYXlD4Pr09UPbZvNiej/kCIrPdvs1qqBPVbef0a ttx1LOio5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLcKgz/A/cKqed7TPqcZLI5 ruUGn1zohQ2R4Vq7rRbv/vDD/s3Nrwz/HV1PMx1hki09fkvb+O++g5c3TnONOTT3v/9qrr4ZdnP PcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 Aug 2024 16:15:43 +0000, Alice Ryhl wrote:
> This patchset contains the file abstractions needed by the Rust
> implementation of the Binder driver.
> 
> Please see the Rust Binder RFC for usage examples:
> https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/
> 
> Users of "rust: types: add `NotThreadSafe`":
> 	[PATCH 5/9] rust: file: add `FileDescriptorReservation`
> 
> [...]

Moving this to vfs.rust.file. This won't show up in -next for quite a while
(until v6.12-rc1 is out).

---

Applied to the vfs.rust.file branch of the vfs/vfs.git tree.
Patches in the vfs.rust.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.rust.file

[1/8] rust: types: add `NotThreadSafe`
      https://git.kernel.org/vfs/vfs/c/1fc5fbeff010
[2/8] rust: task: add `Task::current_raw`
      https://git.kernel.org/vfs/vfs/c/dff63ff65920
[3/8] rust: file: add Rust abstraction for `struct file`
      https://git.kernel.org/vfs/vfs/c/3d52041c524e
[4/8] rust: cred: add Rust abstraction for `struct cred`
      https://git.kernel.org/vfs/vfs/c/bd5715551277
[5/8] rust: security: add abstraction for secctx
      https://git.kernel.org/vfs/vfs/c/b94bf604a856
[6/8] rust: file: add `FileDescriptorReservation`
      https://git.kernel.org/vfs/vfs/c/b7af88a7d25d
[7/8] rust: file: add `Kuid` wrapper
      https://git.kernel.org/vfs/vfs/c/73cd06e92529
[8/8] rust: file: add abstraction for `poll_table`
      https://git.kernel.org/vfs/vfs/c/891ad53c3c62

