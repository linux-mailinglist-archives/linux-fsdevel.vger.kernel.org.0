Return-Path: <linux-fsdevel+bounces-16253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD189A8ED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 07:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B81282838
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 05:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B51BF53;
	Sat,  6 Apr 2024 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="el3qrglN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A96139F
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379637; cv=none; b=ohxkCRgNjaIXmEylGKJqvqixarnI9s+sKGonJWsENhwbymxzoLoiGaFtb5fyXtS5WM7HSPau8u3ix+huYxzGLW+d+SHh4zndLP3KWGgRr5viMqVH/cMh7QLCAWAb9C59GDtiayVFE/aYajdSzbdf1RvCfmH8goXZmTu/t8QD8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379637; c=relaxed/simple;
	bh=LUcXvVIhRjVpkftVtmBl3micXuLLKp6Y6HCogZ0/byw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSpQOKWQtj4HBmfR+DBVxOPbKXmVT1vDI4vJk5z4Nx9xn7g0xLRe9ggrONblSeVcngRYtzFNAIiFpAYAEIZKZ7ZpKJBKXXW7uFN70y8Ts/d90IkAI+qAF+OlYOTQ+aMizUHRfAMJVk1EpzDHpjjg2e6Bp9w5Ei6iA0goW7epyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=el3qrglN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PUUrUyHgmJUU4WZ3A9HQ0pSNDpYFjbemyDM120yZx2o=; b=el3qrglNdgxhZP6Y/VDObTjP9L
	mEjB4fv0NYWyLBL1UfyccEztgzqjvggAsRs5btMR3G2OZFN3AI0RPNfDDe/tUlynJWXs9guQ2TjR1
	AJUZWL7Jcv2RbFjBS/qz1J3CGItEHEdbNs45PdMbfyJ5+1SviMfiwD2qh6PjGzn4cC0YPSaKah3MA
	2SbEup9U7FUGAYGVLRfEIIj0Fh/jP76+kqWq/baBvAQ9T+/RUpK61RWo/8RDzhl2c5Yb93+7K2LC0
	h+Dqwj4dw6SLz7r4mKCLqKLiUVXEFw2eLehnKa06VE/Gxf/WjRpKtOf2nfBgZRjxXLdGBP3fSRgtH
	qUuDoNPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsyAL-006qqu-2a;
	Sat, 06 Apr 2024 05:00:33 +0000
Date: Sat, 6 Apr 2024 06:00:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>
Subject: [PATCH 3/6] get_file_rcu(): no need to check for NULL separately
Message-ID: <20240406050033.GC1632446@ZenIV>
References: <20240406045622.GY538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406045622.GY538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

IS_ERR(NULL) is false and IS_ERR() already comes with unlikely()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index ab38b005633c..8076aef9c210 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -920,13 +920,8 @@ struct file *get_file_rcu(struct file __rcu **f)
 		struct file __rcu *file;
 
 		file = __get_file_rcu(f);
-		if (unlikely(!file))
-			return NULL;
-
-		if (unlikely(IS_ERR(file)))
-			continue;
-
-		return file;
+		if (!IS_ERR(file))
+			return file;
 	}
 }
 EXPORT_SYMBOL_GPL(get_file_rcu);
-- 
2.39.2


