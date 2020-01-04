Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB3130506
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 00:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgADXJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 18:09:55 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35329 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgADXJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 18:09:55 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so39501534ild.2;
        Sat, 04 Jan 2020 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5h7mfBew8wC4kdHYjQMvUUauyZUHrjPQhLOax9PMq8=;
        b=Y6r6sMZcTINd+BpvoIoqf/KfVky43qhhbOVRJ6C6ckbmylOGRHoNQdvl6aMEE8tHk0
         xPKNIrIi550uVnrcP+6RkVYXG6sJuRGPwWPqQWEWPJOsRjOivmiinr8rz0VL3+rMISrn
         BKVSLxkuPoDak+20UeIrzIauJN2AShLrepEb2BLaBuGkSqPAavpl2I1Bt8JMoZFv052B
         EFals0ZzmqsNnFUz5g/en6mBEiTBmTK7csRQLPqAvhmbVtdEBgRaKTvAWiyLcJH93Qhs
         HLhrt2nf6DuHRshcQKoyJfZtjPgktmCKLW9e1Nnzaxmfj5iE1T2JNXNqJH4U10bz70ot
         W9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5h7mfBew8wC4kdHYjQMvUUauyZUHrjPQhLOax9PMq8=;
        b=ad84XM88PFRWsEtaf/fcMGroPZq0cGXGf70d6GfwcvzVZV2bgljarBAjWZJlQzekqi
         +Ymgshgv2YXiyOr/69brAsqrQfqp4esfm5nRx14dJTEoRBVaLHOJ0OgTlPWCf6cJrc8X
         w0SnzaYg6RrvVOPYnx6x/DvObhGt1DPrTDhrmxJ/ARb6hKNt0M1Ru8ij9VaQ0uIPMLGk
         pycn14uz3igNjpqYZPL9L8R9pWnK19uKOjjijeIyPe3r+t60jYKK9a562DwYc0hwRq2g
         bPyghCPP/ntNTZwg1graPx6Eb0Fyog4TIJkYFO2bIWSH+yB4RmzlBZ+bI2C/iKstrlo5
         Tr5w==
X-Gm-Message-State: APjAAAXn/ktFyCaXvf5AcQ6tci80FkKYBy6KhSXvetvvtP2K8hyiVjDq
        0MM0x3MtDUWXm7igOZSKicfC5vj46NYamf9N2KM=
X-Google-Smtp-Source: APXvYqzZ2UDAuVr2nPrEr+J0x7kp+K/k9mdOk/lQHOX0B+nZKLJyviwIpaR5z2Ymb3MTw67mmtaUnsHURQbwHcXLkY4=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr80650566ilq.250.1578179394394;
 Sat, 04 Jan 2020 15:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com> <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 5 Jan 2020 01:09:43 +0200
Message-ID: <CAOQ4uxiMJePVaXFiLw88rnr4qxCPN0dLQcXq_KCC831hZzM7rA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 4, 2020 at 10:41 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This implementation reverse shifts according to the user_ns belonging
> to the mnt_ns.  So if the vfsmount has the newly introduced flag
> MNT_SHIFT and the current user_ns is the same as the mount_ns->user_ns
> then we shift back using the user_ns before committing to the
> underlying filesystem.
>
> For example, if a user_ns is created where interior (fake root, uid 0)
> is mapped to kernel uid 100000 then writes from interior root normally
> go to the filesystem at the kernel uid.  However, if MNT_SHIFT is set,
> they will be shifted back to write at uid 0, meaning we can bind mount
> real image filesystems to user_ns protected faker root.
>
> In essence there are several things which have to be done for this to
> occur safely.  Firstly for all operations on the filesystem, new
> credentials have to be installed where fsuid and fsgid are set to the
> *interior* values.

Must we really install new creds?
Maybe we just need to set/clear a SHIFTED flag on current creds?

i.e. instead of change_userns_creds(path)/revert_userns_creds()
how about start_shifted_creds(mnt)/end_shifted_creds().

and then cred_is_shifted() only checks the flag and no need for
all the cached creds mechanism.

current_fsuid()/current_fsgid() will take care of the shifting based on
the creds flag.

Also, you should consider placing a call to start_shifted/end_shifted
inside __mnt_want_write()/__mnt_drop_write().
This should automatically cover all writable fs ops  - including some that
you missed (setxattr).

Taking this a step further, perhaps it would make sense to wrap all readonly
fs ops with mnt_want_read()/mnt_drop_read() flavors.
Note that inode level already has a similar i_readcount access counter.

This could be used, for example, to provide a facility that is stronger than
MNT_DETACH, and weaker than filesystem "shutdown" ioctl, for blocking
new file opens (with openat()) on a mounted filesystem.

The point is, you add gating to vfs that is generic and not for single use
case (i.e. cred shifting).

Apologies in advance if  some of these ideas are ill advised.

Thanks,
Amir.
