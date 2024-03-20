Return-Path: <linux-fsdevel+bounces-14904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED8881438
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4DB1F2245F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D74EB58;
	Wed, 20 Mar 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyTLkyOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB44B5DA;
	Wed, 20 Mar 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947485; cv=none; b=Q8ylK6kchRR8YkxoGGNa/dZQtqOrR3c7vDlDMo3bKYqLaWo5nDQ4jBiB6pRWr253wqooYUVBNLwsQ2vcMa6sMzvrQKfUzb8S8vfTyWnJIQZIQ1g0IvP6VITx08nGA5brGvkRDZ6+omfHTu4HTEU5rKK/thNN0ga+zgDwYcJkztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947485; c=relaxed/simple;
	bh=TtctzNyS3G8Gx5a7+J8acJckej5yJef4bZFp9lCKimA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQMVlkD/IJn1/tHzYfC/6pJKTxKgSuUhz+GLml4u4AQZOOnCgZdmnLHL1HqFu+FaPU3mkLtkX7ls1V8IdC9U6l1csS8MNHPLXV9YLe/CIDCdwZkUJL1AchPHX53N7/TaA1AC//M4KOxlVPmSIPW1SH5Gs2JXyjqjLLee0M9ekcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyTLkyOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E8FC433F1;
	Wed, 20 Mar 2024 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710947483;
	bh=TtctzNyS3G8Gx5a7+J8acJckej5yJef4bZFp9lCKimA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyTLkyOS1EkdPvOCNpe7qzJPVKT6t4UAcxva3K/gTGhFKufO79PqDLzOjJ+K8PkGK
	 AaPCVC7ztWXOz62T7pR3hAu6iE3Vmn22jwAlQnTltK6940Q+3+euoX5zA5xD1/9Uvc
	 rzSHrjMbCOW6xfrR7H6b/J+wkytGHeKe2L/PWcpw1ueuvFbJft1ZVms1liy5YyRV/G
	 ZiFTwK2qMNC2Y4TPsVMHmCZ6yo/skZyh8BGCsmD1Bro2tmU944k9+yPX/y2CRE4CnG
	 cufQ27ZvYN5fZWAnvNfee7FkpZUrCtV1gImLgrlU3nSqG73JjqD1t5nxNYxzzz7099
	 t9rH4qZn+8y/w==
Date: Wed, 20 Mar 2024 08:11:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, mark.tinguely@oracle.com
Subject: Re: [PATCHSET v5.3] fs-verity support for XFS
Message-ID: <20240320151122.GZ1927156@frogsfrogsfrogs>
References: <20240317161954.GC1927156@frogsfrogsfrogs>
 <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <20240318163512.GB1185@sol.localdomain>
 <20240319220743.GF6226@frogsfrogsfrogs>
 <20240319232118.GU1927156@frogsfrogsfrogs>
 <7ov4snchmjuh6an7cwredibanjjd6zvwcwyic6un6lafjt5e3i@kgt75bq3q56t>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ov4snchmjuh6an7cwredibanjjd6zvwcwyic6un6lafjt5e3i@kgt75bq3q56t>

On Wed, Mar 20, 2024 at 11:16:01AM +0100, Andrey Albershteyn wrote:
> On 2024-03-19 16:21:18, Darrick J. Wong wrote:
> > [fix tinguely email addr]
> > 
> > On Tue, Mar 19, 2024 at 03:07:43PM -0700, Darrick J. Wong wrote:
> > > On Mon, Mar 18, 2024 at 09:35:12AM -0700, Eric Biggers wrote:
> > > > On Sun, Mar 17, 2024 at 09:22:52AM -0700, Darrick J. Wong wrote:
> > > > > Hi all,
> > > > > 
> > > > > From Darrick J. Wong:
> > > > > 
> > > > > This v5.3 patchset builds upon v5.2 of Andrey's patchset to implement
> > > > > fsverity for XFS.
> > > > 
> > > > Is this ready for me to review, or is my feedback on v5 still being
> > > > worked on?
> > > 
> > > It's still being worked on.  I figured it was time to push my work tree
> > > back to Andrey so everyone could see the results of me attempting to
> > > understand the fsverity patchset by working around in the codebase.
> > > 
> > > From your perspective, I suspect the most interesting patches will be 5,
> > > 6, 7+10+14, 11-13, and 15-17.  For everyone on the XFS side, patches
> > > 27-39 are the most interesting since they change the caching strategy
> > > and slim down the ondisk format.
> > > 
> > > > From a quick glance, not everything from my feedback has been
> > > > addressed.
> > > 
> > > That's correct.  I cleaned up the mechanics of passing merkle trees
> > > around, but I didn't address the comments about per-sb workqueues,
> > > fsverity tracepoints, or whether or not iomap should allocate biosets.
> > 
> > That perhaps wasn't quite clear enough -- I'm curious to see what Andrey
> > has to say about that part (patches 8, 9, 18) of the patchset.
> 
> The per-sb workqueue can be used for other fs, which should be
> doable (also I will rename it, as generic name came from the v2 when
> I thought it would be used for more stuff than just verity)

