Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E6765F2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 00:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjG0WTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG0WTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29073187;
        Thu, 27 Jul 2023 15:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DA061F6A;
        Thu, 27 Jul 2023 22:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E6CC433CB;
        Thu, 27 Jul 2023 22:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690496344;
        bh=0QDxqnaIcY9aYSlSdSfjkuKu90WD4q/w29rSRMNnmgk=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=APlOw6wTBy0/wlAtKvZRFFVsPNoczUGhJ87LD1FWVmwPjkR8gazwZ/r3QacBifdwf
         c+tqZCNtUlkZt2t2e9F1r7h0RCtQLaK1oFiAYrH0IJqwrr9cA36EhiF0F76EYVcmQ1
         Kt/0nawfX0dSmh4175rlWbPGy6W/vB5LAUePm+O5ujEG7zZoj2RKrl/7gSAlhuWQLS
         O8YWUtragzPqPI3rkL94jPXWYC/Br0ozdxSKDxklBCC9Q2BVAyKwyzzAdApbeJvMLf
         GqSyWtDP0T0QdrgFxRAZIWTDd/Cevezpq58hE0f+Y4mpXTnXgcZbkZUTrNpPe1tHTf
         eTk7LSamv/XZg==
Date:   Thu, 27 Jul 2023 15:19:03 -0700
Subject: [PATCHSET v26.0 0/7] xfs: stage repair information in pageable memory
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
In-Reply-To: <20230727221158.GE11352@frogsfrogsfrogs>
References: <20230727221158.GE11352@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

In general, online repair of an indexed record set walks the filesystem
looking for records.  These records are sorted and bulk-loaded into a
new btree.  To make this happen without pinning gigabytes of metadata in
memory, first create an abstraction ('xfile') of memfd files so that
kernel code can access paged memory, and then an array abstraction
('xfarray') based on xfiles so that online repair can create an array of
new records without pinning memory.

These two data storage abstractions are critical for repair of space
metadata -- the memory used is pageable, which helps us avoid pinning
kernel memory and driving OOM problems; and they are byte-accessible
enough that we can use them like (very slow and programmatic) memory
buffers.

Later patchsets will build on this functionality to provide blob storage
and btrees.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=big-array
---
 fs/xfs/Kconfig         |    1 
 fs/xfs/Makefile        |    2 
 fs/xfs/scrub/trace.c   |    4 
 fs/xfs/scrub/trace.h   |  260 ++++++++++++
 fs/xfs/scrub/xfarray.c | 1083 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfarray.h |  141 ++++++
 fs/xfs/scrub/xfile.c   |  420 +++++++++++++++++++
 fs/xfs/scrub/xfile.h   |   77 +++
 8 files changed, 1987 insertions(+), 1 deletion(-)
 create mode 100644 fs/xfs/scrub/xfarray.c
 create mode 100644 fs/xfs/scrub/xfarray.h
 create mode 100644 fs/xfs/scrub/xfile.c
 create mode 100644 fs/xfs/scrub/xfile.h

