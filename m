Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF777ABE50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjIWHQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 03:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjIWHQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:16:03 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC571BF;
        Sat, 23 Sep 2023 00:15:57 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7740cedd4baso186909085a.2;
        Sat, 23 Sep 2023 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695453356; x=1696058156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq/skgo905Vb9/3MwnhaYiR/WZVaQLzfkn7Q0xwOaVM=;
        b=TybaS8F/nbhHBtI+uG5Bhk1kdqVaWqa7WIkgRkuK4edSkkMkwSxMP9tAsYzrXkvrhg
         FtxhknsRBlzS5rWOPzHs6vP+V8LbkbffQEhcxX4RdwNHq3lPjwb+Hub/V5xi9i4vL4Me
         x4Ombg1eP1HMxEDz/PnBL3Tp9r1G0SB62N90TsgJ3ybgmyrPH/4u/Sei0Y6RKFIXXNSi
         bS9dssGXW44B74GjZy5YGAJ72dqGa9h5H2rpRwtyJ5HozxygmJrOqQrcz1IWMSf5l2OA
         UFwvTnzQwWgcTny3u8wYJEqq3EcxIJchSIALKC8ZsIFMUyP3//gvtro1134NE6dSvwqA
         stDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695453356; x=1696058156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq/skgo905Vb9/3MwnhaYiR/WZVaQLzfkn7Q0xwOaVM=;
        b=Q+piDx/afMUA+o12Blf9FrVK94vHuV2LUhmmk4kLmQoa3Tr0Z2i/o3+qCKP+Mes/qK
         XacMTOHQ1DMDALgtxGMs8vDOlugY7uq66k2T/JIyiQK83STQPf835HVXBOreHEYtWzLx
         TP9/mkGCOafKlzQRcY7jQo3ulggejl0vbylMUgeMu7gNMkNXeWhAqQKpNTcPszhCibOa
         8MQvh429iWPKvwgAzOJuBmBywIdv1iR2yahBk3av93EPBfFwS5WbmVZ7HSSpYQLnRtTS
         bO0aO4yIJ9iQ8TUoNi6xe0q0aatPog2h4Q+4vcmBPnSV1U6JXBv9Ty6vW8K43ZK4RPCc
         sdcw==
X-Gm-Message-State: AOJu0YyReCQyB8GAEPTENANPNVRd3Voy1cwczv4CNggOjJpTZeLw/zXy
        kfoKkFczxfxi2o+I0GIHv+XwaMNBf4rp3+FGuPs=
X-Google-Smtp-Source: AGHT+IEjj93Q9CjBjKmJa89VT07cL5uAnx8qE9Hd9D6Ihv0LNya0uNzBjdJvjMascKhjH86Cw0EG1gCRnPVnGI9pBR0=
X-Received: by 2002:a05:620a:2698:b0:774:111b:7fb8 with SMTP id
 c24-20020a05620a269800b00774111b7fb8mr1563265qkp.73.1695453356092; Sat, 23
 Sep 2023 00:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
In-Reply-To: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 23 Sep 2023 10:15:44 +0300
Message-ID: <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
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

On Fri, Sep 22, 2023 at 8:15=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> My initial goal was to implement multigrain timestamps on most major
> filesystems, so we could present them to userland, and use them for
> NFSv3, etc.
>
> With the current implementation however, we can't guarantee that a file
> with a coarse grained timestamp modified after one with a fine grained
> timestamp will always appear to have a later value. This could confuse
> some programs like make, rsync, find, etc. that depend on strict
> ordering requirements for timestamps.
>
> The goal of this version is more modest: fix XFS' change attribute.
> XFS's change attribute is bumped on atime updates in addition to other
> deliberate changes. This makes it unsuitable for export via nfsd.
>
> Jan Kara suggested keeping this functionality internal-only for now and
> plumbing the fine grained timestamps through getattr [1]. This set takes
> a slightly different approach and has XFS use the fine-grained attr to
> fake up STATX_CHANGE_COOKIE in its getattr routine itself.
>
> While we keep fine-grained timestamps in struct inode, when presenting
> the timestamps via getattr, we truncate them at a granularity of number
> of ns per jiffy,

That's not good, because user explicitly set granular mtime would be
truncated too and booting with different kernels (HZ) would change
the observed timestamps of files.

> which allows us to smooth over the fuzz that causes
> ordering problems.
>

The reported ordering problems (i.e. cp -u) is not even limited to the
scope of a single fs, right?

Thinking out loud - if the QERIED bit was not per inode timestamp
but instead in a global fs_multigrain_ts variable, then all the inodes
of all the mgtime fs would be using globally ordered timestamps

That should eliminate the reported issues with time reorder for
fine vs coarse grained timestamps.

The risk of extra unneeded "change cookie" updates compared to
per inode QUERIED bit may exist, but I think it is a rather small overhead
and maybe worth the tradeoff of having to maintain a real per inode
"change cookie" in addition to a "globally ordered mgtime"?

If this idea is acceptable, you may still be able to salvage the reverted
ctime series for 6.7, because the change to use global mgtime should
be quite trivial?

Thanks,
Amir.
