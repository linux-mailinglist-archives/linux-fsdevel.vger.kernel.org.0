Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A50F3D0E87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhGULXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 07:23:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50074 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbhGULMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:12:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A17E222F2;
        Wed, 21 Jul 2021 11:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626868321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tj4qVlT848dh2GVHxlkHECSQO4ZDIpukX6Dhb0UQq/0=;
        b=1s/WsA7dX1HTpSXQJb/GUX8ITgJXgpbp79RqzVL013AQEsfL/vZpxID7Avm0jMpa8CLPW+
        4pWp6M6RazCyew/fAW+D9KKEdFkXAWwt/7NPG2lHYtjBQBT9li9621smiVe7U8yCqaCiGk
        KvIiWEnBXJ56K5NjL3Y90FzcGJXMQgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626868321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tj4qVlT848dh2GVHxlkHECSQO4ZDIpukX6Dhb0UQq/0=;
        b=ZEn4gpetAi5JEit4ujrohyiDNF09NZ86w4Q9Y8fMMSzjolJOiw64Se5VkSTDXIoluVnOGM
        4d1hA+/qo5GMg3Bg==
Received: from echidna.suse.de (unknown [10.163.26.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1E73CA3B92;
        Wed, 21 Jul 2021 11:52:01 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH RESEND 2/3] initramfs: print helpful cpio error on "crc" magic
Date:   Wed, 21 Jul 2021 13:51:52 +0200
Message-Id: <20210721115153.28620-2-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210721115153.28620-1-ddiss@suse.de>
References: <20210721115153.28620-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Contrary to the buffer-format.rst documentation, initramfs cpio
extraction does not support "crc" archives, which carry "070702"
header magic. Make it a little clearer that "newc" (magic="070701") is
the only supported cpio format, by extending the POSIX.1 ASCII
(magic="070707") specific error message to also cover "crc" magic.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index f01590cefa2d..19b1c70446fc 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -257,7 +257,7 @@ static int __init do_collect(void)
 static int __init do_header(void)
 {
 	if (memcmp(collected, "070701", 6)) {
-		if (memcmp(collected, "070707", 6) == 0)
+		if (memcmp(collected, "0707", 4) == 0)
 			error("incorrect cpio method used: use -H newc option");
 		else
 			error("no cpio magic");
-- 
2.26.2

