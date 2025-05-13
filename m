Return-Path: <linux-fsdevel+bounces-48902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C009CAB57FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E541B47B55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D4D2BE0FB;
	Tue, 13 May 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZyEjKwWr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89A15ECDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148619; cv=none; b=Wz/UJ+m44lcT7cuBRD3/YL4zI1J2LtY6Kw1AR0xb4hUoUK+llNQt3s/p7Is2SEwpH+uVGWBN4ZIbH6j8B6Q4OVe6S6w8jJWs7BoGp8EKqKRifl44GEk7uHKg6y13wjLjPvD7eG/UeW3FDXe2wTuTV8Qanf0GD3UllRusigR9X8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148619; c=relaxed/simple;
	bh=7h6TDK9XO4vi8HAwbxlZy15xoNWwk+1COdubrAjH45o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrGKAdZ4EfLGzjDHXTOjBo4x3YuBE8D11JHa+fY8KbXSm0dZgevAOozWCLAD+hurXROnqS+PA9ZjLIIaNOWbpBYxNN33a3RI+395Uzr40E0bTtLl9Ci+saAz51/n5zYvnCVqwpIppTJBgwCei6PY4wO5nrB9rd7vZ2s8TjfLrVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZyEjKwWr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso61194785e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1747148614; x=1747753414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/khpT6y/LHVtwUJo6f8G8UANag+DTR3Iq07zRFJyCJk=;
        b=ZyEjKwWrsAnW2QYtYj32PxzL4lx/x3OofUPS7qiK7++XAsrRtdbWZ7mUCwmesvoHmI
         LPx+IZqLQ8o8K0e4vPf1Bs+gfee4Wuvf4hJALUMDUFHuioV0mu32jgdI8ba/iXZ8Sn0e
         3ysOx0xT9+T0rFv5sAiCPbiG5XISV8aKMnex0HlpsRt78RdD5T3BWzTmFCenMO0n15B5
         5G2ipFt52JMrEAiKAuGLhekvL0h0HJEpQKUvh0HYtiskBN9XIWBuZzHt2ArnT7aUY4OU
         9n8lc4aGfg7kNSDTWGaG/vzNqzxcncQ0DaHb77cFxikBcqLBaRoct4q9hzdFNmDPqrHv
         X7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148614; x=1747753414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/khpT6y/LHVtwUJo6f8G8UANag+DTR3Iq07zRFJyCJk=;
        b=fUJQKqN4Lh6fdR4LnDW6zXwpeRYZ6JWfS57DpPuiJoEOmJxtF5iQlQdAv9XPx4Yns1
         CqngNnGoguCs82FIUgOCawdW3IHpQUCU1gHbfBTyf2qkfuKUMaLKAO7LL2hZ30tv3Gk9
         gjSYRCs356k4aM2SdXQcklXnLH2VNFweu6kRPjtA76QOd4KhPZ3zNDqCijMBPeaD1o1J
         Kqh8xtWPBnBq9fWAPMAWzrD9JzfUcQBLd9t9ZZiG/n3J8/2AnB4mSxuyx4bLmu5dj0AL
         ZDaZtIYNLCe/rHD1TpfhRAIRImY9JTyEzIjADCAQZMCGOp3ukES9EW7WuAzqTcSc5gOf
         nvMA==
X-Forwarded-Encrypted: i=1; AJvYcCXmRlrPf9S3thZ7lnJ0o2Y9zE70Si28Js9Smx2eLwegWG5CsbRCrgaCvHVxNkViBdlLnCAuiANU888WLa4o@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJbsp2P4Q1diTxICrdRLcqWbaxeHZFzIe32sqo3UQDyYPR7Fn
	714jue0nUgcRjtH2Pn1ykU6JKdLZLN+l2c2mf6EYHm6+65ldJpLVRuLOoKwtNLA=
X-Gm-Gg: ASbGncuy46JjF3iGy2eHVXGfO3hwMz2gvyTXlh+iBHJTvADB3W2TffdXhXaFGfpgtSi
	3P2om5+a4oeU6Wc0u3fO74nLQO4BFV83hIKlBZhitxICawBex+0XMVtURdxgF9dduu9USiamCXJ
	4IK2FobN7wW6sDCc+zVD6337a02X6oG7hDFmm6AuZ1khum4PXFSez1/hoxlgplkXVr/1TSOELeF
	psFcWroWpDscUW9iXcroxJZRkhjK2fTKPsT1T42zuScQGd6x6iTgrkWmBGbcXFe26hgdesKAHHv
	EhYSoISPsTn2nAd5DdWt2VXPGYnjT1cON5eFMss04fxnRItXfVsWv9GaHBc/W3CEJGw/f5gfD6J
	1iao1uSdpg/BRHvGpD1+2arZH8H31OLCPomouum3PcY8hOKZORTU=
X-Google-Smtp-Source: AGHT+IFEihMN3DpCrImIRC/9uCzJ+D24g5H8VE5PHrXwPAY3J3KM1oWCaSDbh+5QuPzDZpLQql8OBQ==
X-Received: by 2002:a05:600c:1d84:b0:441:d2d8:bd8b with SMTP id 5b1f17b1804b1-442eb3a33a1mr34112495e9.8.1747148614433;
        Tue, 13 May 2025 08:03:34 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bc2fsm106800805e9.20.2025.05.13.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:03:32 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 1/4] include/linux/fs.h: add inode_lock_killable()
Date: Tue, 13 May 2025 17:03:24 +0200
Message-ID: <20250513150327.1373061-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for making inode operations killable while they're waiting for
the lock.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/fs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..5e4ac873228d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -867,6 +867,11 @@ static inline void inode_lock(struct inode *inode)
 	down_write(&inode->i_rwsem);
 }
 
+static inline __must_check int inode_lock_killable(struct inode *inode)
+{
+	return down_write_killable(&inode->i_rwsem);
+}
+
 static inline void inode_unlock(struct inode *inode)
 {
 	up_write(&inode->i_rwsem);
@@ -877,6 +882,11 @@ static inline void inode_lock_shared(struct inode *inode)
 	down_read(&inode->i_rwsem);
 }
 
+static inline __must_check int inode_lock_shared_killable(struct inode *inode)
+{
+	return down_read_killable(&inode->i_rwsem);
+}
+
 static inline void inode_unlock_shared(struct inode *inode)
 {
 	up_read(&inode->i_rwsem);
-- 
2.47.2


