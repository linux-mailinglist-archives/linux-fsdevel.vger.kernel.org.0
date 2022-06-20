Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F27550FE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiFTF7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 01:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiFTF7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:59:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59315DFB4;
        Sun, 19 Jun 2022 22:59:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k7so8814550plg.7;
        Sun, 19 Jun 2022 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EOYYx+p+RkPqrNIib5wPOSg2AyVrOrZK8ANlVZ/2C0=;
        b=Sd9h/IxsghHxFtpRXyO2j23oep6jTeY+ddHz8f4QSTM8ND9/3XbxUbbJALbA2lw9xL
         haE6vxGnUwsLOCdyJoKetcwNsK6RQlyuPVA477gFFw+CrTUkNtUI2znIqE6O4c3yaOsA
         Jjhj+mOldDeb8YVdOK3YvfNnXvadl2i8u00OqRtKRc0BEWPqm7HKq8UfXWih6ro/DHKR
         leoebCQJRCpN21odrBHY0J52k5OL0/2sUVTBuRWDmUzpW8so7TGO4KeLqkEPdNNaB8b/
         ovsN5iZEXzRC9XA5HIz6Wc5a9NayCUuq6rnztSa6r5/mGyMr/YHT+FbxwjS7mQ+QUkel
         RBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9EOYYx+p+RkPqrNIib5wPOSg2AyVrOrZK8ANlVZ/2C0=;
        b=4/MglQra9dpfQR4fTVbeaeTkSaOLdzRf6QMPk69lsQ5wRuhtguWw7fEKwuprpczMY+
         5Tjx2AM84nGcR2atAMcJPFWXIR620krLtOzdO3IIjfChvUSE6jUKPWC1r8s9sHxq2wQY
         1hZdLPaEHWKjKSV9cQ8IPE3SmDQRJW6bZ6toM7A1+Gz+OjytaXgy0J6uF5KOuO8ydawQ
         KFbNIft+5+yQoni+MPAmT2ltmsUf69pnd9dD6pQ4nx1nCdLQLkM/s0v6rxIn/wiYJOqq
         42KxfDeFNMXr8yXPgOFlor8LgqX7sHvUmhwJEzPIPStuYWJ59EMpn3hFSH23qqAKwhAZ
         xyCQ==
X-Gm-Message-State: AJIora8fO9L2RB+Hwwob4w4IdvKTjm0SS26DyDVXVaKwe5C22a5Ivnh9
        ruhY6AH1BDkH+MhgmHN6VOzB9MqzCQ8=
X-Google-Smtp-Source: AGRyM1tmBLsWuVyHtNwc9UPinh5fFkr/4F4/DoTe6qbVaJR3XpgRHdxj539xS9GoC+uIOiwROB76dw==
X-Received: by 2002:a17:903:1c2:b0:163:ef7b:e10f with SMTP id e2-20020a17090301c200b00163ef7be10fmr21847526plh.158.1655704749223;
        Sun, 19 Jun 2022 22:59:09 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903120400b001678ce9080dsm7724191plh.258.2022.06.19.22.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 22:59:08 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 0/3] submit_bh: Drop unnecessary return values and API users
Date:   Mon, 20 Jun 2022 11:28:39 +0530
Message-Id: <cover.1655703466.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
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

submit_bh/submit_bh_wbc are non-blocking functions which just submits
the bio and returns. The caller of submit_bh/submit_bh_wbc needs to wait
on buffer till I/O completion and then check buffer head's b_state field
to know if there was any I/O error.

Hence there is no need for these functions to have any return type.
Even now they always returns 0. Hence drop the return value and make
their return type as void to avoid any confusion.


Ritesh Harjani (3):
  jbd2: Drop useless return value of submit_bh
  fs/buffer: Drop useless return value of submit_bh
  fs/buffer: Make submit_bh & submit_bh_wbc return type as void

 fs/buffer.c                 | 19 ++++++++-----------
 fs/jbd2/commit.c            | 11 +++++------
 fs/jbd2/journal.c           |  6 ++----
 include/linux/buffer_head.h |  2 +-
 4 files changed, 16 insertions(+), 22 deletions(-)

--
2.35.3

