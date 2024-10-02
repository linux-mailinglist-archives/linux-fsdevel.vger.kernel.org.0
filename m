Return-Path: <linux-fsdevel+bounces-30663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78BD98D014
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 11:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636F62828A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD0F1990AA;
	Wed,  2 Oct 2024 09:25:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80BF19884A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861126; cv=none; b=R64xBSIpc5o40NGfwG9mnte2R1QM3Z6bG6ZyxfwgRDTn/VmU/yGv1Y0GcLEip5lLwN8udnJHTnUTjjUcHKMs7z1qWTOzaIqcs3SeaeYAuVVJ+NsQc6qWPzHsNMnsXeXC+yTwfM5OJMIDXol4y5nmKoVadvuxkMW9XKzD4qmDzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861126; c=relaxed/simple;
	bh=ooWI9Kow8SyrKEFCiL3cPo9bca2M49dCLq8dXZid/uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMVUo/f/SPv+yTxCFbTCM7vbqbv7HHMmOfU71u8jq8XDBTVXmalLMUUsgTKAJENftNoAeQ3BPyjnc2C4OjAu24+Ptrg98WR6sBVOvsi2VuuCT3eQPbfIJpYaJBF8tAZ4GptC1IjojzV3Kp6dZe5LAWgPoZyAl4Auh/j1AXuycCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=exkc.moe; spf=pass smtp.mailfrom=getgoogleoff.me; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=exkc.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getgoogleoff.me
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A9A5C23DF6;
	Wed,  2 Oct 2024 11:25:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLSUwjgbG1w9; Wed,  2 Oct 2024 11:25:21 +0200 (CEST)
From: exkc <exkc@exkc.moe>
To: exxxxkc@gmail.com
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] netfs: Fix the netfs_folio tracepoint to handle NULL mapping
Date: Wed,  2 Oct 2024 17:23:43 +0800
Message-ID: <20241002092343.823-1-exkc@exkc.moe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

Fix the netfs_folio tracepoint to handle folios that have a NULL mapping
pointer.  In such a case, just substitute a zero inode number.

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for buffered write")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/2917423.1727697556@warthog.procyon.org.uk
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/trace/events/netfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 76bd42a96815..1d7c52821e55 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -448,7 +448,8 @@ TRACE_EVENT(netfs_folio,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->ino = folio->mapping->host->i_ino;
+		    struct address_space *__m = READ_ONCE(folio->mapping);
+		    __entry->ino = __m ? __m->host->i_ino : 0;
 		    __entry->why = why;
 		    __entry->index = folio_index(folio);
 		    __entry->nr = folio_nr_pages(folio);
-- 
2.46.1


