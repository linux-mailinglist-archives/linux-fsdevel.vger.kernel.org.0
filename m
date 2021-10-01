Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABB41EED0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354074AbhJANoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 09:44:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhJANov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:44:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ED1EA20455;
        Fri,  1 Oct 2021 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633095785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYp6TwJjdmzsZNB4jWXeXSfWsLGtToNBVd9s4mjV1PU=;
        b=pBchRnciQ1ut93uRH15/VxSPV1WZTDKAVDSUBIPO7W5BnXfpuB+HOE+4FK5ksKE4c5Yl0U
        xOhQglp55fqJOmmR6npdJ273eHjS0qfedvwkxYm5HIcAmBblaqL+NCzZexgrodOtEpx2ks
        4rBg3IIYCLlBzbGiveMW3ImgvAgisk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633095785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYp6TwJjdmzsZNB4jWXeXSfWsLGtToNBVd9s4mjV1PU=;
        b=mdRvbzjef+U3ZZQH2og+ac06Kuqmhv2lncOX8AKCnzTANCaYztl4iDjP1VvPIvnIHzt404
        UxDbHv8c9VjUNWBg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C3DBBA3B8B;
        Fri,  1 Oct 2021 13:43:05 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 4/5] initramfs: use do_utime() wrapper consistently
Date:   Fri,  1 Oct 2021 15:42:55 +0200
Message-Id: <20211001134256.5581-5-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001134256.5581-1-ddiss@suse.de>
References: <20211001134256.5581-1-ddiss@suse.de>
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
index 3bc90ab4e443..c64f819ed120 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -379,13 +379,9 @@ static int __init do_name(void)
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

