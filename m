Return-Path: <linux-fsdevel+bounces-53837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D1FAF80C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4021888ED1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E02F7CF9;
	Thu,  3 Jul 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGoKcBuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9332F6FA9;
	Thu,  3 Jul 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568688; cv=none; b=pmgeQxPkiBWJconuyUP+Os2xlTRwfbLrYurCaM33tYmhaOdhBUtws6qQ4b3YdloHcqcMdDDVSzYmmhnAfizOcioXPllz2+m3FdadY5WoJKPi7U6BolkCPQnPImdlmuKshnGnfYkZf7BHRZ4EtFB69dcvVoqpJQhywoU1ZtSA2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568688; c=relaxed/simple;
	bh=akSaRL3RX+WvtwUWvfOzwjDiTkfVYFgkfRs13hWFzFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjZTjdxVcHo3xSpv9oLo+ihvYgac7MSHRkkZzTpY9OFjuvpakn+iR6qDUHwKTaD+pmgjIRBxsWVkl9FWbO0d7Sk1jXzbhxMCVw38a83jLZZyGqQ7zwXOQ9k51MtB3i3sUbjzAQUpYMK621V1WdsqyrrkEEZWOUArPVXYVH2pyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGoKcBuw; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-735a6d7c5b1so152891a34.2;
        Thu, 03 Jul 2025 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568685; x=1752173485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSYWWRwywlLa7gF9aEQucwjgFx3QvAjkIfteydqpUEU=;
        b=lGoKcBuwMCU9WzhyKjIAIrleojLKbkL1FO5UnqQdYdYqkDCst1fppbLcoe0n/qqhID
         xHJw7OGttbS7iU90Pz0yXbqkMAZutoa3zbHfu6eAKqypoQP1bFlkGEtpMHoPlKR0X1t+
         ZpLdHanD7IkaL+b4dygij3cgd4gIS4nm44uF4IQQILk8YCWQQ0WkKPyONz1lFaWrNoZJ
         V7T45yfITTBPWpAp46H0DK/mAoMDzVZ3nSpkkTBL8zgFgjj797Nn5tv+s6wAuxeBnCg7
         +yDD6cpVM7lZQp3l8ZB0dcc51pWwRlyXcUUF0JT2GT3q+impbVbN2+m9G21pHPmhDiSZ
         pCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568685; x=1752173485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CSYWWRwywlLa7gF9aEQucwjgFx3QvAjkIfteydqpUEU=;
        b=ZD0uLeOy0QW+IkK1k109W/5ob3BFGqyMRU7sO7uzv9UYQau2xmDmIfdO6W909Lc0WA
         PktjiqHjurcGWvwZJkfPSmfIU0AXr+UNr7xp+n3Ow4s6WMVuWFdK8Z3n+apWoUgIBlJ8
         alNm4rpsBWi+aAkPOFb/TCkVce8PgZRFqLDCLkT0O1/HVpDe0GDMl6DZfsm1UaO74+WJ
         pR3ER+j0p6JelIUni4wgspn5tKAAIgW8de6fJp/ogdRdi0zRuD/s5d1Hdj717DLkPPwX
         3RCRNKIuU0I4WKnp0Nwuxp2jVE5tlglRngs3rdv4QHWQti1QU8b3tPQjylIXa1aN9xoM
         N1hg==
X-Forwarded-Encrypted: i=1; AJvYcCUmLaciwwXxSv4pDQxd05gMdC2gzGDMyhU7M/EmpHcEt1Wqd8klx7J64BkhhXAMfwzmd32KNFMl8D8cY6TW@vger.kernel.org, AJvYcCVQJ5ykixr6ReG/cRRe2h4C9SwMtOV2wKYu+4H6FJayzQAcHUTf1zdYoS2uuAHqdMZxjTmWtH/S+7WJ@vger.kernel.org, AJvYcCVqg4rBI1AEt3D7cr7iXiJQaK5iLXftisWidnGNZic5ertI0bwGoOYTOQFjBHUE9db1Wy0uwds6u80=@vger.kernel.org, AJvYcCWrEVjW9eHw1VES5SqHxPA8riNIpA0DTY3mY5Z6H3FYvE60ZO2FqhyWZbSs3aqMLUyjJhNN/LRgwRJZulXCtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrw8Qs8gN3llLBWnVzUvw0X4vWcoM9bTeK9zBrKWMWwAH9b5jR
	I/iBnjNLN+hKPp2wP9I6OVYeukmdPRZntncGpyuU42fjcmGgjdbqa6RX
