Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E49AD6B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 12:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390580AbfIIKXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 06:23:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40249 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390549AbfIIKXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id t9so13972408wmi.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7Bzmc8unRj2o3NCWa0+dcZGFlGvmP3kCEEVnSXhkOA=;
        b=eJ1w8LF2MYSOvsRCvj7XcfJA5lhEO87R1bLBeu65GW2j/DGqZqPprE6kQ/hoghBzbS
         w6IdbZv33BK7k8oJg6WhQJ6q45RWIDsL9J4I4lmQeSytRwscjSdlC1vPe0up/jQedywO
         ozLkAMFRLRFb272kZZBTRLL+klZgN6S6NvqmWL2zm4s8aU7nI6u7NRc01CFL+L4mhfAq
         13ec60iL8+uugHfNqWE9jgWn4GLDuRC4ysdNh03NZwYyadGN2ZTHGbRzb+wzh1HI8hEf
         RWxOlKkMMFrrMbl/ZDjywr90FbmUdRl8ZatAWFuhFYCT3A9SCDF+Qy7Us1qtVzMPfVr+
         5ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7Bzmc8unRj2o3NCWa0+dcZGFlGvmP3kCEEVnSXhkOA=;
        b=UX/tnYzU1Vnu4Z2OSFl+kbIeR9WjpYxCCM4ndBa/i8xusgqKKe7Qv1DDg/OjHDQswb
         fztY+gKwXHo3cRgu4TfHkNbyr5OSwhHMi8BArVx7loyf1YOcph4GXEKhVfrAu90Uxy/4
         zihutm1MFp3WOFy2rGs+4bmc1PyN0gnMnWMnylFCGXbT5Mu6hpr08v9Z1xBCWFele1nh
         qGdO4qdEGDUU6FmEhxuH7XjSjYSeUooprD+DWmIMqm0L6QPb6Mrd0092/uSp+vHm+qq1
         N/7/I2/QehWhYl1SXV5tVhDpU+S8/scHuATvdXppczz0s3DuDBKkxd8I7rcNr8vmkqEw
         45GQ==
X-Gm-Message-State: APjAAAXtyl01maLm6d8PP5yFddWOvqr9oDP3On2/h6+wY9Ymrq0fleUu
        bk6NqHn5+rFA4/NlvCteozyzLA==
X-Google-Smtp-Source: APXvYqzmxzn7Fo/gtLbCgxCJksmoaFbMVNn7wj0/OSQx0ISZVsTWLDyDCK67zQsOMozuUO5BCkL7Zg==
X-Received: by 2002:a1c:1acc:: with SMTP id a195mr18081713wma.106.1568024624900;
        Mon, 09 Sep 2019 03:23:44 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:44 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] futex: Remove unused uaddr2 in restart_block
Date:   Mon,  9 Sep 2019 11:23:32 +0100
Message-Id: <20190909102340.8592-2-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not used since introduction in commit 52400ba94675 ("futex: add
requeue_pi functionality").
The result union stays the same size, so nothing saved in task_struct,
but still one __user pointer less to keep.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/restart_block.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index bba2920e9c05..e5078cae5567 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -32,7 +32,6 @@ struct restart_block {
 			u32 flags;
 			u32 bitset;
 			u64 time;
-			u32 __user *uaddr2;
 		} futex;
 		/* For nanosleep */
 		struct {
-- 
2.23.0

