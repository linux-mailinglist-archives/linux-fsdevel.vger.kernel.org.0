Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EBE5062E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 05:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiDSDow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 23:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348168AbiDSDos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA33193D
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 20:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB2F61049
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 03:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7281DC385A1;
        Tue, 19 Apr 2022 03:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650339725;
        bh=Col+AuMuVCxgczTCBn+vOlTtSikyZMVqXjSHcD/QGsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TyU5vl0JDmVQsivRL11MJ6DW2ONKqOvANTg1zGc5zvY4rZlV7JSuq2+3jBKMPGwwV
         zq/It8qZOZ+DZVjS9a8UbUzgbOiSK6XckuaCfJXq1jciaBhNX+RHBYIoG7O+Q52CFL
         zE6BaGe6Yj1ctjHwpg74A2WIiZrb4kpS9i2N1l4s=
Date:   Mon, 18 Apr 2022 20:42:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     hughd@google.com, amir73il@gmail.com, viro@zeniv.linux.org.uk,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] shmem: Allow userspace monitoring of tmpfs for
 lack of space.
Message-Id: <20220418204204.0405eda0c506fd29e857e1e4@linux-foundation.org>
In-Reply-To: <20220418213713.273050-1-krisman@collabora.com>
References: <20220418213713.273050-1-krisman@collabora.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Apr 2022 17:37:10 -0400 Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> When provisioning containerized applications, multiple very small tmpfs

"files"?

> are used, for which one cannot always predict the proper file system
> size ahead of time.  We want to be able to reliably monitor filesystems
> for ENOSPC errors, without depending on the application being executed
> reporting the ENOSPC after a failure.

Well that sucks.  We need a kernel-side workaround for applications
that fail to check and report storage errors?

We could do this for every syscall in the kernel.  What's special about
tmpfs in this regard?  

Please provide additional justification and usage examples for such an
extraordinary thing.

>  It is also not enough to watch
> statfs since that information might be ephemeral (say the application
> recovers by deleting data, the issue can get lost).

We could fix the apps?  Heck, you could patch libc's write() to the same
effect.

>  For this use case,
> it is also interesting to differentiate IO errors caused by lack of
> virtual memory from lack of FS space.

More details, please.  Why interesting?  What actions can the system
operator take based upon this information?

Whatever that action is, I see no user-facing documentation which
guides the user info how to take advantage of this?


