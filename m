Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E6F31E69B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 08:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBRG74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 01:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhBRGss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:48:48 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D80C061756;
        Wed, 17 Feb 2021 22:47:55 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id f20so937091ioo.10;
        Wed, 17 Feb 2021 22:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coiC7DZFnkZ3fn3Had2P/TEGLEiePcjS1aihuXLrqo0=;
        b=ZP4+TEG3PRI4KEmWy+2KnTG2H1BvtyGd+Ke5l26XaLjHKlxY45DH/t8UDVqQfJqKR9
         C+5AbhTx6txfQml9o9H6+0wPd1CtzXVrFiy7Iir+JN8/nNut7q6XiE0T0bFQrwgeYzuV
         dYAQ21uwLbuEW8ThWGmbc7vPtLZJLXIipW3cbXOQgoKnwhCEG46VqaHI1kI8pWkc3oX3
         kkXevkAisePyXhw/n4ekcR9HrHuXRZHGvGFrwGD5+UKu+DvYky+5plGM7M+o7C/t2NDM
         EW2Pk3++F4zU8Wkcep/sjSKT5LUosprer1AmYvhU1Aei8XZmepcRftVQkyHwFqWdhgtc
         JNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coiC7DZFnkZ3fn3Had2P/TEGLEiePcjS1aihuXLrqo0=;
        b=Eevh9XFBS+rChSfLitWnpbkDINbyNsHivKgB3yEecAurgOchAzmOfLgDzVzdugiHvh
         hxpThYH73sugxQ0t1JotqgCcYu66VgDS0sKlh9VxNkJRYNlaQIQKkFrYqoiF+eLQ4eNA
         Cbehg3qLE0k2V7lK4y3180kvOeA1tKKt8FbC9/EqmcedtIYJnOO2uFCucj0a2Ye+4Mc+
         dQzYd5PRqUck9Sdlpx7X+pc0xs0lPhbgnibFwcZ3baM5MmiLofDXu0Wc2u6TrWnlctOb
         7bPD+g6kzoWvrKhJQcYUfyIIK1fqDEk3YA5wcg1mKUG7SPtYd1evgnMv65U2EWf4/vBy
         4sEw==
X-Gm-Message-State: AOAM531nJi+ezDRS8qDfqNO9NpxHmPcV6VKw4hYTe2xBJFfSW9L7tR/e
        upQbg/QirBsVi9k3ZBQsWOqT2/vPK7Z6zWFWxOM=
X-Google-Smtp-Source: ABdhPJyXIPnk2aIwWEt6skFJ+WTgQlXts+vv2jLkbhIcChUBX+p0Yv1qMnm1M6CE0tczJ7I9La5fe6dLBQ2kNBQYlkU=
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr2457301iot.186.1613630874598;
 Wed, 17 Feb 2021 22:47:54 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
 <20210217172654.22519-1-lhenriques@suse.de> <CAN-5tyHVOphSkp3n+V=1gGQ40WNZGHQURSMMdFBS3jRVGfEXhA@mail.gmail.com>
In-Reply-To: <CAN-5tyHVOphSkp3n+V=1gGQ40WNZGHQURSMMdFBS3jRVGfEXhA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 08:47:43 +0200
Message-ID: <CAOQ4uxi08oG9=Oadvt6spA9+zA=dcb-UK8AL-+o2Fn3d57d7iw@mail.gmail.com>
Subject: Re: [PATCH v3] vfs: fix copy_file_range regression in cross-fs copies
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 7:33 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Wed, Feb 17, 2021 at 3:30 PM Luis Henriques <lhenriques@suse.de> wrote:
> >
> > A regression has been reported by Nicolas Boichat, found while using the
> > copy_file_range syscall to copy a tracefs file.  Before commit
> > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > kernel would return -EXDEV to userspace when trying to copy a file across
> > different filesystems.  After this commit, the syscall doesn't fail anymore
> > and instead returns zero (zero bytes copied), as this file's content is
> > generated on-the-fly and thus reports a size of zero.
> >
> > This patch restores some cross-filesystems copy restrictions that existed
> > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > devices").  It also introduces a flag (COPY_FILE_SPLICE) that can be used
> > by filesystems calling directly into the vfs copy_file_range to override
> > these restrictions.  Right now, only NFS needs to set this flag.
> >
> > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > ---
> > Ok, I've tried to address all the issues and comments.  Hopefully this v3
> > is a bit closer to the final fix.
> >
> > Changes since v2
> > - do all the required checks earlier, in generic_copy_file_checks(),
> >   adding new checks for ->remap_file_range
> > - new COPY_FILE_SPLICE flag
> > - don't remove filesystem's fallback to generic_copy_file_range()
> > - updated commit changelog (and subject)
> > Changes since v1 (after Amir review)
> > - restored do_copy_file_range() helper
> > - return -EOPNOTSUPP if fs doesn't implement CFR
> > - updated commit description
>
> In my testing, this patch breaks NFS server-to-server copy file.

Hi Olga,

Can you please provide more details on the failed tests.

Does it fail on the client between two nfs mounts or does it fail
on the server? If the latter, between which two filesystems on the server?

Thanks,
Amir.
