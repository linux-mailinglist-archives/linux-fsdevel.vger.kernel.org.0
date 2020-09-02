Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4072725A5E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 08:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBG5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBG5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:57:19 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A189C061244
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 23:57:19 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b16so2013412vsl.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUwVHY5EhmwuA95hzffZxCTvruckO8XQ5+Y16pohq98=;
        b=WRwTzPMYdidKpIkTgala3f2TZ6QHYRkBxEQXIIqWKC5sWn7F/MD6okYSIJVeQOkFId
         IKS5IXdWHcYvgozJOjcV206Vj6RKCLqxcOH2s3rl/1gD5QdY7hvYziN1fQJWdkCQ76At
         I6qOmM4PG8cSuIq3IgS/x244Fv04Bu9qAyges=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUwVHY5EhmwuA95hzffZxCTvruckO8XQ5+Y16pohq98=;
        b=S21EjYFlhrG6xuGDiHt0jHZJEbTeRbaeBLY+vUsNYJQMA0H2XjnaRIxSIlXe209TAm
         d+uT+Xd8YASxiu2Yx4cq2lzTrg8NybLmVcUEB4NWGbJ15X9Am8n2ChHJbv2Gx86+7L6X
         8OY3+joLFP69ALY9Uv+usYcnLjFaF2x11vqg+qSxW6o+NUTlHCF1UY7MX7/5vJc/2/9Q
         ERzPjpYqg8SR71DgGg+BOjJftzSwvV9JgKhrbg8RJd8vh8RmN33mIOYNFVMJ9u8BA+gn
         K/eBQ9dQfIJXruxpym+DcVxoepiC3y3Yh8sYDD8oUQEIZjbK024dZlRmE0DobZkAWWjZ
         rxeA==
X-Gm-Message-State: AOAM530VRkD5g9jef1IZgMaSz4z0GjJa/1F4W3z4j62YiDIeSR0pvq+p
        TXDhsk5p4ftmmwqqCRTci3HYgwo4te3pBeRlh+ON/g==
X-Google-Smtp-Source: ABdhPJybo4VLTj7yLdHDibIqu3L1li/16wlB5zxQsTci1ydAQ8tpNJiDqIefx93ieplvk+bPPTS9CeBJodA10kUspzQ=
X-Received: by 2002:a67:cb97:: with SMTP id h23mr4246081vsl.43.1599029838101;
 Tue, 01 Sep 2020 23:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200901204045.1250822-1-vgoyal@redhat.com> <20200901204045.1250822-2-vgoyal@redhat.com>
In-Reply-To: <20200901204045.1250822-2-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 2 Sep 2020 08:57:07 +0200
Message-ID: <CAJfpegtUMJqUDhFTePpFP=oQ=XGFj2tfvx+unV94sN3fFZbZHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Add a flag FUSE_NONSHARED_FS
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 1, 2020 at 10:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> FUSE_NONSHARED_FS will signify that filesystem is not shared. That is
> all fuse modifications are going thourgh this single fuse connection. It
> should not happen that file's data/metadata changed without the knowledge
> of fuse. Automatic file time stamp changes will probably be an exception
> to this rule.
>
> If filesystem is shared between different clients, then this flag should
> not be set.

I'm thinking maybe this flag should force some other parameters as well:

^FUSE_POSIX_LOCK
^FUSE_FLOCK_LOCKS
^FUSE_AUTO_INVAL_DATA
FUSE_EXPLICIT_INVAL_DATA
FUSE_CACHE_SYMLINKS
attr_valid=inf
entry_valid=inf
FOPEN_KEEP_CACHE
FOPEN_CACHE_DIR

This would make sure that it's really only used in the non-shared case.

Thanks,
Miklos
