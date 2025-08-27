Return-Path: <linux-fsdevel+bounces-59401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63450B38669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30911894F98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A551E0E08;
	Wed, 27 Aug 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hNJ1gfKo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+n9khl2d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hNJ1gfKo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+n9khl2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772FD14F9FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308059; cv=none; b=la3jJ2elTBJaBufeK9LEqj26/pMvUBWi66P28hlH/tulXWzTCYLWmv5TixfZ5EUwc9ydu7TO9uAT0E8qeK/H3xqic9I0wSkWapsv0P8ePwD+xtZtvDRjWE+jd6utdkw5pNw4rj/226uWung6vhf8LoCXqhOr+q9slMRyMGEwvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308059; c=relaxed/simple;
	bh=2wuf/nHdFysBGBlr5kTnDgd5NgVKF4J69Lu6nnyta4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPRG1Bo3ljI4pG0X+paJxh/CtgcBXBK9oDbGuGGnfud5IKuLQgqjbsUlGrmqG+gDozxT7LU4RtU5Qh8ehnbqVOsRf1rZAYehjlfP5Mh99JnJ5WyV0bGQ67D5m2H8n5uQD6nzNtOprRbjgZXFydeQAkwQM2yBOVCT76UhJbqFw4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hNJ1gfKo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+n9khl2d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hNJ1gfKo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+n9khl2d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CAA122852;
	Wed, 27 Aug 2025 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756308054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIUV/rvBNFGtnWoz6AMDWcfQSNFQrImn3StxIXuCvcY=;
	b=hNJ1gfKoug0X+QSVF/LIxJImahP6cGP2oX6BEFPvhOy66hDhOSFMzY3/mrklfuOZBw3rR0
	8Q7i2eQvuocJdvvIRpw3XRyngoNwIWu0XGWWmKUMKx1mrnGdGIuJJ+TSwP/aFpuBMiVfa4
	vQKYj/VheBJKa4esq+8A86Z5mv/kG8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756308054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIUV/rvBNFGtnWoz6AMDWcfQSNFQrImn3StxIXuCvcY=;
	b=+n9khl2dkHFNup0m6p3/3gGv7KWesh/bRWwJuPsnjqWa8ULhrcERGZatAF2TLNOeHupMkt
	4XAt6SLUdlV4xoAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hNJ1gfKo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+n9khl2d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756308054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIUV/rvBNFGtnWoz6AMDWcfQSNFQrImn3StxIXuCvcY=;
	b=hNJ1gfKoug0X+QSVF/LIxJImahP6cGP2oX6BEFPvhOy66hDhOSFMzY3/mrklfuOZBw3rR0
	8Q7i2eQvuocJdvvIRpw3XRyngoNwIWu0XGWWmKUMKx1mrnGdGIuJJ+TSwP/aFpuBMiVfa4
	vQKYj/VheBJKa4esq+8A86Z5mv/kG8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756308054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIUV/rvBNFGtnWoz6AMDWcfQSNFQrImn3StxIXuCvcY=;
	b=+n9khl2dkHFNup0m6p3/3gGv7KWesh/bRWwJuPsnjqWa8ULhrcERGZatAF2TLNOeHupMkt
	4XAt6SLUdlV4xoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E1CF13867;
	Wed, 27 Aug 2025 15:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AunaGlYir2hiDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 Aug 2025 15:20:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84F96A0999; Wed, 27 Aug 2025 17:20:53 +0200 (CEST)
Date: Wed, 27 Aug 2025 17:20:53 +0200
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>, 
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk, 
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de, martin.petersen@oracle.com, 
	djwong@kernel.org, linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Jan Kara <jack@suse.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
 <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
 <aKx485EMthHfBWef@kbusch-mbp>
 <87cy8ir835.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="na3a25opjxispaux"
Content-Disposition: inline
In-Reply-To: <87cy8ir835.fsf@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9CAA122852
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.51


