Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902BC48C681
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354319AbiALOvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:51:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50306 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354317AbiALOvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:51:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC113B81F44;
        Wed, 12 Jan 2022 14:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501FEC36AEB;
        Wed, 12 Jan 2022 14:51:13 +0000 (UTC)
Date:   Wed, 12 Jan 2022 15:51:09 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220112145109.pou6676bsoatfg6x@wittgenstein>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143419.rgxumbts2jjb4aig@senku>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220112143419.rgxumbts2jjb4aig@senku>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 01:34:19AM +1100, Aleksa Sarai wrote:
> On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
> > If you have an opened O_PATH file, currently there is no way to re-open
> > it with other flags with openat/openat2. As a workaround it is possible
> > to open it via /proc/self/fd/<X>, however
> > 1) You need to ensure that /proc exists
> > 2) You cannot use O_NOFOLLOW flag
> 
> There is also another issue -- you can mount on top of magic-links so if
> you're a container runtime that has been tricked into creating bad
> mounts of top of /proc/ subdirectories there's no way of detecting that
> this has happened. (Though I think in the long-term we will need to
> make it possible for unprivileged users to create a procfs mountfd if
> they have hidepid=4,subset=pids set -- there are loads of things
> containers need to touch in procfs which can be overmounted in malicious
> ways.)

Yeah, though I see this as a less pressing issue for now. I'd rather
postpone this and make userspace work a bit more. There are ways to
design programs so you know that the procfs instance you're interacting
with is the one you want to interact with without requiring unprivileged
mounting outside of a userns+pidns+mountns pair. ;)

> 
> > Both problems may look insignificant, but they are sensitive for CRIU.
> > First of all, procfs may not be mounted in the namespace where we are
> > restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
> > flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
> > file with this flag during restore.
> > 
> > This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
> > struct open_how and changes getname() call to getname_flags() to avoid
> > ENOENT for empty filenames.
> 
> This is something I've wanted to implement for a while, but from memory
> we need to add some other protections in place before enabling this.
> 
> The main one is disallowing re-opening of a path when it was originally
> opened with a different set of modes. [1] is the patch I originally
> wrote as part of the openat2(2) (but I dropped it since I wasn't sure
> whether it might break some systems in subtle ways -- though according
> to my testing there wasn't an issue on any of my machines).

Oh this is the discussion we had around turning an opath fd into a say
O_RDWR fd, I think.
So yes, I think restricting fd reopening makes sense. However, going
from an O_PATH fd to e.g. an fd with O_RDWR does make sense and needs to
be the default anyway. So we would need to implement this as a denylist
anyway. The default is that opath fds can be reopened with whatever and
only if the opath creator has restricted reopening will it fail, i.e.
it's similar to a denylist.

But this patch wouldn't prevent that or hinder the upgrade mask
restriction afaict.
