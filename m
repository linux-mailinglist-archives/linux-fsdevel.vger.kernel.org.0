Return-Path: <linux-fsdevel+bounces-62674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94EB9C602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A40B322CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2F29993A;
	Wed, 24 Sep 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoA/irUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47349659;
	Wed, 24 Sep 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753625; cv=none; b=b69rJJDtJOKB8GN/6OuiPB7VFtkJlqihgqtxvZCX0sxeZsTOf9gzTEQn0mv9nnZdNFJ7lPzdMItrVlS53KTrzDMD/2CVwtdYeoHyk8DKVnJ3bYW/1r716kK4Ui9Gybg7Q87IKKZz57oq/P7cKtVywFv/SvikzYFJcRdO94EiHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753625; c=relaxed/simple;
	bh=MCOjST1alWRkGHrYvRBtFCnBMnj9EfPpsorNR89KwlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6Y8PhUlefGyrxCjcp3we1wExYQeAEOkKqT82uD+yshpplZndi2otdKKT8Sb5cv+G16qLF5rlL+RABGxwsu2nM0MCw69VoABemSCiCN1C6w5NUM++CjAYaMjiuGUQB17Nb2rEEUcN6JXmphFd7DpLwGZdsB3EEnVrAgdDY1RNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoA/irUF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758753623; x=1790289623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCOjST1alWRkGHrYvRBtFCnBMnj9EfPpsorNR89KwlU=;
  b=IoA/irUFGpHGDa4Iu+okgKB/JHKIZKodkAb1AGLr04gUSaEZC8BKcSvW
   SWGjVFGV73tI/PgqqwoCw4H8JtWY1z/653nZPc6RrfQL9BdS+hctFikPt
   su9GpK4RJoc8OZMZo7aYghb24yBfQ+LywkBjLeDPOQWMzNm6Df2mM+2Sv
   v3B1ly4J2U6fye9NqCuB+8ptiB9OEK1ifWpCXz2O7l0Mgc3IfwCdGGhWe
   XAHyZKfQ1+1CAXi18kDohtBVVGnLccqVbCezTDmifI6Hf0hDrm3vPndjr
   ejfT207FU7QREXn5R8qA6gBG1DQJoAqPvWUiUY3wwjI691Z6P7+MPg5gQ
   g==;
X-CSE-ConnectionGUID: 8IyTfyC4TOORaI3Q4AXxEA==
X-CSE-MsgGUID: c/DT7pAnQeqZFMuRjyoQcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="86508952"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="86508952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:40:22 -0700
X-CSE-ConnectionGUID: uMoFIsJsRFSMqGPiVcCSVw==
X-CSE-MsgGUID: 4rEv7CMNRC6bgC1DTPytTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="181163296"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 24 Sep 2025 15:40:18 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1Y9m-0004cb-2Z;
	Wed, 24 Sep 2025 22:40:14 +0000
Date: Thu, 25 Sep 2025 06:39:19 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
	netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/3] nstree: make struct ns_tree private
Message-ID: <202509250641.QU55kXeK-lkp@intel.com>
References: <20250924-work-namespaces-fixes-v1-1-8fb682c8678e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-work-namespaces-fixes-v1-1-8fb682c8678e@kernel.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d969328c513c6679b4be11a995ffd4d184c25b34]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/nstree-make-struct-ns_tree-private/20250924-193826
base:   d969328c513c6679b4be11a995ffd4d184c25b34
patch link:    https://lore.kernel.org/r/20250924-work-namespaces-fixes-v1-1-8fb682c8678e%40kernel.org
patch subject: [PATCH 1/3] nstree: make struct ns_tree private
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20250925/202509250641.QU55kXeK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509250641.QU55kXeK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509250641.QU55kXeK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/nstree.c:17 struct member 'type' not described in 'ns_tree'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

