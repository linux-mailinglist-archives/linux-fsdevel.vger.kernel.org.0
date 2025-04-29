Return-Path: <linux-fsdevel+bounces-47568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96A5AA075E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D8016EE98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9EB2BE0EC;
	Tue, 29 Apr 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BS8TXisa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qork3uvg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvu3U+V7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vL0J2oIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3A2BD5A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745919175; cv=none; b=iqhYYi2KUP2ux4nPbNaRmwU2UZJI/+2St4MnhroXW5g6vsq9TjyCh3woeLt0CIYMJeHFF6lynCkYxIGeRwgfBPAlTY6CFIGqyV9gAMKEauZ+0GvGkPTyfFzJfIGFm0tiKAw9AiG84W+fbb2mFDJgHr7EhLjcKCZwqizWTtcT8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745919175; c=relaxed/simple;
	bh=6fSEk0nLasi2XFVqdsw5B9ozTlL2MMdrAJ1hOnwswUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBGBV5oLbZjhSMwGvhdcxrlL4BT5EB/rUjpb47P3V7FgEAc8MJkNAlhBGpvTqxfWSdXbXTwHjXAKz98ZL0ldooiydz3GF9oJpc4NZhV/3QHCXmQgUbO1CCJgVxnVHD0nFvdx0Tgg8LRKrs2D58uP5d30h34RAFo77tu81VoXtAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BS8TXisa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qork3uvg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvu3U+V7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vL0J2oIh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E919B1F7A5;
	Tue, 29 Apr 2025 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745919170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axQ6VDg/2Q3mj72ydC4+gODgLwSF9HxyukFyq6pOaPA=;
	b=BS8TXisaeb9OFwqumRCpQEgoHRlSuPMpoZZByPZfoZNJ3XjhwLVTHDmRkiHquEEV9GhkiK
	xkuzfxO77dcbsYYHXupLqsN3qlJAHDW6GYdrMl3PIP33rdRmIzl/NZKVctk4g0R5OthTK/
	3iJFuun1byFkHhGnQm7xFXrNEgYBhxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745919170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axQ6VDg/2Q3mj72ydC4+gODgLwSF9HxyukFyq6pOaPA=;
	b=qork3uvg4Ll56BM/EIU7uCygstkmZqKY0UYoyMsFetKzIH+2riMJRQOvBkXSTNU+pxUEoh
	886R+FXIXCvTpvDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745919169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axQ6VDg/2Q3mj72ydC4+gODgLwSF9HxyukFyq6pOaPA=;
	b=xvu3U+V7t7tcS3Xma8xdhnk9Jf5U+Q67C+8Ui7JknY9WC/gkYr9cjczOeMd0GAdEpoacIR
	fpgyv6GAA0giuhG5WlXaNTQLqeqNZAB17ZVzF1oJPJy3sQfY8fj1TPMR2NmsDPB9kwfWbh
	2dkPwsn6BPHVzJYMn4O1Sbrco8yjXCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745919169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axQ6VDg/2Q3mj72ydC4+gODgLwSF9HxyukFyq6pOaPA=;
	b=vL0J2oIh7+CY/g4Y1cpG4MzrRLxLs3tqR5I8zIxDl/T0g17n4eoLfLYrpbMGGXV0ZJ8fH/
	Lb5ysxHWfXo4WKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8AA21340C;
	Tue, 29 Apr 2025 09:32:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bErgNMGcEGisGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Apr 2025 09:32:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D67DA0952; Tue, 29 Apr 2025 11:32:41 +0200 (CEST)
Date: Tue, 29 Apr 2025 11:32:41 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jan Kara <jack@suse.cz>, dave@stgolabs.net, brauner@kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, 
	david@redhat.com, axboe@kernel.dk, hare@suse.de, david@fromorbit.com, 
	djwong@kernel.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, 
	da.gomez@samsung.com, syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <s7w2zocbvucjmgrio2pzfqnur2jr6ra7vxm7zklqk4v2igc23q@k7nelbt7moim>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
 <mxmnbr6gni2lupljf7pzkhs6f3hynr2lq2nshbgcmzg77jduwk@wn76alaoxjts>
 <Z__hthNd2nj9QjrM@bombadil.infradead.org>
 <jwciumjkfwwjeoklsi6ubcspcjswkz5s5gtttzpjqft6dtb7sp@c4ae6y5pix5w>
 <aAlN4-pMHoc-PZ1G@bombadil.infradead.org>
 <aAwSCSG1c-t8ATr3@bombadil.infradead.org>
 <aBAKhPBAdGVrII2Y@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBAKhPBAdGVrII2Y@bombadil.infradead.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,stgolabs.net,kernel.org,mit.edu,dilger.ca,vger.kernel.org,surriel.com,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 28-04-25 16:08:52, Luis Chamberlain wrote:
