Return-Path: <linux-fsdevel+bounces-1461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB87DA418
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 01:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEF8B2164F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 23:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AA2405F7;
	Fri, 27 Oct 2023 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wofbt4EW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E538BDF
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 23:30:24 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEAD1B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 16:30:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso36562391fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698449420; x=1699054220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wvasZUGdzUlCp36t9CiD94Z2xAZIX3c5sqRXyMOP0U=;
        b=Wofbt4EWs2KIYKOjM135GcRCNFbMQ6gs1IjGmmFbiEmqoVhW8EF6+mh1B70MY9MX4L
         /CeeW24glpaJwqHwp44L5/UEqdkx5pY/U0+7bjBylRkHg7NtZS6Y0wFpvPTqafIChBoS
         VKZWJCizQ4Hcd0zZX3kY8bh2+S8MXk7etEiVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698449420; x=1699054220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wvasZUGdzUlCp36t9CiD94Z2xAZIX3c5sqRXyMOP0U=;
        b=iGr5M716SnWheTz/l1nYQFRVYTSH6tqkuSU4B5fyALyzH+PiVU7X6GI7H4Wrebcuqe
         WGo/Kx++/4YFckvkMw/tM6yimTwwtVJLED78UUDCZJZj63aYiZQBpMFI/y4xHVSTSsFm
         YocaPsUVh6px/F51037GWSvdGdxHxQiGMSZUbnu2aLrNxSk9Ic+ypCeuQSIeUkKkA6JN
         E1CHWkxh4tOgHlUS6UWa+Py81FMhBxPkRL6UZ1joL9Kgbr0/iYyNTNEgk/cGy7xnCkbD
         +BcMnW+FhCkWqgL0MtbTvDwHKdLrCmT6BZosyyf5HoK1owOf+JMqq3+E7v8/mw4bEVTn
         /K7w==
X-Gm-Message-State: AOJu0Yyi65LFo6oWavjI5yIK7cZJH9hS4zBzIKuJcmMEMSWQUwzOtT1F
	d+VSHJ9a8OwikhoKV0q2FCxZMs0ywydTD5WANcMklQ==
X-Google-Smtp-Source: AGHT+IFL0aZA2cLAks58II2PjIs5mNB3GuGPPE8ggw3074p3v2Ma8klFw5T/Cmd3h9Wfw7ChLnZ70A==
X-Received: by 2002:a2e:a793:0:b0:2c5:19e9:422c with SMTP id c19-20020a2ea793000000b002c519e9422cmr3431571ljf.24.1698449420238;
        Fri, 27 Oct 2023 16:30:20 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id p26-20020a2ea41a000000b002c2c21750e7sm453406ljn.17.2023.10.27.16.30.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 16:30:18 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507be298d2aso3776519e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 16:30:18 -0700 (PDT)
X-Received: by 2002:a05:6512:488a:b0:502:d743:8a6c with SMTP id
 eq10-20020a056512488a00b00502d7438a6cmr2813810lfb.9.1698449418278; Fri, 27
 Oct 2023 16:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
 <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
 <20231023223810.GW3195650@frogsfrogsfrogs> <20231024-flora-gerodet-8ec178f87fe9@brauner>
 <20231026031325.GH3195650@frogsfrogsfrogs> <CAHk-=whQHBdJTr9noNuRwMtFrWepMHhnq6EtcAypegi5aUkQnQ@mail.gmail.com>
 <20231027-gestiegen-saftig-2e636d251efa@brauner>
In-Reply-To: <20231027-gestiegen-saftig-2e636d251efa@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Oct 2023 13:30:00 -1000
X-Gmail-Original-Message-ID: <CAHk-=wivwYfw0DHn3HowHJPg0rkt2fVSdLwjbsX6dTPNoMWXNA@mail.gmail.com>
Message-ID: <CAHk-=wivwYfw0DHn3HowHJPg0rkt2fVSdLwjbsX6dTPNoMWXNA@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
	Shirley Ma <shirley.ma@oracle.com>, hch@lst.de, jstancek@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Oct 2023 at 08:46, Christian Brauner <brauner@kernel.org> wrote:
>
> One of the critical parts is review. Good reviews are often insanely
> expensive and they are very much a factor in burning people out. If one
> only ever reviews and the load never ends that's going to fsck with you
> in the long run.

I absolutely despise the review requirement that several companies
have. I very much understand why it happens, but I think it's actively
detrimental to the workflow.

It's not just that reviewing is hard, the review requirement tends to
be a serialization point where now you as a developer are waiting for
others to review it, and those others are not nearly as motivated to
do so or are easily going to be nitpicking about the non-critical
things.

So it's not just the reviewers that get burned out, I think the
process ends up being horrific for developers too, and easily leads to
the "let's send out version 17 of this patch based on previous
review". At which point everybody is completely fed up with the whole
process.

And if it doesn't get to version 17, it's because the reviewers too
have gotten so fed up that by version three they go "whatever, I've
seen this before, they fixed the obvious thing I noticed, I'll mark it
reviewed".

The other dynamic with reviews is that you end up getting
review-cliques, either due to company pressure or just a very natural
"you review mine, I review yours" back-scratching.

Don't get me wrong - it can work, and it can even work well, but I
think the times it works really well is when people have gotten so
used to each others, and know each other's quirks and workflows and
they just work well together. But that also means that some people are
having a much easier time getting reviews, because they are part of
that "this group works well together" crowd.

Maybe it's a necessary evil. I certainly do *not* think the "lone
developer goes his own way" model works all that well. But the reason
I said that I wish we had more maintainers, is that I think we would
often be better off with not a "review process" back-and-forth. but a
_pipeline_ through a few levels of maintainers.  Not the "hold things
up and send it back to the developer" kind of thing, but "Oh, this
looks fine, I'll just send it on - possibly with the fixes I think are
needed".

So I think a pipeline of "Signed-off-by" (or just merges) might be
something to strive for as at least a partial replacement for reviews.

Sure, you might get Acked-by's or Reviewed-by's or Tested-by's along
the way *too*, or - when people are just merging directly through git
- you'd just get a merge commit with commentary and perhaps extra
stuff on top.

Back when we started doing the whole "Signed-off-by" - for legal
reasons, not development reasons - the big requirement for me was that
"it needs to work as a pipeline, not as some kind of back-and-forth
that holds up development". And I think the whole sign-off chain has
worked really well, and we've never needed to use it for the original
legal purposes (and hopefully just by virtue of it existing, we never
will), but it has been a huge success from a development standpoint.
When something goes wrong, I think it's been great to have that whole
chain of how it got merged, and in fact one of my least favorite parts
of git ended up being how we never made it easy to see the merge chain
after it's been committed (you can technically get it with "git
name-rev", but it sure is not obvious).

I dunno. Maybe I'm just dreaming. But the complaints about reviews -
or lack of them - do tend to come up a lot, and I feel like the whole
review process is a very big part of the problem.

                 Linus

