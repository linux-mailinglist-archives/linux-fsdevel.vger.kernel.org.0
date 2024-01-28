Return-Path: <linux-fsdevel+bounces-9273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F44183FB15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 00:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13CD2825D5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C34594F;
	Sun, 28 Jan 2024 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NF7sQSeF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160BB446A3
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706485915; cv=none; b=F6IJ4QhSauhzXbxnMsuOz3Wf+Bog+yPLVjCrutBfdOtWlq6IgyX4eFd983e4VqC3OIXzWUBj4F4voavPXPnOQgacOCxBhpX5h5Jz2Oqdsaaoq4d204rkinloDEFd7JnlBL8ZhsmaKHe05+q92eW6Yt2nEA5QX7B88VENChCGXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706485915; c=relaxed/simple;
	bh=KYyRSJNmkJjXA317lVGEfWHF6Kz9icWCrEbj0iKyVNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLcy/VNRP9QEFgkXgplFI8fBu3T5LDcVy6tuOXKf28Qxc9A5Neq1oUfo265yt8krrEhBL6larlX7lnvzDtpZ0ABGrww5uje4qiOf8r5Dy5DwxXoCWvq9AbSSo8Timcl98mZmQWyERD/tkmDBWxXHpgYULX/PfVRH1vSM4vM5vdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NF7sQSeF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706485913; x=1738021913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KYyRSJNmkJjXA317lVGEfWHF6Kz9icWCrEbj0iKyVNY=;
  b=NF7sQSeFf+Y4iG+jZA8/ip8IYJcl5tR4TXAfZvcU12lGKlpTzjEm+74W
   RSMFkMIGwbDxgOXWwLN8yGeXXM0UM34iw/gjhBYRdJgSyVPMST/i+DBKV
   Quvagzj+mV46K/DTLA3ViVifmi8MeWS1LXQaToKiZ9azY2A3fMciDsJdm
   U8G/Vr7wKvdetHIQvjcC2LSbBykqavNrdPvkiW65DScDvDhrJk22iwyAa
   mSX95SZMwU1+o9B4A8twMeev8dDM87nBvYjrlCmghaLuHBqtVD6MzZrCs
   9JN3YMCT1jQC3gmKCgLLFBdNbI44/14BWrlF3sP7ZnW95+LDW4JJfVx1Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9927338"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="9927338"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="906898598"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="906898598"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2024 15:51:50 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUEwG-0003rQ-23;
	Sun, 28 Jan 2024 23:51:48 +0000
Date: Mon, 29 Jan 2024 07:50:58 +0800
From: kernel test robot <lkp@intel.com>
To: Tony Solomonik <tony.solomonik@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, willy@infradead.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: Re: [PATCH v7 1/2] Add do_ftruncate that truncates a struct file
Message-ID: <202401290716.JZDZbcf3-lkp@intel.com>
References: <20240126155720.20385-2-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126155720.20385-2-tony.solomonik@gmail.com>

Hi Tony,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Solomonik/Add-do_ftruncate-that-truncates-a-struct-file/20240126-235914
base:   d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
patch link:    https://lore.kernel.org/r/20240126155720.20385-2-tony.solomonik%40gmail.com
patch subject: [PATCH v7 1/2] Add do_ftruncate that truncates a struct file
config: i386-randconfig-141-20240129 (https://download.01.org/0day-ci/archive/20240129/202401290716.JZDZbcf3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401290716.JZDZbcf3-lkp@intel.com/

smatch warnings:
fs/open.c:178 do_ftruncate() warn: inconsistent indenting

vim +178 fs/open.c

   156	
   157	long do_ftruncate(struct file *file, loff_t length)
   158	{
   159		struct inode *inode;
   160		struct dentry *dentry;
   161		int error;
   162	
   163		dentry = file->f_path.dentry;
   164		inode = dentry->d_inode;
   165		if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
   166			return -EINVAL;
   167	
   168		/* Check IS_APPEND on real upper inode */
   169		if (IS_APPEND(file_inode(file)))
   170			return -EPERM;
   171		sb_start_write(inode->i_sb);
   172		error = security_file_truncate(file);
   173		if (!error)
   174			error = do_truncate(file_mnt_idmap(file), dentry, length,
   175					    ATTR_MTIME | ATTR_CTIME, file);
   176		sb_end_write(inode->i_sb);
   177	
 > 178	  return error;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

