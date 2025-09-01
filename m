Return-Path: <linux-fsdevel+bounces-59736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B565FB3D8B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953361884996
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 05:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6F923DEB6;
	Mon,  1 Sep 2025 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dG0eCgyx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dG0eCgyx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C123BD02
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704281; cv=none; b=a+QRN7Vygepl9xlx0nJyZ+d/rTZy41FgZSXizhJRXnfVhcvUhDtc4+wEsZi8j0MR2N0X2nPEqdVAjHUl959ihgr/6/TJhxtVV6V+TQlBEBak1ZEobP/X7XJik739/ur0+wbmRGOWj0LYYSTOWWYohOn6Vo9vxZqoJXaZ+xU6M4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704281; c=relaxed/simple;
	bh=dZ8lejRFEkUuU2lxgcyqqzsY3TURazY5mYqGYUVSmS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVmNEz45sy+lLrKrLt0W7JLjRRrLSY9MaeLpgjWKyvJs+R//TCdwGNH27OyHx8puXWYOfPpkwax88r9KtYG2hJcCHkfPAqwtDMHgo7ZICWvxMhI1mX+lyh0C+XjTzwkgW14Te8p8YHNORaziMUVayvpxRkuWh1fok0BlpXhLFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dG0eCgyx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dG0eCgyx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6700F1F38D;
	Mon,  1 Sep 2025 05:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU6m0NaGtwnpTmLCDUhHf/bJJmH4J0l4dKDrFK5j/To=;
	b=dG0eCgyxYnwklL+JkA//pW6+9EWzNSTjdAVKm3crIa69nMlGv8XgZlFg8Cwrr++nfrd3cn
	wF1djmjTKxalwY6dErAt55UTwzJxYhTK/9aNPLKXBOawKQB5GDN75nizG9KoW4NSZDohsd
	wsRuDvoiJ/rJLWbu8Y9+mVYS76Tl4G4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756704266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU6m0NaGtwnpTmLCDUhHf/bJJmH4J0l4dKDrFK5j/To=;
	b=dG0eCgyxYnwklL+JkA//pW6+9EWzNSTjdAVKm3crIa69nMlGv8XgZlFg8Cwrr++nfrd3cn
	wF1djmjTKxalwY6dErAt55UTwzJxYhTK/9aNPLKXBOawKQB5GDN75nizG9KoW4NSZDohsd
	wsRuDvoiJ/rJLWbu8Y9+mVYS76Tl4G4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6924F13981;
	Mon,  1 Sep 2025 05:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOQgCwkutWhBJgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 01 Sep 2025 05:24:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] btrfs: support all block sizes which is no larger than page size
Date: Mon,  1 Sep 2025 14:54:03 +0930
Message-ID: <aac1886b134fbe1d8663695e3ee214ed8dd957b6.1756703958.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756703958.git.wqu@suse.com>
References: <cover.1756703958.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Currently if block size < page size, btrfs only supports one single
config, 4K.

This is mostly to reduce the test configurations, as 4K is going to be
the default block size for all architectures.

However all other major filesystems have no artificial limits on the
support block size, and some are already supporting block size > page
sizes.

Since the btrfs subpage block support has been there for a long time,
it's time for us to enable all block size <= page size support.

So here enable all block sizes support as long as it's no larger than
page size for experimental builds.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 335209fe3734..014fb8b12f96 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -78,6 +78,10 @@ bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
 
 	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
 		return true;
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (blocksize <= PAGE_SIZE)
+		return true;
+#endif
 	return false;
 }
 
-- 
2.50.1


