Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F61C31D5EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 08:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBQHzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 02:55:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:46792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhBQHzo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:55:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613548497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gV9fZi9ZMQ+85uUDSdhfOUqQJXrOLRcNGETfioChCIo=;
        b=fGyy949Ey1/r5PfLdWvT48bbwagETLGHHIof00DMOaYAhUEMwJv1QqqV1rvjgU4ZUZmblV
        UgA2dJVd1ZoiOnSYhb2q8XXUqeLsTbZTlq6cVMc8q+PIzFdT48yr8sZQwcLx459lfWBV7f
        31IbdgWOdajHXR4L8jJmQrKUZfz3OEc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9544AF45;
        Wed, 17 Feb 2021 07:54:56 +0000 (UTC)
Date:   Wed, 17 Feb 2021 08:54:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        felipe.franciosi@nutanix.com
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Message-ID: <YCzLz0QmwYLfqvu0@dhcp22.suse.cz>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
 <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
 <b821f4de-3260-f6e2-469f-65ccfa699bb7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b821f4de-3260-f6e2-469f-65ccfa699bb7@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 13:53:12, David Rientjes wrote:
> On Tue, 16 Feb 2021, Michal Hocko wrote:
[...]
> > Overall, I am not really happy about this feature even when above is
> > fixed, but let's hear more the actual problem first.
> 
> Shouldn't this behavior be possible as an oomd plugin instead, perhaps 
> triggered by psi?  I'm not sure if oomd is intended only to kill something 
> (oomkilld? lol) or if it can be made to do sysadmin level behavior, such 
> as shrinking the hugetlb pool, to solve the oom condition.

It should be under control of an admin who knows what the pool is
preallocated for and whether a decrease (e.g. a temporal one) is
tolerable.
 
> If so, it seems like we want to do this at the absolute last minute.  In 
> other words, reclaim has failed to free memory by other means so we would 
> like to shrink the hugetlb pool.  (It's the reason why it's implemented as 
> a predecessor to oom as opposed to part of reclaim in general.)
> 
> Do we have the ability to suppress the oom killer until oomd has a chance 
> to react in this scenario?

We don't and I do not think we want to bind the kernel oom behavior to
any userspace process. We have extensively discussed things like this in
the past IIRC.

-- 
Michal Hocko
SUSE Labs
