Return-Path: <linux-fsdevel+bounces-54655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02EDB01E9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5785E567B4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C032DFA32;
	Fri, 11 Jul 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hf4zS+z8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T1SPKMyN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hf4zS+z8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T1SPKMyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D912DCF6C
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242738; cv=none; b=DjFYmj3s5YfQzoZxAnyrM96/0uAKf1u7jAK5I1qkc/+IGjHTsl7yLs4nLm7fWbsshYzRr/4GDsFTfVGryWMyEV1D1pf0wKlg9Kruchci2T6twjUuM6tnLIFK13huMSh8D0gH76Fo88U+0O/Bqb0rqQS6m3g2qM6o8qtkzsp6EfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242738; c=relaxed/simple;
	bh=5vM0D68YaMu3z+Ia8ntasxDW/Wh1xdo8UMTwy2u3BQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FCFsytXZibJEvmiFQ44umdnid8F5D4vS+EB4snnIvkVXomVq/OgxsUC7O8jmvVDw5vE2RukG67V0pTq1Vcw85ru9pXhzqhmx2snpfzaAIuQHK97ndS6sOsobsTRL47CQOenHF18N6s9+Gd6a1kqQWI6rjOJsH2blz0tCV2Gx8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hf4zS+z8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T1SPKMyN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hf4zS+z8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T1SPKMyN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FAA321190;
	Fri, 11 Jul 2025 14:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752242732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vLtFpp+ISRJwTEls7YgEXlMRkRofGcmRExaiWjJWZPQ=;
	b=Hf4zS+z8dJlo0SPocXX1K9lSBijaGmTQ2q6DR+UHx6dc7gp3zJ4G0X7hrH7DxCJboDvFD2
	pENUop8p/TLc4ZNxUV66pg8zDtVVpA70lDRAZInBH4fAVkeiCK5tPnev+MiFtbaaLTxYZJ
	sQ47U2amneVCVLG+9Sr6IIknkEurIio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752242732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vLtFpp+ISRJwTEls7YgEXlMRkRofGcmRExaiWjJWZPQ=;
	b=T1SPKMyN3WcqSJj8Rcnrtdca+J1BzI1HpM0l60AtskrvC4iqjp0iXc8u1cSwOEiwY78eqx
	D2/2XzrKPg85M2Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752242732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vLtFpp+ISRJwTEls7YgEXlMRkRofGcmRExaiWjJWZPQ=;
	b=Hf4zS+z8dJlo0SPocXX1K9lSBijaGmTQ2q6DR+UHx6dc7gp3zJ4G0X7hrH7DxCJboDvFD2
	pENUop8p/TLc4ZNxUV66pg8zDtVVpA70lDRAZInBH4fAVkeiCK5tPnev+MiFtbaaLTxYZJ
	sQ47U2amneVCVLG+9Sr6IIknkEurIio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752242732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vLtFpp+ISRJwTEls7YgEXlMRkRofGcmRExaiWjJWZPQ=;
	b=T1SPKMyN3WcqSJj8Rcnrtdca+J1BzI1HpM0l60AtskrvC4iqjp0iXc8u1cSwOEiwY78eqx
	D2/2XzrKPg85M2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 780DA1388B;
	Fri, 11 Jul 2025 14:05:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B/UAHSwacWi9TAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Jul 2025 14:05:32 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 11 Jul 2025 16:05:16 +0200
Subject: [PATCH v2] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-export_modules-v2-1-b59b6fad413a@suse.cz>
X-B4-Tracking: v=1; b=H4sIABsacWgC/3XMyw6CMBCF4Vchs7ZmOl6ornwPQwzCVJooJR1oU
 NJ3t7J3+Z/kfAsIB8cC52KBwNGJ830O2hTQdHX/YOXa3EBIByzRKJ4HH8bby7fTk0VpOqGx9V4
 jHiGfhsDWzSt4rXJ3TkYf3qsf9W/9S0WtUNm7LWsy1NLOXmQS3jYfqFJKXzjgQ8iqAAAA
