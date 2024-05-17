Return-Path: <linux-fsdevel+bounces-19653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2658C852A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D981C22C36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE273B2A6;
	Fri, 17 May 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3wtGQS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A085200D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943697; cv=none; b=gcNNP2OpARIlgdEuMyOLr+LD6OJ/f+lY4R4lxlFvRQc9kaPGBGPDyHBYgPX29BUMNE/WJ4NVCIQ1vZOd9y/15bjO/oJ6X5NCoFFvmUUzE4zkC6MC+9wX5SvgWQHYRLpLWJsDqcRRjtI6nMcYb7fMj0iSk23AYgZzR6YZfnhBhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943697; c=relaxed/simple;
	bh=tVRF4RaYBVX+KzaS74RJYVtbLqfxhP6c/vZtg/ARxG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YFYQL32r15KMz8S6meKVix98oIpET7lymqp7AU4vwf/aPCsihgJ1TgH2rJ5IbwgEmpQ8wohoUuSRDfWxD5rZ5HQ1b2YmvCmP2VAMwZZ0CC6klJStnEi84bRafoppOsY//iYGHoUNJI9IZieCDwdUZwBOPxvXcQbFmUMy/+JhOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J3wtGQS1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59e4136010so476264366b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715943694; x=1716548494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8VnQm4Wzd0jj3I6yb4jC8r7D5oR7hIr9rTTosx/fIZs=;
        b=J3wtGQS1k6xFK37jzIZT18XhYZb5nkIcWsXnkp1Dc50WS3EXNbJGS7o6IutTlDEBK7
         Im0K+jdHtwwneTfUl5uJUPFLnLv5wAScjeMQgqOTlTprulXVzdkqqtbTRqhxMKUrqcrg
         wjSUksC7ndVLDDT7tQVsuqCV9LwsbV9ZraWNZdMcCgKzbJmEDVUrqh3kOvDAyTpkxudb
         AGlsdHlTSfTTQfmNC7q0q+C1bkWCye8sidQoOdnhgolyxjrLJ1KlC4b6dghvp8w03/md
         QRoHpUwx51wwmYj2rgeQ8DqDMSUPvPIVlmRj4S6jGdWS2TS16tFThoPrMdAhM5y5ei6l
         GZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715943694; x=1716548494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VnQm4Wzd0jj3I6yb4jC8r7D5oR7hIr9rTTosx/fIZs=;
        b=k+N4IwKyzj01XyHNy11Ag2Dr7vF9muTxje2rM3d/4wuQlgO7PujQS5mmrtDIGncyoM
         wuM/sp9BYWlidvAORs6zZVItkPUfa91wOT+53HqY11bbAnoviOcFuNLRLz2uLw81tE8e
         EIhkOMMBfe2dp41YMnI8mOXo0TrQxK9rDRHDacruBNCiZceEOtsgziQoSQZKcNE6hlaB
         IJd48uXDaQ2aIA9rPFDQ78gDUTHYbwNs/4CekDWRUeDqyRwMnu8UGgMHzU83ZgNM04rJ
         A1l+W3fKcwiMd8PtQZpXtdlCKCq4XwTaVKQsYqBTC4idUzSRIqW5uGFyxsdTufY/isG3
         lWwA==
X-Forwarded-Encrypted: i=1; AJvYcCUzovTVK4VkGBh1OewXdnB8yZmYSZev+IwTFbynh9gqP0AWyd874WMkAXM+ZGJt+Ng/UcMUUbUem1rERmDivWpn4X+8MYshPdmszf+8bQ==
X-Gm-Message-State: AOJu0Yy4WL3LggfBR4bp+4D1CRgrztYMpJWcyGHDDgHRfCt+7J506DUS
	KEzA0XDU1gD4Yw8sQSnd1M5einLUQoURaH712Pu+SE2uEbXkvQex6ylZ7MkM71w=
