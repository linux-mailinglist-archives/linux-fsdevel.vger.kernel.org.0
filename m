Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829771E8C27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 01:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgE2Xj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 19:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2Xj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 19:39:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D54DC03E969;
        Fri, 29 May 2020 16:39:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeoax-000C19-MH; Fri, 29 May 2020 23:39:23 +0000
Date:   Sat, 30 May 2020 00:39:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Don Brace <don.brace@microsemi.com>, linux-scsi@vger.kernel.org
Subject: [PATCHES] uaccess hpsa
Message-ID: <20200529233923.GL23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	hpsa compat ioctl done (hopefully) saner.  I really want
to kill compat_alloc_user_space() off - it's always trouble and
for a driver-private ioctls it's absolutely pointless.

	Note that this is only compile-tested - I don't have the
hardware to test it on *or* userland to issue the ioctls in
question.  So this series definitely needs a review and testing
from hpsa maintainers before it might go anywhere.

	The series is in vfs.git #uaccess.hpsa, based at v5.7-rc1

Al Viro (4):
      hpsa passthrough: lift {BIG_,}IOCTL_Command_struct copy{in,out} into hpsa_ioctl()
      hpsa: don't bother with vmalloc for BIG_IOCTL_Command_struct
      hpsa: get rid of compat_alloc_user_space()
      hpsa_ioctl(): tidy up a bit

 drivers/scsi/hpsa.c | 199 ++++++++++++++++++++++++----------------------------
 1 file changed, 90 insertions(+), 109 deletions(-)

