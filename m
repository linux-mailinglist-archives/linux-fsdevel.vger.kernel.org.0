Return-Path: <linux-fsdevel+bounces-32002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0EE99EEBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED80C1C21657
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6381B219A;
	Tue, 15 Oct 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdWbM18k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A191FC7C2;
	Tue, 15 Oct 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001246; cv=none; b=moifmM/OE5nQ0+cDihwsXtIu6T+TwhA+esHS0AZI+EaTQzRroNkr4sWP4xJhRD0R5SShDtL5uHIa0+OVrbO0CNHfEM6y8jMbKGi5GE3/VJbAht739iZmoE+4xSKiIWUGTmlb4mdVBdWUobuyKPibXcxk4rF9exi9ow/0dbk47PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001246; c=relaxed/simple;
	bh=B1FoE/Ep17QfdE5eaxMRqVW5OkffYkd/dWxh4nAC2JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hha2x2hkq3BlG2vaovE6hdOB9l69hBShEgkaLPX2vNou4hiWPIOn+ozvS0PdmEwUk4w66c1KuqnSgAugYC92AYQnrX5UPCXXLPVfqGpEoz4xO2/r4B9tEApfZv9XfLZp7Zu0SuF2jnJ8JzszoicrvJNvhwkS5Fi8vJ8TqoFWPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdWbM18k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1E1C4CEC6;
	Tue, 15 Oct 2024 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729001245;
	bh=B1FoE/Ep17QfdE5eaxMRqVW5OkffYkd/dWxh4nAC2JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdWbM18k31nMIyiJxFzWCISEPklNwuKZjqvFhddnQfYPSJVy3xDBI7r+eZWU2o8kS
	 1LME3J21a25uBfH6w/6QVxpHsDnCChNEmGp72+96YrzyFvXW0n7qFmLZkCQ0T5Gvrn
	 /KDgg28Y/QfmbZ+hOCCWbi2DjPKQIGqYTrSjfruDauwY3AnbN6omAgVqVR10QGih7I
	 YN6igHZhIe3y4ERlxQYuaZ5UDWbuf/L1pJ6UC2yIzOUC3JxjetB9IFt3gZPPttbCC2
	 ZNs3fNemk2fXSL9pWLVS9UC+3Fi2QF1KjJImPmDQNKk/4aSKOsBFWRdQcfEap79H1N
	 HDqSe7Uov/Khw==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: task: adjust safety comments in Task methods
Date: Tue, 15 Oct 2024 16:07:18 +0200
Message-ID: <20241015-rundfahrt-krone-2675dd6d7e28@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>
References: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=brauner@kernel.org; h=from:subject:message-id; bh=B1FoE/Ep17QfdE5eaxMRqVW5OkffYkd/dWxh4nAC2JI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzlYsdyq038AqPzDMXNK0IPrldM2WzukC94UwznS876 vqyLPI6SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJiI4ieGf5dJ+WQ7xkN508X7/ kx+FVhaKBD0TzN56MP2f2Er9F3pcjAwfVvTZnriyqG4fx2qhoIt3vTZ/n30k3DvD/XL7tHCRGUc 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 14:02:12 +0000, Alice Ryhl wrote:
> The `Task` struct has several safety comments that aren't so great. For
> example, the reason that it's okay to read the `pid` is that the field
> is immutable, so there is no data race, which is not what the safety
> comment says.
> 
> Thus, improve the safety comments. Also add an `as_ptr` helper. This
> makes it easier to read the various accessors on Task, as `self.0` may
> be confusing syntax for new Rust users.
> 
> [...]

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

[1/1] rust: task: adjust safety comments in Task methods
      https://git.kernel.org/vfs/vfs/c/fe95f58320e6

