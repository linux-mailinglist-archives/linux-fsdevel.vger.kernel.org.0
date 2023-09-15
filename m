Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D807A1FC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjIONXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjIONXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:23:18 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259AD2D74;
        Fri, 15 Sep 2023 06:22:29 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a88ef953adso1340268b6e.0;
        Fri, 15 Sep 2023 06:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694784148; x=1695388948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR9v4rs0QBEeLkEB6L/HFuKq3w5EWPdttE2E1ux3Dgk=;
        b=ctNXV7EM1VW3WnUbbQk+1qNmXGSrRMKZ5qutFrybwpN3Vx2jFBiKXbl8jWgQoFSQlS
         zpMx0u1IJ4c3VCjQbu6+sULEC8MHZzHKFwto0CvQDyH6R+L/wGmZCf3A8iBBCyAVBNG6
         7pOT7Pp+DtFu17+mAHgpGHAx9fFarPFabSGPaQxKeYFXvx6r1het7Jge3KPDpOVdf5Eb
         znbgIDzguXfmTO9QUNU8AYvaPDk5IWxgBEF9vs38vWpW0QAm90YL148S1DtCC/n2bwVb
         QeKV4k6D94gT/UOyP5UPpUppAT35KwIGxQChZEtmt2t09bjExH/54ELVCYiSzyPxNeXN
         LW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784148; x=1695388948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR9v4rs0QBEeLkEB6L/HFuKq3w5EWPdttE2E1ux3Dgk=;
        b=NDYpMiv0sjt3/FYpJPoHxylC1qFzOMdUCYjwhKXkaEtbLrJZq7wi3k8jbKAEaPvhsC
         K1aQZH5pjhoU7AIFQ1WUR9IhmiPleK4UquD5bwmviQB4U6yAR6+y30hycG7hjDLHD9Tv
         7zsZ8eCMT7lljhjhBreSAH3Aoo194VAvCSi9AwNsIkuu6TQr5vtCPR/fF+KY/qJxviOf
         EqjdoIjk50RJAVAXnOIFqg0v4J6x9BsopImuudRNZhugz9tMvHpfRKYZzu/v2Kda+lEP
         73gMu0+kAG2qOnCcx0LDNapxBxXm6KkKyaXgGSZ+EnTt3iDecBJgb9MNRa7rsLqSvMDU
         EqUg==
X-Gm-Message-State: AOJu0Yx/IGeB5EQdxW4eSURsS2hsAhKM7j/kAtHD43nK/f6XbsisAl0b
        0Ry5Xju6qZeSmP+gZwC/nlB4KwxTeYGMkP1zP+bfT9Xp
X-Google-Smtp-Source: AGHT+IFwlYo0ppbbaeyEl40+CMDoxgxGlOUZC0AQz7Gi/+du5Qo9jsijDA0aa43DWR41O4AILxV4NRy/lm0RPE70SXo=
X-Received: by 2002:a05:6808:309b:b0:3ab:8295:f2f1 with SMTP id
 bl27-20020a056808309b00b003ab8295f2f1mr2029119oib.45.1694784147169; Fri, 15
 Sep 2023 06:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230913073755.3489676-1-amir73il@gmail.com> <CAOQ4uxg2_d2eFfSy45JCCLE41qCPZtLFytnZ5x5C1uXdCMUA=Q@mail.gmail.com>
 <4919dcc1066d6952190dc224004e1f6bcba5e9df.camel@linux.ibm.com>
 <CAOQ4uxiKgYO5Z25DFG=GQj3GeGZ8unSPExM-jn1HL_U8qncrtA@mail.gmail.com>
 <428533f7393ab4a9f5c243b3a61ff65d27ee80be.camel@linux.ibm.com>
 <CAOQ4uxgAp_jwr-vbNn9eA9PoTrPZHuWb7+phF69c4WKmB8G4oA@mail.gmail.com> <f350092536a5e7305fd4740ee754087e61fd2f9a.camel@linux.ibm.com>
In-Reply-To: <f350092536a5e7305fd4740ee754087e61fd2f9a.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Sep 2023 16:22:15 +0300
Message-ID: <CAOQ4uxh3vP2aMcVxKA4Cu6+LhW-tUiCKOw5g72F4D5Et67Jh4A@mail.gmail.com>
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

