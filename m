Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987994BBAC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 15:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiBROig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 09:38:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiBROif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:38:35 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC54294FCE
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 06:38:18 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id v10so15085934qvk.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ODn7EQIgdlbXADqX+UBHZefEuH8fIQGyeYzZ+VKRfw=;
        b=rF/ktlW9/2DLEe6pGjwtdSoy7rHI80WmP2P1B83dGoMNWPgvYzN4FeFZqnQuDZvvZd
         7VDQs3B1lRuzzxlozM3KoiOU+54L9A8bwuXWPdbs/En/rGIEZDa127VSU7fTjLNxXzT+
         2f5XlsvVnlm/OZelqCP4YuaFDEG01KXeMDDBrtASHiq1afNykN/LLrT96vP70ieid6am
         F6Vb/YqqXFoHn2rad1XvfUN0xorkx7ziXos85ZwbHzXgMWz8EZpgnwaErtkVGo9D2Vxj
         V8yRzgi6DH4PAPTlVbnFJQpI4rjHfPfBgD602/idZr5HRNOnSYNlfHz10KW1mm/9zuql
         IOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ODn7EQIgdlbXADqX+UBHZefEuH8fIQGyeYzZ+VKRfw=;
        b=3bLtHpSpAGF8QsXGUx2nVws28KBvG2ZjRKejl3QUBmenE4RmpSo5MKnmJ8KJyRYmym
         Vae9UQq8sX3fndQLYRAfzyoDz3Hr9b/I+1xEvaM/+NiiRzSE8Pk+eCYb7ChIB2DXHJAU
         YxcbDC4773uMgBJBrIpZV+8P2yoqaeZzrwXJtWOVv+akfQoJcLHSSSHWedQxUnaoXtB+
         BhsxVCjXW2WbOxb2gf4FbfIWCWAjYlBQFkem0zzCzi0XXT0jW8E06k/MLBaVkEJIMxSp
         Qct0O/PEvn5T5oXGV1I4V6uoh8ExOz5Rk/bgU7El0r5CaZ4B1mFa7L8oKoO3hu49eYC2
         deTg==
X-Gm-Message-State: AOAM5310jhnwyXsur7acrSoVQQpCM0TPbdlYIOqzSb79094bg4c1BaWg
        j1bidhfq5CjzU1+nP1VS5tGSXw==
X-Google-Smtp-Source: ABdhPJz7VWeb54D4AlYdjW/UEij+yX9pD34AkP+oXG2NRQ76Fl1p2e2nmHOpiIxTVcbq3kPA1jsqDQ==
X-Received: by 2002:a05:6214:1105:b0:42f:e1a0:6d2e with SMTP id e5-20020a056214110500b0042fe1a06d2emr6019394qvs.122.1645195097921;
        Fri, 18 Feb 2022 06:38:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c144sm2742666qke.57.2022.02.18.06.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:38:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] fs: allow cross-vfsmount reflink/dedupe
Date:   Fri, 18 Feb 2022 09:38:12 -0500
Message-Id: <cover.1645194730.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

These patches allow for cross vfsmount reflink/dedupe for everybody and removes
the duplicate checks in btrfs so we can allow it as well.  This limitation seems
to have been copied around from the original implementation from btrfs, but
makes little sense as we just need to make sure both files are on the same super
block.

Btrfs usage across all the distro's I'm aware of regularly use the pattern of
mounting subvolumes for different areas of the file system, and so we need to
allow reflink to happen over vfsmount as a matter of practicality.  It makes no
sense to make cp --reflink=always not work if you are copying something from say
/var to /home if they're differently mounted subvolumes.

The only change since v1 has been adding the Reviewed-by's for the VFS patch,
and then adding an ASSERT() to the btrfs patch to make sure we catch any changes
to this path.

Al if you have no objections we can send this through the btrfs tree.  Thanks,

Josef

Josef Bacik (2):
  btrfs: remove the cross file system checks from remap
  fs: allow cross-vfsmount reflink/dedupe

 fs/btrfs/reflink.c | 4 +---
 fs/ioctl.c         | 4 ----
 fs/remap_range.c   | 7 +------
 3 files changed, 2 insertions(+), 13 deletions(-)

-- 
2.26.3

