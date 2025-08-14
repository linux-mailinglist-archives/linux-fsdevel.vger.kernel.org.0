Return-Path: <linux-fsdevel+bounces-57836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F602B25B43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA5217BC2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196BF228CB0;
	Thu, 14 Aug 2025 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F39Y3e43";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9cxvEPi4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F39Y3e43";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9cxvEPi4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015F2264A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150538; cv=none; b=eEkCP8mnFhck38opeqTnOXsUya+Yu8MfnrMqoQr1qYfqiipgOWGRAZm+q0LX60WYqJtG8SmUkNIf1rcYCXVLaL3LkLvUwbaQiUpsqK7t4WC0A8P7GwukY493YRp+Oo+tnUIbiO5gavF8mpSa5R/xnfoGvT0kjb3Ms+KacSnbRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150538; c=relaxed/simple;
	bh=Qy2lDVaU9tp922VLOFrG88qVJpSrPTXd5mXfHZMRND0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSdBdJRVjN4VSASqIZRgrzT9dZvgmcG+T1GGikmYe+EyLwXZvIvOeUB665ZcacQLxdNdL0wout+roXjfyaygFsHzcEbpl+kSRJL8Q9Ij7Sstbz1heXThFW1mev5bEmiCWv5FOnVyfuejA80aWC0wuQ/EZejO79gREwhonJiTiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F39Y3e43; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9cxvEPi4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F39Y3e43; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9cxvEPi4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 500A921B1C;
	Thu, 14 Aug 2025 05:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DStSVktOkl/n6gofwO0PCDNIbvcnCso3mNWL07flB1A=;
	b=F39Y3e43R/ozFllSA2himjAv5qYWJS7wL0/ttF/+88pOO7kmgOG1e8wCqDTpXvetif9QJ1
	Hy82jAtINnlCFcGGj74F0CyBBsNffcflCn7uiK1WkmK5NWjzZP2O8ZqOAVa+Ij1wU/0WDr
	n8iEOG/2q15BVTIk31Wrj3wDCmAgTnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DStSVktOkl/n6gofwO0PCDNIbvcnCso3mNWL07flB1A=;
	b=9cxvEPi4DKBpBHODpEOu3BsDVKPwLku8n/6t98L8QU373jynM8dRWF8F10aXJ3pvoZ6c/w
	lunixFk5Ee8oCKBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755150533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DStSVktOkl/n6gofwO0PCDNIbvcnCso3mNWL07flB1A=;
	b=F39Y3e43R/ozFllSA2himjAv5qYWJS7wL0/ttF/+88pOO7kmgOG1e8wCqDTpXvetif9QJ1
	Hy82jAtINnlCFcGGj74F0CyBBsNffcflCn7uiK1WkmK5NWjzZP2O8ZqOAVa+Ij1wU/0WDr
	n8iEOG/2q15BVTIk31Wrj3wDCmAgTnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755150533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DStSVktOkl/n6gofwO0PCDNIbvcnCso3mNWL07flB1A=;
	b=9cxvEPi4DKBpBHODpEOu3BsDVKPwLku8n/6t98L8QU373jynM8dRWF8F10aXJ3pvoZ6c/w
	lunixFk5Ee8oCKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B5AB13479;
	Thu, 14 Aug 2025 05:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SG9BEcN4nWiEYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 Aug 2025 05:48:51 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 6/7] docs: initramfs: file data alignment via name padding
Date: Thu, 14 Aug 2025 15:18:04 +1000
Message-ID: <20250814054818.7266-7-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814054818.7266-1-ddiss@suse.de>
References: <20250814054818.7266-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

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


