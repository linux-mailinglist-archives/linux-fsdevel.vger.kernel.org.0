Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F4541EECD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353959AbhJANow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 09:44:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353532AbhJANou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:44:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8BF8E1FEDB;
        Fri,  1 Oct 2021 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633095785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=El2HKttjCWtLvnp+cn/O47fN/Ug0Z6IqYK1/bdRAPQ4=;
        b=wF0OZULxMEtHcGRnDyBj7E9PKMVRVuxoKibJldGDSEjYXu7lKYn5pPbIn5dhLLaNMurldq
        tY5ikXndTTSRsb5BNU2QvN6v5QMiGUdskvg7jdMoDz9F55S1qlNL5akiUN7A1pORs2/IZn
        IXJ/jZbRYNNVW9qBeZOuIqEnwDl9to4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633095785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=El2HKttjCWtLvnp+cn/O47fN/Ug0Z6IqYK1/bdRAPQ4=;
        b=URFcIEaRzEJdq6NrvGX2/ifVKNVliyQPJIv4t7YLigt6EKlhCvBoAc+XY7jckX+Ft4wwN9
        JOiyIrpEpXaXqrBg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 61C8FA3B89;
        Fri,  1 Oct 2021 13:43:05 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 2/5] initramfs: print helpful cpio error on "crc" magic
Date:   Fri,  1 Oct 2021 15:42:53 +0200
Message-Id: <20211001134256.5581-3-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001134256.5581-1-ddiss@suse.de>
References: <20211001134256.5581-1-ddiss@suse.de>
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
index 6897994c60fb..3bc90ab4e443 100644
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

