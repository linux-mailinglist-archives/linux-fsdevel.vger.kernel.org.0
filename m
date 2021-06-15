Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789993A8675
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFOQ3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhFOQ3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:29:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EF6C06175F;
        Tue, 15 Jun 2021 09:27:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so1834657pjn.1;
        Tue, 15 Jun 2021 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdF3wW4T8FRZFucBIyQHf3j+zRm6LsxIJwnfUlfK+Q4=;
        b=OzI5w5V9+U2EOmeDiAei3lguVsnZxNuFNK164+UsTHn673OW2iaoBqRCbOZ+Zsne0l
         U8uDmBt8sRHl0BEu2RcfG7nD/CvZ2VUOigpBJzVK6mstyTlqKId2s2ft0heudEeuSws2
         G2ZRj3CrZNde2QflwyfNjtdiC43ASssVU1+1V5ZEnChGGYUA0pciQVuwydrrTrDrOpJF
         K4oiekfV/rpRXRs9qGcHEbt6/528rWLOLcJoFyjlf60FTSphvoxo4n54pNb3Gjdpeqxq
         bICXVAd6BwHq/dPEDVRtREBg4ppfFmkHtWWa3qH1dSnawcaex3PZ+f0GgXpkH/R90C8N
         QqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdF3wW4T8FRZFucBIyQHf3j+zRm6LsxIJwnfUlfK+Q4=;
        b=K641ZgOsoa0Z0CQDYA+MyMhv6rhyUb1ugZHzssZf+4jJFIi7UjvCPmi+ShrtWSmKCm
         9Z+8yQst9AZy4HZW/6VJyTRSBCKEZXo10UNg4ImGZZJAyNU0sJR+moZ32gZHgH1/El0J
         LgDIa4yViiuj+e+AuiP+iGfRbZFrfggO602iKm38pnF80lYX5xQRlgQhBD8sZG+ATppu
         kYXHxtq8k4SaaCrLkczJQsntHi9hafEz1kZ5S/CSvGxu6Hh4G0lkivvZXfN2ufi74Ona
         78FS9hXUDiR+Up4VFZb5CjTsomC/xc010UTOkq5AZR1OiBZueBisgTgDa0t5+QnOkarM
         3L3Q==
X-Gm-Message-State: AOAM530SNxpp5fkuljg7wrwGMsYvJVdgc8EpAhxoeuwoHvj+MIGT4BfE
        O8H6ZJTBKfxxdUUJdqC07BE=
X-Google-Smtp-Source: ABdhPJyL1Yi60ltBMEkgVksv87fRWnLmIxRHdG2+l3q0RuiL9fcDc7tchujOwwSo37QnDMS69zk6HA==
X-Received: by 2002:a17:902:b497:b029:115:e287:7b55 with SMTP id y23-20020a170902b497b0290115e2877b55mr4804360plr.79.1623774426347;
        Tue, 15 Jun 2021 09:27:06 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id c25sm15535858pfo.130.2021.06.15.09.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:27:05 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH] exec/binfmt_script: trip zero bytes from the buffer
Date:   Tue, 15 Jun 2021 09:23:46 -0700
Message-Id: <20210615162346.16032-1-avagin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Without this fix, if we try to run a script that contains only the
interpreter line, the interpreter is executed with one extra empty
argument.

The code is written so that i_end has to be set to the end of valuable
data in the buffer.

Fixes: ccbb18b67323 ("exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC")
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 fs/binfmt_script.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
index 1b6625e95958..e242680f96e1 100644
--- a/fs/binfmt_script.c
+++ b/fs/binfmt_script.c
@@ -68,6 +68,9 @@ static int load_script(struct linux_binprm *bprm)
 		if (!next_terminator(i_end, buf_end))
 			return -ENOEXEC;
 		i_end = buf_end;
+		/* Trim zero bytes from i_end */
+		while (i_end[-1] == 0)
+			i_end--;
 	}
 	/* Trim any trailing spaces/tabs from i_end */
 	while (spacetab(i_end[-1]))
-- 
2.31.1

