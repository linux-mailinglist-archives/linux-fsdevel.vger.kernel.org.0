Return-Path: <linux-fsdevel+bounces-9238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7AC83F522
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 12:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AD7283675
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04E200AA;
	Sun, 28 Jan 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UK+cUsN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BF1EB20;
	Sun, 28 Jan 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706441077; cv=none; b=WyRk9GaeocEAUVtGPIcIZLFCbCUYbq3C4o/RAGvXQyPVNDKcfuthIB83v/8+ydZrUQkKcDQq2Ic6CSp06gfJjpA8aARJWAd9d9iMECg+7ff/b+DhQX3VaCsBUXasTvU9ai6nPm51koMN5hbJ1srJgTPaxMonYn5N1FmsZLXfe+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706441077; c=relaxed/simple;
	bh=KNaq6FiBBjclWVzp6k4jvy23iUnCG4CcpVAGv3MI8Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3mE4iWT0yjZJRjWDwtEoQkPI8p9LresDv0lYwM272m/9M3Hw9RpzL8uzKOcEuni6RwcFWVHnYwiu6bSPaNKnJ2bynAkKKtD4g3b/OF3VVqs1jIex4eVU7pAmmG76vq3htb3xYyYvh87lNcJRwR8YdLe6zjHCsMCn4pEPiP2j60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UK+cUsN7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706441075; x=1737977075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KNaq6FiBBjclWVzp6k4jvy23iUnCG4CcpVAGv3MI8Uw=;
  b=UK+cUsN7A+IxZNjrOEE+vz9gkfXhwlFWIJWxRMS3hH2oAfxkf+1HaDjz
   huTAm2nsB28FrCaZbcCnKCUdAiZx1PrA+4O8ricJ0yDEmG2nhnHVZg90V
   aTe+zglgMKBlpHiTtEZr/zcuQL8kzgmZvpou93nGa14pr12MXIfkgx+Pv
   9xZWFV7m+iUBdAVXY2BmNQTBPELE7y7nbnpnZ7ZbICnFUikWTxlsXsWQY
   pLowVFdcB81kqhaP4fkO7uGJjcxqO8p9Q6TEPRbJtMIgdWJkhGfMRjZof
   UU+yiuNVKww1xMTIXb/xh/TV0auNmgtCLrRFS+dfVUKj18jivS79k6EQr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2592988"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2592988"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 03:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3187856"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Jan 2024 03:24:26 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU3Gx-0003LS-0y;
	Sun, 28 Jan 2024 11:24:23 +0000
Date: Sun, 28 Jan 2024 19:24:02 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, chuck.lever@oracle.com,
	jlayton@kernel.org, linux-api@vger.kernel.org, brauner@kernel.org,
	edumazet@google.com, davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Joe Damato <jdamato@fastly.com>, Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-doc@vger.kernel.org,
	"(open list:FILESYSTEMS (VFS and infrastructure))" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <202401281917.WeFbZE56-lkp@intel.com>
References: <20240125225704.12781-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125225704.12781-4-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/eventpoll-support-busy-poll-per-epoll-instance/20240126-070250
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240125225704.12781-4-jdamato%40fastly.com
patch subject: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for epoll_params
config: i386-buildonly-randconfig-002-20240127 (https://download.01.org/0day-ci/archive/20240128/202401281917.WeFbZE56-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281917.WeFbZE56-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281917.WeFbZE56-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/eventpoll.h:89:9: error: unknown type name 'u64'
      89 |         u64 busy_poll_usecs;
         |         ^~~
>> ./usr/include/linux/eventpoll.h:90:9: error: unknown type name 'u16'
      90 |         u16 busy_poll_budget;
         |         ^~~
>> ./usr/include/linux/eventpoll.h:93:9: error: unknown type name 'u8'
      93 |         u8 data[118];
         |         ^~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

