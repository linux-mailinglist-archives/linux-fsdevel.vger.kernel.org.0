Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7CE9416
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 01:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfJ3AVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 20:21:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:32334 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfJ3AVS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 20:21:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 17:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="gz'50?scan'50,208,50";a="211212681"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2019 17:21:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iPbje-000BSo-F6; Wed, 30 Oct 2019 08:21:14 +0800
Date:   Wed, 30 Oct 2019 08:20:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: warn if stale pagecache is left after direct write
Message-ID: <201910300824.UIo56oC7%lkp@intel.com>
References: <157225698620.5453.17655271871684298255.stgit@buzz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="j23rpqvne5hyng2k"
Content-Disposition: inline
In-Reply-To: <157225698620.5453.17655271871684298255.stgit@buzz>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--j23rpqvne5hyng2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Konstantin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.4-rc5 next-20191029]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Konstantin-Khlebnikov/fs-warn-if-stale-pagecache-is-left-after-direct-write/20191030-073543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 23fdb198ae81f47a574296dab5167c5e136a02ba
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/filemap.c: In function 'generic_file_direct_write':
>> mm/filemap.c:3229:3: error: implicit declaration of function 'dio_warn_stale_pagecache'; did you mean 'truncate_pagecache'? [-Werror=implicit-function-declaration]
      dio_warn_stale_pagecache(file);
      ^~~~~~~~~~~~~~~~~~~~~~~~
      truncate_pagecache
   cc1: some warnings being treated as errors

vim +3229 mm/filemap.c

  3163	
  3164	ssize_t
  3165	generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
  3166	{
  3167		struct file	*file = iocb->ki_filp;
  3168		struct address_space *mapping = file->f_mapping;
  3169		struct inode	*inode = mapping->host;
  3170		loff_t		pos = iocb->ki_pos;
  3171		ssize_t		written;
  3172		size_t		write_len;
  3173		pgoff_t		end;
  3174	
  3175		write_len = iov_iter_count(from);
  3176		end = (pos + write_len - 1) >> PAGE_SHIFT;
  3177	
  3178		if (iocb->ki_flags & IOCB_NOWAIT) {
  3179			/* If there are pages to writeback, return */
  3180			if (filemap_range_has_page(inode->i_mapping, pos,
  3181						   pos + write_len - 1))
  3182				return -EAGAIN;
  3183		} else {
  3184			written = filemap_write_and_wait_range(mapping, pos,
  3185								pos + write_len - 1);
  3186			if (written)
  3187				goto out;
  3188		}
  3189	
  3190		/*
  3191		 * After a write we want buffered reads to be sure to go to disk to get
  3192		 * the new data.  We invalidate clean cached page from the region we're
  3193		 * about to write.  We do this *before* the write so that we can return
  3194		 * without clobbering -EIOCBQUEUED from ->direct_IO().
  3195		 */
  3196		written = invalidate_inode_pages2_range(mapping,
  3197						pos >> PAGE_SHIFT, end);
  3198		/*
  3199		 * If a page can not be invalidated, return 0 to fall back
  3200		 * to buffered write.
  3201		 */
  3202		if (written) {
  3203			if (written == -EBUSY)
  3204				return 0;
  3205			goto out;
  3206		}
  3207	
  3208		written = mapping->a_ops->direct_IO(iocb, from);
  3209	
  3210		/*
  3211		 * Finally, try again to invalidate clean pages which might have been
  3212		 * cached by non-direct readahead, or faulted in by get_user_pages()
  3213		 * if the source of the write was an mmap'ed region of the file
  3214		 * we're writing.  Either one is a pretty crazy thing to do,
  3215		 * so we don't support it 100%.  If this invalidation
  3216		 * fails, tough, the write still worked...
  3217		 *
  3218		 * Most of the time we do not need this since dio_complete() will do
  3219		 * the invalidation for us. However there are some file systems that
  3220		 * do not end up with dio_complete() being called, so let's not break
  3221		 * them by removing it completely.
  3222		 *
  3223		 * Noticeable case is a blkdev_direct_IO().
  3224		 *
  3225		 * Skip invalidation for async writes or if mapping has no pages.
  3226		 */
  3227		if (written > 0 && mapping->nrpages &&
  3228		    invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT, end))
> 3229			dio_warn_stale_pagecache(file);
  3230	
  3231		if (written > 0) {
  3232			pos += written;
  3233			write_len -= written;
  3234			if (pos > i_size_read(inode) && !S_ISBLK(inode->i_mode)) {
  3235				i_size_write(inode, pos);
  3236				mark_inode_dirty(inode);
  3237			}
  3238			iocb->ki_pos = pos;
  3239		}
  3240		iov_iter_revert(from, write_len - iov_iter_count(from));
  3241	out:
  3242		return written;
  3243	}
  3244	EXPORT_SYMBOL(generic_file_direct_write);
  3245	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--j23rpqvne5hyng2k
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zdEIqnJn6AjVTo+tExwo/AC2vYUhDWgAAA==

--j23rpqvne5hyng2k--
