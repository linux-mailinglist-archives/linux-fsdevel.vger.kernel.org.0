Return-Path: <linux-fsdevel+bounces-53833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69211AF80AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD112585DB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657E2F5C29;
	Thu,  3 Jul 2025 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAaxPdsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FA2F2C6B;
	Thu,  3 Jul 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568674; cv=none; b=QBSHMA3tsbJ2Z5XiJSmAtAXCBS9UtUWGSerqZpw3hl9hHHxPbxxjjbi9knZn9KFPYFRQo6N0DyLsNJKzg78qp+eEcWDDLrKdAXveAGdM4bHGgHIZeMQ8d7vw24w6YypwqiohGncSGw5DeVUvR6bb5EZ4QJ2dIP2LOzEIH+6ki5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568674; c=relaxed/simple;
	bh=mMW0UbMGTQwYwRZyOjOzEYWkKRV1p4nf8Yc9UlNqkSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnc+AvZm8VbRAaylxK83lrJdwbUFt6wFfZFaqzE/zJDDxdy+waIqkV+56aCP9WrG3EfCYilvk8KoRzKdqlC4Nv0psNm1RKrvhTlOBle9MbKtv62Ks0rNAWA6JTYRtuvpNuzUfhGB+V8S31pWPSVUtw4xSGM6XA1N2d8vqElQ/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAaxPdsU; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73ac40e810eso87945a34.1;
        Thu, 03 Jul 2025 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568672; x=1752173472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWEMonaAutVoYmJ29X2qmwGpA5xB0/IYZPa9u5OJI9E=;
        b=SAaxPdsU3Oz/fwZD39LD9NzYw0vSS7zDOo9DA03mxiPExQ6pB7cQI8vMjdsQrorOKc
         8XAjs3Vy/PP0I7SFWo2E9pjpDZlfYR+QVS4q5PSgVmW6dbdaYceN08NLOnPMbbp0ohmQ
         v9F6boIOstCXHvEMAkVMNKGxECIP8IzhS14StccESVj7JHtXWtXoG5XT2mDCNpX0otV8
         1ZF/pXI7qhZtnk5CdripKIq/VdIgWhXEZxTrGSOo5Dxh93v/n4JrIFJc5XkU3jj9/V23
         aKoyFk+o4pjkoAMWss4/NZHeLzaMrdCzBcAAdDnbeP+Z8eSrcEdd/IxKCGywfgEo4/Gl
         UkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568672; x=1752173472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oWEMonaAutVoYmJ29X2qmwGpA5xB0/IYZPa9u5OJI9E=;
        b=SW8/RCXqHq/0LZeWvMk9A9a8z8RSiQ+BZPLhvu61WfYnfV8E2SHHbmH8pJY+T63dx+
         feOtlLUf05OwQ8oyU9n79MzITGLhr7K9dGWXSV3Ijraz0OG+a+8ZOXFUeOE/BWt1NX1a
         51QUbs6qrAtRfy55RYUoxRlTS9TEgmiRAXEGWSKEkpjftIr3IT7UnfM/+9grmn6CUuar
         KsEzLb3iXDMKP7wPP9uMP/wRIUBlwy69BSwWEBRoO07rzuMMCx04OJ4NKHUHW1xqWc5O
         lNlN2eKKROgllLlAxrJsC4pitU8w2CrGRc/nz6BCBlHG1eA3T6/ZBUWwnAoY+XFgtYyc
         jNCw==
X-Forwarded-Encrypted: i=1; AJvYcCUd7WBBaWa07pZ0BZVcaP1YOIRicNZQjmqfZ++m3keQlA2YVfPM667aSfvgdSO5TIVe4H72EonsD9LEtI/J@vger.kernel.org, AJvYcCVFV1DHGU4E0pNPGA9vimRwQbiSvMqB4GzTqh/lLsK1/AZPSCVWTzgQ7GqamcpnVyj63gizMvV3qY0=@vger.kernel.org, AJvYcCVZc/9qxvYz60rMon3bk88T5tDY4qPgiAbtziTtEU2qBbhq5UjGOlWeEpADJJZmZnkEwMxViJOUe+S+@vger.kernel.org, AJvYcCXqHqi9EZ6vuUEwVkASrV1e42zEYXb1UEoQ548FlT7/6xAMaLuJz9829tw6Fd5TMzAhyTKn50vIqYUoSJQflQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaa3OvJ9Rsx0T/q/C1IsioZn5tFL/04oJGwhe1v9wxQQzRa4Tc
	5ftBYCHwN6xVWi6wl6BFEh4jH+SZIGPccZTpeFhsPMF3TDmryUZ3CHN4
