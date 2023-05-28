Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738B9713765
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 03:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjE1BZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 May 2023 21:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1BZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 May 2023 21:25:46 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5EDD8;
        Sat, 27 May 2023 18:25:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53f158ecfe1so1302394a12.0;
        Sat, 27 May 2023 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685237144; x=1687829144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b44Rf60oUaAcGpO0dqWTBH48dBelIzQdyh7QejEWNW4=;
        b=kfln9wFDTku231dnl5jv9gXmGxBLGm+GeLHXFO5shj4wLFIQRB6HTAdTIm+c/wYKQr
         ZMLsXHI/iwoAF4F5Q3Ng906IsSifrgE87Ki68CLmCGSYQ6so66zVJ5iVkJiy1AUR06ul
         vwy68VfOB3iQs0OIYV/XTEr0a/F1Uv1RuCJzHdZUJjdLfZp+FhlWpHVrvrtvd7R/RQog
         ekfPe7XAQeqFH/8KhvUnMpGZfhDWU8bhslgo80l3ZbiYnZK5M0ziWB+rBq476IrTzwli
         M3PCQQu4xZ4lB8Mih9jznWZxSLnjMrVB/cwN61XHk+N3KZSpL3lhPikqjBG8icmW4cgv
         xwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685237144; x=1687829144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b44Rf60oUaAcGpO0dqWTBH48dBelIzQdyh7QejEWNW4=;
        b=iPkoumwHoV9K0dM5OD0wr5bUM2nfpxY9hU0LyGhS6dqNK6KdQPfS0Li1vD8E2Wi+gL
         ZvFdDr+inw9rugMsbFm3m+brCcQKrIDXWlxvHMGgNh6A2wRRULs1AwKucchXcKzqWoFu
         yET8UnQfn5N+SVr5QZXrTAMa+Tlob4/z9dqkLJihnPPOkxqJgCjCosYN66aGBXVtRGxh
         kFhxn/VEw+m3F8MH35RzqlNNbPftmSI5y4Yix+02e0Kqzod2MiDdZtuf6jvIriGf9SFf
         8YOGGGUOcOqFajlIYnPX48gekOJblOuCvcBtAg4YGoMI1fX05utrQ2+Kui6pRSm52sgo
         eWgw==
X-Gm-Message-State: AC+VfDz0svK84R1Dwo4Lpxiq7gHODMPRh+MZP7DCl+QarZtwKanzBiFN
        h2j11JY+hHuGMc87hcJmySsuOw8hNLWe3g==
X-Google-Smtp-Source: ACHHUZ6JuxPtigaUbnEpUtjjk1rUCSKj5kJKVbQCnvdh3E/PCl0hVDi9NO5g++x4rI44sENmtS9huw==
X-Received: by 2002:a05:6a20:100a:b0:10d:8f40:6469 with SMTP id gs10-20020a056a20100a00b0010d8f406469mr4147880pzc.48.1685237143737;
        Sat, 27 May 2023 18:25:43 -0700 (PDT)
Received: from fedora.hsd1.wa.comcast.net ([2601:602:9300:2710::f1c9])
        by smtp.gmail.com with ESMTPSA id m21-20020a638c15000000b0053449457a25sm4752313pgd.88.2023.05.27.18.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 18:25:43 -0700 (PDT)
From:   Prince Kumar Maurya <princekumarmaurya06@gmail.com>
To:     skhan@linuxfoundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chenzhongjin@huawei.com
Cc:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Null check to prevent null-ptr-deref bug
Date:   Sat, 27 May 2023 18:25:16 -0700
Message-Id: <20230528012516.427126-1-princekumarmaurya06@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <000000000000cafb9305fc4fe588@google.com>
References: <000000000000cafb9305fc4fe588@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on that leads to the null-ptr-deref bug.

Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
---
 fs/sysv/itree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index b22764fe669c..3a6b66e719fd 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -145,6 +145,8 @@ static int alloc_branch(struct inode *inode,
 		 */
 		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh)
+			break;
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
-- 
2.40.1

