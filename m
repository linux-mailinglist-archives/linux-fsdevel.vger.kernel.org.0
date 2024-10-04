Return-Path: <linux-fsdevel+bounces-30998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D1990638
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B0E282181
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A8A2178EF;
	Fri,  4 Oct 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FJ9IYoTa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0e9VSuAc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FJ9IYoTa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0e9VSuAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F82212EEA
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052576; cv=none; b=Rg3vZmSKiV0h9wk4ZgVZgjBp7T2QLHZGrpo0co6+WT8BULXX50xkZUT2ENyqA7uLPhb1IgNBOA0NSo2E48mCmtQhK9kND0mGI7RzqpCXQOEceu3WPgo/n3T6kjbahoZXCdwTwyhrORqGDaJjWnI79jg89q2W/pWgYdsAYhvV1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052576; c=relaxed/simple;
	bh=oK7PEso6zyYxD/gq2TPsdwnCqo1jYMMgX/IW6SFH+rg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=osL/sY6SFAMpSCE+ijAew0dhChYx75mlPumlhKmR9svDh8SOG9734kTYtOzdn4AZpMPTUiMQwzj4PXZVcxuTJ15uxSH5wQUyN6Lb3rDSVOuCtCbR31JljHXArVRPGgyTjZbHL4b47qh6s1gJPDXYlhsiB2Sa6lHOvOWbLFhceZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FJ9IYoTa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0e9VSuAc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FJ9IYoTa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0e9VSuAc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 81CE31F78E;
	Fri,  4 Oct 2024 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728052570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s+svv4+cdngV3Jdo5xQnjcY5K2e3118SIuFNMe4ACtU=;
	b=FJ9IYoTaB2Tgx2QXR/VuJLv3AhbkI+nzB1sMxVQSG8UGEAeWLoiZO/Tz1vI94R+WzbdAIW
	gHpxMOe1Wt0/M5BL3MiICZmAE9TNtVm1pADPlhrUy3yfqPA6kfxNZmXQDT3l7C+kNtDGdn
	86syv/cCM9OXCHmFqLEWmOYYbhlVHJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728052570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s+svv4+cdngV3Jdo5xQnjcY5K2e3118SIuFNMe4ACtU=;
	b=0e9VSuAcEBLUicvhw/hSOp3Gi8yG72hMC0Ukc0rSP6Xsv1M6jdVfJShy0KPf1/qrc9qGaW
	zIc9zzjbvDcd1zCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FJ9IYoTa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0e9VSuAc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728052570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s+svv4+cdngV3Jdo5xQnjcY5K2e3118SIuFNMe4ACtU=;
	b=FJ9IYoTaB2Tgx2QXR/VuJLv3AhbkI+nzB1sMxVQSG8UGEAeWLoiZO/Tz1vI94R+WzbdAIW
	gHpxMOe1Wt0/M5BL3MiICZmAE9TNtVm1pADPlhrUy3yfqPA6kfxNZmXQDT3l7C+kNtDGdn
	86syv/cCM9OXCHmFqLEWmOYYbhlVHJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728052570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=s+svv4+cdngV3Jdo5xQnjcY5K2e3118SIuFNMe4ACtU=;
	b=0e9VSuAcEBLUicvhw/hSOp3Gi8yG72hMC0Ukc0rSP6Xsv1M6jdVfJShy0KPf1/qrc9qGaW
	zIc9zzjbvDcd1zCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76E3E13A55;
	Fri,  4 Oct 2024 14:36:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tkz8HFr9/2bTagAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Oct 2024 14:36:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2BD04A0877; Fri,  4 Oct 2024 16:36:02 +0200 (CEST)
Date: Fri, 4 Oct 2024 16:36:02 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify fixes for 6.12-rc2
Message-ID: <20241004143602.jttrziwhqylh5ugo@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 81CE31F78E
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.12-rc2

to get two fixes for fsnotify.

Top of the tree is cad3f4a22cfa. The full shortlog is:

Jan Kara (1):
      fsnotify: Avoid data race between fsnotify_recalc_mask() and fsnotify_object_watched()

Lizhi Xu (1):
      inotify: Fix possible deadlock in fsnotify_destroy_mark

The diffstat is

 fs/nfsd/filecache.c                |  2 +-
 fs/notify/dnotify/dnotify.c        |  3 +--
 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/notify/fsnotify.c               | 21 ++++++++++++---------
 fs/notify/group.c                  | 11 -----------
 fs/notify/inotify/inotify_user.c   |  2 +-
 fs/notify/mark.c                   |  8 ++++++--
 include/linux/fsnotify_backend.h   | 10 +++-------
 8 files changed, 25 insertions(+), 34 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

