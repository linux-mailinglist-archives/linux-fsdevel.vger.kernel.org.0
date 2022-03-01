Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7E4C8FAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 17:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiCAQH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 11:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiCAQH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:07:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA19F6EA;
        Tue,  1 Mar 2022 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646150806; x=1677686806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j7+mghICr3KLO5uiQDA8PUTR39Oz0pF35skb9c2hCA0=;
  b=kT7GSvHqM3RkT5sOASozHsVu3VvxSWg5zST9fA5pq39EYBARcUKp8teZ
   yi4LNrJ8ufOU8XQnS/bcB60t4r0nV0rnbhpNCxJ+fRiW3oDtZWkuGO/Uq
   xjz5uM6RLtnbTzuROMpu0jKwAj3wHK/0iu9DLXo4MUrYD3mzmleSmHEk3
   kCCOSm+azF437XJR0z29ee/zbbh7weKIMJy/BFVIxjtnd74p1MSyqAz/D
   dXn1NcJrKYUw6cyaeARt6r0TuYwAx55sL4h//4XYiH+J3S+gtpiEyWbYc
   aXKPwkzZZNuEXzoSVu4Df2bDKs7353EhsJBFADcQdki3RXYy+FDAwAu36
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236672239"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="236672239"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630063751"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Mar 2022 08:06:32 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP51D-0000fk-8r; Tue, 01 Mar 2022 16:06:31 +0000
Date:   Wed, 2 Mar 2022 00:06:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meng Tang <tangmeng@uniontech.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: Re: [PATCH v2 1/2] fs/proc: optimize exactly register one ctl_table
Message-ID: <202203012340.8d5kZylK-lkp@intel.com>
References: <20220301115341.30101-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301115341.30101-1-tangmeng@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Meng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mcgrof/sysctl-next]
[also build test WARNING on jack-fs/fsnotify rostedt-trace/for-next linus/master v5.17-rc6 next-20220301]
[cannot apply to kees/for-next/pstore]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Meng-Tang/fs-proc-optimize-exactly-register-one-ctl_table/20220301-195515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
config: hexagon-randconfig-r045-20220301 (https://download.01.org/0day-ci/archive/20220301/202203012340.8d5kZylK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d9e9a410cf46b383390d668770fff70540e27528
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Meng-Tang/fs-proc-optimize-exactly-register-one-ctl_table/20220301-195515
        git checkout d9e9a410cf46b383390d668770fff70540e27528
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/proc/proc_sysctl.c:1281:6: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
           int len = strlen(table->procname) + 1;
               ^
   fs/proc/proc_sysctl.c:1638:26: warning: no previous prototype for function '__register_sysctl_table_single' [-Wmissing-prototypes]
   struct ctl_table_header *__register_sysctl_table_single(
                            ^
   fs/proc/proc_sysctl.c:1638:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct ctl_table_header *__register_sysctl_table_single(
   ^
   static 
   fs/proc/proc_sysctl.c:1988:27: warning: mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
           struct ctl_table_header *link_head;
                                    ^
   3 warnings generated.


vim +1281 fs/proc/proc_sysctl.c

  1256	
  1257	static struct ctl_table_header *new_links_single(struct ctl_dir *dir, struct ctl_table *table,
  1258		struct ctl_table_root *link_root)
  1259	{
  1260		struct ctl_table *link_table;
  1261		struct ctl_table_header *links;
  1262		struct ctl_node *node;
  1263		char *link_name;
  1264		int name_bytes = 0;
  1265	
  1266		name_bytes += strlen(table->procname) + 1;
  1267	
  1268		links = kzalloc(sizeof(struct ctl_table_header) +
  1269				sizeof(struct ctl_node) +
  1270				sizeof(struct ctl_table)*2 +
  1271				name_bytes,
  1272				GFP_KERNEL);
  1273	
  1274		if (!links)
  1275			return NULL;
  1276	
  1277		node = (struct ctl_node *)(links + 1);
  1278		link_table = (struct ctl_table *)(node + 1);
  1279		link_name = (char *)&link_table[2];
  1280	
> 1281		int len = strlen(table->procname) + 1;
  1282	
  1283		memcpy(link_name, table->procname, len);
  1284		link_table->procname = link_name;
  1285		link_table->mode = S_IFLNK|S_IRWXUGO;
  1286		link_table->data = link_root;
  1287		link_name += len;
  1288	
  1289		init_header_single(links, dir->header.root, dir->header.set, node, link_table);
  1290		links->nreg = 1;
  1291	
  1292		return links;
  1293	}
  1294	static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table *table,
  1295		struct ctl_table_root *link_root)
  1296	{
  1297		struct ctl_table *link_table, *entry, *link;
  1298		struct ctl_table_header *links;
  1299		struct ctl_node *node;
  1300		char *link_name;
  1301		int nr_entries, name_bytes;
  1302	
  1303		name_bytes = 0;
  1304		nr_entries = 0;
  1305		for (entry = table; entry->procname; entry++) {
  1306			nr_entries++;
  1307			name_bytes += strlen(entry->procname) + 1;
  1308		}
  1309	
  1310		links = kzalloc(sizeof(struct ctl_table_header) +
  1311				sizeof(struct ctl_node)*nr_entries +
  1312				sizeof(struct ctl_table)*(nr_entries + 1) +
  1313				name_bytes,
  1314				GFP_KERNEL);
  1315	
  1316		if (!links)
  1317			return NULL;
  1318	
  1319		node = (struct ctl_node *)(links + 1);
  1320		link_table = (struct ctl_table *)(node + nr_entries);
  1321		link_name = (char *)&link_table[nr_entries + 1];
  1322	
  1323		for (link = link_table, entry = table; entry->procname; link++, entry++) {
  1324			int len = strlen(entry->procname) + 1;
  1325			memcpy(link_name, entry->procname, len);
  1326			link->procname = link_name;
  1327			link->mode = S_IFLNK|S_IRWXUGO;
  1328			link->data = link_root;
  1329			link_name += len;
  1330		}
  1331		init_header(links, dir->header.root, dir->header.set, node, link_table);
  1332		links->nreg = nr_entries;
  1333	
  1334		return links;
  1335	}
  1336	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
