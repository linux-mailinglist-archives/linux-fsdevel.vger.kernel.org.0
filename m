Return-Path: <linux-fsdevel+bounces-79168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBOvKza6pmn2TAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 322101ECC95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAC3030A41DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7B39890C;
	Tue,  3 Mar 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QrHVjyCH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Ksg1TAI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QrHVjyCH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Ksg1TAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6E3822B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534183; cv=none; b=DpZ6BMWM44S8ImJYkyb+HuY5BfbJYq6jO46iYhs9srdIyASI46MrhPxQnT+R8aPmySa3VoI/zYCYXgdFd6GEcFi80exJMXXwwdZrbbABpEuNWbFs3uIKleK496xcY3bY0bD/8dyRsOopdiWKyiG3RTtM6QTmdRGJJAF/qaovLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534183; c=relaxed/simple;
	bh=78gO3+UDRJwzzldfnEs3JfBLvPYcMCiUADzm2KJFKww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHSPQH7DawLSnklMxJMDqpNJZExn7cj2jYC1pvoAcTmP/+TELNwLIUnuHyymVsm98/BV+xBIf2vBUO2Nk11d6A/8TKzyVzECxznpODHGYJzqwct9GaGm+fZsoj7cDnAAuCpyOsoDP4IRCwyQSNZFwvkQwRFUEvZ/32csen61mG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QrHVjyCH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Ksg1TAI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QrHVjyCH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Ksg1TAI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 411A83F934;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvlI42BLgG88v9mLMZEY6KwxqWwniFDDye01LEogM+U=;
	b=QrHVjyCHgBcbxeBPQFKzXdCdl6euZbFADe5DaL9sIwDOakfMzy/9uY4/HwmQktvGguvOLn
	tE/bRB0STbZ7770Gy3gkPhgBBYeYZrJedcyNReAg/zf0i7cwePufn1Gb2N0lVIrwFA77O2
	7vNSO66eHSZNCUnaCT1rU2FyMKePCsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvlI42BLgG88v9mLMZEY6KwxqWwniFDDye01LEogM+U=;
	b=+Ksg1TAIazn6n/+uTkdxvVTw/ogA9Vnd1LpSdPR0RCFdDu/sjYsrxLi7wxNt/umVWz582T
	w4F6CtwIgAkm3TDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvlI42BLgG88v9mLMZEY6KwxqWwniFDDye01LEogM+U=;
	b=QrHVjyCHgBcbxeBPQFKzXdCdl6euZbFADe5DaL9sIwDOakfMzy/9uY4/HwmQktvGguvOLn
	tE/bRB0STbZ7770Gy3gkPhgBBYeYZrJedcyNReAg/zf0i7cwePufn1Gb2N0lVIrwFA77O2
	7vNSO66eHSZNCUnaCT1rU2FyMKePCsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvlI42BLgG88v9mLMZEY6KwxqWwniFDDye01LEogM+U=;
	b=+Ksg1TAIazn6n/+uTkdxvVTw/ogA9Vnd1LpSdPR0RCFdDu/sjYsrxLi7wxNt/umVWz582T
	w4F6CtwIgAkm3TDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34E8D3EA71;
	Tue,  3 Mar 2026 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNDpDEW5pmmGFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E00C4A0B6B; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-ext4@vger.kernel.org>,
	Ted Tso <tytso@mit.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	linux-aio@kvack.org,
	Benjamin LaHaise <bcrl@kvack.org>,
	Jan Kara <jack@suse.cz>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Subject: [PATCH 19/32] ntfs3: Drop pointless sync_mapping_buffers() call
Date: Tue,  3 Mar 2026 11:34:08 +0100
Message-ID: <20260303103406.4355-51-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=jack@suse.cz; h=from:subject; bh=78gO3+UDRJwzzldfnEs3JfBLvPYcMCiUADzm2KJFKww=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkuXPN5sVNbZNgPUpw40epP2DctibWzh2DnS Wqw5U1nxlyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5LgAKCRCcnaoHP2RA 2WYvB/9SuKl25yl4NLc1kRhZsUFYo7EUNYt1AQEr7OzhL8Iedk7M248nW/vrvKPw3Eub9PCFlN4 9vPMFrc8CQuxROnE+aP9P+segvusk7PFrNJrB2m+52DzCdaRoJsjksDEYEgaGRGQ1c6Dl3tCg3F kXeXPRo7NudfCTZ7wqQ79IJmrRiraLlFnnmNOduphbcUmSjLX992sIsw3GKmIRVfbYrcuBDCsMO GT8j7nUR17OGHoAw/J6GTFeMW75IKXxGHKCfE1alo+BbKIpLVWzKqUReXtai5x0eV3hKy9JvABN e5lcxdX6MG+EdxtjmgPuvw6KtwMsanp2ei6tGj/zuAq6uBDo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 322101ECC95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-79168-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz,paragon-software.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

ntfs3 never calls mark_buffer_dirty_inode() and thus its metadata
buffers list is always empty. Drop the pointless sync_mapping_buffers()
call.

CC: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
CC: ntfs3@lists.linux.dev
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ntfs3/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 7eecf1e01f74..570c92fa7ee7 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -387,9 +387,6 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 		int err2;
 
 		err = filemap_fdatawrite_range(mapping, pos, end - 1);
-		err2 = sync_mapping_buffers(mapping);
-		if (!err)
-			err = err2;
 		err2 = write_inode_now(inode, 1);
 		if (!err)
 			err = err2;
-- 
2.51.0


