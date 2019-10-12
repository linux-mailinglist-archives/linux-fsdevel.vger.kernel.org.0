Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3470FD5285
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 22:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfJLUvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Oct 2019 16:51:40 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60883 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728579AbfJLUvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Oct 2019 16:51:40 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D0669362E26;
        Sun, 13 Oct 2019 07:51:36 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iJOMR-0007JM-WE; Sun, 13 Oct 2019 07:51:36 +1100
Date:   Sun, 13 Oct 2019 07:51:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [Project Quota]file owner could change its project ID?
Message-ID: <20191012205135.GS16973@dread.disaster.area>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=XQ-RyMWtx_6voXMgLtIA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 12, 2019 at 02:33:36PM +0800, Wang Shilong wrote:
> Steps to reproduce:
> [wangsl@localhost tmp]$ mkdir project
> [wangsl@localhost tmp]$ lsattr -p project -d
>     0 ------------------ project
> [wangsl@localhost tmp]$ chattr -p 1 project
> [wangsl@localhost tmp]$ lsattr -p -d project
>     1 ------------------ project
> [wangsl@localhost tmp]$ chattr -p 2 project
> [wangsl@localhost tmp]$ lsattr -p -d project
>     2 ------------------ project
> [wangsl@localhost tmp]$ df -Th .
> Filesystem     Type  Size  Used Avail Use% Mounted on
> /dev/sda3      xfs    36G  4.1G   32G  12% /
> [wangsl@localhost tmp]$ uname -r
> 5.4.0-rc2+
> 
> As above you could see file owner could change project ID of file its self.

Perfectly legal to do this. Working as designed, and intended.
Project quotas have allowed this since they were introduced in the
late 1980s on Irix...

> As my understanding, we could set project ID and inherit attribute to account
> Directory usage, and implement a similar 'Directory Quota' based on this.

Yes, that is a -use- of project quotas, but not the -only- use.
Users have always been allowed to select what project their files
belong to - it's a method of accounting space even when users cannot
access all of the project information.

> But Directories could easily break this limit by change its file to
> other project ID.

Yes. But then users are using the project quotas as traditional
project quotas, which is just fine. There are users out there that
use this mix of behaviours - users have a default directory quota to
limit unbound space usage of home directories, but for files that
belong to a specific project they simply change the project ID and
now the space in their home directory those project files take up is
accounted to the project rather than the user.

> And we used vfs_ioc_fssetxattr_check() to only allow init userspace to
> change project quota:

Right, that's so directory quotas can be enforced for container
use cases, preventing the users inside a container from modifying
the project quota and escaping the space usage limit set for the
container. This means project quotas are unavailable for use
inside user namespaces as they are used for container resource usage
limiting.

> Shall we have something like following to limit admin change for
> Project state too?

As per above, that will break many existing use cases for project
quotas, so I don't think we will be doing that.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
