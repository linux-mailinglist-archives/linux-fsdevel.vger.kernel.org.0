Return-Path: <linux-fsdevel+bounces-76595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HggEmEKhmkRJQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:36:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB9FFCE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1B8E300E5C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C12BDC04;
	Fri,  6 Feb 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WAdYV5Fh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hIku7Ikp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WAdYV5Fh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hIku7Ikp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606C26FD9B
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392157; cv=none; b=k9q3znIFgOa1PhKaXvl0F5mG7uyh2bJ+3LZYCbEZqoZIxJYpNp8whplOwVS2U98347aDBka9CfJuqzWncIKkCkd+7hB4WVRZy9McBHP4+GI8VqWFkECYpUMEI/UAZjo9BAcmuiIbj1JcdrTBMiMrmRf5o3UFkM3HynlMuyE+8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392157; c=relaxed/simple;
	bh=7BSdG8O1SD2/Z6DqYe2xZ60FxCTzKX4RjOvnd335ncU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5SXQRHOzBWD9ht5uBQJqjIQvXgWu3z5GZubS+ZUMny3pv7oMwzZMWJkNM3al8sSie7pBu0M5+bNElS6xnn2TMlWSN7Ogo+ypr3y2e5718BIOhzjTOfxY218mJWSpx5r3/dSUAVC1/icKm2v8x2gcKaOy7jdx1WoR3/afYIzNJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WAdYV5Fh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hIku7Ikp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WAdYV5Fh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hIku7Ikp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FCA23E6E8;
	Fri,  6 Feb 2026 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770392155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqg0VauHz5OEUAgvtmJ6LPTPfRvzttMRzxEn5z628Hc=;
	b=WAdYV5Fhy1Zvfg+YwH4WKi7rqjpQGIBzsI2eFYSkYEvtVZzwjG03KpCc99a/aIg4mrgKC7
	DmTDtu2J+UNdKavwaOvilvqKG7QZfeKB6zIROQuntInAzZgk38y3owTRy/Qlg06qa5NOtF
	z6JqBOx52bZ8KcNZ4ZNWLyyo6McBK6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770392155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqg0VauHz5OEUAgvtmJ6LPTPfRvzttMRzxEn5z628Hc=;
	b=hIku7IkpFOEXRH9rnZS15B4m5ehbV0vsxQJHYT48dPrCmPZfjGDFJ4uN8ZlCWTBgAzmyCt
	XdGZCuVo0xQtY2Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WAdYV5Fh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hIku7Ikp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770392155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqg0VauHz5OEUAgvtmJ6LPTPfRvzttMRzxEn5z628Hc=;
	b=WAdYV5Fhy1Zvfg+YwH4WKi7rqjpQGIBzsI2eFYSkYEvtVZzwjG03KpCc99a/aIg4mrgKC7
	DmTDtu2J+UNdKavwaOvilvqKG7QZfeKB6zIROQuntInAzZgk38y3owTRy/Qlg06qa5NOtF
	z6JqBOx52bZ8KcNZ4ZNWLyyo6McBK6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770392155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqg0VauHz5OEUAgvtmJ6LPTPfRvzttMRzxEn5z628Hc=;
	b=hIku7IkpFOEXRH9rnZS15B4m5ehbV0vsxQJHYT48dPrCmPZfjGDFJ4uN8ZlCWTBgAzmyCt
	XdGZCuVo0xQtY2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56E903EA63;
	Fri,  6 Feb 2026 15:35:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 358xFVsKhmmyCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Feb 2026 15:35:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EECF3A09E9; Fri,  6 Feb 2026 16:35:50 +0100 (CET)
Date: Fri, 6 Feb 2026 16:35:50 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org, 
	djwong@kernel.org, Zhang Yi <yi.zhang@huawei.com>, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
 <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
 <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
 <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
 <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76595-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B1AB9FFCE6
X-Rspamd-Action: no action

On Fri 06-02-26 19:09:53, Zhang Yi wrote:
> On 2/5/2026 11:05 PM, Jan Kara wrote:
> > So how about the following:
> 
> Let me see, please correct me if my understanding is wrong, ana there are
> also some points I don't get.
> 
> > We expand our io_end processing with the
> > ability to journal i_disksize updates after page writeback completes. Then
> > when doing truncate up or appending writes, we keep i_disksize at the old
> > value and just zero folio tails in the page cache, mark the folio dirty and
> > update i_size.
> 
> I think we need to submit this zeroed folio here as well. Because,
> 
> 1) In the case of truncate up, if we don't submit, the i_disksize may have to
>    wait a long time (until the folio writeback is complete, which takes about
>    30 seconds by default) before being updated, which is too long.