> On Fri, Apr 25, 2025 at 03:51:55PM -0700, Luis Chamberlain wrote:
> > On Wed, Apr 23, 2025 at 01:30:29PM -0700, Luis Chamberlain wrote:
> > > On Wed, Apr 23, 2025 at 07:09:28PM +0200, Jan Kara wrote:
> > > > On Wed 16-04-25 09:58:30, Luis Chamberlain wrote:
> > > > > On Tue, Apr 15, 2025 at 06:28:55PM +0200, Jan Kara wrote:
> > > > > > > So I tried:
> > > > > > > 
> > > > > > > root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5 -y 2>&1 > log
> > > > > > > e2fsck 1.47.2 (1-Jan-2025)
> > > > > > > root@e1-ext4-2k /var/lib/xfstests # wc -l log
> > > > > > > 16411 log
> > > > > > 
> > > > > > Can you share the log please?
> > > > > 
> > > > > Sure, here you go:
> > > > > 
> > > > > https://github.com/linux-kdevops/20250416-ext4-jbd2-bh-migrate-corruption
> > > > > 
> > > > > The last trace-0004.txt is a fresh one with Davidlohr's patches
> > > > > applied. It has trace-0004-fsck.txt.
> > > > 
> > > > Thanks for the data! I was staring at them for some time and at this point
> > > > I'm leaning towards a conclusion that this is actually not a case of
> > > > metadata corruption but rather a bug in ext4 transaction credit computation
> > > > that is completely independent of page migration.
> > > > 
> > > > Based on the e2fsck log you've provided the only damage in the filesystem
> > > > is from the aborted transaction handle in the middle of extent tree growth.
> > > > So nothing points to a lost metadata write or anything like that. And the
> > > > credit reservation for page writeback is indeed somewhat racy - we reserve
> > > > number of transaction credits based on current tree depth. However by the
> > > > time we get to ext4_ext_map_blocks() another process could have modified
> > > > the extent tree so we may need to modify more blocks than we originally
> > > > expected and reserved credits for.
> > > > 
> > > > Can you give attached patch a try please?
> > > > 
> > > > 								Honza
> > > > -- 
> > > > Jan Kara <jack@suse.com>
> > > > SUSE Labs, CR
> > > 
> > > > From 4c53fb9f4b9b3eb4a579f69b7adcb6524d55629c Mon Sep 17 00:00:00 2001
> > > > From: Jan Kara <jack@suse.cz>
> > > > Date: Wed, 23 Apr 2025 18:10:54 +0200
> > > > Subject: [PATCH] ext4: Fix calculation of credits for extent tree modification
> > > > 
> > > > Luis and David are reporting that after running generic/750 test for 90+
> > > > hours on 2k ext4 filesystem, they are able to trigger a warning in
> > > > jbd2_journal_dirty_metadata() complaining that there are not enough
> > > > credits in the running transaction started in ext4_do_writepages().
> > > > 
> > > > Indeed the code in ext4_do_writepages() is racy and the extent tree can
> > > > change between the time we compute credits necessary for extent tree
> > > > computation and the time we actually modify the extent tree. Thus it may
> > > > happen that the number of credits actually needed is higher. Modify
> > > > ext4_ext_index_trans_blocks() to count with the worst case of maximum
> > > > tree depth.
> > > > 
> > > > Link: https://lore.kernel.org/all/20250415013641.f2ppw6wov4kn4wq2@offworld
> > > > Reported-by: Davidlohr Bueso <dave@stgolabs.net>
> > > > Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > 
> > > I kicked off tests! Let's see after ~ 90 hours!
> > 
> > Tested-by: kdevops@lists.linux.dev
> > 
> > I have run the test over 3 separate guests and each one has tested this
> > over 48 hours each. There is no ext4 fs corruption reported, all is
> > good, so I do believe thix fixes the issue. One of the guests was on
> > Linus't tree which didn't yet have Davidlorh's fixes for folio migration.
> > And so I believe this patch should have a stable tag fix so stable gets it.
> 
> Jan, my testing has passed 120 hours now on multiple guests. This is
> certainly a fixed bug with your patch.

Thanks for testing! I'll do an official submission of the fix.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

