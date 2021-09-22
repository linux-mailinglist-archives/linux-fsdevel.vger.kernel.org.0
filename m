Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC741482E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 13:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhIVLyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 07:54:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50814 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbhIVLyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:54:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4703E201F2;
        Wed, 22 Sep 2021 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632311556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3AbMJNGRU6lSznxVHegfwMKE7kiJfg2oVBk/ZzsA5Gs=;
        b=f23nWM+hudFLaiPRqpUnpnZrEzfes5dszcyej5czSQtN3C35wm2+YxoMO/EaTj5w+IaJj2
        k6eyydwHd+rVUKS9ZNIPRCe78KUqRq6JDmEevQu8dl+ygjO5whcmLJ/72H/OOs7JJBi3bS
        FHFPnHO8VkIt97VU07plnyR1KIkni6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632311556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3AbMJNGRU6lSznxVHegfwMKE7kiJfg2oVBk/ZzsA5Gs=;
        b=EiLio+LJZxglf/aul8uuj/w8HxGqVdjcvJ6agwNse6sQtDUOLMdWKAY9AoNldX0IKf/Olc
        MuUX6Zw9mdm2jzBw==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B236A3BAC;
        Wed, 22 Sep 2021 11:52:36 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH 4/5] initramfs: use do_utime() wrapper consistently
Date:   Wed, 22 Sep 2021 13:52:21 +0200
Message-Id: <20210922115222.8987-4-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922115222.8987-1-ddiss@suse.de>
References: <20210922115222.8987-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs_utimes() is called via the do_utime() wrapper everywhere except in
do_copy(). Make it consistent.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 19b1c70446fc..7f809a1c8e89 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -378,13 +378,9 @@ static int __init do_name(void)
 static int __init do_copy(void)
 {
 	if (byte_count >= body_len) {
-		struct timespec64 t[2] = { };
 		if (xwrite(wfile, victim, body_len, &wfile_pos) != body_len)
 			error("write error");
-
-		t[0].tv_sec = mtime;
-		t[1].tv_sec = mtime;
-		vfs_utimes(&wfile->f_path, t);
+		do_utime(collected, mtime);
 
 		fput(wfile);
 		eat(body_len);
-- 
2.31.1

