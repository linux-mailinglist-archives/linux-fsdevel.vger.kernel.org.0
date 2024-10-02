Return-Path: <linux-fsdevel+bounces-30815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB0D98E743
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B815F1C25371
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7F61A0BC4;
	Wed,  2 Oct 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="R/1/uZzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563D1A00CB;
	Wed,  2 Oct 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912718; cv=none; b=PXO6x1NJ4l+DDA+7ihzazpHdL7STgVNEDjigorLHeMhS2tKXDAJrJF54C8vhuzba3NZR3BsHcQtpOYnp9NmYhs2R5p3QTjPPBs72fUvyI7nIGOsv72iqVmoy1kH70dCAnlNBxjGGM5a7Ch7q9XK0gbIp8vLbzTiVizp7QVPhW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912718; c=relaxed/simple;
	bh=oIHm5vuPIZznXvIblbYar2SLDHn+DYeKHsv+ZEkNTRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNCEEm+c4FXbzP3UBxTqIBKHT4hU26/PwgkxLFcUJEOylC5eoD2RPt0NAHCBvkml7QSozD26+EqXLKoXf6KsGGbL3GfoIOiAaunSmqZNbD7Bu8n87lGuN5deGyidNuHybgEHPavY0ZPD/NyLt/2njgruPM9W+qxIhbuil+tdIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=R/1/uZzI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KXLeYwW1OCCqt0oK34O4XtdDejRlj8zSL51Jo9mqNzY=; b=R/1/uZzI/kIq1MfL9Fyep64GAN
	DThJRyI7liLrxMsvDeAcg6HQv1z1Ydktk7c41UBYpBb6SSjONTsurzcfgayHZg7l7w6+BjRbv/xAB
	DP9pG7AKa2oReMvwGx3Ae/uX5AKWeV05+AoQUggMbeWFPoDkmlcVfWpYsFaMa3OwMQjNTvfCwzdOE
	6tsFAE3ox7EsCugi/yvjLSJJ61mXHnko8SZzbTqWkIZ0CedMr0cb++XzjBjmNJpsZKc+zHVEKrJwr
	qyPVsw23JHhXUalI88GbHqQ7nkbaKLJMo8FDotp3h3zqxex+/7qTO7s0gmVWqRuJUFpMaIuwnKqgj
	G864n8bA==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw91n-0045tc-JV; Thu, 03 Oct 2024 01:45:08 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v5 02/10] ext4: Use generic_ci_validate_strict_name helper
Date: Wed,  2 Oct 2024 20:44:36 -0300
Message-ID: <20241002234444.398367-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002234444.398367-1-andrealmeid@igalia.com>
References: <20241002234444.398367-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
index 790db7eac6c2..612ccbeb493b 100644
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
2.46.0


