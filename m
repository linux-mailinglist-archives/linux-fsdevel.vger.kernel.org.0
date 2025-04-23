Return-Path: <linux-fsdevel+bounces-47120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F381A99610
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF746544F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4B628A3EF;
	Wed, 23 Apr 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CO06bkUk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGH2myP6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CO06bkUk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGH2myP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93981DDAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428172; cv=none; b=JYGJ+ZrYo/Yes0MbTOpudg91WY5LC2KMpuOMPkORS+ZCuwp6sZPSlQ4a9dBmkNcFe8okArdkZnaCjMXbircjQWt0JY83djjBZ6VMo2OO96L/YoqVgNrkhwdWknT3B2aUmQDFgU58nkOyX1n2K4IHydtDv7Cv2NS4KFrlquKS6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428172; c=relaxed/simple;
	bh=5m1PZHd0dsdAhcA38VPsPYltHVZPTrSClAHxkMd6OA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awK9f5FOknVAk1rAXB9svgQvLm0t5mkwINcygklfuDTu+Fvq5FDHGFaU4kKkiFFkI7QqWHqOaetwNzrhP3ie4TqnPsmo9qwe0QYdC0iLBt0yrGlLz/6rWeRYKfRpZUy9C/ol+FEdYVE7aig8m3S1ixIznDlpDi9MNN4WH5TkpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CO06bkUk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGH2myP6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CO06bkUk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGH2myP6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C5881F449;
	Wed, 23 Apr 2025 17:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745428168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UokPV57Q89xRAxxA7GjXgjX2aUYQnotNsdxc/ZHHrKE=;
	b=CO06bkUkXHVAbGl8DvWmpRJkYgUd7fNvWa2jMCogBG7bw17GinK+YCJAdm+zcohqOJRqFF
	EE6mxXHk0sEfQf6PTpgoPjaKdupiTyXBnEX0vYGv/r4+OvyMjEJIEyAO0RTfkeZpALem3p
	Ii6S5iq8BZI0VJkQQw/ojYXhSJ0akwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745428168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UokPV57Q89xRAxxA7GjXgjX2aUYQnotNsdxc/ZHHrKE=;
	b=aGH2myP62Ln+0PYOVqR721kCl5prNt9Qm9wBuNSj9dINbOA9W702N6sHejb6kwHWXLXb42
	nghq/W56hrSci+CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CO06bkUk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aGH2myP6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745428168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UokPV57Q89xRAxxA7GjXgjX2aUYQnotNsdxc/ZHHrKE=;
	b=CO06bkUkXHVAbGl8DvWmpRJkYgUd7fNvWa2jMCogBG7bw17GinK+YCJAdm+zcohqOJRqFF
	EE6mxXHk0sEfQf6PTpgoPjaKdupiTyXBnEX0vYGv/r4+OvyMjEJIEyAO0RTfkeZpALem3p
	Ii6S5iq8BZI0VJkQQw/ojYXhSJ0akwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745428168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UokPV57Q89xRAxxA7GjXgjX2aUYQnotNsdxc/ZHHrKE=;
	b=aGH2myP62Ln+0PYOVqR721kCl5prNt9Qm9wBuNSj9dINbOA9W702N6sHejb6kwHWXLXb42
	nghq/W56hrSci+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BBE513A3D;
	Wed, 23 Apr 2025 17:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qPrxHcgeCWgXHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Apr 2025 17:09:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0F268A0949; Wed, 23 Apr 2025 19:09:28 +0200 (CEST)
Date: Wed, 23 Apr 2025 19:09:28 +0200
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
Message-ID: <jwciumjkfwwjeoklsi6ubcspcjswkz5s5gtttzpjqft6dtb7sp@c4ae6y5pix5w>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_6Gwl6nowYnsO3w@bombadil.infradead.org>
 <mxmnbr6gni2lupljf7pzkhs6f3hynr2lq2nshbgcmzg77jduwk@wn76alaoxjts>
 <Z__hthNd2nj9QjrM@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4v4cuvrwajlncncp"
