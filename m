Return-Path: <linux-fsdevel+bounces-29837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B9497E9E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 12:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D204F1F21E78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B11953B9;
	Mon, 23 Sep 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkJFmnQd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sUab/YFE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkJFmnQd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sUab/YFE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60C1974F4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087181; cv=none; b=UdD4o8ZQHapFQWe3KH1jyD+gaRx26/9eH/hVCs+aWqrUlG/Zx+AzLr6jK4XC6Jg7Q3v4ZBR+RbXoP1jewaadXZKooJpvsPLD+Sr8ms6+8KFANtWrDn7AF4+J7yky7PwJJ3BkHs/zyqP2ynzUAeibPKHZ5FC5gHSkZyK01o3auAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087181; c=relaxed/simple;
	bh=LdfH4kJYTkJLwveQ2c/U02OMdvtStY/RwoGVgsQLUGo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gnRkIDQG+5LtsUFffPaxXxePDyPKsBU2I0nlaSVZtpVcZio9ktvMEFcHxaK5sz0cCROiGhvEnGzTO2TeH3c1oflx0/xpHN1V6djzHTzjp7IpylcLbuBOKF0Zi1cxqOCO6CWmN4vNGyAvjLkaLH+IqIznw3+eP2+bIPoFMvxSwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkJFmnQd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sUab/YFE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkJFmnQd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sUab/YFE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0C3421F70;
	Mon, 23 Sep 2024 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727087177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2lJ4dTzcdgJS6YK/mnIGwtnl52qaJw16HYC+FeshGTM=;
	b=EkJFmnQdwvxY2cjg5hn8SWjd5tN2gLgr0pC1nZ8JeukKjxqE8kC9jlNg8J+iDiNskUZGMD
	7vjkK4/YPBlr/Y5w17t0Yd4FrNxAB+uopioTpXMLmBOKL/IXM3qeowP34VFW8FtGE1v52X
	TulaHpxHwN4tvlRR+xOC29u90ivnD2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727087177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2lJ4dTzcdgJS6YK/mnIGwtnl52qaJw16HYC+FeshGTM=;
	b=sUab/YFE1E8EQSfyTT3GQVK0FjMlATNzJhuDsJMK4Tlzhx8cIghwLRvGjidLaAwf+TuDeh
	4MzYWvi1f52PWXCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727087177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2lJ4dTzcdgJS6YK/mnIGwtnl52qaJw16HYC+FeshGTM=;
	b=EkJFmnQdwvxY2cjg5hn8SWjd5tN2gLgr0pC1nZ8JeukKjxqE8kC9jlNg8J+iDiNskUZGMD
	7vjkK4/YPBlr/Y5w17t0Yd4FrNxAB+uopioTpXMLmBOKL/IXM3qeowP34VFW8FtGE1v52X
	TulaHpxHwN4tvlRR+xOC29u90ivnD2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727087177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=2lJ4dTzcdgJS6YK/mnIGwtnl52qaJw16HYC+FeshGTM=;
	b=sUab/YFE1E8EQSfyTT3GQVK0FjMlATNzJhuDsJMK4Tlzhx8cIghwLRvGjidLaAwf+TuDeh
	4MzYWvi1f52PWXCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 952CD13A64;
	Mon, 23 Sep 2024 10:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QedmJElC8WbkFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 10:26:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3E5D8A0844; Mon, 23 Sep 2024 12:26:17 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:26:17 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota and isofs cleanups for v6.12-rc1
Message-ID: <20240923102617.fblre3yqve5kqwu6@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.12-rc1

to get a few small cleanups in quota and isofs.

Top of the tree is 116249b12939. The full shortlog is:

Kemeng Shi (4):
      quota: avoid missing put_quota_format when DQUOT_SUSPENDED is passed
      quota: remove unneeded return value of register_quota_format
      quota: remove redundant return at end of void function
      quota: remove unnecessary error code translation in dquot_quota_enable

Thorsten Blum (1):
      isofs: Annotate struct SL_component with __counted_by()

The diffstat is

 fs/isofs/rock.h       |  2 +-
 fs/ocfs2/super.c      |  6 ++----
 fs/quota/dquot.c      | 14 +++++---------
 fs/quota/quota_v1.c   |  3 ++-
 fs/quota/quota_v2.c   |  9 +++------
 include/linux/quota.h |  2 +-
 mm/shmem.c            |  7 +------
 7 files changed, 15 insertions(+), 28 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

