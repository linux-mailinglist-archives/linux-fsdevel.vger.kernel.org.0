Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388AFBF4EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfIZOVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 10:21:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfIZOVV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:21:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63B3410CC207;
        Thu, 26 Sep 2019 14:21:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-72.rdu2.redhat.com [10.10.125.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1A1360C44;
        Thu, 26 Sep 2019 14:21:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] jffs2: Fix mounting under new mount API
From:   David Howells <dhowells@redhat.com>
To:     dwmw2@infradead.org, richard@nod.at
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org,
        dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 Sep 2019 15:21:18 +0100
Message-ID: <156950767876.30879.17024491763471689960.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Thu, 26 Sep 2019 14:21:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The mounting of jffs2 is broken due to the changes from the new mount API
because it specifies a "source" operation, but then doesn't actually
process it.  But because it specified it, it doesn't return -ENOPARAM and
the caller doesn't process it either and the source gets lost.

Fix this by simply removing the source parameter from jffs2 and letting the
VFS deal with it in the default manner.

To test it, enable CONFIG_MTD_MTDRAM and allow the default size and erase
block size parameters, then try and mount the /dev/mtdblock<N> file that
that creates as jffs2.  No need to initialise it.

Fixes: ec10a24f10c8 ("vfs: Convert jffs2 to use the new mount API")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>
cc: Richard Weinberger <richard@nod.at>
cc: linux-mtd@lists.infradead.org
---

 fs/jffs2/super.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index cbe70637c117..0e6406c4f362 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -163,13 +163,11 @@ static const struct export_operations jffs2_export_ops = {
  * Opt_rp_size: size of reserved pool in KiB
  */
 enum {
-	Opt_source,
 	Opt_override_compr,
 	Opt_rp_size,
 };
 
 static const struct fs_parameter_spec jffs2_param_specs[] = {
-	fsparam_string	("source",	Opt_source),
 	fsparam_enum	("compr",	Opt_override_compr),
 	fsparam_u32	("rp_size",	Opt_rp_size),
 	{}

