Return-Path: <linux-fsdevel+bounces-71788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D4CD22FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 00:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A7D3031992
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 23:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBF2D3EF2;
	Fri, 19 Dec 2025 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4mUXYig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5D3A1E64;
	Fri, 19 Dec 2025 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187230; cv=none; b=u5FdR/Ed9LTJuO5X/6A2DVSoSZcCg9tXG7XKFURQgbeFP2UdpK6ecpjyIH0OjCagysXk3dds7McnoaQJoZ2hTiwJyLAJ+j7eqIJYFPNUr6qnYt3Z+xE03EyO7uRUWfjjnBqxm2jc8RUmhvHOAYnAl579aU0z6cMeVttC+jVRago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187230; c=relaxed/simple;
	bh=DqZWmDy/Ff5J419Ueo8IfUMcfkNbg66kqcJ+0BbeOKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f2Uc+4/K+m/AEn+uRJTR2F1NRRcO7LZjMF3FgZE68uXpeW5rEaLrgt3kjiLDNaA6gaEnhwPuSFlIn6KN3/rQOLVkVsoAf4tAcALwmHfIQsnNdCBFBDwliox34k16eVtr5kI4vpP2D3sj8VY9fsc6jLRk+zn2vwE+Ylb4zX/3cJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4mUXYig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B853C4CEF1;
	Fri, 19 Dec 2025 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766187229;
	bh=DqZWmDy/Ff5J419Ueo8IfUMcfkNbg66kqcJ+0BbeOKk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=F4mUXYigtqDGPy1Bu1bTrZMbbjJC0yDgrK7pBYJ5DS88R1+lOtJc/05EFbGLMjv+N
	 dyCDg7phmP6AI/qqlJbvp34apbB04HYDf/8xfoLQCOEw8Ts+t02DALj0GKNH6bcLyJ
	 TO+7RAMMoCVM3u5B2n7vzOCtBKyzOs4OvooxdqX/l7CIPbAV+EqnFpU1wzBr6+nnp+
	 +85gOTQZbZwBt9/Qpca9mZmOs9/zof24jVT/mWAbA/gsJyb0hp3ZhqNu7mrugXo6e6
	 q58dN8J1aXFvMF3HX/1Y4GTh9QXSwsPijwL4vXEKJUMHS+zPUSOW2mR6RtxwU9K20X
	 DAaouTUzxM0sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77845D78797;
	Fri, 19 Dec 2025 23:33:49 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Sat, 20 Dec 2025 08:33:21 +0900
Subject: [PATCH] netfs: fix folio unlock collection end point
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-netfs_mmap_corruption-v1-1-da4a2ce87e18@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBN0oJKuEhFiY80ik7EiiO6et
 PyL9x/IJEwZ+uoBoYsz77GEqSvwq4sLKZ5LA2psDKJWkY6Qp21zafK7yJmOIlSLZGwXgkfrodg
 kFPj+v8P4vh+XyAOgZwAAAA==
X-Change-ID: 20251220-netfs_mmap_corruption-62e187ffc28c
To: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3691;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=bnehbcpLm5UV7kOLOAuC9015mdwwP/1OVmMXJJYp4+A=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBpReDZTHI58pNcDP7ONjbVTvPcCmbidQsITsxhZ
 tagjjNuBgWJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaUXg2QAKCRCrTpvsapjm
 cJKFD/4gdgI+gIbj9zSnPNdgrT/kLxxed+Z3o5ZPyzY1G2mM8Y7QBfPOkC2DmDeNjv5X2+sU0OS
 Xu8Rfl4nFyvsIQ482o8zqxCF7ey03kKpxqru4+tNtp5XLVgRWWLLtS3axq74BN5uhUx2o5ZUdnl
 kcrdmWOYNwHhf9sKxNe+wUphHrPN412lZh9azCMc8rJwkEyD6lvFZkdHKmzTsVDPkNHSipBEVGB
 BlRM1lSkVavC4ZE8tg/W1S2AwhkYfzOTYnNJsV9bCqb+HbNx8jLiKc/4/62ZTA8bd3HOG8KrWE2
 eIMedY4hLUYa511NHTPyDXgg5w/4ZTk3JOU20Eh+y7wYpvXvWzeboMxRx3BWSNd3UNGLTw7cuXs
 xqLdW1EOAjUZKusZgsOrET/PJiB/xBxd8QE1Lo3Sgp8nBDBtZncEGbblebQVf5h1o5eh19HGQbp
 +hKpOQvnljMrWKtQ7d5VlG/nKQ1qT5DLg0eVcrXENVRFVm2jHxKjuDsOmIZnQuZWv7kPhsS79+6
 L+9mqYgadhE34xJ5t001x6Xu0zvp1DeQcTnJEr8x+Q+ZfvbKBO8JQ36Q4fysxLiMVZiI4s/EoNX
 qVtupRpWrv/QbbLK1FpvahYTTN1CTFvdphKnpaq+HU3i8e+UYkBDTtNGJSYRgvEs3bBxb+Eos9V
 Dk0IaxH0TUDXWhA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

