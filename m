Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF809182D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfHRRAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44720 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfHRRAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:00:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so5703291pfc.11;
        Sun, 18 Aug 2019 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4vdpiujyv0Q54P4wr1NHiItOOVlay6nEIW3I5YYez1M=;
        b=qUD/uEQQpa5IDC7eb5nxpxQr/sWFHbFJfQN7K/crcrZ2iHsJ2DJgPtrQ5pL8lKjaOf
         GPYR11BRkK20l0XSflbKunmNOk0fMJ7hCwJC6eYGYAkss/I9A/UcV3qlTgLq3/imhpmS
         4G7Z3YROQt83sLgDymrw4DFNq66x9Xtp/fOBr1KyXz3k1xISoJfPY4oZ5fERJ7E5/V2D
         qnAml5iKJ7fgcKDv5ssM671Ay2p1kCPe/tD1qxfO5W0KY0PbG3iYrwMe5OrlWfGQy5cX
         cWVpHihyiDeAHupNdZksDWLzOzBNVj2M6kFBPl22MqGlI2K2pX0zrxeXijX5QNvQTcXx
         TiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4vdpiujyv0Q54P4wr1NHiItOOVlay6nEIW3I5YYez1M=;
        b=oHckccaQ5NS2PHwKc6DWmN2l1R64v2ZrUCNJ1m35JxntwaVJSyjEbx1dJTYajQumcQ
         Lt1s35Cau1BNb0Etm8oLdCR/HqC9aauLXm0GrmG+W9/3djbAvJn4DY0WPUtsE4Zj7rkQ
         X8jixuQhHj7tr+3pFjf1PsgvkREg17PADkmnM8+giu1PAek2ucTW2gtH9b2m9hWGyOuC
         4IG/gbrcpgz3i83gGB3I0c56iMd/Gu5GzgjXF0NBN5hO4mB2CFNQx3li8DcNRn3xK9mt
         92BO0l7Kzpk6BPUmWg37xOo/RUpVnPUCcjMHu6kUbt5nFppbIMgNNKYdBvq50V6OCcFd
         7IKg==
X-Gm-Message-State: APjAAAX6XTRC/1Xnqq2Dxoal0gpzF2fcwMJjNrTl34Goz552ytQfgI4z
        wOav5Q5ZMynELIAgUIAiAhlHgx5B
X-Google-Smtp-Source: APXvYqyr9mBtlQK7ACvNr+uLKfh0Jp10T6k1lmnDKUFzMFgoW8J/zrcMq8sDrz3A6P+Mu4s+wlJGRQ==
X-Received: by 2002:a63:8dc9:: with SMTP id z192mr16109414pgd.151.1566147602804;
        Sun, 18 Aug 2019 10:00:02 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.10.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 10:00:02 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, hubcap@omnibond.com, martin@omnibond.com,
        devel@lists.orangefs.org
Subject: [PATCH v8 16/20] fs: orangefs: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:13 -0700
Message-Id: <20190818165817.32634-17-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Assume the limits as unsigned according to the below
commit 98e8eef557a9 ("changed PVFS_time from int64_t to uint64_t")
in https://github.com/waltligon/orangefs

Author: Neill Miller <neillm@mcs.anl.gov>
Date:   Thu Sep 2 15:00:38 2004 +0000

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: hubcap@omnibond.com
Cc: martin@omnibond.com
Cc: devel@lists.orangefs.org
---
 fs/orangefs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 2811586fafc2..1ec08fe459cf 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -425,6 +425,8 @@ static int orangefs_fill_sb(struct super_block *sb,
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_time_min = 0;
+	sb->s_time_max = S64_MAX;
 
 	ret = super_setup_bdi(sb);
 	if (ret)
-- 
2.17.1

