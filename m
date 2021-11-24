Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0276B45B09A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 01:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhKXART (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 19:17:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:34248 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhKXARP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 19:17:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="298574126"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="298574126"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 16:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="597292446"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2021 16:14:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpfvG-0002mS-2i; Wed, 24 Nov 2021 00:14:02 +0000
Date:   Wed, 24 Nov 2021 08:13:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akira Kawata <akirakawata1@gmail.com>, akpm@linux-foundation.org,
        adobriyan@gmail.com, viro@zeniv.linux.org.uk,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        akirakawata1@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Message-ID: <202111240802.Wxm5q6aP-lkp@intel.com>
References: <20211123073157.198689-1-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123073157.198689-1-akirakawata1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Akira,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on kees/for-next/pstore linus/master v5.16-rc2 next-20211123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Akira-Kawata/fs-binfmt_elf-Fix-AT_PHDR-for-unusual-ELF-files/20211123-153459
base:   https://github.com/hnaz/linux-mm master
config: i386-randconfig-a012-20211123 (https://download.01.org/0day-ci/archive/20211124/202111240802.Wxm5q6aP-lkp@intel.com/config.gz)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 49e3838145dff1ec91c2e67a2cb562775c8d2a08)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8e8533fa0fdbe61a557de9268ea7091a75aebe81
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Akira-Kawata/fs-binfmt_elf-Fix-AT_PHDR-for-unusual-ELF-files/20211123-153459
        git checkout 8e8533fa0fdbe61a557de9268ea7091a75aebe81
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/binfmt_elf.c:825:16: warning: variable 'load_addr' set but not used [-Wunused-but-set-variable]
           unsigned long load_addr = 0, load_bias = 0, phdr_addr = 0;
                         ^
   1 warning generated.


vim +/load_addr +825 fs/binfmt_elf.c

   821	
   822	static int load_elf_binary(struct linux_binprm *bprm)
   823	{
   824		struct file *interpreter = NULL; /* to shut gcc up */
 > 825		unsigned long load_addr = 0, load_bias = 0, phdr_addr = 0;
   826		int load_addr_set = 0;
   827		unsigned long error;
   828		struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
   829		struct elf_phdr *elf_property_phdata = NULL;
   830		unsigned long elf_bss, elf_brk;
   831		int bss_prot = 0;
   832		int retval, i;
   833		unsigned long elf_entry;
   834		unsigned long e_entry;
   835		unsigned long interp_load_addr = 0;
   836		unsigned long start_code, end_code, start_data, end_data;
   837		unsigned long reloc_func_desc __maybe_unused = 0;
   838		int executable_stack = EXSTACK_DEFAULT;
   839		struct elfhdr *elf_ex = (struct elfhdr *)bprm->buf;
   840		struct elfhdr *interp_elf_ex = NULL;
   841		struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
   842		struct mm_struct *mm;
   843		struct pt_regs *regs;
   844	
   845		retval = -ENOEXEC;
   846		/* First of all, some simple consistency checks */
   847		if (memcmp(elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
   848			goto out;
   849	
   850		if (elf_ex->e_type != ET_EXEC && elf_ex->e_type != ET_DYN)
   851			goto out;
   852		if (!elf_check_arch(elf_ex))
   853			goto out;
   854		if (elf_check_fdpic(elf_ex))
   855			goto out;
   856		if (!bprm->file->f_op->mmap)
   857			goto out;
   858	
   859		elf_phdata = load_elf_phdrs(elf_ex, bprm->file);
   860		if (!elf_phdata)
   861			goto out;
   862	
   863		elf_ppnt = elf_phdata;
   864		for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
   865			char *elf_interpreter;
   866	
   867			if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
   868				elf_property_phdata = elf_ppnt;
   869				continue;
   870			}
   871	
   872			if (elf_ppnt->p_type != PT_INTERP)
   873				continue;
   874	
   875			/*
   876			 * This is the program interpreter used for shared libraries -
   877			 * for now assume that this is an a.out format binary.
   878			 */
   879			retval = -ENOEXEC;
   880			if (elf_ppnt->p_filesz > PATH_MAX || elf_ppnt->p_filesz < 2)
   881				goto out_free_ph;
   882	
   883			retval = -ENOMEM;
   884			elf_interpreter = kmalloc(elf_ppnt->p_filesz, GFP_KERNEL);
   885			if (!elf_interpreter)
   886				goto out_free_ph;
   887	
   888			retval = elf_read(bprm->file, elf_interpreter, elf_ppnt->p_filesz,
   889					  elf_ppnt->p_offset);
   890			if (retval < 0)
   891				goto out_free_interp;
   892			/* make sure path is NULL terminated */
   893			retval = -ENOEXEC;
   894			if (elf_interpreter[elf_ppnt->p_filesz - 1] != '\0')
   895				goto out_free_interp;
   896	
   897			interpreter = open_exec(elf_interpreter);
   898			kfree(elf_interpreter);
   899			retval = PTR_ERR(interpreter);
   900			if (IS_ERR(interpreter))
   901				goto out_free_ph;
   902	
   903			/*
   904			 * If the binary is not readable then enforce mm->dumpable = 0
   905			 * regardless of the interpreter's permissions.
   906			 */
   907			would_dump(bprm, interpreter);
   908	
   909			interp_elf_ex = kmalloc(sizeof(*interp_elf_ex), GFP_KERNEL);
   910			if (!interp_elf_ex) {
   911				retval = -ENOMEM;
   912				goto out_free_ph;
   913			}
   914	
   915			/* Get the exec headers */
   916			retval = elf_read(interpreter, interp_elf_ex,
   917					  sizeof(*interp_elf_ex), 0);
   918			if (retval < 0)
   919				goto out_free_dentry;
   920	
   921			break;
   922	
   923	out_free_interp:
   924			kfree(elf_interpreter);
   925			goto out_free_ph;
   926		}
   927	
   928		elf_ppnt = elf_phdata;
   929		for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++)
   930			switch (elf_ppnt->p_type) {
   931			case PT_GNU_STACK:
   932				if (elf_ppnt->p_flags & PF_X)
   933					executable_stack = EXSTACK_ENABLE_X;
   934				else
   935					executable_stack = EXSTACK_DISABLE_X;
   936				break;
   937	
   938			case PT_LOPROC ... PT_HIPROC:
   939				retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
   940							  bprm->file, false,
   941							  &arch_state);
   942				if (retval)
   943					goto out_free_dentry;
   944				break;
   945			}
   946	
   947		/* Some simple consistency checks for the interpreter */
   948		if (interpreter) {
   949			retval = -ELIBBAD;
   950			/* Not an ELF interpreter */
   951			if (memcmp(interp_elf_ex->e_ident, ELFMAG, SELFMAG) != 0)
   952				goto out_free_dentry;
   953			/* Verify the interpreter has a valid arch */
   954			if (!elf_check_arch(interp_elf_ex) ||
   955			    elf_check_fdpic(interp_elf_ex))
   956				goto out_free_dentry;
   957	
   958			/* Load the interpreter program headers */
   959			interp_elf_phdata = load_elf_phdrs(interp_elf_ex,
   960							   interpreter);
   961			if (!interp_elf_phdata)
   962				goto out_free_dentry;
   963	
   964			/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
   965			elf_property_phdata = NULL;
   966			elf_ppnt = interp_elf_phdata;
   967			for (i = 0; i < interp_elf_ex->e_phnum; i++, elf_ppnt++)
   968				switch (elf_ppnt->p_type) {
   969				case PT_GNU_PROPERTY:
   970					elf_property_phdata = elf_ppnt;
   971					break;
   972	
   973				case PT_LOPROC ... PT_HIPROC:
   974					retval = arch_elf_pt_proc(interp_elf_ex,
   975								  elf_ppnt, interpreter,
   976								  true, &arch_state);
   977					if (retval)
   978						goto out_free_dentry;
   979					break;
   980				}
   981		}
   982	
   983		retval = parse_elf_properties(interpreter ?: bprm->file,
   984					      elf_property_phdata, &arch_state);
   985		if (retval)
   986			goto out_free_dentry;
   987	
   988		/*
   989		 * Allow arch code to reject the ELF at this point, whilst it's
   990		 * still possible to return an error to the code that invoked
   991		 * the exec syscall.
   992		 */
   993		retval = arch_check_elf(elf_ex,
   994					!!interpreter, interp_elf_ex,
   995					&arch_state);
   996		if (retval)
   997			goto out_free_dentry;
   998	
   999		/* Flush all traces of the currently running executable */
  1000		retval = begin_new_exec(bprm);
  1001		if (retval)
  1002			goto out_free_dentry;
  1003	
  1004		/* Do this immediately, since STACK_TOP as used in setup_arg_pages
  1005		   may depend on the personality.  */
  1006		SET_PERSONALITY2(*elf_ex, &arch_state);
  1007		if (elf_read_implies_exec(*elf_ex, executable_stack))
  1008			current->personality |= READ_IMPLIES_EXEC;
  1009	
  1010		if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
  1011			current->flags |= PF_RANDOMIZE;
  1012	
  1013		setup_new_exec(bprm);
  1014	
  1015		/* Do this so that we can load the interpreter, if need be.  We will
  1016		   change some of these later */
  1017		retval = setup_arg_pages(bprm, randomize_stack_top(STACK_TOP),
  1018					 executable_stack);
  1019		if (retval < 0)
  1020			goto out_free_dentry;
  1021		
  1022		elf_bss = 0;
  1023		elf_brk = 0;
  1024	
  1025		start_code = ~0UL;
  1026		end_code = 0;
  1027		start_data = 0;
  1028		end_data = 0;
  1029	
  1030		/* Now we do a little grungy work by mmapping the ELF image into
  1031		   the correct location in memory. */
  1032		for(i = 0, elf_ppnt = elf_phdata;
  1033		    i < elf_ex->e_phnum; i++, elf_ppnt++) {
  1034			int elf_prot, elf_flags;
  1035			unsigned long k, vaddr;
  1036			unsigned long total_size = 0;
  1037			unsigned long alignment;
  1038	
  1039			if (elf_ppnt->p_type != PT_LOAD)
  1040				continue;
  1041	
  1042			if (unlikely (elf_brk > elf_bss)) {
  1043				unsigned long nbyte;
  1044		            
  1045				/* There was a PT_LOAD segment with p_memsz > p_filesz
  1046				   before this one. Map anonymous pages, if needed,
  1047				   and clear the area.  */
  1048				retval = set_brk(elf_bss + load_bias,
  1049						 elf_brk + load_bias,
  1050						 bss_prot);
  1051				if (retval)
  1052					goto out_free_dentry;
  1053				nbyte = ELF_PAGEOFFSET(elf_bss);
  1054				if (nbyte) {
  1055					nbyte = ELF_MIN_ALIGN - nbyte;
  1056					if (nbyte > elf_brk - elf_bss)
  1057						nbyte = elf_brk - elf_bss;
  1058					if (clear_user((void __user *)elf_bss +
  1059								load_bias, nbyte)) {
  1060						/*
  1061						 * This bss-zeroing can fail if the ELF
  1062						 * file specifies odd protections. So
  1063						 * we don't check the return value
  1064						 */
  1065					}
  1066				}
  1067			}
  1068	
  1069			elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
  1070					     !!interpreter, false);
  1071	
  1072			elf_flags = MAP_PRIVATE;
  1073	
  1074			vaddr = elf_ppnt->p_vaddr;
  1075			/*
  1076			 * The first time through the loop, load_addr_set is false:
  1077			 * layout will be calculated. Once set, use MAP_FIXED since
  1078			 * we know we've already safely mapped the entire region with
  1079			 * MAP_FIXED_NOREPLACE in the once-per-binary logic following.
  1080			 */
  1081			if (load_addr_set) {
  1082				elf_flags |= MAP_FIXED;
  1083			} else if (elf_ex->e_type == ET_EXEC) {
  1084				/*
  1085				 * This logic is run once for the first LOAD Program
  1086				 * Header for ET_EXEC binaries. No special handling
  1087				 * is needed.
  1088				 */
  1089				elf_flags |= MAP_FIXED_NOREPLACE;
  1090			} else if (elf_ex->e_type == ET_DYN) {
  1091				/*
  1092				 * This logic is run once for the first LOAD Program
  1093				 * Header for ET_DYN binaries to calculate the
  1094				 * randomization (load_bias) for all the LOAD
  1095				 * Program Headers.
  1096				 *
  1097				 * There are effectively two types of ET_DYN
  1098				 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
  1099				 * and loaders (ET_DYN without INTERP, since they
  1100				 * _are_ the ELF interpreter). The loaders must
  1101				 * be loaded away from programs since the program
  1102				 * may otherwise collide with the loader (especially
  1103				 * for ET_EXEC which does not have a randomized
  1104				 * position). For example to handle invocations of
  1105				 * "./ld.so someprog" to test out a new version of
  1106				 * the loader, the subsequent program that the
  1107				 * loader loads must avoid the loader itself, so
  1108				 * they cannot share the same load range. Sufficient
  1109				 * room for the brk must be allocated with the
  1110				 * loader as well, since brk must be available with
  1111				 * the loader.
  1112				 *
  1113				 * Therefore, programs are loaded offset from
  1114				 * ELF_ET_DYN_BASE and loaders are loaded into the
  1115				 * independently randomized mmap region (0 load_bias
  1116				 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
  1117				 */
  1118				if (interpreter) {
  1119					load_bias = ELF_ET_DYN_BASE;
  1120					if (current->flags & PF_RANDOMIZE)
  1121						load_bias += arch_mmap_rnd();
  1122					alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
  1123					if (alignment)
  1124						load_bias &= ~(alignment - 1);
  1125					elf_flags |= MAP_FIXED_NOREPLACE;
  1126				} else
  1127					load_bias = 0;
  1128	
  1129				/*
  1130				 * Since load_bias is used for all subsequent loading
  1131				 * calculations, we must lower it by the first vaddr
  1132				 * so that the remaining calculations based on the
  1133				 * ELF vaddrs will be correctly offset. The result
  1134				 * is then page aligned.
  1135				 */
  1136				load_bias = ELF_PAGESTART(load_bias - vaddr);
  1137			}
  1138	
  1139			/*
  1140			 * Calculate the entire size of the ELF mapping (total_size).
  1141			 * (Note that load_addr_set is set to true later once the
  1142			 * initial mapping is performed.)
  1143			 */
  1144			if (!load_addr_set) {
  1145				total_size = total_mapping_size(elf_phdata,
  1146								elf_ex->e_phnum);
  1147				if (!total_size) {
  1148					retval = -EINVAL;
  1149					goto out_free_dentry;
  1150				}
  1151			}
  1152	
  1153			error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
  1154					elf_prot, elf_flags, total_size);
  1155			if (BAD_ADDR(error)) {
  1156				retval = IS_ERR((void *)error) ?
  1157					PTR_ERR((void*)error) : -EINVAL;
  1158				goto out_free_dentry;
  1159			}
  1160	
  1161			if (!load_addr_set) {
  1162				load_addr_set = 1;
  1163				load_addr = (elf_ppnt->p_vaddr - elf_ppnt->p_offset);
  1164				if (elf_ex->e_type == ET_DYN) {
  1165					load_bias += error -
  1166					             ELF_PAGESTART(load_bias + vaddr);
  1167					load_addr += load_bias;
  1168					reloc_func_desc = load_bias;
  1169				}
  1170			}
  1171	
  1172			if (elf_ppnt->p_offset <= elf_ex->e_phoff &&
  1173			    elf_ex->e_phoff < elf_ppnt->p_offset + elf_ppnt->p_filesz) {
  1174				phdr_addr = elf_ex->e_phoff - elf_ppnt->p_offset +
  1175					    elf_ppnt->p_vaddr;
  1176			}
  1177	
  1178			k = elf_ppnt->p_vaddr;
  1179			if ((elf_ppnt->p_flags & PF_X) && k < start_code)
  1180				start_code = k;
  1181			if (start_data < k)
  1182				start_data = k;
  1183	
  1184			/*
  1185			 * Check to see if the section's size will overflow the
  1186			 * allowed task size. Note that p_filesz must always be
  1187			 * <= p_memsz so it is only necessary to check p_memsz.
  1188			 */
  1189			if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
  1190			    elf_ppnt->p_memsz > TASK_SIZE ||
  1191			    TASK_SIZE - elf_ppnt->p_memsz < k) {
  1192				/* set_brk can never work. Avoid overflows. */
  1193				retval = -EINVAL;
  1194				goto out_free_dentry;
  1195			}
  1196	
  1197			k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
  1198	
  1199			if (k > elf_bss)
  1200				elf_bss = k;
  1201			if ((elf_ppnt->p_flags & PF_X) && end_code < k)
  1202				end_code = k;
  1203			if (end_data < k)
  1204				end_data = k;
  1205			k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
  1206			if (k > elf_brk) {
  1207				bss_prot = elf_prot;
  1208				elf_brk = k;
  1209			}
  1210		}
  1211	
  1212		e_entry = elf_ex->e_entry + load_bias;
  1213		phdr_addr += load_bias;
  1214		elf_bss += load_bias;
  1215		elf_brk += load_bias;
  1216		start_code += load_bias;
  1217		end_code += load_bias;
  1218		start_data += load_bias;
  1219		end_data += load_bias;
  1220	
  1221		/* Calling set_brk effectively mmaps the pages that we need
  1222		 * for the bss and break sections.  We must do this before
  1223		 * mapping in the interpreter, to make sure it doesn't wind
  1224		 * up getting placed where the bss needs to go.
  1225		 */
  1226		retval = set_brk(elf_bss, elf_brk, bss_prot);
  1227		if (retval)
  1228			goto out_free_dentry;
  1229		if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
  1230			retval = -EFAULT; /* Nobody gets to see this, but.. */
  1231			goto out_free_dentry;
  1232		}
  1233	
  1234		if (interpreter) {
  1235			elf_entry = load_elf_interp(interp_elf_ex,
  1236						    interpreter,
  1237						    load_bias, interp_elf_phdata,
  1238						    &arch_state);
  1239			if (!IS_ERR((void *)elf_entry)) {
  1240				/*
  1241				 * load_elf_interp() returns relocation
  1242				 * adjustment
  1243				 */
  1244				interp_load_addr = elf_entry;
  1245				elf_entry += interp_elf_ex->e_entry;
  1246			}
  1247			if (BAD_ADDR(elf_entry)) {
  1248				retval = IS_ERR((void *)elf_entry) ?
  1249						(int)elf_entry : -EINVAL;
  1250				goto out_free_dentry;
  1251			}
  1252			reloc_func_desc = interp_load_addr;
  1253	
  1254			allow_write_access(interpreter);
  1255			fput(interpreter);
  1256	
  1257			kfree(interp_elf_ex);
  1258			kfree(interp_elf_phdata);
  1259		} else {
  1260			elf_entry = e_entry;
  1261			if (BAD_ADDR(elf_entry)) {
  1262				retval = -EINVAL;
  1263				goto out_free_dentry;
  1264			}
  1265		}
  1266	
  1267		kfree(elf_phdata);
  1268	
  1269		set_binfmt(&elf_format);
  1270	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
