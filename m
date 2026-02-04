Return-Path: <linux-fsdevel+bounces-76320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPGYCNBXg2mJlQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:29:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 759AFE71B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90C8830C2CB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA484410D14;
	Wed,  4 Feb 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GECEUGN4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jdAeoxEO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GECEUGN4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jdAeoxEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D440B6F9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215029; cv=none; b=hw15Yxxlc5zHiUKFgQrw+5XA3+FLDHsGxm+vMNo7OX8Y3xear8NF0Q0THImMhrdMJ4J5fffNUppsVfThnpie7ygAFzq+kiBkjlnsRKrtjLXk3nYnrUKWTsSPP0PYTpCrnEJ29SNCrUGvkQdoOBPGiTdeZMubKVBMHou9wIjEHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215029; c=relaxed/simple;
	bh=5vUsehuZPKeIgCSeACFC8M9S/0Q5TkKs0RXczlR9+fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyVjl30xYPe16l++nDTIN7dmbvpQoO69MkX1CIGus76dB31p0pBAV1Sl4PIJ9xCb/9LMgY+q0DrYl8QRc8mYO40j3lPcBaJ2rvWQQN6KtDddHfyA9MrSgOameeTTF2Cj+1TjkqovO5v2ydPzAfMEaC0lxqVjX7G+97U0+6xvnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GECEUGN4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jdAeoxEO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GECEUGN4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jdAeoxEO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CFDD5BD3A;
	Wed,  4 Feb 2026 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770215027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGxQfo3pNLsPfTQCN+Qxxka1BgGIjfu/518Xoi+fVfo=;
	b=GECEUGN4MDyDAzo2/J0R8f4OEnyskO7j+6j9m9CDIohUqzy8y0csOEvP/cgeiXDB1PpYpI
	UUQYxR2bRXPRPJOQWzDbIXCINFe54pgPwl731uekOhmYeU5p4OuyVY0xThlafzPTg6Unsk
	BQbuqQFgHCeWIrnMQaRc0befZ86jxts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770215027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGxQfo3pNLsPfTQCN+Qxxka1BgGIjfu/518Xoi+fVfo=;
	b=jdAeoxEOjETYHoYMFpSAy2WzMYdh/gGddUqjYSerfsHUTIhM5HVxBbPgU7tdxMHxJZbTYO
	+/4CZt9+/RtPkABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770215027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGxQfo3pNLsPfTQCN+Qxxka1BgGIjfu/518Xoi+fVfo=;
	b=GECEUGN4MDyDAzo2/J0R8f4OEnyskO7j+6j9m9CDIohUqzy8y0csOEvP/cgeiXDB1PpYpI
	UUQYxR2bRXPRPJOQWzDbIXCINFe54pgPwl731uekOhmYeU5p4OuyVY0xThlafzPTg6Unsk
	BQbuqQFgHCeWIrnMQaRc0befZ86jxts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770215027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGxQfo3pNLsPfTQCN+Qxxka1BgGIjfu/518Xoi+fVfo=;
	b=jdAeoxEOjETYHoYMFpSAy2WzMYdh/gGddUqjYSerfsHUTIhM5HVxBbPgU7tdxMHxJZbTYO
	+/4CZt9+/RtPkABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23EF73EA63;
	Wed,  4 Feb 2026 14:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GjK0CHNWg2kcbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Feb 2026 14:23:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D72BAA09D8; Wed,  4 Feb 2026 15:23:46 +0100 (CET)
