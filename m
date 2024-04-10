Return-Path: <linux-fsdevel+bounces-16537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534C389F04A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4F91F214BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC9159583;
	Wed, 10 Apr 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfbWO/OQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9RbhZTG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfbWO/OQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9RbhZTG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B6158D6E;
	Wed, 10 Apr 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746755; cv=none; b=iMW8CpJavdY5exLymZydvLOKQrar8KfftyU0VoyyRQ3h/tEZ96v23KvFFfP6j4uCB2R30zq3FZ4e0/l78fkcbc/XV+JMRH6bd05gOCDM4ao9Q6AYctenxyNvm+c0o8SU95VgI3Ndr78PsGtCIeTVbj0Ms6tIx/6vnEh8CJFh9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746755; c=relaxed/simple;
	bh=2uLsqs7h9g6JN7/WqCner9XkbwliGQfhNQv6hCJYe8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+SRHP3x7NAcj9CFb++NIS5Bye2x1u57U3S9w4I/XbfGaiHstzzFPzn5aWoQmryuD3IhkGxBuoppNORMHSX31lWsMxCvqGMbJAEZT130QKuowqKKQ1cz73OCWQ0ACIGwtMOQX8C4oipjX1bU/trBNnzY1N7vkUL46M+oCKAXAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfbWO/OQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9RbhZTG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfbWO/OQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9RbhZTG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CBD15CB27;
	Wed, 10 Apr 2024 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712746751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atBGykmy/ko8XoU5S8lr0267EBdVuJZjJOWDVdyODEg=;
	b=MfbWO/OQ+5ZQdP1rOfcUvxmJi+cXE3f67wD/MYy7fb1mWiwNg1r6BjIP5NBhDD6nOuLMXQ
	QwfITj0Pwp1UmbjAPi7MBlrq8N7WXicSgCguvEnAPMo2Z8copavmja19oAYeNygK3/++gp
	5IPDiDeQUzjNyo9NWZD5hFA05VLI6dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712746751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atBGykmy/ko8XoU5S8lr0267EBdVuJZjJOWDVdyODEg=;
	b=W9RbhZTGxbfyWT1upN7SfXR8t1MkncYdLgz7aeOJN36P5E6jskvWcZUIbjg6czdBDsFVQM
	AisKayHTLg8ns0Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712746751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atBGykmy/ko8XoU5S8lr0267EBdVuJZjJOWDVdyODEg=;
	b=MfbWO/OQ+5ZQdP1rOfcUvxmJi+cXE3f67wD/MYy7fb1mWiwNg1r6BjIP5NBhDD6nOuLMXQ
	QwfITj0Pwp1UmbjAPi7MBlrq8N7WXicSgCguvEnAPMo2Z8copavmja19oAYeNygK3/++gp
	5IPDiDeQUzjNyo9NWZD5hFA05VLI6dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712746751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atBGykmy/ko8XoU5S8lr0267EBdVuJZjJOWDVdyODEg=;
	b=W9RbhZTGxbfyWT1upN7SfXR8t1MkncYdLgz7aeOJN36P5E6jskvWcZUIbjg6czdBDsFVQM
	AisKayHTLg8ns0Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FE4A1390D;
	Wed, 10 Apr 2024 10:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e30fI/9wFmYadAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 10 Apr 2024 10:59:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A532A06D8; Wed, 10 Apr 2024 12:59:11 +0200 (CEST)
Date: Wed, 10 Apr 2024 12:59:11 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240410105911.hfxz4qh3n5ekrpqg@quack3>
References: <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 09-04-24 14:22:37, Yu Kuai wrote:
> Hi,
> 
> 在 2024/04/09 12:26, Al Viro 写道:
> > On Sun, Apr 07, 2024 at 11:21:56AM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2024/04/07 11:06, Al Viro 写道:
> > > > On Sun, Apr 07, 2024 at 10:34:56AM +0800, Yu Kuai wrote:
> > > > 
> > > > > Other than raw block_device fops, other filesystems can use the opened
> > > > > bdev_file directly for iomap and buffer_head, and they actually don't
> > > > > need to reference block_device anymore. The point here is that whether
> > > > 
> > > > What do you mean, "reference"?  The counting reference is to opened
> > > > file; ->s_bdev is a cached pointer to associated struct block_device,
> > > > and neither it nor pointers in buffer_head are valid past the moment
> > > > when you close the file.  Storing (non-counting) pointers to struct
> > > > file in struct buffer_head is not different in that respect - they
> > > > are *still* only valid while the "master" reference is held.
> > > > 
> > > > Again, what's the point of storing struct file * in struct buffer_head
> > > > or struct iomap?  In any instances of those structures?
> > > 
> > > Perhaps this is what you missed, like the title of this set, in order to
> > > remove direct acceess of bdev->bd_inode from fs/buffer, we must store
> > > bdev_file in buffer_head and iomap, and 'bdev->bd_inode' is replaced
> > > with 'file_inode(bdev)' now.
> > 
> > BTW, what does that have to do with iomap?  All it passes ->bdev to is
> > 	1) bio_alloc()
> > 	2) bio_alloc_bioset()
> > 	3) bio_init()
> > 	4) bdev_logical_block_size()
> > 	5) bdev_iter_is_aligned()
> > 	6) bdev_fua()
> > 	7) bdev_write_cache()
> > 
> > None of those goes anywhere near fs/buffer.c or uses ->bd_inode, AFAICS.
> > 
> > Again, what's the point?  It feels like you are trying to replace *all*
> > uses of struct block_device with struct file, just because.
> > 
> > If that's what's going on, please don't.  Using struct file instead
> > of that bdev_handle crap - sure, makes perfect sense.  But shoving it
> > down into struct bio really, really does not.
> > 
> > I'd suggest to start with adding ->bd_mapping as the first step and
> > converting the places where mapping is all we want to using that.
> > Right at the beginning of your series.  Then let's see what gets
> > left.
> 
> Thanks so much for your advice, in fact, I totally agree with this that
> adding a 'bd_mapping' or expose the helper bdev_mapping().
> 
> However, I will let Christoph and Jan to make the decision, when they
> get time to take a look at this.

I agree with Christian and Al - and I think I've expressed that already in
the previous version of the series [1] but I guess I was not explicit
enough :). I think the initial part of the series (upto patch 21, perhaps
excluding patch 20) is a nice cleanup but the latter part playing with
stashing struct file is not an improvement and seems pointless to me. So
I'd separate the initial part cleaning up the obvious places and let
Christian merge it and then we can figure out what (if anything) to do with
remaining bd_inode uses in fs/buffer.c etc. E.g. what Al suggests with
bd_mapping makes sense to me but I didn't check what's left after your
initial patches...

								Honza

[1] https://lore.kernel.org/all/20240322125750.jov4f3alsrkmqnq7@quack3

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

