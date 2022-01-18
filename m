Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2143249237B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiARKHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 05:07:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37312 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiARKHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:07:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D0FE61F3B5;
        Tue, 18 Jan 2022 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642500420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQqGJftk415vJx/XXTpm/bwFdjgtJIFUFlqqNaeMaQQ=;
        b=d5q9AqqvxP1yj/ixUIKV3aP6bwXzuCynt0ZAKvReBSqkVNgxz0poowbnr4S6Ivi4mUsbiu
        XhYK+cYIpGmnAV/YjqB8mi7CUcyzt3BhJaJVKcWAC5sqcIqAKQXJdGZInrgeHL+avGMy8i
        6XzV3MFxAlbzS8FXGm/IEbNWHS1PJvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642500420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQqGJftk415vJx/XXTpm/bwFdjgtJIFUFlqqNaeMaQQ=;
        b=EzKuS5y0MbnJ4DoB08Y93vuUY4mevmuDppFydabZ8bS/opnr0zcz2OqmhxD00TulwGIEa3
        H1YkE230sgnTjAAw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C487AA3B81;
        Tue, 18 Jan 2022 10:07:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7DD75A05E2; Tue, 18 Jan 2022 11:06:59 +0100 (CET)
Date:   Tue, 18 Jan 2022 11:06:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ivan Delalande <colona@arista.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Potential regression after fsnotify_nameremove() rework in 5.3
Message-ID: <20220118100659.ajl4ngwhpfrh74bs@quack3.lan>
References: <YeI7duagtzCtKMbM@visor>
 <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
 <YeNyzoDM5hP5LtGW@visor>
 <CAOQ4uxhaSh4cUMENkaDJij4t2M9zMU9nCT4S8j+z+p-7h6aDnQ@mail.gmail.com>
 <YeTVx//KrRKiT67U@visor>
 <CAOQ4uxibWbjFJ2-0qoARuyd2WD9PEd9HZ82knB0bcy8L92TOag@mail.gmail.com>
 <20220117142107.vpfmesnocsndbpar@quack3.lan>
 <CAOQ4uxj2mSOLyo612GAD_XnZOdCZ9R_BC-g=Qk_iaU65_yh72Q@mail.gmail.com>
 <CAOQ4uxh5h5tQXtirxfUuZT1NJXrHuqm=e7uXD5sCDWjf5n+DEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh5h5tQXtirxfUuZT1NJXrHuqm=e7uXD5sCDWjf5n+DEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-01-22 00:02:38, Amir Goldstein wrote:
> > > One possibility I can see is: Add fsnotify primitive to create the event,
> > > just not queue it in the notification queue yet (essentially we would
> > > cut-short the event handling before calling fsnotify_insert_event() /
> > > fsnotify_add_event()), only return it. Then another primitive would be for
> > > queueing already prepared event. Then the sequence for unlink would be:
> > >
> > >         LIST_HEAD(event_list);
> > >
> > >         fsnotify_events_prepare(&event_list, ...);
> > >         d_delete(dentry);
> > >         fsnotify_events_report(&event_list);
> > >
> > > And we can optionally wrap this inside d_delete_notify() to make it easier
> > > on the callers. What do you think?
> > >
> >
> > I think it sounds like the "correct" design, but also sounds like a
> > big change that
> > is not so practical for backporting.
> >
> > Given that this is a regression that goes way back, backportability
> > plays a role.
> > Also, a big change like this needs developer time, which I myself don't have
> > at the moment.

Agreed. I'm for simplicity as well.

> > For a simpler backportable solution, instead of preparing the event
> > perhaps it is enough that we ihold() the inode until after fsnotify_unlink()
> > and pass it as an argument very similar to fsnotify_link().
> >
> > The question is how to ihold() the inode only if we are going to queue
> > an IN_DELETE event? Maybe send an internal FS_PRE_DELETE
> > event?
> >
> 
> Actually, seeing that do_unlinkat() already iholds the inode outside
> vfs_unlink()
> anyway, is it so bad that vfs_unlink() will elevate refcount as well, so we can
> call fsnotify_unlink() with the inode arg after d_delete()?

No, that's what I wanted to suggest :) ihold() should be pretty cheap as,
as you have noticed, the cacheline should be dirty and hot anyway. I think
this is by far cheaper than trying to find out whether the event will be
sent or not.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
