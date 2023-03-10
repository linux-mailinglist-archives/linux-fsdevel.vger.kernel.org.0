Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20B6B3704
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 08:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCJHBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 02:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCJHB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:01:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E47F9EF2;
        Thu,  9 Mar 2023 23:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=ObS7kHIMNEO6/K+lu7Q5QaoN1Z0BkLGx2U6foA9qvp0=; b=VhDT+c0yOIEcyNND/R8fz60Uuv
        wvpQ4v7W8XgR4H0orSmpUv0rh4QGHHrUl/XKBabOi5eujNKNFCyO5dSdL/wI8X+IrZTjYbAvWmNMS
        zmZtFY7VsqCv7urBpM1GVULFyW9mG2YtuUu6LWphxQOC1MJSps6xMDKs7Gomm2RluGpMbFCrH2au4
        6BGM0zQTHm2Tg/qHLHDyKPnjf2BqJfXSl7vbMqtqQyuD+HHagTXSiRAVu9h+ToMu7LTBYwncMsYIl
        bQ3oLOYUXig1NMnqNlYzckfloUwFYdK926X/DyDup+DWNyEKe02OXkXcvvix8dF3eMoWbgTnN3p0z
        9f36tHvg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paWkE-00DKg8-7z; Fri, 10 Mar 2023 07:00:50 +0000
Date:   Thu, 9 Mar 2023 23:00:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, tytso@mit.edu,
        guoren@kernel.org, j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] kernel: pid_namespace: simplify sysctls with
 register_sysctl()
Message-ID: <ZArVonOBry+PtBRn@bombadil.infradead.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-9-mcgrof@kernel.org>
 <CALmYWFucv6-9yfS=gamwSsqjgxSKZS0nvVjj_QfBmsLmQD5XOQ@mail.gmail.com>
 <ZApZj9DmMYKuCQ3g@bombadil.infradead.org>
 <ZAquqQg2ZhpKL3x9@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAquqQg2ZhpKL3x9@sol.localdomain>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:14:33PM -0800, Eric Biggers wrote:
> On Thu, Mar 09, 2023 at 02:11:27PM -0800, Luis Chamberlain wrote:
> > On Thu, Mar 02, 2023 at 03:13:54PM -0800, Jeff Xu wrote:
> > > On Thu, Mar 2, 2023 at 12:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >  kernel/pid_sysctl.h    | 3 +--
> > > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > Acked-by: Jeff Xu <jeffxu@google.com>
> > 
> > Andrew, kernel/pid_sysctl.h is new, not on v6.3-rc1 and so I cannot
> > carry this on sysctl-next. Can you carry this patch on your tree?
> > 
> > I see Eric Biggers already took in the fs-verity patch, so I will drop
> > that from my queue.
> > 
> > I can take the rest in this series.
> > 
> > I will also hold off on the last patch which deprecates the routine
> > register_sysctl_paths() until after say the first part of the merge
> > window.
> > 
> > This will allow all of our trees to work on linux-next without conflict.
> > 
> > Let me know if this is OK with you and Eric!
> > 
> 
> That's fine with me.  I applied the fsverity patch based on your cover letter
> that said it was okay
> (https://lore.kernel.org/r/20230302202826.776286-1-mcgrof@kernel.org).

Yeah it perfectly fine!

> If you'd
> like to take all the patches so that you can remove register_sysctl_paths() in
> the same cycle, that would be fine too; it's up to you.

Nah it's fine, no rush in this. One small step at a time.

  Luis
