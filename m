Return-Path: <linux-fsdevel+bounces-60438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B11B46A9A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03048A00CEA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644492D23A8;
	Sat,  6 Sep 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TvN3Covd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244AC2BE641
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149904; cv=none; b=lXjVO5uB7Ib71T1fbXxzfJKQF9mFTwT/vmdyP8yJOSFbjdIVNV2aFVY/XR37x/WK6DHwQ8DXHIZZ2q+E9GxcdlYxU7DNCWD1n0TiKDYkjkQil3mF9ptzYXsJr5AtexbI9t4hEZf1w5d2K0U9KYv+LaK3TIus/l7nPtFrW8y0jLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149904; c=relaxed/simple;
	bh=0EKHhR8JQYv7bStmwWKFrYcdr+YYpeENSPBlUlBfG+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY4I8bC5bvICE0TPwQ5gZaG95vqZGpdTJjlRZsMv4qFVptNxC29m3DVnea5hN5Lqy/qi8yB0Egc8PJS2BBRCOd1HJQ6iHbhilpir2Ikwqxis2voXxNYZa4s3HkzZIGfzHmDdWz5Pg3Ap1zmWJEWo0BDwnVFq/bJOEU6QKxkWq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TvN3Covd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mI6jr23itavF4ZtDQyVF9gPdVnZvamru8WJbVeFdKjg=; b=TvN3Covd1XqYGS/iY26X60yWx0
	qtZ/EhZlpkRPUi7juGe4OjVeVQ1xqqL/A3eXapQXBMjZcsBo9NbHcmocbo1soSnu8lJLi/gTfb2qZ
	Rp2sww2Hy8wILxKT3AXSyIlPyVYQAOwusGnT8jKx0RM8HJNO77EG6NxoNRXAx3ov7z9rqDmucZ16q
	0jlznSEP/w4WebSJXCB4wnYKg/qRq9S1mpluCZyAf8vaHtKSw7amVnGDwNc+L+eAha/2yTdZwKGBf
	Vyo+DW9fUy0oUwL7zECg1x3hdh7SmeF+qZcr/K7CFeacUG0SCeWQ0WmFo425wDDNwkUf61ATCCls7
	808z9heg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxR-00000000OvE-0wTc;
	Sat, 06 Sep 2025 09:11:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 20/21] apparmor/af_unix: constify struct path * arguments
Date: Sat,  6 Sep 2025 10:11:36 +0100
Message-ID: <20250906091137.95554-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

unix_sk(sock)->path should never be modified, least of all by LSM...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/apparmor/af_unix.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index 9129766d1e9c..ac0f4be791ec 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -31,7 +31,7 @@ static inline struct sock *aa_unix_sk(struct unix_sock *u)
 }
 
 static int unix_fs_perm(const char *op, u32 mask, const struct cred *subj_cred,
-			struct aa_label *label, struct path *path)
+			struct aa_label *label, const struct path *path)
 {
 	AA_BUG(!label);
 	AA_BUG(!path);
@@ -224,7 +224,7 @@ static int profile_create_perm(struct aa_profile *profile, int family,
 
 static int profile_sk_perm(struct aa_profile *profile,
 			   struct apparmor_audit_data *ad,
-			   u32 request, struct sock *sk, struct path *path)
+			   u32 request, struct sock *sk, const struct path *path)
 {
 	struct aa_ruleset *rules = profile->label.rules[0];
 	struct aa_perms *p = NULL;
@@ -386,9 +386,9 @@ static int profile_opt_perm(struct aa_profile *profile, u32 request,
 
 /* null peer_label is allowed, in which case the peer_sk label is used */
 static int profile_peer_perm(struct aa_profile *profile, u32 request,
-			     struct sock *sk, struct path *path,
+			     struct sock *sk, const struct path *path,
 			     struct sockaddr_un *peer_addr,
-			     int peer_addrlen, struct path *peer_path,
+			     int peer_addrlen, const struct path *peer_path,
 			     struct aa_label *peer_label,
 			     struct apparmor_audit_data *ad)
 {
@@ -445,7 +445,7 @@ int aa_unix_create_perm(struct aa_label *label, int family, int type,
 static int aa_unix_label_sk_perm(const struct cred *subj_cred,
 				 struct aa_label *label,
 				 const char *op, u32 request, struct sock *sk,
-				 struct path *path)
+				 const struct path *path)
 {
 	if (!unconfined(label)) {
 		struct aa_profile *profile;
@@ -599,9 +599,9 @@ int aa_unix_opt_perm(const char *op, u32 request, struct socket *sock,
 
 static int unix_peer_perm(const struct cred *subj_cred,
 			  struct aa_label *label, const char *op, u32 request,
-			  struct sock *sk, struct path *path,
+			  struct sock *sk, const struct path *path,
 			  struct sockaddr_un *peer_addr, int peer_addrlen,
-			  struct path *peer_path, struct aa_label *peer_label)
+			  const struct path *peer_path, struct aa_label *peer_label)
 {
 	struct aa_profile *profile;
 	DEFINE_AUDIT_SK(ad, op, subj_cred, sk);
-- 
2.47.2


