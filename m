Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903D420B426
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgFZPFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 11:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgFZPFE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:05:04 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED97206DD;
        Fri, 26 Jun 2020 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593183904;
        bh=wtJWXIFI9YRsJckO9IFMlSTewce+oi/0XdPmxJMz3lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ZfrkKAduxaUsGOg4uZ/AK6t3uheMX/O6rD7q96H1l5b6GJ1y4O0AoXCAVslTYQit
         un9wIxo3YKJgVNkUatIBVGWfDyZXBqA8kw8/NObb2Q12U2lORuJ5NWELQ4I0HmPxi+
         YltoJzPpeHP8oUFcnEwI6N0HyEwH3j53RmGbTf2I=
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, andres@anarazel.de
Subject: [fsinfo PATCH v2 3/3] samples: add error state information to test-fsinfo.c
Date:   Fri, 26 Jun 2020 11:05:00 -0400
Message-Id: <20200626150500.565417-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626150500.565417-1-jlayton@kernel.org>
References: <20200626150500.565417-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 samples/vfs/test-fsinfo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 26bf23121c9a..7f43320174d2 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -411,6 +411,15 @@ static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
 	printf("family=%u\n", ss->ss_family);
 }
 
+static void dump_fsinfo_generic_error_state(void *reply, unsigned int size)
+{
+	struct fsinfo_error_state *es = reply;
+
+	printf("\n");
+	printf("\tlatest error : %d (%s)\n", es->wb_error_last, strerror(es->wb_error_last));
+	printf("\tcookie       : 0x%x\n", es->wb_error_cookie);
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -499,6 +508,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
+	FSINFO_VSTRUCT  (FSINFO_ATTR_ERROR_STATE,       fsinfo_generic_error_state),
 	{}
 };
 
-- 
2.26.2

