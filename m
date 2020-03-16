Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE21D187649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 00:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbgCPXi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 19:38:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50813 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732982AbgCPXi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:38:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id z13so3508909wml.0;
        Mon, 16 Mar 2020 16:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOl1AKXgStV93i06X/WL0ilGV0db2i3MJV2zuTRnHiE=;
        b=rQLOqbAGyKRVc3FWPBnLv/9m0l8mWZUgw2umajD/W+V79krhzZBswsGmABz/TIeZFi
         taFfKcN3pov/T3iBXclZ08BDJZxNdNB1GP2GWS/OLjSMGgGv0JPWunqrv3OjYwmeAK2z
         I3mZGU1QBtQ/dLdW247fUjf9BxHkg+ksCqZAU0g77Yoxfk7aBR4Ld6UUe7eu0YYz91Oi
         ytp1L40qadUprCb2+iYbKoSM6P1wfLSvXiS5FL2LVI5cuvL3NtmIeiiuPADeL3TjTVAt
         uKSZfRGbKziV2rpS7XolejYRz89TOEJO+udQJo81kRT1uw5bNLJqX1xoZ5xyuc4F/6Oa
         6Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOl1AKXgStV93i06X/WL0ilGV0db2i3MJV2zuTRnHiE=;
        b=tIUvA1O2RHzQEnQwHbJg2+VxghlJaZUFr9MD97iIzeHF4otvjA1oet9UaxNjU2S2A4
         i7VTrgd1nUtwKj9VyGf1qllcXmAmdg5cAyCFicgJJDd7gl3GGe1Ru2Sd1fhnUEB0TYi7
         t/v8SMtSt6MdKVORFATFNrXzPIjBrymnT6PPSk3s4MPufyxuo6RPGJes/OVwdVwrHJXq
         XHJvHPEsoaTSwAO4L4PVF7iPC5STMzFvzFu3E1z1UuylWXSYSIZlYvrVpUeyTaHZ8waF
         mgr7vJRsA9tUtD6anWoSgGGQm46euoXizExyPuCmB8bzG8dgSm6aZZSMGsD5Tnyxpdh5
         9iPQ==
X-Gm-Message-State: ANhLgQ3aTTkAbUfceasyPTBoex8oC+A++eRRyq23qyLiTES48HpCTg9m
        wWq2qj/DgePfX/SJ0WIFyCiMstEwlw==
X-Google-Smtp-Source: ADFU+vu8a+WaamHkyH+MHqM2Mo5VLLtsW60ZgnT1nDGilxwc78iRnjCmLxoUtEl672tAjFvag07AjQ==
X-Received: by 2002:a1c:2c8a:: with SMTP id s132mr1460869wms.22.1584401934867;
        Mon, 16 Mar 2020 16:38:54 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.googlemail.com with ESMTPSA id i9sm1510495wmd.37.2020.03.16.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:38:54 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 6/6] fs: add missing annotation for pin_kill()
Date:   Mon, 16 Mar 2020 23:38:04 +0000
Message-Id: <20200316233804.96657-7-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316233804.96657-1-jbi.octave@gmail.com>
References: <0/6>
 <20200316233804.96657-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sparse reports a warning at pin_kill()

warning: context imbalance in pin_kill() - unexpected unlock

The root cause is the missing annotation at pin_kill()

Add the missing __releases(RCU)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/fs_pin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index 47ef3c71ce90..ee57700740df 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -28,6 +28,7 @@ void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 }
 
 void pin_kill(struct fs_pin *p)
+	__releases(RCU)
 {
 	wait_queue_entry_t wait;
 
-- 
2.24.1

