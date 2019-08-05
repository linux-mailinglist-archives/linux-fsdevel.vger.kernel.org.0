Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066A282119
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfHEQDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:03:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40891 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfHEQDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:03:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so39873180pfp.7;
        Mon, 05 Aug 2019 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uf5Kyvl6R4lvAs7V00xNhAh6oE9OoqQ2lgWGLPKa4ak=;
        b=N7oQ2Fn2fvq2ydxLF1VKczaQ5uUjRaOuqMtZ6/QWeyh41ouymsleO6JjMZQ2q7Nr1W
         UyA78UP+MMsAwnnjsv21+XJkkefs9BgeSZhkSbo+Y3tl1VO/R/YtO9IcVZP/h5fDcdKD
         hUBoy2dT55bow0DfAeI4gGx2cmVGXeysRyA8XuNnjcNMlg4SKkq3GP6Cy/UW0uGXnSLd
         c9oVC785Crw82Gd90ecSV1B/jasl4o+smnQhv+Nb7RXikO7ImFMLW3KxTcaYvIu+6rnM
         aCgsxqi8TI/8/AISjgJfzV01QbaSRz4rzb8gyqO+sTqcQBTQjftuTeFPJHTpwB9hKGLR
         KUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uf5Kyvl6R4lvAs7V00xNhAh6oE9OoqQ2lgWGLPKa4ak=;
        b=Js17GEynUlmF1U4lx7IRFL6HeJ3CMHPtLrf5Au8+Tbs3C3k2KUCMg/qBiaAVSrRz22
         YvzklVcYBu49cZU/I0lMXjhgW53DjRUUrj1GzN5cmvC2vHpvFhkfcklart4AvPmnydvx
         qLhtBJHG6+qqXQggS6UKVPJK3qEKjsuiUpf1gwrxUdAdQF6MOGjflId3F9OZ0w7yr0PS
         DejjbDt78sZRfNHfptp7AZTf1s3euh4vSp/ETV06gWa/83cwzFJZzQgV3NCZeyJKto8K
         HLN+YC7CJoiZoBz2IC4DXjVuB9QUMtfL/Q36C51KrBmyTPuI+HvlFcPUNDjL/u2ZdbUV
         UJug==
X-Gm-Message-State: APjAAAUcn4POOa//sKNyo97s8I8Qz7wLtZtOtDUFiFFXABaGfctgNduy
        MnOSubrEIkjbrFS2LXYbYF0=
X-Google-Smtp-Source: APXvYqzmK66clykxtZ78Ka6IqlAt4/WQeHtxxjbA/5hlZMyFLmWILOUpzY50fw+Q9jF2knizmG/7EA==
X-Received: by 2002:a17:90a:6546:: with SMTP id f6mr18661240pjs.11.1565021012059;
        Mon, 05 Aug 2019 09:03:32 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n98sm17061262pjc.26.2019.08.05.09.03.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 09:03:31 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2 2/3] i915: convert to new mount API
Date:   Tue,  6 Aug 2019 01:03:06 +0900
Message-Id: <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tmpfs does not set ->remount_fs() anymore and its users need
to be converted to new mount API.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 PF: supervisor instruction fetch in kernel mode
 PF: error_code(0x0010) - not-present page
 RIP: 0010:0x0
 Code: Bad RIP value.
 Call Trace:
  i915_gemfs_init+0x6e/0xa0 [i915]
  i915_gem_init_early+0x76/0x90 [i915]
  i915_driver_probe+0x30a/0x1640 [i915]
  ? kernfs_activate+0x5a/0x80
  ? kernfs_add_one+0xdd/0x130
  pci_device_probe+0x9e/0x110
  really_probe+0xce/0x230
  driver_probe_device+0x4b/0xc0
  device_driver_attach+0x4e/0x60
  __driver_attach+0x47/0xb0
  ? device_driver_attach+0x60/0x60
  bus_for_each_dev+0x61/0x90
  bus_add_driver+0x167/0x1b0
  driver_register+0x67/0xaa

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
---
 drivers/gpu/drm/i915/gem/i915_gemfs.c | 32 +++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
index 099f3397aada..feedc9242072 100644
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -7,14 +7,17 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
+#include <linux/fs_context.h>
 
 #include "i915_drv.h"
 #include "i915_gemfs.h"
 
 int i915_gemfs_init(struct drm_i915_private *i915)
 {
+	struct fs_context *fc = NULL;
 	struct file_system_type *type;
 	struct vfsmount *gemfs;
+	bool ok = true;
 
 	type = get_fs_type("tmpfs");
 	if (!type)
@@ -36,18 +39,29 @@ int i915_gemfs_init(struct drm_i915_private *i915)
 		struct super_block *sb = gemfs->mnt_sb;
 		/* FIXME: Disabled until we get W/A for read BW issue. */
 		char options[] = "huge=never";
-		int flags = 0;
-		int err;
-
-		err = sb->s_op->remount_fs(sb, &flags, options);
-		if (err) {
-			kern_unmount(gemfs);
-			return err;
-		}
+
+		ok = false;
+		fc = fs_context_for_reconfigure(sb->s_root, 0, 0);
+		if (IS_ERR(fc))
+			goto out;
+
+		if (!fc->ops->parse_monolithic ||
+				fc->ops->parse_monolithic(fc, options))
+			goto out;
+
+		if (fc->ops->reconfigure && !fc->ops->reconfigure(fc))
+			ok = true;
 	}
 
+out:
+	if (!ok)
+		dev_err(i915->drm.dev,
+			"Unable to reconfigure %s. %s\n",
+			"shmemfs for preferred allocation strategy",
+			"Continuing, but performance may suffer");
+	if (!IS_ERR_OR_NULL(fc))
+		put_fs_context(fc);
 	i915->mm.gemfs = gemfs;
-
 	return 0;
 }
 
-- 
2.22.0

