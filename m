Return-Path: <linux-fsdevel+bounces-56795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EACAB1BBBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 23:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B4118416E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22623F295;
	Tue,  5 Aug 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="iK3sdzLh";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="plA49Oae";
	dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="sqyw8XdC";
	dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b="Ti1aaDKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tnxip.de (mail.tnxip.de [49.12.77.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1C23A98E;
	Tue,  5 Aug 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.77.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428785; cv=none; b=K6uYxTgyeKcotRTRtbG/nFhnCTarZFqfXVdTvhQka4hmHnvDUTc2hSiRytlmIXXQNFEGrp0b0Ly+mLltdaevPJP2BkvdkOdWjRJUGrQpQUh6AO0FMi1zzQfuoSb3y7505JP3OHCj74aBp1Y0NW3Lb0cal07u7QdHnzpOflMnHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428785; c=relaxed/simple;
	bh=eGNhxf4Hre4TgsWNUVNHLFULnTqhE/8QiTb+q6H69Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jvv5k3djSJKVtdkZ/PdkjMOaZfcm1CWAfGwGrwcxgfGEFAjNMqvBEpx6inbyBl/+hzql2DKLvnOPDfRwvm2ziRAB3M6DrTeghyRvq8/Z6z+OV3r1EOX+EqsTEqG3rwKdfct1EsCanp9OSIn+74TcmEdKW96IkpXFWe9o4jviBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de; spf=pass smtp.mailfrom=tnxip.de; dkim=pass (1024-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=iK3sdzLh; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=plA49Oae; dkim=permerror (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=sqyw8XdC; dkim=neutral (0-bit key) header.d=tnxip.de header.i=@tnxip.de header.b=Ti1aaDKK; arc=none smtp.client-ip=49.12.77.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tnxip.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnxip.de
Received: from gw.tnxip.de (unknown [IPv6:fdc7:1cc3:ec03:1:4b6d:2733:db63:990b])
	by mail.tnxip.de (Postfix) with ESMTPS id DA9A31F58F;
	Tue, 05 Aug 2025 23:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-vps;
	t=1754428776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GydoA6fhSfORm8uTQ8KX9X1f9IeS0fBjHtrwZicRmNo=;
	b=iK3sdzLhFbVOxZVqRsx5VjAVLzxAxxZN7EStUomtnX1rCIH810vvpMwTpkjnL8PJ07Dzup
	7Lq/tFsY0A4wyDOX5b1jXwj2NgT/4z8IYE4yhfvJ4iuG1SZMlF+z7xytdj3+CS4+JdPuvJ
	CGJFc4sIibNfB3SchXxRez5PA2rjYQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-vps-ed; t=1754428776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GydoA6fhSfORm8uTQ8KX9X1f9IeS0fBjHtrwZicRmNo=;
	b=plA49OaeH5yOxP2TnAH0+JEcmNC1YRLEEny7R0fvldOBnCkONzqG6Q89Kq6jmzYtppIbtm
	gH2XPIobHiVf84Cg==
Received: from [IPV6:2a04:4540:8c09:b700:18d7:e1a8:1f2c:446e] (unknown [IPv6:2a04:4540:8c09:b700:18d7:e1a8:1f2c:446e])
	by gw.tnxip.de (Postfix) with ESMTPSA id 8DC50C00000000340D47;
	Tue, 05 Aug 2025 23:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tnxip.de;
	s=mail-gw-ed; t=1754428776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GydoA6fhSfORm8uTQ8KX9X1f9IeS0fBjHtrwZicRmNo=;
	b=sqyw8XdCjNQptyoMoYQHwLC6gSjG2q8HQjRQa5U3Zx/XgTDlZna/m1v+qqVp5n+uzMUVhb
	WJNogNMRlmCzm/Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tnxip.de; s=mail-gw;
	t=1754428776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GydoA6fhSfORm8uTQ8KX9X1f9IeS0fBjHtrwZicRmNo=;
	b=Ti1aaDKKf5NnUKfFkz40TaPnNuUHJcjVlgzFzgiPViy/QJ+kD+sP9bQD9m7tk9sP4bAdoa
	8v6Cnx+I6Q9Epi7waVoy6Al8zXya0YkUXk77pVpix+5Mahkt0izk9Yxyv4cL2r6dvX7wYF
	wtFcBNTCatKz08uvgodE5LeQXI9PV20=
Message-ID: <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
Date: Tue, 5 Aug 2025 23:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [GIT PULL] bcachefs changes for 6.17
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
In-Reply-To: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28.07.25 17:14, Kent Overstreet wrote:
> Schedule notes for users:
>
> I've been digging through the bug tracker and polling users to see what
> bugs are still outstanding, and - it's not much.
>
> So, the experimental label is coming off in 6.18. 
>
> As always, if you do hit a bug, please report it.
>
> -------------------------------
>
> The following changes since commit c37495fe3531647db4ae5787a80699ae1438d7cf:
>
>   bcachefs: Add missing snapshots_seen_add_inorder() (2025-07-24 22:56:37 -0400)
>
> are available in the Git repository at:
>
>   git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-28
>
> for you to fetch changes up to c0d938c16b674bfe9e710579344653b703b92a49:
>
>   bcachefs: Add missing error_throw to bch2_set_version_incompat() (2025-07-25 12:03:48 -0400)
>
> ----------------------------------------------------------------
> bcachefs changes for 6.17-rc1
>
> No noteworthy feature work: we're in hard freeze.
>
> Lots of bugfixes. Assorted user visible changes and fixes:
>
> - Fix a major performance bug when deleting many files: this was caused
>   by the key cache caching keys that had been deleted, causing certain
>   lookups in the inode triggers to scan excessively.
>
> - The "io_read_nopromote" counter has been broken out into sub-counters;
>   these can be seen with 'bcachefs fs top' on a recent bcachefs-tools.
>   This helps when diagnosing why reads aren't coming from the cache.
>
> - Congestion tracking is now a bit less aggressive (this controls when
>   we decide to do a promote); this area still needs more work.
>
> - Metadata writes are no longer throttled by writeback throttling
>
> - Nocow writes can now be rebalanced (e.g. background_target,
>   background_compression options)
>
> - (Almost) all recovery passes now have progress indicators.
>
> - Repair improvements: we'll now reconstruct missing inodes if we find
>   contents for that inode (more than one or two keys), not just if the
>   inodes btree was damaged: similarly for 'dirent to missing inode'.
>
> - Btree node tracepoint improvements: they've been converted to more
>   modern printbuf tracepoints, and include significantly more info.
>
> - Fix in-memory accounting going out of sync with the accounting btree
>   when doing accounting updates before going RW.
>
> - BCH_MIN_NR_BUCKETS (minimum number of buckets per device) has been
>   increased from 64 to 512. In the unlikely event that anyone anyone
>   actually was using bcachefs on sub 128M filesystems and doesn't want
>   to lose access (modern tools will format these small filesystems with
>   a more appropriate bucket size), please file a report or contact me.
>
>   (This was just a syzbot issue, so far as I know).
>
> - CLASS()/guard() conversion: a great deal of code has been converted to
>   the new __cleanup based resource handling, and away from 'goto err'
>   cleanup.

So, no merge yet? That really is a bummer. I was really hoping to
finally be able to run mainline Linux again on my boxes (yes, I
converted all of them to bcachefs early this year), now that pretty much
all issues I was hitting are fixed by this merge request.

I mean, at the rate Kent's tree is stabilizing right now I am actually
considering moving some productive systems over there. But those will
need to run distro kernels. So, please merge, I don't want to jump
through the hoops to run OpenZFS ...


Kind regards

Malte


> ----------------------------------------------------------------
> Alan Huang (5):
>       bcachefs: Don't memcpy more than needed
>       bcachefs: Refactor trans->mem allocation
>       bcachefs: Shut up clang warning
>       bcachefs: Don't lock exec_update_lock
>       bcachefs: Use user_backed_iter instead of iter_is_iovec
>
> Anindya Sundar Gayen (1):
>       bcachefs: remove extraneous ; after statements
>
> George Hu (1):
>       bcachefs: use union for bch_compression_opt to make encode & decode easier
>
> Kent Overstreet (193):
>       bcachefs: Fix UAF by journal write path
>       bcachefs: async_objs: update iter pos after obj printed
>       bcachefs: fsck: dir_loop, subvol_loop now autofix
>       bcachefs: kill darray_u32_has()
>       bcachefs: Reduce __bch2_btree_node_alloc() stack usage
>       bcachefs: Allow CONFIG_UNICODE=m
>       bcachefs: use scoped_guard() in fast_list.c
>       bcachefs: DEFINE_CLASS()es for dev refcounts
>       bcachefs: More errcode conversions
>       bcachefs: add an unlikely() to trans_begin()
>       bcachefs: Plumb trans_kmalloc ip to trans_log_msg
>       bcachefs: Don't log error twice in allocator async repair
>       bcachefs: bch2_trans_has_updates()
>       bcachefs: Improve inode deletion
>       bcachefs: Don't peek key cache unless we have a real key
>       bcachefs: Evict/bypass key cache when deleting
>       bcachefs: -o fix_errors may now be used without -o fsck
>       bcachefs: Improved btree node tracepoints
>       bcachefs: Finish error_throw tracepoints
>       bcachefs: Improve inode_create behaviour on old filesystems
>       bcachefs: Before removing dangling dirents, check for contents
>       bcachefs: check_key_has_inode() reconstructs more aggressively
>       bcachefs: bch_fs.devs_removed
>       bcachefs: ptr_to_removed_device
>       bcachefs: bch2_journal_entry_missing_range()
>       bcachefs: Faster checking for missing journal entries
>       bcachefs: Add missing bch2_log_msg_start()
>       bcachefs: Print errcode when bch2_read_extent() sees error
>       bcachefs: Fix error message in buffered read path
>       bcachefs: Debug param for injecting btree node corruption on read
>       bcachefs: device add now properly sets c->online_devs
>       bcachefs: silence userspace build warning
>       bcachefs: Update path flags cleanups
>       bcachefs: add missing log message newline
>       bcachefs: add missing includes
>       bcachefs: silence userspace build warning
>       bcachefs: trace_data_update_done_no_rw_devs
>       bcachefs: use kvzalloc() for journal bios
>       bcachefs: Improve nopromote visibility
>       bcachefs: unsigned -> enum bch_trans_commit_flags
>       bcachefs: __bch2_btree_node_alloc() now respects target
>       bcachefs: bch2_btree_write_buffer_insert_checks()
>       bcachefs: don't call get_update_rebalance_opts() on btree ptrs
>       bcachefs: kill bch2_err_str() BUG_ON()
>       bcachefs: bch2_read_bio_to_text(): tabstops
>       bcachefs: kill __bch2_print_str()
>       bcachefs: bch_log()
>       bcachefs: c->loglevel
>       bcachefs: Zero list_idx when deleting from async obj lists
>       bcachefs: fix device add before fs started
>       bcachefs: fast_list: warn if non-empty on exit
>       bcachefs: bch2_journal_key_insert_take() accumulates accounting updates
>       bcachefs: bch2_fs_initialize() now runs journal replay
>       bcachefs: do_bch2_trans_commit_to_journal_replay handles accounting
>       bcachefs: bch2_set_nr_journal_buckets_iter() always marks
>       bcachefs: bch2_fs_initialize() initializes before going RW
>       bcachefs: Improve bch2_read_bio_to_text()
>       bcachefs: Fix replicas max options
>       bcachefs: Better congestion visibilty in sysfs
>       bcachefs: nopromote sub counters
>       bcachefs: make congestion tracking less aggressive
>       bcachefs: __bset_aux_tree_verify_ro()
>       bcachefs: Add missing bch2_bkey_set_needs_rebalance to nocow write path
>       bcachefs: delete useless null ptr check
>       bcachefs: Also create snapshots with CAP_FOWNER
>       bcachefs: Fix missing compat code in check_subvol()
>       bcachefs: Fix UAF in check_dirent()
>       bcachefs: Fix journal assertion
>       bcachefs: Fix __bch2_fs_read_write() error path
>       bcachefs: Give debugfs cached btree nodes better indentation
>       bcachefs: Silence clang warning about enum types
>       bcachefs: kill bkey_journal_seq()
>       bcachefs: don't pass bch_ioctl_data by value
>       bcachefs: better device too small error message
>       bcachefs: check_i_sectors now prints paths
>       bcachefs: simplify bch2_trans_do()
>       bcachefs: DEFINE_GUARD(printbuf_atomic)
>       bcachefs: convert super-io.c to CLASS/guards
>       bcachefs: convert super.c to CLASS/guards
>       bcachefs: convert acl.c to CLASS/guards
>       bcachefs: convert xattr.c to CLASS/guards
>       bcachefs: convert thread_with_file.c to CLASS/guards
>       bcachefs: convert unit tests to CLASS/guards
>       bcachefs: convert util.[ch] to CLASS/guards
>       bcachefs: convert six.c to guards
>       bcachefs: convert progress.c to guards
>       bcachefs: convert enumerated_ref.c to guards
>       bcachefs: convert opts.c to CLASS/guards
>       bcachefs: convert sysfs.c to CLASS/guards
>       bcachefs: convert buckets_waiting_for_journal.c to CLASS/guards
>       bcachefs: convert quota.c to CLASS/guards
>       bcachefs: convert sb-clean.c to CLASS/guards
>       bcachefs: convert sb-downgrade.c to CLASS/guards
>       bcachefs: convert sb-errors.c to CLASS/guards
>       bcachefs: convert sb-members.c to CLASS/guards
>       bcachefs: convert clock.c to CLASS/guards
>       bcachefs: convert debug.c to CLASS/guards
>       bcachefs: convert nocow_locking.c to CLASS/guards
>       bcachefs: convert replicas.c to CLASS/guards
>       bcachefs: convert bset.c to CLASS
>       bcachefs: convert bkey.c to CLASS
>       bcachefs: convert chardev.c to CLASS
>       bcachefs: convert fs-ioctl.c to CLASS/guards
>       bcachefs: convert disk_groups.c to guards
>       bcachefs: convert checksum.c to CLASS/guards
>       bcachefs: convert compress.c to guards
>       bcachefs: convert rebalance.c to CLASS/guards
>       bcachefs: convert migrate.c to CLASS/guards
>       bcachefs: convert move.c to CLASS/guards
>       bcachefs: convert movinggc.c to CLASS
>       bcachefs: convert data_update.c to CLASS/guards
>       bcachefs: convert reflink.c to CLASS/guards
>       bcachefs: convert snapshot.c to CLASS/guards
>       bcachefs: convert subvolume.c to CLASS/guards
>       bcachefs: convert str_hash.c to CLASS
>       bcachefs: convert recovery_passes.c to CLASS/guards
>       bcachefs: convert recovery.c to CLASS/guards
>       bcachefs: convert lru.c to CLASS
>       bcachefs: convert extents.c to guards
>       bcachefs: convert logged_ops.c to CLASS
>       bcachefs: convert inode.c to CLASS
>       bcachefs: convert dirent.c to CLASS
>       bcachefs: convert namei.c to CLASS
>       bcachefs: convert io_read.c to CLASS/guards
>       bcachefs: convert io_write.c to CLASS/guards
>       bcachefs: convert io_misc.c to CLASS/guards
>       bcachefs: convert fsck.c to CLASS/guards
>       bcachefs: convert disk_accounting.c to CLASS/guards
>       bcachefs: convert buckets.c to CLASS/guards
>       bcachefs: convert ec.c to CLASS/guards
>       bcachefs: convert backpointers.c to CLASS/guards
>       bcachefs: convert alloc_background.c to CLASS/guards
>       bcachefs: convert alloc_foreground.c to CLASS/guards
>       bcachefs: convert fs.c to CLASS/guards
>       bcachefs: convert fs-io.c to CLASS/guards
>       bcachefs: convert fs-io-pagecache.c to CLASS/guards
>       bcachefs: convert fs-io-buffered.c to CLASS/guards
>       bcachefs: convert fs-io-direct.c to CLASS/guards
>       bcachefs: convert btree_node_scan.c to CLASS/guards
>       bcachefs: convert journal.c to CLASS/guards
>       bcachefs: convert journal_io.c to CLASS/guards
>       bcachefs: convert journal_reclaim.c to CLASS/guards
>       bcachefs: convert journal_seq_blacklist.c to CLASS/guards
>       bcachefs: convert btree_cache.c to CLASS/guards
>       bcachefs: convert btree_gc.c to CLASS/guards
>       bcachefs: convert btree_write_buffer.c to CLASS/guards
>       bcachefs: convert btree_update.c to CLASS/guards
>       bcachefs: convert btree_update_interior.c to CLASS/guards
>       bcachefs: convert btree_trans_commit.c to CLASS/guards
>       bcachefs: convert btree_key_cache.c to CLASS/guards
>       bcachefs: convert btree_io.c to CLASS/guards
>       bcachefs: convert btree_iter.c to CLASS/guards
>       bcachefs: convert btree_locking.c to CLASS/guards
>       bcachefs: convert btree_journal_iter.c to CLASS/guards
>       bcachefs: bch2_run_recovery_pass() now prints errors
>       bcachefs: convert error.c to CLASS/guards
>       bcachefs: Fix padding zeroout when creating casefolded dirents
>       bcachefs: Don't call bch2_recovery_pass_want_ratelimit without sb_lock
>       bcachefs: Tell wbt throttling not to throttle metadata writes
>       bcachefs: Kill redundant write_super() when running recovery passes
>       bcachefs: Add comment to journal_flush_done()
>       bcachefs: Don't emit empty journal entry for accounting
>       bcachefs: sysfs trigger_btree_write_buffer_flush
>       closures: Improve warnings on bad put
>       bcachefs: Fix unhandled key type in fiemap_fill_extent
>       bcachefs: Ensure we don't return with closure on waitlist
>       bcachefs: bch2_move_data() now walks btree nodes
>       bcachefs: rereplicate flushes interior updates
>       bcachefs: can_use_btree_node()
>       bcachefs: Fix error handling in btree_iter_peek_slot
>       bcachefs: fix assert in bch2_btree_path_traverse_cached()
>       bcachefs: Fix allocate_dropping_locks() usage
>       bcachefs: log devices we're scanning in btree node scan
>       bcachefs: Fix refs to undefined fields in __bch2_alloc_v4_to_text()
>       bcachefs: fix check_extent_overbig() call
>       bcachefs: Convert topology repair errs to standard error codes
>       bcachefs: Fix __bch2_alloc_to_v4 copy
>       bcachefs: Flush btree_interior_update_work before freeing fs
>       bcachefs: Only track read latency for congestion tracking
>       bcachefs: Clean up btree_node_read_work() error handling
>       bcachefs: Ensure pick_read_device() returns error for btree pointers
>       bcachefs: btree_lost_data: mark a few more errors for silent fixing
>       bcachefs: Don't allow mounting with crazy numbers of dirty journal entries
>       bcachefs: Add pass_done to recovery_pass_status_to_text()
>       bcachefs: Increase BCH_MIN_NR_NBUCKETS
>       bcachefs: Hook up progress indicators for most recovery passes
>       bcachefs: recovery_pass_will_run()
>       bcachefs: journal_entry_btree_keys_to_text() is more careful
>       bcachefs: dirent_to_text() now uses prt_bytes()
>       bcachefs: Add missing ei_last_dirtied update
>       bcachefs: snapshots: pass snapshot_table where appropriate
>       bcachefs: live_child() no longer uses recursion
>       bcachefs: Add missing error_throw to bch2_set_version_incompat()
>
> Nikita Ofitserov (1):
>       bcachefs: Suppress unnecessary inode_i_sectors_wrong fsck error
>
> Youling Tang (2):
>       bcachefs: Simplify bch2_bio_map()
>       bcachefs: Use bio_add_folio_nofail() for unfailable operations
>
>  fs/bcachefs/acl.c                         |  19 +-
>  fs/bcachefs/alloc_background.c            | 300 +++++++---------
>  fs/bcachefs/alloc_background.h            |   9 +-
>  fs/bcachefs/alloc_foreground.c            | 209 +++++------
>  fs/bcachefs/alloc_foreground.h            |   9 +-
>  fs/bcachefs/async_objs.c                  |  29 +-
>  fs/bcachefs/async_objs.h                  |   7 +-
>  fs/bcachefs/async_objs_types.h            |   2 +-
>  fs/bcachefs/backpointers.c                |  63 ++--
>  fs/bcachefs/bcachefs.h                    |  72 ++--
>  fs/bcachefs/bkey.c                        |   4 +-
>  fs/bcachefs/bset.c                        |  74 ++--
>  fs/bcachefs/btree_cache.c                 |  38 +-
>  fs/bcachefs/btree_cache.h                 |  11 +
>  fs/bcachefs/btree_gc.c                    | 122 +++----
>  fs/bcachefs/btree_io.c                    | 119 ++++---
>  fs/bcachefs/btree_iter.c                  | 129 ++++---
>  fs/bcachefs/btree_iter.h                  |  22 +-
>  fs/bcachefs/btree_journal_iter.c          |  20 +-
>  fs/bcachefs/btree_key_cache.c             |  16 +-
>  fs/bcachefs/btree_locking.c               |  17 +-
>  fs/bcachefs/btree_node_scan.c             |  32 +-
>  fs/bcachefs/btree_trans_commit.c          | 121 ++++---
>  fs/bcachefs/btree_types.h                 |  22 +-
>  fs/bcachefs/btree_update.c                | 171 +++++----
>  fs/bcachefs/btree_update.h                |  79 +++--
>  fs/bcachefs/btree_update_interior.c       | 335 +++++++++---------
>  fs/bcachefs/btree_update_interior.h       |  12 +-
>  fs/bcachefs/btree_write_buffer.c          |  45 ++-
>  fs/bcachefs/btree_write_buffer.h          |   6 +-
>  fs/bcachefs/buckets.c                     | 212 +++++------
>  fs/bcachefs/buckets_waiting_for_journal.c |  30 +-
>  fs/bcachefs/chardev.c                     | 120 ++-----
>  fs/bcachefs/checksum.c                    |  54 ++-
>  fs/bcachefs/clock.c                       |  17 +-
>  fs/bcachefs/compress.c                    |  29 +-
>  fs/bcachefs/compress.h                    |  36 +-
>  fs/bcachefs/data_update.c                 |  33 +-
>  fs/bcachefs/debug.c                       |  92 +++--
>  fs/bcachefs/dirent.c                      |  42 +--
>  fs/bcachefs/dirent.h                      |   4 +-
>  fs/bcachefs/disk_accounting.c             | 266 +++++++-------
>  fs/bcachefs/disk_accounting.h             |   9 +-
>  fs/bcachefs/disk_groups.c                 |  27 +-
>  fs/bcachefs/ec.c                          | 239 +++++--------
>  fs/bcachefs/ec.h                          |   2 +-
>  fs/bcachefs/enumerated_ref.c              |   4 +-
>  fs/bcachefs/errcode.c                     |   3 +-
>  fs/bcachefs/errcode.h                     |  13 +
>  fs/bcachefs/error.c                       |  65 ++--
>  fs/bcachefs/extents.c                     |  38 +-
>  fs/bcachefs/extents.h                     |   3 +
>  fs/bcachefs/fast_list.c                   |  32 +-
>  fs/bcachefs/fast_list.h                   |   2 +-
>  fs/bcachefs/fs-io-buffered.c              |  79 ++---
>  fs/bcachefs/fs-io-direct.c                |  11 +-
>  fs/bcachefs/fs-io-pagecache.c             |  55 ++-
>  fs/bcachefs/fs-io.c                       | 127 ++++---
>  fs/bcachefs/fs-io.h                       |  19 +-
>  fs/bcachefs/fs-ioctl.c                    |  33 +-
>  fs/bcachefs/fs.c                          | 192 +++++-----
>  fs/bcachefs/fsck.c                        | 427 ++++++++++++----------
>  fs/bcachefs/inode.c                       | 101 +++---
>  fs/bcachefs/io_misc.c                     |  36 +-
>  fs/bcachefs/io_read.c                     | 157 +++++---
>  fs/bcachefs/io_read.h                     |  20 +-
>  fs/bcachefs/io_write.c                    |  46 +--
>  fs/bcachefs/journal.c                     | 253 ++++++-------
>  fs/bcachefs/journal.h                     |   3 +-
>  fs/bcachefs/journal_io.c                  | 248 ++++++-------
>  fs/bcachefs/journal_io.h                  |   7 +
>  fs/bcachefs/journal_reclaim.c             | 220 ++++++------
>  fs/bcachefs/journal_seq_blacklist.c       |  56 ++-
>  fs/bcachefs/journal_seq_blacklist.h       |   3 +
>  fs/bcachefs/logged_ops.c                  |  14 +-
>  fs/bcachefs/lru.c                         |  24 +-
>  fs/bcachefs/migrate.c                     |  21 +-
>  fs/bcachefs/move.c                        | 218 +++++-------
>  fs/bcachefs/move.h                        |  14 +-
>  fs/bcachefs/movinggc.c                    |   6 +-
>  fs/bcachefs/namei.c                       |  26 +-
>  fs/bcachefs/nocow_locking.c               |  10 +-
>  fs/bcachefs/opts.c                        |  33 +-
>  fs/bcachefs/opts.h                        |   8 +-
>  fs/bcachefs/printbuf.h                    |   4 +
>  fs/bcachefs/progress.c                    |   6 +-
>  fs/bcachefs/progress.h                    |   3 +
>  fs/bcachefs/quota.c                       |  96 ++---
>  fs/bcachefs/rebalance.c                   |  57 ++-
>  fs/bcachefs/recovery.c                    | 213 +++++------
>  fs/bcachefs/recovery_passes.c             |  68 ++--
>  fs/bcachefs/recovery_passes.h             |   9 +-
>  fs/bcachefs/reflink.c                     |  63 ++--
>  fs/bcachefs/replicas.c                    | 147 ++++----
>  fs/bcachefs/sb-clean.c                    |  36 +-
>  fs/bcachefs/sb-counters_format.h          |   6 +
>  fs/bcachefs/sb-downgrade.c                |  19 +-
>  fs/bcachefs/sb-errors.c                   |  45 +--
>  fs/bcachefs/sb-errors_format.h            |   9 +-
>  fs/bcachefs/sb-members.c                  |  48 ++-
>  fs/bcachefs/sb-members.h                  |  19 +-
>  fs/bcachefs/sb-members_format.h           |   2 +-
>  fs/bcachefs/six.c                         |  21 +-
>  fs/bcachefs/snapshot.c                    | 179 ++++------
>  fs/bcachefs/snapshot.h                    |  32 +-
>  fs/bcachefs/snapshot_types.h              |   2 +-
>  fs/bcachefs/str_hash.c                    |  23 +-
>  fs/bcachefs/str_hash.h                    |   4 +-
>  fs/bcachefs/subvolume.c                   | 106 +++---
>  fs/bcachefs/super-io.c                    |  81 ++---
>  fs/bcachefs/super.c                       | 570 ++++++++++++++----------------
>  fs/bcachefs/sysfs.c                       |  28 +-
>  fs/bcachefs/tests.c                       | 198 +++++------
>  fs/bcachefs/thread_with_file.c            |  52 +--
>  fs/bcachefs/time_stats.c                  |   7 +-
>  fs/bcachefs/trace.h                       | 152 ++------
>  fs/bcachefs/util.c                        |  28 +-
>  fs/bcachefs/util.h                        |  10 +-
>  fs/bcachefs/xattr.c                       |  52 ++-
>  lib/closure.c                             |  12 +-
>  120 files changed, 3972 insertions(+), 4388 deletions(-)
>

