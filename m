Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45043277CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 10:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfEWIPW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 04:15:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42039 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfEWIPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 04:15:21 -0400
Received: from [2001:67c:670:100:ba1b:8b86:7360:f80e] (helo=rettich)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1hTise-0007Xp-Oh; Thu, 23 May 2019 10:15:16 +0200
Received: from jlu by rettich with local (Exim 4.89)
        (envelope-from <jlu@pengutronix.de>)
        id 1hTise-0007rG-6j; Thu, 23 May 2019 10:15:16 +0200
Message-ID: <1558599316.4138.86.camel@pengutronix.de>
Subject: Re: [PATCH] proc: report eip and esp for all threads when
 coredumping
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 23 May 2019 10:15:16 +0200
In-Reply-To: <20190522110047.6bc80ca511a1425d8a069110@linux-foundation.org>
References: <20190522161614.628-1-jlu@pengutronix.de>
         <20190522110047.6bc80ca511a1425d8a069110@linux-foundation.org>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:ba1b:8b86:7360:f80e
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-05-22 at 11:00 -0700, Andrew Morton wrote:
> On Wed, 22 May 2019 18:16:14 +0200 Jan Luebbe <jlu@pengutronix.de> wrote:
> 
> > Commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in
> > /proc/PID/stat") stopped reporting eip/esp and commit fd7d56270b52
> > ("fs/proc: Report eip/esp in /prod/PID/stat for coredumping")
> > reintroduced the feature to fix a regression with userspace core dump
> > handlers (such as minicoredumper).
> > 
> > Because PF_DUMPCORE is only set for the primary thread, this didn't fix
> > the original problem for secondary threads. This commit checks
> > mm->core_state instead, as already done for /proc/<pid>/status in
> > task_core_dumping(). As we have a mm_struct available here anyway, this
> > seems to be a clean solution.
> 
> Could we please have an explicit and complete description of the
> end-user visible effect of this change?

In current mainline, all threads except the main have the
/proc/[pid]/stat fields 'kstkesp' (29, current stack pointer) and
'kstkeip' (30, current instruction pointer) show as 0 even during
coredumping when read by the core dump handler.

minicoredumper for example tries to use this value to find each
thread's stack and tries to dump it, which fails as there is nothing
mapped at 0. The result is that the thread's stack data is missing from
the generated core dump.

With this patch, kstkesp and kstkeip are visible again to the core dump
handler, so the minified core dump contains all stacks again. For a
process running normally, the values are still reported as 0 (as
intended).

> It sounds like we should be backporting this into -stable but without
> the above info it's hard to determine this.

We've been using this patch on 4.19.x for some time, so I agree that
this should be back-ported (fd7d56270b52 is in 4.14).


Andrew, should I send a v2 with Alexey's fix squashed and an updated
commit message?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
