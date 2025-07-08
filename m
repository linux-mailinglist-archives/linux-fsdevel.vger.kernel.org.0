Return-Path: <linux-fsdevel+bounces-54224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B29AFC40B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F696425D51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046929B228;
	Tue,  8 Jul 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nFUmzYoH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B9UQe7nW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nFUmzYoH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B9UQe7nW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14629898B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959772; cv=none; b=JV0R7SiRYPR0fXV8bQbZzgpKNsUQgficMAozp6Xe/7TusgCzi9JiQXp0oaf+w3fuyhfnkQGQc4yvmdXa0ulhDdW8ragHTFlGZkULXY9MxUYSoLHlYTrOO/k5f2eiF2PHrtdbs7D2o2AbTmQuDC4cAwOirT42T5Hoj27Ezibo8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959772; c=relaxed/simple;
	bh=459aY6httSPGlfMwYDEBmR8FgGSiINVjtVfz8HsU3RE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2l/IWpVEr09eFSBoySGRZ7oCqQGAZkju+WQquEi7dqqg6JmGMdgXovyUderjtdiWeT9YyC61tlVJ/i/cT3OLc28biKJmyenzm9Od7L/KJLZP2EJpLbkPTIy8w6kWUt5nwBvtI3Ww2xZAzRzxoQ5hrdauS8H3TMYV/VImivVALs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nFUmzYoH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B9UQe7nW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nFUmzYoH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B9UQe7nW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADE6321167;
	Tue,  8 Jul 2025 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751959760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rx3njnUbgecjnRgMgxvgDvXXhvOOwbYYEjOLicK8wI=;
	b=nFUmzYoHUcMiwkar5mB6A5Dgz+mA/pRvB/aXJt6ERxVCfMItzP5TmbeICEFS1FBw0NE4Vb
	haK26f7jfKw+o1gjfRHLs87v1djh26Qdsltzjcz9FLiDXAsgm8RQjM7PymrAnmTDvqVFUG
	K2J7NlgIJav/YwTR1/HKuS/v4HmSpLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751959760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rx3njnUbgecjnRgMgxvgDvXXhvOOwbYYEjOLicK8wI=;
	b=B9UQe7nWXen6/H8B96iTACpcsNSqh3nkPYMBU0Qz5Ga4/lcTbZaedxSpcjMBRXbs05ojgz
	xyHL6xynrBN0m4Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nFUmzYoH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B9UQe7nW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751959760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rx3njnUbgecjnRgMgxvgDvXXhvOOwbYYEjOLicK8wI=;
	b=nFUmzYoHUcMiwkar5mB6A5Dgz+mA/pRvB/aXJt6ERxVCfMItzP5TmbeICEFS1FBw0NE4Vb
	haK26f7jfKw+o1gjfRHLs87v1djh26Qdsltzjcz9FLiDXAsgm8RQjM7PymrAnmTDvqVFUG
	K2J7NlgIJav/YwTR1/HKuS/v4HmSpLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751959760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rx3njnUbgecjnRgMgxvgDvXXhvOOwbYYEjOLicK8wI=;
	b=B9UQe7nWXen6/H8B96iTACpcsNSqh3nkPYMBU0Qz5Ga4/lcTbZaedxSpcjMBRXbs05ojgz
	xyHL6xynrBN0m4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85CF513A70;
	Tue,  8 Jul 2025 07:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0LhbINDIbGhMRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Jul 2025 07:29:20 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 08 Jul 2025 09:28:57 +0200
Subject: [PATCH 1/2] module: Restrict module namespace access to in-tree
 modules
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-export_modules-v1-1-fbf7a282d23f@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3102; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=459aY6httSPGlfMwYDEBmR8FgGSiINVjtVfz8HsU3RE=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBobMjDDO9ZP+2OuvlBbe1dD04hmH2adv8MYGq1L
 bIPxae+tumJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCaGzIwwAKCRC74LB10kWI
 miYLB/oDTPR3wn8zxmBzuqT8gmUEn7kGjZPRu+wp3fovQXyB6YdqoT1PoKXkkPTDUsb2zK2S4g1
 CVhJoIERGoh3/2UED4yWlVDRUH6XZhFS4Xct5+4uB5HYzXNhzfrPUKRzQIn+nfqbfhw11ziM60w
 nE7ZayMrcEzXnRev68Ypb9dxGhWYEwh77AXTgiQJzwPdhczLd8Bpt4bLK6AJZ+AF5KStwp41/rv
 vNUBgtkWdHTGJtW+45itSEXRhSWqYJI7ukqkGJMJpBg5wDcVCkN+c1kawPjUCjf0nknyG8tVINp
 W8onJIHPDJMt4aPAhedJ+1xx3t0MxU7tIo8yzkqNB7goyj+E
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ADE6321167
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

The module namespace support has been introduced to allow restricting
exports to specific modules only, and intended for in-tree modules such
as kvm. Make this intention explicit by disallowing out of tree modules
both for the module loader and modpost.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/core-api/symbol-namespaces.rst | 5 +++--
 kernel/module/main.c                         | 3 ++-
 scripts/mod/modpost.c                        | 6 +++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index 32fc73dc5529e8844c2ce2580987155bcd13cd09..dc228ac738a5cdc49cc736c29170ca96df6a28dc 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -83,13 +83,14 @@ Symbols exported using this macro are put into a module namespace. This
 namespace cannot be imported.
 
 The macro takes a comma separated list of module names, allowing only those
-modules to access this symbol. Simple tail-globs are supported.
+modules to access this symbol. The access is restricted to in-tree modules.
+Simple tail-globs are supported.
 
 For example::
 
   EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
 
-will limit usage of this symbol to modules whoes name matches the given
+will limit usage of this symbol to in-tree modules whoes name matches the given
 patterns.
 
 How to use Symbols exported in Namespaces
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 413ac6ea37021bc8ae260f624ca2745ed85333fc..ec7d8daa0347e3b65713396d6b6d14c2cb0270d3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1157,7 +1157,8 @@ static int verify_namespace_is_imported(const struct load_info *info,
 	namespace = kernel_symbol_namespace(sym);
 	if (namespace && namespace[0]) {
 
-		if (verify_module_namespace(namespace, mod->name))
+		if (get_modinfo(info, "intree") &&
+		    verify_module_namespace(namespace, mod->name))
 			return 0;
 
 		for_each_modinfo_entry(imported_namespace, info, "import_ns") {
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5ca7c268294ebb65acb0ba52a671eddca9279c61..d78be9834ed75f4b6ddb9af02a300a9bcc9234cc 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1695,7 +1695,8 @@ void buf_write(struct buffer *buf, const char *s, int len)
  * @modname: module name
  *
  * If @namespace is prefixed with "module:" to indicate it is a module namespace
- * then test if @modname matches any of the comma separated patterns.
+ * then test if @modname matches any of the comma separated patterns. Access to
+ * module namespaces is restricted to in-tree modules only.
  *
  * The patterns only support tail-glob.
  */
@@ -1706,6 +1707,9 @@ static bool verify_module_namespace(const char *namespace, const char *modname)
 	const char *sep;
 	bool glob;
 
+	if (external_module)
+		return false;
+
 	if (!strstarts(namespace, prefix))
 		return false;
 

-- 
2.50.0


