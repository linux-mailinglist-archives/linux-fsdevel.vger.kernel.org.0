Return-Path: <linux-fsdevel+bounces-73825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B897D2164C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6577630D59A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C09378D73;
	Wed, 14 Jan 2026 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFqKzBCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1F374163
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426658; cv=none; b=LG2lcSNCSKTEdwagLiDjUpQSCaMS2vC23YOqGv1j/ojlVGdrnMTlfnMRsthpjxuy8u+rovBlS1EvEuxftQJQrZLrcqLBxY2hlh0EL1In8/ZarHwsif3RaT6z2bUnYMb/h4yfhFfYz1UirIiKHYnyQT5NAdelNyzZ46Acq2WvZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426658; c=relaxed/simple;
	bh=qOSHTOI3Xwy3DZlyVIqnpnTOax8Iqhr9i1N4wEWNc+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnWvaT/Bbq60z8TurcFmu1qcUg4U4ztBCBv5ARYZWicJI8BZBJCjWZNK6yuKxSOMnq/OApBf+76xgjwoSePNSX843d2Hw4Ee7jjgPK6M9OsdU1w58fbG2CwvffdZ+12zk1B4iHHw4gckhKSycMCPbR8nMSF6VSEUupbhGj9J/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFqKzBCG; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c95936e43cso121395a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426628; x=1769031428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc2/Dnt7ZvDFJtfoDY9fKj1STHSnh2OdvJ7mPvvodA0=;
        b=DFqKzBCGwmy36uc4WM9nRABxa4ZaH0a0TzJhsgQwWWVxFpY6vPaWWDFvYaBXrm4BOG
         J9IznNse/jDzy4oh2ocmkJq9WWlve0ULh+GM3+QVdGv51sa4WwfLLqBNSoTEvoRgrtMu
         twp0HSXxwgIcR44+Z5/Q30Xd/0Re9df/IuRd+StdDPUho5AU8BoVFIKLbDXI+ef0Oay5
         Oadm9nzDifTWh+B3Qun1Eg4l2+gvFDAve8+8SNzQzmLoHJxZLQcMIdMELhspHQgjIocp
         YKTh1D0m+BAZ23OPU7FR3a+axj0R408vUgOSx2txRT5AZwgDz6ay3ncTH7Le4i+t8l/P
         gcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426628; x=1769031428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc2/Dnt7ZvDFJtfoDY9fKj1STHSnh2OdvJ7mPvvodA0=;
        b=C/CpdDsc3BqzatkYwmARcq4VuZeyGA1uvzU5cQGgwUCt/hQ3oW5IS+/3GtCmhSxiga
         I8Gyho4T4QSxjTotp/OCwF0BK41Wsj3x6GRZ6lQ9Af+IqQk3GBfYwuNQVL02XP0V6ZfV
         h9thnJAPst8WCOQa9+N5aSf5MefjLgj9bk65En2746C38gEGCn3Mijh76JCFBqXzrZ/P
         fgO2IUHQEq78ngx4KSjgBhSTFCVeenS+BltIOLL1p5QFCACHt/s0N+y7v6QfrmNssVxi
         NMKHforqfB/6e/A32rGr3FeBHQWlM0rAe9yNcGcyouAKjBZ2yK280bap96rrg5/zFo+Q
         l5vw==
X-Forwarded-Encrypted: i=1; AJvYcCX2mwsT2ZHcM52JPDkOEQgQFEZ3PgT2bTUKk20jrsVxEv6Dqq6Aysr2t0tD9aBAu9AZ5+gZpoFB9dgaQtMw@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAYhOfI35oF9XYS8zI86EcC/IA0v9YX1PGGFLTXVqWzQvUpuT
	6lpVRCnrhsuXN9Fh0oOy8y+f8BN64kPG6zytHSRo+El5d/0rOXnl35+f
X-Gm-Gg: AY/fxX6VbEZEnHNeja7Pds1Q9zU7fFk7R4pJaXphs9YLFLDQl/pWM2gTNWtwTrT7nxJ
	50wsWDmolT54YQ6RRvZkSQx1TBN9xmsfCRBzpIycE4gvyRZQXol7MlMIpz5I5WXd6ll14nIE6KV
	MEu6oThoLSXSof+rjAx5RuheuETTXUds3yjjNB8jQsBBp+uTq0m16FTlsZqm1JW6hVxBrJsnDnU
	/wRqWJuOnRBgpDzJK8ThJ80oAsgcb+RlGTS4VKDABI4deuE7rJb73TGOrZbfWS8ujzw0Y6qoW3Z
	yif5wyZZrhLBnXqv8exTPdbYRCsWwYDnlTblA1bByPCZVFN/OdMiJQral1pMCi1OIt7PUodnF3J
	7ny6p/hBO+8u8ZYtkPyo5AuAfy3V6VvjkOBWil6hoIMrVQ0L5jpwF/nvKMki2ak+x9LdiFsDfE9
	GEvDSEKEGuaIQSU/RgiR+GNWAigBhtOriXstU+bA45eX3J30hxn6IAkvs=
X-Received: by 2002:a05:6830:8412:b0:7cb:125d:2a43 with SMTP id 46e09a7af769-7cfc8b6a6b0mr1787867a34.28.1768426628343;
        Wed, 14 Jan 2026 13:37:08 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ee883sm19811078a34.28.2026.01.14.13.37.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:37:08 -0800 (PST)
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
Subject: [PATCH V4 09/19] famfs_fuse: magic.h: Add famfs magic numbers
Date: Wed, 14 Jan 2026 15:31:56 -0600
Message-ID: <20260114213209.29453-10-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Famfs distinguishes between its on-media and in-memory superblocks. This
reserves the numbers, but they are only used by the user space
components of famfs.

Signed-off-by: John Groves <john@groves.net>
---
 include/uapi/linux/magic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 638ca21b7a90..712b097bf2a5 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -38,6 +38,8 @@
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
 #define FUSE_SUPER_MAGIC	0x65735546
 #define BCACHEFS_SUPER_MAGIC	0xca451a4e
+#define FAMFS_SUPER_MAGIC	0x87b282ff
+#define FAMFS_STATFS_MAGIC      0x87b282fd
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.52.0