X-Gm-Gg: ASbGncsor2H6JKW7WPFOm5odW0jCWVqH/ADMqUzxKRT/sQ6TncGRSbhiR+igFfTNJuQ
	14POUE5ot6MRyL94+MCxXh0z/EVjAC3fTl3+XWezmyMquUhMw4HAnBCvgtmeUpSuJIkMbLzPxwY
	EK7fJrlXiRPdtH1q9g3KCUV8wKOcTa12PNO9ScgMnhoOwbTJpWa3mjhgNM47rpzAPhNJbZMw2/o
	N73d7nAV7NrxG44cVBOcTJPiRjbyzT8PmdtYn6PTbasq+tIcMJlpwA0ZiuChQDRdPa371IE4ypP
	AACsvXXD6lOSD/brlnaiE+bpR6Xu2QLQssWoqIrIrP2J2nJaJwa9w9yO7zmA/E32DDBWDSamuwJ
	wwVr5V2NzRf3Ojw==
X-Google-Smtp-Source: AGHT+IHUwBODwIp7ctJ4MwNp6YGMLaTDNPH7V/WuiY/SsNw4SKPQYUNXiEa1+Y5X/8t1R2ZxfJ9uFQ==
X-Received: by 2002:a05:6830:8008:b0:73c:47f0:b0f2 with SMTP id 46e09a7af769-73c8980e0e1mr3246513a34.27.1751568671716;
        Thu, 03 Jul 2025 11:51:11 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:08 -0700 (PDT)
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
Subject: [RFC V2 10/18] famfs_fuse: Basic fuse kernel ABI enablement for famfs
Date: Thu,  3 Jul 2025 13:50:24 -0500
Message-Id: <20250703185032.46568-11-john@groves.net>
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

* FUSE_DAX_FMAP flag in INIT request/reply

* fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
  famfs-enabled connection

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           | 14 ++++++++++++++
 include/uapi/linux/fuse.h |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9d87ac48d724..a592c1002861 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -873,6 +873,9 @@ struct fuse_conn {
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
+	/* dev_dax_iomap support for famfs */
+	unsigned int famfs_iomap:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 29147657a99f..e48e11c3f9f3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
 				fc->io_uring = 1;
+			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
+			    flags & FUSE_DAX_FMAP) {
+				/* XXX: Should also check that fuse server
+				 * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
+				 * since it is directing the kernel to access
+				 * dax memory directly - but this function
+				 * appears not to be called in fuse server
+				 * process context (b/c even if it drops
+				 * those capabilities, they are held here).
+				 */
+				fc->famfs_iomap = 1;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1450,6 +1462,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		flags |= FUSE_SUBMOUNTS;
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		flags |= FUSE_PASSTHROUGH;
+	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+		flags |= FUSE_DAX_FMAP;
 
 	/*
 	 * This is just an information flag for fuse server. No need to check
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5e0eb41d967e..6c384640c79b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -229,6 +229,8 @@
  *    - FUSE_URING_IN_OUT_HEADER_SZ
  *    - FUSE_URING_OP_IN_OUT_SZ
  *    - enum fuse_uring_cmd
+ *  7.43
+ *    - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax maps
  */
 
 #ifndef _LINUX_FUSE_H
@@ -435,6 +437,7 @@ struct fuse_file_lock {
  *		    of the request ID indicates resend requests
  * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
+ * FUSE_DAX_FMAP: kernel supports dev_dax_iomap (aka famfs) fmaps
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -482,6 +485,7 @@ struct fuse_file_lock {
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
+#define FUSE_DAX_FMAP		(1ULL << 42)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.49.0


