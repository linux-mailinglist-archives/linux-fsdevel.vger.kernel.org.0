Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BCA4C5E23
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 19:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiB0Sb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 13:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0Sb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:31:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D346CA4F;
        Sun, 27 Feb 2022 10:30:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s24so14536782edr.5;
        Sun, 27 Feb 2022 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/Si1oojWqE7bZU9236xHJfvcaAmph/X2hpEfYgxQN4=;
        b=i3JaEoSbVEmaMs+xVWRb7yDF4KWbTEk+9m59nHltQcJIo5sclCAoMI3EBdSxD5H3FR
         me+dSwZYuGsv/CVO9xmWFW7KyhXdspNSKtBTNs1s0+04ZQgtAdYxDsRY+mdxhg3BV07e
         ONfKwEepbXyFSeId2I3rWKwaWiurwkopRwYxHD5U2s5Vte36WVScXBLrUorL7N/hQ/pf
         AqmEYq48gU7Nlf9onuhP5ErSUGfEMsmrLdFFRoQceMkJNSX84BksC5l51TKmcGH1s+t5
         gyX3vKdyFeYapCy2adcnNXx9aTCw8FDJ8ygoP/eUILSFDPhX00TDgRknaP0+45DuoZIH
         K5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/Si1oojWqE7bZU9236xHJfvcaAmph/X2hpEfYgxQN4=;
        b=O+r+2lL28JGcLC6MzIy+IuOgqu7DO91BxZ0Uad5CZq6HlQ8EdWqsNSpWjz94FtZmXl
         E3MK7QdGKRZ27bJ/XFbpPWZzFL2pH+unxg9H63x65p5qDeJ/glpVmsvl3UL3MqgDbf8J
         R3v+Gw1Y0Lg9XzZL+YLOWtGwmpZSb+WW5kXDhGo5I8yU2IKA7E9LDZAKaip3zDAmVFpR
         nTcMrmCOQcvAIZhsL96qV9c9fPUDL3yE9+KojrYG1lrIlzB1/nyQlC5otXNCw1hsbupB
         KjnKawouwoV7j5kDlxPF8/poCIHXram7HlSyoxHRrxB5LHJdW+DDCoe5eMBStySAGhZA
         vz7Q==
X-Gm-Message-State: AOAM530FhKbiV6HGViEzA8YEMhQTm8tyHb7mvDucs7AZf5UW6QUfVjLI
        v+1OsE4ZK+i4sQkLh2jyq4j7qjt+0Yv7ZCwdqQ8DcZDV+ZA=
X-Google-Smtp-Source: ABdhPJxq1U2NB5ll7G72DsuxUPr0EaZXTef6oivkTG3UiJk+rP2wZDU8ILFMUW3vqteRnic+vCRNFngEtwzl590eB1U=
X-Received: by 2002:aa7:d594:0:b0:410:ef84:f706 with SMTP id
 r20-20020aa7d594000000b00410ef84f706mr16156277edq.347.1645986650062; Sun, 27
 Feb 2022 10:30:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645558375.git.riteshh@linux.ibm.com> <a62c8d1c0d8a01e2b1e3afc9c2b012c04c54b137.1645558375.git.riteshh@linux.ibm.com>
 <20220223094149.h5lj2dwq3sd5b3tp@quack3.lan>
In-Reply-To: <20220223094149.h5lj2dwq3sd5b3tp@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 27 Feb 2022 10:30:38 -0800
Message-ID: <CAD+ocbyhQ4OWO-s021hod=EQFJF_BKE4u0xyLXDNLzkZ_66Tuw@mail.gmail.com>
Subject: Re: [RFC 4/9] ext4: Do not call FC trace event if FS does not support FC
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

- Harshad

On Wed, 23 Feb 2022 at 01:41, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-02-22 02:04:12, Ritesh Harjani wrote:
> > This just puts trace_ext4_fc_commit_start(sb) & ktime_get()
> > for measuring FC commit time, after the check of whether sb
> > supports JOURNAL_FAST_COMMIT or not.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> Looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
> > ---
> >  fs/ext4/fast_commit.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index bf70879bb4fe..7fb1eceef30c 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -1167,13 +1167,13 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
> >       int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
> >       ktime_t start_time, commit_time;
> >
> > +     if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> > +             return jbd2_complete_transaction(journal, commit_tid);
> > +
> >       trace_ext4_fc_commit_start(sb);
> >
> >       start_time = ktime_get();
> >
> > -     if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> > -             return jbd2_complete_transaction(journal, commit_tid);
> > -
> >  restart_fc:
> >       ret = jbd2_fc_begin_commit(journal, commit_tid);
> >       if (ret == -EALREADY) {
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
