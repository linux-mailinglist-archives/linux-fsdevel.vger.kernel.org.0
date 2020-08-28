Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE522556CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgH1IqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 04:46:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:55504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbgH1IqG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:46:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F35E3AC37;
        Fri, 28 Aug 2020 08:46:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EAC9E1E12C0; Fri, 28 Aug 2020 10:46:03 +0200 (CEST)
Date:   Fri, 28 Aug 2020 10:46:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Tycho Kirchner <tychokirchner@mail.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify feature request FAN_MARK_PID
Message-ID: <20200828084603.GA7072@quack2.suse.cz>
References: <dde082eb-b3eb-859e-b442-a65846cff6fa@mail.de>
 <CAOQ4uxjEm=vj5Be5VoUyB9Q+YVq=+aO_4PfXp-iEYZA7qzO1Gw@mail.gmail.com>
 <9def9581-cc09-7a79-ea27-e9b8b75bbd6a@mail.de>
 <CAOQ4uxiTCKrVBCjYrBsNWjRad+Tt_cONfD-nQCBr8x=TyLb_ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiTCKrVBCjYrBsNWjRad+Tt_cONfD-nQCBr8x=TyLb_ww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 23-08-20 16:04:39, Amir Goldstein wrote:
> > Any further help is appreciated.
> >
> 
> A patch along those line (fill in the missing pieces) looks useful to me.
> It could serve a use case where applications are using fanotify filesystem
> mark, but developer would like to limit those application's scope inside
> "system containers".
> 
> Perhaps an even more useful API would be FAN_FILTER_MOUNT_NS.
> FAN_FILTER_PID_NS effectively means that kernel will drop events
> that are expected to report pid 0.
> FAN_FILTER_MOUNT_NS would mean that kernel will drop events that
> are expected to report an fd, whose /proc/<pid>/fd/<fd> symlink cannot
> be resolved (it shows "/") because the file's mount is outside the scope
> of the listener's mount namespace.
> 
> The burden of proof that this will be useful is still on you ;-)

I was thinking that we could add a BPF hook to fanotify_handle_event()
(similar to what's happening in packet filtering code) and you could attach
BPF programs to this hook to do filtering of events. That way we don't have
to introduce new group flags for various filtering options. The question is
whether eBPF is strong enough so that filters useful for fanotify users
could be implemented with it but this particular check seems implementable.

								Honza

> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -685,6 +685,11 @@ static int fanotify_handle_event(struct
> fsnotify_group *group, u32 mask,
> 
>         pr_debug("%s: group=%p mask=%x\n", __func__, group, mask);
> 
> +       /* Interested only in events from group's pid ns */
> +       if (FAN_GROUP_FLAG(group, FAN_FILTER_PID_NS) &&
> +           !pid_nr_ns(task_pid(current), group->fanotify_data.pid_ns))
> +               return 0;
> +
>         if (fanotify_is_perm_event(mask)) {
>                 /*
>                  * fsnotify_prepare_user_wait() fails if we race with mark
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
