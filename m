Return-Path: <linux-fsdevel+bounces-14895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763418811C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 13:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F60A285E22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4283FB95;
	Wed, 20 Mar 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeoINsTh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575823BBC8
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938426; cv=none; b=vGHd4bGnUyjU6TJSDa0SAksSzGTiCPGnyFCuCbA2J1QC1rIV6jt+N87O15mN2CybLLGGQSceAPBC33FFk/i4V2Msj39zcDIiVgd9iAGFa/a+xXWRrM8HS9a69nHprCTDT3RnDqPJykhG6mWVtBNOwTg3p74O54f/wl70960Lsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938426; c=relaxed/simple;
	bh=L8vG9X0aLpduj2IMjd1lFAKHMHqMxxJSPbXUMsD9Vz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhV24Xx8nN7qq+ATQ2AK93PaEf8rWiNPKKeMEp3DgTRPed4oadDAeS5xU4F9ddqM/biqxGt55E/I6HtCQAv2KnLPRH4upkuiG1VfSqOVvFeyNvjnfdKBUn8T0JCS25Xf4NSz6IXqPQuIOjFPymhp8jDNyAXQ7cxzUI2xcMZS/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeoINsTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB54AC433F1;
	Wed, 20 Mar 2024 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710938426;
	bh=L8vG9X0aLpduj2IMjd1lFAKHMHqMxxJSPbXUMsD9Vz0=;
	h=From:To:Cc:Subject:Date:From;
	b=qeoINsThEOWj9Hc0GsyoJQB+8JGsYzJG3bv+N2UstanrJLF5KoXOMJMLEsh08Ute0
	 QxeI5GjP4B2v4bDHFUe0moI6QPD8zhTSfodctZgVlCVj6mreRVCuvh+f28ul1bQHmd
	 oirHvAQTq4Q0SIzmadHqjiKIlhkE0KkyQZajt3aT7G6MOHFS84yG6/UPGcnZVervY4
	 mKEzDAszC9112Agddbg1U5U5wGqBDYSnKpzS4uiSMBNXFWKKTCiZ53c/sbpm+gojMV
	 IFaHEPnKBMLa5wd7HviizOA2TlVLvyhQzSIYIZZkV8KfXEujqLrvKZgQ4ukWr9ccrl
	 fPXb69zXGhARw==
From: cem@kernel.org
To: akpm@linux-foundation.org
Cc: jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	hughd@google.com
Subject: [PATCH RESEND] tmpfs: Fix race on handling dquot rbtree
Date: Wed, 20 Mar 2024 13:39:59 +0100
Message-ID: <20240320124011.398847-1-cem@kernel.org>
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
Reviewed-by: Jan Kara <jack@suse.cz>
---

Hi Andrew, the original series has been pushed through your tree, do you think you can pull this
patch too?

Thanks,
Carlos
 
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


