Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE80A4025C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbhIGI60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 04:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbhIGI6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:58:25 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B041C061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 01:57:19 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u1so7652324vsq.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 01:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSsmXQdog+XhRKFrtC061ebmew6mLTJ95fTRhHi5xkA=;
        b=T9OmG0t/v7+e7ikKzrY0GBccn59UJoYuOtW9D+yB97t32goBea8gIyAqD6b3wlT8v9
         9UuibUNeApxg7PuPqC89FwlInDPXDjW/b+4gkEzSOSTofwfIOucChFesw0tFHV0lu7+s
         5RDCtA1S6/EqCR1O/IvOeB0dtqJt+hftv5M7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSsmXQdog+XhRKFrtC061ebmew6mLTJ95fTRhHi5xkA=;
        b=fbmoWlR/tJaoGrM+yV131kAbIZXv+tMgnLhJBSwZDoUTqIbY5XEmNylZajV59FCVWq
         KhQ4wsM1KsN3MHWLKmnR1FP+2DoYyl7CvqGeb5g36ZwPUskQjjiRwH6yttHdICOTm278
         Ws2E5nr92Wg1Lf60mHIfB95w6rKa7lgWUgomVCq7iHqtzgGX5ynj6kMBoDiGr1Ei2Yyh
         EiSwdmZjVL7kOpyJxDXoQ5Ow+F8Q0pHbthsRSX7MrPIeRawJPewkFuxZYDk/JbxwqETV
         vzGMZ5RiFemowZ4xSChXtc6WMKSQOXGIsLIhVbPYDviriQcZxcyVoC0FeK64YkxuRaCX
         vedg==
X-Gm-Message-State: AOAM533WLPZodv3LODvod6/WffLDYcxY34ogIYTb9SEWIMopb3HqiO2L
        KV/erdqjJ5pyv+MpVpb6TShKLs8ojiFGNDDoDkq+RSGyDqi6Gg==
X-Google-Smtp-Source: ABdhPJxPnu3ZfRglpMJeBrNdkWBiHvtWAtSVJGORo9XW197BFsOPdypCjhnFx8+sR3Nnngu12HNfAzNiDgkP7u3zMWI=
X-Received: by 2002:a05:6102:483:: with SMTP id n3mr8198870vsa.42.1631005038552;
 Tue, 07 Sep 2021 01:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210812054618.26057-1-jefflexu@linux.alibaba.com> <20210812054618.26057-3-jefflexu@linux.alibaba.com>
In-Reply-To: <20210812054618.26057-3-jefflexu@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 10:57:07 +0200
Message-ID: <CAJfpegt48RM_y7mOj5EBcohF0zEmE4D6D7sHNgYgKNgGqDgTsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtiofs: reduce lock contention on fpq->lock
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
> Since %req has been removed from fpq->processing_list, no one except
> request_wait_answer() is looking at this %req and request_wait_answer()
> waits only on FINISH flag, it's OK to remove fpq->lock after %req is
> dropped from the list.

I'll accept a patch to remove FR_SENT completely from virtiofs.

This flag is used for queuing interrupts but interrupts are not yet
implemented in virtiofs.    When blocking lock support is added the
interrupt handling needs to be properly designed.

Thanks,
Miklos
