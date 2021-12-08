Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF19346D233
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 12:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhLHLdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 06:33:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:9578 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhLHLdP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:33:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="236550610"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="236550610"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 03:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="462732511"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2021 03:29:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muv8n-0000VG-7K; Wed, 08 Dec 2021 11:29:41 +0000
Date:   Wed, 8 Dec 2021 19:29:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 42/48] mm: Convert find_lock_entries() to use a
 folio_batch
Message-ID: <202112081952.NHF8MX2L-lkp@intel.com>
References: <20211208042256.1923824-43-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-43-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi "Matthew,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on rostedt-trace/for-next linus/master v5.16-rc4]
[cannot apply to next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Folios-for-5-17/20211208-122734
base:   https://github.com/hnaz/linux-mm master
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112081952.NHF8MX2L-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b883ee2b43293c901ea31f233d1596f255e0dcb9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Folios-for-5-17/20211208-122734
        git checkout b883ee2b43293c901ea31f233d1596f255e0dcb9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/f2fs/dir.c:13:
>> fs/f2fs/f2fs.h:4055:67: warning: 'struct pagevec' declared inside parameter list will not be visible outside of this definition or declaration
    4055 | bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
         |                                                                   ^~~~~~~


vim +4055 fs/f2fs/f2fs.h

4c8ff7095bef64 Chao Yu       2019-11-01  4034  
4c8ff7095bef64 Chao Yu       2019-11-01  4035  /*
4c8ff7095bef64 Chao Yu       2019-11-01  4036   * compress.c
4c8ff7095bef64 Chao Yu       2019-11-01  4037   */
4c8ff7095bef64 Chao Yu       2019-11-01  4038  #ifdef CONFIG_F2FS_FS_COMPRESSION
4c8ff7095bef64 Chao Yu       2019-11-01  4039  bool f2fs_is_compressed_page(struct page *page);
4c8ff7095bef64 Chao Yu       2019-11-01  4040  struct page *f2fs_compress_control_page(struct page *page);
4c8ff7095bef64 Chao Yu       2019-11-01  4041  int f2fs_prepare_compress_overwrite(struct inode *inode,
4c8ff7095bef64 Chao Yu       2019-11-01  4042  			struct page **pagep, pgoff_t index, void **fsdata);
4c8ff7095bef64 Chao Yu       2019-11-01  4043  bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
4c8ff7095bef64 Chao Yu       2019-11-01  4044  					pgoff_t index, unsigned copied);
3265d3db1f1639 Chao Yu       2020-03-18  4045  int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
4c8ff7095bef64 Chao Yu       2019-11-01  4046  void f2fs_compress_write_end_io(struct bio *bio, struct page *page);
4c8ff7095bef64 Chao Yu       2019-11-01  4047  bool f2fs_is_compress_backend_ready(struct inode *inode);
5e6bbde9598230 Chao Yu       2020-04-08  4048  int f2fs_init_compress_mempool(void);
5e6bbde9598230 Chao Yu       2020-04-08  4049  void f2fs_destroy_compress_mempool(void);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4050  void f2fs_decompress_cluster(struct decompress_io_ctx *dic);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4051  void f2fs_end_read_compressed_page(struct page *page, bool failed,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4052  							block_t blkaddr);
4c8ff7095bef64 Chao Yu       2019-11-01  4053  bool f2fs_cluster_is_empty(struct compress_ctx *cc);
4c8ff7095bef64 Chao Yu       2019-11-01  4054  bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
2ce5eeadf5d8d9 Andrew Morton 2021-10-28 @4055  bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
2ce5eeadf5d8d9 Andrew Morton 2021-10-28  4056  				int index, int nr_pages);
bbe1da7e34ac5a Chao Yu       2021-08-06  4057  bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
4c8ff7095bef64 Chao Yu       2019-11-01  4058  void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
4c8ff7095bef64 Chao Yu       2019-11-01  4059  int f2fs_write_multi_pages(struct compress_ctx *cc,
4c8ff7095bef64 Chao Yu       2019-11-01  4060  						int *submitted,
4c8ff7095bef64 Chao Yu       2019-11-01  4061  						struct writeback_control *wbc,
4c8ff7095bef64 Chao Yu       2019-11-01  4062  						enum iostat_type io_type);
4c8ff7095bef64 Chao Yu       2019-11-01  4063  int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
94afd6d6e52531 Chao Yu       2021-08-04  4064  void f2fs_update_extent_tree_range_compressed(struct inode *inode,
94afd6d6e52531 Chao Yu       2021-08-04  4065  				pgoff_t fofs, block_t blkaddr, unsigned int llen,
94afd6d6e52531 Chao Yu       2021-08-04  4066  				unsigned int c_len);
4c8ff7095bef64 Chao Yu       2019-11-01  4067  int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
4c8ff7095bef64 Chao Yu       2019-11-01  4068  				unsigned nr_pages, sector_t *last_block_in_bio,
0683728adab251 Chao Yu       2020-02-18  4069  				bool is_readahead, bool for_write);
4c8ff7095bef64 Chao Yu       2019-11-01  4070  struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
7f59b277f79e8a Eric Biggers  2021-01-04  4071  void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed);
7f59b277f79e8a Eric Biggers  2021-01-04  4072  void f2fs_put_page_dic(struct page *page);
94afd6d6e52531 Chao Yu       2021-08-04  4073  unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn);
4c8ff7095bef64 Chao Yu       2019-11-01  4074  int f2fs_init_compress_ctx(struct compress_ctx *cc);
8bfbfb0ddd706b Chao Yu       2021-05-10  4075  void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse);
4c8ff7095bef64 Chao Yu       2019-11-01  4076  void f2fs_init_compress_info(struct f2fs_sb_info *sbi);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4077  int f2fs_init_compress_inode(struct f2fs_sb_info *sbi);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4078  void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi);
31083031709eea Chao Yu       2020-09-14  4079  int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi);
31083031709eea Chao Yu       2020-09-14  4080  void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
c68d6c88302250 Chao Yu       2020-09-14  4081  int __init f2fs_init_compress_cache(void);
c68d6c88302250 Chao Yu       2020-09-14  4082  void f2fs_destroy_compress_cache(void);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4083  struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4084  void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4085  void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4086  						nid_t ino, block_t blkaddr);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4087  bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4088  								block_t blkaddr);
6ce19aff0b8cd3 Chao Yu       2021-05-20  4089  void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
5ac443e26a0964 Daeho Jeong   2021-03-15  4090  #define inc_compr_inode_stat(inode)					\
5ac443e26a0964 Daeho Jeong   2021-03-15  4091  	do {								\
5ac443e26a0964 Daeho Jeong   2021-03-15  4092  		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
5ac443e26a0964 Daeho Jeong   2021-03-15  4093  		sbi->compr_new_inode++;					\
5ac443e26a0964 Daeho Jeong   2021-03-15  4094  	} while (0)
5ac443e26a0964 Daeho Jeong   2021-03-15  4095  #define add_compr_block_stat(inode, blocks)				\
5ac443e26a0964 Daeho Jeong   2021-03-15  4096  	do {								\
5ac443e26a0964 Daeho Jeong   2021-03-15  4097  		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
5ac443e26a0964 Daeho Jeong   2021-03-15  4098  		int diff = F2FS_I(inode)->i_cluster_size - blocks;	\
5ac443e26a0964 Daeho Jeong   2021-03-15  4099  		sbi->compr_written_block += blocks;			\
5ac443e26a0964 Daeho Jeong   2021-03-15  4100  		sbi->compr_saved_block += diff;				\
5ac443e26a0964 Daeho Jeong   2021-03-15  4101  	} while (0)
4c8ff7095bef64 Chao Yu       2019-11-01  4102  #else
4c8ff7095bef64 Chao Yu       2019-11-01  4103  static inline bool f2fs_is_compressed_page(struct page *page) { return false; }
4c8ff7095bef64 Chao Yu       2019-11-01  4104  static inline bool f2fs_is_compress_backend_ready(struct inode *inode)
4c8ff7095bef64 Chao Yu       2019-11-01  4105  {
4c8ff7095bef64 Chao Yu       2019-11-01  4106  	if (!f2fs_compressed_file(inode))
4c8ff7095bef64 Chao Yu       2019-11-01  4107  		return true;
4c8ff7095bef64 Chao Yu       2019-11-01  4108  	/* not support compression */
4c8ff7095bef64 Chao Yu       2019-11-01  4109  	return false;
4c8ff7095bef64 Chao Yu       2019-11-01  4110  }
4c8ff7095bef64 Chao Yu       2019-11-01  4111  static inline struct page *f2fs_compress_control_page(struct page *page)
4c8ff7095bef64 Chao Yu       2019-11-01  4112  {
4c8ff7095bef64 Chao Yu       2019-11-01  4113  	WARN_ON_ONCE(1);
4c8ff7095bef64 Chao Yu       2019-11-01  4114  	return ERR_PTR(-EINVAL);
4c8ff7095bef64 Chao Yu       2019-11-01  4115  }
5e6bbde9598230 Chao Yu       2020-04-08  4116  static inline int f2fs_init_compress_mempool(void) { return 0; }
5e6bbde9598230 Chao Yu       2020-04-08  4117  static inline void f2fs_destroy_compress_mempool(void) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4118  static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4119  static inline void f2fs_end_read_compressed_page(struct page *page,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4120  						bool failed, block_t blkaddr)
7f59b277f79e8a Eric Biggers  2021-01-04  4121  {
7f59b277f79e8a Eric Biggers  2021-01-04  4122  	WARN_ON_ONCE(1);
7f59b277f79e8a Eric Biggers  2021-01-04  4123  }
7f59b277f79e8a Eric Biggers  2021-01-04  4124  static inline void f2fs_put_page_dic(struct page *page)
7f59b277f79e8a Eric Biggers  2021-01-04  4125  {
7f59b277f79e8a Eric Biggers  2021-01-04  4126  	WARN_ON_ONCE(1);
7f59b277f79e8a Eric Biggers  2021-01-04  4127  }
94afd6d6e52531 Chao Yu       2021-08-04  4128  static inline unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn) { return 0; }
bbe1da7e34ac5a Chao Yu       2021-08-06  4129  static inline bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4130  static inline int f2fs_init_compress_inode(struct f2fs_sb_info *sbi) { return 0; }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4131  static inline void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi) { }
31083031709eea Chao Yu       2020-09-14  4132  static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return 0; }
31083031709eea Chao Yu       2020-09-14  4133  static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
c68d6c88302250 Chao Yu       2020-09-14  4134  static inline int __init f2fs_init_compress_cache(void) { return 0; }
c68d6c88302250 Chao Yu       2020-09-14  4135  static inline void f2fs_destroy_compress_cache(void) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4136  static inline void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4137  				block_t blkaddr) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4138  static inline void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4139  				struct page *page, nid_t ino, block_t blkaddr) { }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4140  static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4141  				struct page *page, block_t blkaddr) { return false; }
6ce19aff0b8cd3 Chao Yu       2021-05-20  4142  static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
6ce19aff0b8cd3 Chao Yu       2021-05-20  4143  							nid_t ino) { }
5ac443e26a0964 Daeho Jeong   2021-03-15  4144  #define inc_compr_inode_stat(inode)		do { } while (0)
94afd6d6e52531 Chao Yu       2021-08-04  4145  static inline void f2fs_update_extent_tree_range_compressed(struct inode *inode,
94afd6d6e52531 Chao Yu       2021-08-04  4146  				pgoff_t fofs, block_t blkaddr, unsigned int llen,
94afd6d6e52531 Chao Yu       2021-08-04  4147  				unsigned int c_len) { }
4c8ff7095bef64 Chao Yu       2019-11-01  4148  #endif
4c8ff7095bef64 Chao Yu       2019-11-01  4149  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
