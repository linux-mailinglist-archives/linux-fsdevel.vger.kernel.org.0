Return-Path: <linux-fsdevel+bounces-54222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD0AFC405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7D9424E20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65683299A84;
	Tue,  8 Jul 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bx1qnh5C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iVUaXGVB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bx1qnh5C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iVUaXGVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E9298993
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959765; cv=none; b=YVDH+Vs/TxmGMxUkSlWphSgy4iSt6g8ceehGBiRRuFAeJxyvlFcNiN60OM9yxIGrok9iky7QZxroeHvWPux+aOje3MroiSERAzaFKpSbcsJ1boB147MgQtdJshaCBnL3KAUK6Ug5C9ZTnCo49xFZJZGLrLoXL6JJNoOTK4Xj8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959765; c=relaxed/simple;
	bh=Yy5s3tOFMC/rTCLld/EgSCsz8DvydWujL2hwXFKTktU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q7yCdLvJkBBKhIm35hhHgvkn8CL4EOt5rmdYvQAdiM8u/StA/rVPiyNLWl/y8839xMCHuhSGIIhac+JxCwDtYT1XMH5owAsJxCgK2KxUqouX3LW3YkAv3D90MV6agw2H51pII/au447pIkWN0pAExjy58cyPA7ZLm5Hnei3Wx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bx1qnh5C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iVUaXGVB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bx1qnh5C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iVUaXGVB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C98F1F395;
	Tue,  8 Jul 2025 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751959761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEPibuz/UmeneAYugM2MEEKg37oU+6TRLDHisiab2fw=;
	b=bx1qnh5CUl5nUrjwr7MFOuFpXrUR1UFemEt6r/AnHAnBqHT8ZNjbRfaTW+4E4oPh1wFT5g
	LGFIr1GkXeMU4xG0tiq8HGQt/BnNbH7g9EZogaJVAq/oW5DRXmwFnlOP8uhigZA0UaWUGV
	Sy5LO/8NTGosx0yQl3acENkhpkqn62E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751959761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEPibuz/UmeneAYugM2MEEKg37oU+6TRLDHisiab2fw=;
	b=iVUaXGVBWmLqcyHQlS7AnDQTecIiydAxk6aig3YXtqA42SGZxZRIWWBdsUnpXo+PdiNb2S
	LQyiepNmcZF8rvDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bx1qnh5C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iVUaXGVB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751959761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEPibuz/UmeneAYugM2MEEKg37oU+6TRLDHisiab2fw=;
	b=bx1qnh5CUl5nUrjwr7MFOuFpXrUR1UFemEt6r/AnHAnBqHT8ZNjbRfaTW+4E4oPh1wFT5g
	LGFIr1GkXeMU4xG0tiq8HGQt/BnNbH7g9EZogaJVAq/oW5DRXmwFnlOP8uhigZA0UaWUGV
	Sy5LO/8NTGosx0yQl3acENkhpkqn62E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751959761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEPibuz/UmeneAYugM2MEEKg37oU+6TRLDHisiab2fw=;
	b=iVUaXGVBWmLqcyHQlS7AnDQTecIiydAxk6aig3YXtqA42SGZxZRIWWBdsUnpXo+PdiNb2S
	LQyiepNmcZF8rvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A976A13A8E;
	Tue,  8 Jul 2025 07:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6AgYKdDIbGhMRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Jul 2025 07:29:20 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 08 Jul 2025 09:28:58 +0200
Subject: [PATCH 2/2] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-export_modules-v1-2-fbf7a282d23f@suse.cz>
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
In-Reply-To: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
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
 Shivank Garg <shivankg@amd.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2759; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=Yy5s3tOFMC/rTCLld/EgSCsz8DvydWujL2hwXFKTktU=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBobMjGRVhqSav0/nkuPb3JRt274Je0nu6HWMSZJ
 zHxfngk2jWJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCaGzIxgAKCRC74LB10kWI
 mopRB/9sjmWSAjMZpnsWt1S+YnTErm/WorHGKp6h7blRs2pSRHzEQDfNodA44cnIgPuQWu0bOIp
 ydNSlgcMYURSrQa6CnqtIHMNybz55YaZLLXMXRm+2VqKCB1nrfdkf/AFv8Pxp9M6kPA5OhzPKgC
 EEsJ/BAhH0ZFPqpqIP+QGjDO/vZ9KA+H/rg1bMYfSqIDOI6jrokkAkkiF0oWfAY3YGAWa871CqT
 RtL4651dKlMxxAoT/kCPP++3ad9LD/2w55BkFguNxbSekaCvIOy/QH+Tn08h0A5GEo8o2WaZDqN
 MWdErQDrTIeK/Q5FJRr9wrah0kCGkFygmy0nsfGO5a9fFT4d
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLizo86y7np4cjncz9mwtfc8qs)];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0C98F1F395
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

With module namespace access restricted to in-tree modules, the GPL
requirement becomes implied. Drop it from the name of the export helper.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/core-api/symbol-namespaces.rst | 6 +++---
 fs/anon_inodes.c                             | 2 +-
 include/linux/export.h                       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index dc228ac738a5cdc49cc736c29170ca96df6a28dc..aafbc0469cd6a4b76225e0e96a86025de512008e 100644
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
@@ -88,7 +88,7 @@ Simple tail-globs are supported.
 
 For example::
 
-  EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
+  EXPORT_SYMBOL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
 
 will limit usage of this symbol to in-tree modules whoes name matches the given
 patterns.
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

-- 
2.50.0


