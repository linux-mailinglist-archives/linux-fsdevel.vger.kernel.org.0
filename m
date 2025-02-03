Return-Path: <linux-fsdevel+bounces-40682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ED1A2669F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6983A55EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC34211283;
	Mon,  3 Feb 2025 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmkpvnXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155641FFC7F
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621936; cv=none; b=XsnYN42wbYdZuKE734wqjOqgJ+Te5TBG0T32+j2vvc2qETDsUgRU29RaH9v5I+mGRE4iJ9IisKoJKbu6EcT+u/4SjHc/aG3xZzE7/8rjqytXsdq1FrwCZwMvTPb2RYSEOpFGysW0vfzfZsQGenuOoHbzL0u/PYBZoLnB8wKDuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621936; c=relaxed/simple;
	bh=0/bbVrNVeVVmEpyRvFaB9DE+nYBCaOhos+L41mmADAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Be2VPmsNVIgeQrY4DgvYXOd4MSZCuYozEgIghnaUH7Fet7RoG/bWURNoS1yoK3hTbmMHKJ3JVIJJzXfgsynJXMWHTume94tkxXEKqR4PQOvjrHaBfNzGpk+n1/KBoFWOQhmRXZ1PT5XC5i9tiw6/qdMUf08rkJNN+Ew7uo+C+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmkpvnXZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa67ac42819so743600966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 14:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738621933; x=1739226733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFxgfqw9HRB+5xQNdBfsHKii2SrLpZfUufppKw/irMo=;
        b=AmkpvnXZVzgqHOvjb3uSx7X5PZ8fzG64hkclt9Sq2wTTq16x3su/Q1Hmz8hvtLLvXu
         Dm+92MRpR1oj1F8y8TvOaA1IRovDU/EmAyEmU0QEFZdDP+BfP9LE8kSfNnEcLnrBtvN2
         kVQvCwhBSGs+NPuxv4L8rEV8z5YzRaxu96rwA8ommRDWy/soalMj6+/HU6hkvmajDVM9
         oYDaopD2kv5cjTC6Ph8uZitHbWbEkfij4J2KdeG7YSmr+zFDqy5w/dizdWccHqOrZnwE
         h+rTaagRlASmZ/wrzIyGQvGYOBNgArxL4kbweFsoSKk0TqMuY7X4A2NJzO0VcLcTqqnA
         RHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738621933; x=1739226733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFxgfqw9HRB+5xQNdBfsHKii2SrLpZfUufppKw/irMo=;
        b=VrER40wzzjfqtySS+MWjyYAE18XBk4B/Dlb68SNsQ8Y17jPmDq4Fn+OaTQBi6ursn7
         /+WpEN9AEvqMxvyHn/qBcFM3IcAF4uvMw8ASNtUTywwVJrhHGBJTHUKw5BAtQ86+LuPP
         1AbwRyKtjqh8fjLDSi/mNF9byFCWLaNxgmU3bqMqarcsNpwxIzcQYB7oifUeh34uR2Ax
         5aqelBRHJekaxLvs/DZI2OATRmWiknCJ3VTUVp9IikiIgIuFCMoGfY6OBf1uB2s/NP4Y
         1dPPMlDP/r/+ZB8FIaYHYUvIiglSbCDF8GluLDNwKJ772vtTLd0jQEFe6IZXTnRYnGAM
         o6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmOAtFXUVBO4p5hxHIC9dNcZxivjaLqyjsbUd84N0RMo28uUxQTxCseIb6h59RjffZJL7AluWfjZ5Z4Vvj@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9YRlMSvV5MGWJYcF4VZXijZ4u3l4Z6d1N0Ytcvp8pbiYoVa+
	jwkFM5qKnHYke0jHMafPLUS+ZCir3MsjwwuVw7DG8+/MV7TKUbxKaY+sfhoR
X-Gm-Gg: ASbGnct9x2jvCemtAC283JtYpaIMbiyp59i53gW/cPG5OjELsEPrC3P2lRMY1pYBSPZ
	rsTa7axzt1uij8ZI6llzV8uXzAQzKWx0uJYuvjstjwL+bon1YYZjEFGq1txCf2N1wY9tf3jjUEe
	77aHeNrAcIy22bogdGl9CoJenFC55gCmiDaJj2rx9GZR4DMZOS7ZuAn3sZG9v8carVO1YzZBrCk
	dqaz7qwluxjK6UkQfIMVLWqXX7Td2y/ZxAjOScLlAxjUqlV60CAHoP6gTrQBBpfJlnOfi6ll9w9
	gTaz1E6Er2wE56lPEPf2JdJQHswIkR9QqaFJPQTGzM+NY5PG0QYc+UR4uxCbLoK55/vPx7YIu57
	bhnsUjiNu1Mgj
