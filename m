Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0070223C51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGQNVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 09:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:21:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4110AC061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 06:21:50 -0700 (PDT)
Date:   Fri, 17 Jul 2020 15:21:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594992108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6yuBzA43RcKjWR9TNWr2XirR3UIzAZu2QFzhLhU8O0=;
        b=HLQSsE5NkY2DHE7OnpMJG8cqW1BLyfnob/h8t11spYof2VRlgsQCCYooYknYzJCRTDIJb0
        1tCKEgdQ/5KDBYa6cudlrZVgVrXICVRPhpXggIlHcN+uCwkRfjJp/tqVWoWlNkxwY+Tzbk
        G5fPSgQvq38YfX3H+RFVqH3IaQ0rHW5B9/c7a2tet2v6TpORg0yFj9YO4jcFea0tJKxJmK
        nwGQdZnmvsBN9cai/c5+nMJuURYtkbsfXrJQ5H62C+29fZbhdWNjUojK/ot5jQxFeHW35H
        A70Jxuv8E7V401vT5XQMATa6LquOlBS2lOmQWAcLXhsWsmSTLoSmlC0QpHgHtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594992108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6yuBzA43RcKjWR9TNWr2XirR3UIzAZu2QFzhLhU8O0=;
        b=sxeUfhyCfOLAjjJnTo9yGSw17hEYYZH4LNZ8JM+eopSKGfkpF5wwkoetM6zuXOYRnxWCml
        z+JSF7dZVx9ttQDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alberto Milone <alberto.milone@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/1] radix-tree: do not export radix_tree_preloads as GPL
Message-ID: <20200717132147.nizfehgvzsdi2tfv@linutronix.de>
References: <20200717101848.1869465-1-alberto.milone@canonical.com>
 <20200717104300.h7k7ho25hmslvtgy@linutronix.de>
 <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-07-17 14:33:31 [+0200], Alberto Milone wrote:
> 
> I checked and CONFIG_DEBUG_LOCK_ALLOC is not enabled in our kernels.

The access to that variable is optimized away if not for debug. I made
this:
| #include <linux/module.h>
| #include <linux/idr.h>
| 
| static int le_init(void)
| {
|         idr_preload_end();
|         return 0;
| }
| module_init(le_init);
| 
| static void le_exit(void)
| {
| }
| module_exit(le_exit);
|    
| MODULE_DESCRIPTION("driver");
| MODULE_LICENSE("prop");

and it produced a .ko. Here the "idr_preload_end()" was reduced to
"preempt_enable()" as intended. No access to
"&radix_tree_preloads.lock".

Sebastian
