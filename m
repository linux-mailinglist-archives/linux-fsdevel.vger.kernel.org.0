Return-Path: <linux-fsdevel+bounces-62111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A75B84241
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AA1523CC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D7C27978C;
	Thu, 18 Sep 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YsIbb7Ud";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J8ISs/bh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YsIbb7Ud";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J8ISs/bh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56C13B280
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191825; cv=none; b=fmckteKszeKaF4NPgiweCdkjNGZrw5Fokg5nb5KkPczvPevEZbFUSX0pBjBRrB9sCg3hF1B8QCkvoDKgi7Qdi8yR9lYtewi0A7Hu7lSMR7aVM8sCbyiotZuUfD7pLlRxqyxqUTFwWlVBkZTjRDoY/ahKpyBymF9ueS9YLKKsbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191825; c=relaxed/simple;
	bh=Zl0/HGDxUmy25vcaqBLLMEVZRoopwwTEZcDoBOvtwmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGZT/3K5QuL2v9Hv5s8toQyS3ugaRY9NM3VX7B+/pPEvDuBGfp6mNPVc9eUZPpIAo+k/8h5gMb2fIZImJ0TDOWmko8q7hv5zObOfffCFScdo4ZCsTe75UqnXC9s7rpOPJrOSFtrmGTGdgIqPEVNsEKrFKs0qRf6gk+Ag1upfk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YsIbb7Ud; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J8ISs/bh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YsIbb7Ud; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J8ISs/bh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A052B1F7E9;
	Thu, 18 Sep 2025 10:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758191820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HyZHHW3d+FbMk9XZQyPkfuT0T5wtgR4NiN0rPi3b8Cg=;
	b=YsIbb7UdSchZLldP8JbwNv143MZ4aO1Ww3rhWJXzxPolTOxpsDK+09rgl/rn94ncXI3laj
	e9OQLbwUhn6eis/HU7m/ldNljrKvp+PTzb+MtxVZSsI15OoDONxWHOLCM7KFXBLOhUuaJG
	HJbZmolArK7qIg5BekjmkHsl+XaWw8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758191820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HyZHHW3d+FbMk9XZQyPkfuT0T5wtgR4NiN0rPi3b8Cg=;
	b=J8ISs/bhRcXtdwxdvseonA+tWUL5uL5UT6gO0QX97TDWNl9xBepz3JWn1ccNlvoPWuHHL3
	JLbMDXyAHzuoxZBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YsIbb7Ud;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="J8ISs/bh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758191820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HyZHHW3d+FbMk9XZQyPkfuT0T5wtgR4NiN0rPi3b8Cg=;
	b=YsIbb7UdSchZLldP8JbwNv143MZ4aO1Ww3rhWJXzxPolTOxpsDK+09rgl/rn94ncXI3laj
	e9OQLbwUhn6eis/HU7m/ldNljrKvp+PTzb+MtxVZSsI15OoDONxWHOLCM7KFXBLOhUuaJG
	HJbZmolArK7qIg5BekjmkHsl+XaWw8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758191820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HyZHHW3d+FbMk9XZQyPkfuT0T5wtgR4NiN0rPi3b8Cg=;
	b=J8ISs/bhRcXtdwxdvseonA+tWUL5uL5UT6gO0QX97TDWNl9xBepz3JWn1ccNlvoPWuHHL3
	JLbMDXyAHzuoxZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DC3C13A39;
	Thu, 18 Sep 2025 10:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PVmUIszgy2jhcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Sep 2025 10:37:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7C21A09B1; Thu, 18 Sep 2025 12:36:59 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] writeback: Avoid uninitialized variable warning
Date: Thu, 18 Sep 2025 12:36:47 +0200
Message-ID: <20250918103646.28698-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=jack@suse.cz; h=from:subject; bh=Zl0/HGDxUmy25vcaqBLLMEVZRoopwwTEZcDoBOvtwmM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBoy+C++gmhLNYXnIGvpJOHMiSFBfFA7TdkEj/4g Fpu/Y/kjymJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMvgvgAKCRCcnaoHP2RA 2eCjCADXWdYsX0kic6Ne8w5qsW8e315c0arrsMGrplY88dofeAzcUWFW5Pc1BmeMhp0kNeN3TM5 KZfCvDA/dhtMBlZrQ9FSBwJpfpVQJ8wnKjK1gjnUA1zFMX6QC0z215TtJA4QpjUQr/eiPvarU5i OySVkmJS7+jvLk96lCx2aSRuCnx4ncHg0V44PPVTBnXISJpWo5HuKtwCmSoi15yCNm94IoATOOX k+0ERkQIjaTAiWfmEtpmupNqwBnAU81U4M2BjS/+/0m1x2jNxfOMS6w3D2Yk4lSLd0yNYQaHtfe P5W0POAPD3P5oVB8T0oNCORoJ8Gli89hHg2S9hr3eVaKv89W
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A052B1F7E9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Smatch reports that 'new_wb' in cleanup_offline_cgwb() can be used
uninitialized. This is actually not true as root cgroup never gets
offlined and other cgroups have a parent but still it's reasonable
defensive programming to have new_wb initialized to NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Christian, please either merge this patch or fold it into 67c312b4e9bf
("writeback: Avoid contention on wb->list_lock when switching inodes") in your
tree. Thanks!

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c1b20ac94e3f..dd4930d2e9e6 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -709,7 +709,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
-	struct bdi_writeback *new_wb;
+	struct bdi_writeback *new_wb = NULL;
 	int nr;
 	bool restart = false;
 
-- 
2.51.0


