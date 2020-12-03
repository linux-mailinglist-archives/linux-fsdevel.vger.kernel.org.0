Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0A2CD417
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 11:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgLCK5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 05:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgLCK5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:57:23 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8B2C061A4D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 02:56:43 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id z10so1491437ilu.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 02:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VO1+HIDMOglaM0TEalKNTQqT3BrHdbC2kLeLU8zkB50=;
        b=gP5ZY3dLt22p+MaYX8ofkvydjzzLSHX5KD++w+lZZd7RRvQJbM3udEXqSyyqToBh0U
         vpugdBjWX4ZYSsVCAxvTnqXdO+Zw+GTgfLT9e6xWsTenHHqhWEwU+yy1GkBroIamInFf
         Fcq3xNGdiQ673EAxHjiJkqzdS4w+Blz1RG2MQ3sZIZWda7Boclahys7bah7oo/r78KiC
         DKJ1g9bRfNRklk2Q2eAuKU6jwzN17HZ/CeQGHdyGPDrO/E1uFFLSGMfRRozUsAQ/8l5c
         Hz2l3rzhFeOcxWoCo70Y3Wsrlss5uIkzVylWW4ae2lZlL++YGLmoy7RcCKWKsNh4o/l8
         gVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VO1+HIDMOglaM0TEalKNTQqT3BrHdbC2kLeLU8zkB50=;
        b=U4NTyVmWXuFE4xgJBIQ0jbZXvj/N5rtjcq1QpuKgkkDnnoBa0QA+201I4pTlrYgZD0
         Sy9rfX+/hPG+xSdFK4yye/346+M26pB2BJFmXoD1bKwT/u4M9UcPtF7FNG8LRI6mvtmQ
         NTrWBEsDXy13GdFXZLeaiuciVVomdZEMGp36q1lKh7IcKOilkHkWS/zrIXdYdM6f766J
         7Tvx9Jc/TSvBxYBJtLZWuZZ9NYoSho4pP2Q0OSqMMtkb7KUnuxnbtMxLB6YQ6UllZOac
         UFnMv/RrS3wp4VJR9HVrQUGEBIP6rLPkrZoXYeer9UOe17EqKtZLkSHrdlOdbd/tjkax
         5h9w==
X-Gm-Message-State: AOAM531MEnbaZpxS8zzmJY3zvy0mSi3N3JrydFf8qTHFTcVY7qI3WRJi
        xBEwrOJa613yI7NTaggV+5UXuWXTsGjq8yb3upY=
X-Google-Smtp-Source: ABdhPJwxiF8LFoAow+GIBFxt3rHsYlFC4HqKEPqB4UQUZRU7freqh2sCEBhoc6jKG+oYVx9HP4ANfer5pwxJY+uapFI=
X-Received: by 2002:a92:5e42:: with SMTP id s63mr2468847ilb.250.1606993002676;
 Thu, 03 Dec 2020 02:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20201202120713.702387-1-amir73il@gmail.com> <20201202120713.702387-8-amir73il@gmail.com>
 <20201203103522.GC11854@quack2.suse.cz>
In-Reply-To: <20201203103522.GC11854@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Dec 2020 12:56:31 +0200
Message-ID: <CAOQ4uxgGPQEDZY-W3yW7W7HhfCNbFq3SHLQc_HMN5ZQoNPNm2w@mail.gmail.com>
Subject: Re: [PATCH 7/7] fsnotify: optimize merging of marks with no ignored masks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 3, 2020 at 12:35 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 02-12-20 14:07:13, Amir Goldstein wrote:
> > fsnotify() tries to merge marks on all object types (sb, mount, inode)
> > even if the object's mask shows no interest in the specific event type.
> >
> > This is done for the case that the object has marks with the event type
> > in their ignored mask, but the common case is that an object does not
> > have any marks with ignored mask.
> >
> > Set a bit in object's fsnotify mask during fsnotify_recalc_mask() to
> > indicate the existence of any marks with ignored masks.
> >
> > Instead of merging marks of all object types, only merge marks from
> > objects that either showed interest in the specific event type or have
> > any marks with ignored mask.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> The idea looks sound to me and the patch fine (besides one bug noted
> below). I'd be interested if an actual performance impact of this and
> previous change could be noticed. Maybe some careful microbenchmark could
> reveal it...

Yeh, as I wrote in the cover letter. I don't know what to do with this.
By all accounts we should not merge unless we can prove benefit.

The reason I brought this back is I was thinking of a way to avoid
having to look up subtree marks on ancestors if sb had no subtree marks
that are interested in the event (or have an ignored mask).

So the benefit may become apparent when we add subtree marks
and then there is no harm to keep the same logic for other mark types.

>
> > +     /*
> > +      * Consider only marks that care about this type of event and marks with
> > +      * an ignored mask.
> > +      */
> > +     test_mask |= FS_HAS_IGNORED_MASK;
> > +     if (test_mask && sb->s_fsnotify_mask) {
>                       ^^ Just '&' here.
>

Heh! oops :)

Thanks,
Amir.
