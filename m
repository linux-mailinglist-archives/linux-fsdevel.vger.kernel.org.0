Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ABB6094C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJWQkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 12:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJWQkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:40:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7D5FC0E;
        Sun, 23 Oct 2022 09:40:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f23so6603192plr.6;
        Sun, 23 Oct 2022 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEMf11Sn3FVY4fOuES/7fY+Nkkl02+sUy0b7CrgdHj8=;
        b=lz68HAfWMz/Hm+dWWSLVqa5c4QpYztULx5yhXHyFqbFCJc6K59PLIhw0jslwbMj/iO
         Ssz8UMjCfS2ltlHzkFgO6TNwrshKqSSEuvi1k+1NyMXZx9gaT5sdlsgRgWUgXo4Jno6L
         VmKnIlHjqhW2wfpyzIlY4nmSbEt9F+c06ZY7BhE4HtN73rQdIgwqwPH1ekrKJpXpefGQ
         J3fkfbjPAcHQqeGO/6yHZGnEMHfhdVs3h7E57rU8CtUAVzOYomiPDg7vyeR7bzA57SDM
         WMfchOnSe1jEtRj37tKs8vS7tqHZH9s2snvchl0+l2+ysOtMHJ2ad4GJ+6Ore5a3F4Kr
         BMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEMf11Sn3FVY4fOuES/7fY+Nkkl02+sUy0b7CrgdHj8=;
        b=L96+5EYQEAZ3vydM2wO7GhrfFCYTMgDckirL/wmAGS4zDkoONj5JDi5fN17i6f72ZL
         xoIpexGI2ityFunyaigWLwWEfXmYo7ZXsWaLJKP6F0gEBOq4/NA8Yv+eGVneXJE/LZf0
         WckJJCuvdpDc4dJKaxat6BzMoJ5jjbg/rcRc7CImD1kaijZD38KstZWGeoT0D62kt9qm
         i9EjFEpuorwloKiTpkjV/odm/Stf2Cm/JNBMD/aLlAvpUD1rM0aXHI1vNB+pxE0WNPju
         sJmkZ7+p/gqFE4+il8f5jFnxbmrHsq63Hm2xbmaXTXs8WNojMbO8roAkKyIapX9pOnXC
         iq2Q==
X-Gm-Message-State: ACrzQf3PH3jzkxOoiV7QnwKBcsqEJ8WhqFDMqvORNN6yLlOHDOVWeOoh
        8oYYYvbRQN8lFn3PysCmPyI=
X-Google-Smtp-Source: AMsMyM7wcFvL73RoiFZkbOs9PtptxzX5LUUfOCVfORHzKgMItTY8lKLhi2fdhcor0COHJNewJvlLhA==
X-Received: by 2002:a17:902:c1c6:b0:186:994f:6e57 with SMTP id c6-20020a170902c1c600b00186994f6e57mr5190100plc.17.1666543230975;
        Sun, 23 Oct 2022 09:40:30 -0700 (PDT)
Received: from localhost ([223.104.41.250])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709026ac700b00172fad607b3sm18118264plt.207.2022.10.23.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 09:40:30 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH -next 0/5] fs: fix possible null-ptr-deref when parsing param
Date:   Mon, 24 Oct 2022 00:39:41 +0800
Message-Id: <20221023163945.39920-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to commit "vfs: parse: deal with zero length string value",
kernel will set the param->string to null pointer in vfs_parse_fs_string()
if fs string has zero length.

Yet the problem is that, when fs parses its mount parameters, it will
dereferences the param->string, without checking whether it is a
null pointer, which may trigger a null-ptr-deref bug.

So this patchset reviews all functions for fs to parse parameters,
by using `git grep -n "\.parse_param" fs/*`, and adds sanity check
on param->string if its function will dereference param->string
without check.

Hawkins Jiawei (5):
  smb3: fix possible null-ptr-deref when parsing param
  nfs: fix possible null-ptr-deref when parsing param
  ceph: fix possible null-ptr-deref when parsing param
  gfs2: fix possible null-ptr-deref when parsing param
  proc: fix possible null-ptr-deref when parsing param

 fs/ceph/super.c      |  3 +++
 fs/cifs/fs_context.c | 58 +++++++++++++++++++++++++++++++++++++++++++-
 fs/gfs2/ops_fstype.c | 10 ++++++++
 fs/nfs/fs_context.c  |  6 +++++
 fs/proc/root.c       |  3 +++
 5 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.25.1

