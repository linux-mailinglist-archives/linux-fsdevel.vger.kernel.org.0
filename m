Return-Path: <linux-fsdevel+bounces-73755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C5D1F8D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CE63301E6B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13030EF63;
	Wed, 14 Jan 2026 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDRMdjdt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG3paoVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F513093C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402437; cv=none; b=cgo5C7NRudn8QU37CaRXel+9zA47+NY5Inu1IlClz7ihOEAETkQ3sRFRXYABTmoT0w8I6jYkK21yP/RybyaRlAlR+5FAouZcUwpTsjcB+X5tsUlRnndDKFHkJqtrzZtWDgQENSD/lkXOQ0r45sK4l38IZRNAvoFKGfFjBmg4DS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402437; c=relaxed/simple;
	bh=3dvD91x1gqfTrKXdU+a3dgSQsKxVq8IhFA1l4oYjdL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzlnzRBc4VEZIL0G5ecdNteN76gHyvTwFM2uMpLvlMAWN5Ch0mN/2c94YvrP9vtdqDYOO0jvCeG531xqf2p2+RCu3Mh+PWN8nAUMHF5UWepED8kV8a6yG9LMvlNAupLOL4KbLfUH+ykOnS4K3e2Np5y/0fZBaQyluKT951hbKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDRMdjdt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BG3paoVW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768402434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWJB21+Zee85RGLzi70gGPDCJxYb/AI28Z0CqCfd5+M=;
	b=HDRMdjdt0EkR3WdxBL0qk7uUglxLhC3rOZOvYEUqO6NzVGEgygBZt7LLGhQSVvDHfNdwrM
	LrTX8Fr/Jld01pwMP7Ax9LHxqTYwcc1TO2RR4vkvb5qdL+AZ3967fsImsT98DM53JnIwHZ
	tjfjOCnDfkoIOcc90AL5o2vhd1eFv+c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-kv-dF1I1MumvgK31aOf3eA-1; Wed, 14 Jan 2026 09:53:53 -0500
X-MC-Unique: kv-dF1I1MumvgK31aOf3eA-1
X-Mimecast-MFC-AGG-ID: kv-dF1I1MumvgK31aOf3eA_1768402432
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-650a191e47cso9125942a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768402432; x=1769007232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWJB21+Zee85RGLzi70gGPDCJxYb/AI28Z0CqCfd5+M=;
        b=BG3paoVWtaHzekGgcOTDDhQ503yBMFWdW3zP74toM//qvaQH2Ar0f0aSIDAF9kfj57
         pJPLfDBWQ2G4U2M7b2yyKryYEKm/K4zoa+5KeLx9thp1fZSzgng//D9Q2OSvHQUZD+fp
         AI0L/q2j0/DH//IV9WzrYLWya39DDrV0AikoHveARzg4lpHxpx/3aKPym+96UwGwUG0/
         96EsK0FpntWbm6zTv1lR9q4MTWsquMWonomOHLqPYZYaa7nFY8DuEqiTBJqk6bLqbK74
         Xkn+JG1oPqRRmXjv7w4B5gvfLb/zH+YQjXTaqZ0vA1Kxlny7hOPHBtaiuY+iipVADnRm
         8NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402432; x=1769007232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gWJB21+Zee85RGLzi70gGPDCJxYb/AI28Z0CqCfd5+M=;
        b=TkXoqN2Docd3YJJmQqHibsbsESloB6+km+Bp5YNOXLRmNLjDp0cRcMwE5Zg2uuE8f4
         tWynbkYkOmFnL1Xgz7P9gn0ctOsZ7WatW/N/6q/x0b3SH2uoYG/08lUcwqNXV0usfu/b
         GCNLeKqYqIydaRzBHyLFGFNL5/JUxhfdB1QlkAmqWFYeki9xQDsKVnioWPTCcpx8c4Ye
         31a2cmNdKagPS1WMndPuVOVqDd1LI+/bYFBcYgfVeN32jEtSzXlHhA0C5FC47aFLqlNN
         XZO090MiYo1c98B6vr46YzV5NOvVQFl952JMTCbVtrrZt+YDhYw1zYsCRAsw5Lu8p3o9
         0XSw==
