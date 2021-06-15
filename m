Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE43A741A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 04:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFOCii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 22:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhFOCig (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:38:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3E9613F1;
        Tue, 15 Jun 2021 01:17:47 +0000 (UTC)
Date:   Mon, 14 Jun 2021 21:17:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] afs: fix tracepoint string placement with built-in AFS
Message-ID: <20210614211745.6eb3d9ca@oasis.local.home>
In-Reply-To: <20210614164752.12438695a27203c8e7c9eaea@linux-foundation.org>
References: <YLAXfvZ+rObEOdc/@localhost.localdomain>
        <20210614164752.12438695a27203c8e7c9eaea@linux-foundation.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 14 Jun 2021 16:47:52 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> Should/can afs_SRXCB##name##_name[] be static?

Probably.
	
> 
> 
> __tracepoint_string is very rarely used.  I wonder if there's much
> point in it existing?

There's a few places that the "tracepoint_string()" couldn't be used,
and this was a workaround for those locations. Yes, it's not used much,
but what's the other solution should we use to replace it?

> 
> 
> kernel/rcu/tree.h does
> 
> static char rcu_name[] = RCU_NAME_RAW;
> static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
> 
> which is asking the compiler to place a copy of these into each
> compilation unit which includes tree.h, which probably isn't what was
> intended.

Yeah, there's a couple of duplicates. Perhaps we can move them into a C
file, and have it simply exported.

-- Steve
