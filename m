Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579DA48C689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354338AbiALOxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354308AbiALOxa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:53:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA56C061748;
        Wed, 12 Jan 2022 06:53:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBAB61879;
        Wed, 12 Jan 2022 14:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33271C36AE5;
        Wed, 12 Jan 2022 14:53:28 +0000 (UTC)
Date:   Wed, 12 Jan 2022 15:53:25 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220112145325.hdim2q2qgewvgceh@wittgenstein>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143940.ugj27xzprmptqmr7@wittgenstein>
 <20220112144331.dpbhi7j2vwutrxyt@senku>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220112144331.dpbhi7j2vwutrxyt@senku>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 01:43:31AM +1100, Aleksa Sarai wrote:
> On 2022-01-12, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > On Wed, Jan 12, 2022 at 12:02:17PM +0300, Andrey Zhadchenko wrote:
> > > If you have an opened O_PATH file, currently there is no way to re-open
> > > it with other flags with openat/openat2. As a workaround it is possible
> > > to open it via /proc/self/fd/<X>, however
> > > 1) You need to ensure that /proc exists
> > > 2) You cannot use O_NOFOLLOW flag
> > > 
> > > Both problems may look insignificant, but they are sensitive for CRIU.
> > 
> > Not just CRIU. It's also an issue for systemd, LXD, and other users.
> > (One old example is where we do need to sometimes stash an O_PATH fd to
> > a /dev/pts/ptmx device and to actually perform an open on the device we
> > reopen via /proc/<pid>/fd/<nr>.)
> > 
> > > First of all, procfs may not be mounted in the namespace where we are
> > > restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
> > > flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
> > > file with this flag during restore.
> > > 
> > > This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
> > > struct open_how and changes getname() call to getname_flags() to avoid
> > > ENOENT for empty filenames.
> > 
> > From my perspective this makes sense and is something that would be
> > very useful instead of having to hack around this via procfs.
> > 
> > However, e should consider adding RESOLVE_EMPTY_PATH since we already
> > have AT_EMPTY_PATH. If we think this is workable we should try and reuse
> > AT_EMPTY_PATH that keeps the api consistent with linkat(), readlinkat(),
> > execveat(), statx(), open_tree(), mount_setattr() etc.
> > 
> > If AT_EMPTY_PATH doesn't conflict with another O_* flag one could make
> > openat() support it too?
> 
> I would much prefer O_EMPTYPATH, in fact I think this is what I called
> it in my first draft ages ago. RESOLVE_ is meant to be related to
> resolution restrictions, not changing the opening mode.

That seems okay to me too. The advantage of AT_EMPTY_PATH is that we
don't double down on the naming confusion, imho.