<nod>

> For tracepoints, I will add all the changes suggested by Eric, the
> signature tracepoints could be probably dropped.

I hacked up a bunch of tracepoint changes which I've attached below.
Note the use of print_hex_str so that the digest comes out like:

a0fcdf17f6d49b47

instead of

a0 fc df 17 f6 d4 9b 47

So that it's an exact match for what the fsverity tool emits.  I also
turned the _ASCEND and _DESCEND trace arguments into separate
tracepoints.

Also, if you ever want to have a tracepoint that stores an int value but
turns that into a string in TP_printk, you should use __print_symbolic
and not open-code the logic.  For bitflags, it's __print_flags.  None of
that is documented anywhere.

> For bioset allocation, I will look into this if there's good way to
> allocate only for verity inodes, if it's not complicate things too
> much. Make sense for systems which won't use fsverity but have
> FS_VERITY=y.

I'd imagine it's more or less a clone of sb_init_dio_done_wq that can be
called from iomap_read_bio_alloc when
(fsverity_active() && !sb->s_read_done_wq).

Something I just noticed -- shouldn't we be calling verity from
iomap_read_folio_sync as well?

--D

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 06b769dd1bdf1..8c6fe4b72b14e 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -232,7 +232,7 @@ static int enable_verity(struct file *filp,
 	if (err)
 		goto out;
 
-	trace_fsverity_enable(inode, desc, &params);
+	trace_fsverity_enable(inode, &params);
 
 	/*
 	 * Start enabling verity on this file, serialized by the inode lock.
@@ -263,7 +263,6 @@ static int enable_verity(struct file *filp,
 		fsverity_err(inode, "Error %d building Merkle tree", err);
 		goto rollback;
 	}
-	trace_fsverity_tree_done(inode, desc, &params);
 
 	/*
 	 * Create the fsverity_info.  Don't bother trying to save work by
@@ -278,6 +277,8 @@ static int enable_verity(struct file *filp,
 		goto rollback;
 	}
 
+	trace_fsverity_tree_done(inode, vi, &params);
+
 	/*
 	 * Tell the filesystem to finish enabling verity on the file.
 	 * Serialized with ->begin_enable_verity() by the inode lock.
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index c1f08bb32ed1f..90c07573dd77b 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -53,8 +53,6 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 	struct fsverity_formatted_digest *d;
 	int err;
 
-	trace_fsverity_verify_signature(inode, signature, sig_size);
-
 	if (sig_size == 0) {
 		if (fsverity_require_signatures) {
 			fsverity_err(inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 0782e94bc818d..a6aa0d0556744 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -122,7 +122,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Byte offset of the wanted hash relative to @addr */
 		unsigned int hoffset;
 	} hblocks[FS_VERITY_MAX_LEVELS];
