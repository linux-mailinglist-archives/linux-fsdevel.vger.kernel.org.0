Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1C396839
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 21:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEaTEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhEaTEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 15:04:35 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC6BC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 12:02:53 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x18so5229062ila.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RZ7BAyySEJy4Lyl5uxB2d32KZdqXL0StXiQ19LEPFuU=;
        b=KvpssveBeWcliCHLZfKlKDLhTjoAH/TKYAtzvMOgG9cayhrqW+hhlN/mm+rBWXWekv
         HLoith0Ls6KRJmODQe73O9wSwujXwqkvaE/oV9sqmzdvLw5wgKuNZvOk0M8DKhuQCRNs
         BjMTwP5Y6JE2VAtsDRFinb+BJ8IWaI93VoyJ/RVDyKBXNqpjnJuM+pYb1uGNv8SY741H
         OWqT72a4aREKXz3ZEtX331u97R2+XUUC8csQqVvEfPRqiZPUOUiGdg2o8lrkYypVTa4i
         pTPWPDfAd7HYHpk4MWaK5L6gePJUOtm0hgNtsd88UNhkyzRuZj6Llj3a7Mk4n0sJsWaT
         bCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RZ7BAyySEJy4Lyl5uxB2d32KZdqXL0StXiQ19LEPFuU=;
        b=HOXZh5NOsKJpNC/H5CjAAgg/vLfr/zGPa756MnNCZu72BASAfmeP2Q8JhJ1R/0i+Sz
         jy/NDjC3hfL7dODI5KKbtcliwx059MOyHnT0QO1gH2Muarfhpfg8F40/ydqTjCvBzCnx
         o+5KfJ2KR79c3bUqAfzJJKwb3Bt6YNVVnvUbo8sWSVTLufKcWsUYkRdkXOhHZYKcVFTf
         aSKQ14IQezVgvEmi7eEo/FnUBEcc4hKdwquHSQ6G7TZG/MJE5WUWiewjk98uQspfaiib
         m2pUDm/QGaxSFspN/FwWNhfR40rJmxuLYKG2qdw7rfiAu8wG4e7ljQamwi3W5BbypQzg
         fchA==
X-Gm-Message-State: AOAM531KitzlMB5okqBf70XZE5fE+xsrxM6EtYr0tc9OHeX2eZmjJteW
        J5Vz6ZnjWJO/CmfatEvz/xTVeXBkT6aeTSWP5Omj8+kEEzAXkg==
X-Google-Smtp-Source: ABdhPJxychpQPXaeXjOWNjDuFGzfK826W4sHBgLp00AUCNl5yz4F+IzeU71XlFiPXTw3QwlZ2oQHywsX990y/UWRcj4=
X-Received: by 2002:a92:dd0c:: with SMTP id n12mr5429206ilm.236.1622487773211;
 Mon, 31 May 2021 12:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAM6ytZrBUMB6xpP_srni8VParnNiuFPZZ2H-WsWUJEZH_vSk1w@mail.gmail.com>
 <YLUXvOI433/W8EvD@casper.infradead.org>
In-Reply-To: <YLUXvOI433/W8EvD@casper.infradead.org>
From:   tianyu zhou <tyjoe.linux@gmail.com>
Date:   Tue, 1 Jun 2021 03:02:42 +0800
Message-ID: <CAM6ytZo5H3rvGqwJOAXmo1Zp3fxXH_ZLivGg1jNc9c_PgAkTUQ@mail.gmail.com>
Subject: Re: Missing check for CAP_SYS_ADMIN in do_reconfigure_mnt()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for reminding!

But here is one more question about the CAP_SYS_ADMIN check inside
may_mount(): why does it check the CAP in
current->nsproxy->mnt_ns->user_ns?

for do_remount(), it checks CAP_SYS_ADMIN in path->mnt->mnt_sb->s_user_ns;
for path_mount(), it checks CAP_SYS_ADMIN in current->nsproxy->mnt_ns->user=
_ns.

Is these two user ns are same during runtime? (If they are same, then
it will be redundant check in path_mount() and its callee
do_remount(); if they are not same, maybe do_reconfigure_mnt() need
more check for path->mnt->mnt_sb->s_user_ns)

Tianyu

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, May 31, 2021 at 10:59:54PM +0800, tianyu zhou wrote:
> > Hi, function do_remount() in fs/namespace.c checks the CAP_SYS_ADMIN
> > before it calls set_mount_attributes().
> >
> > However, in another caller of set_mount_attributes(),
> > do_reconfigure_mnt(), I have not found any check for CAP_SYS_ADMIN.
> > So, is there a missing check bug inside do_reconfigure_mnt() ? (which
> > makes it possible for normal user to reach set_mount_attributes())
>
> You weren't looking hard enough ...
>
> path_mount()
>         if (!may_mount())
>                 return -EPERM;
> ...
>         if ((flags & (MS_REMOUNT | MS_BIND)) =3D=3D (MS_REMOUNT | MS_BIND=
))
>                 return do_reconfigure_mnt(path, mnt_flags);
>
> (this is the only call to do_reconfigure_mnt())
>
> and:
>
> static inline bool may_mount(void)
> {
>         return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMI=
N);
> }
>
