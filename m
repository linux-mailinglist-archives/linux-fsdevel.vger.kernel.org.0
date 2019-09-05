Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B835AAD78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 22:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbfIEU5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 16:57:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:58152 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfIEU5B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:57:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 13:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="gz'50?scan'50,208,50";a="212919069"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Sep 2019 13:56:59 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i5yoM-000EGt-Ou; Fri, 06 Sep 2019 04:56:58 +0800
Date:   Fri, 6 Sep 2019 04:56:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kbuild-all@01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 2/3] mm: Allow large pages to be added to the page cache
Message-ID: <201909060430.ZRV06fap%lkp@intel.com>
References: <20190905182348.5319-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wawj4yvmoihvxujs"
Content-Disposition: inline
In-Reply-To: <20190905182348.5319-3-willy@infradead.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--wawj4yvmoihvxujs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc7 next-20190904]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox/mm-Add-__page_cache_alloc_order/20190906-034745
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/filemap.c: In function '__add_to_page_cache_locked':
>> mm/filemap.c:863:8: error: implicit declaration of function 'compound_nr'; did you mean 'compound_order'? [-Werror=implicit-function-declaration]
      nr = compound_nr(page);
           ^~~~~~~~~~~
           compound_order
   cc1: some warnings being treated as errors

vim +863 mm/filemap.c

   840	
   841	static int __add_to_page_cache_locked(struct page *page,
   842					      struct address_space *mapping,
   843					      pgoff_t offset, gfp_t gfp_mask,
   844					      void **shadowp)
   845	{
   846		XA_STATE(xas, &mapping->i_pages, offset);
   847		int huge = PageHuge(page);
   848		struct mem_cgroup *memcg;
   849		int error;
   850		unsigned int nr = 1;
   851		void *old;
   852	
   853		VM_BUG_ON_PAGE(!PageLocked(page), page);
   854		VM_BUG_ON_PAGE(PageSwapBacked(page), page);
   855		mapping_set_update(&xas, mapping);
   856	
   857		if (!huge) {
   858			error = mem_cgroup_try_charge(page, current->mm,
   859						      gfp_mask, &memcg, false);
   860			if (error)
   861				return error;
   862			xas_set_order(&xas, offset, compound_order(page));
 > 863			nr = compound_nr(page);
   864		}
   865	
   866		page_ref_add(page, nr);
   867		page->mapping = mapping;
   868		page->index = offset;
   869	
   870		do {
   871			unsigned long exceptional = 0;
   872			unsigned int i = 0;
   873	
   874			xas_lock_irq(&xas);
   875			xas_for_each_conflict(&xas, old) {
   876				if (!xa_is_value(old))
   877					break;
   878				exceptional++;
   879				if (shadowp)
   880					*shadowp = old;
   881			}
   882			if (old) {
   883				xas_set_err(&xas, -EEXIST);
   884				break;
   885			}
   886			xas_create_range(&xas);
   887			if (xas_error(&xas))
   888				goto unlock;
   889	
   890	next:
   891			xas_store(&xas, page);
   892			if (++i < nr) {
   893				xas_next(&xas);
   894				goto next;
   895			}
   896			mapping->nrexceptional -= exceptional;
   897			mapping->nrpages += nr;
   898	
   899			/* hugetlb pages do not participate in page cache accounting */
   900			if (!huge)
   901				__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES,
   902							nr);
   903	unlock:
   904			xas_unlock_irq(&xas);
   905		} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
   906	
   907		if (xas_error(&xas))
   908			goto error;
   909	
   910		if (!huge)
   911			mem_cgroup_commit_charge(page, memcg, false, false);
   912		trace_mm_filemap_add_to_page_cache(page);
   913		return 0;
   914	error:
   915		page->mapping = NULL;
   916		/* Leave page->index set: truncation relies upon it */
   917		if (!huge)
   918			mem_cgroup_cancel_charge(page, memcg, false);
   919		page_ref_sub(page, nr);
   920		return xas_error(&xas);
   921	}
   922	ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
   923	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wawj4yvmoihvxujs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ZwAA

--wawj4yvmoihvxujs--
