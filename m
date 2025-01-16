Return-Path: <linux-fsdevel+bounces-39411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5EA13CFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB9161BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B022B8B4;
	Thu, 16 Jan 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRt11gmt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kfWeNzKi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AEqtj3Mb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rguJeDJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C122ACFD;
	Thu, 16 Jan 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039423; cv=none; b=fCu49+XDaD4kOzRcDWVQiwpHPmpnIjAhG+XZxuLNik3LX8QGczPvjeQEDUOq+8T+IB6CSArpJP8Nq2Q/TfhysHH7bIYiq3RjrgmQKsuKzgCYTfrt94xdONvmKRyt5oDTLa/eSxavdnxhP1j1ZTy8+H0gJvrrG+nvFZqPtTn+BEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039423; c=relaxed/simple;
	bh=qKFx1ufCkx2EbQxyaCkh0CWIw8zwTM409ECnG5efR0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udKprhMTNf5C6V2lJh+tlw2ljXnx1/fzDqwmUUNmV0dsZjJ2FQO9+WPyZUbPY/nSNcAqVI9KZkUup0Qu4RqYFDUWzY8ms4B39YPcjEukYu5FrlD9JaXfcUBDNdvqLkGpOYDUZ8riZAB7I+3V0rEVr5GJY0zAdlyUqeRvpFQMABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRt11gmt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kfWeNzKi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AEqtj3Mb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rguJeDJf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69E3A1F7A6;
	Thu, 16 Jan 2025 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737039419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25mhKZCy+wszXZ9AZGe6SbcYXi6AGtNrxGnAfpbsCG8=;
	b=NRt11gmtfmNjMdFRVbyQkpSA5TpQWG59yroonBhnO7FQXE8JV01b0xsz87/uODR2LVJpFl
	9VH6XOTBFMC6B4Yz64A9XhPZ5kHj2usYH+Fivc2td1LVHxUhz3jBF8ABkIJRJgdHGO5Hd7
	BCrao5QJfn+JSwO37rizPqG34Bzywq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737039419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25mhKZCy+wszXZ9AZGe6SbcYXi6AGtNrxGnAfpbsCG8=;
	b=kfWeNzKi+fgEopXZGjI8p4qC5lt2qxDZxR0v+qWlMWj5a0R32zZfnIgR5S9+Z4cq0wAtnV
	o5lKlhzYsumLoGAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737039418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25mhKZCy+wszXZ9AZGe6SbcYXi6AGtNrxGnAfpbsCG8=;
	b=AEqtj3MbeL+dPM2acTUg0CI5VCbmA0YAI7+7kfRVIT44HxlSNq4aRcme0FgvEE7ClayxOe
	QftbTQ8KDffRt2h2ZRfk/R4ZIIXEA6sai0Putj6yU+ON2OanAHowmRx2tqpc84dpVxl08Y
	avdUSwQG2v9LTHs9d6mUJZ7Q4BBQDf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737039418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=25mhKZCy+wszXZ9AZGe6SbcYXi6AGtNrxGnAfpbsCG8=;
	b=rguJeDJfYiIQd7adjxx2wmMWtXBY3kI61YH61TIa1Fqr8uTzpdX9+LnNre7c6BF5ziI8jh
	SG4nVASnZsEtUVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 519C313AEC;
	Thu, 16 Jan 2025 14:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CVjdEzoeiWe6EAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 14:56:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0EB4A08E0; Thu, 16 Jan 2025 15:56:57 +0100 (CET)
Date: Thu, 16 Jan 2025 15:56:57 +0100
From: Jan Kara <jack@suse.cz>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jan Kara <jack@suse.cz>, Jim Zhao <jimzhao.ai@gmail.com>, 
	akpm@linux-foundation.org, willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
Message-ID: <2xndprbkr5k5qer4zb6ov35fa5ym7c36q6mcyapdh22ypqxivh@ahuvuqs47yd4>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
 <a0d751f8-e50b-4fa5-a4bc-bccfc574f3bb@roeck-us.net>
 <b4m3w6wuw3h6ke7qlvimly7nok4ymjvnej2vx3lnds3vysyopr@6b5bnifyst24>
 <64a44636-16ec-4a10-aeb6-e327b7f989c2@roeck-us.net>
 <mqe2boksd5ztaz7xyabyp4sbtufxthcnrbwrjayghe4hpfbp4w@wjqsm467sjp5>
 <0e5dc5f1-c2c2-4893-902b-4677c21a38c0@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e5dc5f1-c2c2-4893-902b-4677c21a38c0@roeck-us.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,linux-foundation.org,infradead.org,vger.kernel.org,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Wed 15-01-25 08:41:43, Guenter Roeck wrote:
