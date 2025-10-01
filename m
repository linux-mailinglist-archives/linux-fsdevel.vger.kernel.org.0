Return-Path: <linux-fsdevel+bounces-63135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5398BAEEAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 03:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5968F1941F3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D323B61E;
	Wed,  1 Oct 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY+d0cNy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF547263B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759280418; cv=none; b=kQUXus3SC9ZT2OfK4KFDvGhwUfG4rBD5R7b6E0xjXg4lYgb+wxo4nEGGAmxkXBFPLUUsqY7L+R2cW+6Yb9szgAkfgBHgj6cjSymfd2QiCU8wflqo/nHtVlChzO9hpXcJK1/FuidDwprgMZ+SwaTru7h0zoNDodi3UfyOC7Qe4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759280418; c=relaxed/simple;
	bh=6jXxieDqFD8fazb/6FJlIG0MiiYnqGvFkdIC+NnRbnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIkooYSLLoxyXHvWnPQ++NMC17ItbJjkng/yB7BSZsqVTZ5XUcJ4h438z3qf7ekdEU3+IL6JApRX6k8zjlNK+o0qvcRbCeHAyGTvdpE7Q5CsAiDrsNh5pWNohkvTUJV0P6HLO1u0tQr/vw7padQUelY56atfqMNCqy/0yr5P3aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YY+d0cNy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e5b7dfeb0so7052425e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759280414; x=1759885214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCvWtFisL/5u6+Z59vMZno7OXVHIR/I5WLUeHX/+HKo=;
        b=YY+d0cNyzGEQfdBce34CnY8Y5J0nP6MHNXNoHn/YixzcOFLd+SR9NgoJBy0PPOURB2
         JXhjTrcMblGwUX9mZIXoftj9SBuwk8ywxzgcHZu6Pv2+xFTJ/91jHS9DfI4vqWfVJW3b
         DPujH12xm7XUmqmzwWoCxs8RGWj6zb/aM6K8bR2cbyURjTErna8D6kZU57Xb5zmK2GBF
         L30jTbNB9IZRMRq7RGtyzCC3+nBhl1VqdeTeQYqGKADTgsk0vGmd5So0oLd5HRFLRuQV
         ECwZPDHPsfBMiXtCh4J9tJd+2h4RkcoMUxYaj5OSwl+2VOK9shk1pNIHLZxwlvCGS6de
         d6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759280414; x=1759885214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCvWtFisL/5u6+Z59vMZno7OXVHIR/I5WLUeHX/+HKo=;
        b=F+yION0DJh4U9+l+bdI4pQJ3r4UTv6MajVxFkPHjUE+Qcm+xzlNiMQORjWd/9VDLoB
         MoIOFDFsC25McP53vAK49mOjC530dhp3CPi1PZUjlmdwWWq73adTDj5NapajcMg0ENJh
         xEOtSzPHpFnfH3sDVBQ84eOxsvrpeiYFSAclfJgwF1TciZmmvoM1T44LfIAjqTAb2UwI
         F3qNWNgDZZ210dlap02Am3n4Jt/6EBCcez8lryr4YTg9J0VUUpoqkprMY58G03SpBJ3i
         fQ8YTSgPUeBbBSk/wLO21cBaBc3BZb9re8bWodevUmderCjaL/3tMnBL5TRaLhyQz8BY
         Varw==
X-Forwarded-Encrypted: i=1; AJvYcCXxVmw15NQJeOd02mEQs8bF6Gv8l2cIeyP/tHZXONTTZxgDYokC136hX87ixwyiWdY7caIxPRQjSR5BHbul@vger.kernel.org
X-Gm-Message-State: AOJu0YwmC7BkatXqLruQHVw7+Q2v2AqtkaemjXzhX88qu/DpIfiVjYN3
	CKcNeHmerzw/sj7zbPqQ51JPp0taz9hpVtD5jWutXzNclINzSMR7rl11
X-Gm-Gg: ASbGncu3mbXKl8WzIczymMgc8R1jtZUUKA+L43sSZFHfmbNcSu4bgftDLlpVOYMyMTs
	idmqQG6x+3VKhXPGcBCElW/ooWbYtPsJud9TzVZtfXBY7ms8oLuhXo2oTxEPpncYCoelTMc/X9p
	YYM82ajivb1tETS8tH/R/OzQkiP4lHu6L8bN4GBURIX+9CqQ6elDbSzOsSHWrggGCcRk3XQefxU
	0zV+IUfPXV5fgziPPClmdfj1TWvP8ud0f+3PmTlUD/pDpuA5HLOvWf5dbsme6Ak8Da+mcNMXWHq
	AiRp/2WMYj5BAxLylaaasz7NHurjbVkqINE+MSs7Jt7en+2KMhJp7oddiwVSYLZMWWT3M9K40Of
	cwjf/+kS/bHdnsoBVp5ua7bBl7kQR8+7U0PPLrnlQG0u6H8/6N1Dz9TGk1PKtOVj/50M+AbRXsg
	OxJuHVlvE+SjfDBpPm2kE/jdQ=
X-Google-Smtp-Source: AGHT+IEKINZ8voVJfqELLMtiD76UXBJ16fK/Vnhpwcd4y7UWCbT3YRZ4FZ+yoP1+6vpFBcsBZnBwNg==
X-Received: by 2002:a05:600c:3543:b0:46e:4921:9443 with SMTP id 5b1f17b1804b1-46e612e3f92mr13029195e9.37.1759280414007;
        Tue, 30 Sep 2025 18:00:14 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b9c88sm14576005e9.22.2025.09.30.18.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 18:00:13 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: assert on ->i_count in iput_final()
Date: Wed,  1 Oct 2025 03:00:10 +0200
Message-ID: <20251001010010.9967-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notably make sure the count is 0 after the return from ->drop_inode(),
provided we are going to drop.

Inspired by suspicious games played by f2fs.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

boots on ext4 without splats

 fs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..fa82cb810af4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1879,6 +1879,7 @@ static void iput_final(struct inode *inode)
 	int drop;
 
 	WARN_ON(inode->i_state & I_NEW);
+	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
 
 	if (op->drop_inode)
 		drop = op->drop_inode(inode);
@@ -1893,6 +1894,12 @@ static void iput_final(struct inode *inode)
 		return;
 	}
 
+	/*
+	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
+	 * Note we only execute this if the verdict was to drop the inode.
+	 */
+	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
+
 	state = inode->i_state;
 	if (!drop) {
 		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
-- 
2.34.1


