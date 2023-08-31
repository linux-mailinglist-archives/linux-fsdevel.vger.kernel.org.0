Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6878F42B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 22:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347419AbjHaUhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 16:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjHaUhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:37:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74CDE67
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 13:37:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so1013165276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693514235; x=1694119035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Riep5pyahAnxXOHIAicjRGy5HGdPOIzlJBXzr6RzmUM=;
        b=d/tC/9gCiFcMnNxE3maBKwVuY5qvIt6zYsH3KEo7xLnXPE65YE0sNlyQLdm5zpja53
         ci5w6djzFf7cPny4E3Jt7x85cP5duyK8doqAsAr3hxJ+gERTU7tTO1nBpxnmjfG5v6Gh
         IqO36G4YiCXcHnfLSA7KbuiVGkrWny3b6QNIud109AeL+ShJBP9+wktprm1V8UXg7Lfl
         OUesBf2RLh7dqJq8zAFIAHVFt2791297eamndqeiX3iGzevcXXehdBfadl4DADJLUMRB
         /+ABw/o933QtEpbByEgABP4hfm2J03cRUAp6GjQ37iwpmf3fUf3z12sjdjC8W4GUosa4
         1kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693514235; x=1694119035;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Riep5pyahAnxXOHIAicjRGy5HGdPOIzlJBXzr6RzmUM=;
        b=R4Hb2BGUCaWPjxqUV7wqp3uVN85u+O1wPTTAb7qHue7a7U84kHcnJaIL9QQg56uNRc
         fEowjm51wkqvgIsvKXUYVnuOyFKHSU8MIb+9+f9vazwpixsDrSCX5Xgi/0FRBUG9vgDd
         7MGsiOJ5EUg3tA6j3H1CDB0Oqx0Be190Kbfaa/d4409DGPID/36sRgrC9R2qMiqcxBGE
         in7jb/VmseUyHLF6q+yBhUjffTc9ZPmmE/5GjJQSHVWqrRpfsoXQYYh/Q96xeZsImM7/
         O2QtJ9DSM6WS7wEd0OXKsH+0S+rlHqFmA2QYNUUnl+E7C2F7BR7DL0+1JyeaURbEOyhF
         1lsQ==
X-Gm-Message-State: AOJu0Yypwn5l+xZwOfWo87qTy60g8VPtMkklmlUByWaPjFF59SEVXFXO
        RNN2krfV5QHUPM+23u+IAQ/dCfcg4LPjkrgF
X-Google-Smtp-Source: AGHT+IFcu8cOp7pIa9OilL6fag67y6JJgGLJBhTT1SQk4UIAxSrG1Tx5R8I4WGtPGGNkLdRhCeCUlRFRF/gQcWz4
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:36f8:f0a:6df2:a7d5])
 (user=mclapinski job=sendgmr) by 2002:a25:9f89:0:b0:d4f:d7a5:ba3b with SMTP
 id u9-20020a259f89000000b00d4fd7a5ba3bmr21259ybq.8.1693514235020; Thu, 31 Aug
 2023 13:37:15 -0700 (PDT)
Date:   Thu, 31 Aug 2023 22:36:45 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831203647.558079-1-mclapinski@google.com>
Subject: [PATCH 0/2] fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
From:   Michal Clapinski <mclapinski@google.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This change introduces a new fcntl to check if an fd points to a memfd's
original open fd (the one created by memfd_create).

We encountered an issue with migrating memfds in CRIU (checkpoint
restore in userspace - it migrates running processes between
machines). Imagine a scenario:
1. Create a memfd. By default it's open with O_RDWR and yet one can
exec() to it (unlike with regular files, where one would get ETXTBSY).
2. Reopen that memfd with O_RDWR via /proc/self/fd/<fd>.

Now those 2 fds are indistinguishable from userspace. You can't exec()
to either of them (since the reopen incremented inode->i_writecount)
and their /proc/self/fdinfo/ are exactly the same. Unfortunately they
are not the same. If you close the second one, the first one becomes
exec()able again. If you close the first one, the other doesn't become
exec()able. Therefore during migration it does matter which is recreated
first and which is reopened but there is no way for CRIU to tell which
was first.

Michal Clapinski (2):
  fcntl: add fcntl(F_CHECK_ORIGINAL_MEMFD)
  selftests: test fcntl(F_CHECK_ORIGINAL_MEMFD)

 fs/fcntl.c                                 |  3 ++
 include/uapi/linux/fcntl.h                 |  9 ++++++
 tools/testing/selftests/memfd/memfd_test.c | 32 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)

-- 
2.42.0.283.g2d96d420d3-goog

