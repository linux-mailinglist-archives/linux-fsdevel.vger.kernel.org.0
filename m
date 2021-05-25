Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5D390C1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhEYWVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhEYWVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:21:42 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF03C061760;
        Tue, 25 May 2021 15:20:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z1so16905819qvo.4;
        Tue, 25 May 2021 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JiBQCwU7hV4K3nb6UTd0Cu6Uln8EMlvZ5BxClGNXEY=;
        b=DuRr6kY0NbHkUSqsW9RLMRyDxHJkP8ZF7n745y/SzAsvvtNXE/O0tmSpLivl2FCmkq
         9gm6oGLqAKXk0Cdzpc23wJpT/RtVKigmn82iKZtD8AKNbcrGI9nMo4gDtEjqSpb8Dpdh
         KEs1NZQD090JOFQkmAECnjgZk1Pwie+U9x4rXTPWGhKbDyhV6fJf+Xu3xmrnZ6HBEamD
         tn3nU+HL270CCHQvw8Mh1D7hosrfpnmrgXba+dNwyQB4cJJsEgfFaSuLB0H3onHaqXvG
         CPB/cj/JwWPCpEtcTCcqRJPci7pUgduozPZ1wFe9kbgvJgoOy4XsQJbBb1JF+Z4fZ4ic
         fVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JiBQCwU7hV4K3nb6UTd0Cu6Uln8EMlvZ5BxClGNXEY=;
        b=Za0AmsukjLMBzbOv5E99TlXj0x6/7uK5qHgoI8gZIrxtcmJPXmftKMCirSlt3ru54l
         EYkCod6ahQWLwG3YmZJaaHp7xDtN65aV6+zG0zD06zQlmLOc9qBNh6vF01+vXtoRDed2
         YRz9C5hycBtWSbcjNz2/0WUVc+o4fpjf0gN6cLt+vgCGJ+/iACRd8xGiX+y4X5QmzDoU
         yiyYIUoTutFwGaAuL8YeY57L/i/GEsBODNEkKHXBH8oxiVyk+TRGu18GkB73A2sLpHIx
         pFqXTtHNK0M9PCjA/Pb7JSNQgwvouMvfDSzsbI8DWPvLjIrVtcwngdGm8Qe62X4N9xnR
         WBpA==
X-Gm-Message-State: AOAM532goBQwQpbG+qENXrIfiJWqJNjzKrzrjoAKtwDnBYKvV3f2OVNA
        i/lRdzCBas0TIC6l2xHBPgM2eOHRxHWI
X-Google-Smtp-Source: ABdhPJyS9ann5Z1dsbL2H7XgQwxsVM2yktt+Bfy5tKTU/wC2tX9jDFKzg8WOtsSS+eixVSUfh2T56A==
X-Received: by 2002:a05:6214:902:: with SMTP id dj2mr39982536qvb.11.1621981209845;
        Tue, 25 May 2021 15:20:09 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m10sm333445qkk.113.2021.05.25.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:20:09 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 4/4] generic/269: add _check_scratch_fs
Date:   Tue, 25 May 2021 18:19:55 -0400
Message-Id: <20210525221955.265524-8-kent.overstreet@gmail.com>
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

