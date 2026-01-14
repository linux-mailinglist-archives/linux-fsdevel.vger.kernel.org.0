Return-Path: <linux-fsdevel+bounces-73850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91EAD21B77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 00:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB525300E8D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881E34320F;
	Wed, 14 Jan 2026 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzSQnAX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24A30EF87
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432339; cv=none; b=YG39GXIzCwJNkKZY+wIy7Tal6k2FPEzhm3R3Bpsv66jKeZzc8qT0XY1n8ut2bZVLMSZaW7RmEh0ufERlu5N+n1dzIb4t/v5Kafj4gph9p7K72DXUKCczunouoexsjgUvRUjVP5FldDLwYOow+8vrPTugi2paqwXxDx+16n7yIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432339; c=relaxed/simple;
	bh=zG2TyLnXjDP5W7454KU8fBzg3dWWFM4U6U41q0cfD0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew+FqQXia0g0fvylRGyxJSl+0kVLs6DunPsngZbgd/kNhpOFS1hLFm8ZjJ+YiiRTR6IFJHv6MbLTqEHcJZCsNtCPA3WQNL4G4EPle7LcX9/qM0U5Upc9UD9jTj7/HG7AP4BZhs2QOx21xMDT0LXeJzj+XJILyHXcNnM2EjAhyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzSQnAX3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c5389c3d4cso36786885a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768432337; x=1769037137; darn=vger.kernel.org;
        h=content-transfer-encoding:libfuse:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUX1Xqe9Ih33TiO90xcxWEJ1pXhMadrkogKYy+yJV2U=;
        b=KzSQnAX3SFP7UvkzmVQcsOcYwY7HH1MYiO+M6lcnLcZhlBRhAh+lJLZBK1oI7Fyvj5
         mkmonQfPumH/ZrX6eQ6Wh9ONdwbuRiCRIo745gaHrmImyrGhRJsOVMHBojTwtZZKDXaZ
         q+ymzlkANpXm0FvUaeFCyRFeZ4qT3li18NLb7qc2x+I92h7KcxNY7mLH/FJTIs07yqLo
         7CE0aWFdiXT4YFx6qd4eDWDOghIcLU9PvMODwBU6eoP7HxS1ydUjgR+86q1sdPvkVxDO
         xjpOdKYv4IcOAW3hveCDoCNF2qCuL946apxb0IQITWACuJnstCGyCSqYw8ZlyYzOQzad
         ETqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768432337; x=1769037137;
        h=content-transfer-encoding:libfuse:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUX1Xqe9Ih33TiO90xcxWEJ1pXhMadrkogKYy+yJV2U=;
        b=CPklahFAqQ1XFaBOWwWwCDskBVGXoPdEi6cnYrZaRyAJtQa2V2IyVseQ6g5Xf624TM
         h5rXKMuLM6TK76IFETYL4RlwcZ17W733mceWvvamuR8SP4U1buZmZOlo+oy/ZPxU5VaR
         0AAYYLCsFxBv/UyVVNLugNEnZo5lvjThT6GiN4N3BRyvvfa0vuBRMT1Qfe8vXD1zV8HL
         Z4qLYNFDjcesObND167+gKODn7F6Nld7cNGRyxYGLq74MQ5AgcxAKN+aaL52vYmbM/lC
         5eBYGKZEzUPogN31jBwS3O567MR8sfMu3V9u/c6lwvPd/JI0dAy/eyoLFtnnFUffjZTO
         osRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaYxkARiyLkKd7dCEEq6XNtatLhqJxZfJ9iJOyHX1ZgPAEOnfKd76aeHJUnx8kkXUKY+Iy92Oe8KivTL9c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3PwnQoHHACqMkUqnwW/WhIeGtGSBLz/ANmS1uP5IIuecyf0L
	L7DrlibiKAL9piQ6JT+k0XW7tJRoQgX6ugf99n2ebTwcSD7KPisWSbeaH1JDWA==
X-Gm-Gg: AY/fxX4o1W/+0W0GlGuKbDVdUkAdqQ2x6da3tHWla2vj4Ts7IpESIgWh7zmC4Vc30p+
	6c9YM3v5heHDvgE1RpwVz03O7fYYg3qhnD9kKodWvY1tdpAGBqYmehUgzzL8aXZUY0jynlcyGYz
	d2o6qii9ZXHUsPlvy4mNGorwmorLrZg0imF1otMUSTBY+Vzh2IWRFnWYWlhQN5Wde1Aw3vXTHXA
	/AIAWe9B1zkj4YTqVwxTd/c3Swjdn4sEJJo8UOUNISry2SRohaqaz5o0mSnIxMUFrM0KOnMR78C
	nlSEoBra7peZUekIFw+Bfo0Hhq/byXC7BiCBhGPV8gTfL66XkUmOv3M/O0At8C79RU3zYTMy5dt
	emG6hzMYKXIrgMqGOC12B6necLfF3mgfjh/dYfhUNSaah8usCw3riDW2Ou0V/bbCGoHCuINfGZ5
	rv/I4gwPyLx2/2N+LhuBMemBgEb/LPqswYDWf/s3l/Z73S
X-Received: by 2002:a05:6808:f8a:b0:450:d833:6bb6 with SMTP id 5614622812f47-45c73d65f1amr2396599b6e.30.1768426990473;
        Wed, 14 Jan 2026 13:43:10 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e1b0779sm11316868b6e.7.2026.01.14.13.43.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:43:10 -0800 (PST)
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
Subject: [PATCH V4 0/3]
Date: Wed, 14 Jan 2026 15:43:04 -0600
Message-ID: <20260114214307.29893-1-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114153133.29420.compound@groves.net>
References: <20260114153133.29420.compound@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
libfuse: add basic famfs support to libfuse
Content-Transfer-Encoding: 8bit

This short series adds adds the necessary support for famfs to libfuse.

This series is also a pull request at [1].

Changes since V3:
- The patch "add API to set kernel mount options" has been dropped. I found
  a way to accomplish the same thing via getxattr.

References

[1] - https://github.com/libfuse/libfuse/pull/1414


John Groves (3):
  fuse_kernel.h: bring up to baseline 6.19
  fuse_kernel.h: add famfs DAX fmap protocol definitions
  fuse: add famfs DAX fmap support

 include/fuse_common.h   |  5 +++
 include/fuse_kernel.h   | 98 ++++++++++++++++++++++++++++++++++++++++-
 include/fuse_lowlevel.h | 37 ++++++++++++++++
 lib/fuse_lowlevel.c     | 31 ++++++++++++-
 patch/maintainers.txt   |  0
 5 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 patch/maintainers.txt


base-commit: 6278995cca991978abd25ebb2c20ebd3fc9e8a13
-- 
2.52.0


