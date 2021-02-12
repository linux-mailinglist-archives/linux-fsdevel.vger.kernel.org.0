Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A41319E3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 13:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhBLMUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 07:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhBLMS4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:18:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 343D264E23;
        Fri, 12 Feb 2021 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613132295;
        bh=PU4VW0JNQGSbREgmbJ1nOCN/MQP6HELV1e9AbMABgmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1lp83Nl95w3AmB0LUeZKyJ6PffpiVjLMU+GNOAt/NUXEVwLPMO9nPTPFFrN8q1uN
         rDTWC1dMqFDT1Hm9Xioy0luL8pvHVWQCTf55leJg4am8LoCbc4O7ISa+NmMFWT5cTJ
         qVTHYvkDIP8yRR9Tf/qSQWOf/bqEzR2lUpR7WN74=
Date:   Fri, 12 Feb 2021 13:18:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
Message-ID: <YCZyBZ1iT+MUXLu1@kroah.com>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com>
 <CAOQ4uxhovoZ4S3WhXwgYDeOeomBxfQ1BdzSyGdqoVX6boDOkeA@mail.gmail.com>
 <YCY+tjPgcDmgmVD1@kroah.com>
 <871rdljxtx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rdljxtx.fsf@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:05:14PM +0000, Luis Henriques wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Feb 12, 2021 at 10:22:16AM +0200, Amir Goldstein wrote:
> >> On Fri, Feb 12, 2021 at 9:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >> >
> >> > On Fri, Feb 12, 2021 at 12:44:00PM +0800, Nicolas Boichat wrote:
> >> > > Filesystems such as procfs and sysfs generate their content at
> >> > > runtime. This implies the file sizes do not usually match the
> >> > > amount of data that can be read from the file, and that seeking
> >> > > may not work as intended.
> >> > >
> >> > > This will be useful to disallow copy_file_range with input files
> >> > > from such filesystems.
> >> > >
> >> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >> > > ---
> >> > > I first thought of adding a new field to struct file_operations,
> >> > > but that doesn't quite scale as every single file creation
> >> > > operation would need to be modified.
> >> >
> >> > Even so, you missed a load of filesystems in the kernel with this patch
> >> > series, what makes the ones you did mark here different from the
> >> > "internal" filesystems that you did not?
> >> >
> >> > This feels wrong, why is userspace suddenly breaking?  What changed in
> >> > the kernel that caused this?  Procfs has been around for a _very_ long
> >> > time :)
> >> 
> >> That would be because of (v5.3):
> >> 
> >> 5dae222a5ff0 vfs: allow copy_file_range to copy across devices
> >> 
> >> The intention of this change (series) was to allow server side copy
> >> for nfs and cifs via copy_file_range().
> >> This is mostly work by Dave Chinner that I picked up following requests
> >> from the NFS folks.
> >> 
> >> But the above change also includes this generic change:
> >> 
> >> -       /* this could be relaxed once a method supports cross-fs copies */
> >> -       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> >> -               return -EXDEV;
> >> -
> >> 
> >> The change of behavior was documented in the commit message.
> >> It was also documented in:
> >> 
> >> 88e75e2c5 copy_file_range.2: Kernel v5.3 updates
> >> 
> >> I think our rationale for the generic change was:
> >> "Why not? What could go wrong? (TM)"
> >> I am not sure if any workload really gained something from this
> >> kernel cross-fs CFR.
> >
> > Why not put that check back?
> >
> >> In retrospect, I think it would have been safer to allow cross-fs CFR
> >> only to the filesystems that implement ->{copy,remap}_file_range()...
> >
> > Why not make this change?  That seems easier and should fix this for
> > everyone, right?
> >
> >> Our option now are:
> >> - Restore the cross-fs restriction into generic_copy_file_range()
> >
> > Yes.
> >
> 
> Restoring this restriction will actually change the current cephfs CFR
> behaviour.  Since that commit we have allowed doing remote copies between
> different filesystems within the same ceph cluster.  See commit
> 6fd4e6348352 ("ceph: allow object copies across different filesystems in
> the same cluster").
> 
> Although I'm not aware of any current users for this scenario, the
> performance impact can actually be huge as it's the difference between
> asking the OSDs for copying a file and doing a full read+write on the
> client side.

Regression in performance is ok if it fixes a regression for things that
used to work just fine in the past :)

First rule, make it work.

thanks,

greg k-h