On Fri, Sep 15, 2023 at 2:36=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Fri, 2023-09-15 at 12:57 +0300, Amir Goldstein wrote:
> > [adding back fsdevel]
> >
> > On Fri, Sep 15, 2023 at 7:04=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > >
> > > On Fri, 2023-09-15 at 06:21 +0300, Amir Goldstein wrote:
> > > > On Thu, Sep 14, 2023 at 11:01=E2=80=AFPM Mimi Zohar <zohar@linux.ib=
m.com> wrote:
> > > > >
> > > > > Hi Amir,  Goldwyn,
> > > > >
> > > > > FYI,
> > > > > 1. ima_file_free() is called to check whether the file is in poli=
cy.
> > > > > 2. ima_check_last_writer() is called to determine whether or not =
the
> > > > > file hash stored as an xattr needs to be updated.
> > > > >
> > > > > 3. As ima_update_xattr() is not being called, I assume there is n=
o
> > > > > appraise rule. I asked on the thread which policy rules are being=
 used
> > > > > and for the boot command line, but assume that they're specifying
> > > > > 'ima_policy=3Dtcb" on the boot command line.
> > > >
> > > > Yes, here is the kconfig from syzbot report dashboard
> > > > https://syzkaller.appspot.com/x/.config?x=3Ddf91a3034fe3f122
> > > >
> > > > >
> > > > > 4. Is commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the
> > > > > i_version") the problem?
> > > >
> > > > IIUC, this commit is responsible for the ovl_getattr() call in the =
stack
> > > > trace. syzbot did not bisect the bug yet, but now that it has found
> > > > a reproducer, it is just a matter of time.
> > > > However, all the bug reports in the  dashboard are only from upstre=
am,
> > > > so I think that means that this bug was not found on any stable ker=
nels.
> > > >
> > > > >
> > > > > 5. ima_file_free() is being called twice.  We should not be seein=
g
> > > > > ima_get_current_hash_algo() in the trace.
> > > > >
> > > > > [   66.991195][ T5030]  ovl_getattr+0x1b1/0xf70
> > > > > [   66.995635][ T5030]  ? ovl_setattr+0x4e0/0x4e0
> > > > > [   67.000229][ T5030]  ? trace_raw_output_contention_end+0xd0/0x=
d0
> > > > > [   67.006387][ T5030]  ? rcu_is_watching+0x15/0xb0
> > > > > [   67.011154][ T5030]  ? rcu_is_watching+0x15/0xb0
> > > > > [   67.015920][ T5030]  ? trace_contention_end+0x3c/0xf0
> > > > > [   67.021122][ T5030]  ? __mutex_lock_common+0x42d/0x2530
> > > > > [   67.026506][ T5030]  ? lock_release+0xbf/0x9d0
> > > > > [   67.031126][ T5030]  ? read_lock_is_recursive+0x20/0x20
> > > > > [   67.036719][ T5030]  ? ima_file_free+0x17c/0x4b0
> > > > > [   67.041578][ T5030]  ? __lock_acquire+0x7f70/0x7f70
> > > > > [   67.046615][ T5030]  ? locks_remove_file+0x429/0x1040
> > > > > [   67.051820][ T5030]  ? mutex_lock_io_nested+0x60/0x60
> > > > > [   67.057030][ T5030]  ? _raw_spin_unlock+0x40/0x40
> > > > > [   67.061894][ T5030]  ? __asan_memset+0x23/0x40
> > > > > [   67.066577][ T5030]  ima_file_free+0x26e/0x4b0
> > > > > [   67.071279][ T5030]  ? ima_get_current_hash_algo+0x10/0x10
> > > > > [   67.076929][ T5030]  ? __rwlock_init+0x150/0x150
> > > > > [   67.081694][ T5030]  ? __lock_acquire+0x7f70/0x7f70
> > > > > [   67.086727][ T5030]  __fput+0x36a/0x910
> > > > > [   67.090728][ T5030]  task_work_run+0x24a/0x300
> > > > >
> > > > >
> > > > > Were you able to duplicate this locally?
> > > > >
> > > >
> > > > I did not try. Honestly, I don't know how to enable IMA.
> > > > Is the only thing that I need to do is set the IMA policy
> > > > in the kernel command line?
> > > >
> > > > Does IMA need to be enabled per fs? per sb?
> > > >
> > > > If so, I can run the overlay test suite with IMA enabled and
> > > > see what happens.
> > >
> > > Yes, you'll definitely will be able to see the measurement list.
> > >
> > > [Setting up the system to verify file signatures is a bit more
> > > difficult:  files need to be signed, keys need to be loaded.  Finally
> > > CentOS and RHEL 9.3 will have file signatures and will publish the IM=
A
> > > code signing key.]
> > >
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
>
> tmpfs is excluded from policy, since there is no way of storing the
> file signature in the initramfs (CPIO).  There have been a number of
> attempts of extending the initramfs CPIO format.  As you know Al's
> reasons for not using some other format persist today.
>
> "cat /sys/kernel/security/ima/policy" will list the current policy.
> The rules is based on the fsmagic labels.  The builtin policy can be
> replaced with a custom policy.
>
> From include/uapi/linux/magic.h:
> #define TMPFS_MAGIC             0x01021994
>
> > I suppose that is because no one can tamper with the storage
> > of tmpfs, but following the same logic, nobody can tamper with
> > the storage of overlayfs files without tampering with storage of
> > underlying fs (e.g. xfs), so measuring overlayfs files should not
> > bring any extra security to the system.
>
> Sorry, files, especially random name files, can be stored on tmpfs and
> do need to be measured and appraised.
>
> > Especially, since if files are signed they are signed in the real
> > storage (e.g. xfs) and not in overlayfs.
>
> IMA-appraisal needs to prevent executing files that aren't properly
> signed no matter the filesystem.  We can't just ignore the upper
> filesystem.   What happens if file metadata - ower, group, modes -
> changes.  Is the file data and metadata copied up to the overlay?  If
> the file data remains the same, then the file signature should still
> verify.   So it isn't as simple as saying the upper layer shouldn't
> ever be verified.
>
>

