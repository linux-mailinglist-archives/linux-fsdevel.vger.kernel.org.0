Return-Path: <linux-fsdevel+bounces-76113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH5pNaMogWkxEgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:43:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E5D2606
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C727314A06A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230E389E1A;
	Mon,  2 Feb 2026 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss2zz3/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851635E548;
	Mon,  2 Feb 2026 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071648; cv=none; b=K2zb7T6v8hG2y+iiaHq98ZpmZehaQuGu/2RSw8vdkayzruqht8u/Mlplt11UuNWlA0ijnul0x90mon8BcfGPWNW6FIOh7I0IWCw72XSadyjmuE8LRULLQBmYw1KAT/cY0b0ZP/4pBz2c/mSIoh8ITHzEhtokdS8RocX+XPPJec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071648; c=relaxed/simple;
	bh=2BLw8V36q4ZcoZntEthTMAW+cHIrT5ib6z9TbOGuvgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMTelsopuhibCaM/2n+m1yyFSppWe7FrwmiU9SMxIX3zv9P44C3EUM612DlEtWNIYmA7beavNqECRl+b0GmYsXagFCDhg4/9xQwlnWosPa8es2TX5n1BUZsbY3UEQU9PFJLC8tpOhyErsZwd6Q6c6Lz46uecuAveOdW/A0kMAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss2zz3/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2840C116C6;
	Mon,  2 Feb 2026 22:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770071647;
	bh=2BLw8V36q4ZcoZntEthTMAW+cHIrT5ib6z9TbOGuvgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ss2zz3/zaUboc6X/2TuV+KFtnflhkrpnIr6d8/rxpr8ixW69zHo15BSkfX7C+GrrG
	 3dxxe8R18qUeUaWY6nisKn2wmrZy9dl4o1heG4kk/K8kzQwV31QMPww5ZQis+db3y1
	 sUNB3MzBBKSAX/TifSu+FMYAccP/HfGZvUCLqmtopz3b9AU+rS3GnhInsnw4q7GRNU
	 0qwPxcnVei484r2+HKkAN3+ed4bSRmzSErbAbjvNW8U/46uXtDcaJiilALdBmk+n+Z
	 EqNcbKlhmyF7FQNNK+sDUH/6bc91lQLmusrhVPXRnKkh41P6MBg+RtcfyL5f5q7jeX
	 20vZJrM+KKiLg==
Date: Mon, 2 Feb 2026 14:34:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: fsverity speedup and memory usage optimization v5
Message-ID: <20260202223404.GA173552@quark>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202211423.GB4838@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202211423.GB4838@quark>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76113-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D0E5D2606
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 01:14:23PM -0800, Eric Biggers wrote:
> On Mon, Feb 02, 2026 at 07:06:29AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series has a hodge podge of fsverity enhances that I looked into as
> > part of the review of the xfs fsverity support series.
> > 
> > The first part optimizes the fsverity read path by kicking off readahead
> > for the fsverity hashes from the data read submission context, which in my
> > simply testing showed huge benefits for sequential reads using dd.
> > I haven't been able to get fio to run on a preallocated fio file, but
> > I expect random read benefits would be significantly better than that
> > still.
> > 
> > The second part avoids the need for a pointer in every inode for fsverity
> > and instead uses a rhashtable lookup, which is done once per read_folio
> > or ->readahead invocation plus for btrfs only for each bio completion.
> > Right now this does not increse the number of inodes in
> > each slab, but for ext4 we are getting very close to that (within
> > 16 bytes by my count).
> > 
> > Changes since v5:
> >  - drop already merged patches
> >  - fix a bisection hazard for non-ENOENT error returns from
> >    generic_read_merkle_tree_page
> >  - don't recurse on invalidate_lock
> >  - refactor page_cache_ra_unbounded locking to support the above
> >  - refactor ext4 and f2fs fsverity readahead to remove the need for the
> >    first_folio branch in the main readpages loop
> 
> Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next
> 
> (Though it's getting late for v6.20 / v7.0.  So if there are any
> additional issues reported, I may have to drop it.)

Unfortunately this silently conflicts with changes in the f2fs tree.
Resolution doesn't look too bad, but we'll need to handle this.
Christoph, Jaegeuk, and Chao, let me know if this looks okay:

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9085d1236d97..081c441c59e71 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2449,11 +2449,13 @@ static void ffs_detach_free(struct folio *folio)
 	WARN_ON_ONCE(ffs->read_pages_pending != 0);
 	kmem_cache_free(ffs_entry_slab, ffs);
 }
 
 static int f2fs_read_data_large_folio(struct inode *inode,
-		struct readahead_control *rac, struct folio *folio)
+				      struct fsverity_info *vi,
+				      struct readahead_control *rac,
+				      struct folio *folio)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
 	struct f2fs_map_blocks map = {0, };
 	pgoff_t index, offset, next_pgofs = 0;
@@ -2519,13 +2521,12 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 				ret = -EFSCORRUPTED;
 				goto err_out;
 			}
 		} else {
 			folio_zero_range(folio, offset << PAGE_SHIFT, PAGE_SIZE);
-			if (f2fs_need_verity(inode, index) &&
-			    !fsverity_verify_page(folio_file_page(folio,
-								index))) {
+			if (vi && !fsverity_verify_page(
+					  vi, folio_file_page(folio, index))) {
 				ret = -EIO;
 				goto err_out;
 			}
 			continue;
 		}
@@ -2552,14 +2553,14 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 submit_and_realloc:
 			f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
 			bio = NULL;
 		}
 		if (bio == NULL)
-			bio = f2fs_grab_read_bio(inode, block_nr,
-					max_nr_pages,
-					f2fs_ra_op_flags(rac),
-					index, false);
+			bio = f2fs_grab_read_bio(inode, vi, block_nr,
+						 max_nr_pages,
+						 f2fs_ra_op_flags(rac), index,
+						 false);
 
 		/*
 		 * If the page is under writeback, we need to wait for
 		 * its completion to see the correct decrypted data.
 		 */
@@ -2627,11 +2628,11 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 	struct address_space *mapping = rac ? rac->mapping : folio->mapping;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
 
 	if (mapping_large_folio_support(mapping))
-		return f2fs_read_data_large_folio(inode, rac, folio);
+		return f2fs_read_data_large_folio(inode, vi, rac, folio);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
 		index = rac ? readahead_index(rac) : folio->index;
 		max_nr_pages = round_up(index + nr_pages, cc.cluster_size) -

