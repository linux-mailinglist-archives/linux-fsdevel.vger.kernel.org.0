Return-Path: <linux-fsdevel+bounces-50137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A58AC87BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442F7170752
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3231EA7DB;
	Fri, 30 May 2025 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx7jl9Ld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248B18991E;
	Fri, 30 May 2025 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748581987; cv=none; b=ohUoabE+O0dKI/9gOInaOtKnn9Eyh3tv2odSEasnP6CDGFO4LyXGrS816aqsn/WKcy7jNDx8Rs595f/Ots5h/mg4g86MnCN10eN3EDulzdfv7x0XRiqcS8HGJPQT8JzHUOQhQW1m6pmNzLBxPvHHsU+41kOg0PFjzbwtv1tsqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748581987; c=relaxed/simple;
	bh=ABXcBcI46740XMmqpKEU0ZDPqOeZjAzBxnVDnWBJ4iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyIzcccRnmwaov5f10rtt3yo4hSN/7cKpbbQEqkASwUpRXrPpEIZZcdkmzNM0y+Bk5JqnUwOyYKcH/N7vx7By+NFGU+6Uy1x4rjW+jLotJ/vEkgxHR25GAutoO1B3k9t2rDwzOEnOmK6eKCNsv6GN4QE0Tle/3qorKFbZHMSo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx7jl9Ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39A9C4CEE9;
	Fri, 30 May 2025 05:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748581987;
	bh=ABXcBcI46740XMmqpKEU0ZDPqOeZjAzBxnVDnWBJ4iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fx7jl9LdKwwReTtrI7QsT6LFaGn0vvss5pRJ32itsL/OYRvOh1jVYJSTvjGW9D0C/
	 GOZjyEYHLPX2OImVlIKWgAnKJgI9ClF8qxwldtr6T0Yvb/+aJ+yQc0XqQj1NLWMN2O
	 2fZsblIl5q/qxmJ8MNfwMJTxizUYJQkzJ7Eoy2wTaTOWCRxVMg6nHI+H9tbKKLnWbZ
	 R71OVtpCqXEWTKwvI+8c65vXkLRlqn2+E85B56NL0iLqHDDe63mD2BMZ17yoAQXYST
	 mzQAwkJqU+sh6/TQORT0Ck7ZfHqknyg7VjCcAgqKsHTIwyELFgKh8SV/iNfh6FMmtc
	 6yzX0sgePbrlw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Pekka Ristola <pekkarr@protonmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: file: mark `LocalFile` as `repr(transparent)`
Date: Fri, 30 May 2025 07:12:59 +0200
Message-ID: <20250530-minuten-beheben-df4e8ce17716@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527204636.12573-1-pekkarr@protonmail.com>
References: <20250527204636.12573-1-pekkarr@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=brauner@kernel.org; h=from:subject:message-id; bh=ABXcBcI46740XMmqpKEU0ZDPqOeZjAzBxnVDnWBJ4iA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRY2sVMnL7n9POedeGPm0XmX/9eeusqo0ydab/W1vVcm 2KdvJRudJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE/Dgjw4M85rkPefVCKxYG nLqu+tv3lrXf5ZsqwRLVutt2BlmVljAyTPl85Pfrn38ybv7abqv1Zn+oyNZPu9NK2lLqjNZVczr bcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 27 May 2025 20:48:55 +0000, Pekka Ristola wrote:
> Unsafe code in `LocalFile`'s methods assumes that the type has the same
> layout as the inner `bindings::file`. This is not guaranteed by the default
> struct representation in Rust, but requires specifying the `transparent`
> representation.
> 
> The `File` struct (which also wraps `bindings::file`) is already marked as
> `repr(transparent)`, so this change makes their layouts equivalent.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] rust: file: mark `LocalFile` as `repr(transparent)`
      https://git.kernel.org/vfs/vfs/c/15ecd83dc062
[2/2] rust: file: improve safety comments
      https://git.kernel.org/vfs/vfs/c/946026ba4293

