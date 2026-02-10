Return-Path: <linux-fsdevel+bounces-76844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BcgCAs8i2neRgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 15:09:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936DE11BBA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2209C30602C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9A36683F;
	Tue, 10 Feb 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gbRFwOel";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZCTfOjJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gbRFwOel";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZCTfOjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E43329E6D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732477; cv=none; b=ZPJtRTTAxCRYFEk9hGJB1LaqhUxWM3f/94VjRWIW9LjHUfxVVgLkXh4xXU4Y0zb+K5Xskbn8k4knEw5MM0aqfXx1nmqPu0tXV9q9j2A9qhzAi2H/lACEShRqreAuN4EbmCaUxWOD4weLipuktsEHwCWQpIoFtLBGVArBB1zZX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732477; c=relaxed/simple;
	bh=Fft/IA0/Vyzn6fcznSIhYi2XkOJ21SgDBtFPkYFRvJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkxcO9zCAml7NldqYALTpsrjRoosAcweByHp7ZE/OHwptVit+YUlzwuvzNzAS5tWSi5+Da0cvxSN3Y8TqSDtz9BcEzt5fTFdojTC3Ztu4g5TP0uTBldlSRdDJCErXTMbo8XTKV0k2UA9VDiKONjiEeokpMuGLLDMs9KRlvvlQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gbRFwOel; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZCTfOjJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gbRFwOel; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZCTfOjJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74C863E714;
	Tue, 10 Feb 2026 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770732473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCguQHcBj2EyZ9iohLKcfhnrAs79op6kIQKzBpiJkrg=;
	b=gbRFwOelcSry88qNy0e7zRnEQ3Sw4130/sqX/qK6t6LdkoW60qMghKNDJ1Mt1am9qOG7Ma
	p0lshmMDt5jQb/RkSlM5Gs2ARRy9AqzmkAJc9+bbubvi7bhbsVspbrB+C9jhq8T+NCH9C7
	dG0L+kunWaC9QG0OaiGM1bq5mU+BvLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770732473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCguQHcBj2EyZ9iohLKcfhnrAs79op6kIQKzBpiJkrg=;
	b=bZCTfOjJEJ5x8mPgXjGOhCrdXBD0iE7vjdadVqFjY+KMjy1AVEXrbNzoML22tO+BvQcFmD
	pzIWUf7GYVqyFdDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gbRFwOel;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bZCTfOjJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770732473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCguQHcBj2EyZ9iohLKcfhnrAs79op6kIQKzBpiJkrg=;
	b=gbRFwOelcSry88qNy0e7zRnEQ3Sw4130/sqX/qK6t6LdkoW60qMghKNDJ1Mt1am9qOG7Ma
	p0lshmMDt5jQb/RkSlM5Gs2ARRy9AqzmkAJc9+bbubvi7bhbsVspbrB+C9jhq8T+NCH9C7
	dG0L+kunWaC9QG0OaiGM1bq5mU+BvLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770732473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCguQHcBj2EyZ9iohLKcfhnrAs79op6kIQKzBpiJkrg=;
	b=bZCTfOjJEJ5x8mPgXjGOhCrdXBD0iE7vjdadVqFjY+KMjy1AVEXrbNzoML22tO+BvQcFmD
	pzIWUf7GYVqyFdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DB393EA62;
	Tue, 10 Feb 2026 14:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IIXbFrk7i2lZLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Feb 2026 14:07:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B7EBA0A4E; Tue, 10 Feb 2026 15:07:49 +0100 (CET)
Date: Tue, 10 Feb 2026 15:07:49 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org, 
	djwong@kernel.org, yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com, 
	yukuai@fnnas.com
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <yrnt4wyocyik4nwcamwk5noc7ilninlt7cmyggzwhwzjjsjzfc@uxdht432fgzm>
References: <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
 <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
 <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
 <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
 <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
 <665b8293-60a2-4d4d-aef5-cb1f9c3c0c13@huaweicloud.com>
 <ac1f8bd8-926e-4182-a5a3-a111b49ecafc@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac1f8bd8-926e-4182-a5a3-a111b49ecafc@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76844-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 936DE11BBA2
X-Rspamd-Action: no action

On Tue 10-02-26 20:02:51, Zhang Yi wrote:
> On 2/9/2026 4:28 PM, Zhang Yi wrote:
> > On 2/6/2026 11:35 PM, Jan Kara wrote:
> >> On Fri 06-02-26 19:09:53, Zhang Yi wrote:
> >>> On 2/5/2026 11:05 PM, Jan Kara wrote:
> >>>> So how about the following:
> >>>
> >>> Let me see, please correct me if my understanding is wrong, ana there are
> >>> also some points I don't get.
> >>>
> >>>> We expand our io_end processing with the
> >>>> ability to journal i_disksize updates after page writeback completes. Then
> 
> While I was extending the end_io path of buffered_head to support updating
> i_disksize, I found another problem that requires discussion.
> 
> Supporting updates to i_disksize in end_io requires starting a handle, which
> conflicts with the data=ordered mode because folios written back through the
> journal process cannot initiate any handles; otherwise, this may lead to a
> deadlock. This limitation does not affect the iomap path, as it does not use
> the data=ordered mode at all.  However, in the buffered_head path, online
> defragmentation (if this change works, it should be the last user) still uses
> the data=ordered mode.

Right and my intention was to use reserved handle for the i_disksize update
similarly as we currently use reserved handle for unwritten extent
conversion after page writeback is done.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

