Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7541AF358
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDRSlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgDRSlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:41:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C78C061A41;
        Sat, 18 Apr 2020 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=d5zfrylOKoUmkiJ/VV8Fl3fzLkxXbmDEJr/3MIsevyo=; b=XCwSjlVez+qHxOPmcyTIK6oiMp
        olawr70vtpi0V1QI9XKQUEdNlzc7gZtydJwYjHnNgNwCiR0Y8ytqLU1885mYKcfU2nNRcSQ+hBEej
        MiJH64ZiTrBz5h80SHKV7B2XhV/8NA5dx2/XMstBP2kRcY+jAyFTPEP07dibSEvWPpw6URRhjEARq
        GsW6VSkFXNXfFpWKtacsKtxhxuNePEr2gYhZGljGT1rr1HkTT8hxKqdKHdiJLDwOvTjuHdAESVOeL
        NqEnuUJjyC5UmLntvc7lJwAg8Acv/O1w1fMRoAZtCHCPa4lyuiz4kTPN/HiIYqU17pqZ6fxYiBEQ9
        d15hNa1Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsOv-0007rZ-9I; Sat, 18 Apr 2020 18:41:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: [RFC PATCH 0/9] fix -Wempty-body build warnings
Date:   Sat, 18 Apr 2020 11:41:02 -0700
Message-Id: <20200418184111.13401-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

When -Wextra is used, gcc emits many warnings about an empty 'if' or
'else' body, like this:

../fs/posix_acl.c: In function ‘get_acl’:
../fs/posix_acl.c:127:22: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
   /* fall through */ ;
                      ^

To quieten these warnings, add a new macro "do_empty()".
I originally wanted to use do_nothing(), but that's already in use.

It would sorta be nice if "fallthrough" could be coerced for this
instead of using something like do_empty().

Or should we just use "{}" in place of ";"?
This causes some odd coding style issue IMO. E.g., see this change:

original:
 	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
		/* fall through */ ;

with new macro:
 	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
		do_empty(); /* fall through */

using {}:
 	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
		{} /* fall through */
or
		{ /* fall through */ }
or even
 	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED) {
		/* fall through */ }
or
 	if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED) {
		} /* fall through */


 drivers/base/devcoredump.c         |    5 +++--
 drivers/dax/bus.c                  |    5 +++--
 drivers/input/mouse/synaptics.c    |    3 ++-
 drivers/target/target_core_pscsi.c |    3 ++-
 drivers/usb/core/sysfs.c           |    2 +-
 fs/nfsd/nfs4state.c                |    3 ++-
 fs/posix_acl.c                     |    2 +-
 include/linux/kernel.h             |    8 ++++++++
 sound/drivers/vx/vx_core.c         |    3 ++-
 9 files changed, 24 insertions(+), 10 deletions(-)
