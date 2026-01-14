Return-Path: <linux-fsdevel+bounces-73833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D43CD216B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A8A3301FAF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08637F8A6;
	Wed, 14 Jan 2026 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYz2ovlW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287D37C111
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426952; cv=none; b=UU7kXdRVfBj+b/bbiBv6Lv0yde3BzemZzXSeDZ1oTTbDWREG2eZpiheUHV4JC3HevBmOWYYXOMTbSDhV/3vFFbEzCsDMDRHjfLybSOzxx76+WLGEfHahSGFjxLCcErdKjaaif+vnMNjqiubSLIUU+TfMktmm0Y+C86lDw05OEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426952; c=relaxed/simple;
	bh=VL5oOUiKrAPPvKr1vFu621tvVEzPIunWgTzSeWNY/A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPLax2EkZ+fGihQVdrYVktFEcPeuLvneCUlNkpQim8rABSO9Q4FWGXLgRTpo3+1J48Jpy/kWKxvyY3S1OtrVBxtHNRpp87h7+o0+ynVbjlua5mspzXWoz6saj5CQsQIS2noiJiivTduGPpl6lfff9dZ1Uf7eLSLYiawDhpJnkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYz2ovlW; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7cfd48df0afso179815a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426925; x=1769031725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAgvwt1OR9TYLgNznZNLzZ51Qby0qHLIemjsJLSQFFs=;
        b=LYz2ovlWQFptlGWfhp1NtFCWhUw28nQ1K+fgwBgaDZwO0Ms3a5ICdSU97gdn5aYKYi
         kM9ZUwHrF3kMPXjCs2vqrCfz4I4Xd/8m39x+Id1H6jof5Vsq+E8jTegX1iZ12Gf9uj37
         icurrqkHP0cQqdmL/XVtmtfEAPs38uIyl9zu2nAJY1TwKNOovK8trm+u2Laic+ulXRJN
         qkf4oKVkXVM6o7Fn5gMvVjOJ60LMGNUAHUrJFBDQYAWMkpRCCiJ42Du5/4Tvu4PKWTym
         bmqgYqkrT1xHMFonvp2YWjydP8Uu9JjWJ1dF/IBvHTG4Je/3CeUoO1PhcPwe1vuOsqeG
         P45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426925; x=1769031725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAgvwt1OR9TYLgNznZNLzZ51Qby0qHLIemjsJLSQFFs=;
        b=doAaI5S/Vz27hkiA0vU2rTsBpY468QU2VkZrnWVXvuvTAHhegnqxUGzUyhQzBhvXUK
         z0tC64XOgc9h9EvU4c81rwxYPshlCW6mWVFPd92a4DsDetcKFGD410O1IJ2yRJzZaVbj
         glA1kbvhr2it7o1aZxkaIpHx12U+Jk+LKWDp2jWGFATNG6db5YfRYfLSq/4Lb/HFtc4N
         hH+zDnhODBYr4FpBBuUhjJWFDC+ggoETGGXA4JulsZjaej4SVgPa04dippgssr+xzphS
         yubt7fP5EFE2EEozYwfnL3ibzV9DF7K694GtdNGFqXosUCYYIqhaeuq00kcrVobilq67
         62KA==
X-Forwarded-Encrypted: i=1; AJvYcCXvnXXVK88ekTddQKjzrZUMRS/SXXN8oJYGK1rX3znMPQ+GH3PPlG8frbpGzUfNHUhPhoS2FH95oZYwUT5G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6U8uq3iVeqhR0BsnSsDFC5K9tRmDDmmHZPitmdbZ14fd7Kx22
	SNhDgB/QA+t13r6xU5IoPafBaUq7YGJa8nNDsU/3sNwZ4C64ElcNfQvj
X-Gm-Gg: AY/fxX5GpOYv0uU46xSKTs0lMYTzFg9ZWk4yK/1kTSwENYh96p3691dK369cAofz+bn
	pJnhJnRI9NQnhnvvVfa5vdOkdPoPMANnuHVx1lXbvM2WwDF1JMaVJTfMWTWvn6Nl1ZEzQXITqDV
	DPOqC4ODJcIBZApex5MxwIQJJfcpZvsZ05vrWgYo+hXMACkpVdSh6oNx/2og321ZuF49Hkr7BsF
	tpTxJy+urfMjYXTPrEItNOXphLeFfD9uveWqGsqSvVNK5c5r5M1SvLQmo57Gq//amYAM2gzF18m
	1KX1LHznWdHqpH6go3eYKYhRww9F1TOOdlmBkfGV+mVZa/q5FMYzUS5yhDQDO+QsAzqbiaKD0es
	B7WUC/qONaTSZEwEXkqKeaQRIFcSQdRWPP6FjfPM/w/zQ3nI91/IX5Rg9qmIrCKiJSbsAq2BMgx
	kReyc2SMaJn/lM2VDoyBrHXonLrEsvg98eLLWbHE4ZmXpg
X-Received: by 2002:a05:6808:18a8:b0:44f:94ef:baa1 with SMTP id 5614622812f47-45c73d673c1mr1898228b6e.22.1768426924855;
        Wed, 14 Jan 2026 13:42:04 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ee883sm19819637a34.28.2026.01.14.13.42.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:42:04 -0800 (PST)
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
Subject: [PATCH V4 18/19] famfs_fuse: Add famfs fmap metadata documentation
Date: Wed, 14 Jan 2026 15:32:05 -0600
Message-ID: <20260114213209.29453-19-john@groves.net>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

This describes the fmap metadata - both simple and interleaved

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/famfs_kfmap.h | 73 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
index 0fff841f5a9e..970ad802b492 100644
--- a/fs/fuse/famfs_kfmap.h
+++ b/fs/fuse/famfs_kfmap.h
@@ -7,6 +7,79 @@
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
  * The structures below are the in-memory metadata format for famfs files.
  * Metadata retrieved via the GET_FMAP response is converted to this format
-- 
2.52.0


