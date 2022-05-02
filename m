Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1A516D4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384169AbiEBJ2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384160AbiEBJ2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 05:28:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915733BBF4;
        Mon,  2 May 2022 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651483472; x=1683019472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Un8ROf/YYHiOCU6+fstsqJ861Fy1UPDTbQBPV60OZOg=;
  b=K0YfWsP0Vew4CwH7SRWc5nsuv7s33I55CIGiZeHW007NtVn++ZVIC2CM
   a3zxYYQ8SKy3U7qEC9tR26F4N4txmgIkEuJJsh8zPussV7+raYcpTVupQ
   /6CSpP+xzkwEcDJkAck1uNWMA/QCelU6jFor/KoFd+2ORoo6awi1YkqvI
   EZKVPAoLgTBqdtHUhoMq3sO4iBc5bkOAzwZP9VFIatBb2DrPFIHtEVreL
   Suz7lCNGyqI8OF4Bj18w1AwE6qvRpkLbZKmJewPHw1FZmRfXEOEWS1l1m
   2b94JZT2MYX8zsAVmkC0naqNH4e78bHhgCjHocb2gpmNE/yrcBwjxNKhF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="327704199"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="327704199"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 02:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="546067712"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2022 02:24:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlSI9-0009Rn-Ao;
        Mon, 02 May 2022 09:24:29 +0000