-	trace_fsverity_verify_block(inode, data_pos);
+
+	trace_fsverity_verify_data_block(inode, params, data_pos);
+
 	/*
 	 * The index of the previous level's block within that level; also the
 	 * index of that block's hash within the current level.
@@ -195,8 +197,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		if (is_hash_block_verified(inode, block, hblock_idx)) {
 			memcpy(_want_hash, block->kaddr + hoffset, hsize);
 			want_hash = _want_hash;
-			trace_fsverity_merkle_tree_block_verified(inode,
-					block, FSVERITY_TRACE_DIR_ASCEND);
+			trace_fsverity_merkle_hit(inode, data_pos, hblock_pos,
+					level,
+					hoffset >> params->log_digestsize);
 			fsverity_drop_merkle_tree_block(inode, block);
 			goto descend;
 		}
@@ -231,8 +234,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			SetPageChecked((struct page *)block->context);
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
-		trace_fsverity_merkle_tree_block_verified(inode, block,
-				FSVERITY_TRACE_DIR_DESCEND);
+		trace_fsverity_verify_merkle_block(inode, block->offset,
+				level, hoffset >> params->log_digestsize);
 		fsverity_drop_merkle_tree_block(inode, block);
 	}
 
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
index 1a6ee2a2c3ce2..f08d3eb3368f3 100644
--- a/include/trace/events/fsverity.h
+++ b/include/trace/events/fsverity.h
@@ -11,14 +11,10 @@ struct fsverity_descriptor;
 struct merkle_tree_params;
 struct fsverity_info;
 
-#define FSVERITY_TRACE_DIR_ASCEND	(1ul << 0)
-#define FSVERITY_TRACE_DIR_DESCEND	(1ul << 1)
-#define FSVERITY_HASH_SHOWN_LEN		20
-
 TRACE_EVENT(fsverity_enable,
-	TP_PROTO(struct inode *inode, struct fsverity_descriptor *desc,
-		struct merkle_tree_params *params),
-	TP_ARGS(inode, desc, params),
+	TP_PROTO(const struct inode *inode,
+		 const struct merkle_tree_params *params),
+	TP_ARGS(inode, params),
 	TP_STRUCT__entry(
 		__field(ino_t, ino)
 		__field(u64, data_size)
@@ -28,7 +24,7 @@ TRACE_EVENT(fsverity_enable,
 	),
 	TP_fast_assign(
 		__entry->ino = inode->i_ino;
-		__entry->data_size = desc->data_size;
+		__entry->data_size = i_size_read(inode);
 		__entry->block_size = params->block_size;
 		__entry->num_levels = params->num_levels;
 		__entry->tree_size = params->tree_size;
@@ -42,118 +38,102 @@ TRACE_EVENT(fsverity_enable,
 );
 
 TRACE_EVENT(fsverity_tree_done,
-	TP_PROTO(struct inode *inode, struct fsverity_descriptor *desc,
-		struct merkle_tree_params *params),
-	TP_ARGS(inode, desc, params),
+	TP_PROTO(const struct inode *inode, const struct fsverity_info *vi,
+		 const struct merkle_tree_params *params),
+	TP_ARGS(inode, vi, params),
 	TP_STRUCT__entry(
 		__field(ino_t, ino)
 		__field(unsigned int, levels)
-		__field(unsigned int, tree_blocks)
+		__field(unsigned int, block_size)
 		__field(u64, tree_size)
-		__array(u8, tree_hash, 64)
+		__dynamic_array(u8, root_hash, params->digest_size)
+		__dynamic_array(u8, file_digest, params->digest_size)
 	),
 	TP_fast_assign(
 		__entry->ino = inode->i_ino;
 		__entry->levels = params->num_levels;
-		__entry->tree_blocks =
-			params->tree_size >> params->log_blocksize;
+		__entry->block_size = params->block_size;
 		__entry->tree_size = params->tree_size;
-		memcpy(__entry->tree_hash, desc->root_hash, 64);
+		memcpy(__get_dynamic_array(root_hash), vi->root_hash, __get_dynamic_array_len(root_hash));
+		memcpy(__get_dynamic_array(file_digest), vi->file_digest, __get_dynamic_array_len(file_digest));
 	),
-	TP_printk("ino %lu levels %d tree_blocks %d tree_size %lld root_hash %s",
+	TP_printk("ino %lu levels %d block_size %d tree_size %lld root_hash %s digest %s",
 		(unsigned long) __entry->ino,
 		__entry->levels,
-		__entry->tree_blocks,
+		__entry->block_size,
 		__entry->tree_size,
-		__print_hex(__entry->tree_hash, 64))
+		__print_hex_str(__get_dynamic_array(root_hash), __get_dynamic_array_len(root_hash)),
+		__print_hex_str(__get_dynamic_array(file_digest), __get_dynamic_array_len(file_digest)))
 );
 
-TRACE_EVENT(fsverity_verify_block,
-	TP_PROTO(struct inode *inode, u64 offset),
-	TP_ARGS(inode, offset),
+TRACE_EVENT(fsverity_verify_data_block,
+	TP_PROTO(const struct inode *inode,
+		 const struct merkle_tree_params *params,
+		 u64 data_pos),
+	TP_ARGS(inode, params, data_pos),
 	TP_STRUCT__entry(
 		__field(ino_t, ino)
-		__field(u64, offset)
+		__field(u64, data_pos)
 		__field(unsigned int, block_size)
 	),
 	TP_fast_assign(
 		__entry->ino = inode->i_ino;
-		__entry->offset = offset;
-		__entry->block_size =
-			inode->i_verity_info->tree_params.block_size;
+		__entry->data_pos = data_pos;
+		__entry->block_size = params->block_size;
 	),
-	TP_printk("ino %lu data offset %lld data block size %u",
+	TP_printk("ino %lu pos %lld merkle_blocksize %u",
 		(unsigned long) __entry->ino,
-		__entry->offset,
+		__entry->data_pos,
 		__entry->block_size)
 );
 
-TRACE_EVENT(fsverity_merkle_tree_block_verified,
-	TP_PROTO(struct inode *inode,
-		 struct fsverity_blockbuf *block,
-		 u8 direction),
-	TP_ARGS(inode, block, direction),
+TRACE_EVENT(fsverity_merkle_hit,
+	TP_PROTO(const struct inode *inode, u64 data_pos, u64 merkle_pos,
+		 unsigned int level, unsigned int hidx),
+	TP_ARGS(inode, data_pos, merkle_pos, level, hidx),
 	TP_STRUCT__entry(
 		__field(ino_t, ino)
-		__field(u64, offset)
-		__field(u8, direction)
+		__field(u64, data_pos)
+		__field(u64, merkle_pos)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
 	),
 	TP_fast_assign(
 		__entry->ino = inode->i_ino;
-		__entry->offset = block->offset;
-		__entry->direction = direction;
+		__entry->data_pos = data_pos;
+		__entry->merkle_pos = merkle_pos;
+		__entry->level = level;
+		__entry->hidx = hidx;
 	),
-	TP_printk("ino %lu block offset %llu %s",
+	TP_printk("ino %lu data_pos %llu merkle_pos %llu level %u hidx %u",
 		(unsigned long) __entry->ino,
-		__entry->offset,
-		__entry->direction == 0 ? "ascend" : "descend")
+		__entry->data_pos,
+		__entry->merkle_pos,
+		__entry->level,
+		__entry->hidx)
 );
 
-TRACE_EVENT(fsverity_read_merkle_tree_block,
-	TP_PROTO(struct inode *inode, u64 offset, unsigned int log_blocksize),
-	TP_ARGS(inode, offset, log_blocksize),
+TRACE_EVENT(fsverity_verify_merkle_block,
+	TP_PROTO(const struct inode *inode, u64 merkle_pos, unsigned int level,
+		unsigned int hidx),
+	TP_ARGS(inode, merkle_pos, level, hidx),
 	TP_STRUCT__entry(
 		__field(ino_t, ino)
-		__field(u64, offset)
-		__field(u64, index)
-		__field(unsigned int, block_size)
-	),
-	TP_fast_assign(
-		__entry->ino = inode->i_ino;
-		__entry->offset = offset;
-		__entry->index = offset >> log_blocksize;
-		__entry->block_size = 1 << log_blocksize;
-	),
-	TP_printk("ino %lu tree offset %llu block index %llu block hize %u",
-		(unsigned long) __entry->ino,
-		__entry->offset,
-		__entry->index,
-		__entry->block_size)
-);
-
-TRACE_EVENT(fsverity_verify_signature,
-	TP_PROTO(const struct inode *inode, const u8 *signature, size_t sig_size),
-	TP_ARGS(inode, signature, sig_size),
-	TP_STRUCT__entry(
-		__field(ino_t, ino)
-		__dynamic_array(u8, signature, sig_size)
-		__field(size_t, sig_size)
-		__field(size_t, sig_size_show)
+		__field(u64, merkle_pos)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
 	),
 	TP_fast_assign(
 		__entry->ino = inode->i_ino;
-		memcpy(__get_dynamic_array(signature), signature, sig_size);
-		__entry->sig_size = sig_size;
-		__entry->sig_size_show = (sig_size > FSVERITY_HASH_SHOWN_LEN ?
-			FSVERITY_HASH_SHOWN_LEN : sig_size);
+		__entry->merkle_pos = merkle_pos;
+		__entry->level = level;
+		__entry->hidx = hidx;
 	),
-	TP_printk("ino %lu sig_size %zu %s%s%s",
+	TP_printk("ino %lu merkle_pos %llu level %u hidx %u",
 		(unsigned long) __entry->ino,
-		__entry->sig_size,
-		(__entry->sig_size ? "sig " : ""),
-		__print_hex(__get_dynamic_array(signature),
-			__entry->sig_size_show),
-		(__entry->sig_size ? "..." : ""))
+		__entry->merkle_pos,
+		__entry->level,
+		__entry->hidx)
 );
 
 #endif /* _TRACE_FSVERITY_H */

