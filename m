Return-Path: <linux-fsdevel+bounces-21872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7590CA5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 13:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF894283F52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 11:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8193314533D;
	Tue, 18 Jun 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLlXO0Bi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B03142636;
	Tue, 18 Jun 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710318; cv=none; b=XoZwA986u17yv7VhtRwmSahAah+XqhKU0Kxld2RcRN9H7rXAiyr3uZUAV7axHZ/3nLTEi00vnTw6rsE2/rE+UiUPZaz/DuKviWdkr3N8ekGTU05xCY6lneB0GuI2t16VDRmLx8YJDyOMV8QB6JSPXjb2t9ze8rPR5vN3jU+IpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710318; c=relaxed/simple;
	bh=+u+w++YM6IO4jdHfMRRceq5IF1mr3qwlKMhbvu6kNKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqIUEZpcTdquXg0IXcSe17t3YWLGnHmpsxTB+V0Yje/YmVmjXmHUjqqb+VzouhPkVd9g6JxC1GNPgQK3DAfgkF93JrEYneqyG0AvwQO61EX7D6g/+w8sM7SUCsg9if1aHwfcri44riLQJXutziaLV5AdzjqWJwf3AejmzDsd9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLlXO0Bi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718710316; x=1750246316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+u+w++YM6IO4jdHfMRRceq5IF1mr3qwlKMhbvu6kNKk=;
  b=lLlXO0BiK6y6wc8KfLiR2uqbhMqpHvZQULeOMZOnTcq1xrYfEnqgCaGn
   1ZyzzPm4m9T+HG1/KCAIr1CpTb6gH7e8i+RNO0vAUF/rM7SF3hRYlslJl
   Iyl/UaMZCXQFOwGzXBjjsIkSFDCiGDBOYJweQphmxZD1oin62pnPHbaGq
   zhjlOhH1jHv662PPSWsJYt1I5+JZBAc140cj4e9adrPLtwVrvG/xIFK+v
   3wXPC2GoYwqPDu0gWlmzGgYtp5KA/vANvubj862/LsJYVXz4c+KcXy5Ci
   vD2nQutNOQ0eVukmSNx+i1IxC50aX9btq6bne9oOe12KCG95SUCIL5ge+
   w==;
X-CSE-ConnectionGUID: fY/GH6zKREa+TWzjOmm98w==
X-CSE-MsgGUID: Qp1jrjJZQ3CJaoo0JelqEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26209677"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26209677"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:31:55 -0700
X-CSE-ConnectionGUID: hxTG5oDVQwWQ1SxGr5TtFg==
X-CSE-MsgGUID: rI+zvokSR1eQHDd6UcOhWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42236567"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2024 04:31:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJX3z-0005Sf-0B;
	Tue, 18 Jun 2024 11:31:47 +0000
Date: Tue, 18 Jun 2024 19:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>, akpm@linux-foundation.org,
	apais@linux.microsoft.com, ardb@kernel.org, bigeasy@linutronix.de,
	brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nagvijay@microsoft.com, oleg@redhat.com, tandersen@netflix.com,
	vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	apais@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: Re: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
Message-ID: <202406181954.9Z65WD4Z-lkp@intel.com>
References: <20240617234133.1167523-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617234133.1167523-2-romank@linux.microsoft.com>

