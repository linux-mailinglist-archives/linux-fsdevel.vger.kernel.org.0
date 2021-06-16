Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DAE3A95A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhFPJOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 05:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhFPJOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:14:53 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5995AC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 02:12:48 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id n61so533337uan.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fg+Lwm8bqclQbxxF9nKW4sgpvY121G0MYdrkC/2k1M8=;
        b=eLGiC8kkhgquOH+uwR66kHv1IPOXh5NS6AtUvw8ENiPjX3MbCqGOFI3kx2g+dx6Tnc
         o1gP20fNEjAVj2TSPTcBjM2RhiYrf1lr/9RdX6k41CyvK+0LvDzAuF1pNfR8SPDFVnIU
         UdbGzPAZBwGtCf4UeXvuvKO6AWBy035AlYzcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg+Lwm8bqclQbxxF9nKW4sgpvY121G0MYdrkC/2k1M8=;
        b=hgi5OJcIBl01UOhMG4q4UUvX/VR3hN48uv1EVIRepwYdqpv5APF8iRmtFz92QBMI0v
         WiYxtaoWLr0BsbQ28CUmSHI+0gT55D6Mof22sfoj+ExCiK9wOGVYATtN3Ch0GC+HjyPk
         roXbA3IOt3tZXnmjsY2LtM0Dr2WWcSyqqMgMBOwAqT0ZPjmdxRwPVjoYOwY+oQGWvMlo
         4eTk/+FWxjRNhwKAqNFuEGCFLxWWqKbxp3W3mC5gqgOn51hhzJVAeCn3LoheF7DVhnev
         8db/nMAoY7FB0wZtpteUgkCNHtP7KN89Tj0j7id8Kt7CottoiIHzMUzM+LO6BptV49Gd
         LERw==
X-Gm-Message-State: AOAM533zijfC94EaNNeTaR7adXv9L9RvY5UojHpSfL/ZTkA6RYrg69c2
        DEnHme+FknYSy7+RcwoP5pOhRKH3o92gSA6yCJBd6ILKfmtRGA==
X-Google-Smtp-Source: ABdhPJyPqKdYY+BCjGVxp5kVHCSvHJwrxRylVWbgfp624rwp6rN9DLHefYeKSZBh8olnEWhl+VTCJoi+r4cet117ZYM=
X-Received: by 2002:ab0:6448:: with SMTP id j8mr3590542uap.13.1623834767170;
 Wed, 16 Jun 2021 02:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
 <162375278118.232295.14989882873957232796.stgit@web.messagingengine.com>
In-Reply-To: <162375278118.232295.14989882873957232796.stgit@web.messagingengine.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Jun 2021 11:12:36 +0200
Message-ID: <CAJfpegttf+kYBCLsUc9eFLc-KNaN=0smdSMoemAK6t52Kb=fEg@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] kernfs: use VFS negative dentry caching
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Jun 2021 at 12:26, Ian Kent <raven@themaw.net> wrote:
>
> If there are many lookups for non-existent paths these negative lookups
> can lead to a lot of overhead during path walks.
>
> The VFS allows dentries to be created as negative and hashed, and caches
> them so they can be used to reduce the fairly high overhead alloc/free
> cycle that occurs during these lookups.
>
> Use the kernfs node parent revision to identify if a change has been
> made to the containing directory so that the negative dentry can be
> discarded and the lookup redone.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
