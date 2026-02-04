Return-Path: <linux-fsdevel+bounces-76337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DBLBs6Bg2llowMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:28:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 749B5EAFB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA193018D67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4134A76B;
	Wed,  4 Feb 2026 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g7WtGYmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D933B945;
	Wed,  4 Feb 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226112; cv=none; b=eXaSQALTEKpJ5Q1ZApFEIGs9EbtuOIKs9BeaSECJ5KfEXo+v0jUfTrANWj4lWcKw6wNK6ASPZrVYpDQ+XOy7XLxjpRW3iytYjC26ZolKA5To58slpjFprIjRAZbJfDuB3oPK1kbkTaibmH4PIS/35XxVRUONm15pIQfmLZIdLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226112; c=relaxed/simple;
	bh=/XuDigISEYyXbKnYAX5EnrMu7ypYv78O0Ukpa0tR+sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8FAbXKRu9YH9Cv5nEIYEYyD0betGJpyMTa81FjDJAHyHaJSkT+sI9fnJ4N+I5/i45ZwP35LW5Jw6cg7bLzCnf7IR+hywO47oBWdp1rhfllXBxRMaAt5VgEl5kk3IhUKLd8Y7bHGcgk3Pc8mrfDhgN1Mc7aFWL/KM4SL2XuWjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g7WtGYmf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HaUbfm56WW9dmRAs9z6HKJz16Yc0+vv/NXHXc38tkeU=; b=g7WtGYmfk9+norJJumdhkvulFc
	Mx9OvNf8EJGLlcZ3wocbrS8vzq7XbuENIF34BZ/O49Lbte+ROl/9qfFMZuH7njQMD4Dqo0HagfRqL
	4EFS8FxdgiaVmloZd+G5BfqZxUXpvD/uxSu81A4T23muljoOO8UKKaTj/2F59ah6uxv9w5pShZaZJ
	aFfHfAW5mFli/HiW01autxBDGeyqkFI0FJIFkzb+jRmLl4KGITzQ45UPP0DlCg5c22yrPfYfz3onF
	uSKAuhmLVPlC0MzLQU8hNDuphkBX5RzIXJ+ipztKV9baW1/XCAM42S8mENWvijOvXVzRadrlfdekz
	CVmZrrhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vnghx-00000005GVg-24fC;
	Wed, 04 Feb 2026 17:30:29 +0000
Date: Wed, 4 Feb 2026 17:30:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
	"jack@suse.cz" <jack@suse.cz>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"janak@mpiricsoftware.com" <janak@mpiricsoftware.com>,
	"syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com" <syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
Message-ID: <20260204173029.GL3183987@ZenIV>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
 <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
 <20260203043806.GF3183987@ZenIV>
 <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9374ab2503627e0dd6f62a29ab5dcde9fc0354f.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76337-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vivo.com,kernel.org,vger.kernel.org,dubeyko.com,mpiricsoftware.com,physik.fu-berlin.de,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 749B5EAFB4
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 11:35:18PM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2026-02-03 at 04:38 +0000, Al Viro wrote:
> > On Mon, Feb 02, 2026 at 05:53:57PM +0000, Viacheslav Dubeyko wrote:
> > > >  out_unload_nls:
> > > > -	unload_nls(sbi->nls);
> > 	^^^^^^^^^^^^^^^^^^^^
> > > >  	unload_nls(nls);
> > > > -	kfree(sbi);
> > 
> > > The patch [1] fixes the issue and it in HFS/HFS+ tree already.
> > 
> > AFAICS, [1] lacks this removal of unload_nls() on failure exit.
> > IOW, the variant in your tree does unload_nls(sbi->nls) twice...
> 
> Yeah, I think you are right here.

While we are at it, this
        kfree(sbi->s_vhdr_buf);
	kfree(sbi->s_backup_vhdr_buf);
might as well go into ->kill_sb().  That would result in the (untested)
delta below and IMO it's easier to follow that way...


diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 592d8fbb748c..6ce4d121e446 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -348,8 +348,6 @@ static void hfsplus_put_super(struct super_block *sb)
 	hfs_btree_close(sbi->attr_tree);
 	hfs_btree_close(sbi->cat_tree);
 	hfs_btree_close(sbi->ext_tree);
-	kfree(sbi->s_vhdr_buf);
-	kfree(sbi->s_backup_vhdr_buf);
 	hfs_dbg("finished\n");
 }
 
@@ -471,7 +469,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (be16_to_cpu(vhdr->version) < HFSPLUS_MIN_VERSION ||
 	    be16_to_cpu(vhdr->version) > HFSPLUS_CURRENT_VERSION) {
 		pr_err("wrong filesystem version\n");
-		goto out_free_vhdr;
+		goto out_unload_nls;
 	}
 	sbi->total_blocks = be32_to_cpu(vhdr->total_blocks);
 	sbi->free_blocks = be32_to_cpu(vhdr->free_blocks);
