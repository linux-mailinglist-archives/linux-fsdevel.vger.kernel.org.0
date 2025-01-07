Return-Path: <linux-fsdevel+bounces-38576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D73A04374
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9E118861EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693818EAD;
	Tue,  7 Jan 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azZj8t5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D021F193F;
	Tue,  7 Jan 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261752; cv=none; b=JLBULkvgNy1dFyh/LPTQzc3CVeMpvmAvI3jVuo5I8LsWBmllnPBHz7vrOE6Q+frlGEkpYDYnvvirkvxXhNnC59psILPjBnWi6qc3MlMo9CV4zoHWBNp6teI6PKVpIaird0lXqWQmhg2+ubLSrXTP5py0d0mGP9MIogmDqG3OZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261752; c=relaxed/simple;
	bh=D3SrGJmGP1nkA0Izy75Ej6typmeKVdyh2npKLZI0swE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBW9ltRDPa3Oe38nelXaMEFyFVd3NVW87eAdSEtoXqWw460yzH/av3Wo3BIedrjOH6POI7FWwr5UwmL5lfcZCWxQC8nNSAp9xHChBXTpYoLHGeOCZR8ngbdsAf2kl39IOSovQUiV0DIf/BzHbYa6x3P8rH0UqSTvIymcmwIFFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azZj8t5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86315C4CED6;
	Tue,  7 Jan 2025 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736261751;
	bh=D3SrGJmGP1nkA0Izy75Ej6typmeKVdyh2npKLZI0swE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azZj8t5y37Kgy1PqaugNEocpHpFKtnRDDR1Kx1F+IBxSgWBfsHXY7LxyefiEWGgHd
	 oK//YOo4XFblQwdJgLMbhV3f5QLZdwZPNh+ZIGjXiJL9xxQy7W1RwGXAD7unCUvKde
	 ydMvcuGGF06KmS1HYcUe6PO2pBVbOr3Uk5MhqlPBmj1Yg2+6zs7k8scrwGqWv8HguI
	 ye4qxXEyhJQmJDt0KrFk1E72U9HcoX4V888fFXjceHR84kgaY4Tfi7hmPLLr/S8Vmx
	 Xx61wf7IO3GW0fYw0A659/TPO4+YwBAowIjUudATKmE02CvfvZFraEjXWaEWXhPkBK
	 hN10A4qOPVmdw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot <syzbot+7848fee1f1e5c53f912b@syzkaller.appspotmail.com>,
	marc.dionne@auristor.com,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] afs: Fix the maximum cell name length
Date: Tue,  7 Jan 2025 15:55:44 +0100
Message-ID: <20250107-fundgrube-unpassend-106795b45fcf@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <376236.1736180460@warthog.procyon.org.uk>
References: <376236.1736180460@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=brauner@kernel.org; h=from:subject:message-id; bh=D3SrGJmGP1nkA0Izy75Ej6typmeKVdyh2npKLZI0swE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTXOhS9KtRzcfszaXpRkVloxKvLUh/vRv44pNpaWv4h8 rFD2WXPjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImU6zP8lTyw23hReZ5d/PLe mnL2pkufFt1Nlb3916h/Kce39Xe1ihkZVtamMEsGbuDiLhc526hR8OfG3GvPFSzWHS5m4nAo0tv HBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 06 Jan 2025 16:21:00 +0000, David Howells wrote:
> The kafs filesystem limits the maximum length of a cell to 256 bytes, but a
> problem occurs if someone actually does that: kafs tries to create a
> directory under /proc/net/afs/ with the name of the cell, but that fails
> with a warning:
> 
>         WARNING: CPU: 0 PID: 9 at fs/proc/generic.c:405
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

[1/1] afs: Fix the maximum cell name length
      https://git.kernel.org/vfs/vfs/c/8fd56ad6e7c9

