Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277046AD956
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 09:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCGIiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 03:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCGIiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:38:18 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88D82B28B
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 00:38:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ay14so45458031edb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 00:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1678178294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnRKhcahxkatbm2bFGkk7mnKxouvXhMRB3sMCcT+Nuc=;
        b=HpJm56Gg6LXY6d/a4PlAxpXPEchq3Rzd3dRLN/jhNSdLcKE4JZQEBXsbr8yRI8D0pW
         G9x0kKTYbndW1sf1JpiSuHVWXz1t4BURAtzoiXRqBDxVRm/AUTMa4Gsk3+kEcYKjT+VB
         j/q3zaS0YJi/F/Mgc8whfBMA3DXlbC7PLrYpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678178294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnRKhcahxkatbm2bFGkk7mnKxouvXhMRB3sMCcT+Nuc=;
        b=FyO/LXdjNWXqcnmH7FacPigX9ubwiQ/cAMGWChaadjI5+o0Wbs3mZdpqk4dVq5hedB
         Kse+EKz5S9a4T8iVHMAOeNTqvvGMxF7Bk3rmnnH9tWCfwyViwHL26LVnv7TkdcIZa3V7
         ts7wyAraJ1LqTubSu3gr+O7BUIPYQg8M+lfOxVFpnj6rQ4201G4b+CqOv2vWoheJ6nje
         4Mx/GTbV3GYYO5AJqDWKu266kPyTsxFQbcoBT5fhohhYXcat1IbxJCIRxnfYLSd75ZfN
         NJWouo/S7pgLy04yBcvkdwtzszWvZed0/vYs21hUC2rzXd2kCyUOcU0O0r1r4dh76AtI
         ohbw==
X-Gm-Message-State: AO0yUKX1n8ZhcUcZFk5Yr9io0We0oxMGWWQ0EOO96BPln/9hu5t5yMU+
        TeX0QRBD2cdtE+K/EOxvK/UGYcKM0Ka026Z04PRj+w==
X-Google-Smtp-Source: AK7set+LKfm+lJJUQWrDUy8KTAYqnLSbU3m7VfgPjpiUrJJ1R3y17dvAZ3Vwwj6530T5sEFBkzKHMtXLp5v5ISIT548=
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr6358643ejf.0.1678178294468; Tue, 07 Mar
 2023 00:38:14 -0800 (PST)
MIME-Version: 1.0
References: <4B9D76D5-C794-4A49-A76F-3D4C10385EE0@kohlschutter.com>
 <CAJfpegs1Kta-HcikDGFt4=fa_LDttCeRmffKhUjWLr=DxzXg-A@mail.gmail.com>
 <83A29F9C-1A91-4753-953A-0C98E8A9832C@kohlschutter.com> <CAJfpegv5W0CycWCc2-kcn4=UVqk1hP7KrvBpzXHwW-Nmkjx8zA@mail.gmail.com>
 <FFA26FD1-60EF-457E-B914-E1978CCC7B57@kohlschutter.com> <CAJfpeguDAJpLMABsomBFQ=w6Li0=sBW0bFyALv4EJrAmR2BkpQ@mail.gmail.com>
 <A31096BA-C128-4D0B-B27D-C34560844ED0@kohlschutter.com> <CAJfpegvBSCQwkCv=5LJDx1LRCN_ztTh9VMvrTbCyt0zf7W2trw@mail.gmail.com>
 <CAHk-=wjg+xyBwMpQwLx_QWPY7Qf8gUOVek8rXdQccukDyVmE+w@mail.gmail.com>
 <EE5E5841-3561-4530-8813-95C16A36D94A@kohlschutter.com> <CAHk-=wh5V8tQScw9Bgc8OiD0r5XmfVSCPp2OHPEf0p5T3obuZg@mail.gmail.com>
 <CAJfpeguXB9mAk=jwWQmk3rivYnaWoLrju_hq-LwtYyNXG4JOeg@mail.gmail.com>
 <CAHk-=wg+bpP5cvcaBhnmJKzTmAtgx12UhR4qzFXXb52atn9gDw@mail.gmail.com>
 <56E6CAAE-FF25-4898-8F9D-048164582E7B@kohlschutter.com> <490c5026-27bd-1126-65dd-2ec975aae94c@eitmlabs.org>
 <CAJfpegt7CMMapxD0W41n2SdwiBn8+B08vsov-iOpD=eQEiPN1w@mail.gmail.com>
 <CALKgVmeaPJj4e9sYP7g+v4hZ7XaHKAm6BUNz14gvaBd=sFCs9Q@mail.gmail.com>
 <CALKgVmdqircMjn+iEuta5a7v5rROmYGXmQ0VJtzcCQnZYbJX6w@mail.gmail.com> <CALKgVmfZdVnqMAW81T12sD5ZLTO0fp-oADp-WradW5O=PBjp1Q@mail.gmail.com>
In-Reply-To: <CALKgVmfZdVnqMAW81T12sD5ZLTO0fp-oADp-WradW5O=PBjp1Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Mar 2023 09:38:03 +0100
Message-ID: <CAJfpeguKVzCyUraDQPGw6vdQFfPwTCuZv0JkMxNA69AiRib3kg@mail.gmail.com>
Subject: Re: [PATCH] [REGRESSION] ovl: Handle ENOSYS when fileattr support is
 missing in lower/upper fs
