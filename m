Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD2044C16E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhKJMmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 07:42:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45622 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhKJMl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:41:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 080DA1FD6F;
        Wed, 10 Nov 2021 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636547949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abOVSwm/vn6oG+gcjWTT9ZXBilojJHifCE0JP3bySLo=;
        b=om2+LErieUPMBQ8xPkmUhUlYh7+1ZypVFjBhUpOA0sJv47RK4KWt5tMDqa6LiA0D+FT2MX
        YnI27n6rWu4pQ/+Ye9AvKY+rZuwnaqu2r1N5bdpBHeouU1PvP6F0QBhntryj7VO0B7J6fA
        dWBmTzZHRoTIr52o66xdanKcHwQHNXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636547949;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abOVSwm/vn6oG+gcjWTT9ZXBilojJHifCE0JP3bySLo=;
        b=LVeTNNRuQ+gTUPfi1EvI8YVv7W5oy2an7TqHM8r4cZupBl2Urj14SUdXB/mi1bL1h7C3g1
        CEQwllwymlyLrQCA==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CA848A3B88;
        Wed, 10 Nov 2021 12:39:08 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 2/4] initramfs: print helpful cpio error on "crc" magic
Date:   Wed, 10 Nov 2021 13:38:48 +0100
Message-Id: <20211110123850.24956-3-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110123850.24956-1-ddiss@suse.de>
References: <20211110123850.24956-1-ddiss@suse.de>
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
index 2f79b3ec0b40..44e692ae4646 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -258,7 +258,7 @@ static int __init do_collect(void)
 static int __init do_header(void)
 {
 	if (memcmp(collected, "070701", 6)) {
-		if (memcmp(collected, "070707", 6) == 0)
+		if (memcmp(collected, "0707", 4) == 0)
 			error("incorrect cpio method used: use -H newc option");
 		else
 			error("no cpio magic");
-- 
2.31.1