> On 1/15/25 08:07, Jan Kara wrote:
> > On Tue 14-01-25 07:01:08, Guenter Roeck wrote:
> > > On 1/14/25 05:19, Jan Kara wrote:
> > > > On Mon 13-01-25 15:05:25, Guenter Roeck wrote:
> > > > > On Thu, Nov 21, 2024 at 06:05:39PM +0800, Jim Zhao wrote:
> > > > > > Address the feedback from "mm/page-writeback: raise wb_thresh to prevent
> > > > > > write blocking with strictlimit"(39ac99852fca98ca44d52716d792dfaf24981f53).
> > > > > > The wb_thresh bumping logic is scattered across wb_position_ratio,
> > > > > > __wb_calc_thresh, and wb_update_dirty_ratelimit. For consistency,
> > > > > > consolidate all wb_thresh bumping logic into __wb_calc_thresh.
> > > > > > 
> > > > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > > > Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> > > > > 
> > > > > This patch triggers a boot failure with one of my 'sheb' boot tests.
> > > > > It is seen when trying to boot from flash (mtd). The log says
> > > > > 
> > > > > ...
> > > > > Starting network: 8139cp 0000:00:02.0 eth0: link down
> > > > > udhcpc: started, v1.33.0
> > > > > EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
> > > > > udhcpc: sending discover
> > > > > udhcpc: sending discover
> > > > > udhcpc: sending discover
> > > > > EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
> > > > 
> > > > Thanks for report! Uh, I have to say I'm very confused by this. It is clear
> > > > than when ext2 detects the directory corruption (we fail checking directory
> > > > inode 363 which is likely /etc/init.d/), the boot fails in interesting
> > > > ways. What is unclear is how the commit can possibly cause ext2 directory
> > > > corruption.  If you didn't verify reverting the commit fixes the issue, I'd
> > > > be suspecting bad bisection but that obviously isn't the case :-)
> > > > 
> > > > Ext2 is storing directory data in the page cache so at least it uses the
> > > > subsystem which the patch impacts but how writeback throttling can cause
> > > > ext2 directory corruption is beyond me. BTW, do you recreate the root
> > > > filesystem before each boot? How exactly?
> > > 
> > > I use pre-built root file systems. For sheb, they are at
> > > https://github.com/groeck/linux-build-test/tree/master/rootfs/sheb
> > 
> > Thanks. So the problematic directory is /usr/share/udhcpc/ where we
> > read apparently bogus metadata at the beginning of that directory.
> > 
> > > I don't think this is related to ext2 itself. Booting an ext2 image from
> > > ata/ide drive works.
> > 
> > Interesting this is specific to mtd. I'll read the patch carefully again if
> > something rings a bell.
> > 
> 
> Interesting. Is there some endianness issue, by any chance ? I only see the problem
> with sheb (big endian), not with sh (little endian). I'd suspect that it is an
> emulation bug, but it is odd that the problem did not show up before.

So far I don't have a good explanation. Let me write down here the facts,
maybe it will trigger the aha effect.

1) Ext2 stores the metadata in little endian ordering. We observe the
problem with the first directory entry in the folio. Both entry->rec_len
(16-bit) and entry->inode (32-bit) appear to be seen in wrong endianity

2) The function that fails is ext2_check_folio(). We kmap_local() the folio
in ext2_get_folio(), then in ext2_check_folio() we do:

	ext2_dirent *p;

	p = (ext2_dirent *)(kaddr + 0);
	rec_len = ext2_rec_len_from_disk(p->rec_len);
	^^^ value 3072 == 0x0c00 seen here instead of correct 0x000c
	this value is invalid so we go to:
	ext2_error(sb, __func__, "bad entry in directory #%lu: : %s - "
                        "offset=%llu, inode=%lu, rec_len=%d, name_len=%d",
                        dir->i_ino, error, folio_pos(folio) + offs,
                        (unsigned long) le32_to_cpu(p->inode),
                        rec_len, p->name_len);

	Here rec_len is printed so we see the wrong value. Also
le32_to_cpu(p->inode) is printed which also shows number with swapped byte
ordering (the message contains inode number 27393 == 0x00006b01 but the
proper inode number is 363 == 0x0000016b). This actually releals more about
the problem because only the two bytes were swapped in the inode number
although we always treat it as 32-bit entity. So this would indeed point
more at some architectural issue rather than a problem in the filesystem /
MM.

Note that to get at this point in the boot we must have correctly
byteswapped many other directory entries in the filesystem. So the problem
must be triggered by some parallel activity happening in the system or
something like that.

3) The problem appears only with MTD storage, not with IDE/SATA on the same
system + filesystem image. It it unclear how the storage influences the
reproduction, rather than that it influences timing of events in the
system.

4) The problem reliably happens with "mm/page-writeback: Consolidate wb_thresh
bumping logic into __wb_calc_thresh", not without it. All this patch does
is that it possibly changes a limit at which processes dirtying pages in
the page cache get throttled. Thus there are fairly limited opportunities
for how it can cause damage (I've checked for possible UAF issues or memory
corruption but I don't really see any such possibility there, it is just
crunching numbers from the mm counters and takes decision based on the
result). This change doesn't have direct on the directory ext2 code. The only
thing it does is that it possibly changes code alignment of ext2 code if it
gets linked afterwards into vmlinux image (provided ext2 is built in). Another
possibility is again that it changes timing of events in the system due to
differences in throttling of processes dirtying page cache.

So at this point I don't have a better explanation than blame the HW. What
really tipped my conviction in this direction is the 16-bit byteswap in a
32-bit entity. Hence I guess I'll ask Andrew to put Jim's patch back into
tree if you don't object.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

