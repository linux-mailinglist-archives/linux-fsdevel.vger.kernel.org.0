Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DCF7A4906
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbjIRL7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241906AbjIRL6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:58:51 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C74CE0;
        Mon, 18 Sep 2023 04:56:13 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7a7857e5290so1567686241.1;
        Mon, 18 Sep 2023 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695038172; x=1695642972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czJiOQ8JI+xl7bBxJqncWH4Q6B795Z7d3/4awiVUVic=;
        b=DNnOvPIsTSQG/I+JYH2PRXVvSvJRKB31MDktMqDDbdEHCe97RGNxgY0rQ5Gm9CMqbA
         9bfqF+n1lp+jqCIGknuvGFhg0ajsyu5sNJ8ZaeDM8crvh0FuuHXWi5JGapWih/zUrz0S
         rMo6YW0+kmEcBroyGDha++df2nqAdgHxjaAPv9nsBtIhMsYUIXgxwyZYyTRiymlDqt2C
         OxOZr0wKqisVE90Nr6xNwLO7Xk6ELwGH0f44hcpCvf/e4BtYTI/fYiqa11szUmorlIex
         EEMMAnQ2BdmWz3G3DyHJlYcJKn6hUsoUdBL5MhWqfyEvk6Wn3GHdLrtMSgMd8pkaWC/O
         NDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695038172; x=1695642972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czJiOQ8JI+xl7bBxJqncWH4Q6B795Z7d3/4awiVUVic=;
        b=NAM2rPI+UULHUx0KaV7YCsdBAObVp687GwoU+2jCuSVMNtghZRP7GYH55w+xFMdLsx
         W4hOQChx0zSqXdCVk9PL3SIiU+izlmOtofvTTuCwhcAaXOnJPR9s1eAKigyoNqKhZn4b
         4t0qBCzQMEIhatNqw0swEG8D/W4+YgHJwZqGKJrFu/9Klo7vurjnglJv+qqtcZulil+D
         u+94zizLlLnMMUYMQ05RLq5Rd2tiFecSrRxhM9w4Ge2/41hngkNxGTnKuW2KRe0bJK2l
         6clEtIf+MdUz9BPXWmqr3/jeEYyCaN27JxtnF4WPay8S4lkgc47iaTb+HP1ZxlQAYESS
         PcqA==
X-Gm-Message-State: AOJu0YxUdl5D/+z+ClUIA7KE4Jchw9R31AZWxikKUTVppxmhLy+C4HQI
        ++FMkcUR2EJQ/Y9BQ358ujUh7b0AnbPUr07PRCc=
X-Google-Smtp-Source: AGHT+IG5otdTbAaP2AzRcdOA5BkciPTyFVveJXumxX5Xa4gXL8dFsDEyfHzPHOx5qOpkpBianyB/k81d/TfvMv+5zaY=
X-Received: by 2002:a05:6102:4ad:b0:44e:adc4:7eba with SMTP id
 r13-20020a05610204ad00b0044eadc47ebamr7177295vsa.26.1695038172363; Mon, 18
 Sep 2023 04:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073755.3489676-1-amir73il@gmail.com> <CAOQ4uxg2_d2eFfSy45JCCLE41qCPZtLFytnZ5x5C1uXdCMUA=Q@mail.gmail.com>
 <4919dcc1066d6952190dc224004e1f6bcba5e9df.camel@linux.ibm.com>
 <CAOQ4uxiKgYO5Z25DFG=GQj3GeGZ8unSPExM-jn1HL_U8qncrtA@mail.gmail.com>
 <428533f7393ab4a9f5c243b3a61ff65d27ee80be.camel@linux.ibm.com>
 <CAOQ4uxgAp_jwr-vbNn9eA9PoTrPZHuWb7+phF69c4WKmB8G4oA@mail.gmail.com> <ddd831c35bdcd46c5912b0f34486a36785f17622.camel@linux.ibm.com>
