Return-Path: <linux-fsdevel+bounces-28776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9171F96E29C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2241C22E69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B918EFC8;
	Thu,  5 Sep 2024 19:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="k+yEejC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1617BEB0;
	Thu,  5 Sep 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563016; cv=none; b=Do48L/Xhblex4Ngf0bka7zEQimWgRAUYYzK2ABCdHlLPVbjj3odlgfBFekni6cNOFgN9ljlpGDoZPlDOY982Ca3C7btjmskU/qze58BrT0hBorXX8BuhYgFjWjVxtHgarQynDrfoLkIEn5pLwqJtMUDGq73cFHoSk/w471e85L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563016; c=relaxed/simple;
	bh=0taofh0Xk8e/xFeBuR+ZJrAFWG6Ywq1ifG5UXMsoJA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7k0vhgKmXpBcJHH7grBNDA/Lw/sxn613j3IA6Z656Yjnh4H9JLPoP3qMdP1TYot5rGFxiWYuzzGScLCoeZZUg+kq7FYO97iBonO+duf4gtbFaxz5nr0XxLxGkzlrSn+Z0ASMnLeTeU8MqTWxMqmkJHjG0fiNlt0THgPIovVWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=k+yEejC8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kxZabVtRIbsH5N40Gr/wp92cNKF1pfI7iuz0Er/EL18=; b=k+yEejC8Dmzzln9UhjVHcqVDCI
	U7faXjakSc/T/yJDWuATyjA6gekduJAOI1X9dqJVLke+YO2Cei9IR3XGwRAEXF1dJdJqQMqnJSqj4
	IoNo7I8bJ+bp9s7CnWz8r9cyeOKWbx3NxipIJBcCURjTwl0so8rsLAMokS2bfXijHvkhlpGhxcohD
	XRp2OljVJlDaM+jjAi3iXWk/ZOTML8RaKnJevj+8BuxAxAJA0u+TzHHrUUxANXsbhBe9CHTMXBpiQ
	GtPqMmi+2k5jXIQ2N+u25g8aOBRov4Va8z+FkguqaHqHipidIdrHf6w+TEC1BV5cjahvsll5aES/2
	YbosNfjw==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smHlF-00A6Ho-GC; Thu, 05 Sep 2024 21:03:17 +0200
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
Subject: [PATCH v3 2/9] ext4: Use generic_ci_validate_strict_name helper
Date: Thu,  5 Sep 2024 16:02:45 -0300
Message-ID: <20240905190252.461639-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905190252.461639-1-andrealmeid@igalia.com>
References: <20240905190252.461639-1-andrealmeid@igalia.com>
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


