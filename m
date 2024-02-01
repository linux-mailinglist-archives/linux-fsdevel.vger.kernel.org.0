Return-Path: <linux-fsdevel+bounces-9808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7241D8451B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 08:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101B6B267F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 07:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEFA43144;
	Thu,  1 Feb 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6Dw5KnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC33157E89;
	Thu,  1 Feb 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706770919; cv=none; b=S9HlbtkbWX+VPHy7jFqeJjcwutS7hT8xxiJAs2n+qpCrU7KHJmHm+tX2a/lYj0zCdgV/edlG9uz94J/nCR62Us0IWCSDfKPrqHye4Yf1VDPwsm6NSK8Icmf2/8fALsBvH++MKdoSXTyI7YkE+nVFpdj6TD/XB8iKG+RvEmDiiGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706770919; c=relaxed/simple;
	bh=Z0os6sV4H7BI+19bTCyZJGJy6DbnbMpARctTbP6TdfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnVTOwvkGLrXUCLfYwB/Yu0BEjzJArxBFzquRqTRuoU7oaWPNopRCOTAMBsPzIqoLvGvkat2Ml8OroA/PsSMlPuctCxSVu/DTFPR64QASPJN6sKmLwj6fT6WYNKIxQWffSC7yAnXFzlRJJsabkkq7J7f0mXn+5ujyHOIylPvdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6Dw5KnM; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706770918; x=1738306918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z0os6sV4H7BI+19bTCyZJGJy6DbnbMpARctTbP6TdfA=;
  b=S6Dw5KnMXRyeguOR32qcptgCzbNJ7qOF7aCTr5mBHDAohc+VpTUI4vau
   r7morwH7iQiFFnSrRrMRAhmDACf3J663SWuGstcbQpduznDcSjg+OiiUc
   Kw1zISPTJaxJ8soQGzt6w0cG+g9BQbT5dkFepLa9VlLSEIyqEMhBwzHUY
   Y+GEY11kDUVYpsIBUSqI7eiBMb+wTrZpESkBpnSwySsaCwUA2mddUgAOQ
   eCR7ErcbAU1om+d0AF2xv2CApHVgtL3xSd9aIJ0sl6K6YxicyGiFfdvDU
   mDPyamA1N1PDD/DacrEXDSxChB4VBhAQSebCuDKxwnxBxtOho6tH+Pt25
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407542951"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="407542951"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 23:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788861726"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788861726"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2024 23:01:53 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVR52-0002UO-2K;
	Thu, 01 Feb 2024 07:01:49 +0000
Date: Thu, 1 Feb 2024 15:01:10 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH DRAFT 1/4] : tracefs: port to kernfs
Message-ID: <202402011431.c6K3rKZS-lkp@intel.com>
References: <20240131-tracefs-kernfs-v1-1-f20e2e9a8d61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-tracefs-kernfs-v1-1-f20e2e9a8d61@kernel.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 41bccc98fb7931d63d03f326a746ac4d429c1dd3]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/tracefs-port-to-kernfs/20240131-214120
base:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
patch link:    https://lore.kernel.org/r/20240131-tracefs-kernfs-v1-1-f20e2e9a8d61%40kernel.org
patch subject: [PATCH DRAFT 1/4] : tracefs: port to kernfs
config: i386-randconfig-061-20240201 (https://download.01.org/0day-ci/archive/20240201/202402011431.c6K3rKZS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402011431.c6K3rKZS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402011431.c6K3rKZS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/tracefs/inode.c:88:27: sparse: sparse: symbol 'global_opts' was not declared. Should it be static?

vim +/global_opts +88 fs/tracefs/inode.c

    87	
  > 88	struct tracefs_mount_opts global_opts = {
    89		.mode	= TRACEFS_DEFAULT_MODE,
    90		.uid	= GLOBAL_ROOT_UID,
    91		.gid	= GLOBAL_ROOT_GID,
    92		.opts	= 0,
    93	};
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