To:     jonathan@eitm.org
Cc:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Mar 2023 at 02:12, Jonathan Katz <jkatz@eitmlabs.org> wrote:
>
> Hi all,
>
> In pursuing this issue, I downloaded the kernel source to see if I
> could debug it further.  In so doing, it looks like Christian's patch
> was never committed to the main source tree (sorry if my terminology
> is wrong).  This is up to and including the 6.3-rc1.  I could also
> find no mention of the fix in the log.
>
> I am trying to manually apply this patch now, but, I am wondering if
> there was some reason that it was not applied (e.g. it introduces some
> instability?)?

It's fixing the bug in the wrong place, i.e. it's checking for an
-ENOSYS return from vfs_fileattr_get(), but that return value is not
valid at that point.

The right way to fix this bug is to prevent -ENOSYS from being
returned in the first place.

Commit 02c0cab8e734 ("fuse: ioctl: translate ENOSYS") fixes one of
those bugs, but of course it's possible that I missed something in
that fix.

Can you please first verify that an upstream kernel (>v6.0) can also
reproduce this issue?

Thanks,
Miklos



>
> Thank you,
> Jonathan
>
>
>
> On Thu, Feb 23, 2023 at 3:11=E2=80=AFPM Jonathan Katz <jkatz@eitmlabs.org=
> wrote:
> >
> > Hi all,
> >
> > Problem persists with me with 6.2.0
> > # mainline --install-latest
> > # reboot
> >
> > # uname -r
> > 6.2.0-060200-generic
> >
> >
> > Representative log messages when mounting:
> > Feb 23 22:50:43 instance-20220314-1510-fileserver-for-overlay kernel:
> > [   44.641683] overlayfs: null uuid detected in lower fs '/', falling
> > back to xino=3Doff,index=3Doff,nfs_export=3Doff.
> >
> >
> >
> > Representative log messages when accessing files:
> > eb 23 23:06:31 instance-20220314-1510-fileserver-for-overlay kernel: [
> >  992.505357] overlayfs: failed to retrieve lower fileattr (8020
> > MeOHH2O RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-172=
2.d/Storage.mcf_idx,
> > err=3D-38)
> > Feb 23 23:06:32 instance-20220314-1510-fileserver-for-overlay kernel:
> > [  993.523712] overlayfs: failed to retrieve lower fileattr (8020
> > MeOHH2O RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-172=
2.d/Storage.mcf_idx,
> > err=3D-38)
> >
> >
> > On Mon, Jan 30, 2023 at 11:27 AM Jonathan Katz <jkatz@eitmlabs.org> wro=
te:
> > >
> > > On Thu, Jan 26, 2023 at 5:26 AM Miklos Szeredi <miklos@szeredi.hu> wr=
ote:
> > > >
> > > > On Wed, 18 Jan 2023 at 04:41, Jonathan Katz <jkatz@eitmlabs.org> wr=
ote:
> > > >
> > > > > I believe that I am still having issues occur within Ubuntu 22.10=
 with
> > > > > the 5.19 version of the kernel that might be associated with this
> > > > > discussion.  I apologize up front for any faux pas I make in writ=
ing
> > > > > this email.
> > > >
> > > > No need to apologize.   The fix in question went into v6.0 of the
> > > > upstream kernel.  So apparently it's still missing from the distro =
you
> > > > are using.
> > >
> > > Thank you for the reply! ---  I have upgraded the Kernel and it still
> > > seems to be throwing errors.  Details follow:
> > >
> > > Distro: Ubuntu 22.10.
> > > Upgraded kernel using mainline (mainline --install-latest)
> > >
> > > # uname -a
> > > Linux instance-20220314-1510-fileserver-for-overlay
> > > 6.1.8-060108-generic #202301240742 SMP PREEMPT_DYNAMIC Tue Jan 24
> > > 08:13:53 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> > >
> > > On mount I still get the following notice in syslog (representative):
> > > Jan 30 19:11:46 instance-20220314-1510-fileserver-for-overlay kernel:
> > > [   71.613334] overlayfs: null uuid detected in lower fs '/', falling
> > > back to xino=3Doff,index=3Doff,nfs_export=3Doff.
> > >
> > > And on access (via samba) I still see the following errors in the
> > > syslog (representative):
> > > Jan 30 19:19:34 instance-20220314-1510-fileserver-for-overlay kernel:
> > > [  539.181858] overlayfs: failed to retrieve lower fileattr (8020
> > > MeOHH2O RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1=
722.d/Storage.mcf_idx,
> > > err=3D-38)
> > >
> > > And on the Windows client, the software still fails with the same sym=
ptomology.
> > >
> > >
> > >
> > >
> > > >
> > > > > An example error from our syslog:
> > > > >
> > > > > kernel: [2702258.538549] overlayfs: failed to retrieve lower file=
attr
> > > > > (8020 MeOHH2O
> > > > > RecoverySample2-20221219-A-JJL-WebinarHilic10C-TOF-TT54-Neg-1722.=
d/analysis.tsf,
> > > > > err=3D-38)
> > > >
> > > > Yep, looks like the same bug.
> > > >
> > > > Thanks,
> > > > Miklos
