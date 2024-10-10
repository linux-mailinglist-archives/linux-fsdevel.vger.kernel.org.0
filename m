Return-Path: <linux-fsdevel+bounces-31604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA9998BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879241C24968
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD01CB502;
	Thu, 10 Oct 2024 15:39:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950D136E23;
	Thu, 10 Oct 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574761; cv=none; b=tq3cAwMWmHbeCsdiEDCliXxGdUoZyUrs7tDOC2bDBAn7cXbYjjOaEsM7NnV1GQij403IXV7B4DH1RiLeJBjwmrXLTqFO6KxWh1O58BpxqAZsV2Tu9eFkme3Ob0Ux8gvElcRlR1MAocl1b1S221jKUr5EAaq5wkA7iP78LMz9uI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574761; c=relaxed/simple;
	bh=amHeT6yQgf6a6sVKtudnarhicorch2Icn8I1kRYqL+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=e+0FfzEFBolXn5chtnxbGZ/+Q/9xe9erqFfdm9aUzh2tp6FxdiW9HG60OMDNRGNxcljsoGn98a/clJy7wX9uwRSt1kqq58Mo7kIeMtDrUrOpHxz641DbNeVZD3STvBMAEvmskv0Awv3LiQvasKVdem5oHEN29TjfLHBmpDiJTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1syvDg-000000003yc-13VW;
	Thu, 10 Oct 2024 11:36:52 -0400
Date: Thu, 10 Oct 2024 11:36:51 -0400
From: Rik van Riel <riel@surriel.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: [PATCH] coredump: add cond_resched() to dump_user_range
Message-ID: <20241010113651.50cb0366@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

The loop between elf_core_dump() and dump_user_range() can run for
so long that the system shows softlockup messages, with side effects
like workqueues and RCU getting stuck on the core dumping CPU.

Add a cond_resched() in dump_user_range() to avoid that softlockup.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 fs/coredump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 53a78b6bbb5b..14c385ffbcc9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1020,6 +1020,7 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		} else {
 			dump_skip(cprm, PAGE_SIZE);
 		}
+		cond_resched();
 	}
 	dump_page_free(dump_page);
 	return 1;
-- 
2.45.2


