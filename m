Return-Path: <linux-fsdevel+bounces-51935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457FFADD2F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B689D3A77EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0E42ED85A;
	Tue, 17 Jun 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrC2u4aJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CC28E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175129; cv=none; b=tb95g/WE1rnQl7czKnBTW5zp1HFnPUQ26hSvTB7UknpqfPglfcLq1cnh08qrlhnzD4aYAhmx/QQR5Y9QhFQVcJVxAKJLVeNXoiyaLrT6la+4hRVIbVyF5fjYGqqU+h1DrarNkkGjkEpFXc2/jGKlJdlbtgWsrOV0oFN2JHACHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175129; c=relaxed/simple;
	bh=TkxYktSgz9zyXmB8yEmnxIsftBD7vhICpHMNCM7oCZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AWNTfkaazg1tA/H37YHaTkNJD7uEaT+X3HT9htABpjG/GC00zXiuMNrW59rAEiE2df4L9pHZzY5fTGwoqHqx3m9iw62k9IMye9oi6uiwZLU6o3dKupgg934lnK81D+BfGHnPeamYMTHUSXofGmlG56jYa/N4sge0RZ+3+ST+onA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrC2u4aJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C527C4CEE3;
	Tue, 17 Jun 2025 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750175129;
	bh=TkxYktSgz9zyXmB8yEmnxIsftBD7vhICpHMNCM7oCZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HrC2u4aJNBk1oSXj3/kro4T4RPRKafoe8ktuQbSzW6YR2q2pZ4DOsnEIn4p9FjTLT
	 cQJjvFTwrQ91nsV2Yr1kKA0WGCsEWJgb3xNF7+XS5B8+dS4ltNA1RaocDa01zwSPEE
	 cqVh10TMS6No0tun8r8JQVBlyRdgpCp8Fsbjrev18snItX4Xs/+NtPpbKhlUbxsVbC
	 YzkjyDLBVcYBmaWWGYJbKBi28a+/aoAwMsOHUPE26Jx9FSbJG0ozl2yFcTRldwUox8
	 I+wg/PyVN72El2CMT1sRMraxVgCAoORtuNwXlPxSeOS3GsauCxXiT/CuEWCcHXDwtM
	 KOC5mlN3macCg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:45:12 +0200
Subject: [PATCH RFC 2/7] pidfs: make inodes mutable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-2-d9466a20da2e@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=690; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TkxYktSgz9zyXmB8yEmnxIsftBD7vhICpHMNCM7oCZA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9k6cenKZ2oPcYts7zyKTEnVP+Kv+/n1l51m36hkMV
 2aYe/I/6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIzSZGhpsrXL62eWupn6y6
 uKbl4KKzJ3TzJhz91qnKKml4RKnxx2uGv0JvOzp/WSV3Zb8+W/HZ8UIud9SFDbbX3fQTPfcvCll
 6hgsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Prepare for allowing extended attributes to be set on pidfd inodes by
allowing them to be mutable.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 9373d03fd263..ca217bfe6e40 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -892,6 +892,8 @@ static int pidfs_init_inode(struct inode *inode, void *data)
 
 	inode->i_private = data;
 	inode->i_flags |= S_PRIVATE | S_ANON_INODE;
+	/* We allow to set xattrs. */
+	inode->i_flags &= ~S_IMMUTABLE;
 	inode->i_mode |= S_IRWXU;
 	inode->i_op = &pidfs_inode_operations;
 	inode->i_fop = &pidfs_file_operations;

-- 
2.47.2


