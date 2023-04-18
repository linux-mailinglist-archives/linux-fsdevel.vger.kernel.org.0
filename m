Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838E36E6C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjDRS56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 14:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjDRS54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:57:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3837AAB
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 11:57:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b16so535486ejz.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1681844268; x=1684436268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GSERGVeyYy5gOumd7ZQabQRKLkbDoehFS3JN/G8r4M=;
        b=SHe3bi91ejtLhjHnWeweNb/YLocrBc9gHmlQcjVirsvLkEanSEwODKFStZNvPnf/QD
         3X467qTgK5CHzdCMWMYJcb1/IzjZT9+laquRt3c+eh08dPFbxjZERokjK/4ivTuGdj5v
         c52kKCJEpjDCf4Ml7EVMzD4pP1ugoFf6ZKgjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681844268; x=1684436268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GSERGVeyYy5gOumd7ZQabQRKLkbDoehFS3JN/G8r4M=;
        b=Iq353WzEOUSQ2M3sMOcMRd5gwAnG1Lax1Dr4XR5Hf2tVKAOYVKD7FFO71D1rTHy8dz
         ISF7BrrU2wEZFnW2Nm2qi7/dGojq9B5XXqu7zcEAbec1T9urQmBfu20h8WuV/DiDYG0H
         HJIlYV2l1TGB6rYqiwUg3AG9SncCZsv//7Cjr8iE4aVrVq1Eqwocn7hkj45rvc2oIdZI
         C/9ugM7KNULzsmHxV0IWWnPJS2tE7rYV4siWILCCc4LLpq7c3p3Tho/IBpMS7B6OCr+G
         WOLFxQHxaoNa8wK/9Xr6Qqkd6YdNvwlo+XQau5DA4QppcSFlZtO0yUxLmvoZx14DDpcH
         xypg==
X-Gm-Message-State: AAQBX9fK/6RxCjuBlwJLe0F1lxgiC2rpihY1idjK4FlS50HNRM1/JVfC
        o9X9cJkLt9wj5Cqct/8Cwd0Dp61bwLwNJqaM4RFkwzUOXfMZgWtiJ5k=
X-Google-Smtp-Source: AKy350YKNG0gWlAmW1HGq2BBzOrP58IVGmMXpuSH5F3Sw9k4ZDfpQrxrolfeCWLetdjEuhw69ZMeBP//gAM8UGylI9U=
X-Received: by 2002:a17:906:ae56:b0:932:1af9:7386 with SMTP id
 lf22-20020a170906ae5600b009321af97386mr11695725ejb.27.1681844268047; Tue, 18
 Apr 2023 11:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
 <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
 <CAOQ4uxhYi2823GiVn9Sf-CRGrcigkbPw2x1VQRV3_Md92gJnrw@mail.gmail.com>
 <CAJfpegsLD-OxYfqPR7AfWbgE1EAPfWs672omt+_u8sYCMFB5Fg@mail.gmail.com> <CAOQ4uxhz7g=N0V8iGiKa2+vupEuH_m9_27kas++6c0bLL2qRyA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhz7g=N0V8iGiKa2+vupEuH_m9_27kas++6c0bLL2qRyA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Apr 2023 20:57:36 +0200
Message-ID: <CAJfpegt38gHcNeEt1mwOYHeMYdVEbj0RhZEs-4iYG7VPJhYDzQ@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] fsinfo and mount namespace notifications
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Apr 2023 at 17:57, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Apr 18, 2023 at 11:54=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:

> > - mount ID's do not uniquely identify a mount across time
> >   o when a mount is deleted, the ID can be immediately reused
> >
> > The following are the minimal requirements needed to fix the above issu=
es:
> >
> > 1) create a new ID for each mount that is unique across time; lets
> > call this umntid
> >
>
> Do you reckon we just stop recycling mntid?
> Do we also need to make it 64bit?
> statx() has already allocated 64bit for stx_mnt_id.
> In that case, should name_to_handle_at() return a truncated mnt_id?

I'm not sure it's realistic to implement the new 64bit ID such that
the truncated value retains the properties of the previous mount ID
implementation.

I think the only sane option is to leave the old mnt_id alone and add
a new 64bit one that is assigned from an atomic counter at allocation
and looked up using a hash table.

> > - mount notifications using watch_queue
> >
> > https://lore.kernel.org/all/159645997768.1779777.8286723139418624756.st=
git@warthog.procyon.org.uk/
> >
> > I also explored fsnotify infrastructure for this.  I think the API is
> > better fit, since we are talking about filesystem related events, but
> > notifications l would need to be extended with the mount ID.
>
> Like this? ;-)
>
> https://lore.kernel.org/linux-fsdevel/20230414182903.1852019-1-amir73il@g=
mail.com/
>
> I was considering whether fanotify should report a 32bit mntid
> (like name_to_handle_at()) or 64bit one (like statx()).
> I should probably go with the latter then.

Or a 32+64bit one, like I said.

Thanks,
Miklos
