Return-Path: <linux-fsdevel+bounces-12927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EB868B67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B3D2825A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 08:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CEA1332AA;
	Tue, 27 Feb 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Atf59c7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A17BAE7;
	Tue, 27 Feb 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024158; cv=none; b=qkLLcN6s/ix3feQ0y12SpybxfBUgUo/J8jog+2NIR39ZX45dZR4Gz0TDCFMegoV0Q5c+EA/nW09njTTTe/px43f+SEG38k05dIFAbP739ASe1e6Z+oApPPQdz/5qQtJXagPSpd3g31KygtdZtj6Twmhwm/XZyrxcfFQJFJeMHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024158; c=relaxed/simple;
	bh=5G55jJ37yALWJA3Flq+WvEdMPXWpcjNUm7qt5e07zjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jybwn+CZPq2SYzMBkM2xn/rrf0SSsPDnX4JXvmk441CzqR6g/DJM9XCrR2+OGyAfrvkX+VXsVQWxt5SKvBiGr6ivrhmknyXOTi9yRrC2T1+ld2YtXQJjq8wAI6FFIpEW4zEuxm1A2T+CdO8REWXafKHUIzbvYmRvO22bFpjDDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Atf59c7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53987C433C7;
	Tue, 27 Feb 2024 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709024158;
	bh=5G55jJ37yALWJA3Flq+WvEdMPXWpcjNUm7qt5e07zjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Atf59c7AojkRaAezxeXkTBddWmqVYEMpSVUixZRLuOjEHENfviEcMjLSwalrOCpoc
	 acf8jx9tPSPoNHPo447tkiyWUxwBHQHOjWXK0Ppq0QQA/mIgZ4RE8Un0gcmnwgLDDS
	 XoOU4JL7rMQMFTAVCCGJ+z5BCeoWSUcf3jJY1hBzG0LUR0tLErSiEPMmvr7C8tSdEJ
	 HqlJipaTmwspWwoUoRe2fO5uz7JTTPFR6h+8V+g0FvNDUIRrcyiBBg02tjOhDnUWYw
	 GydX/0bU1zUzyko2UBeOOEwTA4tMe/O7HZHdp9lWsBWRwK0iLl9t8ZRcwvXKpeAyDG
	 wDmjqEK4T3rRA==
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Avi Kivity <avi@scylladb.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH v4 2/2] fs/aio: Make io_cancel() generate completions again
Date: Tue, 27 Feb 2024 09:55:49 +0100
Message-ID: <20240227-kostenlos-handwagen-e8dbe564375c@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215204739.2677806-3-bvanassche@acm.org>
References: <20240215204739.2677806-1-bvanassche@acm.org> <20240215204739.2677806-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=brauner@kernel.org; h=from:subject:message-id; bh=5G55jJ37yALWJA3Flq+WvEdMPXWpcjNUm7qt5e07zjM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTeXTyNW3TbX7tlRnysjje+FEl9vKTBoaa6ob/+ToRvR u/tBOuLHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJSmVk+B99TKD6nptiTNpN 38Qw5+f5ScaVziLzGLofiLCamc9NZmTonzf5g/Wso50f14jtYY+fUL1p9UK3n289O5f09u9Ue3K OGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 12:47:39 -0800, Bart Van Assche wrote:
> The following patch accidentally removed the code for delivering
> completions for cancelled reads and writes to user space: "[PATCH 04/33]
> aio: remove retry-based AIO"
> (https://lore.kernel.org/all/1363883754-27966-5-git-send-email-koverstreet@google.com/)
> >From that patch:
> 
> -	if (kiocbIsCancelled(iocb)) {
> -		ret = -EINTR;
> -		aio_complete(iocb, ret, 0);
> -		/* must not access the iocb after this */
> -		goto out;
> -	}
> 
> [...]

@Jens, please take another look at this.

---

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

[2/2] fs/aio: Make io_cancel() generate completions again
      https://git.kernel.org/vfs/vfs/c/ff365e6bc31c

