Return-Path: <linux-fsdevel+bounces-7173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D16822BF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF850B2269B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CFE18E15;
	Wed,  3 Jan 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Owqi6S63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAA18EA1
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a235eb41251so1161307966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 03:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704280584; x=1704885384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrSPjHgdnH+nXilbqn4FMcNgLITuz+LIFPl1XscWIj4=;
        b=Owqi6S63H5T1K+L6BI7Dv7ZwecRAfXL1UsHgQWwjJ6hsyuauuBHqAhTljxSn9Ulz9B
         XBG8J2e0fE3tUEitcZflTKGL+oA7+oBPj3YAhLSunPKz9JsMoyFVQh7g+5tMdCNZ91cm
         ZRaXf18HKuL/zNMCYIEkzOKwTqetP64hKbXxavmwdn/GRNIu78cawCg9KV3QVn5DAzC1
         6cbf/vFxrrqcVlt9niH2YkqSNpgvOszeY0AIhTH//8/XHPirkx95UlQvB5IWSDKBUkfi
         ZSkrzcjqGRzqTA5ThQTdic4SIXuHPzzYriAdgdDup6VOusf4Q//puPvatV9xN0TkUgYD
         sdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704280584; x=1704885384;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrSPjHgdnH+nXilbqn4FMcNgLITuz+LIFPl1XscWIj4=;
        b=dTTfJ8W/KWnlGCfMj1pXvWplIdGyTzMXx97nGcfY3fOteUZUrg83j4c14euBApVtvg
         WyDPwkp2m1Ju7ed2IWQOtVSbJXeroLQzFpdg6Lj8GrTLylhmC1Qh6zebcxyWcw7U6xWA
         OUL9wmcIOHD9GfGeV2t4UR6XnBkdniIXb5oX88hvJnHT0Q+r2qQmX9XlfanrzmApxz9+
         yqY4fS0bpAcehy5wdToBhTfk1i12LLNiam7Ug24yB5G5Qw+cghHYlO0ngUHi50X4xIWJ
         FFJIMql+rRmdMO/ZCcXWpciKEeF5xKGH9FgMV3QYPsVE4c8BtinU5RRFG5qR85wR637x
         WX2g==
X-Gm-Message-State: AOJu0YzESOUYoUmy93h73xO2sL+SJfm8zLUiA9qBGtjA3/RCb5yq1qzB
	Q0RUFyw0vs8VHw+2WdWF6yUh2D6uLcks3Q==
X-Google-Smtp-Source: AGHT+IFBs8+CfUnkn5KZED57Ux5CruC7jlDlvcBky02qrjRW+1r7HJfy+cjUpFsYHGo5VhV+D6rBwQ==
X-Received: by 2002:a17:906:3858:b0:a27:9e2d:a453 with SMTP id w24-20020a170906385800b00a279e2da453mr2449018ejc.108.1704280583894;
        Wed, 03 Jan 2024 03:16:23 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id fi8-20020a1709073ac800b00a272de16f52sm7268505ejc.112.2024.01.03.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 03:16:23 -0800 (PST)
Date: Wed, 3 Jan 2024 14:16:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Gregory Price <gourry.memverge@gmail.com>,
	linux-mm@kvack.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com,
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com,
	honggyu.kim@sk.com, vtavarespetr@micron.com, peterz@infradead.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com
