Return-Path: <linux-fsdevel+bounces-63165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDE7BB0297
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 13:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C71F77A9CF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C142D061C;
	Wed,  1 Oct 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rhm3tq8M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XTVPilmI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rhm3tq8M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XTVPilmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678782C08DF
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318158; cv=none; b=FeC4wSx9vDWz2Elp1xfyNt8eziFzYB4Sx64fWu2Pt7t/LbfHdqKkgdVDh9/VDHF6lHSrtoc4z8O6oQHAiDOyWG2Ypy5iix1nkWzGemOJqx5YO78c2MidDZw0JVErOz2bl/1RNl+qt1zcdUTgw8gPCyN84XP6zfeKmoS3Ew7jRP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318158; c=relaxed/simple;
	bh=pWl7KXG6V88StjtOBojI170UM3rqUhN88/hlIq7cLKU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LOEvYS7RkOQ8OY2CHQI8Oo5ySVndbvDWaBp4ANtCSneMGgVV+fsUD/Yzs54hyavKIj8yqorMAzUXwlacU4CLwg4bficPRgwyvAnQes4dhvWvRhJzAFfHVNETTNlVfwRUV47PparvlIsRAomfe5gMQc3PrrMxfGhowoc1JbhgzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rhm3tq8M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XTVPilmI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rhm3tq8M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XTVPilmI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63039336CE;
	Wed,  1 Oct 2025 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759318154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=GI1+bZTnUtLEeHnIEOvguOUgbcW5qnvkajwt5w1wEy8=;
	b=Rhm3tq8Mt0mD4SdjZSFOXnCkPSiE5CCBHipPyf7dtrHS0ab5Zyow1zTM5z642cA4nwywFK
	b3ZypGdDhsKDicD+Q5+gLor1ynQKxCcffIrizbZ8p5gZCwBZwYFCPMVox5ZIg9kjELOVlu
	oti9te7ThmspK5xtZK18wqbegrEIGKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759318154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=GI1+bZTnUtLEeHnIEOvguOUgbcW5qnvkajwt5w1wEy8=;
	b=XTVPilmIKmGovEqtZG1XORl0Kbc/ARBVwnhSwADtJaO4zulprKnSsdRak3zYazS4U6Dd8m
	5jki6rsy4BOIaUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759318154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=GI1+bZTnUtLEeHnIEOvguOUgbcW5qnvkajwt5w1wEy8=;
	b=Rhm3tq8Mt0mD4SdjZSFOXnCkPSiE5CCBHipPyf7dtrHS0ab5Zyow1zTM5z642cA4nwywFK
	b3ZypGdDhsKDicD+Q5+gLor1ynQKxCcffIrizbZ8p5gZCwBZwYFCPMVox5ZIg9kjELOVlu
	oti9te7ThmspK5xtZK18wqbegrEIGKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759318154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=GI1+bZTnUtLEeHnIEOvguOUgbcW5qnvkajwt5w1wEy8=;
	b=XTVPilmIKmGovEqtZG1XORl0Kbc/ARBVwnhSwADtJaO4zulprKnSsdRak3zYazS4U6Dd8m
	5jki6rsy4BOIaUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AA1D13A3F;
	Wed,  1 Oct 2025 11:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQMaFooQ3WhoagAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 11:29:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 13662A0A2D; Wed,  1 Oct 2025 13:29:14 +0200 (CEST)
Date: Wed, 1 Oct 2025 13:29:14 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] udf and quota fixes for 6.18-rc1
Message-ID: <6lzkazta75sjxv2wrxqmskzqzm36zxgbo7w7yjqqlaejbyjegn@tdxtdkkiqzks>
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
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.18-rc1

to get a fix for UDF and quota.

Top of the tree is 3bd5e45c2ce3. The full shortlog is:

Larshin Sergey (1):
      fs: udf: fix OOB read in lengthAllocDescs handling

Shashank A P (1):
      fs: quota: create dedicated workqueue for quota_release_work

The diffstat is

 fs/quota/dquot.c | 10 +++++++++-
 fs/udf/inode.c   |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