--na3a25opjxispaux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 26-08-25 10:29:58, Ritesh Harjani wrote:
> Keith Busch <kbusch@kernel.org> writes:
> 
> > On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
> >> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
> >> > Keith Busch <kbusch@meta.com> writes:
> >> > >
> >> > >   - EXT4 falls back to buffered io for writes but not for reads.
> >> > 
> >> > ++linux-ext4 to get any historical context behind why the difference of
> >> > behaviour in reads v/s writes for EXT4 DIO. 
> >> 
> >> Hum, how did you test? Because in the basic testing I did (with vanilla
> >> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
> >> falling back to buffered IO only if the underlying file itself does not
> >> support any kind of direct IO.
> >
> > Simple test case (dio-offset-test.c) below.
> >
> > I also ran this on vanilla kernel and got these results:
> >
> >   # mkfs.ext4 /dev/vda
> >   # mount /dev/vda /mnt/ext4/
> >   # make dio-offset-test
> >   # ./dio-offset-test /mnt/ext4/foobar
> >   write: Success
> >   read: Invalid argument
> >
> > I tracked the "write: Success" down to ext4's handling for the "special"
> > -ENOTBLK error after ext4_want_directio_fallback() returns "true".
> >
> 
> Right. Ext4 has fallback only for dio writes but not for DIO reads... 
> 
> buffered
> static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> {
> 	/* must be a directio to fall back to buffered */
> 	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> 		    (IOMAP_WRITE | IOMAP_DIRECT))
> 		return false;
> 
>     ...
> }
> 
> So basically the path is ext4_file_[read|write]_iter() -> iomap_dio_rw
>     -> iomap_dio_bio_iter() -> return -EINVAL. i.e. from...
> 
> 
> 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> 		return -EINVAL;
> 
> EXT4 then fallsback to buffered-io only for writes, but not for reads. 

Right. And the fallback for writes was actually inadvertedly "added" by
commit bc264fea0f6f "iomap: support incremental iomap_iter advances". That
changed the error handling logic. Previously if iomap_dio_bio_iter()
returned EINVAL, it got propagated to userspace regardless of what
->iomap_end() returned. After this commit if ->iomap_end() returns error
(which is ENOTBLK in ext4 case), it gets propagated to userspace instead of
the error returned by iomap_dio_bio_iter().

Now both the old and new behavior make some sense so I won't argue that the
new iomap_iter() behavior is wrong. But I think we should change ext4 back
to the old behavior of failing unaligned dio writes instead of them falling
back to buffered IO. I think something like the attached patch should do
the trick - it makes unaligned dio writes fail again while writes to holes
of indirect-block mapped files still correctly fall back to buffered IO.
Once fstests run completes, I'll do a proper submission...


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--na3a25opjxispaux
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-Fail-unaligned-direct-IO-write-with-EINVAL.patch"

From ce6da00a09647a03013c3f420c2e7ef7489c3de8 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 27 Aug 2025 14:55:19 +0200
Subject: [PATCH] ext4: Fail unaligned direct IO write with EINVAL

Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
changed the error handling logic in iomap_iter(). Previously any error
from iomap_dio_bio_iter() got propagated to userspace, after this commit
if ->iomap_end returns error, it gets propagated to userspace instead of
an error from iomap_dio_bio_iter(). This results in unaligned writes to
ext4 to silently fallback to buffered IO instead of erroring out.

Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
unnecessary these days. It is enough to return ENOTBLK from
ext4_iomap_begin() when we don't support DIO write for that particular
file offset (due to hole).

Fixes: bc264fea0f6f ("iomap: support incremental iomap_iter advances")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c  |  2 --
 fs/ext4/inode.c | 35 -----------------------------------
 2 files changed, 37 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 93240e35ee36..cf39f57d21e9 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -579,8 +579,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   dio_flags, NULL, 0);
-	if (ret == -ENOTBLK)
-		ret = 0;
 	if (extend) {
 		/*
 		 * We always perform extending DIO write synchronously so by
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..c3b23c90fd11 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3872,47 +3872,12 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
-{
-	/* must be a directio to fall back to buffered */
-	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
-		    (IOMAP_WRITE | IOMAP_DIRECT))
-		return false;
-
-	/* atomic writes are all-or-nothing */
-	if (flags & IOMAP_ATOMIC)
-		return false;
-
-	/* can only try again if we wrote nothing */
-	return written == 0;
-}
-
-static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
-			  ssize_t written, unsigned flags, struct iomap *iomap)
-{
-	/*
-	 * Check to see whether an error occurred while writing out the data to
-	 * the allocated blocks. If so, return the magic error code for
-	 * non-atomic write so that we fallback to buffered I/O and attempt to
-	 * complete the remainder of the I/O.
-	 * For non-atomic writes, any blocks that may have been
-	 * allocated in preparation for the direct I/O will be reused during
-	 * buffered I/O. For atomic write, we never fallback to buffered-io.
-	 */
-	if (ext4_want_directio_fallback(flags, written))
-		return -ENOTBLK;
-
-	return 0;
-}
-
 const struct iomap_ops ext4_iomap_ops = {
 	.iomap_begin		= ext4_iomap_begin,
-	.iomap_end		= ext4_iomap_end,
 };
 
 const struct iomap_ops ext4_iomap_overwrite_ops = {
 	.iomap_begin		= ext4_iomap_overwrite_begin,
-	.iomap_end		= ext4_iomap_end,
 };
 
 static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
-- 
2.43.0


--na3a25opjxispaux--

