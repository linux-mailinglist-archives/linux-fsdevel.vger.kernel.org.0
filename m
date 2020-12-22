Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B0E2E0FA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 22:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgLVVEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 16:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgLVVEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 16:04:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C41CC0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 13:03:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m203so19369785ybf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 13:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WOgnDDLT8masgIUfxisc/Vz+fHTSbfB6Pago9KBBzf0=;
        b=YtjeHmzrVUTCg4xBTO9RPcviRfGJRfrfiG7zUoI5se6kc4+IWHD6GrZoGb3WHv891N
         wZtXFLGgbJJ8iixIf8pcZUjWqXAb9dZapJbKV3Ncpv39w2ZtgAgQ6B+Ii8NSdFIOrwtS
         3gt8ciHeP0tf684U2vn0KFiqMvPZ77FgPKrM1xAEKjK5hVO7HOTLwYpxpuLgP8+6bILf
         YJGU/88i5dnW2suVciusLv0Py33JBQ9QdoKpC4GW4aNh1jXo+pI0A6cxWYsz7wCrRbcx
         JaIJ0q6WJgSfWRc+vlNZU+rhYplcCYjKYSA0l4NbVdLzJVSElL4yc8hhtrsxzUpVgn0Q
         beYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WOgnDDLT8masgIUfxisc/Vz+fHTSbfB6Pago9KBBzf0=;
        b=HvpeYM+c3a7/ULtZhzMNtGAFNbMhQ6KXVecyXhr+HWcMzGoPJHRGjhL2PkrIRdSXyg
         v+mRja+qqh5/J3mp8p8xPFV8TSXgqREh+il3Y6YSnR39EScYDyxzZkjM0VXXbGUMOzeW
         gChQWomDU/3VICj0J23N0AhdIrEhgzz1Cj/Lq9jhZuNc9pab3O8DgtjC7OpF4OQjyzIv
         I5UDv9Q7AQXR1cxbapp/DpWDoQjFINcKm3IQugao7vg4qJULX5nSzThz8TvgSZT5rBZw
         BeESThuXa4kP4YSdS1tLQmVgujgmo1SMAuRcKdzEuTQUenGqV3Nm0+hQC2ESylwexFB0
         iU2w==
X-Gm-Message-State: AOAM530zyrnT0m98RPkbDv2hyYZ1BT+B703mlromaERDMFbpREv/AyEK
        iHy5LW0J+MymhK3h1BEc+/6dt9uR+QptTSqg+JQ=
X-Google-Smtp-Source: ABdhPJz/6MKJ+O7AFkhNqgqABLRBvALVn+siNQAH2UdqT4fRgX2mkVU08Sks9HdqeglOye1gVWupMTHDX2i4CUgaTUU=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:1843:: with SMTP id
 64mr31148965yby.80.1608671032651; Tue, 22 Dec 2020 13:03:52 -0800 (PST)
Date:   Tue, 22 Dec 2020 13:03:45 -0800
In-Reply-To: <55261f67-deb5-4089-5548-62bc091016ec@roeck-us.net>
Message-Id: <20201222210345.2275038-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <55261f67-deb5-4089-5548-62bc091016ec@roeck-us.net>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] fs: binfmt_em86: check return code of remove_arg_zero
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

remove_arg_zero is declared as __must_check. Looks like it can return
-EFAULT on failure.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 fs/binfmt_em86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_em86.c b/fs/binfmt_em86.c
index 06b9b9fddf70..6e98fcfca66e 100644
--- a/fs/binfmt_em86.c
+++ b/fs/binfmt_em86.c
@@ -63,7 +63,8 @@ static int load_em86(struct linux_binprm *bprm)
 	 * This is done in reverse order, because of how the
 	 * user environment and arguments are stored.
 	 */
-	remove_arg_zero(bprm);
+	retval = remove_arg_zero(bprm);
+	if (retval < 0) return retval;
 	retval = copy_string_kernel(bprm->filename, bprm);
 	if (retval < 0) return retval; 
 	bprm->argc++;
-- 
2.29.2.729.g45daf8777d-goog

