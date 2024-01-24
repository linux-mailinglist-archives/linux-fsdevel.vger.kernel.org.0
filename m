Return-Path: <linux-fsdevel+bounces-8791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787883B0D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9352B32470
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A460312A16F;
	Wed, 24 Jan 2024 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IbCbr5r2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n2HAn+2o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IbCbr5r2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n2HAn+2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC812A144
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120029; cv=none; b=u4rt0+iwvhJ1387QzEfgl1v/ZJt3eTQ2GizE3wS1Bj+CQ8Aqx2kW1/NZie2ij9jcJjidqqQFmxm/2rwJt46HDBPbwHmagSneNnHA/3b4YA1Q4854GqpphjtjCZf6/1rIE0t7SiLa+JG6qJEBvPC8nSd5gmqGao/i8JGKv3M1it8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120029; c=relaxed/simple;
	bh=cYez/pbnaJokLQMTsVGvuHhAsqo+TElYDEhxy7+GpV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZyX7tJuqxvsE6IZ6WOgMEZqGS6nxye/mBRFVcnphJ6ply4j7nT8CH88yRfDg4QSoWOFqpNHq9H2LY4uyxqjTCLADvM9yGIUwGuWGeV7hPAlZ+P+TPKfYYW/ncctCwJSLl1AOXYn+jEVtBqG6WL+Ibc7Gxf1DMZLghhFw8GeQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IbCbr5r2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n2HAn+2o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IbCbr5r2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n2HAn+2o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C93721F43;
	Wed, 24 Jan 2024 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706120024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dszh1KVCbrkwA6b+rzpmvlgBSsl3QFeMm775Umkcr6w=;
	b=IbCbr5r2qNj0eX14e08tu1D+fvsrMP6BcPDGhND5QR/sni6/N5ZCPrw13WgBj4LtsiN1g1
	3BhW0oqKtwjn7kS+v+vc7WWNAzyrHRjaShypkiXGFc3BI5uHd7vxoUILmf5y45jGETbwSd
	Yb9P4cmKtKFBfDFOTPG0VwnnZWVWAsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706120024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dszh1KVCbrkwA6b+rzpmvlgBSsl3QFeMm775Umkcr6w=;
	b=n2HAn+2oYASbnJMpN4hv2uQdyICUoLLaVTlflOu9tq2dVADxG9lL1YKyvmrYw69rzzDtL+
	IadYhDbp/jB3+fBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706120024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dszh1KVCbrkwA6b+rzpmvlgBSsl3QFeMm775Umkcr6w=;
	b=IbCbr5r2qNj0eX14e08tu1D+fvsrMP6BcPDGhND5QR/sni6/N5ZCPrw13WgBj4LtsiN1g1
	3BhW0oqKtwjn7kS+v+vc7WWNAzyrHRjaShypkiXGFc3BI5uHd7vxoUILmf5y45jGETbwSd
	Yb9P4cmKtKFBfDFOTPG0VwnnZWVWAsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706120024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dszh1KVCbrkwA6b+rzpmvlgBSsl3QFeMm775Umkcr6w=;
	b=n2HAn+2oYASbnJMpN4hv2uQdyICUoLLaVTlflOu9tq2dVADxG9lL1YKyvmrYw69rzzDtL+
	IadYhDbp/jB3+fBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84BF91333E;
	Wed, 24 Jan 2024 18:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ruu7EFdTsWX+QwAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 24 Jan 2024 18:13:43 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ebiggers@kernel.org,  viro@zeniv.linux.org.uk,  tytso@mit.edu,
  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org
Subject: [PATCH v4] libfs: Attempt exact-match comparison first during
 casefolded lookup
