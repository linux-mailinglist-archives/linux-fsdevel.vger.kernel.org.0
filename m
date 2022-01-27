Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048C349E718
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiA0QJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 11:09:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49850 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiA0QJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:09:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4F8CB8018A;
        Thu, 27 Jan 2022 16:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C98C340E4;
        Thu, 27 Jan 2022 16:08:58 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 5/6] NFSD: Remove NFS_OFFSET_MAX
Date:   Thu, 27 Jan 2022 11:08:57 -0500
Message-Id:  <164329973737.5879.52128759560418285.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
References:  <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; h=from:subject:message-id; bh=sFAQLFzvhA4p13xvl949Xf12gutHKeO97iVOSPTRk6k=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh8sOZl+LQLRwYtMep9u8pEj019hCcDoSoH+h9hNYw cP8j5uuJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYfLDmQAKCRAzarMzb2Z/lyZ9D/ 9m5aUTsz7/N5QZT5E7PUM1SA/4w9+kG+gCiOehdWshrDOTeMW5Px+tqxj94Z/h0PJjOrUtvqVY0v3R hDyvV8EkHs3OOEhHptsWwUF15UNctW+w6H/Bt+JrIjsw5UbCr4t8KfsO4BeIAYLaGB4XTor4NtZErW 5dKBi9CAXwFhAtvVzwmF3SbZfabxHkeeL+XG0JJP4/p4QUCBKOe89VWDnpT4w8PkpRPs7wqrI1xtaS yN38oT2lWj6cPaiOEedbBqW8KorbRqVBHAJynhQ5nuQKJ4Vb6wIiAFJU1tINuojfBoZZuwcza9dadq nyQuT84LaSbIFVXBgdFU+xrjf1ZLHSerF9/1R71+A5Yv4LJJ/h0CMatmX8KL8SboXBCXYasvqps70H TTBNRAk5hyCu79qhh7C43HI5caO7M4NiIPLnutLx8NuEwLRT81Ov+fmIjlUMQTGC1YzHD83HkPZpOC PnhRaCAEBwon6+OXiCKNpN8GpDnASMNDT6QjIJUTDz/WjF6vLDA+Op05zpAhnEPfKMNJkGGrr0sgMo 8UGowFS/asje0SrWwvkXoUxpnLvXoUf0swh97TIF/3/zGGOmRZQo+l1kuOOcr4DTRRARmKbbgcBfTo 16ChJylvMSAxyJ4sY7RJJjA2fwONl0xVeoCgt4UhOyjGC12IY0iY9O7V9wHw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This constant was introduced way back in Linux v2.3.y before there
was a kernel-wide OFFSET_MAX value. These days we prefer to check
against the limits in the underlying filesystem instead.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/nfs.h |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index 0dc7ad38a0da..b06375e88e58 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -36,14 +36,6 @@ static inline void nfs_copy_fh(struct nfs_fh *target, const struct nfs_fh *sourc
 	memcpy(target->data, source->data, source->size);
 }
 
-
-/*
- * This is really a general kernel constant, but since nothing like
- * this is defined in the kernel headers, I have to do it here.
- */
-#define NFS_OFFSET_MAX		((__s64)((~(__u64)0) >> 1))
-
-
 enum nfs3_stable_how {
 	NFS_UNSTABLE = 0,
 	NFS_DATA_SYNC = 1,

