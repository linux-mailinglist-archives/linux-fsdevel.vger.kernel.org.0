Return-Path: <linux-fsdevel+bounces-53920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A757AF8ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A121CA3D9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC95D288519;
	Fri,  4 Jul 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fo7RQdSv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fo7RQdSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9162EAB74
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621906; cv=none; b=nV7skyEV77u0d+o64Jgo/JFWCDxTUjjE+gIKSXxASezS60XSidHeq2NiNkr6UyHLHNgWBDzxQqSyn4B582oIqbkwHWdfPFMD76Kv4eueT197gNvO/K4O5ev1xU6BoJ7/HU8GaOaHqkGHqwpWW5C2HWFBQVjf4d/jrTho0gu6e4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621906; c=relaxed/simple;
	bh=MZ/m/LzYFtOGPWKutlJERuZ0NK5QCkK48HAfhMZPHHg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jwNOAbLO7EZuQ0lkhkGOu/0S1OQe3+5ntboBdN5LhFLwe5PIWFOPj2PbOk9dHzFAnrvjMAJbqpQTfbuKXIe+iAIwgHSMVlZw7fNJexUPjJwPlMuplhGG+W/FpMi1taw/fa+0oaMa6HIvOYQxNlL6+fG0rFAQR+AFDWsRp7iyM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fo7RQdSv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fo7RQdSv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86A1921199;
	Fri,  4 Jul 2025 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751621902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mq2KZrki2JpsFHBKkNkaSG8J4L/fqaXVmneFRNcJ/9c=;
	b=fo7RQdSvXIdo6VoDqNz/c1nqLkNI0ls/OkjlVanhNAeFmSw4piA2C/QNmGSYNtvq4sDgfb
	9932Gei8StaONn4h5o8ukWL7n65skT17S9wVqY2hVIQ/z/9R2a1JJz2PNLVuBOi3l93ZMn
	ysaEilnShh03tGRlqtllQ0Wo6xdtEK8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751621902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=mq2KZrki2JpsFHBKkNkaSG8J4L/fqaXVmneFRNcJ/9c=;
	b=fo7RQdSvXIdo6VoDqNz/c1nqLkNI0ls/OkjlVanhNAeFmSw4piA2C/QNmGSYNtvq4sDgfb
	9932Gei8StaONn4h5o8ukWL7n65skT17S9wVqY2hVIQ/z/9R2a1JJz2PNLVuBOi3l93ZMn
	ysaEilnShh03tGRlqtllQ0Wo6xdtEK8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86C7E13757;
	Fri,  4 Jul 2025 09:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xltVEg2hZ2g8KQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 04 Jul 2025 09:38:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] btrfs: restrict writes to opened btrfs devices
Date: Fri,  4 Jul 2025 19:08:03 +0930
Message-ID: <bf74fa9eee7917030235a8883e0a4ff53d9e0938.1751621865.git.wqu@suse.com>
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

[WEIRD FLAG EXCLUSION]
Commit ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
removes the BLK_OPEN_RESTRICT_WRITES flag when opening the devices
during mount.

However there is no filesystem except btrfs excluding this flag, which
is weird, and lacks a proper explanation why we need such an exception.

[REASON TO EXCLUDE THAT FLAG]
Btrfs needs to call btrfs_scan_one_device() to determine the fsid, no
matter if we're mounting a new fs or an existing one.

But if a fs is already mounted and that BLK_OPEN_RESTRICT_WRITES is
honored, meaning no other write open is allowed for the block device.

Then we want to mount a subvolume of the mounted fs to another mount
point, we will call btrfs_scan_one_device() again, but it will fail due
to the BLK_OPEN_RESTRICT_WRITES flag (no more write open allowed),
causing only one mount point for the fs.

Thus at that time, we have to exclude the BLK_OPEN_RESTRICT_WRITES to
allow multiple mount points for one fs.

[WHY IT'S SAFE NOW]
The root problem is, we do not need to nor should use BLK_OPEN_WRITE for
btrfs_scan_one_device().
That function is only to read out the super block, no write at all, and
BLK_OPEN_WRITE is only going to cause problems for such usage.

The root problem is fixed by patch "btrfs: always open the device
read-only in btrfs_scan_one_device", so btrfs_scan_one_device() will
always work no matter if the device is opened with
BLK_OPEN_RESTRICT_WRITES.

[ENHANCEMENT]
Just remove the btrfs_open_mode(), as the only call site can be replaced
with regular sb_open_mode().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add more details about the original problem
  And the fix that unintentionally solved the original problem.
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


