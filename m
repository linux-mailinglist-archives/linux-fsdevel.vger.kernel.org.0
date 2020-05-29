Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37F31E7193
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgE2Ae0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgE2AeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:34:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9424DC08C5C6;
        Thu, 28 May 2020 17:34:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSyZ-00HFMm-2w; Fri, 29 May 2020 00:34:19 +0000
Date:   Fri, 29 May 2020 01:34:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCHES] uaccess comedi compat
Message-ID: <20200529003419.GX23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	The way comedi compat ioctls are done is wrong.
Instead of having ->compat_ioctl() copying the 32bit
stuff in, then passing the kernel copies to helpers shared
with native ->ioctl() and doing copyout with conversion if
needed, it's playing silly buggers with creating a 64bit
copy on user stack, then calling native ioctl (which copies
that copy into the kernel), then fetching it from user stack,
converting to 32bit variant and copying that to user.
	Extra headache for no good reason.  And the single
largest remaining pile of __put_user()/__get_user() this side
of arch/*.  IMO compat_alloc_user_space() should die...

	NOTE: this is only compile-tested - I simply don't
have the hardware in question.

	Anyway, the branch lives in #uaccess.comedi, based
at v5.7-rc1
	
Al Viro (10):
      comedi: move compat ioctl handling to native fops
      comedi: get rid of indirection via translated_ioctl()
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_CHANINFO compat
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_RANGEINFO compat
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSN compat
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSNLIST compat
      comedi: lift copy_from_user() into callers of __comedi_get_user_cmd()
      comedi: do_cmdtest_ioctl(): lift copyin/copyout into the caller
      comedi: do_cmd_ioctl(): lift copyin/copyout into the caller
      comedi: get rid of compat_alloc_user_space() mess in COMEDI_CMD{,TEST} compat

 drivers/staging/comedi/Makefile          |   1 -
 drivers/staging/comedi/comedi_compat32.c | 455 -------------------------
 drivers/staging/comedi/comedi_compat32.h |  28 --
 drivers/staging/comedi/comedi_fops.c     | 563 +++++++++++++++++++++++++------
 drivers/staging/comedi/comedi_internal.h |   2 +-
 drivers/staging/comedi/range.c           |  17 +-
 6 files changed, 466 insertions(+), 600 deletions(-)
 delete mode 100644 drivers/staging/comedi/comedi_compat32.c
 delete mode 100644 drivers/staging/comedi/comedi_compat32.h

