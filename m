Return-Path: <linux-fsdevel+bounces-46763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38859A94A79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FA53AED11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5977C1E766E;
	Mon, 21 Apr 2025 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1RGC1be"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF371E51FA;
	Mon, 21 Apr 2025 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199296; cv=none; b=GcDufSfbSZaJoRZnMhgVwCqsfJXpv3wcTxoy12QW0N6fpVl6pHc1e+IC7h3+eZ5haa1o6n5+yJdnsfa5NgObzpAHK6urURFCGvbdCCH8VzLdoPGaOPMrpjZu3vy7nf6oMUNrzMsI3dKNcVoEBpVY6JYWSaaaX1aZDnaFx9yS/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199296; c=relaxed/simple;
	bh=PEQixm1WSR8qIvIweIBLz5yb47diHKRVT7ZCrAw41jE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OV8IxPDR27Ubs+TncNRDCHUPAtM0v9WkvVdKw0CPfZ+SJ39jMkgSkgkUFmei2NvEp5kmhtZkp4pK8uHv3YpR9iD/gakyCp6AvpDhEpVWQzqmLxWjhk529rIZC/VXBl94noEJwo+ZsT1frkhUYN45ARjC0mhHPsclxw85sVnqnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1RGC1be; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c3b863b8eso2361800a34.2;
        Sun, 20 Apr 2025 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199294; x=1745804094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdQVZhgSGxPpGqga5Gwo7PXNt34SxV9og+/VWo3OSP8=;
        b=X1RGC1beM8DJyHo5JWSKeZifBqirEQb9uu7/JfNOgLHU+r7f/ltEFXy2XlRgKKfQDN
         qj3J8yz0l6SntKjjJ7otVXCLMuUPpDp42pk3EmE//e0iZEtTxQn9D6CYqgyWkJRyw3RK
         k80JuQF7qniaLctZQqV61XZimkqAAI+bdMe4pK4hh4wdx0ak6LDVsUXdJ/Nc/4kC5ZAL
         lodJpvPsG3JU2UhFr6kr7zGncNdvz2xBMW/FM1HoospPFhIfrAlJyiGjGRiejJUDwLyl
         PIGprGznbIwJFZJfJ9a4Z3/O7XbcElHgjvx7dRUpSnf7+kLRUS53ZHXOIT4HBP/rWkCL
         cOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199294; x=1745804094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdQVZhgSGxPpGqga5Gwo7PXNt34SxV9og+/VWo3OSP8=;
        b=vjlLSM+m6L6peVEjM4q4F08nVLO573O5C0NXiWkN53J5T0bzs1SnAGltQdSn1lDaH1
         pXOSGirB9ArJsL/BUO0eIM+uObPIKPBypA1yFIMrrkCXW1rdmMXe3l/2kc4XXjKUeeoE
         dSV/yrYLRfMw9BhOgcN7U1L9BT42bGjgSz4JKZDGV9EsgP2wkaEQOAFx8kMEhKOOeX/1
         X193B0Irw1PUtEdj8EyKrVeck0thYGo9yDnuq3chlBp9y3nvD14ts6+mz8jgwmWrcVZA
         ubdkiHw5U74v0Idl/YixaWuk0op/RJvdfeYxDabtSYEGvaul/PN72ZXm6fnASZRXNhqi
         /R0A==
X-Forwarded-Encrypted: i=1; AJvYcCUtbCGncwFLb+UDZj3+wD/gu07OxzvHq8px8LRBgRQ3gVzIMj4ke5rfAIS30HDBh4upxmmuQkly7mVa@vger.kernel.org, AJvYcCVj1xlZPNTLzRn2hsDCnnMxGwGvjhM1kbaBgHlUUL6dzR5BaxtJvP+wl2gYGoymCXrTC69UF0l761BiG3AH@vger.kernel.org, AJvYcCWJpY6zBJyjyZcS0DHT3e9WqkLQ5S60U1N+vwvpNgh6bLFuexx2nyQYjx7dAc7Q7/Ks7UUM/+pb1sVShfg9RA==@vger.kernel.org, AJvYcCWwhTEaZv4nhKRbdhgctcThKXSzmjxuykHJI8A4EvXe7U7OnryR88uS7LVeem0WlOmDgWcfr6/LOMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMuOwmTGfVUF5dXFIE9EnSZuSkxVOjyJhYjqZXEjK7xIokmEA
	Zo7H+ct5YPIo9Wv01pxE+GPattQnY+vltbloIj1iEAcCMt66JZY/wJZsD9bK1Go=
X-Gm-Gg: ASbGnctj7Qlw5hpV4fQf0nh6fI3Cwd7rDcNqj5sstbTVbE14TFmEl51sDcoC2so206x
	xBdBCWwtV3gE90+LVcYxGTGaLHrgih2kV8PllpfynpY4fB7NyDxLayE16tZfz0nFHOylGJxSBC+
	rYP+m5jCPpJgkPK//+UIIraAlL/atyVJbuzOEeBFzle03bTrSPFJKbov+yK3VvGbInxlcjkwujm
	ylSrp4cVzXtIylavRm/X+T3zBuwD8xMBI1qXAshqFMChWHd/AbLlzBGr10CMtYouT8flGndqTxd
	EMWA/o3K6Wni2mkMW5tcJSejZks2d8b0P7zhVLyW1eU9fwbYZD5vOfcVMHQb8thKwU+gqQ==
