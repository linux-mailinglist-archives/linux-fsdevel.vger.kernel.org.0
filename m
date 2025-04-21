Return-Path: <linux-fsdevel+bounces-46746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B419A94A35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA051890BCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D11482E8;
	Mon, 21 Apr 2025 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2nAhr07"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD313635E;
	Mon, 21 Apr 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199244; cv=none; b=QuAMqnioPcP0hIB2Flt0l0JOzf0drBb7nMrecYDb+rFA6lcGxtXXnEGKyfyJgH4MOKup3YOo1kkzbaQf5QD4mbYRuPsEfzRJ8BgGEUfZ1DZF3jUrZ+J6zT/Dx5i478DPlyfVSVA3Akh12RrLnxk3Ti13N+FJvdXcOZ7mXmnXgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199244; c=relaxed/simple;
	bh=gsIhmfFsaL+5EF4z3f0VUnIpcZS1jFVcEdA2B4rIq38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7VhlzfFIldAGWJ20ubSi9pj0oN6Qt+MyzuPZa8JyWgp4K3ozwoknlDWdFVgWYlqBxWnEqd8pxEVSA4wuXC1ngPx7TdARrT6acKK/wfmM5J0o2KIrck9Itm3X24iyM6cIJERGjJfoVi7d8IxeZU9LUnBqspBqo6dn6WdmnHUXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2nAhr07; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72b7a53ceb6so2123321a34.0;
        Sun, 20 Apr 2025 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199241; x=1745804041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37keBjnXcy0vWAMphYKQfFgDhN7R9v7a8FhgLd8vRyw=;
        b=P2nAhr076pc5Udx/CnzJlrC5JYvTZdTnybZ/umvXrx+6P7NB+aZ8imzhdH/zPV1wo8
         Qnvlq00m6W7DPALISQNSQGU4L44d1dlEainKMG0usajTyKh1N/3FMLIhiat8cAyY19yJ
         4g+vwcGocJunvcqqGXropFCKdQqGbs4WQrUIIz1+9t3EA/gWdGtJCz9HJHykRdvIoWDa
         lQuUeNE2vPfUP42AkY/m55KXQw+ppwohEWw1ixndDGjhh9ticrurodjHyc2EoNZjXDX/
         J+adSXWS8QT6CcLKb6nhHiWtJkx/7YuivWd1BmA7Ip8k1Eb5wYU963+VF3S17OKG75KI
         KBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199241; x=1745804041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37keBjnXcy0vWAMphYKQfFgDhN7R9v7a8FhgLd8vRyw=;
        b=RPUdO8I9YxkTN8GCvCbTLSX93I6T4ztcZFR4ltN1bYXnIPlAS3svIWxMQ1ZV+uPnEf
         4H0oHKdxB0p9BwY4qxw3mP4jPKKUt0YBItnDSgGIBsZde3gMJ2VNoeFnYxtq/ijI19R/
         oLjjS6qVTcVmKYVyYHfA/pvEWfu3l0IrifAQP1E1WqQ5SkJLyhjEzpTlBptR4cJmMBLs
         3if2jz0rTdgRsSDRBKqHeDNiIltfWBoG2MB99vBmVIL+tP8XygO1AbC6vgj/rw4rAFJV
         E7GdiuPyeOd0mUEbIrhrX+3LFFerZSpVGTCIUmgjFTTcNjLFYs2GAv5Tqj+FBOIcLOpC
         JmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJoLqqPOwyDo9DpTkW6TUyC7/dcYBQJ1/olNqDuoJXlmcp81me7MPW121gwq1TzZvvaR51Ljp7hIX6lDPF@vger.kernel.org, AJvYcCVATgc7W0tPbZa5SaeItEUs/fJObuJEiiZ2+6WX+jiSs5R1vhICNV3vxW5SbK1eSaijKPg3f74hziDLu76LNA==@vger.kernel.org, AJvYcCXNE6DOX7i4iUgYqt0PX6XrADP94zTzTOPxHY1T7FCSb/15xytNOeDCdtbTen2Lx4R8yH9sYgKnnPs=@vger.kernel.org, AJvYcCXWLyFcIdL9KBz+UugrirDrNlv0xyNgLnOuK2okkuhxk6cVFgX1zw5ounnha2liyITEXFH/YQFmq57c@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtqhS0JXmLfVMKy5IkYE05HIXTVvx/ssnVIzAmQQx6kjT9rqq
	OVywAu7XpC6AfqndvQZWwJJzU5Hr7UZ58x2MLbczAx87Gy+ztuRx
