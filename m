Return-Path: <linux-fsdevel+bounces-32502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E7E9A6FC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BFD1C22A6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8491EBA05;
	Mon, 21 Oct 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="htpsQRv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D851CBEB6;
	Mon, 21 Oct 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528671; cv=none; b=dRjT2/r9dKGepWDXE+jm9h1yeITtTXcMetzEz550OT5XXz1nQRTchXYCAuvXcHY+HmUZZYtVBvd/KoR9O4SNNCigHYXziJtiTLQ+YjNRlEWPZ9tZ2sGAcsKepluC7FsjWs424E1qHJXoan0XFev9IOVwQiVsdzq7CVPgp6XcS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528671; c=relaxed/simple;
	bh=3NOu1Q+Yns95EfGtXDCM6tiXYbYx0Sjfavo/kztUt8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1dVHsd8gXXsQ9u3xJ6T7MEn4igVu1Ykba8xdsyzmSv4wzKK1ceLP8BFoWQG46ekQRfysJCbv1Eajw3h1VNw6nYi3KCp8YpMmzZS2jCV80jyzQlH+Ps1QT0xoKKmm202LJUEVy/l8IOtxgKZvmbERrkdyvTj9b/+oNnEJW+fCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=htpsQRv8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sdXGjKgs/rhRe8l19F01/brI44jeC/ablpb8vlTIOo4=; b=htpsQRv8/js4yHpaG1piv1c4Hv
	NHNUWc+pkc3mBPO5T68D4cNjjpjP0Rl7v1cJ+4EWzTVdbfawo8BtBEnSbSYAUIa3pAWQQpPf+sA47
	6mj33mGgynQTvSiBvpJKx67Rb3MMNAPQJZEfNohKIpuWtoYcjtnjHpUEiFqfm4Q5v8jygXKZb4Htx
	EddtzcoEllFmljbnX6S5FAO+goy7Gu+iw+wisXgV8l9hLVLbP3Qa+oLNQGFZ2o5fm3MPgnnIhwvw/
	OZsrCCBNfJ+daFre0ewfTcDWzFDOlxtDb22Q3LZemdwcmeqQalNya0XkOzAseXR8zPy9Rx4hYmWFf
	4i8Eg/RA==;
Received: from [191.204.195.205] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t2vPe-00DECf-OQ; Mon, 21 Oct 2024 18:37:46 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 21 Oct 2024 13:37:18 -0300
Subject: [PATCH v8 2/9] ext4: Use generic_ci_validate_strict_name helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-tonyk-tmpfs-v8-2-f443d5814194@igalia.com>
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
In-Reply-To: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
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


