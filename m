Return-Path: <linux-fsdevel+bounces-30411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CEA98ACFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 21:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4EE9B21982
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695F199FD2;
	Mon, 30 Sep 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxQHK1Cy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8929199E8E;
	Mon, 30 Sep 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724940; cv=none; b=g+q+YTxBp0dGdogf5qPVGm6dbu9/bdHg9N7XxFGG54a5oK0OVCi8zNK42XIr1PWVtqg+qCNnScCNpsiM53u6vmjg2+d4f9dFK0YpsirqE1AjU+uDuTx9LuLTIcdqkaWidKktGw1f4Qu4imR8KV0rZZNpw/AnTqvbtQGqViJAzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724940; c=relaxed/simple;
	bh=bFq60gg3/DDTP1991jDCUEhlqqvLR/MT6h3RdrnzjOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN2XKiJ4pa5iKyPS32/Z4PQDnWUI1EMTpUFWGEizDrL9/0hhBTKB4LUifwx1BkFd9Zc8IVwPnpB3D0MUfD33UDC7F0cLep9jaFWAToLXaaQMqkLCoftF/RGVjtED6qZrp1HJY11E2yRGjH/oW6HBDd4fKyJIzwS+3LPe6Hz4zg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxQHK1Cy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727724938; x=1759260938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bFq60gg3/DDTP1991jDCUEhlqqvLR/MT6h3RdrnzjOI=;
  b=LxQHK1CyJwDe24TO61kuxU1NkgiKvkrgbrLyqE9Hbnj/VUPWGGXZNrOB
   1B0RkrdriM0wL647LRh9SayafbLg3GmtwcjQFMKP0Ngqt9BfJkRRCSaUG
   TEoYOmhODGLVZIJXxwpkickk84zCA9nBjejPDdDKmAT22FSKR56Hc1VUw
   94S1iMc6BVWDDrrbo9yRdfT77BS4jnJvg99dXjQB1olN5V5BdSCXe7sBh
   dILErzd5zfRiPU6eNFApHvznBFxgIXq7M0vZmKxcqipFLO1oG4l49cw5a
   W4Q8O334vPHiMA9RQAQgZPcvudMozimkqDv0hX3utVowpEa1A0c3S746B
   Q==;
X-CSE-ConnectionGUID: vc11/zSGQUGlc2U6VhQiYQ==
X-CSE-MsgGUID: 4FTD0fnBQXekf9BJkJSABw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26960738"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26960738"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 12:35:37 -0700
X-CSE-ConnectionGUID: aH3uY5nyRuykDUGN1lqx+A==
X-CSE-MsgGUID: /d8VFVQiQCyPkiSPvV8ulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78150926"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Sep 2024 12:35:31 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svMB7-000PoX-0n;
	Mon, 30 Sep 2024 19:35:29 +0000
Date: Tue, 1 Oct 2024 03:34:49 +0800
From: kernel test robot <lkp@intel.com>
To: Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Stas Sergeev <stsp2@yandex.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Florent Revest <revest@chromium.org>, Kees Cook <kees@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v2] add group restriction bitmap
Message-ID: <202410010306.DiK2TZWL-lkp@intel.com>
References: <20240930063405.113227-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930063405.113227-1-stsp2@yandex.ru>

