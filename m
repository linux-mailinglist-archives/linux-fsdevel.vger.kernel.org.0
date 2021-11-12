Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB444EB86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 17:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhKLQms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 11:42:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhKLQmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:42:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 061F021993;
        Fri, 12 Nov 2021 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636735196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fxrhWhPawS2yJnmoJ2Pux/F/vJA8x038Rc3ibWHDJl0=;
        b=oSDb5b4SNoRhR4osVSHBsVCBpRqQy2AOa40kSB+6x4Ny/Ee6N/ChHlCK50WuiOxzypsleR
        s69SQ5fYx/x/9LTPTUqqMpsdK7sUSrDaVns3TH38hdS7iGL7swtJJNgSCb49YgAWijHVNq
        unDb/CAShKkTba563ERtYAYF4zPv3J0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636735196;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fxrhWhPawS2yJnmoJ2Pux/F/vJA8x038Rc3ibWHDJl0=;
        b=Wp1C0P6ZU6ckPnR5Q/kwY64a/fbFt3L3E4gkQNY/rGPWkbOqJyDDzD57A2K9OoHm0YSjIC
        xS6GFgprCPiqlYBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E8792A3B8D;
        Fri, 12 Nov 2021 16:39:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C11D61F2B50; Fri, 12 Nov 2021 17:39:55 +0100 (CET)
Date:   Fri, 12 Nov 2021 17:39:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
Message-ID: <20211112163955.GA30295@quack2.suse.cz>
References: <20211029114028.569755-1-amir73il@gmail.com>
 <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Sat 06-11-21 18:29:39, Amir Goldstein wrote:
> On Fri, Oct 29, 2021 at 2:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > This patch set follows up on the discussion on FAN_REPORT_TARGET_FID [1]
> > from 3 months ago.
> >
> > With FAN_REPORT_PIDFD in 5.15 and FAN_FS_ERROR on its way to 5.16,
> > I figured we could get an early (re)start of the discussion on
> > FAN_REPORT_TARGET_FID towards 5.17.
> >
> > The added information in dirent events solves problems for my use case -
> > It helps getting the following information in a race free manner:
> > 1. fid of a created directory on mkdir
> > 2. from/to path information on rename of non-dir
> >
> > I realize those are two different API traits, but they are close enough
> > so I preferred not to clutter the REPORT flags space any further than it
> > already is. The single added flag FAN_REPORT_TARGET_FID adds:
> > 1. child fid info to CREATE/DELETE/MOVED_* events
> > 2. new parent+name info to MOVED_FROM event
> >
> > Instead of going the "inotify way" and trying to join the MOVED_FROM/
> > MOVED_TO events using a cookie, I chose to incorporate the new
> > parent+name intomation only in the MOVED_FROM event.
> > I made this choice for several reasons:
> > 1. Availability of the moved dentry in the hook and event data
> > 2. First info record is the old parent+name, like FAN_REPORT_DFID_NAME
> > 3. Unlike, MOVED_TO, MOVED_FROM was useless for applications that use
> >    DFID_NAME info to statat(2) the object as we suggested
> >
> > I chose to reduce testing complexity and require all other FID
> > flags with FAN_REPORT_TARGET_FID and there is a convenience
> > macro FAN_REPORT_ALL_FIDS that application can use.
> 
> Self comment - Don't use ALL_ for macro names in uapi...
> There are 3 comment of "Deprecated ..."  for ALL flags in fanotify.h alone...

Yeah, probably the ALL_FIDS is not worth the possible confusion when we add
another FID flag later ;)

> BTW, I did not mention the FAN_RENAME event alternative proposal in this posting
> not because I object to FAN_RENAME, just because it was simpler to implement
> the MOVED_FROM alternative, so I thought I'll start with this proposal
> and see how
> it goes.

I've read through all the patches and I didn't find anything wrong.
Thinking about FAN_RENAME proposal - essentially fsnotify_move() would call
fsnotify_name() once more with FS_RENAME event and we'd gate addition of
second dir+name info just by FS_RENAME instead of FS_MOVED_FROM &&
FAN_REPORT_TARGET_FID. Otherwise everything would be the same as in the
current patch set, wouldn't it? IMHO it looks like a bit cleaner API so I'd
lean a bit more towards that.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
