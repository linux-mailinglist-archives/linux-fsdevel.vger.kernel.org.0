Return-Path: <linux-fsdevel+bounces-44244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3794A66818
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4DB3B9393
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DCB1922D4;
	Tue, 18 Mar 2025 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IR4h8FJJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vgVi0BOv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IR4h8FJJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vgVi0BOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3A4A07
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271071; cv=none; b=uR1GznnFYiLMP+nt9nAihJi5f9l86grlv3VExkCeyGcQrI4jMfasTUvsa0JITtSWiXZAw791isgrlbebXAwEwEmNbxwYhtSnOnp86h7zO9OqU5y82Ldmkob1YEuhpUP1U9mRFwsZZEjbZ78oq2ApU6m1S+t/t5KqCt3xRBKWZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271071; c=relaxed/simple;
	bh=Y8biQCowtBUc/xFrGJf6aiStt9sdR7WzA4nEpBW522s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UaWYmmRC5CQO0qvomODCgK0T8GemhFeK/8UP3t2iEL8DPiFcjN5Uxfhr5ZWoSvV+Zcw5e/dBj1D+mRyCbEos4PFxtFY723L2IsAS3Ki0bdp+NhoZ7DTz0Oo2nRNYDY6Zq0oc+7GY3aHqioJ8cPjaaql5rZUb6ki2aLjQWcmw+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IR4h8FJJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vgVi0BOv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IR4h8FJJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vgVi0BOv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21FDB21D07;
	Tue, 18 Mar 2025 04:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742271065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JB5NQ5kzhVdiEgYJ5Q9lR3ouh6ukRlMDtFjfvGVn46M=;
	b=IR4h8FJJ8TsZNM5MeYe+9KwvS03EaTlod2m1kZEERQvaYQiRVeVH/L1VMJeYyqhU8cexnH
	PGLUK0xumfQDvpFgIX3PYiFg6jxN+N3vqKBdmhqaoEdc7Qlb3y3w/vi7DenJNHMTpFuyJo
	kxzTl7KMMEpuzwGMtuJxqQ29ZCXz570=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742271065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JB5NQ5kzhVdiEgYJ5Q9lR3ouh6ukRlMDtFjfvGVn46M=;
	b=vgVi0BOvf1bSV6bEZV38VxRMNf5YvuNdWJZQmlXNISyHcWQRjMIezMzxFh/JyD0H+7X/zC
	HAmJWVXsv4Xq5NAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742271065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JB5NQ5kzhVdiEgYJ5Q9lR3ouh6ukRlMDtFjfvGVn46M=;
	b=IR4h8FJJ8TsZNM5MeYe+9KwvS03EaTlod2m1kZEERQvaYQiRVeVH/L1VMJeYyqhU8cexnH
	PGLUK0xumfQDvpFgIX3PYiFg6jxN+N3vqKBdmhqaoEdc7Qlb3y3w/vi7DenJNHMTpFuyJo
	kxzTl7KMMEpuzwGMtuJxqQ29ZCXz570=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742271065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JB5NQ5kzhVdiEgYJ5Q9lR3ouh6ukRlMDtFjfvGVn46M=;
	b=vgVi0BOvf1bSV6bEZV38VxRMNf5YvuNdWJZQmlXNISyHcWQRjMIezMzxFh/JyD0H+7X/zC
	HAmJWVXsv4Xq5NAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AFF313314;
	Tue, 18 Mar 2025 04:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /982MVby2GfnSwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 18 Mar 2025 04:11:02 +0000
From: David Disseldorp <ddiss@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] MAINTAINERS: append initramfs files to the VFS section
Date: Tue, 18 Mar 2025 15:07:11 +1100
Message-ID: <20250318040711.20683-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

At the moment it's a little unclear where initramfs patches should be
sent. This should see them end up on the linux-fsdevel mailing list.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a5089..67d52d1c35b4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8901,6 +8901,9 @@ F:	include/linux/fs.h
 F:	include/linux/fs_types.h
 F:	include/uapi/linux/fs.h
 F:	include/uapi/linux/openat2.h
+F:	Documentation/driver-api/early-userspace/buffer-format.rst
+F:	init/do_mounts*
+F:	init/*initramfs*
 
 FILESYSTEMS [EXPORTFS]
 M:	Chuck Lever <chuck.lever@oracle.com>
-- 
2.43.0