In-Reply-To: <ddd831c35bdcd46c5912b0f34486a36785f17622.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 18 Sep 2023 14:56:01 +0300
Message-ID: <CAOQ4uxhoasXiBst4Y+7DhkOkvgVZpcRpt2g1EVygRx=R--kv6Q@mail.gmail.com>
Subject: Re: Fwd: [PATCH] ima: fix wrong dereferences of file->f_path
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 2:00=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Fri, 2023-09-15 at 12:57 +0300, Amir Goldstein wrote:
>
> > > Assuming IMA is configured, just add "ima_policy=3Dtcb" to the comman=
d
> > > line.   This will measure all files executed, mmap'ed, kernel modules=
,
> > > firmware, and all files opened by root.  Normally the builtin policy =
is
> > > replaced with a finer grained one.
> > >
> > > Below are a few commands, but Ken Goldman is writing documentation -
> > > https://ima-doc.readthedocs.io/en/latest/
> > >
> > > 1. Display the IMA measurement list:
> > > # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > # cat /sys/kernel/security/ima/binary_runtime_measurements
> > >
> > > 2. Display the IMA policy  (or append to the policy)
> > > # cat /sys/kernel/security/ima/policy
> > >
> > > 3. Display number of measurements
> > > # cat /sys/kernel/security/ima/runtime_measurements_count
> > >
> >
> > Nice.
> > This seems to work fine and nothing pops up when running
> > fstests unionmount tests of overlayfs over xfs.
> >
> > What strikes me as strange is that there are measurements
> > of files in xfs and in overlayfs, but no measurements of files in tmpfs=
.
> > I suppose that is because no one can tamper with the storage
> > of tmpfs, but following the same logic, nobody can tamper with
> > the storage of overlayfs files without tampering with storage of
> > underlying fs (e.g. xfs), so measuring overlayfs files should not
> > bring any extra security to the system.
> >
> > Especially, since if files are signed they are signed in the real
> > storage (e.g. xfs) and not in overlayfs.
> >
> > So in theory, we should never ever measure files in the
> > "virtual" overlayfs and only measure them in the real fs.
> > The only problem is the the IMA hooks when executing,
> > mmaping, reading files from overlayfs, don't work on the real fs.
> >
> > fsnotify also was not working correctly in that respect, because
> > fs operations on overlayfs did not always trigger fsnotify events
> > on the underlying real fs.
> >
> > This was fixed in 6.5 by commit bc2473c90fca ("ovl: enable fsnotify
> > events on underlying real files") and the file_real_path() infrastructu=
re
> > was added to enable this.
> >
> > This is why I say, that in most likelihood, IMA hook should always use
> > file_real_path() and file_dentry() to perform the measurements
> > and record the path of the real fs when overlayfs is performing the
> > actual read/mmap on the real fs and IMA hooks should ideally
> > do nothing at all (as in tmpfs) when the operation is performed
> > on the "virtual" overlayfs object.
>
> tmpfs is excluded from the builtin policy, since there is no way of
> storing the file signature in the initramfs (CPIO).  There have been a
> number of attempts at extending the initramfs CPIO format, but none
> have been upstreamed.
>
> Agreed, IMA should always use the real file for both the lower and the
> upper overlayfs.
>

I took a quick look at some IMA security hooks and I think it's not going
to be trivial to fix IMA over overlayfs.

Simply adding a bunch of file_real_path() is not going to solve all cases.
I still think that my patch is correct, but in order to fix the syzbot cras=
h
and other issues, a developer will need to run all the IMA test cases
over overlayfs and examine every case more closely.

If it is acceptable I would recommend to opt-out of IMA
measure/appraise of overlayfs files for the default policy, but that means
that underlying real files will not be measure/appraise as well.
This way we at least shut up syzbot, because we know that this
configuration is broken.

Anyway, syzbot has just confirmed that the regressing commit is
"IMA: use vfs_getattr_nosec to get the i_version"

Thanks,
Amir.
