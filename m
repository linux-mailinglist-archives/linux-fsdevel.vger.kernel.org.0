Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808111EFD27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFEQA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgFEQAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:00:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09346C08C5C5
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 09:00:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so5095398pfc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sFzuPg87lia15bj0MACfGhh8dROQtUU99JStdLteJm8=;
        b=N87sRbGURjNVH3cGexUjqOcgDYvYJMy8VoG9ckFH0aB1QHhjcmTB3IoUw+n7gla5Gl
         Nu4+9An1lTW5DFM57UkJtPrMYk4gc1B2g3ORLnaocIqUJYsZ+6I4d5lvKJr/btsT+ObU
         4d5/LypDNzjbQvWdIBOtLpeN/dS/2bG1Wvp5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sFzuPg87lia15bj0MACfGhh8dROQtUU99JStdLteJm8=;
        b=g5qI8cC6HKd+mK+n9yPrezUhQLuzTkXlWqoDYD0l/5G3FWeQVJ+JkZUVXM59yq11Be
         97YuP1t9B6w+Y34Y7chNDNyaWJBcca3/zAIzNlrfU4gjbYYx2Au00/YPY8OpzjO4/+iT
         v7/eDdlX7rJP+UP7D2e+KumP8r72aPo92FQFVdLg8aY/8cQCNxwxrHV2iSD3DgPF9Pnx
         WgAR1qD1ZnO923ZynFqkuVPZmLafZq8SnaGVymtXFFTBml0fUQrayMGpj8idnfKsZRYj
         oW/dU3Dwb0FodQfwjxwG8SmM0elHvrrmLJyro+BCXboqB3teI97niEyMcp8URm6zZeS+
         +FIA==
X-Gm-Message-State: AOAM531e5m8vVJ2F4vjPsRvD7Ysdu9w+vgSORZALi7YD3wqIHYPNCOaL
        4N2yyJBB19uOdOl5hszvDqocFQ==
X-Google-Smtp-Source: ABdhPJzZcH6mbwWsYQHLkHWiTXgnP9bVA4PXBKPDvl3u7f6oXPodSpEarfATZfskj2IlzdjeiODrfg==
X-Received: by 2002:a63:3384:: with SMTP id z126mr9940695pgz.7.1591372820569;
        Fri, 05 Jun 2020 09:00:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gm11sm8391860pjb.9.2020.06.05.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:00:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Relocate execve() sanity checks
Date:   Fri,  5 Jun 2020 09:00:10 -0700
Message-Id: <20200605160013.3954297-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

While looking at the code paths for the proposed O_MAYEXEC flag, I saw
some things that looked like they should be fixed up.

  exec: Change uselib(2) IS_SREG() failure to EACCES
	This just regularizes the return code on uselib(2).

  exec: Move S_ISREG() check earlier
	This moves the S_ISREG() check even earlier than it was already.

  exec: Move path_noexec() check earlier
	This adds the path_noexec() check to the same place as the
	S_ISREG() check.

v2:
- move checks into may_open() using acc_mode instead of f_mode to correctly
  compose with other inode file type tests[1].
- drop the FMODE_EXEC f_flags -> f_mode change for now since it remains
  unclear if it's useful (and is not needed any more for this series).
v1: https://lore.kernel.org/linux-api/20200518055457.12302-1-keescook@chromium.org/

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/202006041910.9EF0C602@keescook/

Kees Cook (3):
  exec: Change uselib(2) IS_SREG() failure to EACCES
  exec: Move S_ISREG() check earlier
  exec: Move path_noexec() check earlier

 fs/exec.c  | 23 ++++++++++++++---------
 fs/namei.c | 10 ++++++++--
 fs/open.c  |  6 ------
 3 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.25.1

