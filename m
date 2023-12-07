Return-Path: <linux-fsdevel+bounces-5134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE5808599
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7064C1C21574
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69037D13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 10:34:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E2D57;
	Thu,  7 Dec 2023 00:58:34 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C615D1F897;
	Thu,  7 Dec 2023 08:58:31 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B666513907;
	Thu,  7 Dec 2023 08:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id H0k9LDeJcWUKOgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 07 Dec 2023 08:58:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 46621A07C7; Thu,  7 Dec 2023 09:58:31 +0100 (CET)
Date: Thu, 7 Dec 2023 09:58:31 +0100
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <20231207085831.udom5ozzsdqucxzm@quack3>
References: <ZWpntZXm32kyfX7M@dread.disaster.area>
 <87fs0gisi5.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs0gisi5.fsf@doe.com>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.89 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,fromorbit.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 15.89
X-Rspamd-Queue-Id: C615D1F897
X-Spam: Yes

On Tue 05-12-23 20:52:26, Ritesh Harjani wrote:
> Dave Chinner <david@fromorbit.com> writes:
> >>  static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
> >>  				 struct inode *inode, loff_t offset)
> >>  {
> >> -	if (offset >= wpc->iomap.offset &&
> >> -	    offset < wpc->iomap.offset + wpc->iomap.length)
> >> +	loff_t maxblocks = (loff_t)INT_MAX;
> >> +	u8 blkbits = inode->i_blkbits;
> >> +	u32 bno;
> >> +	bool new, boundary;
> >> +	int ret;
> >> +
> >> +	if (ext2_imap_valid(wpc, inode, offset))
> >>  		return 0;
> >>  
> >> -	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
> >> +	EXT2_WPC(wpc)->ib_seq = READ_ONCE(EXT2_I(inode)->ib_seq);
> >> +
> >> +	ret = ext2_get_blocks(inode, offset >> blkbits, maxblocks << blkbits,
> >> +			      &bno, &new, &boundary, 0);
> >
> > This is incorrectly ordered. ext2_get_blocks() bumps ib_seq when it
> > does allocation, so the newly stored EXT2_WPC(wpc)->ib_seq is
> > immediately staled and the very next call to ext2_imap_valid() will
> > fail, causing a new iomap to be mapped even when not necessary.
> 
> In case of ext2 here, the allocation happens at the write time itself
> for buffered writes. So what we are essentially doing here (at the time
> of writeback) is querying ->get_blocks(..., create=0) and passing those
> no. of blocks (ret) further. So it is unlikely that the block
> allocations will happen right after we sample ib_seq
> (unless we race with truncate).
> 
> For mmapped writes, we expect to find a hole and in case of a hole at
> the offset, we only pass & cache 1 block in wpc. 
> 
> For mmapped writes case since we go and allocate 1 block, so I agree
> that the ib_seq will change right after in ->get_blocks. But since in
> this case we only alloc and cache 1 block, we anyway will have to call
> ->get_blocks irrespective of ib_seq checking.

I agree with your reasoning Ritesh but I guess it would deserve a comment
because it is a bit subtle and easily forgotten detail.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

