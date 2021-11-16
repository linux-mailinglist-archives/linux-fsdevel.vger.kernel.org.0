Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A8452EC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 11:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbhKPKQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 05:16:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51298 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhKPKPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:15:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21E8A1FD33;
        Tue, 16 Nov 2021 10:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637057556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W+d6t3Y+oTzR5SDlNVMU2oyPWVUgsDG5YlzUlY8wTKU=;
        b=WBXt1uQwBOc27PdmrjJOcX1jbtQhVmCeeq/J1wuruaj3oN1lkirzTjkbI2BTI3D4haUocS
        8anv0OCiVb1szz43Mmr92xRrckJXS4kf6QleEmfbUetFYnsVS1xG8llgyXxJcumYd31BwT
        Zy4Ctnmk8pcexwQYlXq4uEtwhVMPrY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637057556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W+d6t3Y+oTzR5SDlNVMU2oyPWVUgsDG5YlzUlY8wTKU=;
        b=yQ6A4iOailt8wSIh5kXRdwkrHfZMMKp46NY5x+NQjo1NOovbsQO58ky+S50pZixk2WbJAE
        GarQP7nslzY3j0BQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id F2753A3B88;
        Tue, 16 Nov 2021 10:12:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 862F61E0E33; Tue, 16 Nov 2021 11:12:32 +0100 (CET)
Date:   Tue, 16 Nov 2021 11:12:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
Message-ID: <20211116101232.GA23464@quack2.suse.cz>
References: <20211029114028.569755-1-amir73il@gmail.com>
 <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz>
 <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
 <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
 <20211115102330.GC23412@quack2.suse.cz>
 <CAOQ4uxiBFkkbKU=yimLXoYKHFWOoUYrXfg4Kw_CkF=hcSGOm3A@mail.gmail.com>
 <20211115143750.GE23412@quack2.suse.cz>
 <CAOQ4uxgBncZjuTo-K+vxRovd36AuaEKUfBDQwgU86B9qwWWNVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgBncZjuTo-K+vxRovd36AuaEKUfBDQwgU86B9qwWWNVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-11-21 08:59:29, Amir Goldstein wrote:
> > > I like it. However,
> > > If FAN_RENAME can have any combination of old,new,old+new info
> > > we cannot get any with a single new into type
> > > FAN_EVENT_INFO_TYPE_DFID_NAME2
> > >
> > > (as in this posting)
> >
> > We could define only DFID2 and DFID_NAME2 but I agree it would be somewhat
> > weird to have DFID_NAME2 in an event and not DFID_NAME.
> >
> > > We can go with:
> > > #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME   6
> > > #define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME  7
> > > #define FAN_EVENT_INFO_TYPE_OLD_DFID               8
> > > #define FAN_EVENT_INFO_TYPE_NEW_DFID              9
> > >
> > > Or we can go with:
> > > /* Sub-types common to all three fid info types */
> > > #define FAN_EVENT_INFO_FID_OF_OLD_DIR     1
> > > #define FAN_EVENT_INFO_FID_OF_NEW_DIR    2
> > >
> > > struct fanotify_event_info_header {
> > >        __u8 info_type;
> > >        __u8 sub_type;
> > >        __u16 len;
> > > };
> > >
> > > (as in my wip branch fanotify_fid_of)
> >
> > When we went the way of having different types for FID and DFID, I'd
> > continue with OLD_DFID_NAME, NEW_DFID_NAME, ... and keep the padding byte
> > free for now (just in case there's some extension which would urgently need
> > it).
> >
> > > We could also have FAN_RENAME require FAN_REPORT_NAME
> > > that would limit the number of info types, but I cannot find a good
> > > justification for this requirement.
> >
> > Yeah, I would not force that.
> >
> 
> On second thought and after trying to write a mental man page
> and realizing how ugly it gets, I feel strongly in favor of requiring
> FAN_REPORT_NAME for the FAN_RENAME event.
> 
> My arguments are:
> 1. What is the benefit of FAN_RENAME without names?
>     Is the knowledge that *something* was moved from dir A to dir B
>     that important that it qualifies for the extra man page noise and
>     application developer headache?
> 2. My declared motivation for this patch set was to close the last (?)
>     functional gap between inotify and fanotify, that is, being able to
>     reliably join MOVED_FROM and MOVED_TO events.
>     Requiring FAN_REPORT_NAME still meets that goal.
> 3. In this patch set, FAN_REPORT_NAME is required (for now) for
>     FAN_REPORT_TARGET_FID to reduce implementation and test
>     matrix complexity (you did not object, so I wasn't planning on
>     changing this requirement).
>     The same argument holds for FAN_RENAME
> 
> So let's say this - we can add support for OLD_DFID, NEW_DFID types
> later if we think they may serve a purpose, but at this time, I see no
> reason to complicate the UAPI anymore than it already is and I would
> rather implement only:
> 
> /* Info types for FAN_RENAME */
> #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME       10
> /* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID    11 */
> #define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME       12
> /* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID    13 */
> 
> Do you agree?

I agree the utility of FAN_RENAME without FAN_REPORT_NAME is very limited
so I'm OK with not implementing that at least for now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
