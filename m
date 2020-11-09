Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF94E2AB44A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 11:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgKIKD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 05:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgKIKD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:03:58 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B6C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 02:03:57 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so7631480pfb.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 02:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nT84IJPZ6Yllu6oKed6wOIn5E2EhP/PiBG9gGknUnr8=;
        b=fnJBwrsAYc0CtQOtAnXUA1euHgEwLpqKr1z8X9MFFTC56/1m73saU79sAH8S2OOGqT
         vIGPLNToxbCZGKL01eXeMtdVLrWzq2PfsW7rZgtSdKUf3zFDSSHqyDuRTRha3K9vg+l5
         V41UpR5FS1r/ZpBORPVaEBn2F4QuLm5Hj4Kkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nT84IJPZ6Yllu6oKed6wOIn5E2EhP/PiBG9gGknUnr8=;
        b=mvKOiC+ynP/An5oxi3r5d6ev9Bxa/7QayHPws+G8/tuYpANvLCLjLtV61hSt9yhjMQ
         Hc8QTkB8GvCuH+xK+wFfT2teWglNyFaSpJALfH35YQtIGdCSqColF6rxicgDUg0+GJd4
         BONUoTiyCmrTp4ipIYFCUbBaZhffDVAUbnNU1CQEStpx6gc9OqQi3MXpzLU1y4dx4Kse
         xnikwRVkjS092CLtvC2tpt+sp1Jrb57wn9mR9bAvWsFaPYwE1ypI/jraxqtX1dXd2UOG
         u01TEBmxDUFRutMtV+J72MYiyLKSW1XHngiZlP9jGqvZPNLqmd5WiryLB7IoHQYG1RJv
         QeaA==
X-Gm-Message-State: AOAM533jNqLx0Hb9NaZeMIIRWHXGRRD7mgZSAgHZlcVvWTf8nvj+JtvA
        /88bpbzTUYX3TKdfbAmrtU4Wrw==
X-Google-Smtp-Source: ABdhPJw4wkGL2q7D7KNa3l1u0IX4VF8hlI8vpc+gWlei9cyL6+1799Uk8fR0peHXY6TFiQDsL+/AZA==
X-Received: by 2002:a63:6484:: with SMTP id y126mr12568762pgb.320.1604916237577;
        Mon, 09 Nov 2020 02:03:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id a11sm10787210pfn.125.2020.11.09.02.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 02:03:56 -0800 (PST)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 0/2] Support for O_TMPFILE in fuse
Date:   Mon,  9 Nov 2020 19:03:41 +0900
Message-Id: <20201109100343.3958378-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series adds support for O_TMPFILE to fuse. This wasn't supported
previously because  even though it's just another flag for open(2),
there is a separate handler for it in the inode_operations struct.

The implementation re-uses the existing infrastructure for creating new
entries in a directory (currently used by mknod, symlink, and mkdir).
I'm not sure if this requires a new minor version so I've just added the
new message definitions without changing the version number.

Chirantan Ekbote (2):
  uapi/fuse.h: Add message definitions for O_TMPFILE
  fuse: Implement O_TMPFILE support

 fs/fuse/dir.c             | 21 +++++++++++++++++++++
 fs/fuse/file.c            |  3 ++-
 include/uapi/linux/fuse.h |  7 +++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.29.2.222.g5d2a92d10f8-goog

