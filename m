Return-Path: <linux-fsdevel+bounces-66934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60791C30EA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A17C64F1A04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6B2EF65C;
	Tue,  4 Nov 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVDlSM8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD262ECE9E;
	Tue,  4 Nov 2025 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258360; cv=none; b=HZQdY/T7BoqAQRsrxSkEhZUXGhMqg92PFL+i/LyhSTbt4fUKvQnf2HK4uBZ6nvOhbwqFyh4tWmaZjS5HZkDEAAwmK4LB/rd298vBl/xp4W4q6xW2SR8xHKnfaXvaUNcR664+nC+2W34EW8D+h4T5+OdA9hVutMMYk+krFb0PRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258360; c=relaxed/simple;
	bh=CIuyhA1SE77JCvvV7gCQAcX8DXg3tOccPVuCi/0awLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dJ4ytGyPS/SVEQCv6qMKqzCvSkCwr1uIcUzS5w/bU49azB8dAjqfuFVX7OPxtXlY+C6zhdXyRBwrea7ZfG5Vx7D8ugDQ/N0LIND+1Dn7yGbfg+vefLZyBa2LhwzhHajXf0s9PJAAjR64tMwK3tYMof06Fr1F2yzKye71Fn8uHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVDlSM8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15144C4CEF7;
	Tue,  4 Nov 2025 12:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258358;
	bh=CIuyhA1SE77JCvvV7gCQAcX8DXg3tOccPVuCi/0awLU=;
	h=From:Subject:Date:To:Cc:From;
	b=LVDlSM8B8MEG0S4WDNJ4bkaJqLmR65+8+LOK0k4a4t3evokZWqPaRDJ+SFJWpiiAN
	 m0B54ljecsDO0jzUbjDWlM7YqRgrQP7H9PcFUzn1MnoSm17xDy9fazysa5ArAgtD6K
	 AA22YHjvznNjvwwpb79sWR40921OQWA5pQxUOxoQ7v+vOPLDo20FY4Q7Dh8f5HYIAv
	 BxCVrgcN6YqCI9BeCRy+Zrh5s6+G/PAXSw8F+GuN6eTljy9TpgFA2HzxSdzDd+RJBO
	 50arLI3ISJAihDYz0rqxe1x9JiNsLqjCPnUQTJGk5KpjJm24maWFUb1WtI/0/92q+X
	 0lufpjS5UoU7Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/8] fs: introduce super write guard
Date: Tue, 04 Nov 2025 13:12:29 +0100
Message-Id: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK3tCWkC/x2MQQ6CMBAAv0L27JK2iKJXEx/g1XhY2gUaQzG7i
 iaEv1s9ziQzCyhLZIVjsYDwHDVOKYPdFOAHSj1jDJnBGVdba7b4nuSO/YskKHZchT2ZA7u6gVw
 8hLv4+d+ucDmf4JZlS8rYCiU//EYj6ZOlnHelbVB8Bev6BfndiZuFAAAA
X-Change-ID: 20251104-work-guards-fe3d7a09e258
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CIuyhA1SE77JCvvV7gCQAcX8DXg3tOccPVuCi/0awLU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt2iPkvi+JrF+Uc6WnfcK2EwD04W+J144XDV2VkzN
 r5qyC2a2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR2EWMDG8WbvTTvJj0dWno
 6ZZUBd4L7U6zH3xpUErZpH5u3tyfFrcZGV7rncs6UH51+qySNXZuIr+KW+M03ocynE20eMdeVnp
 bmQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

I'm in the process of adding a few more guards for vfs constructs.
I've chosen the easy case of super_start_write() and super_end_write()
and converted eligible callers. I think long-term we can move a lot of
the manual placement to completely rely on guards - where sensible.

Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (8):
      fs: add super_write_guard
      btrfs: use super write guard in btrfs_reclaim_bgs_work()
      btrfs: use super write guard btrfs_run_defrag_inode()
      btrfs: use super write guard in sb_start_write()
      ext4: use super write guard in write_mmp_block()
      btrfs: use super write guard in relocating_repair_kthread()
      open: use super write guard in do_ftruncate()
      xfs: use super write guard in xfs_file_ioctl()

 fs/btrfs/block-group.c | 3 +--
 fs/btrfs/defrag.c      | 7 +++----
 fs/btrfs/volumes.c     | 7 ++++---
 fs/ext4/mmp.c          | 8 ++------
 fs/open.c              | 9 +++------
 fs/xfs/xfs_ioctl.c     | 6 ++----
 include/linux/fs.h     | 5 +++++
 7 files changed, 20 insertions(+), 25 deletions(-)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251104-work-guards-fe3d7a09e258


