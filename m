Return-Path: <linux-fsdevel+bounces-30999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F8990663
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CE72823EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C99217902;
	Fri,  4 Oct 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1YK0paC3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UC3cFcNa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1YK0paC3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UC3cFcNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0A215F6C
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052828; cv=none; b=OtJ0CuSKCTu+srlZs1ifmRxndH7hv0lsA56a1ZW0pQ4fNdyxhH8YDKEr6K86TkSgUSirzXaOpElJRwararVa71RyhPI18NhxRP96mNnxTJmHxHbNZSafwWGF6pjTFLkuzKqgt02mAZWw4HnwNPs5tJDcUOySkv+xsDNcXi1803w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052828; c=relaxed/simple;
	bh=w2ktg9CrZA6u3reCZJXGvsDQ4dFWqnHAoL8EPYeyVlE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uqVDGBrLj8lGtY7IdgbnN0nPSdGVwAhekv9cB6tHdEopbfP7sAUjCjkCY3lM4jIP9l88Jj2HZjci6PVOn0zs5lpebe6vxzRjd4DM0wyQd5AdkM2o+J7+q/hyZQhhKF7RcfmoxI8TEOp+l03SCVlH+5tnbXK4D/sVvKwYHdSuImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1YK0paC3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UC3cFcNa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1YK0paC3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UC3cFcNa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1325F1F745;
	Fri,  4 Oct 2024 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728052825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=mENVZ9JpGyGlsrcrIYDfAYggDnbWJQmaB2GLbqOStwY=;
	b=1YK0paC3QnqNtOav/MuPGRfOKk74w7zVse7VemVoRFo5DqrrFhCz5ij2i65HHCC5/65FXO
	oen/0akXje/SDvM6hkV6kfd2D3ZSMJlZKq6dkvjqB1o8Wbq2MebWfbdCOiKqvpOIxNK2wF
	TTYheGjOejxw0T9BgpFQ4ZS0OqsLnjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728052825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=mENVZ9JpGyGlsrcrIYDfAYggDnbWJQmaB2GLbqOStwY=;
	b=UC3cFcNagGNItYM8oHIjl3nYOpCSYL7btxjuivttCMLOHVzxvteM1gXIk4jawnq4nPGtIc
	c5yfIW0CnkDGmzDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728052825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=mENVZ9JpGyGlsrcrIYDfAYggDnbWJQmaB2GLbqOStwY=;
	b=1YK0paC3QnqNtOav/MuPGRfOKk74w7zVse7VemVoRFo5DqrrFhCz5ij2i65HHCC5/65FXO
	oen/0akXje/SDvM6hkV6kfd2D3ZSMJlZKq6dkvjqB1o8Wbq2MebWfbdCOiKqvpOIxNK2wF
	TTYheGjOejxw0T9BgpFQ4ZS0OqsLnjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728052825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=mENVZ9JpGyGlsrcrIYDfAYggDnbWJQmaB2GLbqOStwY=;
	b=UC3cFcNagGNItYM8oHIjl3nYOpCSYL7btxjuivttCMLOHVzxvteM1gXIk4jawnq4nPGtIc
	c5yfIW0CnkDGmzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 088BF13A55;
	Fri,  4 Oct 2024 14:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zBAQAln+/2Y1bAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Oct 2024 14:40:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B97D5A0877; Fri,  4 Oct 2024 16:40:20 +0200 (CEST)
Date: Fri, 4 Oct 2024 16:40:20 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF fixes for 6.12-rc2
Message-ID: <20241004144020.wqrt2gpjk5w6ed7g@quack3>
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
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.12-rc2

to the couple of UDF error handling fixes to close some issues spotted by
syzbot.

Top of the tree is 264db9d666ad. The full shortlog is:

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Zhao Mengmeng (3):
      udf: refactor udf_current_aext() to handle error
      udf: refactor udf_next_aext() to handle error
      udf: refactor inode_bmap() to handle error

The diffstat is

 fs/udf/balloc.c    |  38 ++++++----
 fs/udf/directory.c |  23 ++++--
 fs/udf/inode.c     | 202 +++++++++++++++++++++++++++++++++++------------------
 fs/udf/partition.c |   6 +-
 fs/udf/super.c     |   3 +-
 fs/udf/truncate.c  |  43 +++++++++---
 fs/udf/udfdecl.h   |  15 ++--
 7 files changed, 224 insertions(+), 106 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

