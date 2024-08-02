Return-Path: <linux-fsdevel+bounces-24860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105C4945D2F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04CDB21FD2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9E51E2876;
	Fri,  2 Aug 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft4ErLKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB871E2865;
	Fri,  2 Aug 2024 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597735; cv=none; b=b40Ph5RO0YiOXzFetPAPS++oZzzjYaNVUlq6P+NFbZHYCMTTdvVAuSN4CVKzuTQbLcsjE1wdvMhljewcDfjHYBw3+iHy9OZNaz/MS7N6oeT3Gnd/bkeWeNS/E+GnPjqUdsk0UrhyGpvzVvYLdOij9qu1eg/3EeL2JL0kDi26M4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597735; c=relaxed/simple;
	bh=sTYDAl+GhWVFIrJHX9/36OBshNazLnzFGi1gab3mprc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ga/wZ6KA4HCTVOxirLtFd7muXRojXxpOTP9bcuwPSy1RfMdQi3iBu+ZRpepSZKxtuiA92ZIC0nhBv53FaqdXCMWhTCLipv0EGug784BzBwse38jV87ifj1e6wcd4AkCniJPFj1tQaFsyfGSpz2JeHDZD7QGLhjjRuYxfWxpPdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft4ErLKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1356C4AF0A;
	Fri,  2 Aug 2024 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722597734;
	bh=sTYDAl+GhWVFIrJHX9/36OBshNazLnzFGi1gab3mprc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ft4ErLKKsCb2O29R7k+q4UD58rM7PXs6HaR29kODgIC4dqihnEqviyQJlxB0Jjxi9
	 eM8iHIR+c4YkTye2aSepFGYQYEgKA7/PL/ffQlvfpU4AGzDFJKRIKeTtTP/He0VRAJ
	 s+VF8PKNQXLwNNwdDBT+B1o7XQYwWYrXnXO87AuazAoy17EVrTSCBiYii/fxWhQFdp
	 36mRV1pi3e8BKQb0XUQGjBKup95jiDcuQhW9uEIZVs7egek1GVuhC1GkuXoYjRwsbw
	 /vmztlJYR3iwk4A4f3d9RE/G9/H4XxxyhYke1wLk9okcVXsuav8irFptqUHgJ2eJIG
	 ToHAPYDAXgeCQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kernel@collabora.com,
	gbiv@google.com,
	inglorion@google.com,
	ajordanr@google.com,
	Doug Anderson <dianders@chromium.org>,
	Jeff Xu <jeffxu@google.com>,
	Jann Horn <jannh@google.com>,
	Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5] proc: add config & param to block forcing mem writes
Date: Fri,  2 Aug 2024 13:22:05 +0200
Message-ID: <20240802-pudding-wellpappe-98827e258859@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802080225.89408-1-adrian.ratiu@collabora.com>
References: <20240802080225.89408-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=brauner@kernel.org; h=from:subject:message-id; bh=sTYDAl+GhWVFIrJHX9/36OBshNazLnzFGi1gab3mprc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaStORi3xf+Md2msxXRb6UXHm29YOlgv3P+dZ95945AH1 3unJpu5d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAFxElpHh2JRvhgc3d3PIim3k 4VSf9134s+4qRqNtbeu55y3WjNspx/C/jneJzLkVuVc+PdtvpMPL1NzVmCYntj7gedPzBIG5j7S 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 02 Aug 2024 11:02:25 +0300, Adrian Ratiu wrote:
> This adds a Kconfig option and boot param to allow removing
> the FOLL_FORCE flag from /proc/pid/mem write calls because
> it can be abused.
> 
> The traditional forcing behavior is kept as default because
> it can break GDB and some other use cases.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] proc: add config & param to block forcing mem writes
      https://git.kernel.org/vfs/vfs/c/26f9eafd16c5

