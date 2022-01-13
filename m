Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19348D4AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiAMJCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 04:02:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56284 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiAMJCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:02:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A88C21F3A8;
        Thu, 13 Jan 2022 09:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642064539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maRJiYWWsej6VtzU8BY/ZSUfh+jtG5r9ye7Nqwr2LU4=;
        b=row7JZbSGynM/P4rzOyrZA53mgeZpQ9CUH1boo32eLI2QtXUzdCwIHjzi8q1ZEUlZC5Mky
        HH8OAdNQh9fpQ5v7SgDnlIj22beb+/UbCbwZQNCioCJPlb9z0KC/o5zZ0HtSWttQYPnVaz
        047dfsye0991We8g9UV70dKfxUcsJoI=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 822C7A3B88;
        Thu, 13 Jan 2022 09:02:19 +0000 (UTC)
Date:   Thu, 13 Jan 2022 10:02:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Message-ID: <Yd/qmyz+qSuoUwbs@alley>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109202848.610874-4-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-11-09 17:28:48, Guilherme G. Piccoli wrote:
> Currently we have the "panic_print" parameter/sysctl to allow some extra
> information to be printed in a panic event. On the other hand, the kdump
> mechanism allows to kexec a new kernel to collect a memory dump for the
> running kernel in case of panic.
> Right now these options are incompatible: the user either sets the kdump
> or makes use of "panic_print". The code path of "panic_print" isn't
> reached when kdump is configured.
> 
> There are situations though in which this would be interesting: for
> example, in systems that are very memory constrained, a handcrafted
> tiny kernel/initrd for kdump might be used in order to only collect the
> dmesg in kdump kernel. Even more common, systems with no disk space for
> the full (compressed) memory dump might very well rely in this
> functionality too, dumping only the dmesg with the additional information
> provided by "panic_print".

Is anyone really using this approach? kmsg_dump() looks like a better
choice when there are memory constrains. It does not need to reserve
memory for booting the crash kernel.

I would not mind much but this change depends on a not fully reliable
assumption, see below.

Also it will also complicate the solution for the kmsg_dump() code path.
It would be better to discuss this togeter with the other patch
https://lore.kernel.org/r/20220106212835.119409-1-gpiccoli@igalia.com


> So, this is what the patch does: allows both functionality to co-exist;
> if "panic_print" is set and the system performs a kdump, the extra
> information is printed on dmesg before the kexec. Some notes about the
> design choices here:
> 
> (a) We could have introduced a sysctl or an extra bit on "panic_print"
> to allow enabling the co-existence of kdump and "panic_print", but seems
> that would be over-engineering; we have 3 cases, let's check how this
> patch change things:
> 
> - if the user have kdump set and not "panic_print", nothing changes;
> - if the user have "panic_print" set and not kdump, nothing changes;
> - if both are enabled, now we print the extra information before kdump,
> which is exactly the goal of the patch (and should be the goal of the
> user, since they enabled both options).
> 
> (b) We assume that the code path won't return from __crash_kexec()
> so we didn't guard against double execution of panic_print_sys_info().

This sounds suspiciously. There is small race window but it actually works.
__crash_kexec() really never returns when @kexec_crash_image is
loaded. Well, it might break in the future if the code is modified.

Best Regards,
Petr
