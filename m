Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4698F4383AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 14:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJWMkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 08:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhJWMkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 08:40:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46824C061764
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Oct 2021 05:38:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y132-20020a1c7d8a000000b0032ca5765d6cso2601490wmc.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Oct 2021 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LQNK5czTX+Eipf3rccwwQpg6ytu9gVI/p3fJtth/VyY=;
        b=RNzYL3DtvAAqik5NDgWoN4vlg78kXJV9n8oetivyERIt4xxuzJGWaKMUV6CXS8DvH6
         0JaMhJnFY6cHnOkNUlrNL5Oyts9sBDm858nLPB4wE1ra+AukMXS+Cco+sxIgN2/SIyD5
         DhznUR+wFds20vOAZCfhOoXjmOSoNRwsGIBD+iviOT3c3DODV9/UyaHJ88dBXTHDaZ4h
         ab5tFX5RxvL8NLGtWxMALwoy497E8Dm4B9F0ytLqWDTOhpgtIsBsCMYkBl2TRn1qhuvw
         tfpAwg71w6pdOBqFk3umIskCn0cOvsadPomcoyNgpA1QTEI5d2Jgfp6OkhGpaumRqM35
         4cfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LQNK5czTX+Eipf3rccwwQpg6ytu9gVI/p3fJtth/VyY=;
        b=R/ZaLG3S7MZ9+c+JZyd345jPrtLusg7Xm1LgppU4Fux5vCG0JMtMw0c+PlTj2KXkzB
         HxeY1UePa6ry0m1bXIVwV/zzBRhcYLGCeh4V4xtF4D8Zn6dl6P4/M7pnhoYQ5JrtTsqR
         3x9SqxXT4xbJ4xgcbijf03BYFVa8xa1Um2rh1pnIeBW3OKGLaU1+azWOdAjlcF/OdA+a
         BT8h6Y4IOTnXrYgOFrqp0T/xQvMWAH2zhoyUWy14q2EOENRfIeqcGtosYqTgi4f5t6JT
         81gxOVk8hIzDdLrwZCtDC7QKBiukHCH9fd7p07NeRuKim0OBffKsL9jMYq08ZzEg6d/S
         1jdw==
X-Gm-Message-State: AOAM53173Mp+NiIQ17zb+75uH3G5soaSaVi/5qv0ECelCj4YkMsp161d
        A4PIoXdLFhn+kfSCN8riQEy1omZlLA==
X-Google-Smtp-Source: ABdhPJw9dNWvHzBTZ6ScvzeWochvSFnQbjvMLPig8doz51p8Xp+fKImNLF8mezoQfeyZ6py3NittqA==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr6609702wmq.184.1634992682944;
        Sat, 23 Oct 2021 05:38:02 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.50])
        by smtp.gmail.com with ESMTPSA id u17sm1669383wrp.93.2021.10.23.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 05:38:02 -0700 (PDT)
Date:   Sat, 23 Oct 2021 15:38:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: delete cast in namei code
Message-ID: <YXQCKPduiZZH9M7Q@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Testing for char equiality works just fine for each signedness.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2613,7 +2613,7 @@ static int lookup_one_common(struct user_namespace *mnt_userns,
 	}
 
 	while (len--) {
-		unsigned int c = *(const unsigned char *)name++;
+		char c = *name++;
 		if (c == '/' || c == '\0')
 			return -EACCES;
 	}
