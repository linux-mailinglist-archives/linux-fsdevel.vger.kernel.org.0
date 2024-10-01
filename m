Return-Path: <linux-fsdevel+bounces-30472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C298B990
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDF31F233E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871BD1A08A8;
	Tue,  1 Oct 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUeQASf7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14453209;
	Tue,  1 Oct 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778326; cv=none; b=l/t6RSNtrGw+EwH6UhO38Gna5tPj5CBALP6EWPJo9yLVNzQ8jq1uTcPmPjOsBQe8++icwkUsX6JZpMBieypfx9GoIDWXo3ZI1VSpHuTbN4ZdaHttBI4tRdhPd4Hh/ePy1LCkEN8qrCFs6leWoavqhvkumdpjB5BGOu2DVRLaW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778326; c=relaxed/simple;
	bh=40XRHJ41qmaIUOOwC+3RxyO1Go8fZLQLdtuobE5ARF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNA+HK0BqBCpOt6NLKIznjAQDAnlvamQqM1qnxVGxEFLt9EwKPzMQJlkz7GE3moaaqhQfAd9e2SS7T8L0H39TTbmwtzD+XWkZdT+hGsjPr7FBd8JAP+eeyBv6YnVaJSP0Dkf+k74LmzHmCXzK62NyB0C3FrZIGg3p3Jc+k3v24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUeQASf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF5DC4CEC6;
	Tue,  1 Oct 2024 10:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727778325;
	bh=40XRHJ41qmaIUOOwC+3RxyO1Go8fZLQLdtuobE5ARF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUeQASf7hH2sO99rapBiNu8OOB8qxif2o0ce5KqCTbNbZFcoP1ordfFDxSwDzfbML
	 0SFsM1571ahYpG8nostuw7H03t3m4WJwuVZ+kVhyMw18GwujHFKWgRFt4mFyb1/3kX
	 uB4b+qaqSyrt22bZV5XsFwtit1p4n2JMOuPv6g2fbLlO68W60Dgy4tf7LYmpF4S4C3
	 wqClBegl2RZ4s4600jEDrWl61GEe/j/Ez1ScnFbVVYj7IzFyn8cuDttTHMdKd+N06Q
	 tKuVhPZJYzR9cjzNGdHaHHgrkCrWbRRfeVPnqPEOLrG09ZnvfuFYAPMyjq6gC9yq8C
	 v47KmPD3RNd5g==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] rust: add seqfile abstraction
Date: Tue,  1 Oct 2024 12:23:35 +0200
Message-ID: <20241001-wohnmobil-umwandeln-ef7392edcdfd@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001-seqfile-v1-1-dfcd0fc21e96@google.com>
References: <20241001-seqfile-v1-1-dfcd0fc21e96@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099; i=brauner@kernel.org; h=from:subject:message-id; bh=40XRHJ41qmaIUOOwC+3RxyO1Go8fZLQLdtuobE5ARF0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9PseTwCb7qu7gw20TMrwvqi+0XrBlo3kxhxjz7/R8E eFolVaTjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlwT2H4p6Cyakrbl4WmHDmn qxxd4+qr042eMzwNWDHnBrd5jH1XOsP/4jIPz+M/Hkl4XOMXy5/Uuq1W697TLomi7iCztVGV6c+ ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 01 Oct 2024 09:07:02 +0000, Alice Ryhl wrote:
> This adds a simple seq file abstraction that lets you print to a seq
> file using ordinary Rust printing syntax.
> 
> An example user from Rust Binder:
> 
>     pub(crate) fn full_debug_print(
>         &self,
>         m: &SeqFile,
>         owner_inner: &mut ProcessInner,
>     ) -> Result<()> {
>         let prio = self.node_prio();
>         let inner = self.inner.access_mut(owner_inner);
>         seq_print!(
>             m,
>             "  node {}: u{:016x} c{:016x} pri {}:{} hs {} hw {} cs {} cw {}",
>             self.debug_id,
>             self.ptr,
>             self.cookie,
>             prio.sched_policy,
>             prio.prio,
>             inner.strong.has_count,
>             inner.weak.has_count,
>             inner.strong.count,
>             inner.weak.count,
>         );
>         if !inner.refs.is_empty() {
>             seq_print!(m, " proc");
>             for node_ref in &inner.refs {
>                 seq_print!(m, " {}", node_ref.process.task.pid());
>             }
>         }
>         seq_print!(m, "\n");
>         for t in &inner.oneway_todo {
>             t.debug_print_inner(m, "    pending async transaction ");
>         }
>         Ok(())
>     }
> 
> [...]

Seems straightforward.

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

[1/1] rust: add seqfile abstraction
      https://git.kernel.org/vfs/vfs/c/66423ace209c

