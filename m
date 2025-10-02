Return-Path: <linux-fsdevel+bounces-63306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334DBB473C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 18:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2F23B3411
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058882417C5;
	Thu,  2 Oct 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RDmNZmW0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tp3W3ewp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="udzK+bp9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kVCpBs0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DA2BD03
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421452; cv=none; b=VQgz77r5KXGUJFAWZMTNQue0SQ4+MAtZ6Dv8M+Y0s1/iSDS9ADYjEn2XZiH1iRkGUMah/kb6VbTLrnKoJDXilxrvjinjbBR8YVhN5b4zQb52nEJSEvEos98rTLtqxG6Tp/qMWqrx4Z62AIgzShEgzWrCYRM+MLOceIk3ZzeiMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421452; c=relaxed/simple;
	bh=rYQip8YriAWHevIYNUakF0xNMVh4JjPY+NxXhpunQrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMFq2s5FCU7EFLmtL7DL/U9NQabuDAyWLuBukbiV5iS4z3uRVlFybhtH6dMx32pHIQ26yeM5UiOQy+0xNQjRHH3yugUp1DA5R9xbsXPgX4f+JgiwXkGBE3XNiDUnQWbYgo1IAE9qdWKlwgsJ4e7VGEqCFhuqvfMp/ZGEODua+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RDmNZmW0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tp3W3ewp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=udzK+bp9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kVCpBs0I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F55B1F74C;
	Thu,  2 Oct 2025 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759421448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CpuVhLQtiQcA3ZMZbbopifPFO4WjbF+1Tmvb0zVyxHA=;
	b=RDmNZmW0iv0OKO2F/EmPHH2rR5SPXi39liX66eHQ4IAUXwbenyEceQgmtmLPLgLQpvr4bB
	gGpw+3K5S6M5hhXVgvYIztcFCoE+9TYybiXlMKyKiPNfcFaLlibKo/ZV2UjnhP25F6RY0k
	OXm9PlB5NyMacXrdotSH44LNCkU8PFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759421448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CpuVhLQtiQcA3ZMZbbopifPFO4WjbF+1Tmvb0zVyxHA=;
	b=Tp3W3ewpH9+5W/IOZy6k/YKs5NoobZo8dPUIl0uJcP8q4LH8YB0S7nt3buij6eFSrv5jpP
	lX7m2HfSIZqOUkCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759421447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CpuVhLQtiQcA3ZMZbbopifPFO4WjbF+1Tmvb0zVyxHA=;
	b=udzK+bp9VVjqP+FnWmQjCAsdwfyLueh4N/gjMi5l2LqeORtgaVlYShhFJSwxiG00vTIUaG
	BbHzYW2u2GGXz/7erN/wNlPCEeAhhPDiUIY/XFxUkwYKuBAEerMPpIBddcUJYs/AABhxcN
	8ArQ5UYrGA/ifv0O+ea2wisgNMQcquk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759421447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CpuVhLQtiQcA3ZMZbbopifPFO4WjbF+1Tmvb0zVyxHA=;
	b=kVCpBs0Igo6Cqeo1YVnxIue/2flVIXe2AxiXETr2d76wM/kyRCeioN0XCInuPQtS5r14y1
	UpSDqfxNk4pBruDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 201E71395B;
	Thu,  2 Oct 2025 16:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N+qDBwek3mi2bwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Oct 2025 16:10:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BBC97A0A58; Thu,  2 Oct 2025 18:10:42 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com,
	syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Subject: [PATCH] ns: Fix mnt ns ida handling in copy_mnt_ns()
Date: Thu,  2 Oct 2025 18:10:40 +0200
Message-ID: <20251002161039.12283-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=jack@suse.cz; h=from:subject; bh=rYQip8YriAWHevIYNUakF0xNMVh4JjPY+NxXhpunQrY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBo3qP/6rKX+Vr6zv3qetVy+sziFa1B6StPYuj3o rnpTHcR50aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaN6j/wAKCRCcnaoHP2RA 2d8VB/9mD9zk9lOgJjfeTZL9rLX9l062CB0YoWEs8lUsoz2PUc5FXkzd5Tcim17ARBKIKO3oGuv hekNRZrMkHifkVY1YqKT9tV1Rt+KoYjTcY6J+5uHzNrFgKL2BBxRT4U/0rpzjn0tByqvFwB7cSc AWwBpBR6zks7lyOTmV2ZymCs2Oq6d9AlUix4P36BYZge9A8wBkV5HVQxuMVqLrfFuBs1YKdPYoe jx+SF5jQHvynWqg5mw15DSjzzVy6XqraQOb94nU0VfMuSIssxuB4adxcY8icz4+RyLk7eCil9q3 e3GeCS97HfoYyLkhR2HQOg0fuJ86QoydH+zAtWXj/nMXa3bB
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[7d23dc5cd4fa132fb9f3,e0f8855a87443d6a2413];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.30

Commit be5f21d3985f ("ns: add ns_common_free()") modified error cleanup
and started to free wrong inode number from the ida. Fix it.

Reported-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com
Reported-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Tested-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com
Fixes: be5f21d3985f ("ns: add ns_common_free()")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index dc01b14c58cd..1ba97d745019 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4165,7 +4165,7 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		namespace_unlock();
-		ns_common_free(ns);
+		ns_common_free(new_ns);
 		dec_mnt_namespaces(new_ns->ucounts);
 		mnt_ns_release(new_ns);
 		return ERR_CAST(new);
-- 
2.51.0


