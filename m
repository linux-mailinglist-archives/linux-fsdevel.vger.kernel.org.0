Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E6421A65D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 19:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGIR4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 13:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGIR4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:56:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0C2C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 10:56:47 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h16so2763212ilj.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVe8ER7vvA9HGUL5K0lp+ZJGlsH2wRxOQYaCqDBOzMc=;
        b=l/H+P2MtHjTlOFriT/641cHuS7TP6LIDiDhxHUtjXctqTcVqKq1E5Yhz5AmRQo7PhJ
         zJfRF2D2rGUYbxdr5soO2sdlSGwqdQdtkiHjGPQiVivNv79hmZvkIhT/HVLx9n+aQhI0
         z75uceTdQpIkbQrhvcvDMzatO4Hvfv22YkPqZzUpQC7t4vgSHHrPInPNWgKfzI68NZUB
         jAsHT3pE0JFdIFgs+GA51dSNxI30ptQADYrKgzzMebIP+h2TybAEgjxasKBqP14cQ0dB
         YbKssBXJ3F8dlWn8d5VuXgEc/nM1fQ2wDmXEE7EyJ1b2X1aaAO3m09GBvVSu9Xpr7iXe
         GXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVe8ER7vvA9HGUL5K0lp+ZJGlsH2wRxOQYaCqDBOzMc=;
        b=FTk4/DbK7WYH4tV3NS025K9hcy3iwW88GqxwHpKjA63+B3HbERZ8gKEN33/4gPaPd8
         3tDJ7/+GOziqTgrdlKbLxalBocQvEviltxQqMasDaYwt+BqQsdmawVXR83Q1pHTiezgh
         LbvYL/QZfxeKVk1EHxB+tQS/xiqdN79KmP5njMe+bu7g0t7ARSxLkQnya53J85OlCT+u
         i0N5xsDLNGugBXMQxUMD7m+jtvz3PI+gBdEkU8IQi+LpnWHcn+itwxelDAujkLnB6GC6
         ClKFSPYkyBjjlNiLHsBXPSCuJ1bXAhC72h7Lcbbn2IK34Fe2IRU8AERi/qORF6o2xIv5
         LKjg==
X-Gm-Message-State: AOAM530+BJXZca42rprY4exj+TBJq8QXiD6alDFsdyZXZX0pMLEf8CKD
        0FbZ7DX/EUHVJx7r7rbrcSwVbT1X/G7GlU097zJKqRYo
X-Google-Smtp-Source: ABdhPJzXY1CO4pM7pXtk3tUd9CkbR4Ea/XHa8zE4N61/GJEd7gDJH8Gykn+GQhUP1n10f6b+FbHMGQC3P+VinwC1Ktw=
X-Received: by 2002:a92:490d:: with SMTP id w13mr28446368ila.250.1594317406562;
 Thu, 09 Jul 2020 10:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200612093343.5669-1-amir73il@gmail.com> <20200612093343.5669-2-amir73il@gmail.com>
 <20200703140342.GD21364@quack2.suse.cz> <CAOQ4uxgJkmSgt6nSO3C4y2Mc=T92ky5K5eis0f1Ofr-wDq7Wrw@mail.gmail.com>
 <20200706110526.GA3913@quack2.suse.cz>
In-Reply-To: <20200706110526.GA3913@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 Jul 2020 20:56:35 +0300
Message-ID: <CAOQ4uxi5Zpp7rCKdOkdw9Nkd=uGC-K2AuLqOFc0WQc_CgJQP2Q@mail.gmail.com>
Subject: Re: fsnotify: minimise overhead when there are no marks with ignore mask
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > Otherwise the patch looks good. One observation though: The (mask &
> > > FS_MODIFY) check means that all vfs_write() calls end up going through the
> > > "slower" path iterating all mark types and checking whether there are marks
> > > anyway. That could be relatively simply optimized using a hidden mask flag
> > > like FS_ALWAYS_RECEIVE_MODIFY which would be set when there's some mark
> > > needing special handling of FS_MODIFY... Not sure if we care enough at this
> > > point...
> >
> > Yeh that sounds low hanging.
> > Actually, I Don't think we need to define a flag for that.
> > __fsnotify_recalc_mask() can add FS_MODIFY to the object's mask if needed.
>
> Yes, that would be even more elegant.
>
> > I will take a look at that as part of FS_PRE_MODIFY work.
> > But in general, we should fight the urge to optimize theoretic
> > performance issues...
>
> Agreed. I just suspect this may bring measurable benefit for hackbench pipe
> or tiny tmpfs writes after seeing Mel's results. But as I wrote this is a
> separate idea and without some numbers confirming my suspicion I don't
> think the complication is worth it so I don't want you to burn time on this
> unless you're really interested :).
>

You know me ;-)
FS_MODIFY optimization pushed to fsnotify_pre_modify branch.
Only tested that LTP tests pass.

Note that this is only expected to improve performance in case there *are*
marks, but not marks with ignore mask, because there is an earlier
optimization in fsnotify() for the no marks case.

Sorry for bombarding you with more patches (I should let you finish with
fanotify_prep and fanotify_name_fid), but if you get a chance and can
take a quick look at these 2 patches on fsnotify_pre_modify branch:
1. fsnotify: replace igrab() with ihold() on attach connector
2. fsnotify: allow adding an inode mark without pinning inode

They are very small and simple, but I am afraid I may be missing something.

Why did we use igrab() there in the first place? Is there a reason or is it
relic from old code?

As for the second patch, I won't get into why I need the evictable inode
marks right now, but I was wondering if there was some inherent reason
that I am missing why that cannot be done and inodes *have* to be pinned
if you attach a mark to them (besides functionality of course)?

Thanks,
Amir.
