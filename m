Return-Path: <linux-fsdevel+bounces-22269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C71915751
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 21:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46AB280CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215501A0710;
	Mon, 24 Jun 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FD9qguVQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEC1A01C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258069; cv=none; b=pSvKlwJpTGjvjHJm/MI/EZmcGd2j5syN8mJL6JENtM4c6zcyXeDkxVD0WyBoCekhHTEWBYHkXHyrgjSre26ij2bmhqta3m94jxqkee78PtbyrvbfQmN6acdj17ldljWuLHnNLc5ie7uPNAWJWAONyvBhcoXWCzJnkpLFeYiLEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258069; c=relaxed/simple;
	bh=uzxwDEpdZWbOlWe+EVCBC/uCl/ucKlhIkrhQYs8YMNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HehP0ObcTqzXuXjLb2AXfAuw3mq5TDyeeQOIZE/BDaqzCJJvxgRw5RLZ6GFzI5aUJLXCShGYpuANbGQqwa2tDkjis1Enodt4giFaLcKbGKJHASbsAc8io5LB0nOzVcWXS2D+jXjcfZP13TVD8ICkxxseo/AxbjfVR85nI1tTwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FD9qguVQ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7008acebf3fso2095542a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719258067; x=1719862867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKDHOAdA7jAJSq+nL+j4X9y2JU2i+CxKLmyZslQ93Zk=;
        b=FD9qguVQ/1iknMSECgLkZVSBWEE2/Ygj/T518gElzvaQ9L3qan2Sb7dw7rmFPH4SYB
         vxCTeJqDpTPiqXju2+GhCkIrNZmkBzFHVYdKvxXY1MCiK1/LkYApJ+e+8RGHwAvYP+kf
         qWzjy9FEC9hPk9LfN5uZA2tCB0i4b+hgWf437n1Og6WYOLW2ITxu5NQ1sGhunVEruBN3
         +qgMiMg8uYks7i8gE+7ufYgwTsTHEVFFYfEjfX+MQ8rkSI5Id2Xui8Kln0BHWw7R7jp2
         2Ygu5IiX042uNwPdGwwtM1RetMc1NbSU0mSLmIqumNWOZg1yLJ0bnW+85UJ5t+2WbIHx
         mZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258067; x=1719862867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKDHOAdA7jAJSq+nL+j4X9y2JU2i+CxKLmyZslQ93Zk=;
        b=syO2NOlMW7JXPWZaGIuegGn4cKrXSKrA0+OHQjHAL0Z92bbwDJVeIAwEtH1YTfFJq0
         AwL/FEiuJsskiOUKFy7mvEBr5dBHplD8ZeVHVH4tlwwfeDIRdbyLhD3qBu5uQCQ2Ka13
         HbHEX/YeWLIdP1/G0iHIY/CckUyWDzlS6PH8wDCZDB+PyhR8R8wegc0wPc4tdLKcyR9M
         Ffei8DDh4lGwKQuHPYaYBkLuK+2EFdQKIoQhcCsXmJcznFLiY9RuV4ighykeNVkjRGUq
         x/PW0z9+oUbeONG7dNh5A6hwmTX8hKFPXjE5oRKGoyh6qHADLq3f/MyEN75fhfuMsV9+
         EjWQ==
X-Gm-Message-State: AOJu0YwL0elUGfl8nEtUR03UhgHCYPC7udwfKeKSrtX9NLclm5Kxtgki
	siN45OJvDmjQY1NEWsOArbZq2pKigOadaFZ6HxkxNgvY5ETIvs/Qh4fKbEhNvh8nzeRqbMllCb4
	g
X-Google-Smtp-Source: AGHT+IFa3/tvXh8OckQVNoG+/SEBA5252iL4LtiV7YMybMMezqoS/Pe1/jTdxTmIpcRl3zQcoouiIw==
X-Received: by 2002:a05:6870:b151:b0:254:77f7:7bdd with SMTP id 586e51a60fabf-25d0198d044mr6312396fac.50.1719258066883;
        Mon, 24 Jun 2024 12:41:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce89d612sm341032685a.5.2024.06.24.12.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:41:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/4] fs: rename show_mnt_opts -> show_vfsmnt_opts
Date: Mon, 24 Jun 2024 15:40:50 -0400
Message-ID: <fb363c62ffbf78a18095d596a19b8412aa991251.1719257716.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719257716.git.josef@toxicpanda.com>
References: <cover.1719257716.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This name is more consistent with what the helper does, which is to just
show the vfsmount options.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/proc_namespace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 0a808951b7d3..e133b507ddf3 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -61,7 +61,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 	return security_sb_show_options(m, sb);
 }
 
-static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
+static void show_vfsmnt_opts(struct seq_file *m, struct vfsmount *mnt)
 {
 	static const struct proc_fs_opts mnt_opts[] = {
 		{ MNT_NOSUID, ",nosuid" },
@@ -124,7 +124,7 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
 	err = show_sb_opts(m, sb);
 	if (err)
 		goto out;
-	show_mnt_opts(m, mnt);
+	show_vfsmnt_opts(m, mnt);
 	if (sb->s_op->show_options)
 		err = sb->s_op->show_options(m, mnt_path.dentry);
 	seq_puts(m, " 0 0\n");
@@ -153,7 +153,7 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 		goto out;
 
 	seq_puts(m, mnt->mnt_flags & MNT_READONLY ? " ro" : " rw");
-	show_mnt_opts(m, mnt);
+	show_vfsmnt_opts(m, mnt);
 
 	/* Tagged fields ("foo:X" or "bar") */
 	if (IS_MNT_SHARED(r))
-- 
2.43.0


