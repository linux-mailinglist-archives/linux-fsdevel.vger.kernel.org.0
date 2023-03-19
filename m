Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6886C04E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCSUr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCSUrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:47:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649561420F;
        Sun, 19 Mar 2023 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bpylSVII1FYDPpIVeV+6MThI+CQatbJ+23qCa7MroYI=; b=h79wg4kJj+IQX0Ct/ULTrC7dxx
        v0HiZsAxr9rRp7MAlzrIs6Qon3wmZm355l7uwPG+9CwpJ3SVqcIllLqxIVBoQIrKj4NVoM62ach6f
        sFjamd25p6gWQDmSMtexer35BP89oCUHk6yZk8WHnAIFMegzx9Y6G5iwL5g1M5zV48U7EFd/ZXCBh
        nv9hgAc7XcvLw8zVCPpn5nakGDILXl34n1bbIamb2erFNDuFs0loLUhRTWSiIHRXWDzvzJK5W0Y2e
        2S5BIWC1xBAToDLYy8pqvRXgYTFPUeCO3nUzOC1vlEofgKDXiZeZB7ITDzKmkSu3hb0/hUo2vImMW
        hF2zuyKw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pdzvo-007PPe-0v;
        Sun, 19 Mar 2023 20:47:08 +0000
Date:   Sun, 19 Mar 2023 13:47:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jeff Xu <jeffxu@google.com>, Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <ZBd0zOqlH2H423ux@bombadil.infradead.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-9-mcgrof@kernel.org>
 <CALmYWFucv6-9yfS=gamwSsqjgxSKZS0nvVjj_QfBmsLmQD5XOQ@mail.gmail.com>
 <ZApZj9DmMYKuCQ3g@bombadil.infradead.org>
 <20230309142746.0bc649a31e76bc46fd929304@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309142746.0bc649a31e76bc46fd929304@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:27:46PM -0800, Andrew Morton wrote:
> On Thu, 9 Mar 2023 14:11:27 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > Andrew, kernel/pid_sysctl.h is new, not on v6.3-rc1 and so I cannot
> > carry this on sysctl-next. Can you carry this patch on your tree?
> 
> Sure, no probs.

Andrew, this one patch will have to go through your tree as kernel/pid_sysctl.h
only exist on your tree. I'll drop it on my end!

Thanks!

  Luis
