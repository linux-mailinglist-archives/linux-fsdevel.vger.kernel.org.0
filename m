Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1B239CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfETOXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:23:05 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:37162 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391389AbfETOXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:23:02 -0400
Received: by mail-it1-f179.google.com with SMTP id m140so23416113itg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2019 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0Kqm8HB2SZREAVefB0vZSaHlhpgNLQcW4vJyF9ZMts=;
        b=eK2Z6iJSkhxfKN3UmHd3EZ3IwxzqbPNlGHHp2DsBYySQTuUsQ67o6FTWpHsb3nXuAs
         a6C3nhu3sbbWHyqC9KbYjiSVlN0VTW23iU59tfotR4ps1o+Wmk74X6rMU1OY8aNBUdTR
         junZ72Dpxtot7TOImIjxdnVEPA7djpvt0L0MyoePVzVSyWj5OV4dM+G3JfA630Xgu3pf
         CLLKWx3OtpDFv9I/PT3kS36qONjh577/3s2fAK3ShLE8S37LdF+0a+HVmU//ixEZbZba
         ZIBQQ0geigJcDh1hduDj5cbMwL8lRPPcDf/hYrrw0PI58vI5x20jF920c2TfNCdC3L1I
         Ggdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0Kqm8HB2SZREAVefB0vZSaHlhpgNLQcW4vJyF9ZMts=;
        b=cQIZ5BgTa2bZJNAhxMykJtefgKmV1fmkwbW9h9qBEncVkstqHd8mqRR6lZvUQ7+gwN
         GIH4tg2ix2dMo9+M+dCpfcOOP9udUI8iXecNgoYSaSCbL+uvMWHQR/fKoCLxVSDOqRs+
         uhTeBoxxddPHfsg1pa+mEbbFYPQrcK7fAE1um8X5a5TF5t0XFR3Kj4e1kWHvhylhpnwr
         jBCzTY4ca2F/spLFpI9vPAzIlER4L0QavEzBsGgy//jGKBrRtPr7K1XiUMRkGPUVdbK8
         ELUcwMeE1MQWLQOR2q+HnuUcGUXeRFqtL2sf0TBpxPpn1v9E6RHNQZDq/2HTaOABHjMA
         1vOw==
X-Gm-Message-State: APjAAAVZKLBW8Zz3xyoV55PY7m+28oK4piSdIEtrJJTnGkHIdPf+IuyK
        HJegMz16d4DFh33OeIOvhN+RD3CaHrLjV61/jRwpxQ==
X-Google-Smtp-Source: APXvYqweHXZFITZ7oe8aBiFG5/EEV503tizKK5vDGcZFP5+/2L5mXSraxtFpCFg5PoNkyduGG3h40YybZwy3dg0KJRY=
X-Received: by 2002:a24:91d2:: with SMTP id i201mr14418445ite.88.1558362181158;
 Mon, 20 May 2019 07:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014285d05765bf72a@google.com> <0000000000000eaf23058912af14@google.com>
 <20190517134850.GG17978@ZenIV.linux.org.uk> <CACT4Y+Z8760uYQP0jKgJmVC5sstqTv9pE6K6YjK_feeK6-Obfg@mail.gmail.com>
 <CACT4Y+bQ+zW_9a3F4jY0xcAn_Hdk5yAwX2K3E38z9fttbF0SJA@mail.gmail.com>
 <20190518162142.GH17978@ZenIV.linux.org.uk> <20190518201843.GD14277@mit.edu> <20190518214148.GI17978@ZenIV.linux.org.uk>
In-Reply-To: <20190518214148.GI17978@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 May 2019 16:22:49 +0200
Message-ID: <CACT4Y+bTeyQi-0QR5XzWjmOpj8VqKh8DoLtxmhd7+hUPqArgbQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabin.rapan@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 18, 2019 at 11:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > What would you prefer to happen in such situations?  Commit summaries
> > > modified enough to confuse CI tools into *NOT* noticing that those
> > > are versions of the same patch?  Some kind of metadata telling the
> > > same tools that such-and-such commits got folded in (and they might
> > > have been split in process, with parts folded into different spots
> > > in the series, at that)?
> > >
> > > Because "never fold in, never reorder, just accumulate patches in
> > > the end of the series" is not going to fly.  For a lot of reasons.
> >
> > As far as I'm concerned, this is the tools problem; I don't think it's
> > worth it for developers to feel they need to twist themselves into
> > knots just to try to make the CI tools' life easier.
>
> FWIW, what _is_ the underlying problem?  It looks like the basic issue
> is with rebase/cherry-pick of a commit; it seems to be trying to
> handle two things:
>         1) report X' in commit C' is similar to report X in commit C,
> with C' apparently being a rebase/cherry-pick/whatnot of C; don't
> want to lose that information
>         2) reports X, Y and Z in commit C don't seem to be reoccuring
> on the current tree, without any claimed fix in it.  Want to keep
> an eye on those.
>
> ... and getting screwed by a mix of those two: reports X, Y and Z in
> commit C don't seem to be reoccuring on the current tree, even though
> it does contain a commit C' that seems to be a rebase of C.  A fix for
> C is *not* present as an identifiable commit in the current tree.
> Was it lost or was it renamed/merged with other commits/replaced by
> another fix?
>
> What I don't quite understand is why does the tool care.  Suppose
> we have a buggy commit + clearly marked fix.  And see a report
> very similar to the original ones, on the tree with alleged fix
> clearly present.  IME the earlier reports are often quite relevant -
> the fix might have been incomplete/racy/etc., and in that case
> the old reports (*AND* pointer to the commit that was supposed to
> have fixed those) are very useful.
>
> What's the problem these reminders are trying to solve?  Computational
> resources eaten by comparisons?

syzbot, as any bug tracking system has notion of "open" and "closed"
bugs. This is useful for 2 main reasons:
 - being able to see what are the currently open bugs (on our plate)
to not go over already closed bugs again and again and to not lose
still relevant bugs (for upstream linux
https://syzkaller.appspot.com/upstream#open)
 - to be able to understand when a new similarly looking crash is
actually a new bug (either not completely fixed old one, or completely
new does not matter much) and report it again (because it's not a good
idea to send an email for every crash as is (hundreds of thousands a
day))

In order to do this tracking syzbot needs the association between
reports and fixing commits. Merely saying "it's fixed" is not enough
because consider you say "it's fixed", but it's fixed only in mm, but
not in net-next. So next second syzbot sees this crash again in
net-next and sends a new bug report as it now thinks the old one is
fixed, so this must be a new one. Only the commit allows it to
precisely understand when the fix is in all trees, and not just in all
trees but in all currently tested builds for these trees.

Above you say "on the tree with alleged fix clearly present". To
understand that syzbot needs to know the commit.
