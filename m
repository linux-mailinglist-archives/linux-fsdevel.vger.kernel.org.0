Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D76528D421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgJMS6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 14:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727733AbgJMS6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602615509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MoWLFPFyS2LTNII5kpPcykIkGrZwVw5sezDcYprZfc8=;
        b=A9C4AayxKS9lMZFt1yKpm/nkQ0Mv24oseaxZjRV9YpDtK4tt+DxN07mFdcLBpJpHsEG6Z+
        dM38Oe1Xg72Y2vb6nMC6OqPCbTy4tvE7NOC/laPj/YZtsJD1w/YAN2+gWSfoj5SHhnKQym
        blyRh0QWdQ4kX2pU2BpJlP76wFZ2a/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-1S6_noQ3OiyRoa48Yd2L5w-1; Tue, 13 Oct 2020 14:58:25 -0400
X-MC-Unique: 1S6_noQ3OiyRoa48Yd2L5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B0AB1084C84;
        Tue, 13 Oct 2020 18:58:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-207.rdu2.redhat.com [10.10.115.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AEA85C22B;
        Tue, 13 Oct 2020 18:58:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E7C65223D0F; Tue, 13 Oct 2020 14:58:08 -0400 (EDT)
Date:   Tue, 13 Oct 2020 14:58:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Qian Cai <cai@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: Unbreakable loop in fuse_fill_write_pages()
Message-ID: <20201013185808.GA164772@redhat.com>
References: <7d350903c2aa8f318f8441eaffafe10b7796d17b.camel@redhat.com>
 <20201013184026.GC142988@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013184026.GC142988@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:40:26PM -0400, Vivek Goyal wrote:
> On Tue, Oct 13, 2020 at 01:11:05PM -0400, Qian Cai wrote:
> > Running some fuzzing on virtiofs with an unprivileged user on today's linux-next 
> > could trigger soft-lockups below.
> > 
> > # virtiofsd --socket-path=/tmp/vhostqemu -o source=$TESTDIR -o cache=always -o no_posix_lock
> > 
> > Basically, everything was blocking on inode_lock(inode) because one thread
> > (trinity-c33) was holding it but stuck in the loop in fuse_fill_write_pages()
> > and unable to exit for more than 10 minutes before I executed sysrq-t.
> > Afterwards, the systems was totally unresponsive:
> > 
> > kernel:NMI watchdog: Watchdog detected hard LOCKUP on cpu 8
> > 
> > To exit the loop, it needs,
> > 
> > iov_iter_advance(ii, tmp) to set "tmp" to non-zero for each iteration.
> > 
> > and
> > 
> > 	} while (iov_iter_count(ii) && count < fc->max_write &&
> > 		 ap->num_pages < max_pages && offset == 0);
> > 
> > == the thread is stuck in the loop ==
> > [10813.290694] task:trinity-c33     state:D stack:25888 pid:254219 ppid: 87180
> > flags:0x00004004
> > [10813.292671] Call Trace:
> > [10813.293379]  __schedule+0x71d/0x1b50
> > [10813.294182]  ? __sched_text_start+0x8/0x8
> > [10813.295146]  ? mark_held_locks+0xb0/0x110
> > [10813.296117]  schedule+0xbf/0x270
> > [10813.296782]  ? __lock_page_killable+0x276/0x830
> > [10813.297867]  io_schedule+0x17/0x60
> > [10813.298772]  __lock_page_killable+0x33b/0x830
> 
> This seems to suggest that filemap_fault() is blocked on page lock and
> is sleeping. For some reason it never wakes up. Not sure why.
> 
> And this will be called from.
> 
> fuse_fill_write_pages()
>    iov_iter_fault_in_readable()
> 
> So fuse code will take inode_lock() and then looks like same process
> is sleeping waiting on page lock. And rest of the processes get blocked
> behind inode lock.
> 
> If we are woken up (while waiting on page lock), we should make forward
> progress. Question is what page it is and why the entity which is
> holding lock is not releasing lock.

I am wondering if virtiofsd still alive and responding to requests? I
see another task which is blocked on getdents() for more than 120s.

[10580.142571][  T348] INFO: task trinity-c36:254165 blocked for more than 123
+seconds.
[10580.143924][  T348]       Tainted: G           O	 5.9.0-next-20201013+ #2
[10580.145158][  T348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
+disables this message.
[10580.146636][  T348] task:trinity-c36     state:D stack:26704 pid:254165 ppid:
+87180 flags:0x00000004
[10580.148260][  T348] Call Trace:
[10580.148789][  T348]  __schedule+0x71d/0x1b50
[10580.149532][  T348]  ? __sched_text_start+0x8/0x8
[10580.150343][  T348]  schedule+0xbf/0x270
[10580.151044][  T348]  schedule_preempt_disabled+0xc/0x20
[10580.152006][  T348]  __mutex_lock+0x9f1/0x1360
[10580.152777][  T348]  ? __fdget_pos+0x9c/0xb0
[10580.153484][  T348]  ? mutex_lock_io_nested+0x1240/0x1240
[10580.154432][  T348]  ? find_held_lock+0x33/0x1c0
[10580.155220][  T348]  ? __fdget_pos+0x9c/0xb0
[10580.155934][  T348]  __fdget_pos+0x9c/0xb0
[10580.156660][  T348]  __x64_sys_getdents+0xff/0x230

May be virtiofsd crashed and hence no requests are completing leading
to a hard lockup?

Vivek

