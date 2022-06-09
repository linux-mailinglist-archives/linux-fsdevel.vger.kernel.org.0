Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1065442AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 06:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiFIEgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 00:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiFIEgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:36:10 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98247B07;
        Wed,  8 Jun 2022 21:36:08 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id g6so3248969vsb.2;
        Wed, 08 Jun 2022 21:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K/i8DYT2ygHvcWIB+TGUjE1cSyP6RpUZJ+cTGMu/weo=;
        b=MkX92/OX5Jd4R4X4Wew8Jy/pDaEgc8pKlkmzkvLpPA1RUmP9CwVAp4mDE0zWuRwoUN
         sHJfzwPkd7kyPFb1HFLU+lLqulZbVnaaJGRs1WgCYAIsflL3FZJ8DzogP+jRp2TVLwf1
         Ne13c4/6HFu8/8IzAfMynFRc/lfRr7q2bylvhRRBJ1mj8iNGM0XBm0zXYDQ04W8q0RVJ
         M024CeoPPCByj+d1HofI1imrGXkc0KUN8Xmnu7ET4Vy0hhKGQ6DU3tpsZQyrpFEgPPJU
         AszWyNxmxvXHkSVqZngAalYpGEcQqo3tNjp0yZ7iw/HSovXDXWPJqho0jtJwHvyzbefv
         4wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K/i8DYT2ygHvcWIB+TGUjE1cSyP6RpUZJ+cTGMu/weo=;
        b=Y89a01FnxkPJe0XhmH37dkKgHDR1Upl1a+2s6tMrspHz60jLkcPB7c0aWxP2vem9t8
         tl1Hwt0wVX+vf3swW2iIBExUvtxGoWmvefaku7XY/qx/vr5jBNyO90wjH/W39B+9PC4D
         AzjgSHan21K3YpRg4RQWL7NqJZ/C33QawvS5GfERvmbMIDLU0kjQbKgjPyVvMx+iRaB9
         n8yWuc8lz1USrGa1SSZnFnO+SKP1iovCwu75KrbihX7q99rRcS+eZJ7R267YGoYwQ2wd
         DwJOJZ89S/qcstG3YOezK+k5EXkjNsNlb/TL/4PiN68UnDXMiP5IqJk+/6fOsZqGzoao
         o9Vg==
X-Gm-Message-State: AOAM532mCVz7072ZAJgyzG2nNZ6uei+re07zrdJuQa9v/f6ArpW75Qv6
        To57dIeLXQd5zbnxgcVOxZ7zLuJG8fz9RQ0o5No=
X-Google-Smtp-Source: ABdhPJxATreDqd9IudoNJR6VJZ9zNaC3pZreydmxwBOzXGiSBfrzQ6mEOynR6Y9h2KoqVyCehMYW3nQHz1cKElRa+b4=
X-Received: by 2002:a67:70c4:0:b0:349:d442:f287 with SMTP id
 l187-20020a6770c4000000b00349d442f287mr17213314vsc.2.1654749367725; Wed, 08
 Jun 2022 21:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com> <08A11E25-0208-4B4F-8759-75C1841E7017@dilger.ca>
In-Reply-To: <08A11E25-0208-4B4F-8759-75C1841E7017@dilger.ca>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 Jun 2022 07:35:56 +0300
Message-ID: <CAOQ4uxh1QG_xJ0Ffh=wKksxWKm1ioazmc8SxeYYH9yHT1PMasg@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 8, 2022 at 9:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Jun 7, 2022, at 9:31 AM, Christian G=C3=B6ttsche <cgzones@googlemail.c=
om> wrote:
> >
> > From: Miklos Szeredi <mszeredi@redhat.com>
> >
> > Support file descriptors obtained via O_PATH for extended attribute
> > operations.
> >
> > Extended attributes are for example used by SELinux for the security
> > context of file objects. To avoid time-of-check-time-of-use issues whil=
e
> > setting those contexts it is advisable to pin the file in question and
> > operate on a file descriptor instead of the path name. This can be
> > emulated in userspace via /proc/self/fd/NN [1] but requires a procfs,
> > which might not be mounted e.g. inside of chroots, see[2].
>
> Will this allow get/set xattrs directly on symlinks?  That is one problem
> that we have with some of the xattrs that are inherited on symlinks, but
> there is no way to change them.  Allowing setxattr directly on a symlink
> would be very useful.

It is possible.
See: https://github.com/libfuse/libfuse/pull/514

That's why Miklos withdrew this patch:
https://lore.kernel.org/linux-fsdevel/CAOssrKeV7g0wPg4ozspG4R7a+5qARqWdG+Gx=
WtXB-MCfbVM=3D9A@mail.gmail.com/

Thanks,
Amir.
