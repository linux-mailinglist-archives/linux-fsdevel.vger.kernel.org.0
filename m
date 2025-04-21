Return-Path: <linux-fsdevel+bounces-46755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7AA94A59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A29B188689C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEB91C6FE0;
	Mon, 21 Apr 2025 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1Smidfi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A81D1A2C06;
	Mon, 21 Apr 2025 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199270; cv=none; b=qBhSi/cxj5JpvKwfoCCC7BUorrkKRTi/TG+fHYMLGBtFtOXn0ovia8RxTUQa0qME56Oom7yuqvkKipKC9r0lG22bheansgJnMKUPe466955efgyPVBTWTPvRJ3B3i6rksKnF+mIcweoFMyg1oarxdr9FitC2gV146n+VogTAN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199270; c=relaxed/simple;
	bh=hS9bzYfAqAxrTx0CKZe+FDkhAKFDz+WpXq24E9q0oXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gS8oU6S7wKuH+be42wdTnn+P4hj60Q0MjFRyBm6IAb0Fi2Q9SbKKxWBhNEp80hXZBg1EyKPZ/3iLMV9anXUWfwILmhUy0chbSk4T0VwM3Yhn+Mqu5XgjgyyV9j0HkSyRrYcOEw18fW/YE4H7IVWwX0Z7PhnTdmX5nE0dAUFU+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1Smidfi; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c2504fa876so912326fac.0;
        Sun, 20 Apr 2025 18:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199267; x=1745804067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jlW0o3VSdWrbOaw+r3nQgVEXzp70rzZbAdQEvNAOUs=;
        b=L1SmidfixXlr0jmS7NNvLFQWgQuz+mfiDA/yyPadyJOS2r2yTcH7vWoEp9NaopPfQs
         83Lhm+pZYlKzudOfUqJYPg2S8xPVo7MEn4ICF50z45hJCbs/hPojgDF8R8BRacqRmcrz
         XQSmCt1Ac+gZ42Pw4OBWjAn/D4w2q7e0sCvtpUw9eeGnsfomLXa9EGSUoRotynwVtZI9
         gdfS3bJSYrl5+VfsDTGe2V3GTg5/IbNhy2cfVo1f/GCkt87+T+o91OtdI0YkTYRCrk2g
         0zmjwuABb9KvNQJNtLvbAp0pIfyTZE6nVMdHtB+6143f9SSiolzIkJcK3rlQ/1SDLAX4
         WflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199267; x=1745804067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jlW0o3VSdWrbOaw+r3nQgVEXzp70rzZbAdQEvNAOUs=;
        b=qhK7tEj1blL4RoIddc0vaa5WQKIZgGrVz4q2Y5R3zGzrcz+Sl/Ma7wzwO7yrfe8mlw
         WoVOxiz27sH7Vx4+NYW9bVX/74rh8oIEBlTiszIPmuG6h7ZWLu8l0vEQNfDGxl21GSCP
         uuHtQIZUw8/gyNAf/c6PL2FrUFh48d9oFSEBRPIoUFzmG7YOa5QcMuuxa/mO7eOL8Cyh
         lddNChiMl84zDYtfY7GLv2akhIb5fgKiRN5RxdNn3QdkMjBxBTLUYFpi9kivjlMmKoDX
         7xjAD2HgvwSKDKGbRftpIbYjWKtuHFGM7AE9/g7myi44XadM9xcC//ylZTpBFbZyYfqL
         V33w==
X-Forwarded-Encrypted: i=1; AJvYcCVBgUJRMKfGMbY4QJkBcea57g1cZ27fCuqILF7KRDLRD7VH9aca9vN20srkxYW6i2c8sUM6quhuzFjLCHFCfw==@vger.kernel.org, AJvYcCW2YxpR5pwPpLnI3Sg8oPyL1X2Bh82kmDBiSnn7aWvwOBntkeWOQxSYzBbpUyqvq85i7chTVhOKGyHwDwfU@vger.kernel.org, AJvYcCX0ijQSPix8/mOa+0+U7i/1brzjxw6CFLiJS0c31hdV6PMJiIIeZJyGjey4YBwsNWVTR7HFMGytAM6s@vger.kernel.org, AJvYcCXg1sOa/z6qq81fuxPGOlHEyR+E86yyfDi2QRVSClNWbOmLXf3CmW9vdSUfoU2Q+ZJRqvGW10GojsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKsJwlJhiOPgJjsIUvYTsvi3jMa3C6LszTXqExEgqPMsOfRqx
	fDh0cK/99XLNrncm3/OP7yq4prfxHsbTGOH+2AfDbhdBpW3jI2u1
