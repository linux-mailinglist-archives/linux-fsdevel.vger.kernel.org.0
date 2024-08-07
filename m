Return-Path: <linux-fsdevel+bounces-25302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1894A8B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFEA1C20905
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDAA200126;
	Wed,  7 Aug 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vy8wRb85";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MaYrq7CE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vy8wRb85";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MaYrq7CE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A21E7A3B;
	Wed,  7 Aug 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037843; cv=none; b=G2URhDejZdBEhisTNVEyAACS0/muQEOZ4z1ev2TF0dO3sjmutwo3rBMEL5KSarHpm5JR8wAnP8dBIzdl+Uf6J6rrvvzxqL5DpUxyvRNmyz/7Tx+0o8nKkxNaNXXTLZPpfIR15N2P3zxmZiXT/FRueV4a8lV/MUUPopR0qYlvpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037843; c=relaxed/simple;
	bh=mm8pAHOnAkFqGyxp5I/86KmQPZ8qC0Sfat11ek1RkW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akafhF/SE/Ma+0GKFhAqeJrW9v3hqLMzLVBBAX8hy65PPCYjWM3XKg+1xUOBfwrlbUq81WlI+1zDoEUt6uPn0ptIfe2qXm/Ocm7xVLKmoyca0417zzKLE4i0dAZESRd2hv2Ifh3pvGG4ml2de9vDFaf9TTeX2oGumABxb6tv+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vy8wRb85; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MaYrq7CE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vy8wRb85; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MaYrq7CE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 161AB1F396;
	Wed,  7 Aug 2024 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723037840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZFoKp6ZkbMc6/3zlTwksVl8/pkkbCAfc22o+fX9lRw=;
	b=vy8wRb85CqOEQSv5d5ynVnKxIHQQKYr9dQV48CQVaC8FrqBrP94yNeygfSNzopfdxYCOs1
	MTYBUmaHTR1CfvTFfwBj11TGnGbSSXiEXqdWrdRGLk9Z9u77JCOMaRoVqbpP9+ZnlPyQ4Q
	PGz9wSX/wUjPOQ85cuVTNw2yrrY0FB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723037840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZFoKp6ZkbMc6/3zlTwksVl8/pkkbCAfc22o+fX9lRw=;
	b=MaYrq7CEAnnMe74p8TpM32mknJ+mhTTOZCFNocbK0Ic1syrR0KTi81lpl/1jNF91Yg1AYH
	NFXXViTNHDm0iTCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723037840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZFoKp6ZkbMc6/3zlTwksVl8/pkkbCAfc22o+fX9lRw=;
	b=vy8wRb85CqOEQSv5d5ynVnKxIHQQKYr9dQV48CQVaC8FrqBrP94yNeygfSNzopfdxYCOs1
	MTYBUmaHTR1CfvTFfwBj11TGnGbSSXiEXqdWrdRGLk9Z9u77JCOMaRoVqbpP9+ZnlPyQ4Q
	PGz9wSX/wUjPOQ85cuVTNw2yrrY0FB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723037840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZFoKp6ZkbMc6/3zlTwksVl8/pkkbCAfc22o+fX9lRw=;
	b=MaYrq7CEAnnMe74p8TpM32mknJ+mhTTOZCFNocbK0Ic1syrR0KTi81lpl/1jNF91Yg1AYH
	NFXXViTNHDm0iTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0939C13A7D;
	Wed,  7 Aug 2024 13:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M2pXApB4s2ZeVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 13:37:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A619CA0762; Wed,  7 Aug 2024 15:37:19 +0200 (CEST)
Date: Wed, 7 Aug 2024 15:37:19 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 03/10] ext4: don't set EXTENT_STATUS_DELAYED on
 allocated blocks
Message-ID: <20240807133719.pjxlhfx25rfqiuul@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-4-yi.zhang@huaweicloud.com>
 <20240806152327.td572f7elpel4aeo@quack3>
 <685055bc-0d56-6cf3-7716-f27e448c8c38@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685055bc-0d56-6cf3-7716-f27e448c8c38@huaweicloud.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 07-08-24 20:18:18, Zhang Yi wrote:
> On 2024/8/6 23:23, Jan Kara wrote:
> > On Fri 02-08-24 19:51:13, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Since we always set EXT4_GET_BLOCKS_DELALLOC_RESERVE when allocating
> >> delalloc blocks, there is no need to keep delayed flag on the unwritten
> >> extent status entry, so just drop it after allocation.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Let me improve the changelog because I was confused for some time before I
> > understood:
> > 
> > Currently, we release delayed allocation reservation when removing delayed
> > extent from extent status tree (which also happens when overwriting one
> > extent with another one). When we allocated unwritten extent under
> > some delayed allocated extent, we don't need the reservation anymore and
> > hence we don't need to preserve the EXT4_MAP_DELAYED status bit. Inserting
> > the new extent into extent status tree will properly release the
> > reservation.
> > 
> 
> Thanks for your review and change log improvement. My original idea was very
> simple, after patch 2, we always set EXT4_GET_BLOCKS_DELALLOC_RESERVE when
> allocating blocks for delalloc extent, these two conditions in the 'if'
> branch can never be true at the same time, so they become dead code and I
> dropped them.
> 
> 	if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
> 	    ext4_es_scan_range(inode, &ext4_es_is_delayed, ...)
> 
> But after thinking your change log, I agree with you that we have already
> properly update the reservation by searching delayed blocks through
> ext4_es_delayed_clu() in ext4_ext_map_blocks() when we allocated unwritten
> extent under some delayed allocated extent even it's not from the write
> back path, so I think we can also drop them even without patch 2. But just
> one point, I think the last last sentence isn't exactly true before path 6,
> should it be "Allocating the new extent blocks will properly release the
> reservation." now ?

Now you've got me confused again ;) Why I wrote the changelog that way is
because ext4_es_remove_extent() is calling ext4_da_release_space(). But now
I've realized I've confused ext4_es_remove_extent() with
__es_remove_extent() which is what gets called when inserting another
extent. So I was wrong and indeed your version of the last sentense is
correct. Thanks for catching this!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

