Return-Path: <linux-fsdevel+bounces-54679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145EB0220F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA7A3B0551
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2492EF2BF;
	Fri, 11 Jul 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qk014Aog";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGbqJis1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bwX2k7F4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="txUHIri+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9141A4F12
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252133; cv=none; b=fBWQuDbwiH3jv4c6a7xjKXeKvIMlesvp+ymQKy7+kYyUvUPZWNsNAasH8x12il7m25IETXlLbj25h63vLYNe7+x5GcHqf9OU96FYh+5kflywy6F7Cw6oBc8eWJhK7N9tNOh8dk16cSW4hMES8sgLWdjVXApY8Pp2Gh0o0smvRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252133; c=relaxed/simple;
	bh=llpvCU+Ye+4Efa/Z1Ghg/p/oL9wDGSzc1XfCKF6Grjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUQGkdD7r9O+zMq2itw/v+XD5CfSaFxo8+n7D2CNMmppjMpkYugSrAd/KF5i0ARs8BzEoyiDqaf8Aib08Kev5l8+NUwsoxjFqA4QdNNRm8CEsTKJsJ8w6Bo7K0ONMPdTev0vuJfsQgGy5GQbcOrHxBH1JJD6Tu8qVNwG5a/HDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qk014Aog; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGbqJis1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bwX2k7F4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=txUHIri+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C47D1F451;
	Fri, 11 Jul 2025 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752252130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnLbYKRKFNofpGYhrrtYzrLsa9RrfDtLERsr9B1iH/E=;
	b=Qk014AogqNi7x12zQcZhqRXe8Y4e7QSQILi0SgTftKlRmKA0EsURdDlwMgEaQe8Uv/c/0d
	OeZl84qLmGk2HgLp9QS02h7onsG2dXAvbVM5FaQ6VrgTiFia4sV0Jscbq5aZkir0LssqIr
	fjTc5r2+rMyaSAdEzNbiw8zIQyv5Jgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752252130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnLbYKRKFNofpGYhrrtYzrLsa9RrfDtLERsr9B1iH/E=;
	b=qGbqJis16XxJexZPDNKMstX2DKgnnCGBk5uLxt7UUJiNurmgrl8rwEs4FeJFQLQJqJ54AV
	XbCcErBlcxGiAuCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752252129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnLbYKRKFNofpGYhrrtYzrLsa9RrfDtLERsr9B1iH/E=;
	b=bwX2k7F4OfcWUPB/XEObXTbsEaHG2pQXzFCW1xfcxnIhb9LnxGT+3c4yZ6jZb8cWDVuU7X
	dtv12J8xUn5RZptjqLewhTzJkkT6+hjyEZQKNzCo14hQ44B0qf3noDViX6EvmxBSvqsS4f
	NTjk+4krrxrmMvSbAm26NsM7UYq/vpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752252129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnLbYKRKFNofpGYhrrtYzrLsa9RrfDtLERsr9B1iH/E=;
	b=txUHIri+bNrjwqDYM0VUDvoMCSV29nLPHyYXE6MeCa0ONsOw2oOKtiRpdJwoxMK44577sT
	vi2bT0lhwUlulrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AC5513918;
	Fri, 11 Jul 2025 16:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id At9UDuE+cWiXfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Jul 2025 16:42:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E1769A099A; Fri, 11 Jul 2025 18:42:08 +0200 (CEST)
Date: Fri, 11 Jul 2025 18:42:08 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, anna.luese@v-bien.de, brauner@kernel.org, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, libaokun1@huawei.com, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, p.raghav@samsung.com, shaggy@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
Message-ID: <okx6a3ngonajh7jrzc65ybd4i6bcnkc7gm4mggyo3jlm6s2ojx@yy5jcipsnd3l>
References: <686a8143.a00a0220.c7b3.005b.GAE@google.com>
 <68710315.a00a0220.26a83e.004a.GAE@google.com>
 <gbzywhurs75yyg2uckcbi7qp7g4cx6tybridb4spts43jxj6gw@66ab5zymisgc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gbzywhurs75yyg2uckcbi7qp7g4cx6tybridb4spts43jxj6gw@66ab5zymisgc>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8396fd456733c122];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,suse.cz:email,appspotmail.com:email,goo.gl:url,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[01ef7a8da81a975e1ccd];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -5.30

On Fri 11-07-25 17:51:40, Jan Kara wrote:
> On Fri 11-07-25 05:27:01, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit 77eb64439ad52d8afb57bb4dae24a2743c68f50d
> > Author: Pankaj Raghav <p.raghav@samsung.com>
> > Date:   Thu Jun 26 11:32:23 2025 +0000
> > 
> >     fs/buffer: remove the min and max limit checks in __getblk_slow()
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127d8d82580000
> > start commit:   835244aba90d Add linux-next specific files for 20250709
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=117d8d82580000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=167d8d82580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8396fd456733c122
> > dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c40f0580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11856a8c580000
> > 
> > Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
> > Fixes: 77eb64439ad5 ("fs/buffer: remove the min and max limit checks in __getblk_slow()")
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Ah, I see what's going on here. The reproducer mounts ext4 filesystem and
> sets block size on loop0 loop device to 32k using LOOP_SET_BLOCK_SIZE. Now
> because there are multiple reproducer running using various loop devices it
> can happen that we're setting blocksize during mount which obviously
> confuses the filesystem (and makes sb mismatch the bdev block size). It is
> really not a good idea to allow setting block size (or capacity for that
> matter) underneath an exclusive opener. The ioctl should have required
> exclusive open from the start but now it's too late to change that so we
> need to perform a similar dance with bd_prepare_to_claim() as in
> loop_configure() to grab temporary exclusive access... Sigh.
> 
> Anyway, the commit 77eb64439ad5 is just a victim that switched KERN_ERR
> messages in the log to WARN_ON so syzbot started to notice this breakage.