Correct but I'm not sure it matters. Current delalloc writes behave in the
same way already. For simplicity I'd thus prefer to not treat truncate up
in a special way but if we decide this indeed desirable, we can either
submit the tail folio immediately, or schedule work with earlier writeback.

> 2) In the case of appending writes. Assume that the folio written beyond this
>    one is written back first, we have to wait this zeroed folio to be write
>    back and then update i_disksize, so we can't wait too long either.

Correct, update of i_disksize after writeback of folios beyond current
i_disksize is blocked by the writeback of the tail folio.

> > When submitting writeback for a folio beyond current
> > i_disksize we make sure writepages submits IO for all the folios from
> > current i_disksize upwards.
> 
> Why "all the folios"? IIUC, we only wait the zeroed EOF folio is sufficient.

I was worried about a case like:

We have 4k blocksize, file is i_disksize 2k. Now you do:
pwrite(file, buf, 1, 6k);
pwrite(file, buf, 1, 10k);
pwrite(file, buf, 1, 14k);

The pwrite at offset 6k needs to zero the tail of the folio with index 0,
pwrite at 10k needs to zero the tail of the folio with index 1, etc. And
for us to safely advance i_disksize to 14k+1, I though all the folios (and
zeroed out tails) need to be written out. But that's actually not the case.
We need to make sure the zeroed tail is written out only if the underlying
block is already allocated and marked as written at the time of zeroing.
And the blocks underlying intermediate i_size values will never be allocated
and written without advancing i_disksize to them. So I think you're
correct, we always have at most one tail folio - the one surrounding
current i_disksize - which needs to be written out to safely advance
i_disksize and we don't care about folios inbetween.

> > When io_end processing happens after completed
> > folio writeback, we update i_disksize to min(i_size, end of IO).
> 
> Yeah, in the case of append write back. Assume we append write the folio 2
> and folio 3,
> 
>        old_idisksize  new_isize
>        |             |
>      [WWZZ][WWWW][WWWW]
>        1  |  2     3
>           A
> 
> Assume that folio 1 first completes the writeback, then we update i_disksize
> to pos A when the writeback is complete. Assume that folio 2 or 3 completes
> first, we should wait(e.g. call filemap_fdatawait_range_keep_errors() or
> something like) folio 1 to complete and then update i_disksize to new_isize.
> 
> But in the case of truncate up, We will only write back this zeroed folio. If
> the new i_size exceeds the end of this folio, how should we update i_disksize
> to the correct value?
> 
> For example, we truncate the file from old old_idisksize to new_isize, but we
> only zero and writeback folio 1, in the end_io processing of folio 1, we can
> only update the i_disksize to A, but we can never update it to new_isize. Am
> I missing something ?
> 
>        old_idisksize new_isize
>        |             |
>      [WWZZ]...hole ...
>        1  |
>           A

Good question. Based on the analysis above one option would be to setup
writeback of page straddling current i_disksize to update i_disksize to
current i_size on completion. That would be simple but would have an
unpleasant side effect that in case of a crash after append write we could
see increased i_disksize but zeros instead of written data. Another option
would be to update i_disksize on completion to the beginning of the first
dirty folio behind the written back range or i_size of there's not such
folio. This would still be relatively simple and mostly deal with "zeros
instead of data" problem.

> > This
> > should take care of non-zero data exposure issues and with "delay map"
> > processing Baokun works on all the inode metadata updates will happen after
> > IO completion anyway so it will be nicely batched up in one transaction.
> 
> Currently, my iomap convert implementation always enables dioread_nolock,

Yes, BTW I think you could remove no-dioread_nolock paths before doing the
conversion to simplify matters a bit. I don't think it's seriously used
anywhere anymore.

> so I feel that this solution can be achieved even without the "delay map"
> feature. After we have the "delay map", we can extend this to the
> buffer_head path.

I agree, delay map is not necessary for this to work. But it will make
things likely faster.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

