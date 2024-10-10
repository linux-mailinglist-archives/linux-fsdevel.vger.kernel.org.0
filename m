Return-Path: <linux-fsdevel+bounces-31631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA9D9992D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98ED1F27FD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA671EF087;
	Thu, 10 Oct 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gdw40U8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C21EBA1C;
	Thu, 10 Oct 2024 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589289; cv=none; b=Tu3zlwyWYnbq2hrkhHQ4HfTvv6BmN7V3smrHuDhklJYf+dboAGjQ1cLMNLnoJrGyl91mPDsI23naM7AzZLdcatvaz0AJX9hqtCy5TnbnTSpKHoad2RDB3ogvBQECcDzKRLWQ6zRY+mSeITMElUouGxhygebB/+xB6fgkdfgq1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589289; c=relaxed/simple;
	bh=771opDvyFkQ0G0wfNGyjFY0zu6bFKT4oWurlBmF1RZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7IKszNIz6jhibiDwwJDaw1J6203O8ZZ1e6WKFKWonl1UfxFFBfzbFPHszbfxBIPFQDq2MINFFoc7MwD/fCmvwZwQR9QomeMZlfOqiwAORwAkVFpZ7lpiDXiPZgdaPmfUElCmCd9NnE8Xg9sujGviDxW8GwKs+Xxqf+Tk947CSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gdw40U8C; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VzXfvIbzNG0CSJ+bJDRaQbQX3trBLicfbCXoWczurs8=; b=gdw40U8ClqfhBNEr1zvH72DVze
	ei/o8WrtCUhyyOBxKWaOESNuBIM15Dnar7hBW/4EIqTwb3xfHTvvKWmrM2jcJ07SSqrWCnGhcMuBx
	OmZnI/kmTHDgMBqxOIfkFRPIzYBe3ay0VysEQqATyKPnMrZZok+8Xz8bZU+BNhlmao9bUfyzRFnLP
	endEIXVlclO+Q7IRSMHMCELHso5NIZpycJLpRgV5mpZcA+dKJjSR034h4SHkPxDTO2djEpcuoHZ0R
	4bktloCNris/aaWJCEljs72STAPAvtsHs8m9TCIEPvUEf2qdj3rvIqXVgF1iELs23iWDjQ14rgrGA
	sBZ9+Ctw==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz2L-007SHz-30; Thu, 10 Oct 2024 21:41:25 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:41 -0300
Subject: [PATCH v6 06/10] tmpfs: Always set simple_dentry_operations as
 dentry ops
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-6-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Set simple_dentry_operations as the superblock dentry ops, so all tmpfs
dentries can inherit it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4f11b55063631976af81e4221c7366b768db6690..162d68784309bdfb8772aa9ba3ccc360780395fd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4662,6 +4662,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_export_op = &shmem_export_ops;
 	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
+
+	sb->s_d_op = &simple_dentry_operations;
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif

-- 
2.47.0


