Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF545DE7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 17:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349922AbhKYQTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 11:19:38 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49562 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352719AbhKYQRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:17:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 67ACB1FD34;
        Thu, 25 Nov 2021 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637856865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bo77CZqSqXbmZ4wuoRaS02pkfz7n85YeAngSJyyojCA=;
        b=l/E6S9bpxNLKTqHtgu3FoItI7WRvrAyEHAXqPvYzWKmAWGv+CzgzLfSyRBGRUjrOKGO/52
        u9RpggNvpjjRsNYdIAf3m/pTweOKiA+cF9swssR15h9RtmZteS15cauWN7xk3t08sQ56yo
        rKPd1cjc1Eq+TNj23NjwgVriy6QJ6JI=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 939A2A3B83;
        Thu, 25 Nov 2021 16:14:23 +0000 (UTC)
Date:   Thu, 25 Nov 2021 17:14:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        senozhatsky@chromium.org, wangqing@vivo.com, bcrl@kvack.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] sysctl: add a new register_sysctl_init() interface
Message-ID: <YZ+2XwgQn8UpVcpb@alley>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123202347.818157-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123202347.818157-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-11-23 12:23:39, Luis Chamberlain wrote:
> From: Xiaoming Ni <nixiaoming@huawei.com>
> 
> The kernel/sysctl.c is a kitchen sink where everyone leaves
> their dirty dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to
> places where they actually belong. The proc sysctl maintainers
> do not want to know what sysctl knobs you wish to add for your own
> piece of code, we just care about the core logic.
> 
> Today though folks heavily rely on tables on kernel/sysctl.c so
> they can easily just extend this table with their needed sysctls.
> In order to help users move their sysctls out we need to provide a
> helper which can be used during code initialization.
> 
> We special-case the initialization use of register_sysctl() since
> it *is* safe to fail, given all that sysctls do is provide a dynamic
> interface to query or modify at runtime an existing variable. So the
> use case of register_sysctl() on init should *not* stop if the sysctls
> don't end up getting registered. It would be counter productive to
> stop boot if a simple sysctl registration failed.
>
> Provide a helper for init then, and document the recommended init
> levels to use for callers of this routine. We will later use this
> in subsequent patches to start slimming down kernel/sysctl.c tables
> and moving sysctl registration to the code which actually needs
> these sysctls.

Do we really need a new helper for this?
Is the failure acceptable only during system initialization?

The warning would be useful even for the original register_sysctl().

It should be up-to-the caller to decide if the failure is fatal
or not. It might be enough to document the reasoning why a warning
is enough in most cases.

Best Regards,
Petr
