Return-Path: <linux-fsdevel+bounces-67205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ABCC37FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 834A44F30F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F62E11AB;
	Wed,  5 Nov 2025 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3DrJn1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DA1E47A5
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377639; cv=none; b=jRMXuuMn7scAAsbpWG/ArC2P1ysfs0IWDYEi1hw9N/AOtzbUH55+c3XEIDaAZxZW72TT025wiO9Dd93rgqF2O/pt+ZP7wpP5qc7fXjrpL/ZBDU+qfkZuQXNEyNwC5H5ylDSqMatjWMy/r7hPNIeP12OHO2HS5pr3SatGnRBH9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377639; c=relaxed/simple;
	bh=2pplFlMMvnjUl6FrlZeDRW3iPjYcJlrYy3U19WE/I2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXRkGkxHIIZbOFU9HGIVWcD74W71Ke71yTFyzFTSNXgqJaCiL0XMqABVwcBUVGQfDZ/CLXD1NhCQfuWvS1sXPhnxOvVQ81aJBWdDRK5zDQgpnV2Q8PQ5X3JE8ty2dg+lWhAFO1E+ZxvDdWV8vPwLBSYqWTharutIOor5SO3gC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3DrJn1J; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso1934015e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762377635; x=1762982435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdLJGs3mR/Ak3xxBl+2P2SaXwjuVbkUq06ZP/Gr3rTg=;
        b=A3DrJn1JOySehDZuoyhVgOJjCj8Z6fOoSQFAB9ZZ3tmRRJw72nfZDI2SJHlrZvl/F7
         NiTOXTvbnFMyo/Dy3ebNkdyoJEqD9NrWLYlQ0eJBLb6HCzD7+68bRruNuWOPFcsNoJKD
         2LjYOBg15pM5bUqcNgtPzt13Q2969Fm9Pk4cHjF+I6FPkPEzYH/Q8dP2WIeSCCZhegTL
         Eq5O5V+Tlimg4aVxJIKkFMf4761msUOVwwGWsWagT+Z6b2Tk650HmxDw8MF000A+u1ip
         UMoDfuBD82+eEMYCKgtJgTXSLfnof6VK4TIW8WFrUDphXnM/um9gcgFPoqMXe3Cn7uaM
         5LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377635; x=1762982435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdLJGs3mR/Ak3xxBl+2P2SaXwjuVbkUq06ZP/Gr3rTg=;
        b=dSdpJ7W+6JIeJYr6F79SnRaPYXpIgZV6xsDKPGTPP3yFIV9s11jrktzSCFtZ941Iwy
         cuY4d7jD1KXhPJFrEBtAULdHNfyqDNGAOCD698TQGyZx6c8sqODIIGlL9HwcyRhzcbfM
         q4kHI8HOgZhcJqdPHiPgfeoP2PScdaNk0nIvXwEXsThR4xx/gL3UBxXj2YmTsMD9/9A+
         Vrmeg8GfaIMJFDE4scOSxeLvat1/X5cWGIkxQ1Mq1GUjBrPzXaI1Q0c5IRCXY9z1AENz
         xZTGwLNE/97oywTNQHTdkTw4juESpijDbpfzlUQbclhehEokdDq07GxEuKQ4SVIVgCzs
         lyvg==
X-Forwarded-Encrypted: i=1; AJvYcCUo3YYCIKP+gbog1yW6v9A1X9uQd8QR3Z+Tc7vd/vxftt6lWuPVRpmbRxDjC7E0b+U1YdIJrgVptaRhiCeA@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZmhZNBWOP0Pi7nvS7c2kNgplTRfpg0klqrMaiMyPK3zYYLPl
	ZT3lrWqjUzL/UeKsJJlj+9D9XMS4DTOnfgoeIv+YC31cunjy8G3fkevF
X-Gm-Gg: ASbGncu1Bkeza3oAfvokdQXHsNpa7gMMAinS86liRdzD5KS09xmO0bHGm7YFKn9pJgV
	fMqKdrh6WKxrcR0HPOXSxkYRan1JBxO4rfHLZwDr+oMQTN372iOXEgPfKoRduZlL/vBFMZVYbM3
	1t9PvX6ZsjoJmPza6MngbWtrvOohCZ7NcdGBF6bzXGRdXMhg1FYffMPnva5krgvRK1/9OJxMkfp
	JJQiwThsZw9F6LVZPgl3hPgQ3vGey45/KstP1GHgreNtnPamFB2hkGIJk9qxyWbTM42EgFBgz5i
	KqUlBItShG++OSZkP5spfGEoOdTb0fTq6vD6iSxrnn7l2z1FOqB5LOZtC9RyehEBHelxk02Vd9H
	WjDvD3ss3nyQYb4Zd+UWw1Yond6RE4wIA1AWIDtFrmtxtBZYrrmIWUopcpI3jHdBGoYBxlAOBs9
	Ez+7Wj6bE+w0mdllid0Of5GRhvq3+iyK/lVXju5ib74v012vmd
X-Google-Smtp-Source: AGHT+IEwpSk8sOAJvDtjfIMcje8WUONwpgtu7bj9S59zK+n8/BOyF98omCH07HtS0euQPIoNmLSS6A==
X-Received: by 2002:a05:600c:358d:b0:477:b93:a7b8 with SMTP id 5b1f17b1804b1-4775cdbd478mr43779465e9.8.1762377634689;
        Wed, 05 Nov 2025 13:20:34 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2f90sm8914505e9.12.2025.11.05.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:20:34 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: mic@digikod.net,
	brauner@kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	eadavis@qq.com,
	gnoack@google.com,
	jack@suse.cz,
	jannh@google.com,
	max.kellermann@ionos.com,
	m@maowtm.org,
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] fs: add iput_not_last()
Date: Wed,  5 Nov 2025 22:20:24 +0100
Message-ID: <20251105212025.807549-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c         | 12 ++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..cff1d3af0d57 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1967,6 +1967,18 @@ void iput(struct inode *inode)
 }
 EXPORT_SYMBOL(iput);
 
+/**
+ *	iput_not_last	- put an inode assuming this is not the last reference
+ *	@inode: inode to put
+ */
+void iput_not_last(struct inode *inode)
+{
+	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
+
+	WARN_ON(atomic_sub_return(1, &inode->i_count) == 0);
+}
+EXPORT_SYMBOL(iput_not_last);
+
 #ifdef CONFIG_BLOCK
 /**
  *	bmap	- find a block number in a file
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..98fc088a461f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2823,6 +2823,7 @@ extern int current_umask(void);
 
 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+void iput_not_last(struct inode *);
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
-- 
2.48.1


