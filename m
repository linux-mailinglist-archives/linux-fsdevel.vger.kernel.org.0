Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E2460272
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 01:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhK1AGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 19:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhK1AEC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 19:04:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D015C061746;
        Sat, 27 Nov 2021 16:00:47 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72B6760F14;
        Sun, 28 Nov 2021 00:00:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7694C60524;
        Sun, 28 Nov 2021 00:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638057645;
        bh=ACnKnpkJp86UAT/IzmO/5pupb8wbug1WfQxQApH4b0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PF1wUCGNXY1sMgZa0gBpVZ2HtoNHBG/0jfxX7MCJNWMvbwV80vZXKtT7TQObIgJJk
         wqYR9ictxr7uzDlLLsWrog2cWds5VFXhPKzILgOxM7n5WBUXLWujf5CTXIrrvDER8L
         jJllZL44TbYhvV1aKPrLAaJsk5PmYVBQiYk4LFUQ=
Date:   Sat, 27 Nov 2021 16:00:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-Id: <20211127160043.1512b4063f30b4d043b37420@linux-foundation.org>
In-Reply-To: <YaC7jij1hHtdOJdE@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
        <20211122153233.9924-3-mhocko@kernel.org>
        <YaC7jij1hHtdOJdE@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 26 Nov 2021 11:48:46 +0100 Michal Hocko <mhocko@suse.com> wrote:

> On Mon 22-11-21 16:32:31, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Dave Chinner has mentioned that some of the xfs code would benefit from
> > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > cannot fail and they do not fit into a single page.
> > 
> > The large part of the vmalloc implementation already complies with the
> > given gfp flags so there is no work for those to be done. The area
> > and page table allocations are an exception to that. Implement a retry
> > loop for those.
> > 
> > Add a short sleep before retrying. 1 jiffy is a completely random
> > timeout. Ideally the retry would wait for an explicit event - e.g.
> > a change to the vmalloc space change if the failure was caused by
> > the space fragmentation or depletion. But there are multiple different
> > reasons to retry and this could become much more complex. Keep the retry
> > simple for now and just sleep to prevent from hogging CPUs.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Are there still any concerns around this patch or the approach in
> general?

Well.  Like GFP_NOFAIL, every use is a sin.  But I don't think I've
ever seen a real-world report of anyone hitting GFP_NOFAIL's
theoretical issues.

I assume there will be a v3?
