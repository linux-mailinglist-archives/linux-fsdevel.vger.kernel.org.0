Return-Path: <linux-fsdevel+bounces-558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F347CCC72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 21:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30968B21207
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6D2DF6D;
	Tue, 17 Oct 2023 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ic02+qwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE062EAFA
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 19:40:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ACE10B;
	Tue, 17 Oct 2023 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697571625; x=1729107625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjdG+Xo/Zz+jbXvAWOg/Uza7joNoZT1tkJb7TwZwpQ8=;
  b=ic02+qwcJ5NmsIi1NpPUMzMbl9ias8jxUbynWg4rzX5aAZAJgqvFA6EQ
   JzdrF7eWuz5FA09zZFWiulPyubLQRed6Uxmy1aa0f8wFqb2DGQh22ekhL
   V+27G4wA0dlZzdV8hfiP20p5IrFLUL67yqq/DeV9s3mBzfCGB1SBT5KDw
   CFpYlQ9cwhPyukuhqhf7HnxXdTdEjH6Il7kTuC5I3FgFBSCCV4RI9428Z
   WMDvphEFYObanXnEb9XsngIYnC4aDqaEPGUiN+xpe2E6p6E1L0A1KtIMr
   KnDXD1W+2GqGXMCWjDzkdicc6SEqhJFFiNx+nyqG+W6HutLkOn6tipMvX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="452344459"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="452344459"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:40:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1003468960"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="1003468960"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Oct 2023 12:40:18 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qspvL-000A0w-0G;
	Tue, 17 Oct 2023 19:40:15 +0000
