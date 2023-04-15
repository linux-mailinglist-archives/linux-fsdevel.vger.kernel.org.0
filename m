Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4349D6E3122
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDOLfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 07:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOLfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 07:35:37 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921ED44BA;
        Sat, 15 Apr 2023 04:35:35 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id f10so7314863vsv.13;
        Sat, 15 Apr 2023 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681558534; x=1684150534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQuUOaQjNnI3LhQDwWrlJuNdVQ2r+6got/EIYQa54mo=;
        b=hT8wjsnNTBtxNV9WKobkwO35hvbv+s93dkHMP++9f/1/yX96veY5u3ERIYT2T46NVk
         KszWwLe9zlujxutksbHT6u2NeQBjlwdwLFftNaWqnjqjD1G6zgxNDZGv8ZJNX2oNgN8i
         fT4HiGQiWIp0HZCXFnwKxN7+dfVSymYT3G8vggYn0UKwtU+DhbzPdgBP95gt4HGW9aBM
         ZTBFHjRIY5BqF2DubsYiASXywhfP4L2sjB8g5o0YTDGt0W6mi1SBXPvv4+8/6lCGorOp
         fhHMxv53wlfXEg/Kx7BN1S6K7+m8BwqYCQs11r0H+CdrBx2zz2z62OZi22t5QslJRQdY
         JfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681558534; x=1684150534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQuUOaQjNnI3LhQDwWrlJuNdVQ2r+6got/EIYQa54mo=;
        b=XfwxR0SQ1VQF5imKRovVPqFswDJpBSGWS14isBq0Qxe/fRkc6EAoTy0Ln3v7oozuoT
         BV75Yhg9E4kXXZDAetzpiEE0ogBSHy2BArQWMXDybRLCdxjjE4BIUDtTLh1aM63Zdfkw
         xWYVhNbUYaKAHZZ3Rx1CwL6KStL2uEnMU+NvDV4z6xwcNqMeIwyJxUCwVDnPsmcXsHWG
         AbaPASPzNdWKSKH+LOZMpARRz5KfSshKMLehbT1eKF/+lxPUA4E+8JscApvtL0yheSZW
         CB7s7mC7hxP/JgyBBSM/PVXh6aTnWbWCxkDyuFuJmi00bnlXyXAyKPKcMjeeaClP+9xu
         7Thw==
X-Gm-Message-State: AAQBX9eZ4Dzv/NGtSttNVNy5JTQUe87iXaNhrNxcWkgk7fPh41tVjySl
        DsfKU3GWuQwDJ3WUD2vlW8QS1BsTEGiO4+61YqM=
X-Google-Smtp-Source: AKy350Za/ZW99Sc2eyyPRafhDAV9O3OPsz4ldcuWs1DITk9ZzkGG9vMclYoTfMfN65WHNKYQ3O0J3rDvritmjvle96g=
X-Received: by 2002:a67:e04f:0:b0:42c:48e9:4fe0 with SMTP id
 n15-20020a67e04f000000b0042c48e94fe0mr4869637vsl.0.1681558534297; Sat, 15 Apr
 2023 04:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230411143702.64495-1-jlayton@kernel.org>
In-Reply-To: <20230411143702.64495-1-jlayton@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 15 Apr 2023 14:35:23 +0300
Message-ID: <CAOQ4uxi9rz1GFP+jMJm482axyAPtAcB+jnZ5jCR++EYKA_iRpw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3][RESEND] fs: opportunistic high-res file timestamps
To:     Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
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

On Tue, Apr 11, 2023 at 5:38=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> (Apologies for the resend, but I didn't send this with a wide enough
> distribution list originally).
>
> A few weeks ago, during one of the discussions around i_version, Dave
> Chinner wrote this:
>
> "You've missed the part where I suggested lifting the "nfsd sampled
> i_version" state into an inode state flag rather than hiding it in
> the i_version field. At that point, we could optimise away the
> secondary ctime updates just like you are proposing we do with the
> i_version updates.  Further, we could also use that state it to
> decide whether we need to use high resolution timestamps when
> recording ctime updates - if the nfsd has not sampled the
> ctime/i_version, we don't need high res timestamps to be recorded
> for ctime...."
>
> While I don't think we can practically optimize away ctime updates
> like we do with i_version, I do like the idea of using this scheme to
> indicate when we need to use a high-res timestamp.
>
> This patchset is a first stab at a scheme to do this. It declares a new
> i_state flag for this purpose and adds two new vfs-layer functions to
> implement conditional high-res timestamp fetching. It then converts both
> tmpfs and xfs to use it.
>
> This seems to behave fine under xfstests, but I haven't yet done
> any performance testing with it. I wouldn't expect it to create huge
> regressions though since we're only grabbing high res timestamps after
> each query.
>
> I like this scheme because we can potentially convert any filesystem to
> use it. No special storage requirements like with i_version field.  I
> think it'd potentially improve NFS cache coherency with a whole swath of
> exportable filesystems, and helps out NFSv3 too.
>
> This is really just a proof-of-concept. There are a number of things we
> could change:
>
> 1/ We could use the top bit in the tv_sec field as the flag. That'd give
>    us different flags for ctime and mtime. We also wouldn't need to use
>    a spinlock.
>
> 2/ We could probably optimize away the high-res timestamp fetch in more
>    cases. Basically, always do a coarse-grained ts fetch and only fetch
>    the high-res ts when the QUERIED flag is set and the existing time
>    hasn't changed.
>
> If this approach looks reasonable, I'll plan to start working on
> converting more filesystems.
>
> One thing I'm not clear on is how widely available high res timestamps
> are. Is this something we need to gate on particular CONFIG_* options?
>
> Thoughts?

Jeff,

Considering that this proposal is pretty uncontroversial,
do you still want to discuss/lead a session on i_version changes in LSF/MM?

I noticed that Chuck listed "timespamt resolution and i_version" as part
of his NFSD BoF topic proposal [1], but I do not think all of these topics
can fit in one 30 minute session.

Dave,

I would like to use this opportunity to invite you and any developers that
are involved in fs development and not going to attend LSF/MM in-person,
to join LSF/MM virtually for some sessions that you may be interested in.
See this lore query [2] for TOPICs proposed this year.

You can let me know privately which sessions you are interested in
attending and your time zone and I will do my best to schedule those
sessions in time slots that would be more convenient for your time zone.

Obviously, I am referring to FS track sessions.
Cross track sessions are going to be harder to accommodate,
but I can try.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/FF0202C3-7500-4BB3-914B-DBAA3E0EA=
3D7@oracle.com/
[2] https://lore.kernel.org/linux-fsdevel/?q=3DLSF+TOPIC+-re+d%3A4.months.a=
go..
