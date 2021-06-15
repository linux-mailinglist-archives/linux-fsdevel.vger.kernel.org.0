Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94F53A7A6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFOJ0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 05:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhFOJ0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:26:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7182C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 02:24:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m2so4211895pgk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xf8JpD2ekVfpgMQrN8/r4OU/MZdor4G8yHG1b47HWJg=;
        b=T6Pc6V7P+l6QtWwMmSDJTJWgM41Ha/R0+XFZvQiSVPFHg9bfrPc71MV19tSYXtuc6Q
         xLNkE0ROtr8R/+MBLIhRxv5ttgNg9VnUL2DV2FoI9IPOGHKpqwbCX6Q97tIVNofDjJRD
         sPjr5XrEXcChomgcvpuAbsjInFC2FKqVZ5r0fZ2aUYF+Q2rHaTEKfeaFT/291p+4Ns1x
         1NYgKmXOwlzGmKkY5Qps1wz67jGMUxhF6LmpsjyAuLUyy2/HlEHGJYN3Utl1wIt8k07X
         bFxA3aZ3gMrYZYA25XyqlSxuEixCbuO2yBvFItD+MZhyBoQWadALyqHmIYGZ8cAA9v+v
         HgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xf8JpD2ekVfpgMQrN8/r4OU/MZdor4G8yHG1b47HWJg=;
        b=kccyd9D0D72LnQyYDQWXZNb8UTm+vB5Yx3LVQXuFnVtuBQyhAdkvtpfqcF/OFW69a5
         Yyap6ObIlJGNxONs9UmzFt4mjfa4LMje4NIsZV6Xv5k2MMPnwR1ojps/nFb9FzbvczJY
         3F9Gj4/7+aUNcwWtoz0EmlekT4+Njep27us0vAy23zuvdjjbeyWpjmIGwR6OZtqp5YbX
         L5IqGu4jOyvE3nOD57foYmLF68299vm1WSymVeUSTOCQ4u+1Ujq15u+TG21IEevz2ng0
         yvayHZ9tzyyUaBlHWodvEUFOF1/BQUZuXXsCK25Zjvd/+Y73q1Q/oBqeVd5JF1rbJq18
         FNkA==
X-Gm-Message-State: AOAM532L47ihq7EWMrR5iUGh7BW6KryotDWZnSIngizWK+Eixlu7K5+L
        t0Aea5Y9aQgOj2/b3KcmebuQpg==
X-Google-Smtp-Source: ABdhPJycpeJaknFiu8qCwXPSbS4EWpvHaQ8bqIXgRertafKBpmQM6c2lUw6WXydvCR67PBwfERyTEg==
X-Received: by 2002:a62:cd46:0:b029:2ea:299c:d7bd with SMTP id o67-20020a62cd460000b02902ea299cd7bdmr2685875pfg.72.1623749084017;
        Tue, 15 Jun 2021 02:24:44 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:325f:b883:4ebe:daf1])
        by smtp.gmail.com with ESMTPSA id r6sm1994978pjm.12.2021.06.15.02.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:24:43 -0700 (PDT)
Date:   Tue, 15 Jun 2021 19:24:32 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fanotify: fix copy_event_to_user() fid error clean up
Message-ID: <YMhx0CceoqRKBz9D@google.com>
References: <1ef8ae9100101eb1a91763c516c2e9a3a3b112bd.1623376346.git.repnop@google.com>
 <CAOQ4uxjHjXbFwWUnVp6cosDzFEE2ZqDwSvH97bU1eWWFvo99kw@mail.gmail.com>
 <20210614102842.GA29751@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614102842.GA29751@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 12:28:42PM +0200, Jan Kara wrote:
> On Fri 11-06-21 10:04:06, Amir Goldstein wrote:
> > On Fri, Jun 11, 2021 at 6:32 AM Matthew Bobrowski <repnop@google.com> wrote:
> > Trick question.
> > There are two LTS kernels where those fixes are relevant 5.4.y and 5.10.y
> > (Patch would be picked up for latest stable anyway)
> > The first Fixes: suggests that the patch should be applied to 5.10+
> > and the second Fixes: suggests that the patch should be applied to 5.4+
> > 
> > In theory, you could have split this to two patches, one auto applied to 5.4+
> > and the other auto applied to +5.10.
> > 
> > In practice, this patch would not auto apply to 5.4.y cleanly even if you
> > split it and also, it's arguably not that critical to worth the effort,
> > so I would keep the first Fixes: tag and drop the second to avoid the
> > noise of the stable bots trying to apply the patch.
> 
> Actually I'd rather keep both Fixes tags. I agree this patch likely won't
> apply for older kernels but it still leaves the information which code is
> being fixed which is still valid and useful. E.g. we have an
> inftrastructure within SUSE that informs us about fixes that could be
> applicable to our released kernels (based on Fixes tags) and we then
> evaluate whether those fixes make sense for us and backport them.
>
> > > Should we also be CC'ing <stable@vger.kernel.org> so this gets backported?
> > >
> > 
> > Yes and no.
> > Actually CC-ing the stable list is not needed, so don't do it.
> > Cc: tag in the commit message is somewhat redundant to Fixes: tag
> > these days, but it doesn't hurt to be explicit about intentions.
> > Specifying:
> >     Cc: <stable@vger.kernel.org> # v5.10+
> > 
> > Could help as a hint in case the Fixes: tags is for an old commit, but
> > you know that the patch would not apply before 5.10 and you think it
> > is not worth the trouble (as in this case).
> 
> I agree that CC to stable is more or less made redundant by the Fixes tag
> these days. I still do use the CC tag for fixes where I think it is really
> important they get pushed to stable or if there's not any particular
> problematic commit that can be added to Fixes tag. But it's more or less
> personal preference these days.

Ah, I see. Thanks for providing your perspectives and sharing your
knowledge.

> Anyway I've added the patch to my tree and will probably send it to Linus
> later this week since the fix is trivial and obvious...

Thanks Jan!

/M
