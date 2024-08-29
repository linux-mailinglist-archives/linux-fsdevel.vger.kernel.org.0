Return-Path: <linux-fsdevel+bounces-27783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4773963FEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F95AB246A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2281A18E040;
	Thu, 29 Aug 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCVgdYn4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35C18C32B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923566; cv=none; b=LOoqs2whNwVVTdL4Fu3RfD9JrL+KtPdx1ZKjAvCt2DxD76gxYJy8yN1I3sIVYLh6SpwUTCZIWE8d78Sy0tACVtZj62HoCTIEfTgoPNv20UXaYviTtWE8OIjnIoyqFd5gfW6cm6ZRL8dyUzTztREtPyxeKGVNr74XgGPqpQMWMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923566; c=relaxed/simple;
	bh=uutYeKyO7LdsKfzYZjAxmuhW/jm/YwmRfv23rebccWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HmnrzuqcxIu3cnws5NacgnQQ/e55SctxAJjxeLnghFKVGYfAQmgDMS5tDAetHU2SsqxtLNI9E+L3VLiQXpJPe7wu1zJnHVOzMuxEXXKkF8cJMxto1LP9Hl5ysOthkdwuObk1JQuLgczAxU8Snqrrek/pALdFF6MOa63jmV8llx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KCVgdYn4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280c55e488so2370015e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724923562; x=1725528362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gAvX4nxugzvLLHwzqMBg3PEBh+8hsK2td8y9rNRJjlY=;
        b=KCVgdYn4OtBXvGEuARbrqUIaMj0O7hGu+SW8Bhc4fKt8LAoNSvx81cttLqfP0e6gzx
         dStQL0WKtixczvHb+lZYwtgUN3koC6sYjb7MMdCriNwqJgtiPC/gFdZxVr4ZxmF+4k+9
         Tsrhpps91KoG1BxERgO6UhFtpanBc7canHYVrndeBQN3d/INI+9HF9UDxZCcj57fWQe+
         6Nm9PUmlC/9BXebj/cfcSWWi5T06oFdXwPFf+mvByo1dPzWZsqBN8dMABoJr8HeJsYxi
         OiEnjCE0F0ixFb9nLSZVqGv54grD23FXvQH7ckqSV2OrsoliVYq6vuHgNvF674hdlIN4
         hrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923562; x=1725528362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAvX4nxugzvLLHwzqMBg3PEBh+8hsK2td8y9rNRJjlY=;
        b=cUVHuFRPie9hjslDltpGl1U7LLd79jLguJu4Lakz69IYx/LQ3J7320ANTzh9Ihq4bK
         yTwfIBSu+DqeHyb7xjf1qxIgMPOjyAI0Wnb38XYO1njLIVAxiouKBSuOFyujiNbViyAg
         wNn7ihp0b4VKhWt1dUu+NqYu4aQ/9EfsdERynlzrirJvH11WdE1IiIX1ynJ5rrC1TmfY
         szWQ65zvLf64KOfX2rG7b+2JNgiw2a9A31I2vdTkPvJCrUXEEaFq60DitAKNGovBT/Mu
         SyYwGguoOoQvKBboZja3N6pn1EvtOS1vvYiXSTjrhWC7Lxxs+S1pUlNt2B4uWN98s6lw
         MZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPPuTu+20pGvITcSD09KYZYKbOKSeaeE0UMNrMY43XRiFE2SXhD3HUycME4O310U1pvaU3IM1IJg0MavQ0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6mx6XcF4wG0WMDyhMKUO/xF4f/gWUCzMJTYLxz8exA8pooVm
	TCyKX6YqtSWUGlu8jVtuHipgQWdMRE0XkUq4K3JWN7o1Y1IyF1wv4CBwCBe59AM=
X-Google-Smtp-Source: AGHT+IHS0mdsJlWj1rrvXndoz5Oe14EVmdyVaw6esL3Lk15aOpT3/U6xPInumH4Z/7S66CPs1y9WnA==
X-Received: by 2002:a05:600c:1909:b0:426:526f:4a1f with SMTP id 5b1f17b1804b1-42bb74549a5mr6726015e9.16.1724923561802;
        Thu, 29 Aug 2024 02:26:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6396580sm44599855e9.9.2024.08.29.02.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:26:01 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:25:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, krisman@kernel.org,
	Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH 3/5] tmpfs: Create casefold mount options
