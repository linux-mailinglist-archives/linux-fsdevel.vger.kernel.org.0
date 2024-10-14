Return-Path: <linux-fsdevel+bounces-31924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9861C99DA63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 01:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B9CB216B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 23:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C391D9A70;
	Mon, 14 Oct 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM5lsxX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75251E4A6;
	Mon, 14 Oct 2024 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950198; cv=none; b=CbOg0OB8xZUcfysT9Ff1/8U25fQqfD5nyQmui2MPUctP9dP1GPnVs8Dx7OrpVABlJk5AGIPiZBBl2CU+9jFeFFPnybey1ASeZ4WHKqF7r32IeJNYYhD6DfUYIbrrEx9nScpK7Rf9h4J+9pmFhguCfQ9PLperKKG6NmPMYCCa5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950198; c=relaxed/simple;
	bh=U4KipJqaa21PVWg2nkw8vmlBA7OYh1syNZ+kKe89Pzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QycxUU04JZS2P4GG5CknlgdnXdcAG3OIsOTqKv+2FBiD8bcHKjqX6dSupLnY3K/HhwwmmuRn7+O/qQ9o0U2bOdwhEiH40sufi0Zpisux6JaA5fiupq5EEZCytSYdcBp8D/ngLnC+ogeh7ljNcwVZkv5c37RHdbztxYNM76rXFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM5lsxX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D559C4CEC3;
	Mon, 14 Oct 2024 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728950197;
	bh=U4KipJqaa21PVWg2nkw8vmlBA7OYh1syNZ+kKe89Pzw=;
	h=From:To:Cc:Subject:Date:From;
	b=KM5lsxX0MbEXefew/Zg2IZ/hMNXTfetmmW13O8z74ZB2Yjaw1RXzFLJJuwZN0HZTp
	 skB147giKv7NJ5duoo67OmQKRvNbdSmmA0R/9m+Iskv3htihzZDpHSv+Z+051+rjUr
	 ojqz3qJ7qcsOzo5QyTYuhCzUK1H7bTMWLynW48pS9XUIz0bbxd8T8tH9dabr7o8Mo/
	 1Hn+0rkIgd6HpcocshWUJM/xEEzeeX1DtWMEi5TbHmMjq0qklH+3dOGjuVcpn92zeE
	 xUDAHfV0hRp98RCf6icFYUhi9yh/lOUFbhEGTHSGZWqCvkhjZ25g8+rEROaxsawmr3
	 SjgJH9YBYv7PQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
Date: Mon, 14 Oct 2024 16:56:31 -0700
Message-ID: <20241014235631.1229438-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From memfd_secret(2) manpage:

  The memory areas backing the file created with memfd_secret(2) are
  visible only to the processes that have access to the file descriptor.
  The memory region is removed from the kernel page tables and only the
  page tables of the processes holding the file descriptor map the
  corresponding physical memory. (Thus, the pages in the region can't be
  accessed by the kernel itself, so that, for example, pointers to the
  region can't be passed to system calls.)

We need to handle this special case gracefully in build ID fetching
code. Return -EACCESS whenever secretmem file is passed to build_id_parse()
family of APIs. Original report and repro can be found in [0].

  [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/

Reported-by: Yi Lai <yi1.lai@intel.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/buildid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 290641d92ac1..f0e6facf61c5 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/secretmem.h>
 
 #define BUILD_ID 3
 
@@ -64,6 +65,10 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 
 	freader_put_folio(r);
 
+	/* reject secretmem folios created with memfd_secret() */
+	if (secretmem_mapping(r->file->f_mapping))
+		return -EACCES;
+
 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
 
 	/* if sleeping is allowed, wait for the page, if necessary */
-- 
2.43.5


