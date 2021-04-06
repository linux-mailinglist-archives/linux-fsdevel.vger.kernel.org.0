Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2C0355E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 00:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhDFWDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhDFWDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:03:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5A6C06174A;
        Tue,  6 Apr 2021 15:03:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id i19so12357025qtv.7;
        Tue, 06 Apr 2021 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pl6NF7ighmszrBnnrt9i5pamFjYQ/T564JehZ9nDrZ8=;
        b=dNqVoUmjFaGLO1KEWNtWpOa4FC3Ur07F1vtFzQDat5pyEQci5kEM8UAWvmchAaus1E
         C2GxXMzXG3x/LO7Z+rRFMHXjXTrYarlPxka0x7ZUBEAiZbaEJ2sXHiGqL3oUMbxmyU3w
         XwA1iwNfKn3s0rZ/IF5WkhflALemiFHXL+vx+3PUqlQD5sE9kn0Eq/nZthmbqD7jz0vF
         KC/LV2M7CMWxIbOI3OSISwIkTbNz5BYK1TwWwCxcKh5cQREnavic5f0HgToNDvl4x9wS
         dwD3Ip7J232HSnCFod8FlhYuBVUdbMXPVu1PTCbttSdfZGr5kzGiHD3TAYK0ij6m8Lyu
         Ag8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pl6NF7ighmszrBnnrt9i5pamFjYQ/T564JehZ9nDrZ8=;
        b=M5zjYnj+cHudDTtg5MEMohXypO9PveC0u/X3o4wI/0OYE0pX600bdPxbdMsDp+yylt
         yjf1zuaYqObGXRE6Lbn+FXoGoo4J1jgPFeOyBXWw/HqZuQetrYB8evi7icbCrsMcS4H2
         OOT4k3oiVUcbO7VFD59bwbpBKDztmjVkVC/bbvboKyndvL+mJPgyqmvwVKJnX3GzX4hW
         ThIN7pCCv+YbKdeaHxGIGp4SEsvVKRHvmmP4fG+KMKGnqk0p0BWA874CqcAQwqGzOrp3
         vxBueQbOGQmcc36GcIVUH2oSMKyo+UKREWP8cefbtCvQR0mEu+3uSp/xRhZ+KF1FO4gc
         q9Ow==
X-Gm-Message-State: AOAM530bwt3Yb8PfaV0HjcA4BxRRzI7lXOpKpUbsSqCmN4DR+/adEM7Q
        KBukuLAIMigVZS2e0mdpEFHCrNImNMpS
X-Google-Smtp-Source: ABdhPJy21e40Dgb6Cu+qJhUdfvvaJHK0LsdQXUIkIhnD2mIKHIADk5CLzF5WXt9h7sKafbqm+NrfsQ==
X-Received: by 2002:ac8:4e4d:: with SMTP id e13mr105276qtw.169.1617746616351;
        Tue, 06 Apr 2021 15:03:36 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id y1sm16777925qki.9.2021.04.06.15.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 15:03:35 -0700 (PDT)
Date:   Tue, 6 Apr 2021 18:03:26 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] vfs: convert inode cache to hlist-bl
Message-ID: <YGzarpyqdcI9ncQu@moria.home.lan>
References: <20210406123343.1739669-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406123343.1739669-1-david@fromorbit.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:33:40PM +1000, Dave Chinner wrote:
> Hi folks,
> 
> Recently I've been doing some scalability characterisation of
> various filesystems, and one of the limiting factors that has
> prevented me from exploring filesystem characteristics is the
> inode hash table. namely, the global inode_hash_lock that protects
> it.
> 
> This has long been a problem, but I personally haven't cared about
> it because, well, XFS doesn't use it and so it's not a limiting
> factor for most of my work. However, in trying to characterise the
> scalability boundaries of bcachefs, I kept hitting against VFS
> limitations first. bcachefs hits the inode hash table pretty hard
> and it becaomse a contention point a lot sooner than it does for
> ext4. Btrfs also uses the inode hash, but it's namespace doesn't
> have the capability to stress the indoe hash lock due to it hitting
> internal contention first.
> 
> Long story short, I did what should have been done a decade or more
> ago - I converted the inode hash table to use hlist-bl to split up
> the global lock. This is modelled on the dentry cache, with one
> minor tweak. That is, the inode hash value cannot be calculated from
> the inode, so we have to keep a record of either the hash value or a
> pointer to the hlist-bl list head that the inode is hashed into so
> taht we can lock the corect list on removal.
> 
> Other than that, this is mostly just a mechanical conversion from
> one list and lock type to another. None of the algorithms have
> changed and none of the RCU behaviours have changed. But it removes
> the inode_hash_lock from the picture and so performance for bcachefs
> goes way up and CPU usage for ext4 halves at 16 and 32 threads. At
> higher thread counts, we start to hit filesystem and other VFS locks
> as the limiting factors. Profiles and performance numbers are in
> patch 3 for those that are curious.
> 
> I've been running this in benchmarks and perf testing across
> bcachefs, btrfs and ext4 for a couple of weeks, and it passes
> fstests on ext4 and btrfs without regressions. So now it needs more
> eyes and testing and hopefully merging....

These patches have been in the bcachefs repo for a bit with no issues, and they
definitely do help with performance - thanks, Dave!
