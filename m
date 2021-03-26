Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF77934AF27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 20:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhCZTQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhCZTP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:15:56 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7190C0613AA;
        Fri, 26 Mar 2021 12:15:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1EEF229EB; Fri, 26 Mar 2021 15:15:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1EEF229EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1616786154;
        bh=6BHDn513XHsmgj36szMHNORK4Y9BRjndGUytTtfEmRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z3EuSgkHnh2Wq4aFs3kivdF0qaOGz5LYseH0nFH9hMml4IYnp027IjnBF5mNI0G+o
         zDHJSILes7nlCbFotBKgMDxkC19nyNtRcAyy2gjNeyUwj1dGraVFV7JNB9v2PqKpoY
         6Jgkvqocv98bO25STMTcfQ2zTtsp1NvpYJ5iXiSw=
Date:   Fri, 26 Mar 2021 15:15:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] xfs: use a unique and persistent value for f_fsid
Message-ID: <20210326191554.GB13139@fieldses.org>
References: <20210322171118.446536-1-amir73il@gmail.com>
 <20210322230352.GW63242@dread.disaster.area>
 <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjFMPNgR-aCqZt3FD90XtBVFZncdgNc4RdOCbsxukkyYQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 06:50:44AM +0200, Amir Goldstein wrote:
> On Tue, Mar 23, 2021 at 1:03 AM Dave Chinner <david@fromorbit.com> wrote:
> > should be using something common across all filesystems from the
> > linux superblock, not deep dark internal filesystem magic. The
> > export interfaces that generate VFS (and NFS) filehandles already
> > have a persistent fsid associated with them, which may in fact be
> > the filesystem UUID in it's entirety.
> >
> 
> Yes, nfsd is using dark internal and AFAIK undocumnetd magic to
> pick that identifier (Bruce, am I wrong?).

Sorry, I kept putting off catching up with this thread and only now
noticed the question.

It's actually done mostly in userspace (rpc.mountd), so "dark internal"
might not be fair, but it is rather complicated.  There are several
options (UUID, device number, number provided by the user with fsid=
option), and I don't recall the logic behind which we use when.

I don't *think* we have good comprehensive documentation of it anywhere.
I wish we did.  It'd take a little time to put together.  Starting
points would be linux/fs/nfsd/nfsfh.c and
nfs-utils/support/export/cache.c.

--b.
