Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ACC6A156D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 04:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBXDfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 22:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXDfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:35:19 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A46A75;
        Thu, 23 Feb 2023 19:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0w+Qstxk/MVBmjqfpO+5HBkk/GHaXIIa9cJiITgSSDE=; b=CFmKBrkNntTLhY8ltatb6+cxbl
        9rqBLpVSmTXDfxotq8z1YOHNVCEkMvtfU27tJ/t/rgq84YzerId9pFYT93hCMqXSORiEc7fODjpxW
        bON1tzBobM9KXJHIaHQciVpyAmtJUWL+LsH4o2c99BEFIuaVWnMNZ9lWDkhDaM2nPlSQjVgJD+KKS
        FiT5QQuviLL4zi5YzCNO3seE+i1QAyzh8RCKry/kvAeCnqZK5nRdh9u3m+Rg7xvVKRT3xfXKkUrsO
        U1b+v1Lf/tkMH90jUGVEmLc5hw6atoaTd59GL6rns6nBwOLcR0ByQ9Z0Bv7/ia9ZahPqKuBPjsDwZ
        OwlB2sDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVOrc-00BsEe-28;
        Fri, 24 Feb 2023 03:35:16 +0000
Date:   Fri, 24 Feb 2023 03:35:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git namespace stuff
Message-ID: <Y/gwdJrHLvEC1lCn@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Rik's patches reducing the amount of synchronize_rcu() triggered
by ipc namespace destruction.  I've some pending stuff reducing that on
the normal umount side, but it's nowhere near ready and Rik's stuff shouldn't
be held back due to conflicts - I'll just redo the parts of my series that
stray into ipc/*.

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namespace

for you to fetch changes up to da27f796a832122ee533c7685438dad1c4e338dd:

  ipc,namespace: batch free ipc_namespace structures (2023-01-27 19:08:00 -0500)

----------------------------------------------------------------
Rik van Riel (2):
      ipc,namespace: make ipc namespace allocation wait for pending free
      ipc,namespace: batch free ipc_namespace structures

 fs/namespace.c        | 18 ++++++++++++++----
 include/linux/mount.h |  1 +
 ipc/mqueue.c          |  5 -----
 ipc/namespace.c       | 35 ++++++++++++++++++++++++++---------
 ipc/util.h            |  2 --
 5 files changed, 41 insertions(+), 20 deletions(-)
