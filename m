Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D658C185777
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 02:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCOBjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 21:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgCOBjM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:39:12 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A39620792;
        Sat, 14 Mar 2020 20:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584219194;
        bh=BekzoYGRaAG7hdnMIHYnXydLgmN0afGG/lRCyAbxsow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxtA5FndvEQrWYJ1lLT38U6RoCkJTTKARYiBRkYMxyhpzJqs9rlw1ebJKhqeONoVc
         PrGI+9cNJaMxe/l32l3G3sElzfnTGKgS9d3i70orWJl/g5fzCmYnfWgQhCRW8GsDd3
         AUxOd5Pk7uahYWHoTpKyZYZRStA9y4nu6SuMdczo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH 4/4] ubifs: wire up FS_IOC_GET_ENCRYPTION_NONCE
Date:   Sat, 14 Mar 2020 13:50:52 -0700
Message-Id: <20200314205052.93294-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200314205052.93294-1-ebiggers@kernel.org>
References: <20200314205052.93294-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This new ioctl retrieves a file's encryption nonce, which is useful for
testing.  See the corresponding fs/crypto/ patch for more details.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index d49fc04f2d7d4..3df9be2c684c3 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -208,6 +208,9 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
 		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
 
+	case FS_IOC_GET_ENCRYPTION_NONCE:
+		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -230,6 +233,7 @@ long ubifs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_REMOVE_ENCRYPTION_KEY:
 	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
 	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
+	case FS_IOC_GET_ENCRYPTION_NONCE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.25.1

