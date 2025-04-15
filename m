Return-Path: <linux-fsdevel+bounces-46494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B61A8A3FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43162188A760
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FE9214A6F;
	Tue, 15 Apr 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jv4GuO/T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DW03iMV3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jv4GuO/T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DW03iMV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE22DFA36
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734240; cv=none; b=Qpgn+/O+E1cF0oNxRvsc8y+8X+e5m5CLuBjbAndDlBWnKr+50wrlkFBcEUQxFdljEBGZkOKfcChZJiyuwdXBEtnQeuJESu1wCogrFzjkjhctfNXL471dYAmpbMkLcBRTfZv2UbIHnz3YMBLTGmLLbOeF8efzBuMif/ZeI83tZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734240; c=relaxed/simple;
	bh=6BhuTa/n+sw6A3pEJyOLp/aG6ySvxHw+1f04hpwGhwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM0bOsHW0woh7wWOYjm/FmJaJBOhPJzQjcDU0cmvcfAIoDIOjKcDJovdcCO+aLm63/DkVlXcjH0HXtTZccs7FzLKnPbWxbDIcurLhsUKsm8REt8wEboR4/mMKB9mvV5YBEbn42km83nnpMDNNSL/OSi9R8SjbhJd8NXobBJv4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jv4GuO/T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DW03iMV3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jv4GuO/T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DW03iMV3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A08A21184;
	Tue, 15 Apr 2025 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744734235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsp5Dc6HOnMd9yPCyRiIOOb7SllY5qkSdNd2gHurJPY=;
	b=Jv4GuO/T9ZIWl1L7QZPPVV//V2ckd1G3h29GQReIyKJ43xnx5jBxS7EcPSlS2ujHc4G4gC
	yZPuQra+lw8g08idMpr6jEZZ3Fb+PsYZhkpXE7rr4ahB4p7TRRy6ja5PMr2fD4+kcHQiiT
	cvQ3NhMxEKWM+TkYwqdZH8t4/lRMwlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744734235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsp5Dc6HOnMd9yPCyRiIOOb7SllY5qkSdNd2gHurJPY=;
	b=DW03iMV3+e+SoUAyEQdrz6b6PgxdSn9pm2Ys2MfZ4LmnucYqcqvfZnzJp0sQADQYiZgSw7
	iIZfZDQzBC4OUuAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Jv4GuO/T";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DW03iMV3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744734235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsp5Dc6HOnMd9yPCyRiIOOb7SllY5qkSdNd2gHurJPY=;
	b=Jv4GuO/T9ZIWl1L7QZPPVV//V2ckd1G3h29GQReIyKJ43xnx5jBxS7EcPSlS2ujHc4G4gC
	yZPuQra+lw8g08idMpr6jEZZ3Fb+PsYZhkpXE7rr4ahB4p7TRRy6ja5PMr2fD4+kcHQiiT
	cvQ3NhMxEKWM+TkYwqdZH8t4/lRMwlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744734235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsp5Dc6HOnMd9yPCyRiIOOb7SllY5qkSdNd2gHurJPY=;
	b=DW03iMV3+e+SoUAyEQdrz6b6PgxdSn9pm2Ys2MfZ4LmnucYqcqvfZnzJp0sQADQYiZgSw7
	iIZfZDQzBC4OUuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D5E0139A1;
	Tue, 15 Apr 2025 16:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oMi/FhuI/mf1YAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 16:23:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0AAA7A0947; Tue, 15 Apr 2025 18:23:55 +0200 (CEST)
Date: Tue, 15 Apr 2025 18:23:54 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	riel@surriel.com, dave@stgolabs.net, willy@infradead.org, hannes@cmpxchg.org, 
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk, hare@suse.de, 
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com, 
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/8] migrate: fix skipping metadata buffer heads on
 migration
Message-ID: <dkjq2c57du34wq7ocvtk37a5gkcondxfedgnbdxse55nhlfioy@v6tx45lkopfm>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-2-mcgrof@kernel.org>
 <dpn6pb7hwpmajoh5k5zla6x7fsmh4rlttstj3hkuvunp6tok3j@ikz2fxpikfv4>
 <Z_15mCAv6nsSgRTf@bombadil.infradead.org>
 <Z_2J9bxCqAUPgq42@bombadil.infradead.org>
 <20250415-freihalten-tausend-a9791b9c3a03@brauner>
 <Z_5_p3t_fNUBoG7Y@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_5_p3t_fNUBoG7Y@bombadil.infradead.org>
