Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069143FDE34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 17:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245699AbhIAPCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245659AbhIAPCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:02:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF7EC061764;
        Wed,  1 Sep 2021 08:01:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n27so7330529eja.5;
        Wed, 01 Sep 2021 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7qZZOBOIHzC8ZJeJHbBTSUHcUrgCSh8RblJOxNcc4c=;
        b=VqCKNrk63wCErHoupi4YrSdq8WOg64q7KTCaDd0lxtHfAsvWdN980u89eQf+2ssGcg
         vnNL4PiGFpmJiERq/7aBoTeS0zFREp7udBTZFM8DKvO9Ms82rrP5vGhEpoNF/eYjtpLr
         /0rxnFqa7thrw1bVw9z6JbfLqAQQgO8ZZu8F7VoIcGrJnV4oEdAAQ7ll05sWEdgjd46j
         qBkkn8uM24wBBnfHCdh7BewbJD+hEKlaU+x9hXxqkSIfaLRlCMIW0uicMPuo15Y7BZhJ
         BUsfJunIDtzR7hKEYeHSUjhLT1Pos4tCyuT2wgfbJqbhX9L7flxbsn3QpevlaH37WE5k
         bfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7qZZOBOIHzC8ZJeJHbBTSUHcUrgCSh8RblJOxNcc4c=;
        b=NldoKtwFcC1arq4DLg7iBdQe2YkxDCwgXU10rNb90yY2ZT4VrWEJARemSZypkqz5ou
         XD++3Zlf1+1rOq256HPdRax+XlU0wAJB81SDpLk+mVGbnzqXRDARMllw2BLQWNKPeMil
         4n2y/MPLlt6l5o4uIfh6I6Y6ta8jfrqU3qefQ91k1yJbUxV6+k8mYbaKFGdS/dJdi9zl
         WzyV+b/3cLShbQTP+5u2SoWaAWvuHk1qUlxmV4XO7Cko2llS5WTnKztODOzT+dsEKFZg
         yTq5emFHHqKx8ziF3ICHroq3FWzxqR3BY2de4X8TCI++suzdNsj5zgUuzCqX5ZGRpjZ+
         QzpA==
X-Gm-Message-State: AOAM532Cn+8yVy9tZMY7yjklUymg8TAcDQt/9Eans791A/aKJVHRO6qW
        VhIjavYs2sEJlGJMK83u3BsgtH6LG2YimQ==
X-Google-Smtp-Source: ABdhPJz0yA4asuWoZeF+DfYkfgZqwBDH6XQUi496szQya/s1UGU4MQWg4Z2FNKTFTsBJULaNC7DY0A==
X-Received: by 2002:a17:906:85ca:: with SMTP id i10mr38691813ejy.316.1630508497453;
        Wed, 01 Sep 2021 08:01:37 -0700 (PDT)
Received: from carbon.v ([108.61.166.58])
        by smtp.googlemail.com with ESMTPSA id kw10sm132724ejc.111.2021.09.01.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 08:01:37 -0700 (PDT)
From:   Dmitry Kadashev <dkadashev@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kadashev <dkadashev@gmail.com>
Subject: [PATCH] namei: get rid of unused filename_parentat()
Date:   Wed,  1 Sep 2021 22:00:40 +0700
Message-Id: <20210901150040.3875227-1-dkadashev@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the switch of kern_path_locked() to __filename_parentat() (to
address use after free bug) nothing is using filename_parentat(). Also,
filename_parentat() is inherently buggy: the "last" output arg
always point to freed memory.

Drop filename_parentat() and rename __filename_parentat() to
filename_parentat().

Link: https://lore.kernel.org/linux-fsdevel/YS9D4AlEsaCxLFV0@infradead.org/
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dmitry Kadashev <dkadashev@gmail.com>
---
On top of https://lore.kernel.org/linux-fsdevel/20210901001341.79887-1-stephen.s.brennan@oracle.com/

 fs/namei.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a0122f0016a3..f2af301cc79f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2514,9 +2514,10 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 	return err;
 }
 
-static int __filename_parentat(int dfd, struct filename *name,
-				unsigned int flags, struct path *parent,
-				struct qstr *last, int *type)
+/* Note: this does not consume "name" */
+static int filename_parentat(int dfd, struct filename *name,
+			     unsigned int flags, struct path *parent,
+			     struct qstr *last, int *type)
 {
 	int retval;
 	struct nameidata nd;
@@ -2538,16 +2539,6 @@ static int __filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
-static int filename_parentat(int dfd, struct filename *name,
-				unsigned int flags, struct path *parent,
-				struct qstr *last, int *type)
-{
-	int retval = __filename_parentat(dfd, name, flags, parent, last, type);
-
-	putname(name);
-	return retval;
-}
-
 /* does lookup, returns the object with parent locked */
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
@@ -2557,8 +2548,7 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 	int type, error;
 
 	filename = getname_kernel(name);
-	error = __filename_parentat(AT_FDCWD, filename, 0, path,
-				    &last, &type);
+	error = filename_parentat(AT_FDCWD, filename, 0, path, &last, &type);
 	if (error) {
 		d = ERR_PTR(error);
 		goto out;
@@ -3641,7 +3631,7 @@ static struct dentry *__filename_create(int dfd, struct filename *name,
 	 */
 	lookup_flags &= LOOKUP_REVAL;
 
-	error = __filename_parentat(dfd, name, lookup_flags, path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 
@@ -4003,7 +3993,7 @@ int do_rmdir(int dfd, struct filename *name)
 	int type;
 	unsigned int lookup_flags = 0;
 retry:
-	error = __filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
 		goto exit1;
 
@@ -4142,7 +4132,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct inode *delegated_inode = NULL;
 	unsigned int lookup_flags = 0;
 retry:
-	error = __filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
+	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (error)
 		goto exit1;
 
@@ -4690,13 +4680,13 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		target_flags = 0;
 
 retry:
-	error = __filename_parentat(olddfd, from, lookup_flags, &old_path,
-					&old_last, &old_type);
+	error = filename_parentat(olddfd, from, lookup_flags, &old_path,
+				  &old_last, &old_type);
 	if (error)
 		goto put_names;
 
-	error = __filename_parentat(newdfd, to, lookup_flags, &new_path, &new_last,
-				&new_type);
+	error = filename_parentat(newdfd, to, lookup_flags, &new_path, &new_last,
+				  &new_type);
 	if (error)
 		goto exit1;
 
-- 
2.33.0

