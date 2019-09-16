Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DCAB4081
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfIPSoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:44:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:51168 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbfIPSoy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:44:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 11:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="gz'50?scan'50,208,50";a="198428975"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 11:44:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i9vzV-000Eep-QN; Tue, 17 Sep 2019 02:44:49 +0800
Date:   Tue, 17 Sep 2019 02:44:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:fixes 2/2] fs/libfs.c:113:4: note: in expansion of macro
 'lockref_get_nested'
Message-ID: <201909170209.ohZzVon0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2l3duro6hhm5qmuh"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--2l3duro6hhm5qmuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/viro/vfs.git fixes
head:   123a084a6b2a8c93285976f28b61bd30ea4368d9
commit: 123a084a6b2a8c93285976f28b61bd30ea4368d9 [2/2] Fix the locking in dcache_readdir() and friends
config: i386-defconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
reproduce:
        git checkout 123a084a6b2a8c93285976f28b61bd30ea4368d9
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/dcache.h:13:0,
                    from include/linux/fs.h:8,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:587,
                    from include/linux/bvec.h:13,
                    from include/linux/blk_types.h:10,
                    from include/linux/genhd.h:19,
                    from include/linux/blkdev.h:11,
                    from fs/libfs.c:7:
   fs/libfs.c: In function 'scan_positives':
>> include/linux/lockref.h:47:33: error: 'lock' undeclared (first use in this function); did you mean 'sock'?
     lockref_get(((void)(subclass),(lock)))
                                    ^
>> fs/libfs.c:113:4: note: in expansion of macro 'lockref_get_nested'
       lockref_get_nested(&d->d_lockref, DENTRY_D_LOCK_NESTED);
       ^~~~~~~~~~~~~~~~~~
   include/linux/lockref.h:47:33: note: each undeclared identifier is reported only once for each function it appears in
     lockref_get(((void)(subclass),(lock)))
                                    ^
>> fs/libfs.c:113:4: note: in expansion of macro 'lockref_get_nested'
       lockref_get_nested(&d->d_lockref, DENTRY_D_LOCK_NESTED);
       ^~~~~~~~~~~~~~~~~~

vim +/lockref_get_nested +113 fs/libfs.c

   > 7	#include <linux/blkdev.h>
     8	#include <linux/export.h>
     9	#include <linux/pagemap.h>
    10	#include <linux/slab.h>
    11	#include <linux/cred.h>
    12	#include <linux/mount.h>
    13	#include <linux/vfs.h>
    14	#include <linux/quotaops.h>
    15	#include <linux/mutex.h>
    16	#include <linux/namei.h>
    17	#include <linux/exportfs.h>
    18	#include <linux/writeback.h>
    19	#include <linux/buffer_head.h> /* sync_mapping_buffers */
    20	#include <linux/fs_context.h>
    21	#include <linux/pseudo_fs.h>
    22	
    23	#include <linux/uaccess.h>
    24	
    25	#include "internal.h"
    26	
    27	int simple_getattr(const struct path *path, struct kstat *stat,
    28			   u32 request_mask, unsigned int query_flags)
    29	{
    30		struct inode *inode = d_inode(path->dentry);
    31		generic_fillattr(inode, stat);
    32		stat->blocks = inode->i_mapping->nrpages << (PAGE_SHIFT - 9);
    33		return 0;
    34	}
    35	EXPORT_SYMBOL(simple_getattr);
    36	
    37	int simple_statfs(struct dentry *dentry, struct kstatfs *buf)
    38	{
    39		buf->f_type = dentry->d_sb->s_magic;
    40		buf->f_bsize = PAGE_SIZE;
    41		buf->f_namelen = NAME_MAX;
    42		return 0;
    43	}
    44	EXPORT_SYMBOL(simple_statfs);
    45	
    46	/*
    47	 * Retaining negative dentries for an in-memory filesystem just wastes
    48	 * memory and lookup time: arrange for them to be deleted immediately.
    49	 */
    50	int always_delete_dentry(const struct dentry *dentry)
    51	{
    52		return 1;
    53	}
    54	EXPORT_SYMBOL(always_delete_dentry);
    55	
    56	const struct dentry_operations simple_dentry_operations = {
    57		.d_delete = always_delete_dentry,
    58	};
    59	EXPORT_SYMBOL(simple_dentry_operations);
    60	
    61	/*
    62	 * Lookup the data. This is trivial - if the dentry didn't already
    63	 * exist, we know it is negative.  Set d_op to delete negative dentries.
    64	 */
    65	struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
    66	{
    67		if (dentry->d_name.len > NAME_MAX)
    68			return ERR_PTR(-ENAMETOOLONG);
    69		if (!dentry->d_sb->s_d_op)
    70			d_set_d_op(dentry, &simple_dentry_operations);
    71		d_add(dentry, NULL);
    72		return NULL;
    73	}
    74	EXPORT_SYMBOL(simple_lookup);
    75	
    76	int dcache_dir_open(struct inode *inode, struct file *file)
    77	{
    78		file->private_data = d_alloc_cursor(file->f_path.dentry);
    79	
    80		return file->private_data ? 0 : -ENOMEM;
    81	}
    82	EXPORT_SYMBOL(dcache_dir_open);
    83	
    84	int dcache_dir_close(struct inode *inode, struct file *file)
    85	{
    86		dput(file->private_data);
    87		return 0;
    88	}
    89	EXPORT_SYMBOL(dcache_dir_close);
    90	
    91	/* parent is locked at least shared */
    92	/*
    93	 * Returns an element of siblings' list.
    94	 * We are looking for <count>th positive after <p>; if
    95	 * found, dentry is grabbed and passed to caller via *<res>.
    96	 * If no such element exists, the anchor of list is returned
    97	 * and *<res> is set to NULL.
    98	 */
    99	static struct list_head *scan_positives(struct dentry *cursor,
   100						struct list_head *p,
   101						loff_t count,
   102						struct dentry **res)
   103	{
   104		struct dentry *dentry = cursor->d_parent, *found = NULL;
   105	
   106		spin_lock(&dentry->d_lock);
   107		while ((p = p->next) != &dentry->d_subdirs) {
   108			struct dentry *d = list_entry(p, struct dentry, d_child);
   109			// we must at least skip cursors, to avoid livelocks
   110			if (d->d_flags & DCACHE_DENTRY_CURSOR)
   111				continue;
   112			if (simple_positive(d) && !--count) {
 > 113				lockref_get_nested(&d->d_lockref, DENTRY_D_LOCK_NESTED);
   114				found = d;
   115				break;
   116			}
   117			if (need_resched()) {
   118				list_move(&cursor->d_child, p);
   119				p = &cursor->d_child;
   120				spin_unlock(&dentry->d_lock);
   121				cond_resched();
   122				spin_lock(&dentry->d_lock);
   123			}
   124		}
   125		spin_unlock(&dentry->d_lock);
   126		dput(*res);
   127		*res = found;
   128		return p;
   129	}
   130	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--2l3duro6hhm5qmuh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
k3V67DBuzJ6yMv4fVarHjbTWAQA=

--2l3duro6hhm5qmuh--
