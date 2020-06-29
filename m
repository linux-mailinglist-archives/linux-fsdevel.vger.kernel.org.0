Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8220D6AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbgF2TWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 15:22:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:59522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbgF2TVf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F304B16E;
        Mon, 29 Jun 2020 13:09:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D87851E12E7; Mon, 29 Jun 2020 15:09:15 +0200 (CEST)
Date:   Mon, 29 Jun 2020 15:09:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Commit 'fs: Do not check if there is a fsnotify watcher on
 pseudo inodes' breaks chromium here
Message-ID: <20200629130915.GF26507@quack2.suse.cz>
References: <7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com>
 <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 28-06-20 15:53:51, Amir Goldstein wrote:
> On Sun, Jun 28, 2020 at 2:14 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> >
> > Hi,
> >
> > I just did usual kernel update and now chromium crashes on startup.
> > It happens both in a KVM's VM (with virtio-gpu if that matters) and natively with amdgpu driver.
> > Most likely not GPU related although I initially suspected that it is.
> >
> > Chromium starts as a white rectangle, shows few white rectangles
> > that resemble its notifications and then crashes.
> >
> > The stdout output from chromium:
> 
> I guess this answers our question whether we could disable fsnoitfy
> watches on pseudo inodes....

Right :-|

> From comments like these in chromium code:
> https://chromium.googlesource.com/chromium/src/+/master/mojo/core/watcher_dispatcher.cc#77
> https://chromium.googlesource.com/chromium/src/+/master/base/files/file_descriptor_watcher_posix.cc#176
> https://chromium.googlesource.com/chromium/src/+/master/ipc/ipc_channel_mojo.cc#240
> 
> I am taking a wild guess that the missing FS_CLOSE event on anonymous pipes is
> the cause for regression.

I was checking the Chromium code for some time. It uses inotify in
base/files/file_path_watcher_linux.cc and watches IN_CLOSE_WRITE event
(among other ones) but I was unable to track down how the class gets
connected to the mojo class that crashes. I'd be somewhat curious how they
place inotify watches on pipe inodes - probably they have to utilize proc
magic links but I'd like to be sure. Anyway your guess appears to be
correct :)

> The motivation for the patch "fs: Do not check if there is a fsnotify
> watcher on pseudo inodes"
> was performance, but actually, FS_CLOSE and FS_OPEN events probably do
> not impact performance as FS_MODIFY and FS_ACCESS.

Correct.

> Do you agree that dropping FS_MODIFY/FS_ACCESS events for FMODE_STREAM
> files as a general rule should be safe?

Hum, so your patch drops FS_MODIFY/FS_ACCESS events also for named pipes
compared to the original patch AFAIU and for those fsnotify works fine
so far. So I'm not sure we won't regress someone else with this.

I've also tested inotify on a sample pipe like: cat /dev/stdin | tee
and watched /proc/<tee pid>/fd/0 and it actually generated IN_MODIFY |
IN_ACCESS when data arrived to a pipe and tee(1) read it and then
IN_CLOSE_WRITE | IN_CLOSE_NOWRITE when the pipe got closed (I thought you
mentioned modify and access events didn't get properly generated?).

So as much as I agree that some fsnotify events on FMODE_STREAM files are
dubious, they could get used (possibly accidentally) and so after this
Chromium experience I think we just have to revert the change and live with
generating notification events for pipes to avoid userspace regressions.

Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
