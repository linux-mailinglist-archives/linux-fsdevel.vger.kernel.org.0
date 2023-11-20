Return-Path: <linux-fsdevel+bounces-3259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F83E7F1D14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD331C21908
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2845D328DB;
	Mon, 20 Nov 2023 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCEoO5FJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254569C;
	Mon, 20 Nov 2023 11:05:36 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c34e87b571so3767335b3a.3;
        Mon, 20 Nov 2023 11:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700507135; x=1701111935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhpwrRa9HQ3nKZT6vnn9bXvfK7gw9DLuWfU1NPaPpJM=;
        b=BCEoO5FJl/T83w6LVqG6ZzoC6TPpxh3WbeWmRniERr+eQPDSwh6rjCwIeX+sUzTDfy
         dkWh4w0L831zdICI860ToPhJwyDOtdD8fUlhoNbgtl1/rLU7G+7iExVwh8kWEIfDwvYx
         2bWaG5kMdRAbu3YclKdG/yFkmCIT6qzqM1krU1xaMsMpzsEUgYSC0gQpqa+jiXCgoweX
         bKDpc11xeYyanb9gx5NSqgnTwPp0ZHWGzZR/el17EEIqkxFFnWaZbX7TR6RrzDPXexEd
         jy5VBNM367RHZ7ewaZV6/JjZ+dPTCK+4LkY1vu53cBdip4idWFlorStUWVEmaH1liLPa
         a7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507135; x=1701111935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhpwrRa9HQ3nKZT6vnn9bXvfK7gw9DLuWfU1NPaPpJM=;
        b=E14aZPudWo1XMtQTR+FSG3JwE6fRL3cLhYJ9WNyJsBU7KYzjn59ucTRnMTMmBC2LoI
         lwpuMmGb0RHzqHrc6vzUQZ5umt/s7e6rNJFPPuEodL1JxtpcGkri1FEa34IoITB5Bcjk
         I6UGkIn9RC0qwejbm1i5Al2GsjTs61FJrbKeivNKC3+4JMQfc2mcUfzBL9y4qPhSk3CH
         bIreDgC5y79nObnahlUFTTu9CzsiAcSzEGl4Xbrz8QrCfU4H5WJYVz2ulY+Y6+AgXBLv
         J4L9dC8HKUhyCfuI0g7ERxOvxcxha5VGVK51OHK248aXtPpETrqk21sPNC4clyaSyUsP
         +Ckw==
X-Gm-Message-State: AOJu0YxQIa+c+eLCvrp2/4Zrl00O+ZjEDq/pvEXwLdehVU1xCr6LOQ4d
	YctK377vej+RUh4OnbJq8seAltv54Tg=
X-Google-Smtp-Source: AGHT+IF8BcJfvClUGoapPelDJvI5Qfjc/yULJcELd4rmgJwN1UAC8Paqph6Zma74j/8Q+RZzVrDf8g==
X-Received: by 2002:a05:6a20:9190:b0:186:c0fe:b842 with SMTP id v16-20020a056a20919000b00186c0feb842mr6854760pzd.2.1700507135067;
        Mon, 20 Nov 2023 11:05:35 -0800 (PST)
Received: from dw-tp.localdomain ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id y10-20020a62f24a000000b006c69851c7c9sm6353699pfl.181.2023.11.20.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:05:34 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 3/3] ext2: Enable large folio support
Date: Tue, 21 Nov 2023 00:35:21 +0530
Message-ID: <3dd8b8bce2c29d5e87bbdc9e37fa11ba80f184b9.1700506526.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700506526.git.ritesh.list@gmail.com>
References: <cover.1700506526.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that ext2 regular file buffered-io path is converted to use iomap,
we can also enable large folio support for ext2.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext2/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index b6224d94a7dd..ad04da5ed6bd 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1425,10 +1425,12 @@ void ext2_set_file_ops(struct inode *inode)
 {
 	inode->i_op = &ext2_file_inode_operations;
 	inode->i_fop = &ext2_file_operations;
-	if (IS_DAX(inode))
+	if (IS_DAX(inode)) {
 		inode->i_mapping->a_ops = &ext2_dax_aops;
-	else
+	} else {
 		inode->i_mapping->a_ops = &ext2_file_aops;
+		mapping_set_large_folios(inode->i_mapping);
+	}
 }
 
 struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
-- 
2.41.0


