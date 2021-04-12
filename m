Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F55435C19C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhDLJbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbhDLJ2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:28:04 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5520C06138E
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 02:27:46 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id r4so2135423vsq.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hKUVtRAYKksa4g4Z/SOXZ+I+SLzgB72dysIQbYZhlk=;
        b=CitFYvjqQpJous7ooVmqfhnFsbgLlnpEDxsDp/0RahdDGBuwdMycdneGcKTEi88ZzZ
         icSfVdFS15Oe9zZx8G7npVnJ3yX5/NnRtCizxLwUgVHWsSjMKS/xvGkHJqooZ72EEjTl
         XCQwB/3XWLH1ObPZxWsIpNdO64fsA4CPgZjc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hKUVtRAYKksa4g4Z/SOXZ+I+SLzgB72dysIQbYZhlk=;
        b=n6h9CbYdoAfzuakVjUxgrBRZxlI6HAIcIbHAreBWJxR/1Ln0U8rTebM3cO6ZGqiHOE
         W1HZI0HvLtVu9CFxHUqeMvnPKCI+rcHy3vfy2zeVCQQrbLj/kY2Fe0V8JcUsJ15xIl59
         QOQwJoupq4EtdqK2q7AaB5F/wAtvqna7LKQcKKLxvL3joB5v0wgk/KKWrWZaOM09gPca
         xAThok8QXygEKk+WJ5B3NV2eEhzjzhhw5edQNIvL5fZRNV1jJl4y3MOhzRopPwwTMj9X
         EKVLYaKvSEijNfRG96tLN2IBLpmljvTh81sOtCS0lMBYbrb2NIJV332tCJNTtMLwmUhA
         5Psw==
X-Gm-Message-State: AOAM532G7UpGi+xma4y5okEn08pB80Id2lKoN3IuxXl2MZowfx5LmT64
        7kAF+qHJphe/A2OTsjx4DiEjHYAaC/0K7+kyEnZBgw==
X-Google-Smtp-Source: ABdhPJygb7TprYuqHMJbs7kZzi/RZ6+3XCz0tKtXIbFxyF52PMynCUJXHei8d09eoHLmkJRmeM3KYqSm+zCP8mXN81k=
X-Received: by 2002:a67:f487:: with SMTP id o7mr19224439vsn.7.1618219664676;
 Mon, 12 Apr 2021 02:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210323160629.228597-1-mszeredi@redhat.com>
In-Reply-To: <20210323160629.228597-1-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Apr 2021 11:27:33 +0200
Message-ID: <CAJfpegv4ttfCZY0DPm+SSc85eL5m3jqhdOS_avu1+WMZhdg7iA@mail.gmail.com>
Subject: Re: [PATCH] vfs: allow stacked ->get_acl() in RCU lookup
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        garyhuang <zjh.20052005@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 5:07 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Overlayfs does not cache ACL's to avoid double caching with all its
> problems.  Instead it just calls the underlying filesystem's
> i_op->get_acl(), which will return the cached value, if possible.
>
> In rcu path walk, however, get_cached_acl_rcu() is employed to get the
> value from the cache, which will fail on overlayfs resulting in dropping
> out of rcu walk mode.  This can result in a big performance hit in certain
> situations.
>
> Add a flags argument to the ->get_acl() callback, and allow
> get_cached_acl_rcu() to call the ->get_acl() method with LOOKUP_RCU.
>
> Don't do this for the generic case of a cache miss, only in case of
> ACL_DONT_CACHE.
>
> Reported-by: garyhuang <zjh.20052005@163.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Hi Al,

Could you please apply this patch?

It's fairly trivial, but unfortunately adds a fair bit of API churn.

Thanks,
Miklos
