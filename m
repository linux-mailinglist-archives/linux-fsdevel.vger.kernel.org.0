Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE5741482A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 13:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhIVLyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 07:54:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbhIVLyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:54:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B83C7201F1;
        Wed, 22 Sep 2021 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632311551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DP5zK5YwcP7TB/exrav4rcNsozXcCy88E5d7YWBggkk=;
        b=HXVYLWPGxdsirynRjkiCZO16VCPID+XKB911GL+wfU4b06jxWUqsdJVJ10ih/aE8keFBeG
        ZUNX9SaAawD3pCF8tQZn6EQCbFosAB66oOZ3kQIGOinICIUau01l/2AImJM+FfYa93pDAU
        wMUFMP5BKOAQExEaeVY6y5ZSYATpdvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632311551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DP5zK5YwcP7TB/exrav4rcNsozXcCy88E5d7YWBggkk=;
        b=XEue/039zqGRlROwsiwXnSf2f/EDfBzTz+IFo0mcGIXhmNf3MjX/Ep625/AXcPsRCKHspk
        IKiJByrZNfxShaCw==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D2B8A3B8E;
        Wed, 22 Sep 2021 11:52:31 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/5] initramfs: print helpful cpio error on "crc" magic
Date:   Wed, 22 Sep 2021 13:52:19 +0200
Message-Id: <20210922115222.8987-2-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922115222.8987-1-ddiss@suse.de>
References: <20210922115222.8987-1-ddiss@suse.de>
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
2.31.1

