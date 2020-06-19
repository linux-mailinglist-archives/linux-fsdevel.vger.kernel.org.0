Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753A3200853
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgFSMFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 08:05:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46233 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731717AbgFSME7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592568297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orSSRgFfv3qUT+UsrD9xGOSEY9WAuTcx2l/m7DY5Xdw=;
        b=BPMTzPVEQmaEzwMozOrjyq0scppsH0DlhJbiu0JO67KQuOnyvB8IdoK5u4NwrGbdQ6PlVa
        1ZqJUKLv6J5opxlulAoFBvmKVxzGqv4R/0vjJez7x5M6kPkfxFezmjMfrFax99iLwJR93w
        TCwhcO+x4ETPPMDWNZKvIEnVoK3DjtA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-9j0xX_7MNp-Kmziz-CKQcQ-1; Fri, 19 Jun 2020 08:04:55 -0400
X-MC-Unique: 9j0xX_7MNp-Kmziz-CKQcQ-1
Received: by mail-qv1-f71.google.com with SMTP id 59so6504464qvb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 05:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=orSSRgFfv3qUT+UsrD9xGOSEY9WAuTcx2l/m7DY5Xdw=;
        b=l/cxrgP2IVT7Caq2zOsMAdgvPMX4zG3PzxhseptaK7bEgY6KmtevFSVpgucyETbli9
         dhhrAh06FE4PgeEyk2UD31y+q1jauzbQieFX0AOP1tczLLVErcq4HfRDJ4ViInF0/sG0
         rVxx6hS8ydhC1YPP5MagS+UzugXlm+D4BCcONIWGd4HqavpCFJQe1QyH6EoCNUQan7cB
         MCT968nr/y5K/6jFEq+bVR4Ngjr5mEc/HYKrD9MYJM8SftVxRKQLwZKpXCRv5hg1pw7D
         +5g+R+u/0DmdW8VS7+bAjBCrI5j9uJoknjDXmTKWeKirn1+soSrwpnm5v2H+rRcmS3/t
         mVcg==
X-Gm-Message-State: AOAM530zK0OGlk5PfCAES+j218ktTmRBTrlTeG5kKkj4QnDKAybwGhCz
        46SfogEv3Jy0rPJNSYqhqDayM0qisJ3PdkeUeqYVZZlEx+Nx0S6fG7ySO0m1Qofnc7G26DiuEvc
        89KpjbbbjVXuXncgL2JBLIMS+vA==
X-Received: by 2002:aed:3b33:: with SMTP id p48mr2950291qte.205.1592568295107;
        Fri, 19 Jun 2020 05:04:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx75r1dWTHaMyeSP1ld6gxk57RCqWkHZnNjQIqc+NyYiE+3KD94I/f13g1qhV9uGflJRhIWuw==
X-Received: by 2002:aed:3b33:: with SMTP id p48mr2950256qte.205.1592568294693;
        Fri, 19 Jun 2020 05:04:54 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id s15sm6751128qtc.95.2020.06.19.05.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 05:04:53 -0700 (PDT)
Message-ID: <a25ec32fd836fafeb2d4dd2f41e9255d02182a84.camel@redhat.com>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
From:   Jeff Layton <jlayton@redhat.com>
To:     Dave Chinner <david@fromorbit.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Date:   Fri, 19 Jun 2020 08:04:53 -0400
In-Reply-To: <20200619024455.GN2005@dread.disaster.area>
References: <20200617172456.GP11245@magnolia>
         <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
         <20200617181816.GA18315@fieldses.org>
         <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
         <20200617184507.GB18315@fieldses.org>
         <20200618013026.ewnhvf64nb62k2yx@gabell>
         <20200618030539.GH2005@dread.disaster.area>
         <20200618034535.h5ho7pd4eilpbj3f@gabell>
         <20200618223948.GI2005@dread.disaster.area>
         <20200619022005.GA25414@fieldses.org>
         <20200619024455.GN2005@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-06-19 at 12:44 +1000, Dave Chinner wrote:
> On Thu, Jun 18, 2020 at 10:20:05PM -0400, J. Bruce Fields wrote:
> > On Fri, Jun 19, 2020 at 08:39:48AM +1000, Dave Chinner wrote:
> > > On Wed, Jun 17, 2020 at 11:45:35PM -0400, Masayoshi Mizuma wrote:
> > > > Thank you for pointed it out.
> > > > How about following change? I believe it works both xfs and btrfs...
> > > > 
> > > > diff --git a/fs/super.c b/fs/super.c
> > > > index b0a511bef4a0..42fc6334d384 100644
> > > > --- a/fs/super.c
> > > > +++ b/fs/super.c
> > > > @@ -973,6 +973,9 @@ int reconfigure_super(struct fs_context *fc)
> > > >                 }
> > > >         }
> > > > 
> > > > +       if (sb->s_flags & SB_I_VERSION)
> > > > +               fc->sb_flags |= MS_I_VERSION;
> > > > +
> > > >         WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
> > > >                                  (fc->sb_flags & fc->sb_flags_mask)));
> > > >         /* Needs to be ordered wrt mnt_is_readonly() */
> > > 
> > > This will prevent SB_I_VERSION from being turned off at all. That
> > > will break existing filesystems that allow SB_I_VERSION to be turned
> > > off on remount, such as ext4.
> > > 
> > > The manipulations here need to be in the filesystem specific code;
> > > we screwed this one up so badly there is no "one size fits all"
> > > behaviour that we can implement in the generic code...
> > 
> > My memory was that after Jeff Layton's i_version patches, there wasn't
> > really a significant performance hit any more, so the ability to turn it
> > off is no longer useful.
> 
> Yes, I completely agree with you here. However, with some
> filesystems allowing it to be turned off, we can't just wave our
> hands and force enable the option. Those filesystems - if the
> maintainers chose to always enable iversion - will have to go
> through a mount option deprecation period before permanently
> enabling it.
>
> > But looking back through Jeff's postings, I don't see him claiming that;
> > e.g. in:
> > 
> > 	https://lore.kernel.org/lkml/20171222120556.7435-1-jlayton@kernel.org/
> > 	https://lore.kernel.org/linux-nfs/20180109141059.25929-1-jlayton@kernel.org/
> > 	https://lore.kernel.org/linux-nfs/1517228795.5965.24.camel@redhat.com/
> > 
> > he reports comparing old iversion behavior to new iversion behavior, but
> > not new iversion behavior to new noiversion behavior.
> 
> Yeah, it's had to compare noiversion behaviour on filesystems where
> it was understood that it couldn't actually be turned off. And,
> realistically, the comaprison to noiversion wasn't really relevant
> to the problem Jeff's patchset was addressing...
> 

I actually did do some comparison with that patchset vs. noiversion
mounted ext4, and found that there was a small performance delta. It
wasn't much but it was measurable enough that I didn't want to propose
removing the option from ext4 altogether at the time. It may be worth it
to do that now though.
-- 
Jeff Layton <jlayton@redhat.com>