In-Reply-To: <CAHk-=wh+4Msg7RKv6mvKz2LfNwK24zKFhnLUyxsrKzsXqni+Kg@mail.gmail.com>
	(Linus Torvalds's message of "Sun, 21 Jan 2024 11:09:01 -0800")
Organization: SUSE
References: <20240119202544.19434-1-krisman@suse.de>
	<20240119202544.19434-2-krisman@suse.de>
	<CAHk-=whW=jahYWDezh8PeudB5ozfjNpdHnek3scMAyWHT5+=Og@mail.gmail.com>
	<87mssywsqs.fsf@mailhost.krisman.be>
	<CAHk-=wh+4Msg7RKv6mvKz2LfNwK24zKFhnLUyxsrKzsXqni+Kg@mail.gmail.com>
Date: Wed, 24 Jan 2024 15:13:40 -0300
Message-ID: <87ttn2sip7.fsf_-_@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IbCbr5r2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n2HAn+2o
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2C93721F43
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 21 Jan 2024 at 08:34, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>>
>> Are you ok with the earlier v2 of this patchset as-is, and I'll send a
>> new series proposing this change?
>
> Yeah, possibly updating just the commit log to mention how
> __d_lookup_rcu_op_compare() takes care of the data race.

Just for completeness, below the version I intend to apply to
unicode/for-next , which is the v2, plus the comments you and Eric
requested. That is, unless something else comes up.

> I do think that just doing the exact check in
> __d_lookup_rcu_op_compare() would then avoid things like the indirect
> call for that (presumably common) case, but it's not a big deal.

I will also follow up with a new patch for this shortly.

Thanks for the reviews.

-- >8 --
Subject: [PATCH v4] libfs: Attempt exact-match comparison first during
 casefolded lookup

Casefolded comparisons are (obviously) way more costly than a simple
memcmp.  Try the case-sensitive comparison first, falling-back to the
case-insensitive lookup only when needed.  This allows any exact-match
lookup to complete without having to walk the utf8 trie.

Note that, for strict mode, generic_ci_d_compare used to reject an
invalid UTF-8 string, which would now be considered valid if it
exact-matches the disk-name.  But, if that is the case, the filesystem
is corrupt.  More than that, it really doesn't matter in practice,
because the name-under-lookup will have already been rejected by
generic_ci_d_hash and we won't even get here.

The memcmp is safe under RCU because we are operating on str/len instead
of dentry->d_name directly, and the caller guarantees their consistency
between each other in __d_lookup_rcu_op_compare.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/libfs.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..306a0510b7dc 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1704,16 +1704,28 @@ bool is_empty_dir_inode(struct inode *inode)
 static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 				const char *str, const struct qstr *name)
 {
-	const struct dentry *parent = READ_ONCE(dentry->d_parent);
-	const struct inode *dir = READ_ONCE(parent->d_inode);
-	const struct super_block *sb = dentry->d_sb;
-	const struct unicode_map *um = sb->s_encoding;
-	struct qstr qstr = QSTR_INIT(str, len);
+	const struct dentry *parent;
+	const struct inode *dir;
 	char strbuf[DNAME_INLINE_LEN];
-	int ret;
+	struct qstr qstr;
+
+	/*
+	 * Attempt a case-sensitive match first. It is cheaper and
+	 * should cover most lookups, including all the sane
+	 * applications that expect a case-sensitive filesystem.
+	 *
+	 * This comparison is safe under RCU because the caller
+	 * guarantees the consistency between str and len. See
+	 * __d_lookup_rcu_op_compare() for details.
+	 */
+	if (len == name->len && !memcmp(str, name->name, len))
+		return 0;
 
+	parent = READ_ONCE(dentry->d_parent);
+	dir = READ_ONCE(parent->d_inode);
 	if (!dir || !IS_CASEFOLDED(dir))
-		goto fallback;
+		return 1;
+
 	/*
 	 * If the dentry name is stored in-line, then it may be concurrently
 	 * modified by a rename.  If this happens, the VFS will eventually retry
@@ -1724,20 +1736,14 @@ static int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
 	if (len <= DNAME_INLINE_LEN - 1) {
 		memcpy(strbuf, str, len);
 		strbuf[len] = 0;
-		qstr.name = strbuf;
+		str = strbuf;
 		/* prevent compiler from optimizing out the temporary buffer */
 		barrier();
 	}
-	ret = utf8_strncasecmp(um, name, &qstr);
-	if (ret >= 0)
-		return ret;
+	qstr.len = len;
+	qstr.name = str;
 
-	if (sb_has_strict_encoding(sb))
-		return -EINVAL;
-fallback:
-	if (len != name->len)
-		return 1;
-	return !!memcmp(str, name->name, len);
+	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
 }
 
 /**
-- 
2.43.0


