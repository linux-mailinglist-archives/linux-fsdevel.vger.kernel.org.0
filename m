Return-Path: <linux-fsdevel+bounces-78490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGFDKilSoGnriAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:01:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1672E1A720E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7C4C30835CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCE339A7E1;
	Thu, 26 Feb 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBiS96KU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AB396D2A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113824; cv=none; b=T7WeezAHGqiAy+MR3tshpMvVy6ndDzOFeVAlbH3p4SfPQ4OIgRAmcPf3D+NzdOI9oUHZKE5K6J7TRVpd9Rf2T5BM4nCtg45t+xCiI3jFVxZRSSCwXjyRphVpPTr4hjMSicHnq6Al1CEJAUYp1qAxVltW+MBmrH61540njZ9SRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113824; c=relaxed/simple;
	bh=l0eAKQAzo+pgoOeNtganbXgUAUlp8x1zQmSRY328jTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iY0rt45wFUQMxlwwO7I6GgMWErFysFPM7fKFFDscq7GdJ/Ntm+wecTSsRkZ48GHJ50C3GJOt28iFJfXXvjqjZLMv0EPZ5oKp9/uMBxJwNijdo86Hpj549Tb2WSjaOUJLDEChAaBnZPfecKYG/a8TNApgeiIONjuNDdFxUDqfXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBiS96KU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC67C19423;
	Thu, 26 Feb 2026 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113823;
	bh=l0eAKQAzo+pgoOeNtganbXgUAUlp8x1zQmSRY328jTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XBiS96KUNeqpvGqhPXw6w9vKxJH3ELpT+obJNZyclmwi87JXLFnyXSXXS41J6BdNw
	 xkmz5xkM+4P6LtjPk7gHoYyd+KuS2jlAvgSHNf4e9FWEOLM5dSd+07tv5thKvh2nki
	 YhGuoS6uxEcU5XX5NpaxIBHFF65ts38ePu9KPL7f289tuHz/jZJugtzATzAkVYFMRY
	 ecfjnWnWZ8XzTV8252g6gyl06JHlvU8qyu41x96P1B5g9oQBBBKe2PTFIghmdfMMMy
	 c0avV+vps7YJKGYW+nzwPs3BX+9+BKW8NKXGL2q6BD44Fxwiy+Mjcxylac0EMA0X8N
	 HW/iYlwUHFs1w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:50:12 +0100
Subject: [PATCH 4/4] selftests: fix mntns iteration selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-visibility-fixes-v1-4-d2c2853313bd@kernel.org>
References: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
In-Reply-To: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l0eAKQAzo+pgoOeNtganbXgUAUlp8x1zQmSRY328jTE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8J/aNHlLwxnjZZ/8Tlf7eO4KiD3O8khmCdeKJ7UHB
 Z7I/F17r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiLf8Y/qdFB/ZtO39psfSr
 88vOt2dpPQ6qPcTab6NscnHFUvEfjFqMDH3+TTdmeHtrc2QLfMne1Clkwvcxxe3q8tyJ0SeOnux
 eww4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-78490-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_EMAILBL_FAIL(0.00)[stable.kernel.org:query timed out];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1672E1A720E
X-Rspamd-Action: no action

Now that we changed permission checking make sure that we reflect that
in the selftests.

Fixes: 9d87b1067382 ("selftests: add tests for mntns iteration")
Cc: stable@kernel.org # v6.14+
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/nsfs/iterate_mntns.c     | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
index 61e55dfbf121..e19ff8168baf 100644
--- a/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
+++ b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
@@ -37,17 +37,20 @@ FIXTURE(iterate_mount_namespaces) {
 	__u64 mnt_ns_id[MNT_NS_COUNT];
 };
 
+static inline bool mntns_in_list(__u64 *mnt_ns_id, struct mnt_ns_info *info)
+{
+	for (int i = 0; i < MNT_NS_COUNT; i++) {
+		if (mnt_ns_id[i] == info->mnt_ns_id)
+			return true;
+	}
+	return false;
+}
+
 FIXTURE_SETUP(iterate_mount_namespaces)
 {
 	for (int i = 0; i < MNT_NS_COUNT; i++)
 		self->fd_mnt_ns[i] = -EBADF;
 
-	/*
-	 * Creating a new user namespace let's us guarantee that we only see
-	 * mount namespaces that we did actually create.
-	 */
-	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
-
 	for (int i = 0; i < MNT_NS_COUNT; i++) {
 		struct mnt_ns_info info = {};
 
@@ -75,13 +78,15 @@ TEST_F(iterate_mount_namespaces, iterate_all_forward)
 	fd_mnt_ns_cur = fcntl(self->fd_mnt_ns[0], F_DUPFD_CLOEXEC);
 	ASSERT_GE(fd_mnt_ns_cur, 0);
 
-	for (;; count++) {
+	for (;;) {
 		struct mnt_ns_info info = {};
 		int fd_mnt_ns_next;
 
 		fd_mnt_ns_next = ioctl(fd_mnt_ns_cur, NS_MNT_GET_NEXT, &info);
 		if (fd_mnt_ns_next < 0 && errno == ENOENT)
 			break;
+		if (mntns_in_list(self->mnt_ns_id, &info))
+			count++;
 		ASSERT_GE(fd_mnt_ns_next, 0);
 		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
 		fd_mnt_ns_cur = fd_mnt_ns_next;
@@ -96,13 +101,15 @@ TEST_F(iterate_mount_namespaces, iterate_all_backwards)
 	fd_mnt_ns_cur = fcntl(self->fd_mnt_ns[MNT_NS_LAST_INDEX], F_DUPFD_CLOEXEC);
 	ASSERT_GE(fd_mnt_ns_cur, 0);
 
-	for (;; count++) {
+	for (;;) {
 		struct mnt_ns_info info = {};
 		int fd_mnt_ns_prev;
 
 		fd_mnt_ns_prev = ioctl(fd_mnt_ns_cur, NS_MNT_GET_PREV, &info);
 		if (fd_mnt_ns_prev < 0 && errno == ENOENT)
 			break;
+		if (mntns_in_list(self->mnt_ns_id, &info))
+			count++;
 		ASSERT_GE(fd_mnt_ns_prev, 0);
 		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
 		fd_mnt_ns_cur = fd_mnt_ns_prev;
@@ -125,7 +132,6 @@ TEST_F(iterate_mount_namespaces, iterate_forward)
 		ASSERT_GE(fd_mnt_ns_next, 0);
 		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
 		fd_mnt_ns_cur = fd_mnt_ns_next;
-		ASSERT_EQ(info.mnt_ns_id, self->mnt_ns_id[i]);
 	}
 }
 
@@ -144,7 +150,6 @@ TEST_F(iterate_mount_namespaces, iterate_backward)
 		ASSERT_GE(fd_mnt_ns_prev, 0);
 		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
 		fd_mnt_ns_cur = fd_mnt_ns_prev;
-		ASSERT_EQ(info.mnt_ns_id, self->mnt_ns_id[i]);
 	}
 }
 

-- 
2.47.3


