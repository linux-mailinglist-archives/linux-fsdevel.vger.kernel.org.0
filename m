Return-Path: <linux-fsdevel+bounces-71677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF07CCCB20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 17:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F057301738A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1136C5AD;
	Thu, 18 Dec 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MS7gOg/f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DJ8Sep7X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MS7gOg/f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DJ8Sep7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5E2D8393
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074703; cv=none; b=tVIzk3o/KYwgfvTCMquY+IvEjNlEFIfzxFINWCFKvpoAqvh19WTKRiLcYUXIFbX0Vad8Q5I37B5xFGMq6DS5/UH/CHvhdOzMVoOqCghHcR/yaJ7rZCsMCJlzDKEmRHGwBqYZF1o8/ku6IHx6o5KtcsuMY/1KI0a2mrVgqcVb068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074703; c=relaxed/simple;
	bh=jbIEAI5MqjsnTTwFJ1orRJGZLBGCTKce0KlIf8l+BSk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i5mTbAIzEPVio2Wo0+iuAOrkBvMyVdptbRq2y3LuGtwG+vhq27RJMHSN5BpopFSrHdJLrcT+m/sHEiqJhR15aPnqg4trSBUw4vUuLPW+Ce036qcUGI4A8UqpHhxQndO1NsLmzlqBvVeFmbrjyeWNS32fSuLpi6Tle+CHYLoMS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MS7gOg/f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DJ8Sep7X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MS7gOg/f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DJ8Sep7X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72B7A5BCEA;
	Thu, 18 Dec 2025 16:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766074700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=baOM8EKBvLL9fCbXYmb52OowM0fn3984p0jGSFCLQZQ=;
	b=MS7gOg/fvOhON7FctmhLqMHNv+nMMxWj6vK4slYUScMepHpkeNpDduA9HnYvhapS3D5JL4
	Vm7r3+ATigLixjTRoysu8HeQl1yn28xqYrH/pLllpv3NCYmLp67ybLyDAqNXpxezACAnhv
	rlJM3KE3M4TFBtbgLFO8gZ/vwQpDhuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766074700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=baOM8EKBvLL9fCbXYmb52OowM0fn3984p0jGSFCLQZQ=;
	b=DJ8Sep7XE+SUC1HBoROVPZsvI+fKBrSwbLExE25wR6roVMSrgN+WqzOKBRm5uCeDNjTE7i
	qnhy6RCTlQd1IgDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766074700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=baOM8EKBvLL9fCbXYmb52OowM0fn3984p0jGSFCLQZQ=;
	b=MS7gOg/fvOhON7FctmhLqMHNv+nMMxWj6vK4slYUScMepHpkeNpDduA9HnYvhapS3D5JL4
	Vm7r3+ATigLixjTRoysu8HeQl1yn28xqYrH/pLllpv3NCYmLp67ybLyDAqNXpxezACAnhv
	rlJM3KE3M4TFBtbgLFO8gZ/vwQpDhuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766074700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=baOM8EKBvLL9fCbXYmb52OowM0fn3984p0jGSFCLQZQ=;
	b=DJ8Sep7XE+SUC1HBoROVPZsvI+fKBrSwbLExE25wR6roVMSrgN+WqzOKBRm5uCeDNjTE7i
	qnhy6RCTlQd1IgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 699F23EA63;
	Thu, 18 Dec 2025 16:18:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pzXEGUwpRGldKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Dec 2025 16:18:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23196A0918; Thu, 18 Dec 2025 17:18:20 +0100 (CET)
Date: Thu, 18 Dec 2025 17:18:20 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify fixes for 6.19-rc2
Message-ID: <27rvclbkoz52xjo4m5zmigtcoke4nbr3lfvfnnqr6pemxulsac@a3lngmry2dy4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.79
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.970];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.19-rc2

to get two fsnotify fixes. The fix from Ahelenia makes sure we generate
event when modifying inode flags, the fix from Amir disables sending of
events from device inodes to their parent directory as it could concievably
create a usable side channel attack in case of some devices and so far we
aren't aware of anybody depending on the functionality.

Top of the tree is 6f7c877cc397. The full shortlog is:

Ahelenia Ziemiańska (1):
      fs: send fsnotify_xattr()/IN_ATTRIB from vfs_fileattr_set()/chattr(1)

Amir Goldstein (1):
      fsnotify: do not generate ACCESS/MODIFY events on child for special files

The diffstat is

 fs/file_attr.c       | 2 ++
 fs/notify/fsnotify.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

