Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8730D49C11A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiAZCSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:18:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50152 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiAZCSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:18:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BAC615D5;
        Wed, 26 Jan 2022 02:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4DFC340E0;
        Wed, 26 Jan 2022 02:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163490;
        bh=QdXqHY16dnBT/c2yDR+Xloz4Oc+CKgHWCU5u0QDMVZ8=;
        h=Subject:From:To:Cc:Date:From;
        b=tduP12Tnd8zt0I4bFeDvDPB+gs5Eb+ef6fYUUl1ay6jw85bUA1mOVH6Cs0Ehbq6mx
         lJaySYzYfMRDQnQYn/Ex+sPec8rQadq1umc6HFOOasDWTVfplZFG27GSKpWO9fnKFc
         U/JIQG+iJYSObugaS2qAVJ+UDsgcVszDcX9/z3Q/w+k03hssly2t9rhyzxAWS1faNs
         wE42QJbuHTZtXLLEwR/aAxp8lPrQ3CwUVOZIEGgFTCQUILfaKGpk1dKO1f4ojxKfaP
         04GsUJIpgWpVvF8HGWN9WeTs0JgRnY8NUXlHCwYIjth2XDg+wJzT4uU6Lxm6uKJKLQ
         9KS/PFIBl9g8g==
Subject: [PATCHSET 0/4] vfs: actually return fs errors from ->sync_fs
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Date:   Tue, 25 Jan 2022 18:18:09 -0800
Message-ID: <164316348940.2600168.17153575889519271710.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

While auditing the VFS code, I noticed that while ->sync_fs is allowed
to return error codes to reflect some sort of internal filesystem error,
none of the callers actually check the return value.  Back when this
callout was introduced for sync_filesystem in 2.5 this didn't matter
because we only did it prior to rebooting, and best-effort was enough.

Nowadays, we've grown other callers that mandate persistence of fs
metadata, like syncfs(2) and quota sync.  Reporting internal fs errors
is critical for these functions, and we drop the errors.  Fix them, and
also fix FIFREEZE, so that userspace can't freeze broken filesystems.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=return-sync-fs-errors-5.17
---
 fs/quota/dquot.c   |   11 ++++++++---
 fs/super.c         |   19 ++++++++++++-------
 fs/sync.c          |   18 ++++++++++++------
 fs/xfs/xfs_super.c |    6 +++++-
 4 files changed, 37 insertions(+), 17 deletions(-)

