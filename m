Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF25390C13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhEYWVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhEYWVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:21:38 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F69C061574;
        Tue, 25 May 2021 15:20:07 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id h20so16606657qko.11;
        Tue, 25 May 2021 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JiBQCwU7hV4K3nb6UTd0Cu6Uln8EMlvZ5BxClGNXEY=;
        b=ckhSJyxQ0oS0M4xWbL55/v6lFaIp9ouApYY4jAWO+oI/fH3Of/lYDOKM4CURCHwxMD
         mMiEx3+pEFYncIZSGL+4rNgoPV8M1bxdqBM+/mDMJUOUjyvYbNEdGaMk4CTeKpkDmnnR
         5sB1OEVRhjhLlXxNBVikJhBiSJk7Jov9kt/I/pXgoCw6d19/XbezOe2ZPfAKlNdwE2w0
         m6BGS9PS/jCeofbdAWlKcA6NsIJHMUsIQH8Cop+VY4UbzwOosa3HVhj9HTOR6O+TCGMK
         BekQkW3u9IpoTWpuAoAc3z/fQZMpYM9RwhJ91LqYaufrMqF/V6ZyFifYCnlH4UshgN7V
         DJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JiBQCwU7hV4K3nb6UTd0Cu6Uln8EMlvZ5BxClGNXEY=;
        b=dY6nuTIdoy244fcVKfBQA+4Fhnv5sBYbqfoVEdt6DEl307g+nJGCNiq3bzoJd1NQte
         IiMDzqXEc7t00PK5SQ6Z3C9VUm8nbbsjvhRQPCYRMuQ2S10BWwf0bA90AsduMU1VkOuf
         OwDw9gjqORav3PBoC8CnLetzo08WHQsgI954V5S7g38VT5ZL4zQC/AmHYOh1QIkaFJ1X
         8LW0L+SjRnI0QQFBUm1NcBOw3lpcCAa1er8ShOhD8GWV3JCWRP5tRvnSQwdtKDIdpc54
         Ij3u20JiggkfMKNo0Q5siexE3XQ4nKbzSXakB7FjNJ8XJXp/gPNP82FBa936fSy2PAze
         wqBw==
X-Gm-Message-State: AOAM532dMRQ8M82oO5uWzByJI6io8SUd6FLaUrlxVyaZXzsAr5fLXiWs
        qXMo3EjCsp9HrEObCcWuY6awW90dvQrW
X-Google-Smtp-Source: ABdhPJwmcUDdx+4YnLmTgW8GsjACMjxqKYdX62W+gzx8nRtSoqsQI3xXbZ3HKf1OH9ZxCPgMaE/JGg==
X-Received: by 2002:a05:620a:b1b:: with SMTP id t27mr37666383qkg.42.1621981205975;
        Tue, 25 May 2021 15:20:05 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m10sm333445qkk.113.2021.05.25.15.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:20:05 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 4/4] generic/269: add _check_scratch_fs
Date:   Tue, 25 May 2021 18:19:51 -0400
Message-Id: <20210525221955.265524-4-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525221955.265524-1-kent.overstreet@gmail.com>
References: <20210525221955.265524-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This probably should be in every test that uses the scratch device.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 tests/generic/269 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/269 b/tests/generic/269
index aec573c06a..484a26f89f 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -63,5 +63,7 @@ if ! _scratch_unmount; then
 	status=1
 	exit
 fi
+
+_check_scratch_fs
 status=0
 exit
-- 
2.32.0.rc0

