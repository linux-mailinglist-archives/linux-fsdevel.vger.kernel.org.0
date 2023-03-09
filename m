Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B159B6B28E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCIPcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjCIPb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:31:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F57AF2222
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 07:31:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id da10so8634262edb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 07:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1678375898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DkXzgN0EHgf1dOpGSe3iIK1kwbBtYjaegg+rlUzVBc=;
        b=rdHTwYBJwTAOH3ZoXGlY/Fp2X/QNDdM0A9louBiy2i2xKkjSp8XnVIFYOQFSgO9Jbo
         8z013P4W0b9argImTH3e4qOX0yhxpK5Ek+WB91F7tRSQbJTQdDRo6BiJbOCQvZ3y9pDc
         ioeOFqkSz9efsJ7Ls+hDktSxzsN5U4r2XK5S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678375898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DkXzgN0EHgf1dOpGSe3iIK1kwbBtYjaegg+rlUzVBc=;
        b=YxmwCm2AmMFrkA90fNHBbd8RlSUWl1T5wwpy+U/9zpBCUEC48QoyOvlUF0Mz0Cyyg5
         P+aegFecPel3Xc4b8El+Rw4+4rpYa7eq4G04SllAq3SPY+3DTg1H40G/sbfz0TZqrv0F
         jSHxWK3ZKtvQBoE8yPtCoSkaAObgZlGWT4yy1LVmNNsjFfsN5yadz18mupPCKJpEnUwP
         yESvIdszA2zpmqoAxZjXypOCqhYXf1ZnH4oDdc6JiN4N/eQC1w8GYKGZntUM6q1+2h8+
         s5VONu2PbKL+8tEEhBoRLHdcnH6OL2mL1z/QmYgN5TdFuhvJT1q4tp6xZnxu1PzYuL3G
         oIfw==
X-Gm-Message-State: AO0yUKXjmBbga1qqlPsSI4Ywpiz/5Eonk+V8hPP7GPBnmw3LokirCdVl
        WNZY8Nn4c9wWP9racTk6ud427EiJCXcgUxmJ6JfJhQ==
X-Google-Smtp-Source: AK7set93nfCrfqMRpk5wPUF0BPSDl1IyaSI2laXoRcIFWebZUNfI5Dc9nDdr7AGuCpFt8SmT8ftKkp/Q8PN8wE40nmg=
X-Received: by 2002:a17:906:5811:b0:877:747d:4a90 with SMTP id
 m17-20020a170906581100b00877747d4a90mr11456691ejq.14.1678375897972; Thu, 09
 Mar 2023 07:31:37 -0800 (PST)
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
 <CALKgVmdqircMjn+iEuta5a7v5rROmYGXmQ0VJtzcCQnZYbJX6w@mail.gmail.com>
 <CALKgVmfZdVnqMAW81T12sD5ZLTO0fp-oADp-WradW5O=PBjp1Q@mail.gmail.com>
 <CAJfpeguKVzCyUraDQPGw6vdQFfPwTCuZv0JkMxNA69AiRib3kg@mail.gmail.com> <CALKgVmcC1VUV_gJVq70n--omMJZUb4HSh_FqvLTHgNBc+HCLFQ@mail.gmail.com>
In-Reply-To: <CALKgVmcC1VUV_gJVq70n--omMJZUb4HSh_FqvLTHgNBc+HCLFQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 9 Mar 2023 16:31:27 +0100
Message-ID: <CAJfpegt0rduBcSqSR=XmQ8bd_ws7Qy=4pxVF0_iysfc7wFagQQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Mar 2023 at 18:14, Jonathan Katz <jkatz@eitmlabs.org> wrote:
>
> On Tue, Mar 7, 2023 at 12:38=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Tue, 7 Mar 2023 at 02:12, Jonathan Katz <jkatz@eitmlabs.org> wrote:
> > >
> > > Hi all,
> > >
> > > In pursuing this issue, I downloaded the kernel source to see if I
> > > could debug it further.  In so doing, it looks like Christian's patch
> > > was never committed to the main source tree (sorry if my terminology
> > > is wrong).  This is up to and including the 6.3-rc1.  I could also
> > > find no mention of the fix in the log.
> > >
> > > I am trying to manually apply this patch now, but, I am wondering if
> > > there was some reason that it was not applied (e.g. it introduces som=
e
> > > instability?)?
> >
> > It's fixing the bug in the wrong place, i.e. it's checking for an
> > -ENOSYS return from vfs_fileattr_get(), but that return value is not
> > valid at that point.
> >
> > The right way to fix this bug is to prevent -ENOSYS from being
> > returned in the first place.
> >
> > Commit 02c0cab8e734 ("fuse: ioctl: translate ENOSYS") fixes one of
> > those bugs, but of course it's possible that I missed something in
> > that fix.
> >
> > Can you please first verify that an upstream kernel (>v6.0) can also
> > reproduce this issue?
>
> Got ya.  that makes a lot of sense, thank you.
>
> I have confirmed that I continue to get the error with 6.2 .
> quick summary of the lowerdir:
>    server ---- NFS(ro) ---- > client "/nfs"
>    client "/nfs" --- bindfs(uidmap) --- > client "/lower"

Can you please run bindfs in debugging mode (-d) and send the
resulting log after reproducing the issue?

Thanks,
Miklos
