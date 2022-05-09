Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C9D51F777
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiEIJD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiEII6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 04:58:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538795591;
        Mon,  9 May 2022 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652086500; x=1683622500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=omO61hzV+UljbcYfTh08uNWMvUL4JKnKkpoJBGWt0AA=;
  b=Jg7H4WFJYOX9knM2jZFufdgatB4v6I2Z/CVsNsYArfvWTjxDkfWvmjUQ
   LzA/Exhhx804m9g/tNaa6tlgerIJd2a8/gTXzE2am25sviA438Db9NEBF
   +3vI+yicO4tcOQ808ZnpOwLphRfpK47jR7nHJ0RctYD8WEWl1ZPMBGktA
   GJF48hbxLIKoEoyEg7C3jNi/OvKcUFglGk10jBeteXQnjiA63lDf7dtfS
   AVzP5mAfYUq0SSoYsoPLlci071j3rXw0unh4lLXbyNDaUTX/y5aBQQNef
   3x9zK/SxcgJqcE5W6SY84II4PwUFGJGVFeaaATcSicIMBApv53bsN6a0w
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="248889274"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="248889274"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 01:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="564955542"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 May 2022 01:54:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnzA2-000GMq-Sf;
        Mon, 09 May 2022 08:54:34 +0000
Date:   Mon, 9 May 2022 16:53:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhanglin <zhang.lin16@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, adobriyan@gmail.com, sfr@canb.auug.org.au,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        kaleshsingh@google.com, stephen.s.brennan@oracle.com,
        ohoono.kwon@samsung.com, haolee.swjtu@gmail.com,
        fweimer@redhat.com, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn, zealci@zte.com.cn,
        zhanglin <zhang.lin16@zte.com.cn>
Subject: Re: [PATCH] fs/proc: add mask_secrets to prevent sensitive
 information leakage.
