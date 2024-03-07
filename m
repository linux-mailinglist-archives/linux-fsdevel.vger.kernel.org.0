Return-Path: <linux-fsdevel+bounces-13914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4E875656
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 19:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE891F21F1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6809135A55;
	Thu,  7 Mar 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MrdGbSdY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8sNY0uT3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MrdGbSdY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8sNY0uT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8851A12FF9D;
	Thu,  7 Mar 2024 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837302; cv=none; b=kffx9FQ56oekNBUdqo4UHGNRynlXfoVTp32QNuPMQEbzWRmDK1FanOqUsvoyWJGKfa5DeDSCH8wGHKrMPQN01xbbJYd0KJk62UKhjsKGDXzqH9yw/xQsQ8VE+5S4aCGf6Dy7QmtbbN4tTQHL1d21ezuraoR6f98nGvS5/QD175Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837302; c=relaxed/simple;
	bh=C2VOgxDNF3z54szP1T9vL+C7fWDnK2058X2DEohiKhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9jm71gDUxON4WXL+zoFY+KyHZ+4wPF9HFHwoWecKwHb2Ogm0JeDMDTcSxFCy7axcHSaiO//+SrJSrf4G+wo61onx7yHYoUJXgqW/RHwBwmGCCfJYxo/rul3L2gcdCAvsEVx4wGvtjNQmfXj//AYjTsDSRBYkV9adAf1iD5CX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MrdGbSdY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8sNY0uT3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MrdGbSdY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8sNY0uT3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0DCB4D8F9;
	Thu,  7 Mar 2024 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709827350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ErBHnKWtRFqvNw55T9rkkKbdxBMzIaYWMEOU702WcoQ=;
	b=MrdGbSdY2GSUUSwxlyzK0gmdXBNHgWiGVODtKopkFRKuDc9hNu97IxwVo8foiDJf+vb5tV
	UXFcob7Vv84VC/sbdecp+uxYSKy6j9C0H1gAUBeOSMEH2bs3SZRl4gzBNaTOJbJdd3Z4ya
	rpK4i0QUmzHhPcoiqpA2C90fIPyIogg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709827350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ErBHnKWtRFqvNw55T9rkkKbdxBMzIaYWMEOU702WcoQ=;
	b=8sNY0uT3kN45SMpk172hGSS+n5QRIhY8gYJ7uQx9kriStHmAhQ/UdAk9oBPlNuihuv0qA7
	3AmTcOQ31f8th9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709827350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ErBHnKWtRFqvNw55T9rkkKbdxBMzIaYWMEOU702WcoQ=;
	b=MrdGbSdY2GSUUSwxlyzK0gmdXBNHgWiGVODtKopkFRKuDc9hNu97IxwVo8foiDJf+vb5tV
	UXFcob7Vv84VC/sbdecp+uxYSKy6j9C0H1gAUBeOSMEH2bs3SZRl4gzBNaTOJbJdd3Z4ya
	rpK4i0QUmzHhPcoiqpA2C90fIPyIogg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709827350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ErBHnKWtRFqvNw55T9rkkKbdxBMzIaYWMEOU702WcoQ=;
	b=8sNY0uT3kN45SMpk172hGSS+n5QRIhY8gYJ7uQx9kriStHmAhQ/UdAk9oBPlNuihuv0qA7
	3AmTcOQ31f8th9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0E2712FC5;
	Thu,  7 Mar 2024 16:02:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qu2ENxXl6WXtcwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 07 Mar 2024 16:02:29 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 90e11876;
	Thu, 7 Mar 2024 16:02:29 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v2 0/3] fs_parser: handle parameters that can be empty and don't have a value
Date: Thu,  7 Mar 2024 16:02:22 +0000
Message-ID: <20240307160225.23841-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[mit.edu,dilger.ca,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 BAYES_HAM(-0.00)[18.80%]
X-Spam-Score: 4.90
X-Spam-Flag: NO

While investigating an ext4/053 fstest failure, I realised that there was
an issue when the flag 'fs_param_can_be_empty' is set in a parameter and it
doesn't have a value

After an initial attempt to fix the issue, Christian suggested a different
approach and the following patches are based in his suggestion.

Another change that I'm introducing in this v2 is the change of parameter
'test_dummy_encryption' to also use the new helper introduced by the first
patch in this series.

Finally, I'd like to ask someone to look closer at the overlayfs patch as
I don't think there were any fstests to validate the case where 'lowerdir'
is empty.

Luis Henriques (3):
  fs_parser: add helper to define parameters with string and flag types
  ext4: fix the parsing of empty string mount parameters
  ovl: fix the parsing of empty string mount parameters

 fs/ext4/super.c           | 25 ++++++++++---------------
 fs/overlayfs/params.c     | 13 +++++--------
 include/linux/fs_parser.h |  8 ++++++++
 3 files changed, 23 insertions(+), 23 deletions(-)


