Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDAB716E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 04:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfISCLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 22:11:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39756 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfISCLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:11:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAluZ-0005e0-L3; Thu, 19 Sep 2019 02:11:11 +0000
Date:   Thu, 19 Sep 2019 03:11:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [git pull] autofs-related stuff
Message-ID: <20190919021111.GK1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	The most interesting part here is getting rid of the last trylock
loop on dentry->d_lock - the ones in fs/dcache.c had been dealt with
several years ago, but there'd been leftovers in fs/autofs/expire.c

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.autofs

for you to fetch changes up to 5f68056ca50fdd3954a93ae66fea7452abddb66f:

  autofs_lookup(): hold ->d_lock over playing with ->d_flags (2019-07-27 10:03:14 -0400)

----------------------------------------------------------------
Al Viro (3):
      autofs: simplify get_next_positive_...(), get rid of trylocks
      get rid of autofs_info->active_count
      autofs_lookup(): hold ->d_lock over playing with ->d_flags

 fs/autofs/autofs_i.h |   1 -
 fs/autofs/expire.c   | 103 ++++++++++++++++-----------------------------------
 fs/autofs/root.c     |  44 ++++++----------------
 3 files changed, 44 insertions(+), 104 deletions(-)