Hi Stas,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.12-rc1 next-20240930]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stas-Sergeev/add-group-restriction-bitmap/20240930-144632
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240930063405.113227-1-stsp2%40yandex.ru
patch subject: [PATCH v2] add group restriction bitmap
config: i386-buildonly-randconfig-001-20241001 (https://download.01.org/0day-ci/archive/20241001/202410010306.DiK2TZWL-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410010306.DiK2TZWL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410010306.DiK2TZWL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sys.c:2799:8: error: call to undeclared function 'may_setgroups'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2799 |                 if (!may_setgroups())
         |                      ^
   1 error generated.


vim +/may_setgroups +2799 kernel/sys.c

  2456	
  2457	SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
  2458			unsigned long, arg4, unsigned long, arg5)
  2459	{
  2460		struct task_struct *me = current;
  2461		unsigned char comm[sizeof(me->comm)];
  2462		long error;
  2463	
  2464		error = security_task_prctl(option, arg2, arg3, arg4, arg5);
  2465		if (error != -ENOSYS)
  2466			return error;
  2467	
  2468		error = 0;
  2469		switch (option) {
  2470		case PR_SET_PDEATHSIG:
  2471			if (!valid_signal(arg2)) {
  2472				error = -EINVAL;
  2473				break;
  2474			}
  2475			me->pdeath_signal = arg2;
  2476			break;
  2477		case PR_GET_PDEATHSIG:
  2478			error = put_user(me->pdeath_signal, (int __user *)arg2);
  2479			break;
  2480		case PR_GET_DUMPABLE:
  2481			error = get_dumpable(me->mm);
  2482			break;
  2483		case PR_SET_DUMPABLE:
  2484			if (arg2 != SUID_DUMP_DISABLE && arg2 != SUID_DUMP_USER) {
  2485				error = -EINVAL;
  2486				break;
  2487			}
  2488			set_dumpable(me->mm, arg2);
  2489			break;
  2490	
  2491		case PR_SET_UNALIGN:
  2492			error = SET_UNALIGN_CTL(me, arg2);
  2493			break;
  2494		case PR_GET_UNALIGN:
  2495			error = GET_UNALIGN_CTL(me, arg2);
  2496			break;
  2497		case PR_SET_FPEMU:
  2498			error = SET_FPEMU_CTL(me, arg2);
  2499			break;
  2500		case PR_GET_FPEMU:
  2501			error = GET_FPEMU_CTL(me, arg2);
  2502			break;
  2503		case PR_SET_FPEXC:
  2504			error = SET_FPEXC_CTL(me, arg2);
  2505			break;
  2506		case PR_GET_FPEXC:
  2507			error = GET_FPEXC_CTL(me, arg2);
  2508			break;
  2509		case PR_GET_TIMING:
  2510			error = PR_TIMING_STATISTICAL;
  2511			break;
  2512		case PR_SET_TIMING:
  2513			if (arg2 != PR_TIMING_STATISTICAL)
  2514				error = -EINVAL;
  2515			break;
  2516		case PR_SET_NAME:
  2517			comm[sizeof(me->comm) - 1] = 0;
  2518			if (strncpy_from_user(comm, (char __user *)arg2,
  2519					      sizeof(me->comm) - 1) < 0)
  2520				return -EFAULT;
  2521			set_task_comm(me, comm);
  2522			proc_comm_connector(me);
  2523			break;
  2524		case PR_GET_NAME:
  2525			get_task_comm(comm, me);
  2526			if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
  2527				return -EFAULT;
  2528			break;
  2529		case PR_GET_ENDIAN:
  2530			error = GET_ENDIAN(me, arg2);
  2531			break;
  2532		case PR_SET_ENDIAN:
  2533			error = SET_ENDIAN(me, arg2);
  2534			break;
  2535		case PR_GET_SECCOMP:
  2536			error = prctl_get_seccomp();
  2537			break;
  2538		case PR_SET_SECCOMP:
  2539			error = prctl_set_seccomp(arg2, (char __user *)arg3);
  2540			break;
  2541		case PR_GET_TSC:
  2542			error = GET_TSC_CTL(arg2);
  2543			break;
  2544		case PR_SET_TSC:
  2545			error = SET_TSC_CTL(arg2);
  2546			break;
  2547		case PR_TASK_PERF_EVENTS_DISABLE:
  2548			error = perf_event_task_disable();
  2549			break;
  2550		case PR_TASK_PERF_EVENTS_ENABLE:
  2551			error = perf_event_task_enable();
  2552			break;
  2553		case PR_GET_TIMERSLACK:
  2554			if (current->timer_slack_ns > ULONG_MAX)
  2555				error = ULONG_MAX;
  2556			else
  2557				error = current->timer_slack_ns;
  2558			break;
  2559		case PR_SET_TIMERSLACK:
  2560			if (arg2 <= 0)
  2561				current->timer_slack_ns =
  2562						current->default_timer_slack_ns;
  2563			else
  2564				current->timer_slack_ns = arg2;
  2565			break;
  2566		case PR_MCE_KILL:
  2567			if (arg4 | arg5)
  2568				return -EINVAL;
  2569			switch (arg2) {
  2570			case PR_MCE_KILL_CLEAR:
  2571				if (arg3 != 0)
  2572					return -EINVAL;
  2573				current->flags &= ~PF_MCE_PROCESS;
  2574				break;
  2575			case PR_MCE_KILL_SET:
  2576				current->flags |= PF_MCE_PROCESS;
  2577				if (arg3 == PR_MCE_KILL_EARLY)
  2578					current->flags |= PF_MCE_EARLY;
  2579				else if (arg3 == PR_MCE_KILL_LATE)
  2580					current->flags &= ~PF_MCE_EARLY;
  2581				else if (arg3 == PR_MCE_KILL_DEFAULT)
  2582					current->flags &=
  2583							~(PF_MCE_EARLY|PF_MCE_PROCESS);
  2584				else
  2585					return -EINVAL;
  2586				break;
  2587			default:
  2588				return -EINVAL;
  2589			}
  2590			break;
  2591		case PR_MCE_KILL_GET:
  2592			if (arg2 | arg3 | arg4 | arg5)
  2593				return -EINVAL;
  2594			if (current->flags & PF_MCE_PROCESS)
  2595				error = (current->flags & PF_MCE_EARLY) ?
  2596					PR_MCE_KILL_EARLY : PR_MCE_KILL_LATE;
  2597			else
  2598				error = PR_MCE_KILL_DEFAULT;
  2599			break;
  2600		case PR_SET_MM:
  2601			error = prctl_set_mm(arg2, arg3, arg4, arg5);
  2602			break;
  2603		case PR_GET_TID_ADDRESS:
  2604			error = prctl_get_tid_address(me, (int __user * __user *)arg2);
  2605			break;
  2606		case PR_SET_CHILD_SUBREAPER:
  2607			me->signal->is_child_subreaper = !!arg2;
  2608			if (!arg2)
  2609				break;
  2610	
  2611			walk_process_tree(me, propagate_has_child_subreaper, NULL);
  2612			break;
  2613		case PR_GET_CHILD_SUBREAPER:
  2614			error = put_user(me->signal->is_child_subreaper,
  2615					 (int __user *)arg2);
  2616			break;
  2617		case PR_SET_NO_NEW_PRIVS:
  2618			if (arg2 != 1 || arg3 || arg4 || arg5)
  2619				return -EINVAL;
  2620	
  2621			task_set_no_new_privs(current);
  2622			break;
  2623		case PR_GET_NO_NEW_PRIVS:
  2624			if (arg2 || arg3 || arg4 || arg5)
  2625				return -EINVAL;
  2626			return task_no_new_privs(current) ? 1 : 0;
  2627		case PR_GET_THP_DISABLE:
  2628			if (arg2 || arg3 || arg4 || arg5)
  2629				return -EINVAL;
  2630			error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
  2631			break;
  2632		case PR_SET_THP_DISABLE:
  2633			if (arg3 || arg4 || arg5)
  2634				return -EINVAL;
  2635			if (mmap_write_lock_killable(me->mm))
  2636				return -EINTR;
  2637			if (arg2)
  2638				set_bit(MMF_DISABLE_THP, &me->mm->flags);
  2639			else
  2640				clear_bit(MMF_DISABLE_THP, &me->mm->flags);
  2641			mmap_write_unlock(me->mm);
  2642			break;
  2643		case PR_MPX_ENABLE_MANAGEMENT:
  2644		case PR_MPX_DISABLE_MANAGEMENT:
  2645			/* No longer implemented: */
  2646			return -EINVAL;
  2647		case PR_SET_FP_MODE:
  2648			error = SET_FP_MODE(me, arg2);
  2649			break;
  2650		case PR_GET_FP_MODE:
  2651			error = GET_FP_MODE(me);
  2652			break;
  2653		case PR_SVE_SET_VL:
  2654			error = SVE_SET_VL(arg2);
  2655			break;
  2656		case PR_SVE_GET_VL:
  2657			error = SVE_GET_VL();
  2658			break;
  2659		case PR_SME_SET_VL:
  2660			error = SME_SET_VL(arg2);
  2661			break;
  2662		case PR_SME_GET_VL:
  2663			error = SME_GET_VL();
  2664			break;
  2665		case PR_GET_SPECULATION_CTRL:
  2666			if (arg3 || arg4 || arg5)
  2667				return -EINVAL;
  2668			error = arch_prctl_spec_ctrl_get(me, arg2);
  2669			break;
  2670		case PR_SET_SPECULATION_CTRL:
  2671			if (arg4 || arg5)
  2672				return -EINVAL;
  2673			error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
  2674			break;
  2675		case PR_PAC_RESET_KEYS:
  2676			if (arg3 || arg4 || arg5)
  2677				return -EINVAL;
  2678			error = PAC_RESET_KEYS(me, arg2);
  2679			break;
  2680		case PR_PAC_SET_ENABLED_KEYS:
  2681			if (arg4 || arg5)
  2682				return -EINVAL;
  2683			error = PAC_SET_ENABLED_KEYS(me, arg2, arg3);
  2684			break;
  2685		case PR_PAC_GET_ENABLED_KEYS:
  2686			if (arg2 || arg3 || arg4 || arg5)
  2687				return -EINVAL;
  2688			error = PAC_GET_ENABLED_KEYS(me);
  2689			break;
  2690		case PR_SET_TAGGED_ADDR_CTRL:
  2691			if (arg3 || arg4 || arg5)
  2692				return -EINVAL;
  2693			error = SET_TAGGED_ADDR_CTRL(arg2);
  2694			break;
  2695		case PR_GET_TAGGED_ADDR_CTRL:
  2696			if (arg2 || arg3 || arg4 || arg5)
  2697				return -EINVAL;
  2698			error = GET_TAGGED_ADDR_CTRL();
  2699			break;
  2700		case PR_SET_IO_FLUSHER:
  2701			if (!capable(CAP_SYS_RESOURCE))
  2702				return -EPERM;
  2703	
  2704			if (arg3 || arg4 || arg5)
  2705				return -EINVAL;
  2706	
  2707			if (arg2 == 1)
  2708				current->flags |= PR_IO_FLUSHER;
  2709			else if (!arg2)
  2710				current->flags &= ~PR_IO_FLUSHER;
  2711			else
  2712				return -EINVAL;
  2713			break;
  2714		case PR_GET_IO_FLUSHER:
  2715			if (!capable(CAP_SYS_RESOURCE))
  2716				return -EPERM;
  2717	
  2718			if (arg2 || arg3 || arg4 || arg5)
  2719				return -EINVAL;
  2720	
  2721			error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
  2722			break;
  2723		case PR_SET_SYSCALL_USER_DISPATCH:
  2724			error = set_syscall_user_dispatch(arg2, arg3, arg4,
  2725							  (char __user *) arg5);
  2726			break;
  2727	#ifdef CONFIG_SCHED_CORE
  2728		case PR_SCHED_CORE:
  2729			error = sched_core_share_pid(arg2, arg3, arg4, arg5);
  2730			break;
  2731	#endif
  2732		case PR_SET_MDWE:
  2733			error = prctl_set_mdwe(arg2, arg3, arg4, arg5);
  2734			break;
  2735		case PR_GET_MDWE:
  2736			error = prctl_get_mdwe(arg2, arg3, arg4, arg5);
  2737			break;
  2738		case PR_PPC_GET_DEXCR:
  2739			if (arg3 || arg4 || arg5)
  2740				return -EINVAL;
  2741			error = PPC_GET_DEXCR_ASPECT(me, arg2);
  2742			break;
  2743		case PR_PPC_SET_DEXCR:
  2744			if (arg4 || arg5)
  2745				return -EINVAL;
  2746			error = PPC_SET_DEXCR_ASPECT(me, arg2, arg3);
  2747			break;
  2748		case PR_SET_VMA:
  2749			error = prctl_set_vma(arg2, arg3, arg4, arg5);
  2750			break;
  2751		case PR_GET_AUXV:
  2752			if (arg4 || arg5)
  2753				return -EINVAL;
  2754			error = prctl_get_auxv((void __user *)arg2, arg3);
  2755			break;
  2756	#ifdef CONFIG_KSM
  2757		case PR_SET_MEMORY_MERGE:
  2758			if (arg3 || arg4 || arg5)
  2759				return -EINVAL;
  2760			if (mmap_write_lock_killable(me->mm))
  2761				return -EINTR;
  2762	
  2763			if (arg2)
  2764				error = ksm_enable_merge_any(me->mm);
  2765			else
  2766				error = ksm_disable_merge_any(me->mm);
  2767			mmap_write_unlock(me->mm);
  2768			break;
  2769		case PR_GET_MEMORY_MERGE:
  2770			if (arg2 || arg3 || arg4 || arg5)
  2771				return -EINVAL;
  2772	
  2773			error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
  2774			break;
  2775	#endif
  2776		case PR_RISCV_V_SET_CONTROL:
  2777			error = RISCV_V_SET_CONTROL(arg2);
  2778			break;
  2779		case PR_RISCV_V_GET_CONTROL:
  2780			error = RISCV_V_GET_CONTROL();
  2781			break;
  2782		case PR_RISCV_SET_ICACHE_FLUSH_CTX:
  2783			error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
  2784			break;
  2785		case PR_GET_GRBITMAP:
  2786			if (arg2 || arg3 || arg4 || arg5)
  2787				return -EINVAL;
  2788			error = current_cred()->group_info->restrict_bitmap;
  2789			break;
  2790		case PR_SET_GRBITMAP:
  2791			/* Allow 31 bits to avoid setting sign bit. */
  2792			if (arg2 > (1U << 31) - 1 || arg3 || arg4 || arg5)
  2793				return -EINVAL;
  2794			current_cred()->group_info->restrict_bitmap |= arg2;
  2795			break;
  2796		case PR_CLR_GRBITMAP:
  2797			if (arg2 || arg3 || arg4 || arg5)
  2798				return -EINVAL;
> 2799			if (!may_setgroups())
  2800				return -EPERM;
  2801			current_cred()->group_info->restrict_bitmap = 0;
  2802			break;
  2803		default:
  2804			error = -EINVAL;
  2805			break;
  2806		}
  2807		return error;
  2808	}
  2809	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

