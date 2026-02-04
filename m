Return-Path: <linux-fsdevel+bounces-76243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HbuM37JgmkJbQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 05:22:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E3E1881
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 05:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A1630B5A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 04:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B649634CFCB;
	Wed,  4 Feb 2026 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjK4iycE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF034C830;
	Wed,  4 Feb 2026 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178931; cv=none; b=O6qqgmtElPdv2pmqWBDO2B3iVb40a6sdNaX+vd4/N8fPKY9vKB2YgMaG9jDe6kWa41zsDpdW0BrORvDchrFunQPM2yD1hasYsFvCM12qOVTLYhzn4G3AGOlmvRuMCVoT9aESXQ1TH2lOVBseN/VPyUhzwM8XCMihaqTCj3WC3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178931; c=relaxed/simple;
	bh=xAr1MaLBjTmJh1EIvHVY9qAFaejUI/5HqFZckEJcElM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzJJZXphl11ryT9DuVpv68INWsMtgEeIyPRd3m9fTizze7KrCfe6Yf3Kg54GafVlx4eOv6A/QpOnXUr9Np1vC6vQsHQIao54/uSa4zr2slpsoee7dWsxzBO3JygIV0EphQdzCu9yMa+fLfCO6XeQk2vUY7Rx5W9lRcDPn5JmXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjK4iycE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770178930; x=1801714930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xAr1MaLBjTmJh1EIvHVY9qAFaejUI/5HqFZckEJcElM=;
  b=mjK4iycElGTEwlgjfamlOsJBDp/oloBHiy57a9XRIQpbX5MDz8ufH/Dj
   za0nr23jg6o2b9Y7Mrj6XhPnuvBRHZJllY9oWiF6+N26F4cOqLQspSRoX
   N4Oe2Y/EC+HPm+18vUkuIGyL4JyVpNyPKvT1+EDVOyG7NkPS1UjFjstpy
   x0n9Y3wWQd82Ak+HOzNZW/oJkCBUw4lm9iZCPRe1duoVg6uZH3DutB9sP
   hSJY3dVL8QjqpdYWT8EnIdBN7BFg19+FldAIq6pxHrw2ov1SnvI+ulP1w
   dWNP1hFtFfzixjOm/8mfdRN0ZWNbLAJ4i+PCoArViXR9PjKB3blGoL7pD
   Q==;
X-CSE-ConnectionGUID: Lmag3X5kTuiYU36BrRcRzw==
X-CSE-MsgGUID: CoWsnVZjRyWWnZzcDVlsUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74979366"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="74979366"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 20:22:09 -0800
X-CSE-ConnectionGUID: K9a77kKNQlCvpvsT37pm5Q==
X-CSE-MsgGUID: U0IMYBoYTtGKmJ6qBBepqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214753861"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2026 20:22:05 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnUOw-00000000hRg-4B3c;
	Wed, 04 Feb 2026 04:22:02 +0000
