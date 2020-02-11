Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674CF1599C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 20:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbgBKTbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 14:31:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33066 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbgBKTbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:31:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id h4so11364359qkm.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 11:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SE2lIQx3P5mwY3EQaRSCUgCct2sPIMvI9iCNgtybvd8=;
        b=ReYqpjfPtN0mGGjim5Vxe1D7me7yyrMd6UiO9aJzmfLByAaHdNIpNtjB7n9qUXmSFK
         ugbHGIs7g+cxoaYJKyWMPXVoHRIpfbOJc6bSrffd7tbAPYExseRBxWT8fqYhJRuyEDR/
         EnaUw8YK9RIQtJs8emRfcYw1FZSNtripVX5NARu5L+oeYeanwYE1TuLzfAkLz06lmhey
         KYplkiBKiR91Vn6oMybNQNj3JC2O/Zv5Zm0qsP9fsU+yYoTa+wpQkt5GMLaWHWpd/iAY
         BeCMdehRlvjIbQYeFvnPpTl0bz7+9JMPd5RbW/52X+D2jSSvxfEIWumljFERaAeX8gRX
         LyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SE2lIQx3P5mwY3EQaRSCUgCct2sPIMvI9iCNgtybvd8=;
        b=V8MyXJkgiYo1/FTFIyaQSjFQt6xemFzfJdrDOX2jOBPPOn9fCgTbUYntCRZxI2M75X
         nFdqc2lIDzvdypsYuHWlBPLz1FgRdpluBEQ814xUa13xMZiNZBwglH/2QUfiQjgNMq/6
         5eJePLmojLMzQJb3SQfDmJhc1jXx1eH35yLJkG54VM+9mLzdOq8MTeIFcldGXEWNLRy5
         2kSrLrNIHzSv8StvLKrx7nf7wZ4KkzkGeMT72STxl0sSwUv2T32mR1NKOypLHK/05vJu
         xBN3KFIylNVRA4FyhXLJNfD/SUwX8+EHJFRq03Bat4LN+hyhNdd6bkfX8vOY4ylQlYH8
         /+TQ==
X-Gm-Message-State: APjAAAXl1EY6Hr89yZc4dXIUP6tl3Xq/Y9Bk0kX2sARpGiISXg1TiyT0
        HTg8HI8YQpNCYuapqs7ciwARgWHviCo=
X-Google-Smtp-Source: APXvYqwcqY2c2mfW1BVMHT24Xz0JXGOIxC0CzaJ9T0HaNd3CVrTU9BYlUHiRtqnXvP3T7MhdUQBaOg==
X-Received: by 2002:a05:620a:1010:: with SMTP id z16mr4305510qkj.237.1581449462363;
        Tue, 11 Feb 2020 11:31:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:3189])
        by smtp.gmail.com with ESMTPSA id z21sm2537612qka.122.2020.02.11.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 11:31:01 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:31:01 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200211193101.GA178975@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:05:38PM -0500, Rik van Riel wrote:
> On Tue, 2020-02-11 at 12:55 -0500, Johannes Weiner wrote:
> > The VFS inode shrinker is currently allowed to reclaim inodes with
> > populated page cache. As a result it can drop gigabytes of hot and
> > active page cache on the floor without consulting the VM (recorded as
> > "inodesteal" events in /proc/vmstat).
> > 
> > This causes real problems in practice. Consider for example how the
> > VM
> > would cache a source tree, such as the Linux git tree. As large parts
> > of the checked out files and the object database are accessed
> > repeatedly, the page cache holding this data gets moved to the active
> > list, where it's fully (and indefinitely) insulated from one-off
> > cache
> > moving through the inactive list.
> 
> > This behavior of invalidating page cache from the inode shrinker goes
> > back to even before the git import of the kernel tree. It may have
> > been less noticeable when the VM itself didn't have real workingset
> > protection, and floods of one-off cache would push out any active
> > cache over time anyway. But the VM has come a long way since then and
> > the inode shrinker is now actively subverting its caching strategy.
> 
> Two things come to mind when looking at this:
> - highmem
> - NUMA
> 
> IIRC one of the reasons reclaim is done in this way is
> because a page cache page in one area of memory (highmem,
> or a NUMA node) can end up pinning inode slab memory in
> another memory area (normal zone, other NUMA node).

That's a good point, highmem does ring a bell now that you mention it.

If we still care, I think this could be solved by doing something
similar to what we do with buffer_heads_over_limit: allow a lowmem
allocation to reclaim page cache inside the highmem zone if the bhs
(or inodes in this case) have accumulated excessively.

AFAICS, we haven't done anything similar for NUMA, so it might not be
much of a problem there. I could imagine this is in part because NUMA
nodes tend to be more balanced in size, and the ratio between cache
memory and inode/bh memory means that these objects won't turn into a
significant externality. Whereas with extreme highmem:lowmem ratios,
they can.