Date:   Mon, 2 May 2022 17:24:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>, miklos@szeredi.hu
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com
Subject: Re: [PATCH v3 3/3] Avoid lookup in d_revalidate()
Message-ID: <202205021705.GXaOa8o4-lkp@intel.com>
References: <20220502054628.25826-4-dharamhans87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502054628.25826-4-dharamhans87@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dharmendra,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.18-rc5]
[cannot apply to mszeredi-fuse/for-next next-20220429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Dharmendra-Singh/FUSE-Implement-atomic-lookup-open-create/20220502-134729
base:    672c0c5173427e6b3e2a9bbb7be51ceeec78093a
config: hexagon-randconfig-r045-20220502 (https://download.01.org/0day-ci/archive/20220502/202205021705.GXaOa8o4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a531ce8124c046dffefe5cd731c952c8f7248c5b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dharmendra-Singh/FUSE-Implement-atomic-lookup-open-create/20220502-134729
        git checkout a531ce8124c046dffefe5cd731c952c8f7248c5b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/fuse/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/fuse/dir.c:571:5: warning: no previous prototype for function 'fuse_do_atomic_common' [-Wmissing-prototypes]
   int fuse_do_atomic_common(struct inode *dir, struct dentry *entry,
       ^
   fs/fuse/dir.c:571:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int fuse_do_atomic_common(struct inode *dir, struct dentry *entry,
   ^
   static 
>> fs/fuse/dir.c:668:63: warning: variable 'fi' is uninitialized when used here [-Wuninitialized]
                   err = fuse_atomic_open_revalidate_inode(reval_inode, entry, fi,
                                                                               ^~
   fs/fuse/dir.c:585:23: note: initialize the variable 'fi' to silence this warning
           struct fuse_inode *fi;
                                ^
                                 = NULL
   2 warnings generated.


vim +/fuse_do_atomic_common +571 fs/fuse/dir.c

   564	
   565	
   566	/*
   567	 * This is common function for initiating atomic operations into libfuse.
   568	 * Currently being used by Atomic create(atomic lookup + create) and
   569	 * Atomic open(atomic lookup + open).
   570	 */
 > 571	int fuse_do_atomic_common(struct inode *dir, struct dentry *entry,
   572				  struct dentry **alias, struct file *file,
   573				  struct inode *reval_inode, unsigned int flags,
   574				  umode_t mode, uint32_t opcode)
   575	{
   576		int err;
   577		struct inode *inode;
   578		struct fuse_mount *fm = get_fuse_mount(dir);
   579		struct fuse_conn *fc = get_fuse_conn(dir);
   580		FUSE_ARGS(args);
   581		struct fuse_forget_link *forget;
   582		struct fuse_create_in inarg;
   583		struct fuse_open_out outopen;
   584		struct fuse_entry_out outentry;
   585		struct fuse_inode *fi;
   586		struct fuse_file *ff;
   587		struct dentry *res = NULL;
   588		void *security_ctx = NULL;
   589		u32 security_ctxlen;
   590		bool atomic_create = (opcode == FUSE_ATOMIC_CREATE ? true : false);
   591		bool create_op = (opcode == FUSE_CREATE ||
   592				  opcode == FUSE_ATOMIC_CREATE) ? true : false;
   593		u64 attr_version = fuse_get_attr_version(fm->fc);
   594	
   595		if (alias)
   596			*alias = NULL;
   597	
   598		/* Userspace expects S_IFREG in create mode */
   599		BUG_ON(create_op && (mode & S_IFMT) != S_IFREG);
   600	
   601		forget = fuse_alloc_forget();
   602		err = -ENOMEM;
   603		if (!forget)
   604			goto out_err;
   605	
   606		err = -ENOMEM;
   607		ff = fuse_file_alloc(fm);
   608		if (!ff)
   609			goto out_put_forget_req;
   610	
   611		if (!fc->dont_mask)
   612			mode &= ~current_umask();
   613	
   614		flags &= ~O_NOCTTY;
   615		memset(&inarg, 0, sizeof(inarg));
   616		memset(&outentry, 0, sizeof(outentry));
   617		inarg.flags = flags;
   618		inarg.mode = mode;
   619		inarg.umask = current_umask();
   620	
   621		if (fm->fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
   622		    !(flags & O_EXCL) && !capable(CAP_FSETID)) {
   623			inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
   624		}
   625	
   626		args.opcode = opcode;
   627		args.nodeid = get_node_id(dir);
   628		args.in_numargs = 2;
   629		args.in_args[0].size = sizeof(inarg);
   630		args.in_args[0].value = &inarg;
   631		args.in_args[1].size = entry->d_name.len + 1;
   632		args.in_args[1].value = entry->d_name.name;
   633		args.out_numargs = 2;
   634		args.out_args[0].size = sizeof(outentry);
   635		args.out_args[0].value = &outentry;
   636		args.out_args[1].size = sizeof(outopen);
   637		args.out_args[1].value = &outopen;
   638	
   639		if (fm->fc->init_security) {
   640			err = get_security_context(entry, mode, &security_ctx,
   641						   &security_ctxlen);
   642			if (err)
   643				goto out_put_forget_req;
   644	
   645			args.in_numargs = 3;
   646			args.in_args[2].size = security_ctxlen;
   647			args.in_args[2].value = security_ctx;
   648		}
   649	
   650		err = fuse_simple_request(fm, &args);
   651		kfree(security_ctx);
   652		if (err)
   653			goto out_free_ff;
   654	
   655		err = -EIO;
   656		if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
   657		    fuse_invalid_attr(&outentry.attr))
   658			goto out_free_ff;
   659	
   660		ff->fh = outopen.fh;
   661		ff->nodeid = outentry.nodeid;
   662		ff->open_flags = outopen.open_flags;
   663	
   664		/* Inode revalidation was bypassed previously for type other than
   665		 * directories, revalidate now as we got fresh attributes.
   666		 */
   667		if (reval_inode) {
 > 668			err = fuse_atomic_open_revalidate_inode(reval_inode, entry, fi,
   669								forget, &outentry,
   670								attr_version);
   671			if (err)
   672				goto out_free_ff;
   673			inode = reval_inode;
   674			kfree(forget);
   675			goto out_finish_open;
   676		}
   677		inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
   678				  &outentry.attr, entry_attr_timeout(&outentry), 0);
   679		if (!inode) {
   680			flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
   681			fuse_sync_release(NULL, ff, flags);
   682			fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
   683			err = -ENOMEM;
   684			goto out_err;
   685		}
   686		kfree(forget);
   687		/*
   688		 * In atomic create, we skipped lookup and it is very much likely that
   689		 * dentry has DCACHE_PAR_LOOKUP flag set on it so call d_splice_alias().
   690		 * Note: Only REG file is allowed under create/atomic create.
   691		 */
   692		/* There is special case when at very first call where we check if
   693		 * atomic create is implemented by USER SPACE/libfuse or not, we
   694		 * skipped lookup. Now, in case where atomic create is not implemented
   695		 * underlying, we fall back to FUSE_CREATE. here we are required to handle
   696		 * DCACHE_PAR_LOOKUP flag.
   697		 */
   698		if (!atomic_create && !d_in_lookup(entry) && fm->fc->no_atomic_create)
   699			d_instantiate(entry, inode);
   700		else {
   701			res = d_splice_alias(inode, entry);
   702			if (res) {
   703				 /* Close the file in user space, but do not unlink it,
   704				  * if it was created - with network file systems other
   705				  * clients might have already accessed it.
   706				  */
   707				if (IS_ERR(res)) {
   708					fi = get_fuse_inode(inode);
   709					fuse_sync_release(fi, ff, flags);
   710					fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
   711					err = PTR_ERR(res);
   712					goto out_err;
   713				}
   714				entry = res;
   715				if (alias)
   716					*alias = res;
   717			}
   718		}
   719		fuse_change_entry_timeout(entry, &outentry);
   720		/*
   721		 * In case of atomic create, we want to indicate directory change
   722		 * only if USER SPACE actually created the file.
   723		 */
   724		if (!atomic_create || (outopen.open_flags & FOPEN_FILE_CREATED))
   725			fuse_dir_changed(dir);
   726		err = finish_open(file, entry, generic_file_open);
   727	out_finish_open:
   728		if (err) {
   729			fi = get_fuse_inode(inode);
   730			fuse_sync_release(fi, ff, flags);
   731		} else {
   732			file->private_data = ff;
   733			fuse_finish_open(inode, file);
   734		}
   735		return err;
   736	
   737	out_free_ff:
   738		fuse_file_free(ff);
   739	out_put_forget_req:
   740		kfree(forget);
   741	out_err:
   742		return err;
   743	}
   744	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
