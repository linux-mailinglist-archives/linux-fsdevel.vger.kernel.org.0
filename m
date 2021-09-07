Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7520E402B4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbhIGPFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhIGPFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:05:24 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752AEC061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 08:04:18 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id a21so8552447vsp.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpfzW/PVwHf+0Rs6X2ui1kGNO3SDbejRkBUW3mGcmE0=;
        b=iAYGVOEGFEObQ+gSfZKdElr9BDoLbQsWmbfuiS3jtgzCULIU3XDKXXVM0XV7nMU0AT
         EoADEg//7Ir4RyNX8DBD/88yo8mSUf/IlPcRpZbQYM3JKFBg15oK/T9+tQ8GVVeEMz1q
         MBFC/k3xrIyY94VHS1Y2pJDNGJk9/BND3Euu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpfzW/PVwHf+0Rs6X2ui1kGNO3SDbejRkBUW3mGcmE0=;
        b=iUMcikJ7SdGAKY5WMLBXP8knJ/y2QA8uaaGLeoGB127SZlkKZyc4WJ7vwBiC74+vJg
         1l4ZdzMBaCQGVUgnRzATj5eYPuUz1Jnf9AMXvBCoAEXEWLFOH+Th9rnwYQJGzNattOb/
         w5E2DqsLBMgNs1jbQ7Cfuoq5htSx3RDB0+FAIZfkLx5VJ2fbUyLQhQNt5BTLXncKhnFE
         t9aaizudXRoO0sdDZ60fHF7oepQTHzd18riIe8dEXWZYukj2kDtRwMYtu2FX/lR/vnAX
         wImYjrdtwyLOsHzsi/Ia3FefblL0PmkM/M+7CvpzITG6NhlNEsKxNFJU5M9OpYxFzunP
         aPeA==
X-Gm-Message-State: AOAM5312Ez9s668thN3ss39Jj2UJ+8k3GeY5WdGbQI8XtTFqHOF5EOlr
        VhOboubKLFOUFwlDxH8jwpiKkScCpPjIXqgUe+k3HA==
X-Google-Smtp-Source: ABdhPJwIERSjQ0+LJJhbH8wqnmfyydiAjQhlY/i0gsHol0tvwD/gQaUqSvu68Y8bSrwCkLGVQmJfQ/4FXIJEr30mGYM=
X-Received: by 2002:a67:eb45:: with SMTP id x5mr9917911vso.19.1631027056058;
 Tue, 07 Sep 2021 08:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aLNUNGo94u1yVKSJwy3rehRP84ha8YmbOdMyehFeVah0w@mail.gmail.com>
 <CAJfpeguDzHO9rx4eVRi4Lvjj0O9-oT8SEN7JAfWtsNj-6M_YAA@mail.gmail.com> <CAPm50aLXQC_Q+fEPsJaUJjn7ahHV57FM1vCOVwJpFfnghXXbzw@mail.gmail.com>
In-Reply-To: <CAPm50aLXQC_Q+fEPsJaUJjn7ahHV57FM1vCOVwJpFfnghXXbzw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 17:04:03 +0200
Message-ID: <CAJfpegtxvm1OPid2PcbSxQx+95C4PBKU6OQSPJx6XR9T=BRXtg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Use kmap_local_page()
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Aug 2021 at 09:48, Hao Peng <flyingpenghao@gmail.com> wrote:
>
> >On Tue, Aug 17, 2021 at 11:42 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> >On Tue, 17 Aug 2021 at 05:17, Hao Peng <flyingpenghao@gmail.com> wrote:
>> >>
>> >> kmap_local_page() is enough.
>>
>> >This explanation is not enough for me to understand the patch.  Please
>> >describe in more detail.
>
>    Due to the introduction of kmap_local_*, the storage of slots used for short-term mapping has
>    changed from per-CPU to per-thread. kmap_atomic() disable preemption, while kmap_local_*()
>    only disable migration.
>    There is no need to disable preemption in several kamp_atomic places used in fuse.
>    The detailed introduction of kmap_local_*d can be found here:
>    https://lwn.net/Articles/836144/


Can you please resubmit the patch with this explanation and without
tab/space corruption?

Thanks,
Miklos
