Return-Path: <linux-fsdevel+bounces-31171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE2E992AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B2228300F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4427F1D26E0;
	Mon,  7 Oct 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+dofVDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966811BA285;
	Mon,  7 Oct 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302330; cv=none; b=ojwhOp13Fv+2v9pIxfCUTwgSw61PvTIfkFNOHkx73iZXpd+3B/F7iORUWTPqUsbS9P96uMdpZsyPQul3T8cgTmK9rom/IcF8owAklayragt79q0H04dqmP2BKHu7bB3T+bHTJuOAayTW545BgZl639aCVIoiYVr7MtwMCXiIKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302330; c=relaxed/simple;
	bh=khvvmbcNdVwUvYoWcpDpONWz7SgWhxezuf85x6iBfXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhPfO0EQhVxz44ZOg016dK/FymGvOWnJ2jlqumJV4rpgiCnYF5fKrB9/MHasJZDGO9S6spkL/l/Pe1mnlEwPuZ/Hc/otm9pMtpL+m2EjIggEiEtX+/7Y64Pb2DS6Sgud60hggmtbN67CJ4GkWGROcAH/6kOErfoUMS6vtdtteFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+dofVDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D1DC4CEC6;
	Mon,  7 Oct 2024 11:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728302330;
	bh=khvvmbcNdVwUvYoWcpDpONWz7SgWhxezuf85x6iBfXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+dofVDJZfONJwuk8iBRC3FhzN90jQzdePvN33DKpVREsWB/VlaocZbLKeRjBNOiI
	 FeSAiYTyTo5pTw9UhtukYpUQRYTqaGDDSnSggqo+lmokr2oM/kLlrCF+RGN3YXlunu
	 RLqTmUBbeRjzhFETMJ9h2JfdlOLeoFeFS5oLghVngQexPIZXLmTMiJ8NSzD2BJ72U+
	 KTW8Ypmmxg6W9F5ysR9d6Yfz1I0Jn7BGB4ikV42jjIte3LKk4QIu53wDkTauuL1pAh
	 pkah0qO1jYn1sJ+mQ8PVQTrtCzDIhko/qds2XPxX1u+2OLdtBhv4dm/iy/EPwpgJR3
	 FlD+tDtETeLgQ==
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve Hjonnevag <arve@android.com>,
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
	linux-fsdevel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v5] rust: add PidNamespace
Date: Mon,  7 Oct 2024 13:58:23 +0200
Message-ID: <20241007-notaufnahme-missrede-c81272cb0d24@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-brauner-rust-pid_namespace-v5-1-a90e70d44fde@kernel.org>
References: <20241002-brauner-rust-pid_namespace-v5-1-a90e70d44fde@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=brauner@kernel.org; h=from:subject:message-id; bh=khvvmbcNdVwUvYoWcpDpONWz7SgWhxezuf85x6iBfXo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzn/lQbOZnxyVV8vy/lKng89MHjS3ljJXjlG49Tkn68 WT1g+43HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPxVWZkOG7Dv0bD4+zir5I1 S17VVhx8ZjtP2VFfcCNHXvykfc/nmjH8r/Fb65PvePHTfpat2b+Mq5Kf1CSUz72vcvGET1wps6Y cKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 02 Oct 2024 13:38:10 +0200, Christian Brauner wrote:
> The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
> 
> The `PidNamespace` of a `Task` doesn't ever change once the `Task` is
> alive. A `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)`
> will not have an effect on the calling `Task`'s pid namespace. It will
> only effect the pid namespace of children created by the calling `Task`.
> This invariant guarantees that after having acquired a reference to a
> `Task`'s pid namespace it will remain unchanged.
> 
> [...]

Applied to the vfs.rust.pid_namespace branch of the vfs/vfs.git tree.
Patches in the vfs.rust.pid_namespace branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.rust.pid_namespace

[1/1] rust: add PidNamespace
      https://git.kernel.org/vfs/vfs/c/2012326b5976