Message-ID: <fc502406-af31-439c-b8fe-94518dd7c800@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823173332.281211-4-andrealmeid@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/tmpfs-Add-casefold-lookup-support/20240826-135457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240823173332.281211-4-andrealmeid%40igalia.com
patch subject: [PATCH 3/5] tmpfs: Create casefold mount options
config: x86_64-randconfig-161-20240827 (https://download.01.org/0day-ci/archive/20240829/202408290349.lp2Eq74b-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202408290349.lp2Eq74b-lkp@intel.com/

smatch warnings:
mm/shmem.c:4307 shmem_parse_opt_casefold() error: uninitialized symbol 'maj'.
mm/shmem.c:4307 shmem_parse_opt_casefold() error: uninitialized symbol 'min'.
mm/shmem.c:4307 shmem_parse_opt_casefold() error: uninitialized symbol 'rev'.

vim +/maj +4307 mm/shmem.c

a024e87c2944676 André Almeida 2024-08-23  4291  static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param)
a024e87c2944676 André Almeida 2024-08-23  4292  {
a024e87c2944676 André Almeida 2024-08-23  4293  	struct shmem_options *ctx = fc->fs_private;
a024e87c2944676 André Almeida 2024-08-23  4294  	unsigned int maj, min, rev, version_number;
a024e87c2944676 André Almeida 2024-08-23  4295  	char version[10];
a024e87c2944676 André Almeida 2024-08-23  4296  	int ret;
a024e87c2944676 André Almeida 2024-08-23  4297  	struct unicode_map *encoding;
a024e87c2944676 André Almeida 2024-08-23  4298  
a024e87c2944676 André Almeida 2024-08-23  4299  	if (strncmp(param->string, "utf8-", 5))
a024e87c2944676 André Almeida 2024-08-23  4300  		return invalfc(fc, "Only utf8 encondings are supported");
a024e87c2944676 André Almeida 2024-08-23  4301  	ret = strscpy(version, param->string + 5, sizeof(version));
a024e87c2944676 André Almeida 2024-08-23  4302  	if (ret < 0)
a024e87c2944676 André Almeida 2024-08-23  4303  		return invalfc(fc, "Invalid enconding argument: %s",
a024e87c2944676 André Almeida 2024-08-23  4304  			       param->string);
a024e87c2944676 André Almeida 2024-08-23  4305  
a024e87c2944676 André Almeida 2024-08-23  4306  	utf8_parse_version(version, &maj, &min, &rev);

No error checking

a024e87c2944676 André Almeida 2024-08-23 @4307  	version_number = UNICODE_AGE(maj, min, rev);
                                                                                     ^^^^^^^^^^^^^

a024e87c2944676 André Almeida 2024-08-23  4308  	encoding = utf8_load(version_number);
a024e87c2944676 André Almeida 2024-08-23  4309  	if (IS_ERR(encoding))
a024e87c2944676 André Almeida 2024-08-23  4310  		return invalfc(fc, "Invalid utf8 version: %s", version);
a024e87c2944676 André Almeida 2024-08-23  4311  	pr_info("tmpfs: Using encoding provided by mount options: %s\n",
a024e87c2944676 André Almeida 2024-08-23  4312  		param->string);
a024e87c2944676 André Almeida 2024-08-23  4313  	ctx->encoding = encoding;
a024e87c2944676 André Almeida 2024-08-23  4314  
a024e87c2944676 André Almeida 2024-08-23  4315  	return 0;
a024e87c2944676 André Almeida 2024-08-23  4316  }
a024e87c2944676 André Almeida 2024-08-23  4317  #else
a024e87c2944676 André Almeida 2024-08-23  4318  static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param)
a024e87c2944676 André Almeida 2024-08-23  4319  {
a024e87c2944676 André Almeida 2024-08-23  4320  	return invalfc(fc, "tmpfs: No kernel support for casefold filesystems\n");
a024e87c2944676 André Almeida 2024-08-23  4321  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