X-Gm-Gg: ASbGncvSO2dtT37GDZRquf+jARuJvwJU6su7gNyiq68evDg7OvE7ZFB0Zs2AcsX2fzp
	iZTFyUU3A5rNp9vwtoKlX1ewNUaNuEUTIil38wbBiSFteF0wxfR7oew7zt6qC5X0X4y1CRN8Qbv
	DfVFnz3hZOtkwlFHWzzQyKA0QYBDZD2jMsqjiBZJ3tXoan0/bPEm9shbNkKfhydRagCSVM2Aa0P
	1sVDkGQLXVNxmBIkraSfm4M98J4Dy4y9vfGeoyEXMz5B30mgR57i1YvHhs53IyaLvgTN7jT9jcc
	7gjTw6zfKSkjDhFyKFvT1eEBWrW/ZljhlLOoRp9Hdc4ZbxjF3KuSmca5TYZKQ8+L4d0TBA==
X-Google-Smtp-Source: AGHT+IF+9XYJIqWLgWlGUpPhWJ2tjvUozsrrXpH8oCW29Y/FQldm3qVZQBAnxt74Itja45OzzhFhaw==
X-Received: by 2002:a05:6871:bd07:b0:2d5:4fd4:a1a9 with SMTP id 586e51a60fabf-2d54fd4b0a3mr3864201fac.6.1745199267484;
        Sun, 20 Apr 2025 18:34:27 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:27 -0700 (PDT)
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
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>,
	Brian Foster <bfoster@redhat.com>,
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
Subject: [RFC PATCH 11/19] famfs_fuse: Basic famfs mount opts
Date: Sun, 20 Apr 2025 20:33:38 -0500
Message-Id: <20250421013346.32530-12-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250421013346.32530-1-john@groves.net>
References: <20250421013346.32530-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* -o shadow=<shadowpath>
* -o daxdev=<daxdev>

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/fuse_i.h |  8 +++++++-
 fs/fuse/inode.c  | 25 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b2c563b1a1c8..931613102d32 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -580,9 +580,11 @@ struct fuse_fs_context {
 	unsigned int blksize;
 	const char *subtype;
 
-	/* DAX device, may be NULL */
+	/* DAX device for virtiofs, may be NULL */
 	struct dax_device *dax_dev;
 
+	const char *shadow; /* famfs - null if not famfs */
+
 	/* fuse_dev pointer to fill in, should contain NULL on entry */
 	void **fudptr;
 };
@@ -938,6 +940,10 @@ struct fuse_conn {
 	/**  uring connection information*/
 	struct fuse_ring *ring;
 #endif
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	char *shadow;
+#endif
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5c6947b12503..7f4b73e739cb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -766,6 +766,9 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	OPT_SHADOW,
+#endif
 	OPT_ERR
 };
 
@@ -780,6 +783,9 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_u32	("max_read",		OPT_MAX_READ),
 	fsparam_u32	("blksize",		OPT_BLKSIZE),
 	fsparam_string	("subtype",		OPT_SUBTYPE),
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	fsparam_string("shadow",		OPT_SHADOW),
+#endif
 	{}
 };
 
@@ -875,6 +881,15 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		ctx->blksize = result.uint_32;
 		break;
 
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	case OPT_SHADOW:
+		if (ctx->shadow)
+			return invalfc(fsc, "Multiple shadows specified");
+		ctx->shadow = param->string;
+		param->string = NULL;
+		break;
+#endif
+
 	default:
 		return -EINVAL;
 	}
@@ -888,6 +903,7 @@ static void fuse_free_fsc(struct fs_context *fsc)
 
 	if (ctx) {
 		kfree(ctx->subtype);
+		kfree(ctx->shadow);
 		kfree(ctx);
 	}
 }
@@ -919,7 +935,10 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 	else if (fc->dax_mode == FUSE_DAX_INODE_USER)
 		seq_puts(m, ",dax=inode");
 #endif
-
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	if (fc->shadow)
+		seq_printf(m, ",shadow=%s", fc->shadow);
+#endif
 	return 0;
 }
 
@@ -1825,6 +1844,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	sb->s_root = root_dentry;
 	if (ctx->fudptr)
 		*ctx->fudptr = fud;
+
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+	fc->shadow = kstrdup(ctx->shadow, GFP_KERNEL);
+#endif
 	mutex_unlock(&fuse_mutex);
 	return 0;
 
-- 
2.49.0


