Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F17ABE21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 08:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjIWGgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 02:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWGge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 02:36:34 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B25199;
        Fri, 22 Sep 2023 23:36:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3adcec86a8cso1957311b6e.3;
        Fri, 22 Sep 2023 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695450987; x=1696055787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2gpg7YRP4E+XAUJHrlXeLmjFlOQEtcIKaK+DMVYN/I=;
        b=VFJCqQ5nGm7ukXcnRWL3QZ/Myw1jpfbOp7VdG/YgR/xvvMqTxH4BpVcQVVLoDX5073
         gj0R5k8FhojWNMplF+Uoaames06vLuiqqIjT0TYix8rkrbksJpjuCJJNzhFLo4jZpzku
         BBSRmQLSFV6RRS/onTaDiXCY5xYP1dGbeOTpf7KVyfpo6JiLY/zdBmcRcdsyxDEqQNGE
         lekPIOoXUVp6MEYPDjI/qjbKopxKTu1vgG08CaD2TMjIVJbxwwlD9+7XO8MwViKFwGL7
         mimTaN3LCNY4ctKLljGzvd3J5rOJfCHvVRnre0+l5FSdTrEB4WACZLEYMf9c8wpQJnCV
         FbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695450987; x=1696055787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2gpg7YRP4E+XAUJHrlXeLmjFlOQEtcIKaK+DMVYN/I=;
        b=PhSknrbq0463MTRGYsU3pwuIBlc7o9hnj75fmtDzIBEP0uapvlkC7aieFD+tiX1OIr
         fWMcq4OUt8JqF8JEfG2LmB6kkhpLqilmzQNd7VhPNUsn7UYlAq89f9H7EKTym4UTpjBO
         +QcYss5fNDGUffvqzhvoSmi+JjCGZXRFD0h1G0fWBwl+ggIgWco4Y9V1KF9lcOIg55nY
         6eNfzN3n8r5o5VfqhPbfSzL70aL26qc1rj6Q4d96f+YowEI5RVDx08K7r1GiK6t6dOKM
         m8H86DrYpma2tI/JlAqUXp5pGctabYeOCKfV2Z5ipJQdfpaEGU9qepw51DXDjkCFYvP2
         wkzg==
X-Gm-Message-State: AOJu0YwiZhGSDADDGrklTa99gidUSFROO96/jqp6PYZCpp2EYzgwB0ww
        E00WtZkjXQf5ebBQbQoLhvFvc6R5sn2/tq3RIS0=
X-Google-Smtp-Source: AGHT+IFdC2FThK1hvtZYKOO6H2Je2K9E6yas4ouFw1ijk2Lqm3hAaTib9/JFCYE9g0Lb0R41695itdbllp8m9zoaS88=
X-Received: by 2002:a05:6808:199f:b0:3ae:126b:8bfc with SMTP id
 bj31-20020a056808199f00b003ae126b8bfcmr2328511oib.4.1695450986775; Fri, 22
 Sep 2023 23:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org> <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
