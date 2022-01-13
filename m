Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1F48D5D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 11:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiAMKeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 05:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiAMKeA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:34:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2EAC06173F;
        Thu, 13 Jan 2022 02:34:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A89461BE6;
        Thu, 13 Jan 2022 10:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43CFC36AE9;
        Thu, 13 Jan 2022 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642070039;
        bh=97BXsEJgLSUpPhg628TSSEHtF2xTCt2ytK13UUxhfiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxvdI9BK40TbhY/2DZbCySwg7nBs/3dkd6k/I2TE8+UmIrfJmDcfrvoLK8i28EXaP
         QSAZYUQ5OxfKXCvQ04l301ASU/BqfxF5ez0jc8Z2Neos7MPG8qSreRAcoaqNIVWCrM
         wAge+hVKxC12eD/nIruP+gxcOqiY9axR+xCHoLY/5ncqHBQSpeZTdI0Tmuac9QhXDS
         DNcXM7jc6Ok59zic0TaqQKgSJWHa06vWyFOclVvNs25QqRLnxxYEqGqZxTrvrqHo7W
         RiBLWRpX9UtCt9W1wxV4ZyyS032Zy7F0aw+0uT9Z1dAHYUdsaxNnQoVndc4A5dUh/w
         wJTAbw0CrtPoQ==
Date:   Thu, 13 Jan 2022 11:33:54 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220113103354.mirvx3copcltiquy@wittgenstein>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143940.ugj27xzprmptqmr7@wittgenstein>
 <20220112144331.dpbhi7j2vwutrxyt@senku>
 <20220112145325.hdim2q2qgewvgceh@wittgenstein>
 <0140c600-89e2-6be7-2967-f4b13b0baeaa@virtuozzo.com>
 <20220113064751.y6sqhdnyudz2eo7e@senku>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113064751.y6sqhdnyudz2eo7e@senku>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 05:47:51PM +1100, Aleksa Sarai wrote:
> On 2022-01-12, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com> wrote:
> > 
> > 
> > On 1/12/22 17:53, Christian Brauner wrote:
> > > On Thu, Jan 13, 2022 at 01:43:31AM +1100, Aleksa Sarai wrote:
> > > > On 2022-01-12, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > > > > On Wed, Jan 12, 2022 at 12:02:17PM +0300, Andrey Zhadchenko wrote:
> > > > > > If you have an opened O_PATH file, currently there is no way to re-open
> > > > > > it with other flags with openat/openat2. As a workaround it is possible
> > > > > > to open it via /proc/self/fd/<X>, however
> > > > > > 1) You need to ensure that /proc exists
> > > > > > 2) You cannot use O_NOFOLLOW flag
> > > > > > 
> > > > > > Both problems may look insignificant, but they are sensitive for CRIU.
> > > > > 
> > > > > Not just CRIU. It's also an issue for systemd, LXD, and other users.
> > > > > (One old example is where we do need to sometimes stash an O_PATH fd to
> > > > > a /dev/pts/ptmx device and to actually perform an open on the device we
> > > > > reopen via /proc/<pid>/fd/<nr>.)
> > > > > 
> > > > > > First of all, procfs may not be mounted in the namespace where we are
> > > > > > restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
> > > > > > flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
> > > > > > file with this flag during restore.
> > > > > > 
> > > > > > This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
> > > > > > struct open_how and changes getname() call to getname_flags() to avoid
> > > > > > ENOENT for empty filenames.
> > > > > 
> > > > >  From my perspective this makes sense and is something that would be
> > > > > very useful instead of having to hack around this via procfs.
> > > > > 
> > > > > However, e should consider adding RESOLVE_EMPTY_PATH since we already
> > > > > have AT_EMPTY_PATH. If we think this is workable we should try and reuse
> > > > > AT_EMPTY_PATH that keeps the api consistent with linkat(), readlinkat(),
> > > > > execveat(), statx(), open_tree(), mount_setattr() etc.
> > > > > 
> > > > > If AT_EMPTY_PATH doesn't conflict with another O_* flag one could make
> > > > > openat() support it too?
> > > > 
> > > > I would much prefer O_EMPTYPATH, in fact I think this is what I called
> > > > it in my first draft ages ago. RESOLVE_ is meant to be related to
> > > > resolution restrictions, not changing the opening mode.
> > > 
> > > That seems okay to me too. The advantage of AT_EMPTY_PATH is that we
> > > don't double down on the naming confusion, imho.
> > Unfortunately AT_EMPTY_PATH is 0x1000 which is O_DSYNC (octal 010000).
> > At first I thought to add new field in struct open_how for AT_* flags.
> > However most of them are irrelevant, except AT_SYMLINK_NOFOLLOW, which
> > duplicates RESOLVE flags, and maybe AT_NO_AUTOMOUNT.
> > O_EMPTYPATH idea seems cool
> 
> Yeah the issue is that openat/openat2 don't actually take AT_* flags and
> all of the constants conflict. I would prefer not mixing O_ and AT_
> flags in open (and I suspect Al would also prefer that).

If we can't reuse the value then it's not that important. But then we
should probably consider adding O_EMPTYPATH indeed. It doesn't make much
sense as a resolve flag (I think you mentioned that in an earlier mail
too.).
