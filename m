Return-Path: <linux-fsdevel+bounces-54603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394C4B01835
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F95188EB0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D4227A903;
	Fri, 11 Jul 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1rLlJb5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C763235355;
	Fri, 11 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226793; cv=none; b=UAN014N8dFcqNqRn0DQWwrfzDu3JvgpZzoNtgNAb6W5i/FxVeAfHT4t3QhycXH7sQEY497pMjRG6r1G4CBhvtprO+AE0lQb1CxOcUoOSW9piNIy8aZbxmIQmPIDtSQn464eguq/Bz95jRdd8mv6Nz2W65KYQsAH3oiNK9GlrtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226793; c=relaxed/simple;
	bh=8KMYBLowxMAusWCsCNJGYgTcbLYvQAEMZyBnuCD5fDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNTSD65R/uNoH4Tq1Ji3sx8o+B5n9bToCrsBcdsfalgfI8hEeVAFBRfrrkOD3HPA6YYxaROUA1otDq8Sl4h7KGQ9k+BRwlcEIJfAqhycl2Lqmvr9KLqA7zHCJFcysoYQkEV7emn3TgChJc02Qo+h66M+aY1Tur2tkA2wL2tRKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1rLlJb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F55C4CEED;
	Fri, 11 Jul 2025 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752226793;
	bh=8KMYBLowxMAusWCsCNJGYgTcbLYvQAEMZyBnuCD5fDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1rLlJb5cTYomFzy7lg6bpHZWL20XDdMLBikBfGYiVR1dY5zHTg5kQY4uGgNgh7mk
	 KeciabVTC2FS+5CVMY3RJGUPeP9dSEXmRp+E1O2E3lULZEii2wadila77lIgy6NyX3
	 zk4YW73BmVeoz2dlv+Y88JPY5aJfibFS65CiJSJO6c231fs+9sE+kWTsEtjkQyiIdB
	 N36B++iwY/q2E/V66n6+HC9o6CNCK1T9futhiNqaB7TrXxT7cbmvcWREn9l+OlURoA
	 jaccK6SSdcgYp5sjx/7QHYiVMJ9x5/X4WU3a9gTov51niH/d/HAqa9wFR9XCMCcIT6
	 SXE+bL+JlXhFA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] isofs: Verify inode mode when loading from disk
Date: Fri, 11 Jul 2025 11:39:46 +0200
Message-ID: <20250711-geknackt-plant-f347dc35e76a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709095545.31062-2-jack@suse.cz>
References: <20250709095545.31062-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=brauner@kernel.org; h=from:subject:message-id; bh=8KMYBLowxMAusWCsCNJGYgTcbLYvQAEMZyBnuCD5fDs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQU3H589dAMkVcKt0W2lKhqbPfw9PZVuio14eouyexHd grrs++IdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkoSLDX4Gp4k6XWi3ulJ36 XuRQEe/78uI3S/fSypaNS5nXRG+P02FkOM2c1bhn5ay7ab/iXtaVyP9893e7TdPCpD4ln1wNHfk l3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Jul 2025 11:55:46 +0200, Jan Kara wrote:
> Verify that the inode mode is sane when loading it from the disk to
> avoid complaints from VFS about setting up invalid inodes.
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

[1/1] isofs: Verify inode mode when loading from disk
      https://git.kernel.org/vfs/vfs/c/0a9e74051313

