Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0153EC4D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiFFQGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 12:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiFFQGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:06:15 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046B819FF6B;
        Mon,  6 Jun 2022 09:06:13 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B7D76264C;
        Mon,  6 Jun 2022 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654531535;
        bh=YC954AWf4ar090GjDL597H0eq+vVgEaQ+bJ5qpgYd/k=;
        h=Date:To:CC:From:Subject;
        b=Bc6ubdrza7z2nTSXbqcXOFvPTnlp87pXcFXdBTVo2gX1BryWPdJY+MkfFCc4VatFN
         zu1boaKtxXgL/40tEHlajJrvLOJMdc0JjoGCgDVmZjO44ZrzGrAptUVNsG1Cb298fb
         ER4+T83BdToH0/va+nA7N+WPBoY7Mx3qF/ABuXos=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id EC8C82469;
        Mon,  6 Jun 2022 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1654531571;
        bh=YC954AWf4ar090GjDL597H0eq+vVgEaQ+bJ5qpgYd/k=;
        h=Date:To:CC:From:Subject;
        b=LLXnxji9bgLV7PfybHzeFxe7ce+Rz8f21T7TLROgiSSJwX5GXpHY9TNSeA4VhA8y0
         J/oMpoOCiE7hS/449qobAvw7Z1M/MjWDx7hd9Gvhzn4EhpmAOe/lwoBQI/DGLDxtnj
         AEGZNP2gJKSM5gllQlF9iD0QJeuIaybzEFtA3KQA=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 6 Jun 2022 19:06:11 +0300
Message-ID: <475f1975-7275-de01-f947-677e3f184276@paragon-software.com>
Date:   Mon, 6 Jun 2022 19:06:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Add missing error check
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must check return value of log_read_rst

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fslog.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 915f42cf07bc..abc8aeffc364 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3843,6 +3843,8 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
  		goto check_restart_area;
  
  	err = log_read_rst(log, l_size, false, &rst_info2);
+	if (err)
+		goto out;
  
  	/* Determine which restart area to use. */
  	if (!rst_info2.restart || rst_info2.last_lsn <= rst_info.last_lsn)
-- 
2.36.1

