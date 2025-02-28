Return-Path: <linux-fsdevel+bounces-42839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCA9A496EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 11:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8ACC1884DFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697425F963;
	Fri, 28 Feb 2025 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPqw8h1p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F02256C74
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737881; cv=none; b=nE6KAzqAHEYrqCOwst192tYaLyzgPSpE/aia200ikDayVTrb/uMhG9yodivftBKzh2NjrREnLdS65X1Bo93cGCxoGMH3xmCh5vFAjou3y0tiz/DkDFik1ylYlHiGoWVQWrvMW/s4RJ1J0+JRtJlB2J1GJ5pjYJiV8/Ml6Du0DDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737881; c=relaxed/simple;
	bh=9sE022UpymRPMJeH7GmXqvdiwZeXsCZS9lw3Cxxohog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rf1TUONweRNjlsHxDOLwkuhcmg6Znhiq8cFaNttz0u7ZW5pTUWPld2CbctXokckMuGcRlXrz+7ukDDauZ3ZCGUAQ6+wPMzs0UlPwbHVkjY4AprIRQBDmnExuf2I8drtNapzGp/h6NBOHEZZ+wgou+qtOZk727PDKi2z5uVVaYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPqw8h1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB9AC4CED6;
	Fri, 28 Feb 2025 10:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740737880;
	bh=9sE022UpymRPMJeH7GmXqvdiwZeXsCZS9lw3Cxxohog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPqw8h1ps532FBv20+KmuQTxvEjUHBfPkMY+W9mFFzNkTeCuraAPzO9w5VbzExl6H
	 2pg0R21mX3KoArOZWY0hyZNYhhjQvcukslHoD+SGl+//a2uY3Xp7n4aQuD5U06eRzK
	 Y7NlRUH/rjnkXfvV5po1hoxlGLcat7hVU5xfankk99j/cUvswUJC37FIB3hOPGcrW8
	 r8M3rqCK1ghYiG/+cSapY7A68M+LSU8uc9g2vbuaJH1R8cbdtp3rojTibhRsnSgGQx
	 ji96Hwz6aBBUp5JAPn1WW9cjHE32qLgor0lv5tW9j2Z8zTn26W2BiOL1pCXgtv8Bjs
	 M9BiRiioq1k1w==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Lukas Schauer <lukas@schauer.dev>,
	Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] watch_queue: fix pipe accounting mismatch
Date: Fri, 28 Feb 2025 11:17:53 +0100
Message-ID: <20250228-marginal-sektkorken-eb11c52a7792@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <206682a8-0604-49e5-8224-fdbe0c12b460@redhat.com>
References: <206682a8-0604-49e5-8224-fdbe0c12b460@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org; h=from:subject:message-id; bh=9sE022UpymRPMJeH7GmXqvdiwZeXsCZS9lw3Cxxohog=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf7A1e6n4h9Ghs/bEQdW2GZQ13FD3zIz8mb1JaN+WAc kCWkmNGRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQs8xj+F7yqYvxhct37qsVD Dj6dJeUP1xd8XZnYvq9yT5LE4Q/f9jEyPJW7193/RHXx/JtBwQcTT4bVLQ/dv1LvZ9sn3/LXOoz POAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 11:41:08 -0600, Eric Sandeen wrote:
> Currently, watch_queue_set_size() modifies the pipe buffers charged to
> user->pipe_bufs without updating the pipe->nr_accounted on the pipe
> itself, due to the if (!pipe_has_watch_queue()) test in
> pipe_resize_ring(). This means that when the pipe is ultimately freed,
> we decrement user->pipe_bufs by something other than what than we had
> charged to it, potentially leading to an underflow. This in turn can
> cause subsequent too_many_pipe_buffers_soft() tests to fail with -EPERM.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] watch_queue: fix pipe accounting mismatch
      https://git.kernel.org/vfs/vfs/c/483b7214f602

