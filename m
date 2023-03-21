Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381B66C2DFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCUJf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCUJf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:35:57 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2612A9BC
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 02:35:56 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id cu36so4143775vsb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Mar 2023 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679391355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvc/4VNbB8WBUsx64rJ7I7ZWXs3cL6FlquMrDKUjXFI=;
        b=Dh1dRRzzTWsqs1rELjj9mln7TzLQ4CdGJIC/lm5XT4cPKCiJ6COS04EbcmA3I1F65r
         9Qh4EnqJxNOFl+Gcq5dlcEFSimqrfQJZQtuStjKSyMSA/zhuuD6Znrs+Mr96AB+l0wcL
         oSJTfomHYFGEBIQijuxhKml+kr6OxqJUafeK+BsC2s3f37KuXAlxw42SeNPg762rQwSm
         bB4u7vnJkjuVjWiJXhIH0lbsndYtAh7QwdZU7eDwvmn3NiyuhJwTpZjfiTfCU+0I2i2a
         TVL5cGKUriEEEfWjJkokZT6Dy6G1DKEnXKKIiFL+Ns9/X4ZuAHnJeTQIitb3FZ+QSULd
         7iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679391355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvc/4VNbB8WBUsx64rJ7I7ZWXs3cL6FlquMrDKUjXFI=;
        b=UobVq4KZB+JEjyN/WArig8554Q9veV5NnxYh+2lFdYn/XW/R/uaEEeNq1797jd8Ih2
         q/rqL4Q/VzgHPE90LAqipx9+4YqEmVYEJs27Qgam6VtaJkyatFbKjdVijBbMPNi7iCOP
         wB4tWPFRDh+Hkrtny3lghgTP+0vtc64s7lAz5aNVgIhPOVCDQDChCggbT5ovWjlsb+zC
         UsfcdY6RzVy7NbwznLhd245PqhcRXkENuLAXMcNWuADKEUAaSHVwX/eRL5HvFN1QCPgE
         MBXvn9ZfogkrR4dIX4susw+/FQlkrxZkV/dVY9nsyEL121K+zQxYu0njk0JnSQyMjsEB
         aT8w==
X-Gm-Message-State: AO0yUKU21IMiny0w0vmzR06pxle6IilrTm9x9/E6DFlJCyT0foXV2S2W
        ZtY+qWyIfXU9PzWQerOKIjT71k2LgNrkTTXbRgodzvoO
X-Google-Smtp-Source: AK7set84OnZxccb+XfEWZtoj0MbCa6MkY1bcDlPbTecYs1OsFQye6CYBODR/gLWWg2QuRN9CCItCEyX+6itRD7o/8WM=
X-Received: by 2002:a67:d31e:0:b0:425:dd2d:1c0 with SMTP id
 a30-20020a67d31e000000b00425dd2d01c0mr1163828vsj.0.1679391355254; Tue, 21 Mar
 2023 02:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230321011047.3425786-1-bschubert@ddn.com>
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Mar 2023 11:35:44 +0200
Message-ID: <CAOQ4uxjXZHr3DZUQVvcTisRy+HYNWSRWvzKDXuHP0w==QR8Yog@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] fuse uring communication
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 3:11=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This adds support for uring communication between kernel and
> userspace daemon using opcode the IORING_OP_URING_CMD. The basic
> appraoch was taken from ublk.  The patches are in RFC state -
> I'm not sure about all decisions and some questions are marked
> with XXX.
>
> Userspace side has to send IOCTL(s) to configure ring queue(s)
> and it has the choice to configure exactly one ring or one
> ring per core. If there are use case we can also consider
> to allow a different number of rings - the ioctl configuration
> option is rather generic (number of queues).
>
> Right now a queue lock is taken for any ring entry state change,
> mostly to correctly handle unmount/daemon-stop. In fact,
> correctly stopping the ring took most of the development
> time - always new corner cases came up.
> I had run dozens of xfstest cycles,
> versions I had once seen a warning about the ring start_stop
> mutex being the wrong state - probably another stop issue,
> but I have not been able to track it down yet.
> Regarding the queue lock - I still need to do profiling, but
> my assumption is that it should not matter for the
> one-ring-per-core configuration. For the single ring config
> option lock contention might come up, but I see this
> configuration mostly for development only.
> Adding more complexity and protecting ring entries with
> their own locks can be done later.
>
> Current code also keep the fuse request allocation, initially
> I only had that for background requests when the ring queue
> didn't have free entries anymore. The allocation is done
> to reduce initial complexity, especially also for ring stop.
> The allocation free mode can be added back later.
>
> Right now always the ring queue of the submitting core
> is used, especially for page cached background requests
> we might consider later to also enqueue on other core queues
> (when these are not busy, of course).
>
> Splice/zero-copy is not supported yet, all requests go
> through the shared memory queue entry buffer. I also
> following splice and ublk/zc copy discussions, I will
> look into these options in the next days/weeks.
> To have that buffer allocated on the right numa node,
> a vmalloc is done per ring queue and on the numa node
> userspace daemon side asks for.
> My assumption is that the mmap offset parameter will be
> part of a debate and I'm curious what other think about
> that appraoch.
>
> Benchmarking and tuning is on my agenda for the next
> days. For now I only have xfstest results - most longer
> running tests were running at about 2x, but somehow when
> I cleaned up the patches for submission I lost that.
> My development VM/kernel has all sanitizers enabled -
> hard to profile what happened. Performance
> results with profiling will be submitted in a few days.

When posting those benchmarks and with future RFC posting,
it's would be useful for people reading this introduction for the
first time, to explicitly state the motivation of your work, which
can only be inferred from the mention of "benchmarks".

I think it would also be useful to link to prior work (ZUFS, fuse2)
and mention the current FUSE performance issues related to
context switches and cache line bouncing that was discussed in
those threads.

Thanks,
Amir.
