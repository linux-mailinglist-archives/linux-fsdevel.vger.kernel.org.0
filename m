Return-Path: <linux-fsdevel+bounces-9650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5338440BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A04EB2ACFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D977F47D;
	Wed, 31 Jan 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm86+0DM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3617F46B
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708224; cv=none; b=URMUP7dB43ilIKOOwK7loraiZt/V2sykvpwgEY6ekNTvpE4yE5KOn1hB6bc5o86QYFr2nLn+nXFIfQMloVCSb/kcOmlRPecqMGHHsKNIhM2F5VGJaRDOBvMW0VMimKPxXpcYwX7udMFWa0PoRUStyyD3tnuixLNTdY/VqqBJoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708224; c=relaxed/simple;
	bh=TYFkPIDUerVZAP7S+7bjohUuc8XQGRiTwBxf1RSlFNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRubiUSeChV6sQyAgItVvJs9Naw0QCcuJ8/tlnuKn02mCZDdcfM3rhtbx1NnUB9GzVaZVOHeSHtEZaxPsz9iqvDsyNcO9CVG4+6dXPlYoKbTynR5+MqAQX3sNurTDfVTSn1xxjAIwLNLr/uaQvxcN17nhbKgdK8gP9lewLnw9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm86+0DM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C2DC433B1;
	Wed, 31 Jan 2024 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708224;
	bh=TYFkPIDUerVZAP7S+7bjohUuc8XQGRiTwBxf1RSlFNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jm86+0DMidX5DNROEbe5Yeht+/hnhhuhI4gZP/y6J5FgNyQKntZ38vmHSKol4HuEl
	 80pC1JmzJjeh9/AEbzWhwvzuHrfENRa3iKm8zaqXYvt76d/D/rV3oXgA0FzR5Cdb26
	 aPwRmdLJ79hTyDjkrdHuT9DClfjlWrpXp8dKV+uxbFaX4kqD+ICBNPq+Cl80LV3d87
	 8Lr6Hq4vgFcqmzMqAJP8fYexiKxmw96j4KoUwp2U2OBU4NNMe2CwiSMfw8duIudOHq
	 bMAXBXUoj8wI0u8zgoXKXZcBVDXnKoi/wRWZ2JCK/eDhBWOX9mGdfrzmD6OB3eSEKG
	 PY/TTvLCbM+hQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 31 Jan 2024 14:36:39 +0100
Subject: [PATCH DRAFT 2/4] : trace: stash kernfs_node instead of dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-tracefs-kernfs-v1-2-f20e2e9a8d61@kernel.org>
References: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
In-Reply-To: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
 Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TYFkPIDUerVZAP7S+7bjohUuc8XQGRiTwBxf1RSlFNA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTu8vkRlXNeevvh+9u6triqfjTTnyHA/dPekOe3gcTyZ
 Rce3Jwa31HCwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR0eMM3+MMvm5L+GXO7Vq0
 c3bxzIW8V5zaJ56I8L6/Qa9CKGK9HSPDUilp9x1bFu1b5DPz/PKN9/YGVXavn8CcHdCw4sOW+1n
 7uAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/trace/trace_events_synth.c | 4 ++--
 kernel/trace/trace_events_user.c  | 2 +-
 kernel/trace/trace_hwlat.c        | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e7af286af4f1..4fe196effada 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -2312,7 +2312,7 @@ core_initcall(trace_events_synth_init_early);
 
 static __init int trace_events_synth_init(void)
 {
-	struct dentry *entry = NULL;
+	struct kernfs_node *entry = NULL;
 	int err = 0;
 	err = tracing_init_dentry();
 	if (err)
@@ -2320,7 +2320,7 @@ static __init int trace_events_synth_init(void)
 
 	entry = tracefs_create_file("synthetic_events", TRACE_MODE_WRITE,
 				    NULL, NULL, &synth_events_fops);
-	if (!entry) {
+	if (IS_ERR(entry)) {
 		err = -ENODEV;
 		goto err;
 	}
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e76f5e1efdf2..d461b2c5bd41 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2698,7 +2698,7 @@ static const struct file_operations user_status_fops = {
  */
 static int create_user_tracefs(void)
 {
-	struct dentry *edata, *emmap;
+	struct kernfs_node *edata, *emmap;
 
 	edata = tracefs_create_file("user_events_data", TRACE_MODE_WRITE,
 				    NULL, NULL, &user_data_fops);
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..11b9f98b8d75 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -54,9 +54,9 @@ static struct trace_array	*hwlat_trace;
 #define DEFAULT_SAMPLE_WIDTH	500000			/* 0.5s */
 #define DEFAULT_LAT_THRESHOLD	10			/* 10us */
 
-static struct dentry *hwlat_sample_width;	/* sample width us */
-static struct dentry *hwlat_sample_window;	/* sample window us */
-static struct dentry *hwlat_thread_mode;	/* hwlat thread mode */
+static struct kernfs_node *hwlat_sample_width;	/* sample width us */
+static struct kernfs_node *hwlat_sample_window;	/* sample window us */
+static struct kernfs_node *hwlat_thread_mode;	/* hwlat thread mode */
 
 enum {
 	MODE_NONE = 0,
@@ -769,7 +769,7 @@ static const struct file_operations thread_mode_fops = {
 static int init_tracefs(void)
 {
 	int ret;
-	struct dentry *top_dir;
+	struct kernfs_node *top_dir;
 
 	ret = tracing_init_dentry();
 	if (ret)

-- 
2.43.0


