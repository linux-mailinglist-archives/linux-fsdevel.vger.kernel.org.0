Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D714E922
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 08:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgAaHaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 02:30:14 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44255 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgAaHaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 02:30:14 -0500
Received: by mail-il1-f195.google.com with SMTP id s85so1910829ill.11;
        Thu, 30 Jan 2020 23:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YnwfCsSdf/0WOJ9Oa1E18FRl+xULNznjlib/kMTaDQ=;
        b=RUXZ2BFI2w5nfAf8NsWnbhtyi6CsfSGTgaRu1CmunD0ClEKGCgjxkIk+5bY/IjeEvh
         B0MqFiGvQf/baEfAy71d82Y9IdyVvub7g31VMJpJLFkPKDPjtKyYjZL2PP+RntiXmeyd
         egtbUom4v/JPhQf09C4KBgEeN/9gBiGjQqPgcBSKOyWk+2Y8FtAg+vq8gX1yujeSGMPd
         oqe9Bwo9MXQtNbOD3Wr7due00Rap9h3uGnXrTRhNroQIlaTS9y2xWtMkFxENYyldy+xb
         3elTNf6nO4M5tx6Q7XbgA8dARURMkl2ojxWqEQPKKYM5kROCe6SXbir9GNNSK8q8Eiz1
         /6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YnwfCsSdf/0WOJ9Oa1E18FRl+xULNznjlib/kMTaDQ=;
        b=sr5auI8PZmXUE+y+T2k/U3LsEt8unCQ0FPJU39MvYGi3zkK00sJ5lE/LmbC1+4Fljs
         PB9WKlHEX+YS2CohQ62nSG7CanDeJ5/tf2OhTTr3kGSSp+taFRV9avyEIHBzDLb96Wfl
         Mk7r3xUGxCun84FUDSvJbbVuuBasWRKTKuJ1rudM7VIcgJYvmGfP6AdFzbKcYKZEQegj
         z/9bXu/kFkmwNk0ZYSC/O7EGWJgaBdUbT1HAneRSSmIL4H4aQz++mWxp2UYLtXYbJ5nc
         lp+8d5YA4PwjNUwmmEPqCY990dTWE2kRBmk6lLoBoiA3aPttFY1GcUAQdOpt/dlxfdkZ
         zLHg==
X-Gm-Message-State: APjAAAUZT0q6vzP3BCriCu5Cuv4/TGzX4moM8nNkn1EESaM9lXDOXTCG
        d4VtlLgrtNI+dU/4n7jlzcOMR9GA+6+5c6cNZ1Y=
X-Google-Smtp-Source: APXvYqzQNsxkQvGJwoAOD70agQSWixU8qWteVRXCA6DxikU+KqdlGmwg++FA3wB6CDDpG14QtPJqm98qe3uXrw8nT8k=
X-Received: by 2002:a92:8656:: with SMTP id g83mr1523334ild.9.1580455813505;
 Thu, 30 Jan 2020 23:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20200131052520.GC6869@magnolia>
In-Reply-To: <20200131052520.GC6869@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 31 Jan 2020 09:30:02 +0200
Message-ID: <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 7:25 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> Hi everyone,
>
> I would like to discuss how to improve the process of shepherding code
> into the kernel to make it more enjoyable for maintainers, reviewers,
> and code authors.  Here is a brief summary of how we got here:
>
> Years ago, XFS had one maintainer tending to all four key git repos
> (kernel, userspace, documentation, testing).  Like most subsystems, the
> maintainer did a lot of review and porting code between the kernel and
> userspace, though with help from others.
>
> It turns out that this didn't scale very well, so we split the
> responsibilities into three maintainers.  Like most subsystems, the
> maintainers still did a lot of review and porting work, though with help
> from others.
>
> It turns out that this system doesn't scale very well either.  Even with
> three maintainers sharing access to the git trees and working together
> to get reviews done, mailing list traffic has been trending upwards for
> years, and we still can't keep up.  I fear that many maintainers are
> burning out.  For XFS, the biggest pain point (AFAICT) is not assembly and
> testing of the git trees, but keeping up with the mail and the reviews.
>
> So what do we do about this?  I think we (the XFS project, anyway)
> should increase the amount of organizing in our review process.  For
> large patchsets, I would like to improve informal communication about
> who the author might like to have conduct a review, who might be
> interested in conducting a review, estimates of how much time a reviewer
> has to spend on a patchset, and of course, feedback about how it went.
> This of course is to lay the groundwork for making a case to our bosses
> for growing our community, allocating time for reviews and for growing
> our skills as reviewers.
>

Interesting.

Eryu usually posts a weekly status of xfstests review queue, often with
a call for reviewers, sometimes with specific patch series mentioned.
That helps me as a developer to monitor the status of my own work
and it helps me as a reviewer to put the efforts where the maintainer
needs me the most.

For xfs kernel patches, I can represent the voice of "new blood".
Getting new people to join the review effort is quite a hard barrier.
I have taken a few stabs at doing review for xfs patch series over the
year, but it mostly ends up feeling like it helped me (get to know xfs code
better) more than it helped the maintainer, because the chances of a
new reviewer to catch meaningful bugs are very low and if another reviewer
is going to go over the same patch series, the chances of new reviewer to
catch bugs that novice reviewer will not catch are extremely low.

However, there are quite a few cleanup and refactoring patch series,
especially on the xfs list, where a review from an "outsider" could still
be of value to the xfs community. OTOH, for xfs maintainer, those are
the easy patches to review, so is there a gain in offloading those reviews?

Bottom line - a report of the subsystem review queue status, call for
reviewers and highlighting specific areas in need of review is a good idea.
Developers responding to that report publicly with availability for review,
intention and expected time frame for taking on a review would be helpful
for both maintainers and potential reviewers.

Thanks,
Amir.

> ---
>
> I want to spend the time between right now and whenever this discussion
> happens to make a list of everything that works and that could be made
> better about our development process.
>
> I want to spend five minutes at the start of the discussion to
> acknowledge everyone's feelings around that list that we will have
> compiled.
>
> Then I want to spend the rest of the session breaking up the problems
> into small enough pieces to solve, discussing solutions to those
> problems, and (ideally) pushing towards a consensus on what series of
> small adjustments we can make to arrive at something that works better
> for everyone.
>
> --D
> _______________________________________________
> Lsf-pc mailing list
> Lsf-pc@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
