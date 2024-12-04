Return-Path: <linux-fsdevel+bounces-36415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F519E397E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C14DB29FB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93C1B21AB;
	Wed,  4 Dec 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VPwp/xaI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Rai7vGx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VPwp/xaI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Rai7vGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D8746E;
	Wed,  4 Dec 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311585; cv=none; b=bHEXA/50H7Kg7oMSaBH77Sto/XmtLDRdpyfMmwjphA2kE1MRMpZluoy5yY1x71L+jS8axELCA6yX7s/n5z+AgVpjkcXuLbdaQZz5qyqpGwmKbfRwFiWo3TNC3RuyZ/Tq0aripy3/OxdM0vjw+LRUPNbFQ2oiXzv53T3Egoxj5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311585; c=relaxed/simple;
	bh=R76BoLqcFt7qjaaPgRxTcpfpnc/z29lonvOuPnFyxTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7Ov9TWyrmB6Uz1TG3hFjyyQnv7pvKX3qr8AiK5KIrpNSPuXglzhWXCbgKydb4Lm2mGadTF5lwk94Y/foWyZKGiyqiExDzcY6IkV7teV3cv2sMpAWZ7r4v347s5j2eGn5yQ3+xlC/YNnyvzupzhFeNTQ0hE4BcRHxUqAq4pD6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VPwp/xaI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Rai7vGx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VPwp/xaI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Rai7vGx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FDDB1F365;
	Wed,  4 Dec 2024 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733311581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgxU0sGAlB8FCPgiDQQDJRVeEbeuL+glRSzvz8klzGU=;
	b=VPwp/xaI67s9OqIrQwKJta5/R0oKbGfEgQwUZRS3y+KzMCqxGhmXaDjFMN7AQKTQ1kUHW2
	MUV6JGKp4zdEXKdxnQAbYaD25Zm9YcbrUIPHAz0u0UbxwEpMnFmTZl5zf8/Fgu/WXR4aMQ
	FuWmXT/auUfkdGejz9vMsfLZ3UKvGdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733311581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgxU0sGAlB8FCPgiDQQDJRVeEbeuL+glRSzvz8klzGU=;
	b=2Rai7vGxc1pCwqVSvkq4hg8Ln/Dt88nGiOtZLWZ1kQCbryUBuMwg6dZlnataZGRjWsCzmz
	sU/JT5qGGHjHzNAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733311581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgxU0sGAlB8FCPgiDQQDJRVeEbeuL+glRSzvz8klzGU=;
	b=VPwp/xaI67s9OqIrQwKJta5/R0oKbGfEgQwUZRS3y+KzMCqxGhmXaDjFMN7AQKTQ1kUHW2
	MUV6JGKp4zdEXKdxnQAbYaD25Zm9YcbrUIPHAz0u0UbxwEpMnFmTZl5zf8/Fgu/WXR4aMQ
	FuWmXT/auUfkdGejz9vMsfLZ3UKvGdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733311581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pgxU0sGAlB8FCPgiDQQDJRVeEbeuL+glRSzvz8klzGU=;
	b=2Rai7vGxc1pCwqVSvkq4hg8Ln/Dt88nGiOtZLWZ1kQCbryUBuMwg6dZlnataZGRjWsCzmz
	sU/JT5qGGHjHzNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FA201396E;
	Wed,  4 Dec 2024 11:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ObHKA108UGfbEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 11:26:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5772A0918; Wed,  4 Dec 2024 12:26:16 +0100 (CET)
Date: Wed, 4 Dec 2024 12:26:16 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, hch@infradead.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 03/27] ext4: don't write back data before punch hole in
 nojournal mode
Message-ID: <20241204112616.sa3dqa25ycpzfrjl@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-4-yi.zhang@huaweicloud.com>
 <20241118231521.GA9417@frogsfrogsfrogs>
 <56e451a7-e6ae-468a-81d8-f2513245f87f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56e451a7-e6ae-468a-81d8-f2513245f87f@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,fromorbit.com,google.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 20-11-24 10:56:53, Zhang Yi wrote:
> On 2024/11/19 7:15, Darrick J. Wong wrote:
> > On Tue, Oct 22, 2024 at 07:10:34PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> There is no need to write back all data before punching a hole in
> >> data=ordered|writeback mode since it will be dropped soon after removing
> >> space, so just remove the filemap_write_and_wait_range() in these modes.
> >> However, in data=journal mode, we need to write dirty pages out before
> >> discarding page cache in case of crash before committing the freeing
> >> data transaction, which could expose old, stale data.
> > 
> > Can't the same thing happen with non-journaled data writes?
> > 
> > Say you write 1GB of "A"s to a file and fsync.  Then you write "B"s to
> > the same 1GB of file and immediately start punching it.  If the system
> > reboots before the mapping updates all get written to disk, won't you
> > risk seeing some of those "A" because we no longer flush the "B"s?
> > 
> > Also, since the program didn't explicitly fsync the Bs, why bother
> > flushing the dirty data at all?  Are data=journal writes supposed to be
> > synchronous flushing writes nowadays?
> 
> Thanks you for your replay.
> 
> This case is not exactly the problem that can occur in data=journal
> mode, the problem is even if we fsync "B"s before punching the hole, we
> may still encounter old data ("A"s or even order) if the system reboots
> before the hole-punching process is completed.
> 
> The details of this problem is the ext4_punch_hole()->
> truncate_pagecache_range()-> ..->journal_unmap_buffer() will drop the
> checkpoint transaction, which may contain B's journaled data. Consequently,
> the journal tail could move advance beyond this point. If we do not flush
> the data before dropping the cache and a crash occurs before the punching
> transaction is committed, B's transaction will never recover, resulting
> in the loss of B's data. Therefore, this cannot happen in non-journaled
> data writes.

Yes, you're correct. The logic in journal_unmap_buffer() (used when freeing
journaled data blocks) assumes that if there's no running / committing
transaction, then orphan replay is going to fixup possible partial
operations and thus it simply discards the block that's being freed. That
works for truncate but not for hole punch or range zeroing. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

