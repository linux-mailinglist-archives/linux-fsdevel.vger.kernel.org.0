Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A01D8E15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbfJPKh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 06:37:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388344AbfJPKh4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:37:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 394C5308FBB4;
        Wed, 16 Oct 2019 10:37:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19EBA5C1D6;
        Wed, 16 Oct 2019 10:37:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] vfs: Handle fs_param_neg_with_empty
From:   David Howells <dhowells@redhat.com>
To:     lczerner@redhat.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Oct 2019 11:37:54 +0100
Message-ID: <157122227425.17182.1135743644487819585.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 16 Oct 2019 10:37:56 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make fs_param_neg_with_empty work.  It says that a parameter with no value
or and empty value should be marked as negated.

This is intended for use with ext4, which hadn't yet been converted.

Fixes: 31d921c7fb96 ("vfs: Add configuration parser helpers")
Reported-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fs_parser.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index d1930adce68d..f95997a76738 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -129,6 +129,11 @@ int fs_parse(struct fs_context *fc,
 	case fs_param_is_string:
 		if (param->type != fs_value_is_string)
 			goto bad_value;
+		if ((p->flags & fs_param_neg_with_empty) &&
+		    (!result->has_value || !param->string[0])) {
+			result->negated = true;
+			goto okay;
+		}
 		if (!result->has_value) {
 			if (p->flags & fs_param_v_optional)
 				goto okay;

