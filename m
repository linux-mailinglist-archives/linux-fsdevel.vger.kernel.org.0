Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA24098F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 18:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhIMQZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhIMQZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:25:47 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B969C061760;
        Mon, 13 Sep 2021 09:24:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h3so9945135pgb.7;
        Mon, 13 Sep 2021 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7iNVw3gDtbqcmJuxqzAp5MJgiBGuJVVVMEOeEc9LwQI=;
        b=KMn3oOOQ7z+gZHnSi7tKwT8HQswrmQXWn3lkFw+yHY0rKS9MNHhd4wHGCJKSgBUW+n
         T9tyboH4kQf5n8hqLQ+QVZjkSSb3UmHmDfhwVZGsusChykPhGMmDVApFEBhgyaEKxcqF
         nQx/BCeW80UOUgD50aLnXPiX4V3x1A3k2VOFzTxgJQqUhtnAXDX5LCWind7N0Ph7r5JS
         YIiLJlvawJQq8N+/L4ad49VBtsL/uFJZK9EarxpeaZCD8dgARJnrDmUwzUoTfpYQ/chd
         wHvBmuxhJWuabByUsiQ+4Bj5XEDk3RaSHUx98oQLvBABSE9710epxsKIwebP8rwgN8I+
         YMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7iNVw3gDtbqcmJuxqzAp5MJgiBGuJVVVMEOeEc9LwQI=;
        b=UWbRY3N6UULWw2HpJkRVP03vsudtg+/KudBZcHXgENc+qQJ+TRXKv3N7PkBp39KDh9
         24XFc0pyV3umAC3Tuw6P+OjoWMUFshSHqIgLpTu4/j2ZTKBQDU1xaF9GbS6Mia/Now6X
         NcSdPMqg2Q9G2+ML3lcgyNJ1/EOkImeGz2StWvUxhS71g+JSozEa0mJDh8TFLu5dNMgt
         yCuNpVEfqrR4awdeh2K35iuiDHTsGt0HEjBPy5TBNkoRL2ZxEMJ/eGcpan9H/nYANjTf
         oDcnEQek6Y7ht6rX9Xqa6VxDeEv12JEVPuXo4QMrqrN3b15dZdnjamSnsxHJ24V8+mfv
         Mqjw==
X-Gm-Message-State: AOAM531WEOUqI1Bo8lRwkz2PpqLvN1hKZYo0vYyXw4I/Wf7l3BBwRqZp
        vm8nDvibEVel6UyOZpozDMk=
X-Google-Smtp-Source: ABdhPJwcRXRk6qz0DRNFCw//xgAu2bkBeEvp9KWsb6qS7ho6P+WnajXyZjSblVMrpMHi4+apDU5iag==
X-Received: by 2002:a65:648b:: with SMTP id e11mr11675333pgv.138.1631550270967;
        Mon, 13 Sep 2021 09:24:30 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g8sm7169782pfv.51.2021.09.13.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:24:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 06:24:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "taoyi.ty" <escape@linux.alibaba.com>,
        Greg KH <gregkh@linuxfoundation.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 0/2] support cgroup pool in v1
Message-ID: <YT97PAm6kaecvXLX@slm.duckdns.org>
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <YTiugxO0cDge47x6@kroah.com>
 <a0c67d71-8045-d8b6-40c2-39f2603ec7c1@linux.alibaba.com>
 <YTuMl+cC6FyA/Hsv@slm.duckdns.org>
 <20210913142059.qbypd4vfq6wdzqfw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913142059.qbypd4vfq6wdzqfw@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Sep 13, 2021 at 04:20:59PM +0200, Christian Brauner wrote:
> Afaict, there is currently now way to prevent the deletion of empty
> cgroups, especially newly created ones. So for example, if I have a
> cgroup manager that prunes the cgroup tree whenever they detect empty
> cgroups they can delete cgroups that were pre-allocated. This is
> something we have run into before.

systemd doesn't mess with cgroups behind a delegation point.

> A related problem is a crashed or killed container manager 
> (segfault, sigkill, etc.). It might not have had the chance to cleanup
> cgroups it allocated for the container. If the container manager is
> restarted it can't reuse the existing cgroup it found because it has no
> way of guaranteeing whether in between the time it crashed and got
> restarted another program has just created a cgroup with the same name.
> We usually solve this by just creating another cgroup with an index
> appended until we we find an unallocated one setting an arbitrary cut
> off point until we require manual intervention by the user (e.g. 1000).
> 
> Right now iirc, one can rmdir() an empty cgroup while someone still
> holds a file descriptor open for it. This can lead to situation where a
> cgroup got created but before moving into the cgroup (via clone3() or
> write()) someone else has deleted it. What would already be helpful is
> if one had a way to prevent the deletion of cgroups when someone still
> has an open reference to it. This would allow a pool of cgroups to be
> created that can't simply be deleted.

The above are problems common for any entity managing cgroup hierarchy.
Beyond the permission and delegation based access control, cgroup doesn't
have a mechanism to grant exclusive managerial operations to a specific
application. It's the userspace's responsibility to coordinate these
operations like in most other kernel interfaces.

Thanks.

-- 
tejun
