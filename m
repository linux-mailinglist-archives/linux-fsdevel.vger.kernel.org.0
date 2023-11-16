Return-Path: <linux-fsdevel+bounces-2987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685197EE8BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 22:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F5D1F230D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E9346531;
	Thu, 16 Nov 2023 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m9bZmFaK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [IPv6:2001:41d0:203:375::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891F9B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 13:18:29 -0800 (PST)
Date: Thu, 16 Nov 2023 16:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700169505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S3w7F7FTyUlc6SpBfGexPQfd+IQlL6+uxiGQCbZXlX8=;
	b=m9bZmFaK7SyE3ZbXTM4OjHut/p3uYn/YlIM0DYkKx1JUNdx04CIqYDL2QQkA6Q9NMqbyL1
	LV6O4RDm96SYaDwYhBQo5Dth7mUnz+bdGfIZpoofrk9KLThJU5kPQI4gtCRAlJ+EKEcRIq
	vPECi5aXdmPTC3PGm+GqnbgtVJ/nRgE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH] fs: export getname()
Message-ID: <20231116211822.leztxrldjzyqadtm@moria.home.lan>
References: <20231116050832.GX1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116050832.GX1957730@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 16, 2023 at 05:08:32AM +0000, Al Viro wrote:
> (in #work.namei; used for bcachefs locking fix)
> From 74d016ecc1a7974664e98d1afbf649cd4e0e0423 Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Wed, 15 Nov 2023 22:41:27 -0500
> Subject: [PATCH 1/2] new helper: user_path_locked_at()
> 
> Equivalent of kern_path_locked() taking dfd/userland name.
> User introduced in the next commit.

also applying this:
-- >8 --

The locking fix in bch2_ioctl_subvolume_destroy() also needs getname()
exported; previous patch provided filename_path_locked()

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/namei.c b/fs/namei.c
index eab372e04767..83dd8b51995a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -218,6 +218,7 @@ getname(const char __user * filename)
 {
 	return getname_flags(filename, 0, NULL);
 }
+EXPORT_SYMBOL(getname);
 
 struct filename *
 getname_kernel(const char * filename)

