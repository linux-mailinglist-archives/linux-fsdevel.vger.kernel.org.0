Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4EE299935
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391350AbgJZV7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 17:59:31 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55205 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391338AbgJZV7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:59:31 -0400
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9674B58BF63;
        Tue, 27 Oct 2020 08:59:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kXAWR-004fZW-3k; Tue, 27 Oct 2020 08:59:23 +1100
Date:   Tue, 27 Oct 2020 08:59:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        peterz@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/dcache: optimize start_dir_add()
Message-ID: <20201026215923.GA306023@dread.disaster.area>
References: <20201022211650.25045-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022211650.25045-1-dave@stgolabs.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=7-415B0cAAAA:8
        a=jnOd6L2yOPG0MfuFbw4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 02:16:50PM -0700, Davidlohr Bueso wrote:
> Considering both end_dir_add() and d_alloc_parallel(), the
> dir->i_dir_seq wants acquire/release semantics, therefore
> micro-optimize for ll/sc archs and use finer grained barriers
> to provide (load)-ACQUIRE ordering (L->S + L->L). This comes
> at no additional cost for most of x86, as sane tso models will
> have a nop for smp_rmb/smp_acquire__after_ctrl_dep.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> Alternatively I guess we could just use cmpxchg_acquire().

Please us cmpxchg_acquire() so that people who have no clue what the
hell smp_acquire__after_ctrl_dep() means or does have some hope of
understanding of what objects the ordering semantics in the function
actually apply to....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
