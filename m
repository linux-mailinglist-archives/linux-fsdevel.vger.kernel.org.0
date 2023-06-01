Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1187571F65E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 01:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjFAXGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 19:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjFAXGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:06:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF20197
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 16:06:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b04782fe07so8561865ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685660766; x=1688252766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RkGG0H7mjY3a+9QsLOolV5JIX0+0TtB9RXUw2XTjJg=;
        b=cwmqt0Q4DfwCMZq9zejM8lH6nVcDOZkqawU3r3zUHN7ix0+BjClFIA2IFCionbvtFN
         RQaE7LP4WTBW9uaCMupU9D8aE8PMHLgn5qk9/eSmcZ157SLZ76JHA0tV9vCIKCMSflAY
         fjWnUVkMsQp+3BpV4aJzM7UKvo/Fb+ihTjxro+0+1QlFzbv8Ms9QcRRgBr5mp82nlpwy
         Bn6fhLKR+1Caez6W7RHGxoYwyMRyxD7GKoHQQH7MzGNljPANT0HbEDyWIe9rzBp99Nqn
         RUjtnGjiWo6t8q0rJIQ50RWp2AaqtHs2f+dS9T1t6S+2q/bUMhUmg9s8g1O6uycgMx3M
         ZTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685660766; x=1688252766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RkGG0H7mjY3a+9QsLOolV5JIX0+0TtB9RXUw2XTjJg=;
        b=mIzkZzFvVF0DnYSH6J6X89wC01OzrdMgJXg0lHc3gAT48Bkpu1SOHCEQrMPZWo+UbW
         Y8YOe/rZl4nL6g/96qivCbCxPDYuypypXj1JWHIYdNEFFzhjczb56po3Gr7cUsFOXwDa
         if8mAoS0h3hFN0JBloDo1Ed6PrjiCU0xhWvxreWhn5Ix387V+rhn1Cr3GBxjxI5Hhgjy
         HIGV6MnAYVeZCypDfRitFuyfL+C0WlOGfidk8+Ku0OZ0kfYk6/4AAnkF8gFOXvLfsRt0
         ebqPkmmxjx96j9nDLGFPCJNnckimgVFUQXm3gIXeiHzf/thSAJT3N6DYHVeRB1zgl6vD
         zBUQ==
X-Gm-Message-State: AC+VfDwgbs+T7m2Di0bzh6wzYZjN6dbFzMIkeURCDZfuOQaqev/ybiyp
        u+MBicr9GC1FMjv4P46LHtQ0hg==
X-Google-Smtp-Source: ACHHUZ46oEBAmDM8AMw+nRtb7ooMsOtJ7vtkx6vl+zBvCBDmYdzFjqdUhiNmLHNa7XPQrt1IElMQzg==
X-Received: by 2002:a17:902:c3cc:b0:1b1:b50c:e313 with SMTP id j12-20020a170902c3cc00b001b1b50ce313mr572141plj.66.1685660766564;
        Thu, 01 Jun 2023 16:06:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b001b02162c866sm4062096plc.44.2023.06.01.16.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:06:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4rMo-006gS5-35;
        Fri, 02 Jun 2023 09:06:03 +1000
Date:   Fri, 2 Jun 2023 09:06:02 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 6/8] xfs: introduce xfs_fs_destroy_super()
Message-ID: <ZHkkWjt0R1ptV7RZ@dread.disaster.area>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-7-qi.zheng@linux.dev>
 <ZHfc3V4KKmW8QTR2@dread.disaster.area>
 <b85c0d63-f6a5-73c4-e574-163b0b07d80a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85c0d63-f6a5-73c4-e574-163b0b07d80a@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 04:43:32PM +0800, Qi Zheng wrote:
> Hi Dave,
> On 2023/6/1 07:48, Dave Chinner wrote:
> > On Wed, May 31, 2023 at 09:57:40AM +0000, Qi Zheng wrote:
> > > From: Kirill Tkhai <tkhai@ya.ru>
> > I don't really like this ->destroy_super() callback, especially as
> > it's completely undocumented as to why it exists. This is purely a
> > work-around for handling extended filesystem superblock shrinker
> > functionality, yet there's nothing that tells the reader this.
> > 
> > It also seems to imply that the superblock shrinker can continue to
> > run after the existing unregister_shrinker() call before ->kill_sb()
> > is called. This violates the assumption made in filesystems that the
> > superblock shrinkers have been stopped and will never run again
> > before ->kill_sb() is called. Hence ->kill_sb() implementations
> > assume there is nothing else accessing filesystem owned structures
> > and it can tear down internal structures safely.
> > 
> > Realistically, the days of XFS using this superblock shrinker
> > extension are numbered. We've got a lot of the infrastructure we
> > need in place to get rid of the background inode reclaim
> > infrastructure that requires this shrinker extension, and it's on my
> > list of things that need to be addressed in the near future.
> > 
> > In fact, now that I look at it, I think the shmem usage of this
> > superblock shrinker interface is broken - it returns SHRINK_STOP to
> > ->free_cached_objects(), but the only valid return value is the
> > number of objects freed (i.e. 0 is nothing freed). These special
> > superblock extension interfaces do not work like a normal
> > shrinker....
> > 
> > Hence I think the shmem usage should be replaced with an separate
> > internal shmem shrinker that is managed by the filesystem itself
> > (similar to how XFS has multiple internal shrinkers).
> > 
> > At this point, then the only user of this interface is (again) XFS.
> > Given this, adding new VFS methods for a single filesystem
> > for functionality that is planned to be removed is probably not the
> > best approach to solving the problem.
> 
> Thanks for such a detailed analysis. Kirill Tkhai just proposeed a
> new method[1], I cc'd you on the email.

I;ve just read through that thread, and I've looked at the original
patch that caused the regression.

I'm a bit annoyed right now. Nobody cc'd me on the original patches
nor were any of the subsystems that use shrinkers were cc'd on the
patches that changed shrinker behaviour. I only find out about this
because someone tries to fix something they broke by *breaking more
stuff* and not even realising how broken what they are proposing is.

The previous code was not broken and it provided specific guarantees
to subsystems via unregister_shrinker(). From the above discussion,
it appears that the original authors of these changes either did not
know about or did not understand them, so that casts doubt in my
mind about the attempted solution and all the proposed fixes for it.

I don't have the time right now unravel this mess and fully
understand the original problem, changes or the band-aids that are
being thrown around. We are also getting quite late in the cycle to
be doing major surgery to critical infrastructure, especially as it
gives so little time to review regression test whatever new solution
is proposed.

Given this appears to be a change introduced in 6.4-rc1, I think the
right thing to do is to revert the change rather than make things
worse by trying to shove some "quick fix" into the kernel to address
it.

Andrew, could you please sort out a series to revert this shrinker
infrastructure change and all the dependent hacks that have been
added to try to fix it so far?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
