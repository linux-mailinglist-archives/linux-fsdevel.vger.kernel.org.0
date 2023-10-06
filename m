Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299DC7BB13A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 07:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjJFFfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 01:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:35:44 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBAACA
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 22:35:43 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a4e29928c3so21012287b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 22:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696570542; x=1697175342; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PaezefeDp7zAJYrklW0Fkd4Zlqg9EojUKIwPXxGjmPs=;
        b=Bd+HFgcmlhXCuItTdkHdjd3UhzPw0xXAk4UyrN7VC1eyvtvg5dHpWkUQCktE+neGgd
         rpk6qYm/rIyjTs1feGkOL+hYZV5/qzmcRq3epkmObJ6xnU2jJi4vwWsoY7sTh25V9RPH
         XCKNS999Z5sC5pY+IIfKQRAQGAV0zVPXNiDBMwxbPq6lRvhA+dvGfGPsrQUvGSdpA7hu
         s6vQZ1CA3kZN0czt/mYwq4VX7bL0iNtoXzFFZe4lAQm9cx7JUUmMNCgo9kjO65kcUQeJ
         moaSfxsLTC8H8LE1P82oJ/Sih4tUWpDu7cbMhhsfj5VGREixvUnCxS/+bM6tj64McYXU
         MzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696570542; x=1697175342;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaezefeDp7zAJYrklW0Fkd4Zlqg9EojUKIwPXxGjmPs=;
        b=h+ftpdaxDGNDrn5ptPqiqRpRjmR5/8febCGGhZucUVa/UL9w2xDNgkPUWErgLn9Efk
         o8/sSZQUAZZ1NYmDlPjVikVKJHHfsLxzOlk3+M5SMxws/Nhn8vq46Gwi2V6igi5qopUS
         wVQqp3YH1TcYhqiaBWPdZlDZ5zevglbHsCDn4QPxUPcaWpiT3OWAeHN+GEqjlyWwBoqx
         EnXdwgEfDOVkpKZM+tKZPpHofWnFOIRV/WQGZ3YIZYASNjA4Sa7dGNYW3blYEHUFn3AR
         FK1X2SqA1Zas+KXjNgBkd3u9zfciLbmyrLIHi2F1Tw9c7TrMWhLD+zNISJ66CpJX7Qv1
         GZKg==
X-Gm-Message-State: AOJu0YyI4PUMzTrFFE/DuMgYhOxqxfJaKXsIaOC6GiEgeTjDa/gNZtIQ
        dB8jUKK8BIRWEzcJqW49hoenxg==
X-Google-Smtp-Source: AGHT+IEpTrnr9XdsKNbpo6pfTBAH5V4ZhM8V1KQHtZFnBvpqLiwm1YQa3LOzuYzsLeu+aZuIuTGmrg==
X-Received: by 2002:a81:a18a:0:b0:595:320d:c9e2 with SMTP id y132-20020a81a18a000000b00595320dc9e2mr8370979ywg.24.1696570542515;
        Thu, 05 Oct 2023 22:35:42 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l197-20020a0de2ce000000b005a4dde66853sm1059846ywe.0.2023.10.05.22.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 22:35:41 -0700 (PDT)
Date:   Thu, 5 Oct 2023 22:35:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Dave Chinner <david@fromorbit.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
In-Reply-To: <ZR3wzVJ019gH0DvS@dread.disaster.area>
Message-ID: <2451f678-38b3-46c7-82fe-8eaf4d50a3a6@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com> <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com> <ZR3wzVJ019gH0DvS@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 5 Oct 2023, Dave Chinner wrote:
> On Fri, Sep 29, 2023 at 08:42:45PM -0700, Hugh Dickins wrote:
> > Percpu counter's compare and add are separate functions: without locking
> > around them (which would defeat their purpose), it has been possible to
> > overflow the intended limit.  Imagine all the other CPUs fallocating
> > tmpfs huge pages to the limit, in between this CPU's compare and its add.
> > 
> > I have not seen reports of that happening; but tmpfs's recent addition
> > of dquot_alloc_block_nodirty() in between the compare and the add makes
> > it even more likely, and I'd be uncomfortable to leave it unfixed.
> > 
> > Introduce percpu_counter_limited_add(fbc, limit, amount) to prevent it.
> > 
> > I believe this implementation is correct, and slightly more efficient
> > than the combination of compare and add (taking the lock once rather
> > than twice when nearing full - the last 128MiB of a tmpfs volume on a
> > machine with 128 CPUs and 4KiB pages); but it does beg for a better
> > design - when nearing full, there is no new batching, but the costly
> > percpu counter sum across CPUs still has to be done, while locked.
> > 
> > Follow __percpu_counter_sum()'s example, including cpu_dying_mask as
> > well as cpu_online_mask: but shouldn't __percpu_counter_compare() and
> > __percpu_counter_limited_add() then be adding a num_dying_cpus() to
> > num_online_cpus(), when they calculate the maximum which could be held
> > across CPUs?  But the times when it matters would be vanishingly rare.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: Tim Chen <tim.c.chen@intel.com>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > ---
> > Tim, Dave, Darrick: I didn't want to waste your time on patches 1-7,
> > which are just internal to shmem, and do not affect this patch (which
> > applies to v6.6-rc and linux-next as is): but want to run this by you.
> 
> Hmmmm. IIUC, this only works for addition that approaches the limit
> from below?

That's certainly how I was thinking about it, and what I need for tmpfs.
Precisely what its limitations (haha) are, I'll have to take care to
spell out.

(IIRC - it's a while since I wrote it - it can be used for subtraction,
but goes the very slow way when it could go the fast way - uncompared
percpu_counter_sub() much better for that.  You might be proposing that
a tweak could adjust it to going the fast way when coming down from the
"limit", but going the slow way as it approaches 0 - that would be neat,
but I've not yet looked into whether it's feasily done.)

> 
> So if we are approaching the limit from above (i.e. add of a
> negative amount, limit is zero) then this code doesn't work the same
> as the open-coded compare+add operation would?

To it and to me, a limit of 0 means nothing positive can be added
(and it immediately returns false for that case); and adding anything
negative would be an error since the positive would not have been allowed.

Would a negative limit have any use?

It's definitely not allowing all the possibilities that you could arrange
with a separate compare and add; whether it's ruling out some useful
possibilities to which it can easily be generalized, I'm not sure.

Well worth a look - but it'll be easier for me to break it than get
it right, so I might just stick to adding some comments.

I might find that actually I prefer your way round: getting slower
as approaching 0, without any need for specifying a limit??  That the
tmpfs case pushed it in this direction, when it's better reversed?  Or
that might be an embarrassing delusion which I'll regret having mentioned.

> 
> Hence I think this looks like a "add if result is less than"
> operation, which is distinct from then "add if result is greater
> than" operation that we use this same pattern for in XFS and ext4.
> Perhaps a better name is in order?

The name still seems good to me, but a comment above it on its
assumptions/limitations well worth adding.

I didn't find a percpu_counter_compare() in ext4, and haven't got
far yet with understanding the XFS ones: tomorrow...

> 
> I'm also not a great fan of having two
> similar-but-not-quite-the-same implementations for the two
> comparisons, but unless we decide to convert the XFs slow path to
> this it doesn't matter that much at the moment....
> 
> Implementation seems OK at a quick glance, though.

Thanks!

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
