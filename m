Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC418764C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 00:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbgCPXiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 19:38:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46527 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732873AbgCPXiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:38:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so6996580wrv.13;
        Mon, 16 Mar 2020 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXTTrsWcQVqx3rmui/RNjZ9XiC0WGWd6yJp/fFg7kAQ=;
        b=XdCgpzmc7GRx1jmSmH993jW/2VnF4RED7od9tiUjv7ulQ9BKGcNAjla8KDIVG9wEUK
         YBDR6jszETj2YOyCk3IsEHnMWVIdyNE+/FBoL2uWbPaT+WoUtg17lCdBtl8JeZFnh88f
         las07iGsqb7SuRo3kJ3+enTStF7sR7AR5jBq4Dt3nUc5MdZgU7QpS2tYrHT1f5P9zOdg
         f8asAng+zWkSLT/IONO1G09vA7hOlXjAs8tmpBVGg4ocfMpLad/YdFKZZ0S4kk5rNDUn
         2ObGT/YCFAFsfjZFiRnJSVrM/z3aoercr06QYHjV0ryUjSwNdu8E1DZSCjTxHgVHLKOn
         0thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXTTrsWcQVqx3rmui/RNjZ9XiC0WGWd6yJp/fFg7kAQ=;
        b=D67MavO4OzTBLlekX8q43MUaopZt22Vorm9BOgZQcpCeoHIRhNZQynw3ts+GpOONV7
         EIu268JApzpO++XGT1+nT6Dbk6S24lVmSgJqzxtLYM04Hxu2DyaopV9Cb9fjnt5dh+TR
         abZT8oyBMwv22GWDsYSUuIHljmtIrNTAL7sRXioUFnhMNXMTdQnWrUeM0wBr/NqRmeFo
         4cR6bcvxNwvvRD3N0OBQYarMAq8JsfNNQ6aMl5E1uYtptONjLc9+xql6s2GzD+5bUrOZ
         77pM6fE/F0963nA52cvOaEPoAxvbWsWAUHE3qRlC/tevPi75zDf2Cik3x8/knJuXFO0t
         27uQ==
X-Gm-Message-State: ANhLgQ1O31SU++9vzjsB+h8Go3zFVhw4t54LJsm7ja9tv9nmOIOoQKV2
        uMjiwHqJXgGsnuQMb2Sf+A==
X-Google-Smtp-Source: ADFU+vtJQwqUb3Sg3gxPN/EEhyFnx3mQTKRU/lB5Q92YGroSWkdI3nvlPMsWSmpJ7WE0DTJwbr4sVQ==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr1913581wrw.358.1584401929075;
        Mon, 16 Mar 2020 16:38:49 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.googlemail.com with ESMTPSA id i9sm1510495wmd.37.2020.03.16.16.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:38:48 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/6] namei: Add missing annotation for unlazy_child()
Date:   Mon, 16 Mar 2020 23:38:00 +0000
Message-Id: <20200316233804.96657-3-jbi.octave@gmail.com>
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

Sparse reports a warning at unlazy_child()

warning: context imbalance in unlazy_child() - unexpected unlock

The root cause is the missing annotation at unlazy_walk()

Add the missing __releases(RCU) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namei.c b/fs/namei.c
index d80e1ac8c211..9af3e8e438a1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -717,6 +717,7 @@ static int unlazy_walk(struct nameidata *nd)
  * terminate_walk().
  */
 static int unlazy_child(struct nameidata *nd, struct dentry *dentry, unsigned seq)
+	__releases(RCU)
 {
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-- 
2.24.1

