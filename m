Return-Path: <linux-fsdevel+bounces-10582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E4384C7C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7385028DC80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7594922F0F;
	Wed,  7 Feb 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N2wCuNM6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ArNwYohN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N2wCuNM6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ArNwYohN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F60322338
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298934; cv=none; b=gR4nm3eNKow9weUIL6PnCu5V1NQyUTiZ4bgKUlj7344CgxuFGRBZqlrMs3hHQLYSJrS6uLWvRnQSgA6sV0YiQO4mcFOvKIHe7dJ3/za+c9Y4Vb4Ub2hvH3gta+s/F82b/0DzrFtkbRQquusnwqeyuI3tE8dOxnSEEpoz5JHOejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298934; c=relaxed/simple;
	bh=eRPmziDp8bOkQBb547mKPxVRetupTzYebxqqpi6QY1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e1UKGDNwkm1/SdYClox0qEjWjUB/PEbR6B796kF6nDAoX/2QCAh3i5Ax7PFeUhBy/Cn+LSiavaXYVL0aaEDrVVqGup0HBSNMOhrKBog3oZbmT/Q86KcC3nvJsrPhKV5B0PQGt2HNfH7m3XcEwMyIPWbXTSdb+jdXWL+i+kE5XNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N2wCuNM6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ArNwYohN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N2wCuNM6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ArNwYohN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34EE71FBB7;
	Wed,  7 Feb 2024 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707298931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sWXdlUYMtiAI8lFz/cfvN8d1MZZotvyXGdZj44Tal2I=;
	b=N2wCuNM66QGiY41wcvE0TPJkBeYN5w0Zay3X2RxUAfVNFNH6/XhGNdS/8imyo5EHjXHD1v
	AoSuqdwCTxitaUSQ8xar0405E6YXrdPO8TsfRh9rWwAvCsdYTihOviZSzREYm6qJdpB2Lx
	gH3Ejd/18RuMGINZ7BCZKeZSrPwzpmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707298931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sWXdlUYMtiAI8lFz/cfvN8d1MZZotvyXGdZj44Tal2I=;
	b=ArNwYohNz/lCGB2f+xAvzLbqkVkRDqAY0kGOj2afX1iWI9a/jyz1JZv6xsqKqnh5DqdITZ
	aAgmpnct9alWJ3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707298931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sWXdlUYMtiAI8lFz/cfvN8d1MZZotvyXGdZj44Tal2I=;
	b=N2wCuNM66QGiY41wcvE0TPJkBeYN5w0Zay3X2RxUAfVNFNH6/XhGNdS/8imyo5EHjXHD1v
	AoSuqdwCTxitaUSQ8xar0405E6YXrdPO8TsfRh9rWwAvCsdYTihOviZSzREYm6qJdpB2Lx
	gH3Ejd/18RuMGINZ7BCZKeZSrPwzpmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707298931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sWXdlUYMtiAI8lFz/cfvN8d1MZZotvyXGdZj44Tal2I=;
	b=ArNwYohNz/lCGB2f+xAvzLbqkVkRDqAY0kGOj2afX1iWI9a/jyz1JZv6xsqKqnh5DqdITZ
	aAgmpnct9alWJ3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 284EB139D8;
	Wed,  7 Feb 2024 09:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9R2JCXNQw2V5UwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 09:42:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C857AA0809; Wed,  7 Feb 2024 10:42:10 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] quota: Use proper __rcu annotation for i_dquot arrays
Date: Wed,  7 Feb 2024 10:42:03 +0100
Message-Id: <20240207093810.6579-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=317; i=jack@suse.cz; h=from:subject:message-id; bh=eRPmziDp8bOkQBb547mKPxVRetupTzYebxqqpi6QY1M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlw1BlHSNBehMasWg6/ukPtiYeP9xF9M06Z66FaSEH 9d34tSmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcNQZQAKCRCcnaoHP2RA2c0NCA CHHfFCJx9sZVl0EDwhTbtXanz0ueoxKv3dhUP28QHIissWDRjk0SHsB26IOtVLqdo7gQwn/YV4j+rf gb1sWBwxlRyiQVfP3g06iWcpITsJRz/UhNysEJnG0yVKCDLgEJTv2BkJlmbDHB41bmLzfyRJ5ok9Dl J1bW/kCLwuqStFCUGeiy1X4PaTbEr4Qh//OrcGd7tNjdZrZ/3Dw4Bq+rB/K2JaWG5Sa0THHXGXntTX uebS2vc0bh/99gnTvgViJuc69J6i/ica0nWbmDmhmLYFfqvZG/EsDIQq4JcrYR6DYqHLCRAV0GaXUZ 8fB7PzLpaJnXUV6p7qMesgs9oibqkk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N2wCuNM6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ArNwYohN
X-Spamd-Result: default: False [1.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.07%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.17
X-Rspamd-Queue-Id: 34EE71FBB7
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Hello,

0-day robot sparse runs have noticed that i_dquot arrays in inode do not have
proper __rcu annotation (as they are protected by dquot_srcu) and when fixing
that I've noticed we don't always use proper accessors for the array. Fix
these issues. I plan to merge this series into my tree.

								Honza

