Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443F71FE999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 05:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgFRDpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFRDpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:45:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717B2C06174E;
        Wed, 17 Jun 2020 20:45:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b4so4277217qkn.11;
        Wed, 17 Jun 2020 20:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E4WVx3mfVHTIynvqaASmx3kJDP8cMZcWWMKXBtc+T4g=;
        b=iXr3J1+CE8J2EENEerAJeaGxzwxK53TqDIe0XrX+GpdlGkNUiQEjTO+tR2qF8N4r9Z
         ESm8iPliifxmoAGXNYkb7s0Y1ib4VGmLy1dLODbx8/4KWRVuEaqy1aTZtEywf84cwFYo
         ZO07YENnRduzyec5XGCL8FJ5yUI+Kfjp+fP2T5aBHBO1LAVn3dfdYj2iQ8p299xIaRnQ
         fW7vW53qGzecwsmdruAGIDBK/QR0odkL8riCV78Z/6jacBIBLezg+M58dsm31CtcVSZT
         BKjXBx9hG1PKRPlppPEBwVqyxkhIO0tv+NJwq0K2E2Mda3H/hnqKLWe1Ijvk355dsIQV
         HLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E4WVx3mfVHTIynvqaASmx3kJDP8cMZcWWMKXBtc+T4g=;
        b=N5Hzvxo/HrIAzfAmnMlnDsMOiXDjiqTsqrjFP9MwuzYc+K+JsHpUUH/uYJ085B2aMo
         PsebWzcWotv9lHZfYSI/oLvr1zseuqOfrrKYyDPU/HP+AwImawnLW1qsKCdToAm2KrJU
         Aixx5fU4fBfQES9/M/gT5MgWGdtZYPQ6HLD1+auSyy1o6VfTd71MHxNoQDOnEKHE1dav
         ZpPCS6HTbIp1vUJP2SB9u5o/Kn91bcaTsEVfOhByn8BCC/WCVgrBSLOB5+IBYW5254YK
         p2APpkrZZLzylUSKcao/BMPMrUF/Mr0Rnm7XgO1YBFYlpbMJmAwt5GpePhpfnavzyzdl
         z3yg==
X-Gm-Message-State: AOAM532BlsO6DJ3k29LIoq8PHpwJIuvq/WAaqiIhVwXmV7TPepyzOMnc
        SsAIgXK+MRNVObpV+jxZOg==
X-Google-Smtp-Source: ABdhPJzmzJcLMNdXiXwFVwuG7zJYOdkJoVtqYvTWSC+lNuvpUirXNk8inAz4bramoCVCKWmaUEjXNA==
X-Received: by 2002:a37:7645:: with SMTP id r66mr1836780qkc.397.1592451937715;
        Wed, 17 Jun 2020 20:45:37 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id v14sm2012859qtj.31.2020.06.17.20.45.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 20:45:37 -0700 (PDT)
Date:   Wed, 17 Jun 2020 23:45:35 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200618034535.h5ho7pd4eilpbj3f@gabell>
References: <20200617080314.GA7147@infradead.org>
 <20200617155836.GD13815@fieldses.org>
 <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618030539.GH2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:05:39PM +1000, Dave Chinner wrote:
> On Wed, Jun 17, 2020 at 09:30:26PM -0400, Masayoshi Mizuma wrote:
> > On Wed, Jun 17, 2020 at 02:45:07PM -0400, J. Bruce Fields wrote:
> > > On Wed, Jun 17, 2020 at 01:28:11PM -0500, Eric Sandeen wrote:
> > > > but mount(8) has already exposed this interface:
> > > > 
> > > >        iversion
> > > >               Every time the inode is modified, the i_version field will be incremented.
> > > > 
> > > >        noiversion
> > > >               Do not increment the i_version inode field.
> > > > 
> > > > so now what?
> > > 
> > > It's not like anyone's actually depending on i_version *not* being
> > > incremented.  (Can you even observe it from userspace other than over
> > > NFS?)
> > > 
> > > So, just silently turn on the "iversion" behavior and ignore noiversion,
> > > and I doubt you're going to break any real application.
> > 
> > I suppose it's probably good to remain the options for user compatibility,
> > however, it seems that iversion and noiversiont are useful for
> > only ext4.
> > How about moving iversion and noiversion description on mount(8)
> > to ext4 specific option?
> > 
> > And fixing the remount issue for XFS (maybe btrfs has the same
> > issue as well)?
> > For XFS like as:
> > 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 379cbff438bc..2ddd634cfb0b 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1748,6 +1748,9 @@ xfs_fc_reconfigure(
> >                         return error;
> >         }
> > 
> > +       if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
> > +               mp->m_super->s_flags |= SB_I_VERSION;
> > +
> >         return 0;
> >  }
> 
> no this doesn't work, because the sueprblock flags are modified
> after ->reconfigure is called.
> 
> i.e. reconfigure_super() does this:
> 
> 	if (fc->ops->reconfigure) {
> 		retval = fc->ops->reconfigure(fc);
> 		if (retval) {
> 			if (!force)
> 				goto cancel_readonly;
> 			/* If forced remount, go ahead despite any errors */
> 			WARN(1, "forced remount of a %s fs returned %i\n",
> 			     sb->s_type->name, retval);
> 		}
> 	}
> 
> 	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
> 				 (fc->sb_flags & fc->sb_flags_mask)));
> 
> And it's the WRITE_ONCE() line that clears SB_I_VERSION out of
> sb->s_flags. Hence adding it in ->reconfigure doesn't help.
> 
> What we actually want to do here in xfs_fc_reconfigure() is this:
> 
> 	if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
> 		fc->sb_flags_mask |= SB_I_VERSION;
> 
> So that the SB_I_VERSION is not cleared from sb->s_flags.
> 
> I'll also note that btrfs will need the same fix, because it also
> sets SB_I_VERSION unconditionally, as will any other filesystem that
> does this, too.

Thank you for pointed it out.
How about following change? I believe it works both xfs and btrfs...

diff --git a/fs/super.c b/fs/super.c
index b0a511bef4a0..42fc6334d384 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -973,6 +973,9 @@ int reconfigure_super(struct fs_context *fc)
                }
        }

+       if (sb->s_flags & SB_I_VERSION)
+               fc->sb_flags |= MS_I_VERSION;
+
        WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
                                 (fc->sb_flags & fc->sb_flags_mask)));
        /* Needs to be ordered wrt mnt_is_readonly() */


- Masa

> 
> Really, this is just indicative of the mess that the mount
> flags vs superblock feature flags are. Filesystems can choose to
> unconditionally support various superblock features, and no mount
> option futzing from userspace should -ever- be able to change that
> feature. Filesystems really do need to be able to override mount
> options that were parsed in userspace and turned into a binary
> flag...
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
