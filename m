Return-Path: <linux-fsdevel+bounces-15822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21C89391D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 10:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68931281C2F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 08:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA59DDDD5;
	Mon,  1 Apr 2024 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdbTPgmN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56086DDB7
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960800; cv=none; b=QF+t5y+RhhY+bA0pF1ZtTMpjjb9JOPgRCABFX/sMjTyS9A0S1xYeS28Z/8RbcSyzD/NZ06xMsJpOv4AfRzMOsWtr4jtZunXzJjctJfF2E+Nxc1vJXemtpwsTkc55jyeFVjK4BMuYVsdP1dVKCuLaatIfCinCZl/rU0/5fIQWVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960800; c=relaxed/simple;
	bh=vgdeUVyXhHA3q4zDa3spGSLQ2M7q2vkACMSbnQIBDI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6L3mkkWQX3E1Q71k8zA/v23UDJM+CZQsIOtlPZtkiUuzEPaAdeH5JQ8v6lA8tZqbHhCGFlwwOc3aPkV5UnrKt859g56tDZEmLhIpwzracBgnznf6m2QcvPkZDOuxP4HEj5RevNOLui0CVslg06fCgJ2ZaNBNwvvxmlGgd81Vx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdbTPgmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70064C433C7;
	Mon,  1 Apr 2024 08:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711960800;
	bh=vgdeUVyXhHA3q4zDa3spGSLQ2M7q2vkACMSbnQIBDI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdbTPgmNawOeGzV7HcHpH64p+WS7rT9z/gaWbc0mbLrByOv+UlqfHRXRk8c17G0o/
	 oKdEAQyMjVBvZN7XLNXHng+MQYxQE62zUlB0BtiPL1Ej/D3Ggg314A1hJQtSVaBe5N
	 OtLLHpjWD/S08FxC9ycgk0ccS8bmaZrUXuuwuGypxmOqxyiEJDO7kLha/M2MuDPrxz
	 Uo41NmtSu/q+cLdo4hg/h0f42M3J6zZbZqfxTSjwXLtijzUmLegy5gH+ziJefnt+2X
	 OSMmFwKPflqcpynFZu3al21C9Ff6YjABucVWH5KlwyteID5jLNaCPy48sw7ma68IQE
	 o1qVuHX04/P5Q==
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Mitchell Augustin <mitchell.augustin@canonical.com>,
	linux-stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] aio: Fix null ptr deref in aio_complete() wakeup
Date: Mon,  1 Apr 2024 10:39:37 +0200
Message-ID: <20240401-hoffen-fachbegriff-ecf9760b765a@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331215212.522544-1-kent.overstreet@linux.dev>
References: <20240331215212.522544-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=brauner@kernel.org; h=from:subject:message-id; bh=vgdeUVyXhHA3q4zDa3spGSLQ2M7q2vkACMSbnQIBDI0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRxFV1PubzeKc1ipYRFS8XRXb1G10R3Z/Vue+9lPfG6x nHWHqnJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5+5SRYf/sQoYldXsCbW8G xXDsNzgYMkM9dlYxSx//5oPHAs8ULWVk2JstOvXLlCtvM09ZH5c1Odzy/wl35w/Xk5ULRQsX1hm I8gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 31 Mar 2024 17:52:12 -0400, Kent Overstreet wrote:
> list_del_init_careful() needs to be the last access to the wait queue
> entry - it effectively unlocks access.
> 
> Previously, finish_wait() would see the empty list head and skip taking
> the lock, and then we'd return - but the completion path would still
> attempt to do the wakeup after the task_struct pointer had been
> overwritten.
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

[1/1] aio: Fix null ptr deref in aio_complete() wakeup
      https://git.kernel.org/vfs/vfs/c/4d455e51278f