Date: Wed, 4 Feb 2026 15:23:46 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Theodore Tso <tytso@mit.edu>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com, 
	ritesh.list@gmail.com, djwong@kernel.org, Zhang Yi <yi.zhang@huawei.com>, 
	yizhang089@gmail.com, yangerkun@huawei.com, 
	yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com, libaokun9@gmail.com
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
Message-ID: <eldlhdvhc4sdlmfed5omg6huv5rl6m7ummstlygh2bownaejqn@bykrybkyywzp>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
 <20260203131407.GA27241@macsyma.lan>
 <9666679c-c9f7-435c-8b67-c67c2f0c19ab@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9666679c-c9f7-435c-8b67-c67c2f0c19ab@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76320-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[mit.edu,huaweicloud.com,infradead.org,vger.kernel.org,dilger.ca,suse.cz,linux.ibm.com,gmail.com,kernel.org,huawei.com,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 759AFE71B0
X-Rspamd-Action: no action

On Wed 04-02-26 09:59:36, Baokun Li wrote:
> On 2026-02-03 21:14, Theodore Tso wrote:
> > On Tue, Feb 03, 2026 at 05:18:10PM +0800, Zhang Yi wrote:
> >> This means that the ordered journal mode is no longer in ext4 used
> >> under the iomap infrastructure.  The main reason is that iomap
> >> processes each folio one by one during writeback. It first holds the
> >> folio lock and then starts a transaction to create the block mapping.
> >> If we still use the ordered mode, we need to perform writeback in
> >> the logging process, which may require initiating a new transaction,
> >> potentially leading to deadlock issues. In addition, ordered journal
> >> mode indeed has many synchronization dependencies, which increase
> >> the risk of deadlocks, and I believe this is one of the reasons why
> >> ext4_do_writepages() is implemented in such a complicated manner.
> >> Therefore, I think we need to give up using the ordered data mode.
> >>
> >> Currently, there are three scenarios where the ordered mode is used:
> >> 1) append write,
> >> 2) partial block truncate down, and
> >> 3) online defragmentation.
> >>
> >> For append write, we can always allocate unwritten blocks to avoid
> >> using the ordered journal mode.
> > This is going to be a pretty severe performance regression, since it
> > means that we will be doubling the journal load for append writes.
> > What we really need to do here is to first write out the data blocks,
> > and then only start the transaction handle to modify the data blocks
> > *after* the data blocks have been written (to heretofore, unused
> > blocks that were just allocated).  It means inverting the order in
> > which we write data blocks for the append write case, and in fact it
> > will improve fsync() performance since we won't be gating writing the
> > commit block on the date blocks getting written out in the append
> > write case.
> 
> I have some local demo patches doing something similar, and I think this
> work could be decoupled from Yi's patch set.
> 
> Since inode preallocation (PA) maintains physical block occupancy with a
> logical-to-physical mapping, and ensures on-disk data consistency after
> power failure, it is an excellent location for recording temporary
> occupancy. Furthermore, since inode PA often allocates more blocks than
> requested, it can also help reduce file fragmentation.
> 
> The specific approach is as follows:
> 
> 1. Allocate only the PA during block allocation without inserting it into
>    the extent status tree. Return the PA to the caller and increment its
>    refcount to prevent it from being discarded.
> 
> 2. Issue IOs to the blocks within the inode PA. If IO fails, release the
>    refcount and return -EIO. If successful, proceed to the next step.
> 
> 3. Start a handle upon successful IO completion to convert the inode PA to
>    extents. Release the refcount and update the extent tree.
> 
> 4. If a corresponding extent already exists, we’ll need to punch holes to
>    release the old extent before inserting the new one.

Sounds good. Just if I understand correctly case 4 would happen only if you
really try to do something like COW with this? Normally you'd just use the
already present blocks and write contents into them?

> This ensures data atomicity, while jbd2—being a COW-like implementation
> itself—ensures metadata atomicity. By leveraging this "delay map"
> mechanism, we can achieve several benefits:
> 
>  * Lightweight, high-performance COW.
>  * High-performance software atomic writes (hardware-independent).
>  * Replacing dio_readnolock, which might otherwise read unexpected zeros.
>  * Replacing ordered data and data journal modes.
>  * Reduced handle hold time, as it's only held during extent tree updates.
>  * Paving the way for snapshot support.
> 
> Of course, COW itself can lead to severe file fragmentation, especially
> in small-scale overwrite scenarios.

I agree the feature can provide very interesting benefits and we were
pondering about something like that for a long time, just never got to
implementing it. I'd say the immediate benefits are you can completely get
rid of dioread_nolock as well as the legacy dioread_lock modes so overall
code complexity should not increase much. We could also mostly get rid of
data=ordered mode use (although not completely - see my discussion with
Zhang over patch 3) which would be also welcome simplification. These
benefits alone are IMO a good enough reason to have the functionality :).
Even without COW, atomic writes and other fancy stuff.

I don't see how you want to get rid of data=journal mode - perhaps that's
related to the COW functionality?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

