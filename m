Return-Path: <linux-fsdevel+bounces-75885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLt6NmWae2nOGAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:35:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54034B2F8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AB30301704E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCC353EEE;
	Thu, 29 Jan 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="khlKxKWl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752C352C52
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708120; cv=none; b=FRLu0pVUoWN9f7bHuhWTjgueZPNbSRh6XrzHGKx/Px3LH6Rv8f+aoTyRzgnJLh5fZIf+EeDAe9xPW4UBsYI4qOHacwGSJBIuhwKKockubtOPrI5hY8vtIwW8yM/rD4yh54PAsPDB//aYwbP1kihl6+GF0Hf6H9mnMBnG4sWh6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708120; c=relaxed/simple;
	bh=g4FdhAWorzinYXns0c9DK6X5UO/oeqcHe4vyhOu4vIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwi7fgQW+R9bJ7TZVaz07XqCu004hmt0oAXqD6YvWTxGeI6scMNjAKNOH7Hego9CrZ6OOlNPIy8e2ODcuyysRjruauA0Igf/TEew7IqMOpUkNo4WzBkLUttJi3sk+27jOgJhlX4z7FlzOMThTW7YedkPTa65I6wa/0Ojtm+aC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=khlKxKWl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so1068843f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1769708117; x=1770312917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Phc9qAk4f5Y7siOZluWOGyZS8E5U/JFAMjIiUncQyU=;
        b=khlKxKWlqYz+ph0xUUrM/0rz7pYhV5qO6qEEOIsVvM9G/Inj6l0grc5qOyYiaNR0IQ
         reuzofvoV2+UkVEHwMMKxk+OVPLSoS+ytPSfFKy6j+AvjuIOWwyNlDuj+qAu7yuCrFkR
         yMydeGuUpe4lyhKGqceMuCrXmO7ftDoAJoXZhvtkbhPkmM8dhRNgzBmT5VlC9oDmfChl
         ZUeNyJrN0bGaUDIgeIkOvxcEX4kQWgeUzVhmx6uMzPPc2g/UyvifRWUlKFL/l0a4TI37
         QTXUtcBNYloKpk7Am3a0jeoAPZyIy6z5qwbymJFz2IYCpPDXd5Cutmi9DSGAelcmFJyW
         zQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708117; x=1770312917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Phc9qAk4f5Y7siOZluWOGyZS8E5U/JFAMjIiUncQyU=;
        b=jbi90xfUdj/fdQX6rtpoFSutt8B/H/gV3/TvhXc4LaL4TDHP23I6nASwGOJ4GbTx78
         bzzfbflmRKDi/rDQK4tT5dTzSVP4EPkeWyhKhBQVSUxBIF3A7LxovUpKkmiT5JZzAQzA
         SKDd3Qi0TSK/CNsaju/xsZMcAVFYTVaVBhOvQGQkMl8BCgqNN8SXAPJv8h0Lijsi9kmW
         0aRD6adSK4NUTjgjSqJuVND2qx7DEqkmyACRzVfoSnLtYLvI/mLRxzUPs0TXTyM5jbx9
         PLj7VQG2u2Qn4muDRk1psD5pGW1PdVstqK9mx4FLJ25M74nrKgvesNjRcfYeV0X2TQtw
         zCeQ==
X-Gm-Message-State: AOJu0YxtFiYXxk9MWkPaHPVNbM3e4xBb6ywL5Q2H/d4enq+kWbIQDz9N
	mlnYA/Lgk4lnylao+Htqg1l8lcjDXS4PXI0sUGCOILy7oUqsS8iLU1GmJwJBp64p9vSvxVfK2EL
	Nd1l/034=
X-Gm-Gg: AZuq6aKJK8+x/o59xu+GTWz5FUA1B3WNtaUM2H/Z9FuZow7iQRnxKYKehlS1L5o4qhj
	lkTL6NPL5GvnHysktFTg6SKwSzdt4XsUPkUEHvbOLXPP0Ieep4qM/Vjsu1kFkhzBWSUkIuf1b/J
	3EJIjW6+Bu/uEhRGk86FNjIBVf+9D0dMYLRGYGBttzzikBLdgEPfjho27hTfzSu+Qj05lV115iZ
	wYLdFWG9p1o+grJl8WOIPdOZSOv6jTmI9By/MvAmZ5qxcO8PDYpjh8/8jcSsD8l0x5t3XjVOojy
	vioP8znT4GKN46Cyii2oS46ZI3RKpLQ/6fig7f6KwyqJ+3FAERDI9Yhm0cDxVCZ/S8k/fYXwWNp
	iaPurYBpFKz6TRn7ixoTfl40rK5SV/RL6sXSVNlTA17Zrc8ns+dreYRWN58Ia/tQcLZtwdsCuRV
	GvbgJ6rzmq8tgezpa4cUQgf3GY3dTXCKHNfwia9Fytyfra3BoO+Rcg7hzUDXSWq+hqzsuAvBHgv
	gcVYGk8dUCDnQ==
