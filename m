Return-Path: <linux-fsdevel+bounces-69291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9923BC7681F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C54334E3C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88EA3064A3;
	Thu, 20 Nov 2025 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGnXSF2+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236427F16C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677962; cv=none; b=R9dLu9FMOcPLUf7riNwHB3Qd7jl/dIIs5NP3D3w5S7IrJPyGS2mJVyybQzcL8XXwB1QBxxVVbHz7ag4l9fYBAcpU0az577831MCVZOVavSX7gXjfhrapKLVwHmmGkhb8Qe9e8z2QIh0y8Sv1x1Hqif43yq3E0mav1K/cys+INkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677962; c=relaxed/simple;
	bh=JJo8nH22IqX1i6lz/2v0w3HCXGgUZ8H3ZP1fuca3fmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9VRRhkVD0ybHQSj7vx4iWgwATcFhOVOfMrVrf+N9lQUUs6Xj3ZbUrg9MiRHfQZFmndfTyZ7mTPPQ+Omey0YDBYx2sex2/YrGSnjKdq1txI81Fmu4uua9+mTnyXusAnvDuwlAa6E9Lf9eEFctlFrPpajG/PrpinyEv9H+ayXc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGnXSF2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDA5C4CEF1;
	Thu, 20 Nov 2025 22:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677962;
	bh=JJo8nH22IqX1i6lz/2v0w3HCXGgUZ8H3ZP1fuca3fmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jGnXSF2+qyf0D3MTxdSibCum4C/R8k6kRWEg0smOtVHjj1H5R6ljbeaPmJ5v3He4g
	 sWbZy/4hUWTHz579fvVo0WJX99VgORPpCntako9yCZ2FlgRCY4ZIiMWXdDmAazdqrF
	 QmGG72ln8ey+osuiZgmgWNAO+NL5T9U5oTBpG0ZCwBaQLBydI4hcjIgPPZ5Jgm4whD
	 JsFRetH4WH27mx0D7zlm9XIjqxBsf6eWou7myqAmZS1TPlLbQqd/vaSZSA6wadbGcQ
	 ntKojhHp66AL81DBC/Geq36rShYUS7zrANkzT9MiH7YAmCfvAYVcpJoJi73017EFQi
	 fYinXeoH2L0Xw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:09 +0100
Subject: [PATCH RFC v2 12/48] eventpoll: convert do_epoll_create() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-12-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JJo8nH22IqX1i6lz/2v0w3HCXGgUZ8H3ZP1fuca3fmg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3ujecf+/pz+W5HX9aOOT2T4ZrDiyelq1au8WRHXn
 vJqL2x801HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRXaaMDB9u+ymmfhHS3uV+
 58V7lzZZ2RXLru6Oes9m8t008EH7ktcM/4umT3736O/pl9sa77QW936wmZgS+fhykYvvQ6tFQZc
 CVnAAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventpoll.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ee7c4b683ec3..908525e5061e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2165,9 +2165,8 @@ static void clear_tfile_check_list(void)
  */
 static int do_epoll_create(int flags)
 {
-	int error, fd;
-	struct eventpoll *ep = NULL;
-	struct file *file;
+	int error;
+	struct eventpoll *ep;
 
 	/* Check the EPOLL_* constant for consistency.  */
 	BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
@@ -2184,26 +2183,17 @@ static int do_epoll_create(int flags)
 	 * Creates all the items needed to setup an eventpoll file. That is,
 	 * a file structure and a free file descriptor.
 	 */
-	fd = get_unused_fd_flags(O_RDWR | (flags & O_CLOEXEC));
-	if (fd < 0) {
-		error = fd;
-		goto out_free_ep;
-	}
-	file = anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep,
-				 O_RDWR | (flags & O_CLOEXEC));
-	if (IS_ERR(file)) {
-		error = PTR_ERR(file);
-		goto out_free_fd;
+	FD_PREPARE(fdf, O_RDWR | (flags & O_CLOEXEC),
+		   anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep,
+				      O_RDWR | (flags & O_CLOEXEC))) {
+		if (fd_prepare_failed(fdf)) {
+			ep_clear_and_put(ep);
+			return fd_prepare_error(fdf);
+		}
+
+		ep->file = fd_prepare_file(fdf);
+		return fd_publish(fdf);
 	}
-	ep->file = file;
-	fd_install(fd, file);
-	return fd;
-
-out_free_fd:
-	put_unused_fd(fd);
-out_free_ep:
-	ep_clear_and_put(ep);
-	return error;
 }
 
 SYSCALL_DEFINE1(epoll_create1, int, flags)

-- 
2.47.3


