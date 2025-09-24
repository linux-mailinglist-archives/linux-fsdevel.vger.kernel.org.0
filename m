Return-Path: <linux-fsdevel+bounces-62640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6ABB9B4C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA60A17CE50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64431B809;
	Wed, 24 Sep 2025 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTypNybc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A8329F28;
	Wed, 24 Sep 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737251; cv=none; b=dkq3E5VWfoGejRODhsNyNwdmMhOZoYf+Z+UcMy9mZ2vjpV/iv1jp/ZFlEEAIgrZ6YH31zIvo03INhM70qYikQADt7K0fXlc9hbUDKf7LsOs5/nMojsncWNQmGr16E+ptuIeUxGszFcY+MuJs+E0K150k0JUwhI9ACU8frQEP/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737251; c=relaxed/simple;
	bh=fuOpkGdWy6bkqx9ds6yLB2wvDIxmKfn5FeXIv7UpWV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBCizHD95IYXZsELjTAn4KaPf2c1cMLpv9h6ULqUF6hLDcwr7kW+OqXXETSfqTaf+DS8nTok3nNtfmr6KP9EGhSzZQ71fSGDatrMFuc4Q3JZDxz+XAxCGHR3Mp9qCuSHtZca71nSOhKs9yzQeQp4iQUtEsHfEaMALKslDw/c9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTypNybc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6DCC4CEF0;
	Wed, 24 Sep 2025 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737251;
	bh=fuOpkGdWy6bkqx9ds6yLB2wvDIxmKfn5FeXIv7UpWV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WTypNybc5mWweQLiEoMpMZOu53hkvHYrLfElED9tvDtdd0xTusXh/tbdWdP8yMeK1
	 gLvHe/TCK6j2ED01hSq1ukwo/zMDtdfGM21bPvj3SBs7WPlYhnjAPyB0UL/vdGH+jU
	 tbQbRSgVsv80W4KNQGDtH4sh7qe0uOWlCh6+xZxeg5Ly9IG87b/AN4qo6iPjBGqQGR
	 gqGPBXTx7u8qPEspN5zA0AqkxUXmVB5dfm9gU9m5R4xxjd8KWt1yuvrGyBeXDq8sBE
	 w4YRN2q3Y41pNKl8PitWfiid+eBYUPDUoVYlNhfKQNj0uQ1g8L+Kf5gqH98R0IdvFi
	 +Klwj9A0VoswQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:08 -0400
Subject: [PATCH v3 22/38] vfs: add fsnotify_modify_mark_mask()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-22-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fuOpkGdWy6bkqx9ds6yLB2wvDIxmKfn5FeXIv7UpWV8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMPam28oyZ5UAyhgM57KvNT0/0ja/FjGutXJ
 pn8TtbBfx2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDwAKCRAADmhBGVaC
 FX1BD/4/76O+gFuzMzgZb3clpS4WyTNRhq5U56aJl4Z21H7Ujkgz/ayyCkVJBkZCPlxmep9ERLn
 zOqsmd9034xmzAP+GdtZahlZy7FRwF6vaH3U5MBdUKl8G4rO5FDTeDkpPT5E0o0/2xdrQV2h4xA
 x2iA0Ii3vR2Cni80lVNZdIsZa1I87dMQFM5dVqFUYzSV1OxvwctuGpkJv1xizy0WtaB/rx6C3I5
 tCfrETJezDldTRR8cH0DkCTexEmdJGwS4VW6030Yb3EjSRYHOMwOxFXbSa0YmMDKSpM9puqEMgZ
 TZS7apkZLKRAoQEdD84rtc4V1wKSDgViMpFsiP0/STstYDZNkME3J52HxA650ICtIdxqLe0M5zT
 oUVvKu78+PpFFK2Isi4BQLEzTqW5cksmTFTkTGBMQeTq99PMvFhvl3ULBjUv/jHaH44Yn3j+IDU
 27jQR8Rx0SbI3jWEB2jV/d2yPnceDwXPi9JFpzAvzBdJEMe2/BRYqE1D7aImcOvIR/avRWB1GUj
 bxcyYdTV224l0yWD/Sd9WkmVSco9ObhHkC9YNQ69Z0u1fC0hfgPVFK6tsuMenlFGKRBW/mM3BY4
 A6kARFYvrCYj52quZ4UKvlYGUdiAoYKVd23ch8bQjqE7LilqpMvCNTJrqffTQVY76dpxMerTM9k
 6o0ZaF8n/UVlFYQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd needs to be able to modify the mask on an existing mark when new
directory delegations are set or unset. Add an exported function that
allows the caller to set and clear bits in the mark->mask, and does
the recalculation if something changed.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/notify/mark.c                 | 29 +++++++++++++++++++++++++++++
 include/linux/fsnotify_backend.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d761dd05c1b361c251818dee89b9cf..5ed42b24df7f6aa3812a7069b4c37f0c6b3414fa 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -309,6 +309,35 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
+/**
+ * fsnotify_modify_mark_mask - set and/or clear flags in a mark's mask
+ * @mark: mark to be modified
+ * @set: bits to be set in mask
+ * @clear: bits to be cleared in mask
+ *
+ * Modify a fsnotify_mark mask as directed, and update its associated conn.
+ * The caller is expected to hold a reference to the mark.
+ */
+void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
+{
+	bool recalc = false;
+	u32 mask;
+
+	WARN_ON_ONCE(clear & set);
+
+	spin_lock(&mark->lock);
+	mask = mark->mask;
+	mark->mask |= set;
+	mark->mask &= ~clear;
+	if (mark->mask != mask)
+		recalc = true;
+	spin_unlock(&mark->lock);
+
+	if (recalc)
+		fsnotify_recalc_mask(mark->connector);
+}
+EXPORT_SYMBOL_GPL(fsnotify_modify_mark_mask);
+
 /* Free all connectors queued for freeing once SRCU period ends */
 static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d4034ddaf3926bf98d8801997e50ba7ddf776292..8d50e6aad3c62c67a9bf73a8d9aab78565668c5f 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -912,6 +912,7 @@ extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
 extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
 extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
+extern void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear);
 
 static inline void fsnotify_init_event(struct fsnotify_event *event)
 {

-- 
2.51.0


