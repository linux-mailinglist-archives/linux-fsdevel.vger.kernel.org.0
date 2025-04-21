Return-Path: <linux-fsdevel+bounces-46754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC65A94A54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7D47A7B6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A4E1A254E;
	Mon, 21 Apr 2025 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLR0akHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572B819F116;
	Mon, 21 Apr 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199267; cv=none; b=rya9oprqGFSSgE3Wd6NUunNu76LFT/TXak5iKxXbNnnsiLZ8JH4C6SBSDJDQQdq2wGpJzGFfLb1E6FNCGZbS13ATRSMYyiatNsO7i32KaC6gvdUhdMqPSOJQlopnHmYodH+WHETzNy6BktUmcP/J8jpt+JNWbhd4jfYcWSCe7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199267; c=relaxed/simple;
	bh=oeJWVqoXTfM85DPBtFlVkuLxvj/f4i/x+rX/RZYjhZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m1FD6gETJqGiwoLqu3D654YXW3QVAHGk44kasHvE+cJBZuUlxhhPaI9C5Vc20YqGNZmjhwxrT/f9FYBvKXH9w5kLDLyALtR68cHEwCM+iqEAY0Kym7JGBWcZstu3qs0iHBfV1o7kGeEmEIc+7WBnOuvTepf/QWLomAYucmtW8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLR0akHF; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72ec58e45baso2259251a34.2;
        Sun, 20 Apr 2025 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199265; x=1745804065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJTUPxCr5iXCtHx04L7AsNg2Bv7yPa69NQGQVSsPk1Y=;
        b=kLR0akHFQ0+52RWtD4lRShBqEAribyBdAVWv9fQh8vE8WLC3g8vyBWpHt/Gwgvow0M
         JXCQ0IAplJDmHQsxk4CViP7Nxu7GnaQnd7SPcrksJ1lEwlCmmF3y79RaZMc1BDeEKbPl
         8gM4pFIXZjnraJ7DzswdoOOF9KiCclYAv12hUbiRw7jgLZ3ErgVDuhlpVT8izq5XnKhU
         Nv6fcMV3F/cdGWuv8a2s4+7WlR22vX5YAm4cdLB0ejmhczagnAuZZ0eFvhg8IuSW3tHk
         5wdTJZb3vIB60R3jh8Y5/bDiRhRddQY6wh6tK30gWa8aNb/RXe0NnZTyvsEbqL5zOott
         gZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199265; x=1745804065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJTUPxCr5iXCtHx04L7AsNg2Bv7yPa69NQGQVSsPk1Y=;
        b=BIaKNY3XZkyUNh03DkddMDPSsOsZdY2Lz4ga7TU8NJGGseP+wUWNxwyPp0ps1kpQ7l
         3UQ2hHaL6I/F9v+VSkKt/n4GWagGKJ4zrzgC15LH7BDVtgfzkH05NAohSPJyXyh3LtUo
         rrsHZXURfD17EJw295fVIuF8k+g+upRNfN7yNuATQAT/jRi0oNo6/wy2pV0eJqy+h5ok
         rYAS1g8DUpL1CB6fPKiG/dfGzhTYRTSB+pGqtApaUYX7UhegTPkEk5z02188xCtjbpWz
         neaq9p0aoxC9pIe1p/Q6zlTO/ig+9ewheMioZyuctkauzT1QZVkS2ovdSgHIU9lzutXV
         4UYw==
X-Forwarded-Encrypted: i=1; AJvYcCUaDypVcEPor3eaiXKin36XuB7YpQu3mk6P0/NbxesnG/jvJGkxoISdC+z7Rw2JiYftRUVgAYll8egE@vger.kernel.org, AJvYcCVhz3ltE3McIFcdtpaPSVTT2F5q3iDMg0YYgbLY58TSx3A7NhKpncmcYm+cpxgRacmCEFe0uJOyaNs=@vger.kernel.org, AJvYcCW1cjoH0dafsGopPfW/2ei4Iu13OZiV1gSFR1bRO385K85uLy5rNHYmOU5c/okAV/EjHYnGZBkzDa6xrFwLtQ==@vger.kernel.org, AJvYcCWeOOBYyNLY09Q61Mi8Gui+PG68MiyiogWva3npDsbg0TzepGe/aIovNJmI8L8Sua1u9v1bbA+s70w3v2u9@vger.kernel.org
X-Gm-Message-State: AOJu0YwBnlCudrXOZcKVG2UIkM6r/IOdCRW74245EBeEfcNALz+P5mQs
	onnJD/AxBbz7W4N9TEEReKM8+RNkSL7FyLOtoOGuTC15TCidjFZK
X-Gm-Gg: ASbGncvCOGML/ZECNPXmTh/jx9sSlAnbPTNH8uwg8Y2vNonlebGwsTthW863gcOjtPt
	g0TgP1NK1deVtdJEsAnZR2Ks3NldzG9h/TLyNjmgd5QbmhrCPgRZe4FS3JxKXnVs9toAh7BTl+5
	toxbFtScIWF/CApHs0hlrRHjzMFAKJdME5iBaOTYDaQB1bd4XDoKydWd0yFmCPTdftSL0yCjOrc
	6nkylPIdeQh7xcet5US+RHcqF3kWQwkL4EoQKQoVhD6iMCaba6GSEeg8kSs2hKwbnK0udtrKu1K
	LylOvldc6u5gge+ADBeSFKFOPFCuPl2l6Dju6jOjXrF/HFBU6PCaITihuFId1uj7TYIRbw==
X-Google-Smtp-Source: AGHT+IEeWI/ZWY1Oz4SEkKzVLnxG9+3nSwWecNs4VxQIfI4WYWMi4G/PZMw2CRTN5C5Uzp8choe8BQ==
X-Received: by 2002:a05:6830:3902:b0:727:3e60:b44b with SMTP id 46e09a7af769-7300622c63dmr5997735a34.14.1745199265163;
        Sun, 20 Apr 2025 18:34:25 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:24 -0700 (PDT)
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
Subject: [RFC PATCH 10/19] famfs_fuse: Basic fuse kernel ABI enablement for famfs
Date: Sun, 20 Apr 2025 20:33:37 -0500
Message-Id: <20250421013346.32530-11-john@groves.net>
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

* FUSE_DAX_FMAP flag in INIT request/reply

* fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
  famfs-enabled connection

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/fuse_i.h          | 3 +++
 fs/fuse/inode.c           | 5 +++++
 include/uapi/linux/fuse.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e04d160fa995..b2c563b1a1c8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -870,6 +870,9 @@ struct fuse_conn {
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
+	/* dev_dax_iomap support for famfs */
+	unsigned int famfs_iomap:1;
+
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 29147657a99f..5c6947b12503 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1392,6 +1392,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
 				fc->io_uring = 1;
+			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
+				       flags & FUSE_DAX_FMAP)
+				fc->famfs_iomap = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1450,6 +1453,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		flags |= FUSE_SUBMOUNTS;
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		flags |= FUSE_PASSTHROUGH;
+	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+		flags |= FUSE_DAX_FMAP;
 
 	/*
 	 * This is just an information flag for fuse server. No need to check
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5e0eb41d967e..f9e14180367a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -435,6 +435,7 @@ struct fuse_file_lock {
  *		    of the request ID indicates resend requests
  * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
+ * FUSE_DAX_FMAP: kernel supports dev_dax_iomap (aka famfs) fmaps
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -482,6 +483,7 @@ struct fuse_file_lock {
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
+#define FUSE_DAX_FMAP		(1ULL << 42)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.49.0


