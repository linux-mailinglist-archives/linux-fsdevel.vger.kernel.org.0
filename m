Return-Path: <linux-fsdevel+bounces-72655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69ECFEE10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF56333A967
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9203986EC;
	Wed,  7 Jan 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly49VzPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9A3986ED
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800093; cv=none; b=Yo/TQfwG/EvCUn3wVVJM5EC/lMMjjWIKCR3lWRPUFldSmY+rwnSBohsKBfqZ3sEYYwzqZmNTU1c8WBDdCDOwpxv9qrjNv77ilAGK7sMMQc9QJEFFeD95HKl27XUDduW58giKkAvdFBTA7RyQJR5RjYilBb7yQ9Kcgwr68hZZsX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800093; c=relaxed/simple;
	bh=rKi3IJhFbcB0WLwepeKv+pU0rou+ccXKzIoDaJEyXMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl0jQ530DrNleuanrFqQjxouvPakYDjEu9m1J/Q+OltFnq5lCJ3GVNZ2OoeyF2Dfr799eA/NF3JCNy+sTnlRmJfyZHB5WBw35gtZvrBjdcs9HHxhZmARmPP0CErPg4gsRez8Ld2UwcZO4bDa1qf9Z6g6GY636oK8HT/01UMG4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly49VzPY; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45085a4ab72so1326525b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800091; x=1768404891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBCgapkD0tMSytl4lZx+vzryyZ4HeCqXI7xZ8qhc6V8=;
        b=ly49VzPYANUzc4j6Fa74Vb7c8LJg8YOCWp9nko3fCKp8W7fEHEMbGvhTSjW1LR+91X
         MPKNfX4LhmaWLjxEhiVbt+gtbC/AvwLZrnL5jSaOeNuYtNtEtIXolqUBy3UnPYYdRi0/
         krsjGYCO+5Cjf6dYggYiSyDdbDeLMRM7zsd3X/4Wzha8YOfEx9iwPbdFqCahL/XxYiSZ
         xNebf/mo50lKjtx9lHy6PlZIVTlI90bqAsNVXmKOzY4GlDoAhs9meIRJuqRu8p5JLjbA
         lkg0IDKgVc/n8XUmGFX3PnUnIh2dbXh5JkslWJ4p6mfhplkTrAy/+QjrGXz/7EA8XKxf
         v9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800091; x=1768404891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBCgapkD0tMSytl4lZx+vzryyZ4HeCqXI7xZ8qhc6V8=;
        b=kEht+I3wtiwQReAbhtu9kcjZnfpSDtq20ezTRrXLoYtxLyBTHZIEAuNtggIDZmJXXT
         0cHvkRpBASWDFHMTKYgfSxT9RtNJ9PywTzCXfWGs1K2TI6ft8R7BtncO8LbzR4caqVgo
         /K3jPc1v93l2pdQTINKEcZi/1w/ms3aAgDvXRAhp1LBogf1bWgsfKmA99sDs6zhkEEfE
         f/cTFiFUgdPXVZcHBcHNVmyqVTr4X/aeqsSjtTDyEaSHj3XlzYuoBrmyaMLFOPevdefz
         JnLvXCd1UXVQMxe3+RVgGk9lDAG+r7sbL7AJzCAbUL0DQbDd/pEglIXVmZbUvmCjqq5v
         s85g==
X-Forwarded-Encrypted: i=1; AJvYcCXqUKVijq8faTDo0ru0VQVSvwjNd85ym6Q80bS24+YGBrVOjGNCalresuAS/RcQMcwXp2iHwgXWSVdirnI1@vger.kernel.org
X-Gm-Message-State: AOJu0YyIv56IkYKFWpbGX3vBVn5nSsUQnd4z1kQCOvgc+WOlnDrcwVAB
	+VEkrahjckEwKgG619XUv1ltRXHx3q/WOvQWTtsiYYADooBqVTp5XXIK
X-Gm-Gg: AY/fxX5VhMVzJMF7prC9ggsb5pBsVyWIqNuC0UMmDYMHX0TsW2VFaQzaSRkuw/VXREX
	EWCHz1k5L12PobbWQOglOkL7gojjI50iMb3orEQGmjxQ1TRX0LFjBD+hE1ewQ0yQ6okb1kNDoZk
	/UagxwmYqtgMB69yyfsTF8Kp5jqIeuyrt+jFWjmWQjeO9e91FV93yYf7TQqJKudy3aPAcKqpMgl
	oPWcNN9q5SgR/65u9Jtk5AK3hXNGdB5mOeJS01/D3EQXDaG5yL6N6chBai1Uo3YOKqAu6UFpC+H
	6LN7KM8W4t+fqPNTFw8xB/pk+a1HPeWWVXHFUucAJabBn7j2LU/IJ3MWlf37l7EsAdqVuSnwi3I
	vsNZdeWHvcX3rHllz4w9IV6EntZQQneviLvOyPeKPESxaAtPJ9gxLFWSfg0wI2gqya1wEPNSz7l
	yVcU/nhhgqulPB0SJ0dpjBVrK9oCVsZGBbhFzuTKIuMk3d
X-Google-Smtp-Source: AGHT+IHcdywbJhWbPofmdnwqwy3siWxMKS2ZL8FYrwKJtzA3ot5XniZZCZFcJRodTSEL4vBFeFPTwA==
X-Received: by 2002:a05:6808:4a52:20b0:45a:76c9:303c with SMTP id 5614622812f47-45a76c9325cmr272281b6e.32.1767800091392;
        Wed, 07 Jan 2026 07:34:51 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm2398424b6e.4.2026.01.07.07.34.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:50 -0800 (PST)
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
	Chen Linxuan <chenlinxuan@uniontech.com>,
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
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 1/4] fuse_kernel.h: bring up to baseline 6.19
Date: Wed,  7 Jan 2026 09:34:40 -0600
Message-ID: <20260107153443.64794-2-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153443.64794-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153443.64794-1-john@groves.net>
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
2.49.0


