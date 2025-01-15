Return-Path: <linux-fsdevel+bounces-39308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A7A128AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F60D7A1487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD91917E9;
	Wed, 15 Jan 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUanq15R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wu7zZod9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUanq15R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wu7zZod9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2308152E0C;
	Wed, 15 Jan 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958534; cv=none; b=ZiLqJ7p1uT7o6Nbq1TwCupJwkSlqCKGf3fKHWGosI17FfR+RIDrUxV0wiUDCJRLFKYgswn3eh18PrZS3u9N96yv/WUd9pr/QcPaatQluPqEPnG7B3nBC0YHWBexdbZPpdfn7NnGoX/lbfGJK+alP5pl6duhdgyFgx+qt+xqlSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958534; c=relaxed/simple;
	bh=FW2TdGjlKIFzgR/ZCI0HKA1aqlcFE6rs6xDJYonyOhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvK3gO9Y26AarIgmWweR+Md5P83b0Ta2iuaDmrhtqaMt/WxfdCdErcuq35t6Wzr1sxuS+sThjrHLcZVpXTvQ+kA9hxIldFGNfDMwBvRJwlGh4VJID5WQBAffhrA/CO5VnT5lFdJA37q3oqhYF6rHk7IKAVgbIp2KBs169K8pSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUanq15R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wu7zZod9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUanq15R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wu7zZod9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B45B1F37E;
	Wed, 15 Jan 2025 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736958529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwWlMeNIUac6pTlqmXEgukSP6+CjESF6OJN9nJ+Y+Fw=;
	b=nUanq15RmvueyuPCRyTT4RocOkuzhqusRXeJI5MFo87QuR6KNP5VF6RqCVmQ92q4PwlreU
	ZoqJamTTYucgo92xbAKmVA9YaYpc9DD+5K9vP/o9NlWfKWK6iUOQGS2mfSDXJ5UBUIFz3+
	Z//MSx8rvnse/dyzyFr4VjpNFnMu/4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736958529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwWlMeNIUac6pTlqmXEgukSP6+CjESF6OJN9nJ+Y+Fw=;
	b=wu7zZod9aFGPCzRB7pKVSrC2lr62pyPt1wMAfn6NRTz1D0Jz9b/otN9iagoGM3yg1v+01A
	5bprqDY/5yGXRmDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nUanq15R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wu7zZod9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736958529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwWlMeNIUac6pTlqmXEgukSP6+CjESF6OJN9nJ+Y+Fw=;
	b=nUanq15RmvueyuPCRyTT4RocOkuzhqusRXeJI5MFo87QuR6KNP5VF6RqCVmQ92q4PwlreU
	ZoqJamTTYucgo92xbAKmVA9YaYpc9DD+5K9vP/o9NlWfKWK6iUOQGS2mfSDXJ5UBUIFz3+
	Z//MSx8rvnse/dyzyFr4VjpNFnMu/4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736958529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwWlMeNIUac6pTlqmXEgukSP6+CjESF6OJN9nJ+Y+Fw=;
	b=wu7zZod9aFGPCzRB7pKVSrC2lr62pyPt1wMAfn6NRTz1D0Jz9b/otN9iagoGM3yg1v+01A
	5bprqDY/5yGXRmDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2E1139CB;
	Wed, 15 Jan 2025 16:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WSnrIkHih2e9HAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 Jan 2025 16:28:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 407B7A08E2; Wed, 15 Jan 2025 17:28:45 +0100 (CET)
Date: Wed, 15 Jan 2025 17:28:45 +0100
From: Jan Kara <jack@suse.cz>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jan Kara <jack@suse.cz>, Jim Zhao <jimzhao.ai@gmail.com>, 
	akpm@linux-foundation.org, willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
Message-ID: <pir6qmj2la57tvjkan5wbhjnji6tw27w45axseqcgfx4zzvz44@3mthcpyjomgw>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
 <a0d751f8-e50b-4fa5-a4bc-bccfc574f3bb@roeck-us.net>
 <b4m3w6wuw3h6ke7qlvimly7nok4ymjvnej2vx3lnds3vysyopr@6b5bnifyst24>
 <64a44636-16ec-4a10-aeb6-e327b7f989c2@roeck-us.net>
 <mqe2boksd5ztaz7xyabyp4sbtufxthcnrbwrjayghe4hpfbp4w@wjqsm467sjp5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mqe2boksd5ztaz7xyabyp4sbtufxthcnrbwrjayghe4hpfbp4w@wjqsm467sjp5>
X-Rspamd-Queue-Id: 9B45B1F37E
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,linux-foundation.org,infradead.org,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 15-01-25 17:07:36, Jan Kara wrote:
> On Tue 14-01-25 07:01:08, Guenter Roeck wrote:
> > On 1/14/25 05:19, Jan Kara wrote:
> > > On Mon 13-01-25 15:05:25, Guenter Roeck wrote:
> > > > On Thu, Nov 21, 2024 at 06:05:39PM +0800, Jim Zhao wrote:
> > > > > Address the feedback from "mm/page-writeback: raise wb_thresh to prevent
> > > > > write blocking with strictlimit"(39ac99852fca98ca44d52716d792dfaf24981f53).
> > > > > The wb_thresh bumping logic is scattered across wb_position_ratio,
> > > > > __wb_calc_thresh, and wb_update_dirty_ratelimit. For consistency,
> > > > > consolidate all wb_thresh bumping logic into __wb_calc_thresh.
> > > > > 
> > > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > > Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> > > > 
> > > > This patch triggers a boot failure with one of my 'sheb' boot tests.
> > > > It is seen when trying to boot from flash (mtd). The log says
> > > > 
> > > > ...
> > > > Starting network: 8139cp 0000:00:02.0 eth0: link down
> > > > udhcpc: started, v1.33.0
> > > > EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
> > > > udhcpc: sending discover
> > > > udhcpc: sending discover
> > > > udhcpc: sending discover
> > > > EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
> > > 
> > > Thanks for report! Uh, I have to say I'm very confused by this. It is clear
> > > than when ext2 detects the directory corruption (we fail checking directory
> > > inode 363 which is likely /etc/init.d/), the boot fails in interesting
> > > ways. What is unclear is how the commit can possibly cause ext2 directory
> > > corruption.  If you didn't verify reverting the commit fixes the issue, I'd
> > > be suspecting bad bisection but that obviously isn't the case :-)
> > > 
> > > Ext2 is storing directory data in the page cache so at least it uses the
> > > subsystem which the patch impacts but how writeback throttling can cause
> > > ext2 directory corruption is beyond me. BTW, do you recreate the root
> > > filesystem before each boot? How exactly?
> > 
> > I use pre-built root file systems. For sheb, they are at
> > https://github.com/groeck/linux-build-test/tree/master/rootfs/sheb
> 
> Thanks. So the problematic directory is /usr/share/udhcpc/ where we
> read apparently bogus metadata at the beginning of that directory.

Ah, the metadata isn't bogus. But the entries in the directory are
apparently byte-swapped (little vs big endian). Is the machine actually
little or big endian?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

