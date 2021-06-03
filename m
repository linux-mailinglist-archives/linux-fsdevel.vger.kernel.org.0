Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E8539A582
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFCQP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 12:15:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:45479 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCQP0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:15:26 -0400
IronPort-SDR: FfdJkhhXZmAT9YRvN9EwJkg0zms8wSx0vhU9bYatiMPBQBZ/b9Zrl1W0PQ8/DYMBX0PHkrYZqj
 p+OfcKNqphxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="267941303"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="267941303"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 09:09:11 -0700
IronPort-SDR: dufkAAo4d/PWJ4wnRLvUbrImK7qsrPSdWH7tO8rcc6MB0N/oqz73Ol9DckJLHf3EMwgK/u9x1B
 5dFui4o2xg/Q==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="480277494"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 09:09:09 -0700
Date:   Thu, 3 Jun 2021 09:09:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@huawei.com
Subject: Re: [PATCH v3] libfs: fix error cast of negative value in
 simple_attr_write()
Message-ID: <20210603160904.GA983893@agluck-desk2.amr.corp.intel.com>
References: <1605341356-11872-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605341356-11872-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 14, 2020 at 04:09:16PM +0800, Yicong Yang wrote:
> The attr->set() receive a value of u64, but simple_strtoll() is used
> for doing the conversion. It will lead to the error cast if user inputs
> a negative value.
> 
> Use kstrtoull() instead of simple_strtoll() to convert a string got
> from the user to an unsigned value. The former will return '-EINVAL' if
> it gets a negetive value, but the latter can't handle the situation
> correctly. Make 'val' unsigned long long as what kstrtoull() takes, this
> will eliminate the compile warning on no 64-bit architectures.
> 
> Fixes: f7b88631a897 ("fs/libfs.c: fix simple_attr_write() on 32bit machines")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v1:
> - address the compile warning for non-64 bit platform.
> Change since v2:
> Link: https://lore.kernel.org/linux-fsdevel/1605000324-7428-1-git-send-email-yangyicong@hisilicon.com/
> - make 'val' unsigned long long and mentioned in the commit
> Link: https://lore.kernel.org/linux-fsdevel/1605261369-551-1-git-send-email-yangyicong@hisilicon.com/

Belated error report on this. Some validation team just moved to
v5.10 and found their error injection scripts no longer work.

They have been using:

# echo $((-1 << 12)) > /sys/kernel/debug/apei/einj/param2

to write the mask value 0xfffffffffffff000 for many years ... but
now writing a negative value (-4096) to this file gives an EINVAL error.

Maybe they've been taking advantage of a bug all this time? The
comment for debugfs_create_x64() says it is for reading/writing
an unsigned value. But when a bug fix breaks user code ... then
we are supposed to ask whether that bug is actually a feature.

If there was a debugfs_create_s64() I might just fix einj.c to
use that ... but there isn't :-(

-Tony
