Return-Path: <linux-fsdevel+bounces-25130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F794952D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830B51F2505F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4E13C661;
	Tue,  6 Aug 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RysdK8l4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B9C144
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960166; cv=none; b=OSPi+5X0aY96QAEH0fIOnfCl36gde5kz+0SgOB+GsO/RoGT3Adiydg/kP9xmqL/FNr1D3dOiTL1fKj3pZYFM4bGzAEudALn+dIt9DMoi9HLYxoNwP/xx4ScN75tnMjpUPxtCNdSVp5sCICxf9xiB6WwgIaZyg+ZCvr7RzCGUofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960166; c=relaxed/simple;
	bh=CMJvcPk73Yhg2hvF422QDgsQzhpQCQjSVQtUQYVkiag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqqQ2xNKl1kB9WtgEcmB0+d3BYlHkgyEppf0FzZtXtOvtqN5cd5cqprl2EVaTFxhR4eChD3zqqy9N7Nfk9NT5/YYdXgzeeezaP7pb/P4M1n7FNMEnUZnO/9mO0w4k8IF1/myMq8ya2NBWa7WYKr2913Lzo0WTf+5FNaSAc83YuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RysdK8l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AD2C4AF0D;
	Tue,  6 Aug 2024 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960165;
	bh=CMJvcPk73Yhg2hvF422QDgsQzhpQCQjSVQtUQYVkiag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RysdK8l4pzrthO4n10U02fpkI+LOzXDXPEkLAOuNwauUERL2USxN7PXCnFj4dzMPg
	 Y+qu6Nje12QbGRztTHWji0cPqXMBuQU2/cb8kxkqeL77DyBO3vLXZPvD1PhfoboueN
	 0L8404RG+auQ+XZERo04eZsalRvIedmZd9b08cQa2RAV3AcRSYFpIeYRnPsPhYSoIP
	 CIwyGjLaZUx7Jo2mhVXXFvnIqytVBX5r0FA0pNqyD1tO78DeCCdiuRvlpYnS7RT6f5
	 KgiGNfYgdo7P+WqHqwsP6ZhLks0JHmlpp0wUftw7hCuo7h39GjL+jBaGwtnUIUp3zk
	 mpE24lMfwIogw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 06 Aug 2024 18:02:30 +0200
Subject: [PATCH RFC 4/6] proc: block mounting on top of
 /proc/<pid>/map_files/*
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-work-procfs-v1-4-fb04e1d09f0c@kernel.org>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CMJvcPk73Yhg2hvF422QDgsQzhpQCQjSVQtUQYVkiag=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRt8pSewHNAIvM8H5fPesbS5M7cuJDZV2O0PMW77Hde3
 SoVzP6so5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLmXowMRxmCbp+0nng1++3s
 C39Sb78r7+mLMEmK/yHr3bVQa/onXob/kQt49nVf3bE6eLFxpc3bBQuCE0NLbCSDNs4LDf+4I+w
 eFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Entries under /proc/<pid>/map_files/* are ephemeral and may go away
before the process dies. As such allowing them to be used as mount
points creates the ability to leak mounts that linger until the process
dies with no ability to unmount them until then. Don't allow using them
as mountpoints.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/proc/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..fce3d377b826 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2276,8 +2276,8 @@ proc_map_files_instantiate(struct dentry *dentry,
 	inode->i_op = &proc_map_files_link_inode_operations;
 	inode->i_size = 64;
 
-	d_set_d_op(dentry, &tid_map_files_dentry_operations);
-	return d_splice_alias(inode, dentry);
+	return proc_splice_unmountable(inode, dentry,
+				       &tid_map_files_dentry_operations);
 }
 
 static struct dentry *proc_map_files_lookup(struct inode *dir,

-- 
2.43.0


