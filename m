Return-Path: <linux-fsdevel+bounces-60621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 780D7B4A448
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB847A7030
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6452236435;
	Tue,  9 Sep 2025 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Wpx+iIFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D823E35E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404518; cv=none; b=G1kGoCg0byfPU40OuOL0E8kEuy53Up/Pj9mLQ5Hw9lwAmWY33lX7AaMmjh2BS15/CCbuamJDpSnp5Y+NdwodY5nbr14lc5e3tv9SX8ABSGCCFK6RyGOZMtXxalSL8GiPueWJ37+6uykmx5e/942bIm3CTRK8ytKX52cUHj4Xwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404518; c=relaxed/simple;
	bh=NlyQX/DsiHcnJuIAXF6bG9cuQ3pMOI7QfUs1ALbUdgI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GZeG+TWkxz3FIuuEY63MfI6R5hSKDmIbZYZVDZXRFl0wM0mLRo2K/IyDPXxIyn6a3t97Kjzdusp8ONMw36yxM60Dbynl3V7X9il6Dh1IxZJkChcjW2gGLQ/E/hDULYpBiWPfRux9HlSknn7yekE34L0ptU123QXFFaKUkfSHOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Wpx+iIFp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so2448220f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757404513; x=1758009313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJIUW/B6bBAlSl449fLp237f72bGDVB2XXvWmb7Dlu0=;
        b=Wpx+iIFpXxgkYTHAU5srBCzcGqY2sWcueYPHzmBoNfAhfOMfjFJ1Xe3jXTu8jufIAH
         LMPgRkUPl7HfXchY9Ipra8ev7LzXtr/i+2n1AELAMfr/xT2nFeb8/gXql+I7f/xNbW7z
         XuytxPToBxuU5XE1NGvQ+o+fDJmd8Wu3dbtLWtt8AqMjOfR+7R+rasfvU6xVFpSFFo1T
         kOebvEBrYEPamdXMxnC6GS+xcpPfDwZyZ+GvowblAhRtpgPmrnELePhi5HOa62WMqHHj
         O6Va90KOYzFAoe6hZwoxhsK3de0Bsi11kAyeGTulNT54VSYMoF8s3I1+PzWc4XvEJgah
         tXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404513; x=1758009313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJIUW/B6bBAlSl449fLp237f72bGDVB2XXvWmb7Dlu0=;
        b=mrSMMTxTGIj00wXotH8lGGTlJebvcuzbEaGrhYVJQHi6wbvsebaKxQkhKgKSekiY+R
         qgFvFZLaCeGuGFmKp2/jM1Btz5sOq1cjM6NIUoVtFNmCC7xKcsWnyLmfZvtguQIZSzCk
         5iQH4P2A99OSCfPPgGo4wUNbMwsWirMcJcOb9NlvjxE1EG5e+QfUfyxbNEg/LYo7VLjK
         aU4wgaasQR8v5soNKvQ3VD0TYOxYc1kZ+Hg5UOpMY2zSXJxmrCb0+vNqMqjmN5NUDwU3
         1pkUrB3mbtff8k1jpjzWttnjnAxihMMsDjsckdCZT3vrjMviyexhq0/uCWcTW+donyom
         btWA==
X-Forwarded-Encrypted: i=1; AJvYcCWNEJIGTGauVmKgG0UV9q1SOUe97vd95Zc0IhOQPbZdvOkKr5cyjGUgG5JTZZCFKEcQZO6Lt87ZjtRFzABs@vger.kernel.org
X-Gm-Message-State: AOJu0YyCpn3TWYt/ixbi0lap6zjWsFeLHvGydlqfM084XAyk7Pv2ML02
	loQpiamkh/ODyDb3RSfCQQ4fiSmPyD88ulaAYlWBEcZIvj8osn/T8mq8W4e4QiYHdgxnkHlv0Rt
	ociZX
X-Gm-Gg: ASbGnctlos6MgthND0XX4ejet9PQdgatt3TwJcHy9IE3M8C3WVn3lnaZQFJXnVW8Obg
	SJhpQaCcvs84wIuxBCi6N3rvrFaog5PsIyXZljF+RnUkCtAIc9XkNa4+XT9XcxBf3cWpRqA5Xxy
	OK/iuNes0CnVdT9Eni9YnXcWQj977GkYwolWrvq4RdIYzT63LSzP1WeCP4vtPd15FUNu7g125+B
	u41aBOeHmJRdWudQnP/pAr1OAHBOCGk384lgNu8CxRzO6BL61tH+M7BfbHO42toYMQhJI12KvXj
	m2bpEQCQTgTlxpnaqRYs6VlBjiQ/E3v5KJA4hkAcXxFVhId7PlBSE613XjxWvIwTS37fe/NNIG4
	pgnrgUeGakw6lOL15OP8KuU7iXUtEPf5icdoM7UfbxN6W37G/qS+PSj9GTZ8zaKq3xriRPrwG23
	pWh+Jj3q7tw4fy4/AfKlAY5U4=
X-Google-Smtp-Source: AGHT+IG4sby9AdCMPvTTLfJtOsnOjswT0sfnstoRYm2t4KB0Ukqf4iZMlcLigEkFw3eJlviQgaxtCg==
X-Received: by 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id ffacd0b85a97d-3e6e931f910mr5542854f8f.61.1757404513482;
        Tue, 09 Sep 2025 00:55:13 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1b3000023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1b:3000:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f5d7sm1492229f8f.53.2025.09.09.00.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:55:13 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/namespaces: make ns_entries const
Date: Tue,  9 Sep 2025 09:55:06 +0200
Message-ID: <20250909075509.810329-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global variables that are never modified should be "const" so so that
they live in the .rodata section instead of the .data section of the
kernel, gaining the protection of the kernel's strict memory
permissions as described in Documentation/security/self-protection.rst

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/proc/namespaces.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 4403a2e20c16..56e81f0273fc 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -12,7 +12,7 @@
 #include "internal.h"
 
 
-static const struct proc_ns_operations *ns_entries[] = {
+static const struct proc_ns_operations *const ns_entries[] = {
 #ifdef CONFIG_NET_NS
 	&netns_operations,
 #endif
@@ -117,7 +117,7 @@ static struct dentry *proc_ns_instantiate(struct dentry *dentry,
 static int proc_ns_dir_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct task_struct *task = get_proc_task(file_inode(file));
-	const struct proc_ns_operations **entry, **last;
+	const struct proc_ns_operations *const*entry, *const*last;
 
 	if (!task)
 		return -ENOENT;
@@ -151,7 +151,7 @@ static struct dentry *proc_ns_dir_lookup(struct inode *dir,
 				struct dentry *dentry, unsigned int flags)
 {
 	struct task_struct *task = get_proc_task(dir);
-	const struct proc_ns_operations **entry, **last;
+	const struct proc_ns_operations *const*entry, *const*last;
 	unsigned int len = dentry->d_name.len;
 	struct dentry *res = ERR_PTR(-ENOENT);
 
-- 
2.47.3


