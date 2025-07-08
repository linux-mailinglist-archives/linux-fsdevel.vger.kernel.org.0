Return-Path: <linux-fsdevel+bounces-54223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88323AFC406
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB92188C376
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F90299ABD;
	Tue,  8 Jul 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="anPko4sX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/xE11s4n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="anPko4sX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/xE11s4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E039298983
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959766; cv=none; b=LNUSsguhZ3BwgY9RA2lKO97rIun/3vxtFPh1UOisEM8hEiHyp6V2qdUC31lzNcMgkLqRRGzNZt+m0pGbYW8suC9cDgzJrEN/19lbrh8mjIB4IuTWprQAMpQxk7/e3SbElRq7YHQHF8ThxT5P4pFuJig7jbFdcaDssoV7HQ3xj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959766; c=relaxed/simple;
	bh=Ovw8fHjX1L/38nilj6fgevmBkLMDrk6bhGz6/AMZW5w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J0Axrn5QdKXi0Ui/pYYax/qw9I52WW8UQLxXh9FGi5+gHjIjORMmbRrPsEdOPQoVH5lnBxnnrcVk2drS4Oyf9dQ4HW78JRQNrQ6LTevqX/GEztwDGle1gzSxTwayxplWDeRyRNSOVTxfqB70SKfIdsPjU1T4Yew/KYcMHs510NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=anPko4sX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/xE11s4n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=anPko4sX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/xE11s4n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89E6C21166;
	Tue,  8 Jul 2025 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751959760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6lln9rOiRt0F1nbbex8lswqls/C0Nv7C+CE5X/JFzO8=;
	b=anPko4sXvaCJ1i5eoiMc/LDs5DUZACKCQckDosGIVz393SniZ3uqVRIyMDmWYfFSWjy6yW
	sHMWyVFjDtgrBztH2D9b6HLobLH7fnjuxwBwYkoLgu805cexn+XEuaZ2HAnwxDJbdBauez
	7nsjgLbEwIV8+BckN02uNr4tDNGWgQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751959760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6lln9rOiRt0F1nbbex8lswqls/C0Nv7C+CE5X/JFzO8=;
	b=/xE11s4nIoKgDyLjnanMzcKx2W5JoxeYkNkvvT0gS9fENqK2Eg5SYT0KbmqFdJnX9DlG4X
	4T1kB3qJo8Oul7AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=anPko4sX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/xE11s4n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751959760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6lln9rOiRt0F1nbbex8lswqls/C0Nv7C+CE5X/JFzO8=;
	b=anPko4sXvaCJ1i5eoiMc/LDs5DUZACKCQckDosGIVz393SniZ3uqVRIyMDmWYfFSWjy6yW
	sHMWyVFjDtgrBztH2D9b6HLobLH7fnjuxwBwYkoLgu805cexn+XEuaZ2HAnwxDJbdBauez
	7nsjgLbEwIV8+BckN02uNr4tDNGWgQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751959760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6lln9rOiRt0F1nbbex8lswqls/C0Nv7C+CE5X/JFzO8=;
	b=/xE11s4nIoKgDyLjnanMzcKx2W5JoxeYkNkvvT0gS9fENqK2Eg5SYT0KbmqFdJnX9DlG4X
	4T1kB3qJo8Oul7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C76B13A54;
	Tue,  8 Jul 2025 07:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vE/2FdDIbGhMRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Jul 2025 07:29:20 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/2] Restrict module namespace to in-tree modules and
 rename macro
Date: Tue, 08 Jul 2025 09:28:56 +0200
Message-Id: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjIbGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3dSKgvyikvjc/JTSnNRiXUMjSwOLtEQTQwMDMyWgpoKi1LTMCrC
 B0bG1tQBN7kiEYAAAAA==
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
 Shivank Garg <shivankg@amd.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=Ovw8fHjX1L/38nilj6fgevmBkLMDrk6bhGz6/AMZW5w=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBobMjAZwq4bIadh+QApGts2c/swA8ncrwsmKtMo
 4EvZOO04kqJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCaGzIwAAKCRC74LB10kWI
 mhZCB/4moRG7wbUo5VFK2hklpApaNqqAhUH1GG4eITpp989rTzBcea/NY7Yj567yptEZ4ANx1OF
 KSG1qjwZfTQY9q8RqFbCKbAvI38S4DQtHbx9k0M7vMQzQB3vNT/kTX7DmNVCcBt5XKszUvG+s2p
 kuetWngNnhAdHuVZ5LArP9VIN0vG9G0cz+y6tGdexgyp6AbM+5oJBzSfND9HU0nKQmywHfNMMI6
 4nirkg9N+Eh//w7sujcxYh4+ESZoeGBRbsiSPkVSUG6IpoKON6/Ll3EuyGR6GXPi/Jz0FT/N+ca
 xbj5vRTZb9H9E8SZjPowV/VydwXou9ni+e5g2VLcP/uvZJHy
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
X-Rspamd-Queue-Id: 89E6C21166
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
part to avoid controversy converting selected existing EXPORT_SYMBOL().
Christoph argued [2] that the _FOR_MODULES() export is intended for
in-tree modules and thus GPL is implied anyway and can be simply dropped
from the export macro name. Peter agreed [3] about the intention for
in-tree modules only, although nothing currently enforces it.

It seems straightforward to add this enforcement, so patch 1 does that.
Patch 2 then drops the _GPL_ from the name and so we're left with
EXPORT_SYMBOL_FOR_MODULES() restricted to in-tree modules only.

Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
8250: export RSA functions"). Hopefully it's resolvable by a merge
commit fixup and we don't need to provide a temporary alias.

[1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
[2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
[3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (2):
      module: Restrict module namespace access to in-tree modules
      module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_MODULES

 Documentation/core-api/symbol-namespaces.rst | 11 ++++++-----
 fs/anon_inodes.c                             |  2 +-
 include/linux/export.h                       |  2 +-
 kernel/module/main.c                         |  3 ++-
 scripts/mod/modpost.c                        |  6 +++++-
 5 files changed, 15 insertions(+), 9 deletions(-)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250708-export_modules-12908fa41006

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


