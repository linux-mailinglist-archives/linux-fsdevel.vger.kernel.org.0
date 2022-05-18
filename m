Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F081952B8B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiERL0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 07:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiERL0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 07:26:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761726176
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 04:26:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so3157411ejd.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EMfQpk6erK9ub9G2PqxUNXVnRn/iT6pIjOzaJWxdUQ=;
        b=EFvcrvCHjyi9PuElNhOPLPFE0B5ZVfrvp67pNgdvD+314Ynvizgkn/yjOtQJqKOiKq
         RBpnU0EmPsjt5XKKhMpb0k9HaEvnGFJ7f24G32UCpGLbC6vbdAfffR8w0z1viqJOTkV8
         SLGLDws/mgPJRjWrrroq1cgil0NgAULjRdmVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EMfQpk6erK9ub9G2PqxUNXVnRn/iT6pIjOzaJWxdUQ=;
        b=4bk5GXz41SKvvxTL+zbGHK4XXja32Mglqcr8q9oG88ujfErNzCvSyDKEAyFfqCyMit
         k4aH/dUXewj6/yO8rSY9cXpayv52Fu6HBdX9CyeGgg4m9l/vvO9tppUNzvffu53LPSiz
         Q7wux5Xx/OoRMv/qHinc05c4QM5WTrYVNnX1Mt+7qqyzB9Z2idxWATj0VQy4bwG0J1aQ
         Nsj1IQKCLdHhX51STe+PTwSjdZTw0vhbjzn7DdBO9Scluf35ZhhJNSSpVgGPoK/2JS5A
         HnFSl0y51HI3KddgPqrx+XBLXyXyNvwSP1s5dM9b5dQSZ3P5ejZYA0uXF/xYxXvKUrEi
         0siQ==
X-Gm-Message-State: AOAM5312jgU0cIEB8ReskkNgkfBgI5rOAuV1uhP+y6DxgAR3U6RUGEzJ
        g+4TG3cFnPfvgO0Eq1g4cNRCi//MSmjqR63yFX/a0A==
X-Google-Smtp-Source: ABdhPJyIwxRSeKDyJ4cXhnMaRhxYlNZbw1vLtIQDOgPb6rroVD5RCcxQdtddU5sDswoNvZ88GmulXqbi0NCs6PDUPLQ=
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id
 gg2-20020a170906898200b006f395f44adfmr23453083ejc.524.1652873177012; Wed, 18
 May 2022 04:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
 <20211112101307.iqf3nhxgchf2u2i3@wittgenstein> <0515c3c8-c9e3-25dd-4b49-bb8e19c76f0d@fb.com>
 <CAJfpegtBuULgvqSkOP==HV3_cU2KuvnywLWvmMTGUihRnDcJmQ@mail.gmail.com>
 <d6f632bc-c321-488d-f50e-749d641786d6@fb.com> <20220518112229.s5nalbyd523nxxru@wittgenstein>
In-Reply-To: <20220518112229.s5nalbyd523nxxru@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 May 2022 13:26:05 +0200
Message-ID: <CAJfpegtNKbOzu0F=-k_ovxrAOYsOBk91e3v6GPgpfYYjsAM5xw@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>,
        kernel-team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 May 2022 at 13:22, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, May 17, 2022 at 12:50:32PM -0400, Dave Marchevsky wrote:

> > Sorry to ressurect this old thread. My proposed alternate approach of "special
> > ioctl to grant exception to descendant userns check" proved unnecessarily
> > complex: ioctls also go through fuse_allow_current_process check, so a special
> > carve-out would be necessary for in both ioctl and fuse_permission check in
> > order to make it possible for non-descendant-userns user to opt in to exception.
> >
> > How about a version of this patch with CAP_DAC_READ_SEARCH check? This way
> > there's more of a clear opt-in vs CAP_SYS_ADMIN.
>
> I still think this isn't needed given that especially for the use-cases
> listed here you have a workable userspace solution to this problem.
>
> If the CAP_SYS_ADMIN/CAP_DAC_READ_SEARCH check were really just about
> giving a privileged task access then it'd be fine imho. But given that
> this means the privileged task is open to a DoS attack it seems we're
> building a trap into the fuse code.
>
> The setns() model has the advantage that this forces the task to assume
> the correct privileges and also serves as an explicit opt-in. Just my 2
> cents here.

Fully agreed.  Using CAP_DAC_READ_SEARCH instead of CAP_SYS_ADMIN
doesn't make this any better, since root has all caps including
CAP_DAC_READ_SEARCH.

Thanks,
Miklos
