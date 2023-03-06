Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8C6ACDDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 20:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCFTSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 14:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCFTSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:18:25 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A4421C
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 11:18:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cw28so43125805edb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 11:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1678130302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbDbkrtYIaj4h/JEt+PGK5ggFWdbYGJfSSTneNQay2I=;
        b=j/07IYjSLrbP9Eed2enqYxlX9HMGoSoiQUuwQx9dFVyPpB3YRAMSeLD9HaWSLpNvYu
         rdpyWP6BteBn7g2st0KtOpwue3ypCyVyHqL7KkagjXQ/Xleg57j0JY3rvKcf8dI7ME4z
         /dfVGyjtzWyQ7xEi+8locFLvagSsTZ6wt9YqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678130302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbDbkrtYIaj4h/JEt+PGK5ggFWdbYGJfSSTneNQay2I=;
        b=zyZWORnSJNO0U7M5ic7ulXtXmnfAOr+USaqI64jOH+hkBVWob0b+WNqmuFUmEKuM5U
         49VyiPDpDtqLrX+QK8bg6cIQnQdNE2cdwLFgCLoGQih3KEyF0Ly/97MGqLrdXJSvLVsL
         BFOSLIrz71syh+YdPsqMBVUS6q5Iz10iTU3Gqz7JKGqbRG4HduBnZ2p71NCXgIkzCKkM
         vnrepBRNK/JNkewSf1EWeOeCrY/PS9Kcslm0Q7ymzHffAauF6bOcuBzQ4zqQk8/5VvDR
         +39QErj3xk0cUM4q6JO9a4ZUs6I1O7niapLnCXtTneqXN6MKsEzDBsQb+yUyUzKJz1x5
         FH9w==
X-Gm-Message-State: AO0yUKU1f0/8qe1WB3ljXD0tvgGH5b5venFfMCOdpZ4mHqqA3Vm00aeC
        QnWDZzQqx5LTT3TFWRyPBv2UPU9talUG674W9eGSXw==
X-Google-Smtp-Source: AK7set9r6F6+ciMT23z4zIyc6eSsWKiXVPrmgrbAFXs3L+sQF77q3SaEIRL9LWHOYyUh2e/b+JTXgVDt4xSUBnGetuA=
X-Received: by 2002:a17:906:edac:b0:8f3:9ee9:f1e2 with SMTP id
 sa12-20020a170906edac00b008f39ee9f1e2mr5847569ejb.5.1678130301984; Mon, 06
 Mar 2023 11:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegvQyD-+EL2DdVWmyKF8odYWj4kAONyRf6VH_h4JCTu=vg@mail.gmail.com> <CAEivzxdX28JhA+DY92nTGn56kmMgdeT9WX__j7NU3QHpg+wcdQ@mail.gmail.com>
In-Reply-To: <CAEivzxdX28JhA+DY92nTGn56kmMgdeT9WX__j7NU3QHpg+wcdQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Mar 2023 20:18:11 +0100
Message-ID: <CAJfpeguYO9J=np5vxH+HjCSAxn=8fcQRhh_-BVadTt86zWfkpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     mszeredi@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org, flyingpeng@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Mar 2023 at 17:44, Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Mon, Mar 6, 2023 at 5:15=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:

> > Apparently all of the added mechanisms (REINIT, BM_REVAL, conn_gen)
> > are crash recovery related, and not useful for C/R.  Why is this being
> > advertised as a precursor for CRIU support?
>
> It's because I'm doing this with CRIU in mind too, I think it's a good
> way to make a universal interface
> which can address not only the recovery case but also the C/R, cause
> in some sense it's a close problem.

That's what I'm wondering about...

Crash recovery is about restoring (or at least regenerating) state in
the userspace server.

In CRIU restoring the state of the userspace server is a solved
problem, the issue is restoring state in the kernel part of fuse.  In
a sense it's the exact opposite problem that crash recovery is doing.

> But of course, Checkpoint/Restore is a way more trickier. But before
> doing all the work with CRIU PoC,
> I wanted to consult with you and folks if there are any serious
> objections to this interface/feature or, conversely,
> if there is someone else who is interested in it.
>
> Now about interfaces REINIT, BM_REVAL.
>
> I think it will be useful for CRIU case, but probably I need to extend
> it a little bit, as I mentioned earlier in the cover letter:
> > >* "fake" daemon has to reply to FUSE_INIT request from the kernel and =
initialize fuse connection somehow.
> > > This setup can be not consistent with the original daemon (protocol v=
ersion, daemon capabilities/settings
> > > like no_open, no_flush, readahead, and so on).
>
> So, after the "fake" demon has done its job during CRIU restore, we
> need to replace it with the actual demon from
> the dumpee tree and performing REINIT looks like a sanner way.

I don't get it.  How does REINIT help with switching to the real daemon?

Thanks,
Miklos
