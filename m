Return-Path: <linux-fsdevel+bounces-54676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C1B021E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DA41C804E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EAB2EF29D;
	Fri, 11 Jul 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Udp8Vect"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE75167DB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251634; cv=none; b=KrvRuUKirWp3DDJXX64JrE3XIBhGe2KVLTrGOFwRUCD3B/j94GvERpXu/1bQWCex9ZGJoqjnVHQNCYqZ4SEWXvdru4ncAGGfOpN62AltUHc21Bexsvx/VS/KeBKkx8nbtqvjzXCgsLGvvafk4mq7lqryTnL4JYtBWIH3KyNHmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251634; c=relaxed/simple;
	bh=Gj/LC7Y73pNk2yrhSS0d/CdEEoi8N1MsToT41z6JG60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HMtYN30n2Lvxoc/W7YJNErniKBWKfbP6yoP41emTWlnUIL4PqZUIki6sQFp0GBX66P22bYsg7wjdiR/CFQdAXtiD4AvHdtd977QBwfZ2mJRNk+3AleGJnYqps/XLRXVckelg40Kynk+Xy7/UGENjJ9af7ZQ/7k7jBmcRKm89V34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Udp8Vect; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453a1208973so72145e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752251630; x=1752856430; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGENYBU/D6swaXzru57Ha4Q1C2TEhr/fKQxS2FRJvrc=;
        b=Udp8VectODpCzbGR6/ZpPBoAOqzbl0yhn3FWu4N4t7ias1oYOjb3Xyh4+U3QS2UQ4b
         9Psb8QEJWgqOwNdzcsuGtD+4kh193WkTJ5nJ9DRAKK8PVA2d3M9MiZ9j/4i6REhICs7P
         0oqjWCe0i3yzb9pTj/0tE3M0zMXSRdi7oyQUqixU+/RljK495PH/1HPasOT7TEczn5yC
         8Z0k4R/jZGru+lrVGWZN6wxa9pwZHcRYJDYtSFv1Tz6lFavOyB79qIJGHP3paHL0NU2H
         +GRF2en9onn6hwtuFp9MAGNGlNIjrZRVYFG+wG5BTQvXu1EYDYa8LRtzb8hK2u/DaKhg
         tlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251630; x=1752856430;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGENYBU/D6swaXzru57Ha4Q1C2TEhr/fKQxS2FRJvrc=;
        b=WkPCObJON0uIgB9yA+cLvWbWCPGJE6TfwyPyx2iFG1NLsZUxwku5cmbIwxeJfueBDH
         cQpEwODyX8SeeEMDxMrfjYYyeTmYK/grZybKFNnhqNUgoq0zRRksdT8mQqtWtRCU3g27
         2HYmv6Gie2kbh4fCONUffCd90ko8LpPQo2wOiGEyj31trhsH/uaUkFoRYeE32f6qdbQk
         2QqzjLfNL8bfLblHgMbeqIxjxWAW28jOluM8fqgIVtvzff90HqYO4Kwg20UcG9ls3uKo
         pzAKLKPPKhudDCPfOXr+Qn/3zA5ADsOPcHdkEDFPGLcRDqP2ry+Xcz7VwYuYpjNE/Xih
         cP+g==
X-Gm-Message-State: AOJu0YxT46yIWDVu+nzgv15728KLP3+sk1hP2ZpVA9SFQ1OHLwYAw90W
	+S3NXmPEVlsyf0GwVSewTCJvx5nJuq4o39aeWZe29L29ToZa8nhVDbgxKy42ZWHYIw==
