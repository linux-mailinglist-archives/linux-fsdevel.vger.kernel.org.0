Return-Path: <linux-fsdevel+bounces-19654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A48C8579
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 13:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B11EB216F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BC03C488;
	Fri, 17 May 2024 11:21:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86433B78B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944881; cv=none; b=X9+zic12iyKbTTcUJSsXg3aqmoJ8Iyg+HvLZCAO+i/rSIT2wVurlL4+N0QIRP8MmUQYOgVTME5pbtyfH/kdygrbk2HzpwvJrwM2QpXIPcvC757q11ub/a/r3/61YiQcJj5bJycHTrJrVl64x1ZhqRg55Ezr/CMTisKAv4WSieeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944881; c=relaxed/simple;
	bh=O3MvDgy0G3K4t+p2hOlemyythq2xz/4e2lquDtfLcKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g3r0DB7uUkbMlaGHBe4ScIoUBoPaZsCnnnYrNbLbRGjBGk0Y2AnFAdFpZovqQSkHS4el4m11+lN22Ny0HRDvti4TVIDZr1SO+3MMYxXiYw2bW87Y01xE1j7DtC9VDSu5i/waKedSrGQeE5OCsvyaiXtRTFja2z1pLbMIU23BISY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VgkyM3ZQKzcf8s;
	Fri, 17 May 2024 19:19:55 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C03391402CA;
	Fri, 17 May 2024 19:21:10 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 19:21:10 +0800
Message-ID: <74576c52-5eca-4961-ada4-a9ec99fb16cf@huawei.com>
Date: Fri, 17 May 2024 19:21:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostfs: convert hostfs to use the new mount api
To: Dan Carpenter <dan.carpenter@linaro.org>, <oe-kbuild@lists.linux.dev>,
	<richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>
CC: <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <d845ba1a-2b10-4d83-a687-56406ce657c9@suswa.mountain>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d845ba1a-2b10-4d83-a687-56406ce657c9@suswa.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Thanks for your attention, I have solved the warnings in the following 
patch (the similar title: hostfs: convert hostfs to use the new mount API):

https://lore.kernel.org/all/20240515025536.3667017-1-lihongbo22@huawei.com/

or

https://patchwork.ozlabs.org/project/linux-um/patch/20240515025536.3667017-1-lihongbo22@huawei.com/

It was strange that the kernel test robot did not send the results on 
the new patch.

Thanks,
Hongbo

On 2024/5/17 19:01, Dan Carpenter wrote:
> Hi Hongbo,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/hostfs-convert-hostfs-to-use-the-new-mount-api/20240513-204233
> base:   git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
> patch link:    https://lore.kernel.org/r/20240513124141.3788846-1-lihongbo22%40huawei.com
> patch subject: [PATCH] hostfs: convert hostfs to use the new mount api
> config: um-randconfig-r081-20240517 (https://download.01.org/0day-ci/archive/20240517/202405171154.21q42SWy-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d3455f4ddd16811401fa153298fadd2f59f6914e)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202405171154.21q42SWy-lkp@intel.com/
> 
> smatch warnings:
> fs/hostfs/hostfs_kern.c:960 hostfs_fill_super() error: uninitialized symbol 'host_root'.
> 
> vim +/host_root +960 fs/hostfs/hostfs_kern.c
> 
> 2c2593890079e8 Hongbo Li         2024-05-13  938  static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  939  {
> 2c2593890079e8 Hongbo Li         2024-05-13  940  	struct hostfs_fs_info *fsi = sb->s_fs_info;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  941  	struct inode *root_inode;
> 2c2593890079e8 Hongbo Li         2024-05-13  942  	char *host_root;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  943  	int err;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  944
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  945  	sb->s_blocksize = 1024;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  946  	sb->s_blocksize_bits = 10;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  947  	sb->s_magic = HOSTFS_SUPER_MAGIC;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  948  	sb->s_op = &hostfs_sbops;
> b26d4cd385fc51 Al Viro           2013-10-25  949  	sb->s_d_op = &simple_dentry_operations;
> 752fa51e4c5182 Wolfgang Illmeyer 2009-06-30  950  	sb->s_maxbytes = MAX_LFS_FILESIZE;
> ce72750f04d68a Sjoerd Simons     2021-11-05  951  	err = super_setup_bdi(sb);
> ce72750f04d68a Sjoerd Simons     2021-11-05  952  	if (err)
> 74ce793bcbde5c Mickaël Salaün    2023-06-12  953  		return err;
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  954
> b58c4e96192ee7 Andy Shevchenko   2020-03-20  955  	/* NULL is printed as '(null)' by printf(): avoid that. */
> 2c2593890079e8 Hongbo Li         2024-05-13  956  	if (fc->source == NULL)
> 2c2593890079e8 Hongbo Li         2024-05-13  957  		host_root = "";
> 
> Uninitialized on else path
> 
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  958
> 2c2593890079e8 Hongbo Li         2024-05-13  959  	fsi->host_root_path =
> 2c2593890079e8 Hongbo Li         2024-05-13 @960  		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
>                                                                                                           ^^^^^^^^^
> 
> 
> 2c2593890079e8 Hongbo Li         2024-05-13  961  	if (fsi->host_root_path == NULL)
> 74ce793bcbde5c Mickaël Salaün    2023-06-12  962  		return -ENOMEM;
> 

