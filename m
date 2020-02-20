Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A891669DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgBTVa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 16:30:56 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33663 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgBTVaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:30:55 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so94393ioh.0;
        Thu, 20 Feb 2020 13:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbAVtHmxkPYTFEqIzqUxUT4jjajs4dhBUAXZ7917FMM=;
        b=spnIzN1lczTskeCoM0VtvCL48OYjGv3fiaDwGz/cpccqFQoypntUQFceuRc6Pkpukv
         MSH1dpjQd/oN6GXkXb3OnrVlKxtGYX3IyWyrshxqpoZhcGIywUO3jv6KpmGbGy64nhwq
         OFs/Po45yEDLpUiG4439frxSNtXCHbghQ4cX47VxvuCZrSewYu+KEDQQJQmIo+Np5joS
         MHlDdDD4D80X1+/SgjGR0AEFa03FwwN5loplEyqdjUhUpgm7b0TaEDgaVaK3wIU2Z/kw
         7czyXm42cH2puCkrecsmRtHrXQpuyK2NChFLPdwFH2jCu7YYsDHqhCWJW5F6bciGHeUm
         FYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbAVtHmxkPYTFEqIzqUxUT4jjajs4dhBUAXZ7917FMM=;
        b=SlVdsnKSp2npDxFHbMVhKUxURS5j3mdDKw1y395oamrWEKpEe2+6sD71UXYQc8Y3tO
         aLk4+0a3BxWqZQl0VtdCnDn9CQXL5kcZAFY1A8hmrAxMNwoJ53ShM48g9ZhpAoc216WU
         O81/i1qIfuUDg0SlnFwXpirHJ/bihN9UqIMVzMHrUfN3f2dU64lcpCtMel0b26GA4r08
         j7Sc/IMo+OF+5R4viRgxamSdKrwxxP3mLJu6T9Azks1J+PfkLXDdRrM3Hmnts6sRs21T
         jh9XG+SBPb3T0wVIsEFlbgdoeCDA39M12oHK8udCO9OHPbUHX/JaM2wUhDkE0eH+zxIZ
         xGQw==
X-Gm-Message-State: APjAAAW8bxic4Yrb7qS2zl4Riw5bWrft7KyEbRFlWrM0oilc+70piqse
        cB14q87K5m6VcN1zSPB3CLS6bN+SALJq9HTEgTx4Ew==
X-Google-Smtp-Source: APXvYqw40LKIf/2R8xKZVZ4VXY6+pk6Cp7e8t1q0/vnMTGx8q7LxEVOIuXKXjVaM+N29QJgHnu73cU9jxhVNGHpz940=
X-Received: by 2002:a5d:9419:: with SMTP id v25mr26035700ion.3.1582234253502;
 Thu, 20 Feb 2020 13:30:53 -0800 (PST)
MIME-Version: 1.0
References: <e88c2f96-fdbb-efb5-d7e2-94bfefbe8bfa@oracle.com> <20200214044242.GI6870@magnolia>
In-Reply-To: <20200214044242.GI6870@magnolia>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 20 Feb 2020 15:30:42 -0600
Message-ID: <CAH2r5mvGHbibnxzERepYqbG0+yacD+pfLanBz52j16WkNm6-1g@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Atomic Writes
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The idea of using O_TMPFILE is interesting ... but opening an
O_TMPFILE is awkward for network file systems because it is not an
atomic operation either ... (create/close then open)

On Thu, Feb 13, 2020 at 10:43 PM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Thu, Feb 13, 2020 at 03:33:08PM -0700, Allison Collins wrote:
> > Hi all,
> >
> > I know there's a lot of discussion on the list right now, but I'd like to
> > get this out before too much time gets away.  I would like to propose the
> > topic of atomic writes.  I realize the topic has been discussed before, but
> > I have not found much activity for it recently so perhaps we can revisit it.
> > We do have a customer who may have an interest, so I would like to discuss
> > the current state of things, and how we can move forward.  If efforts are in
> > progress, and if not, what have we learned from the attempt.
> >
> > I also understand there are multiple ways to solve this problem that people
> > may have opinions on.  I've noticed some older patch sets trying to use a
> > flag to control when dirty pages are flushed, though I think our customer
> > would like to see a hardware solution via NVMe devices.  So I would like to
> > see if others have similar interests as well and what their thoughts may be.
> > Thanks everyone!
>
> Hmmm well there are a number of different ways one could do this--
>
> 1) Userspace allocates an O_TMPFILE file, clones all the file data to
> it, makes whatever changes it wants (thus invoking COW writes), and then
> calls some ioctl to swap the differing extent maps atomically.  For XFS
> we have most of those pieces, but we'd have to add a log intent item to
> track the progress of the remap so that we can complete the remap if the
> system goes down.  This has potentially the best flexibility (multiple
> processes can coordinate to stage multiple updates to non-overlapping
> ranges of the file) but is also a nice foot bazooka.
>
> 2) Set O_ATOMIC on the file, ensure that all writes are staged via COW,
> and defer the cow remap step until we hit the synchronization point.
> When that happens, we persist the new mappings somewhere (e.g. well
> beyond all possible EOF in the XFS case) and then start an atomic remap
> operation to move the new blocks into place in the file.  (XFS would
> still have to add a new log intent item here to finish the remapping if
> the system goes down.)  Less foot bazooka but leaves lingering questions
> like what do you do if multiple processes want to run their own atomic
> updates?
>
> (Note that I think you have some sort of higher level progress tracking
> of the remap operation because we can't leave a torn write just because
> the computer crashed.)
>
> 3) Magic pwritev2 API that lets userspace talk directly to hardware
> atomic writes, though I don't know how userspace discovers what the
> hardware limits are.   I'm assuming the usual sysfs knobs?
>
> Note that #1 and #2 are done entirely in software, which makes them less
> performant but OTOH there's effectively no limit (besides available
> physical space) on how much data or how many non-contiguous extents we
> can stage and commit.
>
> --D
>
> > Allison



-- 
Thanks,

Steve
