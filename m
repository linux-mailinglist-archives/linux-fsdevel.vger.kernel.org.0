Return-Path: <linux-fsdevel+bounces-53840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005AEAF80CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920F7483CFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBDC2F9494;
	Thu,  3 Jul 2025 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiqTCkpC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066D2F9492;
	Thu,  3 Jul 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568700; cv=none; b=tEwxl91dpQLSJqglIJdYQPngcYcfwtBroyl9ADxGWF6li4mwqbpvA2jbaYNAnCMg/QxB3ZPjMu2Ig4UkiEK28SMXt9Vy9qGf2+1GkGAmw4C90gHehmJ6Vkwg+p2sJP8LazauFZZr85enTAXG7mffgCJbHYXcAdxNbtRvjOMsDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568700; c=relaxed/simple;
	bh=nISANB0XlQ0BLoj4/fUTHodInegZ2G/VHJowR2UMMe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQrZXM4kSeZEMcZSKZfPAu+/5Xpl/2HqceWLGmeA24xiNU4POX7i1Z4qNFuj+p6nkM2CJMNI2UgV+m73K5MdUgv4SwcbcfQXjF0PeCYYb3iEfZechy/FSZIXvaHWCWX9ngiK3ikCzK5FmCiXoCiIAhp73xJ3R/NuOdvnHRLfcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiqTCkpC; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ea08399ec8so232630fac.1;
        Thu, 03 Jul 2025 11:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568696; x=1752173496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P2ebQHmA7kMFafoMqaSVOZx8bY3tIBj6NaPdz6n/Mg=;
        b=OiqTCkpCzqTPAHGzSORGblX6AIYQXG2kJUj65O0TnlEZki8x9xKgLwAR/u0GQgD/N7
         5SVTXbHbfYusduE7yyvu2HCcoxM9jdJO+JT4S0thFklfvvA7ikMNJ2Pm7pfq8/4uW941
         jGjhQ3AEpmwwn9caSnsW66XtOAXyZR9wR34hiRsoatY/Iy/OtWdCVRuFzK4d6nDCVLaV
         R9FzMy059CFj/IKauQmTd7b7FoPZ6YVA2D2U59BSE2Qdpcb7igy6dBUkG3Wx4X439oxt
         ZFmtCr2TEwVwwBtj0n7od5nvBlGofSIvURLa/WL4gY01pIJuoJ5pMdCHkAczo9J46Zma
         FurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568696; x=1752173496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4P2ebQHmA7kMFafoMqaSVOZx8bY3tIBj6NaPdz6n/Mg=;
        b=ab/Ja6ZxzXyyaSVFnUlbbAKtAGeXwZRgIVrH2LibgD8YD7dz4NvD/J3PpYypsazPU9
         laiuFC1RY3sPruROBXd5fOJ9A+u/Yswj02xQpEK2gX7sX3jC86QXNPDivIy411W8EQIM
         jZuir8yNPZ9cg1n/dPP65Uf4WCyqHpRVPMrotjcR9CtWUXSP5V1aInRjewRD6iZgZge1
         4e1orqnzqGLfXeKgPiUnR8+7hCQFPtvP3MeH0gZAgnYohEV7rYPNb643Iq+FIfsy42tP
         bRrSPvfFjGOPf8n6Nt7HbtEYatmgWpaS7k0mkjgRo32/JykITObK2udMDj30jfysJDgp
         3PLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWKuM7XCtgBlZFz17v+3bvNImz6sNrqyLZcWmEZHxmXKLtlSmRPoLb7Cda6R36lO2VVp79C7jRbzghtZHD@vger.kernel.org, AJvYcCUmUf6Vi84v4NJEwaCcWt7rGSI5PSbsU2Xf1/rieerNbqyXWJtnjVb2NaxE1ISHUkAeAuaMsMQKQkZAcLhFcQ==@vger.kernel.org, AJvYcCVBlUQKXVgwMwWA/qAjJyqnFPuphz1OFxaH9erKfy3Ls79HP9b4IKTjANhlGw5BwDsKb/rGCW3p0XDg@vger.kernel.org, AJvYcCX/JaB7LHfmEc3cyZ6Lq41mylq1H+2lXqH4WBDplbA9OoaeVXH7rwvP2q9E49/JMXgG17Hg48j/ye0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5pk9LJAqhgXifokrRFmIHnr5b40UFMq35V3aZFMxVSH/DWuhs
	bXi5FC5GRFjlBTh6PW34IZ99dbgaZKejLprDG0Nm7W/eeVBMa1unU1dp
X-Gm-Gg: ASbGnctSoW9JjMu+/l0LFilrWBL6HeoYKkwEq8WpQVmCPbEwlIQJ1km6RtuBC4osd35
	jNPHruqfHHockJ0HCV+kWXpiyXvwo1y+mFZ2pQPe2Gq7kk2KPJv2ym7geUr+S6F5Nbw8iNgvdxI
	wkqxEcaypFd/tkMCIE1znnD2IcQtPD5PvYPOiG4WPbhiQIgFGdiej+jDuYc7iDFZ6DYlXVdxzar
	R1fCgkKpUk4GhsEAL7sDbFD78qIhz0uXnz9l65pQ2n8O7OM3DgyC7ENVaPT0+d+UMgA/hzr0V/E
	Lwxtb90QDWP2lHrjuYZcxCIytavSrm78///bKJKCWOeV+rspgwimx5e+ire0eJWjXPhEHG7gaUL
	Cw0xO50rMBTzScw==
