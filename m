Return-Path: <linux-fsdevel+bounces-13908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C3875568
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 18:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4DD1F254D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977EA131E21;
	Thu,  7 Mar 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmvVsLmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74817722
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833353; cv=none; b=tGQ4MXA7Gxa4ltmF339fPW8V77jmnX+zXfF0R0O7JRHSbv7oKPIzy3cWds16TElrOlqUiEE38+sh7Thn2iHT4ZHtIemWiRqjWyHGC3LAxh9GXmd+e4LwBUwvaxTXK6h7heidJ3GDBgNAzFLdgUDcidWAGXuhF/CDC+ZmG8z80Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833353; c=relaxed/simple;
	bh=jIQ/4k8vSjnqNzNcPnEy4vVGjsz9OnbEy/pl9GkP+mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgvDMNqGRd7pbvrfxq4mTEZTQnguIxCCige9I0ButZFpXliEmMzZDSNhsw6UCq1rdvSkqxnY0iwGNJ+s6Yz17XfGG1/Om0+YR0yISaUcCnSFlK0cC3Hp346b045uIYQm7SQIFZjmHXU+LCOc9E+s/J7syCZYhQtVkaXef1QzKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmvVsLmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463D0C433C7;
	Thu,  7 Mar 2024 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709833352;
	bh=jIQ/4k8vSjnqNzNcPnEy4vVGjsz9OnbEy/pl9GkP+mE=;
	h=From:To:Cc:Subject:Date:From;
	b=YmvVsLmjo7y7QXkOgQvpAZZadKHZzDTUOL3YqOlrbTbhuIRgZr/0ij2x8bw3i1xMQ
	 g6LOrx1rgC/s5mln95igvva1+0jrlJV9oS5v7lJZ+xX61pNcjiyCgC61Dm1Q2aJ+mt
	 I2flh2fS+nkydQHvf4F7g+ZSAdjTZ9nHSvTDfXTKrICVH/HL1jbdjmmN5TeB0z8yUG
	 AqlxYDMkKc1OeWem4v+UoSCszOqFTQXbPgGBpTN7n2H39Tig6Miicw5wLwPUl26fzA
	 QRaBKxHZBp8+RS1LWdcRM1c0t4d+Lg7rOBEnRBws2gqQgwC4KttEf6Sx/uN/JB2KIo
	 QKpVc0awCYwOA==
From: cem@kernel.org
To: hughd@google.com
Cc: jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] tmpfs: Fix race on handling dquot rbtree
Date: Thu,  7 Mar 2024 18:42:10 +0100
Message-ID: <20240307174226.627962-1-cem@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

A syzkaller reproducer found a race while attempting to remove dquot information
from the rb tree.
Fetching the rb_tree root node must also be protected by the dqopt->dqio_sem,
otherwise, giving the right timing, shmem_release_dquot() will trigger a warning
because it couldn't find a node in the tree, when the real reason was the root
node changing before the search starts:

Thread 1				Thread 2
- shmem_release_dquot()			- shmem_{acquire,release}_dquot()

- fetch ROOT				- Fetch ROOT

					- acquire dqio_sem
- wait dqio_sem

					- do something, triger a tree rebalance
					- release dqio_sem

- acquire dqio_sem
- start searching for the node, but
  from the wrong location, missing
  the node, and triggering a warning.

Fixes: eafc474e202978 ("shmem: prepare shmem quota infrastructure")
Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---

I had a chat with Aristeu Rozanski and Jan Kara about this issue, which made me
stop pursuing the wrong direction and reach the root cause faster, thanks guys.
 
 mm/shmem_quota.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index 062d1c1097ae3..ce514e700d2f6 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -116,7 +116,7 @@ static int shmem_free_file_info(struct super_block *sb, int type)
 static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
 {
 	struct mem_dqinfo *info = sb_dqinfo(sb, qid->type);
-	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
+	struct rb_node *node;
 	qid_t id = from_kqid(&init_user_ns, *qid);
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct quota_id *entry = NULL;
@@ -126,6 +126,7 @@ static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
 		return -ESRCH;
 
 	down_read(&dqopt->dqio_sem);
+	node = ((struct rb_root *)info->dqi_priv)->rb_node;
 	while (node) {
 		entry = rb_entry(node, struct quota_id, node);
 
@@ -165,7 +166,7 @@ static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
 static int shmem_acquire_dquot(struct dquot *dquot)
 {
 	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
-	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
+	struct rb_node **n;
 	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
 	struct rb_node *parent = NULL, *new_node = NULL;
 	struct quota_id *new_entry, *entry;
@@ -176,6 +177,8 @@ static int shmem_acquire_dquot(struct dquot *dquot)
 	mutex_lock(&dquot->dq_lock);
 
 	down_write(&dqopt->dqio_sem);
+	n = &((struct rb_root *)info->dqi_priv)->rb_node;
+
 	while (*n) {
 		parent = *n;
 		entry = rb_entry(parent, struct quota_id, node);
@@ -264,7 +267,7 @@ static bool shmem_is_empty_dquot(struct dquot *dquot)
 static int shmem_release_dquot(struct dquot *dquot)
 {
 	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
-	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
+	struct rb_node *node;
 	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 	struct quota_id *entry = NULL;
@@ -275,6 +278,7 @@ static int shmem_release_dquot(struct dquot *dquot)
 		goto out_dqlock;
 
 	down_write(&dqopt->dqio_sem);
+	node = ((struct rb_root *)info->dqi_priv)->rb_node;
 	while (node) {
 		entry = rb_entry(node, struct quota_id, node);
 
-- 
2.44.0