Message-ID: <202205091652.nHbogdH5-lkp@intel.com>
References: <20220509054613.6620-1-zhang.lin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509054613.6620-1-zhang.lin16@zte.com.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi zhanglin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on akpm-mm/mm-everything hnaz-mm/master linus/master v5.18-rc6 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/zhanglin/fs-proc-add-mask_secrets-to-prevent-sensitive-information-leakage/20220509-140823
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220509/202205091652.nHbogdH5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8d1c429178d1ee0c447ee68f4e7b602c5df911f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhanglin/fs-proc-add-mask_secrets-to-prevent-sensitive-information-leakage/20220509-140823
        git checkout f8d1c429178d1ee0c447ee68f4e7b602c5df911f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/proc/mask_secrets.c:49:8: warning: no previous prototype for 'mask_secrets' [-Wmissing-prototypes]
      49 | size_t mask_secrets(struct mm_struct *mm, char __user *buf,
         |        ^~~~~~~~~~~~
   fs/proc/mask_secrets.c: In function 'mask_secrets':
>> fs/proc/mask_secrets.c:71:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
      71 |         int err = 0;
         |             ^~~


vim +/mask_secrets +49 fs/proc/mask_secrets.c

    48	
  > 49	size_t mask_secrets(struct mm_struct *mm, char __user *buf,
    50				      size_t count, loff_t pos)
    51	{
    52		unsigned long arg_start = 0;
    53		unsigned long arg_end = 0;
    54		int mask_arg_len = 0;
    55		size_t remote_vm_copied = 0;
    56		struct file *file = 0;
    57		struct inode *inode = 0;
    58		char *kbuf = 0;
    59		char *progname = 0;
    60		int proghash = -1;
    61		int prog_found = 0;
    62		char *mask_arg_start = 0;
    63		char *mask_arg_end = 0;
    64		struct cmdline_hashtab_item *chi = 0;
    65		char *psecret = 0;
    66		size_t psecret_len = 0;
    67		char *pmask = 0;
    68		size_t pmask_len = 0;
    69		size_t size;
    70		size_t total_copied = 0;
  > 71		int err = 0;
    72	
    73		if (!is_mask_secrets_enabled()) {
    74			err = -EPERM;
    75			goto exit_err;
    76		}
    77	
    78		spin_lock(&mm->arg_lock);
    79		arg_start = mm->arg_start;
    80		arg_end = mm->arg_end;
    81		spin_unlock(&mm->arg_lock);
    82		if (arg_start >= arg_end) {
    83			err = -ERANGE;
    84			goto exit_err;
    85		}
    86		mask_arg_len = arg_end - arg_start + 1;
    87	
    88		file = get_mm_exe_file(mm);
    89		if (!file) {
    90			err = -ENOENT;
    91			goto exit_err;
    92		}
    93		inode = file_inode(file);
    94		if (!inode) {
    95			err = -ENOENT;
    96			goto exit_err;
    97		}
    98		proghash = cmdline_hash(inode->i_ino);
    99		kbuf = kzalloc(max(PATH_MAX, mask_arg_len), GFP_KERNEL);
   100		if (!kbuf) {
   101			err = -ENOMEM;
   102			goto exit_err;
   103		}
   104		progname = d_path(&file->f_path, kbuf, PATH_MAX);
   105		if (IS_ERR_OR_NULL(progname)) {
   106			err = -ENOENT;
   107			goto cleanup_kbuf;
   108		}
   109	
   110		rcu_read_lock();
   111		prog_found = 0;
   112		hash_for_each_possible_rcu(cmdline_hashtab, chi, hlist, proghash)
   113			if (strcmp(chi->progname, progname) == 0) {
   114				prog_found = 1;
   115				break;
   116			}
   117	
   118		if (!prog_found) {
   119			rcu_read_unlock();
   120			goto cleanup_kbuf;
   121		}
   122	
   123		mask_arg_start = kbuf;
   124		mask_arg_end = mask_arg_start + (arg_end - arg_start);
   125		remote_vm_copied = access_remote_vm(mm, arg_start, mask_arg_start, mask_arg_len, FOLL_ANON);
   126		if (remote_vm_copied <= 0) {
   127			rcu_read_unlock();
   128			err = -EIO;
   129			goto cleanup_kbuf;
   130		}
   131		/*skip progname */
   132		for (pmask = mask_arg_start; *pmask && (pmask <= mask_arg_end); pmask++)
   133			;
   134	
   135		if (!chi->secrets) {
   136			rcu_read_unlock();
   137			/*mask everything, such as: xxxconnect host port username password.*/
   138			for (pmask = pmask + 1; (pmask <= mask_arg_end); pmask++)
   139				for (; (pmask <= mask_arg_end) && (*pmask); pmask++)
   140					*pmask = 'Z';
   141			goto copydata;
   142		}
   143	
   144		for (pmask = pmask + 1; pmask <= mask_arg_end; pmask++) {
   145			psecret = chi->secrets;
   146			while (*psecret) {
   147				psecret_len = strlen(psecret);
   148				if (psecret_len < 2) {
   149					rcu_read_unlock();
   150					err = -EINVAL;
   151					goto cleanup_kbuf;
   152				}
   153	
   154				if (strcmp(pmask, psecret) == 0) {
   155					pmask += psecret_len + 1;
   156					goto mask_secret;
   157				}
   158	
   159				if (strncmp(pmask, psecret, psecret_len) == 0) {
   160					/*handle case: --password=xxxx */
   161					if ((psecret[0] == '-') && (psecret[1] == '-'))
   162						if (pmask[psecret_len] == '=') {
   163							pmask += psecret_len + 1;
   164							goto mask_secret;
   165						}
   166	
   167					if (psecret[0] == '-') {
   168						/*handle case: -password=xxxx or -p=xxxx*/
   169						if (pmask[psecret_len] == '=') {
   170							pmask += psecret_len + 1;
   171							goto mask_secret;
   172						}
   173	
   174						/*handle case: -pxxxx*/
   175						if (psecret_len == 2) {
   176							pmask += psecret_len;
   177							goto mask_secret;
   178						}
   179					}
   180				}
   181	
   182				if (psecret_len == 2) {
   183					pmask_len = strlen(pmask);
   184					/*handle case: -yp xxxx, such as: useradd -rp xxxx*/
   185					if ((pmask_len > 2) && (*pmask == '-')
   186					      && (pmask[pmask_len - 1] == psecret[1])) {
   187						pmask += pmask_len + 1;
   188						goto mask_secret;
   189					}
   190				}
   191	
   192				psecret += psecret_len + 1;
   193			}
   194	
   195			pmask += strlen(pmask);
   196			continue;
   197	
   198	mask_secret:
   199			for (; (pmask <= mask_arg_end) && (*pmask); pmask++)
   200				*pmask = 'Z';
   201		}
   202		rcu_read_unlock();
   203	
   204	copydata:
   205		size = arg_end - pos;
   206		size = min_t(size_t, size, count);
   207		if (copy_to_user(buf, mask_arg_start + pos - arg_start, size))
   208			goto cleanup_kbuf;
   209	
   210		total_copied = size;
   211	
   212	cleanup_kbuf:
   213		kfree(kbuf);
   214	
   215	exit_err:
   216		return total_copied;
   217	}
   218	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