X-Rspamd-Queue-Id: 6A08A21184
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[f3c6fda1297c748a7076];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,mit.edu,dilger.ca,vger.kernel.org,surriel.com,stgolabs.net,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 15-04-25 08:47:51, Luis Chamberlain wrote:
> On Tue, Apr 15, 2025 at 11:05:38AM +0200, Christian Brauner wrote:
> > On Mon, Apr 14, 2025 at 03:19:33PM -0700, Luis Chamberlain wrote:
> > > On Mon, Apr 14, 2025 at 02:09:46PM -0700, Luis Chamberlain wrote:
> > > > On Thu, Apr 10, 2025 at 02:05:38PM +0200, Jan Kara wrote:
> > > > > > @@ -859,12 +862,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> > > > > >  			}
> > > > > >  			bh = bh->b_this_page;
> > > > > >  		} while (bh != head);
> > > > > > +		spin_unlock(&mapping->i_private_lock);
> > > > > 
> > > > > No, you've just broken all simple filesystems (like ext2) with this patch.
> > > > > You can reduce the spinlock critical section only after providing
> > > > > alternative way to protect them from migration. So this should probably
> > > > > happen at the end of the series.
> > > > 
> > > > So you're OK with this spin lock move with the other series in place?
> > > > 
> > > > And so we punt the hard-to-reproduce corruption issue as future work
> > > > to do? Becuase the other alternative for now is to just disable
> > > > migration for jbd2:
> > > > 
> > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > index 1dc09ed5d403..ef1c3ef68877 100644
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -3631,7 +3631,6 @@ static const struct address_space_operations ext4_journalled_aops = {
> > > >  	.bmap			= ext4_bmap,
> > > >  	.invalidate_folio	= ext4_journalled_invalidate_folio,
> > > >  	.release_folio		= ext4_release_folio,
> > > > -	.migrate_folio		= buffer_migrate_folio_norefs,
> > > >  	.is_partially_uptodate  = block_is_partially_uptodate,
> > > >  	.error_remove_folio	= generic_error_remove_folio,
> > > >  	.swap_activate		= ext4_iomap_swap_activate,
> > > 
> > > BTW I ask because.. are your expectations that the next v3 series also
> > > be a target for Linus tree as part of a fix for this spinlock
> > > replacement?
> > 
> > Since this is fixing potential filesystem corruption I will upstream
> > whatever we need to do to fix this. Ideally we have a minimal fix to
> > upstream now and a comprehensive fix and cleanup for v6.16.
> 
> Despite our efforts we don't yet have an agreement on how to fix the
> ext4 corruption, becuase Jan noted the buffer_meta() check in this patch
> is too broad and would affect other filesystems (I have yet to
> understand how, but will review).
> 
> And so while we have agreement we can remove the spin lock to fix the
> sleeping while atomic incurred by large folios for buffer heads by this
> patch series, the removal of the spin lock would happen at the end of
> this series.
> 
> And so the ext4 corruption is an existing issue as-is today, its
> separate from the spin lock removal goal to fix the sleeping while
> atomic..

I agree. Ext4 corruption problems are separate from sleeping in atomic
issues.

> However this series might be quite big for an rc2 or rc3 fix for that spin
> lock removal issue. It should bring in substantial performance benefits
> though, so it might be worthy to consider. We can re-run tests with the
> adjustment to remove the spin lock until the last patch in this series.
> 
> The alternative is to revert the spin lock addition commit for Linus'
> tree, ie commit ebdf4de5642fb6 ("mm: migrate: fix reference check race
> between __find_get_block() and migration") and note that it in fact does
> not fix the ext4 corruption as we've noted, and in fact causes an issue
> with sleeping while atomic with support for large folios for buffer
> heads. If we do that then we  punt this series for the next development
> window, and it would just not have the spin lock removal on the last
> patch.

Well, the commit ebdf4de5642fb6 is 6 years old. At that time there were no
large folios (in fact there were no folios at all ;)) in the page cache and
it does work quite well (I didn't see a corruption report from real users
since then). So I don't like removing that commit because it makes a
"reproducible with a heavy stress test" problem become a "reproduced by
real world workloads" problem.

If you look for a fast way to fixup sleep in atomic issues, then I'd
suggest just disabling large pages for block device page cache. That is the
new functionality that actually triggered all these investigations and
sleep-in-atomic reports. And once this patch set gets merged, we can
reenable large folios in the block device page cache again.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

