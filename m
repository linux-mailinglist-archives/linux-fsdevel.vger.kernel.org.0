Return-Path: <linux-fsdevel+bounces-1476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E337DA584
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 09:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F3FB2150B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C91611B;
	Sat, 28 Oct 2023 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0elTMKt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D45664
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 07:44:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD22AEB;
	Sat, 28 Oct 2023 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698479061; x=1730015061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=465OdnQqbfHuFli76mKkKaH0MNO+Oh+EJdtspDJbpzo=;
  b=P0elTMKtLHBLIWqzXIH6QeBB2lsJqlUvfUFA0puKzVXiwB1WtGJoObEA
   1kHT5CqraLLz7nlB6FYvwA/PbcCWVxwV3nPV2B+bv3HRPidQARhXJEtqZ
   Yccxv6QJmgsGpLW0vLHxWnrWkmTzL/0d7WkX32GniFQp3WYJ1L6Dq6NMt
   dKOsqEcerWMAnoqNTqNlwyeJF73tld5Jq4Db8yY5CtEdkF4A0LLv5D8O6
   i5k5MW7+x0UgR2yo71Isaz/M8SzPlmXSvdk5+CM/sD+dAGZMYW9zAvkTf
   z6uSYqZLzyst/h8/JcfiW+Tug8CwhzqnAgj5+J8NqDFhKoP/xeiZmdEFk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="682963"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="682963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 00:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="903506551"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="903506551"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2023 00:41:43 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qwdzP-000BYv-31;
	Sat, 28 Oct 2023 07:44:11 +0000
Date: Sat, 28 Oct 2023 15:43:40 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk,
	brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
	lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
	hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
	surenb@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 2/5] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <202310281500.latmtbJs-lkp@intel.com>
References: <20231028003819.652322-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028003819.652322-3-surenb@google.com>

Hi Suren,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20231027]
[cannot apply to linus/master v6.6-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/mm-rmap-support-move-to-different-root-anon_vma-in-folio_move_anon_rmap/20231028-084120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231028003819.652322-3-surenb%40google.com
patch subject: [PATCH v4 2/5] userfaultfd: UFFDIO_MOVE uABI
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231028/202310281500.latmtbJs-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310281500.latmtbJs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310281500.latmtbJs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/userfaultfd.c:1289: warning: Function parameter or member 'ctx' not described in 'move_pages'
>> mm/userfaultfd.c:1289: warning: Function parameter or member 'mm' not described in 'move_pages'
>> mm/userfaultfd.c:1289: warning: Function parameter or member 'mode' not described in 'move_pages'


vim +1289 mm/userfaultfd.c

  1211	
  1212	/**
  1213	 * move_pages - move arbitrary anonymous pages of an existing vma
  1214	 * @dst_start: start of the destination virtual memory range
  1215	 * @src_start: start of the source virtual memory range
  1216	 * @len: length of the virtual memory range
  1217	 *
  1218	 * Must be called with mmap_lock held for read.
  1219	 *
  1220	 * move_pages() remaps arbitrary anonymous pages atomically in zero
  1221	 * copy. It only works on non shared anonymous pages because those can
  1222	 * be relocated without generating non linear anon_vmas in the rmap
  1223	 * code.
  1224	 *
  1225	 * It provides a zero copy mechanism to handle userspace page faults.
  1226	 * The source vma pages should have mapcount == 1, which can be
  1227	 * enforced by using madvise(MADV_DONTFORK) on src vma.
  1228	 *
  1229	 * The thread receiving the page during the userland page fault
  1230	 * will receive the faulting page in the source vma through the network,
  1231	 * storage or any other I/O device (MADV_DONTFORK in the source vma
  1232	 * avoids move_pages() to fail with -EBUSY if the process forks before
  1233	 * move_pages() is called), then it will call move_pages() to map the
  1234	 * page in the faulting address in the destination vma.
  1235	 *
  1236	 * This userfaultfd command works purely via pagetables, so it's the
  1237	 * most efficient way to move physical non shared anonymous pages
  1238	 * across different virtual addresses. Unlike mremap()/mmap()/munmap()
  1239	 * it does not create any new vmas. The mapping in the destination
  1240	 * address is atomic.
  1241	 *
  1242	 * It only works if the vma protection bits are identical from the
  1243	 * source and destination vma.
  1244	 *
  1245	 * It can remap non shared anonymous pages within the same vma too.
  1246	 *
  1247	 * If the source virtual memory range has any unmapped holes, or if
  1248	 * the destination virtual memory range is not a whole unmapped hole,
  1249	 * move_pages() will fail respectively with -ENOENT or -EEXIST. This
  1250	 * provides a very strict behavior to avoid any chance of memory
  1251	 * corruption going unnoticed if there are userland race conditions.
  1252	 * Only one thread should resolve the userland page fault at any given
  1253	 * time for any given faulting address. This means that if two threads
  1254	 * try to both call move_pages() on the same destination address at the
  1255	 * same time, the second thread will get an explicit error from this
  1256	 * command.
  1257	 *
  1258	 * The command retval will return "len" is successful. The command
  1259	 * however can be interrupted by fatal signals or errors. If
  1260	 * interrupted it will return the number of bytes successfully
  1261	 * remapped before the interruption if any, or the negative error if
  1262	 * none. It will never return zero. Either it will return an error or
  1263	 * an amount of bytes successfully moved. If the retval reports a
  1264	 * "short" remap, the move_pages() command should be repeated by
  1265	 * userland with src+retval, dst+reval, len-retval if it wants to know
  1266	 * about the error that interrupted it.
  1267	 *
  1268	 * The UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES flag can be specified to
  1269	 * prevent -ENOENT errors to materialize if there are holes in the
  1270	 * source virtual range that is being remapped. The holes will be
  1271	 * accounted as successfully remapped in the retval of the
  1272	 * command. This is mostly useful to remap hugepage naturally aligned
  1273	 * virtual regions without knowing if there are transparent hugepage
  1274	 * in the regions or not, but preventing the risk of having to split
  1275	 * the hugepmd during the remap.
  1276	 *
  1277	 * If there's any rmap walk that is taking the anon_vma locks without
  1278	 * first obtaining the folio lock (the only current instance is
  1279	 * folio_referenced), they will have to verify if the folio->mapping
  1280	 * has changed after taking the anon_vma lock. If it changed they
  1281	 * should release the lock and retry obtaining a new anon_vma, because
  1282	 * it means the anon_vma was changed by move_pages() before the lock
  1283	 * could be obtained. This is the only additional complexity added to
  1284	 * the rmap code to provide this anonymous page remapping functionality.
  1285	 */
  1286	ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
  1287			   unsigned long dst_start, unsigned long src_start,
  1288			   unsigned long len, __u64 mode)
> 1289	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

