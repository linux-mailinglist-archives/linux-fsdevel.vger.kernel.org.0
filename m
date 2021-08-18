Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835433F025A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhHRLMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 07:12:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhHRLMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:12:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9D05E20062
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629285109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qx5D4cC2d9fVaaV/ms1gqNVLOQq+z40P3w0wFU3wSQw=;
        b=gwZo+RKW2I0R3QuKnTXOUPhXBi3P/yW2SKtfn9le6mmYbhEt6P14vpOO/IMnIOegNgSi0e
        bDt7ao66Ed+6+46CLg1RRCT+7M1KhfvP0K5q6XWHLRAzBuoMynb+7H68ZKLbYFWRPleekA
        4hYYjvhlOqhcl1ltvC8ORm7Z7HRlV0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629285109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qx5D4cC2d9fVaaV/ms1gqNVLOQq+z40P3w0wFU3wSQw=;
        b=0VqzhnoQzdw5cVhR5Ez160CmZPtSOMsD7x1DqnreEbqQjjOQZ6/GGsClxc8D6JaAHgiEZs
        rprhj8lBrvPYcBBA==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7DBC8A3BA2;
        Wed, 18 Aug 2021 11:11:49 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] exfat: add keeptail mount option
Date:   Wed, 18 Aug 2021 13:11:22 +0200
Message-Id: <20210818111123.19818-2-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818111123.19818-1-ddiss@suse.de>
References: <20210818111123.19818-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The "keeptail" mount option will, in a subsequent commit, control
whether or not trailing periods '.' are stripped from path components.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/exfat/exfat_fs.h | 3 ++-
 fs/exfat/super.c    | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 1d6da61157c9..af33f867b34e 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -204,7 +204,8 @@ struct exfat_mount_options {
 	/* on error: continue, panic, remount-ro */
 	enum exfat_error_mode errors;
 	unsigned utf8:1, /* Use of UTF-8 character set */
-		 discard:1; /* Issue discard requests on deletions */
+		 discard:1, /* Issue discard requests on deletions */
+		 keeptail:1; /* Keep trailing periods in paths */
 	int time_offset; /* Offset of timestamps from UTC (in minutes) */
 };
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 5539ffc20d16..a55c810ffd90 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -173,6 +173,8 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",errors=remount-ro");
 	if (opts->discard)
 		seq_puts(m, ",discard");
+	if (opts->keeptail)
+		seq_puts(m, ",keeptail");
 	if (opts->time_offset)
 		seq_printf(m, ",time_offset=%d", opts->time_offset);
 	return 0;
@@ -216,6 +218,7 @@ enum {
 	Opt_charset,
 	Opt_errors,
 	Opt_discard,
+	Opt_keeptail,
 	Opt_time_offset,
 
 	/* Deprecated options */
@@ -242,6 +245,7 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_string("iocharset",		Opt_charset),
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
+	fsparam_flag("keeptail",		Opt_keeptail),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
 		  NULL),
@@ -296,6 +300,9 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_discard:
 		opts->discard = 1;
 		break;
+	case Opt_keeptail:
+		opts->keeptail = 1;
+		break;
 	case Opt_time_offset:
 		/*
 		 * Make the limit 24 just in case someone invents something
-- 
2.31.1

