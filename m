Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D5713B92B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 06:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgAOFo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 00:44:58 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41783 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOFo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:44:58 -0500
Received: by mail-il1-f193.google.com with SMTP id f10so13759816ils.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 21:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QbplNxmIl6kC//L9+JlCfszdEaKSQY4wQVluIx8pQqg=;
        b=vhxewt4XtLrXBjmbmWZsLrmsGjukLgAPBzn1aCkqcwB4gdHryKMnSQ/h5MeorrGV+F
         MRjJE54pVuoNCfPvnTIrTYgcoYqDfHXNjS39qquVKXe4u/lLCnipET9QDa5BkLLRyBiQ
         RtZ4unOhKuPXE72l2tyhq8XbQWujXVExHcBszN1CXflDweRdzk2NnMifgECPirfskGu0
         bNKJVWUBkTjmkrNQ0F/I5U3HF2oh69hRPUeQOtRi1zHWOa3bySbuZmjXoaqGxMBfxEKZ
         FitEhPTsj2mK3Nz9OIls75sgYAhPAltDKiG+ids/GF/e4m5fRhNu6EMwOfikmDFdJ2jZ
         he2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QbplNxmIl6kC//L9+JlCfszdEaKSQY4wQVluIx8pQqg=;
        b=ISHZ1drJxUTs489aAj8beXWT15eIMP+o/6I8+7agnKYqTU5+I0LD9RiA5pnB8iREEt
         EK3Eojx4MpKmqulakMwn0uQrMXb/Wl6idnsAR02ZPc1BB+FtO1jcatBDIoFm7UEe+MCZ
         3QuhdpXFRMGelaooyN+ADsA/lZQAmLmX617zzxaM/su3E7cn+hR3DKdPKFRBMig2xx6p
         nCW0kIeRfF3mtyjIuHpFh7xnZhvrED24qO+Oudz1kwnEsJuejYnWtHYJqsIAJzIQROuT
         71HHF9FqoAJXrSv3Zk8hKbTxC1meOB4PW8pwSx3ZlUNWlbHIJyXzQlXR6el93F3dxw12
         B2mg==
X-Gm-Message-State: APjAAAX/0zowRsFd2GVOV83189VT4kdffnKA26QDhu9vAxrJ0EAAT24j
        ZC/4bx6MnuxJFtkyYzTc9JPtejYzFpxlXear04tsr70z
X-Google-Smtp-Source: APXvYqxrGM9vpv5guX8BC0fIzD3Dcvzi4dIymQknbxknub69UI4SxZ8QGqE2/i4xq42cCtDs5fvbeuwgbTqgWyV+Yi4=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr2157091ilg.137.1579067097668;
 Tue, 14 Jan 2020 21:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20200114154034.30999-1-amir73il@gmail.com> <20200114162234.GZ8904@ZenIV.linux.org.uk>
 <CAOQ4uxjbRzuAPHbgyW+uGmamc=fZ=eT_p4wCSb0QT7edtUqu8Q@mail.gmail.com>
 <20200114191907.GC8904@ZenIV.linux.org.uk> <CAOQ4uxh-1cUQtWoNR+JzR0fCo-yEC4UrQGcZvKyj6Pg11G7FRQ@mail.gmail.com>
 <CAOQ4uxggg4p6MD2LiAKr2dzj+35iA-B3BptXPpOjWMEUX=QbeA@mail.gmail.com> <20200115000905.GE8904@ZenIV.linux.org.uk>
In-Reply-To: <20200115000905.GE8904@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jan 2020 07:44:46 +0200
Message-ID: <CAOQ4uxhjfp8hLxgOonPz_xuwhYVO+2G03iM6sSP6O_UfMrKTLQ@mail.gmail.com>
Subject: Re: dcache: abstract take_name_snapshot() interface
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 2:09 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 15, 2020 at 02:03:35AM +0200, Amir Goldstein wrote:
>
> > Only problem I forgot about is that I need to propagate name_snapshot
> > into fsnotify_move() instead of qstr (in order to snapshot it).
> > That means I will need to snapshot also new_dentry in vfs_rename(), so
> > I have a name_snapshot to pass into the RENAME_EXCHANGE
> > fsnotify_move() hook.
> >
> > My current patch passes the cute &old_dentry->d_name_snap abstract
> > to fsnotify_move().
> >
> > What shall I do about that?
> >
> >         take_dentry_name_snapshot(&new_name, new_dentry);
> > ???
>
> Wait a sec...  How long is that thing going to be using the snapshot?
> And I bloody well hope that this is _not_ going to be unconditional -
> having each rename() pay for *notify is a bad idea, for obvious
> reasons.  Details, please...

Well, if nobody asked to get notifications about entry name changes,
the snapshot is going to stay alive until fsnotify(), same as old_name
with current code.

The addition of new_name snapshot is only needed for the
RENAME_EXCHANGE case and will be conditional to the flag.

If anyone asked for notifications about entry name changes via the new
FAN_DIR_MODIFY [1][2] event, then event will be queued with a clone
of the name_snapshot that will live until user reads the event.

This is similar to the way that fanotify events keep the dentry refcount
elevated until user reads an event (for reporting object fd)

The advantage of snapshotting the name instead of copy, beyond the
obvious is that events can be allocated from a dedicated kmem_cache
and avoid spurious small variable sized allocations.

An argument in favor of allocating a variable size buffer by fanotify to
copy the name is that fanotify accounts event allocations to the group->memcg
of the watcher, so the risk of DoS on the system gets smaller.
One of the less advertised improvements of FAN_REPORT_FID in v5.1
is that events do not keep an elevated refcount on dentries, the way that
they do with 'legacy' fanotify (reporting fd as object id).

FAN_REPORT_FID_NAME will be a little step back in that sense if it
holds a reference on the name.

As you can see, I am not fixed into snapshot or copy the name.
Looking for opinions is one of the reasons I posted this early bird.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20200108120422.GD20521@quack2.suse.cz/
[2] https://github.com/amir73il/linux/commits/fanotify_name
