Return-Path: <linux-fsdevel+bounces-35900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EFF9D9751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C7B236B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F21D2B22;
	Tue, 26 Nov 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TKzBRPKI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tL9iBoWY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TKzBRPKI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tL9iBoWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25527442
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624442; cv=none; b=d3dwnyIvJis60Khfof8ILitbg2onbQZqb3Qgs6KPXITpzD3dtEhchedm0PZ5jI8PN/VgEebQL26cEFx3PLo4XshXDyJl0pIDaae1ZUpFPpFBndUapIjuD6GTK/LlciLn58DaAzD6X0heZLyqETsZueOSmdsv1PBHdGnpJdopNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624442; c=relaxed/simple;
	bh=EwKrdYK/wuwy4Lq8gR/dyraqGdVWk+4V2eTIlbC8jMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jA0uUjvCZMX3x0H7qCiwVfSmUSzM+mniYNaQv9Hhy7btOW77fKwmF6P195mTb5NY+A7PoqAMUavTn1JdgQWuECksHi+5S0a3+Nr391BOhcgdqE+kbnxlDj8Sz6/2Eieamts9TGt1msVqRy2pcfhOUnzIR4MNzflMZPfQiFClRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TKzBRPKI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tL9iBoWY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TKzBRPKI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tL9iBoWY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CF371F745;
	Tue, 26 Nov 2024 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732624438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMuYAwb1imuEU4MhwhHruanvqPLAeJY1EvyYvhCTLdU=;
	b=TKzBRPKI/5wmBOuyUh/pXHI2KQxLVoV/JuPDuoKt81LB05bJFBUrLA1BtEnXeG/TQHdBRv
	X/C68qv1pvYReZYwBGuchbAFWF7M5vxAeC5t7I3+DZfDlv2qgaRHXSaFSScfMt2+/RVRDb
	7X104gUHWxKZSCHE1RkemCSeeuctyJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732624438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMuYAwb1imuEU4MhwhHruanvqPLAeJY1EvyYvhCTLdU=;
	b=tL9iBoWY1xf2jWfxPtfR5hI/qhBOiSwOEwhr7UNTpJ03k+lDobv0WL8/Mm1qWrbTCtiuhi
	5meD4pxEErdkdaBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TKzBRPKI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tL9iBoWY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732624438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMuYAwb1imuEU4MhwhHruanvqPLAeJY1EvyYvhCTLdU=;
	b=TKzBRPKI/5wmBOuyUh/pXHI2KQxLVoV/JuPDuoKt81LB05bJFBUrLA1BtEnXeG/TQHdBRv
	X/C68qv1pvYReZYwBGuchbAFWF7M5vxAeC5t7I3+DZfDlv2qgaRHXSaFSScfMt2+/RVRDb
	7X104gUHWxKZSCHE1RkemCSeeuctyJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732624438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMuYAwb1imuEU4MhwhHruanvqPLAeJY1EvyYvhCTLdU=;
	b=tL9iBoWY1xf2jWfxPtfR5hI/qhBOiSwOEwhr7UNTpJ03k+lDobv0WL8/Mm1qWrbTCtiuhi
	5meD4pxEErdkdaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D03913A27;
	Tue, 26 Nov 2024 12:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WGn6CjbARWfLUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 12:33:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CBB72A0901; Tue, 26 Nov 2024 13:33:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	syzbot+3ff7365dc04a6bcafa66@syzkaller.appspotmail.com
Subject: [PATCH 2/2] udf: Verify inode link counts before performing rename
Date: Tue, 26 Nov 2024 13:33:49 +0100
Message-Id: <20241126123349.24798-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241126123349.24798-1-jack@suse.cz>
References: <20241126123349.24798-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=jack@suse.cz; h=from:subject; bh=EwKrdYK/wuwy4Lq8gR/dyraqGdVWk+4V2eTIlbC8jMQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnRcAsNONEPnjIYZJxMwC3QPUvsDGHSjzQeC8rYCHl 095SkHiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ0XALAAKCRCcnaoHP2RA2QLAB/ 0RLd9lgptKwyBvdabFVG/6fXWcJKhlEV5NKrDkOhzdi8Kj7Jl8egwno5l5uz0hcq0DAMbNsL1EbqGg cUwq/xHpAllhNrrSUdDq7gk8tp8nd1ViVamb1C40Se4qmrfikf04PBu3sQqJ0kwE4WEtFXxpAnhCI8 fgkVuzfuLLDD3XgRFiWhwJ0CLN2LA8HHjNqNMh1flFH8ROaBXCrDw3fKwEJvbf5Rir73YyssQ/0Sck mdwcf/lvcCoNIHDJsPCcHFJjSO7l74c4btoIZ3uuYE6uEVLG15rptaemRS7X05DVxyCGkv6MW0VATL U1wItvuLtJDDcX4+uaW1ddfTjrHESP
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CF371F745
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[3ff7365dc04a6bcafa66];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

During rename, we are updating link counts of various inodes either when
rename deletes target or when moving directory across directories.
Verify involved link counts are sane so that we don't trip warnings in
VFS.

Reported-by: syzbot+3ff7365dc04a6bcafa66@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 2be775d30ac1..2cb49b6b0716 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -791,8 +791,18 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			retval = -ENOTEMPTY;
 			if (!empty_dir(new_inode))
 				goto out_oiter;
+			retval = -EFSCORRUPTED;
+			if (new_inode->i_nlink != 2)
+				goto out_oiter;
 		}
+		retval = -EFSCORRUPTED;
+		if (old_dir->i_nlink < 3)
+			goto out_oiter;
 		is_dir = true;
+	} else if (new_inode) {
+		retval = -EFSCORRUPTED;
+		if (new_inode->i_nlink < 1)
+			goto out_oiter;
 	}
 	if (is_dir && old_dir != new_dir) {
 		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
-- 
2.35.3


