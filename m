Return-Path: <linux-fsdevel+bounces-36648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9049E74E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E791886BD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE87020B81D;
	Fri,  6 Dec 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PZpMZQhq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGXsG7K5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PZpMZQhq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGXsG7K5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B062171;
	Fri,  6 Dec 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500318; cv=none; b=mqXh3/IfPFnCfXVWFC8Lg2O9VUjc0HhqNv57lW9D6kXr0frxucBTZEWR/1nw5ZmuWuqDkjQ0AJXHxGeUIk8SXwxVwDRTAS1A99U9Qul/MEV5+hH1NORId+KgsZXcOQ+e9qJLLFsGjSGObjfiLQyk9XL1kCi/g57UFbC/SNM4DSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500318; c=relaxed/simple;
	bh=wCTL2ZjpQRRY6WMst98GL6ldhXJSLL8p6Tx1prpotTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmBp3UMvmzsNyKAYqjLCeMCfKYmsyICazyESYNF4i9NzfUpVYhTac207ICo24SLm4z5zpp74MEQ1t/U7vAJLPCdKr0T6gcKTjzUOuyY2YumzzowxgQaRJAvp9gYmg0gzjnW2L9pEfwupp3Nj/3zjTalWiBxDMPHFvXJteI/G4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PZpMZQhq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGXsG7K5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PZpMZQhq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGXsG7K5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DDBE1F37E;
	Fri,  6 Dec 2024 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733500314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt/SdeMd1iRB5c5Rd6Y7lq44iHK7kKqPbjOk3YA3ZQ4=;
	b=PZpMZQhqTR7kjmiBhrDltOQnk8ZkHqTw76XJ+Xm8euzfI/yYFnGkbsP/hVRg60XpqlaR0G
	Nf372g6LN/Pl7yCXIhn1nVQMvY9CjcmgB12vl/HF/qvLcD0xXYeWzcV+KQZhAxv3fnK5cs
	3D5QxDXkDI2z4Fph457UCWXARcDxhAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733500314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt/SdeMd1iRB5c5Rd6Y7lq44iHK7kKqPbjOk3YA3ZQ4=;
	b=mGXsG7K5TuH3+WMnmgzR3qGdDoZmo6Zdx/zTCG44OR6aUYiQTpQ6asiW5R+NK1hdqkD0hj
	CjWIsVuhwYpb+6Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733500314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt/SdeMd1iRB5c5Rd6Y7lq44iHK7kKqPbjOk3YA3ZQ4=;
	b=PZpMZQhqTR7kjmiBhrDltOQnk8ZkHqTw76XJ+Xm8euzfI/yYFnGkbsP/hVRg60XpqlaR0G
	Nf372g6LN/Pl7yCXIhn1nVQMvY9CjcmgB12vl/HF/qvLcD0xXYeWzcV+KQZhAxv3fnK5cs
	3D5QxDXkDI2z4Fph457UCWXARcDxhAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733500314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt/SdeMd1iRB5c5Rd6Y7lq44iHK7kKqPbjOk3YA3ZQ4=;
	b=mGXsG7K5TuH3+WMnmgzR3qGdDoZmo6Zdx/zTCG44OR6aUYiQTpQ6asiW5R+NK1hdqkD0hj
	CjWIsVuhwYpb+6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BBF613647;
	Fri,  6 Dec 2024 15:51:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y90ZIpodU2ceAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Dec 2024 15:51:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3BEF1A08CD; Fri,  6 Dec 2024 16:51:46 +0100 (CET)
Date: Fri, 6 Dec 2024 16:51:46 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 09/27] ext4: move out inode_lock into ext4_fallocate()
Message-ID: <20241206155146.wmc2flrony62d524@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-10-yi.zhang@huaweicloud.com>
 <20241204120527.jus6ymhsddxhlqjz@quack3>
 <792da260-656c-4e05-9d06-90580927bc20@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792da260-656c-4e05-9d06-90580927bc20@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 06-12-24 16:13:14, Zhang Yi wrote:
> On 2024/12/4 20:05, Jan Kara wrote:
> > On Tue 22-10-24 19:10:40, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Currently, all five sub-functions of ext4_fallocate() acquire the
> >> inode's i_rwsem at the beginning and release it before exiting. This
> >> process can be simplified by factoring out the management of i_rwsem
> >> into the ext4_fallocate() function.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Ah, nice. Feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > and please ignore my comments about renaming 'out' labels :).
> > 
> > 								Honza
> > 
> 
> ...
> 
> >> @@ -4774,9 +4765,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >>  
> >>  	inode_lock(inode);
> >>  	ret = ext4_convert_inline_data(inode);
> >> -	inode_unlock(inode);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto out;
> >>  
> >>  	if (mode & FALLOC_FL_PUNCH_HOLE)
> >>  		ret = ext4_punch_hole(file, offset, len);
> >> @@ -4788,7 +4778,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >>  		ret = ext4_zero_range(file, offset, len, mode);
> >>  	else
> >>  		ret = ext4_do_fallocate(file, offset, len, mode);
> >> -
> >> +out:
> >> +	inode_unlock(inode);
> >>  	return ret;
> >>  }
> >>  
> 
> I guess you may want to suggest rename this out to out_inode_lock as well.

Right. This one should better be out_inode_lock.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