Date: Wed, 18 Oct 2023 03:39:58 +0800
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
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
Message-ID: <202310180338.zTpcYECK-lkp@intel.com>
References: <20231009064230.2952396-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009064230.2952396-3-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Suren,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20231017]
[cannot apply to linus/master v6.6-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/mm-rmap-support-move-to-different-root-anon_vma-in-folio_move_anon_rmap/20231009-144552
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231009064230.2952396-3-surenb%40google.com
patch subject: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
config: i386-randconfig-141-20231017 (https://download.01.org/0day-ci/archive/20231018/202310180338.zTpcYECK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231018/202310180338.zTpcYECK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180338.zTpcYECK-lkp@intel.com/

smatch warnings:
mm/userfaultfd.c:1380 remap_pages() warn: unsigned 'src_start + len - src_addr' is never less than zero.

vim +1380 mm/userfaultfd.c

  1195	
  1196	/**
  1197	 * remap_pages - remap arbitrary anonymous pages of an existing vma
  1198	 * @dst_start: start of the destination virtual memory range
  1199	 * @src_start: start of the source virtual memory range
  1200	 * @len: length of the virtual memory range
  1201	 *
  1202	 * remap_pages() remaps arbitrary anonymous pages atomically in zero
  1203	 * copy. It only works on non shared anonymous pages because those can
  1204	 * be relocated without generating non linear anon_vmas in the rmap
  1205	 * code.
  1206	 *
  1207	 * It provides a zero copy mechanism to handle userspace page faults.
  1208	 * The source vma pages should have mapcount == 1, which can be
  1209	 * enforced by using madvise(MADV_DONTFORK) on src vma.
  1210	 *
  1211	 * The thread receiving the page during the userland page fault
  1212	 * will receive the faulting page in the source vma through the network,
  1213	 * storage or any other I/O device (MADV_DONTFORK in the source vma
  1214	 * avoids remap_pages() to fail with -EBUSY if the process forks before
  1215	 * remap_pages() is called), then it will call remap_pages() to map the
  1216	 * page in the faulting address in the destination vma.
  1217	 *
  1218	 * This userfaultfd command works purely via pagetables, so it's the
  1219	 * most efficient way to move physical non shared anonymous pages
  1220	 * across different virtual addresses. Unlike mremap()/mmap()/munmap()
  1221	 * it does not create any new vmas. The mapping in the destination
  1222	 * address is atomic.
  1223	 *
  1224	 * It only works if the vma protection bits are identical from the
  1225	 * source and destination vma.
  1226	 *
  1227	 * It can remap non shared anonymous pages within the same vma too.
  1228	 *
  1229	 * If the source virtual memory range has any unmapped holes, or if
  1230	 * the destination virtual memory range is not a whole unmapped hole,
  1231	 * remap_pages() will fail respectively with -ENOENT or -EEXIST. This
  1232	 * provides a very strict behavior to avoid any chance of memory
  1233	 * corruption going unnoticed if there are userland race conditions.
  1234	 * Only one thread should resolve the userland page fault at any given
  1235	 * time for any given faulting address. This means that if two threads
  1236	 * try to both call remap_pages() on the same destination address at the
  1237	 * same time, the second thread will get an explicit error from this
  1238	 * command.
  1239	 *
  1240	 * The command retval will return "len" is successful. The command
  1241	 * however can be interrupted by fatal signals or errors. If
  1242	 * interrupted it will return the number of bytes successfully
  1243	 * remapped before the interruption if any, or the negative error if
  1244	 * none. It will never return zero. Either it will return an error or
  1245	 * an amount of bytes successfully moved. If the retval reports a
  1246	 * "short" remap, the remap_pages() command should be repeated by
  1247	 * userland with src+retval, dst+reval, len-retval if it wants to know
  1248	 * about the error that interrupted it.
  1249	 *
  1250	 * The UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES flag can be specified to
  1251	 * prevent -ENOENT errors to materialize if there are holes in the
  1252	 * source virtual range that is being remapped. The holes will be
  1253	 * accounted as successfully remapped in the retval of the
  1254	 * command. This is mostly useful to remap hugepage naturally aligned
  1255	 * virtual regions without knowing if there are transparent hugepage
  1256	 * in the regions or not, but preventing the risk of having to split
  1257	 * the hugepmd during the remap.
  1258	 *
  1259	 * If there's any rmap walk that is taking the anon_vma locks without
  1260	 * first obtaining the folio lock (the only current instance is
  1261	 * folio_referenced), they will have to verify if the folio->mapping
  1262	 * has changed after taking the anon_vma lock. If it changed they
  1263	 * should release the lock and retry obtaining a new anon_vma, because
  1264	 * it means the anon_vma was changed by remap_pages() before the lock
  1265	 * could be obtained. This is the only additional complexity added to
  1266	 * the rmap code to provide this anonymous page remapping functionality.
  1267	 */
  1268	ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_mm,
  1269			    unsigned long dst_start, unsigned long src_start,
  1270			    unsigned long len, __u64 mode)
  1271	{
  1272		struct vm_area_struct *src_vma, *dst_vma;
  1273		unsigned long src_addr, dst_addr;
  1274		pmd_t *src_pmd, *dst_pmd;
  1275		long err = -EINVAL;
  1276		ssize_t moved = 0;
  1277	
  1278		/*
  1279		 * Sanitize the command parameters:
  1280		 */
  1281		BUG_ON(src_start & ~PAGE_MASK);
  1282		BUG_ON(dst_start & ~PAGE_MASK);
  1283		BUG_ON(len & ~PAGE_MASK);
  1284	
  1285		/* Does the address range wrap, or is the span zero-sized? */
  1286		BUG_ON(src_start + len <= src_start);
  1287		BUG_ON(dst_start + len <= dst_start);
  1288	
  1289		/*
  1290		 * Because these are read sempahores there's no risk of lock
  1291		 * inversion.
  1292		 */
  1293		mmap_read_lock(dst_mm);
  1294		if (dst_mm != src_mm)
  1295			mmap_read_lock(src_mm);
  1296	
  1297		/*
  1298		 * Make sure the vma is not shared, that the src and dst remap
  1299		 * ranges are both valid and fully within a single existing
  1300		 * vma.
  1301		 */
  1302		src_vma = find_vma(src_mm, src_start);
  1303		if (!src_vma || (src_vma->vm_flags & VM_SHARED))
  1304			goto out;
  1305		if (src_start < src_vma->vm_start ||
  1306		    src_start + len > src_vma->vm_end)
  1307			goto out;
  1308	
  1309		dst_vma = find_vma(dst_mm, dst_start);
  1310		if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
  1311			goto out;
  1312		if (dst_start < dst_vma->vm_start ||
  1313		    dst_start + len > dst_vma->vm_end)
  1314			goto out;
  1315	
  1316		err = validate_remap_areas(src_vma, dst_vma);
  1317		if (err)
  1318			goto out;
  1319	
  1320		for (src_addr = src_start, dst_addr = dst_start;
  1321		     src_addr < src_start + len;) {
  1322			spinlock_t *ptl;
  1323			pmd_t dst_pmdval;
  1324			unsigned long step_size;
  1325	
  1326			BUG_ON(dst_addr >= dst_start + len);
  1327			/*
  1328			 * Below works because anonymous area would not have a
  1329			 * transparent huge PUD. If file-backed support is added,
  1330			 * that case would need to be handled here.
  1331			 */
  1332			src_pmd = mm_find_pmd(src_mm, src_addr);
  1333			if (unlikely(!src_pmd)) {
  1334				if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
  1335					err = -ENOENT;
  1336					break;
  1337				}
  1338				src_pmd = mm_alloc_pmd(src_mm, src_addr);
  1339				if (unlikely(!src_pmd)) {
  1340					err = -ENOMEM;
  1341					break;
  1342				}
  1343			}
  1344			dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
  1345			if (unlikely(!dst_pmd)) {
  1346				err = -ENOMEM;
  1347				break;
  1348			}
  1349	
  1350			dst_pmdval = pmdp_get_lockless(dst_pmd);
  1351			/*
  1352			 * If the dst_pmd is mapped as THP don't override it and just
  1353			 * be strict. If dst_pmd changes into TPH after this check, the
  1354			 * remap_pages_huge_pmd() will detect the change and retry
  1355			 * while remap_pages_pte() will detect the change and fail.
  1356			 */
  1357			if (unlikely(pmd_trans_huge(dst_pmdval))) {
  1358				err = -EEXIST;
  1359				break;
  1360			}
  1361	
  1362			ptl = pmd_trans_huge_lock(src_pmd, src_vma);
  1363			if (ptl) {
  1364				if (pmd_devmap(*src_pmd)) {
  1365					spin_unlock(ptl);
  1366					err = -ENOENT;
  1367					break;
  1368				}
  1369	
  1370				/*
  1371				 * Check if we can move the pmd without
  1372				 * splitting it. First check the address
  1373				 * alignment to be the same in src/dst.  These
  1374				 * checks don't actually need the PT lock but
  1375				 * it's good to do it here to optimize this
  1376				 * block away at build time if
  1377				 * CONFIG_TRANSPARENT_HUGEPAGE is not set.
  1378				 */
  1379				if ((src_addr & ~HPAGE_PMD_MASK) || (dst_addr & ~HPAGE_PMD_MASK) ||
> 1380				    src_start + len - src_addr < HPAGE_PMD_SIZE || !pmd_none(dst_pmdval)) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

