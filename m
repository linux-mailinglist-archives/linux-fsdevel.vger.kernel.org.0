Return-Path: <linux-fsdevel+bounces-46273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A9A86081
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FA916DEE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADADC1C3BEB;
	Fri, 11 Apr 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMl3EnhZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159CD17D2;
	Fri, 11 Apr 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381494; cv=none; b=UkdnWgktxzwOQ6yuwmwOBb6C5lfSBk0HGYUIlcDxJgsgzrvkNyIgzK3naFhxt+IbJrDtrSCusi+D4X4nEssiFwD9gavkF+w+s/RWJej/NDsemV1U/etUSIYTkKPl3teOaiZa4p6cBxlceJ466U6xRN/CyyyJ2BkQ7ZB9G1cAw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381494; c=relaxed/simple;
	bh=nEXymR/eQt1PYODPFLho0tc0POeO7fQ2lEpt9xKM3MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vyk95lyJg330w6EWYYdZJz0KQmCrpJtso3+TCUbsD3Mhs8c01k9k1WZCWKaJQn/9F2PNLJcSdA3b/z3b28cmIsLsvR8y+GW4l6k5YOA03Z/zWzjskPu4vgGkRFJwJ8idxIMnImfkxnQTaU/VTFhP2oJAX7Orzg3W3dIDuaQ0708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMl3EnhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C39C4CEE2;
	Fri, 11 Apr 2025 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744381493;
	bh=nEXymR/eQt1PYODPFLho0tc0POeO7fQ2lEpt9xKM3MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMl3EnhZ6i5vhk3qembdwSNpRWcJQ7qYiH5kLeVlhuIaB9qu7Iv5ABb+m3CLfAsJd
	 ZLQ6H/LFadRoPDgIZ9PzS+UNHxxRgV5NGbb22tgD4yR+Ul5QpR7jqEm9oxhL+JXxvo
	 lhSHf/VLT4m5b5dXQFr7EhPbW0wOdAXk3qjBJnfKK1SeSNv5A0/4eY6ULS/rP+JScx
	 4JrjhCwzOOC/0DZ6L3WSsBYy7WTfCol6/uzY3QkaHzBIOqDvXi7yMBMfnwRDrtvzCN
	 pqC/+0aW08feGvmpcZxuUKuMly3yF/vulK56gwDpEKsA5qkCixSKZAI0LSU0pwpwET
	 Cplsiz2PA0ofw==
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 5/5] fs/fs_context: Mark an unlikely if condition with unlikely() in vfs_parse_monolithic_sep()
Date: Fri, 11 Apr 2025 16:24:41 +0200
Message-ID: <20250411-flechten-berglandschaft-88fd2b1a6c98@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410-fix_fs-v1-5-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com> <20250410-fix_fs-v1-5-7c14ccc8ebaa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=brauner@kernel.org; h=from:subject:message-id; bh=nEXymR/eQt1PYODPFLho0tc0POeO7fQ2lEpt9xKM3MY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/VNN/Nj/B9nDf6RdL5d9/1dc9ESeuusJGSm6vwI7aF Z2MEkWvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZieYqR4bT7J/7rYavjKzYe 7DPb/mfK0S2s8syn9Z+8jb221f9xkQwjwy69FPfFt/ev/Hg6/HeRlXWQhHOLVHqBs12qs5aLBJ8 MPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 19:45:31 +0800, Zijun Hu wrote:
> There is no mount option with pattern "...,=key_or_value,...", so the if
> condition '(value == key)' in while loop of vfs_parse_monolithic_sep() is
> is unlikely true.
> 
> Mark the condition with unlikely() to improve both performance and
> readability.
> 
> [...]

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

[5/5] fs/fs_context: Mark an unlikely if condition with unlikely() in vfs_parse_monolithic_sep()
      https://git.kernel.org/vfs/vfs/c/95bfd4b5928f