X-Google-Smtp-Source: AGHT+IGo0vF44PU8Flj2L8GcXH3uM02w5tyFNQ9qE8+bL2lhGta8EhoiS+njX2Y3R8ShLB5wWk0tPw==
X-Received: by 2002:a17:906:8315:b0:a5a:d6c:a30b with SMTP id a640c23a62f3a-a5a2d65f265mr1511949966b.58.1715943694164;
        Fri, 17 May 2024 04:01:34 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01968sm1108799366b.166.2024.05.17.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:01:33 -0700 (PDT)
Date: Fri, 17 May 2024 13:01:31 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Hongbo Li <lihongbo22@huawei.com>,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	lihongbo22@huawei.com
Subject: Re: [PATCH] hostfs: convert hostfs to use the new mount api
Message-ID: <d845ba1a-2b10-4d83-a687-56406ce657c9@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513124141.3788846-1-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/hostfs-convert-hostfs-to-use-the-new-mount-api/20240513-204233
base:   git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20240513124141.3788846-1-lihongbo22%40huawei.com
patch subject: [PATCH] hostfs: convert hostfs to use the new mount api
config: um-randconfig-r081-20240517 (https://download.01.org/0day-ci/archive/20240517/202405171154.21q42SWy-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d3455f4ddd16811401fa153298fadd2f59f6914e)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405171154.21q42SWy-lkp@intel.com/

smatch warnings:
fs/hostfs/hostfs_kern.c:960 hostfs_fill_super() error: uninitialized symbol 'host_root'.

vim +/host_root +960 fs/hostfs/hostfs_kern.c

2c2593890079e8 Hongbo Li         2024-05-13  938  static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
^1da177e4c3f41 Linus Torvalds    2005-04-16  939  {
2c2593890079e8 Hongbo Li         2024-05-13  940  	struct hostfs_fs_info *fsi = sb->s_fs_info;
^1da177e4c3f41 Linus Torvalds    2005-04-16  941  	struct inode *root_inode;
2c2593890079e8 Hongbo Li         2024-05-13  942  	char *host_root;
^1da177e4c3f41 Linus Torvalds    2005-04-16  943  	int err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  944  
^1da177e4c3f41 Linus Torvalds    2005-04-16  945  	sb->s_blocksize = 1024;
^1da177e4c3f41 Linus Torvalds    2005-04-16  946  	sb->s_blocksize_bits = 10;
^1da177e4c3f41 Linus Torvalds    2005-04-16  947  	sb->s_magic = HOSTFS_SUPER_MAGIC;
^1da177e4c3f41 Linus Torvalds    2005-04-16  948  	sb->s_op = &hostfs_sbops;
b26d4cd385fc51 Al Viro           2013-10-25  949  	sb->s_d_op = &simple_dentry_operations;
752fa51e4c5182 Wolfgang Illmeyer 2009-06-30  950  	sb->s_maxbytes = MAX_LFS_FILESIZE;
ce72750f04d68a Sjoerd Simons     2021-11-05  951  	err = super_setup_bdi(sb);
ce72750f04d68a Sjoerd Simons     2021-11-05  952  	if (err)
74ce793bcbde5c Mickaël Salaün    2023-06-12  953  		return err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  954  
b58c4e96192ee7 Andy Shevchenko   2020-03-20  955  	/* NULL is printed as '(null)' by printf(): avoid that. */
2c2593890079e8 Hongbo Li         2024-05-13  956  	if (fc->source == NULL)
2c2593890079e8 Hongbo Li         2024-05-13  957  		host_root = "";

Uninitialized on else path

^1da177e4c3f41 Linus Torvalds    2005-04-16  958  
2c2593890079e8 Hongbo Li         2024-05-13  959  	fsi->host_root_path =
2c2593890079e8 Hongbo Li         2024-05-13 @960  		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
                                                                                                         ^^^^^^^^^


2c2593890079e8 Hongbo Li         2024-05-13  961  	if (fsi->host_root_path == NULL)
74ce793bcbde5c Mickaël Salaün    2023-06-12  962  		return -ENOMEM;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


