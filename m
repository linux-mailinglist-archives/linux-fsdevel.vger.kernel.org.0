Return-Path: <linux-fsdevel+bounces-32272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2F9A2F7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D1E1C22194
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3442296FB;
	Thu, 17 Oct 2024 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aHd1RBwu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AC1EE009;
	Thu, 17 Oct 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199697; cv=none; b=paDtCMKDHA+vlmpTy4U71JjrsfB18uRZLhicbnmXFxyP1DypgIvYK5xJrLUZ8Tq+eYHeonoZdmpquGWMBNxwXigJwtteM37g4EfEvp8KXl0+VZvxdB4RhxL/pHvw9FX0YbRQodpflTjN2L26M7CS4B97qa1yhfoVGWqUDptn6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199697; c=relaxed/simple;
	bh=3NOu1Q+Yns95EfGtXDCM6tiXYbYx0Sjfavo/kztUt8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLsEy2PGESUtVY/IVRKXJjAi066jitSySN0+Irir4Bc10OMPnm0zIXNcutjFF7nC9s1w1O79jdDi6BwaS24nLk/A9q5jqe+lwgnjaQDiv21mhtcBX6dYMLIYwLvgTzeyAMSfIAqg+nbdCI1yOlIZdoZChteuhgXqEz12H3RHl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aHd1RBwu; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sdXGjKgs/rhRe8l19F01/brI44jeC/ablpb8vlTIOo4=; b=aHd1RBwuJnYKAAbtP2Yfezw+8I
	2PC4JlmTiVs6vwBZeuda4ovEutYVBnolq0TSsGS0RU614r5mzpMktl4vS4+lKdJpCEgQkHHiWMg7J
	Na5rV9q16hIJpT1AnU+YWxnFPG1X6RuD6fX0YTPcZpmBLQcm5+Fky1802d/zGITMcm/LQ9WJiJD07
	E9vJpYiK73JpidObV8ArRYiwDPPSSoblz71efvX4ktX+tppvh4gWgl8qJHaWBo3wm+4jl1FlGc1rL
	Pg/EvQhhWC4+cD2jkxeM5wRa5Crnh89AkYqI9UvN1pRj2nWCuZtvUO5SU92fTRGon5Sps8M7owuYo
	d/zNX3ZA==;
Received: from [179.118.186.49] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Xpa-00Bnlc-1J; Thu, 17 Oct 2024 23:14:50 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Oct 2024 18:14:12 -0300
Subject: [PATCH v7 2/9] ext4: Use generic_ci_validate_strict_name helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-tonyk-tmpfs-v7-2-a9c056f8391f@igalia.com>
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
In-Reply-To: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Use the helper function to check the requirements for casefold
directories using strict encoding.

Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
Changes from v4:
- Now we can drop the if IS_ENABLED() guard
---
 fs/ext4/namei.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2ad5e1790e363e4ac273162e35013..612ccbeb493b8d901c123221ef6573457193dd16 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2395,11 +2395,8 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	if (fscrypt_is_nokey_name(dentry))
 		return -ENOKEY;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
-	    utf8_validate(sb->s_encoding, &dentry->d_name))
+	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
 		return -EINVAL;
-#endif
 
 	retval = ext4_fname_setup_filename(dir, &dentry->d_name, 0, &fname);
 	if (retval)

-- 
2.47.0


