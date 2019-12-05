Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADE0114114
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 13:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfLEM6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 07:58:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:39370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729048AbfLEM6f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:58:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66F10AB87;
        Thu,  5 Dec 2019 12:58:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B24BCDA733; Thu,  5 Dec 2019 13:58:26 +0100 (CET)
Date:   Thu, 5 Dec 2019 13:58:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pipe: Notification queue preparation
Message-ID: <20191205125826.GK2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Howells <dhowells@redhat.com>,
        torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <31452.1574721589@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31452.1574721589@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 10:39:49PM +0000, David Howells wrote:
> David Howells (12):
>       pipe: Reduce #inclusion of pipe_fs_i.h
>       Remove the nr_exclusive argument from __wake_up_sync_key()
>       Add wake_up_interruptible_sync_poll_locked()
>       pipe: Use head and tail pointers for the ring, not cursor and length

This commit (8cefc107ca54c8b06438b7dc9) causes hangs of 'btrfs send'
commands, that's eg. inside fstests or in btrfs-progs testsuite. The
'send' uses pipe/splice to get data from kernel to userspace.

The test that reliably worked for me leaves the process hanging with
this stacktrace (no CPU or IO activity):

[<0>] pipe_write+0x1be/0x4b0
[<0>] new_sync_write+0x11e/0x1c0
[<0>] vfs_write+0xc1/0x1d0
[<0>] kernel_write+0x2c/0x40
[<0>] send_cmd+0x78/0xf0 [btrfs]
[<0>] send_extent_data+0x4b1/0x52c [btrfs]
[<0>] process_extent+0xe46/0xe9d [btrfs]
[<0>] changed_cb+0xcf5/0xd2f [btrfs]
[<0>] send_subvol+0x8ad/0xc0b [btrfs]
[<0>] btrfs_ioctl_send+0xe50/0xf30 [btrfs]
[<0>] _btrfs_ioctl_send+0x80/0x110 [btrfs]
[<0>] btrfs_ioctl+0x18e1/0x3450 [btrfs]
[<0>] do_vfs_ioctl+0xa5/0x710
[<0>] ksys_ioctl+0x70/0x80
[<0>] __x64_sys_ioctl+0x16/0x20
[<0>] do_syscall_64+0x56/0x220
[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe

I've bisected that to the mentioned commit, using test in btrfs-progs
testsuite with command "make TEST=016\* test-misc". Normally the test
can run up to 10 seconds, in the buggy case it stays there.

I can help testing fixes or gathering more information, please let me
know.

Full bisect log:

# bad: [3c0edea9b29f9be6c093f236f762202b30ac9431] pipe: Remove sync on wake_ups
# good: [da0c9ea146cbe92b832f1b0f694840ea8eb33cce] Linux 5.4-rc2
git bisect start '3c0edea9b29f9be6c093f236f762202b30ac9431' 'd055b4fb4d165b06d912e7f846610d120c3bb9fb^'
# bad: [b667b867344301e24f21d4a4c844675ff61d89e1] pipe: Advance tail pointer inside of wait spinlock in pipe_read()
git bisect bad b667b867344301e24f21d4a4c844675ff61d89e1
# good: [f94df9890e98f2090c6a8d70c795134863b70201] Add wake_up_interruptible_sync_poll_locked()
git bisect good f94df9890e98f2090c6a8d70c795134863b70201
# bad: [6718b6f855a0b4962d54bd625be2718cb820cec6] pipe: Allow pipes to have kernel-reserved slots
git bisect bad 6718b6f855a0b4962d54bd625be2718cb820cec6
# bad: [8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98] pipe: Use head and tail pointers for the ring, not cursor and length
git bisect bad 8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98
# first bad commit: [8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98] pipe: Use head and tail pointers for the ring, not cursor and length

>       pipe: Allow pipes to have kernel-reserved slots
>       pipe: Advance tail pointer inside of wait spinlock in pipe_read()
>       pipe: Conditionalise wakeup in pipe_read()
>       pipe: Rearrange sequence in pipe_write() to preallocate slot
>       pipe: Remove redundant wakeup from pipe_write()
>       pipe: Check for ring full inside of the spinlock in pipe_write()
>       pipe: Increase the writer-wakeup threshold to reduce context-switch count
>       pipe: Remove sync on wake_ups
