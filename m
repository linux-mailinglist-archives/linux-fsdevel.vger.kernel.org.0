Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7304D45012E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhKOJ03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 04:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhKOJZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:25:35 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C4C06121D
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 01:21:15 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id i6so33389541uae.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 01:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZRzmfr33ksKeGczCmevzip8qq4bvVpQ08XPdQssnGM=;
        b=Y84O2jZqcupp8FDVBul7yU6K8vTd5w3H9tzfxrA7LsguHQZteSZok4EkX2CPJY7dZn
         3w8nxo4AjZrg+As2RYcufNPbIGt69kE8Vljtp8OCBe5Ejr0+zQ5J+aQDF3h9zQEnl9mC
         ASWxFDzY2HScF4fbXg1VHe2h/605lZgd2tF1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZRzmfr33ksKeGczCmevzip8qq4bvVpQ08XPdQssnGM=;
        b=Cjx1BfyQ2reTc2+fB6I5VZBSbQ6ZpK4xyd7+LyBs1uqbGXqjpWHOH69n0bI+h7Yiab
         kq4vm8pz7sSeBF//RtLeVLh1Smm6mevqlKEaWCtHr/aHmPgiFgocE85dO/i83gz8S6Cn
         rhbDI4oMCHWv/MZLjbsMzT7R2Y0s9biY7BFGKS1pxFGkNPJg9Zq74p01kvyps6DTPlc0
         uaM7fTbOblg/FxsuP4dN5ZpAtWQ1EGA01F+l0ndlQEZngbE/3ZlahY9werZ1kqsGlprT
         JWXoRpdGsKUalJBJLmnXBX3YwMX5EyDcu0SoVu5EF96hsyBvxDWvKcq36CvJrkzQ+/Zu
         aH1Q==
X-Gm-Message-State: AOAM530RDHcLSCdJEpvPuymJ+3lPcw10nasm/Uvlqhzm+ZNLK7yZB5PB
        L1ZBtySgL6bJGICdX4dSUVzhm7jhqegHuiZDDZe+tw==
X-Google-Smtp-Source: ABdhPJz6Az5+mHWva6UQPGv4CesuEhoWD83B1tbTD9++PDTzvwyfRwLJrKTpW6bVxPpoAioKST8WlGxph+8gyAztdMA=
X-Received: by 2002:a67:ec94:: with SMTP id h20mr39959755vsp.59.1636968074344;
 Mon, 15 Nov 2021 01:21:14 -0800 (PST)
MIME-Version: 1.0
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <20211112003249.GL449541@dread.disaster.area> <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area>
In-Reply-To: <20211114231834.GM449541@dread.disaster.area>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Nov 2021 10:21:03 +0100
Message-ID: <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ian Kent <raven@themaw.net>, xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 15 Nov 2021 at 00:18, Dave Chinner <david@fromorbit.com> wrote:
> I just can't see how this race condition is XFS specific and why
> fixing it requires XFS to sepcifically handle it while we ignore
> similar theoretical issues in other filesystems...

It is XFS specific, because all other filesystems RCU free the in-core
inode after eviction.

XFS is the only one that reuses the in-core inode object and that is
very much different from anything the other filesystems do and what
the VFS expects.

I don't see how clearing the quick link buffer in ext4_evict_inode()
could do anything bad.  The contents are irrelevant, the lookup will
be restarted anyway, the important thing is that the buffer is not
freed and that it's null terminated, and both hold for the ext4,
AFAICS.

I tend to agree with Brian and Ian at this point: return -ECHILD from
xfs_vn_get_link_inline() until xfs's inode resue vs. rcu walk
implications are fully dealt with.  No way to fix this from VFS alone.

Thanks,
Miklos