But that is not what I am saying.
I wasn't able to make my point, so I will need to use better
terminology.

Overlayfs files/inodes are *virutal unions* of lower and upper
*real* files/inodes.

You are talking about the aspect that on copy up from
real lower to real upper, the IMA signature needs to be copied to the
real upper file, but that is unrelated to the point I am trying to make.

My point is that any read/mmap/exec of an overlay file object
is *always* delegated to either real upper file or real lower file
which are stored in some *real* fs (e.g. xfs).

IMA already verifies signatures on access to the real files,
either lower or upper.
There is no added security in verifying the signature again
on the *union* file, which is just a *virtual* accessor to the
*real* files.

IOW, the only way to tamper with overlayfs file meta/data
is to tamper with the meta/data of the real files in either upper
or lower layer.

> > So in theory, we should never ever measure files in the
> > "virtual" overlayfs and only measure them in the real fs.
> > The only problem is the the IMA hooks when executing,
> > mmaping, reading files from overlayfs, don't work on the real fs.
>
> Right, if the file data changed, then signature verification would fail
> with the existing signature.   And in most situations that is exactly
> what is desired.
>
> It's possible someone would want to sign files on upper layer with
> their own key, but let's ignore that use case scenario for now.
>
> > fsnotify also was not working correctly in that respect, because
> > fs operations on overlayfs did not always trigger fsnotify events
> > on the underlying real fs.
>
> Yes, that will probably address detecting file change on the real inode
> when accessing the lower overlay.   Not sure that it will address the
> upper overlay issues.
>

upper and lower files are both real.

> > This was fixed in 6.5 by commit bc2473c90fca ("ovl: enable fsnotify
> > events on underlying real files") and the file_real_path() infrastructu=
re
> > was added to enable this.
>
> Ok, will take a closer look later.
>
> > This is why I say, that in most likelihood, IMA hook should always use
> > file_real_path() and file_dentry() to perform the measurements
> > and record the path of the real fs when overlayfs is performing the
> > actual read/mmap on the real fs and IMA hooks should ideally
> > do nothing at all (as in tmpfs) when the operation is performed
> > on the "virtual" overlayfs object.
>
> An IMA policy rule could be defined to ignore the upper layer, but it
> can't be the default.  If the policy is always measure and appraise
> executables and mmap'ed libraries regardless of the filesystem, then we
> can't just ignore the upper layer.
>

It should not ignore the upper layer.
It should ignore the virtual union of lower+upper which is
called overlayfs.

> Shannah tova!
>

Shana Tova!
Amir.
