Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1243CBE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhJ0OV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242508AbhJ0OVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EzpF32Y2Kh2ZzUQaOCru6WXIMfUYuG9RUH2BNfpH+Bk=;
        b=Go5yxzk6Dcqx5K7R7ihibRAKYJkR+mb1r9YeT40NasRivM3NRiBrRjNex/JAmFU8kiC7Ze
        tw6lLoVC3Jsvej6waoUfRn4kTS63aCWWNgTTG1Y7ut76q+o+kO/MOG+bJBE68D7yBPLA+L
        VUx46xxO0U6yiwBnGlpiVojiO5vT6Wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-VfUoCqaMPeKgvU2pJ1SJHg-1; Wed, 27 Oct 2021 10:19:18 -0400
X-MC-Unique: VfUoCqaMPeKgvU2pJ1SJHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3BC11005547;
        Wed, 27 Oct 2021 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFF595DF35;
        Wed, 27 Oct 2021 14:19:15 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 03/13] ext4: move option validation to a separate function
Date:   Wed, 27 Oct 2021 16:18:47 +0200
Message-Id: <20211027141857.33657-4-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move option validation out of parse_options() into a separate function
ext4_validate_options().

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ext4/super.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 42f4a3741692..5f6ad0615a2a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -87,6 +87,7 @@ static void ext4_unregister_li_request(struct super_block *sb);
 static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					    unsigned int journal_inum);
+static int ext4_validate_options(struct super_block *sb);
 
 /*
  * Lock ordering
@@ -2575,10 +2576,9 @@ static int parse_options(char *options, struct super_block *sb,
 			 struct ext4_parsed_options *ret_opts,
 			 int is_remount)
 {
-	struct ext4_sb_info __maybe_unused *sbi = EXT4_SB(sb);
-	char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
 	substring_t args[MAX_OPT_ARGS];
 	int token;
+	char *p;
 
 	if (!options)
 		return 1;
@@ -2596,7 +2596,14 @@ static int parse_options(char *options, struct super_block *sb,
 				     is_remount) < 0)
 			return 0;
 	}
+	return ext4_validate_options(sb);
+}
+
+static int ext4_validate_options(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 #ifdef CONFIG_QUOTA
+	char *usr_qf_name, *grp_qf_name;
 	/*
 	 * We do the test below only for project quotas. 'usrquota' and
 	 * 'grpquota' mount options are allowed even without quota feature
-- 
2.31.1

