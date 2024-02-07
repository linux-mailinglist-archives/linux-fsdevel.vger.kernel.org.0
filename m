Return-Path: <linux-fsdevel+bounces-10586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B17284C802
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE321F2473F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC823746;
	Wed,  7 Feb 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsNE91WU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E523773;
	Wed,  7 Feb 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299567; cv=none; b=A4IR+K2l6ULVHMaoAySFHKWXfQdVYyKUC19zglwv1/ojq3ykRcEHycHD1XfyyWO7tYyU+MEiXNpfduRuVPOwk1NLixK/ITaGLjrL6aGcy3GN67uPUBgFJECP9HFu/V3KxNhqmQyNphMsihzeKPos+mOfR3z+NfAPOudIjnQLYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299567; c=relaxed/simple;
	bh=Fh4NajjlR0/egW0fyj1o2PQ+FfeaaJxRFTbpRnFz4/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHnDe2fGtDk2UygzcgJfKMyVe/Bwitb/nnRdhtIAJ7V7OrM9ikb7aKuQOhHDBN+eyO0gRQXJ0LyZ4P2U1BCoXkioyBJ+gsImE8VyPxjWuIxsRqcE0aWSWD3qzFynIkPTHo2Ht7PXvyBfYZ8++N2lwZnWL4FXgv6Ls3cV7MjzVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsNE91WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5505C433F1;
	Wed,  7 Feb 2024 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299566;
	bh=Fh4NajjlR0/egW0fyj1o2PQ+FfeaaJxRFTbpRnFz4/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsNE91WUeUIypaNzh7t0R+r1tlVAsRWRqx8hjpOxmX+VtAWZ98Z3c/Wh+An0bFzyV
	 7ILpExkjDlRke9cphr3bYv7Z1HEHkG6ehsfoH54o6jUOnYJLRK9qN9R1qLUpWDJ31I
	 Y7ncny7x9KV+J8kT5c5ne3L+Vy5eTvySAXHOwNqaPj0QtmzoLEg7ThmDUO9GwFBCCZ
	 mV6jXJU+cAZRgbgVcSK4VZ4T/rOkM77gJKTIxfc5R0rJQBMzgxG7xB9E9yD5tO/OJF
	 Rk3GA+RKt3UoihnxBWjEYSyf6HLUvopGh/SeBDsEexwPp7v3BG+aw+uEjcgW2tb5T0
	 +7MaYzsj4kLeA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Karel Zak <kzak@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: relax mount_setattr() permission checks
Date: Wed,  7 Feb 2024 10:52:25 +0100
Message-ID: <20240207-schob-dingfest-f6c008f8ab11@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206-vfs-mount-rootfs-v1-1-19b335eee133@kernel.org>
References: <20240206-vfs-mount-rootfs-v1-1-19b335eee133@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=brauner@kernel.org; h=from:subject:message-id; bh=Fh4NajjlR0/egW0fyj1o2PQ+FfeaaJxRFTbpRnFz4/M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQeDnomfGOf4G+JWq/KPZcfTb174t3ZuyXdPltC973/m TPztdbKQx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATOR7F8N8l9Z/exdVWlaXH qrumuQtMqbZ+8ePq+lz18ywStnZJ16QZ/kcqaO4JCazYxxi3qPLD5q8aKT+XOPstLp4zbekpPmF XfyYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 Feb 2024 11:22:09 +0100, Christian Brauner wrote:
> When we added mount_setattr() I added additional checks compared to the
> legacy do_reconfigure_mnt() and do_change_type() helpers used by regular
> mount(2). If that mount had a parent then verify that the caller and the
> mount namespace the mount is attached to match and if not make sure that
> it's an anonymous mount.
> 
> The real rootfs falls into neither category. It is neither an anoymous
> mount because it is obviously attached to the initial mount namespace
> but it also obviously doesn't have a parent mount. So that means legacy
> mount(2) allows changing mount properties on the real rootfs but
> mount_setattr(2) blocks this. I never thought much about this but of
> course someone on this planet of earth changes properties on the real
> rootfs as can be seen in [1].
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

[1/1] fs: relax mount_setattr() permission checks
      https://git.kernel.org/vfs/vfs/c/853c4204729e

