Return-Path: <linux-fsdevel+bounces-46752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79BA94A4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FE418909E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14806199EA2;
	Mon, 21 Apr 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3mFbJBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479B192D66;
	Mon, 21 Apr 2025 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199262; cv=none; b=t1a7YXASYXUma7SpYCGaE/CNmtifuNJWLvhHmQoq23nR4nVZtaOyOqP3ohzz72k7aCraVVq7SnqHvtDVBSpDgrStdeiSo+7lCCh7J+0v4TwsO71MIFcdkN9cUeGeI7Re5dt6IkpDuyHdBZcXxcMc6+lsAKjd4WLlJ5jGxlR+jO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199262; c=relaxed/simple;
	bh=kGGXBghV4lzKmeRVN+j+pfeJiQeXOVHeL7W4dyeFZvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JoghSZyHHMvGfXrmTGh45c9UW4tfLW2fhxzfQW0QcqTWjpQCuDGyppFhgjFeCrc+I+Qaeo8PWArcW0O6sFvL0EIz65bxpEwYOjmTc7rvAffqgNSSU5CO3554qoun82XICWNTrZyZrgaubMQWAnXC6AcW2D4B4mztAl5KVDlM9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3mFbJBH; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7301c227512so671146a34.2;
        Sun, 20 Apr 2025 18:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199260; x=1745804060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/+tFl2/Decgi2IQHespB0RF7ZlGK7hVUQHMC/s+Z0A=;
        b=G3mFbJBH6+0zyZZ/MIdyUQG7anqXHqygHFeTJnSxk65y8Nty492srfbQKx0JuSXT+v
         qE3h+K4OoyFk5t6FuRtA53OON8F9vwyDidVyjPQE3dDCGblkV13DS3ngQKzkgEfv6iNg
         gJPNeonD43Olg3QvWvXGzXQ5u34oJqo0j7t0p+zwqZnQB2cPPY478FzX6GhiYayRzVWc
         Gl4Qd3CVyKUVqhL6cQgfXf575eTUB/NycWxZE8lJe5bpZCf0YP+jCCCsyWLC+H584aED
         uX7FfpnXibKReF/hNhIK7Ry97l31J599Rb8uPb6gZU7uVfnGmjLls9zhVLeNtNxsIBzs
         173Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199260; x=1745804060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/+tFl2/Decgi2IQHespB0RF7ZlGK7hVUQHMC/s+Z0A=;
        b=S64294o3flon9Jz3u8wUdEZxMdU1iSJ/QkSEDMyb6HgNMIM1eyXjNkDwiQlePlrVTN
         desvgdjEtRju5DechysPeD6TpDL7hwfb1HhETYNwcTRanmPp3kg/ScSEP/mPqSxEPEEW
         x5Og+SL1nGsrZDaQL+pZ5LoLZxTbUGwZFDa7SqBaUzZYIJR3U0H3D6wDr8HofEe0BzuY
         BEXSTO0UbnSiI8P8D2dUTt16k6KhGmPqs8vfqSMQbYd3cb4i07P/QCDKeCV2FNgx8rBm
         19wK2om1e5Ft3LxbrcRl3077P+xWFw0jh7TPrtkVQzXcPobqNZ2UydtmCP1cQUERptV5
         ZP4w==
X-Forwarded-Encrypted: i=1; AJvYcCUd3dCAe1tqBiEz2pauqORMzfgrV4feKZTt5h08RVVuuic8DBWf936NsbhQKBPj97TZs/DnHWgrq4baSrjg9Q==@vger.kernel.org, AJvYcCV1bkRRTrf/wJWRTbeMGhKAlng/dffP1RZCkzevJusES83PWzFUKhguCnMoWVeT3IJml27jclYp9kb5dvV4@vger.kernel.org, AJvYcCVKA2FpfVERbhDppGAA7dcZbXwUBBs4UI0hDAPSED75ZhQ4SeUg4lf16Qfi2OrIp6Iei9syl7uJq5hY@vger.kernel.org, AJvYcCWHDm7UFSkFHQmNeJp0n0kljBmCrYI5mr1jynfkfVdmDmZ66pXbLwqNYEwdgYF/+yWZG+O2JVm/V9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD59s55eUbLP9zCe1Y4Ez2zVMQs+PhINH2cqIDT+S4YvxXz7gl
	p8Y+dmxD8sEcgS3Pr4WbACGVIgHFUYUYFMehOyYMlbZxBqW50bwg
X-Gm-Gg: ASbGncvY6JLl2FTvPdTaM+RFiNfFBmDsiZsHYhUiCsSOSUayykjFdO4W3Bth3mLi14V
	Se1YVYTmGaRFfmA2eIGulqJ5FwNcVJdwt6fodwrDLuHrLdCFyK98nRgTNn3HQtT/+0Umtbnu3Em
	MnkabMrNj+6mOdTfk5TZzScddaoguB9mVJLGjK/xa90xvbsSWo8QRvWJD4PVz0SuUvZYqhUGRrP
	8XyMMuqhCN3GIzxe2GS8/OjL3M84SyJVdiaIIHLB9GntZ03zd+ktk+qmp9cz4TijOX3GzjySOJf
	PDEdnvQFUxLVvJD+b9w/9IMPIJKL8xjk4ezmPIwoxZl193C+lVaFWY2pm3d9mVVUTW5dSw==
X-Google-Smtp-Source: AGHT+IEz5bP7JM3BwiQMEUcJwi1iHjsHutNBExuPGxHLduN/ka75Z9MzoFBPbybdCpgm9y3qzmrR2g==
X-Received: by 2002:a05:6830:d06:b0:72b:9bb3:67cd with SMTP id 46e09a7af769-7300620ff0dmr6144248a34.12.1745199259823;
        Sun, 20 Apr 2025 18:34:19 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:19 -0700 (PDT)
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
Subject: [RFC PATCH 08/19] famfs_fuse: Kconfig
Date: Sun, 20 Apr 2025 20:33:35 -0500
Message-Id: <20250421013346.32530-9-john@groves.net>
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

Add FUSE_FAMFS_DAX config parameter, to control compilation of famfs
within fuse.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index ca215a3cba3e..e6d554f2a21c 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -75,3 +75,16 @@ config FUSE_IO_URING
 
 	  If you want to allow fuse server/client communication through io-uring,
 	  answer Y
+
+config FUSE_FAMFS_DAX
+	bool "FUSE support for fs-dax filesystems backed by devdax"
+	depends on FUSE_FS
+	default FUSE_FS
+	select DEV_DAX_IOMAP
+	help
+	  This enables the fabric-attached memory file system (famfs),
+	  which enables formatting devdax memory as a file system. Famfs
+	  is primarily intended for scale-out shared access to
+	  disaggregated memory.
+
+	  To enable famfs or other fuse/fs-dax file systems, answer Y
-- 
2.49.0