X-Gm-Gg: ASbGncu0xAc0wY8zzo8uhSCFZHBWkQw+Xbn6gN10gw8oJJtSFE4GuqlfVJ/ObGVLbj5
	NR6utUxH9G7417EmOgWB6p1a5mrb9NSV8BragbZMoHngnfR+Hgqgx7szZsQUoirE5j/rsIoN30E
	u4AG/HDjzhSyXFjaQ0AF+A2coV65n/uHxkiqB/Sn3Me7xLthbFCJgGEM8tgCXO1Ev3A3P1oob6l
	ibbukBBZKO0+gGbYNLL3yVC2cDypDdh/9KWHjZO+4Qx+iZw100KI/KpDNVFlyrpvkfXQuvu0mR6
	ydZ2NgyFzzsiG+MrtvvXKKeY25Z8mJ9bD357vQP+IplzkW7bzgb6rUOcqTBHyTOYld1Tue7iA7U
	k55Uam+hLjQ==
X-Google-Smtp-Source: AGHT+IFGb8En+0/LEnhrCsPlcQ7eoqZm8bWiCIIc6A88wBl+AkcTJuwgUTtb5+h7cGxeEVSy+ITdaA==
X-Received: by 2002:a05:600c:4854:b0:453:7d31:2f8c with SMTP id 5b1f17b1804b1-4551744f242mr1132995e9.3.1752251630094;
        Fri, 11 Jul 2025 09:33:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:1405:a0ff:fc1b:5b2])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454dd537cd9sm52103105e9.26.2025.07.11.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:33:49 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Jul 2025 18:33:36 +0200
Subject: [PATCH] eventpoll: Fix semi-unbounded recursion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-epoll-recursion-fix-v1-1-fb2457c33292@google.com>
X-B4-Tracking: v=1; b=H4sIAOA8cWgC/x2M2wpAQBRFf0Xn2am5hPIr8mDYOCV0JlLy74bHt
 Vt73RShgkh1dpPilCjbmsDmGfVzt05gGRKTM64wlbWMfVsWVvSHfi6PcvEYDLwvg+sQKD13RZr
 /atM+zwu8p67qZQAAAA==
X-Change-ID: 20250711-epoll-recursion-fix-fb0e336b2aeb
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752251626; l=5822;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Gj/LC7Y73pNk2yrhSS0d/CdEEoi8N1MsToT41z6JG60=;
 b=gPwfqluly2lPkZmTS83b0HCDec4L8Zbjlerf0nzDKtOGnWotL1uJjPIurVYfDrRDBDVdr/MPk
 SV8w59fSDRUCSjOjthW6yvGFSUSWTS5uGDKUKibeBpMTgHhjLbEjDYr
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Ensure that epoll instances can never form a graph deeper than
EP_MAX_NESTS+1 links.

Currently, ep_loop_check_proc() ensures that the graph is loop-free and
does some recursion depth checks, but those recursion depth checks don't
limit the depth of the resulting tree for two reasons:

 - They don't look upwards in the tree.
 - If there are multiple downwards paths of different lengths, only one of
   the paths is actually considered for the depth check since commit
   28d82dc1c4ed ("epoll: limit paths").

Essentially, the current recursion depth check in ep_loop_check_proc() just
serves to prevent it from recursing too deeply while checking for loops.

A more thorough check is done in reverse_path_check() after the new graph
edge has already been created; this checks, among other things, that no
paths going upwards from any non-epoll file with a length of more than 5
edges exist. However, this check does not apply to non-epoll files.

