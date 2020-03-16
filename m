Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A7A18764E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 00:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbgCPXjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 19:39:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35960 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732930AbgCPXiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:38:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id s5so23470444wrg.3;
        Mon, 16 Mar 2020 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCn5xzWGqh0tVqpTIPIigS1SoJ9VMJTzL24LcY1So5I=;
        b=Nghti8WPFDRsy8/jWR61sk+WFLqpvS/1gDkUQZpTMesVtl9jqWo6KfXGXnGO8zZLL+
         zXDiGsComuznrt5sfbrb1g7thEHfVvyiQadC8I2+oK3dEZn4mg2YtoYTigBjNIVLeZ2b
         AfvLaRZIbO7NSS6cc7phmaqWBkww8CF3PQ1nlcsMzzgvEc+eanx93zq22m3szJwAL8/I
         S2c5HcCQv+qZcjgctBFApPK/AasNoYC+1IQA02V2kvcbOI/19ETPhW2bj+BfxfFn5xAk
         pXsmqVUlwqCwNkeuL3L3EAFEyBQUngwOUo+ibRM/7mev1oXiVWitGhEu+rxZmIut0ztw
         G5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCn5xzWGqh0tVqpTIPIigS1SoJ9VMJTzL24LcY1So5I=;
        b=RvH/seEFAx95K/JvI/5Wfmwrpo9TSfT6/MSiDxw03a+WwwDvJzCV3QAmwQPdW7jIAa
         LqIpXO7MDVTk3ZKbz7mGElpN6MKXl0W3w8LEbSIbbpvOj9E5BCYdFcur/V3aI5XhSfZP
         V0LAvFhDm4gaVZFxCMcnDoCPiiPlzlvVoOqW1aiy02YUCTzm6qS5PVFIxaj56qoSD8kx
         TCfapD0d2AtHc5khQaP2n4KW88FTTIhCuZVc5WyLDaeVh7LXcP2VtDxLCjb42rtYqWBQ
         uO3h5UOWXVCRu0ldHloKW3NeFFMmIn/t3RZ3kP+YZX3ySwqpu+haQOvWbYxt6LwYaXB9
         LirA==
X-Gm-Message-State: ANhLgQ1X3LvAMOGbdKLlHCKkgYhDcHusX0/Ey2v7I3NmpmzE/ayNoCe5
        uzGcY9UUSztgeFXSWUAfIrKl0quiog==
X-Google-Smtp-Source: ADFU+vuoVKapg3RsR0MrvkWqtANCfCPwTZOAvlBdZVdpSshTQjHZuzwbr9a6HxFsDpPqXKXq+VDXeA==
X-Received: by 2002:a05:6000:128a:: with SMTP id f10mr905829wrx.242.1584401928021;
        Mon, 16 Mar 2020 16:38:48 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.googlemail.com with ESMTPSA id i9sm1510495wmd.37.2020.03.16.16.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:38:47 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/6] namei: Add missing annotation for unlazy_walk()
Date:   Mon, 16 Mar 2020 23:37:59 +0000
Message-Id: <20200316233804.96657-2-jbi.octave@gmail.com>
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

Sparse reports a warning at unlazy_walk()

warning: context imbalance in unlazy_walk() - unexpected unlock

The root cause is the missing annotation at unlazy_walk()

Add the missing __releases(RCU) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namei.c b/fs/namei.c
index db6565c99825..d80e1ac8c211 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -678,6 +678,7 @@ static bool legitimize_root(struct nameidata *nd)
  * terminate_walk().
  */
 static int unlazy_walk(struct nameidata *nd)
+	__releases(RCU)
 {
 	struct dentry *parent = nd->path.dentry;
 
-- 
2.24.1

