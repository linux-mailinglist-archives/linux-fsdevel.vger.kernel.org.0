Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD851095EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 00:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKYXDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 18:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfKYXDa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 18:03:30 -0500
Received: from localhost (unknown [148.87.23.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D41E20733;
        Mon, 25 Nov 2019 23:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574723009;
        bh=awSI1iSxQbhSMV0m77NwnLOTQKzfcKC3DBlLMmMYNGA=;
        h=Date:From:To:Cc:Subject:From;
        b=WZkLYSU53+TCdd5XbKUpAvsTF6p8uUTt1bP8tiSfGNHTjbY4I4KvZoW7uMxYPBPZX
         wtyI4r554FqLYpnJpLgBiufq4SJNPVMSaOE/HKg39MEVl6+7JBXTze1MmA8V6NroIK
         Wmh4hpF8HJlZnTniKAWpwqM9wevTUHNoOFVQAebQ=
Date:   Mon, 25 Nov 2019 15:03:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, agruenba@redhat.com
Subject: [GIT PULL] splice: fix for 5.5
Message-ID: <20191125230326.GS6211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this single patch for 5.5 that fixes some questionable pipe
behavior in the splice code.  Specifically, whenever we perform a read
into a pipe, we now clamp the read request to the length of the pipe
buffer since there's no point in asking for more than we can handle.
We already fixed this in one place, but Andreas Gruenbacher found
another place where we could overflow, and requested a second fix.

The branch merges cleanly against this morning's HEAD and survived a few
days' worth of xfstests.  The merge was completely straightforward, so
please let me know if you run into anything weird.

--D

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.5-merge-1

for you to fetch changes up to 3253d9d093376d62b4a56e609f15d2ec5085ac73:

  splice: only read in as much information as there is pipe buffer space (2019-10-15 08:44:32 -0700)

----------------------------------------------------------------
New code for 5.5:
- Fix another place in the splice code where a pipe could ask a
filesystem for a longer read than the pipe actually has free buffer
space.

----------------------------------------------------------------
Darrick J. Wong (1):
      splice: only read in as much information as there is pipe buffer space

 fs/splice.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)