X-Gm-Message-State: AOJu0YydRhJnNk/QcEnxeEKPJvSLL48LsGGS6I+wyV9GuUncktbH0Jmn
	R7JgNdncIzIepldryQdFvf/lgJ17DJrAHrR4O5Zgbo5iDWlluP9VJyH1CVJeJLBG+1lYj7bv5IT
	dZPMJ9YYimn8uaI4q+c7RIvzYigoI23w6uPgR60vO9DXWNoVncsBMK/6CNHWwRXcaWBAdSLOU8b
	owCubSkHp8XXeOZtcStmpgcsx4bWM6/00FC2iLna5Me2z7MZqBUqU=
X-Gm-Gg: AY/fxX7Dnwqr6cpziMcbNOFmnPtrMF04J6k4DINgXFxEZpOb+zN1JSzhzpOyNb/p6V1
	3JvoAidTMxpCnYxn5l0ceb8pDiZXd7ETp8yY7rf9YVOZz8UcM93CRclbITLIFKEn0sPKFBm5HYd
	wd9vMxkn5hjMvjBy5hQc8AgaWIfP1UOQLrtrJjMA6f/EMSzCFdvettRkAFwxG4krFfjSaVnZUCM
	KYAUimuVGa03i4T7boKV12LxQ/agpV8uep1phXphC9lWfkaaOOMJwOJqi9nXy2qYGSPq/F6R3RB
	YAH+f9tlb0FEp/pO07QyJtUB1d1V3prOhad79HCqPnsH0gXirJIOKhsYQnG79DqEVXsnahNx2he
	qaPFIR7CObI+feUdORaXKVikn6vosRQBEVCesjgoyjanbJavIRljnNp1syqNdtSov
X-Received: by 2002:a05:6402:3592:b0:640:cdad:d2c0 with SMTP id 4fb4d7f45d1cf-653ee1b1c24mr2018078a12.25.1768402432255;
        Wed, 14 Jan 2026 06:53:52 -0800 (PST)
X-Received: by 2002:a05:6402:3592:b0:640:cdad:d2c0 with SMTP id 4fb4d7f45d1cf-653ee1b1c24mr2018058a12.25.1768402431843;
        Wed, 14 Jan 2026 06:53:51 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-7.pool.digikabel.hu. [193.226.246.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm23059608a12.33.2026.01.14.06.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:53:51 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Luis Henriques <luis@igalia.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/6] fuse: clean up fuse_dentry_tree_work()
Date: Wed, 14 Jan 2026 15:53:41 +0100
Message-ID: <20260114145344.468856-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114145344.468856-1-mszeredi@redhat.com>
References: <20260114145344.468856-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Change time_after64() time_before64(), since the latter is exclusively
  used in this file to compare dentry/inode timeout with current time.

- Move the break statement from the else branch to the if branch, reducing
  indentation.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3910c5a53835..d8dd515d4bd6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -169,21 +169,21 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 		node = rb_first(&dentry_hash[i].tree);
 		while (node) {
 			fd = rb_entry(node, struct fuse_dentry, node);
-			if (time_after64(get_jiffies_64(), fd->time)) {
-				rb_erase(&fd->node, &dentry_hash[i].tree);
-				RB_CLEAR_NODE(&fd->node);
-				spin_lock(&fd->dentry->d_lock);
-				/* If dentry is still referenced, let next dput release it */
-				fd->dentry->d_flags |= DCACHE_OP_DELETE;
-				spin_unlock(&fd->dentry->d_lock);
-				d_dispose_if_unused(fd->dentry, &dispose);
-				if (need_resched()) {
-					spin_unlock(&dentry_hash[i].lock);
-					cond_resched();
-					spin_lock(&dentry_hash[i].lock);
-				}
-			} else
+			if (!time_before64(fd->time, get_jiffies_64()))
 				break;
+
+			rb_erase(&fd->node, &dentry_hash[i].tree);
+			RB_CLEAR_NODE(&fd->node);
+			spin_lock(&fd->dentry->d_lock);
+			/* If dentry is still referenced, let next dput release it */
+			fd->dentry->d_flags |= DCACHE_OP_DELETE;
+			spin_unlock(&fd->dentry->d_lock);
+			d_dispose_if_unused(fd->dentry, &dispose);
+			if (need_resched()) {
+				spin_unlock(&dentry_hash[i].lock);
+				cond_resched();
+				spin_lock(&dentry_hash[i].lock);
+			}
 			node = rb_first(&dentry_hash[i].tree);
 		}
 		spin_unlock(&dentry_hash[i].lock);
-- 
2.52.0


