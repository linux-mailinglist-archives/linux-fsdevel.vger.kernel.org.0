Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2C128883
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 11:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfLUKQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 05:16:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51062 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLUKQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 05:16:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so11294948wmb.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2019 02:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w7EMZsX1P6p24D8oxJ5lDhfZGtIC/1lVYlrnNXeuQH4=;
        b=Rq4LsVBwxYKw74dI8FSDPQwHMWSyqhrfuDWib+CxcFiQE+kws197g+JzT+PxYDTmD5
         FMcelA158Vpx3rW0QMRhO9CsMd4cyy1sKDhJe80scYqoBrsxroKFfwk1JZpGhXoa5apQ
         MXFmF0Y3+qIxm+ClyYCqMHx9AnYAefTs7VmVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7EMZsX1P6p24D8oxJ5lDhfZGtIC/1lVYlrnNXeuQH4=;
        b=axeiSdLhx4HSYCrXosNYM/CzxLuCt96OrEtsQ81VMv6QMHSqgpZ/jXGI+x13mniwHk
         Rl0ArMsfDZKG2WiTqcdMPhmqLp9Ws8+Gm+AB/mjXjUvZIwagBFQQCwLUWsgPaLMpfU+X
         iCLYVYrrqA6jrw0tD42OSGKbJ55kHGIzJhr2pI6DV8vc+d9WU1U3wUDwa9CLiwb+6Gd7
         SxugJShgb0vvbs9aQIYrgt+XpQ/0BiRrF/0bi8gD+w3PLnPhiTc/RwBb9wJT+W/MsGP7
         RY+eGIVEbKaXTsgblYtmJSBgnatFxHAKAD1rwl2SDCPEVsvhxpQz/z56hDlFzpmKte2l
         L2eA==
X-Gm-Message-State: APjAAAWa7ZG67OA520w8LIGKKH6mPLnq0XIzMDHfh8qqK22D+gVDrF04
        Lxb10pKMTMCY32iBKCTrYMDJVw==
X-Google-Smtp-Source: APXvYqyL77witqgEbMqthpAjN1mJkW/ygtn87eZ9je+eLTRHWAOroHYyJnM+yA9gXhnLyAAobryETA==
X-Received: by 2002:a1c:9d52:: with SMTP id g79mr21587689wme.148.1576923414062;
        Sat, 21 Dec 2019 02:16:54 -0800 (PST)
Received: from localhost ([185.69.145.42])
        by smtp.gmail.com with ESMTPSA id f127sm11114118wma.4.2019.12.21.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 02:16:53 -0800 (PST)
Date:   Sat, 21 Dec 2019 10:16:52 +0000
From:   Chris Down <chris@chrisdown.name>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20191221101652.GA494948@chrisdown.name>
References: <20191220024936.GA380394@chrisdown.name>
 <20191220213052.GB7476@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191220213052.GB7476@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong writes:
>On Fri, Dec 20, 2019 at 02:49:36AM +0000, Chris Down wrote:
>> In Facebook production we are seeing heavy inode number wraparounds on
>> tmpfs. On affected tiers, in excess of 10% of hosts show multiple files
>> with different content and the same inode number, with some servers even
>> having as many as 150 duplicated inode numbers with differing file
>> content.
>>
>> This causes actual, tangible problems in production. For example, we
>> have complaints from those working on remote caches that their
>> application is reporting cache corruptions because it uses (device,
>> inodenum) to establish the identity of a particular cache object, but
>
>...but you cannot delete the (dev, inum) tuple from the cache index when
>you remove a cache object??

There are some cache objects which may be long-lived. In these kinds of cases, 
the cache objects aren't removed until they're conclusively not needed.

Since tmpfs shares the i_ino counter with every other user of get_next_ino, 
it's then entirely possible that we can thrash through 2^32 inodes within a 
period that it's possible for a single cache file to exist.

>> because it's not unique any more, the application refuses to continue
>> and reports cache corruption. Even worse, sometimes applications may not
>> even detect the corruption but may continue anyway, causing phantom and
>> hard to debug behaviour.
>>
>> In general, userspace applications expect that (device, inodenum) should
>> be enough to be uniquely point to one inode, which seems fair enough.
>
>Except that it's not.  (dev, inum, generation) uniquely points to an
>instance of an inode from creation to the last unlink.

I didn't mention generation because, even though it's set on tmpfs (to 
prandom_u32()), it's not possible to evaluate it from userspace since `ioctl` 
returns ENOTTY. We can't ask userspace applications to introspect on an inode 
attribute that they can't even access :-)
