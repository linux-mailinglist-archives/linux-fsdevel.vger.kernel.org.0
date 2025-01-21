Return-Path: <linux-fsdevel+bounces-39782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE2A1804D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A221884286
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BB1F2C5C;
	Tue, 21 Jan 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GZ+ReVa0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0UVnQIzx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GZ+ReVa0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0UVnQIzx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4449641
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470839; cv=none; b=iW+CEATh4LygRAskPDuWO9dt2dGEU9Ta7j9CXSu07cyJ739IEgOWyP27uxcvmLGpoG+ToYQdVnA2FrhjTtdRBi7JtJql7mq8PnmOyyk/uFfY1sKw+85jlHJM54k99IbSxRXMWq3MqwWV2V+jjVGk5oYXHMD336g1h7vSaq92YKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470839; c=relaxed/simple;
	bh=Ac+K8+eET9BWCxoOM/N4BGa8OAgeRQafjc3y+DXF7AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hW6hAld1OOYp1R3OsTzLZoQt+FVU7o8YASWfDHif09xS3/s2C5srXRxCL99cIVrzILNWyeftzceFr48YSakJHyy60q6qXTVnrVI6IAEjUCUJEzyVeyg+Zc9nkq/rGxXvEBxMHsULMfqw7i5A7jC4hpgzlA9f8rbYk1Ouo/zdxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GZ+ReVa0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0UVnQIzx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GZ+ReVa0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0UVnQIzx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A4CF2116E;
	Tue, 21 Jan 2025 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737470836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VkWdCJ+1t1xhK4t5HZ1pTDGs286tK4owzNAnacCUjIs=;
	b=GZ+ReVa0kmlrr+iLuhLUkZKQszZW7O99jkA2y8JlPeyDlgbajisX41jsWY3Sa8dg1hMIFj
	6YGOvK18m+VYJf1WN7BboEZBr2MwElSURKlbBkbaLrTPrdAXiW0F3svlmYfgizJgUqPxY1
	wUlTYmlVWv8SN/LKvNwLc91iUyFjWqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737470836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VkWdCJ+1t1xhK4t5HZ1pTDGs286tK4owzNAnacCUjIs=;
	b=0UVnQIzxtlD39Ukh42hwgxQk4vHPUOb6Jgvc/MRp4rh4sZD+Lg7D/XgcYSb69su8/X11Ns
	ozMWCnIen8geC3CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737470836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VkWdCJ+1t1xhK4t5HZ1pTDGs286tK4owzNAnacCUjIs=;
	b=GZ+ReVa0kmlrr+iLuhLUkZKQszZW7O99jkA2y8JlPeyDlgbajisX41jsWY3Sa8dg1hMIFj
	6YGOvK18m+VYJf1WN7BboEZBr2MwElSURKlbBkbaLrTPrdAXiW0F3svlmYfgizJgUqPxY1
	wUlTYmlVWv8SN/LKvNwLc91iUyFjWqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737470836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=VkWdCJ+1t1xhK4t5HZ1pTDGs286tK4owzNAnacCUjIs=;
	b=0UVnQIzxtlD39Ukh42hwgxQk4vHPUOb6Jgvc/MRp4rh4sZD+Lg7D/XgcYSb69su8/X11Ns
	ozMWCnIen8geC3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1E9D1387C;
	Tue, 21 Jan 2025 14:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EywKO3Ozj2fsFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 14:47:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2452A0889; Tue, 21 Jan 2025 15:47:15 +0100 (CET)
Date: Tue, 21 Jan 2025 15:47:15 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Zisofs folio conversion
Message-ID: <ziwnrbaobmlyyxm4gauvzli5sfi26ivl5lj5fs4p776gnvlrup@2dsnusdprdtc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.14-rc1

to get partial conversion of isofs to folios.

Top of the tree is 5c44aa21f086. The full shortlog is:

Matthew Wilcox (Oracle) (1):
      isofs: Partially convert zisofs_read_folio to use a folio

The diffstat is

 fs/isofs/compress.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

