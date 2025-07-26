Return-Path: <linux-fsdevel+bounces-56076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C8BB12A42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 13:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFA7562B23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7088242D7C;
	Sat, 26 Jul 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPQ0AWgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA3239E64;
	Sat, 26 Jul 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753528902; cv=none; b=uj2WXvxeS+LexWChNxJ0VBwoor32nMMc8nqefSywgrxBPX0xmo5EMjmsjl/s0ddcsWYFAV3Y5xfe1CyYEjwc8Ia6Z/tQFL6ttF3B+3w4LwA4/JfUxW+T44ipZgxJqtWrQw/rRkHPmT1Y3BmfzFS3dvNssFS6CVjEbc/mWFcDeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753528902; c=relaxed/simple;
	bh=wbRxOW83h5ag6rAvDa9zsvECbeocst1I6z9JDaiutro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwUooALytDqdP24HcYOsMuEufgIk4VMcBTlTTe3i2lkLtfy7mCzeKs/4XJ8UxG9WxgXnx2ateisGjdLzm/D2R3rhVMHuko8xVFmlynkpNSc36X541m1JKa6bcaj8ElAhENK7sKGFsdrdDnq3bCoQ9A3rPJWflHUilNG1YBhMBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPQ0AWgJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753528901; x=1785064901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wbRxOW83h5ag6rAvDa9zsvECbeocst1I6z9JDaiutro=;
  b=PPQ0AWgJ77eUfULQ45ttrHSmMGzQsJiEc41pqy1v7EMZINqB9aUpBjZW
   +ThcHECS/qSP23F91VEXL+MuORoTSRqN/xTGkkuXsvJRq8KKH5lnQ1590
   ERxuPejosUgb13UjyegduBrP4IwV8oa7VZSzdQp40HQcGtpvZJUdghGRv
   6ZMjnDQ5vUk7dscRusl8oqkmvZqfBKYYZyQER5tK3ZtXYtzBQ7EmXr4xA
   S63yZGEdqtUZyDAa7gPUiAvF9pquGyjura4zZmPduX/NvUvni/264POyG
   ZpzaMRWLvxrnRvg8soqiUf0bQ0yqCQzXDVnxc3C2OLeu//4Q7OG6Rd25+
   w==;
X-CSE-ConnectionGUID: Aa/EvAMmT6SXvgDr0Itg3g==
X-CSE-MsgGUID: JY+xzjfbTWG+fGO8yPDZVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55997856"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55997856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 04:21:39 -0700
X-CSE-ConnectionGUID: 8zotRv7YQvKXCdlELy7OUA==
X-CSE-MsgGUID: 0XG+XZTXR+uiUAgNJ2gZrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192450002"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Jul 2025 04:21:33 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufcy2-000Lvd-0T;
	Sat, 26 Jul 2025 11:21:30 +0000
Date: Sat, 26 Jul 2025 19:20:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, bhupesh@igalia.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	oliver.sang@intel.com, lkp@intel.com, laoar.shao@gmail.com,
	pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de
Subject: Re: [PATCH v6 3/3] include: Set tsk->comm length to 64 bytes
Message-ID: <202507261841.Z2C9RmTJ-lkp@intel.com>
References: <20250724123612.206110-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724123612.206110-4-bhupesh@igalia.com>

