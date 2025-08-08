Return-Path: <linux-fsdevel+bounces-57079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EAB1E92D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70719586870
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D727E045;
	Fri,  8 Aug 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GsONgBEs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6qR8wIDA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GsONgBEs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6qR8wIDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE827C84B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659741; cv=none; b=nNZcIx8/j6hrXOOn9zowDOHpqPZbY7InwY3K0mb0CZ03hvGMOtCireOdyi6/QZboEHfaXuNnQd8pEDzOCl9DLcw3Ki7wWtMoYHk4mN1PYWVb6orsSOJ3lBj5YYg54z+SmIM+HG3asZ/2wO0dFMxbMsI3jXFAgKj3xMrdfteCnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659741; c=relaxed/simple;
	bh=rRy3VVYv/xRGLvEvlzidprZjy0bUEO9RKYo1VLgz/d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SMjyM1ThOIkmdEG6oXNXq0FC7CPi9xrpxsFIKYM7WYKjU4AZ6MTHokC0aYgPBfxaSNOgV9c6hX7ZQD4mSfScuc8OzYXV7z2F0F/jcyxQniTOgLUp0dCpYGFinVMdZoLCgeovoBGG6Vu0Q1xArBuEwGu88TJKWx1jxT2hrMp+zN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GsONgBEs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6qR8wIDA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GsONgBEs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6qR8wIDA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3824820B1B;
	Fri,  8 Aug 2025 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754659736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OmJU47YtbpHXaX5zp+zkWa1Gwazmu1ufdp/ig+r2U0A=;
	b=GsONgBEsBk7YQV3qRb9fQiA9aJAjmyuYURnPuEzbw3MeSfbNSgA/1TQg6oQwJjq6+x0Dfz
	58wJOwRizf4Y615aNS3y2VgQNH6/jIYtUmOsUvo7eedDO2ymG/X2BYDkOfGXZeWqHr4m6q
	Jn92OtMOq8EIs6edfLfCmipDleRL0II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754659736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OmJU47YtbpHXaX5zp+zkWa1Gwazmu1ufdp/ig+r2U0A=;
	b=6qR8wIDAKjiDqbyw5gX1jjB+lMiA4xo+qC4lU1q4xaQa3QY5/7fyqH+HgKo4EPZyYxweSY
	qZsaJGgNzriLIYBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754659736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OmJU47YtbpHXaX5zp+zkWa1Gwazmu1ufdp/ig+r2U0A=;
	b=GsONgBEsBk7YQV3qRb9fQiA9aJAjmyuYURnPuEzbw3MeSfbNSgA/1TQg6oQwJjq6+x0Dfz
	58wJOwRizf4Y615aNS3y2VgQNH6/jIYtUmOsUvo7eedDO2ymG/X2BYDkOfGXZeWqHr4m6q
	Jn92OtMOq8EIs6edfLfCmipDleRL0II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754659736;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OmJU47YtbpHXaX5zp+zkWa1Gwazmu1ufdp/ig+r2U0A=;
	b=6qR8wIDAKjiDqbyw5gX1jjB+lMiA4xo+qC4lU1q4xaQa3QY5/7fyqH+HgKo4EPZyYxweSY
	qZsaJGgNzriLIYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 110051392A;
	Fri,  8 Aug 2025 13:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hDHVA5j7lWhGIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 08 Aug 2025 13:28:56 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 08 Aug 2025 15:28:47 +0200
Subject: [PATCH v4] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-export_modules-v4-1-426945bcc5e1@suse.cz>
X-B4-Tracking: v=1; b=H4sIAI77lWgC/3XMSw6CMBSF4a2Qjq3pLY+CI/dhjCm0V5ookBYal
 LB3CxMxxOE5yfdPxGlrtCOnaCJWe+NM24SRHCJS1bK5a2pU2IQznjLBcqrHrrX97dmq4aEdBV6
 wHGUCjGUkoM5qNOMavFzDro3rW/ta+x6W92/KA2UUSxSS51zxGM9ucPpYvckS8nyDAXaYU6BlW
 pQZSpVALH9xvMXpDscBAyBilQmFKL54nucP47bXsSQBAAA=
