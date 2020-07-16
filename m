Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20CB2223EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 15:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGPNay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPNay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:30:54 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFCAC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 06:30:53 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x9so5058447ila.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3RgPjSCqsR7AqssHdRhZuoRkEExP1RIBw86h+kemhQ=;
        b=Wia1VkNGgw1AUPa7uiiRy8u8Mxmp6ZOm+zrmqAGdN7B+PeGaoy+1/VkzJNGt50Bf/z
         r0VVCs3u5nSzqa/uXZ9Nm66QJBwWN78lqLDfLU3ftCcFSQNyiE6fq44Qsvd8HXOQ6kxC
         GtfgVkzR2wzoIjdKan9EIrqUHSz+oDoFRNqK3ZwOYeNkyBdUsrDOuPOm37YcLf/6eOPT
         iJB8FWAoUfenmKgoG24xh9AT6igLf0ccglDQNnQrhm0pBhZPlEYaKLfcIVZV3FOTJnJQ
         T6tqoO7folErq9t0uIqB8dipp1SexH6TKANWTu8ipmRYMrT3I6lmX0rVv5MQdFAr3wOQ
         eY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3RgPjSCqsR7AqssHdRhZuoRkEExP1RIBw86h+kemhQ=;
        b=K8AE4h0PMbXbT3lRgZNS73OdMMDYPYHQ8gwbJQ2Mx11rejyseXBl7J6pZ5J/bu48J2
         dZRScEs5S1fwRyEARi52UCKicpJAYy3o5HJIGVCCrJR/uAi09W0upAry3D5CzlGHVJfl
         z/FLaW85IQ1/yz0YXFqB+ec/I5cL6YIvru+bkdqPHVay6D1nG1ToEn0EeKe2OVEDYSEZ
         D3HrF+Zf3i1TnygxN2EcIko0dwF9PTC8sFYrc6gwXA8Um6bR4B4S2eK7nNBs0E26Nidt
         1NV7c/Cq7IoYiGOdPBNxGIkqyEnT6bvIdFXOU0XjtC6SEVXmXnsGdubXLM7Xo5YTaJkL
         OwXw==
X-Gm-Message-State: AOAM531FnwQuE+kRKABcGIFgiOZSi1ZjhbmkIwCMAxb8Lh6nhKeNFs/h
        UY9WT99/4t+/0UOuG8Y+UBP3eBN0ywklqPfBQh4=
X-Google-Smtp-Source: ABdhPJwz4B/ekQm6xrEP/0mPzLce4dtPEGspzj5EfBVJRWZZyu0RPRDZ+8iMkcWzbWDmOC+kFTadKliaLk7kGK6gnQM=
X-Received: by 2002:a92:b6d4:: with SMTP id m81mr4704280ill.72.1594906253292;
 Thu, 16 Jul 2020 06:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-11-amir73il@gmail.com>
 <20200716124412.GA5022@quack2.suse.cz>
In-Reply-To: <20200716124412.GA5022@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 16:30:42 +0300
Message-ID: <CAOQ4uxhAO-bwHwh4vK__omwHCcLsD6JmFWCHz6t7VeiqpXDSqA@mail.gmail.com>
Subject: Re: [PATCH v5 10/22] fanotify: no external fh buffer in fanotify_name_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 3:44 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-07-20 11:42:18, Amir Goldstein wrote:
> > The fanotify_fh struct has an inline buffer of size 12 which is enough
> > to store the most common local filesystem file handles (e.g. ext4, xfs).
> > For file handles that do not fit in the inline buffer (e.g. btrfs), an
> > external buffer is allocated to store the file handle.
> >
> > When allocating a variable size fanotify_name_event, there is no point
> > in allocating also an external fh buffer when file handle does not fit
> > in the inline buffer.
> >
> > Check required size for encoding fh, preallocate an event buffer
> > sufficient to contain both file handle and name and store the name after
> > the file handle.
> >
> > At this time, when not reporting name in event, we still allocate
> > the fixed size fanotify_fid_event and an external buffer for large
> > file handles, but fanotify_alloc_name_event() has already been prepared
> > to accept a NULL file_name.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> When reading this, I've got one cleanup idea for later: For FID events, we
> could now easily check fh len in fanotify_alloc_fid_event(). If it fits in
> inline size, allocate the event from kmem cache, if it does not, allocate
> appropriately sized event from kmalloc(). Similarly when freeing event we
> could check fh len to determine how to free the event. This way we can
> completely get rid of the external buffer code, somewhat simplify all
> the fh handling, remove the alignment restrictions on fanotify_fh and
> fanotify_info...
>

OK. Note that the f_handle buffer passed to filesystems is expected to be
aligned anyway, although for encoding it may be less important, see:

cbe7fba8edfc ("ovl: make sure that real fid is 32bit aligned in memory")

Thanks,
Amir.
