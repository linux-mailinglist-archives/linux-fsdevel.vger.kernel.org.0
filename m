Return-Path: <linux-fsdevel+bounces-29287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33745977B21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4981C24C97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9171D5CC4;
	Fri, 13 Sep 2024 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liJPdI1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49571BC088
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216379; cv=none; b=EsuAMyVO4D2ajC9gzWnoGROqFJ/oCIYEx8XXabNMw17QigmjrViUqV9jeHPOsM1v55R0wwVI3BZ206rmwcGVRxhor+P5jxE8y6ou0LZ6Pc2or67L3VGTQKZ9J1FZxvJQOWfl0hyWHRSnjJtoTthTTnR9gHplYGAPLRL4bdf3zY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216379; c=relaxed/simple;
	bh=229q0cc/gWSY3FtIrokp9NeZqZUlwV8F0sDhghzFcN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Un1zbCsuykM6RnGXkMgi02tDIz6fG6IDUcPL58ZFX+r6OEAcrsPI+erNX89CtBxsTSiFtm1cvUiShbPoviY8+YVrIjKpc1L61jUyefrd3gl2jBb5BY+4rkb9sv0VtfqNP9pHangWzgu7hEJhxCJHsiFHphMfph5qanEOuAFf0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liJPdI1I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-205659dc63aso20178455ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726216377; x=1726821177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9QGc3cJirtaLpXDUilt3zsKOZcTUBopr1YaVlolok8=;
        b=liJPdI1IJviuzSLHLccTfEgXf2TMLspSl4pWji0tMCv63IWWqYJJorUQupV9nh6R4P
         NurMLzHRaQzqaKplx1rSeM+Ja7B0BnDoIqe78mV36m7MEicK+g5hzepP8Wb1IN5glawx
         BJJwIVSr4Wfd8duYlZkjHagVtKT4hv80fjUguBpYO5RsYBNV1K3ecLe35YFRnHFNPKr9
         S4JzaNSdmMdpSprGkel3Sse6g9eKdAnqz3A9hrjn59tSuGPydn8hta+UD1FGe5NvbUYN
         C+FquwXx7S9UcPKL87OTdByvFZpfRlIshx4Eldn2Uipe+JzfGJE+cHiFJ32l2+0D1fdg
         Z7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726216377; x=1726821177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9QGc3cJirtaLpXDUilt3zsKOZcTUBopr1YaVlolok8=;
        b=Z+RWYq0S4WggOWDZViLyqRqGGLFK3s71E1PfvONYo2GCqTXdqKp4LyBNxBoGKbrvzk
         wz9lDcCt4XqyPSCY6c/8FOy6D5YAh/3jcdsqGhZy8YttIOzJfXROYbyGsQ89rr3/RSO3
         qxD2FIA0FO2VQnSm7//S2uBpBwB6WlxMX4FXD0evTdwN5VJdE9vcvSCKWnQMCi3PuP9S
         7QhhWkxDD8B6nfJy3akgppOx2jllGAHNg8u+xTtexfkmv/xJ3ABh+jmJoAfThJH4fKky
         cGRr7DYkAsUA+iZ1TSu8dVqnMj8Vyi0E77l//PB/6OPd0bIzMb/aJ4okr0e4/Z/Ygn0Q
         FzPw==
X-Gm-Message-State: AOJu0Yy25OscwujxFjfrrZW/xegH9oh3LoFB43Lp73eedwx2KpxtsI96
	fu871D3xfuvCtSG0hGeftym+Q++exHTdma9VkFfZ7bgsvBoTb4Pb
X-Google-Smtp-Source: AGHT+IFfkHljwusuyuXQ2cmbXHBnMwcsjx3feKYjWiNWRj/xylRdLAPxwEa5Uhc5V4IFVbmaRmhRfg==
X-Received: by 2002:a17:903:22ca:b0:206:a913:96a7 with SMTP id d9443c01a7336-2076e4616e2mr85107905ad.44.1726216376999;
        Fri, 13 Sep 2024 01:32:56 -0700 (PDT)
Received: from localhost.localdomain ([39.144.107.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01a350sm24214965ad.258.2024.09.13.01.32.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:32:55 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: Add a sysctl for automated deletion of dentry
Date: Fri, 13 Sep 2024 16:32:42 +0800
Message-Id: <20240913083242.28055-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 681ce8623567 ("vfs: Delete the associated dentry when deleting a
file") introduced an unconditional deletion of the associated dentry when a
file is removed. However, this led to performance regressions in specific
benchmarks, such as ilebench.sum_operations/s [0], prompting a revert in
commit 4a4be1ad3a6e ("Revert "vfs: Delete the associated dentry when
deleting a file"").

This patch seeks to reintroduce the concept conditionally, where the
associated dentry is deleted only when the user explicitly opts for it
during file removal. A new sysctl fs.automated_deletion_of_dentry is
added for this purpose. Its default value is set to 0.

There are practical use cases for this proactive dentry reclamation.
Besides the Elasticsearch use case mentioned in commit 681ce8623567,
additional examples have surfaced in our production environment. For
instance, in video rendering services that continuously generate temporary
files, upload them to persistent storage servers, and then delete them, a
large number of negative dentries—serving no useful purpose—accumulate.
Users in such cases would benefit from proactively reclaiming these
negative dentries.

Link: https://lore.kernel.org/linux-fsdevel/202405291318.4dfbb352-oliver.sang@intel.com [0]
Link: https://lore.kernel.org/all/20240912-programm-umgibt-a1145fa73bb6@brauner/
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3d8daaecb6d1..ffd2cae2ba8d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -130,6 +130,7 @@ struct dentry_stat_t {
 static DEFINE_PER_CPU(long, nr_dentry);
 static DEFINE_PER_CPU(long, nr_dentry_unused);
 static DEFINE_PER_CPU(long, nr_dentry_negative);
+static int automated_deletion_of_dentry;
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
 /* Statistics gathering. */
@@ -194,6 +195,15 @@ static struct ctl_table fs_dcache_sysctls[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_nr_dentry,
 	},
+	{
+		.procname	= "automated_deletion_of_dentry",
+		.data		= &automated_deletion_of_dentry,
+		.maxlen		= sizeof(automated_deletion_of_dentry),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static int __init init_fs_dcache_sysctls(void)
@@ -2394,6 +2404,8 @@ void d_delete(struct dentry * dentry)
 	 * Are we the only user?
 	 */
 	if (dentry->d_lockref.count == 1) {
+		if (automated_deletion_of_dentry)
+			__d_drop(dentry);
 		dentry->d_flags &= ~DCACHE_CANT_MOUNT;
 		dentry_unlink_inode(dentry);
 	} else {
-- 
2.43.5


