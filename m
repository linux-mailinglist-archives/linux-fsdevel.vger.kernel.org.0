Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF02B3C46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 05:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgKPE6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 23:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgKPE6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:58:09 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF0CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2020 20:58:09 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i13so12153700pgm.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2020 20:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dbPPIUe9/FBeVVzEW0i/OcRzMX2B4SWonN1mMQZAuU=;
        b=h2Ufa6+HwrSgLE2VXLZq3d+uuiHeKA19EXYsCYl48mXWpJplC84LLgsfNJe29zcjGF
         mQ/jh5pd5JvSzFxy0ElbJPmSZfDqvHiHqTRdxOOhZZk7e1g6DI3uYHL2ZH6aos8G5vqn
         gy8VRRTyfYoQOg6YvW/LUVkZ0QanEaEIm+q/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dbPPIUe9/FBeVVzEW0i/OcRzMX2B4SWonN1mMQZAuU=;
        b=IwRHZuGBB3/onQik320ZzUwTn54Hk436TUmwBSzwBtqZxMwMirMCk0uuN1qchu2LaL
         yGq4s8cUaXd1GzDLilPtYr49anQN9mPR9YxhNVwuyKkOqs2EsO30NEeb/4ZA4CdkX9mT
         o+yInkxuommZaBwPH83K5EcrJXAyeHcuewAW/Ax+/ZiFrIfasa08yEJkCWvjHRfy79ZG
         vTXJD7/sDRAd2sKgBe/Lemh7nnHLuWs5sErmImPRdL6EVFaov1H4up3Ds/ujodOUXLqa
         uDQMDzhsVTmKn/zgnyTBbQmhhG1e6XmeolEcax3dP8JXvjz1tbkCHjdgRgP7dH9btsMK
         yaXA==
X-Gm-Message-State: AOAM532n5LXhSV/cBObqbl/O2evVyqS+SJ22wxVAdZ/2ypuL8nNdJgl6
        vu5GH4ImDuB5yPIGcY8s5MGB2A==
X-Google-Smtp-Source: ABdhPJw4LlFGxVnvoR4MPbRwL01eN2QU/vuDbFGca2/Tg5gi2b34hcW3kdWolBDNt+LdPTKAasitJg==
X-Received: by 2002:a63:d94f:: with SMTP id e15mr11521195pgj.73.1605502688716;
        Sun, 15 Nov 2020 20:58:08 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id v23sm16465284pjh.46.2020.11.15.20.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 20:58:08 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: [RFC PATCH 2/3] overlay: Add ovl_do_getxattr helper
Date:   Sun, 15 Nov 2020 20:57:57 -0800
Message-Id: <20201116045758.21774-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116045758.21774-1-sargun@sargun.me>
References: <20201116045758.21774-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We already have a helper for getting xattrs from inodes, namely
ovl_getxattr, but it doesn't allow for copying xattrs onto the current
stack. In addition, it is not instrumented like the rest of the helpers.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/overlayfs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 29bc1ec699e7..9eb911f243e1 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -179,6 +179,15 @@ static inline int ovl_do_setxattr(struct dentry *dentry, const char *name,
 	return err;
 }
 
+static inline int ovl_do_getxattr(struct dentry *dentry, const char *name,
+				  void *value, size_t size)
+{
+	int err = vfs_getxattr(dentry, name, value, size);
+	pr_debug("getxattr(%pd2, \"%s\", \"%*pE\", %zu) = %i\n",
+		 dentry, name, min((int)size, 48), value, size, err);
+	return err;
+}
+
 static inline int ovl_do_removexattr(struct dentry *dentry, const char *name)
 {
 	int err = vfs_removexattr(dentry, name);
-- 
2.25.1

