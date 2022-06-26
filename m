Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2A55B011
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 09:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbiFZH6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jun 2022 03:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiFZH6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:58:01 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D365F4F;
        Sun, 26 Jun 2022 00:57:59 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id k19so2391337uap.7;
        Sun, 26 Jun 2022 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axQpW1lhZT3bSYKkJPZgIKRK4dOyCun6htadvFckmFw=;
        b=XQVUKkRtgkyHQDWJiOco3Rlc69Sn+m0aF2613YoTU7kMvbTzu/J5lPiJ4jNTEcyyWt
         3deRS2kmVE0df4PihzhpDHtKLPdd/ez/Gypk26FOjNjidd2LiOZipoxp4XjHJmuxX1ci
         qPfV/3rbp7SJLIcIkO4rr3nG9IJ41XXnU69gd4L3mvxFz1sfhty5TQpNoVyCf6fxPoyE
         8MNm1sq71gzBIPK0oKa0Wd9TzVcgEX0wPXDTjYj9aHjQfCE8fs0pEBXAL693tBcCCm5K
         Kep1Olp2sFA7+RMyhsdYlb9s+LM2dSoarIhCOYKQj5GpMBpZjjpe73e829fCb9Y1z6L9
         iAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axQpW1lhZT3bSYKkJPZgIKRK4dOyCun6htadvFckmFw=;
        b=5uR1mv8pn7JdYCofrfZJwfOoOblukZzSsiIH9fZDtMRwl5aJmDK/cYgKyxX26czlun
         ESGxyTh4aMf4yEGqg2XFQXwfuwLWRlF1pO27ydaWDfUbsYNDdg/UuPSAvWM/rBWdQIyn
         9S40w6xiwL1vw8/bJPedj1EPPUzq30EGQV6XREAjAvKXKOcXK1q1ZFZt5uMrKVOFUBef
         6sO6jZjlwz+XRzFrtyd7TKpWT0hRFww7w/Ut0k/Vc8vNl95sJGmjCR8KmqWIc21TIit+
         2jjQieNJKjQQCvcwDaThzCqW+4czp+3PgISc82TdNnxTIypdQnd8Hw8PDQH55Srqz0h/
         6Fgw==
X-Gm-Message-State: AJIora/pbziGnGTWlC0N+QThrOdhX9kxu6eQeOEMU1sevvCa6ixrPX/a
        dxj1Lv08kBL2a0DUk0MreZE48tZST5yKojAKwkQ=
X-Google-Smtp-Source: AGRyM1vBD4d36BvxUrj0hbL0BSSBGy+rLjpW7+BiqkaPo9cuBvbw9g3SRR8w9f64FiJM1v78rw2VthgoIbpTtJPPPGk=
X-Received: by 2002:ab0:67d2:0:b0:37f:d4b:f9c2 with SMTP id
 w18-20020ab067d2000000b0037f0d4bf9c2mr2674280uar.60.1656230278264; Sun, 26
 Jun 2022 00:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220624143538.2500990-1-amir73il@gmail.com> <20220624143538.2500990-2-amir73il@gmail.com>
In-Reply-To: <20220624143538.2500990-2-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 26 Jun 2022 10:57:46 +0300
Message-ID: <CAOQ4uxjRzu_Y8eE=C=PnKjzCiDK5k5NBM1dxYttd8yfoy2DnUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fanotify: prepare for setting event flags in
 ignore mask
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 24, 2022 at 5:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> ignore mask is always implicitly applied to events on directories.
>
> Define a mark flag that replaces this legacy behavior with logic of
> applying the ignore mask according to event flags in ignore mask.
>
> Implement the new logic to prepare for supporting an ignore mask that
> ignores events on children and ignore mask that does not ignore events
> on directories.
>
> To emphasize the change in terminology, also rename ignored_mask mark
> member to ignore_mask and use accessors to get only the effective
> ignored events or the ignored events and flags.
>
> This change in terminology finally aligns with the "ignore mask"
> language in man pages and in most of the comments.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

[...]

> @@ -336,7 +337,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
>                 fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
>                         if (!(mark->flags &
>                               FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
> -                               mark->ignored_mask = 0;
> +                               mark->ignore_mask = 0;
>                 }
>         }

Doh! I missed (again) the case of:
!FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY && !FS_EVENT_ON_CHILD

I was starting to look at a fix, but then I stopped to think about the
justification
for FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY on a directory.

The man page does say:
"... the ignore mask is cleared when a modify event occurs for the ignored file
     or directory."
But ignore mask on a parent never really worked when this man page was
written and there is no such thing as a "modify event" on the directory itself.

Furthermore, let's look at the motivation for IGNORED_SURV_MODIFY -
it is meant (I think) to suppress open/access permission events on a file
whose content was already scanned for malware until the content of that
file is modified - an important use case.

But can that use case be extended to all files in a directory?
In theory, anti-malware software could scan a directory and call it "clean"
until any of the files therein is modified. However, an infected file can also
be moved into the "clean" directory, so unless we introduce a flag
IGNORED_DOES_NOT_SURV_MOVED_TO, supporting
!IGNORED_SURV_MODIFY on a directory seems useless.

That leads me to suggest the thing I like most - deprecate.
Until someone comes up with a case to justify !IGNORED_SURV_MODIFY
on a directory, trying to set FAN_MARK_IGNORE on a directory without
IGNORED_SURV_MODIFY will return EISDIR.

We could also say that IGNORED_SURV_MODIFY is implied on
a directory, but I think the EISDIR option is cleaner and easier to
document - especially for the case of "upgrading" a directory mark
from FAN_MARK_IGNORED_MASK to new FAN_MARK_IGNORE.

We could limit that behavior to an ignore mask with EVENT_ON_CHILD
but that will just complicate things for no good reason.

Semi-related, we recently did:
ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
We could have also disallowed FAN_ONDIR and FAN_EVENT_ON_CHILD
on non-dir inode. Too bad I didn't see it.
Do you think that we can/should "fix" FAN_REPORT_TARGET_FID to include
those restrictions?

I would certainly like to disallow dirent events and the extra dir flags
for setting FAN_MARK_IGNORE on a non-dir inode.

I am going to be on two weeks vacation v5.19-rc5..v5.19-rc7,
so unless we have clear answers about the API questions above
early this week, FAN_MARK_IGNORE will probably have to wait
another cycle.

In any case, I am going to post v3 with my API proposal, but considering
the buggy v1 and API issue in v2, I will need to improve the test coverage
before FAN_MARK_IGNORE can be merged.

Thanks,
Amir.
