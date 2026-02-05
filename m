Return-Path: <linux-fsdevel+bounces-76445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FMkAG/2UhGmL3gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:02:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A058F2ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31AF305DA7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA653D5240;
	Thu,  5 Feb 2026 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RCiBlJkz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aYpCmVYb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RCiBlJkz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aYpCmVYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730723D413F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296330; cv=none; b=kASTz9F22XOiIj1Z/wyEQLEVgNyBDkpdIQUJ+FB8bLzyVUkGLHliymDHrUidpc6+4FnhpAW9kfO3bor7KA0mCxQB/5iPm7l+wM4qRUdDsR7vZwoOjKwX14yn1eBFqknkRiL+L5NPkwDyD1WXzSXnnfEwY8FJ9IopCQOv0lWBN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296330; c=relaxed/simple;
	bh=dok/Rkbp5Vnw0Ec3l3ZSzUzo9vU9SzS3nGuFhArGYLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBRXxVFB1kCvpDeLpM4o5GKxEFj+med2zR/ng0y2iYYt4W4m4rcasIIffUNvhQCqdaIhYlhoNk5PqeO44n+mwtvfZZc6IB5I/l5p/hCi0U5DKFLcCCg8Om1jLG3YlWWZJRQORyUkOMRz6JGcyT1U3Zta+hlgudyZx1e47v2YgW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RCiBlJkz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aYpCmVYb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RCiBlJkz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aYpCmVYb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 894345BD99;
	Thu,  5 Feb 2026 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770296328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+IDKmnIWOsbv2X6xMcoaXjlH72AALGCDt2OmbOSlRk=;
	b=RCiBlJkzguMa+Yvjvca5suOt3k5DqsblXd/rcsNmI86wg8893i6dA8gNnGaiArPSMtGobk
	jVkPeHFwH7aNrgHQtWVkSohh1Rf4qzpIea77PHxwBEBlf9aayKLtT4ZbXIlWOr0ndyYWR+
	L/O5BixLKgHcYmT6I50VIwNfSVsMn7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770296328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+IDKmnIWOsbv2X6xMcoaXjlH72AALGCDt2OmbOSlRk=;
	b=aYpCmVYbsPesXGMZNSHex5RixHGdfcoOkVVpHVN0hX8sqNGqVDkOhL7PLmWjeNlv/Ojrsh
	9NOUceJtXr5S0kCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RCiBlJkz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aYpCmVYb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770296328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+IDKmnIWOsbv2X6xMcoaXjlH72AALGCDt2OmbOSlRk=;
	b=RCiBlJkzguMa+Yvjvca5suOt3k5DqsblXd/rcsNmI86wg8893i6dA8gNnGaiArPSMtGobk
	jVkPeHFwH7aNrgHQtWVkSohh1Rf4qzpIea77PHxwBEBlf9aayKLtT4ZbXIlWOr0ndyYWR+
	L/O5BixLKgHcYmT6I50VIwNfSVsMn7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770296328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+IDKmnIWOsbv2X6xMcoaXjlH72AALGCDt2OmbOSlRk=;
	b=aYpCmVYbsPesXGMZNSHex5RixHGdfcoOkVVpHVN0hX8sqNGqVDkOhL7PLmWjeNlv/Ojrsh
	9NOUceJtXr5S0kCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68A6E3EA63;
	Thu,  5 Feb 2026 12:58:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LeSGGQiUhGkrBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 12:58:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 27EB2A09D8; Thu,  5 Feb 2026 13:58:44 +0100 (CET)
Date: Thu, 5 Feb 2026 13:58:44 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, 
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, ritesh.list@gmail.com, djwong@kernel.org, 
	Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com, yangerkun@huawei.com, 
	yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com, libaokun9@gmail.com
Subject: Re: [PATCH -next v2 00/22] ext4: use iomap for regular file's
 buffered I/O path
