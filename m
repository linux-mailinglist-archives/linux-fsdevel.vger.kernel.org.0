Return-Path: <linux-fsdevel+bounces-23937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D193504E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEB01F23330
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03491459E9;
	Thu, 18 Jul 2024 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dy4l8weL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K1tKwXqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64314534D;
	Thu, 18 Jul 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318279; cv=none; b=GLIe7cYwBqEzAnSHt2JUBI/dLlJiXzxVdThn2VoEblSYwsynCPfOT0oG5Yw4oK9pVCwAf51U163gNEWwqdFvcb0uBwGo8bohbvjJ8lyPfDFuio/DEuJeJRrpciun0S1Lr70WRFaX3LGTNGujROeUWdcRdzwKl+0MTesv6MfvKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318279; c=relaxed/simple;
	bh=bqp5rL/4cgQTeVHXHvBw1znXDTvP0d/Nl0NOWUeGnPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bE3mATAZPk6RUJzW3gVKX4OpojTwy8dN4rRD2T/HhbsM/kmSErBS6DhcYmMMEooKL2+nPxL7ATzES1wCdWyCmTY80AFcJ2RUTte16GliS82E55NQ2vuR1EeNgcz+DKRUBwGR4cwyNX5EKSt0NTM9fK3kKFiEyhcID4y9dWNLCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dy4l8weL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K1tKwXqu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4AAE1F747;
	Thu, 18 Jul 2024 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721318276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aDx+OsNKCeLYa4bby9T0KdvITs/mIqsVtsc56yLvxGY=;
	b=dy4l8weLNwFxpNZYO+CS4wTAgLfSO4DMPzR4jhVirNv/T6aWf39Q7CkFwkzblSIgy3vlPD
	P51A0GPZx+J+9JV8kLSUqpVtnKP20zuWvaxt1NgG3PIeLj2GlFEhz5HGifmE8Q1ADs002d
	8Wc2nbGaB+tyY+WOYsH4QvTc4PUXpOg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721318275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aDx+OsNKCeLYa4bby9T0KdvITs/mIqsVtsc56yLvxGY=;
	b=K1tKwXquJWyQUrjxElB4eTRc1WSTpklPk7G5eVZVnMwH1c8ghUszMmDj6VpPbaUkrI4+fg
	sZhrwqCCRLtJuPT4+Gv4YPYusgNCuPBV/jc677I5AwCizQWepNK/p/jGF/sXGlOe6Jb3AA
	Q2BI3a95dda2uQOzFAxQE7JWf5mhOlw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C34701379D;
	Thu, 18 Jul 2024 15:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AoamL4M7mWb/NAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 18 Jul 2024 15:57:55 +0000
From: David Sterba <dsterba@suse.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs/220: remove integrity checker bits
Date: Thu, 18 Jul 2024 17:57:54 +0200
Message-ID: <20240718155754.15499-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

We've deleted the integrity checker code in 6.8, no point testing it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/btrfs/220 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index b98d4149dfd270..59d72a972fdd16 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -192,11 +192,6 @@ test_subvol()
 # These options are enable at kernel compile time, so no bother if they fail
 test_optional_kernel_features()
 {
-	# Test options that are enabled by kernel config, and so can fail safely
-	test_optional_mount_opts "check_int" "check_int"
-	test_optional_mount_opts "check_int_data" "check_int_data"
-	test_optional_mount_opts "check_int_print_mask=123" "check_int_print_mask=123"
-
 	test_should_fail "fragment=invalid"
 	test_optional_mount_opts "fragment=all" "fragment=data,fragment=metadata"
 	test_optional_mount_opts "fragment=data" "fragment=data"
-- 
2.45.0


