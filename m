Return-Path: <linux-fsdevel+bounces-44022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7FEA60F46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 11:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DB7176B82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 10:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838EF1FCFC0;
	Fri, 14 Mar 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHYBgeVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055B1779AE;
	Fri, 14 Mar 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949201; cv=none; b=WrTJGedAff95YtbVc3cuE6pTTjt7ScLNPwP7jabmzqtjUeRXUERhHW8TFjO54vf8smZbwx/JxFfRKL003rt4VgJFBCr/q1B8HD2yS8ckWcc0VNRloWKbZL7PXysHP/s4eqzds9DvpfKGvcfP18/b0gLTm916wJ3obrINSOeVhlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949201; c=relaxed/simple;
	bh=lF7PTFH51arnQLHq6qNQ430Ar2rzGHBSApw39Lpcj5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFDh+yFEx6hdJvj4CGIsAIjFxWWCGXc9MQvDcY1ZJTTpd3BJXHtUC8sQaXULQIpPDoQ658jkhjtMmg+0YWHrym+dBAm/TDhWXLxG0uhuI7mlj8cpjGTIXSk1gSqeSB9Q2gpPWdmxyo0K5MIuL3DJvN4aV18LHL8HXR0xvvFL7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHYBgeVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7A8C4CEE3;
	Fri, 14 Mar 2025 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741949200;
	bh=lF7PTFH51arnQLHq6qNQ430Ar2rzGHBSApw39Lpcj5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHYBgeVFZ0aqVinWffoUSzfX1ha7jnpHUVyMtjJbqxcTpSxJ/brygARCYeH89lGuG
	 jRrVaj/Zpo5RX/BgTH/aH9Nq5xPRmmZBdytWNRulpiHRMUyXezM5BiF4N8tHYoglEk
	 jMcAiwGxHTAQMs6bYCjbm4NycSmIhdS/zYcWT4mg4I8MG2REVODnRtXVA0XAKidst6
	 fF2f4Mf9XxYJtcWqNx6MwkgksNY+Wy8IPLadarzhM3vgdpOF2GacodEieW/PteqMzK
	 HOwJrlf8B0q58ggoPf9D6sfOBPqDyTLDy2EjYy6nMOgBWWqzubtoiPho/o514O78N0
	 YIbLSFXASwcCQ==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	autofs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] VFS/autofs: try_lookup_one_len() does not need any locks
Date: Fri, 14 Mar 2025 11:45:51 +0100
Message-ID: <20250314-parabel-anmeldung-db05fcf4d133@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174190517441.9342.5956460781380903128@noble.neil.brown.name>
References: <174190517441.9342.5956460781380903128@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=brauner@kernel.org; h=from:subject:message-id; bh=lF7PTFH51arnQLHq6qNQ430Ar2rzGHBSApw39Lpcj5o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRf4eQsE89dZu4suFBt9hF1vSU5Al8Xv/k082LR8hm3r buMxNcxd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkgxbD/+TghBSe3YuERM7L ZEkzd/D9sO1de8OxbaVPicD526nHTzIyvG5TPOnW9oHzas56jSa9d3vm/4+9VZ161vmf2+aadUF 7+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 14 Mar 2025 09:32:54 +1100, NeilBrown wrote:
> try_lookup_one_len() is identical to lookup_one_unlocked() except that
> it doesn't include the call to lookup_slow().  The latter doesn't need
> the inode to be locked, so the former cannot either.
> 
> So fix the documentation, remove the WARN_ON and fix the only caller to
> not take the lock.
> 
> [...]

Ok, I merged this into the afs branch with a merge commit explaining why.

---

Applied to the vfs-6.15.shared.afs branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.shared.afs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.shared.afs

[1/1] VFS/autofs: try_lookup_one_len() does not need any locks
      https://git.kernel.org/vfs/vfs/c/be348aed9b44

