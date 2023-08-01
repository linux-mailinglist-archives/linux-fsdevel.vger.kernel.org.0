Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E0E76B7F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjHAOsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjHAOsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:48:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF61BC3
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 07:48:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bcf2de59cso899652666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690901295; x=1691506095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3kEz1CTM4/QozQ2mRQvCjeRan+rFBPUYaNFk70CP28=;
        b=iOm3m4lxaeHZrwJ/xIVKTeBN1U0byLijO0LCVzdEl0KAcnoAo7dIl/sjMNTu76FOwj
         I5sYttUBRz/+24Kk7AcwiIGfsbksopGbx8TSNP+K0sZ9GVgFyS9fq2ygCBwaKym3rVn0
         HaYBkaU1z4DC0dcDrqnOWS6Pv+75FO+XJE/24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690901295; x=1691506095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3kEz1CTM4/QozQ2mRQvCjeRan+rFBPUYaNFk70CP28=;
        b=akVDQyt2T8QdoBJiAV7ElIZpXiYAOvHHOrGJrWVrCfJQNziG2f/82KobcWs381TgGf
         vg95Q2KUaPOMrrNpuhmA/rER8iEFHYOjXGMKccL0sCgGYmTYAtglyoZ/7G2aHqZ5G7cX
         8GErugmbNn/9L6PLshUiV5dqcKP1bfV2a5PLQA/WAkmR98oqXJxdplZyos3khuKu/0Hu
         Pz9eqwpMc9i3q7mVjlKt+GsP13SX4MMizAqMeg96bJjAhiKps5KnHyH15mHcteiqyIx2
         Ftu5Dkq30r8pQbVBhZ4jhYiubWfzIHFPIu+KtpW2Xrqi6eZXbpJBRinEnLT+TQcUBUCe
         nH5g==
X-Gm-Message-State: ABy/qLakIAUCNVU/6hS3GWg39uJ3k24TQvuqSlKdrh1A/3RQijiE5Kxr
        7xm48AD6SayD5lPYiDcU/WV5TRjM3IAmmmo+WoTZoA==
X-Google-Smtp-Source: APBJJlE8JTL1fjZKhwknbK9ebcNbxHgy/MjRz5MqyE0lvybxwlqNOIe/w5g+TuXq1lChRAh1CFeNn4H/qBp2Jg9LqRE=
X-Received: by 2002:a17:906:11:b0:993:f744:d235 with SMTP id
 17-20020a170906001100b00993f744d235mr2630214eja.6.1690901294975; Tue, 01 Aug
 2023 07:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <87wmymk0k9.fsf@vostro.rath.org> <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
 <87tttpk2kp.fsf@vostro.rath.org> <87r0osjufc.fsf@vostro.rath.org>
 <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
 <CAJfpeguJESTqU7d0d0_2t=99P3Yt5a8-T4ADTF3tUdg5ou2qow@mail.gmail.com>
 <87o7jrjant.fsf@vostro.rath.org> <CAJfpegvTTUvrcpzVsJwH63n+zNw+h6krtiCPATCzZ+ePZMVt2Q@mail.gmail.com>
 <2e44acdd-b113-43c3-80cb-150f09478383@app.fastmail.com>
In-Reply-To: <2e44acdd-b113-43c3-80cb-150f09478383@app.fastmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Aug 2023 16:48:03 +0200
Message-ID: <CAJfpegtoi2jNaKjvqMqrWQQrDoJkTZqheXFAb3MMVv7WVsHi0A@mail.gmail.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
To:     Nikolaus Rath <nikolaus@rath.org>
Cc:     Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 1 Aug 2023 at 16:40, Nikolaus Rath <nikolaus@rath.org> wrote:
>
> On Tue, 1 Aug 2023, at 13:53, Miklos Szeredi via fuse-devel wrote:
> > Here's one with the virtual env and the correct head:
> >
> > root@kvm:~/s3ql# git log -1 --pretty="%h %s"
> > 3d35f18543d9 Reproducer for notify_delete issue. To confirm:
> > root@kvm:~/s3ql# ~/s3ql-python-env/bin/python bin/s3qlrm mnt/test
> > WARNING: Received unknown command via control inode
> > ERROR: Uncaught top-level exception:
> > Traceback (most recent call last):
> >   File "/root/s3ql/bin/s3qlrm", line 21, in <module>
> >     s3ql.remove.main(sys.argv[1:])
> >   File "/root/s3ql/src/s3ql/remove.py", line 72, in main
> >     pyfuse3.setxattr(ctrlfile, 'rmtree', cmd)
> >   File "src/pyfuse3.pyx", line 629, in pyfuse3.setxattr
> > OSError: [Errno 22] Invalid argument: 'mnt/test/.__s3ql__ctrl__'
>
> This is odd. I have never heard of anyone having this problem before and it also works fine in the CI.
>
> I apologize that this is taking so much of your time.
>
> I have changed the code a bit to print out what exactly it is receiving: https://github.com/s3ql/s3ql/commit/eb31f7bff4bd985d68fa20c793c2f2edf5db61a5
>
> Would you mind updating your branch and trying again? (You'll need to fetch and reset, since I rebased on top of current master just to be sure).
>
> I can still reproduce this every time (without any other error):
>
> $ mkdir bucket
> $ bin/mkfs.s3ql --plain local://bucket
> Before using S3QL, make sure to read the user's guide, especially
> the 'Important Rules to Avoid Losing Data' section.
> Creating metadata tables...
> Uploading metadata...
> Uploading metadata...
> Uploaded 1 out of ~1 dirty blocks (100%)
> Calculating metadata checksum...
> $ mkdir mnt
> $ bin/mount.s3ql --fg local://bucket mnt &
> Using 10 upload threads.
> Autodetected 1048514 file descriptors available for cache entries
> Using cached metadata.
> Setting cache size to 315297 MB
> Mounting local:///home/nikratio/in-progress/s3ql/bucket/ at /home/nikratio/in-progress/s3ql/mnt...
>
> $ md mnt/test; echo foo > mnt/test/bar
> $ bin/s3qlrm mnt/test
> fuse: writing device: Directory not empty
> ERROR: Failed to submit invalidate_entry request for parent inode 1, name b'test'
> Traceback (most recent call last):
>   File "src/internal.pxi", line 125, in pyfuse3._notify_loop
>   File "src/pyfuse3.pyx", line 915, in pyfuse3.invalidate_entry
> OSError: [Errno 39] fuse_lowlevel_notify_delete returned: Directory not empty
>
> nikratio@vostro ~/i/s3ql (notify_delete_bug)>

WARNING: Received unknown command via control inode: b"1, b'test')"
ERROR: Uncaught top-level exception:
Traceback (most recent call last):
  File "/root/s3ql/bin/s3qlrm", line 21, in <module>
    s3ql.remove.main(sys.argv[1:])
  File "/root/s3ql/src/s3ql/remove.py", line 74, in main
    pyfuse3.setxattr(ctrlfile, 'rmtree', cmd)
  File "src/pyfuse3.pyx", line 629, in pyfuse3.setxattr
OSError: [Errno 22] Invalid argument: 'mnt/test/.__s3ql__ctrl__'

Thanks,
Miklos
