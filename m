Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD682C5E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 00:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391981AbgKZXdm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 18:33:42 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:55330 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391955AbgKZXdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:33:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 5647B180C6DDC;
        Fri, 27 Nov 2020 00:33:39 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Be9LC0iaFSmU; Fri, 27 Nov 2020 00:33:38 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OF5vAhagXaIq; Fri, 27 Nov 2020 00:33:38 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/7] fuse: Make cuse_parse_one a common helper
Date:   Fri, 27 Nov 2020 00:32:56 +0100
Message-Id: <20201126233300.10714-4-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126233300.10714-1-richard@nod.at>
References: <20201126233300.10714-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function will be used by MUSE too, let's share it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/fuse/Kconfig  |  4 +++
 fs/fuse/Makefile |  1 +
 fs/fuse/cuse.c   | 58 +--------------------------------------
 fs/fuse/fuse_i.h |  2 ++
 fs/fuse/helper.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 57 deletions(-)
 create mode 100644 fs/fuse/helper.c

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 40ce9a1c12e5..9c8cc1e7b3a5 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -18,9 +18,13 @@ config FUSE_FS
 	  If you want to develop a userspace FS, or if you want to use
 	  a filesystem based on FUSE, answer Y or M.
=20
+config FUSE_HELPER
+	def_bool n
+
 config CUSE
 	tristate "Character device in Userspace support"
 	depends on FUSE_FS
+	select FUSE_HELPER
 	help
 	  This FUSE extension allows character devices to be
 	  implemented in userspace.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 8c7021fb2cd4..7a5768cce6be 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
=20
 fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
 fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
+fuse-$(CONFIG_FUSE_HELPER) +=3D helper.o
=20
 virtiofs-y :=3D virtio_fs.o
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 45082269e698..fe8515844064 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -199,62 +199,6 @@ struct cuse_devinfo {
 	const char		*name;
 };
=20
-/**
- * cuse_parse_one - parse one key=3Dvalue pair
- * @pp: i/o parameter for the current position
- * @end: points to one past the end of the packed string
- * @keyp: out parameter for key
- * @valp: out parameter for value
- *
- * *@pp points to packed strings - "key0=3Dval0\0key1=3Dval1\0" which en=
ds
- * at @end - 1.  This function parses one pair and set *@keyp to the
- * start of the key and *@valp to the start of the value.  Note that
- * the original string is modified such that the key string is
- * terminated with '\0'.  *@pp is updated to point to the next string.
- *
- * RETURNS:
- * 1 on successful parse, 0 on EOF, -errno on failure.
- */
-static int cuse_parse_one(char **pp, char *end, char **keyp, char **valp=
)
-{
-	char *p =3D *pp;
-	char *key, *val;
-
-	while (p < end && *p =3D=3D '\0')
-		p++;
-	if (p =3D=3D end)
-		return 0;
-
-	if (end[-1] !=3D '\0') {
-		pr_err("info not properly terminated\n");
-		return -EINVAL;
-	}
-
-	key =3D val =3D p;
-	p +=3D strlen(p);
-
-	if (valp) {
-		strsep(&val, "=3D");
-		if (!val)
-			val =3D key + strlen(key);
-		key =3D strstrip(key);
-		val =3D strstrip(val);
-	} else
-		key =3D strstrip(key);
-
-	if (!strlen(key)) {
-		pr_err("zero length info key specified\n");
-		return -EINVAL;
-	}
-
-	*pp =3D p;
-	*keyp =3D key;
-	if (valp)
-		*valp =3D val;
-
-	return 1;
-}
-
 /**
  * cuse_parse_dev_info - parse device info
  * @p: device info string
@@ -275,7 +219,7 @@ static int cuse_parse_devinfo(char *p, size_t len, st=
ruct cuse_devinfo *devinfo)
 	int rc;
=20
 	while (true) {
-		rc =3D cuse_parse_one(&p, end, &key, &val);
+		rc =3D fuse_kv_parse_one(&p, end, &key, &val);
 		if (rc < 0)
 			return rc;
 		if (!rc)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d23954908610..8eba93cd8fb8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1225,5 +1225,7 @@ void fuse_dax_cancel_work(struct fuse_conn *fc);
 /* file.c */
 struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 			       struct fuse_page_desc **desc);
+/* helper.c */
+int fuse_kv_parse_one(char **pp, char *end, char **keyp, char **valp);
=20
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/helper.c b/fs/fuse/helper.c
new file mode 100644
index 000000000000..0c828daf8e8a
--- /dev/null
+++ b/fs/fuse/helper.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helper functions used by CUSE and MUSE
+ *
+ * Copyright (C) 2008-2009  SUSE Linux Products GmbH
+ * Copyright (C) 2008-2009  Tejun Heo <tj@kernel.org>
+ *
+ */
+
+#include <linux/string.h>
+#include <linux/module.h>
+
+#include "fuse_i.h"
+
+/**
+ * fuse_kv_parse_one - parse one key=3Dvalue pair
+ * @pp: i/o parameter for the current position
+ * @end: points to one past the end of the packed string
+ * @keyp: out parameter for key
+ * @valp: out parameter for value
+ *
+ * *@pp points to packed strings - "key0=3Dval0\0key1=3Dval1\0" which en=
ds
+ * at @end - 1.  This function parses one pair and set *@keyp to the
+ * start of the key and *@valp to the start of the value.  Note that
+ * the original string is modified such that the key string is
+ * terminated with '\0'.  *@pp is updated to point to the next string.
+ *
+ * RETURNS:
+ * 1 on successful parse, 0 on EOF, -errno on failure.
+ */
+int fuse_kv_parse_one(char **pp, char *end, char **keyp, char **valp)
+{
+	char *p =3D *pp;
+	char *key, *val;
+
+	while (p < end && *p =3D=3D '\0')
+		p++;
+	if (p =3D=3D end)
+		return 0;
+
+	if (end[-1] !=3D '\0') {
+		pr_err("info not properly terminated\n");
+		return -EINVAL;
+	}
+
+	key =3D val =3D p;
+	p +=3D strlen(p);
+
+	if (valp) {
+		strsep(&val, "=3D");
+		if (!val)
+			val =3D key + strlen(key);
+		key =3D strstrip(key);
+		val =3D strstrip(val);
+	} else
+		key =3D strstrip(key);
+
+	if (!strlen(key)) {
+		pr_err("zero length info key specified\n");
+		return -EINVAL;
+	}
+
+	*pp =3D p;
+	*keyp =3D key;
+	if (valp)
+		*valp =3D val;
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(fuse_kv_parse_one);
--=20
2.26.2

