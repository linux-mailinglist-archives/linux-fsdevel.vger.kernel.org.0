Return-Path: <linux-fsdevel+bounces-70119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8024C9151F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DF454E74E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 08:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD12FD68B;
	Fri, 28 Nov 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXrB/ggD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC3285056;
	Fri, 28 Nov 2025 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320010; cv=none; b=HD59BH655YwnPq9Zhf50diPX9j9QJqxI/idmBaHVUuGSS7lU8NZSUJU04qFxM5M7s1xujYAscltsOXcNBwXPXX+gjEaCObQFUBkZ+plgoqtK6W4bDqz0r3tH7xIzcfM0yR8CDRNRSbpXi5AFvCs3yJsHZj4kmPxjkknH11FC0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320010; c=relaxed/simple;
	bh=09Zq5gI9w7z9B4drnQ+eXrVl4FdKoHjsgKeuB5UVSgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J31h69DdSzWRMeRxqyopCRJ7PtFgNmegKbVfTju/k2dDDe3glCTBVMVXdctRlJkrc0pb4TdIo/EFv0RmY1EGQCSO4fTFxvaGv0pw+Z+RJu+YoVTiLl1/4/gzjfANOz8UIXw/mTMYiEnF8J17bDR/9e6bX4wHMeinCyaUR4OIUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXrB/ggD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B3FC4CEF1;
	Fri, 28 Nov 2025 08:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764320009;
	bh=09Zq5gI9w7z9B4drnQ+eXrVl4FdKoHjsgKeuB5UVSgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXrB/ggDv5AGaW83MDx/oxWnC83vZAisqqa08kG5CR+KrYWkHNb8QtyxJLqW5ooFq
	 6A5xPBO5c+zDWbapDajt+HZQkVnbsd2aqsMm+f9pDlQfG9TBCejPc6eTbeGYgfjHNv
	 7liCqvvNxIEiXn7mUWaGNPOKt5otylNDnehGtlgqvqjSXy6odt4/Cw61o6GfjFHCdc
	 WZjwfRD861MoMb38V8nEAbh3R0suYGtDlM9vMRYoogQ/jUmHOt3AaZiAoKZsBWpdgP
	 DhcZsr2zQQw0fpqHblFvtpneaT7u2LroZmPOMge1VG6TeJ+3/Qh+ubqFpbXe8fgzbh
	 5+vfuC0E9mqXA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+321168dfa622eda99689@syzkaller.appspotmail.com
Subject: Re: [PATCH] fanotify: Don't call fsnotify_destroy_group() when fsnotify_alloc_group() fails.
Date: Fri, 28 Nov 2025 09:53:21 +0100
Message-ID: <20251128-umzug-sandgrube-d5b1adfccf02@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251127201618.2115275-1-kuniyu@google.com>
References: <20251127201618.2115275-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=brauner@kernel.org; h=from:subject:message-id; bh=09Zq5gI9w7z9B4drnQ+eXrVl4FdKoHjsgKeuB5UVSgE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqJjO3bmCft2ve3Vd/Hsa9SVzqc5epa/ZmjSiRHtsg4 +reK14bOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi/YCR4a9nWg6z2CKRLLam NTVWV4xP8wQc2i2gbDCrl5OJZedrFkaGFTFPBTtvpRd/NW4+cFGk/s2hV+Li+obVyZV5R/Rbeed xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Nov 2025 20:16:15 +0000, Kuniyuki Iwashima wrote:
> syzbot reported the splat in __do_sys_fanotify_init(). [0]
> 
> The cited commit introduced the fsnotify_group class.
> 
> The constructor is fsnotify_alloc_group() and could fail,
> so the error is handled this way:
> 
> [...]

Applied to the vfs-6.19.fd_prepare branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.fd_prepare branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.fd_prepare

[1/1] fanotify: Don't call fsnotify_destroy_group() when fsnotify_alloc_group() fails.
      https://git.kernel.org/vfs/vfs/c/c2f27f6b8c79