X-Gm-Gg: ASbGncsFxo+eGBWKjgRgVqj3Prj8f8K8WcJ2mtwDRSwKOvia4zSoZa7la175HL6iRUY
	YtRgNHUj9plAdn6wPIdYpYUofMaVNTloknkV0WWUVSgyl9rrSJr05O+ESEEQ3pTYCsjjZ4spE8s
	qZmPCdQWGTF1toyMAe1Jtin0tMkvhQQ+b9VhbPoSWZ+Vp5hnaF2T92pqijy8spznHWqnI2euiEp
	Obj1HduOwk406lqGytmdrzob2PVJ5lpSfCDxz0LeJFPJHhgU/OmUrzqPnNuTYc1kkJrf4klk8Pn
	y3IZZQNhhZRK82BGc7qlFkDM808YUJlNDiD4pnHKdVEXkmR8MPJQWdX0ikUtUYHOyU4BUJ4tdpj
	LJllxpKXXMygOwA==
X-Google-Smtp-Source: AGHT+IFxF3BaEfdAPQz8g2KUep0eOXOM/aFDkALhw9dVTss75dxJINqAI1lP3b72xWIrM5//XNirxA==
X-Received: by 2002:a05:6830:8104:b0:72b:93c9:41a6 with SMTP id 46e09a7af769-73c8c540f40mr2455436a34.20.1751568685472;
        Thu, 03 Jul 2025 11:51:25 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:25 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Date: Thu,  3 Jul 2025 13:50:28 -0500
Message-Id: <20250703185032.46568-15-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* The new GET_DAXDEV message/response is enabled
* The command it triggered by the update_daxdev_table() call, if there
  are any daxdevs in the subject fmap that are not represented in the
  daxdev_dable yet.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/famfs.c           | 227 ++++++++++++++++++++++++++++++++++++++
 fs/fuse/famfs_kfmap.h     |  26 +++++
 fs/fuse/fuse_i.h          |   1 +
 fs/fuse/inode.c           |   4 +-
 fs/namei.c                |   1 +
 include/uapi/linux/fuse.h |  18 +++
 6 files changed, 276 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index 41c4d92f1451..f5e01032b825 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -20,6 +20,230 @@
 #include "famfs_kfmap.h"
 #include "fuse_i.h"
 
