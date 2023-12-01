Return-Path: <linux-fsdevel+bounces-4555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40303800863
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701D21C20A3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2587210E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6NkvaBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D811FAA;
	Fri,  1 Dec 2023 10:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5380AC433C9;
	Fri,  1 Dec 2023 10:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701425509;
	bh=/JWY5TUxCA/GJX+P6jgYK+fCZpvQBUeUInU5i90en3A=;
	h=From:To:Cc:Subject:Date:From;
	b=b6NkvaBphDzf4Kp5Xpiq8JFOupM7o1eMlJw+JuP9g1x3TN8izHuV3jaGeeHpRcLYl
	 656ymcV/jbGV4+esZRHbadTz3YT83999EPNVUDdl6+xYgQqoN3et1VEPtbx8lQEGa2
	 z2eXWFquZgnVLkzKDZVryjFtiD4rTqse27QdWJAMuKQFfOIG+gnWrWakK/JiK8QlLk
	 uta/Kra+QaowOVMFpIjFGJkoLaerqV4vtNo6qStoHY9EunNILYOH5psJmeV7JVrd/p
	 tCP3855dzdTsvmcuUL2FFJ19Nd9wrSu/DPLyNzvXZ8WpKzqvWLR3DmVdBbF5FAKIh2
	 CBIRY+7xgynzQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Lukas Schauer <lukas@schauer.dev>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] pipe: wakeup wr_wait after setting max_usage
Date: Fri,  1 Dec 2023 11:11:28 +0100
Message-ID: <20231201-orchideen-modewelt-e009de4562c6@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=brauner@kernel.org; h=from:subject:message-id; bh=gSHge1TL79kU/FECQt7i56GDWKWuGhAqgzr7xsLilzI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRmbvR3etLYvvaeiqWAEMNS5Vmv3JZ/t/jRdlP1GItc/ cXrW350d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkKisjQ/+66BgWxaO3OXND r2y8e5nB4P7dvexH/5debLJbWJlwIo+RYd+LLw/2G5bxG9RvW8lY0eQj1Pri/f3nlQFLdvWdPmL 4gR8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

From: Lukas Schauer <lukas@schauer.dev>

Commit c73be61cede5 ("pipe: Add general notification queue support") a
regression was introduced that would lock up resized pipes under certain
conditions. See the reproducer in [1].

The commit resizing the pipe ring size was moved to a different
function, doing that moved the wakeup for pipe->wr_wait before actually
raising pipe->max_usage. If a pipe was full before the resize occured it
would result in the wakeup never actually triggering pipe_write.

Set @max_usage and @nr_accounted before waking writers if this isn't a
watch queue.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=212295 [1]
Cc: <stable@vger.kernel.org>
[Christian Brauner <brauner@kernel.org>: rewrite to account for watch queues]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pipe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 226e7f66b590..8d9286a1f2e8 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1324,6 +1324,11 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;
 
+	if (!pipe_has_watch_queue(pipe)) {
+		pipe->max_usage = nr_slots;
+		pipe->nr_accounted = nr_slots;
+	}
+
 	spin_unlock_irq(&pipe->rd_wait.lock);
 
 	/* This might have made more room for writers */
@@ -1375,8 +1380,6 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned int arg)
 	if (ret < 0)
 		goto out_revert_acct;
 
-	pipe->max_usage = nr_slots;
-	pipe->nr_accounted = nr_slots;
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:
-- 
2.42.0


