Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802CC31EA1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhBRM5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhBRK5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:57:10 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80333C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 02:56:29 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q7so1557686iob.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 02:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XmqErG87BCaoECguo9Z73jNLK5xk3zVFIwU7QIQyB8=;
        b=N0Ra09qPd9+fS9oPJRvRbgXadFj6nzcJBaHJ06OD9dvKGskL6pgH9pePALeyM3viGE
         IrJ2Qxj5jyXXqwr5nYH4akNN73yc2XEwZYUyOztSNddz472LcROl3ICeceDAczCNVMMl
         +OY3oBBU4zAfAWHvwLG0MwcCgoTtQMkkvUGkm1dHRS2XW/efI/3+xbPka4o31Q35yJ/1
         on9DGeB0uemLEJW23G8ReHFxtvDNx5IcCIS9NwWhqyz31R3bN01dQHU8/lpVdSTKvrtg
         w95FIlLYRqqirzekibUfpzy86uGUU77NSkCNP7CLHHG2PcbLCJZU5l6xZFEg//d4A0f8
         cIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XmqErG87BCaoECguo9Z73jNLK5xk3zVFIwU7QIQyB8=;
        b=tc9fVh8Z/aij0JSYhzdsPXJCiGX9XCUuIyt6g5T8mqbU2Rr/AVmnvSzwqiAPr3Zd1v
         0mcdMD1u5MmIIOQM2BMCXY5zsX7w10wk06Bddpcn6rCbjqqATBFtuPjc6esNUgapKyHn
         aw5r9VZcXLMmsXZwwEwf72VsZnnW3XN6GhHpOuz4UxyyuH9smg9omyK3Z5eZSdN8Qicn
         j3o3m4bUfH3L1EEwjlmeC3Mhwdibz1XMlF9flmbBwxyRNp9F+UC4vkmLIN4INQSIELFJ
         zkknwlChwwx5Y2PhwH4XNdeVPAguzPBoGC9z3WmmGowhJo2Pca1cjE69zKmIWwtW+F9o
         yx2w==
X-Gm-Message-State: AOAM530lmzSdsveLKz5KitmRbuW3hewjb9ZaVo58mwdyuxiRF4K7f7vl
        Ci65uXBJrGUi8p6krnn7F6+RxAA3aAiBc0vQDRcvPZZC
X-Google-Smtp-Source: ABdhPJzegA+1aysadcYOMkyvRTl4SVguGDiwX4F6S4y7HNbk6G6W/8ul2Ogd0OsYHtlHVZocsUglvdUqRejHrfOEQ/Y=
X-Received: by 2002:a05:6638:3491:: with SMTP id t17mr3853587jal.81.1613645788911;
 Thu, 18 Feb 2021 02:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210216160258.GE21108@quack2.suse.cz>
 <CAOQ4uxi7NdNQOpGResWEtRDPv+yGSTkMY99tVDVv2mkOW3g97w@mail.gmail.com> <20210217112539.GC14758@quack2.suse.cz>
In-Reply-To: <20210217112539.GC14758@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 12:56:18 +0200
Message-ID: <CAOQ4uxiEuWaw1VKwJvp5V-_dN=MZNXWro4q8OnO8qhN-r7dLhA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Performance improvement for fanotify merge
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 1:25 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 17-02-21 12:52:21, Amir Goldstein wrote:
> > On Tue, Feb 16, 2021 at 6:02 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hi Amir!
> > >
> > > Looking at the patches I've got one idea:
> > >
> > > Currently you have fsnotify_event like:
> > >
> > > struct fsnotify_event {
> > >         struct list_head list;
> > >         unsigned int key;
> > >         unsigned int next_bucket;
> > > };
> > >
> > > And 'list' is used for hashed queue list, next_bucket is used to simulate
> > > single queue out of all the individual lists. The option I'm considering
> > > is:
> > >
> > > struct fsnotify_event {
> > >         struct list_head list;
> > >         struct fsnotify_event *hash_next;
> > >         unsigned int key;
> > > };
> > >
> > > So 'list' would stay to be used for the single queue of events like it was
> > > before your patches. 'hash_next' would be used for list of events in the
> > > hash chain. The advantage of this scheme would be somewhat more obvious
> > > handling,
> >
> > I can agree to that.
> >
> > > also we can handle removal of permission events (they won't be
> > > hashed so there's no risk of breaking hash-chain in the middle, removal
> > > from global queue is easy as currently).
> >
> > Ok. but I do not really see a value in hashing non-permission events
> > for high priority groups, so this is not a strong argument.
>
> The reason why I thought it is somewhat beneficial is that someone might be
> using higher priority fanotify group just for watching non-permission
> events because so far the group priority makes little difference. And
> conceptually it isn't obvious (from userspace POV) why higher priority
> groups should be merging events less efficiently...
>

So I implemented your suggestion with ->next_event, but it did not
end up with being able to remove from the middle of the queue.
The thing is we know that permission events are on list #0, but what
we need to find out when removing a permission event is the previous
event in timeline order and we do not have that information.
So I stayed with hashed queue only for group priority 0.

Pushed partly tested result to fanotify_merge branch.

Will post after testing unless you have reservations.

Thanks,
Amir.
