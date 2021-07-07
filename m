Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3470F3BE3D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGGHrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhGGHrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:47:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D70C061574;
        Wed,  7 Jul 2021 00:44:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso2582666pjz.1;
        Wed, 07 Jul 2021 00:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0e4qh6X8hZkaKgvTuHVOL+IOiL/w9aZMRgfdARHgzGg=;
        b=ipg1ciMSTf3kZZeE3mit0qFPsgj5zRjOR2AAwJfN5WZKv1ahL65eSQjZ569rW4XTeG
         vEuIZFmAjcpJWUNPmmjCm2dFKQK6+QJJtef09DFQg4r5aNVhXcSYjUm77flhsTdLPgzw
         OY6QRYdT6Xr33aSGymEhrAH2FhWO4/kgigTLsrNVV8wzV8WLoSEyTsAGzPFOnhT2npNk
         jZovhsjgSqh01v8Y9HVHTktl30cxZrGpuhva6wOJFJmRSWZOotJMkyxLp5MP4VLMgnxE
         yDLhd6I3S5QqwV7ncB/VFQBhOJob+KsYUFUpWK4YQrPS3q3D05xFlyBYB6C46XDGs6zZ
         ZaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0e4qh6X8hZkaKgvTuHVOL+IOiL/w9aZMRgfdARHgzGg=;
        b=WYZqQObmEvzvPsiGR8NeR/MUJo7255smlfwceFR7kMrQffB+r76zy8sV6qqNgn/7hb
         dBkA5IWkMidZYJO/XIjQjCxpuvYTDg7zUH9yQmKSIaegZDKrhmqn15Nh7hf3KGbBGK8P
         x7C6xuVTfkuvxtIo8cupNnbi5coKUI0Ve6AInI56aDt9onA9Sael4ZMUft4ty2vTcvMo
         ZfIamBZrsq1trOuFv34KKjBjc3E1fKBX+qb1VVQI2U7PBExCWmtfJ+TP4cQMCHxjEh+6
         dMT0jhtoOO4g+rwIewjP4bCvoPd5mnbhY20SYQCr+U8ysHzzUUKmZFRSOn/zmR5lPv7X
         87HA==
X-Gm-Message-State: AOAM531hMExIuSDod13RZGBmDa6jsavtJJIcgfrMUbZMO9Oj7xmQWrAn
        GBklEHj7HIpxFIOnPHwBOxA=
X-Google-Smtp-Source: ABdhPJxjcafVG9vCtOFem9f9EdWv9fquVaqtgUXMF5rhxabs65uETaTz0miKRCt5ZMpkLc7tKHGM5Q==
X-Received: by 2002:a17:902:6b47:b029:129:ab4e:6407 with SMTP id g7-20020a1709026b47b0290129ab4e6407mr6345192plt.20.1625643876011;
        Wed, 07 Jul 2021 00:44:36 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id x39sm12958519pfu.81.2021.07.07.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 00:44:35 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 0/2] fcntl: fix potential deadlocks
Date:   Wed,  7 Jul 2021 15:43:59 +0800
Message-Id: <20210707074401.447952-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Sorry for the delay between v1 and v2, there was an unrelated issue with Syzbot testing.

Syzbot reports a possible irq lock inversion dependency:
https://syzkaller.appspot.com/bug?id=923cfc6c6348963f99886a0176ef11dcc429547b

While investigating this error, I discovered that multiple similar lock inversion scenarios can occur. Hence, this series addresses potential deadlocks for two classes of locks, one in each patch:

1. Fix potential deadlocks for &fown_struct.lock

2. Fix potential deadlock for &fasync_struct.fa_lock

v2 -> v3:
- Removed WARN_ON_ONCE, keeping elaboration for why read_lock_irq is safe to use in the commit message. As suggested by Greg KH.

v1 -> v2:
- Added WARN_ON_ONCE(irqs_disabled()) before calls to read_lock_irq, and added elaboration in the commit message. As suggested by Jeff Layton.

Best wishes,
Desmond

Desmond Cheong Zhi Xi (2):
  fcntl: fix potential deadlocks for &fown_struct.lock
  fcntl: fix potential deadlock for &fasync_struct.fa_lock

 fs/fcntl.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

