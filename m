Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979141F3E1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgFIO2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgFIO2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:28:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC049C05BD1E;
        Tue,  9 Jun 2020 07:28:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p20so22883071iop.11;
        Tue, 09 Jun 2020 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHleEGQvwth+DWFFAZh2cL0FL4PTrqO8oJ2xru0YtMA=;
        b=pUd67zGsjy+kxiVT5oLzIOJmDyKXkWL/r/t5e145O2QSN+AjKyoVYwU7I4IfUxDE+u
         JKBzt9OaMa/tSMOzjcKTxUUEY8c4NAM3RZoR1kNd2p215gJOTugu+WTZvjEj1rvaKOKk
         gAAc84OalvjBc0ZsPWi+G9nhRZCjvtpWoUUV0YDdvbQmt0WitVHq4pohZ/Xy2P7VcZPQ
         au76hFXCES+vG7AhVhfJlxYAqNOg6DisW7rUqImREOye/KwB7sgvyQRP1hNVZGIjjD8v
         Ul1UtSvcSDamUF2xSzkTmgFkca6iqQeQrenxD8oyEN3u0BxYl628qjHaNJjSBxsu4fTN
         t/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHleEGQvwth+DWFFAZh2cL0FL4PTrqO8oJ2xru0YtMA=;
        b=LZm3GHm4KBQmsvVh0HxpMKgErtT34x9lzYfhZXGjiYlaDCCfLC/65SF2n9h6ZfFhMT
         /jS71LB9EtyPX1Xb0gktBY7CrN0GsLzBm1xY/OTN7AHbxCUC74ptPwZ7wL3YoqlHmaah
         MH5U/XQpDPizKJHxCcsbde3LhnDO9xIJilzMSa4Rwn4vnTr39CX+IJDhHzLCvjovz0im
         MyjX4BM5XCaGSkdoIjF/HZn/QiR9aQfQHKMYIkkAmBGlDxkYTfohRRJhhA9hDjQ+tYGX
         9KmTD6jKRT6HDfvrOo1gThxPzeR0aFlsdBHnaT20/rVLj5rUJak98hCJJBHWEEiUmhut
         CB/g==
X-Gm-Message-State: AOAM533fS68QkeRr1ZpsOy6lJXMhlaixv7MfTpmX57Vow9y5miS3d/Ge
        JTMhb1iwnv7j3AFVU/CY41x7oB/j2VldWXPLwhREanr9RlJ0BQ==
X-Google-Smtp-Source: ABdhPJxj53r9fJMQoUdiO8ZXSy+k/8PtAYxUNGUbGwLjh4GNQYtVZAr6428Kuv4ftdjP8UBRWMU3rgbimqXmR+80/+E=
X-Received: by 2002:a02:cc71:: with SMTP id j17mr25858487jaq.94.1591712923004;
 Tue, 09 Jun 2020 07:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <1591254347-15912-1-git-send-email-laoar.shao@gmail.com> <20200609140304.GA11626@infradead.org>
In-Reply-To: <20200609140304.GA11626@infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 9 Jun 2020 22:28:06 +0800
Message-ID: <CALOAHbCeFFPCVS-toSC32qtLqQsEF1KG6p0OBXkQb=T2g6YpYw@mail.gmail.com>
Subject: Re: [PATCH v2] iomap: avoid deadlock if memory reclaim is triggered
 in writepage path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 9, 2020 at 10:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jun 04, 2020 at 03:05:47AM -0400, Yafang Shao wrote:
> > Recently there is a XFS deadlock on our server with an old kernel.
> > This deadlock is caused by allocating memory in xfs_map_blocks() while
> > doing writeback on behalf of memroy reclaim. Although this deadlock happens
> > on an old kernel, I think it could happen on the upstream as well. This
> > issue only happens once and can't be reproduced, so I haven't tried to
> > reproduce it on upsteam kernel.
>
> The report looks sensible, but I don't think the iomap code is the
> right place for this.  Until/unless the VM people agree that
> ->writepages(s) generally should not recurse into the fs I think the
> low-level file system allocating is the right place, so xfs_map_blocks
> would seem like the correct place.

Thanks for your comment.
That is what I did in the previous version [1].
So should I resend the v1 ?

[1]. https://lore.kernel.org/linux-xfs/1591179035-9270-1-git-send-email-laoar.shao@gmail.com/

-- 
Thanks
Yafang
