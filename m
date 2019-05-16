Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B31FCF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEPBq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:26 -0400
Received: from fieldses.org ([173.255.197.46]:33068 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfEPBUX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:20:23 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4BAF88BF; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] nfsd: allow fh_want_write to be called twice
Date:   Wed, 15 May 2019 21:20:06 -0400
Message-Id: <1557969619-17157-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

A fuzzer recently triggered lockdep warnings about potential sb_writers
deadlocks caused by fh_want_write().

Looks like we aren't careful to pair each fh_want_write() with an
fh_drop_write().

It's not normally a problem since fh_put() will call fh_drop_write() for
us.  And was OK for NFSv3 where we'd do one operation that might call
fh_want_write(), and then put the filehandle.

But an NFSv4 protocol fuzzer can do weird things like call unlink twice
in a compound, and then we get into trouble.

I'm a little worried about this approach of just leaving everything to
fh_put().  But I think there are probably a lot of
fh_want_write()/fh_drop_write() imbalances so for now I think we need it
to be more forgiving.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/vfs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index a7e107309f76..db351247892d 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -120,8 +120,11 @@ void		nfsd_put_raparams(struct file *file, struct raparms *ra);
 
 static inline int fh_want_write(struct svc_fh *fh)
 {
-	int ret = mnt_want_write(fh->fh_export->ex_path.mnt);
+	int ret;
 
+	if (fh->fh_want_write)
+		return 0;
+	ret = mnt_want_write(fh->fh_export->ex_path.mnt);
 	if (!ret)
 		fh->fh_want_write = true;
 	return ret;
-- 
2.21.0

