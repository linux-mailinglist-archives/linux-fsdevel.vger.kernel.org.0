Return-Path: <linux-fsdevel+bounces-28401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C359696A04B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBFC1F23B90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573113D245;
	Tue,  3 Sep 2024 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuWuHWX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1F1E502
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373373; cv=none; b=TSS+17tDnTvTg8zvGAdLl9aHLhfmDSAgWbRifiWszYH4SeOfPDw8N/Vh/XleGpUN9Dr9Jqt+ZWsBk3CqhFYuBA4NUt/ZabjSAWP9rfXw8JV7Z6G9q62IXgp+2IpCNO3eJL619yfhci0feuIXvKZgXESkmgvPmBBFZ4HaExcKguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373373; c=relaxed/simple;
	bh=CebY+vup8RjtcJO3CTsKAhV3jVPnEJg6xeCeD64qYmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXmvox/ue5q34j948rsD28g3vLRCliDERWaXEeQVKdDtpt7gFt6OSuCL8ZfcRclNkoUoTf6y7OSD7wmdE0bPQBiHfxK022vshcE9O9Ej5wtleiUgRAKMA4cwFIRJGQWzow2OWf3ewdqb+qQlcct+f3y9JVOtFy+57dbMCVFkjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuWuHWX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0689BC4CEC8;
	Tue,  3 Sep 2024 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373372;
	bh=CebY+vup8RjtcJO3CTsKAhV3jVPnEJg6xeCeD64qYmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YuWuHWX/bnShus2D9Wt4BPKhUFKhBoC2JuQHtpngis5DVhaSb80K8nhQ7YjfXM6eh
	 ORHEfli3aPbBAyZDCOUv2avSMT8I4L/rZ9xbwqotShJf22bkmi/Rrsr1ksNZo8p2qB
	 yhroIQSw/texBgSHn0y8XTPp/cu68rNXCymuGLjwkwRXwemv4lgxsurtLDaQ3C2FcE
	 nT4hqV+8d3IuYjkB/SMfnwpTItI3r2Jc1KdztM38vzHm7i2WH/1vYsE6bbTaTwJBuL
	 6MbnkTx1QYYLjTqBqXuZXney+PfSi40v/QowMB35c1MvlznDbvrPeAYZ3tsEVPZt74
	 WRm/04WjO8UeQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Sep 2024 16:20:54 +0200
Subject: [PATCH v2 13/15] file: port to struct kmem_cache_args
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-work-kmem_cache_args-v2-13-76f97e9a4560@kernel.org>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CebY+vup8RjtcJO3CTsKAhV3jVPnEJg6xeCeD64qYmg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl55zJ6dM2VhKS2/H/aW9Vbv7r6Yer3jIki0R3z/h6
 +JyRfGojlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIko7GP4n2CVvqcx/IdlwHwL
 uX0fojbs3pu1ckf6cjH7jpOqtgznjzP807PtnHyx7T3v4Y1ySXwx8dNiSjMPyfivrI0JePt9s70
 tBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port filp_cache to struct kmem_cache_args.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file_table.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 3ef558f27a1c..861c03608e83 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -511,9 +511,14 @@ EXPORT_SYMBOL(__fput_sync);
 
 void __init files_init(void)
 {
-	filp_cachep = kmem_cache_create_rcu("filp", sizeof(struct file),
-				offsetof(struct file, f_freeptr),
-				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct file, f_freeptr),
+	};
+
+	filp_cachep = kmem_cache_create("filp", sizeof(struct file), &args,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
+				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 

-- 
2.45.2