+/*
+ * famfs_teardown()
+ *
+ * Deallocate famfs metadata for a fuse_conn
+ */
+void /* XXX valid xfs or fuse format? */
+famfs_teardown(struct fuse_conn *fc)
+{
+	struct famfs_dax_devlist *devlist = fc->dax_devlist;
+	int i;
+
+	fc->dax_devlist = NULL;
+
+	if (!devlist)
+		return;
+
+	if (!devlist->devlist)
+		goto out;
+
+	/* Close & release all the daxdevs in our table */
+	for (i = 0; i < devlist->nslots; i++) {
+		if (devlist->devlist[i].valid && devlist->devlist[i].devp)
+			fs_put_dax(devlist->devlist[i].devp, fc);
+	}
+	kfree(devlist->devlist);
+
+out:
+	kfree(devlist);
+}
+
+static int
+famfs_verify_daxdev(const char *pathname, dev_t *devno)
+{
+	struct inode *inode;
+	struct path path;
+	int err;
+
+	if (!pathname || !*pathname)
+		return -EINVAL;
+
+	err = kern_path(pathname, LOOKUP_FOLLOW, &path);
+	if (err)
+		return err;
+
+	inode = d_backing_inode(path.dentry);
+	if (!S_ISCHR(inode->i_mode)) {
+		err = -EINVAL;
+		goto out_path_put;
+	}
+
+	if (!may_open_dev(&path)) { /* had to export this */
+		err = -EACCES;
+		goto out_path_put;
+	}
+
+	*devno = inode->i_rdev;
+
+out_path_put:
+	path_put(&path);
+	return err;
+}
+
+/**
+ * famfs_fuse_get_daxdev() - Retrieve info for a DAX device from fuse server
+ *
+ * Send a GET_DAXDEV message to the fuse server to retrieve info on a
+ * dax device.
+ *
+ * @fm:     fuse_mount
+ * @index:  the index of the dax device; daxdevs are referred to by index
+ *          in fmaps, and the server resolves the index to a particular daxdev
+ *
+ * Returns: 0=success
+ *          -errno=failure
+ */
+static int
+famfs_fuse_get_daxdev(struct fuse_mount *fm, const u64 index)
+{
+	struct fuse_daxdev_out daxdev_out = { 0 };
+	struct fuse_conn *fc = fm->fc;
+	struct famfs_daxdev *daxdev;
+	int err = 0;
+
+	FUSE_ARGS(args);
+
+	/* Store the daxdev in our table */
+	if (index >= fc->dax_devlist->nslots) {
+		pr_err("%s: index(%lld) > nslots(%d)\n",
+		       __func__, index, fc->dax_devlist->nslots);
+		err = -EINVAL;
+		goto out;
+	}
+
+	args.opcode = FUSE_GET_DAXDEV;
+	args.nodeid = index;
+
+	args.in_numargs = 0;
+
+	args.out_numargs = 1;
+	args.out_args[0].size = sizeof(daxdev_out);
+	args.out_args[0].value = &daxdev_out;
+
+	/* Send GET_DAXDEV command */
+	err = fuse_simple_request(fm, &args);
+	if (err) {
+		pr_err("%s: err=%d from fuse_simple_request()\n",
+		       __func__, err);
+		/*
+		 * Error will be that the payload is smaller than FMAP_BUFSIZE,
+		 * which is the max we can handle. Empty payload handled below.
+		 */
+		goto out;
+	}
+
+	down_write(&fc->famfs_devlist_sem);
+
+	daxdev = &fc->dax_devlist->devlist[index];
+
+	/* Abort if daxdev is now valid */
+	if (daxdev->valid) {
+		up_write(&fc->famfs_devlist_sem);
+		/* We already have a valid entry at this index */
+		err = -EALREADY;
+		goto out;
+	}
+
+	/* Verify that the dev is valid and can be opened and gets the devno */
+	err = famfs_verify_daxdev(daxdev_out.name, &daxdev->devno);
+	if (err) {
+		up_write(&fc->famfs_devlist_sem);
+		pr_err("%s: err=%d from famfs_verify_daxdev()\n", __func__, err);
+		goto out;
+	}
+
+	/* This will fail if it's not a dax device */
+	daxdev->devp = dax_dev_get(daxdev->devno);
+	if (!daxdev->devp) {
+		up_write(&fc->famfs_devlist_sem);
+		pr_warn("%s: device %s not found or not dax\n",
+			__func__, daxdev_out.name);
+		err = -ENODEV;
+		goto out;
+	}
+
+	daxdev->name = kstrdup(daxdev_out.name, GFP_KERNEL);
+	wmb(); /* all daxdev fields must be visible before marking it valid */
+	daxdev->valid = 1;
+
+	up_write(&fc->famfs_devlist_sem);
+
+out:
+	return err;
+}
+
+/**
+ * famfs_update_daxdev_table() - Update the daxdev table
+ * @fm   - fuse_mount
+ * @meta - famfs_file_meta, in-memory format, built from a GET_FMAP response
+ *
+ * This function is called for each new file fmap, to verify whether all
+ * referenced daxdevs are already known (i.e. in the table). Any daxdev
+ * indices that referenced in @meta but not in the table will be retrieved via
+ * famfs_fuse_get_daxdev() and added to the table
+ *
+ * Return: 0=success
+ *         -errno=failure
+ */
+static int
+famfs_update_daxdev_table(
+	struct fuse_mount *fm,
+	const struct famfs_file_meta *meta)
+{
+	struct famfs_dax_devlist *local_devlist;
+	struct fuse_conn *fc = fm->fc;
+	int err;
+	int i;
+
+	/* First time through we will need to allocate the dax_devlist */
+	if (!fc->dax_devlist) {
+		local_devlist = kcalloc(1, sizeof(*fc->dax_devlist), GFP_KERNEL);
+		if (!local_devlist)
+			return -ENOMEM;
+
+		local_devlist->nslots = MAX_DAXDEVS;
+
+		local_devlist->devlist = kcalloc(MAX_DAXDEVS,
+						 sizeof(struct famfs_daxdev),
+						 GFP_KERNEL);
+		if (!local_devlist->devlist) {
+			kfree(local_devlist);
+			return -ENOMEM;
+		}
+
+		/* We don't need the famfs_devlist_sem here because we use cmpxchg... */
+		if (cmpxchg(&fc->dax_devlist, NULL, local_devlist) != NULL) {
+			kfree(local_devlist->devlist);
+			kfree(local_devlist); /* another thread beat us to it */
+		}
+	}
+
+	down_read(&fc->famfs_devlist_sem);
+	for (i = 0; i < fc->dax_devlist->nslots; i++) {
+		if (meta->dev_bitmap & (1ULL << i)) {
+			/* This file meta struct references devindex i
+			 * if devindex i isn't in the table; get it...
+			 */
+			if (!(fc->dax_devlist->devlist[i].valid)) {
+				up_read(&fc->famfs_devlist_sem);
+
+				err = famfs_fuse_get_daxdev(fm, i);
+				if (err)
+					pr_err("%s: failed to get daxdev=%d\n",
+					       __func__, i);
+
+				down_read(&fc->famfs_devlist_sem);
+			}
+		}
+	}
+	up_read(&fc->famfs_devlist_sem);
+
+	return 0;
+}
+
+/***************************************************************************/
 
 void
 __famfs_meta_free(void *famfs_meta)
