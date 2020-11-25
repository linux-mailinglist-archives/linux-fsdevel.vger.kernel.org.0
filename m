Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293982C3E61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgKYKqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 05:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgKYKqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:46:36 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6213C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 02:46:28 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t21so2121759pgl.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 02:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=363/J7FI+YxpDHZBVwKbULZE4SMrK80CjI/t3VX+JKo=;
        b=fxIgajKiDWtAbFKmA3ChnnZel9/bUEXRQluPqmTZssZjHzYAWwnaTFxS6bz2LB/9DB
         M3OT102AMcKTOr0V3oG4umBMTSy7f+fmIVQiiqIBeRjmG+vvLUwPTs3gv/jb6ixZ1ZaN
         9ZpeObKTOMZE5AHNDNCubXgPWTulcCFYhDZJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=363/J7FI+YxpDHZBVwKbULZE4SMrK80CjI/t3VX+JKo=;
        b=lXhk63TSoN+LrG+Tkg5rhtkDYk02pKonGgzUVKM5JkyMA5NXfwLdQ5riP1toT87BBl
         RnMH9cHOhInApFT09B5J/bRHNjLzbx6rMpdY85mZ9wWTrX71ivNKo4jhbLX6ED/Q8o+N
         KoCJgJ9QuODaEhqmCBtz64EFzSfcFi0wfPZesx10APlx1tTZdJ64RmnRgfZeMxwnjKby
         fyrHLAzAqNaCj+5gF2wFb/2m9Y70G2FKHJVXaeUyiSb7ehK7tzKv/o0wLv3G0Y2xLEtb
         4xmXeXbcA7auKDNl2/WncWxTYLf6uqEMvPIZ4i8Wh3xxFoXY9IOz766q5qiI9I7YFLeW
         LvVQ==
X-Gm-Message-State: AOAM53053KMW1zifwyBF0qx82DD4/vRICCdVBDd+cDrLchnbUheONcJS
        ulovWzLmiFeN4j5ZqWexCOZsTEx655AKXw==
X-Google-Smtp-Source: ABdhPJzF6UI4mdO7JB5wbsCZIKs6GFhhCdd9AqCdL0bxV7wvlXtGJS4Kdn9dxAfhnxDk4zINn+WimA==
X-Received: by 2002:a17:90b:4398:: with SMTP id in24mr3341952pjb.188.1606301188310;
        Wed, 25 Nov 2020 02:46:28 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id p15sm2408252pjg.21.2020.11.25.02.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 02:46:27 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v1 1/3] fs: Add s_instance_id field to superblock for unique identification
Date:   Wed, 25 Nov 2020 02:46:19 -0800
Message-Id: <20201125104621.18838-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125104621.18838-1-sargun@sargun.me>
References: <20201125104621.18838-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This assigns a per-boot unique number to each superblock. This allows
other components to know whether a filesystem has been remounted
since they last interacted with it.

At every boot it is reset to 0. There is no specific reason it is set to 0,
other than repeatability versus using some random starting number. Because
of this, you must store it along some other piece of data which is
initialized at boot time.

This doesn't have any of the overhead of idr, and a u64 wont wrap any time
soon. There is no forward lookup requirement, so an idr is not needed.

In the future, we may want to expose this to userspace. Userspace programs
can benefit from this if they have large chunks of dirty or mmaped memory
that they're interacting with, and they want to see if that volume has been
unmounted, and remounted. Along with this, and a mechanism to inspect the
superblock's errseq a user can determine whether they need to throw away
their cache or similar. This is another benefit in comparison to just
using a pointer to the superblock to uniquely identify it.

Although this doesn't expose an ioctl or similar yet, in the future we
could add an ioctl that allows for fetching the s_instance_id for a given
cache, and inspection of the errseq associated with that.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
---
 fs/super.c         | 3 +++
 include/linux/fs.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 904459b35119..e47ace7f8c3d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -42,6 +42,7 @@
 
 static int thaw_super_locked(struct super_block *sb);
 
+static u64 s_instance_id_counter;
 static LIST_HEAD(super_blocks);
 static DEFINE_SPINLOCK(sb_lock);
 
@@ -546,6 +547,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	s->s_iflags |= fc->s_iflags;
 	strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
+	s->s_instance_id = s_instance_id_counter++;
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(s->s_type);
@@ -625,6 +627,7 @@ struct super_block *sget(struct file_system_type *type,
 	s->s_type = type;
 	strlcpy(s->s_id, type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
+	s->s_instance_id = s_instance_id_counter++;
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..09bf54382a54 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1472,6 +1472,13 @@ struct super_block {
 	char			s_id[32];	/* Informational name */
 	uuid_t			s_uuid;		/* UUID */
 
+	/*
+	 * ID identifying this particular instance of the superblock. It can
+	 * be used to determine if a particular filesystem has been remounted.
+	 * It may be exposed to userspace.
+	 */
+	u64			s_instance_id;
+
 	unsigned int		s_max_links;
 	fmode_t			s_mode;
 
-- 
2.25.1

