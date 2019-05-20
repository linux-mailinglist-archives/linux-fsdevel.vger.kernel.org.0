Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99423BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfETPOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 11:14:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:52771 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730479AbfETPOy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 11:14:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 08:14:52 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 May 2019 08:14:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hSk02-0005Lo-Eb; Mon, 20 May 2019 23:14:50 +0800
Date:   Mon, 20 May 2019 23:14:22 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Wise <pabs3@bonedaddy.net>
Cc:     kbuild-all@01.org, Neil Horman <nhorman@tuxdriver.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Wise <pabs3@bonedaddy.net>, Jakub Wilk <jwilk@jwilk.net>
Subject: Re: [PATCH] coredump: Split pipe command whitespace before expanding
 template
Message-ID: <201905202342.COVmaSLI%lkp@intel.com>
References: <20190520090115.11276-1-pabs3@bonedaddy.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20190520090115.11276-1-pabs3@bonedaddy.net>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.2-rc1 next-20190520]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Wise/coredump-Split-pipe-command-whitespace-before-expanding-template/20190520-212130
config: riscv-defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/coredump.c: In function 'format_corename':
>> fs/coredump.c:210:4: error: invalid type argument of unary '*' (have 'int')
      (*argvs) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
       ^~~~~~

vim +210 fs/coredump.c

   186	
   187	/* format_corename will inspect the pattern parameter, and output a
   188	 * name into corename, which must have space for at least
   189	 * CORENAME_MAX_SIZE bytes plus one byte for the zero terminator.
   190	 */
   191	static int format_corename(struct core_name *cn, struct coredump_params *cprm,
   192				   size_t **argv, int *argc)
   193	{
   194		const struct cred *cred = current_cred();
   195		const char *pat_ptr = core_pattern;
   196		int ispipe = (*pat_ptr == '|');
   197		bool was_space = false;
   198		int pid_in_pattern = 0;
   199		int err = 0;
   200	
   201		cn->used = 0;
   202		cn->corename = NULL;
   203		if (expand_corename(cn, core_name_size))
   204			return -ENOMEM;
   205		cn->corename[0] = '\0';
   206	
   207		if (ispipe) {
   208			/* sizeof(core_pattern) / 2 is the maximum number of args. */
   209			int argvs = sizeof(core_pattern) / 2;
 > 210			(*argvs) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
   211			if (!(*argv))
   212				return -ENOMEM;
   213			(*argv)[(*argc)++] = 0;
   214			++pat_ptr;
   215		}
   216	
   217		/* Repeat as long as we have more pattern to process and more output
   218		   space */
   219		while (*pat_ptr) {
   220			/*
   221			 * Split on spaces before doing template expansion so that
   222			 * %e and %E don't get split if they have spaces in them
   223			 */
   224			if (ispipe) {
   225				if (isspace(*pat_ptr)) {
   226					was_space = true;
   227					pat_ptr++;
   228					continue;
   229				} else if (was_space) {
   230					was_space = false;
   231					err = cn_printf(cn, "%c", '\0');
   232					if (err)
   233						return err;
   234					(*argv)[(*argc)++] = cn->used;
   235				}
   236			}
   237			if (*pat_ptr != '%') {
   238				err = cn_printf(cn, "%c", *pat_ptr++);
   239			} else {
   240				switch (*++pat_ptr) {
   241				/* single % at the end, drop that */
   242				case 0:
   243					goto out;
   244				/* Double percent, output one percent */
   245				case '%':
   246					err = cn_printf(cn, "%c", '%');
   247					break;
   248				/* pid */
   249				case 'p':
   250					pid_in_pattern = 1;
   251					err = cn_printf(cn, "%d",
   252						      task_tgid_vnr(current));
   253					break;
   254				/* global pid */
   255				case 'P':
   256					err = cn_printf(cn, "%d",
   257						      task_tgid_nr(current));
   258					break;
   259				case 'i':
   260					err = cn_printf(cn, "%d",
   261						      task_pid_vnr(current));
   262					break;
   263				case 'I':
   264					err = cn_printf(cn, "%d",
   265						      task_pid_nr(current));
   266					break;
   267				/* uid */
   268				case 'u':
   269					err = cn_printf(cn, "%u",
   270							from_kuid(&init_user_ns,
   271								  cred->uid));
   272					break;
   273				/* gid */
   274				case 'g':
   275					err = cn_printf(cn, "%u",
   276							from_kgid(&init_user_ns,
   277								  cred->gid));
   278					break;
   279				case 'd':
   280					err = cn_printf(cn, "%d",
   281						__get_dumpable(cprm->mm_flags));
   282					break;
   283				/* signal that caused the coredump */
   284				case 's':
   285					err = cn_printf(cn, "%d",
   286							cprm->siginfo->si_signo);
   287					break;
   288				/* UNIX time of coredump */
   289				case 't': {
   290					time64_t time;
   291	
   292					time = ktime_get_real_seconds();
   293					err = cn_printf(cn, "%lld", time);
   294					break;
   295				}
   296				/* hostname */
   297				case 'h':
   298					down_read(&uts_sem);
   299					err = cn_esc_printf(cn, "%s",
   300						      utsname()->nodename);
   301					up_read(&uts_sem);
   302					break;
   303				/* executable */
   304				case 'e':
   305					err = cn_esc_printf(cn, "%s", current->comm);
   306					break;
   307				case 'E':
   308					err = cn_print_exe_file(cn);
   309					break;
   310				/* core limit size */
   311				case 'c':
   312					err = cn_printf(cn, "%lu",
   313						      rlimit(RLIMIT_CORE));
   314					break;
   315				default:
   316					break;
   317				}
   318				++pat_ptr;
   319			}
   320	
   321			if (err)
   322				return err;
   323		}
   324	
   325	out:
   326		/* Backward compatibility with core_uses_pid:
   327		 *
   328		 * If core_pattern does not include a %p (as is the default)
   329		 * and core_uses_pid is set, then .%pid will be appended to
   330		 * the filename. Do not do this for piped commands. */
   331		if (!ispipe && !pid_in_pattern && core_uses_pid) {
   332			err = cn_printf(cn, ".%d", task_tgid_vnr(current));
   333			if (err)
   334				return err;
   335		}
   336		return ispipe;
   337	}
   338	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RQxZIwEA

--J/dobhs11T7y2rNN--
