Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02514A649D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 20:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbiBATHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 14:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbiBATHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:07:03 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7BEC06173D
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Feb 2022 11:07:03 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a19so10742000pfx.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Feb 2022 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWJtc/jz3NoYF9uCthXFk67SqjsIB7RJSbGEFvTN/iM=;
        b=iSJDkJ5OdDeFbxyOzdLekrR3/0rd6TUS2SxZz0WxjzfyJ94UgxhHoPvQJpGVCTtcdH
         s4biQFpPJRStBBHkAjwh/5vF6XXyRe8YFOtvSRhYOwfsQLjsntoTM4O+MnVZSkzSnVWt
         UKB2j9qLI0kmTsN3HaBBD0AO7GEeyk79bF/ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWJtc/jz3NoYF9uCthXFk67SqjsIB7RJSbGEFvTN/iM=;
        b=IPi3dMrGd7EaPlfiGSoLnSIXTXVs0CLJkFFhLaa11DZvTnNObRjWqK5r7U6RLk4g1d
         hNDcMZuSYcHL970aITYO5caFd18UJ5PDA7d0aEFDqFqJ6TLwuh4v5ahugqNIvtm7YGis
         MN0ErAeKOl1WIRQB+8DkegmNJbZykf5vQU9qAL1/Q4W1FsR/P+dRsxYGgHG9YdbjWzA6
         Xr9L5pCBGzFzTlPWaYPY5BN1Z4bEBS+fbxhZK9wQFxe30CXvrGr9pgsp4DAiaFsy5P59
         b7T2bM8YNWStnU2e5KN9dRC74lo3BZ1MPLxICR7BUNszHQFAM3j768cps/4MXKojGpgV
         Rr+w==
X-Gm-Message-State: AOAM532vUd+qymzCr8WwcHrPJ4tk8jwbTCQ/LLBoWUXoGhBfURiBXmem
        Ui+UMg8xxp8TLTdZL02yo9tpBg==
X-Google-Smtp-Source: ABdhPJzi1szkx68ooZCj+rN//sH6e7I3nmqujxk9Bk4xfgJGsNuh6IWI1ON2C8vwZ1OHES4iTJHhoA==
X-Received: by 2002:a63:496:: with SMTP id 144mr22280682pge.380.1643742422709;
        Tue, 01 Feb 2022 11:07:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 30sm393263pgq.39.2022.02.01.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 11:07:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] exec: Fix min/max typo in stack space calculation
Date:   Tue,  1 Feb 2022 11:07:00 -0800
Message-Id: <20220201190700.3147041-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; h=from:subject; bh=AyfN0zm5xZ0Db6oIPqup3ab4ouMbc0RRClkxyP2qBeg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+YTTKrxw/Oaf72PaFCDQWBpcuw+xIFQ/0i2ikcAr 2xFRrmCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfmE0wAKCRCJcvTf3G3AJhseD/ 9zYuF7jyAPi2L0v81MP3RDf7VIrJ4xgGyoaLiTYxpwk+qOAW9CkBkCV9WopgBo1vMsSCOfN+W2RLnO Pimv6mvRjgSDzwChg9PLzh42NrShTKqoPtkkdjHvVDJ2wOzwcIGcv6qP1KuvRw4ay3slqiVYTt4zPv Mt6H4rml8ElelCkMo1WiqbAugm2gcwOuLxXfEAPCQxTCSz5ajAUH7n/Iqgolu5wzKQP6uRDx/j4y/r rXLERVtMJBcmAVab+49RBXKRmpwcAIv5yYXZQaqEzlt872qcf3UijCEse7hN08365czgY4gpoX5+7P mEjRbZRG+HIU4oupbKJoPgrSIILQxJCID9/7L4L/KtDCs7ENGw27QFtuCI2X6ArtGhFPNvaIbYsU8P CkLa0JmjY1MPJulCQWS8Y6MhrPAc7Sk+VNH/tTrIoSDY+5DwKFczRXckh6jERSLUdAX5aaHTyX/nFk Tb2kLrgqwus7rdlx62zYCGPdJ+nyhGb5W01UVRY9VsrorM/mkOQDqoClWlfmDKirHE4lyEdoHHO4z4 Pz1H4fLS9psYmGX4VjQE0gUJfRTt1qogXkvsTO5TnuhCP91I6jGXl4JFJPRxBA/Gkgh8dpOTpfMgoT fn5FGSVh2Zq+SDEVeK0URl2AKzSH5vsa8I7fi4SspI/OLR0oxOYaAwnGqHFA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When handling the argc == 0 case, the stack space calculation should be
using max() not min().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is a fix for exec-force-single-empty-string-when-argv-is-empty.patch
https://lore.kernel.org/mm-commits/20220201004100.BF6D6C340E8@smtp.kernel.org/
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index bbf3aadf7ce1..40b1008fb0f7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -502,7 +502,7 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
 	 * argc can never be 0, to keep them from walking envp by accident.
 	 * See do_execveat_common().
 	 */
-	ptr_size = (min(bprm->argc, 1) + bprm->envc) * sizeof(void *);
+	ptr_size = (max(bprm->argc, 1) + bprm->envc) * sizeof(void *);
 	if (limit <= ptr_size)
 		return -E2BIG;
 	limit -= ptr_size;
-- 
2.30.2

