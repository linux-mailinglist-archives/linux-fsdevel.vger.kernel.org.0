Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F38429ADEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbgJ0NvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 09:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752844AbgJ0NvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603806666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WwHqBrIiBjdf25gGnD1YX594H4Kf+w9kJfjTvFy9bM0=;
        b=UGNh5LuhIwj2lxXrjAHX5dRCUOgqtJAT+OX2qGxcMgTVFaDpROrsv4NpwpaQP3vyo3mNEf
        y8cyXsB/SaLZ79PkRP8X0csXAmz5u7OtG/c8L/oYxQzrOVWUHMCJUn4VxuQxEZ0+1ioZ9c
        rPBW473tZd56kx+5NJvA6oHPlvedtnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-LvrG_EvTOzG34sLbFgXHZg-1; Tue, 27 Oct 2020 09:51:04 -0400
X-MC-Unique: LvrG_EvTOzG34sLbFgXHZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02CF3ADC28;
        Tue, 27 Oct 2020 13:51:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 412255C1BB;
        Tue, 27 Oct 2020 13:51:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/10] afs: Alter dirty range encoding in page->private
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Oct 2020 13:51:01 +0000
Message-ID: <160380666151.3467511.11680534843519213308.stgit@warthog.procyon.org.uk>
In-Reply-To: <160380659566.3467511.15495463187114465303.stgit@warthog.procyon.org.uk>
References: <160380659566.3467511.15495463187114465303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, page->private on an afs page is used to store the range of
dirtied data within the page, where the range includes the lower bound, but
excludes the upper bound (e.g. 0-1 is a range covering a single byte).

This, however, requires a superfluous bit for the last-byte bound so that
on a 4KiB page, it can say 0-4096 to indicate the whole page, the idea
being that having both numbers the same would indicate an empty range.
This is unnecessary as the PG_private bit is clear if it's an empty range
(as is PG_dirty).

Alter the way the dirty range is encoded in page->private such that the
upper bound is reduced by 1 (e.g. 0-0 is then specified the same single
byte range mentioned above).

Applying this to both bounds frees up two bits, one of which can be used in
a future commit.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index acefa6bf0a4d..0ff1088a7c87 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -878,12 +878,12 @@ static inline unsigned int afs_page_dirty_from(unsigned long priv)
 
 static inline unsigned int afs_page_dirty_to(unsigned long priv)
 {
-	return (priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK;
+	return ((priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK) + 1;
 }
 
 static inline unsigned long afs_page_dirty(unsigned int from, unsigned int to)
 {
-	return ((unsigned long)to << __AFS_PAGE_PRIV_SHIFT) | from;
+	return ((unsigned long)(to - 1) << __AFS_PAGE_PRIV_SHIFT) | from;
 }
 
 #include <trace/events/afs.h>


