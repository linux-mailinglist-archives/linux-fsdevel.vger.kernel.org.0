Return-Path: <linux-fsdevel+bounces-47428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56DFA9D692
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A87924EAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2165618E743;
	Sat, 26 Apr 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvyos4RA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561118BC0C
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626216; cv=none; b=X4wCDV1LZ0J9/TLjpLG3mUefkzsPBgIiCEN67mb/2Rc0msqaHn5cieZdR6SRgjUeLo1yBPGwAjNgLAwkVdTLES/ccAlfs5tLEw5ExHlfT14doamPVc24+J8baeFvVbBBfLQOg/7houZtrxM0eGCdSw5cLm1K5mB3EnAUinJvhzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626216; c=relaxed/simple;
	bh=C7rY5GBUmwBHU1FGK+0Ue5TM75TjEwtvfgkAIk1+Mx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XukJ+hXE/V+AQXPcMWF7gIbRM3dVQMWp0nkry5ciFICFv7kpvNLV81/dRHrD8gZr6oLXmWcvfmkb3HX65rYkFl73fI0Q/rM+5ZD2L30t1OcEbQx0Ngy2NCmaSXLnuftXZoZCj5YlmCkByX5jlnoDdAKonwXZSHaWa47y89t1q4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvyos4RA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7398d65476eso2397355b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626214; x=1746231014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMy8KL3+qDYpmC0o3ViPMYozS32OsYIIS5pnyIAs9wE=;
        b=mvyos4RAHnjXFs+XRst4rBSkmEzjAwEbN+MbRKWZdazoL1RZ0TQoeU6s9Zr14VyJbi
         kwQHmCWvlpOUALYUqh4ijEwFX9NPpSJp8SKAZWxi9xjydetGH/9JA/YnXbuGYvT72Voe
         M1bIdegoxCIWemmxSlASWSH8Rt9c2R5LcfTgP3sSHF2A6Af0E/87jpKTrXev0kZ+7Ll/
         LOljxrDqcdWocUkb0Asz7lcY6rj3oLdoB079fMi6teaNaK/46F5HJ1oStiy9A7L8j9ih
         L3ZPtWnAPa6eKXVYgfUiiz2HjPm8WLeS5FzEBn5FoO23JGcaIs2ioStKGV4zrgl6FkHC
         n17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626214; x=1746231014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMy8KL3+qDYpmC0o3ViPMYozS32OsYIIS5pnyIAs9wE=;
        b=Yiejpqx54osF5aMpI2rLChXaMCfjR/IaebGfRqzdWUWGXpbutUO9RNdL1otNwuJVjt
         KuPT0Z3/cd5f3In6eKOHFUw+hEIs7S7JnEA0D/Sg6BKeTuy24Xe+Atcl1Jf8k/NIiwj3
         VZG1mf/tpbtdGvTt06WFqDKkBS5aoSVXHbf4DkKqNIhchKjO9pqShZyY16Ihej0xNwcj
         jOJvPW3RZoEl0C78Kyhnngp8tE9CDPV3dG+NOYbbJji6+OEaaZXzXfa2OXBpGtD+X7kC
         rqaVPdhUEgbaRSHA/hbkPvsrCwkvCbBx+UF+suK8BV+PXb9MbMykrnaBVWuC2ot1mpV5
         +00Q==
X-Gm-Message-State: AOJu0YyRmOinBW2K+mLOWPUGSs0yDafVFbqZ+ViIASf02xVxMAEHQifp
	YbAtS92nPrIOpU8zYeoZ/eNp5HjTEOp7nR9MPrUitThqNaBsLXiP
X-Gm-Gg: ASbGncsSnDJ5r5LMW6Z/o3JXkI3CKkCdwbD2I+cXIjRAFM5qdSYnNq6oebdtcgxSyhM
	vxFGbF1NGnUnh8INzHsBMrwNVtOupDS4M2hr7nNNP8a3aR3GdmFOM86gxk8XbaZpvDDB5eIha1o
	CP1YaSMQ2tas17u1JZXs4eFviuUpfCQMFTRCEO3IfGTgcEsdt2IrrtXIZ7f0DUHIZ3M4o9AXVFv
	kQ5ovFmh2FHLDfAsija0dXHdsIyTpinlcC3jeg8DrWtO3HJVH1GyBAbN+r4Rr4BYoOYHObH4lrJ
	L/F7HN0OhRefrGeIlWS4Ook2TE6jTs80qyTZ
X-Google-Smtp-Source: AGHT+IFyWd4gQhtsOCIzmbLnsWMJsz/PhL5G4tQYQAQHhNEbAhKPERDpz/fXDKszHdOB5P/uHebeCA==
X-Received: by 2002:a05:6a00:843:b0:736:bced:f4cf with SMTP id d2e1a72fcca58-73fc63ffda2mr6084981b3a.0.1745626214302;
        Fri, 25 Apr 2025 17:10:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6e252sm3770538b3a.119.2025.04.25.17.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 05/11] fuse: support large folios for folio reads
Date: Fri, 25 Apr 2025 17:08:22 -0700
Message-ID: <20250426000828.3216220-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for folio reads into
the page cache.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e44b6d26c1c6..0ca3b31c59f9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -793,7 +793,7 @@ static int fuse_do_readfolio(struct file *file, struct folio *folio)
 	struct inode *inode = folio->mapping->host;
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	loff_t pos = folio_pos(folio);
-	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = folio_size(folio) };
 	struct fuse_io_args ia = {
 		.ap.args.page_zeroing = true,
 		.ap.args.out_pages = true,
-- 
2.47.1


