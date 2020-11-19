Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C882B8CE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 09:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgKSIK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 03:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgKSIK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:10:26 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E396C0613CF;
        Thu, 19 Nov 2020 00:10:25 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so3717756pfa.4;
        Thu, 19 Nov 2020 00:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:date;
        bh=BBH0n/tVSc1pgGFyZLZyko3xhnSum4LcpbbRAXGerhI=;
        b=WTmDIfPsysP7gkIbTbhdG0fHoV9PRvxwBv12ozvkS5AqTZrERknSmXLEGsDrQzG23K
         iJPUzi64GfTM3G3yyKJya5Qp0/bsoiVVZjcTcuK/ZMvMZmu3PaYUcfV3SxVuDMWTv+M5
         ALshmItCqQLa1VYBulouilk++usv7YsHrlsFshx2KMHxdEFy8hTpNVQksVwKOzw7D/Yi
         pNPBtZxKyQ9YnRqf5K5ZtNlTwZBm7anwEC9jN7JjmvaEYwwl6Bsseql305ROLwmaM54E
         B9MCWI0jXM3tDJtERzTspZ2YPNSZhHpPyyTgPx0qESAdRM9QvRzjAJR9uP55kwOJQt9Q
         v0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date;
        bh=BBH0n/tVSc1pgGFyZLZyko3xhnSum4LcpbbRAXGerhI=;
        b=sJsiVBZAhq0DKzSq3aLUZr1guyJZuR2f9SLHlJt/vHl295YvHbxXCFqY1SvyqPXeA1
         LvuI3+/2lFMBI1TPy4oQltQCYTUB1M83fgVALWw3vWkfRdlnWtJq53aFiaFPQgESD+Iu
         Y7+pk9LtGBKhEvJ3jy/qQegSiKtxBar+6KRPfExL44NJET9hZ6B1h7f7FRHupz86HV4T
         dlyeIxSOoJ8yRaNtzNjkAjfFk0m3FCdrhgePYe08a3LX+yR5Fb55CMYTyNAfEQA/Y/ql
         ba2Ap5PzMafDrAnWE5s6qBCGPEIoci/BvqXpwKYZfGpdn1JHnGc1j7hlvshYkXo9gguT
         MOvQ==
X-Gm-Message-State: AOAM5306nT3THtXQmLdVHzvpjjIYn3YXQg6flum6BoDqQ3vVEnkOVs1k
        nbG3wLxSTwoDkFiEM5mfQKA=
X-Google-Smtp-Source: ABdhPJy4GM1rB5XSZxWwWLNTBxuTcgR6YCbGNtqEQS6rmFwpV0JUMeizY06ArgRGOkrHVCDL5lo3kA==
X-Received: by 2002:a62:293:0:b029:197:96c2:bef6 with SMTP id 141-20020a6202930000b029019796c2bef6mr4851211pfc.62.1605773425113;
        Thu, 19 Nov 2020 00:10:25 -0800 (PST)
Received: from localhost.localdomain ([154.93.3.113])
        by smtp.gmail.com with ESMTPSA id 138sm27441741pfy.88.2020.11.19.00.10.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 00:10:24 -0800 (PST)
Message-ID: <5fb62870.1c69fb81.8ef5d.af76@mx.google.com>
X-Google-Original-Message-ID: <1605773323-23376-1-git-send-email---global>
From:   menglong8.dong@gmail.com
X-Google-Original-From: --global
To:     pabs3@bonedaddy.net
Cc:     viro@zeniv.linux.org.uk, nhorman@tuxdriver.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH] coredump: fix core_pattern parse error
Date:   Thu, 19 Nov 2020 03:08:43 -0500
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

'format_corename()' will splite 'core_pattern' on spaces when it
is in pipe mode, and take helper_argv[0] as the path to usermode
executable.

It works fine in most cases. However, if there is a space between
'|' and '/file/path', such as
'| /usr/lib/systemd/systemd-coredump %P %u %g',
helper_argv[0] will be parsed as '', and users will get a
'Core dump to | disabled'.

It is not friendly to users, as the pattern above was valid previously.
Fix this by ignoring the spaces between '|' and '/file/path'.

Fixes: 315c69261dd3 ("coredump: split pipe command whitespace before expanding template")
Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 fs/coredump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 0cd9056d79cc..c6acfc694f65 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -229,7 +229,8 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 		 */
 		if (ispipe) {
 			if (isspace(*pat_ptr)) {
-				was_space = true;
+				if (cn->used != 0)
+					was_space = true;
 				pat_ptr++;
 				continue;
 			} else if (was_space) {
-- 
2.25.1


