Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78B462401
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhK2WO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhK2WMa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:12:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC4DC0E52F7;
        Mon, 29 Nov 2021 13:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=la5n+95FqwkImWApoxw9yt6K9/mVvw40Er2NamVkaww=; b=cQnfGaBPRGTYnKlp2Q3CkKpaRO
        1Q+lgvgboeYnPCIMgXliftKxLBet/Oeo1r/cuz8s5M1vqGtqTrFfEw1bYmSDQeYS/b/hrAwiTJaRL
        sUKW7O+cMgFMXEri4UIaFZ6SO2vzleUeOS7bOrhm1zAQG2/1TvixHQn+k8Gy+c4r71jCpst+kiPLk
        yi45DnPEFJxWliZ1oPUU/EWHCpm0SUP/T3WeLaPKXAyCD1p+AThHC+XIuRJwUvebP2wvjPmEmtef/
        yToFVpzqGCCwnMHRseRYWg5eKe81WU0HoYiN0pzKaxIhMD4V/Gme9xXoytbjFs28Wt4mx7BMV/Aib
        0+0Fj0Hw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrnmA-002Zh1-Fo; Mon, 29 Nov 2021 21:01:26 +0000
Date:   Mon, 29 Nov 2021 13:01:26 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        senozhatsky@chromium.org, wangqing@vivo.com, bcrl@kvack.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] sysctl: add a new register_sysctl_init() interface
Message-ID: <YaU/phu3JoalmC8E@bombadil.infradead.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123202347.818157-2-mcgrof@kernel.org>
 <YZ+2XwgQn8UpVcpb@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ+2XwgQn8UpVcpb@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 05:14:23PM +0100, Petr Mladek wrote:
> On Tue 2021-11-23 12:23:39, Luis Chamberlain wrote:
> > From: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > The kernel/sysctl.c is a kitchen sink where everyone leaves
> > their dirty dishes, this makes it very difficult to maintain.
> > 
> > To help with this maintenance let's start by moving sysctls to
> > places where they actually belong. The proc sysctl maintainers
> > do not want to know what sysctl knobs you wish to add for your own
> > piece of code, we just care about the core logic.
> > 
> > Today though folks heavily rely on tables on kernel/sysctl.c so
> > they can easily just extend this table with their needed sysctls.
> > In order to help users move their sysctls out we need to provide a
> > helper which can be used during code initialization.
> > 
> > We special-case the initialization use of register_sysctl() since
> > it *is* safe to fail, given all that sysctls do is provide a dynamic
> > interface to query or modify at runtime an existing variable. So the
> > use case of register_sysctl() on init should *not* stop if the sysctls
> > don't end up getting registered. It would be counter productive to
> > stop boot if a simple sysctl registration failed.
> >
> > Provide a helper for init then, and document the recommended init
> > levels to use for callers of this routine. We will later use this
> > in subsequent patches to start slimming down kernel/sysctl.c tables
> > and moving sysctl registration to the code which actually needs
> > these sysctls.
> 
> Do we really need a new helper for this?
> Is the failure acceptable only during system initialization?

Yes because it is __init and we allow / guide folks to *think* clearly
about not stopping the init process when it comes to sysctls on failure.

> The warning would be useful even for the original register_sysctl().

We can open code those.

> It should be up-to-the caller to decide if the failure is fatal
> or not. It might be enough to document the reasoning why a warning
> is enough in most cases.

For most case I have seen so far special casing init seems like a worthy
objective. When we're done with the full conversion we can re-visit
things but at this point I can't say sharing this outside of init uses
makes too much sense.

  Luis

