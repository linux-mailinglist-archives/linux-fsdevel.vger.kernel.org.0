Return-Path: <linux-fsdevel+bounces-52751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EABFAE6361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 13:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3FC40073B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48E288CBE;
	Tue, 24 Jun 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+T6U1qF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7D28688D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763532; cv=none; b=ce2jvX/9jcTq7rsSq7hP49H7KI82Lxo+YIova+efCrORBpx6NgdQaNNn9Sn3WAKjsX9UxtSVfXUR/H1SZAJxWIzeUfnoCWH52xOKTAXytJcx6azT6qi0kKk9wNMkCS9D1Y3y1Or2bV1aGjqaGHvOLbV76cULdN9I72yIwfIAC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763532; c=relaxed/simple;
	bh=mmyaQwrNqJf24cVo78MhxpTUoWV9AeICcZr+wKwojr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6cXuejMDRVaVOUbqkdUbmIVbzKufsw8vKy6pGRTq/JPjPQkxQavxUu78x07FbcjwrGJG0CKPf1uugKdXkSYnAcyBMqwuKTrgs62I8srs96fKTfd/BJNVK+TTMyNtexnisEI5wuAt9/i0PwwwdEvZBWgcROhYskEiVJ58pIRsbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+T6U1qF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750763531; x=1782299531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mmyaQwrNqJf24cVo78MhxpTUoWV9AeICcZr+wKwojr0=;
  b=O+T6U1qFn/AfyBBI2aUPPVUH+/xx0+PbJgDcf2jhvUkfL5tchslDSinf
   Tcl/QB4MZNrOXdrmmXMxMVdrcG/TUbTL429EuPfbQQeVDC2eqcJsyTMLE
   B55y6scx8cHKOK46EMAFfkMkHNY+d5GjXywo9hR43z8CUn1qzhVwh3hvg
   qktrl4F7rxp+sQFpBovxzSY2qMgB5JJsDjNU4pRuUvSsScA19JFvpisii
   ucizYdMTM2cVyX7NMDIJnv4SLxEPuG+QPYUakDpPa7QUyma64e2b89wo3
   bstdq2w5qR+3jq5zL+joneNcS3zzmUNvQNprJRzuVNb3yiRsnNJN5IVLX
   w==;
X-CSE-ConnectionGUID: M0qMtONrQPCpiP5yVUfJLQ==
X-CSE-MsgGUID: AfjVurwsQOKEaFBfZ7GNbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52228360"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52228360"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:12:10 -0700
X-CSE-ConnectionGUID: NqGelhMZR6G/Wl6CyymbcA==
X-CSE-MsgGUID: S3jN+/V3QtCLTGpj1W/uZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="155914102"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jun 2025 04:12:08 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uU1ZN-000S3C-2y;
	Tue, 24 Jun 2025 11:12:05 +0000
Date: Tue, 24 Jun 2025 19:11:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, jack@suse.cz, amir73il@gmail.com,
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org,
	sargun@meta.com
Subject: Re: [PATCH] fanotify: support custom default close response
Message-ID: <202506241819.lF9Wd4Tn-lkp@intel.com>
References: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623192503.2673076-1-ibrahimjirdeh@meta.com>

Hi Ibrahim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc3 next-20250623]
[cannot apply to jack-fs/fsnotify]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ibrahim-Jirdeh/fanotify-support-custom-default-close-response/20250624-032902
base:   linus/master
patch link:    https://lore.kernel.org/r/20250623192503.2673076-1-ibrahimjirdeh%40meta.com
patch subject: [PATCH] fanotify: support custom default close response
config: arm-randconfig-002-20250624 (https://download.01.org/0day-ci/archive/20250624/202506241819.lF9Wd4Tn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506241819.lF9Wd4Tn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506241819.lF9Wd4Tn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/notify/fanotify/fanotify_user.c: In function 'finish_permission_event.constprop':
>> fs/notify/fanotify/fanotify_user.c:316:3: warning: argument 2 null where non-null expected [-Wnonnull]
      memcpy(&event->audit_rule, friar, sizeof(*friar));
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:65,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/sysctl.h:26,
                    from include/linux/fanotify.h:5,
                    from fs/notify/fanotify/fanotify_user.c:2:
   arch/arm/include/asm/string.h:20:15: note: in a call to function 'memcpy' declared here
    extern void * memcpy(void *, const void *, __kernel_size_t);
                  ^~~~~~


vim +316 fs/notify/fanotify/fanotify_user.c

70529a199574c1 Richard Guy Briggs 2023-02-03  301  
40873284d7106f Jan Kara           2019-01-08  302  /*
40873284d7106f Jan Kara           2019-01-08  303   * Finish processing of permission event by setting it to ANSWERED state and
40873284d7106f Jan Kara           2019-01-08  304   * drop group->notification_lock.
40873284d7106f Jan Kara           2019-01-08  305   */
40873284d7106f Jan Kara           2019-01-08  306  static void finish_permission_event(struct fsnotify_group *group,
70529a199574c1 Richard Guy Briggs 2023-02-03  307  				    struct fanotify_perm_event *event, u32 response,
70529a199574c1 Richard Guy Briggs 2023-02-03  308  				    struct fanotify_response_info_audit_rule *friar)
40873284d7106f Jan Kara           2019-01-08  309  				    __releases(&group->notification_lock)
40873284d7106f Jan Kara           2019-01-08  310  {
fabf7f29b3e2ce Jan Kara           2019-01-08  311  	bool destroy = false;
fabf7f29b3e2ce Jan Kara           2019-01-08  312  
40873284d7106f Jan Kara           2019-01-08  313  	assert_spin_locked(&group->notification_lock);
70529a199574c1 Richard Guy Briggs 2023-02-03  314  	event->response = response & ~FAN_INFO;
70529a199574c1 Richard Guy Briggs 2023-02-03  315  	if (response & FAN_INFO)
70529a199574c1 Richard Guy Briggs 2023-02-03 @316  		memcpy(&event->audit_rule, friar, sizeof(*friar));
70529a199574c1 Richard Guy Briggs 2023-02-03  317  
fabf7f29b3e2ce Jan Kara           2019-01-08  318  	if (event->state == FAN_EVENT_CANCELED)
fabf7f29b3e2ce Jan Kara           2019-01-08  319  		destroy = true;
fabf7f29b3e2ce Jan Kara           2019-01-08  320  	else
40873284d7106f Jan Kara           2019-01-08  321  		event->state = FAN_EVENT_ANSWERED;
40873284d7106f Jan Kara           2019-01-08  322  	spin_unlock(&group->notification_lock);
fabf7f29b3e2ce Jan Kara           2019-01-08  323  	if (destroy)
fabf7f29b3e2ce Jan Kara           2019-01-08  324  		fsnotify_destroy_event(group, &event->fae.fse);
40873284d7106f Jan Kara           2019-01-08  325  }
40873284d7106f Jan Kara           2019-01-08  326  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