Hi Roman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 831bcbcead6668ebf20b64fdb27518f1362ace3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kisel/binfmt_elf-coredump-Log-the-reason-of-the-failed-core-dumps/20240618-074419
base:   831bcbcead6668ebf20b64fdb27518f1362ace3a
patch link:    https://lore.kernel.org/r/20240617234133.1167523-2-romank%40linux.microsoft.com
patch subject: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed core dumps
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240618/202406181954.9Z65WD4Z-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 78ee473784e5ef6f0b19ce4cb111fb6e4d23c6b2)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240618/202406181954.9Z65WD4Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406181954.9Z65WD4Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/coredump.c:6:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/coredump.c:816:32: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
     815 |         pr_info("Core dump to |%s: vma_count %d, vma_data_size %lu, written %lld bytes, pos %lld\n",
         |                                                                ~~~
         |                                                                %zu
     816 |                 cn.corename, cprm.vma_count, cprm.vma_data_size, cprm.written, cprm.pos);
         |                                              ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:537:34: note: expanded from macro 'pr_info'
     537 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                 ~~~     ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
     464 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +816 fs/coredump.c

   521	
   522	int do_coredump(const kernel_siginfo_t *siginfo)
   523	{
   524		struct core_state core_state;
   525		struct core_name cn;
   526		struct mm_struct *mm = current->mm;
   527		struct linux_binfmt * binfmt;
   528		const struct cred *old_cred;
   529		struct cred *cred;
   530		int retval;
   531		int ispipe;
   532		size_t *argv = NULL;
   533		int argc = 0;
   534		/* require nonrelative corefile path and be extra careful */
   535		bool need_suid_safe = false;
   536		bool core_dumped = false;
   537		static atomic_t core_dump_count = ATOMIC_INIT(0);
   538		struct coredump_params cprm = {
   539			.siginfo = siginfo,
   540			.limit = rlimit(RLIMIT_CORE),
   541			/*
   542			 * We must use the same mm->flags while dumping core to avoid
   543			 * inconsistency of bit flags, since this flag is not protected
   544			 * by any locks.
   545			 */
   546			.mm_flags = mm->flags,
   547			.vma_meta = NULL,
   548			.cpu = raw_smp_processor_id(),
   549		};
   550	
   551		audit_core_dumps(siginfo->si_signo);
   552	
   553		binfmt = mm->binfmt;
   554		if (!binfmt || !binfmt->core_dump) {
   555			retval = -ENOEXEC;
   556			goto fail;
   557		}
   558		if (!__get_dumpable(cprm.mm_flags)) {
   559			retval = -EACCES;
   560			goto fail;
   561		}
   562	
   563		cred = prepare_creds();
   564		if (!cred) {
   565			retval = -EPERM;
   566			goto fail;
   567		}
   568		/*
   569		 * We cannot trust fsuid as being the "true" uid of the process
   570		 * nor do we know its entire history. We only know it was tainted
   571		 * so we dump it as root in mode 2, and only into a controlled
   572		 * environment (pipe handler or fully qualified path).
   573		 */
   574		if (__get_dumpable(cprm.mm_flags) == SUID_DUMP_ROOT) {
   575			/* Setuid core dump mode */
   576			cred->fsuid = GLOBAL_ROOT_UID;	/* Dump root private */
   577			need_suid_safe = true;
   578		}
   579	
   580		retval = coredump_wait(siginfo->si_signo, &core_state);
   581		if (retval < 0)
   582			goto fail_creds;
   583	
   584		old_cred = override_creds(cred);
   585	
   586		ispipe = format_corename(&cn, &cprm, &argv, &argc);
   587	
   588		if (ispipe) {
   589			int argi;
   590			int dump_count;
   591			char **helper_argv;
   592			struct subprocess_info *sub_info;
   593	
   594			if (ispipe < 0) {
   595				printk(KERN_WARNING "format_corename failed\n");
   596				printk(KERN_WARNING "Aborting core\n");
   597				retval = ispipe;
   598				goto fail_unlock;
   599			}
   600	
   601			if (cprm.limit == 1) {
   602				/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
   603				 *
   604				 * Normally core limits are irrelevant to pipes, since
   605				 * we're not writing to the file system, but we use
   606				 * cprm.limit of 1 here as a special value, this is a
   607				 * consistent way to catch recursive crashes.
   608				 * We can still crash if the core_pattern binary sets
   609				 * RLIM_CORE = !1, but it runs as root, and can do
   610				 * lots of stupid things.
   611				 *
   612				 * Note that we use task_tgid_vnr here to grab the pid
   613				 * of the process group leader.  That way we get the
   614				 * right pid if a thread in a multi-threaded
   615				 * core_pattern process dies.
   616				 */
   617				printk(KERN_WARNING
   618					"Process %d(%s) has RLIMIT_CORE set to 1\n",
   619					task_tgid_vnr(current), current->comm);
   620				printk(KERN_WARNING "Aborting core\n");
   621				retval = -EPERM;
   622				goto fail_unlock;
   623			}
   624			cprm.limit = RLIM_INFINITY;
   625	
   626			dump_count = atomic_inc_return(&core_dump_count);
   627			if (core_pipe_limit && (core_pipe_limit < dump_count)) {
   628				printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
   629				       task_tgid_vnr(current), current->comm);
   630				printk(KERN_WARNING "Skipping core dump\n");
   631				retval = -E2BIG;
   632				goto fail_dropcount;
   633			}
   634	
   635			helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
   636						    GFP_KERNEL);
   637			if (!helper_argv) {
   638				printk(KERN_WARNING "%s failed to allocate memory\n",
   639				       __func__);
   640				retval = -ENOMEM;
   641				goto fail_dropcount;
   642			}
   643			for (argi = 0; argi < argc; argi++)
   644				helper_argv[argi] = cn.corename + argv[argi];
   645			helper_argv[argi] = NULL;
   646	
   647			retval = -ENOMEM;
   648			sub_info = call_usermodehelper_setup(helper_argv[0],
   649							helper_argv, NULL, GFP_KERNEL,
   650							umh_pipe_setup, NULL, &cprm);
   651			if (sub_info)
   652				retval = call_usermodehelper_exec(sub_info,
   653								  UMH_WAIT_EXEC);
   654	
   655			kfree(helper_argv);
   656			if (retval) {
   657				printk(KERN_INFO "Core dump to |%s pipe failed\n",
   658				       cn.corename);
   659				goto close_fail;
   660			}
   661		} else {
   662			struct mnt_idmap *idmap;
   663			struct inode *inode;
   664			int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
   665					 O_LARGEFILE | O_EXCL;
   666	
   667			if (cprm.limit < binfmt->min_coredump) {
   668				retval = -E2BIG;
   669				goto fail_unlock;
   670			}
   671	
   672			if (need_suid_safe && cn.corename[0] != '/') {
   673				printk(KERN_WARNING "Pid %d(%s) can only dump core "\
   674					"to fully qualified path!\n",
   675					task_tgid_vnr(current), current->comm);
   676				printk(KERN_WARNING "Skipping core dump\n");
   677				retval = -EPERM;
   678				goto fail_unlock;
   679			}
   680	
   681			/*
   682			 * Unlink the file if it exists unless this is a SUID
   683			 * binary - in that case, we're running around with root
   684			 * privs and don't want to unlink another user's coredump.
   685			 */
   686			if (!need_suid_safe) {
   687				/*
   688				 * If it doesn't exist, that's fine. If there's some
   689				 * other problem, we'll catch it at the filp_open().
   690				 */
   691				do_unlinkat(AT_FDCWD, getname_kernel(cn.corename));
   692			}
   693	
   694			/*
   695			 * There is a race between unlinking and creating the
   696			 * file, but if that causes an EEXIST here, that's
   697			 * fine - another process raced with us while creating
   698			 * the corefile, and the other process won. To userspace,
   699			 * what matters is that at least one of the two processes
   700			 * writes its coredump successfully, not which one.
   701			 */
   702			if (need_suid_safe) {
   703				/*
   704				 * Using user namespaces, normal user tasks can change
   705				 * their current->fs->root to point to arbitrary
   706				 * directories. Since the intention of the "only dump
   707				 * with a fully qualified path" rule is to control where
   708				 * coredumps may be placed using root privileges,
   709				 * current->fs->root must not be used. Instead, use the
   710				 * root directory of init_task.
   711				 */
   712				struct path root;
   713	
   714				task_lock(&init_task);
   715				get_fs_root(init_task.fs, &root);
   716				task_unlock(&init_task);
   717				cprm.file = file_open_root(&root, cn.corename,
   718							   open_flags, 0600);
   719				path_put(&root);
   720			} else {
   721				cprm.file = filp_open(cn.corename, open_flags, 0600);
   722			}
   723			if (IS_ERR(cprm.file)) {
   724				retval = PTR_ERR(cprm.file);
   725				goto fail_unlock;
   726			}
   727	
   728			inode = file_inode(cprm.file);
   729			if (inode->i_nlink > 1) {
   730				retval = -EMLINK;
   731				goto close_fail;
   732			}
   733			if (d_unhashed(cprm.file->f_path.dentry)) {
   734				retval = -EEXIST;
   735				goto close_fail;
   736			}
   737			/*
   738			 * AK: actually i see no reason to not allow this for named
   739			 * pipes etc, but keep the previous behaviour for now.
   740			 */
   741			if (!S_ISREG(inode->i_mode)) {
   742				retval = -EISDIR;
   743				goto close_fail;
   744			}
   745			/*
   746			 * Don't dump core if the filesystem changed owner or mode
   747			 * of the file during file creation. This is an issue when
   748			 * a process dumps core while its cwd is e.g. on a vfat
   749			 * filesystem.
   750			 */
   751			idmap = file_mnt_idmap(cprm.file);
   752			if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
   753					    current_fsuid())) {
   754				pr_info_ratelimited("Core dump to %s aborted: cannot preserve file owner\n",
   755						    cn.corename);
   756				retval = -EPERM;
   757				goto close_fail;
   758			}
   759			if ((inode->i_mode & 0677) != 0600) {
   760				pr_info_ratelimited("Core dump to %s aborted: cannot preserve file permissions\n",
   761						    cn.corename);
   762				retval = -EPERM;
   763				goto close_fail;
   764			}
   765			if (!(cprm.file->f_mode & FMODE_CAN_WRITE)) {
   766				retval = -EACCES;
   767				goto close_fail;
   768			}
   769			retval = do_truncate(idmap, cprm.file->f_path.dentry,
   770					0, 0, cprm.file);
   771			if (retval)
   772				goto close_fail;
   773		}
   774	
   775		/* get us an unshared descriptor table; almost always a no-op */
   776		/* The cell spufs coredump code reads the file descriptor tables */
   777		retval = unshare_files();
   778		if (retval)
   779			goto close_fail;
   780		if (!dump_interrupted()) {
   781			/*
   782			 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
   783			 * have this set to NULL.
   784			 */
   785			if (!cprm.file) {
   786				pr_info("Core dump to |%s disabled\n", cn.corename);
   787				retval = -EPERM;
   788				goto close_fail;
   789			}
   790			if (!dump_vma_snapshot(&cprm)) {
   791				pr_err("Can't get VMA snapshot for core dump |%s\n", cn.corename);
   792				retval = -EACCES;
   793				goto close_fail;
   794			}
   795	
   796			file_start_write(cprm.file);
   797			core_dumped = binfmt->core_dump(&cprm);
   798			/*
   799			 * Ensures that file size is big enough to contain the current
   800			 * file postion. This prevents gdb from complaining about
   801			 * a truncated file if the last "write" to the file was
   802			 * dump_skip.
   803			 */
   804			if (cprm.to_skip) {
   805				cprm.to_skip--;
   806				dump_emit(&cprm, "", 1);
   807			}
   808			file_end_write(cprm.file);
   809			free_vma_snapshot(&cprm);
   810		} else {
   811			pr_err("Core dump to |%s has been interrupted\n", cn.corename);
   812			retval = -EAGAIN;
   813			goto fail;
   814		}
   815		pr_info("Core dump to |%s: vma_count %d, vma_data_size %lu, written %lld bytes, pos %lld\n",
 > 816			cn.corename, cprm.vma_count, cprm.vma_data_size, cprm.written, cprm.pos);
   817		if (ispipe && core_pipe_limit)
   818			wait_for_dump_helpers(cprm.file);
   819	
   820		retval = 0;
   821	
   822	close_fail:
   823		if (cprm.file)
   824			filp_close(cprm.file, NULL);
   825	fail_dropcount:
   826		if (ispipe)
   827			atomic_dec(&core_dump_count);
   828	fail_unlock:
   829		kfree(argv);
   830		kfree(cn.corename);
   831		coredump_finish(core_dumped);
   832		revert_creds(old_cred);
   833	fail_creds:
   834		put_cred(cred);
   835	fail:
   836		return retval;
   837	}
   838	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

