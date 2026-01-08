Return-Path: <linux-fsdevel+bounces-72823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66208D04054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB48331B6FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C047A97C;
	Thu,  8 Jan 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="JuznX+vF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B3479C41;
	Thu,  8 Jan 2026 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873546; cv=none; b=o/3ewqQxNwQRtQWElT/aA9ARdxjE4BsUmnjBKHAXfyEA5vUfUDy2Op3l/GzZsHTDjXrclczQJCttUTGpqSOO6nQolf8V4SaID4l3eQpep5gUvWaqZx4z1HSxHGze0A5l6btuqKhedBuMxvYf/SAEDrrIPjqVTMKpOP8LA3Tq2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873546; c=relaxed/simple;
	bh=Rs4iG22OlFUdQTj4wpJv3/YScVaxsRMoexgeZRYudp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDJHaPtFg/fYUTGIHeZBcZ/bU2o4A7RsPOZRp1Qu4xUIA3VmmniNTtX66JjmXLFp/7rmVea+db6SRlhmsB06ienxLJ78yL+qg0kwhXkJ/aQLMp++moDXN38Em4zgXc/tWRFQq6ETdCuurcQRlAaIgJdhotHbA2QJGnEDKuBwheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=JuznX+vF; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=I3FOrv4m2znxV4qlM+WnCeu3LVaPQpQlPbX2klzxAX4=; b=JuznX+vFraiv6t
	+4oredUfPHB4ie8mxNkz1JTfkFShhdoks0P6DCXr5QXaOr/4m++rY8PhZZBlPTA/TmWs7LB/2RvAT
	E9FP5mp2+9YR8BGqT5UDQ24p8g+DPuOBAcabFw5fCVcFPEmTWzJy4U5S3keW3fMcr/5AYJ9N0kyE7
	1lVUCXYMx+hMgsj+GHID51lQHgoyVtZVIeFvp+1aC41Go1gFJ12t0LMHJtjxH9VJv6MOMzt8nMao/
	kBFnIViS5Ye1fyzTQFE/2gE8EI9SRyy9lGfIdnlAdbVxiz64kXlkqSmF/n4Iha5/F913zm8TBw8zs
	qaGQRvIUp+Tp7adHZjWg==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdofK-00AbI7-8D; Thu, 08 Jan 2026 11:58:58 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vdofK-00000000zvM-017C;
	Thu, 08 Jan 2026 11:58:58 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jack@suse.cz,
	brauner@kernel.or,
	viro@zeniv.linux.org.uk,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] fs: add <linux/init_task.h> for 'init_fs'
Date: Thu,  8 Jan 2026 11:58:56 +0000
Message-Id: <20260108115856.238027-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The init_fs symbol is defined in <linux/init_task.h> but was
not included in fs/fs_struct.c so fix by adding the include.

Fixes the following sparse warning:
fs/fs_struct.c:150:18: warning: symbol 'init_fs' was not declared. Should it be static?

Fixes: 3e93cd671813e ("Take fs_struct handling to new file")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 fs/fs_struct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index b8c46c5a38a0..394875d06fd6 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -6,6 +6,7 @@
 #include <linux/path.h>
 #include <linux/slab.h>
 #include <linux/fs_struct.h>
+#include <linux/init_task.h>
 #include "internal.h"
 
 /*
-- 
2.37.2.352.g3c44437643


