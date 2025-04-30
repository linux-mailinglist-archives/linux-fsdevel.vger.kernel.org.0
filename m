Return-Path: <linux-fsdevel+bounces-47711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DABFAA47E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 12:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB394E181C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C384248F4B;
	Wed, 30 Apr 2025 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qJ0nB70I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GvHo8/El";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qJ0nB70I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GvHo8/El"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44A2367A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007785; cv=none; b=ue3WC+7KK5NVILB++HzJHyzQJ1fVJGxo0Eo0lSsQbfA67k9H4FPVmoF7laqJWEd3HKCjJlziU9pQMvAeAKAJsLj3ZSC22JsfMSapl4CPRa1wsqXbBeCt1ZR2oGYjSZKPQvoya34kVT75L53WeJLhlFQzN0JLizjzfpUi+dTVd7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007785; c=relaxed/simple;
	bh=p4DKBZ+r8Iy5PFJUuBnRM57oj/8ItT/uLeHR6i5xzn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knvQFbZObKMcCBwH7Bp9Z61S1Yscesiy9AuZ37irCsTdOMq3zBrTSybOsRPSbkOYNzjnTiX4OI0GDPlxpTCsoxVrjyg2zVSUSMtQDmH/slJLuXx9eMv4YxKU25bDoo/HEN4SUh2xu6yNm2Ozpn+JS0GKwWQqYNHBwHTzutm4M/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qJ0nB70I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GvHo8/El; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qJ0nB70I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GvHo8/El; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 951411F7BF;
	Wed, 30 Apr 2025 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746007781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aL+RUvEzRlecm/zxsoMvmpuUXla5KNxdrEuzKPGfURc=;
	b=qJ0nB70IkIzDgNXRFphlV8RRyaqWMh6hpfPl0HMBvSqX3CTS4WTqQPL/CCw1NF2zEjqEod
	+JgkjEQH0VpfjekVow68VOQRwsR/1FXVTHGYeE9/J9gB6N5R3iqQjjRswGcEmzgyp9VYm+
	YLuQb97eXAR4cEO9ULsxB2ss3DQUgQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746007781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aL+RUvEzRlecm/zxsoMvmpuUXla5KNxdrEuzKPGfURc=;
	b=GvHo8/ElhlvCnscZ2r7I/9WCEuNqZ0PeuixlLEwW1H7aAg8iab+iTaMD5KfyYg1BtlPNs0
	Ak2jnGN7kv4fJKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746007781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aL+RUvEzRlecm/zxsoMvmpuUXla5KNxdrEuzKPGfURc=;
	b=qJ0nB70IkIzDgNXRFphlV8RRyaqWMh6hpfPl0HMBvSqX3CTS4WTqQPL/CCw1NF2zEjqEod
	+JgkjEQH0VpfjekVow68VOQRwsR/1FXVTHGYeE9/J9gB6N5R3iqQjjRswGcEmzgyp9VYm+
	YLuQb97eXAR4cEO9ULsxB2ss3DQUgQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746007781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aL+RUvEzRlecm/zxsoMvmpuUXla5KNxdrEuzKPGfURc=;
	b=GvHo8/ElhlvCnscZ2r7I/9WCEuNqZ0PeuixlLEwW1H7aAg8iab+iTaMD5KfyYg1BtlPNs0
	Ak2jnGN7kv4fJKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A954139E7;
	Wed, 30 Apr 2025 10:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z1bTIeX2EWilMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Apr 2025 10:09:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32780A0AF0; Wed, 30 Apr 2025 12:09:37 +0200 (CEST)
Date: Wed, 30 Apr 2025 12:09:37 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, wanghaichi0403@gmail.com, yi.zhang@huawei.com, 
	libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 2/4] ext4: fix incorrect punch max_end
Message-ID: <4u2frbxygagij6uxryijqmzgarhotk4cw2w4knm4rpivll5qvg@2d2wd2742v36>
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
 <20250430011301.1106457-2-yi.zhang@huaweicloud.com>
 <ykm27jvrnmhgd4spslhn4mano452c6z34fab7r3776dmjkgo7q@cv2lvsiteufa>
 <8c1f9230-a475-4fc3-9b2d-5f11f5122bb3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c1f9230-a475-4fc3-9b2d-5f11f5122bb3@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 30-04-25 16:44:25, Zhang Yi wrote:
> On 2025/4/30 16:18, Jan Kara wrote:
> > On Wed 30-04-25 09:12:59, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> For the extents inodes, the maxbytes should be sb->s_maxbytes instead of
> >> sbi->s_bitmap_maxbytes. Correct the maxbytes value to correct the
> >> behavior of punch hole.
> >>
> >> Fixes: 2da376228a24 ("ext4: limit length to bitmap_maxbytes - blocksize in punch_hole")
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Thinking about this some more...
> > 
> >> @@ -4015,6 +4015,12 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
> >>  	trace_ext4_punch_hole(inode, offset, length, 0);
> >>  	WARN_ON_ONCE(!inode_is_locked(inode));
> >>  
> >> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> >> +		max_end = sb->s_maxbytes;
> >> +	else
> >> +		max_end = EXT4_SB(sb)->s_bitmap_maxbytes;
> >> +	max_end -= sb->s_blocksize;
> > 
> > I think the -= sb->s_blocksize is needed only for indirect-block based
> > scheme (due to an implementation quirk in ext4_ind_remove_space()). But
> > ext4_ext_remove_space() should be fine with punch hole ending right at
> > sb->s_maxbytes. And since I find it somewhat odd that you can create file
> > upto s_maxbytes but cannot punch hole to the end, it'd limit that behavior
> > as much as possible. Ideally we'd fix ext4_ind_remove_space() but I can't
> > be really bothered for the ancient format...
> > 
> 
> Yes, I share your feelings. Currently, we do not seem to have any
> practical issues. To maintain consistent behavior between the two inode
> types and to keep the code simple, I retained the -= sb->s_blocksize
> operation. Would you suggest that we should at least address the extents
> inodes by removing the -=sb->s_blocksize now?

Yes, what I'm suggesting is that we keep -=sb->s_blocksize specific for the
case !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

