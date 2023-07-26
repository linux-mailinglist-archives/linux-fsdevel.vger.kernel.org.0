Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8B763E38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjGZSPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjGZSPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:15:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7B52D44;
        Wed, 26 Jul 2023 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x97cDGBfbbYgCu4TNBD9kXaxFG/QZ+f5W68FlyrkZcE=; b=Q2VKv6oQ6oHWzZEFcT0SsIsfBn
        oD6MQPzRS5vQQlGWM5+zSeNvcE6Xyd37XYO3CpHLWgeAwlRVV6of7bh40pq3z2rmFr3UWJ6opyss6
        5xmm07nFq4G84pv8yjwZTMUuua6sDDICAkKq2lvbSUsQ8mOMZ7KpxXAfIaq39fe5+m47fdqJu2CMK
        Tn2RWeUgMz0lSjQj5z6W5UmOFQNclWFYFpEQl55xY6r9/NC6S8Lf4bxH+ZzMJCWJ7XdeF8SSHrPK6
        pyiUI2TwB4IZx2YDr6NiJ87nWWbeqHbZMhA0LbGJ0A3u9k8VMwpSlTaE+uKN8QlK0tnYPithCoPM8
        ROqfp5UQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOj2y-00BG7X-34;
        Wed, 26 Jul 2023 18:15:40 +0000
Date:   Wed, 26 Jul 2023 11:15:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, willy@infradead.org,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/14] sysctl: Add a size argument to register functions
 in sysctl
Message-ID: <ZMFizKFkVxUFtSqa@bombadil.infradead.org>
References: <CGME20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd@eucas1p2.samsung.com>
 <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:06:20PM +0200, Joel Granados wrote:
> What?
> These commits set things up so we can start removing the sentinel elements.

Yes but the why must explained right away.

> Why?
> This is part of the push to trim down kernel/sysctl.c by moving the large array
> that was causing merge conflicts. 

Let me elaborate on that:

While the move moving over time of array elements out of kernel/sysctl.c
to their own place helps merge conflicts this patch set does not help
with that in and of itself, what it does is help make sure the move of
sysctls to their own files does not bloat the kernel more, and in fact
helps reduce the overall build time size of the kernel and run time
memory consumed by the kernel by about ~64 bytes per array.

Without this patch set each time we moved a set of sysctls out of
kernel/sysctl.c to its own subsystem we'd have to add a new sentinel
element (an empty sysctl entry), and while that helps clean up
kernel/sysctl.c to avoid merge conflicts, it also bloats the kernel
by about 64 bytes on average each time.

We can do better. We can make those moves *not* have a size penalty, and
all around also reduce the build / run time of the kernel.

*This* is the why, that if we don't do this the cleanup of
kernel/sysctl.c ends up slowly bloating the kernel. Willy had
suggested we instead remove the sentinel so that each move does not
incur a size penalty, but also that in turn reduces the size of the
kernel at build time / run time by a ballpark about ~64 bytes per
array.

Then the following is more details about estimates of overall size
savings, it's not miscellaneous information at all, it's very relevant
information to this patch set.

> Misc:
> A consequence of eventually removing all the sentinels (64 bytes per sentinel)
> is the bytes we save. Here I include numbers for when all sentinels are removed
> to contextualize this chunk
>   * bloat-o-meter:
>     The "yesall" configuration results save 9158 bytes (you can see the output here
>     https://lore.kernel.org/all/20230621091000.424843-1-j.granados@samsung.com/.
>     The "tiny" configuration + CONFIG_SYSCTL save 1215 bytes (you can see the
>     output here [2])
>   * memory usage:
>     As we no longer need the sentinel element within proc_sysctl.c, we save some
>     bytes in main memory as well. In my testing kernel I measured a difference of
>     6720 bytes. I include the way to measure this in [1]

  Luis
