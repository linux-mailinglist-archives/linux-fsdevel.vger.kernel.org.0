Return-Path: <linux-fsdevel+bounces-78717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YINVDQetoWk3vgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:41:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B31B9219
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54495305F550
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C798286D4E;
	Fri, 27 Feb 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PypMnjJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453071A9FAF;
	Fri, 27 Feb 2026 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202151; cv=none; b=RxOl1IPNMP9JVhGhWFourqx5ageeStpj+/u3L5aOAiaCHKD2jmxOXBtk/1vWAfC9x9jK02CRRanqWZ5k+TkTY3uS+9Gm2XEBryvIEC+EoKHG/neDYtRumY9WqDeuiSowewZdWNgSYHprmSVuwxm5C03aFeLjAiw/tnZSxn/ueuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202151; c=relaxed/simple;
	bh=qfT2Mr35jf7uJaOGpgAujO40WzOULEbrUPaqrBMPcXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjypcYjhYOhPwCNIZhn4kFlQeWZl1E/JrhgGYqCbf5/WDs58KrGlGAbP7GLXojGMjp9R8yjMCUp9G/n5f55r0ZrifHQQLl5hx8CAzCElRCsG3cNkUqvFWupREYBOj2y9MsZxV4vJ0K+MC1a/xGqokmVjuxKr+t6xJALpYUJzk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PypMnjJM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772202150; x=1803738150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qfT2Mr35jf7uJaOGpgAujO40WzOULEbrUPaqrBMPcXw=;
  b=PypMnjJMCO3GuEe4tgephfTfq566UbWMktmJMkIEUMKC8UPcKILD4uxt
   gKa5x0zTtgZ4QbHgixhEbTUnI8yyPYlEYh4utB2b9DxzwIJ8O2qJ8ko7d
   rFcMpm46gsiWZJh1Xk29aPl1R9fane1N2sYUt7HGtezolzTMjLTSZknkB
   FKGRutO01R4bAuPf76Ai3LlR9Ni0fEyYTqrIBv9NDqoB28oLEhv3nVLF6
   UE/kYpfB0czxxo6Lcwg5Jjs2TvSnoWnkWjMLOaJS1q8bcEQYPdzZTIRpv
   s8bMKTclg+jo1nTAnaurDvy7GZOuKVvbqxWiBqtUbmOJzhq3ooMqotBey
   w==;
X-CSE-ConnectionGUID: Ie5fD75JS9CQjA9YrepY+g==
X-CSE-MsgGUID: PXtDdtcFT22XyUSWyj7Ueg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="83615063"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="83615063"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 06:22:29 -0800
X-CSE-ConnectionGUID: XVZI3Zo3Sdy/HUKz8JjXpQ==
X-CSE-MsgGUID: 0CAEpBZ+TSOXtOZ/EhbyiQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 27 Feb 2026 06:22:26 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvyjY-00000000Aex-0R1W;
	Fri, 27 Feb 2026 14:22:24 +0000
Date: Fri, 27 Feb 2026 22:20:43 +0800
From: kernel test robot <lkp@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] hpfs: obsolete check=none mount option
Message-ID: <202602272252.89OlLXUV-lkp@intel.com>
References: <fd8dabf8-f0a5-418a-9b3d-da981101ca86@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd8dabf8-f0a5-418a-9b3d-da981101ca86@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78717-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 474B31B9219
X-Rspamd-Action: no action