Sent fix here:
https://lore.kernel.org/all/20250711163202.19623-2-jack@suse.cz

								Honza

#syz test

From 4aa776eb9b3967bff31087b7595ddcc902200056 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 11 Jul 2025 18:16:44 +0200
Subject: [PATCH] loop: Avoid updating block size under exclusive owner
X-Developer-Signature: v=1; a=openpgp-sha256; l=3277; i=jack@suse.cz;
 h=from:subject; bh=cdZuEh4Dk+/Xi2fTOZRQxovM+RzBRb1FW6MBEN4Icws=;
 b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGDIKbZq0xH0Ml+s1mUn/FXh44vuGfB7/6WemZT/fv/SJRXZ0
 +Oc9nYzGLAyMHAyyYoosqyMval+bZ9S1NVRDBmYQKxPIFAYuTgGYyJE37P+TzLkNtVn5K1Q9Umaq3T
 Vmcb4tyOvXYsYcLfHv9g9F9zVruARylmxL8Gx73a307cwFM9/kww0b8vqYHvX33H2TnVeYsO+NW0RF
 KsOmd0cUjl7aWW4kFO6cOtNdIZ/HrHijk2bAKdYZ1wwucvbN27p4kRvXZfMu06WeZyz/7+FrF/9270
 Ostl1ml45ORWBlp5amyvXZvl33u5tr76znST50+oRf0to8n2afbSZCK3Ris+7MjpqnMo+lK+Sf5s/+
 L65hUjq2EwOyugu3PAk1khb9cHXhXN6anJo32VfsI6N+MsSzMxh+4O86wRg/98EH3obLLcIX2wOjKu
 es+vb1lH1Gx6ctQVE7E7Ok87oA
X-Developer-Key: i=jack@suse.cz; a=openpgp;
 fpr=93C6099A142276A28BBE35D815BC833443038D8C

Syzbot came up with a reproducer where a loop device block size is
changed underneath a mounted filesystem. This causes a mismatch between
the block device block size and the block size stored in the superblock
causing confusion in various places such as fs/buffer.c. The particular
issue triggered by syzbot was a warning in __getblk_slow() due to
requested buffer size not matching block device block size.

Fix the problem by getting exclusive hold of the loop device to change
its block size. This fails if somebody (such as filesystem) has already
an exclusive ownership of the block device and thus prevents modifying
the loop device under some exclusive owner which doesn't expect it.

Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 500840e4a74e..5cc72770e253 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1432,17 +1432,34 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 	return 0;
 }
 
-static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
+static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
+			       struct block_device *bdev, unsigned long arg)
 {
 	struct queue_limits lim;
 	unsigned int memflags;
 	int err = 0;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
+	/*
+	 * If we don't hold exclusive handle for the device, upgrade to it
+	 * here to avoid changing device under exclusive owner.
+	 */
+	if (!(mode & BLK_OPEN_EXCL)) {
+		err = bd_prepare_to_claim(bdev, loop_set_block_size, NULL);
+		if (err)
+			return err;
+	}
+
+	err = mutex_lock_killable(&lo->lo_mutex);
+	if (err)
+		goto abort_claim;
+
+	if (lo->lo_state != Lo_bound) {
+		err = -ENXIO;
+		goto unlock;
+	}
 
 	if (lo->lo_queue->limits.logical_block_size == arg)
-		return 0;
+		goto unlock;
 
 	sync_blockdev(lo->lo_device);
 	invalidate_bdev(lo->lo_device);
@@ -1455,6 +1472,11 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 
+unlock:
+	mutex_unlock(&lo->lo_mutex);
+abort_claim:
+	if (!(mode & BLK_OPEN_EXCL))
+		bd_abort_claiming(bdev, loop_set_block_size);
 	return err;
 }
 
@@ -1473,9 +1495,6 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 	case LOOP_SET_DIRECT_IO:
 		err = loop_set_dio(lo, arg);
 		break;
-	case LOOP_SET_BLOCK_SIZE:
-		err = loop_set_block_size(lo, arg);
-		break;
 	default:
 		err = -EINVAL;
 	}
@@ -1530,9 +1549,12 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
 		break;
 	case LOOP_GET_STATUS64:
 		return loop_get_status64(lo, argp);
+	case LOOP_SET_BLOCK_SIZE:
+		if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		return loop_set_block_size(lo, mode, bdev, arg);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
-	case LOOP_SET_BLOCK_SIZE:
 		if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		fallthrough;
-- 
2.43.0


