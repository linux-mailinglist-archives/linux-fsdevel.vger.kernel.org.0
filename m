Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71AD319B27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 09:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhBLIXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 03:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhBLIXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:23:07 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE16FC061574;
        Fri, 12 Feb 2021 00:22:27 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id q5so7485192ilc.10;
        Fri, 12 Feb 2021 00:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QbnuU3w0fMxLbjjXQCuQlV17YLHiXRweTN+JAYolKs=;
        b=iplLAyDNexWr1YjMBumTYEKEEMPoTGBydbtrQL2Hi0O3xMaZAnvFZ9JRk5QvBWu0FZ
         QC/3IxUbnMQb1GNzLaq56xtHoWSxFBzwNvFCQIGzM8d5Cd4GcNPVRNBhtDEToe8+ulaQ
         1PhKDBCAPo1fc4N8yfZg71LZ+odREfKQy9YbAIww45p1x40LSK7hfvRN8uvxF1K6WeKu
         h5Q0pKBOs5pM31xtZlenADnIrTJYIadYuy0U8OZJg2IEHdp8Jfd+RFqRYNuVdFU8RXcl
         Y64h0+52lbkvvi3DXhNwaF+nD70QR9nWKly7nD0X7H7r3SYg6ENA2jePcp2rMrdjrZz0
         voDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QbnuU3w0fMxLbjjXQCuQlV17YLHiXRweTN+JAYolKs=;
        b=BX/pa/7GeJskC5MyoHz37faGNWkfkUNAzhpGq3o4VsuVkice2D/vlZI6nPHbIVIi3f
         StV7DQ9fgwQSG0cWb0EKpxA4TJuVG/AUObV8skpRgVivJCWYLB0bUkY4H/X3y9fEDtTx
         5MGvXI10s1uYXhKXVrvMHrrfULCA2a/cN+l4nuPrRiW6FRdNPcUnnfDc7jyaUSuGixSy
         WQZOlBeGCPYfAfrzlK80rM9PbHo0T34HmepaxGYyTYAXeq9XUVIu55Jm/tmWihjbMpPC
         ZAFs+dcGIRlH4JnqWGbTqfZxA7dqdyqzm8hQfk/75HAv0gajK3yYTnDj6UwzWwHuygc+
         Vx9A==
X-Gm-Message-State: AOAM531DwF+N3TBGFgUf4oUZyU6MNDoGvReGPwWhfBj8ld3W7QtsN/PS
        jj0qiWTT7IrBBocIeTWKaRZb8kaLuLwKex+TeEA=
X-Google-Smtp-Source: ABdhPJyrXMlshXTgv5ZY6W5If1SjxvuVfmYaBhOjwCFVOCXG0cpNzO/sIEln1zjGEogtIKp6reu5gKb8k8u0Rib4jVY=
X-Received: by 2002:a05:6e02:2c2:: with SMTP id v2mr1532394ilr.137.1613118147110;
 Fri, 12 Feb 2021 00:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid> <YCYybUg4d3+Oij4N@kroah.com>
In-Reply-To: <YCYybUg4d3+Oij4N@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 12 Feb 2021 10:22:16 +0200
Message-ID: <CAOQ4uxhovoZ4S3WhXwgYDeOeomBxfQ1BdzSyGdqoVX6boDOkeA@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 9:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 12, 2021 at 12:44:00PM +0800, Nicolas Boichat wrote:
> > Filesystems such as procfs and sysfs generate their content at
> > runtime. This implies the file sizes do not usually match the
> > amount of data that can be read from the file, and that seeking
> > may not work as intended.
> >
> > This will be useful to disallow copy_file_range with input files
> > from such filesystems.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> > I first thought of adding a new field to struct file_operations,
> > but that doesn't quite scale as every single file creation
> > operation would need to be modified.
>
> Even so, you missed a load of filesystems in the kernel with this patch
> series, what makes the ones you did mark here different from the
> "internal" filesystems that you did not?
>
> This feels wrong, why is userspace suddenly breaking?  What changed in
> the kernel that caused this?  Procfs has been around for a _very_ long
> time :)

That would be because of (v5.3):

5dae222a5ff0 vfs: allow copy_file_range to copy across devices

The intention of this change (series) was to allow server side copy
for nfs and cifs via copy_file_range().
This is mostly work by Dave Chinner that I picked up following requests
from the NFS folks.

But the above change also includes this generic change:

-       /* this could be relaxed once a method supports cross-fs copies */
-       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
-               return -EXDEV;
-

The change of behavior was documented in the commit message.
It was also documented in:

88e75e2c5 copy_file_range.2: Kernel v5.3 updates

I think our rationale for the generic change was:
"Why not? What could go wrong? (TM)"
I am not sure if any workload really gained something from this
kernel cross-fs CFR.

In retrospect, I think it would have been safer to allow cross-fs CFR
only to the filesystems that implement ->{copy,remap}_file_range()...

Our option now are:
- Restore the cross-fs restriction into generic_copy_file_range()
- Explicitly opt-out of CFR per-fs and/or per-file as Nicolas' patch does

Preference anyone?

Thanks,
Amir.
