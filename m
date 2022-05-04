Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5B51968D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 06:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbiEDEbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 00:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344558AbiEDEax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 00:30:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAC2B1B0;
        Tue,  3 May 2022 21:27:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i17so377983pla.10;
        Tue, 03 May 2022 21:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+cGrnPRGPK/ucSsABpTChWSDeibddA+M2PSMWrLe4Q=;
        b=hudgSCzJK8/Xys0xHyBNbbzxocrhG4QHCPtvAJSmTDAZHKDQ/M8Shd1LL1JlLbkcvS
         xNnsAjs1tusI6X7Rgg7DH2IkAV4VjlJg4Of4vaX7FHZi8OyCQmiL6pnQ6427oRB2B520
         G3Ra3PcvEAe+wu9TZkFLcoTzt3Twins720nGwOwyUsF+IEvC0+EFXvdUd67HT1Eqwzu+
         Or8rNKc/6MiE7fmFaqdSWiYeTU5A+uuLIfa0MPNePqTSJwjIvILsart97SFXyhnBq11x
         J7gDK+0v2CpvTg4wbrgw6WKnjuvKzRnXE//uFMbA5Ssdp782vHQQbeXFMpwBJ1vuS9Qc
         zCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+cGrnPRGPK/ucSsABpTChWSDeibddA+M2PSMWrLe4Q=;
        b=Xr2duc+HmrS3z1Wqd3A0FTfFxgCh3QAVUuZN0cQso9dgUdmdBOWXLrBtKgXvZ8h02x
         tF9CxsHEqD0iSE0GziRmlrk9G60Wi05CybqS6KjA8mCWtxMZBHERC/v9rDCsh0xPD1NO
         L7zXtu8ueeHDjsMRndiaZ3Me+YAjWzP/YfYIzKWIPdXmHwzGVY734UsLGbGhsyc+JGRq
         hDz98EQBY4EswqyYyNlyI6e2yHV4/JW+QEHCV0m95So5d1us1MadLuWwAaPOKKsAr1wS
         6WKBx2fQiNeVc6uTueiIfk9bQmutXwRXfPipMleM5a1Im3S5AC2GcAmqdzz8V0qsm+i5
         Ph1A==
X-Gm-Message-State: AOAM532HEAhDKL2MSIIwfFm3UsCKR4EuMa9pTFLzYjFoP2tDQmQGN7uC
        2D6rNolB9hqim14jb+ujLUfdb1CeuE5j/ChuiG2+7uqJ7X0=
X-Google-Smtp-Source: ABdhPJxdtYKQTvwQ+7OKcaPPxrUWY69nr7lCsfgEBI6s3bNdbPmyFE1nOgiL7SfwBaVBK252dBjnwx6mYLAWbtlVCwc=
X-Received: by 2002:a17:90b:3d0b:b0:1dc:1953:462d with SMTP id
 pt11-20020a17090b3d0b00b001dc1953462dmr8438078pjb.122.1651638421425; Tue, 03
 May 2022 21:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <20220502102521.22875-2-dharamhans87@gmail.com> <YnGIUOP2BezDAb1k@redhat.com>
In-Reply-To: <YnGIUOP2BezDAb1k@redhat.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Wed, 4 May 2022 09:56:49 +0530
Message-ID: <CACUYsyGoX+o19u41cZyF92eDBO-9rFN_EEWBvWBGrEMuNn29Mw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] FUSE: Implement atomic lookup + create
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 4, 2022 at 1:24 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, May 02, 2022 at 03:55:19PM +0530, Dharmendra Singh wrote:
> > From: Dharmendra Singh <dsingh@ddn.com>
> >
> > When we go for creating a file (O_CREAT), we trigger
> > a lookup to FUSE USER SPACE. It is very  much likely
> > that file does not exist yet as O_CREAT is passed to
> > open(). This lookup can be avoided and can be performed
> > as part of create call into libfuse.
> >
> > This lookup + create in single call to libfuse and finally
> > to USER SPACE has been named as atomic create. It is expected
> > that USER SPACE create the file, open it and fills in the
> > attributes which are then used to make inode stand/revalidate
> > in the kernel cache. Also if file was newly created(does not
> > exist yet by this time) in USER SPACE then it should be indicated
> > in `struct fuse_file_info` by setting a bit which is again used by
> > libfuse to send some flags back to fuse kernel to indicate that
> > that file was newly created. These flags are used by kernel to
> > indicate changes in parent directory.
>
> Reading the existing code a little bit more and trying to understand
> existing semantics. And that will help me unerstand what new is being
> done.
>
> So current fuse_atomic_open() does following.
>
> A. Looks up dentry (if d_in_lookup() is set).
> B. If dentry is positive or O_CREAT is not set, return.
> C. If server supports atomic create + open, use that to create file and
>    open it as well.
> D. If server does not support atomic create + open, just create file
>    using "mknod" and return. VFS will take care of opening the file.
>
> Now with this patch, new flow is.
>
> A. Look up dentry if d_in_lookup() is set as well as either file is not
>    being created or fc->no_atomic_create is set. This basiclally means
>    skip lookup if atomic_create is supported and file is being created.
>
> B. Remains same. if dentry is positive or O_CREATE is not set, return.
>
> C. If server supports new atomic_create(), use that.
>
> D. If not, if server supports atomic create + open, use that
>
> E. If not, fall back to mknod and do not open file.
>
> So to me this new functionality is basically atomic "lookup + create +
> open"?
>
> Or may be not. I see we check "fc->no_create" and fallback to mknod.
>
>         if (fc->no_create)
>                 goto mknod;
>
> So fc->no_create is representing both old atomic "create + open" as well
> as new "lookup + create + open" ?
>
> It might be obvious to you, but it is not to me. So will be great if
> you shed some light on this.
>

I think you got it right now. New atomic create does what you
mentioned as new flow.  It does  lookup + create + open in single call
(being called as atomic create) to USER SPACE. mknod is a special case
where the file system does not have a create call implemented. I think
its legacy probably goes back to Linux 2.4 if I am not wrong. We did
not make any changes into that.

Second patch avoids lookup for open calls. 3rd patch avoids lookup in
de_revalidate() but for non-dir. And only in case when default
permissions are not enabled.