X-Google-Smtp-Source: AGHT+IFnaohm+1vpUnTkm3zoIOdovIzr+/8MuJ2xXxfmzv2Todd3FjvaTkrldDEH046PZ67gRIosKQ==
X-Received: by 2002:a05:6871:68a:b0:2eb:87a9:7fc5 with SMTP id 586e51a60fabf-2f791de6e45mr6858fac.16.1751568695843;
        Thu, 03 Jul 2025 11:51:35 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:34 -0700 (PDT)
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
Subject: [RFC V2 17/18] famfs_fuse: Add famfs metadata documentation
Date: Thu,  3 Jul 2025 13:50:31 -0500
Message-Id: <20250703185032.46568-18-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

This describes the fmap metadata - both simple and interleaved

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/famfs_kfmap.h | 87 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
index f79707b9f761..2c317554b151 100644
--- a/fs/fuse/famfs_kfmap.h
+++ b/fs/fuse/famfs_kfmap.h
@@ -7,10 +7,87 @@
 #ifndef FAMFS_KFMAP_H
 #define FAMFS_KFMAP_H
 
+/* KABI version 43 (aka v2) fmap structures
+ *
+ * The location of the memory backing for a famfs file is described by
+ * the response to the GET_FMAP fuse message (defined in
+ * include/uapi/linux/fuse.h
+ *
+ * There are currently two extent formats: Simple and Interleaved.
+ *
+ * Simple extents are just (devindex, offset, length) tuples, where devindex
+ * references a devdax device that must be retrievable via the GET_DAXDEV
+ * message/response.
+ *
+ * The extent list size must be >= file_size.
+ *
+ * Interleaved extents merit some additional explanation. Interleaved
+ * extents stripe data across a collection of strips. Each strip is a
+ * contiguous allocation from a single devdax device - and is described by
+ * a simple_extent structure.
+ *
+ * Interleaved_extent example:
+ *   ie_nstrips = 4
+ *   ie_chunk_size = 2MiB
+ *   ie_nbytes = 24MiB
+ *
+ * ┌────────────┐────────────┐────────────┐────────────┐
+ * │Chunk = 0   │Chunk = 1   │Chunk = 2   │Chunk = 3   │
+ * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
+ * │Stripe = 0  │Stripe = 0  │Stripe = 0  │Stripe = 0  │
+ * │            │            │            │            │
+ * └────────────┘────────────┘────────────┘────────────┘
+ * │Chunk = 4   │Chunk = 5   │Chunk = 6   │Chunk = 7   │
+ * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
+ * │Stripe = 1  │Stripe = 1  │Stripe = 1  │Stripe = 1  │
+ * │            │            │            │            │
+ * └────────────┘────────────┘────────────┘────────────┘
+ * │Chunk = 8   │Chunk = 9   │Chunk = 10  │Chunk = 11  │
+ * │Strip = 0   │Strip = 1   │Strip = 2   │Strip = 3   │
+ * │Stripe = 2  │Stripe = 2  │Stripe = 2  │Stripe = 2  │
+ * │            │            │            │            │
+ * └────────────┘────────────┘────────────┘────────────┘
+ *
+ * * Data is laid out across chunks in chunk # order
+ * * Columns are strips
+ * * Strips are contiguous devdax extents, normally each coming from a
+ *   different memory device
+ * * Rows are stripes
+ * * The number of chunks is (int)((file_size + chunk_size - 1) / chunk_size)
+ *   (and obviously the last chunk could be partial)
+ * * The stripe_size = (nstrips * chunk_size)
+ * * chunk_num(offset) = offset / chunk_size    //integer division
+ * * strip_num(offset) = chunk_num(offset) % nchunks
+ * * stripe_num(offset) = offset / stripe_size  //integer division
+ * * ...You get the idea - see the code for more details...
+ *
+ * Some concrete examples from the layout above:
+ * * Offset 0 in the file is offset 0 in chunk 0, which is offset 0 in
+ *   strip 0
+ * * Offset 4MiB in the file is offset 0 in chunk 2, which is offset 0 in
+ *   strip 2
+ * * Offset 15MiB in the file is offset 1MiB in chunk 7, which is offset
+ *   3MiB in strip 3
+ *
+ * Notes about this metadata format:
+ *
+ * * For various reasons, chunk_size must be a multiple of the applicable
+ *   PAGE_SIZE
+ * * Since chunk_size and nstrips are constant within an interleaved_extent,
+ *   resolving a file offset to a strip offset within a single
+ *   interleaved_ext is order 1.
+ * * If nstrips==1, a list of interleaved_ext structures degenerates to a
+ *   regular extent list (albeit with some wasted struct space).
+ */
+
 /*
- * These structures are the in-memory metadata format for famfs files. Metadata
- * retrieved via the GET_FMAP response is converted to this format for use in
- * resolving file mapping faults.
+ * The structures below are the in-memory metadata format for famfs files.
+ * Metadata retrieved via the GET_FMAP response is converted to this format
+ * for use in  resolving file mapping faults.
+ *
+ * The GET_FMAP response contains the same information, but in a more
+ * message-and-versioning-friendly format. Those structs can be found in the
+ * famfs section of include/uapi/linux/fuse.h (aka fuse_kernel.h in libfuse)
  */
 
 enum famfs_file_type {
@@ -19,7 +96,7 @@ enum famfs_file_type {
 	FAMFS_LOG,
 };
 
-/* We anticipate the possiblity of supporting additional types of extents */
+/* We anticipate the possibility of supporting additional types of extents */
 enum famfs_extent_type {
 	SIMPLE_DAX_EXTENT,
 	INTERLEAVED_EXTENT,
@@ -63,7 +140,7 @@ struct famfs_file_meta {
 /**
  * famfs_daxdev - tracking struct for a daxdev within a famfs file system
  *
- * This is the in-memory daxdev metadata that is populated by
+ * This is the in-memory daxdev metadata that is populated by parsing
  * the responses to GET_FMAP messages
  */
 struct famfs_daxdev {
-- 
2.49.0


