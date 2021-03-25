Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3B3493DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCYOSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYOSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:18:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3267C06174A;
        Thu, 25 Mar 2021 07:18:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ce10so3191127ejb.6;
        Thu, 25 Mar 2021 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lMu1u0tgdpKUYdK0Y2edV56h3EG24/y18/fAyUCWVWo=;
        b=RbjSEQfqNEssxKbJqIH/emUW3jSbq9bgkMVtMsexGztaajgm+fopQefEDxTPfEaDIb
         FVO53ZNlI1hsSzxMiyfd+OssWBBSeB+fZTI4mw22lXVF+ItJhweULzi3KcSISHl9fc6Z
         uyYcjwB/mOGr56dLrk9UO608Wg1Kg8l7Egglol76u7z9losnL8FdpcIQAqW1bsRXaX0U
         qlRjkh/aG1c225VZti7tuHpguitH9L+1frIE2ZwhHSPkVsXy31F14bWaCM1Qx9S00rLx
         rMIMXH0WQRMuKUuMEaiiyYgRmbo75EQVt9xEZGWlRyjFMTHA0UQPlet9J8xEeaFAnxhZ
         tHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lMu1u0tgdpKUYdK0Y2edV56h3EG24/y18/fAyUCWVWo=;
        b=owSoQKmvPLxfGvn1I/xv7A0VM9Oj2f5XOFByaA74Jq4WUbQlzlAW9yKc22iY1zIv1s
         Qs3f+fFRvORZinkGNpC3Ghwq9+ymH65CK70OY/RDuyCNw7mC6Mqzn0Qq2TQYs5oaw8yp
         PW/R8wMZh1mTZsDvgtaIXlOg2QRJKGnOe7yuRDRFfUz9blpmVE5DiBSH/i2ircZwZ/q6
         kenEzOsqoEckuLw5BXr+desAB4Kmz1e42eq+KdhhunBzf/1iw2ys7DMfwOLDaMg6P1Ke
         EBAmIiOEFqtzLfzmcBQgHQ7e6l7LUZhpJWTSjMMNon4JqkrG6nPgyvLlTpFGdeS0FJ8a
         aUng==
X-Gm-Message-State: AOAM533S3B2qpzuKhVd5gwL1+7uuJ3Qic6cbmJRfrgS4DfrpwJhnscam
        f9uY5F+Fw9LRKA7jl5iy0s8=
X-Google-Smtp-Source: ABdhPJx99KPo9V0jaqGGq7Ye9JnyXiJfOF3Cm5/DRDHl9roTqWzH+YfFFqt8ZH8gC0LIsPotgBYXig==
X-Received: by 2002:a17:907:e8f:: with SMTP id ho15mr9886768ejc.541.1616681908525;
        Thu, 25 Mar 2021 07:18:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p19sm2793453edr.57.2021.03.25.07.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:18:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 25 Mar 2021 15:18:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on
 SIGTRAP
Message-ID: <20210325141820.GA1456211@gmail.com>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-8-elver@google.com>
 <YFs2XHqepwtlLinx@hirez.programming.kicks-ass.net>
 <YFs4RDKfbjw89tf3@hirez.programming.kicks-ass.net>
 <YFs84dx8KcAtSt5/@hirez.programming.kicks-ass.net>
 <YFtB+Ta9pkMg4C2h@hirez.programming.kicks-ass.net>
 <YFtF8tEPHrXnw7cX@hirez.programming.kicks-ass.net>
 <CANpmjNPkBQwmNFO_hnUcjYGM=1SXJy+zgwb2dJeuOTAXphfDsw@mail.gmail.com>
 <CACT4Y+aKmdsXhRZi2f3LsX3m=krdY4kPsEUcieSugO2wY=xA-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aKmdsXhRZi2f3LsX3m=krdY4kPsEUcieSugO2wY=xA-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Dmitry Vyukov <dvyukov@google.com> wrote:

> On Wed, Mar 24, 2021 at 3:05 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 24 Mar 2021 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > One last try, I'll leave it alone now, I promise :-)
> >
> > This looks like it does what you suggested, thanks! :-)
> >
> > I'll still need to think about it, because of the potential problem
> > with modify-signal-races and what the user's synchronization story
> > would look like then.
> 
> I agree that this looks inherently racy. The attr can't be allocated
> on stack, user synchronization may be tricky and expensive. The API
> may provoke bugs and some users may not even realize the race problem.

Yeah, so why cannot we allocate enough space from the signal handler 
user-space stack and put the attr there, and point to it from 
sig_info?

The idea would be to create a stable, per-signal snapshot of whatever 
the perf_attr state is at the moment the event happens and the signal 
is generated - which is roughly what user-space wants, right?

Thanks,

	Ingo
