Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA7496096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 15:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381023AbiAUOSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 09:18:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53568 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350813AbiAUOSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:18:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D519CB81FE5;
        Fri, 21 Jan 2022 14:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2946AC340E1;
        Fri, 21 Jan 2022 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642774720;
        bh=drXbDDI7Zkm5TxhfNdcieA7XvXno9U2261QKbBkQDhk=;
        h=From:To:Cc:Subject:Date:From;
        b=Vbgrb8pOE5NJgZkxChBxnfBwnTgRKt0r+2xBHOH8f5bfPaRHyIsuwI6f1b92p3JG1
         l/oOVI/xzkc173Uk0UQrfwZQkFYX3YEnNQFIfy6krMaWEMUEufHym+VaHLBxzn+4DW
         tkQt5I55FgOYr64Lja5ki/zWFiJtWVogIk/e8swtbRFt9O8ayCelnsOJ7boab0la+H
         p+fHymkXso+dbJ9lmlz0qBTA0PtgWgkcJdTgFDDTpkDA/uh+sFDy1VAD/KyCuLo4Hd
         IhxUvzBP5YCHVsCWiqb34Ce2l4jM6aAg+XSHhvzZT7OBUiUrACRJsFaNNSryIfFB6c
         g8pMYQPQ32jXA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/3] ceph: uninline data on open instead of write
Date:   Fri, 21 Jan 2022 09:18:35 -0500
Message-Id: <20220121141838.110954-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inline_data feature for ceph allowed you to store the first chunk of
file data in the MDS instead of the OSD, using the cap system to keep
things in sync. The kernel client implementation has always been a bit
buggy and racy, and user uptake of this feature was pretty low.

A couple of years ago, we decided to formally deprecate the inline_data
feature entirely, and marked it as such in the Octopus release. We're
still waiting on a few pieces in userland [1] before we can rip out
support there so we need to keep support for inline_data in the client
for now.

This patch series changes the client from uninlining the data on the
first write, to doing so at open time. This gets the uninlining out of
the more fiddly write codepaths, and fits with the larger goal of
aggressively deprecating inline_data.

The original series was proposed by David. I added fixes for a few bugs
found during testing and rolled in a related fix to change how we acquire
the inode pointer.

[1]: https://tracker.ceph.com/issues/52916

David Howells (2):
  ceph: Make ceph_netfs_issue_op() handle inlined data
  ceph: Uninline the data on a file opened for writing

Jeff Layton (1):
  ceph: switch netfs read ops to use rreq->inode instead of
    rreq->mapping->host

 fs/ceph/addr.c  | 239 +++++++++++++++++++++++-------------------------
 fs/ceph/file.c  |  32 +++----
 fs/ceph/super.h |   2 +-
 3 files changed, 129 insertions(+), 144 deletions(-)

-- 
2.34.1