@@ -495,7 +493,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	if ((last_fs_block > (sector_t)(~0ULL) >> (sbi->alloc_blksz_shift - 9)) ||
 	    (last_fs_page > (pgoff_t)(~0ULL))) {
 		pr_err("filesystem size too large\n");
-		goto out_free_vhdr;
+		goto out_unload_nls;
 	}
 
 	/* Set up operations so we can load metadata */
@@ -522,7 +520,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->ext_tree = hfs_btree_open(sb, HFSPLUS_EXT_CNID);
 	if (!sbi->ext_tree) {
 		pr_err("failed to load extents file\n");
-		goto out_free_vhdr;
+		goto out_unload_nls;
 	}
 	sbi->cat_tree = hfs_btree_open(sb, HFSPLUS_CAT_CNID);
 	if (!sbi->cat_tree) {
@@ -648,9 +646,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	hfs_btree_close(sbi->cat_tree);
 out_close_ext_tree:
 	hfs_btree_close(sbi->ext_tree);
-out_free_vhdr:
-	kfree(sbi->s_vhdr_buf);
-	kfree(sbi->s_backup_vhdr_buf);
 out_unload_nls:
 	unload_nls(nls);
 	return err;
@@ -716,6 +711,8 @@ static void hfsplus_kill_super(struct super_block *sb)
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 
 	kill_block_super(sb);
+	kfree(sbi->s_vhdr_buf);
+	kfree(sbi->s_backup_vhdr_buf);
 	call_rcu(&sbi->rcu, delayed_free);
 }
 
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 30cf4fe78b3d..8e4dcc83af30 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -139,32 +139,29 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	u32 blocksize;
 	int error = 0;
 
-	error = -EINVAL;
 	blocksize = sb_min_blocksize(sb, HFSPLUS_SECTOR_SIZE);
 	if (!blocksize)
-		goto out;
+		return -EINVAL;
 
 	sbi->min_io_size = blocksize;
 
 	if (hfsplus_get_last_session(sb, &part_start, &part_size))
-		goto out;
+		return -EINVAL;
 
-	error = -ENOMEM;
 	sbi->s_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
 	if (!sbi->s_vhdr_buf)
-		goto out;
+		return -ENOMEM;
 	sbi->s_backup_vhdr_buf = kmalloc(hfsplus_min_io_size(sb), GFP_KERNEL);
 	if (!sbi->s_backup_vhdr_buf)
-		goto out_free_vhdr;
+		return -ENOMEM;
 
 reread:
 	error = hfsplus_submit_bio(sb, part_start + HFSPLUS_VOLHEAD_SECTOR,
 				   sbi->s_vhdr_buf, (void **)&sbi->s_vhdr,
 				   REQ_OP_READ);
 	if (error)
-		goto out_free_backup_vhdr;
+		return error;
 
-	error = -EINVAL;
 	switch (sbi->s_vhdr->signature) {
 	case cpu_to_be16(HFSPLUS_VOLHEAD_SIGX):
 		set_bit(HFSPLUS_SB_HFSX, &sbi->flags);
@@ -194,12 +191,11 @@ int hfsplus_read_wrapper(struct super_block *sb)
 				   sbi->s_backup_vhdr_buf,
 				   (void **)&sbi->s_backup_vhdr, REQ_OP_READ);
 	if (error)
-		goto out_free_backup_vhdr;
+		return error;
 
-	error = -EINVAL;
 	if (sbi->s_backup_vhdr->signature != sbi->s_vhdr->signature) {
 		pr_warn("invalid secondary volume header\n");
-		goto out_free_backup_vhdr;
+		return -EINVAL;
 	}
 
 	blocksize = be32_to_cpu(sbi->s_vhdr->blocksize);
@@ -221,7 +217,7 @@ int hfsplus_read_wrapper(struct super_block *sb)
 
 	if (sb_set_blocksize(sb, blocksize) != blocksize) {
 		pr_err("unable to set blocksize to %u!\n", blocksize);
-		goto out_free_backup_vhdr;
+		return -EINVAL;
 	}
 
 	sbi->blockoffset =
@@ -230,11 +226,4 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	sbi->sect_count = part_size;
 	sbi->fs_shift = sbi->alloc_blksz_shift - sb->s_blocksize_bits;
 	return 0;
-
-out_free_backup_vhdr:
-	kfree(sbi->s_backup_vhdr_buf);
-out_free_vhdr:
-	kfree(sbi->s_vhdr_buf);
-out:
-	return error;
 }

