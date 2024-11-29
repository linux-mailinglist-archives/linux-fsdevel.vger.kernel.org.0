Return-Path: <linux-fsdevel+bounces-36139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B89DE6DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D8D164C75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27AF19D8B7;
	Fri, 29 Nov 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwRCQdXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E231E515;
	Fri, 29 Nov 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885361; cv=none; b=bQ/llUGlRha0YYwLfGKnGwLAFDh2coi9QmGUJQB7ulJ4VfZul4OghA5QteADzzVGBDdtLZwUlk80DNwfnZoloG1H1+FSvAhadiyK2rpPB9Z/AVgWsLKQ6Qs/YaBNKSE4+94oUPPTnqzXZZBv3VRW3zWclE1iHQdztxzzHYhMr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885361; c=relaxed/simple;
	bh=2sxux6PRth5l+f8CVfspeq9PFKP9hifG3FyArFbSFwA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bOa+bCsDxn+L+/Uwus2Ff78+DuLMee/vTNxjrcay8V9n7hiLLDOejdow9axfDAfZ9TuZUMydSQhpzFPhmpQ1mrJve5hcMtYpYN44sitRD7zg4SLwDHR9WIm7+8oziQY81HuCFsOM4pNB0yAyFXH0C3oJk0c4GLTQHGxWoEtLv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwRCQdXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40440C4CECF;
	Fri, 29 Nov 2024 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732885360;
	bh=2sxux6PRth5l+f8CVfspeq9PFKP9hifG3FyArFbSFwA=;
	h=From:Subject:Date:To:Cc:From;
	b=fwRCQdXpdJ+cA+jb04grTip9nF9nwdiuY0A3yA/7GyFz6aKB5YCpuY+ug6K+wkbu4
	 7JTv/CROmgT6TOoyrMnajM6pasYnBJ1T5QojdFf0smt2sOvUzOsx4SFMQ60/3Lh3sS
	 l7uv6CHfGUsQjgTwJYWx0WLy1IrOp/DuciipobM2Gqz+EaDoHS74IAf2RyjrPS0yTx
	 jbgFdQ/MbUgQGuBo/9b1Ej8bomNTDm5mUiVvwhOsRLGIJZqBWoXinnOPYEi2l27KWt
	 75UQen8ycNqkkp93HC4sIk2nfel/kSOMe+tjQ+UxcLPPizQEkTp83N8uJGRkCr11YW
	 ltp8d4sVoO1nQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/3] pidfs: file handle preliminaries
Date: Fri, 29 Nov 2024 14:02:22 +0100
Message-Id: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF67SWcC/22OwQ6CMBBEf8Xs2SV0JRQ8mZj4AV4NhwILNCglW
 4Iawr9bOHucSd6bWcCzWPZwPiwgPFtv3RACHQ9QdWZoGW0dMlBMiVKU4dtJj6OtG49U1glVmo3
 WBAEYhRv72WUPuN+uUISyNJ6xFDNU3eZ5GT+xRJsOlULKNrCzfnLy3U/Masf/7c0KY8zihlKdn
 vI6zy49y8DPyEkLxbquPxpiV63OAAAA
X-Change-ID: 20241128-work-pidfs-2bd42c7ea772
To: Erin Shepherd <erin.shepherd@e43.eu>, 
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2130; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2sxux6PRth5l+f8CVfspeq9PFKP9hifG3FyArFbSFwA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR77s5tCvl8gPEdb/fP4jPbWmOZZRdNqp/bWfVR/EyA1
 r7YTeZVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJL2dkmL/lro9WhCObyvJk
 60V/U+8WbTl6nX9Xp1K4tWnwqUgdXUaGBSzz29offTKecqqwb9G+vlm1U0U/mdwymDn/wITTR8q
 q2AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This reworks the inode number allocation for pidfs in order to support
file handles properly.

Recently we received a patchset that aims to enable file handle encoding
and decoding via name_to_handle_at(2) and open_by_handle_at(2).

A crucical step in the patch series is how to go from inode number to
struct pid without leaking information into unprivileged contexts. The
issue is that in order to find a struct pid the pid number in the
initial pid namespace must be encoded into the file handle via
name_to_handle_at(2). This can be used by containers using a separate
pid namespace to learn what the pid number of a given process in the
initial pid namespace is. While this is a weak information leak it could
be used in various exploits and in general is an ugly wart in the
design.

To solve this problem a new way is needed to lookup a struct pid based
on the inode number allocated for that struct pid. The other part is to
remove the custom inode number allocation on 32bit systems that is also
an ugly wart that should go away.

So, a new scheme is used that I was discusssing with Tejun some time
back. A cyclic ida is used for the lower 32 bits and a the high 32 bits
are used for the generation number. This gives a 64 bit inode number
that is unique on both 32 bit and 64 bit. The lower 32 bit number is
recycled slowly and can be used to lookup struct pids.

Thanks!
Christian

---
Changes in v2:
- Remove __maybe_unused pidfd_ino_get_pid() function that was only there
  for initial illustration purposes.
- Link to v1: https://lore.kernel.org/r/20241128-work-pidfs-v1-0-80f267639d98@kernel.org

---
Christian Brauner (3):
      pidfs: rework inode number allocation
      pidfs: remove 32bit inode number handling
      pidfs: support FS_IOC_GETVERSION

 fs/pidfs.c            | 118 ++++++++++++++++++++++++++++++++------------------
 include/linux/pidfs.h |   2 +
 kernel/pid.c          |  14 +++---
 3 files changed, 86 insertions(+), 48 deletions(-)
---
base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
change-id: 20241128-work-pidfs-2bd42c7ea772


