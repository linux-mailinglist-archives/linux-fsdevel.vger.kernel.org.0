Return-Path: <linux-fsdevel+bounces-53834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3066AF80B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E35F3A27E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73332F5C4A;
	Thu,  3 Jul 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWPoSXAk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCF92F3624;
	Thu,  3 Jul 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568678; cv=none; b=mEyUkNQJOSFUFJCK1pfRcNZVaJi+60OwnVwxVY8KgRatle9whLkZg+mY5SGCjjPMYkFs9QvCDXtKe5yglrFipFy5CEhAL/UBstoKTC4r6wDLv268NvjsJtfFi9epGsikQ0xQR9Oew6pOKuaKYzO0lqG5N6pqTJLEv1OeFqJDGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568678; c=relaxed/simple;
	bh=AwpmHSUwtyys54NEGAXRI09zoURnC8vbuHi9iQ+9sBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UewyQcgsYYSMMlYTqZZjxpHDb9Q0HRpEsTja0A7mAEJ0xIaeQA/A4xxsaPZ7CtQiWdFejWJrPj7JQhDQydTn+Ptfr0ckxcBr61qv9XUkjbVePF/JWCpnc7x67l3OuIyqpb7Kv1Jk1yV/kwEw0zSsJt1ENkXOeSFeTp+mGgqSPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWPoSXAk; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so198972fac.1;
        Thu, 03 Jul 2025 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568675; x=1752173475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDkFGX1XbHNMHX4qdJagUzrPXsT4EJAQRqP6IodfCe4=;
        b=DWPoSXAkjHSwSobfeXI1UPx5NeEUrb32tDI+JjNBRFyN5yzTKiScLrVjpNNo6X4iGd
         fsEpt/7cfZNr3QEs+iZv966e5m3MDssu1f47uCiceKo9nnuqmXn7dhesq8/QpdFfsv5N
         29f6vOb0F7XOreVv8zn4qFAsN7SUnfHWEZnF5LinhJPkaVWMgPeET6kapqFoJD0NYNfu
         lGe4WrZemy0y5+tJWJPbyHsMzq/w4+AZmaWAfwK3MZaVjSBzyPB70SXI1Y85HtGELsn5
         0MByYOcDVVeY23Z2Tl3PBDJDaeARHs1CwnPBEWYVokqh/dinn1RexJjH1A+9+bCypQz7
         HPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568675; x=1752173475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDkFGX1XbHNMHX4qdJagUzrPXsT4EJAQRqP6IodfCe4=;
        b=DM/jiTe7wxUys9HxzE2JVun9oyr32gB0yKDrruZx46hwy7RZSIWK4kt1eXnPgNx+cJ
         Hty2ZWja6qczPrYzvF/O5gAP1eDYqmtUZcj3f/iYIndSloLfqqByyW/0VPWmunz9DISN
         mG7XZQg3Pd/J8hyqeiMTDq4Rlv8QQ/5jeOgFQElifBeOotmbjnrpfGKURNgYDaZt9Niq
         CPYbQcA1oufpLvSdDCMjQPfG6gJt50l+xknBnB8wknptCiYttSgfdtM1+395PxcamCDg
         0aJjgoXta0ULGNv31ScY0l4/H70SQxWVBVy3c25SnDePj9DYyn2O2Jgh85diOeTON6qM
         GtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1XCW2r9ASVqiKZaqTe5qLlMJ3rgv13wICeC40gwky1yOKgWq0Xly+b+cSUq6onqkrTZOq1m8JIvE=@vger.kernel.org, AJvYcCWD3KnmMGOyzOtNOgreKjGVzp8ZQ8cvOa0Ih2WhRBezOOGLCwOr0/hmXCjzCNtjscANQS/ZFdiIiE7oBH5B@vger.kernel.org, AJvYcCX/cts8XKieLG4p+QXwuZk593TxVd52aU2tuhc5QLeVBSwt+Du/M8MDzhZvKUEvsGYTt5PoYdNGbfkaza49Cg==@vger.kernel.org, AJvYcCXnbfoV11NBoT94oZqaRUa4C1KnsJB0V/m4vi9FFA5lRzi1rSwfmKyeoYIayEELS0nm+6L/u20rgJex@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfnvVlDTF1VwLgxG0SymK4ov2kGaQECnwggULeiqSJAEa6vtY
	zDMizS5+ReWOwHpY71DNpigb31bpov/E5tTGL8GmOTcMEl4sWdJ1n+gk
X-Gm-Gg: ASbGncs+tWkABgYI89uPeasdxvZFTNo8uUpJTYZ3wosaiHDKDS50toBt0qX+zHYMSFU
	FYvfRlhkKzY+E/I1OS8V93WnAeOWQZk2hW9Fz0EoTd72rxnflnZSUJbR2bjyrTVI4InCypiCG/v
	sYPcGsdkNdYv57lbpxXgQ5RmslcQq7ozfr4sLi3i1amNyhDtnEOBk4a4RQejsgvhPAjKeCczx9o
	H+Q18eLks4dYUvd41N2c5+TZyDkybmOGJH/U7E6AExe4arIqgXqZdiohKnlr/4giAFdpQ/ZQNRK
	0Z4ngFuNYHOU8fsOrrrxXYqFxdAhBB+ywx3CCFixA2WMl6z9NPynSMSRuJ9YItX6qzKG+DOqehj
	vLe8R1YFmYzrPRQ==
X-Google-Smtp-Source: AGHT+IGvk7MVTbXEVO8MsBWhLFSbBMBlbcME3R7purdewnEgQEPBsk82mX9lJGQ/44BnQtmyeHJu2w==
X-Received: by 2002:a05:6871:898a:b0:2ea:841f:773c with SMTP id 586e51a60fabf-2f5a8c25e66mr7281432fac.35.1751568674740;
        Thu, 03 Jul 2025 11:51:14 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:14 -0700 (PDT)
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
Subject: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
Date: Thu,  3 Jul 2025 13:50:25 -0500
Message-Id: <20250703185032.46568-12-john@groves.net>
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

* -o shadow=<shadowpath>
* -o daxdev=<daxdev>

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/fuse_i.h |  8 +++++++-
 fs/fuse/inode.c  | 28 +++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a592c1002861..f4ee61046578 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -583,9 +583,11 @@ struct fuse_fs_context {
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
@@ -941,6 +943,10 @@ struct fuse_conn {
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
index e48e11c3f9f3..a7e1cf8257b0 100644
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
 
@@ -1017,6 +1036,9 @@ void fuse_conn_put(struct fuse_conn *fc)
 		}
 		if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 			fuse_backing_files_free(fc);
+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
+		kfree(fc->shadow);
+#endif
 		call_rcu(&fc->rcu, delayed_release);
 	}
 }
@@ -1834,6 +1856,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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