In-Reply-To: <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Sep 2023 09:36:15 +0300
Message-ID: <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 23, 2023 at 3:43=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 21 Sept 2023 at 11:51, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > We have many, many inodes though, and 12 bytes per adds up!
>
> That was my thinking, but honestly, who knows what other alignment
> issues might eat up some - or all - of the theoreteical 12 bytes.
>
> It might be, for example, that the inode is already some aligned size,
> and that the allocation alignment means that the size wouldn't
> *really* shrink at all.
>
> So I just want to make clear that I think the 12 bytes isn't
> necessarily there. Maybe you'd get it, maybe it would be hidden by
> other things.
>
> My biggest impetus was really that whole abuse of a type that I
> already disliked for other reasons.
>
> > I'm on board with the idea, but...that's likely to be as big a patch
> > series as the ctime overhaul was. In fact, it'll touch a lot of the sam=
e
> > code. I can take a stab at that in the near future though.
>
> Yea, it's likely to be fairly big and invasive.  That was one of the
> reasons for my suggested "inode_time()" macro hack: using the macro
> argument concatenation is really a hack to "gather" the pieces based
> on name, and while it's odd and not a very typical kernel model, I
> think doing it that way might allow the conversion to be slightly less
> painful.
>
> You'd obviously have to have the same kind of thing for assignment.
>
> Without that kind of name-based hack, you'd have to create all these
> random helper functions that just do the same thing over and over for
> the different times, which seems really annoying.
>
> > Since we're on the subject...another thing that bothers me with all of
> > the timestamp handling is that we don't currently try to mitigate "torn
> > reads" across the two different words. It seems like you could fetch a
> > tv_sec value and then get a tv_nsec value that represents an entirely
> > different timestamp if there are stores between them.
>
> Hmm. I think that's an issue that we have always had in theory, and
> have ignored because it's simply not problematic in practice, and
> fixing it is *hugely* painful.
>
> I suspect we'd have to use some kind of sequence lock for it (to make
> reads be cheap), and while it's _possible_ that having the separate
> accessor functions for reading/writing those times might help things
> out, I suspect the reading/writing happens for the different times (ie
> atime/mtime/ctime) together often enough that you might want to have
> the locking done at an outer level, and _not_ do it at the accessor
> level.
>
> So I suspect this is a completely separate issue (ie even an accessor
> doesn't make the "hugely painful" go away). And probably not worth
> worrying about *unless* somebody decides that they really really care
> about the race.
>
> That said, one thing that *could* help is if people decide that the
> right format for inode times is to just have one 64-bit word that has
> "sufficient resolution". That's what we did for "kernel time", ie
> "ktime_t" is a 64-bit nanosecond count, and by being just a single
> value, it avoids not just the horrible padding with 'struct
> timespec64', it is also dense _and_ can be accessed as one atomic
> value.

Just pointing out that xfs has already changed it's on-disk timestamp
format to this model (a.k.a bigtime), but the in-core inode still uses
the timespec64 of course.
The vfs can inprise from this model.

>
> Sadly, that "sufficient resolution" couldn't be nanoseconds, because
> 64-bit nanoseconds isn't enough of a spread. It's fine for the kernel
> time, because 2**63 nanoseconds is 292 years, so it moved the "year
> 2038" problem to "year 2262".

Note that xfs_bigtime_to_unix(XFS_BIGTIME_TIME_MAX) is in year
2486, not year 2262, because there was no need to use the 64bit to
go backwards to year 1678.

>
> And that's ok when we're talking about times that are kernel running
> times and we haev a couple of centuries to say "ok, we'll need to make
> it be a bigger type", but when you save the values to disk, things are
> different. I suspect filesystem people are *not* willing to deal with
> a "year 2262" issue.
>

Apparently, they are willing to handle the "year 2486" issue ;)

> But if we were to say that "a tenth of microsecond resolution is
> sufficient for inode timestamps", then suddenly 64 bits is *enormous*.
> So we could do a
>
>     // tenth of a microseconds since Jan 1, 1970
>     typedef s64 fstime_t;
>
> and have a nice dense timestamp format with reasonable - but not
> nanosecond - accuracy. Now that 292 year range has become 29,247
> years, and filesystem people *might* find the "year-31k" problem
> acceptable.
>
> I happen to think that "100ns timestamp resolution on files is
> sufficient" is a very reasonable statement, but I suspect that we'll
> still find lots of people who say "that's completely unacceptable"
> both to that resolution, and to the 31k-year problem.
>

I am guessing that you are aware of the Windows/SMB FILETIME
standard which is 64bit in 100ns units (since 1601).
So the 31k-year "problem" is very widespread already.

But the resolution change is counter to the purpose of multigrain
timestamps - if two syscalls updated the same or two different inodes
within a 100ns tick, apparently, there are some workloads that
care to know about it and fs needs to store this information persistently.

Thanks,
Amir.
