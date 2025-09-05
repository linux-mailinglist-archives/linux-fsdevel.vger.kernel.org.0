Return-Path: <linux-fsdevel+bounces-60355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F1EB45998
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D5A60647
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3FC35E4C7;
	Fri,  5 Sep 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsp2NMjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFA27AC5A;
	Fri,  5 Sep 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080348; cv=none; b=A+9sRqAxhJo35LoGlU2ZqjEO1EuDbiESoUFwLq9EG2i1qoM1nMpTMBYTjc0r7oR3+MXZdhmdHqlK8xtkb5hW8DBXjjuQfBK0PY+zZbINl8YVa9KzVEI6yX5WlJQ8pnZ4JrZlDJxiEPFI8edM9PLYjfGui1DZvV2GLc3/xM5xbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080348; c=relaxed/simple;
	bh=dJfF0Rw0L4xSQFtUq3anCWc2bDQRv8Coe7/OfF8Ir/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvxMz8pbMZcRKkqyU0cv4K/bn4OoFdBsmDRZpvmjDdde/crvwcNdoFLGLu1UTh7dMSEqlISkLK6NbbPy/4Szl7vGbk42row1EUn0Cs4KBl4P6irqQs6Nmi74oYO+J43EGZb8WanGErreTDR8ydHrjqJp7SnbbYX2b56N1V/qVeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsp2NMjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE52C4CEF1;
	Fri,  5 Sep 2025 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080347;
	bh=dJfF0Rw0L4xSQFtUq3anCWc2bDQRv8Coe7/OfF8Ir/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bsp2NMjDEx+QYI95iBU62+tuqV+aboQL/7r+IezDpFXfH0YoWm9FLYiFiv/9RzKYe
	 rRr/VPIa9mh3/DHl8ca3DxU7+a+3gIjcAOBQ7cXwFeIDGgu1MmWHpa/AK/O9rXTzjW
	 knK1tkiRc+X8ddpFL0yehZTsH9G00Uw6ZTOwr9gLSEmvPbQ8kx+yH2KOFqjk1HxApE
	 fBC0GF6IxYnRAXSndRP1tpI2ZMam/sLggsCIpZAdPB6zBf3vHrii5K0ZzmvZGS1VOy
	 lQ1DaihOMRkjuH2xiCBKMMWNOyF8RqUk6IYCTSmK96hfvjzpqF0RwoDruVGF82Rnx7
	 nvYVN9BGCk1Gw==
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/1] eventpoll: Fix priority inversion problem
Date: Fri,  5 Sep 2025 15:52:14 +0200
Message-ID: <20250905-weltoffen-eintopf-551fba944be9@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752581388.git.namcao@linutronix.de>
References: <cover.1752581388.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=brauner@kernel.org; h=from:subject:message-id; bh=dJfF0Rw0L4xSQFtUq3anCWc2bDQRv8Coe7/OfF8Ir/I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTsei3im99+fsm+Ceukai8q/BXf6NbE/oFj1qJp63I1d 9yMWe9b3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR8W8M/8McY7duPLDX1H3t ZfV8tvhZLyd+6X84xWbJr66ALbfS7Hcy/OHPe+Xx0P1s7LcHFSd2lix2vC71Qtnypcvx1pU8ujN nJLEAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 14:46:33 +0200, Nam Cao wrote:
> This v4 is the follow-up to v3 at:
> https://lore.kernel.org/linux-fsdevel/20250527090836.1290532-1-namcao@linutronix.de/
> which resolves a priority inversion problem.
> 
> The v3 patch was merged, but then got reverted due to regression.
> 
> The direction of v3 was wrong in the first place. It changed the
> eventpoll's event list to be lockless, making the code harder to read. I
> stared at the patch again, but still couldn't figure out what the bug is.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] eventpoll: Replace rwlock with spinlock
      https://git.kernel.org/vfs/vfs/c/0c43094f8cc9

