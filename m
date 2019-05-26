Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2F2AA46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfEZOee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42958 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfEZOee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so14324631wrb.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K62MJb0ZaY6QRlPyoVo0DCk3fPJSEXBJYKNVP8bpoVQ=;
        b=MCMueGQtOj4JgS3XMhaJacHZW58+NLOA3qQL70Uv5I2o1QaK+D9nm5A2Hogc9yhruB
         U+vj+hHHfpHsBUbXsR4r90j7fv0cgn0EXieNe64zodY3umFZM2CSPKK7H4pZoxoWjRRN
         WO6vY8r6dRSY/y5AeBo2QqPho1t+K0OLSkykrUaZ+QINnoPP7p6SS261+eYfsBs1nXdV
         ro4Ue18Wlg6YbRyTXPIwtNPdL/i0vm61CFDNlcfNOznJw06Z2DCjI+28qzcpRW6cOn2Y
         hdWQWJO+8OHj6kcilBMvipSOvHUr61EgAgX6VWEyAns4+YuA7MsdpsUS0EW3ndNQPiqF
         eU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K62MJb0ZaY6QRlPyoVo0DCk3fPJSEXBJYKNVP8bpoVQ=;
        b=VTFhv0pzcKAwgPn8I+JUR7wE4gjIOxTUnTZTn9Oh/WYJgXRCHHH2F74g3yXTvY6f6c
         zZpcqD8JbxCi0zavA6qHM8Uevg2Tw/o5zkcmPtKgaVeGEUBH9CvMADoVZz87geJQrFJD
         FftZu//G3wgjj4MuoijGJCX0GL2cKdgpZdQ7Or88rczYLzYhAPlyxfGlz0qalcN/SeWQ
         GwkmG2fisexJlyDxXKAiTY3jGTqLsWao0b+qwP0lF/Bu4XuPITCvQtgjn9pyRHGmgB+F
         YXQVWyTUJ8rR0sjxSA4h0gDILrcuSsLc/A8KOgLopYRzmuSUMUqxW0+bdDIHdzhXzrxl
         JdSg==
X-Gm-Message-State: APjAAAU2cHo2dFjWcnbZ1GV8/n3Kl32m0rod8vaErkGT7XmegWj9yuvO
        IoEUJvfeQya8TMl492LG+Tw=
X-Google-Smtp-Source: APXvYqxfocEIn9EYuYCmV+Fkh4AivmFwT5hH0YstIRHH0NZ9A1kMthDGwoU3TK6WpCL5GNHEOocBGA==
X-Received: by 2002:adf:e590:: with SMTP id l16mr1669367wrm.257.1558881272798;
        Sun, 26 May 2019 07:34:32 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:32 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/10] debugfs: simplify __debugfs_remove_file()
Date:   Sun, 26 May 2019 17:34:07 +0300
Message-Id: <20190526143411.11244-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move simple_unlink()+d_delete() from __debugfs_remove_file() into
caller __debugfs_remove() and rename helper for post remove file to
__debugfs_file_removed().

This will simplify adding fsnotify_unlink() hook.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/debugfs/inode.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index acef14ad53db..d89874da9791 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -617,13 +617,10 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
-static void __debugfs_remove_file(struct dentry *dentry, struct dentry *parent)
+static void __debugfs_file_removed(struct dentry *dentry)
 {
 	struct debugfs_fsdata *fsd;
 
-	simple_unlink(d_inode(parent), dentry);
-	d_delete(dentry);
-
 	/*
 	 * Paired with the closing smp_mb() implied by a successful
 	 * cmpxchg() in debugfs_file_get(): either
@@ -644,16 +641,15 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
 
 	if (simple_positive(dentry)) {
 		dget(dentry);
-		if (!d_is_reg(dentry)) {
-			if (d_is_dir(dentry))
-				ret = simple_rmdir(d_inode(parent), dentry);
-			else
-				simple_unlink(d_inode(parent), dentry);
-			if (!ret)
-				d_delete(dentry);
+		if (d_is_dir(dentry)) {
+			ret = simple_rmdir(d_inode(parent), dentry);
 		} else {
-			__debugfs_remove_file(dentry, parent);
+			simple_unlink(d_inode(parent), dentry);
 		}
+		if (!ret)
+			d_delete(dentry);
+		if (d_is_reg(dentry))
+			__debugfs_file_removed(dentry);
 		dput(dentry);
 	}
 	return ret;
-- 
2.17.1