X-Google-Smtp-Source: AGHT+IFvhi11eKZv5Y/gzRlzyAgr2UzcgOUfeV5gBpd2B3+8/z28bKwE37MnSOlyjxSbt8eeloMeSg==
X-Received: by 2002:a05:6830:7182:b0:72b:80b8:8c67 with SMTP id 46e09a7af769-73006333e6fmr5754877a34.28.1745199294139;
        Sun, 20 Apr 2025 18:34:54 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:53 -0700 (PDT)
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
Subject: [RFC PATCH 19/19] famfs_fuse: (ignore) debug cruft
Date: Sun, 20 Apr 2025 20:33:46 -0500
Message-Id: <20250421013346.32530-20-john@groves.net>
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

This debug cruft will be dropped from the "real" patch set

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/Makefile |  2 +-
 fs/fuse/dev.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 65a12975d734..ad3e06a9a809 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -4,7 +4,7 @@
 #
 
 # Needed for trace events
-ccflags-y = -I$(src)
+ccflags-y = -I$(src) -g -DDEBUG -fno-inline -fno-omit-frame-pointer
 
 obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51e31df4c546..ba947511a379 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -30,6 +30,60 @@
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
 
+static char *opname[] = {
+	[FUSE_LOOKUP]	   =   "LOOKUP",
+	[FUSE_FORGET]	   =   "FORGET",
+	[FUSE_GETATTR]	   =   "GETATTR",
+	[FUSE_SETATTR]	   =   "SETATTR",
+	[FUSE_READLINK]	   =   "READLINK",
+	[FUSE_SYMLINK]	   =   "SYMLINK",
+	[FUSE_MKNOD]	   =   "MKNOD",
+	[FUSE_MKDIR]	   =   "MKDIR",
+	[FUSE_UNLINK]	   =   "UNLINK",
+	[FUSE_RMDIR]	   =   "RMDIR",
+	[FUSE_RENAME]	   =   "RENAME",
+	[FUSE_LINK]	   =   "LINK",
+	[FUSE_OPEN]	   =   "OPEN",
+	[FUSE_READ]	   =   "READ",
+	[FUSE_WRITE]	   =   "WRITE",
+	[FUSE_STATFS]	   =   "STATFS",
+	[FUSE_STATX]       =   "STATX",
+	[FUSE_RELEASE]	   =   "RELEASE",
+	[FUSE_FSYNC]	   =   "FSYNC",
+	[FUSE_SETXATTR]	   =   "SETXATTR",
+	[FUSE_GETXATTR]	   =   "GETXATTR",
+	[FUSE_LISTXATTR]   =   "LISTXATTR",
+	[FUSE_REMOVEXATTR] =   "REMOVEXATTR",
+	[FUSE_FLUSH]	   =   "FLUSH",
+	[FUSE_INIT]	   =   "INIT",
+	[FUSE_OPENDIR]	   =   "OPENDIR",
+	[FUSE_READDIR]	   =   "READDIR",
+	[FUSE_RELEASEDIR]  =   "RELEASEDIR",
+	[FUSE_FSYNCDIR]	   =   "FSYNCDIR",
+	[FUSE_GETLK]	   =   "GETLK",
+	[FUSE_SETLK]	   =   "SETLK",
+	[FUSE_SETLKW]	   =   "SETLKW",
+	[FUSE_ACCESS]	   =  "ACCESS",
+	[FUSE_CREATE]	   =  "CREATE",
+	[FUSE_INTERRUPT]   =  "INTERRUPT",
+	[FUSE_BMAP]	   =  "BMAP",
+	[FUSE_IOCTL]	   =  "IOCTL",
+	[FUSE_POLL]	   =  "POLL",
+	[FUSE_FALLOCATE]   =  "FALLOCATE",
+	[FUSE_DESTROY]	   =  "DESTROY",
+	[FUSE_NOTIFY_REPLY] = "NOTIFY_REPLY",
+	[FUSE_BATCH_FORGET] = "BATCH_FORGET",
+	[FUSE_READDIRPLUS] = "READDIRPLUS",
+	[FUSE_RENAME2]     =  "RENAME2",
+	[FUSE_COPY_FILE_RANGE] = "COPY_FILE_RANGE",
+	[FUSE_LSEEK]	   = "LSEEK",
+	[CUSE_INIT]	   = "CUSE_INIT",
+	[FUSE_TMPFILE]     = "TMPFILE",
+	[FUSE_SYNCFS]      = "SYNCFS",
+	[FUSE_GET_FMAP]    = "GET_FMAP",
+	[FUSE_GET_DAXDEV]  = "GET_DAXDEV",
+};
+
 static struct kmem_cache *fuse_req_cachep;
 
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
@@ -566,6 +620,13 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 	}
 	fuse_put_request(req);
 
+	pr_debug("%s: opcode=%s (%d) nodeid=%lld out_numargs=%d len[0]=%d len[1]=%d\n",
+		  __func__, opname[args->opcode], args->opcode,
+		  args->nodeid,
+		  args->out_numargs,
+		  args->out_args[0].size,
+		  (args->out_numargs > 1) ? args->out_args[1].size : 0);
+
 	return ret;
 }
 
-- 
2.49.0


