Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9053B445441
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 14:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKDNxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDNxr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:53:47 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B7C061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 06:51:09 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id q13so10948356uaq.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qCM6Bly3e9KCBYykCNOGsudyVI/cxLH4a+sNblQ83IE=;
        b=qrdJrXUWOp+dSb1eU88vr5RvjeBQpZi/W5cYf3F/J1E5/wqRur1LxyvBlZEq0am1bF
         Gv6FzOEGJBEZ0tu+vy1WQt+Dh8Qy8xmcCKQ2wlgBhTYWUXJjLrO/5OXeshHQLMJ1rbCw
         6FxY2rnvBc6OBb7SEkwB5Ghad9vunLlNjPmnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qCM6Bly3e9KCBYykCNOGsudyVI/cxLH4a+sNblQ83IE=;
        b=RORgsE46UPzlbOMgOX724/5ae4msET7Vz2ZGgIk8v3yXTD1acCiXieLV9PLx1m9etZ
         nZxQULwBK2kSAshyHmyaseqmnpikbWUYDmAJ0Uj72QteLQGykbWW6K4YnhaojJq4p0Sp
         i0p9ILDt6Ejjz4eBrAjCPIZEKTO+vXYR1gI/IlUe/+pqeAGXbnAu0+pCLOo4jW/2FG7y
         ewkQyCBuhz4nRhw4Kj+AgpYdNQR8Xp5qTVkdGZUY2DaD/ply57p1AiXELsmfCC5mf02z
         x4GJzfws93/5BaMIT+DSamMsaGEvpX/L7wzE2/jmobDSM+JmrHURaSmVvZjpj7enDwL4
         60tA==
X-Gm-Message-State: AOAM530EAbkZV1klE3MgDEcFREv/GPGpZ20+SWimJgaTmCx4vjWPe4Gq
        Ll7gjyB6FYk9KdXGyp+c+0h8MFohvvckjzarBZTczw==
X-Google-Smtp-Source: ABdhPJzvzr0nxS9q70NP1DsZ2lUtMGtJale/VEwXIhNitqt+ps7xTnyNZD8ymDl3mROF++RTpKt+5gRjTFi2BpwhNpc=
X-Received: by 2002:ab0:6002:: with SMTP id j2mr40739538ual.9.1636033868688;
 Thu, 04 Nov 2021 06:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <88ba5bf0c8d5f08b9556499a9891543530471f03.camel@kernel.org>
In-Reply-To: <88ba5bf0c8d5f08b9556499a9891543530471f03.camel@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 4 Nov 2021 14:50:57 +0100
Message-ID: <CAJfpegtNDk2QA5VF+28zo6ViagW5CSvhaajs5ePwbC0r7AF=AA@mail.gmail.com>
Subject: Re: FUSE statfs f_fsid field
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 4 Nov 2021 at 14:27, Jeff Layton <jlayton@kernel.org> wrote:
>
> Hi Miklos!
>
> I was looking at an issue [1] with ceph-fuse and noticed that statfs
> always reports f_fsid =3D=3D 0 via statfs. Is there a reason for not lett=
ing
> the driver fill out that field?

Hi Jeff,

I do not remember ever hearing of this field.   The statfs(2) man page
doesn't make it very obvious either:

   The f_fsid field

       [...] The general idea is that f_fsid contains some random
stuff  such  that
       the  pair (f_fsid,ino) uniquely determines a file.  Some operating s=
ys=E2=80=90
       tems use (a variation on) the device number, or the device number  c=
om=E2=80=90
       bined  with  the  filesystem  type. [...]

I'd be somewhat concerned about allowing an unprivileged fuse server
to fill this, as that may allow impersonation of another filesystem.

For a privileged fuse server I see no problem with allowing to set this.

Thanks,
Miklos
