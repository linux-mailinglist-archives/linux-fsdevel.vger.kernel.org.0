Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00718764F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 00:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbgCPXit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 19:38:49 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53409 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732873AbgCPXit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:38:49 -0400
Received: by mail-wm1-f48.google.com with SMTP id 25so19573598wmk.3;
        Mon, 16 Mar 2020 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCOASbKIk/eztd0+a4bJk0Nw8ytr6z5GvXEV97QcrW0=;
        b=BIiuCbVMArPrTrZV8g/UKJSjycuUYUQKhZdkv2Zw8bObdDCX4Mn7JbuhB4yL7+ywRj
         0QbOClYDLOHdZ591r4CIOkv7JWvQvqvTBc1Zul7dEJzcoKh3a0UcjqdVIx6xvVy/Cmh+
         sxWqLUtT1iGzs56tXrE/bh5fqLqxgakWzY5kfYYG8VJCMrPFN7iY1FNttawjfetHr7T9
         2E0P1sX3ZmZ9Bv6vVyhSNmOnpEEkfHPmsabh7hLzIVYu88N8wdHNYs3Dz606gpzDxhlt
         RpVL2tNPjWCLOA7Mv8IBXcJ3a+3am4AUiGARPkN8r7mK/qVtXGtTMDtyhxHtKLEjoqg/
         IUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCOASbKIk/eztd0+a4bJk0Nw8ytr6z5GvXEV97QcrW0=;
        b=TboBBmfERjegDk/ZRgeZYPFErYwPBseSZwYYSd9UO4CMOwrW8gpktmE5e9Qrn5B1ns
         NARlNYiSt08u8oUdZRNRfeSmkEqQ0LOUgFnr9ynPxzS/7Cn8XJvFILHAFP9qM1Ut+KbQ
         8Xz2XbU3IajHniZ888T1a+IEle/ERRc6qrT8LeEHGfSzHbdgvAP7E0gci6KsfkvBmDHx
         Qwni9rmtuK8I/pLeCMW15TBJqyP/9Ho+XV+NIUXBpnGLH6nf9qYG8JKLvgGJag1WYg1L
         Fj9bZrROOaNvI5b/bf8ZghC/uk5FDdiLOQ+ziSKIMetqlh8Mms60wQLaBEuev/UWsRX4
         A58g==
X-Gm-Message-State: ANhLgQ2TJoTQpu+jXtCB2gn9OC+sqPtX2q0mwQiU6JG9cp7GNIKtvet7
        fNxPTD7bovpYOAGVBntIUIcVgY/rrw==
X-Google-Smtp-Source: ADFU+vsso9j9Trv7CuavLXkwX5AoJ+GqEOWAGxR8QFosCyX4kuQiDd6yBNfdyzuemAR0iBIU111cbQ==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr1452071wmj.176.1584401927067;
        Mon, 16 Mar 2020 16:38:47 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.googlemail.com with ESMTPSA id i9sm1510495wmd.37.2020.03.16.16.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:38:46 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] lock warning cleanups
Date:   Mon, 16 Mar 2020 23:37:58 +0000
Message-Id: <20200316233804.96657-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/6>
References: <0/6>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds missing annotations to various functions,
that register warnings of context imbalance when built with Sparse tool.
The adds fix the warnings, improve on readability of the code
and give better insight or directive on what the functions are actually doing.

Jules Irenge (6):
  namei: Add missing annotation for unlazy_walk()
  namei: Add missing annotation for unlazy_child()
  fs: Add missing annotation for __wait_on_freeing_inode()
  fs/fs-writeback.c: Add missing annotation for
    wbc_attach_and_unlock_inode()
  fs/fs-writeback.c: replace two annotations for
    __inode_wait_for_writeback()
  fs: add missing annotation for pin_kill()

 fs/fs-writeback.c | 4 ++--
 fs/fs_pin.c       | 1 +
 fs/inode.c        | 2 ++
 fs/namei.c        | 2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.24.1

