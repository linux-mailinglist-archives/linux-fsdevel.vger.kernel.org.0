Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE07025476D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgH0OuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728083AbgH0NlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598535668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6x4893U1XZUaKie9nG5yKGJyij3esKFZmrFVgshH0M=;
        b=UHLvCGDeP/VTyc/asAUOUnC26BPtghXUJlc7IWc11ktajZsIk3/5xnJR5xQc8xjtqRwWVA
        tDevr2+NGItnFAqdiFCNgAVFWiRkWyvowvo6snWZGhfUfZGsoRpe04uytaYJunjaEhOH9I
        +wwS7YRWVHaFL/SpnOvF57QrOzNhSM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-1uL7r7AxPuWd6lzDfgbeMg-1; Thu, 27 Aug 2020 09:41:04 -0400
X-MC-Unique: 1uL7r7AxPuWd6lzDfgbeMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED5DD18A2240;
        Thu, 27 Aug 2020 13:40:58 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-96.ams2.redhat.com [10.36.113.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD72C7C55A;
        Thu, 27 Aug 2020 13:40:53 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aleksa Sarai <asarai@suse.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH v5 1/3] io_uring: use an enumeration for io_uring_register(2) opcodes
Date:   Thu, 27 Aug 2020 15:40:42 +0200
Message-Id: <20200827134044.82821-2-sgarzare@redhat.com>
In-Reply-To: <20200827134044.82821-1-sgarzare@redhat.com>
References: <20200827134044.82821-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The enumeration allows us to keep track of the last
io_uring_register(2) opcode available.

Behaviour and opcodes names don't change.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5:
 - explicitly assign enum values since this is UAPI [Kees]
---
 include/uapi/linux/io_uring.h | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index d65fde732518..5f12ae6a415c 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -255,17 +255,22 @@ struct io_uring_params {
 /*
  * io_uring_register(2) opcodes and arguments
  */
-#define IORING_REGISTER_BUFFERS		0
-#define IORING_UNREGISTER_BUFFERS	1
-#define IORING_REGISTER_FILES		2
-#define IORING_UNREGISTER_FILES		3
-#define IORING_REGISTER_EVENTFD		4
-#define IORING_UNREGISTER_EVENTFD	5
-#define IORING_REGISTER_FILES_UPDATE	6
-#define IORING_REGISTER_EVENTFD_ASYNC	7
-#define IORING_REGISTER_PROBE		8
-#define IORING_REGISTER_PERSONALITY	9
-#define IORING_UNREGISTER_PERSONALITY	10
+enum {
+	IORING_REGISTER_BUFFERS			= 0,
+	IORING_UNREGISTER_BUFFERS		= 1,
+	IORING_REGISTER_FILES			= 2,
+	IORING_UNREGISTER_FILES			= 3,
+	IORING_REGISTER_EVENTFD			= 4,
+	IORING_UNREGISTER_EVENTFD		= 5,
+	IORING_REGISTER_FILES_UPDATE		= 6,
+	IORING_REGISTER_EVENTFD_ASYNC		= 7,
+	IORING_REGISTER_PROBE			= 8,
+	IORING_REGISTER_PERSONALITY		= 9,
+	IORING_UNREGISTER_PERSONALITY		= 10,
+
+	/* this goes last */
+	IORING_REGISTER_LAST
+};
 
 struct io_uring_files_update {
 	__u32 offset;
-- 
2.26.2

