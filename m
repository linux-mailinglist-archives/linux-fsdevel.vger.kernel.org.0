Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0CC7BB067
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 04:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjJFC4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 22:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjJFC4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 22:56:22 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C7E7
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 19:56:20 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d89ba259964so1864240276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Oct 2023 19:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696560979; x=1697165779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHArqxu2qvv+0QWfp9YXmo0v1ys/eNAvTHWEBAqut18=;
        b=ajSKYXOro6poGXXUa2xNDgWiay9AME4I17RTXh6yZTxpQS+CWtFw35WTy01NS+Nc4s
         7qn9Lq87Eyx6Sh7QUByM2XZag6WbGko6TTgAgYv3dfV1SnO9UxA0yp5sBeI7lFfI8fr6
         xZolX9+dexXjLMRrihXCsHUuqb3Nfcw8KxAy2tAEOYYkEunCkd/4jbttmLjJRHF4o6yZ
         a62vh4n/+NtmixCzs8k4yFjDztO7FCI1zqNBK2lMso+Ztg2TawGLsQQUEC48n1Qg17vH
         ceMB7Uc/ruF+vTS4S/AbfojCHeFMnKZ/khLOdQ+2x9hoBt7rcXotjk79ikqVAe1+Cjt5
         D7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696560979; x=1697165779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHArqxu2qvv+0QWfp9YXmo0v1ys/eNAvTHWEBAqut18=;
        b=geOzWurHepXLFbh/6++t6zuNFVVyfC2XmA+dmDVnm1NoG9dY7j4YGSFVrig+LRV/a1
         YAEZ3z3+Fuxh4HWEBPi67Jaw2eprjbqw5DJjklQssdYt8dAOFWO9M6s0bvJd6VMaLs5K
         Q2ZF4PlXiP2ZaKXn9nCLirPabNJs3ybjTSa6oEUoWJGF8M1BCS1fKsRzp+0VhKA/qHje
         ai2FSdtkwkuDvA2uXIrjM0u0v+X/yuCpKaKGtDTb4YzpOoOi2z6wXxwkYh/WHWCsPGJT
         khSmtqxKA4ujcm7B32BfhqfaWpjG3QgHTvIddoudJ9RwACgoJCtA/RDWq6aJjKFmdh4q
         JjjA==
X-Gm-Message-State: AOJu0Yygs+JvKJrBvzlPUpCrxAQZrJL5KKAZ/RkHyfDbHwNTWtFuRV/1
        NE8O5MxWC+b3tbaqn0TBEAI6DWnTn+nBSIvKznl/
X-Google-Smtp-Source: AGHT+IHre+a34KZNGIs0z++veEpRz77t1WlEFWTAbeLlkjBKLMPcIoQncO3aQ0/CHJ2xAP9H60aKr56+aFyEAFaH3e8=
X-Received: by 2002:a25:556:0:b0:d0f:6f1d:89ec with SMTP id
 83-20020a250556000000b00d0f6f1d89ecmr6477803ybf.35.1696560979263; Thu, 05 Oct
 2023 19:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net> <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
In-Reply-To: <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Oct 2023 22:56:08 -0400
Message-ID: <CAHC9VhTwnjhfmkT5Rzt+SBf-8hyw4PYkbuPYnm6XLoyY7VAUiw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 5, 2023 at 11:47=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
> On Thu, 5 Oct 2023 at 06:23, Ian Kent <raven@themaw.net> wrote:
> > The proc interfaces essentially use <mount namespace>->list to provide
> >
> > the mounts that can be seen so it's filtered by mount namespace of the
> >
> > task that's doing the open().
> >
> >
> > See fs/namespace.c:mnt_list_next() and just below the m_start(), m_next=
(),
>
> /proc/$PID/mountinfo will list the mount namespace of $PID.  Whether
> current task has permission to do so is decided at open time.
>
> listmount() will list the children of the given mount ID.  The mount
> ID is looked up in the task's mount namespace, so this cannot be used
> to list mounts of other namespaces.  It's a more limited interface.
>
> I sort of understand the reasoning behind calling into a security hook
> on entry to statmount() and listmount().  And BTW I also think that if
> statmount() and listmount() is limited in this way, then the same
> limitation should be applied to the proc interfaces.  But that needs
> to be done real carefully because it might cause regressions.  OTOH if
> it's only done on the new interfaces, then what is the point, since
> the old interfaces will be available indefinitely?

LSMs that are designed to enforce access controls on procfs interfaces
typically leverage the fact that the procfs interfaces are file based
and the normal file I/O access controls can be used.  In some cases,
e.g. /proc/self/attr, there may also be additional access controls
implemented via a dedicated set of LSM hooks.

> Also I cannot see the point in hiding some mount ID's from the list.
> It seems to me that the list is just an array of numbers that in
> itself doesn't carry any information.

I think it really comes down to the significance of the mount ID, and
I can't say I know enough of the details here to be entirely
comfortable taking a hard stance on this.  Can you help me understand
the mount ID concept a bit better?

While I'm reasonably confident that we want a security_sb_statfs()
control point in statmount(), it may turn out that we don't want/need
a call in the listmount() case.  Perhaps your original patch was
correct in the sense that we only want a single security_sb_statfs()
call for the root (implying that the child mount IDs are attributes of
the root/parent mount)?  Maybe it's something else entirely?

--=20
paul-moore.com
