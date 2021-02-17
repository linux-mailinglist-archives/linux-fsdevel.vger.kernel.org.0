Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3865131D7B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBQKxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 05:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBQKxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:53:13 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E0AC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 02:52:33 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id f6so13336659ioz.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 02:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vw2/bBvvtXX6voBKbU5wuY6cTPGAys2sIZs4FZg4xk0=;
        b=kYAY4tEA51yavcsAffdnzD4YlP0wz4+tgAuWbYfvP7cWuhfbYz8FVVGk1ZtKvzJxiH
         LDEOepWGGq0h1FpjN2IZIJlVJg8C7srVaatBuPE6lT6cBOGIOxciqB33VwDu+xTDIhNZ
         3OgV3uXutJ6CmHIJxloPSeRntZZhYsV9r58baxDsOm0QchkhNsN/x1f8HLjW2t8MX7i1
         Bz4oDPGctjqw9n+QraGO893wjoE4SBTI4PDEOEnt04vbk5ay1tYuUqnD+1E3GTm6jzG4
         OX7rPftdkcaA5hBTF5TTrhdkVYrCjhT/SkLXd9vy9xzj2CkVBbywtd3It1/jZQH4uBa4
         svjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vw2/bBvvtXX6voBKbU5wuY6cTPGAys2sIZs4FZg4xk0=;
        b=Cmsl2UbXc03UPseB8RnXVvWqLc/YLsSaMxRlEYtabPtbQnn1V0beRq+mBntQfcuNYb
         0zbgIVC0BrOW2PNAZ+aDHaFAF97GeEIYTCARRXxnkpK0nPiW/4voBO/VgzCs0R+x57uG
         OvPV7ZmsUdyA8Rmf9u+MtoEN473unHjf5WhlfVXsFMGOPWFTMpFutGSLxY8wFMP8Daie
         2gEEj/ptdFnS93lDbIfn514Trq0Fv2ZFfnyub4hcYK0R1LBURymwddjiT5b1dqcC3nPE
         lrAuOxgfirecZyYR6AIRNKaWnFvD1axmgG5MWBaj9KcxTBW6weWXoUWVOk+M4jzdV1cN
         v0Nw==
X-Gm-Message-State: AOAM5304XgXLhU0s1tp0LYIcWVPRJ1AnjmgG0VIaZhW6nxFwBmEPDWWo
        4PODc5sdqYSVR7wmaPx8y56oJyM7Mb+M8Qff42i5EGf/eW4=
X-Google-Smtp-Source: ABdhPJx/gqnDZAQBSwrMpJ+yoV0kL6yssf4kw92xmbDzlSO+ClFG34maWG/nwCEMcuQpub1iy5eNFzPtg2TSLf04Sc0=
X-Received: by 2002:a02:660b:: with SMTP id k11mr24591902jac.120.1613559152854;
 Wed, 17 Feb 2021 02:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210216160258.GE21108@quack2.suse.cz>
In-Reply-To: <20210216160258.GE21108@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Feb 2021 12:52:21 +0200
Message-ID: <CAOQ4uxi7NdNQOpGResWEtRDPv+yGSTkMY99tVDVv2mkOW3g97w@mail.gmail.com>
Subject: Re: [PATCH 0/7] Performance improvement for fanotify merge
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 6:02 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> Looking at the patches I've got one idea:
>
> Currently you have fsnotify_event like:
>
> struct fsnotify_event {
>         struct list_head list;
>         unsigned int key;
>         unsigned int next_bucket;
> };
>
> And 'list' is used for hashed queue list, next_bucket is used to simulate
> single queue out of all the individual lists. The option I'm considering
> is:
>
> struct fsnotify_event {
>         struct list_head list;
>         struct fsnotify_event *hash_next;
>         unsigned int key;
> };
>
> So 'list' would stay to be used for the single queue of events like it was
> before your patches. 'hash_next' would be used for list of events in the
> hash chain. The advantage of this scheme would be somewhat more obvious
> handling,

I can agree to that.

> also we can handle removal of permission events (they won't be
> hashed so there's no risk of breaking hash-chain in the middle, removal
> from global queue is easy as currently).

Ok. but I do not really see a value in hashing non-permission events
for high priority groups, so this is not a strong argument.

> The disadvantage is increase of
> event size by one pointer on 64-bit but I think we can live with that. What
> do you think?

Given the round size of fixes size events in v5.10, that would be a shame:

ls -l /sys/kernel/slab/*notify*event
lrwxrwxrwx 1 root root 0 Feb 17 12:23
/sys/kernel/slab/fanotify_fid_event -> :0000064
lrwxrwxrwx 1 root root 0 Feb 17 12:23
/sys/kernel/slab/fanotify_path_event -> :0000056
lrwxrwxrwx 1 root root 0 Feb 17 12:23
/sys/kernel/slab/fanotify_perm_event -> :0000064

Counter proposal:

struct fsnotify_event {
        struct list_head list;
        struct fsnotify_event *hash_next;
        unsigned int key;
        u32 mask;
};

It is quite strange that mask is a member of struct fanotify_event and
struct inotify_event_info to begin with.

Moving the mask member to struct fsnotify_event like that is not going
to change the resulting inotify/fanotify event size.

We can actually squeeze fanotify_event_type into 2 low bits of pid
pointer, and reduce the size of all fanotify events by one pointer,
because FANOTIFY_EVENT_TYPE_OVERFLOW is nice to have.
The overflow event can use FANOTIFY_EVENT_TYPE_PATH with a
NULL path values (as early versions of the patch did).

This is not worth doing with current round event size, IMO.

Thanks,
Amir.
