Return-Path: <linux-fsdevel+bounces-64659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED92BF0207
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160003BEA39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7818C26;
	Mon, 20 Oct 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f3Oi8Dc5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tr0BvbnB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zUBeF+yB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7q9sk7dh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF12F5313
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951830; cv=none; b=OSJ2oJR679UIAP5C9Ge+9EUCLatLbZYOtOYRoGWRoeaCYkNkiHtDduLhYOHK6qhKz6aWJABsfpTBQAxmac8iKnDTx4IR0E9uql/z4ABevTYsyJzgpBf5xjFesYk1D7AnZj7zrdumEyKtB8oiHhEsJSR5ehsG+Nn6ILyKY4T81WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951830; c=relaxed/simple;
	bh=7qfYja8kmciatM0466E6Qs5KrG9YxVb7sUJlwvKFbis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oi7VTfPsXLW8Inpg2oG6S3N6UEcXDf7XNRuCU06ZIJbD1xrjCKf17E3Ma9vruweKSpfoxnLkXOGWbDjKVPn6MHo8kqEK6xBQlM0IIs61pJj4K8lFzTWWtPDAEEwizoEVNXQbP44uiYuNvlfz+97GkcGIUKzfN1bI0Da5klBbgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f3Oi8Dc5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tr0BvbnB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zUBeF+yB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7q9sk7dh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9807B211E7;
	Mon, 20 Oct 2025 09:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760951817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=S6oD/plOYALAy17UBsqaE7AXeM6gWkJEws35/FgSuP4=;
	b=f3Oi8Dc5JWFpw69TijDxkVIr144AI/5muBrH5f195I5nbOvT1GX/Ucy1pg9eAtbiqZPr1Z
	ybIpOD6kxhrUR6hZ9CQdKYENbqLpwp2chJ6PDnsjfotZq9ob55qs7UbDIJXUYRzLmr5uVa
	lHtVCslBW4neZPPpP4C4SMEmbhd0Qa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760951817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=S6oD/plOYALAy17UBsqaE7AXeM6gWkJEws35/FgSuP4=;
	b=Tr0BvbnBAv0nvHcPvTlccq8zpdbY8l60AlCtaH1lRtPK6PYOfVy4dIiGid14iMia/XiSIB
	A7ABQNXkZiyqlUBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760951813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=S6oD/plOYALAy17UBsqaE7AXeM6gWkJEws35/FgSuP4=;
	b=zUBeF+yBdcZoPu2vygFb5hNYXPXk12CyWZQm/nbZ8N/pGroYq63FiHGLUl7jZaYrPjcTj6
	fplqVRtg/llWChep2R5RCp2aZeFHbrChLQkzcorRzpTWjEnHU6GRIAnOLwR7VGpu46q+Jz
	oBFelSRBdajWLLx+uzEoETa+Ruy7Jbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760951813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=S6oD/plOYALAy17UBsqaE7AXeM6gWkJEws35/FgSuP4=;
	b=7q9sk7dhAxim8k4/6RDSw8s8X7KxgeNhCrC1E8xYqH7IK74kfzRqVXnp3p3d/1wvoHxrX4
	mAcm+i//1LACkSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DCD613AAC;
	Mon, 20 Oct 2025 09:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K6GbIgX+9WjEeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:16:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41CD3A0856; Mon, 20 Oct 2025 11:16:53 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:16:53 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify fixes for 6.18-rc3
Message-ID: <uxjyfajfg7zfe43r7lryobk4c7jfevqmlwobbqavmbs5mwyph5@pbftyugt3k6m>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.18-rc3

to get two fixes for fsnotify subsystem:
  * kind of a stop-gap solution for a race between unmount of a filesystem
    with fsnotify marks and someone inspecting fdinfo of fsnotify group
    with those marks in procfs. Proper solution is in the works but it will
    get a while to settle.
  * a fix for non-decodable file handles (used by unprivileged apps using
    fanotify).

Top of the tree is a7c4bb43bfdc. The full shortlog is:

Jakub Acs (1):
      fs/notify: call exportfs_encode_fid with s_umount

Jan Kara (1):
      expfs: Fix exportfs_can_encode_fh() for EXPORT_FH_FID

The diffstat is

 fs/notify/fdinfo.c       | 6 ++++++
 include/linux/exportfs.h | 7 ++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

