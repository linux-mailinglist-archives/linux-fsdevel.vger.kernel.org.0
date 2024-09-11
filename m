Return-Path: <linux-fsdevel+bounces-29099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6339755DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD451C235DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29431AB51F;
	Wed, 11 Sep 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d3GntHFk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05B1AAE37;
	Wed, 11 Sep 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065939; cv=none; b=TAcO6qNGnnC35GieJU653YTTeym+25x85Ckk0bNYbpYdaAsw3skTG6t8GcD0kckhWbQs0oLpG8TjZ86N+nZsJyN9+dn9CARX7nw5f3yk5x8HfY92CZiI/yXfRqrGKM/CfYQPiutksXNRuCcGgI6dMsFBa/+dAp4ED25k84Jljyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065939; c=relaxed/simple;
	bh=0taofh0Xk8e/xFeBuR+ZJrAFWG6Ywq1ifG5UXMsoJA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzRCrh0ULld5iN9Gb+q0w0/lzwZmnoyukSR21THdhyJov3dmEXgbW4K7se8Lb9ENbRqmOemqA7/2LoJslX3nHP7WO35p8LwmNZUwE/EoSf6ptvay2Qrl/7m1todJYW/DQtY0Stt7jogiAW+dfWby7MQ0qHn3vLy2CkoGpgvmpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=d3GntHFk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kxZabVtRIbsH5N40Gr/wp92cNKF1pfI7iuz0Er/EL18=; b=d3GntHFkdbbMSCXQUNBp91ixBf
	9OIUngs6Lz8HspCHitoMhM+6/l/YsLELRFGnW2P9DblIt558GwmqgnJGce4qp6WHDmuG86C5POYVV
	Bl5v5DEh2FEO70Vymnl9a/tI3/1xWfCgIybnnSHuPd74+4vWpGjFuxoo6gvobs+wc0hgznp0Jc9DS
	2lTOaJ5cRQQwanvW74I+p5hOUYaoDu7HS0Jwx0055qobygH786E/npE4xaeuZNpnXhtAwPpGRMsog
	Ok13crqzkBfgGFCSmzuMbx4DjIQAQTYQZpXBatIclfY56U2TN45aNkHqbXaOi7dD4qTiHYo3mkWE8
	wI1XTxgg==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1soOau-00CTwi-4M; Wed, 11 Sep 2024 16:45:20 +0200
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
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: [PATCH v4 02/10] ext4: Use generic_ci_validate_strict_name helper
Date: Wed, 11 Sep 2024 11:44:54 -0300
Message-ID: <20240911144502.115260-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911144502.115260-1-andrealmeid@igalia.com>
References: <20240911144502.115260-1-andrealmeid@igalia.com>
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

Suggested-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6a95713f9193..beca80e70b0c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2394,8 +2394,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 		return -ENOKEY;
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
-	    utf8_validate(sb->s_encoding, &dentry->d_name))
+	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
 		return -EINVAL;
 #endif
 
-- 
2.46.0


