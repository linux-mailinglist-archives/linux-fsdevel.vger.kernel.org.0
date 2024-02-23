Return-Path: <linux-fsdevel+bounces-12615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE21861A76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7BC1C25881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5C14CABA;
	Fri, 23 Feb 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0bAx9pv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21814CAA3;
	Fri, 23 Feb 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710198; cv=none; b=suN0HGDBmrGeHq3rrKsvFkOoCg/jA5xXak06XRYUdUJEuo6kRK6GaY9cTJ8rCPgV7jwcFyUBI8dJqNGEtEu9v8IAj/Lhyc/VUMTonIOMAcTkpx78ElftIlmIo3i1Klz1aXFJBlSgQtuGUTMv7vY2kjFeDaWlkImWpDAUzF4BUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710198; c=relaxed/simple;
	bh=5E8ws1s3l5Z0WPoeTvetPbeYIJIcr9hUCwqUfntZF8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMuwP6uLuzKzYBGr5IaJmxy79QQglqb2fpuNzOL5Y/BvB13DuttO3OLoqIVlrduH9l2vZeBPfW8WvjT10Vj/NHPx/bkq6BfXnqqYPU5krBmcKEo8aDQu7u9c54vjoXBqYOiwKKkKXcFXbcuCCedvbfXM96iIXBTaWvDAUON2qiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0bAx9pv; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-214c940145bso280784fac.1;
        Fri, 23 Feb 2024 09:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710195; x=1709314995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu2qZWqnSX2CvxPOf8wPdAKOwn+qgMDO2ue/T6c8dWQ=;
        b=B0bAx9pvCF1D6/l324gryIcIkYjxGugpsY2Pr4HVR7BLnwlbxdL6UWrNrbmpGHeEkj
         wzA8x1J0hjuytXyRMUHvWH2be2f4n4p9WRryOJJ9Vhu/y+7vwbZywi6QNMKCjXI3q11R
         bvam7xwHBwNodU2b5UrzJFKIY089RXcHKSa4RAIFXPZjnVSyMh9oAdys8Sdi75YA1n8z
         /4emqswolk+926uXu6oMQkJMhz9JbNP/q+8xA0QmDLiWoeBpC0ApJsIDOhEUretjE+D2
         c3aMOdoO9iM57YhtTtqwQq4Y5Pk2GNXzA3kl2aremxwriicNE9DtZOjNaPX554izfpHK
         TGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710195; x=1709314995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zu2qZWqnSX2CvxPOf8wPdAKOwn+qgMDO2ue/T6c8dWQ=;
        b=EHjcW8uLWcmeuR7wkUnp/2NMD9+1glZ5+y5zbhsu5TrO/6sQmhMFlwBvNo2xKfSb+T
         UXOligqjPxadd68qxj/P2WUdj+nMMnvbIC/5x595xP6B3jkAUG41lsQ8ygdenpO2bqNA
         GI0qiwYjVGKuU88Btom61PdmiXn0Aznr8vCr+vBFFKEvT+b1VbiP+Gb62yxtuc8qkHgz
         eiAKUsZOo/lDPRqjGcGRrMQUvIZCB89MJgTtx64CR2+z9deTXKi5I+yOrt+50DJX1eQH
         I9u2GUUKoc0pLlocP3YYR9/lP0rLCR2WiPkO4e31fWED+gsWOZLqxafieOacw8nx0g67
         KY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQXCOQ25RkYQBC2sFY84KY310eSx/1Sp92fvDWh84Ka5XudqjOuWXvZA+kpAd3mEvq+5zy1msKOLcVhQuW4yJTGf3al52L1zoNZSyBwdvt9GjViTUrMM3q+RKdrzgoI0/ldJrYVOD0JFY2N4hTgveaMgIWj5z++5Bbh9z023Gu/IihjGuYowiOLIqDPfMF/Y87BRley3dMERsQTBwwak67Gw==
X-Gm-Message-State: AOJu0Yy7PbfAMC0z5QQQ3l0GUcQ2NZ0TNis+xPQO3yMDfnG1RGTlwwYV
	lH256Tj/lcz2usCt3yaHotX62qc+4JbGbtUTlfA3jEivZ3oUsR+N
X-Google-Smtp-Source: AGHT+IGYcgtz8Iy06lQQNWXgj+Ve6jWn51fNo3ZASvjNCtG6BLvd5/jrMrMZaBzsTgxAsVPTnEaAAA==
X-Received: by 2002:a05:6870:93cb:b0:21e:4f99:d3c9 with SMTP id c11-20020a05687093cb00b0021e4f99d3c9mr406481oal.50.1708710195603;
        Fri, 23 Feb 2024 09:43:15 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.43.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:43:15 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 20/20] famfs: Add Kconfig and Makefile plumbing
Date: Fri, 23 Feb 2024 11:42:04 -0600
Message-Id: <1225d42bc8756c016bb73f8a43095a384b08524a.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add famfs Kconfig and Makefile, and hook into fs/Kconfig and fs/Makefile

Signed-off-by: John Groves <john@groves.net>
---
 fs/Kconfig        |  2 ++
 fs/Makefile       |  1 +
 fs/famfs/Kconfig  | 10 ++++++++++
 fs/famfs/Makefile |  5 +++++
 4 files changed, 18 insertions(+)
 create mode 100644 fs/famfs/Kconfig
 create mode 100644 fs/famfs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 89fdbefd1075..8a11625a54a2 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -141,6 +141,8 @@ source "fs/autofs/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
 
+source "fs/famfs/Kconfig"
+
 menu "Caches"
 
 source "fs/netfs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index c09016257f05..382c1ea4f4c3 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_FAMFS)             += famfs/
diff --git a/fs/famfs/Kconfig b/fs/famfs/Kconfig
new file mode 100644
index 000000000000..e450928d8912
--- /dev/null
+++ b/fs/famfs/Kconfig
@@ -0,0 +1,10 @@
+
+
+config FAMFS
+       tristate "famfs: shared memory file system"
+       depends on DEV_DAX && FS_DAX
+       help
+         Support for the famfs file system. Famfs is a dax file system that
+	 can support scale-out shared access to fabric-attached memory
+	 (e.g. CXL shared memory). Famfs is not a general purpose file system;
+	 it is an enabler for data sets in shared memory.
diff --git a/fs/famfs/Makefile b/fs/famfs/Makefile
new file mode 100644
index 000000000000..8cac90c090a4
--- /dev/null
+++ b/fs/famfs/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FAMFS) += famfs.o
+
+famfs-y := famfs_inode.o famfs_file.o
-- 
2.43.0


