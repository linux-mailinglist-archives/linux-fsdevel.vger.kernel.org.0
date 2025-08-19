Return-Path: <linux-fsdevel+bounces-58246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565ABB2B811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CDA3BF15E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C798C2561AA;
	Tue, 19 Aug 2025 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="veVtcVAd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UzumozL9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="veVtcVAd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UzumozL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A392AD3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 03:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575455; cv=none; b=nMYRTQW3ZoZ1MnKeuHlkwB3VOeMGoo9ZCzAinNI8omFXehZ7TjjXUBE8mGZL30+UOE2+uKklQ6bdbivcJLu4GKHI+rNaF21PFNCOHAMlEStpJRNI6Vw1CCiANz0k801kAXn+CkcJF1Q8u3HdV0DRwIMKAtAdos3lqtcO8wsKRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575455; c=relaxed/simple;
	bh=6mnuzM4q/dwfPrjL3CSRyBhY72WMxe2KVq8Yf5e54DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKsZ3ouoWm9rbBcA3pZ1KDGxcq9WGjUtUt+VDT80EoXsQ1tKHqt2PqvrmRFJqDz9RBpTq74InMsk52gNnA8CkpZkatYnPT1PIC1qTACKD3OLX9gjgUXCuYGfZGkv2R4lGJWDj7dzosviP2Sk+sUkMFYghCyoWy2CP87Hd+1morI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=veVtcVAd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UzumozL9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=veVtcVAd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UzumozL9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7612A1F74C;
	Tue, 19 Aug 2025 03:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1uc6YNVC18m/bixy80wyX5GulHJ2J1AS1bdYG4/3Uw=;
	b=veVtcVAdRrpS40CFk881GihAKgAK7nhQDl7PzCqXApt/hcTneLECKytBN/D0uXxEWJGxg+
	4GPGVQVJ7fvxt3jKhVJfjCiwJE6fuGjQiujUtZL3Owjgct0Ew0Ihd2DXxNKp8MiSSgoEvN
	goAbIIEk3G0JgClJeQbZijC97F74fYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1uc6YNVC18m/bixy80wyX5GulHJ2J1AS1bdYG4/3Uw=;
	b=UzumozL9Sv2T3Px2GUI4JkVKhni7pLVTNnB5USKkHonOSNC5GgtACkX9zXp08hqc3eh8GS
	AK9AdaSWKGSHAuBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1uc6YNVC18m/bixy80wyX5GulHJ2J1AS1bdYG4/3Uw=;
	b=veVtcVAdRrpS40CFk881GihAKgAK7nhQDl7PzCqXApt/hcTneLECKytBN/D0uXxEWJGxg+
	4GPGVQVJ7fvxt3jKhVJfjCiwJE6fuGjQiujUtZL3Owjgct0Ew0Ihd2DXxNKp8MiSSgoEvN
	goAbIIEk3G0JgClJeQbZijC97F74fYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1uc6YNVC18m/bixy80wyX5GulHJ2J1AS1bdYG4/3Uw=;
	b=UzumozL9Sv2T3Px2GUI4JkVKhni7pLVTNnB5USKkHonOSNC5GgtACkX9zXp08hqc3eh8GS
	AK9AdaSWKGSHAuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EB1E13686;
	Tue, 19 Aug 2025 03:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6D/SBXP0o2gJawAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 19 Aug 2025 03:50:11 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	ddiss@suse.de,
	nsc@kernel.org
Subject: [PATCH v3 6/8] docs: initramfs: file data alignment via name padding
Date: Tue, 19 Aug 2025 13:05:49 +1000
Message-ID: <20250819032607.28727-7-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819032607.28727-1-ddiss@suse.de>
References: <20250819032607.28727-1-ddiss@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The existing cpio extraction logic reads (maximum PATH_MAX) name_len
bytes from the archive into the collected name buffer and ensures that
the trailing byte is a null-terminator. This allows the actual file name
to be shorter than name_len, with the name string simply zero-terminated
prior to the last byte.

Initramfs generators, such as dracut-cpio[1], can take advantage of name
zero-padding to align file data segments within the archive to
filesystem block boundaries. Block boundary alignment may allow the
copy_file_range syscall to reflink archive source and destination
extents.

Link: https://github.com/dracutdevs/dracut/commit/300e4b116c624bca1b9e7251708b1ae656fe9157 [1]
Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
---
 Documentation/driver-api/early-userspace/buffer-format.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
index 726bfa2fe70da..4597a91100b7b 100644
--- a/Documentation/driver-api/early-userspace/buffer-format.rst
+++ b/Documentation/driver-api/early-userspace/buffer-format.rst
@@ -86,6 +86,11 @@ c_mtime is ignored unless CONFIG_INITRAMFS_PRESERVE_MTIME=y is set.
 The c_filesize should be zero for any file which is not a regular file
 or symlink.
 
+c_namesize may account for more than one trailing '\0', as long as the
+value doesn't exceed PATH_MAX.  This can be useful for ensuring that a
+subsequent file data segment is aligned, e.g. to a filesystem block
+boundary.
+
 The c_chksum field contains a simple 32-bit unsigned sum of all the
 bytes in the data field.  cpio(1) refers to this as "crc", which is
 clearly incorrect (a cyclic redundancy check is a different and
-- 
2.43.0


