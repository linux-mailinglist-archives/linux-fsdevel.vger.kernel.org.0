Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A08D47FDAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 14:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhL0Nn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 08:43:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53268 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229644AbhL0Nn3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:43:29 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BRDhFk8024251
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 08:43:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9C46A15C33A3; Mon, 27 Dec 2021 08:43:15 -0500 (EST)
Date:   Mon, 27 Dec 2021 08:43:15 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] fs: super: possible ABBA deadlocks in
 do_thaw_all_callback() and freeze_bdev()
Message-ID: <YcnC85Vc95OTBJSV@mit.edu>
References: <e3de0d83-1170-05c8-672c-4428e781b988@gmail.com>
 <YckgOocIWOrOoRvf@casper.infradead.org>
 <YclDafAwrN0TkhCi@mit.edu>
 <a9dde5cc-b919-9c82-a185-851c2eab5442@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9dde5cc-b919-9c82-a185-851c2eab5442@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 27, 2021 at 05:32:09PM +0800, Jia-Ju Bai wrote:
> Thanks for your reply and suggestions.
> I will try to trigger this possible deadlock by enabling lockdep and using
> the workloads that you suggested.
> In my opinion, static analysis can conveniently cover some code that is hard
> to be covered at runtime, and thus it is useful to detecting some
> infrequently-triggered bugs.
> However, it is true that static analysis sometimes has many false positives,
> which is unsatisfactory :(
> I am trying some works to relieve this problem in kernel-code analysis.
> I can understand that the related code is not frequently executed, but I
> think that finding and fixing bugs should be always useful in practice :)

The thing about the sysrq commands is that they are almost always used
in emergency situations when the system administrator with physical
access to the console sends a sysrq command (e.g., by sending a BREAK
to the serial console).  This is usually done when the system has
*already* locked up for some reason, such as getting livelocked due to
an out of memory condition, or maybe even a deadlock.  So if sysrq-j
could potentially cause a deadlock, so what?  Sysrq-j would only be
used when the system was in a really bad state due to a bug in any
case.  In over 10 years of kernel development, I can't remember a
single time when I've needed to use sysrq-j.

So it might be that the better way to handle this would be to make
sure all of the emergency sysrq code in fs/super.c is under the
CONFIG_MAGIC_SYSRQ #ifdef --- and then do the static analysis without
CONFIG_MAGIC_SYSRQ defined.

As I said, I agree it's a bug, and if I had infinite resources, I'd
certainly ask an engineer to completely rework the emergency sysrq-j
code path to address the potential ABBA deadlock.  The problem is I do
*not* have infinite resources, which means I have to prioritize which
bugs get attention, and how much time engineers on my team spend
working on new features or performance enhacements that can justify
their salaries and ensure that they get good performance ratings ---
since leadership, technical difficulty and business impact is how
engineers get judged at my company.

Unfortunately, judging business impact is one of those things that is
unfair to expect a static analyzer to do.  And after all, if we have
infinite resources, why should an OS bother with a VM?  We can just
pin all process text/data segments in memory, if money (and DRAM
availability in the supply chain) is no object.  :-)

Cheers,

						- Ted
