Return-Path: <linux-fsdevel+bounces-25131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A6C94952E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECFF1C21A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5142AA9;
	Tue,  6 Aug 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izy16J70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94128382
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960167; cv=none; b=Jx0mG8rC++a5iVkWdxYNJqT7MgskzzhicD7+zL/hraka8bSHTi3CO1gcd6ZOQ1dIkrxR3Bb7eargRBrXHi/n9Lp8xypQEw5ShDQUqvqujKCR1TbL2tbgpKiKwBnoJKwHCsqgasPiq5Cy+c//YRAoqJ2OuGOdPIzaUcKiZygrUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960167; c=relaxed/simple;
	bh=mGE09MY53cVyBZDTv5xs8m17LFOvUXS/Bx6Bgx9K2uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OX4rDH/Njz1r+wy+W86OFJBPh1okjIyphL4mypBmQACtO90zwZ5nJ08LLKhk3RkkokHnj1A78kTnVQ2qZIcNa0Wx/OpukEGMO/fYXKF8s0zERA1MGDOv4yYpJx4FhPP/oKvw3OV0Jm56omKVYLgoOBy0QYc/EIvmFPbeg7qmdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izy16J70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14D0C4AF13;
	Tue,  6 Aug 2024 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960167;
	bh=mGE09MY53cVyBZDTv5xs8m17LFOvUXS/Bx6Bgx9K2uM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Izy16J70e00QhZLDiNRn1JQKGtb0D9WZQHBwDCe9XSVoGsMaDRqMyBfFKXMu0sNvE
	 kwS1UVB2OszOYTfQr4cPKnIN6AoYI4nqGTcwJ2+KsvLa83j8S40ZKSxGDq/XTynIH7
	 39pcOYiTNIr2c8ax2oM63zNJf055VBWPtRNafq3kT/LAby5Vn9tFeRqtZe3BXjoicp
	 7KT68eAR4oI/wLRxwW0FG/3k3u4Hu1CFLw1J0Nndw0foytOAly7bJOqudh9zmflDBC
	 wMOEqhzDxssSqFYcrlM3QCQuqrYyM76E4bMkGzIJzeCQOor8FRE7U2pMcOc3GagMU2
	 uWZeen7r0Jfhw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 06 Aug 2024 18:02:31 +0200
Subject: [PATCH RFC 5/6] proc: block mounting on top of /proc/<pid>/fd/*
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-work-procfs-v1-5-fb04e1d09f0c@kernel.org>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mGE09MY53cVyBZDTv5xs8m17LFOvUXS/Bx6Bgx9K2uM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt8pT+UVVh4pv2sih5VnaTs1Grsrym7LW+uUuK2Vhq7
 7k02Lt2lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATGSvB8P/uoeb3p5p3sj1eO4H
 Hd6Ai4skOO6+LQvcnSjX993FJ3L3IUaGN+IqN25MmWjGNmXH/fXtHsLaf2+cYO6WZdSumv3a6uE
 CXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Entries under /proc/<pid>/fd/* are ephemeral and may go away before the
process dies. As such allowing them to be used as mount points creates
the ability to leak mounts that linger until the process dies with no
ability to unmount them until then. Don't allow using them as
mountpoints.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/proc/fd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index ab243caf1b71..f6b7344b9b2e 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -220,8 +220,8 @@ static struct dentry *proc_fd_instantiate(struct dentry *dentry,
 	ei->op.proc_get_link = proc_fd_link;
 	tid_fd_update_inode(task, inode, data->mode);
 
-	d_set_d_op(dentry, &tid_fd_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return proc_splice_unmountable(inode, dentry,
+				       &tid_fd_dentry_operations);
 }
 
 static struct dentry *proc_lookupfd_common(struct inode *dir,

-- 
2.43.0


