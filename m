Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E7659DA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiL3XAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiL3XAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:00:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658EE1CFC9;
        Fri, 30 Dec 2022 15:00:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1702FB81D84;
        Fri, 30 Dec 2022 23:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26AAC433EF;
        Fri, 30 Dec 2022 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672441226;
        bh=30AGiV7N3yLx3LEE00Lz5n1GV3M5wwwMQ2QfGSyjFJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C/Qo/sD0Z13ThavkOQqlOkZBsPVswFifsqfTmsaRCqUUhv0pAId7dfQa102tPXYwW
         AUcS5zNyQTbJ+bCU6WI68UHUDACqZwfQb0HwOwwAzW0vbxwhsYm8Z1BsgTqcVjh2PH
         fqYon4s8eB3fVEVyHFaQlrQnPqo/HwsIrhnnTmCJ0eH67DAwMWjEuNenhpH/biGpIW
         TWuATc4gQnb0S4K/+JYC2mMZsALhQSBkk+J7Uv+NFxoVliKaSklU+WoiJCF7c9gQE9
         NEObYlTrtm9rrfj6c2FugVkmEbUG1S7TRiUjyW2o5NBtfrswHs5SpISly9OzHrdEuq
         mdYRPs9ZfRQ4A==
Subject: [PATCHSET v24.0 0/7] xfs: stage repair information in pageable memory
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:12:34 -0800
Message-ID: <167243835481.692498.14657125042725378987.stgit@magnolia>
In-Reply-To: <Y69Unb7KRM5awJoV@magnolia>
References: <Y69Unb7KRM5awJoV@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/xfs/scrub/xfile.c   |  426 +++++++++++++++++++
 fs/xfs/scrub/xfile.h   |   78 +++
 8 files changed, 1998 insertions(+), 1 deletion(-)
 create mode 100644 fs/xfs/scrub/xfarray.c
 create mode 100644 fs/xfs/scrub/xfarray.h
 create mode 100644 fs/xfs/scrub/xfile.c
 create mode 100644 fs/xfs/scrub/xfile.h

