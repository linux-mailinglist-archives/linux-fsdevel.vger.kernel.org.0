Return-Path: <linux-fsdevel+bounces-36495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F302F9E4302
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 19:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0581167034
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E722391A0;
	Wed,  4 Dec 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbcuQFsx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQ88MfQ0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbcuQFsx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQ88MfQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCBA239180
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335832; cv=none; b=MnhWRAO0B1nl7cic3GB3BYkrvKEaJ6MhLam3//te5bFXr3IvIeAETXs3DGA+F8AX4AUPBBWeb5gZrBfz1hdFMn6PdSVzMbMUbkLJI5i7r9EWog3Mxwh1yea1dCRjHhH35YjWnN6LoiYP2EEzuzCNsH9n9R+cWpM+dJ2Vhdc6GK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335832; c=relaxed/simple;
	bh=qsnbtMcDW53WttW8Db8GDkWi6xWRN01H+NvvxSvIAc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fw10nVdnTTFlKhtIJVmiAhkdwP4vgUKRtTQ7/lxgsMmACe6ERx2RnT87JOuwZS5PqOuxEWk9q2qqbtpRSYcKjSIdhbhTajw/G8laN6MukB1nanCEIB1XKDOfQzZKpETNgUPLC1ZNtE2NBAMUHv0W1X5jNollXEylT5+EoZajFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbcuQFsx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UQ88MfQ0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbcuQFsx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UQ88MfQ0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20DA221119;
	Wed,  4 Dec 2024 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733335829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I0pEilZzNMorHBT6XrcsVyt4tybUWY1SpMpNu4fE6ak=;
	b=AbcuQFsx/kDN0u6QDLh4kNud4ZZfdEJ0vcKmeQVC78ZFQ4RThImJCthb0nnQ0pRkFtnSpl
	MODLDAhUodyaNMA+7yZQn4rKFW2TV0ErGChNnJ9f1zvx7XAGh41A5ocyWtw2G9V2rkUCxG
	8L5ons8myTUm9fQ8kCR/xjoeI/fZlbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733335829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I0pEilZzNMorHBT6XrcsVyt4tybUWY1SpMpNu4fE6ak=;
	b=UQ88MfQ0D3o69p7Bvl5Z/Abcn3SIPrOLjH1QU3/13hkNlW1gWKFOsKhf0BjWHP9IWkJfMR
	wYqEHN5UqxO3jQDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AbcuQFsx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UQ88MfQ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733335829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I0pEilZzNMorHBT6XrcsVyt4tybUWY1SpMpNu4fE6ak=;
	b=AbcuQFsx/kDN0u6QDLh4kNud4ZZfdEJ0vcKmeQVC78ZFQ4RThImJCthb0nnQ0pRkFtnSpl
	MODLDAhUodyaNMA+7yZQn4rKFW2TV0ErGChNnJ9f1zvx7XAGh41A5ocyWtw2G9V2rkUCxG
	8L5ons8myTUm9fQ8kCR/xjoeI/fZlbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733335829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I0pEilZzNMorHBT6XrcsVyt4tybUWY1SpMpNu4fE6ak=;
	b=UQ88MfQ0D3o69p7Bvl5Z/Abcn3SIPrOLjH1QU3/13hkNlW1gWKFOsKhf0BjWHP9IWkJfMR
	wYqEHN5UqxO3jQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12EFE139C2;
	Wed,  4 Dec 2024 18:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mbM/BBWbUGcdJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 18:10:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 96A58A08F2; Wed,  4 Dec 2024 19:10:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] readahead: Reintroduce fix for improper RA window sizing
Date: Wed,  4 Dec 2024 19:10:14 +0100
Message-Id: <20241204181016.15273-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; i=jack@suse.cz; h=from:subject; bh=qsnbtMcDW53WttW8Db8GDkWi6xWRN01H+NvvxSvIAc8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnUJrxh2WR4y5zp2dErfiVofTkRukMMdLyJLw+giQf JCfXffWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ1Ca8QAKCRCcnaoHP2RA2bIEB/ 9cEV1Qh1CCAv5Jr8n1aWt6bYv4755A+Rkxo2GNYA1P4lpLocFZ0aNlp0LYMODOTzU13QpIBXU/ch++ 0EY2Ex+NBxHJlDzHLY327/lGa8yrhDqxyqrOxiNaT9eY/595mb9tZSeSjmoVd/JvueBxRQGLbyBc3j 1Wm4sHIW4wBVKBbLQx/Xel/GU2hgW3yTUugXiGQCK51Je0mF0VFmHZa3LZBomC8+seutGtclRpgaO7 lZQIdCOQTX35hbwY5yeSRB9RkIXF6cVzrqEUHk7eZ64ZsQIEXeXD+leNUZUiH06gNy/rXkAmtj8TGY WP2cdGbhWleGMnxctswM9/ciNJpF6y
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20DA221119
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Hello,

this small patch series reintroduces a fix of readahead window confusion (and
thus read throughput reduction) when page_cache_ra_order() ends up failing due
to folios already present in the page cache. After thinking about this for
a while I have ended up with a dumb fix that just rechecks if we have something
to read before calling do_page_cache_ra(). This fixes the problem reported in
[1]. I still think it doesn't make much sense to update readahead window size
in read_pages() so patch 1 removes that but the real fix in patch 2 does not
depend on it.

Patches are based on top of my revert that's in MM tree as of today but I
expect it lands in Linus' tree very soon.

								Honza

[1] https://lore.kernel.org/all/49648605-d800-4859-be49-624bbe60519d@gmail.com