X-Change-ID: 20250708-export_modules-12908fa41006
To: Matthias Maennich <maennich@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, 
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>, 
 Shivank Garg <shivankg@amd.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5352; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=5vM0D68YaMu3z+Ia8ntasxDW/Wh1xdo8UMTwy2u3BQ0=;
 b=kA0DAAgBu+CwddJFiJoByyZiAGhxGiig/phGhp3SPEOzFjMWa0uxZCukD/YGq9JSswRw6JlEY
 YkBMwQAAQgAHRYhBHu7yEEVmSNIlkhN8bvgsHXSRYiaBQJocRooAAoJELvgsHXSRYia00wH/RA/
 1s7HG/W2UsZza9uL7w7BE6qxCEbJAyuHkO22QCdj3N7Obx9FfPyMt3Tb6X7JaVXi3cJ/VUc+fOs
 2QB+IpoQgvPXFZYTj6xB0rDqGwintZDkAu5O9y+FYAEiNAODZvzd3mrr71rd7LNbMMbzgLTCDLb
 AAjp/DCQccB2gD/79+en5GStoNIyAaSwemW03mg89+Lb+Skamf/vBrehkOxGtQ3CKcr1mHqPDeJ
 Ytl7v72Z+3tRU+mMBi6jntboVOeBoa5pKZqVfQnDIywV+8LIVUMCV6Ep0w0B3U+juqZTLNZULjX
 QobE841Uosqvzj6Ea4IXfQwA8MI6/LYF1vjjOV4=
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Christoph suggested that the explicit _GPL_ can be dropped from the
module namespace export macro, as it's intended for in-tree modules
only. It would be possible to resrict it technically, but it was pointed
out [2] that some cases of using an out-of-tree build of an in-tree
module with the same name are legitimate. But in that case those also
have to be GPL anyway so it's unnecessary to spell it out.

Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey5sb_8muzdWTMkA@mail.gmail.com/ [2]
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Shivank Garg <shivankg@amd.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
part to avoid controversy converting selected existing EXPORT_SYMBOL().
Christoph argued [2] that the _FOR_MODULES() export is intended for
in-tree modules and thus GPL is implied anyway and can be simply dropped
from the export macro name. Peter agreed [3] about the intention for
in-tree modules only, although nothing currently enforces it.

It seemed straightforward to add this enforcement, so v1 did that. But
there were concerns of breaking the (apparently legitimate) usecases of
loading an updated/development out of tree built version of an in-tree
module.

So leave out the enforcement part and just drop the _GPL_ from the
export macro name and so we're left with EXPORT_SYMBOL_FOR_MODULES()
only. Any in-tree module used in an out-of-tree way will have to be GPL
anyway by definition.

Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
8250: export RSA functions"). Hopefully it's resolvable by a merge
commit fixup and we don't need to provide a temporary alias.

[1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
[2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
[3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/
---
Changes in v2:
- drop the patch to restrict module namespace export for in-tree modules
- fix a pre-existing documentation typo (Nicolas Schier)
- Link to v1: https://patch.msgid.link/20250708-export_modules-v1-0-fbf7a282d23f@suse.cz
---
 Documentation/core-api/symbol-namespaces.rst | 8 ++++----
 fs/anon_inodes.c                             | 2 +-
 include/linux/export.h                       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index 32fc73dc5529e8844c2ce2580987155bcd13cd09..6f7f4f47d43cdeb3b5008c795d254ca2661d39a6 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -76,8 +76,8 @@ A second option to define the default namespace is directly in the compilation
 within the corresponding compilation unit before the #include for
 <linux/export.h>. Typically it's placed before the first #include statement.
 
-Using the EXPORT_SYMBOL_GPL_FOR_MODULES() macro
------------------------------------------------
+Using the EXPORT_SYMBOL_FOR_MODULES() macro
+-------------------------------------------
 
 Symbols exported using this macro are put into a module namespace. This
 namespace cannot be imported.
@@ -87,9 +87,9 @@ modules to access this symbol. Simple tail-globs are supported.
 
 For example::
 
-  EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
+  EXPORT_SYMBOL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
 
-will limit usage of this symbol to modules whoes name matches the given
+will limit usage of this symbol to modules whose name matches the given
 patterns.
 
 How to use Symbols exported in Namespaces
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 1d847a939f29a41356af3f12e5f61372ec2fb550..180a458fc4f74249d674ec3c6e01277df1d9e743 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -129,7 +129,7 @@ struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *n
 	}
 	return inode;
 }
-EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
+EXPORT_SYMBOL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
 
 static struct file *__anon_inode_getfile(const char *name,
 					 const struct file_operations *fops,
diff --git a/include/linux/export.h b/include/linux/export.h
index f35d03b4113b19798036d2993d67eb932ad8ce6f..a686fd0ba406509da5f397e3a415d05c5a051c0d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -91,6 +91,6 @@
 #define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", ns)
 #define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "GPL", ns)
 
-#define EXPORT_SYMBOL_GPL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
+#define EXPORT_SYMBOL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
 
 #endif /* _LINUX_EXPORT_H */

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250708-export_modules-12908fa41006

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


