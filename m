Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B412B7AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfE0Ohx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 10:37:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51584 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfE0Ohx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 10:37:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A081915EDF3;
        Mon, 27 May 2019 10:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=zot+SgMMZ6NLkAbEfpi2LUH3mQg=; b=sWfOaR
        Vk+aJbCEAlII2KwizI8uEAjvrRCGxGjVlq9esNoojV6ynhwQKBcAvWyvfipnrCwE
        OhZa7VZwY/DfU1CC3BDgEpBieBcuLXnVSMEG85s977vrD8xv6Lv/E2UY48runV0f
        uH/YesulcIvXULY5X6xTYKZRXW5ZHalfCjWhI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9757315EDF2;
        Mon, 27 May 2019 10:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=iGYrYXMmcUG/e3dkcmXnxQB5h/4Pjc8UzTVPVZ4a6Eg=; b=T3H3Hf1yUjjiAwjwbeXLI2c1avRjSUaDRUKgwlobx330QqXp72MtELf0geJg99iyhaGzLXIlUYpcIbOfP5xWb9uoFIKnMPHdcNV+sz9wuy0HqpgoB7RvzxrmzlDZDCQWAuRxkJgosFDOLBGgEIAORfZIpwqMq4G2plGrOz46iuM=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08FEF15EDF1;
        Mon, 27 May 2019 10:37:48 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id E1ADA2DA045D;
        Mon, 27 May 2019 10:37:46 -0400 (EDT)
Date:   Mon, 27 May 2019 10:37:46 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Jann Horn <jannh@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
In-Reply-To: <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1905271031340.1558@knanqh.ubzr>
References: <20190524201817.16509-1-jannh@google.com> <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org> <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: FF6CA618-808C-11E9-ACB2-72EEE64BB12D-78420484!pb-smtp2.pobox.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 27 May 2019, Jann Horn wrote:

> On Sat, May 25, 2019 at 11:43 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com> wrote:
> > > load_flat_shared_library() is broken: It only calls load_flat_file() if
> > > prepare_binprm() returns zero, but prepare_binprm() returns the number of
> > > bytes read - so this only happens if the file is empty.
> >
> > ouch.
> >
> > > Instead, call into load_flat_file() if the number of bytes read is
> > > non-negative. (Even if the number of bytes is zero - in that case,
> > > load_flat_file() will see nullbytes and return a nice -ENOEXEC.)
> > >
> > > In addition, remove the code related to bprm creds and stop using
> > > prepare_binprm() - this code is loading a library, not a main executable,
> > > and it only actually uses the members "buf", "file" and "filename" of the
> > > linux_binprm struct. Instead, call kernel_read() directly.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > I only found the bug by looking at the code, I have not verified its
> > > existence at runtime.
> > > Also, this patch is compile-tested only.
> > > It would be nice if someone who works with nommu Linux could have a
> > > look at this patch.
> >
> > 287980e49ffc was three years ago!  Has it really been broken for all
> > that time?  If so, it seems a good source of freed disk space...
> 
> Maybe... but I didn't want to rip it out without having one of the
> maintainers confirm that this really isn't likely to be used anymore.

Last time I played with this, I couldn't figure out the toolchain to 
produce shared libs. Only static executables worked fine. If I recall, 
existing binfmt_flat distros don't use shared libs either.

For shared lib support on no-MMU target, binfmt_elf_fdpic is a much 
saner choice.


Nicolas
