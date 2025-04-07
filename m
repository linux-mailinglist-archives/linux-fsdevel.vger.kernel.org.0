Return-Path: <linux-fsdevel+bounces-45853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D398A7DA7A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463EA16F7E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B32235375;
	Mon,  7 Apr 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp97n+kM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5356023535D
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019697; cv=none; b=f1P5xudqyOUeIH25cYnVkIP6INeyWpOsO9qwIEIms2Ax4oNf2Bsjqh9S/S8FFKzYB16TFFT7bjAJpMHlMGc22XFTzIVOZDVDc3UP4y8wqzoaFIsu2H/Rp3coLBjwex0R54Tj7WbvqOC1FqkrGDeFNhNqQqN9SawgO4Ky1OPK0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019697; c=relaxed/simple;
	bh=98OBOQFblJwLUfpJ22v4FmjzjKsmScxuLc0VekWWN3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izCJIhc0u9a5w+lLSeTiOu/Vx5JKOI2SOacf9eJBue5QEqSbh5x9PUiq8GT/OH1fjMZDb2sOhuFpD0TMXIDfKagDOV+ersdKcXe+ppsGIuzOyQwns+ufdvX2DamZQpukZWlr8uExeORO5YasJA7Jy1rstMt63T9cpOJT3gda3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp97n+kM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A74C4CEE7;
	Mon,  7 Apr 2025 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019696;
	bh=98OBOQFblJwLUfpJ22v4FmjzjKsmScxuLc0VekWWN3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tp97n+kMClf5r30DZ6LE6CiA4G76xWxVJekLk7Hh2/flJXxKdQ+2FEjWCd3o4GsOd
	 AXcd6lZ3nuyg7PMMuoBxCJOhQdBTD6E+4BQFAUeFIZ3sf2mtSjcucPxP1QFlHNkAWG
	 oIZaOfvBUzGSwwg4PTwKHuhT+2tPMzIEZVy+CG4A2URENCh/8ut3GVP0cjtLOtiIJO
	 bjyPfW47SshoZuw9ocnaJjlybUORaSDuLWWleRUxJ7bgtURzMbDdQKRDkegdOgOWiN
	 RDtGd+hhp536dNhc1/Uw05djZMyMeJOU89r28tc4o1P4/OtPOtZWkpBBgZ0rSrqT49
	 ps2REkPJ93kGA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:21 +0200
Subject: [PATCH 7/9] selftests/filesystems: add second test for anonymous
 inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-7-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=brauner@kernel.org;
 h=from:subject:message-id; bh=98OBOQFblJwLUfpJ22v4FmjzjKsmScxuLc0VekWWN3k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnDdWW39qwd67CUfGl5KmBtd8frxIuDPG0nVNs79a
 +UuWk183FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRlemMDC932Fdf25Thyy0U
 7R2x1V9SPzhk9vLNL14v3/q76fq00/MYGXbvO5irZ1dl0uN4d+G84omb+KW/OfjfcOhj3XZqnYm
 BAzcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that anonymous inodes cannot be chmod()ed.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/anon_inode_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index f2cae8f1ccae..7c4d0a225363 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -22,5 +22,18 @@ TEST(anon_inode_no_chown)
 	EXPECT_EQ(close(fd_context), 0);
 }
 
+TEST(anon_inode_no_chmod)
+{
+	int fd_context;
+
+	fd_context = sys_fsopen("tmpfs", 0);
+	ASSERT_GE(fd_context, 0);
+
+	ASSERT_LT(fchmod(fd_context, 0777), 0);
+	ASSERT_EQ(errno, EOPNOTSUPP);
+
+	EXPECT_EQ(close(fd_context), 0);
+}
+
 TEST_HARNESS_MAIN
 

-- 
2.47.2


