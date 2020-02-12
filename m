Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 316ED15A2ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgBLIJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:09:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40145 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgBLIJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:09:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so1006527wru.7;
        Wed, 12 Feb 2020 00:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mWNR8NSNpO0Bl2CKSRCvCBTWEWrxN6txmVC2QQsJvlA=;
        b=nQQoFjqhZGz2y/YBr+MqQtgdOgTNLZ9qqfOGfCdZ6/Az340eyQOlci2sVCJJIxPEOG
         xpIOqZzL3XaTT/yYOmvw0+13WHFx2tukYWPg7dN6VH/YT9TEw6sTkAiRjl9lnP+2gs1z
         ETku8OAl4pw0pbA11i5kISmCJjOHa0mVOqIgiAinXmwnk38+TEfauf2Rq9vdzVn+73vh
         gJXvmPDZY3c4XgyMRdTzJ9v9KUUtuBh+vjywCdluxQVUJREbFlZlavD/EMYczAgXyVoD
         n7PJuXXJGcxd2l+eA0DiZbmDhSuMICyWO/F2RMG+iUXhmqfp+jIf2E0+QfgkRIRDLJfq
         uULw==
X-Gm-Message-State: APjAAAVdkmWl57sgOzFagQmU+WTOfU0qmLU43i88J7Y5/x/hCXthaJHe
        JsTrMSbl94DoaBdOVjqfEgY=
X-Google-Smtp-Source: APXvYqxTXKnfx3FFH0goWGtL6x0SsQ17kWIazgeliJhAHrEul9Tz4kkhx2jJG3D6HaU43bOvI0ZwWw==
X-Received: by 2002:a5d:670a:: with SMTP id o10mr13711467wru.227.1581494987979;
        Wed, 12 Feb 2020 00:09:47 -0800 (PST)
Received: from localhost (ip-37-188-227-72.eurotel.cz. [37.188.227.72])
        by smtp.gmail.com with ESMTPSA id t13sm8590070wrw.19.2020.02.12.00.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 00:09:47 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:09:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200212080945.GA11353@dhcp22.suse.cz>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 11-02-20 16:28:39, Linus Torvalds wrote:
> On Tue, Feb 11, 2020 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Testing this will be a challenge, but the issue was real - a 7GB
> > highmem machine isn't crazy and I expect the inode has become larger
> > since those days.
> 
> Hmm. I would say that in the intening years a 7GB highmem machine has
> indeed become crazy.

Absolutely agreed.

> It used to be something we kind of supported.

And it's been few years since we have been actively discouraging people
from using 32b kernels with a lot of memory. There are bug reports
popping out from time to time but I do not remember any case where using
64b kernel would be a no-go. So my strong suspicion is that people
simply keep their kernels on 32b without a good reason because it tends
to work most of the time until they hit one of the lowmem problems and
they move over to 64b.

> But we really should consider HIGHMEM to be something that is on the
> deprecation list. In this day and age, there is no excuse for running
> a 32-bit kernel with lots of physical memory.
> 
> And if you really want to do that, and have some legacy hardware with
> a legacy use case, maybe you should be using a legacy kernel.
> 
> I'd personally be perfectly happy to start removing HIGHMEM support again.

I wouldn't be opposed at all.
-- 
Michal Hocko
SUSE Labs
