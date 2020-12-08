Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148F82D27D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 10:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgLHJjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 04:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgLHJjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:39:09 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D7EC061794
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Dec 2020 01:38:23 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2so9505887pfq.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Dec 2020 01:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1xsP4hi+UGnP2yxtDqsufVew2mnlvtx1BXkv0GZN90=;
        b=eJKHIJ7oh3DpeexTdsuQEJnzvwrJ12Rl31xgSVrkzcb/aZZYka+igWw1YO2PtWFB1J
         rxhPC50Vyx0iG9Cv0NV/2bZzoTjchW2CQNOftmmF2qoKbny/RO5hnJGA1TFooI5p46vM
         V3hLYPyau1rDL4bT8/Dhto0x7gn8cHdXxjkgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1xsP4hi+UGnP2yxtDqsufVew2mnlvtx1BXkv0GZN90=;
        b=SDB8pdSrt5aGvKfOz2tvYe2ktR0T3KT+1CylcPeOWOLZCzzGctt+K748lrgWPS8hEJ
         eScnskmr95OM2fwCxSCDL1r5C2u5UYhRabqHilD04t2YpCrlSTkNGA1OLX0Jgqhnc8IO
         qwhSalU2xvEMja/jMlsp4jjVQaHRXJivjVFz2PLf4TW42p6tKoKyL41P44XbAsmDAb8F
         NDsZRP8oxCXdBLylFSFdwyvWgc5MfgrWl2OXo8STJS2F2Si9T+l1v3EtXPACvg8SKyHy
         OEJFC1dbS+TJztoWbtMNqGt04Wc2pd/az+8ld/nDwmx7y53XPRd+J08wpVZpHV06vtJu
         RoUQ==
X-Gm-Message-State: AOAM531leLtrnLRwPEmI+/ySoggvt7XjJD624CX5xSqZHRWG7YjBCLwp
        fInoA5nLiW5OuUB/nAwlqRasbQ==
X-Google-Smtp-Source: ABdhPJzz4+LER4Ucs9KFsZC8AVR333BX5objLsX8hHl7a2LaE2+WqTD3hzdG2uTXKcPBbZkmH0u0LQ==
X-Received: by 2002:a17:90b:b0d:: with SMTP id bf13mr1617624pjb.194.1607420303307;
        Tue, 08 Dec 2020 01:38:23 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id 129sm12316232pfw.86.2020.12.08.01.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 01:38:22 -0800 (PST)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 0/2] fuse: fscrypt ioctl support
Date:   Tue,  8 Dec 2020 18:38:06 +0900
Message-Id: <20201208093808.1572227-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201207040303.906100-1-chirantan@chromium.org>
References: <20201207040303.906100-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds support for the FS_IOC_GET_ENCRYPTION_POLICY_EX ioctl
to fuse.  We want this in Chrome OS because have applications running
inside a VM that expect this ioctl to succeed on a virtiofs mount.

This series doesn't add support for other dynamically-sized ioctls
because there don't appear to be any users for them.  However, once
these patches are merged it should hopefully be much simpler to add
support for other ioctls in the future, if necessary.

Changes in v2:
 * Move ioctl length calculation to a separate function.
 * Properly clean up in the error case.
 * Check that the user-provided size does not cause an integer
   overflow.

Chirantan Ekbote (2):
  fuse: Move ioctl length calculation to a separate function
  fuse: Support FS_IOC_GET_ENCRYPTION_POLICY_EX

 fs/fuse/file.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

