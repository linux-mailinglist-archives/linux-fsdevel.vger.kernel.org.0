Return-Path: <linux-fsdevel+bounces-58783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64767B3172B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C3B022BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12BB2FD1AB;
	Fri, 22 Aug 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N1or8S1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E02FABE5;
	Fri, 22 Aug 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864384; cv=none; b=tm/X7pmwSug0B562ytBAe87KO62HxM7VMzL2Ilzs/fR/ADwqpr16YPi8fB06TGsyzAK68lDSlv7nnIBbANsDZ+Ig/1SBxOPZgBuDgcG6OV/U/7poeFfDF9YtKUnAAVFKIjRViKZL5iz9vrtLFOJp4hOI3Hjx0agDAe3wQJZU7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864384; c=relaxed/simple;
	bh=oo7a9LMl6LvKVsaPP9YxoC1Kx8MNfiAwhl5ihmWoLPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MILUTqCBLYHrDFLxNT/0pt0VWxjzZqvyhXhL+9G9MDS+b3MflaI83NuBh/xixdA7yDMVq2Icx2RoxVYYqze7sXRhWPWE59/2qFLmlYxIsTLCOIXiQ2DJw6zjLn4+yNK3wgC7aaIr/YlR9wFWXt19a6FfAxTPO8FfxpRFjb8/yNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=N1or8S1w; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ccPu4bTJVH4YGNhd1S906YfRzpqLPlcWMDklK0KtHtk=; b=N1or8S1wu8Iw+g1rx1tY+aHF+Y
	OzAyfUAzK8J2Z61/AEiyJ3Qk24qEEMGRAcZMNoCMxWGUI+CTgbX4i7JUQ0KnbKcB9nRGSsFNxEwJM
	3Aan6Zj4SGMOu4KtTD8+6UrIpJW3T0pIRUCJPsRGRrrohotkoktao3y22E35AB9Qgb9w7oaSp9Ge4
	Ibuj0BDOpw7fglFc9tC65j9f2iqNQA3l2JZo+9p8xIHB17VLqigEljZP3VvEO4tGeRlVD5vhgjxU8
	QVUTc8TjdG3G/jlvRiGzO5xlmDUm38alEBLzxfHR8J6okyKECwdU69yPqalxl5125kJeQbJqkhBii
	sxSTDzlg==;
Received: from [223.233.71.242] (helo=[192.168.1.8])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1upQX9-0005Vq-8O; Fri, 22 Aug 2025 14:06:15 +0200
Message-ID: <dfb52ed4-8f18-1489-e6b4-56180cfa5440@igalia.com>
Date: Fri, 22 Aug 2025 17:36:09 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 3/5] treewide: Replace 'get_task_comm()' with
 'strscpy_pad()'
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Bhupesh <bhupesh@igalia.com>,
 akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, laoar.shao@gmail.com,
 pmladek@suse.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de
References: <20250821102152.323367-4-bhupesh@igalia.com>
 <202508221127.LiaxcbdW-lkp@intel.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <202508221127.LiaxcbdW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/25 9:29 AM, kernel test robot wrote:
> Hi Bhupesh,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 5303936d609e09665deda94eaedf26a0e5c3a087]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250821-182426
> base:   5303936d609e09665deda94eaedf26a0e5c3a087
> patch link:    https://lore.kernel.org/r/20250821102152.323367-4-bhupesh%40igalia.com
> patch subject: [PATCH v8 3/5] treewide: Replace 'get_task_comm()' with 'strscpy_pad()'
> config: x86_64-buildonly-randconfig-001-20250822 (https://download.01.org/0day-ci/archive/20250822/202508221127.LiaxcbdW-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508221127.LiaxcbdW-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508221127.LiaxcbdW-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> drivers/gpu/drm/panthor/panthor_sched.c:3420:2: error: call to undeclared function 'get_task_comm'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      3420 |         get_task_comm(group->task_info.comm, task);
>           |         ^
>     drivers/gpu/drm/panthor/panthor_sched.c:3420:2: note: did you mean 'get_task_mm'?
>     include/linux/sched/mm.h:151:26: note: 'get_task_mm' declared here
>       151 | extern struct mm_struct *get_task_mm(struct task_struct *task);
>           |                          ^
>     1 error generated.
>
>
> vim +/get_task_comm +3420 drivers/gpu/drm/panthor/panthor_sched.c
>
> de85488138247d Boris Brezillon 2024-02-29  3414
> 33b9cb6dcda252 Chia-I Wu       2025-07-17  3415  static void group_init_task_info(struct panthor_group *group)
> 33b9cb6dcda252 Chia-I Wu       2025-07-17  3416  {
> 33b9cb6dcda252 Chia-I Wu       2025-07-17  3417  	struct task_struct *task = current->group_leader;
> 33b9cb6dcda252 Chia-I Wu       2025-07-17  3418
> 33b9cb6dcda252 Chia-I Wu       2025-07-17  3419  	group->task_info.pid = task->pid;
> 33b9cb6dcda252 Chia-I Wu       2025-07-17 @3420  	get_task_comm(group->task_info.comm, task);
> 33b9cb6dcda252 Chia-I Wu       2025-07-17  3421  }
> 33b9cb6dcda252 Chia-I Wu       2025-07-17  3422
>
Ok, let me check the same and fix it in v9.

Thanks.

