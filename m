Return-Path: <linux-fsdevel+bounces-13584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483968718E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FAF28410D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB45491F;
	Tue,  5 Mar 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIc4DOlQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06B5490E;
	Tue,  5 Mar 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629393; cv=none; b=teEpeBLLyHTUgcvIG3jEYIbcbreuylVlZa2glsAPLkzXY/LfAll7HtqlbBxlkvGsZ3btkgCYvIdO66OVoEurgdW2YFe1s1e5HIXw3rnKry3W33qoG1sqW2n02HcLL8/qM0NxSDEqlRm4ETbh8FZwaN5JufxfrIfrX8m4YIz3S6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629393; c=relaxed/simple;
	bh=0z3ZfR7fH8MNjZhZhjSXXycCjPoCP8KMQwydlho5Ss0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGX+NgdGC8AQyJqQBHaVxUYKheHo4aSCfG7xZBGCC4Osqd/zYWkqmHfHFPGB/+a2IJImQwr8f0v/QYf6B86LSRGroGYnjoO3dnBycYflsjbjSbfy4mIJXLdWl6a1n/M5e6svRh0aFYGTx825TRtxo3oEgvchwNUu1pOzelxEj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIc4DOlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEA2C433F1;
	Tue,  5 Mar 2024 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709629393;
	bh=0z3ZfR7fH8MNjZhZhjSXXycCjPoCP8KMQwydlho5Ss0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIc4DOlQj7dQchzqZueCPmUNmZZYha0RNvJnu4rRL0c67/MvVpGM4K5wkF4P/ZzG+
	 dJEU0hIYKXOz9dnJVO7XBwfJZmHkJ9KdM2L1P78pHqF9QT3mvpf572538gveRMJBOH
	 hQMOMTWw+KfW1w8N5/smmNUcuEsP4D7ffBfVlkX8+xS9ZXdP//yE1uh1rAfqehFb6u
	 Zo0z42efKBtF7aoeFKk33NEo+UTHCHm0HyEEnhM8ks5skSHs3+0L3lly3mF+sZEF4y
	 7bVZZvFwn6QNbeL4KKrVUn/xfqF7uG14oWBu9ife8B8nDHD7RpCEf9MU8yKq8prCjB
	 ptPJMDSvauQCA==
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Benjamin LaHaise <ben@communityfibre.ca>,
	Eric Biggers <ebiggers@google.com>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	stable@vger.kernel.org,
	syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Subject: Re: [PATCH] Revert "fs/aio: Make io_cancel() generate completions again"
Date: Tue,  5 Mar 2024 10:01:21 +0100
Message-ID: <20240305-querbalken-bewarben-8cd446ceed55@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304182945.3646109-1-bvanassche@acm.org>
References: <20240304182945.3646109-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=brauner@kernel.org; h=from:subject:message-id; bh=0z3ZfR7fH8MNjZhZhjSXXycCjPoCP8KMQwydlho5Ss0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+u3+i6KTk+vXX3z6d4rc5g9fYbgp7plDw9FeXjXRDG n6Gq1Wwd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkLgvDP9P9MYcLuzMXqc6J f9OzZvaRpeoJWfuyxKt3SF51ePFh+UFGhnNz/rx6w7txtZsDw0P5nAzzR+eclBLnNGkGPs+O8v7 znhkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 04 Mar 2024 10:29:44 -0800, Bart Van Assche wrote:
> Patch "fs/aio: Make io_cancel() generate completions again" is based on the
> assumption that calling kiocb->ki_cancel() does not complete R/W requests.
> This is incorrect: the two drivers that call kiocb_set_cancel_fn() callers
> set a cancellation function that calls usb_ep_dequeue(). According to its
> documentation, usb_ep_dequeue() calls the completion routine with status
> -ECONNRESET. Hence this revert.
> 
> [...]

I'm not enthusiastic about how we handled this. There was apparently
more guesswork involved than anything else and I had asked multiple
times whether that patch is really required. So please, let's be more
careful going forward.

---

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

[1/1] Revert "fs/aio: Make io_cancel() generate completions again"
      https://git.kernel.org/vfs/vfs/c/d435ca3d38eb

