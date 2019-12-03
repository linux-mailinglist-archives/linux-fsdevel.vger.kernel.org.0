Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D838110F469
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 02:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCBOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 20:14:00 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51468 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbfLCBOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:14:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5A56A8EE180;
        Mon,  2 Dec 2019 17:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575335639;
        bh=d4Rd40uDY5V6rF9DBhCn3DiiMG2CNa/baISyPlkOCFo=;
        h=Subject:From:To:Cc:Date:From;
        b=BixzRhSp6dDT6ytNUfVApYNxIfHdkSBTBuF3aj4JpRzcH8OmQ187GC7rc8fB9OkDa
         xUYrnhL214aAyEVBVjTjTykIJoiU2Lv/KDu+BXS5tIVt5K4LseUJSPPC1f/SWEegzs
         fFgAgeXu0st7tnhWXfYes+v6uXB7v6uFuLcARk/E=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QLwOI7-bIJ0T; Mon,  2 Dec 2019 17:13:59 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A57A58EE11D;
        Mon,  2 Dec 2019 17:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575335638;
        bh=d4Rd40uDY5V6rF9DBhCn3DiiMG2CNa/baISyPlkOCFo=;
        h=Subject:From:To:Cc:Date:From;
        b=CEx48PbOs1csmNTOZD4UnaSp0epFMxGKw3GZv4khSbZPaUthtqmMjbi7kCaizrA9Y
         dKFgjQpMhbAZ/uQRNeVOqfq6Flb6rY920ml56FUhM8TvCxcO6ubemPKpjvuB1XZPkk
         mOCMwg20SsIXxN5DRl9ozhJAvkQ1Ar7BdVZdRi3E=
Message-ID: <1575335637.24227.26.camel@HansenPartnership.com>
Subject: [PATCH 0/2] shiftfs reworked as a uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 02 Dec 2019 17:13:57 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've split these patches into two for easy review.  I think there's no
real point adding MS_SHIFT and letting the old mount API configure
this, so the second patch depends on the configfd proposal previously
sent since currently the new mount API is deficient in handling bind
mount properties.  However, for those of you who want to get it working
with the old API, simply adding MS_SHIFT and wiring it up to MNT_SHIFT
should work for now ... you can ignore all the part about the allow-
shift marking for test purposes ... I suspect the allow mechanism will
likely change, say to something xattr based, anyway.

James

---

James Bottomley (2):
  fs: introduce uid/gid shifting bind mount
  fs: expose shifting bind mount to userspace

 fs/attr.c             |  87 ++++++++++++++++++++++++++++----------
 fs/bind.c             |  35 ++++++++++++++++
 fs/exec.c             |   7 +++-
 fs/inode.c            |   9 ++--
 fs/internal.h         |   2 +
 fs/mount.h            |   2 +
 fs/namei.c            | 114 +++++++++++++++++++++++++++++++++++++++++---------
 fs/namespace.c        |   1 +
 fs/open.c             |  25 ++++++++++-
 fs/posix_acl.c        |   4 +-
 fs/proc_namespace.c   |   4 ++
 fs/stat.c             |  31 ++++++++++++--
 include/linux/cred.h  |  10 +++++
 include/linux/mount.h |   4 +-
 include/linux/sched.h |   5 +++
 kernel/capability.c   |  14 ++++++-
 kernel/cred.c         |  20 +++++++++
 kernel/groups.c       |   7 ++++
 18 files changed, 325 insertions(+), 56 deletions(-)

-- 
2.16.4

