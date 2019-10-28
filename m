Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66602E6F74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 10:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfJ1J7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 05:59:38 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:58310 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732833AbfJ1J7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:59:38 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 2EB892E14B4;
        Mon, 28 Oct 2019 12:59:36 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1MMz6MIGFv-xZl450v5;
        Mon, 28 Oct 2019 12:59:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572256776; bh=qKbZKUhxXAikWcE9+erLx+dDD7QZSmSl+7ceSjN66mg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=jUI0uMDZxH7owFu2UKMQ7KRNEqVM5Fbnu6SXj3wPdJctmvDEmSPHmXmo6rltQ5bhe
         694+7ixWanoElRRUS6lOxjlbB4kBGFgbbUylTyyYmSJ2L0Qk/29Wqo1A4QYeNHpyPk
         Zu7c2Lxu3D39+XN8kJyMx7YY88JeIlPMHJ3VhZak=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id brINrBKnHB-xZV0tdEe;
        Mon, 28 Oct 2019 12:59:35 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/filemap: do not allocate cache pages beyond end of file
 at read
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Mon, 28 Oct 2019 12:59:34 +0300
Message-ID: <157225677483.3442.4227193290486305330.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Page cache could contain pages beyond end of file during write or
if read races with truncate. But generic_file_buffered_read() always
allocates unneeded pages beyond eof if somebody reads here and one
extra page at the end if file size is page-aligned.

Function generic_file_buffered_read() calls page_cache_sync_readahead()
if page not found in cache and then do another lookup. Readahead checks
file size in __do_page_cache_readahead() before allocating pages.
After that generic_file_buffered_read() falls back to slow path and
allocates page for ->readpage() without checking file size.

This patch checks file size before allocating page for ->readpage().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/filemap.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 85b7d087eb45..92abf5f348a9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2225,6 +2225,10 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		goto out;
 
 no_cached_page:
+		/* Do not allocate cache pages beyond end of file. */
+		if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
+			goto out;
+
 		/*
 		 * Ok, it wasn't cached, so we need to create a new
 		 * page..

