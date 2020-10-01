Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7763280000
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbgJANXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgJANXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:23:16 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D843C0613E2
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 06:23:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z13so6570691iom.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/D8lflHZl+pyRBpje1AOWjSCE2mWJXJ2ifqvo+4wLgk=;
        b=ca3LwzebSbTf5HaXzI+UdOzzL9tZi2iEmLcIsBJIaYRGbjFU/q2N7g2a8KnwS4ndmM
         hfBJMh6oeXtGrYxhwNSXxEtos8h58buRo8ExSGJbDj/n/nAvWP4o8e9yD3776bIN+arI
         EToQyD18a7RE0SZaLKC8/1yDFdkSn+lXKIFa9JYZFEiDTfQoRmJYLs67i2egKyiqBuzM
         f0xeRj7N8lxxf2/ZJ4YO6apDJu4m58lByPtu0Qx/3mc6QgJ0JbXPcbcr0LvhNbFgC9Pr
         0PiJDMo+1uFyP76yS5x2cp6DD974UtT7PaFAg2a8r8hb0VJTkIFY5HVbvHeV3kVVi9gg
         nRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/D8lflHZl+pyRBpje1AOWjSCE2mWJXJ2ifqvo+4wLgk=;
        b=q152Z/I7D0nNpMJaxgaGQcGGUwK1CU4fSN6TYgDz9G2XGgQ/ASyF+vN9qWvW2h3SkM
         l/RA6/xYlVt+tV74BoFszoCm6g/+ckpPLyEUL5zlU8irKrl3sg0BoI8L3+0AlielHN3J
         /baHMmA8aaSNiAd90Bd5mTROiAs4aMeGlbtVbOsVHo0/fG359IsEdC1D6FnHvx8HPfJ6
         t5gaeYhr7SumLe/+71bm0FsJrPqQEauABOPE6+tkJJobCZ1gtnu0QcaMhQ61hm9vkSfI
         5nYMYvU9IUBr4Sn98mpSx7pkG/U/MGZ2nchVBDTCzJgMAFhEP3ABewCVRrfbcJ8QqOC7
         cQmQ==
X-Gm-Message-State: AOAM533/MfB5QRQ2jlqaXbdLj8dxwH7/rdySgta+E19A+CDVCMYl/9NY
        xTH322xNfNvN2TSjus5YpSP8FqsYSoFfCQu/jdDphvA8BJM=
X-Google-Smtp-Source: ABdhPJzzK0IofL/NnEpXUNzfMkOSJuzyyh6MzRgAvuuEtEweb7GYq6kjTU5jl3t2cpfHP5iWMlUFo6s/lhQF/bFfiDg=
X-Received: by 2002:a02:b606:: with SMTP id h6mr4785500jam.93.1601558595739;
 Thu, 01 Oct 2020 06:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200914172737.GA5011@192.168.3.9> <20200915070841.GF4863@quack2.suse.cz>
 <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com> <20201001110058.GG17860@quack2.suse.cz>
In-Reply-To: <20201001110058.GG17860@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 1 Oct 2020 16:23:04 +0300
Message-ID: <CAOQ4uxgBvdUxM66AG3-1KFhA_KeZxxb=HZKqqRv_0iddDaZ_5A@mail.gmail.com>
Subject: Re: pairing FAN_MOVED_FROM/FAN_MOVED_TO events
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > (*) I got an internal complaint about missing the rename cookie with
> > FAN_REPORT_NAME, so I had to carry a small patch internally.
> > The problem is not that the rename cookie is really needed, but that without
> > the rename cookie, events can be re-ordered across renames and that can
> > generate some non-deterministic event sequences.
> >
> > So I am thinking of keeping the rename cookie in the kernel event just for
> > no-merge indication and then userspace can use object fid to match
> > MOVED_FROM/MOVED_TO events.
>
> Well, the event sequences are always non-deterministic due to event
> merging. So I'm somewhat surprised that rename events particularly matter.
> I suspect the code relying on "determinism" is buggy, it just perhaps
> doesn't manifest in practice for other event types...
>

Maybe I did not explain the issue correctly.

The use case is matching pairs of MOVED_FROM/MOVED_TO events,
regardless of re-ordering with other event types.

In inotify, both those events carry a unique cookie, so they are never merged
with any other event type. The events themselves have the same cookie but
differ in filename, so are not merged.

In vfs code, fsnotify_move() is called under lock_rename() so:
1. Cross-parent MOVED event pairs are fully serialized
2. Same-parent MOVED event pairs are serialized in each parent...
3. ... but may be interleaved with MOVED event pairs in other parents
4. Subsequent MOVED event pairs of the same object are also
    serialized per moved object

The rules above apply to fanotify MOVED events as well, but in fanotify,
because cookie is not stored in event and not participating in merge,
the MOVED_FROM/MOVED_TO events can be merged with other
event types and therefore re-ordered amongst themselves.

Our userspace service needs to be able to match MOVED_FROM/MOVED_TO
event pairs for several reasons and I believe this is quite a common
need.

This need is regardless of re-ordering the MOVED_FROM/MOVED_TO event
pair with other events such as CREATE/DELETE.

To mention a concrete example, if listener can reliably match a MOVED pair
and the DFID/FID object is found locally in the MOVED_TO name, then a remote
command to the backup destination to rename from the MOVED_FROM
name can be attempted.

All we need to do in order to allow for fanotify listeners to use DFID/FID
to match MOVED_FROM/MOVED_TO interleaved event pairs is to
NOT merge MOVED events with other event types if group has all
these flags (FAN_REPORT_DFID_NAME | FAN_REPORT_FID).

IMO, there is not much to lose with this minor change in event merge
condition and there is much to gain.

The documentation is a bit more tricky, but it is generally sufficient
to document that MOVED_FROM/MOVED_TO events on the same
object (FID) are not re-ordered amongst themselves with respective
group flag combination.

Do you agree?

Thanks,
Amir.