X-Gm-Gg: ASbGnct2NyvEsicEzjfk0DU76myKb1YWQPUyxxPDdFbKeaIVMpvr+dSiz5WjjgpBEoQ
	wwruQWogiwjpmGc37TKQnpzKh0ALUYrj4BZlwoMzipQ9xRYTdOO+wQMpiG5orv7urBlOGkIJLjA
	Jz3lJdCdIvxPTZQpfAeDa2DJcy2XGn+dPjQKnwEpkdRvSZrErehW7G8nCY3F8/ihhX3QcUgeuXI
	0p5XgSUJHwY9pdl2fqwLEphBlJzQUBg6Qs5L1EzQBCaFNKrTMXdawInHVUyDS9TPluO1OS9TDLR
	7sfvg/SBN8Ml014ZiPVINj3JVaLebVqTlcwbaTA7pGlScZN4ullVOw/Y3wNJ2RDRYU8vXA==
X-Google-Smtp-Source: AGHT+IGp8RZLlzeUTFl1h5mg3H6My52ABBiCe3Ryq979SMBCBftURNPp06AGz5RNSl+DLM/21GFUdA==
X-Received: by 2002:a05:6830:630b:b0:72a:1222:9e8a with SMTP id 46e09a7af769-7300606460dmr5662821a34.14.1745199241117;
        Sun, 20 Apr 2025 18:34:01 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.33.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:00 -0700 (PDT)
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
Subject: [RFC PATCH 02/19] dev_dax_iomap: Add fs_dax_get() func to prepare dax for fs-dax usage
Date: Sun, 20 Apr 2025 20:33:29 -0500
Message-Id: <20250421013346.32530-3-john@groves.net>
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

This function should be called by fs-dax file systems after opening the
devdax device. This adds holder_operations, which effects exclusivity
between callers of fs_dax_get().

This function serves the same role as fs_dax_get_by_bdev(), which dax
file systems call after opening the pmem block device.

This also adds the CONFIG_DEV_DAX_IOMAP Kconfig parameter

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/Kconfig |  6 ++++++
 drivers/dax/super.c | 30 ++++++++++++++++++++++++++++++
 include/linux/dax.h |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d656e4c0eb84..ad19fa966b8b 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -78,4 +78,10 @@ config DEV_DAX_KMEM
 
 	  Say N if unsure.
 
+config DEV_DAX_IOMAP
+       depends on DEV_DAX && DAX
+       def_bool y
+       help
+         Support iomap mapping of devdax devices (for FS-DAX file
+         systems that reside on character /dev/dax devices)
 endif
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e16d1d40d773..48bab9b5f341 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -122,6 +122,36 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)
 EXPORT_SYMBOL_GPL(fs_put_dax);
 #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+/**
+ * fs_dax_get()
+ *
+ * fs-dax file systems call this function to prepare to use a devdax device for
+ * fsdax. This is like fs_dax_get_by_bdev(), but the caller already has struct
+ * dev_dax (and there  * is no bdev). The holder makes this exclusive.
+ *
+ * @dax_dev: dev to be prepared for fs-dax usage
+ * @holder: filesystem or mapped device inside the dax_device
+ * @hops: operations for the inner holder
+ *
+ * Returns: 0 on success, <0 on failure
+ */
+int fs_dax_get(struct dax_device *dax_dev, void *holder,
+	const struct dax_holder_operations *hops)
+{
+	if (!dax_dev || !dax_alive(dax_dev) || !igrab(&dax_dev->inode))
+		return -ENODEV;
+
+	if (cmpxchg(&dax_dev->holder_data, NULL, holder))
+		return -EBUSY;
+
+	dax_dev->holder_ops = hops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fs_dax_get);
+#endif /* DEV_DAX_IOMAP */
+
 enum dax_device_flags {
 	/* !alive + rcu grace period == no new operations / mappings */
 	DAXDEV_ALIVE,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index df41a0017b31..86bf5922f1b0 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -51,6 +51,11 @@ struct dax_holder_operations {
 
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
+
+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
+int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
+struct dax_device *inode_dax(struct inode *inode);
+#endif
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
-- 
2.49.0


