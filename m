Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96606B3585
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 05:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCJEU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 23:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCJETv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:19:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBFC10A952;
        Thu,  9 Mar 2023 20:15:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1219F60C73;
        Fri, 10 Mar 2023 04:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80602C433EF;
        Fri, 10 Mar 2023 04:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678421676;
        bh=IHYty/4GTvZcVEJLtsO716Yxd/JYXDChKqHKhiBDzHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzXqPpoGiFMKB4yYHchwmNYtVQ7zrP/Ipp7V8pXYHvSGnBNtKOZZVN7RAlBV+5JrN
         uF9mdwNrqWIk/BT4de7XsERryKBvBUQC5YpuHhnwNtnAW/Dc20JQLyW6kkzVxCWBWo
         rdGD7iaNiurnCAnLr/vxP4WQFmB71Gxw+uSBS/vR+uKL5hGFx3lpgqd/Z8PcixUejv
         i6QAyvFIbclomubfrewfOeWSW9CY2r4zihCd2YyteQMOf93ZyBZ1b6aDQhjer9BtzM
         2Jl6xziuv99xXe15KJLp3kPmOCy600ALioiA6hTy26TsENIGNpmtgWUnru8Ok+i4J3
         Tjqe7TMYbO/vg==
Date:   Thu, 9 Mar 2023 20:14:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <ZAquqQg2ZhpKL3x9@sol.localdomain>
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-9-mcgrof@kernel.org>
 <CALmYWFucv6-9yfS=gamwSsqjgxSKZS0nvVjj_QfBmsLmQD5XOQ@mail.gmail.com>
 <ZApZj9DmMYKuCQ3g@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZApZj9DmMYKuCQ3g@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:11:27PM -0800, Luis Chamberlain wrote:
> On Thu, Mar 02, 2023 at 03:13:54PM -0800, Jeff Xu wrote:
> > On Thu, Mar 2, 2023 at 12:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >  kernel/pid_sysctl.h    | 3 +--
> > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > >
> > Acked-by: Jeff Xu <jeffxu@google.com>
> 
> Andrew, kernel/pid_sysctl.h is new, not on v6.3-rc1 and so I cannot
> carry this on sysctl-next. Can you carry this patch on your tree?
> 
> I see Eric Biggers already took in the fs-verity patch, so I will drop
> that from my queue.
> 
> I can take the rest in this series.
> 
> I will also hold off on the last patch which deprecates the routine
> register_sysctl_paths() until after say the first part of the merge
> window.
> 
> This will allow all of our trees to work on linux-next without conflict.
> 
> Let me know if this is OK with you and Eric!
> 

That's fine with me.  I applied the fsverity patch based on your cover letter
that said it was okay
(https://lore.kernel.org/r/20230302202826.776286-1-mcgrof@kernel.org).  If you'd
like to take all the patches so that you can remove register_sysctl_paths() in
the same cycle, that would be fine too; it's up to you.

- Eric
