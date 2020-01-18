Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB114184E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 16:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgARP2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 10:28:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49760 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgARP2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:28:46 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isq1Z-00AxdN-Np; Sat, 18 Jan 2020 15:28:33 +0000
Date:   Sat, 18 Jan 2020 15:28:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        quae@daurnimator.com, dev@opencontainers.org,
        containers@lists.linux-foundation.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] openat2: minor uapi cleanups
Message-ID: <20200118152833.GS8904@ZenIV.linux.org.uk>
References: <20200115144831.GJ8904@ZenIV.linux.org.uk>
 <20200118120800.16358-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118120800.16358-1-cyphar@cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 18, 2020 at 11:07:58PM +1100, Aleksa Sarai wrote:
> Patch changelog:
>   v3:
>    * Merge changes into the original patches to make Al's life easier.
>      [Al Viro]
>   v2:
>    * Add include <linux/types.h> to openat2.h. [Florian Weimer]
>    * Move OPEN_HOW_SIZE_* constants out of UAPI. [Florian Weimer]
>    * Switch from __aligned_u64 to __u64 since it isn't necessary.
>      [David Laight]
>   v1: <https://lore.kernel.org/lkml/20191219105533.12508-1-cyphar@cyphar.com/>
> 
> While openat2(2) is still not yet in Linus's tree, we can take this
> opportunity to iron out some small warts that weren't noticed earlier:
> 
>   * A fix was suggested by Florian Weimer, to separate the openat2
>     definitions so glibc can use the header directly. I've put the
>     maintainership under VFS but let me know if you'd prefer it belong
>     ot the fcntl folks.
> 
>   * Having heterogenous field sizes in an extensible struct results in
>     "padding hole" problems when adding new fields (in addition the
>     correct error to use for non-zero padding isn't entirely clear ).
>     The simplest solution is to just copy clone(3)'s model -- always use
>     u64s. It will waste a little more space in the struct, but it
>     removes a possible future headache.
> 
> This patch is intended to replace the corresponding patches in Al's
> #work.openat2 tree (and *will not* apply on Linus' tree).
> 
> @Al: I will send some additional patches later, but they will require
>      proper design review since they're ABI-related features (namely,
> 	 adding a way to check what features a syscall supports as I
> 	 outlined in my talk here[1]).

#work.openat2 updated, #for-next rebuilt and force-pushed.  There's
a massive update of #work.namei as well, also pushed out; not in
#for-next yet, will post the patch series for review later today.
