Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B139086EAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404592AbfHIAFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 20:05:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:26737 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733258AbfHIAFh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 20:05:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 17:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="175004945"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Aug 2019 17:05:32 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvsPU-000ByF-4G; Fri, 09 Aug 2019 08:05:32 +0800
Date:   Fri, 9 Aug 2019 08:04:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        adilger@dilger.ca, jaegeuk@kernel.org, darrick.wong@oracle.com,
        miklos@szeredi.hu, rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/9] fiemap: Use a callback to fill fiemap extents
Message-ID: <201908090808.UlvbBeuF%lkp@intel.com>
References: <20190808082744.31405-8-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808082744.31405-8-cmaiolino@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Carlos,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc3 next-20190808]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Carlos-Maiolino/New-fiemap-infrastructure-and-bmap-removal/20190808-221354
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/ioctl.c:87:52: sparse: sparse: incorrect type in initializer (different address spaces) @@    expected struct fiemap_extent [noderef] <asn:1> *dest @@    got n:1> *dest @@
>> fs/ioctl.c:87:52: sparse:    expected struct fiemap_extent [noderef] <asn:1> *dest
>> fs/ioctl.c:87:52: sparse:    got void *fi_cb_data
   fs/ioctl.c:83:5: sparse: sparse: symbol 'fiemap_fill_user_extent' was not declared. Should it be static?
>> fs/ioctl.c:218:28: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected void *[assigned] fi_cb_data @@    got struct fiemap_extent [nvoid *[assigned] fi_cb_data @@
>> fs/ioctl.c:218:28: sparse:    expected void *[assigned] fi_cb_data
>> fs/ioctl.c:218:28: sparse:    got struct fiemap_extent [noderef] <asn:1> *
>> fs/ioctl.c:224:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1> * @@    got oderef] <asn:1> * @@
>> fs/ioctl.c:224:14: sparse:    expected void const volatile [noderef] <asn:1> *
>> fs/ioctl.c:224:14: sparse:    got void *[assigned] fi_cb_data

