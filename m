Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388AD711B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjEZA3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjEZA3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:29:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D61A4;
        Thu, 25 May 2023 17:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C8264C01;
        Fri, 26 May 2023 00:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560E0C433EF;
        Fri, 26 May 2023 00:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685060936;
        bh=XckDz2ezIs9e94oVQv9VFKzPQuH3IhBaFejOs5zHT+k=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=GsxMmX332o+xAHvfZXoYyo/SILZFW8T7S3y8Hws/TCbHPfs6/mHpVFKi0Na+pxzMd
         QRDqSV13O8M3VNF3vNtxpMMRv8JNqCGs11g/FN6IBfGxU3yX0BCDu03Vykbnz8WeRs
         omrwrC7Hki2ppF2y/D+VekNZzU4s+9QwDACnYB8aEw3KH/QMLLH2zpsC83tmDYbkQn
         Mt3gDs6oYV3vUnhCqwt5SrRfA5NNMPl57RjX1dJ5S2noZoooDqHmKjMgJZOsXpsH4j
         73BJwi3eqBfGP7WwuL+mamXlZ43xSQeyWX9go8Iu4TcOHkUFT72Sk8Rki74PJYfqng
         etKURHEa3U6/A==
Date:   Thu, 25 May 2023 17:28:55 -0700
Subject: [PATCHSET v25.0 0/7] xfs: stage repair information in pageable memory
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
In-Reply-To: <20230526000020.GJ11620@frogsfrogsfrogs>
References: <20230526000020.GJ11620@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 fs/xfs/scrub/trace.h   |  262 ++++++++++++
 fs/xfs/scrub/xfarray.c | 1084 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfarray.h |  142 ++++++
 fs/xfs/scrub/xfile.c   |  433 +++++++++++++++++++
 fs/xfs/scrub/xfile.h   |   78 +++
 8 files changed, 2005 insertions(+), 1 deletion(-)
 create mode 100644 fs/xfs/scrub/xfarray.c
 create mode 100644 fs/xfs/scrub/xfarray.h
 create mode 100644 fs/xfs/scrub/xfile.c
 create mode 100644 fs/xfs/scrub/xfile.h

