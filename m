Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964AB402530
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbhIGIgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 04:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbhIGIgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:36:00 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E7BC061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 01:34:55 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a14so5151747uao.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0q53YT3XvFhfsnGqeW9X6BJ+dZY91toW3fLTVzpHF0o=;
        b=FsScJHrbC+3N+bhSBxfEBjdFNbD1Frd1EN89LdKobKzBcJ3Q5nlzjZuHc7/pjbKvF8
         TLSXS+duH1CFsS0pDsGjgnRWjlBBGSP2hzteI8XT8ki+F+bmepRClnu8uRCeL1QyD1B/
         zDMbq3L0LRqJKJ9uw6Q1sojsvYhIXOFvQDLFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0q53YT3XvFhfsnGqeW9X6BJ+dZY91toW3fLTVzpHF0o=;
        b=pm0qFQDrFciyE/SK1Ur+9NfCV/TpoVRi31hZgu+K2MNm9aCKMXL8lFxwDA3AZ9cCIL
         if+tb3gO4rHTqLQlTQtxvN1pvetQdhhf5G0M8sArsS87FMJlTngxGhu98mzgiw52mejJ
         /y+UfGlzGq6y+5M9B6nPf0g/jxF4sc5IsI9HJXoSkvn6HBs8SJjV2+cphkoIRIGZWvFt
         rN5GaeB3S5NIHKj9EBBCmm5CY0GnzZqCMM1I8erIR+IwEl/fgdrc08e52r3T3VWTvY+P
         PUcmE0KCihnDNcVR2PUql6YIq9n9ruV3ulqFxULB016SAuOLmDO7GySki0YR8aQFIrN8
         WUFA==
X-Gm-Message-State: AOAM533LDpM9te0v2SrrUtnuYsu0NUIeXtOwbj1O1oOgZg0jipR/Evhu
        46CkL1v7Z3Iw13ldOMFccddVP4Vk1xfUclG/l2+j/g==
X-Google-Smtp-Source: ABdhPJzpqX767/lmZx1qI7ToijljuiAU0OIfHCyf9Di38x3jFTnNg2qk4m7epa+ues/BqvpnlsWahTivorfxCQaIJoE=
X-Received: by 2002:a05:6130:30a:: with SMTP id ay10mr7911194uab.8.1631003694239;
 Tue, 07 Sep 2021 01:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210812054618.26057-1-jefflexu@linux.alibaba.com> <20210812054618.26057-2-jefflexu@linux.alibaba.com>
In-Reply-To: <20210812054618.26057-2-jefflexu@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 10:34:43 +0200
Message-ID: <CAJfpegs3QGVNa4CXt0Hayr=G50cQb1TWowRDuVf0pZv6FYV3kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: disable atomic_o_trunc if no_open is enabled
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 12 Aug 2021 at 07:46, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> From: Liu Bo <bo.liu@linux.alibaba.com>
>
> When 'no_open' is used by virtiofsd, guest kernel won't send OPEN request
> any more.  However, with atomic_o_trunc, SETATTR request is also omitted in
> OPEN(O_TRUNC) so that the backend file is not truncated.  With a following
> GETATTR, inode size on guest side is updated to be same with that on host
> side, the end result is that O_TRUNC semantic is broken.
>
> This disables atomic_o_trunc as well if with no_open.

I don't quite get it why one would want to enable atomic_o_trunc with
no_open in the first place?

Thanks,
Miklos
