Return-Path: <linux-fsdevel+bounces-46497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6280AA8A418
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7CD1680AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08197218ACA;
	Tue, 15 Apr 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tEwn20Mo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oMFX+yzr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tEwn20Mo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oMFX+yzr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA72218AD7
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734544; cv=none; b=QSoRvDMniTWJytTtaTVLMhu3di/nDfkNEKbJtQZYYPATRqgFRfA+tapwShLUxGd0lPrEbbIGVChDL5BBTqq6lEiXrMBk9wMopPLIkusNtER8O/zzG2f2CEbMtTv5NbJio0i2OKxmddVO0oUFb1Y6nTOvgVQwE21fOm+eihPqluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734544; c=relaxed/simple;
	bh=NPlsXXLZnVJPY0vfYOn/xF+pFccMWDBeqkP5asbLPeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXGzQYXAbhSLGR7QJrovuCdenfzuKYu2mRAydMd6IDFbefJlJ5egxFXdHgWCQ0Ks+B6VVZGAZNAlBaPPuRrvSQokgpwvpFfrY+3pkPqH5NeIlD0ujQluW2fq4slOK+a5uLlETMjUvPyDQ2KjFPxzTE6OC/Bkx4H410zXEB2par4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tEwn20Mo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oMFX+yzr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tEwn20Mo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oMFX+yzr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6312221163;
	Tue, 15 Apr 2025 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744734540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Qk1j3azgbPTvauj1mXFqLxWgx/cpNmmXQbhPNKelaQ=;
	b=tEwn20MoTrcAAHfvGccbc3mLlpd7TDkfeuu8qTEgxg3ROW6ErqiOgW6wYh+tQ4COBK500B
	Q+UxTiOPBeYgFgTPfUOkArNVMLK+eeLpv1QTGmuyBMU9E3Swt+a2rZmKL70Laa38zCgopd
	X7Bh5IP74F4uv5/0zlupUOk1NoXqDTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744734540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Qk1j3azgbPTvauj1mXFqLxWgx/cpNmmXQbhPNKelaQ=;
	b=oMFX+yzro7/ngnKHLhCDdjMSYrC0X6cgWZ6bdwKzuFnKiopwp/uTrcz2Cr4bSTO/uvCWc5
	Bbc7Q8/G1Tp72zDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tEwn20Mo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oMFX+yzr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744734540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Qk1j3azgbPTvauj1mXFqLxWgx/cpNmmXQbhPNKelaQ=;
	b=tEwn20MoTrcAAHfvGccbc3mLlpd7TDkfeuu8qTEgxg3ROW6ErqiOgW6wYh+tQ4COBK500B
	Q+UxTiOPBeYgFgTPfUOkArNVMLK+eeLpv1QTGmuyBMU9E3Swt+a2rZmKL70Laa38zCgopd
	X7Bh5IP74F4uv5/0zlupUOk1NoXqDTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744734540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Qk1j3azgbPTvauj1mXFqLxWgx/cpNmmXQbhPNKelaQ=;
	b=oMFX+yzro7/ngnKHLhCDdjMSYrC0X6cgWZ6bdwKzuFnKiopwp/uTrcz2Cr4bSTO/uvCWc5
	Bbc7Q8/G1Tp72zDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40A4E139A1;
	Tue, 15 Apr 2025 16:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDfCD0yJ/mdYYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 16:29:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BD0EAA0947; Tue, 15 Apr 2025 18:28:55 +0200 (CEST)
Date: Tue, 15 Apr 2025 18:28:55 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net, 
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com, 
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <mxmnbr6gni2lupljf7pzkhs6f3hynr2lq2nshbgcmzg77jduwk@wn76alaoxjts>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
X-Rspamd-Queue-Id: 6312221163
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,mit.edu,dilger.ca,vger.kernel.org,surriel.com,stgolabs.net,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com,syzkaller.appspotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 15-04-25 09:18:10, Luis Chamberlain wrote:
> On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > On Wed 09-04-25 18:49:38, Luis Chamberlain wrote:
> > > ** Reproduced on vanilla Linux with udelay(2000) **
> > > 
> > > Call trace (ENOSPC journal failure):
> > >   do_writepages()
> > >     → ext4_do_writepages()
> > >       → ext4_map_blocks()
> > >         → ext4_ext_map_blocks()
> > >           → ext4_ext_insert_extent()
> > >             → __ext4_handle_dirty_metadata()
> > >               → jbd2_journal_dirty_metadata() → ERROR -28 (ENOSPC)
> > 
> > Curious. Did you try running e2fsck after the filesystem complained like
> > this? This complains about journal handle not having enough credits for
> > needed metadata update. Either we've lost some update to the journal_head
> > structure (b_modified got accidentally cleared) or some update to extent
> > tree.
> 
> Just tried it after pkill fsstress and stopping the test:
> 
> root@e1-ext4-2k /var/lib/xfstests # umount /dev/loop5
> root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5
> fsck from util-linux 2.41
> e2fsck 1.47.2 (1-Jan-2025)
> /dev/loop5 contains a file system with errors, check forced.
> Pass 1: Checking inodes, blocks, and sizes
> Inode 26 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 129 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 592 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 1095 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 1416 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 1653 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 1929 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 1965 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 2538 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 2765 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 2831 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 2838 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 3595 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 4659 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 5268 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 6400 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 6830 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 8490 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 8555 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 8658 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 8754 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 8996 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 9168 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 9430 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 9468 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 9543 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 9632 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 9746 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 10043 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 10280 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 10623 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 10651 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 10691 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 10708 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 11389 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 11564 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 11578 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 11842 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 11900 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 12721 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 12831 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 13531 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yyyyInode 16580 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 16740 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 17123 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 17192 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 17412 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 17519 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yyInode 18730 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 18974 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 19118 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yyInode 19806 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 19942 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 20303 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 20323 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 21047 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 21919 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 22180 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 22856 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 23462 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 23587 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 23775 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 23916 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 24046 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 24161 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 25576 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 25666 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 25992 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 26404 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 26795 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 26862 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 26868 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 27627 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 27959 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 28014 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 29120 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 29308 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yyyyInode 30673 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 31127 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 31332 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 31547 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yyInode 32727 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 32888 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 33062 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yyyInode 34421 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 34508 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yyyyInode 35996 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 36258 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yyInode 36867 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 37166 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 37171 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 37548 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 37732 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> yInode 38028 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> Inode 38099 extent tree (at level 1) could be shorter.  Optimize<y>? yes
> ....

These are harmless. They are not errors, just opportunities for
optimization of the extent tree e2fsck can make.

> So I tried:
> 
> root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5 -y 2>&1 > log
> e2fsck 1.47.2 (1-Jan-2025)
> root@e1-ext4-2k /var/lib/xfstests # wc -l log
> 16411 log

Can you share the log please?

> root@e1-ext4-2k /var/lib/xfstests # tail log
> 
> Free blocks count wrong for group #609 (62, counted=63).
> Fix? yes
> 
> Free blocks count wrong (12289, counted=12293).
> Fix? yes

These could potentially indicate some interesting issues but it depends on
what the above e2fsck messages are...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