X-Received: by 2002:a05:6000:4007:b0:435:a2f8:1515 with SMTP id ffacd0b85a97d-435f3a62efamr583681f8f.10.1769708116859;
        Thu, 29 Jan 2026 09:35:16 -0800 (PST)
Received: from snaipe-arista.aristanetworks.com ([81.255.216.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf16sm16904163f8f.22.2026.01.29.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:35:16 -0800 (PST)
From: Snaipe <me@snai.pe>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [RFC PATCH 1/1] fs,ns: allow copying of shm_mnt mount trees
Date: Thu, 29 Jan 2026 18:35:15 +0100
Message-ID: <20260129173515.1649305-2-me@snai.pe>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129173515.1649305-1-me@snai.pe>
References: <20260129173515.1649305-1-me@snai.pe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[snai.pe:s=snai.pe];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[snai.pe:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[snai.pe];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-75885-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@snai.pe,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,snai.pe:email,snai.pe:dkim,snai.pe:mid]
X-Rspamd-Queue-Id: 54034B2F8C
X-Rspamd-Action: no action

From: "Franklin \"Snaipe\" Mathieu" <me@snai.pe>

The main motivation for this change is to be able to bind-mount memfd file
descriptors. Prior to this change, it was not easy for a process to
create a private in-memory handle that could then be bind-mounted.

A process had to have access to a tmpfs, create a file in it, call
open_tree on the resulting file descriptor, close the original file
descriptor, unlink the file, and then check that no other process raced
the process to open the new file. Doable, but not great for mounting
sensitive content like secrets.

With this change, it is now possible for a process to prepare a memfd,
and call open_tree on it:

    int tmpfd = memfd_create("secret", 0);
    fchmod(tmpfd, 0600);
    write(tmpfd, "SecretKey", 9);

    int treefd = open_tree(tmpfd, "", OPEN_TREE_CLONE|AT_EMPTY_PATH|AT_RECURSIVE);
    move_mount(treefd, "", -1, "/secret.txt", MOVE_MOUNT_F_EMPTY_PATH);

Signed-off-by: Franklin "Snaipe" Mathieu <me@snai.pe>
---
 fs/namespace.c | 8 ++++++++
 mm/internal.h  | 2 ++
 mm/shmem.c     | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..f51ad2013662 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -38,6 +38,9 @@
 #include "pnode.h"
 #include "internal.h"
 
+/* For checking memfd bind-mounts via shm_mnt */
+#include "../mm/internal.h"
+
 /* Maximum number of mounts in a mount namespace */
 static unsigned int sysctl_mount_max __read_mostly = 100000;
 
@@ -2901,6 +2904,8 @@ static int do_change_type(const struct path *path, int ms_flags)
  * (3) The caller tries to copy a pidfs mount referring to a pidfd.
  * (4) The caller is trying to copy a mount tree that belongs to an
  *     anonymous mount namespace.
+ * (5) The caller is trying to copy a mount tree belonging to shm_mnt
+ *     (e.g. bind-mounting a file descriptor obtained from memfd_create)
  *
  *     For that to be safe, this helper enforces that the origin mount
  *     namespace the anonymous mount namespace was created from is the
@@ -2943,6 +2948,9 @@ static inline bool may_copy_tree(const struct path *path)
 	if (d_op == &pidfs_dentry_operations)
 		return true;
 
+	if (path->mnt == shm_mnt)
+		return true;
+
 	if (!is_mounted(path->mnt))
 		return false;
 
diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..aa45c5576b16 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -24,6 +24,8 @@
 
 struct folio_batch;
 
+extern struct vfsmount *shm_mnt __ro_after_init;
+
 /*
  * Maintains state across a page table move. The operation assumes both source
  * and destination VMAs already exist and are specified by the user.
diff --git a/mm/shmem.c b/mm/shmem.c
index b9081b817d28..449d6bc813ae 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -43,7 +43,7 @@
 #include <linux/unicode.h>
 #include "swap.h"
 
-static struct vfsmount *shm_mnt __ro_after_init;
+struct vfsmount *shm_mnt __ro_after_init;
 
 #ifdef CONFIG_SHMEM
 /*
-- 
2.52.0


