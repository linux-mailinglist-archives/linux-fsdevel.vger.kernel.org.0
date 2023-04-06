Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0B6D924E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjDFJJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjDFJJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7183;
        Thu,  6 Apr 2023 02:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F07615D9;
        Thu,  6 Apr 2023 09:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D30C433EF;
        Thu,  6 Apr 2023 09:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680772186;
        bh=89z7jVK3dMAn7VBgMvt/Ijr6T41u1MDrt2CMwepk5+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbyqOtXES+6s3UGbMFP8FMuAHD6hWRHCnzSXh+Ei6nLb45TKssOVaR5L9G3M/PgKb
         4zC+6ZjxTh5L+JCtpYV5dJ88XUgvSct1hbBKrs9Na0/8ghNg0lqtHTV4+kndvmRTPR
         Qen0JBYFDgJzje2h4WjF7zJ0HMWILRM6HzTzTyMdcAo/7xNwm/XCUWUzshLA+LVvAH
         Fu5C1LkS5GnaDDkoULrsDeCUQi4XDGnoEN7IjzcuO9I1pmecj1ERfqr/QozHEZwBHY
         cwwolBs64zxuXQzA0CLzaTZUz0PEA69QyqJJiX4/zigzzKrV3cWReZmM8ep2uvOTih
         A6/WRwYpv/KYw==
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RESEND PATCH v2] eventfd: use wait_event_interruptible_locked_irq() helper
Date:   Thu,  6 Apr 2023 11:08:49 +0200
Message-Id: <20230406-kernig-parabel-d12963a4e7fa@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_16F9553E8354D950D704214D6EA407315F0A@qq.com>
References: <tencent_16F9553E8354D950D704214D6EA407315F0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=brauner@kernel.org; h=from:subject:message-id; bh=K8ik1op6ugu9bhhVGatLJ3Hq0wNNQNCodDUXq+Rpsfk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTo9bD7Rip5Hvrd1Tqvcn/pXNF1hls9FdIl/s58+u2N5nt9 swr1jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsOs/IMP2xcdDhLnu7bznSL1YeU9 t89Pq1QmV/0+1uPJsX/3GtD2D471fUFv12cc2t1lnn1qYcXMXs7HZubRzj+yPiH1QFjpfUcwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Thu, 06 Apr 2023 03:20:02 +0800, wenyang.linux@foxmail.com wrote:
> wait_event_interruptible_locked_irq was introduced by commit 22c43c81a51e
> ("wait_event_interruptible_locked() interface"), but older code such as
> eventfd_{write,read} still uses the open code implementation.
> Inspired by commit 8120a8aadb20
> ("fs/timerfd.c: make use of wait_event_interruptible_locked_irq()"), this
> patch replaces the open code implementation with a single macro call.
> 
> [...]

I ran LTP with ./runltp -f syscalls -s eventfd passes and aligns with what was
done for timerfd.

Applied, thanks!

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc
[1/1] eventfd: use wait_event_interruptible_locked_irq() helper
      commit: 113348a44b8622b497fb884f41c8659481ad0b04
