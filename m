Return-Path: <linux-fsdevel+bounces-30319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7147B98985C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 01:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC101F2186E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 23:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915217DE1A;
	Sun, 29 Sep 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPi5war6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4526AD9;
	Sun, 29 Sep 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727651219; cv=none; b=FJygST7522BDYgRtLFazkY7NXR0332TkarWgMVQqgaqnBbQw5otVYDRpSOu20E9xYSSqbN4s3lW6yEu2KSYhR9HFd5isWuFZpm51vYlSKpFzMRT1E6v3qERs4mxdiq9sr0tmnaVeutdFsrCZGY1gsQh0axadCyiJFCzCgoN/AXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727651219; c=relaxed/simple;
	bh=4hSaBqgEa3ayJyytv/Hn6lZcuxjYI4hzmrq6enHX3jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5G7kI4hzQBX1stRrryj0SZ8ctE6AimsehcoVMffGp5f4XTAMeEkaJsxxgInnGboDRDn1UQ+s+G6vs369HHpqyiwqnvCGlpm/aKVff2xjnSQq569zSJmbJV5SnszBN1DUj/5cI0opvHZFBDXJGJ46miH2Jft0vXHBjZjD/j9jMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPi5war6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so27170125e9.3;
        Sun, 29 Sep 2024 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727651216; x=1728256016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jdFejcxdLhzzj1xvhfj2HwO/ISLBOj58Q9HnQMa3XM=;
        b=FPi5war6gSVwLR0m8mt+gbdA+NQp588DhHM5cntbgb8c6d36EOnuz+we0oXKAboTq6
         miRPTyjRk4i36csV2Z0iCuCOedNT7NC9lKZh83dbt+L8oh2fEW+qEvjZrX0CoQmY7bQ7
         GyKZ+C03tM/1Pln1H2iglMY5sWo3VC5bE2s1X0AligkBqlgo9cndu7BUi+31G8IIDkRe
         aLYJ1kY2OcE7RCaRG7KhUjiLb51oV2iQ+T1V+qvnGM/JcTddWX/MmIizZX8FOeJDizI1
         HDMVVIrFJv1yzLvsGOjGRfRPkqOGu/f5EgB+L2upwSgaU9RnUYA9xW6/3mTKsOz/eIPJ
         jJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727651216; x=1728256016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jdFejcxdLhzzj1xvhfj2HwO/ISLBOj58Q9HnQMa3XM=;
        b=QRDuq3DpVQRgMuhgSW5DHyn2UNzCQTQRQ1NcNISmy2C6O2hNYOa1Q81tnc4Y8YpUYX
         H1bEC3jvXNW85Ln7h7vJrB62Zr16KXUUJ/+EkIWLsL9UkP2fMSYDEDAfeTWysHAW1muF
         7NAIwhrdm9uYmdit9vGODHQId+aNWZc3ytizmjPhVvuSSH6KBqKbNj5Ow60AIytwyz0Q
         XFDmBq5xghtCP35CpyaCVi+cITVNirTUdSY9KGgs9lLxstJgSGIy35jm+Eu8uB98SxXk
         z/7P9s9CdLIRLNh9PAfxNgpAIW16xvveIGr+z/OYrgxhUdpQHc2tBy2kMvKz6rl4K5sP
         YwsA==
X-Forwarded-Encrypted: i=1; AJvYcCXAHb7sTSnWlIj3hIVQh845Vj3S9H/8Hr0fKuMelUQ8NkYFo126vQ9gFlD+aRkHwED/SxUhxAKvMWBvtuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3N/OrnS13mFk+oWtERhff5khaVW9jQLydyd/EkTCznmAAhP9P
	/B3OhQ1D/Z9Mog5Pd5YQaNEUMolVEf9LhKCWygiENYWuuKP0e0UX
X-Google-Smtp-Source: AGHT+IHh/iA4AezibHLdoZoaho0VJVidl7o8NgQVKmYwAGPqu4fmymwqfCOukvYNPNu6GcpbDT9KdA==
X-Received: by 2002:a05:600c:4f14:b0:429:e6bb:a436 with SMTP id 5b1f17b1804b1-42f58414591mr68210565e9.9.1727651215870;
        Sun, 29 Sep 2024 16:06:55 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.. ([2a01:e11:5400:7400:ca98:6bb1:3a23:ef55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dd2eadsm87441985e9.6.2024.09.29.16.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 16:06:55 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Gianfranco Trad <gianf.trad@gmail.com>,
	syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Subject: [PATCH v1] Fix NULL pointer dereference in read_cache_folio
Date: Mon, 30 Sep 2024 01:05:50 +0200
Message-ID: <20240929230548.370027-3-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check on filler to prevent NULL pointer dereference condition in
read_cache_folio[1].

[1] https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531

Reported-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
Tested-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4f3753f0a158..960f389e2d3b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2360,7 +2360,10 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 	/* Start the actual read. The read will unlock the page. */
 	if (unlikely(workingset))
 		psi_memstall_enter(&pflags);
-	error = filler(file, folio);
+	if (filler)
+		error = filler(file, folio);
+	else
+		return -EIO;
 	if (unlikely(workingset))
 		psi_memstall_leave(&pflags);
 	if (error)
-- 
2.43.0


