Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46454462EEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 09:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbhK3Izh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 03:55:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37588 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhK3Izf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:55:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16AA6B817DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 08:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C86C53FC7;
        Tue, 30 Nov 2021 08:52:12 +0000 (UTC)
Date:   Tue, 30 Nov 2021 09:52:10 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 08/10] fs: port higher-level mapping helpers
Message-ID: <20211130085210.rqs5vkeuoo7g2bwo@wittgenstein>
References: <20211123114227.3124056-1-brauner@kernel.org>
 <20211123114227.3124056-9-brauner@kernel.org>
 <CAOQ4uxhWj_o0WFUpJn7d-YXpT_dTNFWBPzetb13N8LkyMywbDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhWj_o0WFUpJn7d-YXpT_dTNFWBPzetb13N8LkyMywbDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:15:35AM +0200, Amir Goldstein wrote:
> On Tue, Nov 23, 2021 at 3:29 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > Enable the mapped_fs{g,u}id() helpers to support filesystems mounted
> > with an idmapping. Apart from core mapping helpers that use
> > mapped_fs{g,u}id() to initialize struct inode's i_{g,u}id fields xfs is
> > the only place that uses these low-level helpers directly.
> >
> > The patch only extends the helpers to be able to take the filesystem
> > idmapping into account. Since we don't actually yet pass the
> > filesystem's idmapping in no functional changes happen. This will happen
> > in a final patch.
> >
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > CC: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  fs/xfs/xfs_inode.c          | 10 ++++++----
> >  fs/xfs/xfs_symlink.c        |  5 +++--
> >  include/linux/fs.h          |  8 ++++----
> >  include/linux/mnt_mapping.h | 12 ++++++++----
> >  4 files changed, 21 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 64b9bf334806..7ac8247b5498 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -977,6 +977,7 @@ xfs_create(
> >         struct xfs_trans_res    *tres;
> >         uint                    resblks;
> >         xfs_ino_t               ino;
> > +       struct user_namespace   *fs_userns = &init_user_ns;
> >
> >         trace_xfs_create(dp, name);
> >
> > @@ -988,8 +989,8 @@ xfs_create(
> >         /*
> >          * Make sure that we have allocated dquot(s) on disk.
> >          */
> > -       error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns),
> > -                       mapped_fsgid(mnt_userns), prid,
> > +       error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, fs_userns),
> > +                       mapped_fsgid(mnt_userns, fs_userns), prid,
> 
> I am confused.
> Do we intend to enable idmapped xfs sb?

No, I don't think we need to given that we have idmapped mount support.
I'm happy to just continue passing down the initial idmapping.


> If the answer is yes, then feel free to add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> I did a quick review pass of all the patches.
> The ones I did not reply to I felt I needed to take a close look
> so will continue with the review later.

Thank you, appreciate it!

Christian
