Return-Path: <linux-fsdevel+bounces-917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4486F7D3640
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB19A28154C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 12:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16E18E09;
	Mon, 23 Oct 2023 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njPX+HNj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D57480
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 12:19:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BF6FD;
	Mon, 23 Oct 2023 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698063549; x=1729599549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ErrJCE1bf5l80mKArl/0+fuj5JQv5yol0gyX7rJ0rbs=;
  b=njPX+HNjrHVS7JnpEDqmrOnQsf50ASC1LwT87DDmocuqTmKv+qVy9Edc
   9VkZt/DR0pLPci7zMbEdIbLWxq1GgeaLvb+P2C4OqkIbl3A3LHbFj9iSI
   RU2cr1Xs/0ho8ESeI9zEYaCrAPdUOwKcXARfiLNdStTX8Lr/zD9ZUzEHu
   x3yllgIIR3t3z1WH1/cI6rbEEGEnnco36IB8KKPdz7sNhfCzV0Zl4a31k
   xYlX4wny9Zmn1hWcvPctS55g0yj2dc+QWwcfVmf9tSVWSuR/ETXvgFLku
   v+ZIuvcgI6Vt1YTGGlXcVpX5l+amsTVBsFDmXSmalWeWvgdwBKiXFRIyq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5451034"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5451034"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793118206"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="793118206"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:19:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1quttd-00000007w2X-3I8b;
	Mon, 23 Oct 2023 15:19:01 +0300
Date: Mon, 23 Oct 2023 15:19:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, yangerkun <yangerkun@huawei.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTZktSo8oIUD5unq@smile.fi.intel.com>
References: <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com>
 <826dbab6-f6e0-fc02-e5d3-141c00a2a141@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <826dbab6-f6e0-fc02-e5d3-141c00a2a141@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 21, 2023 at 09:48:38AM +0800, Baokun Li wrote:
> On 2023/10/20 23:06, Andy Shevchenko wrote:
> > On Fri, Oct 20, 2023 at 05:51:59PM +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 19, 2023 at 11:43:47AM -0700, Linus Torvalds wrote:

...

> > > I even rebuilt again with just rebased on top of e64db1c50eb5 and it doesn't
> > > boot, so we found the culprit that triggers this issue.
> 
> This patch does not seem to cause this problem. Just like linus said, this
> patch
> has only two slight differences from the previous:
> 1) Change "if (err)" to "if (err < 0)"
>     In all the implementations of dq_op->write_dquot(), the returned value
> of err
>     is not greater than 0. Therefore, this does not cause behavior
> inconsistency.
> 2) Adding quota_error()
>     quota_error() does not seem to cause a boot failure.
> 
> Also, you mentioned that the root file system is initramfs. If no other file
> system
> that supports quota is automatically mounted during startup, it seems that
> quota
> does not cause this problem logically.
> 
> In my opinion, as Josh mentioned, replace the CONFIG_DEBUG_LIST related
> BUG()/BUG_ON() with WARN_ON(), and then check whether the system can be
> started normally. If yes, it indicates that the panic is caused by the list
> corruption, then, check for the items that may damage the list. If WARN_ON()
> is recorded in the dmesg log of the machine after the startup, it is easier
> to locate the problem.

I mentioned that I have checked that, but okay, lemme double check it.
I took the test-mrfld-jr branch and applied that patch on top.
And as expected no luck.

fstab I have, btw is this

$ cat output/target/etc/fstab
# <file system> <mount pt>      <type>  <options>       <dump>  <pass>
/dev/root       /               ext2    rw,noauto       0       1
proc            /proc           proc    defaults        0       0
devpts          /dev/pts        devpts  defaults,gid=5,mode=620,ptmxmode=0666   0       0
tmpfs           /dev/shm        tmpfs   mode=0777       0       0
tmpfs           /tmp            tmpfs   mode=1777       0       0
tmpfs           /run            tmpfs   mode=0755,nosuid,nodev  0       0
sysfs           /sys            sysfs   defaults        0       0

Not sure if /dev/root affects this all, it's Buildroot + Busybox in initramfs
at the end.

On the booted machine
(clang build of my main branch, based on the latest -rcX):

Welcome to Buildroot
buildroot login: root

# uname -a
Linux buildroot 6.6.0-rc7-00142-g9266a02ba229 #28 SMP PREEMPT_DYNAMIC Mon Oct 23 15:00:17 EEST 2023 x86_64 GNU/Linux

# mount
rootfs on / type rootfs (rw,size=453412k,nr_inodes=113353)
devtmpfs on /dev type devtmpfs (rw,relatime,size=453412k,nr_inodes=113353,mode=755)
proc on /proc type proc (rw,relatime)
devpts on /dev/pts type devpts (rw,relatime,gid=5,mode=620,ptmxmode=666)
tmpfs on /dev/shm type tmpfs (rw,relatime,mode=777)
tmpfs on /tmp type tmpfs (rw,relatime)
tmpfs on /run type tmpfs (rw,nosuid,nodev,relatime,mode=755)
sysfs on /sys type sysfs (rw,relatime)

What is fishy here is the size of rootfs, it's only 30M compressed side,
I can't be ~450M decompressed. I just noticed this, dunno if it's related.

-- 
With Best Regards,
Andy Shevchenko



