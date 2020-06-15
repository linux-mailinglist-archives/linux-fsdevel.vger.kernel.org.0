Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2490F1F9E52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgFORZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 13:25:53 -0400
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:48473 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729682AbgFORZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:25:53 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id C8B53FAB2A
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 18:25:50 +0100 (IST)
Received: (qmail 13298 invoked from network); 15 Jun 2020 17:25:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jun 2020 17:25:47 -0000
Date:   Mon, 15 Jun 2020 18:25:45 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
Message-ID: <20200615172545.GG3183@techsingularity.net>
References: <20200615121358.GF3183@techsingularity.net>
 <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi0fqKFZ9=U-+DQ78233hR9TXEU44xRih4q=M556ynphA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 07:26:38PM +0300, Amir Goldstein wrote:
> On Mon, Jun 15, 2020 at 3:14 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Changelog since v1
> > o Updated changelog
> 
> Slipped to commit message
> 

It's habit, it's the layout I generally use for mm even though others
prefer having it below ---. I wasn't sure of fsnotify's preferred format
for tracking major differences between versions.

> >
> > The kernel uses internal mounts created by kern_mount() and populated
> > with files with no lookup path by alloc_file_pseudo for a variety of
> > reasons. An example of such a mount is for anonymous pipes. For pipes,
> > every vfs_write regardless of filesystem, fsnotify_modify() is called to
> > notify of any changes which incurs a small amount of overhead in fsnotify
> > even when there are no watchers. It can also trigger for reads and readv
> > and writev, it was simply vfs_write() that was noticed first.
> >
> > A patch is pending that reduces, but does not eliminte, the overhead of
> 
> typo: eliminte
> 

Yes.

> > fsnotify but for files that cannot be looked up via a path, even that
> > small overhead is unnecessary. The user API for fanotify is based on
> > the pathname and a dirfd and proc entries appear to be the only visible
> > representation of the files. Proc does not have the same pathname as the
> > internal entry and the proc inode is not the same as the internal inode
> > so even if fanotify is used on a file under /proc/XX/fd, no useful events
> > are notified.
> >
> 
> Note that fanotify is not the only uapi to add marks, but this is fine by me
> I suppose if Jan wants to he can make small corrections on commit.
> 

True but I didn't think inotify was materially different as it also takes
a path. Is that wrong or are there others that matter and can attach to
a file that cannot be looked up via a path?

> > The difference is small but in some cases it's outside the noise so
> > while marginal, there is still some small benefit to ignoring fsnotify
> > for files allocated via alloc_file_pseudo in some cases.
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 

Thanks!

-- 
Mel Gorman
SUSE Labs
