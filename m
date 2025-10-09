Return-Path: <linux-fsdevel+bounces-63631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F713BC7D99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3957F3A3378
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB842D3EF6;
	Thu,  9 Oct 2025 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMirGicO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3362D130B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996786; cv=none; b=IXjU2GDbv0WfnXhHv5S9wlHKFNNmduv4SAtXixRRtpHrS2/YoQ8+N8EHYXInzu/bpPNeBc1RCcklra8dY9ZiK00i1jG2ffmmHGopSQEdecIEMfyjKvZQNcHzzgTRfsV7JGFLGzQBpHG1kLY91tl0zRUjTv/ZFIkF+jnzTALr0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996786; c=relaxed/simple;
	bh=hn/T4KF427I5vM1FE3EEQtD8Ky5WVe1EdG5AuHI54+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTkZEy4PjifQAMqOGID27eoRmuvJnuBZvqgeEN77QmrrojwyCLuSV1a4YNBN1ewt1sgm1LxmHq4Uuxwjia/kP7PYd+FqDWjktBA47eC8df+N+3weWbn781yIDiX6ZLxpGsN5aKghXJ+7Dzj+tti3UkOWstlVpc8oYvU6IdshQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMirGicO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b41870fef44so112510066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996781; x=1760601581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v56yGNQ37Majx7vHh2h4KlxSuTszWt/5MXXh209zdXY=;
        b=lMirGicOJdPSNtq9UZZJiIbkDKhy9CQKtYmj64hbx8QVtEfVQuXDHFoFXpPwusWLPp
         TgB2diOAbyyiUZcXGKKHKQWVgGL1Jx5zQmAsLuWo7rzUL/RHUceQ6EmmLLL7Tuuvpp4o
         p9ObZpVAYRgOtDSAocog43dOeC1QR+/iw8CnAsNHbYFgI5Ks4nU2NhrpX0ALFEcaEVps
         HMcARGcAMROGsXQWYoNrwFrRuRN/dEOF92/+8jeLPDMVuQaS266+1IDl1a5rwpVSlF6c
         2XA+0rOpC18GFVQLbBReMGiW4hLHZ1ZRNPiZz+JymED71pXEAhX8lcUFUw1rNjt8rgI/
         ickw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996781; x=1760601581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v56yGNQ37Majx7vHh2h4KlxSuTszWt/5MXXh209zdXY=;
        b=V7yOdARBb3ZwP4RWrVK6B696kD5JPEZTvdwPNiLjnTqe2vMi8ajx4Z5SeS0KW8BpYb
         /g3cb8dgSigQ55kum0f1LpQJQ8/+MiCXmpSzNN9egyO7Gl0U+kmsO0X85MhXaFGBLmE1
         nzOxww71ilHUWNSkHB5ZwVA5mdiKhKdXXIeCO9j9LA11AkP/WApyxhTyRCD2x5XWecO/
         idueYj+1mKvJq3ixmFdUotvu7x2V15M4KEuS77zbW+5hysP+cFEcarodVGJRqDyYmMpg
         QhA9Az6wLVmoOdXrF1Z/JXBFNZi1bQRBnRtBvjIrDLtS0Qf0H906SYkL1ipFxejeFdba
         kbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfJDzmNZAJCdbBBUFmsYwjtFAUyqxhDMIdkLVBtWeNL7I31DUy9yPWQ76YYXHU4ip3rmpvzOY+9X8WEg3q@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKrWgZh5F0Mq6f07dmrSjex/o/iFdCmC+lEbxDYqU/iruCwOX
	tk3o1gFkKsRXzJpuAc2tZnd33rWmVszvjjPzA9DyQi7QL/gNokllHe4q
X-Gm-Gg: ASbGncv8MJixDpPWvbKAIX6y8+l1fo5ZbH7y/oHQTeqiQUjRpZlJLYkRTTm0obbzVnC
	QiLGL2HqkmCONZ8ETlTjsYj0DdI3MRPXml/e9sRJyCXGxtARrnqeiOZw/ovj/GU1E2Gr50JphvM
	mjzQiQooskwau/DIFP+7SbWHyFCK5yMj3G5tbI315PHtUnCzrcc5/H4tPi/tu8oD0+O/Fn6hOey
	gVIpshV3xCs+0hkQKnSlV24e0VwUa0kPvZBSYPG2LnGHnmqJ3dba8IlF+moQSgSgwND/ULMHQD6
	1QCNehKde29STwaGZgps1yEAIwpU+Okdb2X8LR1z4S2aoMXNnMWv3vdi3vH3xK21Wx4Wz9NdWGL
	gd8uKf6Ai9TLhlokQmDiVKaxJLHjL0F4EdG/3+r1SJXvL0Irx00BfJVWg5eY8lGHnmq+RXByWLy
	beT1eTw3dEOHdghzyi9cSKPrypvxM4/jwE
X-Google-Smtp-Source: AGHT+IEc4DRH7N7VTwKCGCSJIEPnJelkA9fOKTTSeoDugfMSCygU9n//Fy4KEuh4pwZhlTzmLezAHw==
X-Received: by 2002:a17:907:3f17:b0:b41:abc9:613c with SMTP id a640c23a62f3a-b50ac5d08e9mr658923266b.51.1759996781064;
        Thu, 09 Oct 2025 00:59:41 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:40 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v7 01/14] fs: move wait_on_inode() from writeback.h to fs.h
Date: Thu,  9 Oct 2025 09:59:15 +0200
Message-ID: <20251009075929.1203950-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only consumer outside of fs/inode.c is gfs2 and it already includes
fs.h in the relevant file.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h        | 10 ++++++++++
 include/linux/writeback.h | 11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ac62b9d10b00..b35014ba681b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -949,6 +949,16 @@ static inline void inode_fake_hash(struct inode *inode)
 	hlist_add_fake(&inode->i_hash);
 }
 
+static inline void wait_on_inode(struct inode *inode)
+{
+	wait_var_event(inode_state_wait_address(inode, __I_NEW),
+		       !(READ_ONCE(inode->i_state) & I_NEW));
+	/*
+	 * Pairs with routines clearing I_NEW.
+	 */
+	smp_rmb();
+}
+
 /*
  * inode->i_rwsem nesting subclasses for the lock validator:
  *
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index e1e1231a6830..06195c2a535b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -189,17 +189,6 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 void inode_wait_for_writeback(struct inode *inode);
 void inode_io_list_del(struct inode *inode);
 
-/* writeback.h requires fs.h; it, too, is not included from here. */
-static inline void wait_on_inode(struct inode *inode)
-{
-	wait_var_event(inode_state_wait_address(inode, __I_NEW),
-		       !(READ_ONCE(inode->i_state) & I_NEW));
-	/*
-	 * Pairs with routines clearing I_NEW.
-	 */
-	smp_rmb();
-}
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 #include <linux/cgroup.h>
-- 
2.34.1