Hi Tetsuo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master linux/master v7.0-rc1 next-20260226]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tetsuo-Handa/hpfs-obsolete-check-none-mount-option/20260226-222815
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/fd8dabf8-f0a5-418a-9b3d-da981101ca86%40I-love.SAKURA.ne.jp
patch subject: [PATCH] hpfs: obsolete check=none mount option
config: x86_64-randconfig-r071-20260227 (https://download.01.org/0day-ci/archive/20260227/202602272252.89OlLXUV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602272252.89OlLXUV-lkp@intel.com/

New smatch warnings:
fs/hpfs/anode.c:92 hpfs_add_sector_to_btree() warn: inconsistent indenting
fs/hpfs/anode.c:289 hpfs_remove_btree() warn: inconsistent indenting
fs/hpfs/anode.c:444 hpfs_truncate_btree() warn: inconsistent indenting
fs/hpfs/dnode.c:445 move_to_top() warn: inconsistent indenting
fs/hpfs/dnode.c:547 delete_empty_dnode() warn: inconsistent indenting
fs/hpfs/dnode.c:751 hpfs_count_dnodes() warn: inconsistent indenting
fs/hpfs/dnode.c:824 hpfs_de_as_down_as_possible() warn: inconsistent indenting
fs/hpfs/dnode.c:1056 map_fnode_dirent() warn: inconsistent indenting

Old smatch warnings:
fs/hpfs/anode.c:167 hpfs_add_sector_to_btree() warn: inconsistent indenting
fs/hpfs/anode.c:301 hpfs_remove_btree() warn: inconsistent indenting
fs/hpfs/anode.c:322 hpfs_remove_btree() warn: passing freed memory 'bh' (line 300)
fs/hpfs/anode.c:452 hpfs_truncate_btree() warn: passing freed memory 'bh' (line 443)
fs/hpfs/anode.c:470 hpfs_truncate_btree() warn: passing freed memory 'bh' (line 443)
fs/hpfs/dnode.c:47 hpfs_add_pos() error: we previously assumed 'hpfs_inode->i_rddir_off' could be null (see line 31)
fs/hpfs/dnode.c:786 hpfs_count_dnodes() warn: inconsistent indenting
fs/hpfs/dnode.c:1074 map_fnode_dirent() warn: inconsistent indenting

vim +92 fs/hpfs/anode.c

^1da177e4c3f41 Linus Torvalds      2005-04-16   60  
^1da177e4c3f41 Linus Torvalds      2005-04-16   61  secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsigned fsecno)
^1da177e4c3f41 Linus Torvalds      2005-04-16   62  {
^1da177e4c3f41 Linus Torvalds      2005-04-16   63  	struct bplus_header *btree;
^1da177e4c3f41 Linus Torvalds      2005-04-16   64  	struct anode *anode = NULL, *ranode = NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16   65  	struct fnode *fnode;
^1da177e4c3f41 Linus Torvalds      2005-04-16   66  	anode_secno a, na = -1, ra, up = -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16   67  	secno se;
^1da177e4c3f41 Linus Torvalds      2005-04-16   68  	struct buffer_head *bh, *bh1, *bh2;
^1da177e4c3f41 Linus Torvalds      2005-04-16   69  	int n;
^1da177e4c3f41 Linus Torvalds      2005-04-16   70  	unsigned fs;
^1da177e4c3f41 Linus Torvalds      2005-04-16   71  	int c1, c2 = 0;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11   72  
^1da177e4c3f41 Linus Torvalds      2005-04-16   73  	if (fnod) {
^1da177e4c3f41 Linus Torvalds      2005-04-16   74  		if (!(fnode = hpfs_map_fnode(s, node, &bh))) return -1;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11   75  		btree = GET_BTREE_PTR(&fnode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16   76  	} else {
^1da177e4c3f41 Linus Torvalds      2005-04-16   77  		if (!(anode = hpfs_map_anode(s, node, &bh))) return -1;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11   78  		btree = GET_BTREE_PTR(&anode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16   79  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16   80  	a = node;
^1da177e4c3f41 Linus Torvalds      2005-04-16   81  	go_down:
^1da177e4c3f41 Linus Torvalds      2005-04-16   82  	if ((n = btree->n_used_nodes - 1) < -!!fnod) {
^1da177e4c3f41 Linus Torvalds      2005-04-16   83  		hpfs_error(s, "anode %08x has no entries", a);
^1da177e4c3f41 Linus Torvalds      2005-04-16   84  		brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16   85  		return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16   86  	}
ddc19e6e04c113 Al Viro             2012-04-17   87  	if (bp_internal(btree)) {
0b69760be6968c Mikulas Patocka     2011-05-08   88  		a = le32_to_cpu(btree->u.internal[n].down);
0b69760be6968c Mikulas Patocka     2011-05-08   89  		btree->u.internal[n].file_secno = cpu_to_le32(-1);
^1da177e4c3f41 Linus Torvalds      2005-04-16   90  		mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16   91  		brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  @92  			if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_add_sector_to_btree #1")) return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16   93  		if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11   94  		btree = GET_BTREE_PTR(&anode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16   95  		goto go_down;
^1da177e4c3f41 Linus Torvalds      2005-04-16   96  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16   97  	if (n >= 0) {
0b69760be6968c Mikulas Patocka     2011-05-08   98  		if (le32_to_cpu(btree->u.external[n].file_secno) + le32_to_cpu(btree->u.external[n].length) != fsecno) {
^1da177e4c3f41 Linus Torvalds      2005-04-16   99  			hpfs_error(s, "allocated size %08x, trying to add sector %08x, %cnode %08x",
0b69760be6968c Mikulas Patocka     2011-05-08  100  				le32_to_cpu(btree->u.external[n].file_secno) + le32_to_cpu(btree->u.external[n].length), fsecno,
^1da177e4c3f41 Linus Torvalds      2005-04-16  101  				fnod?'f':'a', node);
^1da177e4c3f41 Linus Torvalds      2005-04-16  102  			brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  103  			return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  104  		}
0b69760be6968c Mikulas Patocka     2011-05-08  105  		if (hpfs_alloc_if_possible(s, se = le32_to_cpu(btree->u.external[n].disk_secno) + le32_to_cpu(btree->u.external[n].length))) {
32daab969cc16e Wei Yongjun         2012-10-04  106  			le32_add_cpu(&btree->u.external[n].length, 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  107  			mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  108  			brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  109  			return se;
^1da177e4c3f41 Linus Torvalds      2005-04-16  110  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  111  	} else {
^1da177e4c3f41 Linus Torvalds      2005-04-16  112  		if (fsecno) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  113  			hpfs_error(s, "empty file %08x, trying to add sector %08x", node, fsecno);
^1da177e4c3f41 Linus Torvalds      2005-04-16  114  			brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  115  			return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  116  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  117  		se = !fnod ? node : (node + 16384) & ~16383;
^1da177e4c3f41 Linus Torvalds      2005-04-16  118  	}	
7d23ce36e3f52f Mikulas Patocka     2011-05-08  119  	if (!(se = hpfs_alloc_sector(s, se, 1, fsecno*ALLOC_M>ALLOC_FWD_MAX ? ALLOC_FWD_MAX : fsecno*ALLOC_M<ALLOC_FWD_MIN ? ALLOC_FWD_MIN : fsecno*ALLOC_M))) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  120  		brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  121  		return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  122  	}
0b69760be6968c Mikulas Patocka     2011-05-08  123  	fs = n < 0 ? 0 : le32_to_cpu(btree->u.external[n].file_secno) + le32_to_cpu(btree->u.external[n].length);
^1da177e4c3f41 Linus Torvalds      2005-04-16  124  	if (!btree->n_free_nodes) {
0b69760be6968c Mikulas Patocka     2011-05-08  125  		up = a != node ? le32_to_cpu(anode->up) : -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  126  		if (!(anode = hpfs_alloc_anode(s, a, &na, &bh1))) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  127  			brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  128  			hpfs_free_sectors(s, se, 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  129  			return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  130  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  131  		if (a == node && fnod) {
0b69760be6968c Mikulas Patocka     2011-05-08  132  			anode->up = cpu_to_le32(node);
ddc19e6e04c113 Al Viro             2012-04-17  133  			anode->btree.flags |= BP_fnode_parent;
^1da177e4c3f41 Linus Torvalds      2005-04-16  134  			anode->btree.n_used_nodes = btree->n_used_nodes;
^1da177e4c3f41 Linus Torvalds      2005-04-16  135  			anode->btree.first_free = btree->first_free;
^1da177e4c3f41 Linus Torvalds      2005-04-16  136  			anode->btree.n_free_nodes = 40 - anode->btree.n_used_nodes;
^1da177e4c3f41 Linus Torvalds      2005-04-16  137  			memcpy(&anode->u, &btree->u, btree->n_used_nodes * 12);
ddc19e6e04c113 Al Viro             2012-04-17  138  			btree->flags |= BP_internal;
^1da177e4c3f41 Linus Torvalds      2005-04-16  139  			btree->n_free_nodes = 11;
^1da177e4c3f41 Linus Torvalds      2005-04-16  140  			btree->n_used_nodes = 1;
0b69760be6968c Mikulas Patocka     2011-05-08  141  			btree->first_free = cpu_to_le16((char *)&(btree->u.internal[1]) - (char *)btree);
0b69760be6968c Mikulas Patocka     2011-05-08  142  			btree->u.internal[0].file_secno = cpu_to_le32(-1);
0b69760be6968c Mikulas Patocka     2011-05-08  143  			btree->u.internal[0].down = cpu_to_le32(na);
^1da177e4c3f41 Linus Torvalds      2005-04-16  144  			mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  145  		} else if (!(ranode = hpfs_alloc_anode(s, /*a*/0, &ra, &bh2))) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  146  			brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  147  			brelse(bh1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  148  			hpfs_free_sectors(s, se, 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  149  			hpfs_free_sectors(s, na, 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  150  			return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  151  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  152  		brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  153  		bh = bh1;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  154  		btree = GET_BTREE_PTR(&anode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16  155  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  156  	btree->n_free_nodes--; n = btree->n_used_nodes++;
32daab969cc16e Wei Yongjun         2012-10-04  157  	le16_add_cpu(&btree->first_free, 12);
0b69760be6968c Mikulas Patocka     2011-05-08  158  	btree->u.external[n].disk_secno = cpu_to_le32(se);
0b69760be6968c Mikulas Patocka     2011-05-08  159  	btree->u.external[n].file_secno = cpu_to_le32(fs);
0b69760be6968c Mikulas Patocka     2011-05-08  160  	btree->u.external[n].length = cpu_to_le32(1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  161  	mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  162  	brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  163  	if ((a == node && fnod) || na == -1) return se;
^1da177e4c3f41 Linus Torvalds      2005-04-16  164  	c2 = 0;
0b69760be6968c Mikulas Patocka     2011-05-08  165  	while (up != (anode_secno)-1) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  166  		struct anode *new_anode;
^1da177e4c3f41 Linus Torvalds      2005-04-16  167  			if (hpfs_stop_cycles(s, up, &c1, &c2, "hpfs_add_sector_to_btree #2")) return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  168  		if (up != node || !fnod) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  169  			if (!(anode = hpfs_map_anode(s, up, &bh))) return -1;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  170  			btree = GET_BTREE_PTR(&anode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16  171  		} else {
^1da177e4c3f41 Linus Torvalds      2005-04-16  172  			if (!(fnode = hpfs_map_fnode(s, up, &bh))) return -1;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  173  			btree = GET_BTREE_PTR(&fnode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16  174  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  175  		if (btree->n_free_nodes) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  176  			btree->n_free_nodes--; n = btree->n_used_nodes++;
32daab969cc16e Wei Yongjun         2012-10-04  177  			le16_add_cpu(&btree->first_free, 8);
0b69760be6968c Mikulas Patocka     2011-05-08  178  			btree->u.internal[n].file_secno = cpu_to_le32(-1);
0b69760be6968c Mikulas Patocka     2011-05-08  179  			btree->u.internal[n].down = cpu_to_le32(na);
0b69760be6968c Mikulas Patocka     2011-05-08  180  			btree->u.internal[n-1].file_secno = cpu_to_le32(fs);
^1da177e4c3f41 Linus Torvalds      2005-04-16  181  			mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  182  			brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  183  			brelse(bh2);
^1da177e4c3f41 Linus Torvalds      2005-04-16  184  			hpfs_free_sectors(s, ra, 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  185  			if ((anode = hpfs_map_anode(s, na, &bh))) {
0b69760be6968c Mikulas Patocka     2011-05-08  186  				anode->up = cpu_to_le32(up);
ddc19e6e04c113 Al Viro             2012-04-17  187  				if (up == node && fnod)
ddc19e6e04c113 Al Viro             2012-04-17  188  					anode->btree.flags |= BP_fnode_parent;
ddc19e6e04c113 Al Viro             2012-04-17  189  				else
ddc19e6e04c113 Al Viro             2012-04-17  190  					anode->btree.flags &= ~BP_fnode_parent;
^1da177e4c3f41 Linus Torvalds      2005-04-16  191  				mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  192  				brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  193  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  194  			return se;
^1da177e4c3f41 Linus Torvalds      2005-04-16  195  		}
0b69760be6968c Mikulas Patocka     2011-05-08  196  		up = up != node ? le32_to_cpu(anode->up) : -1;
0b69760be6968c Mikulas Patocka     2011-05-08  197  		btree->u.internal[btree->n_used_nodes - 1].file_secno = cpu_to_le32(/*fs*/-1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  198  		mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  199  		brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  200  		a = na;
^1da177e4c3f41 Linus Torvalds      2005-04-16  201  		if ((new_anode = hpfs_alloc_anode(s, a, &na, &bh))) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  202  			anode = new_anode;
0b69760be6968c Mikulas Patocka     2011-05-08  203  			/*anode->up = cpu_to_le32(up != -1 ? up : ra);*/
ddc19e6e04c113 Al Viro             2012-04-17  204  			anode->btree.flags |= BP_internal;
^1da177e4c3f41 Linus Torvalds      2005-04-16  205  			anode->btree.n_used_nodes = 1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  206  			anode->btree.n_free_nodes = 59;
0b69760be6968c Mikulas Patocka     2011-05-08  207  			anode->btree.first_free = cpu_to_le16(16);
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  208  			GET_BTREE_PTR(&anode->btree)->u.internal[0].down = cpu_to_le32(a);
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  209  			GET_BTREE_PTR(&anode->btree)->u.internal[0].file_secno = cpu_to_le32(-1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  210  			mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  211  			brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  212  			if ((anode = hpfs_map_anode(s, a, &bh))) {
0b69760be6968c Mikulas Patocka     2011-05-08  213  				anode->up = cpu_to_le32(na);
^1da177e4c3f41 Linus Torvalds      2005-04-16  214  				mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  215  				brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  216  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  217  		} else na = a;
^1da177e4c3f41 Linus Torvalds      2005-04-16  218  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  219  	if ((anode = hpfs_map_anode(s, na, &bh))) {
0b69760be6968c Mikulas Patocka     2011-05-08  220  		anode->up = cpu_to_le32(node);
ddc19e6e04c113 Al Viro             2012-04-17  221  		if (fnod)
ddc19e6e04c113 Al Viro             2012-04-17  222  			anode->btree.flags |= BP_fnode_parent;
^1da177e4c3f41 Linus Torvalds      2005-04-16  223  		mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  224  		brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  225  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  226  	if (!fnod) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  227  		if (!(anode = hpfs_map_anode(s, node, &bh))) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  228  			brelse(bh2);
^1da177e4c3f41 Linus Torvalds      2005-04-16  229  			return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  230  		}
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  231  		btree = GET_BTREE_PTR(&anode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16  232  	} else {
^1da177e4c3f41 Linus Torvalds      2005-04-16  233  		if (!(fnode = hpfs_map_fnode(s, node, &bh))) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  234  			brelse(bh2);
^1da177e4c3f41 Linus Torvalds      2005-04-16  235  			return -1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  236  		}
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  237  		btree = GET_BTREE_PTR(&fnode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16  238  	}
0b69760be6968c Mikulas Patocka     2011-05-08  239  	ranode->up = cpu_to_le32(node);
0b69760be6968c Mikulas Patocka     2011-05-08  240  	memcpy(&ranode->btree, btree, le16_to_cpu(btree->first_free));
ddc19e6e04c113 Al Viro             2012-04-17  241  	if (fnod)
ddc19e6e04c113 Al Viro             2012-04-17  242  		ranode->btree.flags |= BP_fnode_parent;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  243  	GET_BTREE_PTR(&ranode->btree)->n_free_nodes = (bp_internal(GET_BTREE_PTR(&ranode->btree)) ? 60 : 40) - GET_BTREE_PTR(&ranode->btree)->n_used_nodes;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  244  	if (bp_internal(GET_BTREE_PTR(&ranode->btree))) for (n = 0; n < GET_BTREE_PTR(&ranode->btree)->n_used_nodes; n++) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  245  		struct anode *unode;
0b69760be6968c Mikulas Patocka     2011-05-08  246  		if ((unode = hpfs_map_anode(s, le32_to_cpu(ranode->u.internal[n].down), &bh1))) {
0b69760be6968c Mikulas Patocka     2011-05-08  247  			unode->up = cpu_to_le32(ra);
ddc19e6e04c113 Al Viro             2012-04-17  248  			unode->btree.flags &= ~BP_fnode_parent;
^1da177e4c3f41 Linus Torvalds      2005-04-16  249  			mark_buffer_dirty(bh1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  250  			brelse(bh1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  251  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  252  	}
ddc19e6e04c113 Al Viro             2012-04-17  253  	btree->flags |= BP_internal;
^1da177e4c3f41 Linus Torvalds      2005-04-16  254  	btree->n_free_nodes = fnod ? 10 : 58;
^1da177e4c3f41 Linus Torvalds      2005-04-16  255  	btree->n_used_nodes = 2;
0b69760be6968c Mikulas Patocka     2011-05-08  256  	btree->first_free = cpu_to_le16((char *)&btree->u.internal[2] - (char *)btree);
0b69760be6968c Mikulas Patocka     2011-05-08  257  	btree->u.internal[0].file_secno = cpu_to_le32(fs);
0b69760be6968c Mikulas Patocka     2011-05-08  258  	btree->u.internal[0].down = cpu_to_le32(ra);
0b69760be6968c Mikulas Patocka     2011-05-08  259  	btree->u.internal[1].file_secno = cpu_to_le32(-1);
0b69760be6968c Mikulas Patocka     2011-05-08  260  	btree->u.internal[1].down = cpu_to_le32(na);
^1da177e4c3f41 Linus Torvalds      2005-04-16  261  	mark_buffer_dirty(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  262  	brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  263  	mark_buffer_dirty(bh2);
^1da177e4c3f41 Linus Torvalds      2005-04-16  264  	brelse(bh2);
^1da177e4c3f41 Linus Torvalds      2005-04-16  265  	return se;
^1da177e4c3f41 Linus Torvalds      2005-04-16  266  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  267  
^1da177e4c3f41 Linus Torvalds      2005-04-16  268  /*
^1da177e4c3f41 Linus Torvalds      2005-04-16  269   * Remove allocation tree. Recursion would look much nicer but
^1da177e4c3f41 Linus Torvalds      2005-04-16  270   * I want to avoid it because it can cause stack overflow.
^1da177e4c3f41 Linus Torvalds      2005-04-16  271   */
^1da177e4c3f41 Linus Torvalds      2005-04-16  272  
^1da177e4c3f41 Linus Torvalds      2005-04-16  273  void hpfs_remove_btree(struct super_block *s, struct bplus_header *btree)
^1da177e4c3f41 Linus Torvalds      2005-04-16  274  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  275  	struct bplus_header *btree1 = btree;
^1da177e4c3f41 Linus Torvalds      2005-04-16  276  	struct anode *anode = NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  277  	anode_secno ano = 0, oano;
^1da177e4c3f41 Linus Torvalds      2005-04-16  278  	struct buffer_head *bh;
^1da177e4c3f41 Linus Torvalds      2005-04-16  279  	int level = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  280  	int pos = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  281  	int i;
^1da177e4c3f41 Linus Torvalds      2005-04-16  282  	int c1, c2 = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  283  	int d1, d2;
^1da177e4c3f41 Linus Torvalds      2005-04-16  284  	go_down:
^1da177e4c3f41 Linus Torvalds      2005-04-16  285  	d2 = 0;
ddc19e6e04c113 Al Viro             2012-04-17  286  	while (bp_internal(btree1)) {
0b69760be6968c Mikulas Patocka     2011-05-08  287  		ano = le32_to_cpu(btree1->u.internal[pos].down);
^1da177e4c3f41 Linus Torvalds      2005-04-16  288  		if (level) brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16 @289  			if (hpfs_stop_cycles(s, ano, &d1, &d2, "hpfs_remove_btree #1"))
^1da177e4c3f41 Linus Torvalds      2005-04-16  290  				return;
^1da177e4c3f41 Linus Torvalds      2005-04-16  291  		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  292  		btree1 = GET_BTREE_PTR(&anode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16  293  		level++;
^1da177e4c3f41 Linus Torvalds      2005-04-16  294  		pos = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  295  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  296  	for (i = 0; i < btree1->n_used_nodes; i++)
0b69760be6968c Mikulas Patocka     2011-05-08  297  		hpfs_free_sectors(s, le32_to_cpu(btree1->u.external[i].disk_secno), le32_to_cpu(btree1->u.external[i].length));
^1da177e4c3f41 Linus Torvalds      2005-04-16  298  	go_up:
^1da177e4c3f41 Linus Torvalds      2005-04-16  299  	if (!level) return;
^1da177e4c3f41 Linus Torvalds      2005-04-16  300  	brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  301  		if (hpfs_stop_cycles(s, ano, &c1, &c2, "hpfs_remove_btree #2")) return;
^1da177e4c3f41 Linus Torvalds      2005-04-16  302  	hpfs_free_sectors(s, ano, 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  303  	oano = ano;
0b69760be6968c Mikulas Patocka     2011-05-08  304  	ano = le32_to_cpu(anode->up);
^1da177e4c3f41 Linus Torvalds      2005-04-16  305  	if (--level) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  306  		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
68a74490629eb6 Gustavo A. R. Silva 2025-08-11  307  		btree1 = GET_BTREE_PTR(&anode->btree);
^1da177e4c3f41 Linus Torvalds      2005-04-16  308  	} else btree1 = btree;
^1da177e4c3f41 Linus Torvalds      2005-04-16  309  	for (i = 0; i < btree1->n_used_nodes; i++) {
0b69760be6968c Mikulas Patocka     2011-05-08  310  		if (le32_to_cpu(btree1->u.internal[i].down) == oano) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  311  			if ((pos = i + 1) < btree1->n_used_nodes)
^1da177e4c3f41 Linus Torvalds      2005-04-16  312  				goto go_down;
^1da177e4c3f41 Linus Torvalds      2005-04-16  313  			else
^1da177e4c3f41 Linus Torvalds      2005-04-16  314  				goto go_up;
^1da177e4c3f41 Linus Torvalds      2005-04-16  315  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  316  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  317  	hpfs_error(s,
^1da177e4c3f41 Linus Torvalds      2005-04-16  318  		   "reference to anode %08x not found in anode %08x "
^1da177e4c3f41 Linus Torvalds      2005-04-16  319  		   "(probably bad up pointer)",
^1da177e4c3f41 Linus Torvalds      2005-04-16  320  		   oano, level ? ano : -1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  321  	if (level)
^1da177e4c3f41 Linus Torvalds      2005-04-16  322  		brelse(bh);
^1da177e4c3f41 Linus Torvalds      2005-04-16  323  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  324  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