Message-ID: <zpjowfhezn5mr7sgmxdg5kghgskm4cip77qr4ok4j6oa5e36y7@5hdpftwo56ex>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <aYGZB_hugPRXCiSI@infradead.org>
 <77c14b3e-33f9-4a00-83a4-0467f73a7625@huaweicloud.com>
 <20260203131407.GA27241@macsyma.lan>
 <9666679c-c9f7-435c-8b67-c67c2f0c19ab@huawei.com>
 <eldlhdvhc4sdlmfed5omg6huv5rl6m7ummstlygh2bownaejqn@bykrybkyywzp>
 <e186c712-1594-4f66-aa89-5517696f70ec@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e186c712-1594-4f66-aa89-5517696f70ec@huaweicloud.com>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76445-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[suse.cz,huawei.com,mit.edu,infradead.org,vger.kernel.org,dilger.ca,linux.ibm.com,gmail.com,kernel.org,alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9A058F2ECD
X-Rspamd-Action: no action

On Thu 05-02-26 10:06:11, Zhang Yi wrote:
> On 2/4/2026 10:23 PM, Jan Kara wrote:
> > On Wed 04-02-26 09:59:36, Baokun Li wrote:
> >> On 2026-02-03 21:14, Theodore Tso wrote:
> >>> On Tue, Feb 03, 2026 at 05:18:10PM +0800, Zhang Yi wrote:
> >>>> This means that the ordered journal mode is no longer in ext4 used
> >>>> under the iomap infrastructure.  The main reason is that iomap
> >>>> processes each folio one by one during writeback. It first holds the
> >>>> folio lock and then starts a transaction to create the block mapping.
> >>>> If we still use the ordered mode, we need to perform writeback in
> >>>> the logging process, which may require initiating a new transaction,
> >>>> potentially leading to deadlock issues. In addition, ordered journal
> >>>> mode indeed has many synchronization dependencies, which increase
> >>>> the risk of deadlocks, and I believe this is one of the reasons why
> >>>> ext4_do_writepages() is implemented in such a complicated manner.
> >>>> Therefore, I think we need to give up using the ordered data mode.
> >>>>
> >>>> Currently, there are three scenarios where the ordered mode is used:
> >>>> 1) append write,
> >>>> 2) partial block truncate down, and
> >>>> 3) online defragmentation.
> >>>>
> >>>> For append write, we can always allocate unwritten blocks to avoid
> >>>> using the ordered journal mode.
> >>> This is going to be a pretty severe performance regression, since it
> >>> means that we will be doubling the journal load for append writes.
> >>> What we really need to do here is to first write out the data blocks,
> >>> and then only start the transaction handle to modify the data blocks
> >>> *after* the data blocks have been written (to heretofore, unused
> >>> blocks that were just allocated).  It means inverting the order in
> >>> which we write data blocks for the append write case, and in fact it
> >>> will improve fsync() performance since we won't be gating writing the
> >>> commit block on the date blocks getting written out in the append
> >>> write case.
> >>
> >> I have some local demo patches doing something similar, and I think this
> >> work could be decoupled from Yi's patch set.
> >>
> >> Since inode preallocation (PA) maintains physical block occupancy with a
> >> logical-to-physical mapping, and ensures on-disk data consistency after
> >> power failure, it is an excellent location for recording temporary
> >> occupancy. Furthermore, since inode PA often allocates more blocks than
> >> requested, it can also help reduce file fragmentation.
> >>
> >> The specific approach is as follows:
> >>
> >> 1. Allocate only the PA during block allocation without inserting it into
> >>    the extent status tree. Return the PA to the caller and increment its
> >>    refcount to prevent it from being discarded.
> >>
> >> 2. Issue IOs to the blocks within the inode PA. If IO fails, release the
> >>    refcount and return -EIO. If successful, proceed to the next step.
> >>
> >> 3. Start a handle upon successful IO completion to convert the inode PA to
> >>    extents. Release the refcount and update the extent tree.
> >>
> >> 4. If a corresponding extent already exists, we’ll need to punch holes to
> >>    release the old extent before inserting the new one.
> > 
> > Sounds good. Just if I understand correctly case 4 would happen only if you
> > really try to do something like COW with this? Normally you'd just use the
> > already present blocks and write contents into them?
> > 
> >> This ensures data atomicity, while jbd2—being a COW-like implementation
> >> itself—ensures metadata atomicity. By leveraging this "delay map"
> >> mechanism, we can achieve several benefits:
> >>
> >>  * Lightweight, high-performance COW.
> >>  * High-performance software atomic writes (hardware-independent).
> >>  * Replacing dio_readnolock, which might otherwise read unexpected zeros.
> >>  * Replacing ordered data and data journal modes.
> >>  * Reduced handle hold time, as it's only held during extent tree updates.
> >>  * Paving the way for snapshot support.
> >>
> >> Of course, COW itself can lead to severe file fragmentation, especially
> >> in small-scale overwrite scenarios.
> > 
> > I agree the feature can provide very interesting benefits and we were
> > pondering about something like that for a long time, just never got to
> > implementing it. I'd say the immediate benefits are you can completely get
> > rid of dioread_nolock as well as the legacy dioread_lock modes so overall
> > code complexity should not increase much. We could also mostly get rid of
> > data=ordered mode use (although not completely - see my discussion with
> > Zhang over patch 3) which would be also welcome simplification. These
> 
> I suppose this feature can also be used to get rid of the data=ordered mode
> use in online defragmentation. With this feature, perhaps we can develop a
> new method of online defragmentation that eliminates the need to pre-allocate
> a donor file.  Instead, we can attempt to allocate as many contiguous blocks
> as possible through PA. If the allocated length is longer than the original
> extent, we can perform the swap and copy the data. Once the copy is complete,
> we can atomically construct a new extent, then releases the original blocks
> synchronously or asynchronously, similar to a regular copy-on-write (COW)
> operation. What does this sounds?

Well, the reason why defragmentation uses the donor file is that there can
be a lot of policy in where and how the file is exactly placed (e.g. you
might want to place multiple files together). It was decided it is too
complex to implement these policies in the kernel so we've offloaded the
decision where the file is placed to userspace. Back at those times we were
also considering adding interface to guide allocation of blocks for a file
so the userspace defragmenter could prepare donor file with desired blocks.
But then the interest in defragmentation dropped (particularly due to
advances in flash storage) and so these ideas never materialized.

We might rethink the online defragmentation interface but at this point
I'm not sure we are ready to completely replace the idea of guiding the
block placement using a donor file...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

