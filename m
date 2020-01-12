Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AB0138868
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 23:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbgALWOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 17:14:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43745 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgALWOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 17:14:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so6720485wre.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2020 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pdsn7Z43myA4UM/waxQ04+O5Uff/PNpJ2sZTu/NBBhQ=;
        b=peitwbdH0PEzHXILp4o55vJNfIMewfas8TB78TKNQTzgDZd7vcGW5MbgYnJzdogAvx
         P7yH5akqY21dHfdmKZ7rgfxfZ/RZinG6VRJPZR0iPRNxyjTWMfQX8QsIiEilUKSD5O1T
         H8Rr3S6NDRcC5lUTVpxKUnUmJnG6i/K/bq4+u6sm3x6qYVeaZ+qiqKJSIBNPGvXJOcpl
         tipEJLPCIkLdOZbn880NPqEPx2wt/714ELtLQQJ0lVOvQ3xe3E0/tBMZBLtcnV48T/oL
         7L1Fjqji9lNKnlka2922pvst5javZR0MR6oWsnfAyyEPR8CGmmhtZlMIaFlKodV5S4ha
         eJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pdsn7Z43myA4UM/waxQ04+O5Uff/PNpJ2sZTu/NBBhQ=;
        b=ts4RoH7TBLM1n4zmssMHXj83IM1gzNX4mZn7BUN1sU6ox3n2qeSfa2VuyhyWSjZw2j
         kS8eXLhlYdLAiVcs///19b6X5fCbXMogezgFnCHyKqWl+5Zp44PtCVucM4bSX3EMVAOT
         p3BdBMxNS2zfJs92++topTMNN1CsFFtugy6Dh5w8V/1zaaYrkxUxx19o556wPmKQ/GY2
         0M3+ZDBy7F3p0OOTXhFV2F3xEhtoDaH0QKlrECXK/Tb97Z/YljMpm4BvWDK+3lvKKG3o
         d2V9Jl/zexVy3p4bVHjeu2eLq1B2s4wdW3xEy2qSXmsMJ1AsBPIDWEOzq7rBTsL7yG1u
         WOoA==
X-Gm-Message-State: APjAAAUvQqiyzM/icGdZxtZfAHX2D5I0kJY0vWtokQYrBqYQc4eOMNrc
        xn5PFchWyXY2Wo9iK3kgVQ0Ca5Rc
X-Google-Smtp-Source: APXvYqxP3zmyBU+A1ueBQwz6VBg4TQTNFFMb+7FI1T3HttRgBQK9kq/CsI8Jk8Edw48qSH+Qhnj0pg==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr14512633wro.56.1578867249429;
        Sun, 12 Jan 2020 14:14:09 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id d14sm12838967wru.9.2020.01.12.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 14:14:08 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH] udf: Fix meaning of ENTITYID_FLAGS_* macros to be really bitwise-or flags
Date:   Sun, 12 Jan 2020 23:13:53 +0100
Message-Id: <20200112221353.29711-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently ENTITYID_FLAGS_* macros definitions are written as hex numbers
but their meaning is not bitwise-or flags. But rather bit position. This is
unusual and could be misleading. So change meaning of ENTITYID_FLAGS_*
macros definitions to be really bitwise-or flags.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/udf/ecma_167.h | 4 ++--
 fs/udf/super.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index f9ee412fe..3fd85464a 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -95,8 +95,8 @@ struct regid {
 } __packed;
 
 /* Flags (ECMA 167r3 1/7.4.1) */
-#define ENTITYID_FLAGS_DIRTY		0x00
-#define ENTITYID_FLAGS_PROTECTED	0x01
+#define ENTITYID_FLAGS_DIRTY		0x01
+#define ENTITYID_FLAGS_PROTECTED	0x02
 
 /* Volume Structure Descriptor (ECMA 167r3 2/9.1) */
 #define VSD_STD_ID_LEN			5
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 0dad63f88..7e6ec9fa0 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -773,7 +773,7 @@ static int udf_verify_domain_identifier(struct super_block *sb,
 		udf_warn(sb, "Not OSTA UDF compliant %s descriptor.\n", dname);
 		goto force_ro;
 	}
-	if (ident->flags & (1 << ENTITYID_FLAGS_DIRTY)) {
+	if (ident->flags & ENTITYID_FLAGS_DIRTY) {
 		udf_warn(sb, "Possibly not OSTA UDF compliant %s descriptor.\n",
 			 dname);
 		goto force_ro;
-- 
2.20.1

