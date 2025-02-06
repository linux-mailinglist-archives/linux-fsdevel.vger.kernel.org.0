Return-Path: <linux-fsdevel+bounces-41009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4939A2A04C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5165916757A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7959B2248BF;
	Thu,  6 Feb 2025 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BdXSljiK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gy7nnXnH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BdXSljiK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gy7nnXnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEB22489C;
	Thu,  6 Feb 2025 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820797; cv=none; b=brCh9UGVoSRf2VJ2PyhCzeXbMCWfUBM98sJna7GiLyT2ufI5p9y7/uksZq9cnIHX3l/R8wlFY3tZJ95TYLa6iOj+MphJhQ0ktYGpDRcBtc/ezJzfeZZurdnBY4FVPHCreFJwfIcgqhwg6dqusyeIGYr654iiupHMxYQoKT4Zb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820797; c=relaxed/simple;
	bh=t0MO4Xthm06JoD2KBBBPHCuqBY6I1wuhuOK+pFBBIgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XS+PMkLw+RDsX3z4AZ7gKONDYEgKdo/FF85fPRqiWvf0bCKPLTJqA25du3Qp0SOI0S/s5CP5HRKVXM746HpSxKfS+rAZzLgakO4UXiUtYax6yVb1z10be9dSOpPs680+eSRo+DefiVr+p/9HtgnhTKrBIg6SAdNiGrUNhZxluKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BdXSljiK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gy7nnXnH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BdXSljiK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gy7nnXnH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 447BD1F381;
	Thu,  6 Feb 2025 05:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDLQ5/tKoGgGRjuqm2ZNWoZwMtK0kQNV8iRObc8Hijo=;
	b=BdXSljiKOgP7NP72GsFD0oeKHdyJrVHK9Pf+AXQ8ccALMbG+vXGQefFj+m98ar/wamDvdj
	TUhhsjvogWYz4VD4Z3OCSdjEKL9ZVjF7eAPIV34xd1nx1wQIwVKB/Lf1MwFkaDLMb+C2rP
	lazDmaa+Kat2uf9wdBKHqZXTK1dPf40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDLQ5/tKoGgGRjuqm2ZNWoZwMtK0kQNV8iRObc8Hijo=;
	b=gy7nnXnHEgQZMRLk+HBI2p5zB65oV3Nc6Z++Q2BQ5uCDEB3ZVfFf36Ux5Bv9SIXfuR787v
	3vqdwPegqMgw5tBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDLQ5/tKoGgGRjuqm2ZNWoZwMtK0kQNV8iRObc8Hijo=;
	b=BdXSljiKOgP7NP72GsFD0oeKHdyJrVHK9Pf+AXQ8ccALMbG+vXGQefFj+m98ar/wamDvdj
	TUhhsjvogWYz4VD4Z3OCSdjEKL9ZVjF7eAPIV34xd1nx1wQIwVKB/Lf1MwFkaDLMb+C2rP
	lazDmaa+Kat2uf9wdBKHqZXTK1dPf40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDLQ5/tKoGgGRjuqm2ZNWoZwMtK0kQNV8iRObc8Hijo=;
	b=gy7nnXnHEgQZMRLk+HBI2p5zB65oV3Nc6Z++Q2BQ5uCDEB3ZVfFf36Ux5Bv9SIXfuR787v
	3vqdwPegqMgw5tBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D2B313795;
	Thu,  6 Feb 2025 05:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q6EYDLdMpGeJBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:46:31 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] VFS: repack LOOKUP_ bit flags.
Date: Thu,  6 Feb 2025 16:42:44 +1100
Message-ID: <20250206054504.2950516-8-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The LOOKUP_ bits are not in order, which can make it awkward when adding
new bits.  Two bits have recently been added to the end which makes them
look like "scoping flags", but in fact they aren't.

Also LOOKUP_PARENT is described as "internal use only" but is used in
fs/nfs/

This patch:
 - Moves these three flags into the "pathwalk mode" section
 - changes all bits to use the BIT(n) macro
 - Allocates bits in order leaving gaps between the sections,
   and documents those gaps.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/namei.h | 46 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/namei.h b/include/linux/namei.h
index 839a64d07f8c..0d81e571a159 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -18,38 +18,38 @@ enum { MAX_NESTED_LINKS = 8 };
 enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 
 /* pathwalk mode */
-#define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
-#define LOOKUP_DIRECTORY	0x0002	/* require a directory */
-#define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
-#define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
-#define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
-#define LOOKUP_MOUNTPOINT	0x0080	/* follow mounts in the end */
-
-#define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache */
-#define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */
+#define LOOKUP_FOLLOW		BIT(0)	/* follow links at the end */
+#define LOOKUP_DIRECTORY	BIT(1)	/* require a directory */
+#define LOOKUP_AUTOMOUNT	BIT(2)  /* force terminal automount */
+#define LOOKUP_EMPTY		BIT(3)	/* accept empty path [user_... only] */
+#define LOOKUP_LINKAT_EMPTY	BIT(4) /* Linkat request with empty path. */
+#define LOOKUP_DOWN		BIT(5)	/* follow mounts in the starting point */
+#define LOOKUP_MOUNTPOINT	BIT(6)	/* follow mounts in the end */
+#define LOOKUP_REVAL		BIT(7)	/* tell ->d_revalidate() to trust no cache */
+#define LOOKUP_RCU		BIT(8)	/* RCU pathwalk mode; semi-internal */
+#define LOOKUP_CACHED		BIT(9) /* Only do cached lookup */
+#define LOOKUP_PARENT		BIT(10)	/* Looking up final parent in path */
+/* 5 spare bits for pathwalk */
 
 /* These tell filesystem methods that we are dealing with the final component... */
-#define LOOKUP_OPEN		0x0100	/* ... in open */
-#define LOOKUP_CREATE		0x0200	/* ... in object creation */
-#define LOOKUP_EXCL		0x0400	/* ... in target must not exist */
-#define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
+#define LOOKUP_OPEN		BIT(16)	/* ... in open */
+#define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
+#define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
+#define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
 
 #define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |	\
 				 LOOKUP_RENAME_TARGET)
-
-/* internal use only */
-#define LOOKUP_PARENT		0x0010
+/* 4 spare bits for intent */
 
 /* Scoping flags for lookup. */
-#define LOOKUP_NO_SYMLINKS	0x010000 /* No symlink crossing. */
-#define LOOKUP_NO_MAGICLINKS	0x020000 /* No nd_jump_link() crossing. */
-#define LOOKUP_NO_XDEV		0x040000 /* No mountpoint crossing. */
-#define LOOKUP_BENEATH		0x080000 /* No escaping from starting point. */
-#define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
-#define LOOKUP_CACHED		0x200000 /* Only do cached lookup */
-#define LOOKUP_LINKAT_EMPTY	0x400000 /* Linkat request with empty path. */
+#define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
+#define LOOKUP_NO_MAGICLINKS	BIT(25) /* No nd_jump_link() crossing. */
+#define LOOKUP_NO_XDEV		BIT(26) /* No mountpoint crossing. */
+#define LOOKUP_BENEATH		BIT(27) /* No escaping from starting point. */
+#define LOOKUP_IN_ROOT		BIT(28) /* Treat dirfd as fs root. */
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
+/* 3 spare bits for scoping */
 
 extern int path_pts(struct path *path);
 
-- 
2.47.1


