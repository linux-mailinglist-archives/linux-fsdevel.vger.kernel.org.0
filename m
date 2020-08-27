Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7426A2546CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgH0O3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgH0O3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:29:08 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C144C061264;
        Thu, 27 Aug 2020 07:28:54 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBItU-005aDQ-Dk; Thu, 27 Aug 2020 14:28:48 +0000
Date:   Thu, 27 Aug 2020 15:28:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuqi Jin <jinyuqi@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [NAK] Re: [PATCH] fs: Optimized fget to improve performance
Message-ID: <20200827142848.GZ1236603@ZenIV.linux.org.uk>
References: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 06:19:44PM +0800, Shaokun Zhang wrote:
> From: Yuqi Jin <jinyuqi@huawei.com>
> 
> It is well known that the performance of atomic_add is better than that of
> atomic_cmpxchg.
> The initial value of @f_count is 1. While @f_count is increased by 1 in
> __fget_files, it will go through three phases: > 0, < 0, and = 0. When the
> fixed value 0 is used as the condition for terminating the increase of 1,
> only atomic_cmpxchg can be used. When we use < 0 as the condition for
> stopping plus 1, we can use atomic_add to obtain better performance.

Suppose another thread has just removed it from the descriptor table.

> +static inline bool get_file_unless_negative(atomic_long_t *v, long a)
> +{
> +	long c = atomic_long_read(v);
> +
> +	if (c <= 0)
> +		return 0;

Still 1.  Now the other thread has gotten to dropping the last reference,
decremented counter to zero and committed to freeing the struct file.

> +
> +	return atomic_long_add_return(a, v) - 1;

... and you increment that sucker back to 1.  Sure, you return 0, so the
caller does nothing to that struct file.  Which includes undoing the
changes to its refecount.

In the meanwhile, the third thread does fget on the same descriptor,
and there we end up bumping the refcount to 2 and succeeding.  Which
leaves the caller with reference to already doomed struct file...

	IOW, NAK - this is completely broken.  The whole point of
atomic_long_add_unless() is that the check and conditional increment
are atomic.  Together.  That's what your optimization takes out.
