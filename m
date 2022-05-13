Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C368F525913
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 02:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359788AbiEMAqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359802AbiEMAqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 20:46:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9166201
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 17:46:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i10so11847156lfg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 17:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knHMRJixLOAGSjCAzt+KDHGWqZ6HewC/MJ/9blaGmh4=;
        b=VVXNnhYlFuL7cKP5b5jF3jjpXEVvaRmL8lvt4DKAAIoDq197eZcH3Bw2rC2/fd4L/T
         EQKahsOrrkyZq4Q57fQ2tK/gesAwrcJdQmNuscHQnQNqzrC40qiqI0xNlkoZcIZHnHv8
         lR4esKgRExl41C7yabaInNZEKRuJqVfR4b0PSQpqYaXCy792Ng++OkteBh/Dpa9HWaSn
         1MRYhwcjjinUzMf98ziteBM/DU8Mmi4tEK0+adaa7ZQ5bfb1AvSMQPeZ5K7m0UfdTEw/
         vcKeqE59h0Hg3cb23CwaWa+jgul6qfPkEoUumlOHt2my6N+cM2fHLTY2p+DSAF50j5IG
         LRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knHMRJixLOAGSjCAzt+KDHGWqZ6HewC/MJ/9blaGmh4=;
        b=HyUfEHz8dTk0XwNRIiavt2CVu+5WB5B//fiYpFsMtFrm203GlHLFbxL2sZ9x9cLCza
         hb/5DXg6mxRAK/sBs1Xujj8Al7vd66xRV89eOVLdkFQUYyJ85Qz4yFGcs1W65Chbl+au
         kH+WBDNY/z6L0w8wBnnRGWMJZNl3VxFzJWehoTaV4dAPS1M501VVdx6Kdp4Wvu07E15L
         z/6xQU57y2MiJ5IP8O51eNELo33x7DqAAw7NMRbFsmuup60nFYOQrh7Sp2XcdhBFGfml
         t/zTv0mwGuVLzD//zMx9hGC8vLDyizs4wy3stuc/05HbQGVbbHXuuENJOGrf6LrdZRwl
         alww==
X-Gm-Message-State: AOAM5300y86cwFVNZWoACBsHICvA8KJuLQzzLTuw7ai4PgkbSIkfP/eo
        mu0SWHaOKPSqmaXOgm7W0raKwIxR/yi3SXPk+rghhRgmGgY=
X-Google-Smtp-Source: ABdhPJx4issx6reR03dQniJXLbvuVUwS5SU4RWJv1a/vjjNVfFHjnSVbF99NAxqDIlgN7pphGoZVreTBMD1Cj24DTkU=
X-Received: by 2002:a05:6512:e86:b0:472:60c3:8430 with SMTP id
 bi6-20020a0565120e8600b0047260c38430mr1680909lfb.226.1652402786122; Thu, 12
 May 2022 17:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <Yn16M/fayt6tK/Gp@zeniv-ca.linux.org.uk> <4239a930-2765-a798-4831-d7c0d135c681@kernel.dk>
In-Reply-To: <4239a930-2765-a798-4831-d7c0d135c681@kernel.dk>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 12 May 2022 17:46:14 -0700
Message-ID: <CAHRSSEzo2Fs+vkCbgXQ+ybiusKap-Fw55pv2OXkESKx6_70=+A@mail.gmail.com>
Subject: Re: [RFC] unify the file-closing stuff in fs/file.c
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 4:48 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/12/22 3:20 PM, Al Viro wrote:
> >       Right now we have two places that do such removals - pick_file()
> > and {__,}close_fd_get_file().
> >
> >       They are almost identical - the only difference is in calling
> > conventions (well, and the fact that __... is called with descriptor
> > table locked).
> >
> >       Calling conventions are... interesting.
> >
> > 1) pick_file() - returns file or ERR_PTR(-EBADF) or ERR_PTR(-EINVAL).
> > The latter is for "descriptor is greater than size of descriptor table".
> > One of the callers treats all ERR_PTR(...) as "return -EBADF"; another
> > uses ERR_PTR(-EINVAL) as "end the loop now" indicator.
> >
> > 2) {__,}close_fd_get_file() returns 0 or -ENOENT (huh?), with file (or NULL)
> > passed to caller by way of struct file ** argument.  One of the callers
> > (binder) ignores the return value completely and checks if the file is NULL.
> > Another (io_uring) checks for return value being negative, then maps
> > -ENOENT to -EBADF, not that any other value would be possible.
> >
> > ERR_PTR(-EINVAL) magic in case of pick_file() is borderline defensible;
> > {__,}close_fd_get_file() conventions are insane.  The older caller
> > (in binder) had never even looked at return value; the newer one
> > patches the bogus -ENOENT to what it wants to report, with strange
> > "defensive" BS logics just in case __close_fd_get_file() would somehow
> > find a different error to report.
> >
> > At the very least, {__,}close_fd_get_file() callers would've been happier
> > if it just returned file or NULL.  What's more, I'm seriously tempted
> > to make pick_file() do the same thing.  close_fd() won't care (checking
> > for NULL is just as easy as for IS_ERR) and __range_close() could just
> > as well cap the max_fd argument with last_fd(files_fdtable(current->files)).
> >
> > Does anybody see problems with the following?
>
> Looks good to me, and much better than passing in the pointer to the
> file pointer imho.

I agree. This looks good.

>
> --
> Jens Axboe
>