Date: Wed, 4 Feb 2026 12:21:41 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yizhang089@gmail.com,
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <202602041239.JFyNwVcg-lkp@intel.com>
References: <20260203062523.3869120-4-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203062523.3869120-4-yi.zhang@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	TAGGED_FROM(0.00)[bounces-76243-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 568E3E1881
X-Rspamd-Action: no action

Hi Zhang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260202]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/ext4-make-ext4_block_zero_page_range-pass-out-did_zero/20260203-144244
base:   next-20260202
patch link:    https://lore.kernel.org/r/20260203062523.3869120-4-yi.zhang%40huawei.com
patch subject: [PATCH -next v2 03/22] ext4: only order data when partially block truncating down
config: riscv-randconfig-r071-20260204 (https://download.01.org/0day-ci/archive/20260204/202602041239.JFyNwVcg-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602041239.JFyNwVcg-lkp@intel.com/

New smatch warnings:
fs/ext4/inode.c:4577 ext4_truncate() warn: unsigned 'zero_len' is never less than zero.

Old smatch warnings:
fs/ext4/inode.c:2651 mpage_prepare_extent_to_map() warn: missing error code 'err'
fs/ext4/inode.c:5129 check_igot_inode() warn: missing unwind goto?

vim +/zero_len +4577 fs/ext4/inode.c

  4494	
  4495	/*
  4496	 * ext4_truncate()
  4497	 *
  4498	 * We block out ext4_get_block() block instantiations across the entire
  4499	 * transaction, and VFS/VM ensures that ext4_truncate() cannot run
  4500	 * simultaneously on behalf of the same inode.
  4501	 *
  4502	 * As we work through the truncate and commit bits of it to the journal there
  4503	 * is one core, guiding principle: the file's tree must always be consistent on
  4504	 * disk.  We must be able to restart the truncate after a crash.
  4505	 *
  4506	 * The file's tree may be transiently inconsistent in memory (although it
  4507	 * probably isn't), but whenever we close off and commit a journal transaction,
  4508	 * the contents of (the filesystem + the journal) must be consistent and
  4509	 * restartable.  It's pretty simple, really: bottom up, right to left (although
  4510	 * left-to-right works OK too).
  4511	 *
  4512	 * Note that at recovery time, journal replay occurs *before* the restart of
  4513	 * truncate against the orphan inode list.
  4514	 *
  4515	 * The committed inode has the new, desired i_size (which is the same as
  4516	 * i_disksize in this case).  After a crash, ext4_orphan_cleanup() will see
  4517	 * that this inode's truncate did not complete and it will again call
  4518	 * ext4_truncate() to have another go.  So there will be instantiated blocks
  4519	 * to the right of the truncation point in a crashed ext4 filesystem.  But
  4520	 * that's fine - as long as they are linked from the inode, the post-crash
  4521	 * ext4_truncate() run will find them and release them.
  4522	 */
  4523	int ext4_truncate(struct inode *inode)
  4524	{
  4525		struct ext4_inode_info *ei = EXT4_I(inode);
  4526		unsigned int credits;
  4527		int err = 0, err2;
  4528		handle_t *handle;
  4529		struct address_space *mapping = inode->i_mapping;
  4530	
  4531		/*
  4532		 * There is a possibility that we're either freeing the inode
  4533		 * or it's a completely new inode. In those cases we might not
  4534		 * have i_rwsem locked because it's not necessary.
  4535		 */
  4536		if (!(inode_state_read_once(inode) & (I_NEW | I_FREEING)))
  4537			WARN_ON(!inode_is_locked(inode));
  4538		trace_ext4_truncate_enter(inode);
  4539	
  4540		if (!ext4_can_truncate(inode))
  4541			goto out_trace;
  4542	
  4543		if (inode->i_size == 0 && !test_opt(inode->i_sb, NO_AUTO_DA_ALLOC))
  4544			ext4_set_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE);
  4545	
  4546		if (ext4_has_inline_data(inode)) {
  4547			int has_inline = 1;
  4548	
  4549			err = ext4_inline_data_truncate(inode, &has_inline);
  4550			if (err || has_inline)
  4551				goto out_trace;
  4552		}
  4553	
  4554		/* If we zero-out tail of the page, we have to create jinode for jbd2 */
  4555		if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
  4556			err = ext4_inode_attach_jinode(inode);
  4557			if (err)
  4558				goto out_trace;
  4559		}
  4560	
  4561		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
  4562			credits = ext4_chunk_trans_extent(inode, 1);
  4563		else
  4564			credits = ext4_blocks_for_truncate(inode);
  4565	
  4566		handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
  4567		if (IS_ERR(handle)) {
  4568			err = PTR_ERR(handle);
  4569			goto out_trace;
  4570		}
  4571	
  4572		if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
  4573			unsigned int zero_len;
  4574	
  4575			zero_len = ext4_block_truncate_page(handle, mapping,
  4576							    inode->i_size);
> 4577			if (zero_len < 0) {
  4578				err = zero_len;
  4579				goto out_stop;
  4580			}
  4581			if (zero_len && !IS_DAX(inode) &&
  4582			    ext4_should_order_data(inode)) {
  4583				err = ext4_jbd2_inode_add_write(handle, inode,
  4584						inode->i_size, zero_len);
  4585				if (err)
  4586					goto out_stop;
  4587			}
  4588		}
  4589	
  4590		/*
  4591		 * We add the inode to the orphan list, so that if this
  4592		 * truncate spans multiple transactions, and we crash, we will
  4593		 * resume the truncate when the filesystem recovers.  It also
  4594		 * marks the inode dirty, to catch the new size.
  4595		 *
  4596		 * Implication: the file must always be in a sane, consistent
  4597		 * truncatable state while each transaction commits.
  4598		 */
  4599		err = ext4_orphan_add(handle, inode);
  4600		if (err)
  4601			goto out_stop;
  4602	
  4603		ext4_fc_track_inode(handle, inode);
  4604		ext4_check_map_extents_env(inode);
  4605	
  4606		down_write(&EXT4_I(inode)->i_data_sem);
  4607		ext4_discard_preallocations(inode);
  4608	
  4609		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
  4610			err = ext4_ext_truncate(handle, inode);
  4611		else
  4612			ext4_ind_truncate(handle, inode);
  4613	
  4614		up_write(&ei->i_data_sem);
  4615		if (err)
  4616			goto out_stop;
  4617	
  4618		if (IS_SYNC(inode))
  4619			ext4_handle_sync(handle);
  4620	
  4621	out_stop:
  4622		/*
  4623		 * If this was a simple ftruncate() and the file will remain alive,
  4624		 * then we need to clear up the orphan record which we created above.
  4625		 * However, if this was a real unlink then we were called by
  4626		 * ext4_evict_inode(), and we allow that function to clean up the
  4627		 * orphan info for us.
  4628		 */
  4629		if (inode->i_nlink)
  4630			ext4_orphan_del(handle, inode);
  4631	
  4632		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
  4633		err2 = ext4_mark_inode_dirty(handle, inode);
  4634		if (unlikely(err2 && !err))
  4635			err = err2;
  4636		ext4_journal_stop(handle);
  4637	
  4638	out_trace:
  4639		trace_ext4_truncate_exit(inode);
  4640		return err;
  4641	}
  4642	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

