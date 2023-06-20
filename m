Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9937372E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjFTR3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 13:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjFTR3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:29:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DAA3;
        Tue, 20 Jun 2023 10:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A849061344;
        Tue, 20 Jun 2023 17:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B9CC433C9;
        Tue, 20 Jun 2023 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687282181;
        bh=2v0ful0jkg7uWqndTWCdzFH7x6ZP3BwJtCQbQPqXJnw=;
        h=Date:From:To:Cc:Subject:From;
        b=g4HTY0/EKPj45X6/zaslEYJc9TOBSzNXRLcLqzEwUP3gW+jxG2AvYW46kZjwdFIPt
         IlXHhCE7vZIbGItnqATcRkt4Ss29sfWWSXTBk/hmi2uj0QmO+RvJsQ5rFcq/yhgVwn
         7zhy5Yzkdg2hvRA0c/Xfu3gnihDHdpb007vRfc5r7JFW8Uc9QuCk24U0D80Mb6Yokw
         XuBMbUIdf/bGBP8IFfBVM4zaWRpeQTtjsCld/NmOrINxDnFlqH0iipAlfov4/VF0O1
         GYwQXCvy4LRD77I0QYdQnpeCJr9fF6Rz4bgLo4p0PY53zzfWAO8zMQwDrvaMziBTPc
         Sp6vifmQGhfBQ==
Date:   Tue, 20 Jun 2023 11:30:36 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] readdir: Replace one-element arrays with
 flexible-array members
Message-ID: <ZJHiPJkNKwxkKz1c@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
members in multiple structures.

Address the following -Wstringop-overflow warnings seen when built
m68k architecture with m5307c3_defconfig configuration:
In function '__put_user_fn',
    inlined from 'fillonedir' at fs/readdir.c:170:2:
include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
   49 |                 *(u8 __force *)to = *(u8 *)from;
      |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
fs/readdir.c: In function 'fillonedir':
fs/readdir.c:134:25: note: at offset 1 into destination object 'd_name' of size 1
  134 |         char            d_name[1];
      |                         ^~~~~~
In function '__put_user_fn',
    inlined from 'filldir' at fs/readdir.c:257:2:
include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
   49 |                 *(u8 __force *)to = *(u8 *)from;
      |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
fs/readdir.c: In function 'filldir':
fs/readdir.c:211:25: note: at offset 1 into destination object 'd_name' of size 1
  211 |         char            d_name[1];
      |                         ^~~~~~

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/312
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/readdir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 9c53edb60c03..b264ce60114d 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -131,7 +131,7 @@ struct old_linux_dirent {
 	unsigned long	d_ino;
 	unsigned long	d_offset;
 	unsigned short	d_namlen;
-	char		d_name[1];
+	char		d_name[];
 };
 
 struct readdir_callback {
@@ -208,7 +208,7 @@ struct linux_dirent {
 	unsigned long	d_ino;
 	unsigned long	d_off;
 	unsigned short	d_reclen;
-	char		d_name[1];
+	char		d_name[];
 };
 
 struct getdents_callback {
@@ -388,7 +388,7 @@ struct compat_old_linux_dirent {
 	compat_ulong_t	d_ino;
 	compat_ulong_t	d_offset;
 	unsigned short	d_namlen;
-	char		d_name[1];
+	char		d_name[];
 };
 
 struct compat_readdir_callback {
@@ -460,7 +460,7 @@ struct compat_linux_dirent {
 	compat_ulong_t	d_ino;
 	compat_ulong_t	d_off;
 	unsigned short	d_reclen;
-	char		d_name[1];
+	char		d_name[];
 };
 
 struct compat_getdents_callback {
-- 
2.34.1

