Return-Path: <linux-fsdevel+bounces-35608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4075E9D656C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 22:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF2C2832B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267118733B;
	Fri, 22 Nov 2024 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L6pwn8nc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9qbKUo8i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L6pwn8nc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9qbKUo8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592E249E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732311576; cv=none; b=ug43GqDJdcpnMUr+Ze66AKnZXN0QP/v1BqAFEsZ5ya8ngDq30xfhjoLrPCsiTGwyhLv53hHqdICZLa7VmXLSGbyYJ5wAUrNK61c4dYpS1NUjSFUdFftEyXfsrYZkSe+ltI0wl1qzw0X1frj5kSh8otXznIvMTGs2q/PcHMxeui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732311576; c=relaxed/simple;
	bh=kCMmcXK6UycTEbe0f7IKt5XPD1206GnLOikNVMxDXIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dXh4gpMshI5Seq7yp3mowjk+LbLD3URf4FT3S6at5LIMunBvTLauEZv/ebR3pOO6SAFXzLxTUMzIIlLUhuI+IuXyzjgsFt/U4B9kvU3UeKAhGsneWcFmCcw+xDPhwkoKxfp3DcB/bV8aDHLYlPyUYuz8qT8vclZYp+1xpeCaFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L6pwn8nc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9qbKUo8i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L6pwn8nc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9qbKUo8i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 644DB2119C;
	Fri, 22 Nov 2024 21:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732311572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CUu6QYqCDGjcFeGk95MW6KCjfCbCnEAKIEJYh0hU2oI=;
	b=L6pwn8ncXJhrnYXVURE7VZn6Ov8uz1BF3zj70FQiYCDvf6/rYm4gQzKTcmAyClecoRipgB
	LcP/xODAVH/6c5Q7mVhoSFL5KiFYMg+NNiPhs8GISW4bwKegpwtQsbh1u4BH17oPZ/rHM7
	RW21mugvKHziwQH6yjxsbUpOymPZoEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732311572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CUu6QYqCDGjcFeGk95MW6KCjfCbCnEAKIEJYh0hU2oI=;
	b=9qbKUo8idpFyJ83pSKejxPhcuERWMGYBZmzIyhyG+8J2NSgh51SwFPzJO9Qyk6cPTomt71
	OxbtZR/YspZFDoAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732311572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CUu6QYqCDGjcFeGk95MW6KCjfCbCnEAKIEJYh0hU2oI=;
	b=L6pwn8ncXJhrnYXVURE7VZn6Ov8uz1BF3zj70FQiYCDvf6/rYm4gQzKTcmAyClecoRipgB
	LcP/xODAVH/6c5Q7mVhoSFL5KiFYMg+NNiPhs8GISW4bwKegpwtQsbh1u4BH17oPZ/rHM7
	RW21mugvKHziwQH6yjxsbUpOymPZoEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732311572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CUu6QYqCDGjcFeGk95MW6KCjfCbCnEAKIEJYh0hU2oI=;
	b=9qbKUo8idpFyJ83pSKejxPhcuERWMGYBZmzIyhyG+8J2NSgh51SwFPzJO9Qyk6cPTomt71
	OxbtZR/YspZFDoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 142ED13998;
	Fri, 22 Nov 2024 21:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1RkOhP6QGeiYwAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 22 Nov 2024 21:39:31 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>,
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] unicode updates
Date: Fri, 22 Nov 2024 16:39:22 -0500
Message-ID: <87jzcvkkxh.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

The following changes since commit 17712b7ea0756799635ba159cc773082230ed028:

  Merge tag 'io_uring-6.11-20240802' of git://git.kernel.dk/linux (2024-08-=
02 14:18:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/=
unicode-next-6.13

for you to fetch changes up to 6b56a63d286f6f57066c4b5648d8fbec9510beae:

  MAINTAINERS: Add Unicode tree (2024-10-11 15:02:41 -0400)

----------------------------------------------------------------
unicode updates

This update includes:

  - A patch by Thomas Wei=C3=9Fschuh constifying a read-only struct.

  - A patch by Andr=C3=A9 Almeida fixing the error path of unicode_load,
  which might trigger a kernel oops if it fails to find the unicode
  module.

  - One documentation fix by Gan Jie, updating a filename in the README.

  - A patch by Andr=C3=A9 Almeida adding the link of my tree to MAINTAINERS.

All but the MAINTAINERS patch have been sitting on my tree and in
linux-next since early in the 6.12 cycle.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

----------------------------------------------------------------
Andr=C3=A9 Almeida (2):
      unicode: Fix utf8_load() error path
      MAINTAINERS: Add Unicode tree

Gan Jie (1):
      unicode: change the reference of database file

Thomas Wei=C3=9Fschuh (1):
      unicode: constify utf8 data table

 MAINTAINERS                   | 1 +
 fs/unicode/README.utf8data    | 8 ++++----
 fs/unicode/mkutf8data.c       | 4 ++--
 fs/unicode/utf8-core.c        | 2 +-
 fs/unicode/utf8data.c_shipped | 2 +-
 fs/unicode/utf8n.h            | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)


--=20
Gabriel Krisman Bertazi

