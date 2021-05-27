Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4993923DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 02:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhE0Al2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 20:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234134AbhE0Al1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 20:41:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 342E5613AC;
        Thu, 27 May 2021 00:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622075994;
        bh=4KHaoj275K4DXjF4ZE9cKWuSigdgD7f0eMe9Z/iWUm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ym5GjGnHe4QXS89UGx7DJP/leAh/SYefgb8qGLcutUX8s8tACCzifxQ3lY6KJ/SuS
         30fYcCRJYwPTUtwFyhiPNEg6+vkTosIe2cjcI2Cj24WxfoXOhnjHFDjnRMKNIENmMG
         DkCIawj9+jydf2055yLvw++MBI8O1S1ga0/I5G5A=
Date:   Wed, 26 May 2021 17:39:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng zhou <zhoufeng.zf@bytedance.com>
Cc:     adobriyan@gmail.com, rppt@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, chenying.kernel@bytedance.com,
        zhengqi.arch@bytedance.com
Subject: Re: [PATCH] fs/proc/kcore.c: add mmap interface
Message-Id: <20210526173953.49fb3dc48c0f2a8b3c31fe2b@linux-foundation.org>
In-Reply-To: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
References: <20210526075142.9740-1-zhoufeng.zf@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 May 2021 15:51:42 +0800 Feng zhou <zhoufeng.zf@bytedance.com> wrote:

> From: ZHOUFENG <zhoufeng.zf@bytedance.com>
> 
> When we do the kernel monitor, use the DRGN
> (https://github.com/osandov/drgn) access to kernel data structures,
> found that the system calls a lot. DRGN is implemented by reading
> /proc/kcore. After looking at the kcore code, it is found that kcore
> does not implement mmap, resulting in frequent context switching
> triggered by read. Therefore, we want to add mmap interface to optimize
> performance. Since vmalloc and module areas will change with allocation
> and release, consistency cannot be guaranteed, so mmap interface only
> maps KCORE_TEXT and KCORE_RAM.
> 
> The test results:
> 1. the default version of kcore
> real 11.00
> user 8.53
> sys 3.59
> 
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
> 99.64  128.578319          12  11168701           pread64
> ...
> ------ ----------- ----------- --------- --------- ----------------
> 100.00  129.042853              11193748       966 total
> 
> 2. added kcore for the mmap interface
> real 6.44
> user 7.32
> sys 0.24
> 
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
> 32.94    0.130120          24      5317       315 futex
> 11.66    0.046077          21      2231         1 lstat
>  9.23    0.036449         177       206           mmap
> ...
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    0.395077                 25435       971 total
> 
> The test results show that the number of system calls and time
> consumption are significantly reduced.
> 

hm, OK, I guess why not.  The performance improvements for DRGN (which
appears to be useful) are nice and the code is simple.

I'm surprised that it makes this much difference.  Has DRGN been fully
optimised to minimise the amount of pread()ing which it does?  Why does
it do so much reading?

Thanks, I shall await input from others before moving ahead with this.