vim +87 fs/ioctl.c

    79	
    80	#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
    81	#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
    82	#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
    83	int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
    84				    u64 phys, u64 len, u32 flags)
    85	{
    86		struct fiemap_extent extent;
  > 87		struct fiemap_extent __user *dest = fieinfo->fi_cb_data;
    88	
    89		/* only count the extents */
    90		if (fieinfo->fi_extents_max == 0) {
    91			fieinfo->fi_extents_mapped++;
    92			return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
    93		}
    94	
    95		if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
    96			return 1;
    97	
    98		if (flags & SET_UNKNOWN_FLAGS)
    99			flags |= FIEMAP_EXTENT_UNKNOWN;
   100		if (flags & SET_NO_UNMOUNTED_IO_FLAGS)
   101			flags |= FIEMAP_EXTENT_ENCODED;
   102		if (flags & SET_NOT_ALIGNED_FLAGS)
   103			flags |= FIEMAP_EXTENT_NOT_ALIGNED;
   104	
   105		memset(&extent, 0, sizeof(extent));
   106		extent.fe_logical = logical;
   107		extent.fe_physical = phys;
   108		extent.fe_length = len;
   109		extent.fe_flags = flags;
   110	
   111		dest += fieinfo->fi_extents_mapped;
   112		if (copy_to_user(dest, &extent, sizeof(extent)))
   113			return -EFAULT;
   114	
   115		fieinfo->fi_extents_mapped++;
   116		if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
   117			return 1;
   118		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
   119	}
   120	
   121	/**
   122	 * fiemap_fill_next_extent - Fiemap helper function
   123	 * @fieinfo:	Fiemap context passed into ->fiemap
   124	 * @logical:	Extent logical start offset, in bytes
   125	 * @phys:	Extent physical start offset, in bytes
   126	 * @len:	Extent length, in bytes
   127	 * @flags:	FIEMAP_EXTENT flags that describe this extent
   128	 *
   129	 * Called from file system ->fiemap callback. Will populate extent
   130	 * info as passed in via arguments and copy to user memory. On
   131	 * success, extent count on fieinfo is incremented.
   132	 *
   133	 * Returns 0 on success, -errno on error, 1 if this was the last
   134	 * extent that will fit in user array.
   135	 */
   136	int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
   137				    u64 phys, u64 len, u32 flags)
   138	{
   139		return fieinfo->fi_cb(fieinfo, logical, phys, len, flags);
   140	}
   141	EXPORT_SYMBOL(fiemap_fill_next_extent);
   142	
   143	/**
   144	 * fiemap_check_flags - check validity of requested flags for fiemap
   145	 * @fieinfo:	Fiemap context passed into ->fiemap
   146	 * @fs_flags:	Set of fiemap flags that the file system understands
   147	 *
   148	 * Called from file system ->fiemap callback. This will compute the
   149	 * intersection of valid fiemap flags and those that the fs supports. That
   150	 * value is then compared against the user supplied flags. In case of bad user
   151	 * flags, the invalid values will be written into the fieinfo structure, and
   152	 * -EBADR is returned, which tells ioctl_fiemap() to return those values to
   153	 * userspace. For this reason, a return code of -EBADR should be preserved.
   154	 *
   155	 * Returns 0 on success, -EBADR on bad flags.
   156	 */
   157	int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags)
   158	{
   159		u32 incompat_flags;
   160	
   161		incompat_flags = fieinfo->fi_flags & ~(FIEMAP_FLAGS_COMPAT & fs_flags);
   162		if (incompat_flags) {
   163			fieinfo->fi_flags = incompat_flags;
   164			return -EBADR;
   165		}
   166		return 0;
   167	}
   168	EXPORT_SYMBOL(fiemap_check_flags);
   169	
   170	static int fiemap_check_ranges(struct super_block *sb,
   171				       u64 start, u64 len, u64 *new_len)
   172	{
   173		u64 maxbytes = (u64) sb->s_maxbytes;
   174	
   175		*new_len = len;
   176	
   177		if (len == 0)
   178			return -EINVAL;
   179	
   180		if (start > maxbytes)
   181			return -EFBIG;
   182	
   183		/*
   184		 * Shrink request scope to what the fs can actually handle.
   185		 */
   186		if (len > maxbytes || (maxbytes - len) < start)
   187			*new_len = maxbytes - start;
   188	
   189		return 0;
   190	}
   191	
   192	static int ioctl_fiemap(struct file *filp, unsigned long arg)
   193	{
   194		struct fiemap fiemap;
   195		struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
   196		struct fiemap_extent_info fieinfo = { 0, };
   197		struct inode *inode = file_inode(filp);
   198		struct super_block *sb = inode->i_sb;
   199		u64 len;
   200		int error;
   201	
   202		if (!inode->i_op->fiemap)
   203			return -EOPNOTSUPP;
   204	
   205		if (copy_from_user(&fiemap, ufiemap, sizeof(fiemap)))
   206			return -EFAULT;
   207	
   208		if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
   209			return -EINVAL;
   210	
   211		error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
   212					    &len);
   213		if (error)
   214			return error;
   215	
   216		fieinfo.fi_flags = fiemap.fm_flags;
   217		fieinfo.fi_extents_max = fiemap.fm_extent_count;
 > 218		fieinfo.fi_cb_data = ufiemap->fm_extents;
   219		fieinfo.fi_start = fiemap.fm_start;
   220		fieinfo.fi_len = len;
   221		fieinfo.fi_cb = fiemap_fill_user_extent;
   222	
   223		if (fiemap.fm_extent_count != 0 &&
 > 224		    !access_ok(fieinfo.fi_cb_data,
   225			       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
   226			return -EFAULT;
   227	
   228		if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
   229			filemap_write_and_wait(inode->i_mapping);
   230	
   231		error = inode->i_op->fiemap(inode, &fieinfo);
   232		fiemap.fm_flags = fieinfo.fi_flags;
   233		fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
   234		if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
   235			error = -EFAULT;
   236	
   237		return error;
   238	}
   239	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
