Return-Path: <linux-fsdevel+bounces-14729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE487E700
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 11:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F6F2826B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F132D7B8;
	Mon, 18 Mar 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2dw1UmQt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3z0xrg9c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2dw1UmQt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3z0xrg9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4911C2C87A;
	Mon, 18 Mar 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756746; cv=none; b=SA1AGNsuVXfDPErOhRUb7lKnR80vfZFydoLebAKofCGKrrRCNR2CSaGw2QOuKlHGmO5KHReE4fgNsmOMvxDwpyCpxULZEMyUa32FmvKTHeaUZzq7FeMhYZKDZ3Y69wzxXwiO+bfY8tkr+6p2FG5tqLTucrtIW6b5QPP0FrN4qT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756746; c=relaxed/simple;
	bh=bErza8r5vX4TMpVnLgnjWknUlsjPH6b+8522Wz2lM54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3dXTk1abGbsMqIhBP27rFTNnI1cZIMQB9t+RiIugt+6JNlZrw2R+hjSCmSvWmNMasnb17T/R2QmhSZydPLKSYuUNi54KHMg9t3fKDZdwXGiIjDoCFQGwAQbLQnpDdFwgYEOu297xSf2eW/RCW3Vgri2zgaHeXdUSJvZOR+2qiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2dw1UmQt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3z0xrg9c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2dw1UmQt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3z0xrg9c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 880CF348C3;
	Mon, 18 Mar 2024 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710756742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXeXlxOahp88uM7sj5XyseV2tk62A3EuPgcosS5F4ow=;
	b=2dw1UmQtc7AIvk4NmyXmy1gMrw9H9l9ObhFnI29e+XZf2iJ1LNr31QYMlOjjLYr2rvJQog
	hQDALrZKeXlSgW+Ppj1yVUnpeu49nv5xqQiKyIpbFo/ZlyDfTie+PU9R4aXQNXhYDEd9T9
	Bhif0CoMg7CxytzI/n/+H2WaULS4Wjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710756742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXeXlxOahp88uM7sj5XyseV2tk62A3EuPgcosS5F4ow=;
	b=3z0xrg9c5b0ltCbZEyJT3buHnc54X0K8YJjSdemSfbP4dr6iISxl8z2aR0atSZuDvo8JbP
	Uw2aoGrpk1cUTuCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710756742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXeXlxOahp88uM7sj5XyseV2tk62A3EuPgcosS5F4ow=;
	b=2dw1UmQtc7AIvk4NmyXmy1gMrw9H9l9ObhFnI29e+XZf2iJ1LNr31QYMlOjjLYr2rvJQog
	hQDALrZKeXlSgW+Ppj1yVUnpeu49nv5xqQiKyIpbFo/ZlyDfTie+PU9R4aXQNXhYDEd9T9
	Bhif0CoMg7CxytzI/n/+H2WaULS4Wjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710756742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXeXlxOahp88uM7sj5XyseV2tk62A3EuPgcosS5F4ow=;
	b=3z0xrg9c5b0ltCbZEyJT3buHnc54X0K8YJjSdemSfbP4dr6iISxl8z2aR0atSZuDvo8JbP
	Uw2aoGrpk1cUTuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D8C61389C;
	Mon, 18 Mar 2024 10:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uACdHoYT+GXkWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 10:12:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2043CA07D9; Mon, 18 Mar 2024 11:12:22 +0100 (CET)
Date: Mon, 18 Mar 2024 11:12:22 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: cheung wall <zzqq0103.hey@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING in mark_buffer_dirty
Message-ID: <20240318101222.sbh52pa4mmwidzyw@quack3>
References: <CAKHoSAuCUF8kNFdv5Chb2Fnup2vwDb0W+UPOxHzgCg_O=KJA0A@mail.gmail.com>
 <ZfUl8pGp_JMWMaVI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfUl8pGp_JMWMaVI@casper.infradead.org>
X-Spam-Score: 7.91
X-Spamd-Result: default: False [7.91 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.48)[79.55%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(3.00)[0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *******
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Sat 16-03-24 04:54:10, Matthew Wilcox wrote:
> 
> This might be an iomap bug, so adding Christoph & Darrick.
> 
> On Sat, Mar 16, 2024 at 12:29:36PM +0800, cheung wall wrote:
> > HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)
> > WARNING: CPU: 0 PID: 2920 at fs/buffer.c:1176
> > mark_buffer_dirty+0x232/0x290
> 
> This is WARN_ON_ONCE(!buffer_uptodate(bh)), so we're trying to mark a
> buffer dirty when that buffer is not uptodate.
> 
> > RIP: 0010:mark_buffer_dirty+0x232/0x290
> > fs/buffer.c:1176
> > Call Trace:
> >  <TASK>
> >  __block_commit_write+0xe9/0x200
> > fs/buffer.c:2191
> 
> ... but line 2190 and 91 are:
> 
>                         set_buffer_uptodate(bh);
>                         mark_buffer_dirty(bh);
> 
> and the folio is locked.  So how do we clear the uptodate flag on the
> buffer without the folio locked?

Given this happens on block device page cache, I can imagine there's
someone operating on the cache directly using buffer heads without locking
the page. Filesystems do this all the time. I don't see the reproducer doing
anything like that but who knows...

								Honza

> >  block_write_end+0xb1/0x1f0
> > fs/buffer.c:2267
> >  iomap_write_end+0x461/0x8c0
> > fs/iomap/buffered-io.c:857
> >  iomap_write_iter
> > fs/iomap/buffered-io.c:938
> > [inline]
> >  iomap_file_buffered_write+0x4eb/0x800
> > fs/iomap/buffered-io.c:987
> >  blkdev_buffered_write
> > block/fops.c:646
> > [inline]
> >  blkdev_write_iter+0x4ae/0xa40
> > block/fops.c:696
> >  call_write_iter
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

