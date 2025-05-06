Return-Path: <linux-fsdevel+bounces-48228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBBEAAC2C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0394B1C40831
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29CC182B4;
	Tue,  6 May 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKwbhWZh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1avpgVkL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKwbhWZh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1avpgVkL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B817333F
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531220; cv=none; b=ZH3CjIT7WR/9/nXsTmkuBgQjhdf2zWtYv/BPPuOnPY3IRgWnU36skbLkA5bRHdZmv2shOzynG/+cMVF3+B/CGgpxiL5VrJamiTtgKc0M7vpcO/6sI1FWqwnZbs2Gd6WWfS8jPxa4ExS24+HRaU2anqKxH5hEiZgNhXGYGOq8244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531220; c=relaxed/simple;
	bh=MoetjBBVZR1BGXuHKBFlquwNeinQUMvhrU1krUSWWak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqFUPy2jnAGARhoeAlUoEzwY+/i7TROqeHAKY885p3MYICIIBwnV0ZN3aQEWIFKvmLScu82eTJ6JA6gqdGgVvRvnqf4rgpSKzkmKn9+lWT4ngQvVRojRZxRiu/ul0IFNEOWdn8HOrij/WCBbxTmas9TTyz7Fc0Lvyo0YHNtn0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKwbhWZh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1avpgVkL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKwbhWZh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1avpgVkL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9FAE22119C;
	Tue,  6 May 2025 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746531216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhcyRWXpsrmtT2eg3HpVL2y2qZ9F1J3uLoV1OoSPIwI=;
	b=OKwbhWZhfNNcFx73JgUpyn+f1UZnbCGGSWdF3cFkaxEgqhUZxSC8VckoA3FbkAK/tOuFH1
	Y9snMqDKs0Mnz4eTGcR+kMMzSpPdPx4kwpTYcvXcMCucVd16XgHh63kOdi679vnxupiT+x
	aLCcw8bzILPVUlc8Tv/5GCmapwEWIiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746531216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhcyRWXpsrmtT2eg3HpVL2y2qZ9F1J3uLoV1OoSPIwI=;
	b=1avpgVkL3+AiJbcsoqjFMucf/lEVN42K2yEF0BgmT+/4bV3gz3GVvwHGA+FerHMYaV3eQJ
	+/TlLWkZ6H+duMBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746531216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhcyRWXpsrmtT2eg3HpVL2y2qZ9F1J3uLoV1OoSPIwI=;
	b=OKwbhWZhfNNcFx73JgUpyn+f1UZnbCGGSWdF3cFkaxEgqhUZxSC8VckoA3FbkAK/tOuFH1
	Y9snMqDKs0Mnz4eTGcR+kMMzSpPdPx4kwpTYcvXcMCucVd16XgHh63kOdi679vnxupiT+x
	aLCcw8bzILPVUlc8Tv/5GCmapwEWIiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746531216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EhcyRWXpsrmtT2eg3HpVL2y2qZ9F1J3uLoV1OoSPIwI=;
	b=1avpgVkL3+AiJbcsoqjFMucf/lEVN42K2yEF0BgmT+/4bV3gz3GVvwHGA+FerHMYaV3eQJ
	+/TlLWkZ6H+duMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92554137CF;
	Tue,  6 May 2025 11:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZUy7I5DzGWi7FwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 May 2025 11:33:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0CCBAA09BE; Tue,  6 May 2025 13:33:36 +0200 (CEST)
Date: Tue, 6 May 2025 13:33:36 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Liebes Wang <wanghaichi0403@gmail.com>, ojaswin@linux.ibm.com, Theodore Ts'o <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, syzkaller@googlegroups.com, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: kernel BUG in zero_user_segments
Message-ID: <l2ckvuxugdhoq3wf3s7hufwn7q3togt7tususj23te4fc75h5d@itemgw27odar>
References: <CADCV8spm=TtW_Lu6p-5q-jdHv1ryLcx45mNBEcYdELbHv_4TnQ@mail.gmail.com>
 <uxweupjmz7pzbj77cciiuxduxnbuk33mx75bimynzcjmq664zo@xqrdf6ouf5v6>
 <ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com>
 <aBGVmIin8YxRyFDp@casper.infradead.org>
 <znfg4s5ysxqvrzeevkmtgixj5vztcyqbuny7waqkugnzkpg2zx@2vxwh57flvva>
 <d93e69d0-8145-40ac-8afc-f1e8ccbe2052@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d93e69d0-8145-40ac-8afc-f1e8ccbe2052@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,infradead.org,gmail.com,linux.ibm.com,mit.edu,vger.kernel.org,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 06-05-25 10:25:06, Zhang Yi wrote:
> On 2025/5/1 19:19, Jan Kara wrote:
> > On Wed 30-04-25 04:14:32, Matthew Wilcox wrote:
> >> On Tue, Apr 29, 2025 at 03:55:18PM +0800, Zhang Yi wrote:
> >>> After debugging, I found that this problem is caused by punching a hole
> >>> with an offset variable larger than max_end on a corrupted ext4 inode,
> >>> whose i_size is larger than maxbyte. It will result in a negative length
> >>> in the truncate_inode_partial_folio(), which will trigger this problem.
> >>
> >> It seems to me like we're asking for trouble when we allow an inode with
> >> an i_size larger than max_end to be instantiated.  There are probably
> >> other places which assume it is smaller than max_end.  We should probably
> >> decline to create the bad inode in the first place?
> > 
> > Indeed somewhat less quirky fix could be to make ext4_max_bitmap_size()
> > return one block smaller limit. Something like:
> > 
> >         /* Compute how many blocks we can address by block tree */
> >         res += ppb;
> >         res += ppb * ppb;
> >         res += ((loff_t)ppb) * ppb * ppb;
> > +	/*
> > +	 * Hole punching assumes it can map the block past end of hole to
> > +	 * tree offsets
> > +	 */
> > +	res -= 1;
> >         /* Compute how many metadata blocks are needed */
> >         meta_blocks = 1;
> >         meta_blocks += 1 + ppb;
> > 
> > The slight caveat is that in theory there could be filesystems out there
> > with so large files and then we'd stop allowing access to such files. But I
> > guess the chances are so low that it's probably worth trying.
> > 
> 
> Hmm, I suppose this approach could pose some risks to our legacy products,
> and it makes me feel uneasy. Personally, I am more inclined toward the
> current solution, unless we decide to fix the ext4_ind_remove_space()
> directly. :)

OK. I'm just curious, are you using indirect-block based inodes and using
them upto the current s_bitmap_maxbytes size? :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

