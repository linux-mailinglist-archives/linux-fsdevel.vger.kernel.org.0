Return-Path: <linux-fsdevel+bounces-46058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A496A821D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3AB7A6351
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EBE25D54E;
	Wed,  9 Apr 2025 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLkVhwoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A661DF247;
	Wed,  9 Apr 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193615; cv=none; b=h+M4yjXzpz0IkIBdsjgYcd6KA5JpcTYS7AguC3TDQ+/c7ifur5YgYMbDKIxSOeca2gmvIAb1mdNAueJreHpZ1X0Res1ljaGibM3W4b41zXthezxvzTplsyZXNjwvjAdylpEU6sbJTlC2FIHj4WAvkD71V/7Na/hBBQ8047I2bWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193615; c=relaxed/simple;
	bh=dUdUWym5ovCHTYE0yebKW3XmpoT7e1/mNzS5YCqW+Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO0OMOiFQ4jO6Xqmvv6fl4yKZrKuSgMzTaw/K4k4ommk2SB/nJn6RfWBhTkF/P4DJ2qixJxhsN0w2bgERDk7C9E0PK+8kyUvj3SHmiY1rfOruC5nfqWo0s2UdzivAxj+gPWNglDC0ItMhRkAFsc6gWTsix36l2iDbyetcFuL+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLkVhwoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB29CC4CEE3;
	Wed,  9 Apr 2025 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744193615;
	bh=dUdUWym5ovCHTYE0yebKW3XmpoT7e1/mNzS5YCqW+Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLkVhwoKBkGTH6hbaWb4/1KKscrHZU/HG84Y2naBxDHAxLeoYagomf8sCOAODXHQ9
	 sP7IbVfh+7Wsu9BHt3WlhuspspgAFY8mzLoPSl3o1qPo6Oeg55bVLJ5Gur6nhirCQf
	 N/aqVPDBpcixMF4LMdPRLTT74BqKBnQEvZ0DxNrnvADhyQ2PNbEO1/dOBxZmHfQQf8
	 1q+MacTqLEvUYGCWN5z118BPPt16b9E2HZh/C4SMLcqOISm7QQGANY5nu9zygUjLkP
	 S2vUTxdUCOuwuGy54nWr1mrCixI5xD4D20Nx6C4H5iyKV+zLLEaQxMKAKV+umc6g2m
	 gezDN3vczU5tg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot+3b6c5c6a1d0119b687a1@syzkaller.appspotmail.com,
	syzbot+8245611446194a52150d@syzkaller.appspotmail.com,
	syzbot+1aa62e6852a6ad1c7944@syzkaller.appspotmail.com,
	syzbot+54e6c2176ba76c56217e@syzkaller.appspotmail.com,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix afs_dynroot_readdir() to not use the RCU read lock
Date: Wed,  9 Apr 2025 12:13:29 +0200
Message-ID: <20250409-osten-altpapier-8ff3e8b0017f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <1638014.1744145189@warthog.procyon.org.uk>
References: <1638014.1744145189@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=brauner@kernel.org; h=from:subject:message-id; bh=dUdUWym5ovCHTYE0yebKW3XmpoT7e1/mNzS5YCqW+Yo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/8/A8W8DVZ7s88vX25gjln+cqZ93dtiBDVnoVz/rH8 SkhJsKdHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJWcPwk/Ft9fer/svP7JTN irn+NVzlT2rm/NOTnJXWMC9dek8x5hojw6sF/dMak0JiLE7rsTy8Xp76OkgoRbl+Qv/JaU+CFvW vYAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 08 Apr 2025 21:46:29 +0100, David Howells wrote:
> afs_dynroot_readdir() uses the RCU read lock to walk the cell list whilst
> emitting cell automount entries - but dir_emit() may write to a userspace
> buffer, thereby causing a fault to occur and waits to happen.
> 
> Fix afs_dynroot_readdir() to get a shared lock on net->cells_lock instead.
> 
> This can be triggered by enabling lockdep, preconfiguring a number of
> cells, doing "mount -t afs none /afs -o dyn" (or using the kafs-client
> package with afs.mount systemd unit enabled) and then doing "ls /afs".
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

[1/1] afs: Fix afs_dynroot_readdir() to not use the RCU read lock
      https://git.kernel.org/vfs/vfs/c/7571ebd29ff2

