Return-Path: <linux-fsdevel+bounces-49110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A13AB8237
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529483AD7B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006028D846;
	Thu, 15 May 2025 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzkpGciT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E21DB13E
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300363; cv=none; b=RAOihwN+nLdnFNPIj1K9uLp5e+lYN9jQk0g9rZYxZrUKyuNSnj1J9CnPOng1M6qRK5NnGAYjzEn5sILV0oGKCHxaE2Ut96nkT6FlZ7i2EjPD4vdAf8KRsj9nMAEaBeOgX3rAIcNg15pEbshFtLuomzPTScJUzMR2hfotro8vDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300363; c=relaxed/simple;
	bh=6DN0dtPTY7CuhKwI4qlhW7cNb9FWTRT0hV3iNudhwv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+Z/Z8Y0MbqhQNjDVCvg1Eoh+mGkfb9XqaOjTF0elwWVy764LuDwjx5Xy6ihBlp9MzpxtbiC64H2IWIHAAUZPgHWIK8iRbEaE0bBe0EjYd3rYTAgZ1Wu3Oeid5h6MmKM8+mY356LGJQrRk5xRRo/daxGQx2z3PiPtPgesLUz/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzkpGciT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A13AC4CEE7;
	Thu, 15 May 2025 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747300361;
	bh=6DN0dtPTY7CuhKwI4qlhW7cNb9FWTRT0hV3iNudhwv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzkpGciTuHeSUPpwGpYtZD1j/hmFBMtx2X1enpidKz5iW0LPD+OZ9Q5FQwAkuonEo
	 //Jm1PaBbD7f5sxaEALKRhcHlQpyEsc1V6VGPtMjGUznpr6hrRmCmXvzOB0XL7zCJ3
	 2D2f6/ZH6ePgtGMSqPrlQwybUOKbXr75M1o5vxQjo3m6uWDJ/MwSlbvxoyI0kQYvJR
	 /xSxHrfrqv0M9d/1dBsJX6FgjGufkMZNJY0khTZhS8JSwxUeqxBK7+XOMc2fP/9foB
	 3OxMZRI/fGwdt/yQu/zDKUjUkBFRYAXOKZ1CCgTQUw3ps0QnOhGDJiayz6p776tTTO
	 7EMBPSvX/TH0Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH] fuse: don't allow signals to interrupt getdents copying
Date: Thu, 15 May 2025 11:12:25 +0200
Message-ID: <20250515-antlitz-aufzwingen-cdba155ce864@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513112335.1473177-1-mszeredi@redhat.com>
References: <20250513112335.1473177-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=brauner@kernel.org; h=from:subject:message-id; bh=6DN0dtPTY7CuhKwI4qlhW7cNb9FWTRT0hV3iNudhwv8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSobmCdHmG7Qbh/vb3y7uygaskTG25/M5HM1f1+9+Z75 rULQy1mdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzktSIjw3omQ+n5ZzbJL+L+ +NLwzJ0f7lNunQy97jKv6a7jh5n6O7wZ/jtMk/AVFU29af+E/cLJBcXpk474h3W79XS93S1Zyzi tjRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 13:23:31 +0200, Miklos Szeredi wrote:
> When getting the directory contents, the entries are first fetched to a
> kernel buffer, then they are copied to userspace with dir_emit().  This
> second phase is non-blocking as long as the userspace buffer is not paged
> out, making it interruptible makes zero sense.
> 
> Overload d_type as flags, since it only uses 4 bits from 32.
> 
> [...]

Not pretty, but fine.

---

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] fuse: don't allow signals to interrupt getdents copying
      https://git.kernel.org/vfs/vfs/c/8d9117009dd6

