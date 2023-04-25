Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E266A6EE25C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDYNBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjDYNBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:01:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F5D315;
        Tue, 25 Apr 2023 06:01:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso3611729f8f.2;
        Tue, 25 Apr 2023 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682427674; x=1685019674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGePo+323IAj5uoeF7RJtIA7ttlt5KyRYR7yLs+0X/s=;
        b=eIwu+SPFhBEvDEA6AUndh6gllmC6ap6HqhGKayQ7oZIa5OoxOprc9w9Qu9ZJ7I6uDt
         Gpa5Oxg3kBBa1cETzgwkJA0bq7mFLlaPeqAeMxyDME0LopsBTs+56lIA9WFLyOhAIcN0
         vHSkbOouH7xinu37wGluUrb0SM7m/j5uR+TzxEPCoOwDkEv2JRJjYD5D4Y/9YhnrowXi
         14JhM697QCWA6onB2mdF6KseK3+L89F5IPJr8UJNWem36oxw4lcqBIgKibc2stNSlP5l
         oUiMQo8RDwv3vuT9IgzPNqzwmFcl+CSVM1oOlKOP0MzYvCyicDctuhF6TNGDp/rImDwB
         LzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427674; x=1685019674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGePo+323IAj5uoeF7RJtIA7ttlt5KyRYR7yLs+0X/s=;
        b=fY2XfEmJvIjOpexrup1WzjwcO+MJlx29hLeg2orqHhM7LLyGFoINH0+rXMFkS8u8YO
         F1BnqVNZrbEY97CxWlJ8jMks1Wh9sCvPLzt2iI2ZZJvbTQ3D9OkqYjpAPrPOolYGimB4
         34c1airzqQVI9Fv1ZWTNYKLz6YkHwdH39Awi60IhXOS5EYACyO0sv6Ji+VHcI3HHo88O
         12H+QFvVpNDD2yDbES2qhCef2oanfvEsyXRGr0Crifde/9UxmTIiseJeX0lOE4zbD9B8
         RaCy0YqTT+pnRUSroQJ+HF//MrwSKtArNMFxSt4/2CNmLZJruwaqRFAMvijofH266Tki
         symw==
X-Gm-Message-State: AAQBX9f2/E52FcIKbOBPa2ktocZ0i6f63obvw5RBaCYy2IkFCYwd3dyK
        1Dav89DSYRZYFUxYJifwI0Q=
X-Google-Smtp-Source: AKy350bBFdtqGR/HCdXtKYXl75p64JMBisk/rq1s5bzeqqu/2BVcB3VNlW5sT9m1GWuQ2/LK//HI4g==
X-Received: by 2002:adf:e590:0:b0:2fb:1f34:dc6d with SMTP id l16-20020adfe590000000b002fb1f34dc6dmr10969089wrm.64.1682427671425;
        Tue, 25 Apr 2023 06:01:11 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm13103447wrp.20.2023.04.25.06.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:01:11 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC][PATCH 0/4] Prepare for supporting more filesystems with fanotify
Date:   Tue, 25 Apr 2023 16:01:01 +0300
Message-Id: <20230425130105.2606684-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot at an
alternative proposal to seamlessly support more filesystems.

While fanotify relaxes the requirements for filesystems to support
reporting fid to require only the ->encode_fh() operation, there are
currently no new filesystems that meet the relaxed requirements.

I will shortly post patches that allow overlayfs to meet the new
requirements with default overlay configurations.

The overlay and vfs/fanotify patch sets are completely independent.
The are both available on my github branch [2] and there is a simple
LTP test variant that tests reporting fid from overlayfs [3], which
also demonstrates the minor UAPI change of name_to_handle_at(2) for
requesting a non-decodeable file handle by userspace.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7vtft@quack3/
[2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
[3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid

Amir Goldstein (4):
  exportfs: change connectable argument to bit flags
  exportfs: add explicit flag to request non-decodeable file handles
  exportfs: allow exporting non-decodeable file handles to userspace
  fanotify: support reporting non-decodeable file handles

 Documentation/filesystems/nfs/exporting.rst |  4 +--
 fs/exportfs/expfs.c                         | 29 ++++++++++++++++++---
 fs/fhandle.c                                | 20 ++++++++------
 fs/nfsd/nfsfh.c                             |  5 ++--
 fs/notify/fanotify/fanotify.c               |  4 +--
 fs/notify/fanotify/fanotify_user.c          |  6 ++---
 fs/notify/fdinfo.c                          |  2 +-
 include/linux/exportfs.h                    | 18 ++++++++++---
 include/uapi/linux/fcntl.h                  |  5 ++++
 9 files changed, 67 insertions(+), 26 deletions(-)

-- 
2.34.1

