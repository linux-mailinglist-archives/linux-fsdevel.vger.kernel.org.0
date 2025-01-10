Return-Path: <linux-fsdevel+bounces-38876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0818EA095BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C5C1890110
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820E211A0F;
	Fri, 10 Jan 2025 15:29:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D322116E6;
	Fri, 10 Jan 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522955; cv=none; b=R1XXuA7XMuBmZolznptuoxICPFuDsw9rVFTaHC02YHMC2EwZdfq4lfLlchDcnVvN9IWAp1v8+v+006a68d0NYdVofwSuBrpUMVpZu5VEi5hzFBr4fMa+OrJwA8Vpgmc4R5b6fi/a0RTl2i9H4ZDCl1LMXY6q0lSnvlZqaC8/0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522955; c=relaxed/simple;
	bh=fA7u/sj4d5vsG9CKpJVF/T8byYGfWbiukTlRhhxzfJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RW8qtdwY8vuUwNh3LpqV8ZE/8bOgWuWXhrSTU1S6UgfJ5XQMnKWeWkkznBVN+MCAbjAVXE+8ZNm10eQKnsj5wPoMzzA2i3/h5sIqZgF4Oa/OanJIAST2flIqZHHzhVnwELaQv+B84kY+810HYv3k+jVDYUwpl9lsgXkEVXZIBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tWGvy-0000000037I-38in;
	Fri, 10 Jan 2025 10:28:26 -0500
Date: Fri, 10 Jan 2025 10:28:21 -0500
From: Rik van Riel <riel@surriel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, kernel-team@meta.com, Breno
 =?UTF-8?B?TGVpdMOjbw==?= <leitao@debian.org>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc: fix softlockup in __read_vmcore (part 2)
Message-ID: <20250110102821.2a37581b@fangorn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

Since commit 5cbcb62dddf5 ("fs/proc: fix softlockup in __read_vmcore")
the number of softlockups in __read_vmcore at kdump time have gone
down, but they still happen sometimes.

In a memory constrained environment like the kdump image, a softlockup
is not just a harmless message, but it can interfere with things like
RCU freeing memory, causing the crashdump to get stuck.

The second loop in __read_vmcore has a lot more opportunities for
natural sleep points, like scheduling out while waiting for a data
write to happen, but apparently that is not always enough.

Add a cond_resched() to the second loop in __read_vmcore to
(hopefully) get rid of the softlockups.

Signed-off-by: Rik van Riel <riel@surriel.com>
Fixes: 5cbcb62dddf5 ("fs/proc: fix softlockup in __read_vmcore")
Reported-by: Breno Leitao <leitao@debian.org>
---
 fs/proc/vmcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3d8a82cee63e..658bf199d424 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -404,6 +404,8 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			if (!iov_iter_count(iter))
 				return acc;
 		}
+
+		cond_resched();
 	}
 
 	return acc;
-- 
2.47.1