X-Change-ID: 20250708-export_modules-12908fa41006
To: Daniel Gomez <da.gomez@samsung.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7973; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=rRy3VVYv/xRGLvEvlzidprZjy0bUEO9RKYo1VLgz/d8=;
 b=kA0DAAgBu+CwddJFiJoByyZiAGiV+5SigK7nMwShFY4kakvPs+Jal5r/4VXR4gV+3lwmTnVfB
 YkBMwQAAQgAHRYhBHu7yEEVmSNIlkhN8bvgsHXSRYiaBQJolfuUAAoJELvgsHXSRYiaoNQH/inX
 ECy47YnpTZ8/t0jO9YRpVMzZTQxpy+a00YR6R9XLc0Wk/MabNTu5vhlbGvPrUWlCWAQdLOp6T3A
 D/gMiin7LgFJWFd6a/oQO5E4ExqjcRKmWqVpF4dnjn2ecyx8y4LWuFY2vh4JGJQJqM5Wgu1EGJY
 SD5HJtulYMkk9Cw+jE/M5W24GlSkmhF97dA9lCTGChnc1hXdeOdqWKUfN/mpnMcusJMQONrZa+c
 7KWP/y7cPn/78UOgbQ/4NxEUhNS+MX7x7cf1kntTtxK0gRUFn2CASR7EPJ347RPVhCb1RXJ7pfv
 gBTT8qZlAfm0zfq4nGdcQ8BoTwzrg9UfTNYkjrQ=
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
	RCPT_COUNT_TWELVE(0.00)[26];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,amd.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

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
In v3, Greg suggested [0] applying after 6.17-rc1. At this moment I can
see all new users of EXPORT_SYMBOL_GPL_FOR_MODULES() pending for 6.17
were merged already and nothing more is in next-20250808. Thus this
rebased version renames all usages. If we merge this before rc1 then
people basing their branches with more new usages (AFAIK KVM might be)
on rc1 will be covered. If this is merged after rc1, they will have to
rebase, as Greg said. I guess it's up to Linus and Daniel.

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

[0] https://lore.kernel.org/all/2025072219-dollhouse-margarita-de67@gregkh/
[1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
[2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
[3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/
---
Changes in v4:
- rebase to current mainline, rename new usages in drivers/tty/serial/8250/8250_rsa.c
- Link to v3: https://patch.msgid.link/20250715-export_modules-v3-1-11fffc67dff7@suse.cz

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
 drivers/tty/serial/8250/8250_rsa.c           |  8 ++++----
 fs/anon_inodes.c                             |  2 +-
 include/linux/export.h                       |  2 +-
 4 files changed, 12 insertions(+), 11 deletions(-)

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
diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index d34093cc03ad9407f7117dda49554625c14e019a..12a65b79583c03e73bd8f3439b8b541c027f242f 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -147,7 +147,7 @@ void rsa_enable(struct uart_8250_port *up)
 	if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 		serial_out(up, UART_RSA_FRR, 0);
 }
-EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_enable, "8250_base");
+EXPORT_SYMBOL_FOR_MODULES(rsa_enable, "8250_base");
 
 /*
  * Attempts to turn off the RSA FIFO and resets the RSA board back to 115kbps compat mode. It is
@@ -179,7 +179,7 @@ void rsa_disable(struct uart_8250_port *up)
 		up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
 	uart_port_unlock_irq(&up->port);
 }
-EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_disable, "8250_base");
+EXPORT_SYMBOL_FOR_MODULES(rsa_disable, "8250_base");
 
 void rsa_autoconfig(struct uart_8250_port *up)
 {
@@ -192,7 +192,7 @@ void rsa_autoconfig(struct uart_8250_port *up)
 	if (__rsa_enable(up))
 		up->port.type = PORT_RSA;
 }
-EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_autoconfig, "8250_base");
+EXPORT_SYMBOL_FOR_MODULES(rsa_autoconfig, "8250_base");
 
 void rsa_reset(struct uart_8250_port *up)
 {
@@ -201,7 +201,7 @@ void rsa_reset(struct uart_8250_port *up)
 
 	serial_out(up, UART_RSA_FRR, 0);
 }
-EXPORT_SYMBOL_GPL_FOR_MODULES(rsa_reset, "8250_base");
+EXPORT_SYMBOL_FOR_MODULES(rsa_reset, "8250_base");
 
 #ifdef CONFIG_SERIAL_8250_DEPRECATED_OPTIONS
 #ifndef MODULE
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
base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
change-id: 20250708-export_modules-12908fa41006

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


