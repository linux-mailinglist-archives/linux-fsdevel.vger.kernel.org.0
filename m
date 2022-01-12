Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BA48C628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354148AbiALOjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354143AbiALOjs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:39:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D4C06173F;
        Wed, 12 Jan 2022 06:39:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E32A8B81ED0;
        Wed, 12 Jan 2022 14:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E827DC36AEA;
        Wed, 12 Jan 2022 14:39:43 +0000 (UTC)
Date:   Wed, 12 Jan 2022 15:39:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, ptikhomirov@virtuozzo.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220112143940.ugj27xzprmptqmr7@wittgenstein>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 12:02:17PM +0300, Andrey Zhadchenko wrote:
> If you have an opened O_PATH file, currently there is no way to re-open
> it with other flags with openat/openat2. As a workaround it is possible
> to open it via /proc/self/fd/<X>, however
> 1) You need to ensure that /proc exists
> 2) You cannot use O_NOFOLLOW flag
> 
> Both problems may look insignificant, but they are sensitive for CRIU.

Not just CRIU. It's also an issue for systemd, LXD, and other users.
(One old example is where we do need to sometimes stash an O_PATH fd to
a /dev/pts/ptmx device and to actually perform an open on the device we
reopen via /proc/<pid>/fd/<nr>.)

> First of all, procfs may not be mounted in the namespace where we are
> restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
> flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
> file with this flag during restore.
> 
> This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
> struct open_how and changes getname() call to getname_flags() to avoid
> ENOENT for empty filenames.

From my perspective this makes sense and is something that would be
very useful instead of having to hack around this via procfs.

However, e should consider adding RESOLVE_EMPTY_PATH since we already
have AT_EMPTY_PATH. If we think this is workable we should try and reuse
AT_EMPTY_PATH that keeps the api consistent with linkat(), readlinkat(),
execveat(), statx(), open_tree(), mount_setattr() etc.

If AT_EMPTY_PATH doesn't conflict with another O_* flag one could make
openat() support it too?
