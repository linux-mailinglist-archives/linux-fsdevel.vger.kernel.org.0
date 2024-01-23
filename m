Return-Path: <linux-fsdevel+bounces-8590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35145839294
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 882C5B240A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56FD60241;
	Tue, 23 Jan 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gt+VT4IA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cqYtvH7g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gt+VT4IA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cqYtvH7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0F50A69;
	Tue, 23 Jan 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023529; cv=none; b=o2TccfEqtM8sWHGDC16+VhTNmR6dGfYwVWBn8z1jfx5HRcufAOk9wPH6M0UV3pRfAY+Ay0mWTT0rAePUFvf2Y47S3yEzVtXzqVaXZfAjAede2vOZt1VHXIhFk9US95ck7bfavUUxolJSQXR9yNeqhPRXSSPKeECflyTs8/WtqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023529; c=relaxed/simple;
	bh=RYcHNi+xKW7jK9A61eUsZ9qSxqKSTDlx6JYBz35Kcfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ldKQftxjXCZ6TIMJFxLXT/Yty065mRpunyc8kSZNgPMqDRxAJBAfqcZjAcoF0CyucL+8wjMJ1Or2VzvapeGx5nfRUDWWTyE85Nu1VQPC+scz5PljlvnopOlpPQ2MHSuWest98fVS8Ny9Em3nCSPKSaEneEmN75FkXG6WRBwFSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gt+VT4IA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cqYtvH7g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gt+VT4IA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cqYtvH7g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79C06222A4;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzLJs0PCqRN+5hB9gyvhRk6iW2jsPO147i/0WvAWKUw=;
	b=Gt+VT4IAZ1WN+/XwjbcqTxEvqJ2hnnov7df/Hz+GT3LXJQDGzn1rK7XFgCmCXM/MJcAzKa
	BZm5kF/fJv89bImOfqNnyhaU7sgTRQZhJ9Ky6XXd/yhx2KSMWls9rmUx0wSFFMiWxh/0Wx
	QBSrnY2lwZAVAtC9tvXh6MO0ovVn+XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzLJs0PCqRN+5hB9gyvhRk6iW2jsPO147i/0WvAWKUw=;
	b=cqYtvH7gdAAgPzSh1eF60VHBKRzl2E7Xcz02gvQjzKNDugCeHonBu+Myld4zpqvSmVpoq+
	+Sxc4hGgJYWRDzDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzLJs0PCqRN+5hB9gyvhRk6iW2jsPO147i/0WvAWKUw=;
	b=Gt+VT4IAZ1WN+/XwjbcqTxEvqJ2hnnov7df/Hz+GT3LXJQDGzn1rK7XFgCmCXM/MJcAzKa
	BZm5kF/fJv89bImOfqNnyhaU7sgTRQZhJ9Ky6XXd/yhx2KSMWls9rmUx0wSFFMiWxh/0Wx
	QBSrnY2lwZAVAtC9tvXh6MO0ovVn+XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzLJs0PCqRN+5hB9gyvhRk6iW2jsPO147i/0WvAWKUw=;
	b=cqYtvH7gdAAgPzSh1eF60VHBKRzl2E7Xcz02gvQjzKNDugCeHonBu+Myld4zpqvSmVpoq+
	+Sxc4hGgJYWRDzDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68BBA139B1;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tSuLGWXar2WYdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA7C7A0808; Tue, 23 Jan 2024 16:25:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4/9] udf: Remove GFP_NOFS allocation in udf_expand_file_adinicb()
Date: Tue, 23 Jan 2024 16:25:03 +0100
Message-Id: <20240123152520.4294-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=jack@suse.cz; h=from:subject; bh=RYcHNi+xKW7jK9A61eUsZ9qSxqKSTDlx6JYBz35Kcfk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pPvhS/hzxWqf76meTP/IfQTuPd5gXityBVBIqn rtlTQSiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aTwAKCRCcnaoHP2RA2TufCA CeFM8Jm3yJ57PVVuPPsizuwOaKOZ4I2beoBcmuX5dFk2GAO8RI2glKRPKOBBA4FysS1bWg6BPM2kc1 RaYvQm0I3xUbAzE3JFsz2jFviPJcHv8WhYniqZU5dEjUrOAptWomAdw6XsjhSCCN2WtyekR8G/HQlc mrnGHI7wrO4o9yH2qDi88RR3HzqFSkmGAR/vcj8uKIVNBcC1vxJ/8z8Vgqfkw3HJOLc15xDAIIpSLZ ND4ACUC2F/OHcEFMb5IYJgn5OYd+gLnNnPvoQalJKejKYsXYvIY+qnoCj9wg48WFOTAe9z2XHijnoT cL5BA3TqlYA8qBVAd6j+WN98W+BZBH
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

udf_expand_file_adinicb() is called under inode->i_rwsem and
mapping->invalidate_lock. i_rwsem is safe wrt fs reclaim,
invalidate_lock on this inode is safe as well (we hold inode reference
so reclaim will not touch it, furthermore even lockdep should not
complain as invalidate_lock is acquired from udf_evict_inode() only when
truncating inode which should not happen from fs reclaim).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d8493449d4c5..2f831a3a91af 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -357,7 +357,7 @@ int udf_expand_file_adinicb(struct inode *inode)
 		return 0;
 	}
 
-	page = find_or_create_page(inode->i_mapping, 0, GFP_NOFS);
+	page = find_or_create_page(inode->i_mapping, 0, GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
-- 
2.35.3


