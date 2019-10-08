Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABBCCFCA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfJHOm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:42:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46519 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfJHOm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:42:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so16956778qkd.13;
        Tue, 08 Oct 2019 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9uCi3q86YRVwLBVm7j5KxG7/x58NKYLZhxuiCgWigpA=;
        b=c8ojss2b871W/etAhaHqC1NA2LlonwjH7v3X7mlrwnxU0MVU6EEKNUaHZMmmh9aIKy
         ThGpKwDm0pVCMHTd6xCRKAM1Q3PLMSDL4D07qXkWY1u1ETQ0TqzgQ8BkScsJF7Us7BU3
         ndV500rc2ilVOM960Pfe/1Hu/S3ZfgrOn1GOVezKl1uWzOAd7sfwhsbRF4kJOxeHFcma
         US6tgXSuOyPxsoxaDWgR3XElj2lv0+6Y/fBJXPOk3VnN7GjF9oWp6ahA5JoVS6ZXIe79
         NGGIx7OhhIIMTpOQZsb/LCX+h6DJ9jzcdTzeefZ92PxfjlQFuRzhCvtlHsLOXoUN3r4v
         dKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9uCi3q86YRVwLBVm7j5KxG7/x58NKYLZhxuiCgWigpA=;
        b=Ws6oJJRRvDt8+52hSmrhD8Kq4SuHRCxWelRs0TRBuwEVJreg59MxdBGFl13OSJWa8h
         iJ2EQj8pa957OwR17/tGmUuiExKNtuH+MOJ98yWzzSuxGmLQxTl4DVDIXIUvFqA0aO+8
         /jV4q9fYuYb70mJWxluN6gY7GC1g8E1LLztVa7kQ9Cy1iElbv8ePbEzu6tNjlBJVpPJY
         Isit9z3j6AdxbtjlMhourTnCu4MPEvgaGyuV9+RNGOqQh2QBWqbDa5BTEEiBAu6Dztgn
         gQIlgNBJf7o8rLa5EFa921gD0hzha3BKVHV5aOTUBxXIypl8DZlzgc7LRtc+sjtO/t7w
         JsBQ==
X-Gm-Message-State: APjAAAVDCwRXXVurnGMta0qH2WqV//RRzIxxstV6v/L8OtVFGEZBEvrU
        gysDiL4Ff+qxYxTl06wTPJA=
X-Google-Smtp-Source: APXvYqyg7KFgyNWZE6kk7Zx0Qm/yQ93s3+7fo2JzbYVCY7vfdYkOQutHa701YhLc0jGvOvLL1dTF5A==
X-Received: by 2002:a37:a709:: with SMTP id q9mr28554605qke.135.1570545745258;
        Tue, 08 Oct 2019 07:42:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:3979])
        by smtp.gmail.com with ESMTPSA id v7sm8839874qte.29.2019.10.08.07.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 07:42:24 -0700 (PDT)
Date:   Tue, 8 Oct 2019 07:42:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Avoid getting stuck during cyclic writebacks
Message-ID: <20191008144221.GA18794@devbig004.ftw2.facebook.com>
References: <20191003142713.GA2622251@devbig004.ftw2.facebook.com>
 <20191008142322.GP2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008142322.GP2751@twin.jikos.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Tue, Oct 08, 2019 at 04:23:22PM +0200, David Sterba wrote:
> > 1. There is a single file which has accumulated enough dirty pages to
> >    trigger balance_dirty_pages() and the writer appending to the file
> >    with a series of short writes.
> > 
> > 2. bdp kicks in, wakes up background writeback and sleeps.
> 
> What does 'bdp' refer to?

Oh, Sorry about that.  balance_dirty_pages().

> > IOW, as long as it's not EOF and there's budget, the code never
> > retries writing back the same page.  Only when a page happens to be
> > the last page of a particular run, we end up retrying the page, which
> > can't possibly guarantee anything data integrity related.  Besides,
> > cyclic writes are only used for non-syncing writebacks meaning that
> > there's no data integrity implication to begin with.
> 
> The code was added in a91326679f2a0a4c239 ("Btrfs: make
> mapping->writeback_index point to the last written page") after a user
> report in https://www.spinics.net/lists/linux-btrfs/msg52628.html , slow
> appends that caused fragmentation

Ah, okay, that makes sense.  That prolly warrants some comments.

> What you describe as the cause is similar, but you're partially
> reverting the fix that was supposed to fix it. As there's more code
> added by the original patch, the revert won't probably bring back the
> bug.
> 
> The whole function and states are hard to follow, I agree with your
> reasoning about the check being bogus and overall I'd rather see fewer
> special cases in the function.
> 
> Also the removed comment mentions media errors but this was not the
> problem for the original report and is not a common scenario either. So
> as long as the fallback in such case is sane (ie. set done = 1 and
> exit), I don't see futher problems.
> 
> > Fix it by always setting done_index past the current page being
> > processed.
> > 
> > Note that this problem exists in other writepages too.
> 
> I can see that write_cache_pages does the same done_index updates.  So
> it makes sense that the page walking and writeback index tracking
> behaviour is consistent, unless extent_write_cache_pages has diverged
> too much.
> 
> I'll add the patch to misc-next. Thanks.

So, in case trying to write the last page is still needed, the thing
necessary to fix this deadlock is avoiding repeating on the last page
too many times / indefinitely as that's what ends up blocking forward
progress - almost all of dirty data is behind the cyclic cursor and
the cursor can't wrap back to get to them.

Thanks.

-- 
tejun
