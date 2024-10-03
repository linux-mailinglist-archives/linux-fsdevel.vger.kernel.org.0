Return-Path: <linux-fsdevel+bounces-30855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725B98EE5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF791C21A15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABE155330;
	Thu,  3 Oct 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feY+wyL9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sz6F9+5Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="feY+wyL9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sz6F9+5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4313D245;
	Thu,  3 Oct 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955968; cv=none; b=DL1s6jAVrkvZbConfRBz4WuEI9v7Lct3k/dc58xZPjTM9RPU+HXMbZE8LIE/dTc4Xsi77fQK9D97+sXM/RYka9cqBT827crw8qzub84iPtp/GtXA5M1YUWvNTV7Eu+A6a5xb0oCCqT3YCFdcIbjRMJga5ro3Swj0n+qMpu6M7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955968; c=relaxed/simple;
	bh=uYxntOLomNurH/glEymVuBYbQJqrhAopyIorvKSj8zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4CBAGstm//0rstAPbypd/AepsVeIuuaTOPprbqG4K3l/fowJLJwUpd1kCSWFrJp0OiwM4cL9rsfDnb7eCYccdQK6XL7N/tGMSdSgNxLvJY45qjP5qx3MISaYjfjJle0bie1bon0eCyxWygtkMic8LxgDjzTp4x2eGl/G+n//b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feY+wyL9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sz6F9+5Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=feY+wyL9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sz6F9+5Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9047F1FDE6;
	Thu,  3 Oct 2024 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727955964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcC68ZzlwFoukPB1up1folji2OO+BVaGy0P+ZZAdd5Y=;
	b=feY+wyL94AZGixecMwLvGBEloL+wvtyZGZlf6Da4/pw0GOWAYk+9bElFoMMIUzIaBksBFt
	IktvpH7NuVDiCD7/w2V8AXkoHL78X1yKvSZU9/y8u4r2cHcGQNuoUO9awhjvlXhrdoU3Rf
	MedlNd8WYcmzI2/u9d0tuwQxTeCcLtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727955964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcC68ZzlwFoukPB1up1folji2OO+BVaGy0P+ZZAdd5Y=;
	b=sz6F9+5Za9PWzZFXOsZGjNi9C9aj46at2HjHlbluoZ4/HWH+eLHQRGMC/zRJZFiDuQ5YGO
	Jeke18qX0qlVLECQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727955964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcC68ZzlwFoukPB1up1folji2OO+BVaGy0P+ZZAdd5Y=;
	b=feY+wyL94AZGixecMwLvGBEloL+wvtyZGZlf6Da4/pw0GOWAYk+9bElFoMMIUzIaBksBFt
	IktvpH7NuVDiCD7/w2V8AXkoHL78X1yKvSZU9/y8u4r2cHcGQNuoUO9awhjvlXhrdoU3Rf
	MedlNd8WYcmzI2/u9d0tuwQxTeCcLtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727955964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcC68ZzlwFoukPB1up1folji2OO+BVaGy0P+ZZAdd5Y=;
	b=sz6F9+5Za9PWzZFXOsZGjNi9C9aj46at2HjHlbluoZ4/HWH+eLHQRGMC/zRJZFiDuQ5YGO
	Jeke18qX0qlVLECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DAD2139CE;
	Thu,  3 Oct 2024 11:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f8GoHvyD/mZ+GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 11:46:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B8AAA086F; Thu,  3 Oct 2024 13:45:56 +0200 (CEST)
Date: Thu, 3 Oct 2024 13:45:55 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <20241003114555.bl34fkqsja4s5tok@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002014017.3801899-1-david@fromorbit.com>
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Dave!

On Wed 02-10-24 11:33:17, Dave Chinner wrote:
> There are two superblock iterator functions provided. The first is a
> generic iterator that provides safe, reference counted inodes for
> the callback to operate on. This is generally what most sb->s_inodes
> iterators use, and it allows the iterator to drop locks and perform
> blocking operations on the inode before moving to the next inode in
> the sb->s_inodes list.
> 
> There is one quirk to this interface - INO_ITER_REFERENCE - because
> fsnotify iterates the inode cache -after- evict_inodes() has been
> called during superblock shutdown to evict all non-referenced
> inodes. Hence it should only find referenced inodes, and it has
> a check to skip unreferenced inodes. This flag does the same.

Overall I really like the series. A lot of duplicated code removed and
scalability improved, we don't get such deals frequently :) Regarding
INO_ITER_REFERENCE I think that after commit 1edc8eb2e9313 ("fs: call
fsnotify_sb_delete after evict_inodes") the check for 0 i_count in
fsnotify_unmount_inodes() isn't that useful anymore so I'd be actually fine
dropping it (as a separate patch please).

That being said I'd like to discuss one thing: As you have surely noticed,
some of the places iterating inodes perform additional checks on the inode
to determine whether the inode is interesting or not (e.g. the Landlock
iterator or iterators in quota code) to avoid the unnecessary iget / iput
and locking dance. The inode refcount check you've worked-around with
INO_ITER_REFERENCE is a special case of that. Have you considered option to
provide callback for the check inside the iterator?

Also maybe I'm went a *bit* overboard here with macro magic but the code
below should provide an iterator that you can use like:

	for_each_sb_inode(sb, inode, inode_eligible_check(inode)) {
		do my stuff here
	}

that will avoid any indirect calls and will magically handle all the
cleanup that needs to be done if you break / jump out of the loop or
similar. I actually find such constructs more convenient to use than your
version of the iterator because there's no need to create & pass around the
additional data structure for the iterator body, no need for special return
values to abort iteration etc.

								Honza

/* Find next inode on the inode list eligible for processing */
#define sb_inode_iter_next(sb, inode, old_inode, inode_eligible) 	\
({									\
	struct inode *ret = NULL;					\
									\
	cond_resched();							\
	spin_lock(&(sb)->s_inode_list_lock);				\
	if (!(inode))							\
		inode = list_first_entry((sb)->s_inodes, struct inode,	\
					 i_sb_list);			\
	while (1) {							\
		if (list_entry_is_head(inode, (sb)->s_inodes, i_sb_list)) { \
			spin_unlock(&(sb)->s_inode_list_lock);		\
			break;						\
		}							\
		spin_lock(&inode->i_lock);				\
		if ((inode)->i_state & (I_NEW | I_FREEING | I_WILL_FREE) || \
		    !inode_eligible) {					\
			spin_unlock(&(inode)->i_lock);			\
			continue;					\
		}							\
		__iget(inode);						\
		spin_unlock(&(inode)->i_lock);				\
		spin_unlock(&(sb)->s_inode_list_lock);			\
		iput(*old_inode);					\
		*old_inode = inode;					\
		ret = inode;						\
		break;							\
	}								\
	ret;								\
})

#define for_each_sb_inode(sb, inode, inode_eligible)			\
	for (DEFINE_FREE(old_inode, struct inode *, if (_T) iput(_T)),	\
	     inode = NULL;						\
	     inode = sb_inode_iter_next((sb), inode, &old_inode,	\
					 inode_eligible);		\
	    )
	     

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