@@ -336,6 +560,9 @@ famfs_file_init_dax(
 	if (rc)
 		goto errout;
 
+	/* Make sure this fmap doesn't reference any unknown daxdevs */
+	famfs_update_daxdev_table(fm, meta);
+
 	/* Publish the famfs metadata on fi->famfs_meta */
 	inode_lock(inode);
 	if (fi->famfs_meta) {
diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
index ce785d76719c..f79707b9f761 100644
--- a/fs/fuse/famfs_kfmap.h
+++ b/fs/fuse/famfs_kfmap.h
@@ -60,4 +60,30 @@ struct famfs_file_meta {
 	};
 };
 
+/**
+ * famfs_daxdev - tracking struct for a daxdev within a famfs file system
+ *
+ * This is the in-memory daxdev metadata that is populated by
+ * the responses to GET_FMAP messages
+ */
+struct famfs_daxdev {
+	/* Include dev uuid? */
+	bool valid;
+	bool error;
+	dev_t devno;
+	struct dax_device *devp;
+	char *name;
+};
+
+#define MAX_DAXDEVS 24
+
+/**
+ * famfs_dax_devlist - list of famfs_daxdev's
+ */
+struct famfs_dax_devlist {
+	int nslots;
+	int ndevs;
+	struct famfs_daxdev *devlist; /* XXX: make this an xarray! */
+};
+
 #endif /* FAMFS_KFMAP_H */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fb6095655403..37298551539c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1565,6 +1565,7 @@ int famfs_file_init_dax(struct fuse_mount *fm,
 			     struct inode *inode, void *fmap_buf,
 			     size_t fmap_size);
 void __famfs_meta_free(void *map);
+void famfs_teardown(struct fuse_conn *fc);
 #endif
 
 static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1682755abf30..c29e9d96ea92 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1049,8 +1049,10 @@ void fuse_conn_put(struct fuse_conn *fc)
 		}
 		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 			fuse_backing_files_free(fc);
-		if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+		if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)) {
 			kfree(fc->shadow);
+			famfs_teardown(fc);
+		}
 		call_rcu(&fc->rcu, delayed_release);
 	}
 }
diff --git a/fs/namei.c b/fs/namei.c
index ecb7b95c2ca3..75a1e1d46593 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3380,6 +3380,7 @@ bool may_open_dev(const struct path *path)
 	return !(path->mnt->mnt_flags & MNT_NODEV) &&
 		!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
 }
+EXPORT_SYMBOL(may_open_dev);
 
 static int may_open(struct mnt_idmap *idmap, const struct path *path,
 		    int acc_mode, int flag)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index ecaaa62910f0..8a81b6c334fe 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -235,6 +235,9 @@
  *      - struct fuse_famfs_simple_ext
  *      - struct fuse_famfs_iext
  *      - struct fuse_famfs_fmap_header
+ *    - Add the following structs for the GET_DAXDEV message and reply
+ *      - struct fuse_get_daxdev_in
+ *      - struct fuse_get_daxdev_out
  *    - Add the following enumerated types
  *      - enum fuse_famfs_file_type
  *      - enum famfs_ext_type
@@ -1351,6 +1354,20 @@ struct fuse_famfs_fmap_header {
 	uint64_t reserved1;
 };
 
+struct fuse_get_daxdev_in {
+	uint32_t        daxdev_num;
+};
+
+#define DAXDEV_NAME_MAX 256
+struct fuse_daxdev_out {
+	uint16_t index;
+	uint16_t reserved;
+	uint32_t reserved2;
+	uint64_t reserved3; /* enough space for a uuid if we need it */
+	uint64_t reserved4;
+	char name[DAXDEV_NAME_MAX];
+};
+
 static inline int32_t fmap_msg_min_size(void)
 {
 	/* Smallest fmap message is a header plus one simple extent */
@@ -1358,4 +1375,5 @@ static inline int32_t fmap_msg_min_size(void)
 		+ sizeof(struct fuse_famfs_simple_ext));
 }
 
+
 #endif /* _LINUX_FUSE_H */
-- 
2.49.0


