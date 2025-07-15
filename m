Return-Path: <linux-fsdevel+bounces-54927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A912BB0553C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358B74A7739
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCBB27702D;
	Tue, 15 Jul 2025 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5jxx6m/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I5oxk0CU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uuErKiOE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Js32Augx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BC26D4F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569042; cv=none; b=bBwoKqpzK48AmQB3kGt8JJFBeZKZvhM/yx3jVciA5fsQVdlpE6xipN90TZVYY1KSk7TKKSDa29Zw09IQgtGuzldynDmMDSOzLSugLx2BgZjcjYXXU9+ljbltfwy8XsIpHN1rkBOu54VEpGk6PWt57PQU+PSYR/ybNC2LvaEn3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569042; c=relaxed/simple;
	bh=0GHiXuFJ0sPNdExiAaur+rUxx6laEHGWmYoUiB3Ud4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oek+eYOsZpnCHQu7Ie49WMEgq6DMw8iVfsGNcvZ6UN2OyeoTsqPpOPDkCoDOoaXZu5YOUh/QF7RHt/OGEqd8u3arnB/X3sia+wvdIGKzwfTKx4wIpHj5HjBVLVXyxlZGs48YCXx6lQnWhFlDDsbzagjyqfpJSeb00POfIJIOYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5jxx6m/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I5oxk0CU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uuErKiOE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Js32Augx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FFAB2123B;
	Tue, 15 Jul 2025 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752569038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzsbV3x/CTXCYelsSexk/bEtGHCl7KiDjnp2uvahdSc=;
	b=a5jxx6m/CaOccokz/O0TY8251voZxZC/x/adt4c7wq1vg71be1YVvPFPS6oZ/5LlbJairD
	iImp1yFdvBadhifv6mXlnAGXe71KHuPv9svha5iOzOQxUWE83DYAUox/jOHY+8msMpKty7
	SKuVgdKnfM9taLqhgjfWGqAmbnMLzS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752569038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzsbV3x/CTXCYelsSexk/bEtGHCl7KiDjnp2uvahdSc=;
	b=I5oxk0CUHyLD2zS6/YruuonvMwbiLNST4LqQL2sR1MW2g3k0H4ltkTFAhylYWczcJtVBYt
	otEECBvaOLEJBEAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uuErKiOE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Js32Augx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752569037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzsbV3x/CTXCYelsSexk/bEtGHCl7KiDjnp2uvahdSc=;
	b=uuErKiOEIU91JQCE37oO0BoM/Noc+djNR7nwchwoMe44WFRO4K5sMZFyZKqRqZZlyDCRMa
	uePtAw9SJe2XfTFvSGfR6AgwKyLk/OmOLfJwpXzhzom5+WALXRLbCHvItzQ7DR8efhfgMd
	8L0dquaOreW0ag9JIPaO8JfsIIIpGx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752569037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzsbV3x/CTXCYelsSexk/bEtGHCl7KiDjnp2uvahdSc=;
	b=Js32Augx0D2eHWZjVsmFinbwj4bHtj+F8xoIKqgGbc3qD5jUTdO2nRTl38SqeXVBwQAHVh
	DGCNI/VPk+Ej/JCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3311013306;
	Tue, 15 Jul 2025 08:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RHXbC80UdmhXWQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 15 Jul 2025 08:43:57 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 15 Jul 2025 10:43:42 +0200
Subject: [PATCH v3] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-export_modules-v3-1-11fffc67dff7@suse.cz>
X-B4-Tracking: v=1; b=H4sIAL0UdmgC/3WMSwrCMBQAryJZG8l7/bvyHiKSNi82oE1J2lAtv
 btpNwricgZmZubJGfLsuJuZo2C8sV2EZL9jTSu7G3GjIjMUmIlClJym3rrh+rBqvJPngJUotUx
 BiJzFqHekzbQNz5fIrfGDdc/tH2C1f1cBuOC61oXEEhUm+uRHT4fmxdZRwK8Y4CdGDrzOqjrXU
 qWQyE+8LMsbR41eeucAAAA=
X-Change-ID: 20250708-export_modules-12908fa41006
To: Daniel Gomez <da.gomez@samsung.com>, 
 Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
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
 Vlastimil Babka <vbabka@suse.cz>, Nicolas Schier <nicolas.schier@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5974; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=0GHiXuFJ0sPNdExiAaur+rUxx6laEHGWmYoUiB3Ud4Q=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBodhTKL+/6akuC8CrysdCHQUIjqsTEUvKr34WYb
 vG0IR2VE1eJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCaHYUygAKCRC74LB10kWI
 ml+OB/9JEN7quxar46H7voGtAZ9BnamAKmyjYc9fFSAab88gE+V7f9e9tBmF/v1H1ZPWI+c+KIf
 LfRxWCaarttPv2dox17LE5Y6fig0Pa9kxnJZ2y4KVCrRQocAjpfkIVHJEbs9D52j43AjdzXeOHu
 gPJr9F6pLLYgkZq6+HrxIm6Bo3cKoss1VyPbr0qUGxYrRPqPGzO3G3knkCaJQij7RdjxPSbWpW9
 pEqDl8q4O+5gh4c/jxtzcJvL0vIXLqLC0eTnUw34IjvH+CmO/h42xH9o60fkppU16HnkWgNnwDp
 BtLGwqs5MkKog39XNGvt2MKyZJ8ooIrZily+lVt3MQvUyfEQ
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 5FFAB2123B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

Christoph suggested that the explicit _GPL_ can be dropped from the
module namespace export macro, as it's intended for in-tree modules
only. It would be possible to restrict it technically, but it was
pointed out [2] that some cases of using an out-of-tree build of an
in-tree module with the same name are legitimate. But in that case those
also have to be GPL anyway so it's unnecessary to spell it out in the
macro name.

Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey5sb_8muzdWTMkA@mail.gmail.com/ [2]
Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Shivank Garg <shivankg@amd.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Nicolas Schier <n.schier@avm.de>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Daniel, please clarify if you'll take this via module tree or Christian
can take it via vfs tree?

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
Changes in v3:
- Clarified the macro documentation about in-tree intention and GPL
  implications, per Daniel.
- Applied tags.
- Link to v2: https://patch.msgid.link/20250711-export_modules-v2-1-b59b6fad413a@suse.cz

Changes in v2:
- drop the patch to restrict module namespace export for in-tree modules
- fix a pre-existing documentation typo (Nicolas Schier)
- Link to v1: https://patch.msgid.link/20250708-export_modules-v1-0-fbf7a282d23f@suse.cz
---
 Documentation/core-api/symbol-namespaces.rst | 11 ++++++-----
 fs/anon_inodes.c                             |  2 +-
 include/linux/export.h                       |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index 32fc73dc5529e8844c2ce2580987155bcd13cd09..034898e81ba201097330ab9875429e7d3fa30c0f 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -76,20 +76,21 @@ A second option to define the default namespace is directly in the compilation
 within the corresponding compilation unit before the #include for
 <linux/export.h>. Typically it's placed before the first #include statement.
 
-Using the EXPORT_SYMBOL_GPL_FOR_MODULES() macro
------------------------------------------------
+Using the EXPORT_SYMBOL_FOR_MODULES() macro
+-------------------------------------------
 
 Symbols exported using this macro are put into a module namespace. This
-namespace cannot be imported.
+namespace cannot be imported. These exports are GPL-only as they are only
+intended for in-tree modules.
 
 The macro takes a comma separated list of module names, allowing only those
 modules to access this symbol. Simple tail-globs are supported.
 
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


