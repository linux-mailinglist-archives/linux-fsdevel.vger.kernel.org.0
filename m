Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875F948D50A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 10:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiAMJbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 04:31:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59610 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiAMJbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:31:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 69B621F3D0;
        Thu, 13 Jan 2022 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642066300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tNIWwIUMcDmi9ZqG5FAYmz9YUg0nC27JkLBuHr5SBc=;
        b=Tuxkb0QbikOTnHX/qShX311jOaC3/A/+Ryh1bHBu2gI7kpsTfiTJyPsCSdkgS/zo2flwu3
        pC4QePv8f6rVUUZ6wMoBknMEM5Xu12uzfeTuZqaJSrD5v93WsugocgUKjkrlPeasQ+KVjL
        kN2vwbfv4l9NUNGgL9Kpysux80tYzF4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 461FEA3B84;
        Thu, 13 Jan 2022 09:31:40 +0000 (UTC)
Date:   Thu, 13 Jan 2022 10:31:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH 2/3] panic: Add option to dump all CPUs backtraces in
 panic_print
Message-ID: <Yd/xe5c2HfhwqWwk@alley>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-3-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109202848.610874-3-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-11-09 17:28:47, Guilherme G. Piccoli wrote:
> Currently the "panic_print" parameter/sysctl allows some interesting debug
> information to be printed during a panic event. This is useful for example
> in cases the user cannot kdump due to resource limits, or if the user
> collects panic logs in a serial output (or pstore) and prefers a fast
> reboot instead of a kdump.

Yes, I have missed this possibility many times.

> Happens that currently there's no way to see all CPUs backtraces in
> a panic using "panic_print" on architectures that support that. We do
> have "oops_all_cpu_backtrace" sysctl, but although partially overlapping
> in the functionality, they are orthogonal in nature: "panic_print" is
> a panic tuning (and we have panics without oopses, like direct calls to
> panic() or maybe other paths that don't go through oops_enter()
> function), and the original purpose of "oops_all_cpu_backtrace" is to
> provide more information on oopses for cases in which the users desire
> to continue running the kernel even after an oops, i.e., used in
> non-panic scenarios.

panic() already prevents double backtrace of the CPU that Oopsed, see:

#ifdef CONFIG_DEBUG_BUGVERBOSE
	/*
	 * Avoid nested stack-dumping if a panic occurs during oops processing
	 */
	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
		dump_stack();
#endif

It should be possible to do something similar also for backtraces
on all CPUs.

There are more situation when the backtraces are printed and panic()
is called, for example: softlockup_panic and
softlockup_all_cpu_backtrace.

Well, it is just nice to have. People probably will not use these
options together. And it is better to have the backtraces twice
than do not have them at all.

> So, we hereby introduce an additional bit for "panic_print" to allow
> dumping the CPUs backtraces during a panic event.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
