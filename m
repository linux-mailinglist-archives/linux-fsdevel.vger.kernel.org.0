Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B824531A836
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhBLXQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 18:16:04 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:52339 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhBLXQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:16:02 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 723661AD616;
        Sat, 13 Feb 2021 10:15:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lAhed-001sT9-SG; Sat, 13 Feb 2021 10:15:15 +1100
Date:   Sat, 13 Feb 2021 10:15:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <20210212231515.GV4626@dread.disaster.area>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com>
 <CAOQ4uxhovoZ4S3WhXwgYDeOeomBxfQ1BdzSyGdqoVX6boDOkeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhovoZ4S3WhXwgYDeOeomBxfQ1BdzSyGdqoVX6boDOkeA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=ag1SF4gXAAAA:8 a=cm27Pg_UAAAA:8
        a=7-415B0cAAAA:8 a=P2FMUFWqZWbRXQpyToAA:9 a=CjuIK1q_8ugA:10
        a=Yupwre4RP9_Eg_Bd0iYG:22 a=xmb-EsYY8bH0VWELuYED:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:22:16AM +0200, Amir Goldstein wrote:
> On Fri, Feb 12, 2021 at 9:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 12, 2021 at 12:44:00PM +0800, Nicolas Boichat wrote:
> > > Filesystems such as procfs and sysfs generate their content at
> > > runtime. This implies the file sizes do not usually match the
> > > amount of data that can be read from the file, and that seeking
> > > may not work as intended.
> > >
> > > This will be useful to disallow copy_file_range with input files
> > > from such filesystems.
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > ---
> > > I first thought of adding a new field to struct file_operations,
> > > but that doesn't quite scale as every single file creation
> > > operation would need to be modified.
> >
> > Even so, you missed a load of filesystems in the kernel with this patch
> > series, what makes the ones you did mark here different from the
> > "internal" filesystems that you did not?
> >
> > This feels wrong, why is userspace suddenly breaking?  What changed in
> > the kernel that caused this?  Procfs has been around for a _very_ long
> > time :)
> 
> That would be because of (v5.3):
> 
> 5dae222a5ff0 vfs: allow copy_file_range to copy across devices
> 
> The intention of this change (series) was to allow server side copy
> for nfs and cifs via copy_file_range().
> This is mostly work by Dave Chinner that I picked up following requests
> from the NFS folks.
> 
> But the above change also includes this generic change:
> 
> -       /* this could be relaxed once a method supports cross-fs copies */
> -       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> -               return -EXDEV;
> -

This isn't the problem.

The problem is that proc sets the file size to zero length, so
if you attempt to CFR from one proc file to another it will still
report "zero bytes copied" because the source file is zero length.

The other problem is that if the write fails, the generated data
from the /proc file gets thrown away - the splice code treats write
failures like a short read and hence the data sent to the failed
write is consumed and lost.

This has nothing to do with cross-fs cfr support - it's just one
mechanism that can be used to expose the problems that using CFR on
pipes that masquerade as regular files causes.

Userspace can't even tell that CFR failed incorrectly, because the
files that it returns immediate EOF on are zero length. Nor can
userspace know taht a short read tossed away data, because it might
actually be a short read rather than a write failure...

> Our option now are:
> - Restore the cross-fs restriction into generic_copy_file_range()
> - Explicitly opt-out of CFR per-fs and/or per-file as Nicolas' patch does

- Stop trying using cfr for things it was never intended for.

Anyone using cfr has to be prepared for it to fail and do the copy
manually themselves. If you can't tell from userspace if a file has
data in it without actually calling read(), then you can't use
copy_file_range() on it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
