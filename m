Return-Path: <linux-fsdevel+bounces-51994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51CDADE049
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 03:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF61179EFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 01:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D55170A11;
	Wed, 18 Jun 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncrglit1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB897F9C1;
	Wed, 18 Jun 2025 01:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750208564; cv=none; b=BwYAyFz6DJ1yXiMhOaDHlfpVGxBGiZd/MaVfZzm7t+4hdl8EFsquWpZE6AmQ4tQ2l7vmP+WINbQrSAtSY3vNcHNALPQRJF0QahGPjWkdiE+GzYZoo7GMl1VlYIJKORb6d+vZjdVTTGvnT4je6azpiN5HSRMeVnxcuueQdfDK1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750208564; c=relaxed/simple;
	bh=PWnnedWVfPY2tdFcAXHhWCXMbyXV6iE2eboLu0vmnrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9gkEdxCrG3JJm7MsL+NsVb95Pmw7H7jLJurPLYzVTVCM9irIoCoP9GsU5A+T4WtZXdSleeZV9xtvsZoi1Pq/kRsh1k54uJkZxmy9tiMstIGWBxqWiaOYnJwkw/rBgPyDD4cRWs7f1spyRqkTqjlD51WPm3dgjzbIfoQ+Mf+Qdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncrglit1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750208563; x=1781744563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PWnnedWVfPY2tdFcAXHhWCXMbyXV6iE2eboLu0vmnrA=;
  b=ncrglit1M0cJ+EyR6zkB2N2ldq31bxhdNIoXKCSorBpNXJUKOcs321c9
   b8u4V4MaRqTbTOIQ3Qg3DnXJQ+SvoB3hthJZ2gyZo9GqlbCwYJjrOUa7T
   pm/5i18/sHQwigxAvr/Mag0pX10EtfAAockGsswdn7opo/YeNoEYV/LE1
   GWFENDCzA/n7itJL/NMg6lqMw0dx3l6VNBj0zhCvOgdfr2eJaWM7KdQGF
   LpH29Sfngaa+EVTcM6QDmvKuWRnRS8Od3YrGkelEzZU7z+BLJUkJF5qvz
   VMdh+b+YAoHor8k3bXbGCpcFVNcXlDzUV+Lg6YTiZ4ZrkhzYYgyeQx5GY
   w==;
X-CSE-ConnectionGUID: 71CzB1joTyydmeZmXG5pcQ==
X-CSE-MsgGUID: B/FJNYOIQ3G6o8AfecYydg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52278352"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52278352"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 18:02:42 -0700
X-CSE-ConnectionGUID: Zna6SpJ6Rn60loJKW+5dHQ==
X-CSE-MsgGUID: zHzHN8bpSBeRBzY74FOBaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="149588616"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Jun 2025 18:02:37 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRhCE-000JGU-3C;
	Wed, 18 Jun 2025 01:02:34 +0000
Date: Wed, 18 Jun 2025 09:02:07 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@meta.com, andrii@kernel.org,
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
	m@maowtm.org, neil@brown.name, Song Liu <song@kernel.org>
Subject: Re: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Message-ID: <202506180814.GoByWn1r-lkp@intel.com>
References: <20250617061116.3681325-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617061116.3681325-2-song@kernel.org>

Hi Song,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/namei-Introduce-new-helper-function-path_walk_parent/20250617-141322
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250617061116.3681325-2-song%40kernel.org
patch subject: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
config: loongarch-randconfig-r072-20250618 (https://download.01.org/0day-ci/archive/20250618/202506180814.GoByWn1r-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250618/202506180814.GoByWn1r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506180814.GoByWn1r-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/namei.c:2072 function parameter 'path' not described in '__path_walk_parent'
>> Warning: fs/namei.c:2072 function parameter 'root' not described in '__path_walk_parent'
>> Warning: fs/namei.c:2072 function parameter 'flags' not described in '__path_walk_parent'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

