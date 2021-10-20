Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE77D434A2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 13:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhJTLjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJTLje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:39:34 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B06C06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 04:37:17 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id i22so5899490ual.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sgh0E4WzTxkz/1nH7Mg+y9YH3c6ZU+fCxLPTMDK0UIs=;
        b=Pg4XCvk7v04pHdpqK/2dL1K6wTIEOCxnNkotjI+q0PVHQQ+Fnc+p2SZFAZbVc8fjka
         oFHeKVfllqvc/7NcRdJ0i3LRAJ6R7LR40f3FYJNLr5ffORZemorpuunIAT6CK+ZNp80X
         I2Bsvi/Na1hf011xtOItbeN4uXa1OKlCx9xDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sgh0E4WzTxkz/1nH7Mg+y9YH3c6ZU+fCxLPTMDK0UIs=;
        b=xkLDWEtPN2P3to6ODlcYGPqwvUOantYPP3051Xl+z7AbQNuTJjncbajignXjzBblTA
         3QD8FHMe9ZGymFXVXQJ4FVwZiAL0E25pAf3TAmnzNox4rNprqEO6l+ShAuvLwmmmpCZH
         y57pwGWPtXi0Z8UpA8zDI9lNOe0mkaivztxp1baBv1DTPqkuubnHOlXtmVKuyy1NL9uO
         gGrasDtYpdJ1ACQI3ZgXJ+71l5tfMYOGC1Yh410HwxsK8hskXxP8RxU0el0jHTgt2ZN2
         VeIqU+2TAriVu97Jq2kediVSC8E6tBYP9fsuA5wMiedeqUUh9Qou9+DeQBJXxTDIl/N4
         901g==
X-Gm-Message-State: AOAM532ezp0QJJeTSBhjYPAYGL/Rn9yKqsapyFMT+WYP2T1+Ei92/hNZ
        eRvgO+5xs6O+oK4/Mhv5XOChisiWpNbSCGlvyjML7w==
X-Google-Smtp-Source: ABdhPJyCxYleL/0URzjEwPiKX5bnIFKIkI5XUl0ft13LtfDoe7baWMaJLQjsvskuwnHIWgBwHWwhPaBnVtSyhzSMzxg=
X-Received: by 2002:a67:c284:: with SMTP id k4mr41762162vsj.24.1634729837141;
 Wed, 20 Oct 2021 04:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <DB9P193MB140461EEF44F153D9F66FF958DB89@DB9P193MB1404.EURP193.PROD.OUTLOOK.COM>
 <PAXP193MB1405A3EC41713BE9D524FBE48DB89@PAXP193MB1405.EURP193.PROD.OUTLOOK.COM>
 <YW7i72bOgRGmCs2O@miu.piliscsaba.redhat.com> <YW7zuLv8TYDNzyqC@mussarela>
In-Reply-To: <YW7zuLv8TYDNzyqC@mussarela>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Oct 2021 13:37:06 +0200
Message-ID: <CAJfpegutjX3oaJzBWdr1Ra2zNS2wm=2W4DoWV=PSMd-JVZ8nGQ@mail.gmail.com>
Subject: Re: [oss-security] CVE-2021-3847: OverlayFS - Potential Privilege
 Escalation using overlays copy_up
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     oss-security@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Alon Zahavi <Alon.Zahavi@cyberark.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Nir Chako <Nir.Chako@cyberark.com>,
        Alon Zahavi <zahavi.alon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 Oct 2021 at 18:35, Thadeu Lima de Souza Cascardo
<cascardo@canonical.com> wrote:
>
> On Tue, Oct 19, 2021 at 05:23:27PM +0200, Miklos Szeredi wrote:
> > On Thu, Oct 14, 2021 at 06:30:53PM +0000, Alon Zahavi wrote:
> > >
> > > After disclosing the issue with the linux-distros mailing list, I am =
reporting the security issue publicly to here.
> > > There is no patch available and may not be available for a long time =
because the kernel can=E2=80=99t enforce the mitigation proposed, as that w=
ould be a layering violation and could also possibly cause a regression.
> > > This vulnerability was attached with CVE-2021-3847.
> > > Here is the report that was initially sent:
> > >
> > > ## Bug Class
> > > Escalation of privileges - Bypassing the security extended attribute =
attachment restrictions (in order to modify the security.capability xattr, =
a process will need CAP_SYS_ADMIN or CAP_SETFCAP).
> > > # Technical Details
> > > ## Summary:
> > > An attacker with a low-privileged user on a Linux machine with an ove=
rlay mount which has a file capability in one of its layers may escalate hi=
s privileges up to root when copying a capable file from a nosuid mount int=
o another mount.
> > > ## In details:
> > > If there is an overlay mount that one of its lower layers contains a =
file with capabilities and in case that the lower layer is a nosuid mount (=
which means the file capabilities are being ignored at execution), an attac=
ker with low-privileges user can touch the file, which causes the overlayFS=
 driver to copy_up the file with its capabilities into the upper layer. Tha=
t way the attacker can now execute the file with the file's capabilities, t=
hus escalating its privileges.
> >
> > I think this is a misunderstanding about how overlayfs operates.  Mount=
ing
> > overlayfs is effectively a just-in-time version of "cp -a lowerdir uppe=
rdir".
> > In other words if the admin creates an overlay where the lower layer is
> > untrusted and the upper layer is trusted, then that act itself is the
> > privilege escalation.
> >
> > This is more formally documented in "Documentation/filesystems/overlayf=
s.rst"
> > in the "Permission model" section.
> >
> > If this model is not clear, then maybe it needs to be spelled out more
> > explicitly.  Perhaps even a warning message could be added to the kerne=
l logs
> > in case the lower mount is "nosuid".  But IMO erroring out on the copy-=
up or
> > skipping copy up of certain attributes would make the cure worse than t=
he
> > disease.
>
> Should we fail (and log it) when the lower mount and upper mount have dif=
ferent
> suid settings, and require a force option to be used?

"cp -a" doesn't fail if used to copy from a nosuid mount to a suid
mount, right?  Should it?

I understand the psychology behind this: people think copy-up is done
by the current (unprivileged) user, because it's triggered by the
current user.   But copy up isn't done by the current user, it's done
by the mounting user (i.e .with the privileges of the mounting task).

The reason for this is that in many cases copy up *can not* be
performed by the current task.  Just think of the case where e.g. root
owned parent directory needs to be copied up before the user writable
file is copied up.

This means that it's the responsibility of the mounting user to ensure
that copy-up does not compromise security, since the current
(unprivileged) user will be able to *trigger* operations done with the
privileges of the mounting user, such as the scenario described in
this CVE.

Thanks,
Miklos
