Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2729E405BF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 19:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbhIIRY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 13:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhIIRYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:24:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51719C061574
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 10:23:15 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m4so4139818ljq.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6IJpdyTV9RM1+HAVghvZCBeKL8NDMdT8/thsJ+vYl0=;
        b=d/Cm/SAUhDwf7DCQEkoVrmFkB/9CL0b8pA5PmPS8EU77HXDdzgEOXRUTwEK6IETgXK
         d7dwkAqlP05KbPlW3NS8FI7pi0/wpcu8lpfbqGzYvk5d/J1P80i0uY894FNCjnJ99IT7
         Z/LeSXzV7P3I2yGkUEJbF3lmaMHtRIQBM+ljk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6IJpdyTV9RM1+HAVghvZCBeKL8NDMdT8/thsJ+vYl0=;
        b=R75FHCGiBBpcHVkzfZCgtRJVNNVqJ4TSmsMTX8wi8r1Lj44rcLl7q1hg+IBWin71BU
         BZvzz8H/IfTB5qKOsXvQ1h4gnq+aH7vEC5mAMLDlNOsC28M70wy6PZrqqkpeS5WlRNZe
         sA3iuIq8FUOBaPoZ3OIfNFor47HN73yiuxVCnyAcVndJTmGaj7W4W2/ZgLL6Es7nf9qQ
         GRyxjoFMWFK5XFupnHIvODoX3T1VepCUM0Y8CT1O+TqzhXyPW43nXgIScECXLx0+Pjxv
         axhQiPru7892xjB3s+X/UCWShCS0Mt0yCTv4pcGxqtM8UIJCee/iWtskzTRSyGl9HDhh
         Psag==
X-Gm-Message-State: AOAM533eGQPSrCPfjlen9CwGICUALvTNvSB7nQzLKh6PGIj+vTRo3f3b
        zc6RbSZIwRxO09aIAjpoGzat8VWpyBwE2RasDjk=
X-Google-Smtp-Source: ABdhPJxd4mQZQAidA624DDPuLCasIWStnTugiwOk425ucCdSSEuq3HQTHi9oQetvrq7ej1vRYFYosg==
X-Received: by 2002:a05:651c:1409:: with SMTP id u9mr736652lje.429.1631208193247;
        Thu, 09 Sep 2021 10:23:13 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id j3sm263939ljq.84.2021.09.09.10.23.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 10:23:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id i28so4137432ljm.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 10:23:12 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr806608ljn.56.1631208192152;
 Thu, 09 Sep 2021 10:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-17-agruenba@redhat.com>
 <YTnwZU8Q0eqBccmM@infradead.org>
In-Reply-To: <YTnwZU8Q0eqBccmM@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 10:22:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF7TPaumMU6HjBjawjFWjvEg=116=gtnzsxAcfdP4wAw@mail.gmail.com>
Message-ID: <CAHk-=wgF7TPaumMU6HjBjawjFWjvEg=116=gtnzsxAcfdP4wAw@mail.gmail.com>
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 9, 2021 at 4:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> What about just passing done_before as an argument to
> iomap_dio_complete? gfs2 would have to switch to __iomap_dio_rw +
> iomap_dio_complete instead of iomap_dio_rw for that, and it obviously
> won't work for async completions, but you force sync in this case
> anyway, right?

I think you misunderstand.

Or maybe I do.

It very much doesn't force sync in this case. It did the *first* part
of it synchronously, but then it wants to continue with that async
part for the rest, and very much do that async completion.

And that's why it wants to add that "I already did X much of the
work", exactly so that the async completion can report the full end
result.

But maybe now it's me who is misunderstanding.

          Linus