As a result, it is possible to recurse to a depth of at least roughly 500,
tested on v6.15. (I am unsure if deeper recursion is possible; and this may
have changed with commit 8c44dac8add7 ("eventpoll: Fix priority inversion
problem").)

To fix it:

1. In ep_loop_check_proc(), note the subtree depth of each visited node,
and use subtree depths for the total depth calculation even when a subtree
has already been visited.
2. Add ep_get_upwards_depth_proc() for similarly determining the maximum
depth of an upwards walk.
3. In ep_loop_check(), use these values to limit the total path length
between epoll nodes to EP_MAX_NESTS edges.

Fixes: 22bacca48a17 ("epoll: prevent creating circular epoll structures")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/eventpoll.c | 60 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d4dbffdedd08..44648cc09250 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -218,6 +218,7 @@ struct eventpoll {
 	/* used to optimize loop detection check */
 	u64 gen;
 	struct hlist_head refs;
+	u8 loop_check_depth;
 
 	/*
 	 * usage count, used together with epitem->dying to
@@ -2142,23 +2143,24 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 }
 
 /**
- * ep_loop_check_proc - verify that adding an epoll file inside another
- *                      epoll structure does not violate the constraints, in
- *                      terms of closed loops, or too deep chains (which can
- *                      result in excessive stack usage).
+ * ep_loop_check_proc - verify that adding an epoll file @ep inside another
+ *                      epoll file does not create closed loops, and
+ *                      determine the depth of the subtree starting at @ep
  *
  * @ep: the &struct eventpoll to be currently checked.
  * @depth: Current depth of the path being checked.
  *
- * Return: %zero if adding the epoll @file inside current epoll
- *          structure @ep does not violate the constraints, or %-1 otherwise.
+ * Return: depth of the subtree, or INT_MAX if we found a loop or went too deep.
  */
 static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 {
-	int error = 0;
+	int result = 0;
 	struct rb_node *rbp;
 	struct epitem *epi;
 
+	if (ep->gen == loop_check_gen)
+		return ep->loop_check_depth;
+
 	mutex_lock_nested(&ep->mtx, depth + 1);
 	ep->gen = loop_check_gen;
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
@@ -2166,13 +2168,11 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 		if (unlikely(is_file_epoll(epi->ffd.file))) {
 			struct eventpoll *ep_tovisit;
 			ep_tovisit = epi->ffd.file->private_data;
-			if (ep_tovisit->gen == loop_check_gen)
-				continue;
 			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS)
-				error = -1;
+				result = INT_MAX;
 			else
-				error = ep_loop_check_proc(ep_tovisit, depth + 1);
-			if (error != 0)
+				result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1);
+			if (result > EP_MAX_NESTS)
 				break;
 		} else {
 			/*
@@ -2186,9 +2186,27 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 			list_file(epi->ffd.file);
 		}
 	}
+	ep->loop_check_depth = result;
 	mutex_unlock(&ep->mtx);
 
-	return error;
+	return result;
+}
+
+/**
+ * ep_get_upwards_depth_proc - determine depth of @ep when traversed upwards
+ */
+static int ep_get_upwards_depth_proc(struct eventpoll *ep, int depth)
+{
+	int result = 0;
+	struct epitem *epi;
+
+	if (ep->gen == loop_check_gen)
+		return ep->loop_check_depth;
+	hlist_for_each_entry_rcu(epi, &ep->refs, fllink)
+		result = max(result, ep_get_upwards_depth_proc(epi->ep, depth + 1) + 1);
+	ep->gen = loop_check_gen;
+	ep->loop_check_depth = result;
+	return result;
 }
 
 /**
@@ -2204,8 +2222,22 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
  */
 static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
 {
+	int depth, upwards_depth;
+
 	inserting_into = ep;
-	return ep_loop_check_proc(to, 0);
+	/*
+	 * Check how deep down we can get from @to, and whether it is possible
+	 * to loop up to @ep.
+	 */
+	depth = ep_loop_check_proc(to, 0);
+	if (depth > EP_MAX_NESTS)
+		return -1;
+	/* Check how far up we can go from @ep. */
+	rcu_read_lock();
+	upwards_depth = ep_get_upwards_depth_proc(ep, 0);
+	rcu_read_unlock();
+
+	return (depth+1+upwards_depth > EP_MAX_NESTS) ? -1 : 0;
 }
 
 static void clear_tfile_check_list(void)

---
base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
change-id: 20250711-epoll-recursion-fix-fb0e336b2aeb

-- 
Jann Horn <jannh@google.com>


