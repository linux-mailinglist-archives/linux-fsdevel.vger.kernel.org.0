Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B607A2A92CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 10:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKFJce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 04:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJce (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:32:34 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F98C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 01:32:34 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so511505pgk.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 01:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PxvV9u6M80cl4hcgbDJhd9HztGYBoR3NGSphqmqlCWw=;
        b=AlLe/9RfaBW00flnUeevAYon649rL1Cwp17puWi68VuZFne3RN8s7hRonCVnE47SaR
         SwuEqNpfRJx05e997/hdgEU0YfTnBiwIEBNQ6+qTaHyt+0YATVgHwNCMKeACF0oJFNBu
         I4YhWPtEe1/NkVW8LtSESqMyUNuEE4VX+nunwIL3ZUQ09ym0FrGl6PytrF/g9JgcTDe+
         DByA1qbrLlXiRNfSZpHL503DDCFXxeIarMiScGPn6aKIDOQoraM8T9l8nggq1W2jX6Fn
         99Liok8D9cswCnav23j1MkAbEaXQSxFSpltnnxk6q5gLc8T2mwacx2SfBfq2ns6XXpS8
         E0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PxvV9u6M80cl4hcgbDJhd9HztGYBoR3NGSphqmqlCWw=;
        b=qDnlNLJ2KPo451Rnbp/oNoduFe2aeEd+/nwWPfNFNgK1hps95VRHZHz2GZrcOR+RAV
         PoWMew1D2+rx7hzvWrDsX+dJBblmcMATy+eS5JGmKg0VeU0MRaokLUEkbucHmyMIfCIc
         KxiW3T9ZFpBL5o7r5z1mqDBl3lublgNP8fL8GCCiWrsP7GdIOhseSI/wBdA6mKRHjMnr
         ZGBFlxLv5MUveMIMg2J/RElUKDdx2aMy+Gv7SyE+6vWEFje9uWiLl9OTa60cJSX7uk/S
         D1qKAA80zJMC7Fw1KtW/AtK1b1+oHA7MeHtJHrSrwxBijWs0Lf7SqZFBVh7chX3Cc0PF
         hbrg==
X-Gm-Message-State: AOAM531sERfscYVh6zkTQGA8WZwY0NT5GnAOhFkekRCnI178nnQWiwzg
        GtkKZ8P0VFgrhBi7Poz2IQ==
X-Google-Smtp-Source: ABdhPJwJEUHbzxywpowgU1LuAJjhUc6GsVtkqPxgRT3D6ZEOx9E2gWVW2INhaeKCuvYeiUUxOfbvnA==
X-Received: by 2002:a17:90a:7089:: with SMTP id g9mr1624385pjk.47.1604655153897;
        Fri, 06 Nov 2020 01:32:33 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id a24sm1374678pfl.174.2020.11.06.01.32.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 01:32:33 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     viro@zeniv.linux.org.uk, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] fs: Use true,false for bool variable
Date:   Fri,  6 Nov 2020 17:32:28 +0800
Message-Id: <1604655148-1542-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle reports:

./fs/ioctl.c:355:4-12: WARNING: Assignment of 0/1 to bool variable

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4e6cc0a7d69c..732876e302b5 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -352,7 +352,7 @@ static int __generic_block_fiemap(struct inode *inode,
 			 */
 			if (!past_eof &&
 			    blk_to_logical(inode, start_blk) >= isize)
-				past_eof = 1;
+				past_eof = true;
 
 			/*
 			 * First hole after going past the EOF, this is our
-- 
2.20.0

