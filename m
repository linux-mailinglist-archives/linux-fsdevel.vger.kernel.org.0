Return-Path: <linux-fsdevel+bounces-18089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D152D8B5547
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F6B1F22F01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D764439AF1;
	Mon, 29 Apr 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J3YXv5De";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUUTHm6H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J3YXv5De";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NUUTHm6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074C383BA;
	Mon, 29 Apr 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386359; cv=none; b=JYLTuBg1Fom8cjGi6sPvN+7gCSKoAeIHrDSaRg+csHd/kpF8Czml5gMm8jx8cK0yLnmHtjY3wiWEbOSPboe0jTe4VQ0fN7Lx4Sz8cr2sU2VkgAsObB2XMM/nKK84hTQfgGj3WukFYLEI58ICnqqdggU93LvqtPKK2Zz62TmwUNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386359; c=relaxed/simple;
	bh=cADUwdCDxPZT/pSB/dKjxUYhDiMPjw+O+Xt5ZtJsSKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prfR6T7K8WZ1jZ2UyLbzg1Sw2kaPEI8PO7UD48VUbWBfmjOaIviKvSHKzJyr/WQJUr9C0rnFk6o+HiWFfucYwYoF1QKBGBEuLFgXsyVb+6VZ+malvTc/0myzWvgmrv3Udq5pPahDr8RLzMkaC0KoUaJzf2AT52ZoG7IdH8eSZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J3YXv5De; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUUTHm6H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J3YXv5De; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NUUTHm6H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 629FF225FA;
	Mon, 29 Apr 2024 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714386355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdguafLdAH4AdttvIwHOB3Ush9+rDDpiVxU7qZjO9K0=;
	b=J3YXv5DeF63aric9ZS4jrCwDLLyL5Gq4Shk2YyT+Cya0zsUwL7pKrSSitNgXGs+RV1ZGWC
	0kYRSIhPo5CMhMiF+p/2Hz+0LwG/wKbpIZF9l0HuihtmMMLJz1/Z4SLd9oI0O3dqQGmQ3K
	UUP7LFJyJY0KUj9sGX+xOO+/MXJ33Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714386355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdguafLdAH4AdttvIwHOB3Ush9+rDDpiVxU7qZjO9K0=;
	b=NUUTHm6HmvLhAvbA7nKESwcZ7fFHCyQ1QcYJ2Ssh0q+Xqwhpm/gmTFmJf/Y5sYnxWaTnnf
	l9B6UU9FJCapryBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714386355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdguafLdAH4AdttvIwHOB3Ush9+rDDpiVxU7qZjO9K0=;
	b=J3YXv5DeF63aric9ZS4jrCwDLLyL5Gq4Shk2YyT+Cya0zsUwL7pKrSSitNgXGs+RV1ZGWC
	0kYRSIhPo5CMhMiF+p/2Hz+0LwG/wKbpIZF9l0HuihtmMMLJz1/Z4SLd9oI0O3dqQGmQ3K
	UUP7LFJyJY0KUj9sGX+xOO+/MXJ33Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714386355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdguafLdAH4AdttvIwHOB3Ush9+rDDpiVxU7qZjO9K0=;
	b=NUUTHm6HmvLhAvbA7nKESwcZ7fFHCyQ1QcYJ2Ssh0q+Xqwhpm/gmTFmJf/Y5sYnxWaTnnf
	l9B6UU9FJCapryBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59148139DE;
	Mon, 29 Apr 2024 10:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2cTIFbN1L2blMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 10:25:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 01A2EA082F; Mon, 29 Apr 2024 12:25:50 +0200 (CEST)
Date: Mon, 29 Apr 2024 12:25:50 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/9] ext4: trim delalloc extent
Message-ID: <20240429102550.sx4vdl75whxovmc2@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-4-yi.zhang@huaweicloud.com>
 <20240425155640.ktvqqwhteitysaby@quack3>
 <acd4e7c9-c68b-9edc-bba4-dce5e8ce7879@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd4e7c9-c68b-9edc-bba4-dce5e8ce7879@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,huawei.com:email]

On Fri 26-04-24 17:38:23, Zhang Yi wrote:
> On 2024/4/25 23:56, Jan Kara wrote:
> > On Wed 10-04-24 11:41:57, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> The cached delalloc or hole extent should be trimed to the map->map_len
> >> if we map delalloc blocks in ext4_da_map_blocks(). But it doesn't
> >> trigger any issue now because the map->m_len is always set to one and we
> >> always insert one delayed block once a time. Fix this by trim the extent
> >> once we get one from the cached extent tree, prearing for mapping a
> >> extent with multiple delalloc blocks.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Well, but we already do the trimming in ext4_da_map_blocks(), don't we? You
> > just move it to a different place... Or do you mean that we actually didn't
> > set 'map' at all in some cases and now we do? 
> 
> Yeah, now we only trim map len if we found an unwritten extent or written
> extent in the cache, this isn't okay if we found a hole and
> ext4_insert_delayed_block() and ext4_da_map_blocks() support inserting
> map->len blocks. If we found a hole which es->es_len is shorter than the
> length we want to write, we could delay more blocks than we expected.
> 
> Please assume we write data [A, C) to a file that contains a hole extent
> [A, B) and a written extent [B, D) in cache.
> 
>                       A     B  C  D
> before da write:   ...hhhhhh|wwwwww....
> 
> Then we will get extent [A, B), we should trim map->m_len to B-A before
> inserting new delalloc blocks, if not, the range [B, C) is duplicated.

Thanks for explanation!

> > In either case the 'map'
> > handling looks a bit sloppy in ext4_da_map_blocks() as e.g. the
> > 'add_delayed' case doesn't seem to bother with properly setting 'map' based
> > on what it does. So maybe we should clean that up to always set 'map' just
> > before returning at the same place where we update the 'bh'? And maybe bh
> > update could be updated in some common helper because it's content is
> > determined by the 'map' content?
> > 
> 
> I agree with you, it looks that we should always revise the map->m_len
> once we found an extent from the cache, and then do corresponding handling
> according to the extent type. so it's hard to put it to a common place.
> But we can merge the handling of written and unwritten extent, I've moved
> the bh updating into ext4_da_get_block_prep() and do some cleanup in
> patch 9, please look at that patch, does it looks fine to you?

Oh, yes, what patch 9 does improve things significantly and it addresses my
concern. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Maybe in the changelog you can just mention that the remaining cases not
setting map->m_len will be handled in patch 9.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

