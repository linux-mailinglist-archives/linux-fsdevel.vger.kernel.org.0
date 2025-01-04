Return-Path: <linux-fsdevel+bounces-38380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC06A0135A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 09:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E25C3A42CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FED14A4E7;
	Sat,  4 Jan 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsrSX8RZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D6EC5;
	Sat,  4 Jan 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735980170; cv=none; b=S2bnryLsr/H6JzkPfv8KW7Qlcuv/EvOmJR3xqt5vEdNPUsgrexEAv7gdgbB+Hdbkk0of+c+EyuMaUKE5F+fkBrUpHh9eVHLx1g6zt3g718d+gyiYUsHCf8gp0gWAHmLZviXeEsZRW5QN0//rP43eJGAY+E0clhZWorzBx3VvEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735980170; c=relaxed/simple;
	bh=dI2FFtsB8VM0uT86jdX2NulpgK1vXGYc9eIJpmi6JzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqp7WLawiRtwwdTZe8kHab+9CbwvVpThr6g9S0Z+Qol2rMu/X/7WE4R20GchiaIYWf25pQuKobaMrn0chMORDlsNlDKSa5WLX0PFRFAHf98/psVrv9P5OaAnEqAv2CJGLIMddasUB3CKQ2WihQjkVNBmwVChtM+5s5D1A8aa/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsrSX8RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E33C4CED1;
	Sat,  4 Jan 2025 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735980170;
	bh=dI2FFtsB8VM0uT86jdX2NulpgK1vXGYc9eIJpmi6JzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsrSX8RZbs2nuwGcmrvS1Gd9B8rcinzsY/dY7uEgrV3LXOk8yDDulKgWTcGhc2FAS
	 U3SHSGRK4UbmS5hdUwhMTEm664SWwMCe8f1bUu7CqJXnf5g2V0B0VyYXadnwfNBWGj
	 OlPeaA3xAROa1CjgwlVbXT33C20qoI4c9hgK49iYf0NKM1f53U57DTZYnj+mKk+2AV
	 yZlYE/miUyhTAVhstMc7g8ehBSDOUkDmfjFRKpDCYycXPf827xKseNf9nQXsJATfPY
	 OVfr6+NpCQMI8ybceE7KkdldnAilHhHWufEQ+4Zwp0ycLYPQZI9Hng+zxGnSTAf+LM
	 wOR3C9/hMtX8g==
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Sat,  4 Jan 2025 09:42:31 +0100
Message-ID: <20250104-lauwarm-beide-c6be67c9b682@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250102140715.GA7091@redhat.com>
References: <20250102140715.GA7091@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=brauner@kernel.org; h=from:subject:message-id; bh=dI2FFtsB8VM0uT86jdX2NulpgK1vXGYc9eIJpmi6JzU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRXfGk8VvJu0keL5ov2DxVqjmS+KJn69VHLhL2T9Jq+2 MrbRcZc7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIwjSGv4KyAf47JvZtVDR+ Etc2ddqi3a8dn2cL6NxceMLxCsuJChOGvzJii7mr1/r93576+HWmjbqSzzftjDN5XhNPrC4WseP JYwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 02 Jan 2025 15:07:15 +0100, Oleg Nesterov wrote:
> wake_up(pipe->wr_wait) makes no sense if pipe_full() is still true after
> the reading, the writer sleeping in wait_event(wr_wait, pipe_writable())
> will check the pipe_writable() == !pipe_full() condition and sleep again.
> 
> Only wake the writer if we actually released a pipe buf, and the pipe was
> full before we did so.
> 
> [...]

Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.misc

[1/1] pipe_read: don't wake up the writer if the pipe is still full
      https://git.kernel.org/vfs/vfs/c/b004b4d254e7

