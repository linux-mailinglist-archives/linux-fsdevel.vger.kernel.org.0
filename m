Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EC165FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgBTOsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 09:48:00 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:5421 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727705AbgBTOsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:48:00 -0500
X-IronPort-AV: E=Sophos;i="5.70,464,1574118000"; 
   d="scan'208";a="339865431"
Received: from unknown (HELO hadrien) ([132.227.124.212])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 15:47:57 +0100
Date:   Thu, 20 Feb 2020 15:47:56 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Alexey Dobriyan <adobriyan@gmail.com>
cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH] proc: faster open/read/close with "permanent" files
 (fwd)
Message-ID: <alpine.DEB.2.21.2002201546100.2210@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

It looks like an unlock may be needed o lines 721 and 732.

julia

---------- Forwarded message ----------
Hi Alexey,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jeyu/modules-next]
[also build test WARNING on linus/master v5.6-rc2 next-20200218]
[cannot apply to linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Alexey-Dobriyan/proc-faster-open-read-close-with-permanent-files/20200218-231203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
:::::: branch date: 6 hours ago
:::::: commit date: 6 hours ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> fs/proc/generic.c:721:2-8: preceding lock on line 706
   fs/proc/generic.c:732:4-10: preceding lock on line 706
   fs/proc/generic.c:732:4-10: preceding lock on line 748

# https://github.com/0day-ci/linux/commit/3cd4ad42ca7c52d1513e7ba9f08a06197a7380c8
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 3cd4ad42ca7c52d1513e7ba9f08a06197a7380c8
vim +721 fs/proc/generic.c

8ce584c7416d8a Al Viro         2013-03-30  699
8ce584c7416d8a Al Viro         2013-03-30  700  int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
8ce584c7416d8a Al Viro         2013-03-30  701  {
8ce584c7416d8a Al Viro         2013-03-30  702  	struct proc_dir_entry *root = NULL, *de, *next;
8ce584c7416d8a Al Viro         2013-03-30  703  	const char *fn = name;
8ce584c7416d8a Al Viro         2013-03-30  704  	unsigned int len;
8ce584c7416d8a Al Viro         2013-03-30  705
ecf1a3dfff22bd Waiman Long     2015-09-09 @706  	write_lock(&proc_subdir_lock);
8ce584c7416d8a Al Viro         2013-03-30  707  	if (__xlate_proc_name(name, &parent, &fn) != 0) {
ecf1a3dfff22bd Waiman Long     2015-09-09  708  		write_unlock(&proc_subdir_lock);
8ce584c7416d8a Al Viro         2013-03-30  709  		return -ENOENT;
8ce584c7416d8a Al Viro         2013-03-30  710  	}
8ce584c7416d8a Al Viro         2013-03-30  711  	len = strlen(fn);
8ce584c7416d8a Al Viro         2013-03-30  712
710585d4922fd3 Nicolas Dichtel 2014-12-10  713  	root = pde_subdir_find(parent, fn, len);
8ce584c7416d8a Al Viro         2013-03-30  714  	if (!root) {
ecf1a3dfff22bd Waiman Long     2015-09-09  715  		write_unlock(&proc_subdir_lock);
8ce584c7416d8a Al Viro         2013-03-30  716  		return -ENOENT;
8ce584c7416d8a Al Viro         2013-03-30  717  	}
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  718  	if (unlikely(pde_is_permanent(root))) {
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  719  		WARN(1, "removing permanent /proc entry '%s/%s'",
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  720  			root->parent->name, root->name);
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16 @721  		return -EINVAL;
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  722  	}
4f1134370a29a5 Alexey Dobriyan 2018-04-10  723  	rb_erase(&root->subdir_node, &parent->subdir);
710585d4922fd3 Nicolas Dichtel 2014-12-10  724
8ce584c7416d8a Al Viro         2013-03-30  725  	de = root;
8ce584c7416d8a Al Viro         2013-03-30  726  	while (1) {
710585d4922fd3 Nicolas Dichtel 2014-12-10  727  		next = pde_subdir_first(de);
8ce584c7416d8a Al Viro         2013-03-30  728  		if (next) {
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  729  			if (unlikely(pde_is_permanent(root))) {
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  730  				WARN(1, "removing permanent /proc entry '%s/%s'",
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  731  					next->parent->name, next->name);
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  732  				return -EINVAL;
3cd4ad42ca7c52 Alexey Dobriyan 2020-02-16  733  			}
4f1134370a29a5 Alexey Dobriyan 2018-04-10  734  			rb_erase(&next->subdir_node, &de->subdir);
8ce584c7416d8a Al Viro         2013-03-30  735  			de = next;
8ce584c7416d8a Al Viro         2013-03-30  736  			continue;
8ce584c7416d8a Al Viro         2013-03-30  737  		}
8ce584c7416d8a Al Viro         2013-03-30  738  		next = de->parent;
8ce584c7416d8a Al Viro         2013-03-30  739  		if (S_ISDIR(de->mode))
8ce584c7416d8a Al Viro         2013-03-30  740  			next->nlink--;
e06689bf57017a Alexey Dobriyan 2019-12-04  741  		write_unlock(&proc_subdir_lock);
e06689bf57017a Alexey Dobriyan 2019-12-04  742
e06689bf57017a Alexey Dobriyan 2019-12-04  743  		proc_entry_rundown(de);
8ce584c7416d8a Al Viro         2013-03-30  744  		if (de == root)
8ce584c7416d8a Al Viro         2013-03-30  745  			break;
8ce584c7416d8a Al Viro         2013-03-30  746  		pde_put(de);
8ce584c7416d8a Al Viro         2013-03-30  747
ecf1a3dfff22bd Waiman Long     2015-09-09  748  		write_lock(&proc_subdir_lock);
8ce584c7416d8a Al Viro         2013-03-30  749  		de = next;
8ce584c7416d8a Al Viro         2013-03-30  750  	}
8ce584c7416d8a Al Viro         2013-03-30  751  	pde_put(root);
8ce584c7416d8a Al Viro         2013-03-30  752  	return 0;
8ce584c7416d8a Al Viro         2013-03-30  753  }
8ce584c7416d8a Al Viro         2013-03-30  754  EXPORT_SYMBOL(remove_proc_subtree);
4a520d2769beb7 David Howells   2013-04-12  755

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