X-Google-Smtp-Source: AGHT+IHzlKwLVWw4IVYzO30LEZ1HqeolMs1QSBzegYLtizg0i5AgUH0VH7IJh900KL/NDVSdErpNbA==
X-Received: by 2002:a17:906:a3d3:b0:ab6:d9f7:fd71 with SMTP id a640c23a62f3a-ab6d9f83783mr2234630966b.51.1738621932645;
        Mon, 03 Feb 2025 14:32:12 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724a9c5fsm8339651a12.54.2025.02.03.14.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:32:12 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Alex Williamson <alex.williamson@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fsnotify: disable notification by default for all pseudo files
Date: Mon,  3 Feb 2025 23:32:04 +0100
Message-Id: <20250203223205.861346-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203223205.861346-1-amir73il@gmail.com>
References: <20250203223205.861346-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most pseudo files are not applicable for fsnotify events at all,
let alone to the new pre-content events.

Disable notifications to all files allocated with alloc_file_pseudo()
and enable legacy inotify events for the specific cases of pipe and
socket, which have known users of inotify events.

Pre-content events are also kept disabled for sockets and pipes.

Fixes: 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: https://lore.kernel.org/linux-fsdevel/20250131121703.1e4d00a7.alex.williamson@redhat.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com/
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c | 11 +++++++++++
 fs/open.c       |  4 ++--
 fs/pipe.c       |  6 ++++++
 net/socket.c    |  5 +++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index f0291a66f9db4..35b93da6c5cb1 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -375,7 +375,13 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 	if (IS_ERR(file)) {
 		ihold(inode);
 		path_put(&path);
+		return file;
 	}
+	/*
+	 * Disable all fsnotify events for pseudo files by default.
+	 * They may be enabled by caller with file_set_fsnotify_mode().
+	 */
+	file_set_fsnotify_mode(file, FMODE_NONOTIFY);
 	return file;
 }
 EXPORT_SYMBOL(alloc_file_pseudo);
@@ -400,6 +406,11 @@ struct file *alloc_file_pseudo_noaccount(struct inode *inode,
 		return file;
 	}
 	file_init_path(file, &path, fops);
+	/*
+	 * Disable all fsnotify events for pseudo files by default.
+	 * They may be enabled by caller with file_set_fsnotify_mode().
+	 */
+	file_set_fsnotify_mode(file, FMODE_NONOTIFY);
 	return file;
 }
 EXPORT_SYMBOL_GPL(alloc_file_pseudo_noaccount);
diff --git a/fs/open.c b/fs/open.c
index 3fcbfff8aede8..1be20de9f283a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -936,8 +936,8 @@ static int do_dentry_open(struct file *f,
 
 	/*
 	 * Set FMODE_NONOTIFY_* bits according to existing permission watches.
-	 * If FMODE_NONOTIFY was already set for an fanotify fd, this doesn't
-	 * change anything.
+	 * If FMODE_NONOTIFY mode was already set for an fanotify fd or for a
+	 * pseudo file, this call will not change the mode.
 	 */
 	file_set_fsnotify_mode_from_watchers(f);
 	error = fsnotify_open_perm(f);
diff --git a/fs/pipe.c b/fs/pipe.c
index 94b59045ab44b..ce1af7592780d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -960,6 +960,12 @@ int create_pipe_files(struct file **res, int flags)
 	res[1] = f;
 	stream_open(inode, res[0]);
 	stream_open(inode, res[1]);
+	/*
+	 * Disable permission and pre-content events, but enable legacy
+	 * inotify events for legacy users.
+	 */
+	file_set_fsnotify_mode(res[0], FMODE_NONOTIFY_PERM);
+	file_set_fsnotify_mode(res[1], FMODE_NONOTIFY_PERM);
 	return 0;
 }
 
diff --git a/net/socket.c b/net/socket.c
index 262a28b59c7f0..28bae5a942341 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -479,6 +479,11 @@ struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname)
 	sock->file = file;
 	file->private_data = sock;
 	stream_open(SOCK_INODE(sock), file);
+	/*
+	 * Disable permission and pre-content events, but enable legacy
+	 * inotify events for legacy users.
+	 */
+	file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
 	return file;
 }
 EXPORT_SYMBOL(sock_alloc_file);
-- 
2.34.1


