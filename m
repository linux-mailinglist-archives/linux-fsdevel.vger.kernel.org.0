Return-Path: <linux-fsdevel+bounces-53897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06923AF8824
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D2C582760
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F052609EC;
	Fri,  4 Jul 2025 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IsDbz2EB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IsDbz2EB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831532609D6
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751611273; cv=none; b=QvvOfPbxG+Sz+bbHH9clZrjoNCU6zi9bApC8khTeF/WiTOxcG7Z/fLCIFIS+gq0GKITWQhvY3PwT9N2AR9MxF4sWvxuh/ENe3TDCYF5tXa77txnj6l/bPPzLKgsWYMg2v9n8m1cOjYeSM2xksfJm2y3P4vBN2ywRJ7mZ8wjEFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751611273; c=relaxed/simple;
	bh=PENlf/e+1YNyR9pUELwlf158BnD0tqsLCP7YMyhtpJI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PCdAtqOtEkoR9fg4wsAfACy8u+AH/pP3ll4SHaGBUkpqumMPClq0ENXuRpbFlFPm6nB/4J6/qdEDb8YEMzRvx1ZXXGuAXHSK6sjytPT622DT2DTG7IVlsX68bgXmowjiqsNbjkdWj8gosBs2CEMYEtKMYE2nKO2vGEQe7gPWBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IsDbz2EB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IsDbz2EB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA3D921171;
	Fri,  4 Jul 2025 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751611263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=10ziZD4CLLe8fyKM0HP+OSUIYNcIGZYgVBiqw9sFF4Y=;
	b=IsDbz2EBIdeSjDdF3Iszzi5lDwD9248r5ArmSE5jhMaIjeb/UwTp17Z8yTnW9LfpipDh9x
	UqRpmHbiltdRmGtlJOGGtuNtN/FIBjEJvoK61Fecha5IMES/2IFx4LqzHxuRprF6u5PK3d
	/A21FzHLkB1xUHyb00x4gAmPcIQ/E2w=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751611263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=10ziZD4CLLe8fyKM0HP+OSUIYNcIGZYgVBiqw9sFF4Y=;
	b=IsDbz2EBIdeSjDdF3Iszzi5lDwD9248r5ArmSE5jhMaIjeb/UwTp17Z8yTnW9LfpipDh9x
	UqRpmHbiltdRmGtlJOGGtuNtN/FIBjEJvoK61Fecha5IMES/2IFx4LqzHxuRprF6u5PK3d
	/A21FzHLkB1xUHyb00x4gAmPcIQ/E2w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B767613A71;
	Fri,  4 Jul 2025 06:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fkUxHn53Z2gIcAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 04 Jul 2025 06:41:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] btrfs: restrict writes to opened btrfs devices
Date: Fri,  4 Jul 2025 16:10:44 +0930
Message-ID: <71033485f3e1802afe62ad6e118d5722845ec1f3.1751611231.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Commit ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
removes the BLK_OPEN_RESTRICT_WRITES flag when opening the devices
during mount.

However I can not figure out why we need to exclude that flag.

Even before that commit, btrfs_open_devices() is protected by
uuid_mutex, thus there will be only one process winning the race and
open all devices properly.

The ones losing the race will still grab the same fs_devices, but only
increasing the open counter, not really opening the devices read-write
again.

So there seems to be no special requirement from btrfs to explicitly
exclude BLK_OPEN_RESTRICT_WRITES flag.

Just use the common sb_open_mode() to do the device opening.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index dd6e8a50ac39..0587e4973564 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -261,12 +261,6 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	{}
 };
 
-/* No support for restricting writes to btrfs devices yet... */
-static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
-{
-	return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
-}
-
 static bool btrfs_match_compress_type(const char *string, const char *type, bool may_have_level)
 {
 	const int len = strlen(type);
@@ -1843,7 +1837,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	struct btrfs_fs_devices *fs_devices = NULL;
 	struct btrfs_device *device;
 	struct super_block *sb;
-	blk_mode_t mode = btrfs_open_mode(fc);
+	blk_mode_t mode = sb_open_mode(fc->sb_flags);
 	int ret;
 
 	btrfs_ctx_to_info(fs_info, ctx);
-- 
2.50.0


