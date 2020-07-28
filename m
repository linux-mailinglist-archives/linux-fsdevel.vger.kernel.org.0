Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3379D23034B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgG1GvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 02:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgG1GvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:51:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1DC061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 23:51:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so6701153wma.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cvhA/gIk4GDGba9Z0se8vRKuxDpc88ZTmpvpOsOhfts=;
        b=H1iQbFgLJzgwvgNko+DLUCzk9KbOE1Fpvh+L9/kff+DEXXH64V2YI9xGnR/dD+bN1r
         HHuoGSfBwDxszSzSb0up/ib8xl1kZI5H2MDJ3nTXu+of26495pmtb1pB47rrIfn28ecP
         Bi+S0muto1TU8Kd03WtxnrOg+TJgIL3gnZqKdqcmGso0kmWevdPtyN6pjZUlWm8HOWVk
         qR+2125lGH/spgmWag4hAy/4FeeP5KZjUbc8hOdcxJJ80jGA+1cqUD2+v2ivcm3KF7XZ
         593EA2lmxexpuj+iFkjeKGRoW0WJ7tYeYHzXhUmcqhHXkKojvJlbyE2+hnTAdmLyMvON
         mghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cvhA/gIk4GDGba9Z0se8vRKuxDpc88ZTmpvpOsOhfts=;
        b=BH7XIX1TzkjGccEMoC8XZvHDTkCBvklzLoWOuqVRnIYvgrgRrPcd6GVlcVl6GCTYuq
         bRTAGB4KgoC6ig/R8EEzpxUE0qkbEcRe9/MA89SlOAZp8SeskpxDVaGfMWDYzsL8ZJ0w
         ZcjyPuZXVxrt6PW9tkpu2egc/eRC1BmCSFqrT+mGBufbuj1Yt8xNq4p22yoqAXFC1l7t
         piZfIjFdXBFATjf8kR4I+EisPnHfPgySkcSm8BJnLJuSZiYqdZxYffQ3QfH4ZARAxdJX
         7PkNC2zX9H21Oe2Kn9F/+04GX+3avrBkeqt/pZScRtY+W8MqvDXBvJNYk+cuED6YCmf1
         QszA==
X-Gm-Message-State: AOAM533gx5WeP9HuJ+U1Td9baaTAriTpQY8VBGS3cN/fLfucZ/Nj5VO3
        yuN6iAaKl9xd9km3OSlr4uYyGobW
X-Google-Smtp-Source: ABdhPJwCFXrK3n8ShULKSgsE9xjHjCLSi1knhXWJ1YAl8BL7QAplPhlBlqhVcjWVCy4aS2LAB9A/Cw==
X-Received: by 2002:a1c:e1d4:: with SMTP id y203mr2490798wmg.140.1595919074934;
        Mon, 27 Jul 2020 23:51:14 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id 68sm16321775wra.39.2020.07.27.23.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:51:14 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fanotify: compare fsid when merging name event
Date:   Tue, 28 Jul 2020 09:51:08 +0300
Message-Id: <20200728065108.26332-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This was missed when splitting name event from fid event

Fixes: cacfb956d46e ("fanotify: record name info for FAN_DIR_MODIFY event")
Cc: <stable@vger.kernel.org> # v5.7+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

We missed a spot in v5.7.

IMO, the issue is not that critical that we must fast track the fix to
v5.8, but I am posting this patch based on v5.8-rc7, so you may decide
whether you want to fast track it or to apply it at the beginning of the
series for next.

Either way, this is going to be easier for cherry-picking to stable rather
that backporting the fix from the top of the series for next.
I pushed my "forward porting" to branch fsnotify-fixes.

Thanks,
Amir.

 fs/notify/fanotify/fanotify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 85eda539b35f..04f9a7012f46 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -64,6 +64,7 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 		return false;
 
 	if (fne1->name_len != fne2->name_len ||
+	    !fanotify_fsid_equal(&fne1->fsid, &fne2->fsid) ||
 	    !fanotify_fh_equal(&fne1->dir_fh, &fne2->dir_fh))
 		return false;
 
-- 
2.17.1

