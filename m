Return-Path: <linux-fsdevel+bounces-63541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3297BC118C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 13:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E78D4EC97C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC93D2D94A3;
	Tue,  7 Oct 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD2PaoZq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278421B9D2;
	Tue,  7 Oct 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835384; cv=none; b=btHTa5h4rY34GkW5FhLiNoV3m/hIYy2/YTuQOROWAEV9/9kBwJxbI9EH7xegAjZRLjpxzSj2I0DrXiOp6/yUWi1jDzTVYUQbBGoIniReNtDPDJOF3tLrGpyWR6/lbSoLwni8+e5S1C/Tyg+RAN571rSxrgpwjaeWv50y4inK5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835384; c=relaxed/simple;
	bh=rgq8d4ugZnWe9AV2Ehp8CrYUbkdo9dHQtpNkX4CYq9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTqMnm/pc9o1f3fTiG47EqjDIQwokdpvpt2KtPvP4h8Qp8HIME8vrWSTFDi9P472ZyVhucjfCJccoLw+vAS+K00cT8X1BouzSL6fsVXAhS6kWtR/FzVI0rLEkjdcSpPBSDwqoLGrBWalhuRakbvKN2h4TFEU/6iQubRsr7pWAqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD2PaoZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD597C4CEF1;
	Tue,  7 Oct 2025 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759835383;
	bh=rgq8d4ugZnWe9AV2Ehp8CrYUbkdo9dHQtpNkX4CYq9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hD2PaoZqNW3wbtZfWHVn6VrY/Pp6x/MLA4QY+PCFO/jZ9OMIMnPbzw1n7mMS1UAYv
	 pb0k+SFDM2s7xxMPPKGw/h9ZwFkkjCe/t6QmYhm1eBrN10MKe44ZcLvVSkh7TAGST6
	 OfhTAo0VTxr+dAX7iIydRZyXq4mRFVNmYjJKNoGp+Yv74qKFl/tVts2RbxHHdZuzg6
	 NzAudrJvuMYVcJXhVurF1dFBMCdzExv5SNdiTU94muhDeB2eckwNu+2HE0FPGTKvZJ
	 MeqxodcKPFWENaMCuCnH5wTJ2Yn4nqa0NCKMBdjGbobgUdwc3gtXVZ0b3ZmsasSgXe
	 ayLadNOuhYi4Q==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vfs: Don't leak disconnected dentries on umount
Date: Tue,  7 Oct 2025 13:09:38 +0200
Message-ID: <20251007-tropfen-farbbeutel-cba3590f0b71@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002155506.10755-2-jack@suse.cz>
References: <20251002155506.10755-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=brauner@kernel.org; h=from:subject:message-id; bh=rgq8d4ugZnWe9AV2Ehp8CrYUbkdo9dHQtpNkX4CYq9k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8+fJJ16/tlwl/w7spmq8PHdm9T4BX1PO5v9BigV2ZT cUrzt2b2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRm2IMv9mvHZS3d36isF2+ qL9wh63Mw/8aKXG5j0VnHZG5pfBy/j6G/76zTmR5vNlw6NLcOfOmfZVqflt2diXL4TCpgqjXt15 86mAFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 02 Oct 2025 17:55:07 +0200, Jan Kara wrote:
> When user calls open_by_handle_at() on some inode that is not cached, we
> will create disconnected dentry for it. If such dentry is a directory,
> exportfs_decode_fh_raw() will then try to connect this dentry to the
> dentry tree through reconnect_path(). It may happen for various reasons
> (such as corrupted fs or race with rename) that the call to
> lookup_one_unlocked() in reconnect_one() will fail to find the dentry we
> are trying to reconnect and instead create a new dentry under the
> parent. Now this dentry will not be marked as disconnected although the
> parent still may well be disconnected (at least in case this
> inconsistency happened because the fs is corrupted and .. doesn't point
> to the real parent directory). This creates inconsistency in
> disconnected flags but AFAICS it was mostly harmless. At least until
> commit f1ee616214cb ("VFS: don't keep disconnected dentries on d_anon")
> which removed adding of most disconnected dentries to sb->s_anon list.
> Thus after this commit cleanup of disconnected dentries implicitely
> relies on the fact that dput() will immediately reclaim such dentries.
> However when some leaf dentry isn't marked as disconnected, as in the
> scenario described above, the reclaim doesn't happen and the dentries
> are "leaked". Memory reclaim can eventually reclaim them but otherwise
> they stay in memory and if umount comes first, we hit infamous "Busy
> inodes after unmount" bug. Make sure all dentries created under a
> disconnected parent are marked as disconnected as well.
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

[1/1] vfs: Don't leak disconnected dentries on umount
      https://git.kernel.org/vfs/vfs/c/56094ad3eaa2