9p suffered from a corruption in mmap-heavy workloads such as compiling
with clang (e.g. kernel build with `make LLVM=1`, failing with random
errors on mmaped headers and clang segfaults)

David Howells identified a problem in the netfs trace of such a crash,
below:
> We unlocked page ix=00005 before doing the ZERO subreq that clears
> the page tail.  That shouldn't have happened since the collection
> point hasn't reached the end of the folio yet.

netfs_collect_folio: R=00001b55 ix=00003 r=3000-4000 t=3000/5fb2
netfs_folio: i=157f3 ix=00003-00003 read-done
netfs_folio: i=157f3 ix=00003-00003 read-unlock
netfs_collect_folio: R=00001b55 ix=00004 r=4000-5000 t=4000/5fb2
netfs_folio: i=157f3 ix=00004-00004 read-done
netfs_folio: i=157f3 ix=00004-00004 read-unlock
netfs_collect_folio: R=00001b55 ix=00005 r=5000-5fb2 t=5000/5fb2
netfs_folio: i=157f3 ix=00005-00005 read-done
netfs_folio: i=157f3 ix=00005-00005 read-unlock
...
netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=c
netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=8
...
netfs_sreq: R=00001b55[2] ZERO SUBMT f=000 s=5fb2 0/4e s=0 e=0
netfs_sreq: R=00001b55[2] ZERO TERM  f=102 s=5fb2 4e/4e s=5 e=0

This patch changes the end condition for collecting folios that have
been read, from "is the IO over?" to "have we read up till the end of
the folio?" (collected_to >= fend), which delays the read-unlock to the
"ZERO CONSUM" step after the page tail has been zeroed

Reported-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Link: https://lkml.kernel.org/r/2332946.iZASKD2KPV@weasel
Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
A few notes out of order:
- I don't really understand why this actually matter -- sure,
  there'll be junk after the mmap region ends, but why does
  this cause a bug? Since the folio is unlocked the zero fill operation
  ends up zeroing the end of another page? Well, either way there's no
  doubt that the early unlock was a problem...
- I have no idea how to test that this doesn't break something else by
  not unlocking a page that should be unlocked e.g. something that
  wouldn't need zero-filling (partial refresh?) -- I don't *think* we
  have anything like that, but I don't actually know, so pleae don't
  trust me too much here... Nothing I normally test on 9p broke so it's
  probably not too far off though.

This has been broken for about a year so I guess there's no great hurry
at this point, but any extra pair of eyes would be appreciated...

(Christian S, I've tested as much as I could think of, but any extra
validation would be great too if you have time!)
---
 fs/netfs/read_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index a95e7aadafd072edbb0f1743e0020eaf65b7d1ed..7a0ffa675fb17aa7431c0fd6cc546deb0be0be22 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -137,7 +137,7 @@ static void netfs_read_unlock_folios(struct netfs_io_request *rreq,
 		rreq->front_folio_order = order;
 		fsize = PAGE_SIZE << order;
 		fpos = folio_pos(folio);
-		fend = umin(fpos + fsize, rreq->i_size);
+		fend = fpos + fsize;
 
 		trace_netfs_collect_folio(rreq, folio, fend, collected_to);
 

---
base-commit: b10e94717f7e295d7ff6ce08249f7e31b630ef1b
change-id: 20251220-netfs_mmap_corruption-62e187ffc28c

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>



