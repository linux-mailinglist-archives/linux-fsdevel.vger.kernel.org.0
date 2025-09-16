Return-Path: <linux-fsdevel+bounces-61739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13AB5987A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B493C7B734B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CD132A822;
	Tue, 16 Sep 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzHK56T4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F3329F3F
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031178; cv=none; b=Kc32dFIbCp8Tj0yr7ty36PKJG0mjpugSnEkCDY4sOd4S4W9fyXjDlUi7MkNiIVxvGOaHgosvjpMiofd1Pz8Zvz37fW3b7okoTUYsyhVbssSwP1NhgiTHEJnWPDnClHAyYQDFciYJYOO+m/RC0shD2CHkYIrGp9ytwMBE9ZqquHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031178; c=relaxed/simple;
	bh=4ZH9W3P+XiG/Sp7tBDITc58g7he5Ng0NmNakO8szh+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNd96i1MJIAjzGyawVvuCfKKhp+34skJYlTvFeXh/9sGowHarnORia26Lj496twkZi05q8VRUHO8UQkc1kCxN+Xse3qQls4P7XoQbljx+vktoLUcRh5uSOLL1oXIuvL1u8AvinublfSPsZcus3LyRhAU7FOwwJO3tvE+456ObJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzHK56T4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso55132085e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031174; x=1758635974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhJbct8Hpn8FASNagja9p1KxL0ag1VLHqziGZAwrXc4=;
        b=NzHK56T4Gc9JTM6H5ShPFQQhyyD1KBGLZZDgYq4XZa1aMIo2n4DP9S0SqtZSlgWAel
         URh6NqbNPTAC0XBYWmTWUCNq3f7yIBNCgTDGy30CRsnWD3N6BeCrDUdCf8AY1Jy0sxfs
         WxF4HDJQyHIVnXBszwq0VmZmX6SitvC+7rsMYWXwI9n075Gotqh9WWoCi35qff0KJekl
         vzrjUrDNBpGx9Ytd4bcUK8NHqrUw/DQeUDJF/Nrmm/urXLiciDnr62isLxnvHErkwNE9
         ChRWElykA0Gkfi8CJCeridEoKr/rNMWmUrWzXUSrCFAYe/597o+/Dg7K3iJmLIkP7uTy
         7GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031174; x=1758635974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhJbct8Hpn8FASNagja9p1KxL0ag1VLHqziGZAwrXc4=;
        b=PbR5aEIHzJKdZrM8OXpf4/z19DMU//7JMlJQ6NA1sHKR6lJs+QLtNaly7IepHF/U+q
         qgGCG2UMoQnmONXu6qVWb+bv7w9TXjBbRZi/FeYpQbavsMkAHezPFpRfajMQrWOXAJTa
         OfHWpACezl7OMOHF4uqZ+NwGWGatzCg1I1dvPY63dRgVadowBLqVJXbqnHvDSH9cwfGN
         XjD/4U+WMUjTr7z4dG8IWmwFelkD2HqR+QhScJCN19AG3xunk1z5eJictaDaSX9pNjXV
         haK17SdjRGY9AVEkT4vkXzybX0Celad6nfh6gDN/qR10KXk1BoL65EVhsYS9s6HL3nWh
         7Hqg==
X-Forwarded-Encrypted: i=1; AJvYcCWms0LYMAVBt3HJnwbOqTPnTiNzLXcoIYWZnSjoX0Kjdg9nd6+QILXikGBiotHAfFrp4AOVLhhqzLm3DJrn@vger.kernel.org
X-Gm-Message-State: AOJu0YynD1ofLHutn30kGf+PgkRD6zBn8dJuxCCxb5DhiDoSImYRaanh
	FLhTsUsJqIk9Xy7eWqE7/dnNUTdjvK99+Yr8fYatACYNAENQMaODDgTv
X-Gm-Gg: ASbGncv64JMXExGL41zrTWP00t3LOYe9/og5/gUcXrv5v3l9kLfP5CCqc8NXmOGB/pM
	61cMyj3D3PUFkEVPgCxwLtJHC8KyYuYA+Xurg1Lq4r2LH506jM2r+c83oMHH8PXii8IEUVPnevL
	bI62qhZkVwI1ibGaeN3yat+Vk3hRM6t0G5NYaJxjfOnTVvjElecQdIeYQxuBs5G+/NDsHJZXCNw
	Ze6wAaw5bWDLt3ngaqN4Da8C9PQ7oUEl0EntqzlxbqqSIhsh/3gpwBRuqHHkGTvXiyrv6Ol77Cm
	sMwFCxKXyj7pSk4u04IYJ1SRkTU6uOpKJtT2YO5hywGy0LARbCRpQWRbTV3wt87wNQFzZQ4lRE3
	u6/gu+axWZg3RacOPpOVUHUZqv7nAnodfNa0N7MbT5ev+l55bzSz826lQCA8OHCmLEE+jI0Op
X-Google-Smtp-Source: AGHT+IEv/yp+v5i4wDZD8rx/vzr2v/aCCUSPqPNX1ISHbufqpWah1qF1v3yMiZroJvxSpOFaPBPDfg==
X-Received: by 2002:a5d:5d01:0:b0:3e1:734b:5393 with SMTP id ffacd0b85a97d-3e7657b6a36mr14835320f8f.28.1758031174218;
        Tue, 16 Sep 2025 06:59:34 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:33 -0700 (PDT)
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
Subject: [PATCH v4 01/12] fs: provide accessors for ->i_state
Date: Tue, 16 Sep 2025 15:58:49 +0200
Message-ID: <20250916135900.2170346-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

In order to keep things manageable this patchset merely gets the thing
off the ground with only lockdep checks baked in.

Current consumers can be trivially converted.

Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state  	=> state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_set_raw(inode, I_A | I_B)

The "_once" vs "_raw" discrepancy stems from the read variant differing
by READ_ONCE as opposed to just lockdep checks.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 59 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c4fd010cf5bf..d54171f13c7a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -756,7 +756,7 @@ enum inode_state_bits {
 	/* reserved wait address bit 3 */
 };
 
-enum inode_state_flags_t {
+enum inode_state_flags_enum {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
 	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
@@ -840,7 +840,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_t	i_state;
+	enum inode_state_flags_enum i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -899,6 +899,61 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * i_state handling
+ *
+ * We hide all of it behind helpers so that we can validate consumers.
+ */
+static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
+{
+	return READ_ONCE(inode->i_state);
+}
+
+static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
+{
+	lockdep_assert_held(&inode->i_lock);
+	return inode->i_state;
+}
+
+static inline void inode_state_add_raw(struct inode *inode,
+				       enum inode_state_flags_enum addflags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+}
+
+static inline void inode_state_add(struct inode *inode,
+				   enum inode_state_flags_enum addflags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_add_raw(inode, addflags);
+}
+
+static inline void inode_state_del_raw(struct inode *inode,
+				       enum inode_state_flags_enum delflags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+}
+
+static inline void inode_state_del(struct inode *inode,
+				   enum inode_state_flags_enum delflags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_del_raw(inode, delflags);
+}
+
+static inline void inode_state_set_raw(struct inode *inode,
+				       enum inode_state_flags_enum setflags)
+{
+	WRITE_ONCE(inode->i_state, setflags);
+}
+
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum setflags)
+{
+	lockdep_assert_held(&inode->i_lock);
+	inode_state_set_raw(inode, setflags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.43.0


