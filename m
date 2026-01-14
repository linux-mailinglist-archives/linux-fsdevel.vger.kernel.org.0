Return-Path: <linux-fsdevel+bounces-73835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F2D216CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 471BA3022025
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7075D39447C;
	Wed, 14 Jan 2026 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwAksuye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593638F242
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427049; cv=none; b=a/Kd86/Eoy5+YAMf0dGJd8V3dOd9D2hr8b7d8EplPrlGMgsd0vg36HEi8t6m+GVROxLmeK8QOiQHUoknMn0teyHfJMziXUwNkTfER1aELMykIjfrFJ7zwZDNe9rZbWyHOYxekjJlhNRXu0PtQ+JkbbJa2eGDmA46rRe4EtdBbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427049; c=relaxed/simple;
	bh=6IXyikUrXXga0w+XTOVh8PGo9rM6Mf6O+h0Sd4yHab4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN0RuOGIvCEEcbuSJjiBmz9Tsi9F2Kf5f0iSaVfMVgZIRfGRbSq4QmjUbpZfmClZMaO33wLdh6eD8++f5Y0CJeNMbQ7HcjWoH01K68cUxtISEVciWAHGRIo6q0FoYADvl22GKBcAaHoiBpC44HExJUNxpNGOr/X/2c0bG2aVfas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwAksuye; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6da42fbd4so169467a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427023; x=1769031823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KokXwqCF3cjj7h8MwPrV07VxZRdfFYCa5Cm5tvCoTf0=;
        b=DwAksuyem4fEXByAYX/OKg/0P0/Ha1dtdmlvYZE+UKXX7YyZhN6fgvtGrdB1rdORUR
         JYGbLkRMbFZiHz2y/aRbCY+WLcRwNL7CXT0eUHAYgo6HV+q8lpX1KviYMFS/BE7mNHGk
         uyH986y0xx/kzFtWryKbAN9a5V1E+Jl3Mm7y5ym+XXz5kbjSeR2t3iwG40PFZZElLFHn
         26IlsFBc5TWc/7ZiOL422nsR/U8knSTp40kFKtyt2oAWo9N5sNTgSgPA/2ieckJvpcJD
         yQ70eaExuqB3Xs/c0UplQHbP9DgRJGwkfpx2CiMo0vveGX7b6miuFZlcKRl1iwukA1KD
         ZCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427023; x=1769031823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KokXwqCF3cjj7h8MwPrV07VxZRdfFYCa5Cm5tvCoTf0=;
        b=FpAZxUIuseN4jM+ltxDAhnGqz7EC8x+Q2gF2DVV+mmkhdshcQ8jMIsWGXEwBclqvWV
         qGPs+LwnTzcGs0m3HTu2CvCLXskXldvrjnacs/s9XnS+L3UyjOMeoQSENr3n1hrimmJy
         Y2hsQ2wnfvPuCIsdh8C9pAURanVxTam6+m+VsLCA8rc6teHPDHs7rA35eX+DonMfiUht
         qCUM4crnA6yDVBPJe5inPUCQXfdzCD74BhAQUYI1t+Veg4Z2LF5i4kcWCdrQKO3gmNCf
         Zj/ohNZomRjisokfY306EqxhF4S+Xdk6ctfRh3UQN5Fd9DdfAbiitY7W4T9c7YwsHKSB
         2sYg==
X-Forwarded-Encrypted: i=1; AJvYcCVIOSGnOZt+UcbZ4UNuFQDViqFlDlw/A1SPkn57axkqIurBB+LGOmOrNjyGbdgNJBVb/MtuJr4vJzyxWHil@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSuRhw9kq4xncrAGP8UEdVzyKshp6SUQ71QR7j0FUcsk7NQyA
	9t7BcjsDUfyVDeVdS76DXdT2juCMiDg03xOTOivjG5kKuIiFPAT+3wNC
X-Gm-Gg: AY/fxX5WlLJrV2CmPvCETkvhFXrhT6WGFRi5HfxtNWBHVwqieRNaQj/EFuNmJhDUahV
	YEF7mg2QMr3YkTnpXOG6YN/SNoP4fO+JP02oHBIiy3xIWxjvQV4EYmtfvH66Hq3F5PGT9HN60O+
	835ux1ZzDv16srgg4U2DvgKgfot0Lf6Ih2fkimHvlurkboxFx9Jt6E68Zl/RXtzOqa9n7UqOuZb
	f6PkmqeO3OBLOSIHObCw3EFaLFzOdGGqWNLGcLUg6MELeCUBFu8EVCyD80Xf1gRTwHuZlP1K+Lk
	3RyJE14FBLGj42IjqrICw4aH98x4Ca7I+CfxhfH/++QtMcCcMe6Q3loDMDkOScu7xVf06tpnf5e
	NpRZBhsE2Dny6DAdtUAvTzv4vQcRYfWT4eV4rqCZ8yOeZPqYxA+fF8M07vR3MwgztLhk74Yw7eQ
	+wQxd/tYi9F6GPHtlTMTRz2oZijil9u6if+xBLEG6KIFsE
X-Received: by 2002:a05:6808:229f:b0:450:ad22:f9ee with SMTP id 5614622812f47-45c712da165mr2717268b6e.10.1768427023109;
        Wed, 14 Jan 2026 13:43:43 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa515f4dasm17619569fac.21.2026.01.14.13.43.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:43:42 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 1/3] fuse_kernel.h: bring up to baseline 6.19
Date: Wed, 14 Jan 2026 15:43:05 -0600
Message-ID: <20260114214307.29893-2-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114214307.29893-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114214307.29893-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is copied from include/uapi/linux/fuse.h in 6.19 with no changes.

Signed-off-by: John Groves <john@groves.net>
---
 include/fuse_kernel.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 94621f6..c13e1f9 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -239,6 +239,7 @@
  *  7.45
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
+ *  - add FUSE_NOTIFY_PRUNE
  */
 
 #ifndef _LINUX_FUSE_H
@@ -680,7 +681,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
-	FUSE_NOTIFY_CODE_MAX,
+	FUSE_NOTIFY_PRUNE = 9,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1119,6 +1120,12 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_notify_prune_out {
+	uint32_t	count;
+	uint32_t	padding;
+	uint64_t	spare;
+};
+
 struct fuse_backing_map {
 	int32_t		fd;
 	uint32_t	flags;
@@ -1131,6 +1138,7 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.52.0


