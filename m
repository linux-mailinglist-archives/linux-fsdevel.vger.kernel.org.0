Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3AC7ADC9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjIYQDQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjIYQDP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:03:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD39BE
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 09:03:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5031426b626so10714131e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695657786; x=1696262586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A3CURX8d3cYG1fQrKnA7galRUzLSX0ZMwE51Q1+NG/M=;
        b=IvWUoNSWKOtV1bSMBIDt4E7tBS36TXSoXU9yus55zerd8GX2eFhseHdXWqXCc6opb/
         GEmFXTj2IaGtWjqqGQt72sJxRMQwVi8zCDp1b6P1AkP3gLLynjZhEKh4bAeMBOIJTn24
         ghl10NC8DEtkiK2xb/vPzLuj+Kxz6HK2/h4fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657786; x=1696262586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3CURX8d3cYG1fQrKnA7galRUzLSX0ZMwE51Q1+NG/M=;
        b=WSI9YekMaI6ByMoUR8I9SAY/fVocQ1X/H4JsImW5jrCps4YN3+QxFzmCbGXKF7lL5N
         IhfN8SiinKW7mKJ12AT+qA9gCP1CoVFmauWqbm3xJz34oD4s8PEzLyFoBZq+G1G7pTtG
         m19QTffDv7+Pb97NKh9oMFCjW0HTZnvVR38gcDl0qO3Tfqko7s+26qJ6/uGc1+w3gNJV
         56dWvWLhdV1ZBnadWJsB4sbuqBQbzeekQl9Jmg5oRcs7e16Hbn/OC1bYT5VDq9CRdyR6
         U3o+ReOTsk3WC9v+clJxuy2xqcVhKQfiGKMQnIA0JQSrH/6Z6bG7XbYtqCt8covHbF+1
         tUXQ==
X-Gm-Message-State: AOJu0YwW3yl8FUMinrS8eQ4NwkXx74n073G8MiJZI7dX8Qf80Fi9cUh8
        DdbsCc7guGkdVxAyTFIsEbqZMZND30vN0vIm3EjWqQ==
X-Google-Smtp-Source: AGHT+IFnDZ3SLGTXxHCxP6qu7eps6DVTaPlHosKsblADwTUaz1Nj1A3c6S4iE1yD9Ofnql5tn6r70A==
X-Received: by 2002:a19:645e:0:b0:4fb:8f79:631 with SMTP id b30-20020a19645e000000b004fb8f790631mr5095326lfj.46.1695657786146;
        Mon, 25 Sep 2023 09:03:06 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id d10-20020ac25eca000000b0050307789accsm1739794lfq.42.2023.09.25.09.02.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 09:02:58 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso114230641fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 09:02:56 -0700 (PDT)
X-Received: by 2002:a2e:800c:0:b0:2bc:dd96:147d with SMTP id
 j12-20020a2e800c000000b002bcdd96147dmr6582130ljg.28.1695657774017; Mon, 25
 Sep 2023 09:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
 <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com> <9ee3b65480b227102c04272d2219f366c65a14f3.camel@kernel.org>
In-Reply-To: <9ee3b65480b227102c04272d2219f366c65a14f3.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Sep 2023 09:02:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1YhGmwcWn4TfTC1fMaDjhbLJMge123rj2YEjZNy5KFQ@mail.gmail.com>
Message-ID: <CAHk-=wg1YhGmwcWn4TfTC1fMaDjhbLJMge123rj2YEjZNy5KFQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 25 Sept 2023 at 04:23, Jeff Layton <jlayton@kernel.org> wrote:
>
> The catch here is that we have at least some testcases that do things
> like set specific values in the mtime and atime, and then test that the
> same value is retrievable.

Yeah, I'm sure that happens. But as you say, we already have
per-filesystem granularity issues that means that there is some non-ns
granularity that those tests have to deal with.

Unless they currently just work on one or two filesystems, of course.

> Of course, that set truncates the values at jiffies granularity (~4ms on
> my box). That's well above 100ns, so it's possible that's too coarse for
> us to handwave this problem away.

Note that depending or enforcing some kind of jiffies granularity is
*particularly* bad, because it's basically a random value.

It will depend on architecture and on configuration. On some
architectures it's a fixed value (some have it at 100, which is, I
think, the original x86 case), on others it's "configurable", but not
really (ie alpha is "configurable" in our Kconfig, but the _hardware_
typically has a fixed clock tick at 1024 Hz, but then there are
platforms that are different, and then there's Qemu that likes a lower
frequency to avoid overhead etc etc).

And then we have the "modern default", which is to ask the user at
config time if they want a 100 / 250 / 300 / 1000 HZ value, and the
actual hw clock tick may be much more dynamic than that.

Anyway, what I'm saying is just that we should *not* limit granularity
to anything that has to do with jiffies. Yes, that's still a real
thing in that it's a "cheap read of the current time", but it should
never be seen as any kind of vfs granularity.

And yes, HZ will be in the "roughly 100-1000" range, so if we're
talking granularities that are microseconds or finer, then at most
you'll have rounding issues - and since any HZ rounding issues should
only be for the cases where we set the time to "now" - rounding
shouldn't be an issue anyway, since it's not a time that is specified
by user space.

End result: try to avoid anything to do with HZ in filesystem code,
unless it's literally about jiffies (which should typically be mostly
about any timeouts a filesystem may have, not about timestamps
themselves).

               Linus
