Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86A22AA47
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfEZOeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33992 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfEZOeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id e19so5286965wme.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YNfgOrwd5oLG9pqVP9CmPHnoazZONbT1LB1KR0Zu2bE=;
        b=IWuwmV9tYKElqzqbb3C+cGStUb7HC74An2r5w1ne62mqblCgdMt5tls0T52CDZpwvi
         5Fh+Cln7w7ajkN+SFS3qO0PqrJIAd3RN8azVkHQ5uM5I6jIerpRCo/xYOO9ntSCdGVwC
         5w2kUc+lZ3E88YQq8MSZDoVspNQxFPMK92eNBTygwLyT3oCJV9++VLbieiahW7TaWNVl
         zc3DNZYEPtIo4OzJBsw4lo/Vvg6LQlRtxV9i/Hwy+arrgoYJhOI59UuCTB2k8MZu8Po4
         3A2+Z6c05E/dORed7kxbR3w5WikfUG9bEGX/8nfRG+eDuf1XbwQD0SqY+xKxFh8VfM1H
         qdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YNfgOrwd5oLG9pqVP9CmPHnoazZONbT1LB1KR0Zu2bE=;
        b=F/z4xST8FtWri0oGdLqOpl4xA1MAbpJkIEHyY9ILDNVaCEI1uaQIP3GyiGkHj3hCWs
         eAY6PkbB7PzotjNBjcQ5xGJDkg66MPvEFjy9kTQvlZJah2IsVbLgmmR+oiqtpbGg6E7p
         Z3LxVAjkq1rM/j80QkifVthcNQtUK/oQXLATynu1rQFUZrQc6OV5LGuWW+lfmTsZsIIt
         UbEBtm2vDk+PktGVCOIoFr877LCpoFxKorE4vH+ItEybPYn+o2HTddk1HKmWpCy9p4fF
         2CdUkREjl6R2m7k/8TIBF/3r0uWtYI7CwHoMoCiUN9z9by3UhK3srgoiVlv2iNFtk00b
         lFwg==
X-Gm-Message-State: APjAAAUrZf6f61ipFeIEzaoSEARfMiBCuIXezFeuYW9p7pQfImZ3v0Q8
        2j1aqS5/PbX2/+P3AkkuseI=
X-Google-Smtp-Source: APXvYqxzg7F7XpArIL8GO/uwyaPe2G7b1Ml15LI2p0Tp/cGUdJAxqhNYxbEUytnhVGvlLTgWDpgMbQ==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr22998831wmc.47.1558881274481;
        Sun, 26 May 2019 07:34:34 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:33 -0700 (PDT)
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
Subject: [PATCH v3 07/10] debugfs: call fsnotify_{unlink,rmdir}() hooks
Date:   Sun, 26 May 2019 17:34:08 +0300
Message-Id: <20190526143411.11244-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/debugfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index d89874da9791..1e444fe1f778 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -643,8 +643,11 @@ static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
 		dget(dentry);
 		if (d_is_dir(dentry)) {
 			ret = simple_rmdir(d_inode(parent), dentry);
+			if (!ret)
+				fsnotify_rmdir(d_inode(parent), dentry);
 		} else {
 			simple_unlink(d_inode(parent), dentry);
+			fsnotify_unlink(d_inode(parent), dentry);
 		}
 		if (!ret)
 			d_delete(dentry);
-- 
2.17.1