Content-Disposition: inline
In-Reply-To: <Z__hthNd2nj9QjrM@bombadil.infradead.org>
X-Rspamd-Queue-Id: 8C5881F449
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,stgolabs.net,kernel.org,mit.edu,dilger.ca,vger.kernel.org,surriel.com,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com,syzkaller.appspotmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO


--4v4cuvrwajlncncp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 16-04-25 09:58:30, Luis Chamberlain wrote:
> On Tue, Apr 15, 2025 at 06:28:55PM +0200, Jan Kara wrote:
> > > So I tried:
> > > 
> > > root@e1-ext4-2k /var/lib/xfstests # fsck /dev/loop5 -y 2>&1 > log
> > > e2fsck 1.47.2 (1-Jan-2025)
> > > root@e1-ext4-2k /var/lib/xfstests # wc -l log
> > > 16411 log
> > 
> > Can you share the log please?
> 
> Sure, here you go:
> 
> https://github.com/linux-kdevops/20250416-ext4-jbd2-bh-migrate-corruption
> 
> The last trace-0004.txt is a fresh one with Davidlohr's patches
> applied. It has trace-0004-fsck.txt.

Thanks for the data! I was staring at them for some time and at this point
I'm leaning towards a conclusion that this is actually not a case of
metadata corruption but rather a bug in ext4 transaction credit computation
that is completely independent of page migration.

Based on the e2fsck log you've provided the only damage in the filesystem
is from the aborted transaction handle in the middle of extent tree growth.
So nothing points to a lost metadata write or anything like that. And the
credit reservation for page writeback is indeed somewhat racy - we reserve
number of transaction credits based on current tree depth. However by the
time we get to ext4_ext_map_blocks() another process could have modified
the extent tree so we may need to modify more blocks than we originally
expected and reserved credits for.

Can you give attached patch a try please?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--4v4cuvrwajlncncp
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-Fix-calculation-of-credits-for-extent-tree-modi.patch"

From 4c53fb9f4b9b3eb4a579f69b7adcb6524d55629c Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 23 Apr 2025 18:10:54 +0200
Subject: [PATCH] ext4: Fix calculation of credits for extent tree modification

Luis and David are reporting that after running generic/750 test for 90+
hours on 2k ext4 filesystem, they are able to trigger a warning in
jbd2_journal_dirty_metadata() complaining that there are not enough
credits in the running transaction started in ext4_do_writepages().

Indeed the code in ext4_do_writepages() is racy and the extent tree can
change between the time we compute credits necessary for extent tree
computation and the time we actually modify the extent tree. Thus it may
happen that the number of credits actually needed is higher. Modify
ext4_ext_index_trans_blocks() to count with the worst case of maximum
tree depth.

Link: https://lore.kernel.org/all/20250415013641.f2ppw6wov4kn4wq2@offworld
Reported-by: Davidlohr Bueso <dave@stgolabs.net>
Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36..43286632e650 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2396,18 +2396,19 @@ int ext4_ext_calc_credits_for_single_extent(struct inode *inode, int nrblocks,
 int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
 {
 	int index;
-	int depth;
 
 	/* If we are converting the inline data, only one is needed here. */
 	if (ext4_has_inline_data(inode))
 		return 1;
 
-	depth = ext_depth(inode);
-
+	/*
+	 * Extent tree can change between the time we estimate credits and
+	 * the time we actually modify the tree. Assume the worst case.
+	 */
 	if (extents <= 1)
-		index = depth * 2;
+		index = EXT4_MAX_EXTENT_DEPTH * 2;
 	else
-		index = depth * 3;
+		index = EXT4_MAX_EXTENT_DEPTH * 3;
 
 	return index;
 }
-- 
2.43.0


--4v4cuvrwajlncncp--

