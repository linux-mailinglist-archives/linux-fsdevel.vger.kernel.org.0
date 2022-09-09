Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701925B42C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 01:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIIXFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 19:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIIXFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:05:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DC8112107
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 16:05:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bq9so5437338wrb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Sep 2022 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XEHjZdE5cXej0sCzp6ZOyx5QbkHBZBBmUgOJJuhhkJA=;
        b=J1WpVx0CRLo6dGvLFhALEQ6Xluo2eo8BQYOSB0bVXOoq100QqVscj3PFfGuLqc/T2L
         SKgQtIP+vlNGcH857n6xTAhIXSQ8hNLqLCWiJcahboGMEXnVzlngyPrTtqfrf/oeML3N
         XDGXWEDVswcCPVJEd6HT9+jX2mc8uEsZwNbWuhJIzusq0pZsik9FiXRH3PWF0X+5czF1
         H0Nlmbm0JkQI13VXWgcVOcX1fg4LZc+SpFQ/ldltCxJNufYu6mIX0d77F7uMujXE2s3f
         dom7BYp22foU4qv5qizHE7QpcmUBUyxpdwiH90iXiJ+tW/b45tpDlEHDi7AAFtDv4uDr
         ictQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XEHjZdE5cXej0sCzp6ZOyx5QbkHBZBBmUgOJJuhhkJA=;
        b=qkhXewSuxk2Vm7QDDlXs04uAficBwG+Y3fWZKws9Zp6/dJ8I0BnO4Tv7WF2OcBLfVa
         b1wpsaSsxkvprpKboUlLrPN2i879RNI37ilBy4mMHUw3a2evj2HAMSmRaPw53pJBlgN6
         WNfP8Iwwi5pvY+moPSw1Kb4tMuZcBOwEHQtnVcbqrZy1i74vWIIeucuc9RnuBTFgd5rK
         u5qFwbsNDtzkPkFkOTPaXpZ9RZiDydero8nyNBlgCUez1jkvAy+Ud+cUkOhEKnHRO/4I
         V7iDRC/HUS6jn/nGP6o1uEGYZB2AcRUb3fJVzOx8vB9YX/j4N/NMS7d67xd0fj0A0PDC
         yt1Q==
X-Gm-Message-State: ACgBeo0MP+PQyi43y2vMTv4FnknyKE47qXyQL+1tssqmiflMvTGKosgP
        zhY/jDa1EQPIYeGGmmOtY9Mn/nTQTNvxFq0JbOz8dA==
X-Google-Smtp-Source: AA6agR6Qe6ZFAe5XnZ2xLl7TvYhpp5qlBYFWOt3v4WnorqZQleqYA0cJGs7hxvw6hd0FFq+Y/wrIG8mCD/V+T99d8ag=
X-Received: by 2002:a5d:64a9:0:b0:225:66ef:be9d with SMTP id
 m9-20020a5d64a9000000b0022566efbe9dmr9096995wrp.604.1662764746086; Fri, 09
 Sep 2022 16:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220909180617.374238-1-fmayer@google.com> <87v8pw8bkx.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87v8pw8bkx.fsf@email.froward.int.ebiederm.org>
From:   Florian Mayer <fmayer@google.com>
Date:   Fri, 9 Sep 2022 16:05:34 -0700
Message-ID: <CAJAyTCCcecgqeMfs9W8=U4wi-6O+DaRktUsyJuStYy-JgKQCdg@mail.gmail.com>
Subject: Re: [PATCH RESEND] Add sicode to /proc/<PID>/stat.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 9 Sept 2022 at 14:47, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Added linux-api because you are changing the api.

Thanks.

> Several things.  First you are messing with /proc/<pid>/stat which is
> heavily used.  You do add the value to the end of the list which is
> good.  You don't talk about how many userspace applications you have
> tested to be certain that it is actually safe to add something to this
> file, nor do you talk about measuring performance.

Makes sense. Given this and Kees comment above, it seems like status
instead is a better place. That should deal with the compatibility
issue given it's a key-value pair file. Do you have the same
performance concerns for that file as well?

> This implementation seems very fragile.  How long until you need the
> full siginfo of the signal that caused the process to exit somewhere?

For our use case probably never. I don't know if someone else will
eventually need everything.

> There are two ways to get this information with existing APIs.
> - Catch the signal in the process and give it to someone.

This would involve establishing a back-channel from the child process
to init, which is not impossible but also not particularly
architecturally nice.

> - Debug the process and stop in PTRACE_EVENT_EXIT and read
>   the signal with PTRACE_PEEKSIGINFO.

This will not work with the SELinux rules we want to enforce on Android.

> I know people have wanted the full siginfo on exit before, but we have
> not gotten there yet.

That sounds like a much bigger change. How would that look? A new
sys-call to get the siginfo from a zombie? A new wait API?


Florian
