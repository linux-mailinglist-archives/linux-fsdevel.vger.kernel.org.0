Return-Path: <linux-fsdevel+bounces-63465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D06BBDB34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B98E334A5D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230C2417C5;
	Mon,  6 Oct 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0IIgcMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A72153EA;
	Mon,  6 Oct 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746896; cv=none; b=IDtVRrFaPhyUS53G85sU//d/DJvXDlpKQB+7uDhEsHOgoNEL0jZnk5tmjyf4liWWNI5KSbQrSxqxSwiL/AQ9CfsEC095O7CLL8ePXDrodWH+pXJBnFXiXIoUVTyuxgIti6kGuaqPh6WcEueKQnIAwFPrxbkQU4Dlv2t9dmeCxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746896; c=relaxed/simple;
	bh=T1iv863cqpbYgIRCNRsUsJwO2QAocd0RGlh9y8gcaWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3b7vD6XgdGC0NOFJKSIIOS0NQZa1JvEswmoIYrKhRC7eYzlYCW1/zOmpNWQcHA/mUYWp7dFPeEmqhQqvjeY6AeHbtpAGgcnLFDoOj7m0qDv0aW4LFuGu/aYzCwERTMc7KR04mrzFX0K8LMZsJm9JDCZmaqaJQANW/HNuzhvEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0IIgcMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54744C4CEF5;
	Mon,  6 Oct 2025 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759746896;
	bh=T1iv863cqpbYgIRCNRsUsJwO2QAocd0RGlh9y8gcaWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0IIgcMuU6KSBWOL9n/PFX7hjO8gADDVGnf1+1IfSiCjhBi89fDoM9roahXYZzx45
	 +9QrrVSL3bWqg93q0lP7k0jRePhAZ0IiLK5tqlkvAQ5QQo7mmR1jFz0+G8Dz9Z2/Yw
	 MG9Sct5UdV40PXJGKc5TbrFcu73qd2Fwi7VTwpP2xQroThCYfAQYFZ16xrcdOd125F
	 hBVCTzExkexRPYKA+DtKCrAna7ZGoaRdw1SsAyEKjrTnOzNmY0zUA3Ijw7XVzI9hhW
	 +i6R6T/Av5evceYg59bxT3k5UzJ3bX8obn1bLG9NQUwliwZ8KdoAzvvKhgL4hbwsq6
	 gp8oxui97X/Jg==
From: Christian Brauner <brauner@kernel.org>
To: Tong Li <djfkvcing117@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] rust: file: add intra-doc link for 'EBADF'
Date: Mon,  6 Oct 2025 12:34:44 +0200
Message-ID: <20251006-leben-anfechtbar-f6862b1a35de@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930110258.23827-1-djfkvcing117@gmail.com>
References: <20250930110258.23827-1-djfkvcing117@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=brauner@kernel.org; h=from:subject:message-id; bh=T1iv863cqpbYgIRCNRsUsJwO2QAocd0RGlh9y8gcaWE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8nu1ZM4f9DmNYDZeFUPVN/x1/PdVvfDnot+DO8bKLP YIir5aFdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykWYLhf/K3RrUTQU5CKdIl Dx3uvTp2t8TjvdT88NQGpRkfr81yl2P4n37n9PmdL347NvHwqRlmxgW6Htz2csNS3h2lDV952rP +MAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 19:02:58 +0800, Tong Li wrote:
> The `BadFdError` doc comment mentions the `EBADF` constant but does
> not currently provide a navigation target for readers of the
> generated docs. Turning the references into intra-doc links matches
> the rest of the module and makes the documentation easier to
> explore.
> 
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

[1/1] rust: file: add intra-doc link for 'EBADF'
      https://git.kernel.org/vfs/vfs/c/2b0b5bcc45a0

