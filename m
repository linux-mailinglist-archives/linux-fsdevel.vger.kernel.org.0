Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE931D9A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 13:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhBQMlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 07:41:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:39216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232090AbhBQMl3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:41:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613565642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFaD6cMmUflfe3zZL8l/1NnW+074aRMBx7mpt03K63o=;
        b=T3NWYvman7n71RhYgVvyPrPRDNUhUpUESPEg1c+s/N1CuBVc0QBEPJW6rIvcSjTwOhyXpy
        2VYCtSP/dZG7z5I2jh4WrO+TJ1rMZMu1jvL/jpMXu5XDO7F/zKwaNNaRDv3ee++RcExMS/
        /4Q7qPxK6uEgQ7X9LGLMF8fTy9ce8F8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2025AF26;
        Wed, 17 Feb 2021 12:40:42 +0000 (UTC)
Date:   Wed, 17 Feb 2021 13:40:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Message-ID: <YC0OjfaiFzRUJOx4@dhcp22.suse.cz>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
 <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
 <bb3508e7-48d1-fa1b-f1a0-7f42be55ed9c@oracle.com>
 <YCzMVa5QSyUtlmnI@dhcp22.suse.cz>
 <D66DC6A7-C708-4888-8FCF-E4EB0F90ED48@nutanix.com>
 <YC0MiqwCGp90Oj4N@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC0MiqwCGp90Oj4N@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-02-21 13:31:07, Michal Hocko wrote:
[...]
> Thanks for your usecase description. It helped me to understand what you
> are doing and how this can be really useful for your particular setup.
> This is really a very specific situation from my POV. I am not yet sure
> this is generic enough to warrant for a yet another tunable. One thing
> you can do [1] is to
> hook into oom notifiers interface (register_oom_notifier) and release
> pages from the callback.

Forgot to mention that this would be done from a kernel module.

> Why is that batter than a global tunable?
> For one thing you can make the implementation tailored to your specific
> usecase. As the review feedback has shown this would be more tricky to
> be done in a general case. Unlike a generic solution it would allow you
> to coordinate with your userspace if you need. Would something like that
> work for you?
> 
> ---
> [1] and I have to say I hate myself for suggesting that because I was
> really hoping this interface would go away. But the reality disagrees so
> I gave up on that goal...
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
