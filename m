Return-Path: <linux-fsdevel+bounces-7549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A705B827051
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04822B21E92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0945BF0;
	Mon,  8 Jan 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gPBmFgUg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3uhXRIdF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gPBmFgUg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3uhXRIdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FC45944
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 070902200B;
	Mon,  8 Jan 2024 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704721801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=bKGJbYxTQAzw5OJcxXnzfzCdUMDO6DqVNrm7WEkMHwY=;
	b=gPBmFgUgl5BLoaXk42lGdm5ImbgXOap80iSZKNzKu8Fb/iV3Y45qP3EBeEja99Ttha87ii
	MAHOQRtAyWQTysYvWFsCdPLl9iy1ldiWpGSCp2hrzSMIf8LoxQGZoqXIPCaCGlig8+KwEf
	b+Ak0rhamAwCLdM00IQ2SuPJtnKFgxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704721801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=bKGJbYxTQAzw5OJcxXnzfzCdUMDO6DqVNrm7WEkMHwY=;
	b=3uhXRIdFdJrbQioWswJ3Sm6+B62qfdI+VdcbEZEqN9rZgFwOyvNXNmfCIuKuPXfNDPY9TQ
	akanUTYqMKJ4OEDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704721801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=bKGJbYxTQAzw5OJcxXnzfzCdUMDO6DqVNrm7WEkMHwY=;
	b=gPBmFgUgl5BLoaXk42lGdm5ImbgXOap80iSZKNzKu8Fb/iV3Y45qP3EBeEja99Ttha87ii
	MAHOQRtAyWQTysYvWFsCdPLl9iy1ldiWpGSCp2hrzSMIf8LoxQGZoqXIPCaCGlig8+KwEf
	b+Ak0rhamAwCLdM00IQ2SuPJtnKFgxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704721801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=bKGJbYxTQAzw5OJcxXnzfzCdUMDO6DqVNrm7WEkMHwY=;
	b=3uhXRIdFdJrbQioWswJ3Sm6+B62qfdI+VdcbEZEqN9rZgFwOyvNXNmfCIuKuPXfNDPY9TQ
	akanUTYqMKJ4OEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F151113686;
	Mon,  8 Jan 2024 13:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ar/nOoj9m2VQBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jan 2024 13:50:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A3E9A07EB; Mon,  8 Jan 2024 14:50:00 +0100 (CET)
Date: Mon, 8 Jan 2024 14:50:00 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] quota cleanup for 6.8-rc1
Message-ID: <20240108135000.hshmcktxiqb4gsao@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.51
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.71)[98.72%]
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.8-rc1

to get a small cleanup in the quota code.

Top of the tree is d1c371035c82. The full shortlog is:

Chao Yu (1):
      quota: convert dquot_claim_space_nodirty() to return void

The diffstat is

 fs/quota/dquot.c         |  6 +++---
 include/linux/quotaops.h | 15 +++++----------
 2 files changed, 8 insertions(+), 13 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

