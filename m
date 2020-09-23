Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D9275E7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWRUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 13:20:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36078 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgIWRUO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:20:14 -0400
X-Greylist: delayed 1987 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 13:20:13 EDT
Received: from [192.168.15.220] (helo=alex-laptop)
        by relay3.sw.ru with smtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1kL8Qm-000qs2-Kg; Wed, 23 Sep 2020 20:19:48 +0300
Date:   Wed, 23 Sep 2020 20:19:58 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     avagin@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fsopen: fsconfig syscall restart fix
Message-Id: <20200923201958.b27ecda5a1e788fb5f472bcd@virtuozzo.com>
In-Reply-To: <20200923170322.GP3421308@ZenIV.linux.org.uk>
References: <20200923164637.13032-1-alexander.mikhalitsyn@virtuozzo.com>
        <20200923164637.13032-2-alexander.mikhalitsyn@virtuozzo.com>
        <20200923170322.GP3421308@ZenIV.linux.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Sep 2020 18:03:22 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Wed, Sep 23, 2020 at 07:46:36PM +0300, Alexander Mikhalitsyn wrote:
> > During execution of vfs_fsconfig_locked function we can get ERESTARTNOINTR
> > error (or other interrupt error). But we changing fs context fc->phase
> > field to transient states and our entry fc->phase checks in switch cases
> > (see FS_CONTEXT_CREATE_PARAMS, FS_CONTEXT_RECONF_PARAMS) will always fail
> > after syscall restart which will lead to returning -EBUSY to the userspace.
> > 
> > The idea of the fix is to save entry-time fs_context phase field value and
> > recover fc->phase value to the original one before exiting with
> > "interrupt error" (ERESTARTNOINTR or similar).
> 
> If you have e.g. vfs_create_tree() fail in the middle of ->get_tree(),
> the only thing you can do to that thing is to discard it.  The state is
> *NOT* required to be recoverable after a failure exit - quite a bit of
> config might've been consumed and freed by that point.
> 
> CREATE and RECONFIGURE are simply not restartable.

Thank you for quick response!

I got you idea. But as far as I understand fsopen/fsconfig API is in
early-development stage and we can think about convenience here.

Consider the typical code here:
int fsfd;
fsfd = fsopen("somefs", 0);
// a lot of:
fsconfig(fsfd, FSCONFIG_SET_FLAG, ...);
fsconfig(fsfd, FSCONFIG_SET_STRING, ...);
fsconfig(fsfd, FSCONFIG_SET_BINARY, ...);
//...

// now call:
fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0)
-> get signal here or something else
-> syscall restarted but this doesn't work because
of broken fc->phase state
-> get EBUSY
-> now we need to repeat *all* steps with
fsconfig(fsfd, FSCONFIG_SET_FLAG/FSCONFIG_SET_STRING, ...).
Speaking honestly, this looks weird.

Regards,
Alex.