Subject: Re: [PATCH v4 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2
 to support weighted interleave
Message-ID: <94405fba-8539-425b-b21a-3016cdd7be91@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218194631.21667-12-gregory.price@memverge.com>

Hi Gregory,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231219-074837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools
patch link:    https://lore.kernel.org/r/20231218194631.21667-12-gregory.price%40memverge.com
patch subject: [PATCH v4 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2 to support weighted interleave
config: x86_64-randconfig-161-20231219 (https://download.01.org/0day-ci/archive/20231220/202312200223.7X9rUFgu-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312200223.7X9rUFgu-lkp@intel.com/

smatch warnings:
mm/mempolicy.c:2044 __do_sys_get_mempolicy2() warn: maybe return -EFAULT instead of the bytes remaining?
mm/mempolicy.c:2044 __do_sys_get_mempolicy2() warn: maybe return -EFAULT instead of the bytes remaining?

vim +2044 mm/mempolicy.c

a2af87404eb73e Gregory Price     2023-12-18  1992  SYSCALL_DEFINE4(get_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
a2af87404eb73e Gregory Price     2023-12-18  1993  		unsigned long, addr, unsigned long, flags)
a2af87404eb73e Gregory Price     2023-12-18  1994  {
a2af87404eb73e Gregory Price     2023-12-18  1995  	struct mpol_args kargs;
a2af87404eb73e Gregory Price     2023-12-18  1996  	struct mempolicy_args margs;
a2af87404eb73e Gregory Price     2023-12-18  1997  	int err;
a2af87404eb73e Gregory Price     2023-12-18  1998  	nodemask_t policy_nodemask;
a2af87404eb73e Gregory Price     2023-12-18  1999  	unsigned long __user *nodes_ptr;
8bfd7ddc0dd439 Gregory Price     2023-12-18  2000  	unsigned char __user *weights_ptr;
8bfd7ddc0dd439 Gregory Price     2023-12-18  2001  	unsigned char weights[MAX_NUMNODES];
a2af87404eb73e Gregory Price     2023-12-18  2002  
a2af87404eb73e Gregory Price     2023-12-18  2003  	if (flags & ~(MPOL_F_ADDR))
a2af87404eb73e Gregory Price     2023-12-18  2004  		return -EINVAL;
a2af87404eb73e Gregory Price     2023-12-18  2005  
a2af87404eb73e Gregory Price     2023-12-18  2006  	/* initialize any memory liable to be copied to userland */
a2af87404eb73e Gregory Price     2023-12-18  2007  	memset(&margs, 0, sizeof(margs));
8bfd7ddc0dd439 Gregory Price     2023-12-18  2008  	memset(weights, 0, sizeof(weights));
a2af87404eb73e Gregory Price     2023-12-18  2009  
a2af87404eb73e Gregory Price     2023-12-18  2010  	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
a2af87404eb73e Gregory Price     2023-12-18  2011  	if (err)
a2af87404eb73e Gregory Price     2023-12-18  2012  		return -EINVAL;
a2af87404eb73e Gregory Price     2023-12-18  2013  
8bfd7ddc0dd439 Gregory Price     2023-12-18  2014  	if (kargs.il_weights)
8bfd7ddc0dd439 Gregory Price     2023-12-18  2015  		margs.il_weights = weights;
8bfd7ddc0dd439 Gregory Price     2023-12-18  2016  	else
8bfd7ddc0dd439 Gregory Price     2023-12-18  2017  		margs.il_weights = NULL;
8bfd7ddc0dd439 Gregory Price     2023-12-18  2018  
a2af87404eb73e Gregory Price     2023-12-18  2019  	margs.policy_nodes = kargs.pol_nodes ? &policy_nodemask : NULL;
a2af87404eb73e Gregory Price     2023-12-18  2020  	if (flags & MPOL_F_ADDR)
a2af87404eb73e Gregory Price     2023-12-18  2021  		err = do_get_vma_mempolicy(untagged_addr(addr), NULL, &margs);
a2af87404eb73e Gregory Price     2023-12-18  2022  	else
a2af87404eb73e Gregory Price     2023-12-18  2023  		err = do_get_task_mempolicy(&margs);
a2af87404eb73e Gregory Price     2023-12-18  2024  
a2af87404eb73e Gregory Price     2023-12-18  2025  	if (err)
a2af87404eb73e Gregory Price     2023-12-18  2026  		return err;
a2af87404eb73e Gregory Price     2023-12-18  2027  
a2af87404eb73e Gregory Price     2023-12-18  2028  	kargs.mode = margs.mode;
a2af87404eb73e Gregory Price     2023-12-18  2029  	kargs.mode_flags = margs.mode_flags;
a2af87404eb73e Gregory Price     2023-12-18  2030  	kargs.policy_node = margs.policy_node;
a2af87404eb73e Gregory Price     2023-12-18  2031  	kargs.home_node = margs.home_node;
a2af87404eb73e Gregory Price     2023-12-18  2032  	if (kargs.pol_nodes) {
a2af87404eb73e Gregory Price     2023-12-18  2033  		nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
a2af87404eb73e Gregory Price     2023-12-18  2034  		err = copy_nodes_to_user(nodes_ptr, kargs.pol_maxnodes,
a2af87404eb73e Gregory Price     2023-12-18  2035  					 margs.policy_nodes);
a2af87404eb73e Gregory Price     2023-12-18  2036  		if (err)
a2af87404eb73e Gregory Price     2023-12-18  2037  			return err;

This looks wrong as well.

a2af87404eb73e Gregory Price     2023-12-18  2038  	}
a2af87404eb73e Gregory Price     2023-12-18  2039  
8bfd7ddc0dd439 Gregory Price     2023-12-18  2040  	if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE && kargs.il_weights) {
8bfd7ddc0dd439 Gregory Price     2023-12-18  2041  		weights_ptr = u64_to_user_ptr(kargs.il_weights);
8bfd7ddc0dd439 Gregory Price     2023-12-18  2042  		err = copy_to_user(weights_ptr, weights, kargs.pol_maxnodes);
8bfd7ddc0dd439 Gregory Price     2023-12-18  2043  		if (err)
8bfd7ddc0dd439 Gregory Price     2023-12-18 @2044  			return err;

This should return -EFAULT same as the copy_to_user() on the next line.

8bfd7ddc0dd439 Gregory Price     2023-12-18  2045  	}
8bfd7ddc0dd439 Gregory Price     2023-12-18  2046  
a2af87404eb73e Gregory Price     2023-12-18  2047  	return copy_to_user(uargs, &kargs, usize) ? -EFAULT : 0;
a2af87404eb73e Gregory Price     2023-12-18  2048  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


