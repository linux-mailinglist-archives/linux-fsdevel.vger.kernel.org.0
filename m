Return-Path: <linux-fsdevel+bounces-63473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268BABBDD33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D2C1891415
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC6E2676DE;
	Mon,  6 Oct 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ/TUbHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47630212569
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748602; cv=none; b=Od0eT+2VFVJUrkGUlSWe87A1ai6eStHgHtGAVsKIil/z+Rdhh5ND2CvjUHgUg7t8+DO5sQkfKdzYedmqJB1lyv+AiWxPXmsavCL/OLwBG/+d06YbDRyrKuftzux/8u2+vMMneGkosr6ff8WNO1OOrvzqUupGxcb3YHi0WUxqF8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748602; c=relaxed/simple;
	bh=cotaFjgWgMCiyxFcNvHTXRimWlvPi7waTGL1vtrVTDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZN7eX7no59511RY0phDR4P9jNSHnTbEAaqrlAGdcjXb/+P0ib5T+XR2neh+oNDNrNXNLlvlUPvGqhRB+mvYESyzuR8g3omfKgt0VObH4aRyQJ3MNEUIpgVx4wJdGgbtchsysOZhWAzoylLjqhx56beQ7woAOyvhHEP1GDV+sHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ/TUbHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61938C4CEF5;
	Mon,  6 Oct 2025 11:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759748601;
	bh=cotaFjgWgMCiyxFcNvHTXRimWlvPi7waTGL1vtrVTDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJ/TUbHDK2algle7TkQqgToaJ2yiYL5Go/LVWHKbHsE4B9SlM4mYv8uiSOxY4F0Qa
	 YnBwqOG6j8/Ph8PcOK0UWbZ/9ZScjvA+Phk9dJMuIPFPQl4la7dtdvxNOuENvpHyUS
	 Ojh0fswrt0+9TTZv0u6QoqEGcRY6Waqrt0TP8be4Q8hYq4jr/Egro2pparM4GJwvIZ
	 8E1Hbfv4URIJNtSoq+kVaanRDO3QXXbrjv+zsXHY/jeO08osoks5yPWHv5/cpw9Ftl
	 GlZrZnyP7NEFxNfFvL3NVojhM7lewvP65prv/TjTaQPdIQwoEMtCQjk662bBPWXD/y
	 KSQ6AArbQkhJQ==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com,
	syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Subject: Re: [PATCH] ns: Fix mnt ns ida handling in copy_mnt_ns()
Date: Mon,  6 Oct 2025 13:03:15 +0200
Message-ID: <20251006-rammen-nerven-f7dff27e8e43@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002161039.12283-2-jack@suse.cz>
References: <20251002161039.12283-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=brauner@kernel.org; h=from:subject:message-id; bh=cotaFjgWgMCiyxFcNvHTXRimWlvPi7waTGL1vtrVTDs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8Xvh1NefL+YJJScfveXMtVE/zZ7u01LzSu2CR8pmim qqbGyWudZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE5CTDf8cj4is4hY/UBize YHv8hO2s9WEhD5p5X8/eILnx+J3szSGMDC92X2aY3hvFamSm+7PGg0HqV6uxmNlFt7SMtvwXjn3 K3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 02 Oct 2025 18:10:40 +0200, Jan Kara wrote:
> Commit be5f21d3985f ("ns: add ns_common_free()") modified error cleanup
> and started to free wrong inode number from the ida. Fix it.
> 
> 

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

[1/1] ns: Fix mnt ns ida handling in copy_mnt_ns()
      https://git.kernel.org/vfs/vfs/c/502f6e0e7b72

