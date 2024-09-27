Return-Path: <linux-fsdevel+bounces-30236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22751988155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBEF1F20FEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6691BB683;
	Fri, 27 Sep 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIERjt0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F241BA29B;
	Fri, 27 Sep 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429335; cv=none; b=LqcxbijW7aADSVD+RG4W0Oc44xmBqkJcquXpImkFlYiD81qBn2mppNu1qHLHEhejBYZ4pvDf1+uL2WdQ8ouUaCmIGuPovfg3EBzQuMf+Fex97+0s4TQ6ZXLs/EHANRLZSMXY8/qPgb76CZ9bEqssFbiMyefq5ow5KwiLOLboWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429335; c=relaxed/simple;
	bh=sKt8/7JHzE8MsBKuh6blTXHEQ9ZK2ZOA5ITusQ2b34A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVS3DS75ifYnI9cB8npw1JHUeNLKK4kcIcJ0FesSkX/rNvN39ZabT+YJYZQ3BRDVXO2qNZYw5terSqfvkxvb+TnfyVyxZ04mzHK7phWYh+qevXII1E53m9AWWj2czoOc5tz2nOBEN4NZ+9QP6BykDR2o7Tc5VTLQPtlcBhpyD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIERjt0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840D9C4CECF;
	Fri, 27 Sep 2024 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727429335;
	bh=sKt8/7JHzE8MsBKuh6blTXHEQ9ZK2ZOA5ITusQ2b34A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XIERjt0IDuxY6m4h5IPyGGlGQabYhSaYp/Hc+uC04n6GPcJhF0ld9iaV/yY7Nw3Lc
	 rIVREsf4iV6yxmfFbtF0ELn46T5RQ5vjqiSSQflhm2UM2e8Jkx4WlJleOUeHVAH07F
	 xqzEyzpECi8dDMudQ3+kez//lTcFAypUvgWlPcUDdc1dZrQPp+3T66GoNedNRmAR+2
	 LZONBILhvibMfeTs11NwlHKGZUrrtkPWne3uAIMRhst/Eyr4Q9nqmIoWPR4Pt527o3
	 qnhiroQziVj/CJik1a7wx9AKYqneZyvAz2Wqi4QRUCuBeFGBaajgJYojcitTaFW9aP
	 nwTxTo/0sIRTg==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v10 0/8] File abstractions needed by Rust Binder
Date: Fri, 27 Sep 2024 11:28:42 +0200
Message-ID: <20240927-kicken-minigolf-de3ebd20f6ec@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=brauner@kernel.org; h=from:subject:message-id; bh=sKt8/7JHzE8MsBKuh6blTXHEQ9ZK2ZOA5ITusQ2b34A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9qzq19sr6j49iFAK1mwN7HfOd7oiJNPh/WTRnLcM/r 1CZC6dfdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkTTjD/+oP0xMuXPkqaj+T OXRDe2qA9Swrhvm81vP9K/kNLn+8vZ6R4crmW8vk/6TL+9T9LGrdd/7Dot2K79nM8tfv518h+i8 8hhkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 15 Sep 2024 14:31:26 +0000, Alice Ryhl wrote:
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

Applied to the vfs.rust.file.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.rust.file.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.rust.file.v6.13

[1/8] rust: types: add `NotThreadSafe`
      https://git.kernel.org/vfs/vfs/c/cf9139a8a2ff
[2/8] rust: task: add `Task::current_raw`
      https://git.kernel.org/vfs/vfs/c/16c7a0430f3a
[3/8] rust: file: add Rust abstraction for `struct file`
      https://git.kernel.org/vfs/vfs/c/d403edaaee09
[4/8] rust: cred: add Rust abstraction for `struct cred`
      https://git.kernel.org/vfs/vfs/c/fa4912bed836
[5/8] rust: security: add abstraction for secctx
      https://git.kernel.org/vfs/vfs/c/34f391deba6d
[6/8] rust: file: add `FileDescriptorReservation`
      https://git.kernel.org/vfs/vfs/c/054e1b6a797e
[7/8] rust: file: add `Kuid` wrapper
      https://git.kernel.org/vfs/vfs/c/a78b176bfdc2
[8/8] rust: file: add abstraction for `poll_table`
      https://git.kernel.org/vfs/vfs/c/e0cdb09b7100

