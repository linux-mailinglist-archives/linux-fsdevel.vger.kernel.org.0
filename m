Return-Path: <linux-fsdevel+bounces-35460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD49D5048
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 17:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188731F22DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792411990AF;
	Thu, 21 Nov 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kSuvxf3m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wdlGnnSN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mn/cJpt6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yj5Ah/vh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3F13F43B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204873; cv=none; b=nWP+gxrANJ5XjdyCqvIUvtBjOQhXMbqnINtTYQinQT8bhmgR2QNh8X5r6ykVm0csfqqeTrF5BoLKhdwMreRn/aklEZfNi6zjiDnw26LsUkuLFaPtRFB6OlcQEhu1QeTJ4+XJ285kEY8XwdcpmdA4qrbuf9UZxNA02GaYWjIIn7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204873; c=relaxed/simple;
	bh=DobePUaX58pEaHmStGe55s3+Vt8u2WLtj2sujKdfFhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LsBa8A7dCdnnsd2mKPU2RAgXugMQOZ95kIQ2edHCh8rYVanXq00z8yUzKDlHEInFTeaHek7gKffAOlkxV9wx5Yn5bVT/naxx8tAbZNwBK7roMsfOoigF8mFxsY6cQbDLSzwb98cuC199bYpggyAW6sgzpPAti2pwaZ26yH82N2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kSuvxf3m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wdlGnnSN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mn/cJpt6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yj5Ah/vh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3DD31F745;
	Thu, 21 Nov 2024 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732204870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=giIcY6M9ywachVqaXX7W7GFtOZGSvGEgRsQncaggfPI=;
	b=kSuvxf3mZzNF9sCe9FOdH7nbi4ZmJEdwzMBopdGNqC2CZsFeGhrs4MsC3RI7Dg1XN5rk9q
	aC0/dsDhgGCuOD1cHJY1jEQeVZzg9c8IZq7vG3oMndmpadxJ37GGMJiIBRPPt6v7ITW+CD
	Sp+RopgC8N64KMP6Bvl6o03qZZtJ2LY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732204870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=giIcY6M9ywachVqaXX7W7GFtOZGSvGEgRsQncaggfPI=;
	b=wdlGnnSNvsqCSs0bwn/eTLEH+rGO2Y16Lj9XDm+5UfG33vgY9ZA2g7r4lr8xonqdlQFMfM
	sRJXMcHSA9+HoABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732204868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=giIcY6M9ywachVqaXX7W7GFtOZGSvGEgRsQncaggfPI=;
	b=mn/cJpt6E4W4NJ1eegtxLS/G1xpSoOGl2qzYQp3NKmESMshfmdasgzAt+gOG7nDAq486Lh
	F+beSUOyJBYAye+oZZxz5J7GuzdRnOxLp9mRhzOdWAmW+eNbi0aVxsXQr6ad3kpA1DWS5V
	UH6I5YH847j5gxkQyzjLnLaAzK5g5PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732204868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=giIcY6M9ywachVqaXX7W7GFtOZGSvGEgRsQncaggfPI=;
	b=Yj5Ah/vhOg+dXPJQa5sWvzXXdMKPzn7GinvoHw+4eIYBX7kicDh7l0aNiJt6y9l4TSDBK7
	p+Cx3OSriqPM8dCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D861B13927;
	Thu, 21 Nov 2024 16:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lufNNERZP2fzVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 16:01:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4965FA08A2; Thu, 21 Nov 2024 17:01:08 +0100 (CET)
Date: Thu, 21 Nov 2024 17:01:08 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota and isofs fixes for 6.13-rc1
Message-ID: <20241121160108.vu2g7nknhxrvqlkx@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.969];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v6.13-rc1

to get a fix of memory leak in isofs and a cleanup of includes in quota.

Top of the tree is 344044d8c9e2. The full shortlog is:

Al Viro (1):
      dquot.c: get rid of include ../internal.h

Hao Ge (1):
      isofs: avoid memory leak in iocharset

The diffstat is

 fs/isofs/inode.c | 8 ++++----
 fs/quota/dquot.c | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

