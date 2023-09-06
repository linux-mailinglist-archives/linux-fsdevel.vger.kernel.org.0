Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CA579462E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 00:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbjIFW2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 18:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjIFW2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:28:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57BC1724;
        Wed,  6 Sep 2023 15:28:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB40C433C7;
        Wed,  6 Sep 2023 22:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694039329;
        bh=oMudE4Rzm4wjPyDC9fGvE9zWkTY3IGWqWV/ATmYeI1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMZdbYQbrj3jX90LFcUcE8K/nKqqjJPO/JCaOJIZZleiVcly/pyUSbL4UkIcAX9RN
         zHOJRL0alA0neBxlUZt0y3o01TAi4+lXFnD+/uus/24sDVGzrGFv7Jtp5wKpjbBhiQ
         hECuS2wRfJEJ+dSjmBpKUquv3dEJE/ZnXtnkIjuaEf7h+Gp6fz0RwlHsWmhyeHvrhM
         9oBcUhY/sbSRHdgDaCx28ZR9Mql/kwNlNVMsi2yW/ou64qCMpHiEq2nO1WIly57JEj
         xGUSKfcelzwtA9j8GKdjpvQ67qxoMQfy00d7bu5bf/C044U7cpNelesy6etM0If82o
         UdWbgXNpWbKAA==
Date:   Wed, 6 Sep 2023 15:28:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230906222847.GA230622@dev-arch.thelio-3990X>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent,

On Sat, Sep 02, 2023 at 11:25:55PM -0400, Kent Overstreet wrote:
> here's the bcachefs pull request, for 6.6. Hopefully everything
> outstanding from the previous PR thread has been resolved; the block
> layer prereqs are in now via Jens's tree and the dcache helper has a
> reviewed-by from Christain.

I pulled this into mainline locally and did an LLVM build, which found
an immediate issue. It appears the bcachefs codes uses zero length
arrays for flexible arrays instead of the C99 syntax that the kernel is
moving to, which will cause issues with -fstrict-flex-arrays=3 (clang
16+, gcc 13+), see commit df8fc4e934c1 ("kbuild: Enable
-fstrict-flex-arrays=3"). Currently, building x86_64 defconfig + the
bcachefs configs with clang warns (or errors with CONFIG_WERROR):

  In file included from fs/bcachefs/replicas.c:6:
  fs/bcachefs/replicas.h:46:2: error: array index 0 is past the end of the array (that has type '__u8[0]' (aka 'unsigned char[0]')) [-Werror,-Warray-bounds]
     46 |         e->devs[0]      = dev;
        |         ^       ~
  fs/bcachefs/bcachefs_format.h:1392:2: note: array 'devs' declared here
   1392 |         __u8                    devs[0];
        |         ^
  1 error generated.

GCC would warn in the same manner if -Warray-bounds was not disabled for
it... :(

  In file included from fs/bcachefs/buckets.c:22:
  In function 'bch2_replicas_entry_cached',
      inlined from 'update_cached_sectors' at fs/bcachefs/buckets.c:409:2,
      inlined from 'bch2_mark_alloc' at fs/bcachefs/buckets.c:590:9:
  fs/bcachefs/replicas.h:46:16: error: array subscript 0 is outside array bounds of '__u8[0]' {aka 'unsigned char[]'} [-Werror=array-bounds=]
     46 |         e->devs[0]      = dev;
        |         ~~~~~~~^~~
  In file included from fs/bcachefs/bcachefs.h:206,
                   from fs/bcachefs/buckets.c:8:
  fs/bcachefs/bcachefs_format.h: In function 'bch2_mark_alloc':
  fs/bcachefs/bcachefs_format.h:1392:33: note: while referencing 'devs'
   1392 |         __u8                    devs[0];
        |                                 ^~~~

GCC shows many other instances of this problem for the same reason (I
can send a build log if you'd like), such as 'struct snapshot_table' in
subvolume_types.h and several other structures in bcachefs_format.h.

Cheers,
Nathan