Hi Bhupesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on tip/sched/core akpm-mm/mm-everything linus/master v6.16-rc7 next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250724-203927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250724123612.206110-4-bhupesh%40igalia.com
patch subject: [PATCH v6 3/3] include: Set tsk->comm length to 64 bytes
config: sparc64-randconfig-001-20250725 (https://download.01.org/0day-ci/archive/20250726/202507261841.Z2C9RmTJ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261841.Z2C9RmTJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261841.Z2C9RmTJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nouveau_chan.c: In function 'nouveau_channel_ctor':
>> drivers/gpu/drm/nouveau/nouveau_chan.c:336:51: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
     snprintf(args->name, __member_size(args->name), "%s[%d]",
                                                      ^~
   drivers/gpu/drm/nouveau/nouveau_chan.c:336:2: note: 'snprintf' output between 4 and 77 bytes into a destination of size 32
     snprintf(args->name, __member_size(args->name), "%s[%d]",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       current->comm, task_pid_nr(current));
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/nouveau/nouveau_drm.c: In function 'nouveau_drm_open':
>> drivers/gpu/drm/nouveau/nouveau_drm.c:1202:32: warning: '%s' directive output may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
     snprintf(name, sizeof(name), "%s[%d]",
                                   ^~
   drivers/gpu/drm/nouveau/nouveau_drm.c:1202:2: note: 'snprintf' output between 4 and 77 bytes into a destination of size 32
     snprintf(name, sizeof(name), "%s[%d]",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       current->comm, pid_nr(rcu_dereference(fpriv->pid)));
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +336 drivers/gpu/drm/nouveau/nouveau_chan.c

ebb945a94bba2c Ben Skeggs          2012-07-20  246  
5b8a43aeb9cbf6 Marcin Slusarz      2012-08-19  247  static int
5cca41ac70e587 Ben Skeggs          2024-07-26  248  nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
06db7fded6dec8 Ben Skeggs          2022-06-01  249  		     struct nouveau_channel **pchan)
ebb945a94bba2c Ben Skeggs          2012-07-20  250  {
152be54224de18 Danilo Krummrich    2023-10-02  251  	const struct nvif_mclass hosts[] = {
284ad706ad2f50 Ben Skeggs          2025-02-04  252  		{ BLACKWELL_CHANNEL_GPFIFO_B, 0 },
32cb1cc358ffed Ben Skeggs          2024-11-25  253  		{ BLACKWELL_CHANNEL_GPFIFO_A, 0 },
44f93b209e2afd Ben Skeggs          2024-11-25  254  		{    HOPPER_CHANNEL_GPFIFO_A, 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  255  		{    AMPERE_CHANNEL_GPFIFO_B, 0 },
7f4f35ea5b080e Ben Skeggs          2022-06-01  256  		{    AMPERE_CHANNEL_GPFIFO_A, 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  257  		{    TURING_CHANNEL_GPFIFO_A, 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  258  		{     VOLTA_CHANNEL_GPFIFO_A, 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  259  		{    PASCAL_CHANNEL_GPFIFO_A, 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  260  		{   MAXWELL_CHANNEL_GPFIFO_A, 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  261  		{    KEPLER_CHANNEL_GPFIFO_B, 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  262  		{    KEPLER_CHANNEL_GPFIFO_A, 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  263  		{     FERMI_CHANNEL_GPFIFO  , 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  264  		{       G82_CHANNEL_GPFIFO  , 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  265  		{      NV50_CHANNEL_GPFIFO  , 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  266  		{      NV40_CHANNEL_DMA     , 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  267  		{      NV17_CHANNEL_DMA     , 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  268  		{      NV10_CHANNEL_DMA     , 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  269  		{      NV03_CHANNEL_DMA     , 0 },
06db7fded6dec8 Ben Skeggs          2022-06-01  270  		{}
06db7fded6dec8 Ben Skeggs          2022-06-01  271  	};
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  272  	DEFINE_RAW_FLEX(struct nvif_chan_v0, args, name, TASK_COMM_LEN + 16);
5cca41ac70e587 Ben Skeggs          2024-07-26  273  	struct nvif_device *device = &cli->device;
ebb945a94bba2c Ben Skeggs          2012-07-20  274  	struct nouveau_channel *chan;
06db7fded6dec8 Ben Skeggs          2022-06-01  275  	const u64 plength = 0x10000;
06db7fded6dec8 Ben Skeggs          2022-06-01  276  	const u64 ioffset = plength;
06db7fded6dec8 Ben Skeggs          2022-06-01  277  	const u64 ilength = 0x02000;
06db7fded6dec8 Ben Skeggs          2022-06-01  278  	int cid, ret;
06db7fded6dec8 Ben Skeggs          2022-06-01  279  	u64 size;
06db7fded6dec8 Ben Skeggs          2022-06-01  280  
06db7fded6dec8 Ben Skeggs          2022-06-01  281  	cid = nvif_mclass(&device->object, hosts);
06db7fded6dec8 Ben Skeggs          2022-06-01  282  	if (cid < 0)
06db7fded6dec8 Ben Skeggs          2022-06-01  283  		return cid;
06db7fded6dec8 Ben Skeggs          2022-06-01  284  
06db7fded6dec8 Ben Skeggs          2022-06-01  285  	if (hosts[cid].oclass < NV50_CHANNEL_GPFIFO)
06db7fded6dec8 Ben Skeggs          2022-06-01  286  		size = plength;
06db7fded6dec8 Ben Skeggs          2022-06-01  287  	else
06db7fded6dec8 Ben Skeggs          2022-06-01  288  		size = ioffset + ilength;
ebb945a94bba2c Ben Skeggs          2012-07-20  289  
ebb945a94bba2c Ben Skeggs          2012-07-20  290  	/* allocate dma push buffer */
5cca41ac70e587 Ben Skeggs          2024-07-26  291  	ret = nouveau_channel_prep(cli, size, &chan);
ebb945a94bba2c Ben Skeggs          2012-07-20  292  	*pchan = chan;
ebb945a94bba2c Ben Skeggs          2012-07-20  293  	if (ret)
ebb945a94bba2c Ben Skeggs          2012-07-20  294  		return ret;
ebb945a94bba2c Ben Skeggs          2012-07-20  295  
ebb945a94bba2c Ben Skeggs          2012-07-20  296  	/* create channel object */
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  297  	args->version = 0;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  298  	args->namelen = __member_size(args->name);
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  299  	args->runlist = __ffs64(runm);
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  300  	args->runq = 0;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  301  	args->priv = priv;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  302  	args->devm = BIT(0);
06db7fded6dec8 Ben Skeggs          2022-06-01  303  	if (hosts[cid].oclass < NV50_CHANNEL_GPFIFO) {
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  304  		args->vmm = 0;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  305  		args->ctxdma = nvif_handle(&chan->push.ctxdma);
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  306  		args->offset = chan->push.addr;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  307  		args->length = 0;
bbf8906b2cad17 Ben Skeggs          2014-08-10  308  	} else {
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  309  		args->vmm = nvif_handle(&chan->vmm->vmm.object);
06db7fded6dec8 Ben Skeggs          2022-06-01  310  		if (hosts[cid].oclass < FERMI_CHANNEL_GPFIFO)
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  311  			args->ctxdma = nvif_handle(&chan->push.ctxdma);
06db7fded6dec8 Ben Skeggs          2022-06-01  312  		else
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  313  			args->ctxdma = 0;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  314  		args->offset = ioffset + chan->push.addr;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  315  		args->length = ilength;
06db7fded6dec8 Ben Skeggs          2022-06-01  316  	}
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  317  	args->huserd = 0;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  318  	args->ouserd = 0;
06db7fded6dec8 Ben Skeggs          2022-06-01  319  
06db7fded6dec8 Ben Skeggs          2022-06-01  320  	/* allocate userd */
06db7fded6dec8 Ben Skeggs          2022-06-01  321  	if (hosts[cid].oclass >= VOLTA_CHANNEL_GPFIFO_A) {
06db7fded6dec8 Ben Skeggs          2022-06-01  322  		ret = nvif_mem_ctor(&cli->mmu, "abi16ChanUSERD", NVIF_CLASS_MEM_GF100,
06db7fded6dec8 Ben Skeggs          2022-06-01  323  				    NVIF_MEM_VRAM | NVIF_MEM_COHERENT | NVIF_MEM_MAPPABLE,
06db7fded6dec8 Ben Skeggs          2022-06-01  324  				    0, PAGE_SIZE, NULL, 0, &chan->mem_userd);
06db7fded6dec8 Ben Skeggs          2022-06-01  325  		if (ret)
ebb945a94bba2c Ben Skeggs          2012-07-20  326  			return ret;
ebb945a94bba2c Ben Skeggs          2012-07-20  327  
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  328  		args->huserd = nvif_handle(&chan->mem_userd.object);
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  329  		args->ouserd = 0;
ebb945a94bba2c Ben Skeggs          2012-07-20  330  
06db7fded6dec8 Ben Skeggs          2022-06-01  331  		chan->userd = &chan->mem_userd.object;
06db7fded6dec8 Ben Skeggs          2022-06-01  332  	} else {
06db7fded6dec8 Ben Skeggs          2022-06-01  333  		chan->userd = &chan->user;
06db7fded6dec8 Ben Skeggs          2022-06-01  334  	}
ebb945a94bba2c Ben Skeggs          2012-07-20  335  
e270b3665f8321 Gustavo A. R. Silva 2025-04-16 @336  	snprintf(args->name, __member_size(args->name), "%s[%d]",
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  337  		 current->comm, task_pid_nr(current));
ebb945a94bba2c Ben Skeggs          2012-07-20  338  
06db7fded6dec8 Ben Skeggs          2022-06-01  339  	ret = nvif_object_ctor(&device->object, "abi16ChanUser", 0, hosts[cid].oclass,
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  340  			       args, __struct_size(args), &chan->user);
06db7fded6dec8 Ben Skeggs          2022-06-01  341  	if (ret) {
06db7fded6dec8 Ben Skeggs          2022-06-01  342  		nouveau_channel_del(pchan);
ebb945a94bba2c Ben Skeggs          2012-07-20  343  		return ret;
bbf8906b2cad17 Ben Skeggs          2014-08-10  344  	}
ebb945a94bba2c Ben Skeggs          2012-07-20  345  
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  346  	chan->runlist = args->runlist;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  347  	chan->chid = args->chid;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  348  	chan->inst = args->inst;
e270b3665f8321 Gustavo A. R. Silva 2025-04-16  349  	chan->token = args->token;
06db7fded6dec8 Ben Skeggs          2022-06-01  350  	return 0;
ebb945a94bba2c Ben Skeggs          2012-07-20  351  }
ebb945a94bba2c Ben Skeggs          2012-07-20  352  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

